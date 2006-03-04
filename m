Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWCDEoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCDEoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWCDEoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:44:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:13493 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750932AbWCDEoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:44:06 -0500
Date: Fri, 3 Mar 2006 21:44:05 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>
Message-Id: <20060304044404.12782.88641.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 1/9] Time: Reduced NTP rework (part 1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This reworks some of the interrupt time NTP adjustments so that 
it could be re-used by the generic timekeeping infrastructure. 
	
This is done by logically separating the code which adjusts xtime from 
the code that decides, based on the NTP state variables, how much to 
adjust time each tick.
	
This should not affect the existing behavior, but just separate the 
logical functionality so it can be re-used.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 timer.c |   95 +++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 67 insertions(+), 28 deletions(-)

linux-2.6.16-rc5_timeofday-ntp-part1_B20.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
index fc6646f..680fa7e 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -741,34 +741,68 @@ static long adjtime_adjustment(void)
 	return time_adjust_step;
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
 
-	time_adjust_step = adjtime_adjustment();
-	if (time_adjust_step)
-		/* Reduce by this step the amount of time left  */
-		time_adjust -= time_adjust_step;
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
+	/* increment the interval sum: */
+	interval_sum += interval_ns;
+
+	/* calculate the per tick singleshot adjtime adjustment step: */
+	while (interval_ns >= tick_nsec) {
+		time_adjust -= adjtime_adjustment();
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
@@ -792,19 +826,24 @@ u64 current_tick_length(void)
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
+		 * Calculate the nsec delta using the NTP
+		 * adjustments:
+		 *     tick_nsec, adjtime_adjustment(), phase_advance()
+		 */
+		long delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
+		delta_nsec += phase_advance();
+
+		xtime_advance(delta_nsec);
+		ntp_advance(tick_nsec);
+		time_interpolator_update(delta_nsec);
+
+	} while (--ticks);
 }
 
 /*
