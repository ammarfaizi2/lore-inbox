Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSCMUK5>; Wed, 13 Mar 2002 15:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311163AbSCMUKk>; Wed, 13 Mar 2002 15:10:40 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:5789 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S311147AbSCMUKK>; Wed, 13 Mar 2002 15:10:10 -0500
Date: Wed, 13 Mar 2002 21:10:07 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Node affine NUMA scheduler
Message-ID: <Pine.LNX.4.21.0203131948140.8009-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is an update of the NUMA scheduler I'm playing with. It is built on
top of Ingo's O(1) scheduler, the patch is for the IA-64 port of the 
latest 2.4.17 version of the O(1) scheduler which I posted to the LSE
mailing list. Once again, please don't regard this as a finished solution,
it is more a discussion basis.

Here is a description of the background and the implementation.

This scheduler extension is targeted to cc-NUMA machines with CPUs grouped
in multiple nodes, each node having its own memory. Accessing the memory
of a remote node implies taking penalties in memory access latency and
bandwidth. Therefore it is desirable to keep processes on or near the node
on which their memory (or most of it) is allocated. Fixing the
cpus_allowed mask of tasks to a particular nodes would of course be a
solution but experiments show that for loads >100% this leads to poorer
performance (due to bad load balancing). In this approach I assign each
task a homenode on which its memory will be allocated (different patch
needed) and the scheduler will try to keep the task on its homenode or
attract it to it.

- CPUs are grouped in pools or nodes, the topology is described in the
macro CPU_TO_NODE and architecture/platform dependent.

- Each task_structure has an additional variable called node.

- The homenode of a task (and its initial CPU) is chosen in do_execve(). I
switched to this kind of initial balancing instead of do_fork() after some
discussions. For some cases (multithreaded tasks) this is not always
optimal and will require some additional treatment.

- The load_balance routine is changed as follows:
    - Tries to balance the load inside the own node when invoked
    (i.e. each tick on idle cpus, every 250ms on busy cpus). This is the
    same behavior as Ingo's design, but restricted to the nearest CPUs
    (the node).

    - If the local node is balanced, finds the most loaded node and its
    most loaded CPU. 
        - If the local node's load is below the machines average load,
        tries to steal a task immediately from the most loaded CPU.
        - If the local node load is (within some margins) same as the
        machine's average load, remebers the most loaded node and waits
        100ms before trying to steal a task. As all idle CPUs are racing
        for getting a task from the most loaded node, this gives us a
        chance to get better balance between nodes.

    - Tasks not running on their homenode are treated preferrentially by
    the CPUs belonging to the homenode. The load seen by a CPU is
    "subjective" because the tasks originating from its node are counted
    twice. This is basically the force attracting the tasks back to their
    homenode.

- I kept Ingo's timings and margins for balancing:
    - 1ms or 1 tick for idle cpus, 250ms for busy cpus,
    - >= 25% load imbalance necessary.

The patch is tested on a 16 CPU Itanium server (NEC AzusA) and I've seen
gains of 10-80% in performance, depending on the load. I'd be curious to
hear whether anybody else is working on node affinity and/or has
ideas/comments...

Best regards,
Erich



diff -urN 2.4.17-ia64-kdbv2.1-K3+/arch/ia64/kernel/smpboot.c 2.4.17-ia64-kdbv2.1-k3z-nod9/arch/ia64/kernel/smpboot.c
--- 2.4.17-ia64-kdbv2.1-K3+/arch/ia64/kernel/smpboot.c	Mon Mar  4 11:39:18 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/arch/ia64/kernel/smpboot.c	Wed Mar 13 18:27:45 2002
@@ -83,6 +83,8 @@
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 volatile int ia64_cpu_to_sapicid[NR_CPUS];
 
+char node_number[NR_CPUS] __cacheline_aligned;
+
 static volatile unsigned long cpu_callin_map;
 
 struct smp_boot_data smp_boot_data __initdata;
@@ -134,6 +136,22 @@
 
 __setup("nointroute", nointroute);
 
