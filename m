Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbTLRUph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTLRUph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:45:37 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:39521 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265275AbTLRUpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:45:16 -0500
Date: Thu, 18 Dec 2003 12:44:12 -0800 (PST)
From: John Hawkes <hawkes@babylon.engr.sgi.com>
Message-Id: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Cc: mingo@elte.hu, johnstul@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger suggests raising this issue on LKML to encourage a search
for a more general solution to my ia64 problem.

My specific problem is that the generic ia64 sched_clock() is broken for
"drifty ITC" (the per-CPU cycle counter clock) platforms, such as the SGI
sn.  sched_clock() currently uses its local CPU's ITC and therefore on
drifty platforms its values are not synchronized across the CPUs.  This
results (in part) in an invalid load_balance() is-the-cache-hot-or-not
calculation.

I proposed fixing this in arch/ia64 by making sched_clock() support an
optional platform-specific implementation.  I insert a quick summary of
that patch here, and append the full patch at the end of this email.  In my
patch the generic ia64 implementation remains the same, and the sn platform-
specific implementation uses the sn's synchronized RTC to return a high-
resolution sched_clock() value.

The generic part of my patch:

+static unsigned long long
+itc_sched_clock (void)
+{
+	return (offset * local_cpu_data->nsec_per_cyc) >> IA64_NSEC_PER_CY
C_SHIFT;
+}
+
+unsigned long long (*ia64_sched_clock)(void) = &itc_sched_clock;
+
 unsigned long long
 sched_clock (void)
 {
-	unsigned long offset = ia64_get_itc();
-
-	return (offset * local_cpu_data->nsec_per_cyc) >> IA64_NSEC_PER_CYC_SHIFT;
+	return ia64_sched_clock();
 }

However, David Mosberger rejected this patch, and he seeks instead some
hypothetical more generic approach to "drifty timebase platforms".  One
possible generic change would be to relax the semantics of sched_clock()
to no longer expect that the values be synchronized across all CPUs.
Some amount of code would need to be added to sched.c to deal with
unsynchronized values: scheduler_tick() remembers a local jiffies-
granularity sched_clock() in the runqueue struct, and load_balance's
can_migrate_task() uses that saved timestamp to compare against the tested
task->timestamp to determine cache-hot-or-not, rather than using the local
CPU's sched_clock() value.  Also, task->timestamp needs to be readjusted
when the task migrates:

diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/kernel/sched.c linux-2.6.0-schedclock2/kernel/sched.c
--- linux-2.6.0/kernel/sched.c	Mon Nov 24 12:18:20 2003
+++ linux-2.6.0-schedclock2/kernel/sched.c	Mon Dec 15 17:13:24 2003
@@ -199,7 +199,7 @@
 struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+			nr_uninterruptible, timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -1135,6 +1135,7 @@
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
+	p->timestamp = sched_clock() - (src_rq->timestamp_last_tick - p->timestamp);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
@@ -1155,7 +1156,7 @@
 static inline int
 can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
 {
-	unsigned long delta = sched_clock() - tsk->timestamp;
+	unsigned long delta = rq->timestamp_last_tick - tsk->timestamp;
 
 	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
 		return 0;
@@ -1361,6 +1362,8 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	rq->timestamp_last_tick = sched_clock();
+
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
@@ -2639,6 +2642,8 @@
 		if (p->prio < rq_dest->curr->prio)
 			resched_task(rq_dest->curr);
 	}
+	p->timestamp = rq_dest->timestamp_last_tick;
+
  out:
 	double_rq_unlock(this_rq(), rq_dest);
 	local_irq_restore(flags);


My personal preference is to keep sched_clock() semantics unchanged (i.e.,
to presume that all CPU values are synchronized), and to bury non-compliant
platform complexity in arch-specific and platform-specific implementations,
rather than add any unnecessary complications to sched.c.

