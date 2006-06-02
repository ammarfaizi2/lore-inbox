Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWFBB7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWFBB7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWFBB7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:59:31 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:10695 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751088AbWFBB7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:59:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 11:59:05 +1000
User-Agent: KMail/1.9.1
Cc: "'Chris Mason'" <mason@suse.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com>
In-Reply-To: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021159.06519.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 09:57, Chen, Kenneth W wrote:
> Chris Mason wrote on Thursday, June 01, 2006 3:56 PM
>
> > Hello everyone,
> >
> > Recent benchmarks showed some performance regressions between 2.6.16 and
> > 2.6.5.  We tracked down one of the regressions to lock contention in
> > schedule heavy workloads (~70,000 context switches per second)
> >
> > kernel/sched.c:dependent_sleeper() was responsible for most of the lock
> > contention, hammering on the run queue locks.  The patch below is more of
> > a discussion point than a suggested fix (although it does reduce lock
> > contention significantly).  The dependent_sleeper code looks very
> > expensive to me, especially for using a spinlock to bounce control
> > between two different siblings in the same cpu.
>
> Yeah, this also sort of echo a recent discovery on one of our benchmarks
> that schedule() is red hot in the kernel.  I was just scratching my head
> not sure what's going on.  This dependent_sleeper could be the culprit
> considering it is called almost at every context switch.  I don't think
> we are hitting on lock contention, but by the large amount of code it
> executes.  It really needs to be cut down ....

Thanks for the suggestion. How about something like this which takes your
idea and further expands on it. Compiled, boot and runtime tests ok.

---
It is not critical to functioning that dependent_sleeper() succeeds every
time. We can significantly reduce the locking overhead and contention of
dependent_sleeper by only doing trylock on the smt sibling runqueues. As
we're only doing trylock it means we do not need to observe the normal
locking order and we can get away without unlocking this_rq in schedule().
This provides us with an opportunity to simplify the code further.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/sched.c |   58 +++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 22 deletions(-)

Index: linux-2.6.17-rc5/kernel/sched.c
===================================================================
--- linux-2.6.17-rc5.orig/kernel/sched.c	2006-05-25 21:33:19.000000000 +1000
+++ linux-2.6.17-rc5/kernel/sched.c	2006-06-02 11:51:13.000000000 +1000
@@ -1687,7 +1687,7 @@ unsigned long nr_active(void)
  * double_rq_lock - safely lock two runqueues
  *
  * We must take them in cpu order to match code in
- * dependent_sleeper and wake_dependent_sleeper.
+ * wake_dependent_sleeper.
  *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
@@ -2731,6 +2731,32 @@ static void wake_sleeping_dependent(int 
 }
 
 /*
+ * Try to lock all the siblings of a cpu that is already locked. As we're
+ * only doing trylock the order is not important.
+ */
+static int trylock_smt_siblings(cpumask_t sibling_map)
+{
+	cpumask_t locked_siblings;
+	int i;
+
+	cpus_clear(locked_siblings);
+	for_each_cpu_mask(i, sibling_map) {
+		if (!spin_trylock(&cpu_rq(i)->lock))
+			break;
+		cpu_set(i, locked_siblings);
+
+	}
+
+	/* Did we lock all the siblings? */
+	if (cpus_equal(sibling_map, locked_siblings))
+		return 1;
+
+	for_each_cpu_mask(i, locked_siblings)
+		spin_unlock(&cpu_rq(i)->lock);
+	return 0;
+}
+
+/*
  * number of 'lost' timeslices this task wont be able to fully
  * utilize, if another task runs on a sibling. This models the
  * slowdown effect of other tasks running on siblings:
@@ -2740,7 +2766,11 @@ static inline unsigned long smt_slice(ta
 	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
 }
 
-static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+/*
+ * To minimise lock contention and to have to drop this_rq's runlock we only
+ * trylock the sibling runqueues and give up if we can't acquire the locks.
+ */
+static int dependent_sleeper(int this_cpu, struct runqueue *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
 	cpumask_t sibling_map;
@@ -2755,22 +2785,14 @@ static int dependent_sleeper(int this_cp
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
+	if (!trylock_smt_siblings(sibling_map))
+		return 0;
 
 	/*
-	 * Establish next task to be run - it might have gone away because
-	 * we released the runqueue lock above:
+	 * Establish next task to be run.
 	 */
-	if (!this_rq->nr_running)
-		goto out_unlock;
 	array = this_rq->active;
 	if (!array->nr_active)
 		array = this_rq->expired;
@@ -2835,7 +2857,7 @@ check_smt_task:
 				wakeup_busy_runqueue(smt_rq);
 		}
 	}
-out_unlock:
+
 	for_each_cpu_mask(i, sibling_map)
 		spin_unlock(&cpu_rq(i)->lock);
 	return ret;
@@ -2967,7 +2989,6 @@ need_resched_nonpreemptible:
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
-go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
@@ -2986,13 +3007,6 @@ go_idle:
 			next = rq->idle;
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

-- 
-ck
