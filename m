Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVDUVDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVDUVDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDUVDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 17:03:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48329 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261879AbVDUVDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 17:03:40 -0400
Subject: [RFC][PATCH] i386: fix hpet for systems that don't support legacy
	replacement  (v. A0)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 14:03:37 -0700
Message-Id: <1114117417.19541.239.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Currently the i386 HPET code assumes the entire HPET implementation
from the spec is present. This breaks on boxes that do not implement the
optional legacy timer replacement functionality portion of the spec.

This patch, which is very similar to my x86-64 patch for the same issue,
fixes the problem allowing i386 systems that cannot use the HPET for the
timer interrupt and RTC to still use the HPET as a time source. I've
tested this patch on a system systems without HPET, with HPET but
without legacy timer replacement, as well as HPET with legacy timer
replacement.

Comments and feedback would be appreciated.

thanks
-john

Changelog:
A0: First sent to lkml

diff -Nru a/arch/i386/kernel/time_hpet.c b/arch/i386/kernel/time_hpet.c
--- a/arch/i386/kernel/time_hpet.c	2005-04-21 13:55:07 -07:00
+++ b/arch/i386/kernel/time_hpet.c	2005-04-21 13:55:07 -07:00
@@ -26,6 +26,7 @@
 static unsigned long hpet_period;	/* fsecs / HPET clock */
 unsigned long hpet_tick;		/* hpet clks count per tick */
 unsigned long hpet_address;		/* hpet memory map physical address */
+int hpet_use_timer;
 
 static int use_hpet; 		/* can be used for runtime check of hpet */
 static int boot_hpet_disable; 	/* boottime override for HPET timer */
@@ -73,27 +74,30 @@
 	hpet_writel(0, HPET_COUNTER);
 	hpet_writel(0, HPET_COUNTER + 4);
 
-	/*
-	 * Set up timer 0, as periodic with first interrupt to happen at
-	 * hpet_tick, and period also hpet_tick.
-	 */
-	cfg = hpet_readl(HPET_T0_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
-	       HPET_TN_SETVAL | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T0_CFG);
-
-	/*
-	 * The first write after writing TN_SETVAL to the config register sets
-	 * the counter value, the second write sets the threshold.
-	 */
-	hpet_writel(tick, HPET_T0_CMP);
-	hpet_writel(tick, HPET_T0_CMP);
+	if (hpet_use_timer) {
+		/*
+		 * Set up timer 0, as periodic with first interrupt to happen at
+		 * hpet_tick, and period also hpet_tick.
+		 */
+		cfg = hpet_readl(HPET_T0_CFG);
+		cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
+		       HPET_TN_SETVAL | HPET_TN_32BIT;
+		hpet_writel(cfg, HPET_T0_CFG);
 
+		/*
+		 * The first write after writing TN_SETVAL to the config register sets
+		 * the counter value, the second write sets the threshold.
+		 */
+		hpet_writel(tick, HPET_T0_CMP);
+		hpet_writel(tick, HPET_T0_CMP);
+	}
 	/*
  	 * Go!
  	 */
 	cfg = hpet_readl(HPET_CFG);
-	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+	if (hpet_use_timer)
+		cfg |= HPET_CFG_LEGACY;
+	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 
 	return 0;
@@ -128,12 +132,11 @@
 	 * However, we can do with one timer otherwise using the
 	 * the single HPET timer for system time.
 	 */
-	if (
 #ifdef CONFIG_HPET_EMULATE_RTC
-		!(id & HPET_ID_NUMBER) ||
-#endif
-	    !(id & HPET_ID_LEGSUP))
+	if (!(id & HPET_ID_NUMBER))
 		return -1;
+#endif
+
 
 	hpet_period = hpet_readl(HPET_PERIOD);
 	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD))
@@ -152,6 +155,8 @@
 	if (hpet_tick_rem > (hpet_period >> 1))
 		hpet_tick++; /* rounding the result */
 
+	hpet_use_timer = id & HPET_ID_LEGSUP;
+
 	if (hpet_timer_stop_set_go(hpet_tick))
 		return -1;
 
@@ -202,7 +207,8 @@
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	wait_timer_tick = wait_hpet_tick;
+	if (hpet_use_timer)
+		wait_timer_tick = wait_hpet_tick;
 #endif
 	return 0;
 }
diff -Nru a/arch/i386/kernel/timers/timer_hpet.c b/arch/i386/kernel/timers/timer_hpet.c
--- a/arch/i386/kernel/timers/timer_hpet.c	2005-04-21 13:55:07 -07:00
+++ b/arch/i386/kernel/timers/timer_hpet.c	2005-04-21 13:55:07 -07:00
@@ -79,7 +79,7 @@
 
 	eax = hpet_readl(HPET_COUNTER);
 	eax -= hpet_last;	/* hpet delta */
-
+	eax = min(hpet_tick, eax);
 	/*
          * Time offset = (hpet delta) * ( usecs per HPET clock )
 	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
@@ -105,9 +105,12 @@
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	rdtsc(last_tsc_low, last_tsc_high);
 
-	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
-		int lost_ticks = (offset - hpet_last) / hpet_tick;
+	if (hpet_use_timer)
+		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+	else
+		offset = hpet_readl(HPET_COUNTER);
+	if (unlikely(((offset - hpet_last) >= (2*hpet_tick)) && (hpet_last != 0))) {
+		int lost_ticks = ((offset - hpet_last) / hpet_tick) - 1;
 		jiffies_64 += lost_ticks;
 	}
 	hpet_last = offset;
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-04-21 13:55:07 -07:00
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-04-21 13:55:07 -07:00
@@ -477,7 +477,7 @@
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient;
 #ifdef CONFIG_HPET_TIMER
-		if (is_hpet_enabled()){
+		if (is_hpet_enabled() && hpet_use_timer){
 			unsigned long result, remain;
 			printk("Using TSC for gettimeofday\n");
 			tsc_quotient = calibrate_tsc_hpet(NULL);
diff -Nru a/include/asm-i386/hpet.h b/include/asm-i386/hpet.h
--- a/include/asm-i386/hpet.h	2005-04-21 13:55:07 -07:00
+++ b/include/asm-i386/hpet.h	2005-04-21 13:55:07 -07:00
@@ -92,6 +92,7 @@
 
 extern unsigned long hpet_tick;  	/* hpet clks count per tick */
 extern unsigned long hpet_address;	/* hpet memory map physical address */
+extern int hpet_use_timer;
 
 extern int hpet_rtc_timer_init(void);
 extern int hpet_enable(void);