+void __init
+bub_sort(int n, int *a)
+{
+	int end, j, t;
+
+	for (end = n-1; end >= 0; end--) {
+		for (j = 0; j < end; j++) {
+			if (a[j] > a[j+1]) {
+				t = a[j+1];
+				a[j+1] = a[j];
+				a[j] = t;
+			}
+		}
+	}
+}
+
 void
 sync_master (void *arg)
 {
@@ -496,6 +515,13 @@
 	if  (max_cpus != -1)
 		printk (KERN_INFO "Limiting CPUs to %d\n", max_cpus);
 
+#ifdef CONFIG_IA64_DIG
+	/* 
+ 	 * To be on the safe side: sort SAPIC IDs of CPUs
+ 	 */
+	bub_sort(smp_boot_data.cpu_count, &smp_boot_data.cpu_phys_id[0]);
+#endif
+
 	if (smp_boot_data.cpu_count > 1) {
 
 		printk(KERN_INFO "SMP: starting up secondaries.\n");
@@ -541,7 +567,24 @@
 	}
   smp_done:
 	;
+#ifdef CONFIG_IA64_DIG
+	bld_node_number();
+	bld_pools();
+#endif
+}
+#ifdef CONFIG_IA64_DIG
+/* build translation table for CPU_TO_NODE macro */
+void __init
+bld_node_number(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		if (cpu_online_map & (1<<cpu))
+			node_number[cpu] = SAPICID_TO_NODE(cpu_physical_id(cpu));
 }
+#endif
+
 
 /*
  * Assume that CPU's have been discovered by some platform-dependant interface.  For
@@ -572,6 +615,7 @@
 
 /* Number of ticks we consider an idle tasks still cache-hot.
  * For Itanium: with 1GB/s bandwidth we need 4ms to fill up 4MB L3 cache...
- * So let's try 10 ticks.
+ * The minimum time_slice is 10 ticks, so let's try 6 ticks.
  */
-unsigned long cache_decay_ticks=10;
+unsigned long cache_decay_ticks=6;
+
diff -urN 2.4.17-ia64-kdbv2.1-K3+/fs/exec.c 2.4.17-ia64-kdbv2.1-k3z-nod9/fs/exec.c
--- 2.4.17-ia64-kdbv2.1-K3+/fs/exec.c	Fri Dec 21 18:41:55 2001
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/fs/exec.c	Thu Mar  7 13:50:42 2002
@@ -860,6 +860,10 @@
 	int retval;
 	int i;
 
+#ifdef CONFIG_SMP
+	sched_exec_migrate();
+#endif
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urN 2.4.17-ia64-kdbv2.1-K3+/include/asm-ia64/smp.h 2.4.17-ia64-kdbv2.1-k3z-nod9/include/asm-ia64/smp.h
--- 2.4.17-ia64-kdbv2.1-K3+/include/asm-ia64/smp.h	Tue Mar  5 15:39:59 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/include/asm-ia64/smp.h	Tue Mar 12 17:58:43 2002
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_SMP
 
+#include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
@@ -113,6 +114,23 @@
 
 #define NO_PROC_ID		0xffffffff	/* no processor magic marker */
 
+extern char node_number[NR_CPUS] __cacheline_aligned;
+#ifdef CONFIG_IA64_DIG
+/* sooner or later this should be a configurable parameter [EF] */
+#define NR_NODES 4
+#define CPU_TO_NODE(cpu) node_number[cpu]
+/* 
+ * This is the node ID on the NEC AzusA, 
+ * on LION and BigSur it correctly initializes to node 0
+ */
+#define SAPICID_TO_NODE(hwid) ((hwid >> 12) & 0xff)
+#else
+/* need to be set for the specific platform! */
+#define NR_NODES               1
+#define CPU_TO_NODE(cpu)       0
+#define SAPICID_TO_NODE(hwid)  0
+#endif
+
 extern void __init init_smp_config (void);
 extern void smp_do_timer (struct pt_regs *regs);
 
