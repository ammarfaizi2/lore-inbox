Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWBGO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWBGO2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWBGO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:28:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15561 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965098AbWBGO2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:28:31 -0500
Date: Tue, 7 Feb 2006 15:28:28 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>, Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Suresh B <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [rfc][patch] sched: remove smpnice
Message-ID: <20060207142828.GA20930@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to get some comments on removing smpnice for 2.6.16. I don't
think the code is quite ready, which is why I asked for Peter's additions
to also be merged before I acked it (although it turned out that it still
isn't quite ready with his additions either).

Basically I have had similar observations to Suresh in that it does not
play nicely with the rest of the balancing infrastructure (and raised
similar concerns in my review).

The samples (group of 4) I got for "maximum recorded imbalance" on a 2x2
SMP+HT Xeon are as follows:

           | Following boot | hackbench 20        | hackbench 40
-----------+----------------+---------------------+---------------------
2.6.16-rc2 | 30,37,100,112  | 5600,5530,6020,6090 | 6390,7090,8760,8470
+nosmpnice |  3, 2,  4,  2  |   28, 150, 294, 132 |  348, 348, 294, 347

Hackbench raw performance is down around 15% with smpnice (but that in
itself isn't a huge deal because it is just a benchmark). However, the
samples show that the imbalance passed into move_tasks is increased by
about a factor of 10-30. I think this would also go some way to
explaining latency blips turning up in the balancing code (though I
haven't actually measured that).

We'll probably have to revert this in the SUSE kernel.

The other option for 2.6.16 would be to fast track Peter's stuff, which
I could put some time into... but that seems a bit risky at this stage
of the game.

I'd like to hear any other suggestions though. Patch included to aid
discussion at this stage, rather than to encourage any rash decisions.

Nick
--

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -215,7 +215,6 @@ struct runqueue {
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
-	unsigned long prio_bias;
 	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
@@ -671,68 +670,13 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
-#ifdef CONFIG_SMP
-static inline void inc_prio_bias(runqueue_t *rq, int prio)
-{
-	rq->prio_bias += MAX_PRIO - prio;
-}
-
-static inline void dec_prio_bias(runqueue_t *rq, int prio)
-{
-	rq->prio_bias -= MAX_PRIO - prio;
-}
-
-static inline void inc_nr_running(task_t *p, runqueue_t *rq)
-{
-	rq->nr_running++;
-	if (rt_task(p)) {
-		if (p != rq->migration_thread)
-			/*
-			 * The migration thread does the actual balancing. Do
-			 * not bias by its priority as the ultra high priority
-			 * will skew balancing adversely.
-			 */
-			inc_prio_bias(rq, p->prio);
-	} else
-		inc_prio_bias(rq, p->static_prio);
-}
-
-static inline void dec_nr_running(task_t *p, runqueue_t *rq)
-{
-	rq->nr_running--;
-	if (rt_task(p)) {
-		if (p != rq->migration_thread)
-			dec_prio_bias(rq, p->prio);
-	} else
-		dec_prio_bias(rq, p->static_prio);
-}
-#else
-static inline void inc_prio_bias(runqueue_t *rq, int prio)
-{
-}
-
-static inline void dec_prio_bias(runqueue_t *rq, int prio)
-{
-}
-
-static inline void inc_nr_running(task_t *p, runqueue_t *rq)
-{
-	rq->nr_running++;
-}
-
-static inline void dec_nr_running(task_t *p, runqueue_t *rq)
-{
-	rq->nr_running--;
-}
-#endif
-
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	inc_nr_running(p, rq);
+	rq->nr_running++;
 }
 
 /*
@@ -741,7 +685,7 @@ static inline void __activate_task(task_
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
-	inc_nr_running(p, rq);
+	rq->nr_running++;
 }
 
 static int recalc_task_prio(task_t *p, unsigned long long now)
@@ -865,7 +809,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	dec_nr_running(p, rq);
+	rq->nr_running--;
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -1009,61 +953,27 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static unsigned long __source_load(int cpu, int type, enum idle_type idle)
+static inline unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long running = rq->nr_running;
-	unsigned long source_load, cpu_load = rq->cpu_load[type-1],
-		load_now = running * SCHED_LOAD_SCALE;
-
+	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
 	if (type == 0)
-		source_load = load_now;
-	else
-		source_load = min(cpu_load, load_now);
-
-	if (running > 1 || (idle == NOT_IDLE && running))
-		/*
-		 * If we are busy rebalancing the load is biased by
-		 * priority to create 'nice' support across cpus. When
-		 * idle rebalancing we should only bias the source_load if
-		 * there is more than one task running on that queue to
-		 * prevent idle rebalance from trying to pull tasks from a
-		 * queue with only one running task.
-		 */
-		source_load = source_load * rq->prio_bias / running;
+		return load_now;
 
-	return source_load;
-}
-
-static inline unsigned long source_load(int cpu, int type)
-{
-	return __source_load(cpu, type, NOT_IDLE);
+	return min(rq->cpu_load[type-1], load_now);
 }
 
 /*
  * Return a high guess at the load of a migration-target cpu
  */
-static inline unsigned long __target_load(int cpu, int type, enum idle_type idle)
+static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long running = rq->nr_running;
-	unsigned long target_load, cpu_load = rq->cpu_load[type-1],
-		load_now = running * SCHED_LOAD_SCALE;
-
+	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
 	if (type == 0)
-		target_load = load_now;
-	else
-		target_load = max(cpu_load, load_now);
+		return load_now;
 
-	if (running > 1 || (idle == NOT_IDLE && running))
-		target_load = target_load * rq->prio_bias / running;
-
-	return target_load;
-}
-
-static inline unsigned long target_load(int cpu, int type)
-{
-	return __target_load(cpu, type, NOT_IDLE);
+	return max(rq->cpu_load[type-1], load_now);
 }
 
 /*
@@ -1532,7 +1442,7 @@ void fastcall wake_up_new_task(task_t *p
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
 				p->array->nr_active++;
-				inc_nr_running(p, rq);
+				rq->nr_running++;
 			}
 			set_need_resched();
 		} else
@@ -1877,9 +1787,9 @@ void pull_task(runqueue_t *src_rq, prio_
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	dec_nr_running(p, src_rq);
+	src_rq->nr_running--;
 	set_task_cpu(p, this_cpu);
-	inc_nr_running(p, this_rq);
+	this_rq->nr_running++;
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -2058,9 +1968,9 @@ find_busiest_group(struct sched_domain *
 
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
-				load = __target_load(i, load_idx, idle);
+				load = target_load(i, load_idx);
 			else
-				load = __source_load(i, load_idx, idle);
+				load = source_load(i, load_idx);
 
 			avg_load += load;
 		}
@@ -2173,7 +2083,7 @@ static runqueue_t *find_busiest_queue(st
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = __source_load(i, 0, idle);
+		load = source_load(i, 0);
 
 		if (load > max_load) {
 			max_load = load;
@@ -3576,10 +3486,8 @@ void set_user_nice(task_t *p, long nice)
 		goto out_unlock;
 	}
 	array = p->array;
-	if (array) {
+	if (array)
 		dequeue_task(p, array);
-		dec_prio_bias(rq, p->static_prio);
-	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
@@ -3589,7 +3497,6 @@ void set_user_nice(task_t *p, long nice)
 
 	if (array) {
 		enqueue_task(p, array);
-		inc_prio_bias(rq, p->static_prio);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
