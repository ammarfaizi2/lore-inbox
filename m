Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWDCP1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWDCP1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWDCP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:27:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:14535 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751704AbWDCP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:27:32 -0400
Subject: [PATCH 02/02 -rt] Include an interval timer for
	timeofday_periodic_hook
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:27:13 -0400
Message-Id: <1144078033.21444.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses an interval timer that can be updated in interrupt
context without too much latency, so that the timeofday_periodic_hook
doesn't wrap if is is prevented from executing because of a high
priority task.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt12/kernel/time/timeofday.c
===================================================================
--- linux-2.6.16-rt12.orig/kernel/time/timeofday.c	2006-04-03 11:14:29.000000000 -0400
+++ linux-2.6.16-rt12/kernel/time/timeofday.c	2006-04-03 11:18:44.000000000 -0400
@@ -69,8 +69,19 @@ static struct timespec monotonic_time_of
  * cycle_last:
  *	Value of the clocksource at the last timeofday_periodic_hook()
  *	(adjusted only minorly to account for rounded off cycles)
+ * cycle_last_interval:
+ *	A value called at small intervals to prevent the cycle_last
+ *	from wrapping.  The difference is added to cycle_last_index
+ *	to keep a running value of the time from the last call to
+ *	timeofday_periodic_hook.
+ * cycle_last_index:
+ *	The time called by the cycle update between calls
+ *	to timeofday_periodic_hook.  The cycle update can be done in
+ *	interrupt context, where as the periodic hook is too heavy.
  */
 static cycle_t cycle_last;
+static cycle_t cycle_last_interval;
+static cycle_t cycle_last_index;
 
 /* [clocksource_interval variables]
  * ts_interval:
@@ -271,7 +282,8 @@ static inline s64 __get_nsec_offset(void
 	cycle_now = read_clocksource(clock);
 
 	/* calculate the delta since the last timeofday_periodic_hook: */
-	cycle_delta = (cycle_now - cycle_last) & clock->mask;
+	cycle_delta = (cycle_now - cycle_last_interval) & clock->mask;
+	cycle_delta += cycle_last_index;
 
 	/* convert to nanoseconds: */
 	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
@@ -575,7 +587,8 @@ static int timeofday_resume_hook(struct 
 	 * time drift.
 	 */
 	suspend_end = read_persistent_clock();
-	cycle_last = read_clocksource(clock);
+	cycle_last = cycle_last_interval = read_clocksource(clock);
+	cycle_last_index = 0;
 
 	/* calculate suspend time and add it to system time: */
 	suspend_time = suspend_end - suspend_start;
@@ -619,6 +632,48 @@ static int timeofday_init_device(void)
 
 device_initcall(timeofday_init_device);
 
+static int timeofday_update_cycles(struct hrtimer *timer)
+{
+	unsigned long flags;
+
+	cycle_t cycle_now, cycle_delta;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* read time source & calc time since last call: */
+	cycle_now = read_clocksource(clock);
+	cycle_delta = (cycle_now - cycle_last_interval) & clock->mask;
+	cycle_last_interval = cycle_now;
+
+	cycle_last_index += cycle_delta;
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	timer->expires.tv64 += TICK_NSEC;
+
+	return HRTIMER_RESTART;
+}
+
+static struct hrtimer cycle_update_timer;
+
+static void timeofday_init_update_cycles(void)
+{
+	ktime_t now;
+
+	hrtimer_init(&cycle_update_timer, CLOCK_MONOTONIC,
+		     HRTIMER_ABS);
+
+	cycle_update_timer.function = timeofday_update_cycles;
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+	cycle_update_timer.mode = HRTIMER_CB_IRQSAFE;
+#endif
+	now = ktime_get();
+	now.tv64 += TICK_NSEC;
+
+	hrtimer_start(&cycle_update_timer, now, HRTIMER_ABS);
+}
+
 /**
  * timeofday_periodic_hook - Does periodic update of timekeeping values.
  * @unused:	unused value
@@ -652,10 +707,12 @@ static void timeofday_periodic_hook(unsi
 	/* read time source & calc time since last call: */
 	cycle_now = read_clocksource(clock);
 	check_periodic_interval(cycle_now);
-	cycle_delta = (cycle_now - cycle_last) & clock->mask;
+	cycle_delta = (cycle_now - cycle_last_interval) & clock->mask;
+	cycle_delta += cycle_last_index;
+	cycle_last = cycle_last_interval = cycle_now;
+	cycle_last_index = 0;
 
 	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
-	cycle_last = (cycle_now - cycle_delta)&clock->mask;
 
 	/* update system_time:  */
 	__increment_system_time(delta_nsec);
@@ -681,7 +738,8 @@ static void timeofday_periodic_hook(unsi
 	next = get_next_clocksource();
 	if (next != clock) {
 		/* immediately set new cycle_last: */
-		cycle_last = read_clocksource(next);
+		cycle_last = cycle_last_interval = read_clocksource(next);
+		cycle_last_index = 0;
 		/* update cycle_now to avoid problems in accumulation later: */
 		cycle_now = cycle_last;
 		/* swap clocksources: */
@@ -728,7 +786,8 @@ static void timeofday_periodic_hook(unsi
 		if (cycle_delta) {
 			delta_nsec = cyc2ns_rem(&old_clock, ntp_adj,
 						cycle_delta, &remainder);
-			cycle_last = cycle_now;
+			cycle_last = cycle_last_interval = cycle_now;
+			cycle_last_index = 0;
 			__increment_system_time(delta_nsec);
 			ntp_advance(delta_nsec);
 		}
@@ -810,7 +869,7 @@ void __init timeofday_init(void)
 	clock = get_next_clocksource();
 
 	/* initialize cycle_last offset base: */
-	cycle_last = read_clocksource(clock);
+	cycle_last = cycle_last_interval = read_clocksource(clock);
 
 	/* initialize wall_time_offset to now: */
 	/* XXX - this should be something like ns_to_ktime() */
@@ -828,6 +887,8 @@ void __init timeofday_init(void)
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
+	timeofday_init_update_cycles();
+
 	/* install timeofday_periodic_hook timer: */
 	init_timer(&timeofday_timer);
 	timeofday_timer.function = timeofday_periodic_hook;


