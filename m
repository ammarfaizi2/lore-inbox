Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUKBUTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUKBUTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUKBUTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:19:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:12968 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261408AbUKBURo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:17:44 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: kenneth.w.chen@intel.com, kernel@kolivas.org, ricklind@us.ibm.com,
       Nick Piggin <nickpiggin@yahoo.com.au>, mingo@elte.hu
Subject: [RFC][PATCH] sched: aggressive idle balance
Date: Tue, 2 Nov 2004 15:16:38 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ms+hBlfI56zjV46"
Message-Id: <200411021416.38119.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ms+hBlfI56zjV46
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

This patch allows more aggressive idle balances, reducing idle time in 
scenarios where should not be any, where nr_running > nr_cpus.  We have seen 
this in a couple of online transaction workloads.  Three areas are targeted:

1) In try_to_wake_up(), wake_idle() is called to move the task to a sibling if 
the task->cpu is busy and the sibling is idle.  This has been expanded to any 
idle cpu, but the closest idle cpu is picked first by starting with cpu->sd, 
then going up the domains as necessary.

2) can_migrate() is modified.  Honestly part of it looked kind of backwards.  
We checked for task_hot() if the cpu was idle.  I would think we would do 
that if is was -not- idle.  Changes to can migrate are:
  a) same policies for running tasks and cpus_allowed, return 0
  b) We omit task_hot check for -whole- idle cpus (not just a sibling),
     when task_cpu(p) and this_cpu are member siblings in the same core,
     or when nr_balance_failed > cache_nice_tries
  c) finally, if this_cpu is busy we still do the task_hot check

3) Add SD_BALANCE_NEWIDLE to SD_NODE_INIT.  All this does is allow a newly 
idle cpu a broader span of cpus, only if necessary, to pull a task.  We still 
target cpus closest to the this_cpu, starting with this_cpu->sd, then as 
needed moving up the domains.  **This is vital for Opteron, where each node 
only has one cpu.  idle_balance() never works because it would never consider 
looking beyond the cpu->sd, because cpu->sd->sd did not have 
SD_BALANCE_NEWIDLE set.

So far we have seen 3-5% with these patches on online transaction workolads 
and no regressions on SDET.  Kenneth, I am particularly interested in using 
this with your increased cache_hot_time value, where you got your best 
throughput:

> cache_hot_time  | workload throughput
> --------------------------------------
> 25ms            - 111.1   (5% idle)

...but still had idle time.  Do you think you could try these patches with 
your 25ms cache_hot_time?  I think your workload could benefit from both the 
longer cache_hot_time for busy cpus, but more aggressive idle balances, 
hopefully driving your workload to 100% cpu utilization.

Any feedback greatly appreciated, thanks.

-Andrew Theurer


--Boundary-00=_ms+hBlfI56zjV46
Content-Type: text/x-diff;
  charset="us-ascii";
  name="idle-balance-patch-2610rc1bk9"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="idle-balance-patch-2610rc1bk9"

