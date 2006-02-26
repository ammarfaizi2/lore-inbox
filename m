Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWBZXOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWBZXOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWBZXOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:14:50 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:28709 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751426AbWBZXOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:14:49 -0500
Message-Id: <20060226231438.517421000@towertech.it>
References: <20060226231438.307751000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 27 Feb 2006 00:14:39 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] RTC Subsystem, library functions
Content-Disposition: inline; filename=rtc-lib.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RTC and date/time related functions. 

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
---
 lib/Makefile |    2 -
 lib/rtc.c    |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/lib/rtc.c	2006-02-26 22:03:21.000000000 +0100
@@ -0,0 +1,98 @@
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
+	int days, month, year;
+
+	days = time / 86400;
+	time -= days * 86400;
+
+	tm->tm_wday = (days + 4) % 7;
+
+	year = 1970 + days / 365;
+	days -= (year - 1970) * 365
+	        + LEAPS_THRU_END_OF(year - 1)
+	        - LEAPS_THRU_END_OF(1970 - 1);
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
+	if (tm->tm_year < 70 ||
+	    tm->tm_mon >= 12 ||
+	    tm->tm_mday < 1 ||
+	    tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900) ||
+	    tm->tm_hour >= 24 ||
+	    tm->tm_min >= 60 ||
+	    tm->tm_sec >= 60)
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
+		       tm->tm_hour, tm->tm_min, tm->tm_sec);
+	return 0;
+}
+EXPORT_SYMBOL(rtc_tm_to_time);
--- linux-rtc.orig/lib/Makefile	2006-02-26 21:49:51.000000000 +0100
+++ linux-rtc/lib/Makefile	2006-02-26 21:52:09.000000000 +0100
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o rtc.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 

--
