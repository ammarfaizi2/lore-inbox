Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbWCFBxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWCFBxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWCFBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:53:19 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:55679 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751564AbWCFBxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:53:13 -0500
Message-Id: <20060306015009.110961000@towertech.it>
References: <20060306015008.858209000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 06 Mar 2006 02:50:09 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@digeo.com
Subject: [PATCH 01/16] RTC Subsystem, library functions
Content-Disposition: inline; filename=rtc-lib.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RTC and date/time related functions. 

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/Kconfig       |    2 +
 drivers/Makefile      |    1 
 drivers/rtc/Kconfig   |    6 +++
 drivers/rtc/Makefile  |    5 ++
 drivers/rtc/rtc-lib.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/rtc.h   |    5 ++
 6 files changed, 118 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-lib.c	2006-03-05 02:49:51.000000000 +0100
@@ -0,0 +1,99 @@
+/*
+ * rtc and date/time utility functions
+ *
+ * Copyright (C) 2005-06 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * based on arch/arm/common/rtctime.c and other bits
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+
+static const unsigned char rtc_days_in_month[] = {
+	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
+};
+
+#define LEAPS_THRU_END_OF(y) ((y)/4 - (y)/100 + (y)/400)
+#define LEAP_YEAR(year) ((!(year % 4) && (year % 100)) || !(year % 400))
+
+int rtc_month_days(unsigned int month, unsigned int year)
+{
+	return rtc_days_in_month[month] + (LEAP_YEAR(year) && month == 1);
+}
+EXPORT_SYMBOL(rtc_month_days);
+
+/*
+ * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
+ */
+void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
+{
+	register int days, month, year;
+
+	days = time / 86400;
+	time -= days * 86400;
+
+	/* day of the week, 1970-01-01 was a Thursday */
+	tm->tm_wday = (days + 4) % 7;
+
+	year = 1970 + days / 365;
+	days -= (year - 1970) * 365
+		+ LEAPS_THRU_END_OF(year - 1)
+		- LEAPS_THRU_END_OF(1970 - 1);
+	if (days < 0) {
+		year -= 1;
+		days += 365 + LEAP_YEAR(year);
+	}
+	tm->tm_year = year - 1900;
+	tm->tm_yday = days + 1;
+
+	for (month = 0; month < 11; month++) {
+		int newdays;
+
+		newdays = days - rtc_month_days(month, year);
+		if (newdays < 0)
+			break;
+		days = newdays;
+	}
+	tm->tm_mon = month;
+	tm->tm_mday = days + 1;
+
+	tm->tm_hour = time / 3600;
+	time -= tm->tm_hour * 3600;
+	tm->tm_min = time / 60;
+	tm->tm_sec = time - tm->tm_min * 60;
+}
+EXPORT_SYMBOL(rtc_time_to_tm);
+
+/*
+ * Does the rtc_time represent a valid date/time?
+ */
+int rtc_valid_tm(struct rtc_time *tm)
+{
+	if (tm->tm_year < 70
+		|| tm->tm_mon >= 12
+		|| tm->tm_mday < 1
+		|| tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
+		|| tm->tm_hour >= 24
+		|| tm->tm_min >= 60
+		|| tm->tm_sec >= 60)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtc_valid_tm);
+
+/*
+ * Convert Gregorian date to seconds since 01-01-1970 00:00:00.
+ */
+int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time)
+{
+	*time = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+	return 0;
+}
+EXPORT_SYMBOL(rtc_tm_to_time);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/Makefile	2006-03-05 02:48:31.000000000 +0100
@@ -0,0 +1,5 @@
+#
+# Makefile for RTC class/drivers.
+#
+
+obj-$(CONFIG_RTC_LIB)	+= rtc-lib.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/Kconfig	2006-03-05 02:48:31.000000000 +0100
@@ -0,0 +1,6 @@
+#
+# RTC class/drivers configuration
+#
+
+config RTC_LIB
+	bool
\ No newline at end of file
--- linux-rtc.orig/drivers/Kconfig	2006-03-05 02:38:14.000000000 +0100
+++ linux-rtc/drivers/Kconfig	2006-03-05 02:38:16.000000000 +0100
@@ -70,4 +70,6 @@ source "drivers/sn/Kconfig"
 
 source "drivers/edac/Kconfig"
 
+source "drivers/rtc/Kconfig"
+
 endmenu
--- linux-rtc.orig/drivers/Makefile	2006-03-05 02:38:14.000000000 +0100
+++ linux-rtc/drivers/Makefile	2006-03-05 02:38:16.000000000 +0100
@@ -56,6 +56,7 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
+obj-$(CONFIG_RTC_LIB)		+= rtc/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
--- linux-rtc.orig/include/linux/rtc.h	2006-03-05 02:38:14.000000000 +0100
+++ linux-rtc/include/linux/rtc.h	2006-03-05 02:48:31.000000000 +0100
@@ -95,6 +95,11 @@ struct rtc_pll_info {
 
 #ifdef __KERNEL__
 
+extern int rtc_month_days(unsigned int month, unsigned int year);
+extern int rtc_valid_tm(struct rtc_time *tm);
+extern int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time);
+extern void rtc_time_to_tm(unsigned long time, struct rtc_time *tm);
+
 typedef struct rtc_task {
 	void (*func)(void *private_data);
 	void *private_data;

--
