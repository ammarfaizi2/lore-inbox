Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTAQRPK>; Fri, 17 Jan 2003 12:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbTAQRPJ>; Fri, 17 Jan 2003 12:15:09 -0500
Received: from franka.aracnet.com ([216.99.193.44]:44747 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267615AbTAQRPE>; Fri, 17 Jan 2003 12:15:04 -0500
Date: Fri, 17 Jan 2003 09:23:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <295750000.1042824212@titus>
In-Reply-To: <200301171535.21226.efocht@ess.nec.de>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <200301171535.21226.efocht@ess.nec.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like the cleanup of the topology.h. 

And the rest of Ingo's second version:

diff -urpN -X /home/fletch/.diff.exclude ingo-A/kernel/sched.c ingo-B/kernel/sched.c
--- ingo-A/kernel/sched.c	Fri Jan 17 09:18:32 2003
+++ ingo-B/kernel/sched.c	Fri Jan 17 09:19:42 2003
@@ -153,10 +153,9 @@ struct runqueue {
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
-	int prev_nr_running[NR_CPUS];
+	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
-	unsigned int nr_balanced;
 	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
@@ -765,29 +764,6 @@ static int find_busiest_node(int this_no
 	return node;
 }
 
-static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
-{
-	int this_node = __cpu_to_node(this_cpu);
-	/*
-	 * Avoid rebalancing between nodes too often.
-	 * We rebalance globally once every NODE_BALANCE_RATE load balances.
-	 */
-	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
-		int node = find_busiest_node(this_node);
-		this_rq->nr_balanced = 0;
-		if (node >= 0)
-			return (__node_to_cpu_mask(node) | (1UL << this_cpu));
-	}
-	return __node_to_cpu_mask(this_node);
-}
-
-#else /* !CONFIG_NUMA */
-
-static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
-{
-	return cpu_online_map;
-}
-
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -807,10 +783,10 @@ static inline unsigned int double_lock_b
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
 			/* Need to recalculate nr_running */
-			if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+			if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
 				nr_running = this_rq->nr_running;
 			else
-				nr_running = this_rq->prev_nr_running[this_cpu];
+				nr_running = this_rq->prev_cpu_load[this_cpu];
 		} else
 			spin_lock(&busiest->lock);
 	}
@@ -847,10 +823,10 @@ static inline runqueue_t *find_busiest_q
 	 * that case we are less picky about moving a task across CPUs and
 	 * take what can be taken.
 	 */
-	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+	if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
 		nr_running = this_rq->nr_running;
 	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
+		nr_running = this_rq->prev_cpu_load[this_cpu];
 
 	busiest = NULL;
 	max_load = 1;
@@ -859,11 +835,11 @@ static inline runqueue_t *find_busiest_q
 			continue;
 
 		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+		if (idle || (rq_src->nr_running < this_rq->prev_cpu_load[i]))
 			load = rq_src->nr_running;
 		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
+			load = this_rq->prev_cpu_load[i];
+		this_rq->prev_cpu_load[i] = rq_src->nr_running;
 
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;
@@ -922,7 +898,7 @@ static inline void pull_task(runqueue_t 
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle)
+static void load_balance(runqueue_t *this_rq, int idle, unsigned long cpumask)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -930,8 +906,7 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
-					cpus_to_balance(this_cpu, this_rq));
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
 	if (!busiest)
 		goto out;
 
@@ -1006,21 +981,75 @@ out:
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=100, every 10 msecs.)
+ *
+ * On NUMA, do a node-rebalance every 400 msecs.
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
+#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 2)
+#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
 
-static inline void idle_tick(runqueue_t *rq)
+#if CONFIG_NUMA
+static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
 {
-	if (jiffies % IDLE_REBALANCE_TICK)
-		return;
-	spin_lock(&rq->lock);
-	load_balance(rq, 1);
-	spin_unlock(&rq->lock);
+	int node = find_busiest_node(__cpu_to_node(this_cpu));
+	unsigned long cpumask, this_cpumask = 1UL << this_cpu;
+
+	if (node >= 0) {
+		cpumask = __node_to_cpu_mask(node) | this_cpumask;
+		spin_lock(&this_rq->lock);
+		load_balance(this_rq, idle, cpumask);
+		spin_unlock(&this_rq->lock);
+	}
 }
+#endif
 
+static void rebalance_tick(runqueue_t *this_rq, int idle)
+{
+#if CONFIG_NUMA
+	int this_cpu = smp_processor_id();
+#endif
+	unsigned long j = jiffies;
+
+	/*
+	 * First do inter-node rebalancing, then intra-node rebalancing,
+	 * if both events happen in the same tick. The inter-node
+	 * rebalancing does not necessarily have to create a perfect
+	 * balance within the node, since we load-balance the most loaded
+	 * node with the current CPU. (ie. other CPUs in the local node
+	 * are not balanced.)
+	 */
+	if (idle) {
+#if CONFIG_NUMA
+		if (!(j % IDLE_NODE_REBALANCE_TICK))
+			balance_node(this_rq, idle, this_cpu);
+#endif
+		if (!(j % IDLE_REBALANCE_TICK)) {
+			spin_lock(&this_rq->lock);
+			load_balance(this_rq, 0, __cpu_to_node_mask(this_cpu));
+			spin_unlock(&this_rq->lock);
+		}
+		return;
+	}
+#if CONFIG_NUMA
+	if (!(j % BUSY_NODE_REBALANCE_TICK))
+		balance_node(this_rq, idle, this_cpu);
+#endif
+	if (!(j % BUSY_REBALANCE_TICK)) {
+		spin_lock(&this_rq->lock);
+		load_balance(this_rq, idle, __cpu_to_node_mask(this_cpu));
+		spin_unlock(&this_rq->lock);
+	}
+}
+#else
+/*
+ * on UP we do not need to balance between CPUs:
+ */
+static inline void rebalance_tick(runqueue_t *this_rq, int idle)
+{
+}
 #endif
 
 DEFINE_PER_CPU(struct kernel_stat, kstat) = { { 0 } };
@@ -1063,9 +1092,7 @@ void scheduler_tick(int user_ticks, int 
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
-#if CONFIG_SMP
-		idle_tick(rq);
-#endif
+		rebalance_tick(rq, 1);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
@@ -1121,11 +1148,8 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->active);
 	}
 out:
-#if CONFIG_SMP
-	if (!(jiffies % BUSY_REBALANCE_TICK))
-		load_balance(rq, 0);
-#endif
 	spin_unlock(&rq->lock);
+	rebalance_tick(rq, 0);
 }
 
 void scheduling_functions_start_here(void) { }
@@ -1184,7 +1208,7 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
-		load_balance(rq, 1);
+		load_balance(rq, 1, __cpu_to_node_mask(smp_processor_id()));
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif

