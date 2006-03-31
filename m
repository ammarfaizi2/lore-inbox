Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWCaNIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCaNIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWCaNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:08:10 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:39586 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932104AbWCaNIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:08:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Thorsten Will <thor_w@arcor.de>, ck list <ck@vds.kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Staircase test patch
Date: Fri, 31 Mar 2006 23:07:58 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1906
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_umSLE//qbR2d90c"
Message-Id: <200603312307.58507.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_umSLE//qbR2d90c
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thorsten et al

Well I finally found the _cause_ of the slow I/O problem. I rewrote the 
deadline component for staircase 3 times and then I even wrote a completely 
new scheduler for my own experimentation! Then I threw all those away.

Anyway this patch (only applies to 2.6.16-ck2) does a number of cleanups for 
staircase. Specifically there are two major improvements. The first is that 
the sleep type in disk reads was not being accounted for at all meaning disk 
reads would have unfairly low cpu usage under load. The problem with fixing 
this previously was that it would then allow other sneaky tasks to use kernel 
activity on their behalf to get unfair cpu usage. The second major change is 
accounting properly for kernel activity on behalf of a task. This fixes a 
number of "exploit" cases that have been suggested for some time, and 
improves the fairness of tests like the starve.c that Mike Galbraith 
published. I have to thank Mike for bringing these to my attention that I've 
tried hard to ignore for some time.

Thorsten could you please test to see if this fixes the problem for you? I 
_know_ Mike isn't going to test it for me (sorry again...)

These changes should all end up in staircase v15 all going well.

Cheers,
Con

As an attachment since most of my mailing list users prefer that.

--Boundary-00=_umSLE//qbR2d90c
Content-Type: text/x-diff;
  charset="utf-8";
  name="sched-staircase14.2_test3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sched-staircase14.2_test3.patch"

---
 include/linux/sched.h |    2 
 kernel/sched.c        |  129 +++++++++++++++++++++++++-------------------------
 2 files changed, 67 insertions(+), 64 deletions(-)

Index: linux-2.6.16-ck2/kernel/sched.c
===================================================================
--- linux-2.6.16-ck2.orig/kernel/sched.c	2006-03-30 20:39:34.000000000 +1000
+++ linux-2.6.16-ck2/kernel/sched.c	2006-03-31 22:50:07.000000000 +1000
@@ -16,9 +16,9 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
- *  2006-03-16	New staircase scheduling policy by Con Kolivas with help
+ *  2006-03-31	New staircase scheduling policy by Con Kolivas with help
  *		from William Lee Irwin III, Zwane Mwaikambo & Peter Williams.
- *		Staircase v14.2
+ *		Staircase v14.2_test3
  */
 
 #include <linux/mm.h>
@@ -64,7 +64,7 @@
 #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
 #define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
-
+#define MIN_USER_PRIO		(MAX_PRIO - 2)
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
@@ -77,9 +77,9 @@
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
-#define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 #define NSJIFFY			(1000000000 / HZ)	/* One jiffy in ns */
+#define NS_TO_JIFFIES(TIME)	((TIME) / NSJIFFY)
+#define JIFFIES_TO_NS(TIME)	((TIME) * NSJIFFY)
 #define TASK_PREEMPTS_CURR(p, rq)	((p)->prio < (rq)->curr->prio)
 
 int sched_compute __read_mostly = 0;