diff -Naurp linux-2.6.10-rc1-bk9/include/asm-i386/topology.h linux-2.6.10-rc1-bk9-idle/include/asm-i386/topology.h
--- linux-2.6.10-rc1-bk9/include/asm-i386/topology.h	2004-11-02 18:06:26.000000000 -0800
+++ linux-2.6.10-rc1-bk9-idle/include/asm-i386/topology.h	2004-11-02 18:18:15.000000000 -0800
@@ -83,6 +83,8 @@ static inline cpumask_t pcibus_to_cpumas
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
diff -Naurp linux-2.6.10-rc1-bk9/include/asm-ia64/topology.h linux-2.6.10-rc1-bk9-idle/include/asm-ia64/topology.h
--- linux-2.6.10-rc1-bk9/include/asm-ia64/topology.h	2004-11-02 18:06:26.000000000 -0800
+++ linux-2.6.10-rc1-bk9-idle/include/asm-ia64/topology.h	2004-11-02 18:18:15.000000000 -0800
@@ -56,6 +56,8 @@ void build_cpu_to_node_map(void);
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
diff -Naurp linux-2.6.10-rc1-bk9/include/asm-ppc64/topology.h linux-2.6.10-rc1-bk9-idle/include/asm-ppc64/topology.h
--- linux-2.6.10-rc1-bk9/include/asm-ppc64/topology.h	2004-11-02 18:06:26.000000000 -0800
+++ linux-2.6.10-rc1-bk9-idle/include/asm-ppc64/topology.h	2004-11-02 18:18:15.000000000 -0800
@@ -51,6 +51,8 @@ static inline int node_to_first_cpu(int 
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
diff -Naurp linux-2.6.10-rc1-bk9/include/asm-x86_64/topology.h linux-2.6.10-rc1-bk9-idle/include/asm-x86_64/topology.h
--- linux-2.6.10-rc1-bk9/include/asm-x86_64/topology.h	2004-11-02 18:06:26.000000000 -0800
+++ linux-2.6.10-rc1-bk9-idle/include/asm-x86_64/topology.h	2004-11-02 18:18:15.000000000 -0800
@@ -46,7 +46,9 @@ static inline cpumask_t __pcibus_to_cpum
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
+				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
diff -Naurp linux-2.6.10-rc1-bk9/include/linux/topology.h linux-2.6.10-rc1-bk9-idle/include/linux/topology.h
--- linux-2.6.10-rc1-bk9/include/linux/topology.h	2004-11-02 18:06:26.000000000 -0800
+++ linux-2.6.10-rc1-bk9-idle/include/linux/topology.h	2004-11-02 18:17:21.000000000 -0800
@@ -120,6 +120,7 @@ static inline int __next_node_with_cpus(
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\
+				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
diff -Naurp linux-2.6.10-rc1-bk9/kernel/sched.c linux-2.6.10-rc1-bk9-idle/kernel/sched.c
--- linux-2.6.10-rc1-bk9/kernel/sched.c	2004-11-02 18:06:47.000000000 -0800
+++ linux-2.6.10-rc1-bk9-idle/kernel/sched.c	2004-11-02 18:22:32.000000000 -0800
@@ -441,6 +441,31 @@ static inline void rq_unlock(runqueue_t 
 	spin_unlock_irq(&rq->lock);
 }
 
+#ifdef CONFIG_SCHED_SMT
+static int cpu_and_siblings_are_idle(int cpu)
+{
+	int sib;
+	for_each_cpu_mask(sib, cpu_sibling_map[cpu]) {
+		if (idle_cpu(sib))
+			continue;
+		return 0;
+	}
+
+	return 1;
+}
+
+static inline int cpus_are_siblings(int cpu1, int cpu2)
+{
+        cpumask_t tmp;
+        cpus_and(tmp, cpu_sibling_map[cpu1], cpu_sibling_map[cpu2]);
+        return cpus_weight(tmp);
+}
+#else
+#define cpus_are_siblings(A, B) (0)
+#define cpu_and_siblings_are_idle(A) idle_cpu(A)
+#endif
+
+
 #ifdef CONFIG_SCHEDSTATS
 /*
  * Called when a process is dequeued from the active array and given
@@ -923,9 +948,10 @@ static inline unsigned long target_load(
 #endif
 
 /*
- * wake_idle() is useful especially on SMT architectures to wake a
- * task onto an idle sibling if we would otherwise wake it onto a
- * busy sibling.
+ * wake_idle() will wake a task on an idle cpu if task->cpu is
+ * not idle and an idle cpu is available.  The span of cpus to
+ * search starts with cpus closest then further out as needed,
+ * so we always favor a closer, idle cpu.
  *
  * Returns the CPU we should wake onto.
  */
@@ -933,24 +959,23 @@ static inline unsigned long target_load(
 static int wake_idle(int cpu, task_t *p)
 {
 	cpumask_t tmp;
-	runqueue_t *rq = cpu_rq(cpu);
 	struct sched_domain *sd;
 	int i;
 
 	if (idle_cpu(cpu))
 		return cpu;
 
-	sd = rq->sd;
-	if (!(sd->flags & SD_WAKE_IDLE))
-		return cpu;
-
-	cpus_and(tmp, sd->span, p->cpus_allowed);
-
-	for_each_cpu_mask(i, tmp) {
-		if (idle_cpu(i))
-			return i;
+	for_each_domain(cpu, sd) {
+		if (sd->flags & SD_WAKE_IDLE) {
+			cpus_and(tmp, sd->span, cpu_online_map);
+			cpus_and(tmp, tmp, p->cpus_allowed);
+			for_each_cpu_mask(i, tmp) {
+				if (idle_cpu(i))
+					return i;
+			}
+		}
+		else break;
 	}
-
 	return cpu;
 }
 #else
@@ -1062,7 +1087,7 @@ static int try_to_wake_up(task_t * p, un
 out_set_cpu:
 	schedstat_inc(rq, ttwu_attempts);
 	new_cpu = wake_idle(new_cpu, p);
-	if (new_cpu != cpu && cpu_isset(new_cpu, p->cpus_allowed)) {
+	if (new_cpu != cpu) {
 		schedstat_inc(rq, ttwu_moved);
 		set_task_cpu(p, new_cpu);
 		task_rq_unlock(rq, &flags);
@@ -1637,13 +1662,20 @@ int can_migrate_task(task_t *p, runqueue
 	if (!cpu_isset(this_cpu, p->cpus_allowed))
 		return 0;
 
-	/* Aggressive migration if we've failed balancing */
-	if (idle == NEWLY_IDLE ||
-			sd->nr_balance_failed < sd->cache_nice_tries) {
-		if (task_hot(p, rq->timestamp_last_tick, sd))
-			return 0;
-	}
+	/* 
+	 * Aggressive migration allowed if:
+	 * 1) the [whole] cpu is idle, or
+	 * 2) too many balance attempts have failed, or
+	 * 3) both cpus are siblings in the same core
+	 */
+
+	if (cpu_and_siblings_are_idle(this_cpu) || \
+			sd->nr_balance_failed > sd->cache_nice_tries || \
+			cpus_are_siblings(this_cpu, task_cpu(p)))
+		return 1;
 
+	if (task_hot(p, rq->timestamp_last_tick, sd))
+			return 0;
 	return 1;
 }
 
@@ -2058,23 +2090,6 @@ static inline void idle_balance(int this
 	}
 }
 
-#ifdef CONFIG_SCHED_SMT
-static int cpu_and_siblings_are_idle(int cpu)
-{
-	int sib;
-	for_each_cpu_mask(sib, cpu_sibling_map[cpu]) {
-		if (idle_cpu(sib))
-			continue;
-		return 0;
-	}
-
-	return 1;
-}
-#else
-#define cpu_and_siblings_are_idle(A) idle_cpu(A)
-#endif
-
-
 /*
  * active_load_balance is run by migration threads. It pushes running tasks
  * off the busiest CPU onto idle CPUs. It requires at least 1 task to be

--Boundary-00=_ms+hBlfI56zjV46--

