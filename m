Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSBYScb>; Mon, 25 Feb 2002 13:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSBYSc0>; Mon, 25 Feb 2002 13:32:26 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:58312 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S291745AbSBYScP>; Mon, 25 Feb 2002 13:32:15 -0500
Date: Mon, 25 Feb 2002 19:32:02 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.21.0202251737420.30318-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Fri, 22 Feb 2002, Mike Kravetz wrote:

> Below is preliminary patch to implement some form of NUMA scheduling
> on top of Ingo's K3 scheduler patch for 2.4.17.  This is VERY early
> code and brings up some issues that need to be discussed/explored in
> more detail.  This patch was created to form a basis for discussion,
> rather than as a solution.  The patch was created for the i386 based
> NUMA system I have access to.  It will not work on other architectures.
> However, the only architecture specific code is a call to initialize
> some of the NUMA specific scheduling data structures.  Therefore, it
> should be trivial to port.

I am yet another one working on the NUMA extension of Ingo's
O(1) scheduler, having IA64 in mind, like Jesse, I guess. It's good to see
that so many people take care of this issue, lets me hope that we'll get a
good solution at the end.

My approach is in some details different from yours therefore I'll append
it to this email. It is for IA64 (DIG64 architectures), works fine on
NEC's AzusA Itanium server and is also meant as a discussion basis, not as
a finished solution/project.

Some basic but minor differences to your patch are:
- The 'cpu sets' are called cpu pools. Arrays for looping over the CPUs
within one pool are provided.
- It is built on top of Ingo's solution for set_cpus_allowed(), let's call
it K3+ (for 2.4.17 kernels).

The more important differences to your patch:
- It adresses the notion of "home node" of a task, this should be the node
from which a task should get its memory and on which it should preferably
run. I'm using this feature together with a memory affinity patch not
included here.
	- Each task gets an additional "node" field in its task_struct,
	- each runqueue tracks the number of tasks from different nodes,
	- tasks coming from a remote node are migrated earlier.
