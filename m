Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWCXLPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWCXLPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCXLPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:15:22 -0500
Received: from mail.gmx.de ([213.165.64.20]:13701 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751644AbWCXLPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:15:21 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143198459.7741.14.camel@homer>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:16:03 +0100
Message-Id: <1143198964.7741.23.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 3/6

This patch does various interactivity cleanups.

1.  Removes the barrier between kernel threads and user tasks wrt
dynamic priority handling.

2.  Removes the priority barrier for IO.

3.  Treats TASK_INTERACTIVE as a transition point that all tasks must
stop at prior to being promoted further.

4.  Moves division out of the fast path and into scheduler_tick().
While doing so, tightens timeslice accounting, since it's free, and is
the flip-side of the reason for having nanosecond sched_clock().

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm1/include/linux/sched.h.org	2006-03-19 05:42:00.000000000 +0100
+++ linux-2.6.16-mm1/include/linux/sched.h	2006-03-19 08:40:34.000000000 +0100
@@ -741,6 +741,7 @@
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	long slice_time_ns;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-mm1/kernel/sched.c-2.uninterruptible	2006-03-23 15:07:26.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 15:17:26.000000000 +0100
@@ -99,6 +99,10 @@
 #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
+#define NS_MAX_SLEEP_AVG_PCNT	(NS_MAX_SLEEP_AVG / 100)
+#define PCNT_PER_DYNPRIO	(100 / MAX_BONUS)
+#define NS_PER_DYNPRIO		(PCNT_PER_DYNPRIO * NS_MAX_SLEEP_AVG_PCNT)
+#define NS_TICK			(1000000000 / HZ)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -153,9 +157,25 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+#define SLEEP_AVG_DIVISOR(p) (1 + CURRENT_BONUS(p))
+
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
+	MAX_BONUS), NS_MAX_SLEEP_AVG))
+
+/*
+ * Returns whether a task has been asleep long enough to be considered idle.
+ * The metric is whether this quantity of sleep would promote the task more
+ * than one priority beyond marginally interactive.
+ */
+static int task_interactive_idle(task_t *p, unsigned long sleep_time)
+{
+	unsigned long ceiling = (CURRENT_BONUS(p) + 2) * NS_PER_DYNPRIO;
+
+	if (p->sleep_avg + sleep_time < ceiling)
+		return 0;
+	return p->sleep_avg + sleep_time >= INTERACTIVE_SLEEP_AVG(p);
+}
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -185,6 +205,11 @@
 	return static_prio_timeslice(p->static_prio);
 }
 
+static inline unsigned int task_timeslice_ns(task_t *p)
+{
+	return static_prio_timeslice(p->static_prio) * NS_TICK;
+}
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -826,35 +851,32 @@
 
 	if (likely(sleep_time > 0)) {
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
+		 * Tasks that sleep a long time are categorised as idle.
+		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
+		if (task_interactive_idle(p, sleep_time)) {
+			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
-		} else {
 			/*
-			 * Tasks waking from uninterruptible sleep are
-			 * limited in their sleep_avg rise as they
-			 * are likely to be waiting on I/O
+			 * Promote previously interactive task.
 			 */
-			if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
-				}
+			if (p->sleep_avg > ceiling) {
+				ceiling = p->sleep_avg / NS_PER_DYNPRIO;
+				if (ceiling < MAX_BONUS)
+					ceiling++;
+				ceiling *= NS_PER_DYNPRIO;
+			} else {
+				ceiling += p->slice_time_ns >> 2;
+				if (ceiling > NS_MAX_SLEEP_AVG)
+					ceiling = NS_MAX_SLEEP_AVG;
 			}
 
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
+		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.
 			 *
@@ -1510,21 +1532,23 @@
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
-	p->time_slice = (current->time_slice + 1) >> 1;
+	p->slice_time_ns = current->slice_time_ns >> 1;
+	if (unlikely(p->slice_time_ns < NS_TICK))
+		p->slice_time_ns = NS_TICK;
+	p->time_slice = NS_TO_JIFFIES(p->slice_time_ns);
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
 	p->first_time_slice = 1;
-	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
-	if (unlikely(!current->time_slice)) {
+	current->slice_time_ns >>= 1;
+	if (unlikely(current->slice_time_ns < NS_TICK)) {
 		/*
 		 * This case is rare, it happens when the parent has only
 		 * a single jiffy left from its timeslice. Taking the
 		 * runqueue lock is not a problem.
 		 */
-		current->time_slice = 1;
 		scheduler_tick();
 	}
 	local_irq_enable();
@@ -1632,9 +1656,9 @@
 	 */
 	rq = task_rq_lock(p->parent, &flags);
 	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > task_timeslice(p)))
