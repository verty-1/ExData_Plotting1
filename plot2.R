## Coursera Exploratory Data Analysis Week 1 Project
##
## plot2.R
## R script creates second plot and creates output plot file plot2.png 
## This script uses the lubridate and dplyr libraries
library(lubridate)
library(dplyr)
##
## Project is defined from github for: 
## https://github.com/rdpeng/ExData_Plotting1
##
## Read file as rawdata
##
        setwd("~/Telematics and Analytics/Statistics/Data Science Specialization/Exploratory Analysis/week1/project")
        df0 <- read.table("./household_power_consumption.txt", 
                header = TRUE, sep = ";", stringsAsFactors = FALSE)
##
## Create new date and time stamp in POSIXlt format  
##         
        stamp <- strptime(paste(df0$Date,df0$Time), "%d/%m/%Y %H:%M:%S", 
                tz="America/Los_Angeles")
##
## Subset data for period of February 1 and 2, 2007, remove unused factors
##
        u <- year(stamp) == 2007 & month(stamp) == 2 & 
                (day(stamp) == 1 | day(stamp) == 2)   
        df0[,10] <- u
        pdata <- filter(df0, V10 == "TRUE")
        for (index in 3:8) {pdata[,index] <- as.numeric(pdata[,index])}
        pdata <- rename(pdata, Subset=V10) ## Plot data frame
        rm(df0) ## free up memory
##
## Replace "?" missing data with "NA", noting that ? is a special metacharacter
##      grep("\\?", df0[,3]) ## Reveals "?" is in raw data df0
##      grep("\\?", pdata) ## There were no "?" in plotdata
##      sub("\\?", "NA", pdata) ## was not necessary  
##
## Put timeframe in POSIXct class     
        stamp2 <- strptime(paste(pdata$Date,pdata$Time), "%d/%m/%Y %H:%M:%S", 
                tz="America/Los_Angeles")
        pdata[,11] <- as.POSIXct(stamp2)
        pdata <- rename(pdata, ptime=V11) ## Plot data frame
##
## Line plot and png file
##        
        with(pdata, plot(ptime,Global_active_power, type="l", 
                ylab="Global Active Power (kilowatts)", xlab="Time"))        
        dev.copy(png, file = "plot2.png")
        dev.off()
## End        