- The load_balancing() concept is different:
	- there are no special time intervals for balancing across pool
	boundaries, the need for this can occur very quickly and I
	have the feeling that 2*250ms is a long time for keeping the 
	nodes unbalanced. This means: each time load_balance() is called
	it _can_ balance across pool boundaries (but doesn't have to).
	- When load_balance() is called it first tries to balance the
	local cpu pool. If this one is well balanced, it will try to
	find the most loaded pool.
	- Each runqueue has its own statistics arrays, thus gathering
	the balancing information happens lockless. The information
	is as "fresh" as possible. Again I think that with 2*250ms the
	info in your cpu sets could be too old for certain cases.
- Initial balancing is done in do_fork() instead of do_execve(). Again: I
collect the current balance information because I have the feeling this
should be as "new" as possible. Using do_fork() means that we don't have
to call smp_migrate_task() (which went away in the latest version from
Ingo, but certainly we'd find some replacement), such that the task has
chances to live long on its initial CPU.
- When balancing initially I tried to take into account the case of cpu
pools of different sizes as well as cpus_allowed masks covering only parts
of a cpu pool.


I didn't address things like topology discovery, either. The topology is
hidden behind a macro called CPU_TO_NODE() and is currently considered to
have two levels (cpus and nodes). It is easy to extend this concept to a
multi-level scheduler (e.g. cpus -> multi-core packages -> nodes ->
supernodes) but I didn't have to (yet?). In such a scheduler the tasks
wouldn't get too far from their home node because we would first try to
balance locally and over short distances.

Also the load balancing decisions are only based on the CPU loads, sure
there are some more criteria we might want to use (memory consumption...).

Coming back to the discussion, which is partly embedded in the
description of the patch:

I like the way how your cpu sets are defined, this is much more elegant
than my solution. But your only way to address a set is by its cpu mask,
which means that when you want to address a set you have to loop over all
smp_num_cpus. With large numbers of cpus this could become a
problem. Anyhow, this is minor and can be changed easilly. As well as the
problem of having cpu sets of different sizes.

Of more concern is the reuse of old balancing data. For busy CPUs I think
the interval of 0.5s is far too long. Maybe this would make more sense if
the data would be some running average, otherwise I would expect mistakes
in the balancing decisions. Especially for the initial balancing, where I
would like to decide on which node the memory of the task should be. But I
still believe that this long term decision should be taken with the best
data available! Just think about quickly forking several tasks: they
might all go to the same node and lead to a terrible imbalance. Not that
bad if you take them to another node after a short while, but quite bad
if all the memory goes to their original node and most of the tasks have
to access it with poor latency.

Would be interesting to hear oppinions on initial balancing. What are the
pros and cons of balancing at do_fork() or do_execve()? And it would be
interesting to learn about other approaches, too...

Best regards,

Erich

diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/arch/ia64/kernel/smpboot.c 2.4.17-ia64-kdbv2.1-K3ia64-nod3/arch/ia64/kernel/smpboot.c
--- 2.4.17-ia64-kdbv2.1-K3ia64/arch/ia64/kernel/smpboot.c	Mon Feb 18 12:26:44 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/arch/ia64/kernel/smpboot.c	Fri Feb 22 14:11:45 2002
@@ -83,6 +83,8 @@
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 volatile int ia64_cpu_to_sapicid[NR_CPUS];
 
+char node_number[NR_CPUS] __cacheline_aligned;
+
 static volatile unsigned long cpu_callin_map;
 
 struct smp_boot_data smp_boot_data __initdata;
@@ -134,6 +136,23 @@
 
 __setup("nointroute", nointroute);
 
+/* simple sort routine for sorting the hardware CPU IDs */
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
+         * To be on the safe side: sort SAPIC IDs of CPUs
+         */
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
@@ -575,3 +618,4 @@
  * So let's try 10 ticks.
  */
 unsigned long cache_decay_ticks=10;
+
diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/include/asm-ia64/smp.h 2.4.17-ia64-kdbv2.1-K3ia64-nod3/include/asm-ia64/smp.h
--- 2.4.17-ia64-kdbv2.1-K3ia64/include/asm-ia64/smp.h	Thu Feb 21 19:33:12 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/include/asm-ia64/smp.h	Mon Feb 25 18:02:45 2002
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
 
diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/include/linux/prctl.h 2.4.17-ia64-kdbv2.1-K3ia64-nod3/include/linux/prctl.h
--- 2.4.17-ia64-kdbv2.1-K3ia64/include/linux/prctl.h	Mon Feb  4 12:41:39 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/include/linux/prctl.h	Mon Feb 25 17:43:54 2002
@@ -26,4 +26,8 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get/set node for node-affine scheduling */
+#define PR_GET_NODE       16
+#define PR_SET_NODE       17
+
 #endif /* _LINUX_PRCTL_H */
diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/include/linux/sched.h 2.4.17-ia64-kdbv2.1-K3ia64-nod3/include/linux/sched.h
--- 2.4.17-ia64-kdbv2.1-K3ia64/include/linux/sched.h	Thu Feb 21 19:33:12 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/include/linux/sched.h	Mon Feb 25 18:02:45 2002
@@ -314,6 +314,9 @@
 	unsigned long cpus_allowed;
 	unsigned int time_slice;
 
+	int node;
+	list_t node_list;
+
 	task_t *next_task, *prev_task;
 
 	struct mm_struct *mm, *active_mm;
diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/kernel/fork.c 2.4.17-ia64-kdbv2.1-K3ia64-nod3/kernel/fork.c
--- 2.4.17-ia64-kdbv2.1-K3ia64/kernel/fork.c	Tue Feb 19 15:09:35 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/kernel/fork.c	Mon Feb 25 18:26:18 2002
@@ -639,11 +639,15 @@
 #ifdef CONFIG_SMP
 	{
 		int i;
+		void sched_best_cpu(struct task_struct *p);
+#if NR_NODES > 1
+		void sched_best_node(struct task_struct *p);
+
+		if (!(clone_flags & CLONE_VM))
+			sched_best_node(p);
+#endif
+		sched_best_cpu(p);
 
-		if (likely(p->cpus_allowed & (1UL<<smp_processor_id())))
-			p->cpu = smp_processor_id();
-		else
-			p->cpu = __ffs(p->cpus_allowed);
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < smp_num_cpus; i++)
 			p->per_cpu_utime[cpu_logical_map(i)] =
diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/kernel/sched.c 2.4.17-ia64-kdbv2.1-K3ia64-nod3/kernel/sched.c
--- 2.4.17-ia64-kdbv2.1-K3ia64/kernel/sched.c	Thu Feb 21 19:40:11 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/kernel/sched.c	Mon Feb 25 18:12:29 2002
@@ -144,6 +144,9 @@
 	int prev_nr_running[NR_CPUS];
 	task_t *migration_thread;
 	list_t migration_queue;
+ 	int nr_homenode[NR_NODES];
+ 	int cpus_load[NR_CPUS];
+ 	int pools_load[NR_NODES];
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -163,6 +166,27 @@
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
+static int numpools;
+static int pool_ptr[NR_NODES+1];
+static int pool_cpus[NR_CPUS];
+static unsigned long pool_mask[NR_NODES];
+
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
@@ -247,10 +271,12 @@
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	rq->nr_homenode[p->node]++;
 }
 
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	rq->nr_homenode[p->node]--;
 	rq->nr_running--;
 	dequeue_task(p, p->array);
 	p->array = NULL;
@@ -341,7 +367,7 @@
 
 void wake_up_forked_process(task_t * p)
 {
-	runqueue_t *rq = this_rq();
+	runqueue_t *rq = task_rq(p);
 
 	spin_lock_irq(&rq->lock);
 	p->state = TASK_RUNNING;
@@ -356,7 +382,7 @@
 		p->prio = effective_prio(p);
 	}
 	INIT_LIST_HEAD(&p->migration_list);
-	p->cpu = smp_processor_id();
+	//p->cpu = smp_processor_id();
 	activate_task(p, rq);
 	spin_unlock_irq(&rq->lock);
 	init_MUTEX(&p->migration_sem);
@@ -471,6 +497,110 @@
 }
 
 /*
+ * Find a runqueue from which to steal a task. We try to do this as locally as
+ * possible because we don't want to let tasks get far from their home node.
+ * This is done in two steps:
+ * 1. First try to find a runqueue within the own CPU pool (AKA node) with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and its
+ * most loaded CPU. Remote runqueues running tasks having their homenode on the
+ * current node are preferred (those tasks count twice in the load calculation).
+ *
+ * This concept can be extended easilly to more than two levels (multi-level
+ * scheduler?), e.g.: CPU -> multi-core package -> node -> supernode...
+ *                                                         <efocht@ess.nec.de>
+ */
+static runqueue_t *scan_pools(runqueue_t *this_rq, int idle, int *curr_running,
+			      int *imbalance)
+{
+	runqueue_t *busiest, *rq_src;
+	int i, ii, load, max_load, pool, max_pool_load, max_pool_idx,
+		best_cpu, nr_running = *curr_running,
+		this_cpu = smp_processor_id(),
+		this_pool = CPU_TO_NODE(this_cpu);
+
+	busiest = NULL;
+	max_load = 1;
+
+	this_rq->pools_load[this_pool] = 0;
+	for (ii = pool_ptr[this_pool]; ii < pool_ptr[this_pool+1]; ii++) {
+		i = pool_cpus[ii];
+		rq_src = cpu_rq(cpu_logical_map(i));
+		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+			load = rq_src->nr_running;
+		else
+			load = this_rq->prev_nr_running[i];
+		this_rq->prev_nr_running[i] = rq_src->nr_running;
+		this_rq->pools_load[this_pool] += load;
+
+		if ((load > max_load) && (rq_src != this_rq)) {
+			busiest = rq_src;
+			max_load = load;
+		}
+	}
+
+	if (likely(!busiest))
+		goto scan_all;
+
+	*imbalance = (max_load - nr_running)/2;
+
+	/* It needs an at least ~25% imbalance to trigger balancing. */
+	if (idle || (*imbalance >= (max_load + 3)/4))
+		goto out;
+	else
+		busiest = NULL;
+
+ scan_all:
+	max_pool_load = this_rq->pools_load[this_pool];
+	max_pool_idx = this_pool;
+	for (pool = 0; pool < numpools; pool++) {
+		if (pool == this_pool) continue; // current pool already done
+		this_rq->pools_load[pool] = 0;
+		for (ii = pool_ptr[pool]; ii < pool_ptr[pool+1]; ii++) {
+			i = pool_cpus[ii];
+			rq_src = cpu_rq(cpu_logical_map(i));
+			if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+				load = rq_src->nr_running;
+			else
+				load = this_rq->prev_nr_running[i];
+			this_rq->prev_nr_running[i] = rq_src->nr_running;
+			/* prefer RQs which have tasks from this node running */
+			load += rq_src->nr_homenode[this_pool];
+			this_rq->cpus_load[i] = load;
+			this_rq->pools_load[pool] += load;
+		}
+		if (this_rq->pools_load[pool] > max_pool_load) {
+			max_pool_load = this_rq->pools_load[pool];
+			max_pool_idx = pool;
+		}
+	}
+	if (likely(max_pool_idx == this_pool))
+		goto out;
+
+	*imbalance = (max_pool_load - this_rq->pools_load[this_pool])/2;
+	/* It needs an at least ~25% imbalance to trigger balancing. */
+	if (!idle && (*imbalance < (max_pool_load + 3)/4))
+		goto out;
+
+	/* find most loaded CPU within pool from which we'll try to steal a task */
+	best_cpu = pool_cpus[pool_ptr[max_pool_idx]];
+	max_load = this_rq->cpus_load[best_cpu];
+	for (ii = pool_ptr[max_pool_idx]+1; ii < pool_ptr[max_pool_idx+1]; ii++) {
+		i = pool_cpus[ii];
+		if (this_rq->cpus_load[i] > max_load) {
+			max_load = this_rq->cpus_load[i];
+			best_cpu = i;
+		}
+	}
+	*imbalance = (max_load - nr_running)/2;
+	/* It needs an at least ~25% imbalance to trigger balancing. */
+	if (idle || (*imbalance >= (max_load + 3)/4))
+		busiest = cpu_rq(cpu_logical_map(best_cpu));
+ out:
+	return busiest;
+}
+
+/*
  * Current runqueue is empty, or rebalance tick: if there is an
  * inbalance (current runqueue is too short) then pull from
  * busiest runqueue(s).
@@ -480,12 +610,12 @@
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
@@ -514,29 +644,9 @@
 	else
 		nr_running = this_rq->prev_nr_running[this_cpu];
 
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < smp_num_cpus; i++) {
-		rq_src = cpu_rq(cpu_logical_map(i));
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
-			load = rq_src->nr_running;
-		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
-
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
-		}
-	}
 
-	if (likely(!busiest))
-		return;
-
-	imbalance = (max_load - nr_running) / 2;
-
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (imbalance < (max_load + 3)/4))
+	busiest = scan_pools(this_rq, idle, &nr_running, &imbalance);
+	if (!busiest)
 		return;
 
 	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
@@ -548,6 +658,14 @@
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
@@ -589,7 +707,8 @@
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		((p) != (rq)->curr) &&					\
-			(tmp->cpus_allowed & (1 << (this_cpu))))
+			(tmp->cpus_allowed & (1 << (this_cpu))) &&	\
+		((take_own && (tmp->node == this_pool)) || !take_own))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr = curr->next;
@@ -605,9 +724,11 @@
 	 */
 	dequeue_task(next, array);
 	busiest->nr_running--;