-			p->parent->time_slice = task_timeslice(p);
+		p->parent->slice_time_ns += p->slice_time_ns;
+		if (unlikely(p->parent->slice_time_ns > task_timeslice_ns(p)))
+			p->parent->slice_time_ns = task_timeslice_ns(p);
 	}
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = p->parent->sleep_avg /
@@ -2653,7 +2677,9 @@
 				    unsigned long long now)
 {
 	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
-	p->sched_time += now - last;
+	long run_time = now - last;
+	p->sched_time += run_time;
+	p->slice_time_ns -= run_time;
 }
 
 /*
@@ -2781,13 +2807,21 @@
 	 * priority until it either goes to sleep or uses up its
 	 * timeslice. This makes it possible for interactive tasks
 	 * to use up their timeslices at their highest priority levels.
-	 */
+	 *
+	 * We don't want to update every task at each tick, so we
+	 * update a task's time_slice according to how much cpu
+	 * time it has received since it was last ticked.
+	 */
+	if (p->slice_time_ns < NS_TICK)
+		p->time_slice = 0;
+	else p->time_slice = NS_TO_JIFFIES(p->slice_time_ns);
 	if (rt_task(p)) {
 		/*
 		 * RR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
 		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
+		if ((p->policy == SCHED_RR) && !p->time_slice) {
+			p->slice_time_ns = task_timeslice_ns(p);
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
@@ -2797,11 +2831,22 @@
 		}
 		goto out_unlock;
 	}
-	if (!--p->time_slice) {
+	if (!p->time_slice) {
+		long slice_time_ns = task_timeslice_ns(p);
+		long run_time = (-1 * p->slice_time_ns) + slice_time_ns;
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
+		p->slice_time_ns = slice_time_ns;
 		p->time_slice = task_timeslice(p);
+		/*
+		 * Tasks are charged proportionately less run_time at high
+		 * sleep_avg to delay them losing their interactive status
+		 */
+		run_time /= SLEEP_AVG_DIVISOR(p);
+		if (p->sleep_avg >= run_time)
+			p->sleep_avg -= run_time;
+		else p->sleep_avg = 0;
+		p->prio = effective_prio(p);
 		p->first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
@@ -3066,7 +3111,6 @@
 	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
 	int cpu, idx, new_prio;
 
 	/*
@@ -3100,19 +3144,6 @@
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
-		run_time = now - prev->timestamp;
-		if (unlikely((long long)(now - prev->timestamp) < 0))
-			run_time = 0;
-	} else
-		run_time = NS_MAX_SLEEP_AVG;
-
-	/*
-	 * Tasks charged proportionately less run_time at high sleep_avg to
-	 * delay them losing their interactive status
-	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
-
 	spin_lock_irq(&rq->lock);
 
 	if (unlikely(prev->flags & PF_DEAD))
@@ -3186,7 +3217,6 @@
 		if (next->sleep_type == SLEEP_INTERACTIVE)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
-		array = next->array;
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 
 		if (unlikely(next->prio != new_prio)) {
@@ -3206,9 +3236,6 @@
 
 	update_cpu_clock(prev, rq, now);
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0)
-		prev->sleep_avg = 0;
 	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);


