Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274899AbTGaVpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274883AbTGaVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:44:38 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:12522 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S269685AbTGaVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:42:24 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Date: Thu, 31 Jul 2003 23:45:36 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>
References: <200307280548.53976.efocht@gmx.net> <59140000.1059663916@[10.10.2.4]>
In-Reply-To: <59140000.1059663916@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A4YK/AwQ85SoZT0"
Message-Id: <200307312345.36368.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_A4YK/AwQ85SoZT0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 31 July 2003 17:05, Martin J. Bligh wrote:
> you're using node_to_cpu_mask for ia64 ... others were using
> node_to_cpumask (1 less "_"), so this doesn't build ...

Ooops, you're right, of course. Sorry about this mistake :-(

Erich




--Boundary-00=_A4YK/AwQ85SoZT0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="1cpufix-lb2-2.6.0t1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="1cpufix-lb2-2.6.0t1.patch"

diff -urNp 2.6.0t1/kernel/sched.c 2.6.0t1-1cpufix/kernel/sched.c
--- 2.6.0t1/kernel/sched.c	2003-07-14 05:37:14.000000000 +0200
+++ 2.6.0t1-1cpufix/kernel/sched.c	2003-07-31 20:46:30.000000000 +0200
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

--Boundary-00=_A4YK/AwQ85SoZT0--

