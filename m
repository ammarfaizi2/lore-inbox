Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274976AbTHPXIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274977AbTHPXIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:08:11 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:46479 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S274976AbTHPXH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:07:59 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: scheduler fix / cross node balancer change
Date: Sun, 17 Aug 2003 01:11:22 +0200
User-Agent: KMail/1.5.1
Cc: LSE <lse-tech@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aorP/rMMd3etVjy"
Message-Id: <200308170111.22946.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_aorP/rMMd3etVjy
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A new attempt to fix the 1 CPU per node problem of the current NUMA
scheduler. The previous version was a bit too aggressive with cross
node balancing.

This patch:
- links the frequency of cross-node balances to the number of failed
local balance attempts while simplifying the code,
- fixes the 1 CPU/node issue, i.e. eliminates local balance attempts
for the nodes which have only one CPU. Can happen on any NUMA
platform, is a major issue on x86_64.
- makes the cross-node balance frequency tunable by the parameter
NUMA_FACTOR_BONUS. Its default setting is such that the scheduler
behaves like before: cross node balance every 5 local node balances on
an idle CPU, every 2 local node balances on a busy CPU. This parameter
should be tuned for each platform depending on its NUMA factor.

Regards,
Erich





--Boundary-00=_aorP/rMMd3etVjy
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="1cpufix-lb5-2.6.0t3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="1cpufix-lb5-2.6.0t3.patch"

diff -urNp 2.6.0-test3/include/linux/topology.h 2.6.0-test3-1cpuf/include/linux/topology.h
--- 2.6.0-test3/include/linux/topology.h	2003-08-09 06:38:46.000000000 +0200
+++ 2.6.0-test3-1cpuf/include/linux/topology.h	2003-08-17 00:51:13.000000000 +0200
@@ -48,4 +48,13 @@ static inline int __next_node_with_cpus(
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
diff -urNp 2.6.0-test3/kernel/sched.c 2.6.0-test3-1cpuf/kernel/sched.c
--- 2.6.0-test3/kernel/sched.c	2003-08-09 06:39:35.000000000 +0200
+++ 2.6.0-test3-1cpuf/kernel/sched.c	2003-08-17 00:46:56.000000000 +0200
@@ -164,6 +164,7 @@ struct runqueue {
 	prio_array_t *active, *expired, arrays[2];
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
+	unsigned int nr_lb_failed;
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
 #endif
@@ -856,6 +857,42 @@ static int find_busiest_node(int this_no
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
+static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
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
+		if (node >= 0)
+			return (node_to_cpumask(node) | (1UL << this_cpu));
+	}
+	return node_to_cpumask(this_node);
+}
+
+#else /* !CONFIG_NUMA */
+
+static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
+{
+	return cpu_online_map;
+}
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SMP
@@ -960,6 +997,12 @@ static inline runqueue_t *find_busiest_q
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
 
@@ -995,7 +1038,7 @@ static inline void pull_task(runqueue_t 
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle, unsigned long cpumask)
+static void load_balance(runqueue_t *this_rq, int idle)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -1003,7 +1046,8 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+				     cpus_to_balance(this_cpu, this_rq));
 	if (!busiest)
 		goto out;
 
@@ -1085,29 +1129,9 @@ out:
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
-	unsigned long cpumask, this_cpumask = 1UL << this_cpu;
-
-	if (node >= 0) {
-		cpumask = node_to_cpumask(node) | this_cpumask;
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
@@ -1119,24 +1143,16 @@ static void rebalance_tick(runqueue_t *t
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
@@ -1308,7 +1324,7 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
-		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
+		load_balance(rq, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif

--Boundary-00=_aorP/rMMd3etVjy--

