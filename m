Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWCRAlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWCRAlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWCRAkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:40:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:25295 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932785AbWCRAkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:40:22 -0500
Date: Fri, 17 Mar 2006 17:40:21 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20060318004020.32251.87158.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
References: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 4/10] Time: Use clocksource abstraction for NTP adjustments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Instead of incrementing xtime by tick_nsec + ntp adjustments, 
use the clocksource abstraction. This removes the need to keep 
time_phase adjustments as we just use the current_tick_length() 
function and accumulate using shifted nanoseconds.

By using the clocksource abstraction to increment time, this allows 
other clocksources to be used consistently in the face of late or lost 
ticks, while preserving the existing behavior via the jiffies 
clocksource.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 timer.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 19 deletions(-)

linux-2.6.16-rc6_timeofday-core3_C0.patch
============================================
diff --git a/kernel/timer.c b/kernel/timer.c
index 90fe137..99b6c83 100644
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
 
@@ -892,13 +883,33 @@ static void update_wall_time(void)
 	 * case of lost or late ticks, it will accumulate correctly.
 	 */
 	while (offset > clock->interval_cycles) {
-		update_wall_time_one_tick();
-		if (xtime.tv_nsec >= 1000000000) {
-			xtime.tv_nsec -= 1000000000;
+		s64 ntp_snsecs	= current_tick_length(clock->shift);
+
+		/* increment the last cycle, offset and remainder snsec vals */
+		last_clock_cycle += clock->interval_cycles;
+		offset -= clock->interval_cycles;
+		remainder_snsecs += clock->interval_snsecs;
+
+		/* accumulate error between NTP and clock tick interval */
+		error += (ntp_snsecs - (s64)clock->interval_snsecs);
+
+		/* interpolator bits */
+		time_interpolator_update(clock->interval_snsecs
+						>> clock->shift);
+
+		update_ntp_one_tick();
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
+	xtime.tv_nsec = remainder_snsecs >> clock->shift;
+	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
 }
 
 /*