As a reference point, the current i386 2.6.0-test11 algorithm is platform-
specific and is, in my opinion, less clean than the arch/ia64 change I have
proposed:  all i386 NUMA platforms are forced to use the low-resolution
"jiffies" value as the only officially synchronized timebase.  (However,
with my sched.c patch, it is possible that i386 NUMA platforms could use the
unsynchronized higher resolution TSC.)

unsigned long long sched_clock(void)
{
	unsigned long long this_offset;

	/*
	 * In the NUMA case we dont use the TSC as they are not
	 * synchronized across all CPUs.
	 */
#ifndef CONFIG_NUMA
	if (!use_tsc)
#endif
		return (unsigned long long)jiffies * (1000000000 / HZ);

	/* Read the Time Stamp Counter */
	rdtscll(this_offset);

	/* return the value in ns */
	return cycles_2_ns(this_offset);
}

This same "#ifndef CONFIG_NUMA" fallback-to-jiffies approach would work for
ia64, but I don't see it as either visually superior to my platform-specific
vector or as functionally superior, because all NUMA platforms would revert
back to using the low-resolution jiffies as the sched_clock() timebase.  The
2.4 kernel used jiffies, and someone decided that in 2.6 the scheduler
needs a higher-resolution timestamp to better calculate process priority.

An unworkable approach (before anyone suggests it) is to periodically resync
ITC clocks:  an sn platform can theoretically support CPUs that run at
different clock speeds, and thus these ITCs can never be synchronized.

Comments?

John Hawkes


Here is the full ia64 patch that Mosberger rejected:

diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/arch/ia64/kernel/time.c linux-2.6.0-schedclock/arch/ia64/kernel/time.c
--- linux-2.6.0/arch/ia64/kernel/time.c	Mon Oct 20 12:48:11 2003
+++ linux-2.6.0-schedclock/arch/ia64/kernel/time.c	Tue Nov 18 17:28:31 2003
@@ -42,12 +42,18 @@
 
 #endif
 
+static unsigned long long
+itc_sched_clock (void)
+{
+	return (offset * local_cpu_data->nsec_per_cyc) >> IA64_NSEC_PER_CY
C_SHIFT;
+}
+
+unsigned long long (*ia64_sched_clock)(void) = &itc_sched_clock;
+
 unsigned long long
 sched_clock (void)
 {
-	unsigned long offset = ia64_get_itc();
-
-	return (offset * local_cpu_data->nsec_per_cyc) >> IA64_NSEC_PER_CYC_SHIFT;
+	return ia64_sched_clock();
 }
 
 static void
diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/arch/ia64/sn/kernel/sn2/timer.c linux-2.6.0-schedclock/arch/ia64/sn/kernel/sn2/timer.c
--- linux-2.6.0/arch/ia64/sn/kernel/sn2/timer.c	Mon Jul 14 11:51:29 2003
+++ linux-2.6.0-schedclock/arch/ia64/sn/kernel/sn2/timer.c	Wed Nov 19 10:00:43 2003
@@ -22,6 +22,8 @@
 extern unsigned long sn_rtc_cycles_per_second;
 static volatile unsigned long last_wall_rtc;
 
+extern unsigned long long (*ia64_sched_clock)(void);
+
 static unsigned long rtc_offset;	/* updated only when xtime write-lock is held! */
 static long rtc_nsecs_per_cycle;
 static long rtc_per_timer_tick;
@@ -55,6 +57,12 @@
 	last_wall_rtc = GET_RTC_COUNTER();
 }
 
+static unsigned long long
+sn_sched_clock(void)
+{
+	return GET_RTC_COUNTER() * rtc_nsecs_per_cycle;
+}
+
 
 static struct time_interpolator sn2_interpolator = {
 	.get_offset =	getoffset,
@@ -73,4 +81,6 @@
 	rtc_nsecs_per_cycle = 1000000000 / sn_rtc_cycles_per_second;
 
 	last_wall_rtc = GET_RTC_COUNTER();
+
+	ia64_sched_clock = &sn_sched_clock;
 }
