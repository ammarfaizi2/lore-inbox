Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTFTVhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbTFTVhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:37:20 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:8579 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264827AbTFTVgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:36:52 -0400
Date: Fri, 20 Jun 2003 23:50:46 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: george anzinger <george@mvista.com>, Christian Kujau <evil@g-house.de>,
       Daniel Whitener <dwhitener@defeet.com>, <johnstul@us.ibm.com>,
       Clemens Schwaighofer <cs@tequila.co.jp>,
       Alex Goddard <agoddard@purdue.edu>
Subject: [patch] fix wrong uptime on non-i386 platforms
Message-ID: <Pine.LNX.4.33.0306202341050.7684-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are most of the missing wall_to_monotonic initializations that the
non-i386 architectures still need to pick up.
This should fix the reported uptime inconsistencies.

Disclaimer: completely untested, since I don't have (most of) the hardware.

Tim

--- linux-2.5.72/arch/alpha/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/alpha/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -369,6 +369,7 @@
 		year += 100;

 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = 0;

 	if (HZ > (1<<16)) {

--- linux-2.5.72/arch/m68k/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/m68k/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -101,6 +101,7 @@
 			time.tm_year += 100;
 		xtime.tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
 				      time.tm_hour, time.tm_min, time.tm_sec);
+		wall_to_monotonic.tv_sec = -xtime.tv_sec;
 		xtime.tv_nsec = 0;
 	}


--- linux-2.5.72/arch/m68knommu/kernel/time.c	Sat Jun 14 21:18:24 2003
+++ linux-2.5.72-ufix/arch/m68knommu/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -129,6 +129,7 @@
 	if ((year += 1900) < 1970)
 		year += 100;
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = 0;

 	mach_sched_init(timer_interrupt);

--- linux-2.5.72/arch/parisc/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/parisc/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -242,7 +242,9 @@
 	if(pdc_tod_read(&tod_data) == 0) {
 		write_seqlock_irq(&xtime_lock);
 		xtime.tv_sec = tod_data.tod_sec;
+		wall_to_monotonic.tv_sec = -xtime.tv_sec;
 		xtime.tv_nsec = tod_data.tod_usec * 1000;
+		wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
 		write_sequnlock_irq(&xtime_lock);
 	} else {
 		printk(KERN_ERR "Error reading tod clock\n");

--- linux-2.5.72/arch/ppc/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/ppc/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -332,6 +332,7 @@
 		if (sec==old_sec)
 			printk("Warning: real time clock seems stuck!\n");
 		xtime.tv_sec = sec;
+		wall_to_monotonic.tv_sec = -xtime.tv_sec;
 		xtime.tv_nsec = 0;
 		/* No update now, we just read the time from the RTC ! */
 		last_rtc_update = xtime.tv_sec;

--- linux-2.5.72/arch/ppc64/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/ppc64/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -468,6 +468,7 @@
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			      tm.tm_hour, tm.tm_min, tm.tm_sec);
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	tb_last_stamp = get_tb();
 	do_gtod.tb_orig_stamp = tb_last_stamp;
 	do_gtod.varp = &do_gtod.vars[0];

--- linux-2.5.72/arch/s390/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/s390/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -263,6 +263,8 @@
 	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
 		(0x3c26700LL*1000000*4096);
         tod_to_timeval(set_time_cc, &xtime);
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
+	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;

         /* request the 0x1004 external interrupt */
         if (register_early_external_interrupt(0x1004, do_comparator_interrupt,

--- linux-2.5.72/arch/sh/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/sh/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -367,6 +367,8 @@
 #endif

 	rtc_gettimeofday(&xtime);
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
+	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;

 	setup_irq(TIMER_IRQ, &irq0);


--- linux-2.5.72/arch/sparc/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/sparc/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -408,9 +408,9 @@
 	mon = MSTK_REG_MONTH(mregs);
 	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	wall_to_monotonic.tv_nsec = 0;
+	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
 	mregs->creg &= ~MSTK_CREG_READ;
 	spin_unlock_irq(&mostek_lock);
 #ifdef CONFIG_SUN4

--- linux-2.5.72/arch/sparc64/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/sparc64/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -703,9 +703,9 @@
 	}

 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	wall_to_monotonic.tv_nsec = 0;
+	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;

 	if (mregs) {
 		tmp = mostek_read(mregs + MOSTEK_CREG);

--- linux-2.5.72/arch/x86_64/kernel/time.c	Fri Jun 20 23:25:45 2003
+++ linux-2.5.72-ufix/arch/x86_64/kernel/time.c	Fri Jun 20 23:37:10 2003
@@ -542,6 +542,7 @@
 #endif

 	xtime.tv_sec = get_cmos_time();
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = 0;

 	if (!hpet_init()) {






