Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966333AbWKNUdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966333AbWKNUdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966339AbWKNUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:33:44 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63157 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S966337AbWKNUdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:41 -0500
Date: Tue, 14 Nov 2006 12:33:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061114203322.12761.81739.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/8] Move idle status calculation into rebalance_tick()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perform the idle state determination in rebalance_tick.

If we separate balancing from sched_tick then we also need
to determine the idle state in rebalance_tick.

V2->V3
	Remove useless idlle != 0 check. Checking nr_running seems
	to be sufficient. Thanks Suresh.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-10 22:48:56.838771375 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-10 22:49:12.178951052 -0600
@@ -2870,10 +2870,16 @@ static void update_load(struct rq *this_
  */
 
 static void
-rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+rebalance_tick(int this_cpu, struct rq *this_rq)
 {
 	unsigned long interval;
 	struct sched_domain *sd;
+	/*
+	 * We are idle if there are no processes running. This
+	 * is valid even if we are the idle process (SMT).
+	 */
+	enum idle_type idle = !this_rq->nr_running ?
+				SCHED_IDLE : NOT_IDLE;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2905,37 +2911,26 @@ rebalance_tick(int this_cpu, struct rq *
 /*
  * on UP we do not need to balance between CPUs:
  */
-static inline void rebalance_tick(int cpu, struct rq *rq)
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
 	if (!rq->nr_running)
-		return 0;
+		return;
 
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
@@ -3151,20 +3146,20 @@ void scheduler_tick(void)
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
-	} else
+		wake_priority_sleeper(rq);
+	else
 		task_running_tick(rq, p);
+#ifdef CONFIG_SMP
 	update_load(rq);
-	rebalance_tick(cpu, rq, idle);
+	rebalance_tick(cpu, rq);
+#endif
 }
 
 #ifdef CONFIG_SCHED_SMT
