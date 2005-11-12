Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVKLEtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVKLEtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKLEtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:49:00 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:2225 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751333AbVKLEs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:48:59 -0500
Date: Fri, 11 Nov 2005 21:48:57 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Message-Id: <20051112044856.8240.14509.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 1/13] Time: Reduced NTP rework (part 1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	With Roman's suggestions, I've been working on reducing the footprint
of my timeofday patches. This is the first of two patches that reworks
some of the interrupt time NTP adjustments so that it could be re-used
with the timeofday patches. The motivation of the change is to logically
separate the code which adjusts xtime and the code that decides, based
on the NTP state variables, how much per tick to adjust xtime. 

Thus this patch should not affect the existing behavior, but just
separate the logical functionality so it can be re-used.

This patch applies on top of my ntp-shift-right patch I posted awhile
back.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 timer.c |   96 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 63 insertions(+), 33 deletions(-)

linux-2.6.14_timeofday-ntp-part1_B10.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
index 636c669..30a1979 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -589,6 +589,7 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
+long time_adjust_step;	/* per tick time_adjust step */
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -725,45 +726,52 @@ static void second_overflow(void)
 #endif
 }
 
-/* in the NTP reference this is called "hardclock()" */
-static void update_wall_time_one_tick(void)
+/**
+ * ntp_advance() - increments the NTP state machine
+ *
+ * Must be holding the xtime writelock when calling.
+ *
+ */
+static void ntp_advance(unsigned long interval_ns)
 {
-	long time_adjust_step, delta_nsec;
+	static unsigned long interval_sum;
 
-	if ((time_adjust_step = time_adjust) != 0 ) {
-		/*
-		 * We are doing an adjtime thing.  Prepare time_adjust_step to
-		 * be within bounds.  Note that a positive time_adjust means we
-		 * want the clock to run faster.
-		 *
-		 * Limit the amount of the step to be in the range
-		 * -tickadj .. +tickadj
-		 */
-		time_adjust_step = min(time_adjust_step, (long)tickadj);
-		time_adjust_step = max(time_adjust_step, (long)-tickadj);
+	/* increment the interval sum */
+	interval_sum += interval_ns;
+
+	/* calculate the per tick singleshot adjtime adjustment step */
+	while (interval_ns >= tick_nsec) {
+		time_adjust_step = time_adjust;
+		if (time_adjust_step) {
+	    		/* We are doing an adjtime thing.
+	     		 *
+			 * Prepare time_adjust_step to be within bounds.
+			 * Note that a positive time_adjust means we want
+			 * the clock to run faster.
+			 *
+		    	 * Limit the amount of the step to be in the range
+			 * -tickadj .. +tickadj
+			 */
+	    		time_adjust_step = min(time_adjust_step, (long)tickadj);
+			time_adjust_step = max(time_adjust_step,
+							 (long)-tickadj);
 
-		/* Reduce by this step the amount of time left  */
-		time_adjust -= time_adjust_step;
-	}
-	delta_nsec = tick_nsec + time_adjust_step * 1000;
-	/*
-	 * Advance the phase, once it gets to one microsecond, then
-	 * advance the tick more.
-	 */
-	time_phase += time_adj;
-	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
-		long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
-		time_phase -= ltemp << (SHIFT_SCALE - 10);
-		delta_nsec += ltemp;
+			/* Reduce by this step the amount of time left  */
+		    	time_adjust -= time_adjust_step;
+		}
+		interval_ns -= tick_nsec;
 	}
-	xtime.tv_nsec += delta_nsec;
-	time_interpolator_update(delta_nsec);
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust != 0) {
 		time_adjust = time_next_adjust;
 		time_next_adjust = 0;
 	}
+
+	while (interval_sum >= NSEC_PER_SEC) {
+		interval_sum -= NSEC_PER_SEC;
+		second_overflow();
+	}
 }
 
 /*
@@ -775,14 +783,36 @@ static void update_wall_time_one_tick(vo
  */
 static void update_wall_time(unsigned long ticks)
 {
+	long delta_nsec;
+
 	do {
 		ticks--;
-		update_wall_time_one_tick();
-		if (xtime.tv_nsec >= 1000000000) {
-			xtime.tv_nsec -= 1000000000;
+
+		/* Calculate the nsec delta using the
+		 * precomputed NTP adjustments:
+		 *     tick_nsec, time_adjust_step, time_adj
+		 */
+		delta_nsec = tick_nsec + time_adjust_step * 1000;
+		/*
+		 * Advance the phase, once it gets to one microsecond, then
+		 * advance the tick more.
+		 */
+		time_phase += time_adj;
+		if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
+			long ltemp = shift_right(time_phase,
+							(SHIFT_SCALE - 10));
+			time_phase -= ltemp << (SHIFT_SCALE - 10);
+			delta_nsec += ltemp;
+		}
+
+		xtime.tv_nsec += delta_nsec;
+		if (xtime.tv_nsec >= NSEC_PER_SEC) {
+			xtime.tv_nsec -= NSEC_PER_SEC;
 			xtime.tv_sec++;
-			second_overflow();
 		}
+		ntp_advance(tick_nsec);
+		time_interpolator_update(delta_nsec);
+
 	} while (ticks);
 }
 
