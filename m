Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTHXRRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 13:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTHXRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 13:17:30 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:20652 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S261258AbTHXRRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 13:17:25 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Andi Kleen <ak@muc.de>, mingo@elte.hu
Subject: [patch 2.6.0t4] 1 cpu/node scheduler fix
Date: Sun, 24 Aug 2003 19:13:24 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0IPS/ZZ91GujX7u"
Message-Id: <200308241913.24699.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0IPS/ZZ91GujX7u
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is the 1 cpu/node fix of the NUMA scheduler rewritten for the new
cpumask handling. The previous version was a bit too aggressive with
cross node balancing so I changed the default timings a bit such that
the behavior is very similar to the old one.

Here is what the patch does:
- Links the frequency of cross-node balances to the number of failed
local balance attempts. This simplifies the code by removing the too
rigid cross-node balancing dependency of the timer interrupts.

- Fixes the 1 CPU/node issue, i.e. eliminates local balance attempts
for the nodes which have only one CPU. Can happen on any NUMA
platform (playing around with a 2 CPU/node box and have a flaky CPU,
so I have sometimes a node with only one CPU), is a major issue on
AMD64.

- Makes the cross-node balance frequency tunable by the parameter
NUMA_FACTOR_BONUS. Its default setting is such that the scheduler
behaves like before: cross node balance every 5 local node balances on
an idle CPU, every 2 local node balances on a busy CPU. This parameter
should be tuned for each platform depending on its NUMA factor.

This simple patch is not meant as opposition to Andrew's attempt to
NUMAize the whole scheduler. That one will definitely make NUMA
coders' lives easier but I fear that it is a bit too complex for
2.6. The attached small incremental change is sufficient to solve the
main problem. Besides, the change of the cross-node scheduling is
compatible with Andrew's scheduler structure. I really don't like the
timer-based cross-node balancing because it is too unflexible (no way
to have different balancing intervals for each node) and I'd really
like to get back to just one single point of entry for load balancing:
the routine load_balance(), no matter whether we balance inside a
timer interrupt or while the CPU is going idle.

Erich



--Boundary-00=_0IPS/ZZ91GujX7u
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="1cpufix-2.6.0t4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="1cpufix-2.6.0t4.patch"

diff -urNp 2.6.0-test4/include/linux/topology.h 2.6.0-test4-1cpuf/include/linux/topology.h
--- 2.6.0-test4/include/linux/topology.h	2003-08-23 01:57:55.000000000 +0200
+++ 2.6.0-test4-1cpuf/include/linux/topology.h	2003-08-23 19:29:15.000000000 +0200
@@ -54,4 +54,13 @@ static inline int __next_node_with_cpus(
 #define for_each_node_with_cpus(node) \
 	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
 
+#ifndef NUMA_FACTOR_BONUS
+/*
+ * High NUMA_FACTOR_BONUS means rare cross-node load balancing. The default
+ * value of 3 means idle_node_rebalance after 5 (failed) local balances,
+ * busy_node_rebalance after 2 failed local balances. Should be tuned for
+ * each platform in asm/topology.h.
+ */
+#define NUMA_FACTOR_BONUS 3
+#endif
 #endif /* _LINUX_TOPOLOGY_H */
diff -urNp 2.6.0-test4/kernel/sched.c 2.6.0-test4-1cpuf/kernel/sched.c
--- 2.6.0-test4/kernel/sched.c	2003-08-23 01:58:43.000000000 +0200
+++ 2.6.0-test4-1cpuf/kernel/sched.c	2003-08-23 21:07:34.000000000 +0200
@@ -164,6 +164,7 @@ struct runqueue {
 	prio_array_t *active, *expired, arrays[2];
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
+	unsigned int nr_lb_failed;
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
 #endif
@@ -873,6 +874,45 @@ static int find_busiest_node(int this_no
 	return node;
 }
 
+/*
+ * Decide whether the scheduler should balance locally (inside the same node)
+ * or globally depending on the number of failed local balance attempts.
+ * The number of failed local balance attempts depends on the number of cpus
+ * in the current node. In case it's just one, go immediately for global
+ * balancing. On a busy cpu the number of retries is smaller.
+ * NUMA_FACTOR_BONUS can be used to tune the frequency of global load
+ * balancing (in topology.h).
+ */
+static inline cpumask_t cpus_to_balance(int this_cpu, runqueue_t *this_rq)
+{
+	int node, retries, this_node = cpu_to_node(this_cpu);
+
+	if (nr_cpus_node(this_node) == 1) {
+		retries = 0;
+	} else {
+		retries = 2 + NUMA_FACTOR_BONUS;
+		/* less retries for busy CPUs */
+		if (this_rq->curr != this_rq->idle)
+			retries >>= 1;
+	}
+	if (this_rq->nr_lb_failed >= retries) {
+		node = find_busiest_node(this_node);
+		this_rq->nr_lb_failed = 0;
+		if (node >= 0) {
+			cpumask_t cpumask = node_to_cpumask(node);
+			cpu_set(this_cpu, cpumask);
+			return cpumask;
+		}
+	}
+	return node_to_cpumask(this_node);
+}
+
+#else /* !CONFIG_NUMA */
+
+static inline cpumask_t cpus_to_balance(int this_cpu, runqueue_t *this_rq)
+{
+	return cpu_online_map;
+}
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SMP
@@ -977,6 +1017,12 @@ static inline runqueue_t *find_busiest_q
 		busiest = NULL;
 	}
 out:
+#ifdef CONFIG_NUMA
+	if (!busiest)
+		this_rq->nr_lb_failed++;
+	else
+		this_rq->nr_lb_failed = 0;
+#endif
 	return busiest;
 }
 
