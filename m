Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWDBGCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWDBGCz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 01:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWDBGCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 01:02:54 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:11188 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751091AbWDBGCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 01:02:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Sun, 2 Apr 2006 16:02:14 +1000
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
References: <4404CF98.7020804@bigpond.net.au> <440508C9.6030701@bigpond.net.au> <442F3116.6070202@bigpond.net.au>
In-Reply-To: <442F3116.6070202@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mj2LEttjFfeo771"
Message-Id: <200604021602.14901.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_mj2LEttjFfeo771
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 02 April 2006 12:04, Peter Williams wrote:
> Con and Nick,
> 	I've taken the liberty of modifying staircase and nicksched (in the
> 2.6.16-mm2 version) to support priority inheritance.  I'd appreciate it
> if you could review the code?

Looks fine to me.

Here are two patches (I know it's bad form to send two patches as attachments 
under normal circumstances but I'm sure you won't mind). The first brings us 
up to staircase v15. The second adds the sched_system_tick function from 
account_system_time that staircase 15 needs to work properly. Unfortunately I 
can only build test these patches at this time (since the family needs my 
only pc and they build fine) but the changes are mostly straightforward so 
they should be ok.

Cheers,
Con

--Boundary-00=_mj2LEttjFfeo771
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="plugsched-6.3.1-staircase14.1_15.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="plugsched-6.3.1-staircase14.1_15.patch"

---
 include/linux/sched_runq.h |    3 
 include/linux/sched_task.h |    2 
 kernel/staircase.c         |  228 ++++++++++++++++++++++++---------------------
 3 files changed, 127 insertions(+), 106 deletions(-)

