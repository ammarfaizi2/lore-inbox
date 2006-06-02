Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWFBDzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWFBDzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWFBDzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:55:44 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:26086 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751086AbWFBDzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:55:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 13:55:23 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021159.06519.kernel@kolivas.org> <200606021228.37910.kernel@kolivas.org>
In-Reply-To: <200606021228.37910.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021355.23671.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 12:28, Con Kolivas wrote:
> Actually looking even further, we only introduced the extra lookup of the
> next task when we started unlocking the runqueue in schedule(). Since we
> can get by without locking this_rq in schedule with this approach we can
> simplify dependent_sleeper even further by doing the dependent sleeper
> check after we have discovered what next is in schedule and avoid looking
> it up twice. I'll hack something up to do that soon.

Something like this (sorry I couldn't help but keep hacking on it).
---
It is not critical to functioning that dependent_sleeper() succeeds every
time. We can significantly reduce the locking overhead and contention of
dependent_sleeper by only doing trylock on the smt sibling runqueues. As
we're only doing trylock it means we do not need to observe the normal
locking order and we can get away without unlocking this_rq in schedule().
This provides us with an opportunity to simplify the code further.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/sched.c |   58 +++++++++++++++++----------------------------------------
 1 files changed, 18 insertions(+), 40 deletions(-)

Index: linux-2.6.17-rc5/kernel/sched.c
===================================================================
--- linux-2.6.17-rc5.orig/kernel/sched.c	2006-05-25 21:33:19.000000000 +1000
+++ linux-2.6.17-rc5/kernel/sched.c	2006-06-02 13:54:32.000000000 +1000
@@ -1687,7 +1687,7 @@ unsigned long nr_active(void)
  * double_rq_lock - safely lock two runqueues
  *
  * We must take them in cpu order to match code in
- * dependent_sleeper and wake_dependent_sleeper.
+ * wake_dependent_sleeper.
  *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
@@ -2740,13 +2740,18 @@ static inline unsigned long smt_slice(ta
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
 		if (tmp->flags & SD_SHARE_CPUPOWER)
@@ -2755,29 +2760,12 @@ static int dependent_sleeper(int this_cp
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
-
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
+	for_each_cpu_mask(i, sibling_map) {
+		if (unlikely(!spin_trylock(&cpu_rq(i)->lock)))
+			cpu_clear(i, sibling_map);
+	}
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -2835,7 +2823,7 @@ check_smt_task:
 				wakeup_busy_runqueue(smt_rq);
 		}
 	}
-out_unlock:
+
 	for_each_cpu_mask(i, sibling_map)
 		spin_unlock(&cpu_rq(i)->lock);
 	return ret;
@@ -2845,7 +2833,8 @@ static inline void wake_sleeping_depende
 {
 }
 
-static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+static inline int dependent_sleeper(int this_cpu, struct runqueue *this_rq,
+	struct task_struct *p)
 {
 	return 0;
 }
@@ -2967,7 +2956,6 @@ need_resched_nonpreemptible:
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
-go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
@@ -2981,18 +2969,6 @@ go_idle:
 			if (!rq->nr_running)
 				goto switch_tasks;
 		}
-	} else {
-		if (dependent_sleeper(cpu, rq)) {
-			next = rq->idle;
-			goto switch_tasks;
-		}
-		/*
-		 * dependent_sleeper() releases and reacquires the runqueue
-		 * lock, hence go into the idle loop if the rq went
-		 * empty meanwhile:
-		 */
-		if (unlikely(!rq->nr_running))
-			goto go_idle;
 	}
 
 	array = rq->active;
@@ -3030,6 +3006,8 @@ go_idle:
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
+	if (dependent_sleeper(cpu, rq, next))
+		next = rq->idle;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);

-- 
-ck
