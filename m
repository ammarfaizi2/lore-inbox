Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbUKKXzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUKKXzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUKKXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:53:17 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:34949 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262415AbUKKXFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:05:21 -0500
Subject: [PATCH 2/3] Fix sysdev time support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100213485.6031.18.camel@desktop.cunninghams>
References: <1100213485.6031.18.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1100213798.6031.31.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 09:59:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra parameter to get_cmos_time and to arch specific routines,
allowing the user to specify whether we should wait for the beginning of
a new second, or simply ensure that the time returned is accurate.

diff -ruN 991-old/arch/cris/kernel/time.c 991-new/arch/cris/kernel/time.c
--- 991-old/arch/cris/kernel/time.c	2004-11-03 21:53:48.000000000 +1100
+++ 991-new/arch/cris/kernel/time.c	2004-11-12 09:20:09.000000000 +1100
@@ -173,7 +173,7 @@
 /* grab the time from the RTC chip */
 
 unsigned long
-get_cmos_time(void)
+get_cmos_time(int wait)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
diff -ruN 991-old/arch/i386/kernel/apm.c 991-new/arch/i386/kernel/apm.c
--- 991-old/arch/i386/kernel/apm.c	2004-11-03 21:51:14.000000000 +1100
+++ 991-new/arch/i386/kernel/apm.c	2004-11-12 09:20:09.000000000 +1100
@@ -232,7 +232,7 @@
 #include "io_ports.h"
 
 extern spinlock_t i8253_lock;
-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int wait);
 extern void machine_real_restart(unsigned char *, int);
 
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -1148,7 +1148,7 @@
 static void set_time(void)
 {
 	if (got_clock_diff) {	/* Must know time zone in order to set clock */
-		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
+		xtime.tv_sec = get_cmos_time(1) + clock_cmos_diff;
 		xtime.tv_nsec = 0; 
 	} 
 }
@@ -1159,7 +1159,7 @@
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -get_cmos_time(0);
 	clock_cmos_diff += get_seconds();
 	got_clock_diff = 1;
 #endif
diff -ruN 991-old/arch/i386/kernel/i386_ksyms.c 991-new/arch/i386/kernel/i386_ksyms.c
--- 991-old/arch/i386/kernel/i386_ksyms.c	2004-11-03 21:55:02.000000000 +1100
+++ 991-new/arch/i386/kernel/i386_ksyms.c	2004-11-12 09:20:09.000000000 +1100
@@ -57,7 +57,7 @@
 #endif
 
 extern unsigned long cpu_khz;
-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int wait);
 
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
diff -ruN 991-old/arch/i386/kernel/time.c 991-new/arch/i386/kernel/time.c
--- 991-old/arch/i386/kernel/time.c	2004-11-12 09:27:07.129404328 +1100
+++ 991-new/arch/i386/kernel/time.c	2004-11-12 09:27:13.982362520 +1100
@@ -303,7 +303,7 @@
 }
 
 /* not static: needed by APM */
