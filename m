Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTHVPtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbTHVPtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:49:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:944 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263316AbTHVPtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:49:03 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Date: Fri, 22 Aug 2003 10:46:31 -0500
User-Agent: KMail/1.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org
References: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XrjR/L+0IcK32A2"
Message-Id: <200308221046.31662.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XrjR/L+0IcK32A2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 13 August 2003 15:49, Bill Davidsen wrote:
> On Mon, 28 Jul 2003, Andrew Theurer wrote:
> > Personally, I'd like to see all systems use NUMA sched, non NUMA systems
> > being a single node (no policy difference from non-numa sched), allowing
> > us to remove all NUMA ifdefs.  I think the code would be much more
> > readable.
>
> That sounds like a great idea, but I'm not sure it could be realized short
> of a major rewrite. Look how hard Ingo and Con are working just to get a
> single node doing a good job with interactive and throughput tradeoffs.

Actually it's not too bad.  Attached is a patch to do it.  It also does 
multi-level node support and makes all the load balance routines 
runqueue-centric instead of cpu-centric, so adding something like shared 
runqueues (for HT) should be really easy.  Hmm, other things: inter-node 
balance intervals are now arch specific (AMD is "1").  The default busy/idle 
balance timers of 200/1 are not arch specific, but I'm thinking they should 
be.  And for non-numa, the scheduling policy is the same as it was with 
vanilla O(1). 

> Once they get a good handle on identifying process behaviour, and I
> believe they will, that information could be used in improving NUMA
> performance, by sending not just 'a job" but "the right job" if it exists.
> I'm sure there are still a few graduate theses possible on the topic!

I do agree, but I think _what_ we pick is definitely 2.7 work.  All I'd like 
to see for 2.6 is a very nice, unified framework to build on.

As for 1cpu/node case I think this second patch (on top of first) will take 
care of it; however I have not had a chance to test on AMD yet.

-Andrew Theurer

--Boundary-00=_XrjR/L+0IcK32A2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-numasched2.260-test3-bk8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-numasched2.260-test3-bk8"

