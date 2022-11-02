#### Homework 2 #####
rm(list = ls())
library(tidyverse)

#import data 
dfraw = read_csv('https://osf.io/uzpce/download')

#Look at data
glimpse(dfraw)

#Rename variables in a simple way without function
mgmt = dfraw1$management
emp_firm = dfraw1$emp_firm
firm_age = dfraw1$firmage 
ownership = dfraw1$ownership

#Check nature and missing observations for variables 
is.numeric(mgmt)
is.numeric(emp_firm)
is.numeric(firm_age)

table(mgmt, useNA = 'ifany')
table(emp_firm, useNA = 'ifany')
table(firm_age, useNA = 'ifany')

!is.na(firm_age)

#use US firms observed in wave 2004, employment firm 100 and 5000 
dfraw1 = dfraw %>% filter(country == 'United States') %>%
  filter(wave == '2004')%>%
  filter(emp_firm >= 100 & emp_firm <= 5000)

rm(dfraw)

#Create a descriptive statistic for management, emp_firm, 
install.packages('modelsummary')
library(modelsummary)

summary(dfraw1)

dfraw2 = rename(dfraw1, firm_age = firmage)

#skip for now so that I can use the copy later to transpose a column
rm(dfraw1)

#create additional functions for the datasummary function
range_ds = function(x) 
  max(x, na.rm = T) - min(x, na.rm = T)

qs = function(x) 
  quantile(x, na.rm = T, probs = c(.5, .95))

#Create the datasummary function with quantile and range functions
datasummary(mgmt + emp_firm + firm_age ~ 
              Mean + Median + SD + Min + Max +
              range_ds + qs, 
              data = dfraw2)
#Create descriptive statistics with mgmt grouped by ownership
#install library for piping
library(dplyr)
#This creates a tibble to show the statistics
dfraw2 %>% 
  group_by(ownership) %>% 
  summarize(mean = mean(mgmt),
            median = median(mgmt),
            min = min(mgmt),
            max = max(mgmt))
          
#Histogram of management with label
m = hist(mgmt)
plot(m, main="Histogram of Management")

# Kernel Density Plot
m <- density(mgmt) # returns the density data
plot(m, main="Kernel Density of Management")
polygon(m, col="red", border="black")



