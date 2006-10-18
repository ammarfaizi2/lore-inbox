Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423054AbWJRV71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423054AbWJRV71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423055AbWJRV71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:59:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:22718 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423054AbWJRV70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:59:26 -0400
Date: Wed, 18 Oct 2006 14:59:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
In-Reply-To: <45367D32.6090301@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610181457130.30795@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
 <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
 <45366DF0.6040702@yahoo.com.au> <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com>
 <45367D32.6090301@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revised and tested patch. Be sure to disable interruipts in
load_balance. Fix the wait_priority_sleeper issue.

[PATCH] rebalance_tick() with interrupts enabled

load_balancing has the potential of running for some time if f.e.
sched_domains for a system with 1024 processors have to be balanced.
We currently do all of that with interrupts disabled. So we may be unable
to service interrupts for some time. Most of that time is potentially
spend in rebalance_tick.

This patch splits off rebalance_tick from scheduler_tick and schedules
it via a tasklet.

Successfully completed an AIM7 run with it.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/kernel/sched.c	2006-10-18 15:45:27.921708469 -0500
+++ linux-2.6.19-rc2-mm1/kernel/sched.c	2006-10-18 15:58:58.255149369 -0500
@@ -2531,7 +2531,7 @@ static inline unsigned long minus_1_or_z
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
  *
- * Called with this_rq unlocked.
+ * Called with this_rq unlocked. Interrupts may be enabled.
  */
 static int load_balance(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum idle_type idle)
@@ -2541,6 +2541,7 @@ static int load_balance(int this_cpu, st
 	unsigned long imbalance;
 	struct rq *busiest;
 	cpumask_t cpus = CPU_MASK_ALL;
+	unsigned long flags;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -2580,11 +2581,13 @@ redo:
 		 * still unbalanced. nr_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
+		local_irq_save(flags);
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 				      minus_1_or_zero(busiest->nr_running),
 				      imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
+		local_irq_restore(flags);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(all_pinned)) {
@@ -2601,13 +2604,13 @@ redo:
 
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 
-			spin_lock(&busiest->lock);
+			spin_lock_irqsave(&busiest->lock, flags);
 
 			/* don't kick the migration_thread, if the curr
 			 * task on busiest cpu can't be moved to this_cpu
 			 */
 			if (!cpu_isset(this_cpu, busiest->curr->cpus_allowed)) {
-				spin_unlock(&busiest->lock);
+				spin_unlock_irqrestore(&busiest->lock, flags);
 				all_pinned = 1;
 				goto out_one_pinned;
 			}
@@ -2617,7 +2620,7 @@ redo:
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			spin_unlock(&busiest->lock);
+			spin_unlock_irqrestore(&busiest->lock, flags);
 			if (active_balance)
 				wake_up_process(busiest->migration_thread);
 
@@ -2831,13 +2834,19 @@ static inline unsigned long cpu_offset(i
 	return jiffies + cpu * HZ / NR_CPUS;
 }
 
-static void
-rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+/*
+ * Called from a tasklet with interrupts enabled.
+ */
+static void rebalance_tick(unsigned long dummy)
 {
+	int this_cpu = smp_processor_id();
+	struct rq *this_rq = cpu_rq(this_cpu);
+	enum idle_type idle;
 	unsigned long this_load, interval, j = cpu_offset(this_cpu);
 	struct sched_domain *sd;
 	int i, scale;
 
+	idle = (current == this_rq->idle) ? SCHED_IDLE : NOT_IDLE;
 	this_load = this_rq->raw_weighted_load;
 
 	/* Update our load: */
@@ -2882,35 +2891,30 @@ rebalance_tick(int this_cpu, struct rq *
 		}
 	}
 }
+
+static DECLARE_TASKLET(rebalance, rebalance_tick, 0);
+
 #else
 /*
  * on UP we do not need to balance between CPUs:
  */
-static inline void rebalance_tick(int cpu, struct rq *rq, enum idle_type idle)
-{
-}
 static inline void idle_balance(int cpu, struct rq *rq)
 {
 }
 #endif
 
-static inline int wake_priority_sleeper(struct rq *rq)
+static inline void wake_priority_sleeper(struct rq *rq)
 {
-	int ret = 0;
-
 #ifdef CONFIG_SCHED_SMT
 	spin_lock(&rq->lock);
 	/*
 	 * If an SMT sibling task has been put to sleep for priority
 	 * reasons reschedule the idle task to see if it can now run.
 	 */
-	if (rq->nr_running) {
+	if (rq->nr_running)
 		resched_task(rq->idle);
-		ret = 1;
-	}
 	spin_unlock(&rq->lock);
 #endif
-	return ret;
 }
 
 DEFINE_PER_CPU(struct kernel_stat, kstat);
@@ -3057,10 +3061,8 @@ void scheduler_tick(void)
 	rq->timestamp_last_tick = now;
 
 	if (p == rq->idle) {
-		if (wake_priority_sleeper(rq))
-			goto out;
-		rebalance_tick(cpu, rq, SCHED_IDLE);
-		return;
+		wake_priority_sleeper(rq);
+		goto out;
 	}
 
 	/* Task might have expired already, but not scheduled off yet */
@@ -3135,7 +3137,9 @@ void scheduler_tick(void)
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
-	rebalance_tick(cpu, rq, NOT_IDLE);
+#ifdef CONFIG_SMP
+	tasklet_schedule(&rebalance);
+#endif
 }
 
 #ifdef CONFIG_SCHED_SMT