diff -urN 2.4.17-ia64-kdbv2.1-K3+/include/linux/prctl.h 2.4.17-ia64-kdbv2.1-k3z-nod9/include/linux/prctl.h
--- 2.4.17-ia64-kdbv2.1-K3+/include/linux/prctl.h	Mon Feb  4 12:41:39 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/include/linux/prctl.h	Thu Mar  7 13:50:42 2002
@@ -26,4 +26,8 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get/set node for node-affine scheduling */
+#define PR_GET_NODE       16
+#define PR_SET_NODE       17
+
 #endif /* _LINUX_PRCTL_H */
diff -urN 2.4.17-ia64-kdbv2.1-K3+/include/linux/sched.h 2.4.17-ia64-kdbv2.1-k3z-nod9/include/linux/sched.h
--- 2.4.17-ia64-kdbv2.1-K3+/include/linux/sched.h	Tue Mar  5 15:40:01 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/include/linux/sched.h	Tue Mar 12 17:58:43 2002
@@ -149,6 +149,7 @@
 extern void update_one_process(task_t *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
+extern void sched_migrate_task(task_t *p, int cpu);
 extern void migration_init(void);
 extern unsigned long cache_decay_ticks;
 
@@ -314,6 +315,8 @@
 	unsigned long cpus_allowed;
 	unsigned int time_slice;
 
+	int node;
+
 	task_t *next_task, *prev_task;
 
 	struct mm_struct *mm, *active_mm;
@@ -453,6 +457,29 @@
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#if NR_NODES > 1
+/* Avoid zeroes in integer divides for load calculations */
+#define BALANCE_FACTOR 100
+/* 
+ * If the current node has average load it waits 100ms before trying to
+ * steal a task from a remote node.
+ */
+#define BALANCE_POOL_WAIT (HZ/10)
+
+extern int numpools;
+extern int pool_ptr[NR_NODES+1];
+extern int pool_cpus[NR_CPUS];
+extern int pool_nr_cpus[NR_NODES];
+extern unsigned long pool_mask[NR_NODES];
+extern void *runqueues_address;
+
+# define HOMENODE_INC(rq,node) (rq)->nr_homenode[node]++
+# define HOMENODE_DEC(rq,node) (rq)->nr_homenode[node]--
+#else
+# define HOMENODE_INC(rq,node) {}
+# define HOMENODE_DEC(rq,node) {}
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urN 2.4.17-ia64-kdbv2.1-K3+/kernel/fork.c 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/fork.c
--- 2.4.17-ia64-kdbv2.1-K3+/kernel/fork.c	Mon Mar  4 11:39:18 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/fork.c	Thu Mar  7 13:50:42 2002
@@ -640,10 +640,6 @@
 	{
 		int i;
 
-		if (likely(p->cpus_allowed & (1UL<<smp_processor_id())))
-			p->cpu = smp_processor_id();
-		else
-			p->cpu = __ffs(p->cpus_allowed);
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < smp_num_cpus; i++)
 			p->per_cpu_utime[cpu_logical_map(i)] =
diff -urN 2.4.17-ia64-kdbv2.1-K3+/kernel/ksyms.c 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/ksyms.c
--- 2.4.17-ia64-kdbv2.1-K3+/kernel/ksyms.c	Mon Mar  4 11:39:18 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/ksyms.c	Fri Mar  8 01:29:16 2002
@@ -576,3 +576,14 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+#if NR_NODES > 1
+#include <linux/sched.h>
+EXPORT_SYMBOL(runqueues_address);
+EXPORT_SYMBOL(numpools);
+EXPORT_SYMBOL(pool_ptr);
+EXPORT_SYMBOL(pool_cpus);
+EXPORT_SYMBOL(pool_nr_cpus);
+EXPORT_SYMBOL(pool_mask);
+EXPORT_SYMBOL(sched_migrate_task);
+#endif
diff -urN 2.4.17-ia64-kdbv2.1-K3+/kernel/sched.c 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/sched.c
--- 2.4.17-ia64-kdbv2.1-K3+/kernel/sched.c	Tue Mar  5 18:48:05 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/sched.c	Wed Mar 13 15:29:58 2002
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <asm/mmu_context.h>
 #include <linux/kernel_stat.h>
+#include <linux/module.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -144,9 +145,13 @@
 	int prev_nr_running[NR_CPUS];
 	task_t *migration_thread;
 	list_t migration_queue;
+	unsigned long wait_time;
+	int wait_node;
+	short nr_homenode[NR_NODES];
+	short load[2][NR_CPUS];
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
@@ -163,6 +168,29 @@
 	return (p == task_rq(p)->curr);
 }
 
