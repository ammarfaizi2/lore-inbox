Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSLaNUm>; Tue, 31 Dec 2002 08:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSLaNUm>; Tue, 31 Dec 2002 08:20:42 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:22918 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261371AbSLaNUa>; Tue, 31 Dec 2002 08:20:30 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [PATCH 2.5.53] NUMA scheduler (1/3)
Date: Tue, 31 Dec 2002 14:29:04 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <200212021629.39060.efocht@ess.nec.de> <200212181721.39434.efocht@ess.nec.de>
In-Reply-To: <200212181721.39434.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_G4KZQDQ4139OOV3O9VTK"
Message-Id: <200212311429.04382.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_G4KZQDQ4139OOV3O9VTK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here comes the minimal NUMA scheduler built on top of the O(1) load
balancer rediffed for 2.5.53 with some changes in the core part. As
suggested by Michael, I added the cputimes_stat patch, as it is
absolutely needed for understanding the scheduler behavior.

The three patches:
01-numa-sched-core-2.5.53-24.patch: core NUMA scheduler infrastructure
  providing a node aware load_balancer. Cosmetic changes + more comments.

02-numa-sched-ilb-2.5.53-21.patch: initial load balancing, selects
  least loaded node & CPU at exec().

03-cputimes_stat-2.5.53.patch: adds back to the kernel per CPU user
  and system time statistics for each process in /proc/PID/cpu. Needed
  for evaluating scheduler behavior and performance of tasks running
  on SMP and NUMA systems.

Regards,
Erich

--------------Boundary-00=_G4KZQDQ4139OOV3O9VTK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01-numa-sched-core-2.5.53-24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-numa-sched-core-2.5.53-24.patch"

diff -urN a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	2002-12-24 06:20:16.000000000 +0100
+++ b/arch/i386/kernel/smpboot.c	2002-12-31 13:02:47.000000000 +0100
@@ -1191,6 +1191,7 @@
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+	build_node_data();
 }
 
 void __init smp_intr_init()
diff -urN a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	2002-12-24 06:19:49.000000000 +0100
+++ b/arch/ia64/kernel/smpboot.c	2002-12-31 13:03:02.000000000 +0100
@@ -397,7 +397,7 @@
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -522,6 +522,7 @@
 
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+	build_node_data();
 }
 
 int __devinit
diff -urN a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	2002-12-24 06:21:01.000000000 +0100
+++ b/arch/ppc64/kernel/smp.c	2002-12-31 13:03:21.000000000 +0100
@@ -679,4 +679,5 @@
 
 	/* XXX fix this, xics currently relies on it - Anton */
 	smp_threads_ready = 1;
+	build_node_data();
 }
