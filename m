Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWFBWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWFBWPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWFBWPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:15:00 -0400
Received: from mga03.intel.com ([143.182.124.21]:2073 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751496AbWFBWO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:14:59 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45280508:sNHT35487004"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Con Kolivas" <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 15:14:59 -0700
Message-ID: <000301c68691$fd0a2c00$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGInBptJF7xR+mTtS/Qg4G8lEwOAAbtRBw
In-Reply-To: <447FFD35.9020909@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Friday, June 02, 2006 1:56 AM
> Chen, Kenneth W wrote:
> 
> > Ha, you beat me by one minute. It did cross my mind to use try lock there as
> > well, take a look at my version, I think I have a better inner loop.
> 
> Actually you *have* to use trylocks I think, because the current runqueue
> is already locked.
> 
> And why do we lock all siblings in the other case, for that matter? (not
> that it makes much difference except on niagara today).
> 
> Rolled up patch with everyone's changes attached.


Rolled up patch on top of Nick's.  This version doesn't have the change
that removes the bully-ness in dependent_sleeper(), which is under debate
right now (I still think it should be removed).



--- ./kernel/sched.c.orig	2006-06-02 15:59:42.000000000 -0700
+++ ./kernel/sched.c	2006-06-02 16:05:13.000000000 -0700
@@ -239,7 +239,6 @@ struct runqueue {
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
-	int cpu;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1728,9 +1727,6 @@ unsigned long nr_active(void)
 /*
  * double_rq_lock - safely lock two runqueues
  *
- * We must take them in cpu order to match code in
- * dependent_sleeper and wake_dependent_sleeper.
- *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
  */
@@ -1742,7 +1738,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1->cpu < rq2->cpu) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1778,7 +1774,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest->cpu < this_rq->cpu) {
+		if (busiest < this_rq) {
 			spin_unlock(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -2712,48 +2708,33 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
-static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+/*
+ * Called with interrupts disabled and this_rq's runqueue locked.
+ */
+static void wake_sleeping_dependent(int this_cpu)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
 	int i;
 
 	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
-
+			break;
+		}
 	if (!sd)
 		return;
 
-	/*
-	 * Unlock the current runqueue because we have to lock in
-	 * CPU order to avoid deadlocks. Caller knows that we might
-	 * unlock. We keep IRQs disabled.
-	 */
-	spin_unlock(&this_rq->lock);
-
-	sibling_map = sd->span;
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	/*
-	 * We clear this CPU from the mask. This both simplifies the
-	 * inner loop and keps this_rq locked when we exit:
-	 */
-	cpu_clear(this_cpu, sibling_map);
-
-	for_each_cpu_mask(i, sibling_map) {
+	for_each_cpu_mask(i, sd->span) {
 		runqueue_t *smt_rq = cpu_rq(i);
 
+		if (i == this_cpu)
+			continue;
+		if (unlikely(!spin_trylock(&smt_rq->lock)))
+			continue;
+
 		wakeup_busy_runqueue(smt_rq);
+		spin_unlock(&smt_rq->lock);
 	}
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
-	/*
-	 * We exit with this_cpu's rq still held and IRQs
-	 * still disabled:
-	 */
 }
 
 /*
@@ -2766,48 +2747,38 @@ static inline unsigned long smt_slice(ta
 	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
 }
 
-static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+/*
+ * To minimise lock contention and not have to drop this_rq's runlock we only
+ * trylock the sibling runqueues and bypass those runqueues if we fail to
+ * acquire their lock. As we only trylock the normal locking order does not
+ * need to be obeyed.
+ */
+static int dependent_sleeper(int this_cpu, struct runqueue *this_rq,
+	struct task_struct *p)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
-	prio_array_t *array;
 	int ret = 0, i;
-	task_t *p;
 
 	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
-
+			break;
+		}
 	if (!sd)
 		return 0;
 
-	/*
-	 * The same locking rules and details apply as for
-	 * wake_sleeping_dependent():
-	 */
-	spin_unlock(&this_rq->lock);
-	sibling_map = sd->span;
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sd->span) {
+		runqueue_t *smt_rq;
+		task_t *smt_curr;
 
-	/*
-	 * Establish next task to be run - it might have gone away because
-	 * we released the runqueue lock above:
-	 */
-	if (!this_rq->nr_running)
-		goto out_unlock;
-	array = this_rq->active;
-	if (!array->nr_active)
-		array = this_rq->expired;
-	BUG_ON(!array->nr_active);
+		if (i == this_cpu)
+			continue;
 
-	p = list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
-		task_t, run_list);
+		smt_rq = cpu_rq(i);
+		if (unlikely(!spin_trylock(&smt_rq->lock)))
+			continue;
 
-	for_each_cpu_mask(i, sibling_map) {
-		runqueue_t *smt_rq = cpu_rq(i);
-		task_t *smt_curr = smt_rq->curr;
+		smt_curr = smt_rq->curr;
 
 		/* Kernel threads do not participate in dependent sleeping */
 		if (!p->mm || !smt_curr->mm || rt_task(p))
@@ -2860,18 +2831,18 @@ check_smt_task:
 			else
 				wakeup_busy_runqueue(smt_rq);
 		}
+
+		spin_unlock(&smt_rq->lock);
 	}
-out_unlock:
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
 	return ret;
 }
 #else
-static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static inline void wake_sleeping_dependent(int this_cpu)
 {
 }
 
-static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+static inline int dependent_sleeper(int this_cpu, struct runqueue *this_rq,
+	struct task_struct *p)
 {
 	return 0;
 }
@@ -2993,32 +2964,13 @@ need_resched_nonpreemptible:
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
-go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
-			wake_sleeping_dependent(cpu, rq);
-			/*
-			 * wake_sleeping_dependent() might have released
-			 * the runqueue, so break out if we got new
-			 * tasks meanwhile:
-			 */
-			if (!rq->nr_running)
-				goto switch_tasks;
-		}
-	} else {
-		if (dependent_sleeper(cpu, rq)) {
-			next = rq->idle;
+			wake_sleeping_dependent(cpu);
 			goto switch_tasks;
 		}
-		/*
-		 * dependent_sleeper() releases and reacquires the runqueue
-		 * lock, hence go into the idle loop if the rq went
-		 * empty meanwhile:
-		 */
-		if (unlikely(!rq->nr_running))
-			goto go_idle;
 	}
 
 	array = rq->active;
@@ -3056,6 +3008,8 @@ go_idle:
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
+	if (dependent_sleeper(cpu, rq, next))
+		next = rq->idle;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -6152,7 +6106,6 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
-		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 