+/*
+ * Variables for describing and accessing processor pools. Using a
+ * compressed row format like notation.
+ *
+ * numpools: number of CPU pools (nodes),
+ * pool_cpus[]: CPUs in pools sorted by their pool ID,
+ * pool_ptr[node]: index of first element in pool_cpus[] belonging to node.
+ * pool_mask[]: cpu mask of a pool.
+ *
+ * Example: loop over all CPUs in a pool p:
+ * for (i = pool_ptr[p]; i < pool_ptr[p+1]; i++) {
+ *      cpu = pool_cpus[i];
+ *      ...
+ * }
+ *                                                      <efocht@ess.nec.de>
+ */
+int numpools;
+int pool_ptr[NR_NODES+1];
+int pool_cpus[NR_CPUS];
+int pool_nr_cpus[NR_NODES];
+unsigned long pool_mask[NR_NODES];
+void *runqueues_address = (void *)runqueues;
+
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
@@ -247,10 +275,12 @@
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	HOMENODE_INC(rq,p->node);
 }
 
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	HOMENODE_DEC(rq,p->node);
 	rq->nr_running--;
 	dequeue_task(p, p->array);
 	p->array = NULL;
@@ -471,6 +501,128 @@
 }
 
 /*
+ * Calculate load of a CPU pool, store results in data[][NR_CPUS].
+ * Return the index of the most loaded runqueue.
+ *
+ */
+static int calc_pool_load(short data[][NR_CPUS], int this_cpu, int pool, int idle)
+{
+	runqueue_t *rq_src, *this_rq = cpu_rq(this_cpu);
+	int this_pool = CPU_TO_NODE(this_cpu);
+	int i, ii, idx=-1, refload, load;
+
+	data[1][pool] = 0;
+	refload = -1;
+
+	for (ii = pool_ptr[pool]; ii < pool_ptr[pool+1]; ii++) {
+		i = pool_cpus[ii];
+		rq_src = cpu_rq(cpu_logical_map(i));
+		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+			load = rq_src->nr_running;
+		else
+			load = this_rq->prev_nr_running[i];
+		this_rq->prev_nr_running[i] = rq_src->nr_running;
+		/* prefer cpus running tasks from this node */
+		if (pool != this_pool)
+			load += rq_src->nr_homenode[this_pool];
+
+		data[0][i] = load;
+		data[1][pool] += load;
+
+		if (load > refload) {
+			idx = i;
+			refload = load;
+		}
+	}
+	data[1][pool] = data[1][pool] * BALANCE_FACTOR / pool_nr_cpus[pool];
+	return idx;
+}
+
+/*
+ * Find a runqueue from which to steal a task. We try to do this as locally as
+ * possible because we don't want to let tasks get far from their home node.
+ * This is done in two steps:
+ * 1. First try to find a runqueue within the own CPU pool (AKA node) with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and its
+ * most loaded CPU. Remote runqueues running tasks having their homenode on the
+ * current node are preferred (those tasks count twice in the load calculation).
+ * If the current load is far below the average try to steal a task from the
+ * most loaded node/cpu. Otherwise wait 100ms and give less loaded nodes the
+ * chance to approach the average load.
+ *
+ * This concept can be extended easilly to more than two levels (multi-level
+ * scheduler?), e.g.: CPU -> multi-core package -> node -> supernode...
+ *                                                         <efocht@ess.nec.de>
+ */
+static runqueue_t *scan_pools(runqueue_t *this_rq, int idle, int *imbalance)
+{
+	runqueue_t *busiest = NULL;
+	int imax, best_cpu = -1, pool, max_pool_load, max_pool_idx, nr_running;
+	int this_cpu = (int)(((void *)this_rq - (void *)cpu_rq(0))/sizeof(runqueue_t));
+	int avg_load, this_pool = CPU_TO_NODE(this_cpu);
+
+	/* Need at least ~25% imbalance to trigger balancing. */
+#define BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
+
+	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+		nr_running = this_rq->nr_running;
+	else
+		nr_running = this_rq->prev_nr_running[this_cpu];
+
+	imax = calc_pool_load(this_rq->load, this_cpu, this_pool, idle);
+	if (imax == this_cpu)
+		goto scan_all;
+
+	/* enough imbalance on local node? */
+	if (!BALANCED(this_rq->load[0][imax],nr_running)) {
+		*imbalance = (this_rq->load[0][imax] - nr_running)/2;
+		busiest = cpu_rq(cpu_logical_map(imax));
+		goto out;
+	}
+
+ scan_all:
+	max_pool_load = this_rq->load[1][this_pool];
+	max_pool_idx = this_pool;
+	avg_load = max_pool_load * pool_nr_cpus[this_pool];
+	for (pool = 0; pool < numpools; pool++) {
+		if (pool == this_pool) continue;
+		imax = calc_pool_load(this_rq->load, this_cpu, pool, idle);
+		avg_load += this_rq->load[1][pool]*pool_nr_cpus[pool];
+		if (this_rq->load[1][pool] > max_pool_load) {
+			max_pool_load = this_rq->load[1][pool];
+			max_pool_idx = pool;
+			best_cpu = imax;
+		}
+	}
+	/* Exit if not enough imbalance on any remote node. */
+	if ((best_cpu < 0) ||
+	    BALANCED(max_pool_load,this_rq->load[1][this_pool])) {
+		this_rq->wait_node = -1;
+		goto out;
+	}
+	avg_load /= smp_num_cpus;
+	if (BALANCED(avg_load,this_rq->load[1][this_pool])) {
+		if (this_rq->wait_node != max_pool_idx) {
+			this_rq->wait_node = max_pool_idx;
+			this_rq->wait_time = jiffies;
+			goto out;
+		} else
+			if (jiffies - this_rq->wait_time < BALANCE_POOL_WAIT)
+				goto out;
+	}
+	/* Enough imbalance in the remote cpu loads? */
+	if (!BALANCED(this_rq->load[0][best_cpu],nr_running)) {
+		*imbalance = (this_rq->load[0][best_cpu] - nr_running)/2;
+		busiest = cpu_rq(cpu_logical_map(best_cpu));
+		this_rq->wait_node = -1;
+	}
+
+ out:
+	return busiest;
+}
+
+/*
  * Current runqueue is empty, or rebalance tick: if there is an
  * inbalance (current runqueue is too short) then pull from
  * busiest runqueue(s).
@@ -480,12 +632,12 @@
  */
 static void load_balance(runqueue_t *this_rq, int idle)
 {
-	int imbalance, nr_running, load, max_load,
-		idx, i, this_cpu = smp_processor_id();
+	int imbalance, nr_running, idx, this_cpu = smp_processor_id();
 	task_t *next = this_rq->idle, *tmp;
-	runqueue_t *busiest, *rq_src;
+	runqueue_t *busiest;
 	prio_array_t *array;
 	list_t *head, *curr;
+	int this_pool=CPU_TO_NODE(this_cpu), take_own;
 
 	/*
 	 * We search all runqueues to find the most busy one.
@@ -509,34 +661,10 @@
 	 * that case we are less picky about moving a task across CPUs and
 	 * take what can be taken.
 	 */
-	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
-		nr_running = this_rq->nr_running;
-	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
 
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < smp_num_cpus; i++) {
-		rq_src = cpu_rq(cpu_logical_map(i));
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
-			load = rq_src->nr_running;
-		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
+	busiest = scan_pools(this_rq, idle, &imbalance);
 
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
-		}
-	}
-
-	if (likely(!busiest))
-		return;
-
-	imbalance = (max_load - nr_running) / 2;
-
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (imbalance < (max_load + 3)/4))
+	if (!busiest)
 		return;
 
 	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
