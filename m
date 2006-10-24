Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWJXSbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWJXSbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWJXSbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:31:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13706 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161158AbWJXSbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:31:39 -0400
Date: Tue, 24 Oct 2006 11:31:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061024183124.4530.92230.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/5] Create rebalance_domains from rebalance_tick
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create rebalance_domains() from rebalance_tick().

Essentially rebalance_domains = rebalance_tick. However, we
do the idle calculation on our own. This removes some processing
from scheduler_tick into rebalance_domains().

While we are at it: Take the opportunity to avoid taking
the request queue lock in wake_priority_sleeper if
there are no running processes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/sched.c	2006-10-24 10:39:13.782726627 -0500
+++ linux-2.6.19-rc2-mm2/kernel/sched.c	2006-10-24 10:40:32.928543506 -0500
@@ -2842,18 +2842,22 @@ static void update_load(struct rq *this_
 }
 
 /*
- * rebalance_tick will get called every timer tick, on every CPU.
+ * rebalance_domains is called from the scheduler_tick.
  *
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
  * Balancing parameters are set up in arch_init_sched_domains.
  */
-static void
-rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+static void rebalance_domains(unsigned long dummy)
 {
+	int this_cpu = smp_processor_id();
+	struct rq *this_rq = cpu_rq(this_cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
+	/* Idle means on the idle queue without a runnable task */
+	enum idle_type idle = (this_rq->idle && !this_rq->nr_running) ?
+				SCHED_IDLE : NOT_IDLE;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2885,34 +2889,26 @@ rebalance_tick(int this_cpu, struct rq *
 /*
  * on UP we do not need to balance between CPUs:
  */
-static inline void rebalance_tick(int cpu, struct rq *rq, enum idle_type idle)
-{
-}
 static inline void idle_balance(int cpu, struct rq *rq)
 {
 }
-static inline void update_load(struct rq *this_rq)
-{
-}
 #endif
 
-static inline int wake_priority_sleeper(struct rq *rq)
+static inline void wake_priority_sleeper(struct rq *rq)
 {
-	int ret = 0;
-
 #ifdef CONFIG_SCHED_SMT
+	if (!rq->nr_running)
+		return;
+
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
@@ -3123,17 +3119,15 @@ void scheduler_tick(void)
 	struct task_struct *p = current;
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	enum idle_type idle = NOT_IDLE;
 
 	update_cpu_clock(p, rq, now);
 
 	rq->timestamp_last_tick = now;
 
-	if (p == rq->idle) {
+	if (p == rq->idle)
 		/* Task on the idle queue */
-		if (!wake_priority_sleeper(rq))
-			idle = SCHED_IDLE;
-	} else {
+		wake_priority_sleeper(rq);
+	else {
 		/* Task on cpu queue */
 		if (p->array != rq->active)
 			/* Task has expired but was not scheduled yet */
@@ -3141,8 +3135,10 @@ void scheduler_tick(void)
 		else
 			time_slice(rq, p);
 	}
+#ifdef CONFIG_SMP
 	update_load(rq);
-	rebalance_tick(cpu, rq, idle);
+	rebalance_domains(0L);
+#endif
 }
 
 #ifdef CONFIG_SCHED_SMT
