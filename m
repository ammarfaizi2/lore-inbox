Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWJ1Clt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWJ1Clt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWJ1Cls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:41:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12521 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751627AbWJ1Clr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:41:47 -0400
Date: Fri, 27 Oct 2006 19:41:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061028024138.10809.27755.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/7] Move idle stat calculation into rebalance_tick()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-27 15:43:45.467245352 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-27 15:45:30.794096498 -0500
@@ -2849,10 +2849,16 @@ static void update_load(struct rq *this_
  * Balancing parameters are set up in arch_init_sched_domains.
  */
 static void
-rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
+rebalance_tick(int this_cpu, struct rq *this_rq)
 {
 	unsigned long interval;
 	struct sched_domain *sd;
+	/*
+	 * A task is idle if this is the idle queue
+	 * and we have no runnable task
+	 */
+	enum idle_type idle = (this_rq->idle && !this_rq->nr_running) ?
+				SCHED_IDLE : NOT_IDLE;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2884,37 +2890,26 @@ rebalance_tick(int this_cpu, struct rq *
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
@@ -3130,20 +3125,20 @@ void scheduler_tick(void)
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
