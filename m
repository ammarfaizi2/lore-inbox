Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSLRQNo>; Wed, 18 Dec 2002 11:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSLRQNo>; Wed, 18 Dec 2002 11:13:44 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:61895 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261529AbSLRQNj>; Wed, 18 Dec 2002 11:13:39 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [PATCH 2.5.52] NUMA scheduler (1/2)
Date: Wed, 18 Dec 2002 17:21:39 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <200211191726.07214.efocht@ess.nec.de> <200212021629.39060.efocht@ess.nec.de>
In-Reply-To: <200212021629.39060.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3GPB2TAF7WTB3B0PZWAZ"
Message-Id: <200212181721.39434.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_3GPB2TAF7WTB3B0PZWAZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This is the first part of the minimal NUMA scheduler built on top of
the O(1) load balancer. It is rediffed for 2.5.52 and contains a small
bugfix in build_node_data().

The two patches are:

01-numa-sched-core-2.5.52-23.patch: core NUMA scheduler infrastructure
  providing a node aware load_balancer.

02-numa-sched-ilb-2.5.52-21.patch: initial load balancing, selects
  least loaded node & CPU at exec().

Regards,
Erich

--------------Boundary-00=_3GPB2TAF7WTB3B0PZWAZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01-numa-sched-core-2.5.52-23.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-numa-sched-core-2.5.52-23.patch"

diff -urN a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	2002-12-16 03:07:56.000000000 +0100
+++ b/arch/i386/kernel/smpboot.c	2002-12-18 16:53:12.000000000 +0100
@@ -1202,6 +1202,9 @@
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif
 }
 
 void __init smp_intr_init()
diff -urN a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	2002-12-16 03:07:50.000000000 +0100
+++ b/arch/ia64/kernel/smpboot.c	2002-12-18 16:53:13.000000000 +0100
@@ -397,7 +397,7 @@
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -522,6 +522,9 @@
 
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif
 }
 
 int __devinit
diff -urN a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	2002-12-16 03:08:13.000000000 +0100
+++ b/arch/ppc64/kernel/smp.c	2002-12-18 16:53:13.000000000 +0100
@@ -679,4 +679,7 @@
 
 	/* XXX fix this, xics currently relies on it - Anton */
 	smp_threads_ready = 1;
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif
 }
diff -urN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2002-12-16 03:07:44.000000000 +0100
+++ b/include/linux/sched.h	2002-12-18 16:53:13.000000000 +0100
@@ -20,6 +20,7 @@
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
+#include <asm/topology.h>
 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
