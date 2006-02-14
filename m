Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWBNSk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWBNSk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWBNSk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:40:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24526 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964859AbWBNSk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:40:26 -0500
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com, Robin Holt <holt@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>, Jes Sorensen <jes@sgi.com>
Date: Tue, 14 Feb 2006 10:40:17 -0800
Message-Id: <20060214184017.20492.48141.sendpatchset@tomahawk.engr.sgi.com>
Subject: Re: [PATCH] ia64: simplify and fix udelay()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version #2, merging Andreas Schwab's suggestion:

The original ia64 udelay() was simple, but flawed for platforms without
synchronized ITCs:  a preemption and migration to another CPU during the
while-loop likely resulted in too-early termination or very, very
lengthy looping.

The first fix (now in 2.6.15) broke the delay loop into smaller,
non-preemptible chunks, reenabling preemption between the chunks.  This
fix is flawed in that the total udelay is computed to be the sum of just
the non-premptible while-loop pieces, i.e., not counting the time spent
in the interim preemptible periods.  If an interrupt or a migration
occurs during one of these interim periods, then that time is invisible
and only serves to lengthen the effective udelay().

This new fix backs out the current flawed fix and returns to a simple
udelay(), fully preemptible and interruptible.  It implements two simple
alternative udelay() routines:  one a default generic version that uses
ia64_get_itc(), and the other an sn-specific version that uses that
platform's RTC.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/arch/ia64/kernel/time.c
===================================================================
--- linux.orig/arch/ia64/kernel/time.c	2006-02-14 10:09:25.000000000 -0800
+++ linux/arch/ia64/kernel/time.c	2006-02-14 10:22:56.000000000 -0800
@@ -250,32 +250,27 @@ time_init (void)
 	set_normalized_timespec(&wall_to_monotonic, -xtime.tv_sec, -xtime.tv_nsec);
 }
 
-#define SMALLUSECS 100
+/*
+ * Generic udelay assumes that if preemption is allowed and the thread
+ * migrates to another CPU, that the ITC values are synchronized across
+ * all CPUs.
+ */
+static void
+ia64_itc_udelay (unsigned long usecs)
+{
+	unsigned long start = ia64_get_itc();
+	unsigned long end = start + usecs*local_cpu_data->cyc_per_usec;
+
+	while (time_before(ia64_get_itc(), end))
+		cpu_relax();
+}
+
+void (*ia64_udelay)(unsigned long usecs) = &ia64_itc_udelay;
 
 void
 udelay (unsigned long usecs)
 {
-	unsigned long start;
-	unsigned long cycles;
-	unsigned long smallusecs;
-
-	/*
-	 * Execute the non-preemptible delay loop (because the ITC might
-	 * not be synchronized between CPUS) in relatively short time
-	 * chunks, allowing preemption between the chunks.
-	 */
-	while (usecs > 0) {
-		smallusecs = (usecs > SMALLUSECS) ? SMALLUSECS : usecs;
-		preempt_disable();
-		cycles = smallusecs*local_cpu_data->cyc_per_usec;
-		start = ia64_get_itc();
-
-		while (ia64_get_itc() - start < cycles)
-			cpu_relax();
-
-		preempt_enable();
-		usecs -= smallusecs;
-	}
+	(*ia64_udelay)(usecs);
 }
 EXPORT_SYMBOL(udelay);
 
Index: linux/arch/ia64/sn/kernel/sn2/timer.c
===================================================================
--- linux.orig/arch/ia64/sn/kernel/sn2/timer.c	2006-01-02 19:21:10.000000000 -0800
+++ linux/arch/ia64/sn/kernel/sn2/timer.c	2006-02-14 10:27:26.000000000 -0800
@@ -14,6 +14,7 @@
 
 #include <asm/hw_irq.h>
 #include <asm/system.h>
+#include <asm/timex.h>
 
 #include <asm/sn/leds.h>
 #include <asm/sn/shub_mmr.h>
@@ -28,9 +29,27 @@ static struct time_interpolator sn2_inte
 	.source = TIME_SOURCE_MMIO64
 };
 
+/*
+ * sn udelay uses the RTC instead of the ITC because the ITC is not
+ * synchronized across all CPUs, and the thread may migrate to another CPU
+ * if preemption is enabled.
+ */
+static void
+ia64_sn_udelay (unsigned long usecs)
+{
+	unsigned long start = rtc_time();
+	unsigned long end = start +
+			usecs * sn_rtc_cycles_per_second / 1000000;
+
+	while (time_before((unsigned long)rtc_time(), end))
+		cpu_relax();
+}
+
 void __init sn_timer_init(void)
 {
 	sn2_interpolator.frequency = sn_rtc_cycles_per_second;
 	sn2_interpolator.addr = RTC_COUNTER_ADDR;
 	register_time_interpolator(&sn2_interpolator);
+
+	ia64_udelay = &ia64_sn_udelay;
 }
Index: linux/include/asm-ia64/timex.h
===================================================================
--- linux.orig/include/asm-ia64/timex.h	2006-01-02 19:21:10.000000000 -0800
+++ linux/include/asm-ia64/timex.h	2006-02-14 10:27:46.000000000 -0800
@@ -15,6 +15,8 @@
 
 typedef unsigned long cycles_t;
 
+extern void (*ia64_udelay)(unsigned long usecs);
+
 /*
  * For performance reasons, we don't want to define CLOCK_TICK_TRATE as
  * local_cpu_data->itc_rate.  Fortunately, we don't have to, either: according to George
