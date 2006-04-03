Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWDCQwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWDCQwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWDCQwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:52:04 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:6532 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751277AbWDCQwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:52:01 -0400
Subject: [PATCH -rt] new update for tod periodic hook cycle times.
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 12:51:44 -0400
Message-Id: <1144083104.24581.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, scratch the two patches that I sent earlier. The ones that added the
enqueue to the hrtimer_interrupt and the tod update.  This patch does
the tod update from update_process_times.  This way we don't need to
allow driver writers the ability to create large latencies, because they
can add their call backs into the hrtimer_interrupt.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt12/kernel/time/timeofday.c
===================================================================
--- linux-2.6.16-rt12.orig/kernel/time/timeofday.c	2006-04-03 12:09:48.000000000 -0400
+++ linux-2.6.16-rt12/kernel/time/timeofday.c	2006-04-03 12:23:59.000000000 -0400
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
@@ -618,6 +631,34 @@ static int timeofday_init_device(void)
 }
 
 device_initcall(timeofday_init_device);
+/**
+ * timeofday_update_cycles - Does periodic update of the cycle_last_interval
+ *	this prevents cycle_last from wrapping in the case that
+ *	 timeofday_periodic_hook is preempted too long to do a update in time.
+ *
+ * Does small interval updates to assist with timeofday_periodic_hook, since
+ * that function is too big to be called from hard interrupt context.
+ *
+ * Called via update_process_times (in interrupt context)
+ */
+
+void timeofday_update_cycles(void)
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
+}
 
 /**
  * timeofday_periodic_hook - Does periodic update of timekeeping values.
@@ -652,10 +693,12 @@ static void timeofday_periodic_hook(unsi
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
@@ -681,7 +724,8 @@ static void timeofday_periodic_hook(unsi
 	next = get_next_clocksource();
 	if (next != clock) {
 		/* immediately set new cycle_last: */
-		cycle_last = read_clocksource(next);
+		cycle_last = cycle_last_interval = read_clocksource(next);
+		cycle_last_index = 0;
 		/* update cycle_now to avoid problems in accumulation later: */
 		cycle_now = cycle_last;
 		/* swap clocksources: */
@@ -728,7 +772,8 @@ static void timeofday_periodic_hook(unsi
 		if (cycle_delta) {
 			delta_nsec = cyc2ns_rem(&old_clock, ntp_adj,
 						cycle_delta, &remainder);
-			cycle_last = cycle_now;
+			cycle_last = cycle_last_interval = cycle_now;
+			cycle_last_index = 0;
 			__increment_system_time(delta_nsec);
 			ntp_advance(delta_nsec);
 		}
@@ -810,7 +855,7 @@ void __init timeofday_init(void)
 	clock = get_next_clocksource();
 
 	/* initialize cycle_last offset base: */
-	cycle_last = read_clocksource(clock);
+	cycle_last = cycle_last_interval = read_clocksource(clock);
 
 	/* initialize wall_time_offset to now: */
 	/* XXX - this should be something like ns_to_ktime() */
Index: linux-2.6.16-rt12/include/linux/timeofday.h
===================================================================
--- linux-2.6.16-rt12.orig/include/linux/timeofday.h	2006-03-31 20:24:38.000000000 -0500
+++ linux-2.6.16-rt12/include/linux/timeofday.h	2006-04-03 12:13:38.000000000 -0400
@@ -32,6 +32,7 @@ extern int do_settimeofday(struct timesp
 extern int timeofday_is_continuous(void);
 extern u32 timeofday_get_clockres(void);
 extern void timeofday_init(void);
+extern void timeofday_update_cycles(void);
 
 #ifndef CONFIG_IS_TICK_BASED
 #define arch_getoffset() (0)
Index: linux-2.6.16-rt12/kernel/timer.c
===================================================================
--- linux-2.6.16-rt12.orig/kernel/timer.c	2006-04-03 12:14:44.000000000 -0400
+++ linux-2.6.16-rt12/kernel/timer.c	2006-04-03 12:14:54.000000000 -0400
@@ -1015,6 +1015,7 @@ void update_process_times(int user_tick)
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_tick);
 	scheduler_tick();
+	timeofday_update_cycles();
 #ifndef CONFIG_PREEMPT_RT
  	run_posix_cpu_timers(p);
 #endif


