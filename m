Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCWDGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCWDGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCWDGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:06:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:41901 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932137AbWCWDGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:06:17 -0500
Date: Wed, 22 Mar 2006 20:06:13 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mackerras <paulus@samba.org>
Message-Id: <20060323030613.19338.31297.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 4/10] Time: Use clocksource abstraction for NTP adjustments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Instead of incrementing xtime by tick_nsec + ntp adjustments, 
use the clocksource abstraction to increment and scale time. Using the 
clocksource abstraction allows other clocksources to be used 
consistently in the face of late or lost ticks, while preserving the 
existing behavior via the jiffies clocksource.

This removes the need to keep time_phase adjustments as we just use the 
current_tick_length() function as the NTP interface and accumulate time 
using shifted nanoseconds.

The basics of this design was by Roman Zippel, however it is my own 
interpretation and implementation, so the credit should go to him and 
the blame to me.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/clocksource.h |   98 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c              |   47 ++++++++++++---------
 2 files changed, 126 insertions(+), 19 deletions(-)

linux-2.6.16_timeofday-core3_C1.patch
============================================
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index c4187cd..9f1e576 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -173,6 +173,104 @@ static inline void calculate_clocksource
 	c->interval_snsecs = (u64)c->interval_cycles * c->mult;
 }
 
+
+/**
+ * error_aproximation - calculates an error adjustment for a given error
+ *
+ * @error:	Error value (unsigned)
+ * @unit:	Adjustment unit
+ *
+ * For a given error value, this function takes the adjustment unit
+ * and uses binary approximation to return a power of two adjustment value.
+ *
+ * This function is only for use by the the make_ntp_adj() function
+ * and you must hold a write on the xtime_lock when calling.
+ */
+static inline int error_aproximation(u64 error, u64 unit)
+{
+	static int saved_adj = 0;
+	u64 adjusted_unit = unit << saved_adj;
+
+	if (error > (adjusted_unit * 2)) {
+		/* large error, so increment the adjustment factor */
+		saved_adj++;
+	} else if (error > adjusted_unit) {
+		/* just right, don't touch it */
+	} else if (saved_adj) {
+		/* small error, so drop the adjustment factor */
+		saved_adj--;
+		return 0;
+	}
+
+	return saved_adj;
+}
+
+
+/**
+ * make_ntp_adj - Adjusts the specified clocksource for a given error
+ *
+ * @clock:		Pointer to clock to be adjusted
+ * @cycles_delta:	Current unacounted cycle delta
+ * @error:		Pointer to current error value
+ *
+ * Returns clock shifted nanosecond adjustment to be applied against
+ * the accumulated time value (ie: xtime).
+ *
+ * If the error value is large enough, this function calulates the
+ * (power of two) adjustment value, and adjusts the clock's mult and
+ * interval_snsecs values accordingly.
+ *
+ * However, since there may be some unaccumulated cycles, to avoid
+ * time inconsistencies we must adjust the accumulation value
+ * accordingly.
+ *
+ * This is not very intuitive, so the following proof should help:
+ * The basic timeofday algorithm:  base + cycle * mult
+ * Thus:
+ *    new_base + cycle * new_mult = old_base + cycle * old_mult
+ *    new_base = old_base + cycle * old_mult - cycle * new_mult
+ *    new_base = old_base + cycle * (old_mult - new_mult)
+ *    new_base - old_base = cycle * (old_mult - new_mult)
+ *    base_delta = cycle * (old_mult - new_mult)
+ *    base_delta = cycle * (mult_delta)
+ *
+ * Where mult_delta is the adjustment value made to mult
+ *
+ * XXX - Hopefully gcc is smart enough to avoid the multiplies.
+ */
+static inline s64 make_ntp_adj(struct clocksource *clock,
+				cycles_t cycles_delta, s64* error)
+{
+	s64 ret = 0;
+	if (*error  > ((s64)clock->interval_cycles+1)/2) {
+		/* calculate adjustment value */
+		int adjustment = 1 << error_aproximation(*error,
+						clock->interval_cycles);
+		/* adjust clock */
+		clock->mult += adjustment;
+		clock->interval_snsecs += clock->interval_cycles * adjustment;
+
+		/* adjust the base and error for the adjustment */
+		ret =  -(cycles_delta * adjustment);
+		*error -= clock->interval_cycles * adjustment;
+		/* XXX adj error for cycle_delta offset? */
+	} else if ((-(*error))  > ((s64)clock->interval_cycles+1)/2) {
+		/* calculate adjustment value */
+		int adjustment = 1 << error_aproximation(-(*error),
+						clock->interval_cycles);
+		/* adjust clock */
+		clock->mult -= adjustment;
+		clock->interval_snsecs -= clock->interval_cycles * adjustment;
+
+		/* adjust the base and error for the adjustment */
+		ret =  cycles_delta * adjustment;
+		*error += clock->interval_cycles * adjustment;
+		/* XXX adj error for cycle_delta offset? */
+	}
+	return ret;
+}
+
+
 /* used to install a new clocksource */
 int register_clocksource(struct clocksource*);
 void reselect_clocksource(void);