@@ -548,6 +676,14 @@
 		goto out_unlock;
 
 	/*
+	 * Try to steal tasks coming from this_pool, if any
+	 */
+	if (busiest->nr_homenode[this_pool])
+		take_own = 1;
+	else
+		take_own = 0;
+
+	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
 	 * be cache-cold, thus switching CPUs has the least effect
@@ -589,7 +725,8 @@
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		((p) != (rq)->curr) &&					\
-			(tmp->cpus_allowed & (1 << (this_cpu))))
+			(tmp->cpus_allowed & (1 << (this_cpu))) &&	\
+		((take_own && (tmp->node == this_pool)) || !take_own))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr = curr->next;
@@ -605,9 +742,11 @@
 	 */
 	dequeue_task(next, array);
 	busiest->nr_running--;
+	HOMENODE_DEC(busiest,next->node);
 	next->cpu = this_cpu;
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
+	HOMENODE_INC(this_rq,next->node);
 	if (next->prio < current->prio)
 		current->need_resched = 1;
 	if (!idle && --imbalance) {
@@ -1377,6 +1517,142 @@
 		spin_unlock(&rq2->lock);
 }
 
+/* used as counter for round-robin node-scheduling */
+static atomic_t sched_node=ATOMIC_INIT(0);
+
+/*
+ * Find the least loaded CPU on the current node of the task.
+ */
+int sched_best_cpu(struct task_struct *p)
+{
+	int n, best_cpu = p->cpu, cpu, load;
+
+	load = 1000000;
+	for (n = pool_ptr[p->node]; n < pool_ptr[p->node+1]; n++) {
+		cpu = cpu_logical_map(pool_cpus[n]);
+		if (!(p->cpus_allowed & (1UL << cpu)))
+			continue;
+		if (cpu_rq(cpu)->nr_running < load) {
+			best_cpu = cpu;
+			load = cpu_rq(cpu)->nr_running;
+		}
+	}
+	return best_cpu;
+}
+
+/*
+ * Find the node with fewest tasks assigned to it. Don't bother about the
+ * current load of the nodes, the load balancer should take care.
+ */
+int sched_best_node(struct task_struct *p)
+{
+	int n, best_node=0, min_load, pool_load, min_pool=p->node;
+	int pool, load[NR_NODES];
+	unsigned long mask = p->cpus_allowed & cpu_online_map;
+
+	do {
+		best_node = atomic_inc_return(&sched_node) % numpools;
+	} while (!(pool_mask[best_node] & mask));
+
+	for (pool = 0; pool < numpools; pool++)
+		load[pool] = 0;
+
+	for (n = 0; n < smp_num_cpus; n++)
+		for (pool = 0; pool < numpools; pool++)
+			load[pool] += cpu_rq(cpu_logical_map(n))->nr_homenode[pool];
+
+	/* don't count own process, this one will be moved */
+	--load[p->node];
+
+	min_load = 100000000;
+	for (n = 0; n < numpools; n++) {
+		pool = (best_node + n) % numpools;
+		pool_load = (100*load[pool])/pool_nr_cpus[pool];
+		if ((pool_load < min_load) && (pool_mask[pool] & mask)) {
+			min_load = pool_load;
+			min_pool = pool;
+		}
+	}
+	atomic_set(&sched_node, min_pool);
+	return min_pool;
+}
+
+void sched_exec_migrate(void)
+{
+	int new_cpu, new_node;
+
+	if (numpools > 1) {
+		new_node = sched_best_node(current);
+		if (new_node != current->node) {
+			HOMENODE_DEC(this_rq(),current->node);
+			HOMENODE_INC(this_rq(),new_node);
+			current->node = new_node;
+		}
+	}
+	new_cpu = sched_best_cpu(current);
+	if (new_cpu != smp_processor_id())
+		sched_migrate_task(current, new_cpu);
+}
+
+
+void pools_info(void)
+{
+	int i, j;
+
+	printk("CPU pools : %d\n",numpools);
+	for (i=0;i<numpools;i++) {
+		printk("pool %d :",i);
+		for (j=pool_ptr[i];j<pool_ptr[i+1];j++)
+			printk("%d ",pool_cpus[j]);
+		printk("\n");
+	}
+}
+
+void bld_pools(void)
+{
+	int i, j, ptr;
+	int flag[NR_CPUS] = { [ 0 ... NR_CPUS-1] = 0 };
+	unsigned long mask;
+
+	numpools = 0;
+	ptr = 0;
+	for (i = 0; i < smp_num_cpus; i++) {
+		if (!(cpu_online_map & (1<<i))) continue;
+		if (!flag[i]) {
+			pool_ptr[numpools]=ptr;
+			mask = 0UL;
+			for (j = 0; j < smp_num_cpus; j++) {
+				if (! (cpu_online_map & (1<<j))) continue;
+				if (i == j || CPU_TO_NODE(i) == CPU_TO_NODE(j)) {
+					pool_cpus[ptr++]=j;
+					flag[j]=1;
+					mask |= (1<<j);
+				}
+			}
+			pool_nr_cpus[numpools] = ptr - pool_ptr[numpools];
+			pool_mask[numpools] = mask;
+			numpools++;
+		}
+	}
+	pool_ptr[numpools]=ptr;
+	pools_info();
+}
+
+void set_task_node(task_t *p, int node)
+{
+	runqueue_t *rq;
+	unsigned long flags;
+
+	if (node < 0 || node >= numpools) return;
+	rq = task_rq_lock(p, &flags);
+	if (p->array) {
+		HOMENODE_DEC(rq, p->node);
+		HOMENODE_INC(rq, node);
+	}
+	p->node = node;
+	task_rq_unlock(rq, &flags);
+}
+
 void __init init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(idle->cpu);