@@ -446,6 +447,9 @@
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void build_node_data(void);
+#endif
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2002-12-16 03:08:14.000000000 +0100
+++ b/kernel/sched.c	2002-12-18 16:53:13.000000000 +0100
@@ -158,6 +158,10 @@
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
+
+	unsigned long wait_time;
+	int wait_node;
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -177,6 +181,55 @@
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+#define cpu_to_node(cpu) __cpu_to_node(cpu)
+#define LOADSCALE 128
+
+#ifdef CONFIG_NUMA
+/* Number of CPUs per node: sane values until all CPUs are up */
+int _node_nr_cpus[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = NR_CPUS };
+int node_ptr[MAX_NUMNODES+1]; /* first cpu of node (logical cpus are sorted!)*/
+#define node_ncpus(node)  _node_nr_cpus[node]
+
+#define NODE_DELAY_IDLE  (1*HZ/1000)
+#define NODE_DELAY_BUSY  (20*HZ/1000)
+
+/* the following macro implies that logical CPUs are sorted by node number */
+#define loop_over_node(cpu,node) \
+	for(cpu=node_ptr[node]; cpu<node_ptr[node+1]; cpu++)
+
+/*
+ * Build node_ptr and node_ncpus data after all CPUs have come up. This
+ * expects that the logical CPUs are sorted by their node numbers! Check
+ * out the NUMA API for details on why this should be that way.     [EF]
+ */
+void build_node_data(void)
+{
+	int n, cpu, ptr;
+	unsigned long mask;
+
+	ptr=0;
+	for (n=0; n<numnodes; n++) {
+		mask = __node_to_cpu_mask(n) & cpu_online_map;
+		node_ptr[n] = ptr;
+		for (cpu=0; cpu<NR_CPUS; cpu++)
+			if (mask  & (1UL << cpu))
+				ptr++;
+		node_ncpus(n) = ptr - node_ptr[n];
+	}
+	node_ptr[numnodes] = ptr;
+	printk("CPU nodes : %d\n",numnodes);
+	for (n=0; n<numnodes; n++)
+		printk("node %d : %d .. %d\n",n,node_ptr[n],node_ptr[n+1]-1);
+}
+
+#else
+#define node_ncpus(node)  num_online_cpus()
+#define NODE_DELAY_IDLE 0
+#define NODE_DELAY_BUSY 0
+#define loop_over_node(cpu,n) for(cpu=0; cpu<NR_CPUS; cpu++)
+#endif
+
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -652,81 +705,134 @@
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * Find a runqueue from which to steal a task. We try to do this as locally as
+ * possible because we don't want to let tasks get far from their node.
+ * 
+ * 1. First try to find a runqueue within the own node with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and its
+ * most loaded CPU.
+ *
+ * This routine implements node balancing by delaying steals from remote
+ * nodes more if the own node is (within margins) averagely loaded. The
+ * most loaded node is remembered as well as the time (jiffies). In the
+ * following calls to the load_balancer the time is compared with
+ * NODE_DELAY_BUSY (if load is around the average) or NODE_DELAY_IDLE (if own
+ * node is unloaded) if the most loaded node didn't change. This gives less 
+ * loaded nodes the chance to approach the average load but doesn't exclude
+ * busy nodes from stealing (just in case the cpus_allowed mask isn't good
+ * for the idle nodes).
+ * This concept can be extended easilly to more than two levels (multi-level
+ * scheduler), e.g.: CPU -> node -> supernode... by implementing node-distance
+ * dependent steal delays.
+ *
+ *                                                         <efocht@ess.nec.de>
+ */
+
+struct node_queue_data {
+	int total_load;
+	int average_load;
+	int busiest_cpu;
+	int busiest_cpu_load;
+};
+
+/*
+ * Check if CPUs are balanced. The check is more involved than the O(1) original
+ * because that one is simply wrong in certain cases (integer arithmetic !!!) EF
+ */
+#define CPUS_BALANCED(m,t) (((m)<=1) || (((m)-(t))/2 < (((m)+(t))/2 + 3)/4))
+/*
+ * Check if nodes are imbalanced. "this" node is balanced (compared to the "comp"
+ * node) when it's load is not smaller than "comp"'s load - LOADSCALE/2.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+#define NODES_BALANCED(comp,this) (((comp)-(this)) < LOADSCALE/2)
+
+static inline runqueue_t *find_busiest_queue(int this_cpu, int idle, int *nr_running)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+	runqueue_t *busiest_rq = NULL, *this_rq = cpu_rq(this_cpu), *src_rq;
+	int busiest_cpu, busiest_node=0, cpu, load, max_avg_load, avg_load;
+	int n, steal_delay, system_load = 0, this_node=cpu_to_node(this_cpu); 
+	struct node_queue_data nd[MAX_NUMNODES], *node;
 
-	/*
-	 * We search all runqueues to find the most busy one.
-	 * We do this lockless to reduce cache-bouncing overhead,
-	 * we re-check the 'best' source CPU later on again, with
-	 * the lock held.
-	 *
-	 * We fend off statistical fluctuations in runqueue lengths by
-	 * saving the runqueue length during the previous load-balancing
-	 * operation and using the smaller one the current and saved lengths.
-	 * If a runqueue is long enough for a longer amount of time then
-	 * we recognize it and pull tasks from it.
-	 *
-	 * The 'current runqueue length' is a statistical maximum variable,
-	 * for that one we take the longer one - to avoid fluctuations in
-	 * the other direction. So for a load-balance to happen it needs
-	 * stable long runqueue on the target CPU and stable short runqueue
-	 * on the local runqueue.
-	 *
-	 * We make an exception if this CPU is about to become idle - in
-	 * that case we are less picky about moving a task across CPUs and
-	 * take what can be taken.
-	 */
 	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
