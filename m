Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTEPVPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTEPVPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:15:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:21192 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264533AbTEPVPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:15:11 -0400
Date: Fri, 16 May 2003 14:23:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
       john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@napali.hpl.hp.com>
Subject: time interpolation hooks
Message-Id: <20030516142311.3844ee97.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 21:27:59.0163 (UTC) FILETIME=[05E7F8B0:01C31BF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gents, the below patch comes from David M-T, out of the ia64 tree.  It may
be a suitable solution to the "gettimeofday goes backwards when interrupts
were blocked" problem.

It will need per-arch support.  I'm not sure what that looks like; maybe
David can outline what the reset/update functions should do?

(Those function pointers should go away in favour of optionally-stubbed-out
static calls.  Minor point).


Please review, thanks.





Basically, what the patch does is provide two hooks such that platforms
(and subplatforms) can provide time-interpolation in a way that guarantees
that two causally related gettimeofday() calls will never see time going
backwards (unless there is a settimeofday() call, of course).

There is some evidence that the current scheme does work: we use it on ia64
both for cycle-counter-based interpolation and the SGI folks use it with a
chipset-based high-performance counter.


It seems like enough platforms do this sort of thing to provide _some_
support in the core, especially because it's rather tricky to guarantee
that time never goes backwards (short of a settimeofday, of course).

This patch is based on something Jes Sorensen wrote for the SGI Itanium 2
platform (which has a chipset-internal high-res clock).  I adapted it so it
can be used for cycle-counter interpolation also.  The net effect is that
"last_time_offset" can be removed completely from the kernel.

The basic idea behind the patch is simply: every time you advance xtime by
N nanoseconds, you call update_wall_time_hook(NSEC).  Every time the time
gets set (i.e., discontinuity is OK), reset_wall_time_hook() is called.



 25-akpm/include/linux/timex.h |    7 +++++++
 25-akpm/kernel/time.c         |    8 +++-----
 25-akpm/kernel/timer.c        |   27 ++++++++++++++++++++-------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff -puN include/linux/timex.h~time-interpolation-infrastructure include/linux/timex.h
--- 25/include/linux/timex.h~time-interpolation-infrastructure	Fri May 16 14:13:11 2003
+++ 25-akpm/include/linux/timex.h	Fri May 16 14:13:11 2003
@@ -310,6 +310,13 @@ extern long pps_calcnt;		/* calibration 
 extern long pps_errcnt;		/* calibration errors */
 extern long pps_stbcnt;		/* stability limit exceeded */
 
+/*
+ * Call-back for high precision timer sources to snapshot every time
+ * wall_jiffies is updated.
+ */
+extern void (*update_wall_time_hook)(long adjust_nsec);
+extern void (*reset_wall_time_hook)(void);
+
 #endif /* KERNEL */
 
 #endif /* LINUX_TIMEX_H */
diff -puN kernel/time.c~time-interpolation-infrastructure kernel/time.c
--- 25/kernel/time.c~time-interpolation-infrastructure	Fri May 16 14:13:11 2003
+++ 25-akpm/kernel/time.c	Fri May 16 14:13:11 2003
@@ -35,8 +35,6 @@
  */
 struct timezone sys_tz;
 
-extern unsigned long last_time_offset;
-
 #if !defined(__alpha__) && !defined(__ia64__)
 
 /*
@@ -77,9 +75,10 @@ asmlinkage long sys_stime(int * tptr)
 	if (get_user(value, tptr))
 		return -EFAULT;
 	write_seqlock_irq(&xtime_lock);
+
+	(*reset_wall_time_hook)();
 	xtime.tv_sec = value;
 	xtime.tv_nsec = 0;
-	last_time_offset = 0;
 	time_adjust = 0;	/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -125,7 +124,7 @@ inline static void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
 	xtime.tv_sec += sys_tz.tz_minuteswest * 60;
-	last_time_offset = 0;
+	(*update_wall_time_hook)(sys_tz.tz_minuteswest * 60 * NSEC_PER_SEC);
 	write_sequnlock_irq(&xtime_lock);
 }
 
@@ -381,7 +380,6 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
-	last_time_offset = 0;
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);
diff -puN kernel/timer.c~time-interpolation-infrastructure kernel/timer.c
--- 25/kernel/timer.c~time-interpolation-infrastructure	Fri May 16 14:13:11 2003
+++ 25-akpm/kernel/timer.c	Fri May 16 14:13:11 2003
@@ -65,6 +65,16 @@ struct tvec_t_base_s {
 
 typedef struct tvec_t_base_s tvec_base_t;
 
+/*
+ * Hooks for using external high precision timers for the system clock.
+ * On systems where the CPU clock isn't synchronized between CPUs,
+ * it is necessary to use an external source such as an RTC to obtain
+ * precision in gettimeofday().
+ */
+static void nop (void) { }
+void (*update_wall_time_hook)(long delta_nsec) = (void (*) (void)) &nop;
+void (*reset_wall_time_hook)(void) = &nop;
+
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
 {
@@ -517,6 +527,7 @@ static void second_overflow(void)
 	if (xtime.tv_sec % 86400 == 0) {
 	    xtime.tv_sec--;
 	    wall_to_monotonic.tv_sec++;
+	    (*update_wall_time_hook)(-NSEC_PER_SEC);
 	    time_state = TIME_OOP;
 	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
@@ -527,6 +538,7 @@ static void second_overflow(void)
 	if ((xtime.tv_sec + 1) % 86400 == 0) {
 	    xtime.tv_sec++;
 	    wall_to_monotonic.tv_sec--;
+	    (*update_wall_time_hook)(NSEC_PER_SEC);
 	    time_state = TIME_WAIT;
 	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
@@ -605,7 +617,7 @@ static void second_overflow(void)
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	long time_adjust_step;
+	long time_adjust_step, delta_nsec;
 
 	if ( (time_adjust_step = time_adjust) != 0 ) {
 	    /* We are doing an adjtime thing. 
@@ -621,11 +633,11 @@ static void update_wall_time_one_tick(vo
 		time_adjust_step = tickadj;
 	     else if (time_adjust < -tickadj)
 		time_adjust_step = -tickadj;
-	     
+
 	    /* Reduce by this step the amount of time left  */
 	    time_adjust -= time_adjust_step;
 	}
-	xtime.tv_nsec += tick_nsec + time_adjust_step * 1000;
+	delta_nsec = tick_nsec + time_adjust_step * 1000;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
@@ -634,13 +646,15 @@ static void update_wall_time_one_tick(vo
 	if (time_phase <= -FINEUSEC) {
 		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
 		time_phase += ltemp << (SHIFT_SCALE - 10);
-		xtime.tv_nsec -= ltemp;
+		delta_nsec -= ltemp;
 	}
 	else if (time_phase >= FINEUSEC) {
 		long ltemp = time_phase >> (SHIFT_SCALE - 10);
 		time_phase -= ltemp << (SHIFT_SCALE - 10);
-		xtime.tv_nsec += ltemp;
+		delta_nsec += ltemp;
 	}
+	xtime.tv_nsec += delta_nsec;
+	(*update_wall_time_hook)(delta_nsec);	/* update time interpolation */
 }
 
 /*
@@ -660,6 +674,7 @@ static void update_wall_time(unsigned lo
 	if (xtime.tv_nsec >= 1000000000) {
 	    xtime.tv_nsec -= 1000000000;
 	    xtime.tv_sec++;
+	    (*update_wall_time_hook)(NSEC_PER_SEC);
 	    second_overflow();
 	}
 }
@@ -777,7 +792,6 @@ unsigned long wall_jiffies = INITIAL_JIF
 #ifndef ARCH_HAVE_XTIME_LOCK
 seqlock_t xtime_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
 #endif
-unsigned long last_time_offset;
 
 /*
  * This function runs timers and the timer-tq in bottom half context.
@@ -811,7 +825,6 @@ static inline void update_times(void)
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
 	}
-	last_time_offset = 0;
 	calc_load(ticks);
 }
   

_

