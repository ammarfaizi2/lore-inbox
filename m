Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVKAWYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVKAWYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKAWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:24:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:8358 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751349AbVKAWYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:24:13 -0500
Subject: [RFC][PATCH 1/12] Reduced NTP rework (part 1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:24:09 -0800
Message-Id: <1130883849.27168.458.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	With Roman's suggestions, I've been working on reducing the footprint
of my timeofday patches. This is the first of two patches that reworks
some of the interrupt time NTP adjustments so that it could be re-used
with the timeofday patches. The motivation of the change is to logically
separate the code which adjusts xtime and the code that decides, based
on the NTP state variables, how much per tick to adjust xtime. 

Thus this patch should not affect the existing behaviour, but just
separate the logical functionality so it can be re-used.

This patch applies ontop of my ntp-shift-right patch I posted awhile
back.

thanks
-john

 timer.c |   96 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 63 insertions(+), 33 deletions(-)

linux-2.6.14-rc5-mm1_timeofday-ntp-part1_B9.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -589,6 +589,7 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
+long time_adjust_step;	/* per tick time_adjust step */
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -716,45 +717,52 @@ static void second_overflow(void)
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
@@ -766,14 +774,36 @@ static void update_wall_time_one_tick(vo
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
 


