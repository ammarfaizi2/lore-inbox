Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759352AbWLFBHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759352AbWLFBHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759365AbWLFBHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:07:06 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:36857 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759352AbWLFBHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:07:04 -0500
Message-Id: <20061206010604.916239000@mvista.com>
User-Agent: quilt/0.45-1
Date: Tue, 05 Dec 2006 17:06:04 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: -rt tsc frequency check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure about this code. It's checking the PM timer, and
doesn't seem to touch the TSC, then it marks the TSC unstable
based on the stability of the PM timer. 

The reason that this caught my attention is that it
marks my (AFAIK stable) tsc as unstable when it first 
runs.

Is there something in here that I'm missing?

---
 arch/i386/kernel/tsc.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

Index: linux-2.6.19/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.19.orig/arch/i386/kernel/tsc.c
+++ linux-2.6.19/arch/i386/kernel/tsc.c
@@ -402,40 +402,30 @@ static struct dmi_system_id __initdata b
 
 #define TSC_FREQ_CHECK_INTERVAL (10*MSEC_PER_SEC) /* 10sec in MS */
 static struct timer_list verify_tsc_freq_timer;
-static unsigned long pm_multiplier;
 
 /* XXX - Probably should add locking */
 static void verify_tsc_freq(unsigned long unused)
 {
 	static u64 last_tsc;
-	static unsigned long last_jiffies, last_pm;
+	static unsigned long last_jiffies;
 
 	u64 now_tsc, interval_tsc;
-	unsigned long now_jiffies, interval_jiffies, pm, pm_delta;
+	unsigned long now_jiffies, interval_jiffies ;
 
 	if (check_tsc_unstable())
 		return;
 
 	rdtscll(now_tsc);
 	now_jiffies = jiffies;
-	pm = acpi_pm_read_early();
 
 	if (!last_jiffies)
 		goto out;
 
 	interval_jiffies = now_jiffies - last_jiffies;
 
-	if (pm == last_pm) {
-		interval_tsc = now_tsc - last_tsc;
-		interval_tsc *= HZ;
-		do_div(interval_tsc, cpu_khz*1000);
-	} else {
-		if (pm < last_pm)
-			pm += ACPI_PM_OVRRUN;
-		pm_delta = pm - last_pm;
-		interval_tsc = (((u64) pm_delta) * pm_multiplier) >> 22;
-		do_div(interval_tsc, TICK_NSEC);
-	}
+	interval_tsc = now_tsc - last_tsc;
+	interval_tsc *= HZ;
+	do_div(interval_tsc, cpu_khz*1000);
 
 	if (interval_tsc < (interval_jiffies * 3 / 4)) {
 		printk("TSC appears to be running slowly. "
@@ -446,7 +436,6 @@ static void verify_tsc_freq(unsigned lon
 out:
 	last_tsc = now_tsc;
 	last_jiffies = now_jiffies;
-	last_pm = pm;
 	/* set us up to go off on the next interval: */
 	mod_timer(&verify_tsc_freq_timer,
 		jiffies + msecs_to_jiffies(TSC_FREQ_CHECK_INTERVAL));
@@ -500,8 +489,6 @@ static int __init init_tsc_clocksource(v
 		if (!pmtmr_ioport || !clocksource_tsc.rating)
 			clocksource_tsc.is_continuous = 0;
 
-		pm_multiplier = clocksource_hz2mult(PMTMR_TICKS_PER_SEC, 22);
-
 		init_timer(&verify_tsc_freq_timer);
 		verify_tsc_freq_timer.function = verify_tsc_freq;
 		verify_tsc_freq_timer.expires =
--
