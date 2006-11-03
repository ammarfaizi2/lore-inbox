Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753530AbWKCUrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbWKCUrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWKCUrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:47:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60597 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753530AbWKCUrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:47:04 -0500
Date: Fri, 3 Nov 2006 12:47:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204701.15739.21200.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
References: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/7] Move idle stat calculation into rebalance_tick()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perform the idle state determination in rebalance tick.

If we separate balancing from sched_tick then we also need
to determine the idle state in rebalance_tick.

V2->V3
	Remove useless idlle != 0 check. Checking nr_running seems
	to be sufficient. Thanks Suresh.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-03 12:53:23.254849673 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-03 12:54:30.683565162 -0600
@@ -2850,10 +2850,16 @@ static void update_load(struct rq *this_
  * Balancing parameters are set up in arch_init_sched_domains.
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
@@ -2885,37 +2891,26 @@ rebalance_tick(int this_cpu, struct rq *
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
@@ -3131,20 +3126,20 @@ void scheduler_tick(void)
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