diff --git a/kernel/timer.c b/kernel/timer.c
index dc9b4ec..339d52f 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -599,7 +599,6 @@ long time_tolerance = MAXFREQ;		/* frequ
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-static long time_phase;			/* phase offset (scaled us)	*/
 long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
 static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
@@ -758,27 +757,14 @@ static long adjtime_adjustment(void)
 }
 
 /* in the NTP reference this is called "hardclock()" */
-static void update_wall_time_one_tick(void)
+static void update_ntp_one_tick(void)
 {
-	long time_adjust_step, delta_nsec;
+	long time_adjust_step;
 
 	time_adjust_step = adjtime_adjustment();
 	if (time_adjust_step)
 		/* Reduce by this step the amount of time left  */
 		time_adjust -= time_adjust_step;
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
-	}
-	xtime.tv_nsec += delta_nsec;
-	time_interpolator_update(delta_nsec);
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust != 0) {
@@ -883,8 +869,13 @@ device_initcall(timekeeping_init_device)
  */
 static void update_wall_time(void)
 {
+	static s64 remainder_snsecs, error;
+	s64 snsecs_per_sec;
 	cycle_t now, offset;
 
+	snsecs_per_sec = (s64)NSEC_PER_SEC << clock->shift;
+	remainder_snsecs += (s64)xtime.tv_nsec << clock->shift;
+
 	now = read_clocksource(clock);
 	offset = (now - last_clock_cycle)&clock->mask;
 
@@ -892,17 +883,35 @@ static void update_wall_time(void)
 	 * case of lost or late ticks, it will accumulate correctly.
 	 */
 	while (offset > clock->interval_cycles) {
+		/* get the ntp interval in clock shifted nanoseconds */
+		s64 ntp_snsecs	= current_tick_length(clock->shift);
+
 		/* accumulate one interval */
+		remainder_snsecs += clock->interval_snsecs;
 		last_clock_cycle += clock->interval_cycles;
 		offset -= clock->interval_cycles;
 
-		update_wall_time_one_tick();
-		if (xtime.tv_nsec >= 1000000000) {
-			xtime.tv_nsec -= 1000000000;
+		/* interpolator bits */
+		time_interpolator_update(clock->interval_snsecs
+						>> clock->shift);
+		/* increment the NTP state machine */
+		update_ntp_one_tick();
+
+		/* accumulate error between NTP and clock interval */
+		error += (ntp_snsecs - (s64)clock->interval_snsecs);
+
+		/* correct the clock when NTP error is too big */
+		remainder_snsecs += make_ntp_adj(clock, offset, &error);
+
+		if (remainder_snsecs >= snsecs_per_sec) {
+			remainder_snsecs -= snsecs_per_sec;
 			xtime.tv_sec++;
 			second_overflow();
 		}
 	}
+	/* store full nanoseconds into xtime */
+	xtime.tv_nsec = remainder_snsecs >> clock->shift;
+	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
 }
 
 /*