Index: linux-2.6.16-mm2/include/linux/sched_runq.h
===================================================================
--- linux-2.6.16-mm2.orig/include/linux/sched_runq.h	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/include/linux/sched_runq.h	2006-04-02 14:29:55.000000000 +1000
@@ -39,8 +39,7 @@ struct ingo_runqueue_queue {
 struct staircase_runqueue_queue {
 	DECLARE_BITMAP(bitmap, STAIRCASE_NUM_PRIO_SLOTS);
 	struct list_head queue[STAIRCASE_NUM_PRIO_SLOTS - 1];
-	unsigned int cache_ticks;
-	unsigned int preempted;
+	unsigned short cache_ticks, preempted;
 };
 #endif
 
Index: linux-2.6.16-mm2/include/linux/sched_task.h
===================================================================
--- linux-2.6.16-mm2.orig/include/linux/sched_task.h	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/include/linux/sched_task.h	2006-04-02 14:31:39.000000000 +1000
@@ -48,7 +48,7 @@ struct ingo_ll_sched_drv_task {
 #ifdef CONFIG_CPUSCHED_STAIRCASE
 struct staircase_sched_drv_task {
 	unsigned long sflags;
-	unsigned long runtime, totalrun, ns_debit;
+	unsigned long runtime, totalrun, ns_debit, systime;
 	unsigned int bonus;
 	unsigned int slice, time_slice;
 };
Index: linux-2.6.16-mm2/kernel/staircase.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/staircase.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/staircase.c	2006-04-02 15:11:10.000000000 +1000
@@ -2,8 +2,8 @@
  *  kernel/staircase.c
  *  Copyright (C) 2002-2006 Con Kolivas
  *
- * 2006-02-22 Staircase scheduler by Con Kolivas <kernel@kolivas.org>
- *            Staircase v14.1
+ * 2006-04-02 Staircase scheduler by Con Kolivas <kernel@kolivas.org>
+ *            Staircase v15
  */
 #include <linux/sched.h>
 #include <linux/init.h>
@@ -23,8 +23,7 @@ static void staircase_init_runqueue_queu
 {
 	int k;
 
-	qup->staircase.cache_ticks = 0;
-	qup->staircase.preempted = 0;
+	qup->staircase.cache_ticks = qup->staircase.preempted = 0;
 
 	for (k = 0; k < STAIRCASE_MAX_PRIO; k++) {
 		INIT_LIST_HEAD(qup->staircase.queue + k);
@@ -42,7 +41,9 @@ static int staircase_idle_prio(void)
 static void staircase_set_oom_time_slice(struct task_struct *p,
 	unsigned long t)
 {
-	p->sdu.staircase.slice = p->sdu.staircase.time_slice = t;
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+
+	sp->slice = sp->time_slice = t;
 }
 
 /*
@@ -53,13 +54,14 @@ static void staircase_set_oom_time_slice
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(STAIRCASE_MAX_PRIO))
+#define MIN_USER_PRIO		(STAIRCASE_MAX_PRIO - 1)
 
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
-#define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 #define NSJIFFY			(1000000000 / HZ)	/* One jiffy in ns */
+#define NS_TO_JIFFIES(TIME)	((TIME) / NSJIFFY)
+#define JIFFIES_TO_NS(TIME)	((TIME) * NSJIFFY)
 
 int sched_compute __read_mostly = 0;
 /*
@@ -68,7 +70,7 @@ int sched_compute __read_mostly = 0;
  *and has twenty times larger intervals. Set to a minimum of 6ms.
  */
 #define _RR_INTERVAL		((6 * HZ / 1001) + 1)
-#define RR_INTERVAL()		(_RR_INTERVAL * (1 + 16 * sched_compute))
+#define RR_INTERVAL()		(_RR_INTERVAL * (1 + 9 * sched_compute))
 #define DEF_TIMESLICE		(RR_INTERVAL() * 19)
 
 #define TASK_PREEMPTS_CURR(p, rq) \
@@ -81,7 +83,7 @@ static unsigned long ns_diff(const unsig
 	const unsigned long long v2)
 {
 	unsigned long long vdiff;
-	if (likely(v1 > v2)) {
+	if (likely(v1 >= v2)) {
 		vdiff = v1 - v2;
 #if BITS_PER_LONG < 64
 		if (vdiff > (1 << 31))
@@ -103,10 +105,12 @@ static unsigned long ns_diff(const unsig
 static inline void dequeue_task(struct task_struct *p,
 	struct staircase_runqueue_queue *rqq)
 {
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+
 	list_del_init(&p->run_list);
 	if (list_empty(rqq->queue + p->prio))
 		__clear_bit(p->prio, rqq->bitmap);
-	p->sdu.staircase.ns_debit = 0;
+	sp->ns_debit = 0;
 }
 
 static void enqueue_task(struct task_struct *p,
@@ -117,10 +121,19 @@ static void enqueue_task(struct task_str
 	__set_bit(p->prio, rqq->bitmap);
 }
 
-static inline void requeue_task(struct task_struct *p,
-	struct staircase_runqueue_queue *rq)
+static void fastcall requeue_task(struct task_struct *p,
+	struct staircase_runqueue_queue *rqq, const int prio)
 {
-	list_move_tail(&p->run_list, rq->queue + p->prio);
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+
+	list_move_tail(&p->run_list, rqq->queue + prio);
+	if (p->prio != prio) {
+		if (list_empty(rqq->queue + p->prio))
+			__clear_bit(p->prio, rqq->bitmap);
+		p->prio = prio;
+		__set_bit(prio, rqq->bitmap);
+	}
+	sp->ns_debit = 0;
 }
 
 /*
@@ -140,7 +153,9 @@ static inline void enqueue_task_head(str
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, &rq->qu.staircase);
+	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
+
+	enqueue_task(p, rqq);
 	inc_nr_running(p, rq);
 }
 
@@ -150,7 +165,9 @@ static inline void __activate_task(task_
  */
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task_head(p, &rq->qu.staircase);
+	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
+
+	enqueue_task_head(p, &rqq);
 	inc_nr_running(p, rq);
 }
 #endif
@@ -239,22 +256,24 @@ static inline void staircase_set_load_we
 static void inc_bonus(task_t *p, const unsigned long totalrun,
 	const unsigned long sleep)
 {
-	unsigned int best_bonus;
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+	unsigned int best_bonus = sleep / (totalrun + 1);
 
-	best_bonus = sleep / (totalrun + 1);
-	if (p->sdu.staircase.bonus >= best_bonus)
+	if (sp->bonus >= best_bonus)
 		return;
 
-	p->sdu.staircase.bonus++;
 	best_bonus = bonus(p);
-	if (p->sdu.staircase.bonus > best_bonus)
-		p->sdu.staircase.bonus = best_bonus;
+	if (sp->bonus < best_bonus)
+		sp->bonus++;
 }
 
-static void dec_bonus(task_t *p)
+static inline void dec_bonus(task_t *p)
 {
-	if (p->sdu.staircase.bonus)
-		p->sdu.staircase.bonus--;
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+
+	sp->totalrun = 0;
+	if (sp->bonus)
+		sp->bonus--;
 }
 
 /*
@@ -270,41 +289,43 @@ int sched_interactive __read_mostly = 1;
  */
 static int staircase_normal_prio(task_t *p)
 {
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
 	int prio;
 	unsigned int full_slice, used_slice = 0;
 	unsigned int best_bonus, rr;
 
 	full_slice = slice(p);
-	if (full_slice > p->sdu.staircase.slice)
-		used_slice = full_slice - p->sdu.staircase.slice;
+	if (full_slice > sp->slice)
+		used_slice = full_slice - sp->slice;
 
 	best_bonus = bonus(p);
 	prio = MAX_RT_PRIO + best_bonus;
 	if (sched_interactive && !sched_compute && p->policy != SCHED_BATCH)
-		prio -= p->sdu.staircase.bonus;
+		prio -= sp->bonus;
 
 	rr = rr_interval(p);
 	prio += used_slice / rr;
-	if (prio > STAIRCASE_MAX_PRIO - 1)
-		prio = STAIRCASE_MAX_PRIO - 1;
+	if (prio > MIN_USER_PRIO)
+		prio = MIN_USER_PRIO;
 	return prio;
 }
 
 static inline void continue_slice(task_t *p)
 {
-	unsigned long total_run = NS_TO_JIFFIES(p->sdu.staircase.totalrun);
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+	unsigned long total_run = NS_TO_JIFFIES(sp->totalrun);
 
-	if (total_run >= p->sdu.staircase.slice) {
- 		p->sdu.staircase.totalrun -=
- 			JIFFIES_TO_NS(p->sdu.staircase.slice);
+	if (total_run >= sp->slice || p->prio == MIN_USER_PRIO)
 		dec_bonus(p);
-	} else {
-		unsigned int remainder;
+	else {
+		unsigned long remainder;
 
-		p->sdu.staircase.slice -= total_run;
-		remainder = p->sdu.staircase.slice % rr_interval(p);
+		sp->slice -= total_run;
+		if (sp->slice <= sp->time_slice)
+			dec_bonus(p);
+		remainder = sp->slice % rr_interval(p);
 		if (remainder)
-			p->sdu.staircase.time_slice = remainder;
+			sp->time_slice = remainder;
  	}
 }
 
@@ -315,35 +336,36 @@ static inline void continue_slice(task_t
  */
 static inline void recalc_task_prio(task_t *p, const unsigned long long now)
 {
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+	/* Double the systime to account for missed sub-jiffy time */
+	unsigned long ns_systime = JIFFIES_TO_NS(sp->systime) * 2;
 	unsigned long sleep_time = ns_diff(now, p->timestamp);
 
 	/*
-	 * Add the total for this last scheduled run (p->runtime) to the
-	 * running total so far used (p->totalrun).
+	 * Add the total for this last scheduled run (sp->runtime) and system
+	 * time (sp->systime) done on behalf of p to the running total so far
+	 * used (sp->totalrun).
 	 */
-	p->sdu.staircase.totalrun += p->sdu.staircase.runtime;
+	sp->totalrun += sp->runtime + ns_systime;
+
+	/* systime is unintentionally seen as sleep, subtract it */
+	if (likely(ns_systime < sleep_time))
+		sleep_time -= ns_systime;
+	else
+		sleep_time = 0;
 
 	/*
 	 * If we sleep longer than our running total and have not set the
-	 * PF_NONSLEEP flag we gain a bonus.
+	 * SF_NONSLEEP flag we gain a bonus.
 	 */
-	if (sleep_time >= p->sdu.staircase.totalrun &&
-		!(p->sdu.staircase.sflags & SF_NONSLEEP) &&
-		!sched_compute) {
-			inc_bonus(p, p->sdu.staircase.totalrun, sleep_time);
-			p->sdu.staircase.totalrun = 0;
-			return;
+	if (sleep_time >= sp->totalrun && !(sp->sflags & SF_NONSLEEP)) {
+		inc_bonus(p, sp->totalrun, sleep_time);
+		sp->totalrun = 0;
+		return;
 	}
 
-	/*
-	 * If we have not set the PF_NONSLEEP flag we elevate priority by the
-	 * amount of time we slept.
-	 */
-	if (p->sdu.staircase.sflags & SF_NONSLEEP)
-		p->sdu.staircase.sflags &= ~SF_NONSLEEP;
-	else
-		p->sdu.staircase.totalrun -= sleep_time;
-
+	/* We elevate priority by the amount of time we slept. */
+	sp->totalrun -= sleep_time;
 	continue_slice(p);
 }
 
@@ -355,6 +377,7 @@ static inline void recalc_task_prio(task
  */
 static void activate_task(task_t *p, runqueue_t *rq, const int local)
 {
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
 	unsigned long long now = sched_clock();
 	unsigned long rr = rr_interval(p);
 
@@ -366,11 +389,12 @@ static void activate_task(task_t *p, run
 			+ rq->timestamp_last_tick;
 	}
 #endif
-	p->sdu.staircase.slice = slice(p);
-	p->sdu.staircase.time_slice = p->sdu.staircase.slice % rr ? : rr;
+	sp->slice = slice(p);
+	sp->time_slice = sp->slice % rr ? : rr;
 	if (!rt_task(p)) {
 		recalc_task_prio(p, now);
-		p->sdu.staircase.sflags &= ~SF_NONSLEEP;
+		sp->sflags &= ~SF_NONSLEEP;
+		sp->systime = 0;
 		p->prio = effective_prio(p);
 	}
 	p->timestamp = now;
@@ -398,12 +422,17 @@ static void fastcall deactivate_task(tas
  */
 static void fastcall preempt(const task_t *p, runqueue_t *rq)
 {
-	if (p->prio >= rq->curr->prio)
+	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
+	task_t *curr = rq->curr;
+
+	if (p->prio >= curr->prio)
 		return;
-	if (!sched_compute || rq->qu.staircase.cache_ticks >= CACHE_DELAY ||
-		!p->mm || rt_task(p))
-			resched_task(rq->curr);
-	rq->qu.staircase.preempted = 1;
+	if (!sched_compute || rqq->cache_ticks >= CACHE_DELAY || !p->mm ||
+	    rt_task(p) || curr == rq->idle) {
+		resched_task(curr);
+		return;
+	}
+	rqq->preempted = 1;
 }
 
 /***
@@ -436,7 +465,7 @@ static void staircase_wake_up_task(task_
 
 /*
  * Perform scheduler related setup for a newly forked process p.
- * p is forked by current.
+ * p is forked by current. (nothing to do)
  */
 static void staircase_fork(task_t *__unused)
 {
@@ -452,6 +481,8 @@ static void staircase_fork(task_t *__unu
 static void staircase_wake_up_new_task(task_t *p,
 	const unsigned long clone_flags)
 {
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+	struct staircase_sched_drv_task *scurr = &current->sdu.staircase;
 	unsigned long flags;
 	int this_cpu, cpu;
 	runqueue_t *rq, *this_rq;
@@ -461,21 +492,20 @@ static void staircase_wake_up_new_task(t
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
 
-	/*
-	 * Forked process gets no bonus to prevent fork bombs.
-	 */
-	p->sdu.staircase.bonus = 0;
+	/* Forked process gets no bonus to prevent fork bombs. */
+	sp->bonus = 0;
+	scurr->sflags |= SF_NONSLEEP;
 
 	if (likely(cpu == this_cpu)) {
-		current->sdu.staircase.sflags |= SF_NONSLEEP;
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
@@ -501,20 +531,13 @@ static void staircase_wake_up_new_task(t
 		 */
 		task_rq_unlock(rq, &flags);
 		this_rq = task_rq_lock(current, &flags);
-		current->sdu.staircase.sflags |= SF_NONSLEEP;
 	}
 
 	task_rq_unlock(this_rq, &flags);
 }
 
 /*
- * Potentially available exiting-child timeslices are
- * retrieved here - this way the parent does not get
- * penalized for creating too many threads.
- *
- * (this cannot be used to 'generate' timeslices
- * artificially, because any timeslice recovered here
- * was given away by the parent in the first place.)
+ * Perform task exit functions (nothing to do)
  */
 static void staircase_exit(task_t *__unused)
 {
@@ -620,11 +643,12 @@ out:
 static void time_slice_expired(task_t *p, runqueue_t *rq)
 {
 	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
 
 	set_tsk_need_resched(p);
 	dequeue_task(p, rqq);
 	p->prio = effective_prio(p);
-	p->sdu.staircase.time_slice = rr_interval(p);
+	sp->time_slice = rr_interval(p);
 	enqueue_task(p, rqq);
 }
 
@@ -635,6 +659,8 @@ static void time_slice_expired(task_t *p
 static void staircase_tick(struct task_struct *p, struct runqueue *rq,
 	unsigned long long now)
 {
+	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
 	int cpu = smp_processor_id();
 	unsigned long debit, expired_balance = rq->nr_running;
 
@@ -661,31 +687,31 @@ static void staircase_tick(struct task_s
 
 	spin_lock(&rq->lock);
 	debit = ns_diff(rq->timestamp_last_tick, p->timestamp);
-	p->sdu.staircase.ns_debit += debit;
-	if (p->sdu.staircase.ns_debit < NSJIFFY)
+	sp->ns_debit += debit;
+	if (sp->ns_debit < NSJIFFY)
 		goto out_unlock;
-	p->sdu.staircase.ns_debit %= NSJIFFY;
+	sp->ns_debit %= NSJIFFY;
 	/*
 	 * Tasks lose bonus each time they use up a full slice().
 	 */
-	if (!--p->sdu.staircase.slice) {
+	if (!--sp->slice) {
 		dec_bonus(p);
-		p->sdu.staircase.slice = slice(p);
+		sp->slice = slice(p);
 		time_slice_expired(p, rq);
-		p->sdu.staircase.totalrun = 0;
+		sp->totalrun = 0;
 		goto out_unlock;
 	}
 	/*
 	 * Tasks that run out of time_slice but still have slice left get
 	 * requeued with a lower priority && RR_INTERVAL time_slice.
 	 */
-	if (!--p->sdu.staircase.time_slice) {
+	if (!--sp->time_slice) {
 		time_slice_expired(p, rq);
 		goto out_unlock;
 	}
-	rq->qu.staircase.cache_ticks++;
-	if (rq->qu.staircase.preempted &&
-		rq->qu.staircase.cache_ticks >= CACHE_DELAY) {
+	rqq->cache_ticks++;
+	if (rqq->preempted &&
+		rqq->cache_ticks >= CACHE_DELAY) {
 		set_tsk_need_resched(p);
 		goto out_unlock;
 	}
@@ -721,6 +747,7 @@ static void staircase_schedule(void)
 	int cpu, idx;
 	struct task_struct *prev = current, *next;
 	struct runqueue *rq = this_rq();
+	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
 	unsigned long long now = sched_clock();
 	unsigned long debit;
 	struct list_head *queue;
@@ -781,8 +808,8 @@ go_idle:
 			goto go_idle;
 	}
 
-	idx = sched_find_first_bit(rq->qu.staircase.bitmap);
-	queue = rq->qu.staircase.queue + idx;
+	idx = sched_find_first_bit(rqq->bitmap);
+	queue = rqq->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
 switch_tasks:
@@ -799,8 +826,7 @@ switch_tasks:
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
-		rq->qu.staircase.preempted = 0;
-		rq->qu.staircase.cache_ticks = 0;
+		rqq->preempted = rqq->cache_ticks = 0;
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -950,14 +976,9 @@ static long staircase_sys_yield(void)
 	current->sdu.staircase.slice = slice(current);
 	current->sdu.staircase.time_slice = rr_interval(current);
 	if (likely(!rt_task(current)))
-		newprio = STAIRCASE_MAX_PRIO - 1;
+		newprio = MIN_USER_PRIO;
 
-	if (newprio != current->prio) {
-		dequeue_task(current, rqq);
-		current->prio = newprio;
-		enqueue_task(current, rqq);
-	} else
-		requeue_task(current, rqq);
+	requeue_task(current, rqq, newprio);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -1023,9 +1044,10 @@ static void staircase_migrate_dead_tasks
 {
 	unsigned i;
 	struct runqueue *rq = cpu_rq(dead_cpu);
+	struct staircase_runqueue_queue *rqq = &rq->qu.staircase;
 
 	for (i = 0; i < STAIRCASE_MAX_PRIO; i++) {
-		struct list_head *list = &rq->qu.staircase.queue[i];
+		struct list_head *list = &rqq->queue[i];
 		while (!list_empty(list))
 			migrate_dead(dead_cpu, list_entry(list->next, task_t,
 				run_list));

--Boundary-00=_mj2LEttjFfeo771
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="plugsched-6.3.1-sched_system_time.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="plugsched-6.3.1-sched_system_time.patch"

---
 include/linux/sched_drv.h |    1 +
 include/linux/sched_spa.h |    1 +
 kernel/ingo_ll.c          |    5 +++++
 kernel/ingosched.c        |    5 +++++
 kernel/nicksched.c        |    5 +++++
 kernel/sched.c            |    1 +
 kernel/sched_spa.c        |    5 +++++
 kernel/sched_spa_ebs.c    |    1 +
 kernel/sched_spa_svr.c    |    1 +
 kernel/sched_spa_ws.c     |    1 +
 kernel/sched_zaphod.c     |    1 +
 kernel/staircase.c        |    8 ++++++++
 12 files changed, 35 insertions(+)

Index: linux-2.6.16-mm2/include/linux/sched_drv.h
===================================================================
--- linux-2.6.16-mm2.orig/include/linux/sched_drv.h	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/include/linux/sched_drv.h	2006-04-02 15:28:56.000000000 +1000
@@ -32,6 +32,7 @@ struct sched_drv {
 	int (*move_tasks)(runqueue_t *, int, runqueue_t *, unsigned long, unsigned long,
 		 struct sched_domain *, enum idle_type, int *all_pinned);
 #endif
+	void (*sched_system_tick)(task_t *);
 	void (*tick)(struct task_struct*, struct runqueue *, unsigned long long);
 #ifdef CONFIG_SCHED_SMT
 	struct task_struct *(*head_of_queue)(union runqueue_queue *);
Index: linux-2.6.16-mm2/kernel/ingo_ll.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/ingo_ll.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/ingo_ll.c	2006-04-02 15:31:29.000000000 +1000
@@ -752,6 +752,10 @@ out:
 }
 #endif
 
+static void ingo_system_tick(struct task_struct *p)
+{
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1290,6 +1294,7 @@ const struct sched_drv ingo_ll_sched_drv
 #ifdef CONFIG_SMP
 	.move_tasks = ingo_move_tasks,
 #endif
+	.sched_system_tick = ingo_system_tick,
 	.tick = ingo_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = ingo_head_of_queue,
Index: linux-2.6.16-mm2/kernel/ingosched.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/ingosched.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/ingosched.c	2006-04-02 15:31:40.000000000 +1000
@@ -777,6 +777,10 @@ out:
 }
 #endif
 
+static void ingo_system_tick(struct task_struct *p)
+{
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1336,6 +1340,7 @@ const struct sched_drv ingo_sched_drv = 
 #ifdef CONFIG_SMP
 	.move_tasks = ingo_move_tasks,
 #endif
+	.sched_system_tick = ingo_system_tick,
 	.tick = ingo_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = ingo_head_of_queue,
Index: linux-2.6.16-mm2/kernel/nicksched.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/nicksched.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/nicksched.c	2006-04-02 15:32:54.000000000 +1000
@@ -642,6 +642,10 @@ out:
 }
 #endif
 
+static void nick_system_tick(struct task_struct *p)
+{
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1087,6 +1091,7 @@ const struct sched_drv nick_sched_drv = 
 #ifdef CONFIG_SMP
 	.move_tasks = nick_move_tasks,
 #endif
+	.sched_system_tick = nick_system_tick,
 	.tick = nick_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = nick_head_of_queue,
Index: linux-2.6.16-mm2/kernel/sched.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/sched.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/sched.c	2006-04-02 15:29:01.000000000 +1000
@@ -1693,6 +1693,7 @@ void account_system_time(struct task_str
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
 	/* Account for system time used */
 	acct_update_integrals(p);
+	sched_drvp->sched_system_tick(p);
 }
 
 /*
Index: linux-2.6.16-mm2/kernel/sched_spa.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/sched_spa.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/sched_spa.c	2006-04-02 15:39:37.000000000 +1000
@@ -825,6 +825,10 @@ static void spa_nf_runq_data_tick(unsign
 {
 }
 
+void spa_system_tick(struct task_struct *p)
+{
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1658,6 +1662,7 @@ const struct sched_drv spa_nf_sched_drv 
 #ifdef CONFIG_SMP
 	.move_tasks = spa_move_tasks,
 #endif
+	.sched_system_tick = spa_system_tick,
 	.tick = spa_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = spa_head_of_queue,
Index: linux-2.6.16-mm2/kernel/staircase.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/staircase.c	2006-04-02 15:11:10.000000000 +1000
+++ linux-2.6.16-mm2/kernel/staircase.c	2006-04-02 15:35:48.000000000 +1000
@@ -652,6 +652,13 @@ static void time_slice_expired(task_t *p
 	enqueue_task(p, rqq);
 }
 
+static void staircase_system_tick(struct task_struct *p)
+{
+	struct staircase_sched_drv_task *sp = &p->sdu.staircase;
+
+	sp->systime++;
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1115,6 +1122,7 @@ const struct sched_drv staircase_sched_d
 #ifdef CONFIG_SMP
 	.move_tasks = staircase_move_tasks,
 #endif
+	.sched_system_tick = staircase_system_tick,
 	.tick = staircase_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = staircase_head_of_queue,
Index: linux-2.6.16-mm2/kernel/sched_spa_ebs.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/sched_spa_ebs.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/sched_spa_ebs.c	2006-04-02 15:37:52.000000000 +1000
@@ -370,6 +370,7 @@ const struct sched_drv spa_ebs_sched_drv
 #ifdef CONFIG_SMP
 	.move_tasks = spa_move_tasks,
 #endif
+	.sched_system_tick = spa_system_tick,
 	.tick = spa_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = spa_head_of_queue,
Index: linux-2.6.16-mm2/kernel/sched_spa_svr.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/sched_spa_svr.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/sched_spa_svr.c	2006-04-02 15:38:21.000000000 +1000
@@ -170,6 +170,7 @@ const struct sched_drv spa_svr_sched_drv
 #ifdef CONFIG_SMP
 	.move_tasks = spa_move_tasks,
 #endif
+	.sched_system_tick = spa_system_tick,
 	.tick = spa_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = spa_head_of_queue,
Index: linux-2.6.16-mm2/kernel/sched_spa_ws.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/sched_spa_ws.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/sched_spa_ws.c	2006-04-02 15:38:12.000000000 +1000
@@ -317,6 +317,7 @@ const struct sched_drv spa_ws_sched_drv 
 #ifdef CONFIG_SMP
 	.move_tasks = spa_move_tasks,
 #endif
+	.sched_system_tick = spa_system_tick,
 	.tick = spa_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = spa_head_of_queue,
Index: linux-2.6.16-mm2/kernel/sched_zaphod.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/sched_zaphod.c	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/kernel/sched_zaphod.c	2006-04-02 15:38:02.000000000 +1000
@@ -607,6 +607,7 @@ const struct sched_drv zaphod_sched_drv 
 #ifdef CONFIG_SMP
 	.move_tasks = spa_move_tasks,
 #endif
+	.sched_system_tick = spa_system_tick,
 	.tick = spa_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = spa_head_of_queue,
Index: linux-2.6.16-mm2/include/linux/sched_spa.h
===================================================================
--- linux-2.6.16-mm2.orig/include/linux/sched_spa.h	2006-04-02 14:20:34.000000000 +1000
+++ linux-2.6.16-mm2/include/linux/sched_spa.h	2006-04-02 15:40:47.000000000 +1000
@@ -111,6 +111,7 @@ void spa_wake_up_task(struct task_struct
 void spa_fork(task_t *);
 void spa_wake_up_new_task(task_t *, unsigned long);
 void spa_exit(task_t *);
+void spa_system_tick(struct task_struct *);
 void spa_tick(struct task_struct *, struct runqueue *, unsigned long long);
 void spa_schedule(void);
 void spa_set_normal_task_nice(task_t *, long);

--Boundary-00=_mj2LEttjFfeo771--
