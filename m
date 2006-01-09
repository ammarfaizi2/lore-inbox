Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWAIPol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWAIPol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWAIPol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:44:41 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:59085 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S964822AbWAIPoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:44:39 -0500
Date: Mon, 09 Jan 2006 16:43:50 +0100
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] HPET RTC emulation: add watchdog timer
To: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@muc.de>, Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <20060109154350.GA22126@turing.informatik.uni-halle.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
X-Scan-Signature: f5b632eca7265bbb17ab7e1153978ded
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent the emulated RTC timer from stopping when interrupts are
disabled for too long, implement the watchdog timer to restart it when
needed.

Index: linux-2.6.15/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.15.orig/arch/i386/kernel/time_hpet.c	2006-01-06 16:11:10.000000000 +0100
+++ linux-2.6.15/arch/i386/kernel/time_hpet.c	2006-01-08 21:31:55.000000000 +0100
@@ -413,9 +413,45 @@ int hpet_set_periodic_freq(unsigned long
 
 int hpet_rtc_dropped_irq(void)
 {
+	unsigned int cnt, ticks_per_int, lost_ints;
+
 	if (!is_hpet_enabled())
 		return 0;
 
+	if (UIE_on | PIE_on | AIE_on) {
+		/*
+		 * The interrupt handler schedules the next interrupt at a
+		 * constant offset from the time the current interrupt was
+		 * scheduled, without regard to the actual time. When the
+		 * handler is delayed too long, it tries to schedule the next
+		 * interrupt in the past and the hardware would not interrupt
+		 * until the counter had wrapped around. We catch it here.
+		 */
+		cnt = hpet_readl(HPET_COUNTER);
+		/* was the comparator set to a time in the past? */
+		if ((int)(cnt - hpet_t1_cmp) > 0) {
+			/* determine how many interrupts were actually lost */
+			ticks_per_int = (hpet_tick * HZ) / hpet_rtc_int_freq;
+			lost_ints = (cnt - hpet_t1_cmp) / ticks_per_int + 1;
+			/*
+			 * Make sure that, even with the time needed to execute
+			 * this code, the next scheduled interrupt has been
+			 * moved back to the future.
+			 */
+			lost_ints++;
+
+			cnt = hpet_t1_cmp + lost_ints * ticks_per_int;
+			hpet_writel(cnt, HPET_T1_CMP);
+			hpet_t1_cmp = cnt;
+
+			if (PIE_on)
+				PIE_count += lost_ints;
+
+			printk(KERN_WARNING "rtc: lost some interrupts"
+			       " at %ldHz.\n", hpet_rtc_int_freq);
+		}
+	}
+
 	return 1;
 }
 
Index: linux-2.6.15/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.15.orig/arch/x86_64/kernel/time.c	2006-01-06 16:11:13.000000000 +0100
+++ linux-2.6.15/arch/x86_64/kernel/time.c	2006-01-08 21:42:16.000000000 +0100
@@ -1234,9 +1234,45 @@ int hpet_set_periodic_freq(unsigned long
 
 int hpet_rtc_dropped_irq(void)
 {
+	unsigned int cnt, ticks_per_int, lost_ints;
+
 	if (!is_hpet_enabled())
 		return 0;
 
+	if (UIE_on | PIE_on | AIE_on) {
+		/*
+		 * The interrupt handler schedules the next interrupt at a
+		 * constant offset from the time the current interrupt was
+		 * scheduled, without regard to the actual time. When the
+		 * handler is delayed too long, it tries to schedule the next
+		 * interrupt in the past and the hardware would not interrupt
+		 * until the counter had wrapped around. We catch it here.
+		 */
+		cnt = hpet_readl(HPET_COUNTER);
+		/* was the comparator set to a time in the past? */
+		if ((int)(cnt - hpet_t1_cmp) > 0) {
+			/* determine how many interrupts were actually lost */
+			ticks_per_int = (hpet_tick * HZ) / hpet_rtc_int_freq;
+			lost_ints = (cnt - hpet_t1_cmp) / ticks_per_int + 1;
+			/*
+			 * Make sure that, even with the time needed to execute
+			 * this code, the next scheduled interrupt has been
+			 * moved back to the future.
+			 */
+			lost_ints++;
+
+			cnt = hpet_t1_cmp + lost_ints * ticks_per_int;
+			hpet_writel(cnt, HPET_T1_CMP);
+			hpet_t1_cmp = cnt;
+
+			if (PIE_on)
+				PIE_count += lost_ints;
+
+			printk(KERN_WARNING "rtc: lost some interrupts"
+			       " at %ldHz.\n", hpet_rtc_int_freq);
+		}
+	}
+
 	return 1;
 }
 
