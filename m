Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWJRSCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWJRSCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWJRSCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:02:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62145 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161246AbWJRSCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:02:17 -0400
Date: Wed, 18 Oct 2006 11:01:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
In-Reply-To: <4536629C.4050807@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
 <4536629C.4050807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After that, it might be acceptable to call rebalance_tick from a tasklet,
> although it would be uneeded overhead on small systems. It might be better

Here is a patch that only runs rebalance tick from a tasklet in the 
scheduler. For UP there will be no tasklet.

[RFC] sched_rebalance_tick with interrupts enabled

scheduler_tick() has the potential of running for some time if f.e.
sched_domains for a system with 1024 processors have to be balanced.
We currently do all of that with interrupts disabled. So we may be unable
to service interrupts for some time. Most of that time is potentially
spend in rebalance_tick.

This patch splits off rebalance_tick from scheduler_tick and schedules
it via a tasklet.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/kernel/sched.c	2006-10-18 12:28:03.000000000 -0500
+++ linux-2.6.19-rc2-mm1/kernel/sched.c	2006-10-18 12:57:04.848077764 -0500
@@ -2831,13 +2831,37 @@ static inline unsigned long cpu_offset(i
 	return jiffies + cpu * HZ / NR_CPUS;
 }
 
-static void
-rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+static inline int wake_priority_sleeper(struct rq *rq)
+{
+	int ret = 0;
+
+#ifdef CONFIG_SCHED_SMT
+	spin_lock(&rq->lock);
+	/*
+	 * If an SMT sibling task has been put to sleep for priority
+	 * reasons reschedule the idle task to see if it can now run.
+	 */
+	if (rq->nr_running) {
+		resched_task(rq->idle);
+		ret = 1;
+	}
+	spin_unlock(&rq->lock);
+#endif
+	return ret;
+}
+
+
+static void rebalance_tick(unsigned long dummy)
 {
+	int this_cpu = smp_processor_id();
 	unsigned long this_load, interval, j = cpu_offset(this_cpu);
 	struct sched_domain *sd;
 	int i, scale;
+	struct rq *this_rq = cpu_rq(this_cpu);
+	enum idle_type idle = NOT_IDLE;
 
+	if (current == this_rq->idle &&!wake_priority_sleeper(this_rq))
+		idle = SCHED_IDLE;
 	this_load = this_rq->raw_weighted_load;
 
 	/* Update our load: */
@@ -2882,37 +2906,18 @@ rebalance_tick(int this_cpu, struct rq *
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
-{
-	int ret = 0;
-
-#ifdef CONFIG_SCHED_SMT
-	spin_lock(&rq->lock);
-	/*
-	 * If an SMT sibling task has been put to sleep for priority
-	 * reasons reschedule the idle task to see if it can now run.
-	 */
-	if (rq->nr_running) {
-		resched_task(rq->idle);
-		ret = 1;
-	}
-	spin_unlock(&rq->lock);
-#endif
-	return ret;
-}
-
 DEFINE_PER_CPU(struct kernel_stat, kstat);
 
 EXPORT_PER_CPU_SYMBOL(kstat);
@@ -3056,12 +3061,8 @@ void scheduler_tick(void)
 
 	rq->timestamp_last_tick = now;
 
-	if (p == rq->idle) {
-		if (wake_priority_sleeper(rq))
-			goto out;
-		rebalance_tick(cpu, rq, SCHED_IDLE);
-		return;
-	}
+	if (p == rq->idle)
+		goto out;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
@@ -3135,7 +3136,9 @@ void scheduler_tick(void)
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
-	rebalance_tick(cpu, rq, NOT_IDLE);
+#ifdef CONFIG_SMP
+	tasklet_schedule(&rebalance);
+#endif
 }
 
 #ifdef CONFIG_SCHED_SMT