@@ -1012,7 +1058,7 @@ static inline void pull_task(runqueue_t 
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle, cpumask_t cpumask)
+static void load_balance(runqueue_t *this_rq, int idle)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -1020,7 +1066,8 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+				     cpus_to_balance(this_cpu, this_rq));
 	if (!busiest)
 		goto out;
 
@@ -1102,29 +1149,9 @@ out:
  */
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 #define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
-#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 5)
-#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
-
-#ifdef CONFIG_NUMA
-static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
-{
-	int node = find_busiest_node(cpu_to_node(this_cpu));
-
-	if (node >= 0) {
-		cpumask_t cpumask = node_to_cpumask(node);
-		cpu_set(this_cpu, cpumask);
-		spin_lock(&this_rq->lock);
-		load_balance(this_rq, idle, cpumask);
-		spin_unlock(&this_rq->lock);
-	}
-}
-#endif
 
 static void rebalance_tick(runqueue_t *this_rq, int idle)
 {
-#ifdef CONFIG_NUMA
-	int this_cpu = smp_processor_id();
-#endif
 	unsigned long j = jiffies;
 
 	/*
@@ -1136,24 +1163,16 @@ static void rebalance_tick(runqueue_t *t
 	 * are not balanced.)
 	 */
 	if (idle) {
-#ifdef CONFIG_NUMA
-		if (!(j % IDLE_NODE_REBALANCE_TICK))
-			balance_node(this_rq, idle, this_cpu);
-#endif
 		if (!(j % IDLE_REBALANCE_TICK)) {
 			spin_lock(&this_rq->lock);
-			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
+			load_balance(this_rq, idle);
 			spin_unlock(&this_rq->lock);
 		}
 		return;
 	}
-#ifdef CONFIG_NUMA
-	if (!(j % BUSY_NODE_REBALANCE_TICK))
-		balance_node(this_rq, idle, this_cpu);
-#endif
 	if (!(j % BUSY_REBALANCE_TICK)) {
 		spin_lock(&this_rq->lock);
-		load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
+		load_balance(this_rq, idle);
 		spin_unlock(&this_rq->lock);
 	}
 }
@@ -1331,7 +1350,7 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
-		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
+		load_balance(rq, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif

--Boundary-00=_0IPS/ZZ91GujX7u--

