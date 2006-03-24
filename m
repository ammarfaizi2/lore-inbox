Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWCXLUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWCXLUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWCXLUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:20:55 -0500
Received: from mail.gmx.de ([213.165.64.20]:44442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751651AbWCXLUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:20:54 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143198964.7741.23.camel@homer>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer>
	 <1143198964.7741.23.camel@homer>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:21:35 +0100
Message-Id: <1143199295.7741.29.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 4/6

This patch implements the throttling.

Throttling is done via computing a slice_avg, which is the upper limit
of what a task's sleep_avg may be and be sane.  When a task begins to
consume more CPU than it's sleep_avg indicates it should, the task will
be throttled.  A task which conforms to expectations can save credit for
later use, which allows interactive tasks to do a burst of activity
without being throttled.  When their reserve is exhausted however,
that's the end of high ussage at high priority.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm1/include/linux/sched.h.org	2006-02-28 06:11:17.000000000 +0100
+++ linux-2.6.16-mm1/include/linux/sched.h	2006-02-28 06:11:41.000000000 +0100
@@ -733,14 +733,14 @@
 	unsigned short ioprio;
 	unsigned int btrace_seq;
 
-	unsigned long sleep_avg;
+	unsigned long sleep_avg, last_slice, throttle;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
 	enum sleep_type sleep_type;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	unsigned int time_slice, slice_info;
 	long slice_time_ns;
 
 #ifdef CONFIG_SCHEDSTATS
--- linux-2.6.16-mm1/kernel/sched.c-3.interactivity	2006-03-23 15:18:48.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 16:28:04.000000000 +0100
@@ -80,6 +80,21 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
+#if (BITS_PER_LONG < 64)
+#define JIFFIES_TO_NS64(TIME) \
+	((unsigned long long)(TIME) * ((unsigned long) (1000000000 / HZ)))
+
+#define NS64_TO_JIFFIES(TIME) \
+	((((unsigned long long)((TIME)) >> BITS_PER_LONG) * \
+	(1 + NS_TO_JIFFIES(~0UL))) + NS_TO_JIFFIES((unsigned long)(TIME)))
+#else /* BITS_PER_LONG < 64 */
+
+#define NS64_TO_JIFFIES(TIME) NS_TO_JIFFIES(TIME)
+#define JIFFIES_TO_NS64(TIME) JIFFIES_TO_NS(TIME)
+
+#endif /* BITS_PER_LONG < 64 */
+
+
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
@@ -177,6 +192,115 @@
 	return p->sleep_avg + sleep_time >= INTERACTIVE_SLEEP_AVG(p);
 }
 
