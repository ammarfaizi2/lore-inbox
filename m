Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVLPBHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVLPBHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLPBHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:07:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:59278 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751248AbVLPBHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:07:11 -0500
Date: Thu, 15 Dec 2005 18:07:07 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051216010706.19280.30085.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 1/11] Time: Reduced NTP rework (part 1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	With Roman's suggestions, I've been working on reducing the 
footprint of my timeofday patches. This is the first of two patches 
that reworks some of the interrupt time NTP adjustments so that it 
could be re-used with the timeofday patches. The motivation of the 
change is to logically separate the code which adjusts xtime and the 
code that decides, based on the NTP state variables, how much per tick 
to adjust xtime. 

Thus this patch should not affect the existing behavior, but just 
separate the logical functionality so it can be re-used.

Andrew, please consider for inclusion into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 timer.c |  123 ++++++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 85 insertions(+), 38 deletions(-)

linux-2.6.15-rc5_timeofday-ntp-part1_B14.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
index 91572cf..2a0a549 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -589,6 +589,7 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
+long time_adjust_step;			/* per tick time_adjust step */
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -716,45 +717,86 @@ static void second_overflow(void)
 #endif
 }
 
-/* in the NTP reference this is called "hardclock()" */
-static void update_wall_time_one_tick(void)
+/**
+ * ntp_advance - increments the NTP state machine
+ * @interval_ns: interval, in nanoseconds
+ *
+ * Must be holding the xtime writelock when calling.
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
+	/* increment the interval sum: */
+	interval_sum += interval_ns;
+
+	/* calculate the per tick singleshot adjtime adjustment step: */
+	while (interval_ns >= tick_nsec) {
+		time_adjust_step = time_adjust;
+		if (time_adjust_step) {
+	    		/*
+			 * We are doing an adjtime thing.
+			 *
+			 * Prepare time_adjust_step to be within bounds.
+			 * Note that a positive time_adjust means we want
+			 * the clock to run faster.
+			 *
+			 * Limit the amount of the step to be in the range
+			 * -tickadj .. +tickadj:
+			 */
+			time_adjust_step = min(time_adjust_step, (long)tickadj);
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
+			/* Reduce by this step the amount of time left: */
+			time_adjust -= time_adjust_step;
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
+}
+
+/**
+ * phase_advance - advance the phase
+ *
+ * advance the phase, once it gets to one nanosecond advance the tick more.
+ */
+static inline long phase_advance(void)
+{
+	long delta = 0;
+
+	time_phase += time_adj;
+
+	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
+		delta = shift_right(time_phase, (SHIFT_SCALE - 10));
+		time_phase -= delta << (SHIFT_SCALE - 10);
+	}
+
+	return delta;
+}
+
+/**
+ * xtime_advance - advance xtime
+ * @delta_nsec: adjustment in nsecs
+ */
+static inline void xtime_advance(long delta_nsec)
+{
+	xtime.tv_nsec += delta_nsec;
+	if (likely(xtime.tv_nsec < NSEC_PER_SEC))
+		return;
+
+	xtime.tv_nsec -= NSEC_PER_SEC;
+	xtime.tv_sec++;
 }
 
 /*
@@ -762,19 +804,24 @@ static void update_wall_time_one_tick(vo
  * usually just one (we shouldn't be losing ticks,
  * we're doing this this way mainly for interrupt
  * latency reasons, not because we think we'll
- * have lots of lost timer ticks
+ * have lots of lost timer ticks)
  */
 static void update_wall_time(unsigned long ticks)
 {
 	do {
-		ticks--;
-		update_wall_time_one_tick();
-		if (xtime.tv_nsec >= 1000000000) {
-			xtime.tv_nsec -= 1000000000;
-			xtime.tv_sec++;
-			second_overflow();
-		}
-	} while (ticks);
+		/*
+		 * Calculate the nsec delta using the precomputed NTP
+		 * adjustments:
+		 *     tick_nsec, time_adjust_step, time_adj
+		 */
+		long delta_nsec = tick_nsec + time_adjust_step * 1000;
+		delta_nsec += phase_advance();
+
+		xtime_advance(delta_nsec);
+		ntp_advance(tick_nsec);
+		time_interpolator_update(delta_nsec);
+
+	} while (--ticks);
 }
 
 /*
