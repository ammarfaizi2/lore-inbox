Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTG1TOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270490AbTG1TOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:14:47 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:47838 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S270486AbTG1TOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:14:41 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: [patch] scheduler fix for 1cpu/node case
Date: Mon, 28 Jul 2003 21:16:46 +0200
User-Agent: KMail/1.5.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org
MIME-Version: 1.0
Message-Id: <200307280548.53976.efocht@gmx.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eaXJ/L/tFObG8aS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_eaXJ/L/tFObG8aS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

after talking to several people at OLS about the current NUMA
scheduler the conclusion was:
(1) it sucks (for particular workloads),
(2) on x86_64 (embarassingly simple NUMA) it's useless, goto (1).

Fact is that the current separation of local and global balancing,
where global balancing is done only in the timer interrupt at a fixed
rate is way too unflexible. A CPU going idle inside a well balanced
node will stay idle for a while even if there's a lot of work to
do. Especially in the corner case of one CPU per node this is
condemning that CPU to idleness for at least 5 ms. So x86_64 platforms
(but not only those!) suffer and whish to switch off the NUMA
scheduler while keeping NUMA memory management on.

The attached patch is a simple solution which
- solves the 1 CPU / node problem,
- lets other systems behave (almost) as before,
- opens the way to other optimisations like multi-level node
  hierarchies (by tuning the retry rate)
- simpifies the NUMA scheduler and deletes more lines of code than it
  adds.

The timer interrupt based global rebalancing might appear to be a
simple and good idea but it takes the scheduler a lot of
flexibility. In the patch the global rebalancing is done after a
certain number of failed attempts to locally balance. The number of
attempts is proportional to the number of CPUs in the current
node. For only 1 CPU in the current node the scheduler doesn't even
try to balance locally, it wouldn't make sense anyway. Of course one
could instead set IDLE_NODE_REBALANCE_TICK = IDLE_REBALANCE_TICK, but
this is more ugly (IMHO) and only helps when all nodes have 1 CPU /
node.

Please consider this for inclusion.

Thanks,
Erich




--Boundary-00=_eaXJ/L/tFObG8aS
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="1cpufix-lb-2.6.0t1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="1cpufix-lb-2.6.0t1.patch"

diff -urNp 2.6.0t1/kernel/sched.c 2.6.0t1-1cpufix/kernel/sched.c
--- 2.6.0t1/kernel/sched.c	2003-07-14 05:37:14.000000000 +0200
+++ 2.6.0t1-1cpufix/kernel/sched.c	2003-07-28 05:32:28.000000000 +0200
@@ -164,6 +164,7 @@ struct runqueue {
 	prio_array_t *active, *expired, arrays[2];
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
+	unsigned int nr_lb_failed;
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
 #endif
@@ -856,6 +857,35 @@ static int find_busiest_node(int this_no
 	return node;
 }
 
+/*
+ * Decide whether the scheduler should balance locally (inside the same node)
+ * or globally depending on the number of failed local balance attempts.
+ * The number of failed local balance attempts depends on the number of cpus
+ * in the current node. In case it's just one, go immediately for global
+ * balancing. On a busy cpu the number of retries is smaller.
+ */
+static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
+{
+	int node, retries, this_node = cpu_to_node(this_cpu);
+
+	retries = nr_cpus_node(this_node) - 1;
+	if (this_rq->curr != this_rq->idle)
+		retries >>= 1;
+	if (this_rq->nr_lb_failed >= retries) {
+		node = find_busiest_node(this_node);
+		this_rq->nr_lb_failed = 0;
+		if (node >= 0)
+			return (node_to_cpu_mask(node) | (1UL << this_cpu));
+	}
+	return node_to_cpu_mask(this_node);
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
@@ -960,6 +990,12 @@ static inline runqueue_t *find_busiest_q
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
 
@@ -995,7 +1031,7 @@ static inline void pull_task(runqueue_t 
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle, unsigned long cpumask)
+static void load_balance(runqueue_t *this_rq, int idle)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -1003,7 +1039,8 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+				     cpus_to_balance(this_cpu, this_rq));
 	if (!busiest)
 		goto out;
 
@@ -1085,29 +1122,9 @@ out:
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
@@ -1119,24 +1136,16 @@ static void rebalance_tick(runqueue_t *t
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
@@ -1306,7 +1315,7 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
-		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
+		load_balance(rq, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif

--Boundary-00=_eaXJ/L/tFObG8aS--