@@ -508,7 +508,7 @@ static unsigned long ns_diff(const unsig
 	const unsigned long long v2)
 {
 	unsigned long long vdiff;
-	if (likely(v1 > v2)) {
+	if (likely(v1 >= v2)) {
 		vdiff = v1 - v2;
 #if BITS_PER_LONG < 64
 		if (vdiff > (1 << 31))
@@ -550,9 +550,16 @@ static void fastcall enqueue_task(task_t
  * Put task to the end of the run list without the overhead of dequeue
  * followed by enqueue.
  */
-static inline void requeue_task(task_t *p, runqueue_t *rq)
+static void requeue_task(task_t *p, runqueue_t *rq, const int prio)
 {
-	list_move_tail(&p->run_list, rq->queue + p->prio);
+	list_move_tail(&p->run_list, rq->queue + prio);
+	if (p->prio != prio) {
+		if (list_empty(rq->queue + p->prio))
+			__clear_bit(p->prio, rq->bitmap);
+		p->prio = prio;
+		__set_bit(prio, rq->bitmap);
+	}
+	p->ns_debit = 0;
 }
 
 static inline void enqueue_task_head(task_t *p, runqueue_t *rq)
@@ -681,20 +688,18 @@ static unsigned int fastcall slice(const
 static void fastcall inc_bonus(task_t *p, const unsigned long totalrun,
 	const unsigned long sleep)
 {
-	unsigned int best_bonus;
+	unsigned int best_bonus = sleep / (totalrun + 1);
 
-	best_bonus = sleep / (totalrun + 1);
 	if (p->bonus >= best_bonus)
 		return;
-
-	p->bonus++;
 	best_bonus = bonus(p);
-	if (p->bonus > best_bonus)
-		p->bonus = best_bonus;
+	if (p->bonus < best_bonus)
+		p->bonus++;
 }
 
 static void dec_bonus(task_t *p)
 {
+	p->totalrun = 0;
 	if (p->bonus)
 		p->bonus--;
 }
@@ -740,7 +745,7 @@ static int effective_prio(task_t *p)
 			 */
 			p->time_slice = p->slice % RR_INTERVAL() ? :
 				RR_INTERVAL();
-			return MAX_PRIO - 2;
+			return MIN_USER_PRIO;
 		}
 		return MAX_PRIO - 1;
 	}
@@ -756,8 +761,8 @@ static int effective_prio(task_t *p)
 
 	rr = rr_interval(p);
 	prio += used_slice / rr;
-	if (prio > MAX_PRIO - 2)
-		prio = MAX_PRIO - 2;
+	if (prio > MIN_USER_PRIO)
+		prio = MIN_USER_PRIO;
 	return prio;
 }
 
@@ -765,13 +770,14 @@ static inline void continue_slice(task_t
 {
 	unsigned long total_run = NS_TO_JIFFIES(p->totalrun);
 
-	if (total_run >= p->slice) {
-		p->totalrun -= JIFFIES_TO_NS(p->slice);
+	if (total_run >= p->slice || p->prio == MIN_USER_PRIO)
 		dec_bonus(p);
-	} else {
-		unsigned int remainder;
+	else {
+		unsigned long remainder;
 
 		p->slice -= total_run;
+		if (p->slice <= p->time_slice)
+			dec_bonus(p);
 		remainder = p->slice % rr_interval(p);
 		if (remainder)
 			p->time_slice = remainder;
@@ -785,34 +791,35 @@ static inline void continue_slice(task_t
  */
 static inline void recalc_task_prio(task_t *p, const unsigned long long now)
 {
+	/* Double the systime to account for missed sub-jiffy time */
+	unsigned long ns_systime = JIFFIES_TO_NS(p->systime) * 2;
 	unsigned long sleep_time = ns_diff(now, p->timestamp);
 
 	/*
-	 * Add the total for this last scheduled run (p->runtime) to the
-	 * running total so far used (p->totalrun).
-	 */
-	p->totalrun += p->runtime;
+	 * Add the total for this last scheduled run (p->runtime) and system
+	 * time (p->systime) done on behalf of p to the running total so far
+	 * used (p->totalrun).
+	 */
+	p->totalrun += p->runtime + ns_systime;
+
+	/* systime is unintentionally seen as sleep, subtract it */
+	if (likely(ns_systime < sleep_time))
+		sleep_time -= ns_systime;
+	else
+		sleep_time = 0;
 
 	/*
 	 * If we sleep longer than our running total and have not set the
 	 * PF_NONSLEEP flag we gain a bonus.
 	 */
-	if (sleep_time >= p->totalrun && !(p->flags & PF_NONSLEEP) &&
-		!sched_compute) {
-			inc_bonus(p, p->totalrun, sleep_time);
-			p->totalrun = 0;
-			return;
+	if (sleep_time >= p->totalrun && !(p->flags & PF_NONSLEEP)) {
+		inc_bonus(p, p->totalrun, sleep_time);
+		p->totalrun = 0;
+		return;
 	}
 
-	/*
-	 * If we have not set the PF_NONSLEEP flag we elevate priority by the
-	 * amount of time we slept.
-	 */
-	if (p->flags & PF_NONSLEEP)
-		p->flags &= ~PF_NONSLEEP;
-	else
-		p->totalrun -= sleep_time;
-
+	/* We elevate priority by the amount of time we slept. */
+	p->totalrun -= sleep_time;
 	continue_slice(p);
 }
 
@@ -840,6 +847,7 @@ static void activate_task(task_t *p, run
 	if (!rt_task(p)) {
 		recalc_task_prio(p, now);
 		p->flags &= ~PF_NONSLEEP;
+		p->systime = 0;
 		p->prio = effective_prio(p);
 	}
 	p->timestamp = now;
@@ -1221,11 +1229,15 @@ static inline int wake_idle(const int cp
  */
 static void fastcall preempt(const task_t *p, runqueue_t *rq)
 {
-	if (p->prio >= rq->curr->prio)
+	task_t *curr = rq->curr;
+
+	if (p->prio >= curr->prio)
 		return;
-	if (!sched_compute || rq->cache_ticks >= CACHE_DELAY ||
-		!p->mm || rt_task(p))
-			resched_task(rq->curr);
+	if (!sched_compute || rq->cache_ticks >= CACHE_DELAY || !p->mm ||
+	    rt_task(p) || curr == rq->idle) {
+		resched_task(curr);
+		return;
+	}
 	rq->preempted = 1;
 }
 
@@ -1449,21 +1461,20 @@ void fastcall wake_up_new_task(task_t *p
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
 
-	/*
-	 * Forked process gets no bonus to prevent fork bombs.
-	 */
+	/* Forked process gets no bonus to prevent fork bombs. */
 	p->bonus = 0;
+	current->flags |= PF_NONSLEEP;
 
 	if (likely(cpu == this_cpu)) {
-		current->flags |= PF_NONSLEEP;
 		activate_task(p, rq, 1);
-		if (!(clone_flags & CLONE_VM))
+		if (!(clone_flags & CLONE_VM)) {
 			/*
 			 * The VM isn't cloned, so we're in a good position to
 			 * do child-runs-first in anticipation of an exec. This
 			 * usually avoids a lot of COW overhead.
 			 */
 			set_need_resched();
+		}
 		/*
 		 * We skip the following code due to cpu == this_cpu
 	 	 *
@@ -1489,7 +1500,6 @@ void fastcall wake_up_new_task(task_t *p
 		 */
 		task_rq_unlock(rq, &flags);
 		this_rq = task_rq_lock(current, &flags);
-		current->flags |= PF_NONSLEEP;
 	}
 	task_rq_unlock(this_rq, &flags);
 }
@@ -2522,6 +2532,7 @@ void account_system_time(struct task_str
 	else
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
 
+	p->systime++;
 	/* Account for system time used */
 	acct_update_integrals(p);
 }
@@ -2550,10 +2561,8 @@ void account_steal_time(struct task_stru
 static void time_slice_expired(task_t *p, runqueue_t *rq)
 {
 	set_tsk_need_resched(p);
-	dequeue_task(p, rq);
-	p->prio = effective_prio(p);
 	p->time_slice = rr_interval(p);
-	enqueue_task(p, rq);
+	requeue_task(p, rq, effective_prio(p));
 }
 
 /*
@@ -2639,7 +2648,6 @@ void scheduler_tick(void)
 		dec_bonus(p);
 		p->slice = slice(p);
 		time_slice_expired(p, rq);
-		p->totalrun = 0;
 		goto out_unlock;
 	}
 	/*
@@ -2758,7 +2766,7 @@ static int dependent_sleeper(const int t
 		goto out_unlock;
 
 	p = list_entry(this_rq->queue[sched_find_first_bit(this_rq->bitmap)].next,
-		task_t, run_list);
+		       task_t, run_list);
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -3471,8 +3479,8 @@ void set_user_nice(task_t *p, const long
 		 * lowered its priority, then reschedule its CPU:
 		 */
 		if (delta < 0 || ((delta > 0 || idleprio_task(p)) &&
-			task_running(rq, p)))
-				resched_task(rq->curr);
+		    task_running(rq, p)))
+			resched_task(rq->curr);
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -3973,14 +3981,9 @@ asmlinkage long sys_sched_yield(void)
 	current->slice = slice(current);
 	current->time_slice = rr_interval(current);
 	if (likely(!rt_task(current) && !idleprio_task(current)))
-		newprio = MAX_PRIO - 2;
+		newprio = MIN_USER_PRIO;
 
-	if (newprio != current->prio) {
-		dequeue_task(current, rq);
-		current->prio = newprio;
-		enqueue_task(current, rq);
-	} else
-		requeue_task(current, rq);
+	requeue_task(current, rq, newprio);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
Index: linux-2.6.16-ck2/include/linux/sched.h
===================================================================
--- linux-2.6.16-ck2.orig/include/linux/sched.h	2006-03-31 22:49:35.000000000 +1000
+++ linux-2.6.16-ck2/include/linux/sched.h	2006-03-31 22:49:52.000000000 +1000
@@ -739,7 +739,7 @@ struct task_struct {
 	unsigned short ioprio;
 
 	unsigned long long timestamp;
-	unsigned long runtime, totalrun, ns_debit;
+	unsigned long runtime, totalrun, ns_debit, systime;
 	unsigned int bonus;
 	unsigned int slice, time_slice;
 	unsigned long long sched_time; /* sched_clock time spent running */

--Boundary-00=_umSLE//qbR2d90c--
