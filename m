Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVIBRZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVIBRZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVIBRZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:25:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53951 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750734AbVIBRZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:25:40 -0400
Date: Fri, 2 Sep 2005 22:55:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ck list <ck@vds.kolivas.org>,
       thomas.schlichter@web.de
Subject: Re: [PATCH 2/3] dyntick - Fix lost tick calculation in timer pm.c
Message-ID: <20050902172504.GB4650@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <200509030143.57782.kernel@kolivas.org> <200509030145.18368.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509030145.18368.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,
	Pls use this updated "Lost tick" calculation patch, which rectifies the
two problems Thomas pointed out. I have done some basic test with it. 

Would it be possible to incorporate this updated patch in
http://ck.kolivas.org/patches/dyn-ticks/2.6.13-mm1-dtck1.patch?

Sorry for the inconvenience!

----


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

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>
---

 linux-2.6.13-mm1-root/arch/i386/kernel/timers/timer_pm.c |   48 ++++++---------
 1 files changed, 22 insertions(+), 26 deletions(-)

diff -puN arch/i386/kernel/timers/timer_pm.c~pm_timer_fix arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c~pm_timer_fix	2005-09-02 22:13:44.000000000 +0530
+++ linux-2.6.13-mm1-root/arch/i386/kernel/timers/timer_pm.c	2005-09-02 22:18:09.000000000 +0530
@@ -30,6 +30,8 @@
   ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
 
 
+static int pm_ticks_per_jiffy = PMTMR_EXPECTED_RATE / (CALIBRATE_LATCH/LATCH);
+
 /* The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
  * in arch/i386/acpi/boot.c */
@@ -37,8 +39,7 @@ u32 pmtmr_ioport = 0;
 
 
 /* value of the Power timer at last timer interrupt */
-static u32 offset_tick;
-static u32 offset_delay;
+static u32 offset_last;
 
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
@@ -127,6 +128,11 @@ pm_good:
 	if (verify_pmtmr_rate() != 0)
 		return -ENODEV;
 
+	printk ("Using %u PM timer ticks per jiffy \n", pm_ticks_per_jiffy);
+
+	offset_last = read_pmtmr();
+	setup_pit_timer();
+
 	init_cpu_khz();
 	return 0;
 }
@@ -150,47 +156,37 @@ static inline u32 cyc2us(u32 cycles)
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
+
+	/* convert to ticks */
+	lost = delta / pm_ticks_per_jiffy;
+	offset_last += lost * pm_ticks_per_jiffy;
+	offset_last &= ACPI_PM_MASK;
 
 	/* convert to usecs */
-	delta = cyc2us(delta);
+	deltaus = cyc2us(lost*pm_ticks_per_jiffy);
 
 	/* update the monotonic base value */
-	monotonic_base += delta * NSEC_PER_USEC;
+	monotonic_base += deltaus * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
-	/* convert to ticks */
-	delta += offset_delay;
-	lost = delta / (USEC_PER_SEC / HZ);
-	offset_delay = delta % (USEC_PER_SEC / HZ);
-
-
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
@@ -205,7 +201,7 @@ static unsigned long long monotonic_cloc
 	/* atomically read monotonic base & last_offset */
 	do {
 		seq = read_seqbegin(&monotonic_lock);
-		last_offset = offset_tick;
+		last_offset = offset_last;
 		base = monotonic_base;
 	} while (read_seqretry(&monotonic_lock, seq));
 
@@ -239,11 +235,11 @@ static unsigned long get_offset_pmtmr(vo
 {
 	u32 now, offset, delta = 0;
 
-	offset = offset_tick;
+	offset = offset_last;
 	now = read_pmtmr();
 	delta = (now - offset)&ACPI_PM_MASK;
 
-	return (unsigned long) offset_delay + cyc2us(delta);
+	return (unsigned long) cyc2us(delta);
 }
 
 
_

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