diff -urN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2002-12-24 06:19:35.000000000 +0100
+++ b/include/linux/sched.h	2002-12-31 13:02:18.000000000 +0100
@@ -445,6 +445,12 @@
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void build_node_data(void);
+#else
+#define build_node_data() {}
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2002-12-24 06:21:05.000000000 +0100
+++ b/kernel/sched.c	2002-12-31 13:46:03.000000000 +0100
@@ -158,6 +158,10 @@
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
+#ifdef CONFIG_NUMA
+	unsigned long wait_time;
+	int wait_node;
+#endif
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -178,6 +182,64 @@
 #endif
 
 /*
+ * Node loads are scaled with LOADSCALE. This way:
+ * - we avoid zeros in integer divisions (dividing by node CPU number),
+ * - loads of nodes with different numbers of CPUs are comparable.
+ */
+#define LOADSCALE 128
+
+#ifdef CONFIG_NUMA
+/* Number of CPUs per node: sane values until all CPUs are up */
+static int _node_nr_cpus[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = NR_CPUS };
+static int node_ptr[MAX_NUMNODES+1]; /* first cpu of node (logical cpus are sorted!)*/
+#define node_nr_cpus(node)  _node_nr_cpus[node]
+
+/*
+ * Delay stealing from remote node when own queue is idle/busy. These delays
+ * tend to equalize the node loads. NODE_DELAY_IDLE is nonzero because we
+ * want to give idle CPUs in the busiest node a chance to steal first.
+ */
+#define NODE_DELAY_IDLE  (1*HZ/1000)
+#define NODE_DELAY_BUSY  (20*HZ/1000)
+
+/* the following macro implies that logical CPUs are sorted by node number */
+#define loop_over_node(cpu,node) \
+	for(cpu = node_ptr[node]; cpu < node_ptr[node+1]; cpu++)
+
+/*
+ * Build node_ptr and node_nr_cpus data after all CPUs have come up. This
+ * expects that the logical CPUs are sorted by their node numbers! Check
+ * out the NUMA API for details on why this should be that way.     [EF]
+ */
+void build_node_data(void)
+{
+	int n, cpu, ptr;
+	unsigned long mask;
+
+	ptr=0;
+	for (n = 0; n < numnodes; n++) {
+		mask = __node_to_cpu_mask(n) & cpu_online_map;
+		node_ptr[n] = ptr;
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
+			if (mask  & (1UL << cpu))
+				ptr++;
+		node_nr_cpus(n) = ptr - node_ptr[n];
+	}
+	node_ptr[numnodes] = ptr;
+	printk("CPU nodes : %d\n",numnodes);
+	for (n = 0; n < numnodes; n++)
+		printk("node %d : %d .. %d\n",n,node_ptr[n],node_ptr[n+1]-1);
+}
+
+#else
+#define node_nr_cpus(node)  num_online_cpus()
+#define NODE_DELAY_IDLE 0
+#define NODE_DELAY_BUSY 0
+#define loop_over_node(cpu,n) for(cpu = 0; cpu < NR_CPUS; cpu++)
+#endif
+
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -652,81 +714,134 @@
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
+#define cpus_balanced(m,t) (((m)<=1) || (((m)-(t))/2 < (((m)+(t))/2 + 3)/4))
+/*
+ * Check if nodes are imbalanced. "this" node is balanced (compared to the "comp"
+ * node) when it's load is not smaller than "comp"'s load - LOADSCALE/2.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+#define nodes_balanced(comp,this) (((comp)-(this)) < LOADSCALE/2)
+
+static inline runqueue_t *find_busiest_queue(int this_cpu, int idle, int *nr_running)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+	runqueue_t *busiest_rq = NULL, *this_rq = cpu_rq(this_cpu), *src_rq;
+	int busiest_cpu, busiest_node=0, cpu, load, max_avg_load, avg_load;
+	int n, steal_delay, system_load = 0, this_node=__cpu_to_node(this_cpu); 
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
+		if (!cpu_online(cpu))
+			continue;
+		node = &nd[__cpu_to_node(cpu)];
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
+		if (!cpus_balanced(nd[this_node].busiest_cpu_load,*nr_running)) {
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
+		node->average_load = node->total_load*LOADSCALE/node_nr_cpus(n);
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
+	    nodes_balanced(max_avg_load,nd[this_node].average_load)) {
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
+	if (nodes_balanced(avg_load,nd[this_node].average_load))
+		steal_delay = NODE_DELAY_BUSY;
+	else
+		steal_delay = NODE_DELAY_IDLE;
+	/* if we have a new most loaded node: just mark it */
+	if (this_rq->wait_node != busiest_node) {
+		this_rq->wait_node = busiest_node;
+		this_rq->wait_time = jiffies;
+		goto out;
+	/* old most loaded node: check if waited enough */
+	} else if (jiffies - this_rq->wait_time < steal_delay)
+		goto out;
+
+	if ((!cpus_balanced(nd[busiest_node].busiest_cpu_load,*nr_running))) {
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
@@ -758,16 +873,21 @@
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
@@ -2110,7 +2230,8 @@
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);

--------------Boundary-00=_G4KZQDQ4139OOV3O9VTK--