@@ -1392,6 +1668,7 @@
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpu = cpu;
+	idle->node = SAPICID_TO_NODE(cpu_physical_id(cpu));
 	double_rq_unlock(idle_rq, rq);
 	idle->need_resched = 1;
 	__restore_flags(flags);
@@ -1425,7 +1702,15 @@
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
-	}
+		for (j = 0; j < NR_NODES; j++)
+			rq->nr_homenode[j]=0;
+		pool_cpus[i] = i;
+	}
+	pool_ptr[0] = 0;
+	pool_ptr[1] = NR_CPUS;
+	numpools = 1;
+	pool_mask[0] = -1L;
+	pool_nr_cpus[0] = NR_CPUS;
 	/*
 	 * We have to do a little magic to get the first
 	 * process right in SMP mode.
@@ -1509,10 +1794,20 @@
 	down(&req.sem);
 }
 
-static int migration_thread(void * unused)
+void sched_migrate_task(task_t *p, int dest_cpu)
 {
-	int bind_cpu = (int) (long) unused;
-	int cpu = cpu_logical_map(bind_cpu);
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << cpu_logical_map(dest_cpu))))
+		return;
+	set_cpus_allowed(p, 1UL << cpu_logical_map(dest_cpu));
+	set_cpus_allowed(p, old_mask);
+}
+
+static int migration_thread(void * bind_cpu)
+{
+	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	struct sched_param param = { sched_priority: 99 };
 	runqueue_t *rq;
 	int ret;
diff -urN 2.4.17-ia64-kdbv2.1-K3+/kernel/sys.c 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/sys.c
--- 2.4.17-ia64-kdbv2.1-K3+/kernel/sys.c	Fri Feb  8 12:02:06 2002
+++ 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/sys.c	Tue Mar 12 17:03:06 2002
@@ -1205,6 +1205,8 @@
 {
 	int error = 0;
 	int sig;
+	int pid;
+	struct task_struct *child;
 
 	switch (option) {
 		case PR_SET_PDEATHSIG:
@@ -1272,6 +1274,35 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_GET_NODE:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				error = put_user(child->node,(int *)arg2);
+			} else {
+				printk("prctl: could not find process %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+		case PR_SET_NODE:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				if (child->uid == current->uid || \
+				    current->uid == 0) {
+					printk("setting node of process %d to %d\n",pid,(int)arg2);
+					set_task_node(child,(int)arg2);
+				}
+			} else {
+				printk("prctl: could not find process %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+
 		default:
 			error = -EINVAL;
 			break;

