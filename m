Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDAJLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDAJLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDAJLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:11:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:61672 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750760AbWDAJLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:11:38 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 6/9] sched throttle tree extract - move
	division to slow path
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143881983.7617.41.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>  <1143881983.7617.41.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 11:12:11 +0200
Message-Id: <1143882731.7617.55.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves division of runtime from the fast path into the slow
path.  In doing so, it converts the task's time slice into nanoseconds,
which also disallows high frequency scheduling tasks from stealing time
from their neighbors by ducking the timer interrupt. (two birds, one
stone)

slice_time_ns is identical in function to time_slice, but conversion of
everything that referred to time_slice to nanoseconds just made a mess.
Ergo, I close the lesser of two evils, and duplicated what was necessary
to allow use of nanoseconds only where needed.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/include/linux/sched.h.org	2006-03-31 11:25:02.000000000 +0200
+++ linux-2.6.16-mm2/include/linux/sched.h	2006-03-31 11:27:32.000000000 +0200
@@ -744,6 +744,7 @@ struct task_struct {
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	long slice_time_ns;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-mm2/kernel/sched.c-5.interactive_idle	2006-04-01 09:12:51.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-31 13:34:12.000000000 +0200
@@ -102,6 +102,7 @@
 #define NS_MAX_SLEEP_AVG_PCNT	(NS_MAX_SLEEP_AVG / 100)
 #define PCNT_PER_DYNPRIO	(100 / MAX_BONUS)
 #define NS_PER_DYNPRIO		(PCNT_PER_DYNPRIO * NS_MAX_SLEEP_AVG_PCNT)
+#define NS_TICK			(1000000000 / HZ)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -156,6 +157,8 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define SLEEP_AVG_DIVISOR(p) (1 + CURRENT_BONUS(p))
+
 #define INTERACTIVE_SLEEP_AVG(p) \
 	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
 	MAX_BONUS), NS_MAX_SLEEP_AVG))
@@ -202,6 +205,11 @@ static inline unsigned int task_timeslic
 	return static_prio_timeslice(p->static_prio);
 }
 
+static inline unsigned int task_timeslice_ns(task_t *p)
+{
+	return static_prio_timeslice(p->static_prio) * NS_TICK;
+}
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -1563,21 +1571,23 @@ void fastcall sched_fork(task_t *p, int 
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
@@ -1686,9 +1696,9 @@ void fastcall sched_exit(task_t *p)
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
@@ -2709,7 +2719,9 @@ static inline void update_cpu_clock(task
 				    unsigned long long now)
 {
 	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
-	p->sched_time += now - last;
+	long run_time = now - last;
+	p->sched_time += run_time;
+	p->slice_time_ns -= run_time;
 }
 
 /*
@@ -2837,13 +2849,21 @@ void scheduler_tick(void)
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
@@ -2853,11 +2873,22 @@ void scheduler_tick(void)
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
@@ -3122,7 +3153,6 @@ asmlinkage void __sched schedule(void)
 	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
 	int cpu, idx, new_prio;
 
 	/*
@@ -3156,19 +3186,6 @@ need_resched_nonpreemptible:
 
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
@@ -3242,7 +3259,6 @@ go_idle:
 		if (next->sleep_type == SLEEP_INTERACTIVE)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
-		array = next->array;
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 
 		if (unlikely(next->prio != new_prio)) {
@@ -3262,9 +3278,6 @@ switch_tasks:
 
 	update_cpu_clock(prev, rq, now);
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0)
-		prev->sleep_avg = 0;
 	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);