-unsigned long get_cmos_time(void)
+unsigned long get_cmos_time(int wait)
 {
 	unsigned long retval;
 
@@ -311,8 +311,8 @@
 
 	if (efi_enabled)
 		retval = efi_get_time();
-	else
-		retval = mach_get_cmos_time();
+	else {
+		retval = mach_get_cmos_time(wait);
 
 	spin_unlock(&rtc_lock);
 
@@ -323,7 +323,7 @@
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
-	long cmos_time = get_cmos_time();
+	long cmos_time = get_cmos_time(0);
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
@@ -336,7 +336,7 @@
 static int time_resume(struct sys_device *dev)
 {
 	unsigned long flags;
-	unsigned long cmos_time = get_cmos_time();
+	unsigned long cmos_time = get_cmos_time(1);
 	unsigned long sec = cmos_time + clock_cmos_diff;
 	unsigned long sleep_length = cmos_time - sleep_start;
 
@@ -376,7 +376,7 @@
 /* Duplicate of time_init() below, with hpet_enable part added */
 void __init hpet_time_init(void)
 {
-	xtime.tv_sec = get_cmos_time();
+	xtime.tv_sec = get_cmos_time(1);
 	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
@@ -404,7 +404,7 @@
 		return;
 	}
 #endif
-	xtime.tv_sec = get_cmos_time();
+	xtime.tv_sec = get_cmos_time(1);
 	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
diff -ruN 991-old/arch/sh/boards/mpc1211/rtc.c 991-new/arch/sh/boards/mpc1211/rtc.c
--- 991-old/arch/sh/boards/mpc1211/rtc.c	2004-11-03 21:53:48.000000000 +1100
+++ 991-new/arch/sh/boards/mpc1211/rtc.c	2004-11-12 09:20:09.000000000 +1100
@@ -20,7 +20,7 @@
 #endif
 
 /* arc/i386/kernel/time.c */
-unsigned long get_cmos_time(void)
+unsigned long get_cmos_time(int wait)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	int i;
@@ -32,12 +32,14 @@
 	 * Let's hope other operating systems interpret the RTC the same way.
 	 */
 	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
+	if (wait) {
+		for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+				break;
+		for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+			if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+				break;
+	}
 	do { /* Isn't this overkill ? UIP above should guarantee consistency */
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
diff -ruN 991-old/arch/x86_64/kernel/time.c 991-new/arch/x86_64/kernel/time.c
--- 991-old/arch/x86_64/kernel/time.c	2004-11-03 21:54:16.000000000 +1100
+++ 991-new/arch/x86_64/kernel/time.c	2004-11-12 09:20:09.000000000 +1100
@@ -495,7 +495,7 @@
 	return cycles_2_ns(a);
 }
 
-unsigned long get_cmos_time(void)
+unsigned long get_cmos_time(int wait)
 {
 	unsigned int timeout, year, mon, day, hour, min, sec;
 	unsigned char last, this;
@@ -514,23 +514,28 @@
 	timeout = 1000000;
 	last = this = 0;
 
-	while (timeout && last && !this) {
-		last = this;
-		this = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
-		timeout--;
+	if (wait) {
+		while (timeout && last && !this) {
+			last = this;
+			this = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
+			timeout--;
+		}
 	}
 
 /*
  * Here we are safe to assume the registers won't change for a whole second, so
  * we just go ahead and read them.
-	 */
-
+ *
+ * Since we may not wait here, re-added while loop from x86. -Nigel Cunningham
+ */
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
 		day = CMOS_READ(RTC_DAY_OF_MONTH);
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
 
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
diff -ruN 991-old/arch/x86_64/kernel/x8664_ksyms.c 991-new/arch/x86_64/kernel/x8664_ksyms.c
--- 991-old/arch/x86_64/kernel/x8664_ksyms.c	2004-11-03 21:51:36.000000000 +1100
+++ 991-new/arch/x86_64/kernel/x8664_ksyms.c	2004-11-12 09:20:09.000000000 +1100
@@ -45,7 +45,7 @@
 EXPORT_SYMBOL(drive_info);
 #endif
 
-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int wait);
 
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
diff -ruN 991-old/include/asm-i386/mach-default/mach_time.h 991-new/include/asm-i386/mach-default/mach_time.h
--- 991-old/include/asm-i386/mach-default/mach_time.h	2004-11-03 21:53:12.000000000 +1100
+++ 991-new/include/asm-i386/mach-default/mach_time.h	2004-11-12 09:20:09.000000000 +1100
@@ -79,7 +79,7 @@
 	return retval;
 }
 
-static inline unsigned long mach_get_cmos_time(void)
+static inline unsigned long mach_get_cmos_time(int wait)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	int i;
@@ -90,12 +90,14 @@
 	 * Let's hope other operating systems interpret the RTC the same way.
 	 */
 	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
+	if (wait) {
+		for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+				break;
+		for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+			if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+				break;
+	}
 	do { /* Isn't this overkill ? UIP above should guarantee consistency */
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

