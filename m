Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWFBI42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWFBI42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFBI42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:56:28 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:44971 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751341AbWFBI41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:56:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=hbKh89WAsbqrLCt5cbp3nYLWsJYzVYpmMAFf+mTf+zo9hls3icqD/NJO87xrKNwQ9vxRKaxx69uzmTOsQt7WJ3fzLMDtUkVEJcaqtrT0hooPcvA/ThiehdHeVc8AMB/JZsURRq5BLKMPXVo/staElzVe1x6lNlr9pWVK+rGSSU0=  ;
Message-ID: <447FFD35.9020909@yahoo.com.au>
Date: Fri, 02 Jun 2006 18:56:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
References: <000201c6861f$6a2d4e20$0b4ce984@amr.corp.intel.com>
In-Reply-To: <000201c6861f$6a2d4e20$0b4ce984@amr.corp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------060308000209090209000201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060308000209090209000201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chen, Kenneth W wrote:

> Ha, you beat me by one minute. It did cross my mind to use try lock there as
> well, take a look at my version, I think I have a better inner loop.

Actually you *have* to use trylocks I think, because the current runqueue
is already locked.

And why do we lock all siblings in the other case, for that matter? (not
that it makes much difference except on niagara today).

Rolled up patch with everyone's changes attached.

-- 
SUSE Labs, Novell Inc.

--------------060308000209090209000201
Content-Type: text/plain;
 name="sched-smt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-smt.patch"

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2006-06-02 18:51:25.000000000 +1000
+++ linux-2.6/kernel/sched.c	2006-06-02 18:54:38.000000000 +1000
@@ -239,7 +239,6 @@ struct runqueue {
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
-	int cpu;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1687,7 +1686,7 @@ unsigned long nr_active(void)
  * double_rq_lock - safely lock two runqueues
  *
  * We must take them in cpu order to match code in
- * dependent_sleeper and wake_dependent_sleeper.
+ * wake_dependent_sleeper.
  *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
@@ -1700,7 +1699,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1->cpu < rq2->cpu) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1736,7 +1735,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest->cpu < this_rq->cpu) {
+		if (busiest < this_rq) {
 			spin_unlock(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -2686,6 +2685,9 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
+/*
+ * Called with interrupts disabled and this_rq's runqueue locked.
+ */
 static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
@@ -2693,41 +2695,24 @@ static void wake_sleeping_dependent(int 
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
 	sibling_map = sd->span;
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	/*
-	 * We clear this CPU from the mask. This both simplifies the
-	 * inner loop and keps this_rq locked when we exit:
-	 */
 	cpu_clear(this_cpu, sibling_map);
-
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
+		if (unlikely(!spin_trylock(&smt_rq->lock)))
+			continue;
 
 		wakeup_busy_runqueue(smt_rq);
-	}
 
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
-	/*
-	 * We exit with this_cpu's rq still held and IRQs
-	 * still disabled:
-	 */
+		spin_unlock(&smt_rq->lock);
+	}
 }
 
 /*
@@ -2740,48 +2725,38 @@ static inline unsigned long smt_slice(ta
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
 	cpumask_t sibling_map;
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
 	sibling_map = sd->span;
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
 	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sibling_map) {
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
-
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
@@ -2834,10 +2809,10 @@ check_smt_task:
 			else
 				wakeup_busy_runqueue(smt_rq);
 		}
+
+		spin_unlock(&smt_rq->lock);
 	}
-out_unlock:
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
+
 	return ret;
 }
 #else
@@ -2845,7 +2820,8 @@ static inline void wake_sleeping_depende
 {
 }
 
-static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+static inline int dependent_sleeper(int this_cpu, struct runqueue *this_rq,
+	struct task_struct *p)
 {
 	return 0;
 }
@@ -2967,32 +2943,13 @@ need_resched_nonpreemptible:
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
-go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
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
@@ -3030,6 +2987,8 @@ go_idle:
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
+	if (dependent_sleeper(cpu, rq, next))
+		next = rq->idle;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -6126,7 +6085,6 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
-		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 

--------------060308000209090209000201--
Send instant messages to your online friends http://au.messenger.yahoo.com 
