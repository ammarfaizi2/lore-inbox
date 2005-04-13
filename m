Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVDMCsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVDMCsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVDMCpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:45:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:54477 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262133AbVDMCnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:43:19 -0400
Subject: [RFC][PATCH] X86_64: no legacy HPET fix
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 19:43:16 -0700
Message-Id: <1113360197.19541.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Currently the x86-64 HPET code assumes the entire HPET implementation
from the spec is present. This breaks on boxes that do not implement the
optional legacy timer replacement functionality portion of the spec.

This is my first swing at resolving this issue, allowing x86-64 systems
that cannot use the HPET for the timer interrupt and RTC to still use
the HPET as a time source. Unfortunately I haven't gotten to test this
on other HPET enabled systems, so proceed with caution.

Its likely a similar patch will be necessary for i386.

Comments/Thoughts/Feedback?

thanks
-john

linux-2.6.12-rc2_hpet-nolegacy-fix_A0
=====================================
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2005-04-12 19:31:50 -07:00
+++ b/arch/x86_64/kernel/time.c	2005-04-12 19:31:50 -07:00
@@ -60,6 +60,7 @@
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
+static int hpet_use_timer;
 unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
@@ -373,8 +374,10 @@
 
 	write_seqlock(&xtime_lock);
 
-	if (vxtime.hpet_address) {
-		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+	if (vxtime.hpet_address)
+		offset = hpet_readl(HPET_COUNTER);
+
+	if (hpet_use_timer) {
 		delay = hpet_readl(HPET_COUNTER) - offset;
 	} else {
 		spin_lock(&i8253_lock);
@@ -732,7 +735,7 @@
 	struct hpet_data	hd;
 	unsigned int 		ntimer;
 
-	if (!vxtime.hpet_address)
+	if (!hpet_use_timer)
           return -1;
 
 	memset(&hd, 0, sizeof (hd));
@@ -794,17 +797,18 @@
  * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
  * and period also hpet_tick.
  */
-
-	hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
+	if (hpet_use_timer) {
+		hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
 		    HPET_TN_32BIT, HPET_T0_CFG);
-	hpet_writel(hpet_tick, HPET_T0_CMP);
-	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
-
+		hpet_writel(hpet_tick, HPET_T0_CMP);
+		hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
+		cfg |= HPET_CFG_LEGACY;
+	}
 /*
  * Go!
  */
 
-	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 
 	return 0;
@@ -825,10 +829,11 @@
 
 	id = hpet_readl(HPET_ID);
 
-	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
-	    !(id & HPET_ID_LEGSUP))
+	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER))
 		return -1;
 
+	hpet_use_timer = (id & HPET_ID_LEGSUP);
+	
 	hpet_period = hpet_readl(HPET_PERIOD);
 	if (hpet_period < 100000 || hpet_period > 100000000)
 		return -1;
@@ -892,9 +897,11 @@
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (!hpet_init()) {
+	if (!hpet_init())
                 vxtime_hz = (1000000000000000L + hpet_period / 2) /
 			hpet_period;
+			
+	if (hpet_use_timer) {
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 	} else {
@@ -940,12 +947,12 @@
 	if (oem_force_hpet_timer())
 		notsc = 1;
 	if (vxtime.hpet_address && notsc) {
-		timetype = "HPET";
+		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
 		vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		vxtime.mode = VXTIME_HPET;
 		do_gettimeoffset = do_gettimeoffset_hpet;
 	} else {
-		timetype = vxtime.hpet_address ? "HPET/TSC" : "PIT/TSC";
+		timetype = hpet_use_timer ? "HPET/TSC" : "PIT/TSC";
 		vxtime.mode = VXTIME_TSC;
 	}
 


