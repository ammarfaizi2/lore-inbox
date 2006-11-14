Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966337AbWKNUe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966337AbWKNUe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966339AbWKNUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:33:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61877 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S966335AbWKNUdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:38 -0500
Date: Tue, 14 Nov 2006 12:33:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061114203317.12761.87607.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/8] Extract load calculation from rebalance_tick
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extract load calculation from rebalance_tick

A load calculation is always done in rebalance_tick() in addition
to the real load balancing activities that only take place when certain
jiffie counts have been reached. Move that processing into a separate
function and call it directly from scheduler_tick().

Also extract the time slice handling from scheduler_tick and
put it into a separate function. Then we can clean up scheduler_tick
significantly. It will no longer have any gotos.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-10 22:48:31.784869982 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-10 22:48:56.838771375 -0600
@@ -2836,20 +2836,9 @@ static void active_load_balance(struct r
 	spin_unlock(&target_rq->lock);
 }
 
-/*
- * rebalance_tick will get called every timer tick, on every CPU.
- *
- * It checks each scheduling domain to see if it is due to be balanced,
- * and initiates a balancing operation if so.
- *
- * Balancing parameters are set up in arch_init_sched_domains.
- */
-
-static void
-rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+static void update_load(struct rq *this_rq)
 {
-	unsigned long this_load, interval;
-	struct sched_domain *sd;
+	unsigned long this_load;
 	int i, scale;
 
 	this_load = this_rq->raw_weighted_load;
@@ -2869,6 +2858,22 @@ rebalance_tick(int this_cpu, struct rq *
 			new_load += scale-1;
 		this_rq->cpu_load[i] = (old_load*(scale-1) + new_load) / scale;
 	}
+}
+
+/*
+ * rebalance_tick will get called every timer tick, on every CPU.
+ *
+ * It checks each scheduling domain to see if it is due to be balanced,
+ * and initiates a balancing operation if so.
+ *
+ * Balancing parameters are set up in arch_init_sched_domains.
+ */
+
+static void
+rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+{
+	unsigned long interval;
+	struct sched_domain *sd;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2900,12 +2905,15 @@ rebalance_tick(int this_cpu, struct rq *
 /*
  * on UP we do not need to balance between CPUs:
  */
-static inline void rebalance_tick(int cpu, struct rq *rq, enum idle_type idle)
+static inline void rebalance_tick(int cpu, struct rq *rq)
 {
 }
 static inline void idle_balance(int cpu, struct rq *rq)
 {
 }
+static inline void update_load(struct rq *this_rq)
+{
+}
 #endif
 
 static inline int wake_priority_sleeper(struct rq *rq)
@@ -3055,35 +3063,12 @@ void account_steal_time(struct task_stru
 		cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
-/*
- * This function gets called by the timer code, with HZ frequency.
- * We call it with interrupts disabled.
- *
- * It also gets called by the fork code, when changing the parent's
- * timeslices.
- */
-void scheduler_tick(void)
+static void task_running_tick(struct rq *rq, struct task_struct *p)
 {
-	unsigned long long now = sched_clock();
-	struct task_struct *p = current;
-	int cpu = smp_processor_id();
-	struct rq *rq = cpu_rq(cpu);
-
-	update_cpu_clock(p, rq, now);
-
-	rq->timestamp_last_tick = now;
-
-	if (p == rq->idle) {
-		if (wake_priority_sleeper(rq))
-			goto out;
-		rebalance_tick(cpu, rq, SCHED_IDLE);
-		return;
-	}
-
-	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
+		/* Task has expired but was not scheduled yet */
 		set_tsk_need_resched(p);
-		goto out;
+		return;
 	}
 	spin_lock(&rq->lock);
 	/*
@@ -3151,8 +3136,35 @@ void scheduler_tick(void)
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
-out:
-	rebalance_tick(cpu, rq, NOT_IDLE);
+}
+
+/*
+ * This function gets called by the timer code, with HZ frequency.
+ * We call it with interrupts disabled.
+ *
+ * It also gets called by the fork code, when changing the parent's
+ * timeslices.
+ */
+void scheduler_tick(void)
+{
+	unsigned long long now = sched_clock();
+	struct task_struct *p = current;
+	int cpu = smp_processor_id();
+	struct rq *rq = cpu_rq(cpu);
+	enum idle_type idle = NOT_IDLE;
+
+	update_cpu_clock(p, rq, now);
+
+	rq->timestamp_last_tick = now;
+
+	if (p == rq->idle) {
+		/* Task on the idle queue */
+		if (!wake_priority_sleeper(rq))
+			idle = SCHED_IDLE;
+	} else
+		task_running_tick(rq, p);
+	update_load(rq);
+	rebalance_tick(cpu, rq, idle);
 }
 
 #ifdef CONFIG_SCHED_SMT
