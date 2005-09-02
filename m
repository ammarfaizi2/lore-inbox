Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVIBPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVIBPpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbVIBPpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:45:39 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:50826 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751498AbVIBPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:45:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: [PATCH 2/3] dyntick - Fix lost tick calculation in timer pm.c
Date: Sat, 3 Sep 2005 01:45:18 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <200509030143.57782.kernel@kolivas.org>
In-Reply-To: <200509030143.57782.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OOHGDeV8T3oqGU0"
Message-Id: <200509030145.18368.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_OOHGDeV8T3oqGU0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Con
---




--Boundary-00=_OOHGDeV8T3oqGU0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dyntick-Fix_lost_tick_calculation_in_timer_pm_c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dyntick-Fix_lost_tick_calculation_in_timer_pm_c.patch"

Currently, lost tick calculation in timer_pm.c is based on number
of microseconds that has elapsed since the last tick. Calculating
the number of microseconds is approximated by cyc2us, which
basically does :

	microsec = (cycles * 286) / 1024

Consider 10 ticks lost. This amounts to 14319*10 = 143190 cycles 
(14319 = PMTMR_EXPECTED_RATE/(CALIBRATE_LATCH/LATCH)).
This amount to 39992 microseconds as per the above equation 
or 39992 / 4000 = 9 lost ticks, which is incorrect.

I feel lost ticks can be based on cycles difference directly
rather than being based on microseconds that has elapsed.

Following patch is in that direction. 

With this patch, time had kept up really well on one particular
machine (Intel 4way Pentium 3 box) overnight, while
on another newer machine (Intel 4way Xeon with HT) it didnt do so
well (time sped up after 3 or 4 hours). Hence I consider this
particular patch will need more review/work.

Fix lost tick calculation in timer_pm.c

Code by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_pm.c	2005-09-03 01:11:55.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c	2005-09-03 01:12:11.000000000 +1000
@@ -31,6 +31,8 @@
   ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
 
 
+static int pm_ticks_per_jiffy = PMTMR_EXPECTED_RATE / (CALIBRATE_LATCH/LATCH);
+
 /* The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
  * in arch/i386/acpi/boot.c */
@@ -38,8 +40,7 @@ u32 pmtmr_ioport = 0;
 
 
 /* value of the Power timer at last timer interrupt */
-static u32 offset_tick;
-static u32 offset_delay;
+static u32 offset_last;
 
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
@@ -128,6 +129,11 @@ pm_good:
 	if (verify_pmtmr_rate() != 0)
 		return -ENODEV;
 
+	printk ("Using %u PM timer ticks per jiffy \n", pm_ticks_per_jiffy);
+
+	offset_last = read_pmtmr();
+	setup_pit_timer();
+
 	init_cpu_khz();
 	set_dyn_tick_max_skip((0xFFFFFF / (286 * 1000000)) * 1024 * HZ);
 	return 0;
@@ -152,47 +158,37 @@ static inline u32 cyc2us(u32 cycles)
  */
 static void mark_offset_pmtmr(void)
 {
-	u32 lost, delta, last_offset;
-	static int first_run = 1;
-	last_offset = offset_tick;
+	u32 lost, delta, deltaus, offset_now;
 
 	write_seqlock(&monotonic_lock);
 
-	offset_tick = read_pmtmr();
+	offset_now = read_pmtmr();
 
 	/* calculate tick interval */
-	delta = (offset_tick - last_offset) & ACPI_PM_MASK;
+	delta = (offset_now - offset_last) & ACPI_PM_MASK;
 
 	/* convert to usecs */
-	delta = cyc2us(delta);
+	deltaus = cyc2us(delta);
 
 	/* update the monotonic base value */
-	monotonic_base += delta * NSEC_PER_USEC;
+	monotonic_base += deltaus * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
 	/* convert to ticks */
-	delta += offset_delay;
-	lost = delta / (USEC_PER_SEC / HZ);
-	offset_delay = delta % (USEC_PER_SEC / HZ);
-
+	lost = delta / pm_ticks_per_jiffy;
+	offset_last += lost * pm_ticks_per_jiffy;
+	offset_last &= ACPI_PM_MASK;
 
 	/* compensate for lost ticks */
 	if (lost >= 2)
 		jiffies_64 += lost - 1;
-
-	/* don't calculate delay for first run,
-	   or if we've got less then a tick */
-	if (first_run || (lost < 1)) {
-		first_run = 0;
-		offset_delay = 0;
-	}
 }
 
 static int pmtmr_resume(void)
 {
 	write_seqlock(&monotonic_lock);
 	/* Assume this is the last mark offset time */
-	offset_tick = read_pmtmr();
+	offset_last = read_pmtmr();
 	write_sequnlock(&monotonic_lock);
 	return 0;
 }
@@ -207,7 +203,7 @@ static unsigned long long monotonic_cloc
 	/* atomically read monotonic base & last_offset */
 	do {
 		seq = read_seqbegin(&monotonic_lock);
-		last_offset = offset_tick;
+		last_offset = offset_last;
 		base = monotonic_base;
 	} while (read_seqretry(&monotonic_lock, seq));
 
@@ -241,11 +237,11 @@ static unsigned long get_offset_pmtmr(vo
 {
 	u32 now, offset, delta = 0;
 
-	offset = offset_tick;
+	offset = offset_last;
 	now = read_pmtmr();
 	delta = (now - offset)&ACPI_PM_MASK;
 
-	return (unsigned long) offset_delay + cyc2us(delta);
+	return (unsigned long) cyc2us(delta);
 }
 
 

--Boundary-00=_OOHGDeV8T3oqGU0--
