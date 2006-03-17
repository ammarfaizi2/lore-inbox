Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWCRABA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWCRABA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCRAAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:00:43 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:38289 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751689AbWCRAAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:00:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <15.132654658@selenic.com>
Subject: [PATCH 14/14] RTC: Remove some duplicate BCD definitions
Date: Fri, 17 Mar 2006 17:30:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some duplicate BCD definitions

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.16-rc5-rtc/arch/m68k/bvme6000/rtc.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/m68k/bvme6000/rtc.c	2006-03-06 16:01:30.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/m68k/bvme6000/rtc.c	2006-03-11 16:07:50.000000000 -0600
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mc146818rtc.h>	/* For struct rtc_time and ioctls, etc */
 #include <linux/smp_lock.h>
+#include <linux/bcd.h>
 #include <asm/bvme6000hw.h>
 
 #include <asm/io.h>
@@ -32,9 +33,6 @@
  *	ioctls.
  */
 
-#define BCD2BIN(val) (((val)&15) + ((val)>>4)*10)
-#define BIN2BCD(val) ((((val)/10)<<4) + (val)%10)
-
 static unsigned char days_in_mo[] =
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
Index: 2.6.16-rc5-rtc/arch/m68k/mvme16x/rtc.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/m68k/mvme16x/rtc.c	2006-03-06 16:01:30.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/m68k/mvme16x/rtc.c	2006-03-11 16:04:47.000000000 -0600
@@ -17,6 +17,7 @@
 #include <linux/poll.h>
 #include <linux/mc146818rtc.h>	/* For struct rtc_time and ioctls, etc */
 #include <linux/smp_lock.h>
+#include <linux/bcd.h>
 #include <asm/mvme16xhw.h>
 
 #include <asm/io.h>
@@ -31,9 +32,6 @@
  *	ioctls.
  */
 
-#define BCD2BIN(val) (((val)&15) + ((val)>>4)*10)
-#define BIN2BCD(val) ((((val)/10)<<4) + (val)%10)
-
 static const unsigned char days_in_mo[] =
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
Index: 2.6.16-rc5-rtc/arch/mips/momentum/ocelot_3/setup.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/mips/momentum/ocelot_3/setup.c	2006-03-06 16:01:30.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/mips/momentum/ocelot_3/setup.c	2006-03-11 15:57:35.000000000 -0600
@@ -58,6 +58,7 @@
 #include <linux/bootmem.h>
 #include <linux/mv643xx.h>
 #include <linux/pm.h>
+#include <linux/bcd.h>
 
 #include <asm/time.h>
 #include <asm/page.h>
@@ -131,9 +132,6 @@ void setup_wired_tlb_entries(void)
 	add_wired_entry(ENTRYLO(0xfc000000), ENTRYLO(0xfd000000), (signed)0xfc000000, PM_16M);
 }
 
-#define CONV_BCD_TO_BIN(val)	(((val) & 0xf) + (((val) >> 4) * 10))
-#define CONV_BIN_TO_BCD(val)	(((val) % 10) + (((val) / 10) << 4))
-
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
@@ -143,16 +141,16 @@ unsigned long m48t37y_get_time(void)
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
-	year = CONV_BCD_TO_BIN(rtc_base[0x7fff]);
-	year += CONV_BCD_TO_BIN(rtc_base[0x7ff1]) * 100;
+	year = BCD2BIN(rtc_base[0x7fff]);
+	year += BCD2BIN(rtc_base[0x7ff1]) * 100;
 
-	month = CONV_BCD_TO_BIN(rtc_base[0x7ffe]);
+	month = BCD2BIN(rtc_base[0x7ffe]);
 
-	day = CONV_BCD_TO_BIN(rtc_base[0x7ffd]);
+	day = BCD2BIN(rtc_base[0x7ffd]);
 
-	hour = CONV_BCD_TO_BIN(rtc_base[0x7ffb]);
-	min = CONV_BCD_TO_BIN(rtc_base[0x7ffa]);
-	sec = CONV_BCD_TO_BIN(rtc_base[0x7ff9]);
+	hour = BCD2BIN(rtc_base[0x7ffb]);
+	min = BCD2BIN(rtc_base[0x7ffa]);
+	sec = BCD2BIN(rtc_base[0x7ff9]);
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
@@ -175,22 +173,22 @@ int m48t37y_set_time(unsigned long sec)
 	rtc_base[0x7ff8] = 0x80;
 
 	/* year */