-		nr_running = this_rq->nr_running;
+		*nr_running = this_rq->nr_running;
 	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
+		*nr_running = this_rq->prev_nr_running[this_cpu];
 
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for (n = 0; n < numnodes; n++) {
+		nd[n].busiest_cpu_load = -1;
+		nd[n].total_load = 0;
+	}
 
-		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
-			load = rq_src->nr_running;
+	/* compute all node loads and save their max cpu loads */
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu)) continue;
+		node = &nd[cpu_to_node(cpu)];
+		src_rq = cpu_rq(cpu);
+		if (idle || (src_rq->nr_running < this_rq->prev_nr_running[cpu]))
+			load = src_rq->nr_running;
 		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
-
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
+			load = this_rq->prev_nr_running[cpu];
+		this_rq->prev_nr_running[cpu] = src_rq->nr_running;
+		node->total_load += load;
+		if (load > node->busiest_cpu_load) {
+			node->busiest_cpu_load = load;
+			node->busiest_cpu = cpu;
 		}
 	}
 
-	if (likely(!busiest))
-		goto out;
+	busiest_cpu = nd[this_node].busiest_cpu;
+	if (busiest_cpu != this_cpu) {
+		if (!CPUS_BALANCED(nd[this_node].busiest_cpu_load,*nr_running)) {
+			busiest_rq = cpu_rq(busiest_cpu);
+			this_rq->wait_node = -1;
+			goto out;
+		}
+	}
 
-	*imbalance = (max_load - nr_running) / 2;
+#ifdef CONFIG_NUMA
+	max_avg_load = -1;
+	for (n = 0; n < numnodes; n++) {
+		node = &nd[n];
+		system_load += node->total_load;
+		node->average_load = node->total_load*LOADSCALE/node_ncpus(n);
+		if (node->average_load > max_avg_load) {
+			max_avg_load = node->average_load;
+			busiest_node = n;
+		}
+	}
 
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest = NULL;
+	/* Exit if not enough imbalance on any remote node. */
+	if ((busiest_node == this_node) || (max_avg_load <= LOADSCALE) ||
+	    NODES_BALANCED(max_avg_load,nd[this_node].average_load)) {
+		this_rq->wait_node = -1;
 		goto out;
 	}
 
-	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <= nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest = NULL;
+	busiest_cpu = nd[busiest_node].busiest_cpu;
+	avg_load = system_load*LOADSCALE/num_online_cpus();
+	/* Wait longer before stealing if own node's load is average. */
+	if (NODES_BALANCED(avg_load,nd[this_node].average_load))
+		steal_delay = NODE_DELAY_BUSY;
+	else
+		steal_delay = NODE_DELAY_IDLE;
+	/* if we have a new most loaded node: just mark it */
+	if (this_rq->wait_node != busiest_node) {
+		this_rq->wait_node = busiest_node;
+		this_rq->wait_time = jiffies;
+		goto out;
+	} else
+	/* old most loaded node: check if waited enough */
+		if (jiffies - this_rq->wait_time < steal_delay)
+			goto out;
+
+	if ((!CPUS_BALANCED(nd[busiest_node].busiest_cpu_load,*nr_running))) {
+		busiest_rq = cpu_rq(busiest_cpu);
+		this_rq->wait_node = -1;
 	}
-out:
-	return busiest;
+#endif
+ out:
+	return busiest_rq;
 }
 
 /*
@@ -758,16 +864,21 @@
  */
 static void load_balance(runqueue_t *this_rq, int idle)
 {
-	int imbalance, idx, this_cpu = smp_processor_id();
+	int imbalance, nr_running, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
 	prio_array_t *array;
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	busiest = find_busiest_queue(this_cpu, idle, &nr_running);
 	if (!busiest)
 		goto out;
 
+	imbalance = (busiest->nr_running - nr_running)/2;
+
+	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
+	if (busiest->nr_running <= nr_running + 1)
+		goto out_unlock;
 	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
@@ -839,10 +950,10 @@
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=100, every 10 msecs.)
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 
 static inline void idle_tick(runqueue_t *rq)
@@ -2110,7 +2221,8 @@
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);

--------------Boundary-00=_3GPB2TAF7WTB3B0PZWAZ--