+/*
+ * Interactive boost can lead to starvation if the decision to
+ * boost a task turns out to be a bad one.  To combat this, we
+ * compute the sane upper limit for cpu usage 'slice_avg' based
+ * upon a task's sleep_avg, and use this information combined
+ * with a timer to determine when intervention is required.
+ *
+ * When a task is behaving as it's sleep_avg indicates it should,
+ * it's throttle is moved forward, otherwise it will timeout, and
+ * the task's priority will be lowered.
+ *
+ * Throttling tunables.
+ *
+ * CREDIT_C1: The amount of cpu time in seconds that a new task
+ *           will run completely free, ie the head start a task
+ *           has before it has to push it's timer forward to avoid
+ *           being throttled.  Each conforming slice thereafter
+ *           increases it's stored credit, and vice versa.
+ *
+ * CREDIT_C2: The maximum amount of CPU time in seconds a task
+ *           can store for later use.  When a task has no stored
+ *           credit left, now is time C2.  Tasks begin life with
+ *           C1 seconds credit, ie C2 is C1 seconds in front of
+ *           them, and the 'buffer' will grow in front of them
+ *           if they perform in a conformant manner.  The maximum
+ *           credit that fits in 32 bits jiffies is 42949 seconds.
+ */
+
+#define CREDIT_C1 10
+#define CREDIT_C2 14400
+
+#define C1 (CREDIT_C1 * MAX_BONUS * HZ)
+#define C2 (CREDIT_C2 * MAX_BONUS * HZ + C1)
+#define C3 (MAX_BONUS * C2)
+
+#define credit_exhausted(p, credit) \
+	(time_after_eq(jiffies, (p)->throttle + (credit)))
+
+/*
+ * Masks for p->slice_info, formerly p->first_time_slice.
+ * SLICE_FTS:   0x80000000  Task is in it's first ever timeslice.
+ * SLICE_NEW:   0x40000000  Slice refreshed.
+ * SLICE_SPA:   0x3FFE0000  Spare bits.
+ * SLICE_LTS:   0x0001FF80  Last time slice
+ * SLICE_AVG:   0x0000007F  Task slice_avg stored as percentage.
+ */
+#define SLICE_AVG_BITS    7
+#define SLICE_LTS_BITS   10
+#define SLICE_SPA_BITS   13
+#define SLICE_NEW_BITS    1
+#define SLICE_FTS_BITS    1
+
+#define SLICE_AVG_SHIFT   0
+#define SLICE_LTS_SHIFT   (SLICE_AVG_SHIFT + SLICE_AVG_BITS)
+#define SLICE_SPA_SHIFT   (SLICE_LTS_SHIFT + SLICE_LTS_BITS)
+#define SLICE_NEW_SHIFT   (SLICE_SPA_SHIFT + SLICE_SPA_BITS)
+#define SLICE_FTS_SHIFT   (SLICE_NEW_SHIFT + SLICE_NEW_BITS)
+
+#define INFO_MASK(x)      ((1U << (x))-1)
+#define SLICE_AVG_MASK    (INFO_MASK(SLICE_AVG_BITS) << SLICE_AVG_SHIFT)
+#define SLICE_LTS_MASK    (INFO_MASK(SLICE_LTS_BITS) << SLICE_LTS_SHIFT)
+#define SLICE_SPA_MASK    (INFO_MASK(SLICE_SPA_BITS) << SLICE_SPA_SHIFT)
+#define SLICE_NEW_MASK    (INFO_MASK(SLICE_NEW_BITS) << SLICE_NEW_SHIFT)
+#define SLICE_FTS_MASK    (INFO_MASK(SLICE_FTS_BITS) << SLICE_FTS_SHIFT)
+
+/*
+ * p->slice_info access macros.
+ */
+#define first_time_slice(p) ((p)->slice_info & SLICE_FTS_MASK)
+#define set_first_time_slice(p) ((p)->slice_info |= SLICE_FTS_MASK)
+#define clr_first_time_slice(p) ((p)->slice_info &= ~SLICE_FTS_MASK)
+
+#define slice_is_new(p) ((p)->slice_info & SLICE_NEW_MASK)
+#define set_slice_is_new(p) ((p)->slice_info |= SLICE_NEW_MASK)
+#define clr_slice_is_new(p) ((p)->slice_info &= ~SLICE_NEW_MASK)
+
+#define last_slice(p) (((p)->slice_info & SLICE_LTS_MASK) >> SLICE_LTS_SHIFT)
+#define set_last_slice(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_LTS_MASK) | (((n) << SLICE_LTS_SHIFT) & SLICE_LTS_MASK)))
+
+#define NS_SLEEP_AVG_PCNT (NS_MAX_SLEEP_AVG / 100)
+
+#define slice_avg(p) ((typeof((p)->sleep_avg)) \
+	((((p)->slice_info & SLICE_AVG_MASK) >> SLICE_AVG_SHIFT) * \
+	NS_SLEEP_AVG_PCNT))
+#define set_slice_avg(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_AVG_MASK) | ((((n) / NS_SLEEP_AVG_PCNT) \
+	<< SLICE_AVG_SHIFT) & SLICE_AVG_MASK)))
+#define slice_avg_raw(p)  \
+	(((p)->slice_info & SLICE_AVG_MASK) >> SLICE_AVG_SHIFT)
+#define set_slice_avg_raw(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_AVG_MASK) | (((n) << SLICE_AVG_SHIFT) & SLICE_AVG_MASK)))
+
+/*
+ * cpu usage macros.
+ */
+#define cpu_avg(p) \
+	(100 - slice_avg_raw(p))
+
+#define cpu_max(p) \
+	(100 - ((p)->sleep_avg / NS_SLEEP_AVG_PCNT))
+
+#define time_this_slice(p) \
+	(jiffies - (p)->last_slice)
+
+#define cpu_this_slice(p) \
+	(100 * last_slice(p) / max((unsigned) time_this_slice(p), \
+	(unsigned) last_slice(p)))
+
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
@@ -851,13 +975,20 @@
 
 	if (likely(sleep_time > 0)) {
 		/*
+		 * Update throttle position.
+		 */
+		p->throttle += NS64_TO_JIFFIES(__sleep_time);
+		if (time_before(jiffies, p->throttle))
+			p->throttle = jiffies;
+
+		/*
 		 * Tasks that sleep a long time are categorised as idle.
 		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
-		if (task_interactive_idle(p, sleep_time)) {
+		if (C2 && task_interactive_idle(p, sleep_time)) {
 			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
 
 			/*
@@ -912,6 +1043,7 @@
 		runqueue_t *this_rq = this_rq();
 		comp = (now - this_rq->timestamp_last_tick)
 			+ rq->timestamp_last_tick;
+
 	}
 #endif
 
@@ -1532,16 +1664,28 @@
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
-	p->slice_time_ns = current->slice_time_ns >> 1;
-	if (unlikely(p->slice_time_ns < NS_TICK))
-		p->slice_time_ns = NS_TICK;
+	p->slice_time_ns = (current->slice_time_ns + NS_TICK) >> 1;
 	p->time_slice = NS_TO_JIFFIES(p->slice_time_ns);
+	if (unlikely(p->slice_time_ns < NS_TICK)) {
+		p->slice_time_ns = NS_TICK;
+		p->time_slice = 1;
+	}
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
-	p->first_time_slice = 1;
+	set_first_time_slice(p);
 	p->timestamp = sched_clock();
+
+	/*
+	 * Set up slice_info for the child.
+	 */
+	set_slice_avg(p, p->sleep_avg);
+	set_last_slice(p, p->time_slice);
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+	p->throttle = jiffies - C2 + C1;
+
 	current->slice_time_ns >>= 1;
 	if (unlikely(current->slice_time_ns < NS_TICK)) {
 		/*
@@ -1655,7 +1799,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if (first_time_slice(p) && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->slice_time_ns += p->slice_time_ns;
 		if (unlikely(p->parent->slice_time_ns > task_timeslice_ns(p)))
 			p->parent->slice_time_ns = task_timeslice_ns(p);
@@ -2771,6 +2915,89 @@
 }
 
 /*
+ * Refresh timeslice and associated slice information.
+ * @p: the process to refresh.
+ */
+static void refresh_timeslice(task_t *p)
+{
+	unsigned long slice_time = jiffies - p->last_slice;
+	unsigned int slice = last_slice(p);
+	unsigned int slice_avg, cpu, idle;
+	long run_time = -1 * p->slice_time_ns;
+	int w = MAX_BONUS, delta, bonus;
+
+	/*
+	 * Update time_slice.
+	 */
+	p->slice_time_ns = task_timeslice_ns(p);
+	p->time_slice = task_timeslice(p);
+	set_last_slice(p, p->time_slice);
+
+	/*
+	 * Update sleep_avg.
+	 *
+	 * Tasks charged proportionately less run_time at high
+	 * sleep_avg to delay them losing their interactive status
+	 */
+	run_time += JIFFIES_TO_NS(slice);
+	if (C2)
+		run_time /= SLEEP_AVG_DIVISOR(p);
+	if (p->sleep_avg >= run_time)
+		p->sleep_avg -= run_time;
+	else p->sleep_avg = 0;
+
+	/*
+	 * Update slice_avg.
+	 */
+	slice_avg = slice_avg_raw(p);
+	cpu = cpu_this_slice(p);
+	idle = 100 - cpu;
+
+	delta = max(slice_avg, idle) - min(slice_avg, idle);
+	w = 1 + (delta / w);
+	slice_avg = (w * slice_avg + idle) / (w + 1);
+	set_slice_avg_raw(p, slice_avg);
+
+	/*
+	 * If we've hit the timeout, we aren't draining enough sleep_avg
+	 * to catch up with the task's cpu usage.  Up the ante to bring
+	 * the task back toward balance.  This is important, because it
+	 * allows interactive tasks to push their throttle back enough
+	 * that they can both sustain, and rapidly recover from throttling
+	 * instead of descending into C3.
+	 */
+	if (credit_exhausted(p, C2) && p->sleep_avg > slice_avg(p)) {
+		unsigned long run_time = p->sleep_avg - slice_avg(p);
+		run_time /= w;
+		if (p->sleep_avg >= run_time)
+			p->sleep_avg -= run_time;
+	}
+
+	/*
+	 * Update throttle position.
+	 */
+	if (cpu < cpu_max(p) + PCNT_PER_DYNPRIO || !credit_exhausted(p, C1)) {
+		bonus = idle * PCNT_PER_DYNPRIO / 100;
+		p->throttle += (slice_time - slice) * bonus;
+	} else if (cpu >= cpu_max(p) + PCNT_PER_DYNPRIO) {
+		bonus = (cpu - cpu_max(p)) / PCNT_PER_DYNPRIO;
+		p->throttle -= slice_time * bonus;
+	}
+
+	if (time_before(jiffies, p->throttle))
+		p->throttle = jiffies;
+	else if (credit_exhausted(p, C3))
+		p->throttle = jiffies - C3;
+
+	/*
+	 * And finally, stamp and flag the new slice.
+	 */
+	clr_first_time_slice(p);
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -2821,9 +3048,7 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy == SCHED_RR) && !p->time_slice) {
-			p->slice_time_ns = task_timeslice_ns(p);
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
+			refresh_timeslice(p);
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -2832,22 +3057,10 @@
 		goto out_unlock;
 	}
 	if (!p->time_slice) {
-		long slice_time_ns = task_timeslice_ns(p);
-		long run_time = (-1 * p->slice_time_ns) + slice_time_ns;
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->slice_time_ns = slice_time_ns;
-		p->time_slice = task_timeslice(p);
-		/*
-		 * Tasks are charged proportionately less run_time at high
-		 * sleep_avg to delay them losing their interactive status
-		 */
-		run_time /= SLEEP_AVG_DIVISOR(p);
-		if (p->sleep_avg >= run_time)
-			p->sleep_avg -= run_time;
-		else p->sleep_avg = 0;
+		refresh_timeslice(p);
 		p->prio = effective_prio(p);
-		p->first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -3238,6 +3451,14 @@
 
 	prev->timestamp = prev->last_ran = now;
 
+	/*
+	 * Tag start of execution of a new timeslice.
+	 */
+	if (unlikely(slice_is_new(next))) {
+		next->last_slice = jiffies;
+		clr_slice_is_new(next);
+	}
+
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
 		next->timestamp = now;