-	rtc_base[0x7fff] = CONV_BIN_TO_BCD(tm.tm_year % 100);
-	rtc_base[0x7ff1] = CONV_BIN_TO_BCD(tm.tm_year / 100);
+	rtc_base[0x7fff] = BIN2BCD(tm.tm_year % 100);
+	rtc_base[0x7ff1] = BIN2BCD(tm.tm_year / 100);
 
 	/* month */
-	rtc_base[0x7ffe] = CONV_BIN_TO_BCD(tm.tm_mon);
+	rtc_base[0x7ffe] = BIN2BCD(tm.tm_mon);
 
 	/* day */
-	rtc_base[0x7ffd] = CONV_BIN_TO_BCD(tm.tm_mday);
+	rtc_base[0x7ffd] = BIN2BCD(tm.tm_mday);
 
 	/* hour/min/sec */
-	rtc_base[0x7ffb] = CONV_BIN_TO_BCD(tm.tm_hour);
-	rtc_base[0x7ffa] = CONV_BIN_TO_BCD(tm.tm_min);
-	rtc_base[0x7ff9] = CONV_BIN_TO_BCD(tm.tm_sec);
+	rtc_base[0x7ffb] = BIN2BCD(tm.tm_hour);
+	rtc_base[0x7ffa] = BIN2BCD(tm.tm_min);
+	rtc_base[0x7ff9] = BIN2BCD(tm.tm_sec);
 
 	/* day of week -- not really used, but let's keep it up-to-date */
-	rtc_base[0x7ffc] = CONV_BIN_TO_BCD(tm.tm_wday + 1);
+	rtc_base[0x7ffc] = BIN2BCD(tm.tm_wday + 1);
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
Index: 2.6.16-rc5-rtc/arch/mips/tx4938/common/rtc_rx5c348.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/mips/tx4938/common/rtc_rx5c348.c	2006-02-17 14:05:34.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/mips/tx4938/common/rtc_rx5c348.c	2006-03-11 15:55:48.000000000 -0600
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/rtc.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 #include <asm/time.h>
 #include <asm/tx4938/spi.h>
 
@@ -77,17 +78,6 @@ spi_rtc_io(unsigned char *inbuf, unsigne
 			   inbufs, incounts, outbufs, outcounts, 0);
 }
 
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 /* RTC-dependent code for time.c */
 
 static int
Index: 2.6.16-rc5-rtc/arch/sh/boards/mpc1211/rtc.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/sh/boards/mpc1211/rtc.c	2006-03-06 18:07:24.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/sh/boards/mpc1211/rtc.c	2006-03-11 15:53:36.000000000 -0600
@@ -9,16 +9,9 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 #include <linux/mc146818rtc.h>
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 unsigned long get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
Index: 2.6.16-rc5-rtc/arch/sh/boards/sh03/rtc.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/sh/boards/sh03/rtc.c	2006-03-06 18:07:24.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/sh/boards/sh03/rtc.c	2006-03-11 15:54:16.000000000 -0600
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 #include <asm/io.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
@@ -33,14 +34,6 @@
 #define RTC_BUSY	1
 #define RTC_STOP	2
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val)	((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 extern void (*rtc_get_time)(struct timespec *);
 extern int (*rtc_set_time)(const time_t);
 extern spinlock_t rtc_lock;
Index: 2.6.16-rc5-rtc/arch/sh/kernel/cpu/rtc.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/sh/kernel/cpu/rtc.c	2005-10-27 19:02:08.000000000 -0500
+++ 2.6.16-rc5-rtc/arch/sh/kernel/cpu/rtc.c	2006-03-11 15:51:36.000000000 -0600
@@ -9,18 +9,10 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
-
+#include <linux/bcd.h>
 #include <asm/io.h>
 #include <asm/rtc.h>
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 void sh_rtc_gettimeofday(struct timespec *ts)
 {
 	unsigned int sec128, sec, sec2, min, hr, wk, day, mon, yr, yr100, cf_bit;
Index: 2.6.16-rc5-rtc/arch/sh64/kernel/time.c
===================================================================
--- 2.6.16-rc5-rtc.orig/arch/sh64/kernel/time.c	2006-03-06 16:01:31.000000000 -0600
+++ 2.6.16-rc5-rtc/arch/sh64/kernel/time.c	2006-03-11 15:52:36.000000000 -0600
@@ -30,6 +30,7 @@
 #include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/bcd.h>
 
 #include <asm/registers.h>	 /* required by inline __asm__ stmt. */
 
@@ -105,14 +106,6 @@
 #define RCR1    	rtc_base+0x38
 #define RCR2    	rtc_base+0x3c
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #define TICK_SIZE (tick_nsec / 1000)
 
 extern unsigned long wall_jiffies;