+	busiest->nr_homenode[next->node]--;
 	next->cpu = this_cpu;
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
+	this_rq->nr_homenode[next->node]++;
 	if (next->prio < current->prio)
 		current->need_resched = 1;
 	if (!idle && --imbalance) {
@@ -1436,31 +1557,111 @@
 		spin_unlock(&rq2->lock);
 }
 
-int sched_move_task(task_t *p, int src_cpu, int tgt_cpu)
+/* used as counter for round-robin node-scheduling */
+static atomic_t sched_node=ATOMIC_INIT(0);
+
+/*
+ * Find the least loaded CPU on the current node of the task.
+ */
+void sched_best_cpu(struct task_struct *p)
 {
-	int res = 0;
-	unsigned long flags;
-	runqueue_t *src = cpu_rq(src_cpu);
-	runqueue_t *tgt = cpu_rq(tgt_cpu);
+	int nn, best_node = p->node, best_cpu, cpu, load, min_load;
 
-	local_irq_save(flags);
-	double_rq_lock(src, tgt);
-	if (task_rq(p) != src || p == src->curr)
-		goto out;
-	if (p->cpu != tgt_cpu) {
-		p->cpu = tgt_cpu;
-		if (p->array) {
-			deactivate_task(p, src);
-			activate_task(p, tgt);
+	best_cpu = p->cpu;
+	min_load = task_rq(p)->nr_running;
+	for (nn = pool_ptr[best_node]; nn < pool_ptr[best_node+1]; nn++) {
+		cpu = cpu_logical_map(pool_cpus[nn]);
+		if (p->cpus_allowed & (1UL << cpu))
+			continue;
+		load = cpu_rq(cpu)->nr_running;
+		if (load < min_load) {
+			best_cpu = cpu;
+			min_load = load;
 		}
 	}
-	res = 1;
- out:
-	double_rq_unlock(src, tgt);
-	local_irq_restore(flags);
-	return res;
+	p->cpu  = best_cpu;
+}
+
+/*
+ * Find the (relatively) least loaded node for the given process taking into
+ * account the cpus_allowed mask. Try to Round Robin search for the best node.
+ */
+void sched_best_node(struct task_struct *p)
+{
+	int i, nn, node=0, best_node, load, min_load;
+	int pool_load[NR_NODES] = { [0 ... NR_NODES-1] = 0};
+	int cpus_per_node[NR_NODES] = { [0 ... NR_NODES-1] = 0};
+	unsigned long mask = p->cpus_allowed & cpu_online_map;
+
+	do {
+		best_node = atomic_inc_return(&sched_node) % numpools;
+	} while (!(pool_mask[best_node] & mask));
+
+	for (i = 0; i < smp_num_cpus; i++) {
+		int cpu = cpu_logical_map(i);
+		if (!(mask & (1<<cpu)))
+			continue;
+		load = cpu_rq(cpu)->nr_running;
+		node = CPU_TO_NODE(cpu);
+		cpus_per_node[node]++;
+		pool_load[node] += 1000*load;
+	}
+	min_load = pool_load[best_node] / cpus_per_node[node];
+	for (nn = 1; nn < numpools; nn++) {
+		node = (best_node + nn) % numpools;
+		if (cpus_per_node[node] > 0) {
+			load = pool_load[node] / cpus_per_node[node];
+			if (load < min_load) {
+				min_load = load;
+				best_node = node;
+			}
+		}
+	}
+	p->node = best_node;
+	atomic_set(&sched_node, best_node);
 }
 
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
+			pool_mask[numpools]=mask;
+			numpools++;
+		}
+	}
+	pool_ptr[numpools]=ptr;
+	pools_info();
+}
 
 void __init init_idle(task_t *idle, int cpu)
 {
@@ -1477,6 +1678,7 @@
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpu = cpu;
+	idle->node = SAPICID_TO_NODE(cpu_physical_id(cpu));
 	double_rq_unlock(idle_rq, rq);
 	idle->need_resched = 1;
 	__restore_flags(flags);
@@ -1510,6 +1712,8 @@
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
+		for (j = 0; j < NR_NODES; j++)
+			rq->nr_homenode[j]=0;
 	}
 	/*
 	 * We have to do a little magic to get the first
diff -urN 2.4.17-ia64-kdbv2.1-K3ia64/kernel/sys.c 2.4.17-ia64-kdbv2.1-K3ia64-nod3/kernel/sys.c
--- 2.4.17-ia64-kdbv2.1-K3ia64/kernel/sys.c	Fri Feb  8 12:02:06 2002
+++ 2.4.17-ia64-kdbv2.1-K3ia64-nod3/kernel/sys.c	Mon Feb 25 17:56:55 2002
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
+					child->node = (int)arg2;
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