diff -Naurp linux-2.6.0-test3-bk8-numasched/kernel/sched.c linux-2.6.0-test3-bk8-numasched2/kernel/sched.c
--- linux-2.6.0-test3-bk8-numasched/kernel/sched.c	2003-08-22 12:03:30.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched2/kernel/sched.c	2003-08-22 12:14:09.000000000 -0500
@@ -1261,7 +1261,7 @@ static void rebalance_tick(runqueue_t *t
 
 	if (idle) {
 		while (node) {
-			if (!(j % node->idle_rebalance_tick))
+			if (!(j % node->idle_rebalance_tick) && (node->nr_cpus > 1))
 				balance_node(this_rq, idle, last_node, node);
 			last_node = node;
 			node = node->parent_node;
@@ -1269,7 +1269,7 @@ static void rebalance_tick(runqueue_t *t
 		return;
 	}
 	while (node) {
-		if (!(j % node->busy_rebalance_tick))
+		if (!(j % node->busy_rebalance_tick) && (node->nr_cpus > 1))
 			balance_node(this_rq, idle, last_node, node);
 		last_node = node;
 		node = node->parent_node;
@@ -1405,6 +1405,7 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
+	struct node_t *node;
 	int idx;
 
 	/*
@@ -1449,8 +1450,10 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
-		if (rq->node)
-			load_balance(rq, 1, rq->node);
+		node = rq->node;
+		while (node->nr_cpus < 2 && node != top_node)
+			node = node->parent_node;
+		load_balance(rq, 1, node);
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif

--Boundary-00=_XrjR/L+0IcK32A2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-numasched.260-test3-bk8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-numasched.260-test3-bk8"

diff -Naurp linux-2.6.0-test3-bk8/arch/i386/kernel/smpboot.c linux-2.6.0-test3-bk8-numasched/arch/i386/kernel/smpboot.c
--- linux-2.6.0-test3-bk8/arch/i386/kernel/smpboot.c	2003-08-21 13:17:40.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/arch/i386/kernel/smpboot.c	2003-08-21 18:34:23.000000000 -0500
@@ -504,12 +504,16 @@ cpumask_t node_2_cpu_mask[MAX_NR_NODES] 
 /* which node each logical CPU is on */
 int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
 
+/* which node each node is on */
+int node_2_node[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = MAX_NUMNODES-1 };
+
 /* set up a mapping between cpu and node. */
 static inline void map_cpu_to_node(int cpu, int node)
 {
 	printk("Mapping cpu %d to node %d\n", cpu, node);
 	cpu_set(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = node;
+	node_2_node[node] = MAX_NUMNODES-1;
 }
 
 /* undo a mapping between cpu and node. */
diff -Naurp linux-2.6.0-test3-bk8/arch/x86_64/kernel/smpboot.c linux-2.6.0-test3-bk8-numasched/arch/x86_64/kernel/smpboot.c
--- linux-2.6.0-test3-bk8/arch/x86_64/kernel/smpboot.c	2003-08-21 10:42:38.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/arch/x86_64/kernel/smpboot.c	2003-08-21 15:33:36.000000000 -0500
@@ -63,6 +63,9 @@ static cpumask_t smp_commenced_mask;
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+/* which node each node is on */
+volatile int node_2_node[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = MAX_NUMNODES-1;
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
diff -Naurp linux-2.6.0-test3-bk8/include/asm-generic/topology.h linux-2.6.0-test3-bk8-numasched/include/asm-generic/topology.h
--- linux-2.6.0-test3-bk8/include/asm-generic/topology.h	2003-08-21 10:39:24.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/include/asm-generic/topology.h	2003-08-21 15:33:36.000000000 -0500
@@ -52,8 +52,11 @@
 #endif
 
 /* Cross-node load balancing interval. */
-#ifndef NODE_BALANCE_RATE
-#define NODE_BALANCE_RATE 10
+#ifndef IDLE_NODE_BALANCE_INTERVAL
+#define IDLE_NODE_BALANCE_INTERVAL 2
+#endif
+#ifndef BUSY_NODE_BALANCE_INTERVAL
+#define BUSY_NODE_BALANCE_INTERVAL 5
 #endif
 
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -Naurp linux-2.6.0-test3-bk8/include/asm-i386/topology.h linux-2.6.0-test3-bk8-numasched/include/asm-i386/topology.h
--- linux-2.6.0-test3-bk8/include/asm-i386/topology.h	2003-08-21 10:42:40.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/include/asm-i386/topology.h	2003-08-21 15:38:09.000000000 -0500
@@ -36,6 +36,7 @@
 /* Mappings between logical cpu number and node number */
 extern cpumask_t node_2_cpu_mask[];
 extern int cpu_2_node[];
+extern int node_2_node[];
 
 /* Returns the number of the node containing CPU 'cpu' */
 static inline int cpu_to_node(int cpu)
@@ -46,9 +47,11 @@ static inline int cpu_to_node(int cpu)
 /* Returns the number of the node containing MemBlk 'memblk' */
 #define memblk_to_node(memblk) (memblk)
 
-/* Returns the number of the node containing Node 'node'.  This architecture is flat, 
-   so it is a pretty simple function! */
-#define parent_node(node) (node)
+/* Returns the number of the node containing Node 'node'. */   
+static inline int parent_node(int node)
+{
+	return node_2_node[node];
+}
 
 /* Returns a bitmask of CPUs on Node 'node'. */
 static inline cpumask_t node_to_cpumask(int node)
@@ -73,7 +76,8 @@ static inline cpumask_t pcibus_to_cpumas
 }
 
 /* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 100
+#define IDLE_NODE_BALANCE_INTERVAL 2
+#define BUSY_NODE_BALANCE_INTERVAL 5
 
 #else /* !CONFIG_NUMA */
 /*
diff -Naurp linux-2.6.0-test3-bk8/include/asm-x86_64/topology.h linux-2.6.0-test3-bk8-numasched/include/asm-x86_64/topology.h
--- linux-2.6.0-test3-bk8/include/asm-x86_64/topology.h	2003-08-21 10:42:40.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/include/asm-x86_64/topology.h	2003-08-21 15:33:36.000000000 -0500
@@ -27,7 +27,8 @@ static inline cpumask_t pcibus_to_cpumas
 	return ret;
 }
 
-#define NODE_BALANCE_RATE 30	/* CHECKME */ 
+#define IDLE_NODE_BALANCE_INTERVAL	1
+#define BUSY_NODE_BALANCE_INTERVAL	1
 
 #endif
 
diff -Naurp linux-2.6.0-test3-bk8/include/linux/sched.h linux-2.6.0-test3-bk8-numasched/include/linux/sched.h
--- linux-2.6.0-test3-bk8/include/linux/sched.h	2003-08-21 10:42:40.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/include/linux/sched.h	2003-08-21 15:33:36.000000000 -0500
@@ -498,14 +498,10 @@ static inline int set_cpus_allowed(task_
 }
 #endif
 
-#ifdef CONFIG_NUMA
+extern void numa_sched_topology_report(void);
+extern void rq_to_node_init(void);
+extern void node_to_node_init(void);
 extern void sched_balance_exec(void);
-extern void node_nr_running_init(void);
-#else
-#define sched_balance_exec()   {}
-#define node_nr_running_init() {}
-#endif
-
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -Naurp linux-2.6.0-test3-bk8/init/main.c linux-2.6.0-test3-bk8-numasched/init/main.c
--- linux-2.6.0-test3-bk8/init/main.c	2003-08-21 10:39:58.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/init/main.c	2003-08-21 15:33:36.000000000 -0500
@@ -537,11 +537,12 @@ static void do_pre_smp_initcalls(void)
 {
 	extern int spawn_ksoftirqd(void);
 #ifdef CONFIG_SMP
+	node_to_node_init();
+	rq_to_node_init();
+	numa_sched_topology_report();
 	extern int migration_init(void);
-
 	migration_init();
 #endif
-	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -Naurp linux-2.6.0-test3-bk8/kernel/sched.c linux-2.6.0-test3-bk8-numasched/kernel/sched.c
--- linux-2.6.0-test3-bk8/kernel/sched.c	2003-08-21 10:42:40.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched/kernel/sched.c	2003-08-22 12:03:30.000000000 -0500
@@ -35,12 +35,6 @@
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 
-#ifdef CONFIG_NUMA
-#define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
-#else
-#define cpu_to_node_mask(cpu) (cpu_online_map)
-#endif
-
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -76,6 +70,8 @@
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define IDLE_REBALANCE_TICK 	(HZ/1000 ?: 1)
+#define BUSY_REBALANCE_TICK 	(HZ/5 ?: 1)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -162,15 +158,13 @@ struct runqueue {
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
-	int prev_cpu_load[NR_CPUS];
-#ifdef CONFIG_NUMA
-	atomic_t *node_nr_running;
+	int id, prev_cpu_load[NR_CPUS];
+	struct node_t *node;
 	int prev_node_load[MAX_NUMNODES];
-#endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
-
 	atomic_t nr_iowait;
+	runqueue_t *next;
 };
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
@@ -189,51 +183,177 @@ static DEFINE_PER_CPU(struct runqueue, r
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
+ 
+/*
+ * This is our NUMA node struct, used heavily for load balance.
+ * Nodes may contain lists of runqueues or child_nodes.  Nodes
+ * also point to their parent_node.  These pointers allow 
+ * an arbitrary level of nested nodes.  The scheduler code should
+ * use these structs, not simple NUMA topology when interpreting 
+ * topology.  Simple NUMA topology should only be used to populate
+ * these structs. 
+ */
+struct node_t {
+	int id, idle_rebalance_tick, busy_rebalance_tick, nr_cpus;
+	struct node_t *parent_node, *child_nodes;
+	struct runqueue *runqueues;
+	atomic_t nr_running;
+	struct node_t *next;
+} ____cacheline_aligned;
+
+static struct node_t nodes[MAX_NUMNODES] __cacheline_aligned = {
+	[0 ...MAX_NUMNODES-1].parent_node = NULL,
+	[0 ...MAX_NUMNODES-1].child_nodes = NULL,
+	[0 ...MAX_NUMNODES-1].runqueues = NULL,
+	[0 ...MAX_NUMNODES-1].nr_running = ATOMIC_INIT(0),
+	[0 ...MAX_NUMNODES-1].nr_cpus = 0,
+	[0 ...MAX_NUMNODES-1].busy_rebalance_tick = BUSY_REBALANCE_TICK,
+	[0 ...MAX_NUMNODES-1].idle_rebalance_tick = IDLE_REBALANCE_TICK
+};
 
-#ifdef CONFIG_NUMA
+#define nodeptr(node)		(nodes + (node))
 
-/*
- * Keep track of running tasks.
+/* 
+ * The last node is always the highest level node
  */
+#define top_node		(nodes + MAX_NUMNODES -1)
 
-static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
-	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
 
-static inline void nr_running_init(struct runqueue *rq)
-{
-	rq->node_nr_running = &node_nr_running[0];
-}
+/*
+ * Keep track of running tasks. Update nr_running for 
+ * rq->node and all parent nodes
+ */
 
 static inline void nr_running_inc(runqueue_t *rq)
 {
-	atomic_inc(rq->node_nr_running);
+	struct node_t *node = rq->node;
+	while (node) {
+		atomic_inc(&node->nr_running);
+		node = node->parent_node;
+	}
 	rq->nr_running++;
 }
 
 static inline void nr_running_dec(runqueue_t *rq)
 {
-	atomic_dec(rq->node_nr_running);
+	struct node_t *node = rq->node;
+	while (node) {
+		atomic_dec(&node->nr_running);
+		node = node->parent_node;
+	}
 	rq->nr_running--;
 }
 
-__init void node_nr_running_init(void)
+void numa_sched_topology_report(void)
 {
-	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i))
-			cpu_rq(i)->node_nr_running =
-				&node_nr_running[cpu_to_node(i)];
+struct node_t *m, *n, *o;
+runqueue_t *rq;
+
+	printk("scheduler topology report:\n");
+	m = top_node;
+	while (m) {
+		n = m;
+		while (n) {
+			printk("node %i...\n", n->id);
+			printk("nr_running: %u\n", atomic_read(&n->nr_running));
+			printk("idle_rebalance_tick: %i\n", n->idle_rebalance_tick);
+			printk("busy_rebalance_tick: %i\n", n->busy_rebalance_tick);
+			printk("  has %i cpus\n", n->nr_cpus);
+			printk("  has these runqueues: ");
+			rq = n->runqueues;
+			while (rq) {
+				printk(" %i,", rq->id);
+				rq = rq->next;
+			}
+			printk("\n");
+
+			printk("  has these children:");
+			o = n->child_nodes;
+			while (o) {
+				printk(" %i,", o->id);
+				o = o->next;
+			}
+			printk("\n\n");
+		n = n->next;
+		}
+	m = m->child_nodes;
 	}
 }
 
-#else /* !CONFIG_NUMA */
+void map_rq_to_node(runqueue_t *rq, struct node_t *node)
+{
+	/* node to rq */
+	rq->next = node->runqueues;
+	node->runqueues = rq; 
+	node->nr_cpus++;
+	/* rq to node */
+	rq->node = node;
+}
 
-# define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+void map_node_to_node(struct node_t *child, struct node_t *parent)
+{
+		/* parent to child */
+		child->next = parent->child_nodes;
+		parent->child_nodes = child;
+		/* child to parent */
+		child->parent_node = parent;
+}
+
+/* 
+ * Make sure all valid runqueues point to a node.
+ */
+void rq_to_node_init(void)
+{
+	int i, node;
 
-#endif /* CONFIG_NUMA */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		node = cpu_to_node(i);
+		if (node >= 0) {
+			if (!(cpu_rq(i)->node))
+				map_rq_to_node(cpu_rq(i), nodeptr(node));
+		}
+	}
+}
+
+/* 
+ * Setup the pointers between parent and child nodes 
+ * (use simple NUMA topology functions).
+ * Also setup parent node balance ticks
+ */
+void node_to_node_init(void)
+{
+	int i, node;
+	struct node_t *m, *n;
+
+	/* Setup the hierarchy of nodes */
+	m = top_node;
+	while (m) {
+		n = m;
+		while (n) {
+			for (i = 0; i < MAX_NUMNODES; i++) {
+				node = parent_node(i);
+				if ((n->id == node) && (i != node))
+					map_node_to_node(nodeptr(i), nodeptr(node));
+			}
+			n = n->next;
+		}
+		m = m->child_nodes;
+	}
+	/* Setup the balance intervals */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		n = nodeptr(i)->child_nodes;
+		if (n) {
+			nodeptr(i)->idle_rebalance_tick = 
+				n->idle_rebalance_tick * IDLE_NODE_BALANCE_INTERVAL;
+			nodeptr(i)->busy_rebalance_tick = 
+				n->busy_rebalance_tick * BUSY_NODE_BALANCE_INTERVAL;
+		}
+	}
+	top_node->nr_cpus = 16;
+}
 
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
@@ -688,12 +808,7 @@ static inline task_t * context_switch(ru
  */
 unsigned long nr_running(void)
 {
-	unsigned long i, sum = 0;
-
-	for (i = 0; i < NR_CPUS; i++)
-		sum += cpu_rq(i)->nr_running;
-
-	return sum;
+	return atomic_read(&top_node->nr_running);
 }
 
 unsigned long nr_uninterruptible(void)
@@ -766,7 +881,6 @@ static inline void double_rq_unlock(runq
 		spin_unlock(&rq2->lock);
 }
 
-#ifdef CONFIG_NUMA
 /*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
@@ -793,37 +907,46 @@ static void sched_migrate_task(task_t *p
  */
 static int sched_best_cpu(struct task_struct *p)
 {
-	int i, minload, load, best_cpu, node = 0;
-	cpumask_t cpumask;
+	int minload, load, best_cpu;
+	struct node_t *node, *best_node;
+	runqueue_t *rq;
 
 	best_cpu = task_cpu(p);
 	if (cpu_rq(best_cpu)->nr_running <= 2)
 		return best_cpu;
 
 	minload = 10000000;
-	for_each_node_with_cpus(i) {
-		/*
-		 * Node load is always divided by nr_cpus_node to normalise 
-		 * load values in case cpu count differs from node to node.
-		 * We first multiply node_nr_running by 10 to get a little
-		 * better resolution.   
-		 */
-		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
-		if (load < minload) {
-			minload = load;
-			node = i;
+	node = top_node;
+	while (node->child_nodes) {
+		node = node->child_nodes;
+		best_node = node->child_nodes;
+		while (node) {
+			/*
+			 * Node load is always divided by nr_cpus_node to normalise 
+			 * load values in case cpu count differs from node to node.
+			 * We first multiply node_nr_running by 10 to get a little
+			 * better resolution.   
+			 */
+			if (node->nr_cpus) {
+				load = 10 * atomic_read(&node->nr_running)
+				/ node->nr_cpus;
+				if (load < minload) {
+					minload = load;
+					best_node = node;
+				}	
+			}
+			node = node->next;
 		}
+		node = best_node;
 	}
-
 	minload = 10000000;
-	cpumask = node_to_cpumask(node);
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_isset(i, cpumask))
-			continue;
-		if (cpu_rq(i)->nr_running < minload) {
-			best_cpu = i;
-			minload = cpu_rq(i)->nr_running;
+	rq = node->runqueues;
+	while (rq) {
+		if (rq->nr_running < minload) {
+			minload = rq->nr_running;
+			best_cpu = rq->id;
 		}
+		rq = rq->next;
 	}
 	return best_cpu;
 }
@@ -848,33 +971,38 @@ void sched_balance_exec(void)
  * of different cpu count but also [first] multiplied by 10 to 
  * provide better resolution.
  */
-static int find_busiest_node(int this_node)
+static struct node_t *find_busiest_node(struct node_t *this_node, struct node_t *parent_node)
 {
-	int i, node = -1, load, this_load, maxload;
+	int load, this_load, maxload = 0;
+	struct node_t *node, *busiest_node = NULL;
 
-	if (!nr_cpus_node(this_node))
-		return node;
-	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
-		+ (10 * atomic_read(&node_nr_running[this_node])
-		/ nr_cpus_node(this_node));
-	this_rq()->prev_node_load[this_node] = this_load;
-	for_each_node_with_cpus(i) {
-		if (i == this_node)
+	if (!(this_node->nr_cpus))
+		return busiest_node;
+	this_load = maxload = (this_rq()->prev_node_load[this_node->id] >> 1)
+		+ (10 * atomic_read(&this_node->nr_running))
+		/ this_node->nr_cpus;
+	this_rq()->prev_node_load[this_node->id] = this_load;
+
+	/* cycle through the list of member nodes */
+	node = parent_node->child_nodes;
+	while (node) {
+		if (!(node->nr_cpus) || (node == this_node)) {
+			node = node->next;
 			continue;
-		load = (this_rq()->prev_node_load[i] >> 1)
-			+ (10 * atomic_read(&node_nr_running[i])
-			/ nr_cpus_node(i));
-		this_rq()->prev_node_load[i] = load;
+		}
+		load = (this_rq()->prev_node_load[node->id] >> 1)
+			+ (10 * atomic_read(&node->nr_running))
+			/ node->nr_cpus;
+		this_rq()->prev_node_load[node->id] = load;
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
 			maxload = load;
-			node = i;
+			busiest_node = node;
 		}
+		node = node->next;
 	}
-	return node;
+	return busiest_node;
 }
 
-#endif /* CONFIG_NUMA */
-
 #ifdef CONFIG_SMP
 
 /*
@@ -905,10 +1033,11 @@ static inline unsigned int double_lock_b
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in cpumask.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, cpumask_t cpumask)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle , int *imbalance, struct node_t *node)
 {
-	int nr_running, load, max_load, i;
+	int nr_running, load, max_load, cpu_id;
 	runqueue_t *busiest, *rq_src;
+	struct node_t *m, *n;
 
 	/*
 	 * We search all runqueues to find the most busy one.
@@ -939,21 +1068,31 @@ static inline runqueue_t *find_busiest_q
 
 	busiest = NULL;
 	max_load = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_isset(i, cpumask))
-			continue;
-
-		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_cpu_load[i]))
-			load = rq_src->nr_running;
-		else
-			load = this_rq->prev_cpu_load[i];
-		this_rq->prev_cpu_load[i] = rq_src->nr_running;
-
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
+	if (nr_running > 1)
+		max_load = nr_running;
+	n = node;
+	while (n) {
+		m = n;
+		while (m) {
+			rq_src = m->runqueues;
+			while (rq_src) {
+				cpu_id = rq_src->id;
+				if (idle || (rq_src->nr_running < this_rq->prev_cpu_load[cpu_id]))
+					load = rq_src->nr_running;
+				else
+					load = this_rq->prev_cpu_load[cpu_id];
+				this_rq->prev_cpu_load[cpu_id] = rq_src->nr_running;
+				load = rq_src->nr_running;
+
+				if ((load > max_load) && (rq_src != this_rq)) {
+					busiest = rq_src;
+					max_load = load;
+				}
+			rq_src = rq_src->next;
+			}
+			m = m->next;
 		}
+		n = n->child_nodes;
 	}
 
 	if (likely(!busiest))
@@ -1012,7 +1151,7 @@ static inline void pull_task(runqueue_t 
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle, cpumask_t cpumask)
+static void load_balance(runqueue_t *this_rq, int idle, struct node_t *node)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -1020,7 +1159,7 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, node);
 	if (!busiest)
 		goto out;
 
@@ -1094,67 +1233,46 @@ out:
  * get called every timer tick, on every CPU. Our balancing action
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
- *
- * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
- * systems with HZ=100, every 10 msecs.)
- *
- * On NUMA, do a node-rebalance every 400 msecs.
  */
-#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
-#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
-#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 5)
-#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
 
-#ifdef CONFIG_NUMA
-static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
+static void balance_node(runqueue_t *this_rq, int idle, struct node_t *last_node, struct node_t *node)
 {
-	int node = find_busiest_node(cpu_to_node(this_cpu));
+	if (last_node)
+		node = find_busiest_node(last_node, node);
 
-	if (node >= 0) {
-		cpumask_t cpumask = node_to_cpumask(node);
-		cpu_set(this_cpu, cpumask);
+	if (node) {
 		spin_lock(&this_rq->lock);
-		load_balance(this_rq, idle, cpumask);
+		load_balance(this_rq, idle, node);
 		spin_unlock(&this_rq->lock);
 	}
 }
-#endif
 
 static void rebalance_tick(runqueue_t *this_rq, int idle)
 {
-#ifdef CONFIG_NUMA
-	int this_cpu = smp_processor_id();
-#endif
 	unsigned long j = jiffies;
+	struct node_t *node = this_rq->node, *last_node = NULL;
 
 	/*
-	 * First do inter-node rebalancing, then intra-node rebalancing,
-	 * if both events happen in the same tick. The inter-node
-	 * rebalancing does not necessarily have to create a perfect
-	 * balance within the node, since we load-balance the most loaded
-	 * node with the current CPU. (ie. other CPUs in the local node
-	 * are not balanced.)
+	 * we start with lowest level node (the whole system in nonNUMA)
+	 * then we loop, node = node->parent_node and see if it's time for
+	 * a balance.  Each time we loop, the scope of cpus to balance gets
+	 * bigger.
 	 */
+
 	if (idle) {
-#ifdef CONFIG_NUMA
-		if (!(j % IDLE_NODE_REBALANCE_TICK))
-			balance_node(this_rq, idle, this_cpu);
-#endif
-		if (!(j % IDLE_REBALANCE_TICK)) {
-			spin_lock(&this_rq->lock);
-			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
-			spin_unlock(&this_rq->lock);
+		while (node) {
+			if (!(j % node->idle_rebalance_tick))
+				balance_node(this_rq, idle, last_node, node);
+			last_node = node;
+			node = node->parent_node;
 		}
 		return;
 	}
-#ifdef CONFIG_NUMA
-	if (!(j % BUSY_NODE_REBALANCE_TICK))
-		balance_node(this_rq, idle, this_cpu);
-#endif
-	if (!(j % BUSY_REBALANCE_TICK)) {
-		spin_lock(&this_rq->lock);
-		load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
-		spin_unlock(&this_rq->lock);
+	while (node) {
+		if (!(j % node->busy_rebalance_tick))
+			balance_node(this_rq, idle, last_node, node);
+		last_node = node;
+		node = node->parent_node;
 	}
 }
 #else
@@ -1331,7 +1449,8 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
-		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
+		if (rq->node)
+			load_balance(rq, 1, rq->node);
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif
@@ -2516,16 +2635,18 @@ void __init sched_init(void)
 
 	/* Init the kstat counters */
 	init_kstat();
+	for (i = 0; i < MAX_NUMNODES; i++)
+		nodeptr(i)->id = i;
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
+		rq->id = i;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
-		nr_running_init(rq);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--Boundary-00=_XrjR/L+0IcK32A2--

