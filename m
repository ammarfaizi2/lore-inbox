Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUHTM0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUHTM0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUHTM0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:26:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8369 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266831AbUHTMXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:23:06 -0400
Date: Fri, 20 Aug 2004 14:24:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched-smt-fixes.patch, 2.6.8.1-mm2
Message-ID: <20040820122435.GA9424@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


while looking at HT scheduler bugreports and boot failures i discovered
a bad assumption in most of the HT scheduling code: that resched_task()
can be called without holding the task's runqueue.

This is most definitely not valid - doing it without locking can lead to
the task on that CPU exiting, and this CPU corrupting the (ex-)
task_info struct. It can also lead to HT-wakeup races with task
switching on that other CPU. (this_CPU marking the wrong task on
that_CPU as need_resched - resulting in e.g. idle wakeups not working.)

The attached patch against 2.6.8.1-mm2 fixes it all up. Changes:

- resched_task() needs to touch the task so the runqueue lock of that CPU
  must be held: resched_task() now enforces this rule.

- wake_priority_sleeper() was called without holding the runqueue lock.

- wake_sleeping_dependent() needs to hold the runqueue locks of all siblings
  (2 typically). Effects of this ripples back to schedule() as well - in the
  non-SMT case it gets compiled out so it's fine.

- dependent_sleeper() needs the runqueue locks too - and it's slightly harder
  because it wants to know the 'next task' info which might change during
  the lock-drop/reacquire. Ripple effect on schedule() => compiled out on
  non-SMT so fine.

- resched_task() was disabling preemption for no good reason - all paths
  that called this function had either a spinlock held or irqs disabled.

Compiled & booted on x86 SMP and UP, with and without SMT. Booted the
SMT kernel on a real SMP+HT box as well. (Unpatched kernel wouldnt even
boot with the resched_task() assert in place.)

	Ingo

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-smt-fixes.patch"


locking in the SMT scheduler was completely wrong:

- resched_task() needs to touch the task so the runqueue lock of that CPU
  must be held. resched_task() now enforces this rule.

- resched_task() was disabling preemption for no good reason - all paths
  that called this function had either a spinlock held or irqs disabled.

- wake_priority_sleeper() was called without holding the runqueue lock.

- wake_sleeping_dependent() needs to hold the runqueue locks of all siblings
  (2 typically). Effects of this ripples back to schedule() as well - in the
  non-SMT case it gets compiled out so it's fine.

- dependent_sleeper() needs the runqueue locks too - and it's slightly harder
  because it wants to know the 'next task' info which might change during
  the lock-drop/reacquire. Ripple effect on schedule() => compiled out on
  non-SMT so fine.

Compiled & booted on x86 SMP and UP, with and without SMT. Booted the SMT
kernel on a real SMP+HT box as well.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -919,7 +919,8 @@ static void resched_task(task_t *p)
 {
 	int need_resched, nrpolling;
 
-	preempt_disable();
+	BUG_ON(!spin_is_locked(&task_rq(p)->lock));
+
 	/* minimise the chance of sending an interrupt to poll_idle() */
 	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
 	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
@@ -927,7 +928,6 @@ static void resched_task(task_t *p)
 
 	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
 		smp_send_reschedule(task_cpu(p));
-	preempt_enable();
 }
 #else
 static inline void resched_task(task_t *p)
@@ -2407,8 +2407,10 @@ void scheduler_tick(int user_ticks, int 
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
+		spin_lock(&rq->lock);
 		if (wake_priority_sleeper(rq))
-			goto out;
+			goto out_unlock;
+		spin_unlock(&rq->lock);
 		rebalance_tick(cpu, rq, IDLE);
 		return;
 	}
@@ -2497,23 +2499,34 @@ out:
 }
 
 #ifdef CONFIG_SCHED_SMT
-static inline void wake_sleeping_dependent(int cpu, runqueue_t *rq)
+static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
-	int i;
-	struct sched_domain *sd = rq->sd;
+	struct sched_domain *sd = this_rq->sd;
 	cpumask_t sibling_map;
+	int i;
 
 	if (!(sd->flags & SD_SHARE_CPUPOWER))
 		return;
 
+	/*
+	 * Unlock the current runqueue because we have to lock in
+	 * CPU order to avoid deadlocks. Caller knows that we might
+	 * unlock. We keep IRQs disabled.
+	 */
+	spin_unlock(&this_rq->lock);
+
 	cpus_and(sibling_map, sd->span, cpu_online_map);
-	for_each_cpu_mask(i, sibling_map) {
-		runqueue_t *smt_rq;
 
-		if (i == cpu)
-			continue;
+	for_each_cpu_mask(i, sibling_map)
+		spin_lock(&cpu_rq(i)->lock);
+	/*
+	 * We clear this CPU from the mask. This both simplifies the
+	 * inner loop and keps this_rq locked when we exit:
+	 */
+	cpu_clear(this_cpu, sibling_map);
 
-		smt_rq = cpu_rq(i);
+	for_each_cpu_mask(i, sibling_map) {
+		runqueue_t *smt_rq = cpu_rq(i);
 
 		/*
 		 * If an SMT sibling task is sleeping due to priority
@@ -2522,27 +2535,53 @@ static inline void wake_sleeping_depende
 		if (smt_rq->curr == smt_rq->idle && smt_rq->nr_running)
 			resched_task(smt_rq->idle);
 	}
+
+	for_each_cpu_mask(i, sibling_map)
+		spin_unlock(&cpu_rq(i)->lock);
+	/*
+	 * We exit with this_cpu's rq still held and IRQs
+	 * still disabled:
+	 */
 }
 
-static inline int dependent_sleeper(int cpu, runqueue_t *rq, task_t *p)
+static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
-	struct sched_domain *sd = rq->sd;
+	struct sched_domain *sd = this_rq->sd;
 	cpumask_t sibling_map;
+	prio_array_t *array;
 	int ret = 0, i;
+	task_t *p;
 
 	if (!(sd->flags & SD_SHARE_CPUPOWER))
 		return 0;
 
+	/*
+	 * The same locking rules and details apply as for
+	 * wake_sleeping_dependent():
+	 */
+	spin_unlock(&this_rq->lock);
 	cpus_and(sibling_map, sd->span, cpu_online_map);
-	for_each_cpu_mask(i, sibling_map) {
-		runqueue_t *smt_rq;
-		task_t *smt_curr;
+	for_each_cpu_mask(i, sibling_map)
+		spin_lock(&cpu_rq(i)->lock);
+	cpu_clear(this_cpu, sibling_map);
 
-		if (i == cpu)
-			continue;
+	/*
+	 * Establish next task to be run - it might have gone away because
+	 * we released the runqueue lock above:
+	 */
+	if (!this_rq->nr_running)
+		goto out_unlock;
+	array = this_rq->active;
+	if (!array->nr_active)
+		array = this_rq->expired;
+	BUG_ON(!array->nr_active);
 
-		smt_rq = cpu_rq(i);
-		smt_curr = smt_rq->curr;
+	p = list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
+		task_t, run_list);
+
+	for_each_cpu_mask(i, sibling_map) {
+		runqueue_t *smt_rq = cpu_rq(i);
+		task_t *smt_curr = smt_rq->curr;
 
 		/*
 		 * If a user task with lower static priority than the
@@ -2568,14 +2607,17 @@ static inline int dependent_sleeper(int 
 			(smt_curr == smt_rq->idle && smt_rq->nr_running))
 				resched_task(smt_curr);
 	}
+out_unlock:
+	for_each_cpu_mask(i, sibling_map)
+		spin_unlock(&cpu_rq(i)->lock);
 	return ret;
 }
 #else
-static inline void wake_sleeping_dependent(int cpu, runqueue_t *rq)
+static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 }
 
-static inline int dependent_sleeper(int cpu, runqueue_t *rq, task_t *p)
+static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
 	return 0;
 }
@@ -2656,13 +2698,33 @@ need_resched:
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
+go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
+			/*
+			 * wake_sleeping_dependent() might have released
+			 * the runqueue, so break out if we got new
+			 * tasks meanwhile:
+			 */
+			if (!rq->nr_running)
+				goto switch_tasks;
+		}
+	} else {
+		if (dependent_sleeper(cpu, rq)) {
+			schedstat_inc(rq, sched_goidle);
+			next = rq->idle;
 			goto switch_tasks;
 		}
+		/*
+		 * dependent_sleeper() releases and reacquires the runqueue
+		 * lock, hence go into the idle loop if the rq went
+		 * empty meanwhile:
+		 */
+		if (unlikely(!rq->nr_running))
+			goto go_idle;
 	}
 
 	array = rq->active;
@@ -2683,12 +2745,6 @@ need_resched:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (dependent_sleeper(cpu, rq, next)) {
-		schedstat_inc(rq, sched_goidle);
-		next = rq->idle;
-		goto switch_tasks;
-	}
-
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 

--d6Gm4EdcadzBjdND--
