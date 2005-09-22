Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVIVT6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVIVT6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVIVT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:58:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44008 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030289AbVIVT6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:58:50 -0400
Subject: [RFC][PATCH 1/2] Reduced NTP rework (part 1)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 12:58:40 -0700
Message-Id: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman, All,
	
	With Roman's suggestions, I've been working on reducing the footprint
of my timeofday patches. This is the first of two patches that I wanted
to float by the list for feedback before I merge it into my patchset.

This patch reworks some of the interrupt time NTP adjustments so that it
could be re-used with the timeofday patches. The motivation of the
change is to logically separate the code which adjusts xtime and the
code that decides (based on the NTP state variables) how much per tick
to adjust xtime. 

Thus this patch should not affect the existing behavior, but just
separate the logical functionality so it can be re-used.

This is mainly for review, so I don't think anyone will really use it,
but it applies ontop of my ntp-shift-right_A3 cleanup patch I sent out
earlier.

thanks
-john

linux-2.6.14-rc2_timeofday-ntp-part1_B6test.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -742,46 +742,47 @@ static void second_overflow(void)
 #endif
 }
 
-/* in the NTP reference this is called "hardclock()" */
-static void update_wall_time_one_tick(void)
+long time_adjust_step;
+
+static void ntp_advance(unsigned long interval_ns)
 {
-	long time_adjust_step, delta_nsec;
+	static unsigned long interval_sum;
 
-	if ( (time_adjust_step = time_adjust) != 0 ) {
-	    /* We are doing an adjtime thing. 
-	     *
-	     * Prepare time_adjust_step to be within bounds.
-	     * Note that a positive time_adjust means we want the clock
-	     * to run faster.
-	     *
-	     * Limit the amount of the step to be in the range
-	     * -tickadj .. +tickadj
-	     */
-	     time_adjust_step = min(time_adjust_step, (long)tickadj);
-	     time_adjust_step = max(time_adjust_step, (long)-tickadj);
+	/* increment the interval sum */
+	interval_sum += interval_ns;
 
-	    /* Reduce by this step the amount of time left  */
-	    time_adjust -= time_adjust_step;
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
+	/* calculate the per tick singleshot adjtime adjustment step */
+	while (interval_ns >= tick_nsec) {
+		time_adjust_step = time_adjust;
+		if (time_adjust_step) {
+	    	/* We are doing an adjtime thing.
+		     *
+		     * Prepare time_adjust_step to be within bounds.
+		     * Note that a positive time_adjust means we want the clock
+	    	 * to run faster.
+		     *
+	    	 * Limit the amount of the step to be in the range
+		     * -tickadj .. +tickadj
+		     */
+	    	 time_adjust_step = min(time_adjust_step, (long)tickadj);
+		     time_adjust_step = max(time_adjust_step, (long)-tickadj);
+
+		    /* Reduce by this step the amount of time left  */
+	    	time_adjust -= time_adjust_step;
+		}
+		interval_ns -= tick_nsec;
 	}
-	xtime.tv_nsec += delta_nsec;
-	time_interpolator_update(delta_nsec);
 
 	/* Changes by adjtime() do not take effect till next tick. */
-	if (time_next_adjust != 0) {
+	if (time_next_adjust) {
 		time_adjust = time_next_adjust;
 		time_next_adjust = 0;
 	}
+
+	while (interval_sum > NSEC_PER_SEC) {
+		interval_sum -= NSEC_PER_SEC;
+		second_overflow();
+	}
 }
 
 /*
@@ -793,14 +794,35 @@ static void update_wall_time_one_tick(vo
  */
 static void update_wall_time(unsigned long ticks)
 {
+	long delta_nsec;
+
 	do {
 		ticks--;
-		update_wall_time_one_tick();
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
+			long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
+			time_phase -= ltemp << (SHIFT_SCALE - 10);
+			delta_nsec += ltemp;
+		}
+
+		xtime.tv_nsec += delta_nsec;
 		if (xtime.tv_nsec >= 1000000000) {
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
-			second_overflow();
 		}
+		ntp_advance(tick_nsec);
+		time_interpolator_update(delta_nsec);
+
 	} while (ticks);
 }
 


