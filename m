Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJYRb6>; Fri, 25 Oct 2002 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSJYRb6>; Fri, 25 Oct 2002 13:31:58 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:11461 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261505AbSJYRbt>; Fri, 25 Oct 2002 13:31:49 -0400
From: Erich Focht <efocht@ess.nec.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA scheduler 1/2
Date: Fri, 25 Oct 2002 19:37:53 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Theurer <habanero@us.ibm.com>
References: <200210111954.30447.efocht@ess.nec.de>
In-Reply-To: <200210111954.30447.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5ZSJOKQKKB2E6WAW0JIP"
Message-Id: <200210251937.53335.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_5ZSJOKQKKB2E6WAW0JIP
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Here come the rediffed (for 2.5.44) patches for my version of the
NUMA scheduler extensions. I'm only sending the first two parts of
the complete set of 5 patches (which make the node affine NUMA scheduler
with dynamic homenode selection). The two patches lead to a pooling
NUMA scheduler with initial load balancing at exec().

The balancing strategy so far is:
- try to balance inside the own node
- when balancing across nodes, try to avoid big differences in node loads=
=2E
- when doing an exec(), move the task to the least loaded node.

On a 16 CPU NEC Azusa these two patches lead to roughly a factor of 4
improvement in the "hackbench" test of Rusty (which he now calls
schedbench).

Patch descriptions are as in my previous post:
01-numa_sched_core-2.5.44-10a.patch :
       Provides basic NUMA functionality. It implements CPU pools
       with all the mess needed to initialize them. Also it has a
       node aware find_busiest_queue() which first scans the own
       node for more loaded CPUs. If no steal candidate is found on
       the own node, it finds the most loaded node and tries to steal
       a task from it. By steal delays for remote node steals it
       tries to achieve equal node load. These delays can be extended
       to cope with multi-level node hierarchies (that patch is not
       included).
02-numa_sched_ilb-2.5.44-10.patch :
       This patch provides simple initial load balancing during exec().
       It is node aware and will select the least loaded node. Also it
       does a round-robin initial node selection to distribute the load
       better across the nodes.

The patches should run on ia32 NUMAQ and ia64 Azusa & TX7. Other
architectures just need the build_node() call similar to
arch/i386/kernel/smpboot.c. Be careful to REALLY initialize
cache_decay_ticks (that shouldn't be zero on an SMP machine, anyway).

The first patch provides important infrastructure for any following
NUMA scheduler patches. It introduces CPU pools and a way to loop over
single CPU pools. The pool data initialization is somewhat messy and
sensitive. I'm trying to rewrite it to use RCU, anyway the problem is
that we have to initialize the pool data to something reasonable before
we know how many CPUs will be up and before the cpu_to_node() macro
delivers reasonable numbers. Later on the pool data must be initialized
(and could be changed by CPU hotplug) in a way that goes unnoticed by
the load balancer...

Regards,
Erich

--------------Boundary-00=_5ZSJOKQKKB2E6WAW0JIP
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="01-numa_sched_core-2.5.44-10a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-numa_sched_core-2.5.44-10a.patch"

diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Sat Oct 19 06:01:53 2002
+++ b/arch/i386/kernel/smpboot.c	Fri Oct 25 18:07:58 2002
@@ -1195,6 +1195,9 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	build_pools();
+#endif
 }
 
 void __init smp_intr_init()
diff -urNp a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Sat Oct 19 06:01:18 2002
+++ b/arch/ia64/kernel/smpboot.c	Fri Oct 25 18:07:58 2002
@@ -396,7 +396,7 @@ unsigned long cache_decay_ticks;	/* # of
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -481,6 +481,9 @@ smp_cpus_done (unsigned int dummy)
 
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+#ifdef CONFIG_NUMA
+	build_pools();
+#endif
 }
 
 int __devinit
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat Oct 19 06:01:11 2002
+++ b/include/linux/sched.h	Fri Oct 25 18:07:58 2002
@@ -22,6 +22,7 @@ extern unsigned long event;
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
+#include <asm/topology.h>
 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
@@ -157,7 +158,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -443,6 +443,13 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void build_pools(void);
+extern void pooldata_lock(void);
+extern void pooldata_unlock(void);
+#endif
+extern void sched_migrate_task(task_t *p, int cpu);
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Oct 19 06:02:28 2002
+++ b/kernel/sched.c	Fri Oct 25 18:56:13 2002
@@ -157,6 +157,9 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
+	unsigned long wait_time;
+	int wait_node;
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -177,6 +180,103 @@ static struct runqueue runqueues[NR_CPUS
 #endif
 
 /*
+ * Variables for describing and accessing processor pools. Using a
+ * compressed row format like notation. Processor pools are treated
+ * like logical node numbers.
+ *
+ * numpools: number of CPU pools (nodes),
+ * pool_cpus[]: CPUs in pools sorted by their pool ID,
+ * pool_ptr[pool]: index of first element in pool_cpus[] belonging to pool.
+ * pool_mask[]: cpu mask of a pool.
+ *
+ * Example: loop over all CPUs in a node:
+ * loop_over_node(i,cpu,node) {
+ *      // "cpu" is set to each CPU in the node
+ *      // "i" is needed as a loop index, should be of int type
+ *      ...
+ * }
+ *                                                      <efocht@ess.nec.de>
+ */
+int numpools, pool_ptr[MAX_NUMNODES+1], pool_nr_cpus[MAX_NUMNODES];
+unsigned long pool_mask[MAX_NUMNODES];
+static spinlock_t pool_lock = SPIN_LOCK_UNLOCKED;
+#define cpu_to_node(cpu) __cpu_to_node(cpu)
+
+/* Avoid zeroes in integer divides for load calculations */
+#define BALANCE_FACTOR 100
+
+#ifdef CONFIG_NUMA
+int pool_cpus[NR_CPUS];
+#define POOL_DELAY_IDLE  (1*HZ/1000)
+#define POOL_DELAY_BUSY  (20*HZ/1000)
+#define loop_over_node(i,cpu,n) \
+	for(i=pool_ptr[n], cpu=pool_cpus[i]; i<pool_ptr[n+1]; i++, cpu=pool_cpus[i])
+
+void pooldata_lock(void)
+{
+	int i;
+	spin_lock(&pool_lock);
+	/* 
+	 * Wait a while, any loops using pool data should finish
+	 * in between. This is VERY ugly and should be replaced
+	 * by some real RCU stuff. [EF]
+	 */
+	for (i=0; i<100; i++)
+		udelay(1000);
+}
+
+void pooldata_unlock(void)
+{
+	spin_unlock(&pool_lock);
+}
+
+#define pooldata_is_locked() spin_is_locked(&pool_lock)
+
+/*
+ * Call pooldata_lock() before calling this function and
+ * pooldata_unlock() after!
+ */
+void build_pools(void)
+{
+	int n, cpu, ptr, i;
+	unsigned long mask;
+
+	pooldata_lock();
+	ptr=0;
+	for (n=0; n<numnodes; n++) {
+		mask = pool_mask[n] = __node_to_cpu_mask(n) & cpu_online_map;
+		pool_ptr[n] = ptr;
+		for (cpu=0; cpu<NR_CPUS; cpu++)
+			if (mask  & (1UL << cpu))
+				pool_cpus[ptr++] = cpu;
+		pool_nr_cpus[n] = ptr - pool_ptr[n];
+	}
+	numpools=numnodes;
+	pool_ptr[numpools]=ptr;
+	printk("CPU pools : %d\n",numpools);
+	for (n=0;n<numpools;n++) {
+		printk("pool %d :",n);
+		loop_over_node(i,cpu,n)
+			printk("%d ",cpu);
+		printk("\n");
+	}
+	if (cache_decay_ticks==1)
+		printk("WARNING: cache_decay_ticks=1, probably unset by platform. Running with poor CPU affinity!\n");
+#ifdef CONFIG_X86_NUMAQ
+	/* temporarilly set this to a reasonable value for NUMAQ */
+	cache_decay_ticks=8;
+#endif
+	pooldata_unlock();
+}
+
+#else
+#define POOL_DELAY_IDLE 0
+#define POOL_DELAY_BUSY 0
+#define loop_over_node(i,cpu,n) for(cpu=0; cpu<NR_CPUS; cpu++)
+#endif
+
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -635,81 +735,222 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * Calculate load of a CPU pool, return it in pool_load, return load
+ * of most loaded CPU in cpu_load.
+ * Return the index of the most loaded runqueue.
+ */
+static int calc_pool_load(int *pool_load, int *cpu_load, int this_cpu, int pool, int idle)
+{
+	runqueue_t *rq_src, *this_rq = cpu_rq(this_cpu);
+	int i, cpu, idx=-1, refload, load;
+
+	*pool_load = 0;
+	refload = -1;
+	loop_over_node(i, cpu, pool) {
+		if (!cpu_online(i)) continue;
+		rq_src = cpu_rq(cpu);
+		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[cpu]))
+			load = rq_src->nr_running;
+		else
+			load = this_rq->prev_nr_running[cpu];
+		this_rq->prev_nr_running[cpu] = rq_src->nr_running;
+		*pool_load += load;
+		if (load > refload) {
+			idx = cpu;
+			refload = load;
+		}
+	}
+	*cpu_load = refload;
+	*pool_load = *pool_load * BALANCE_FACTOR / pool_nr_cpus[pool];
+	return idx;
+}
+
+#ifdef CONFIG_NUMA
+/*
+ * Scan the load of all pools/nodes, find the most loaded one and the
+ * most loaded CPU on it. Returns:
+ *  -1         : if no steal should occur,
+ *  cpu number : steal should by attempted from the given cpu.
+ *
+ * This routine implements node balancing by delaying steals from remote
+ * nodes more if the own node is (within margins) averagely loaded. The
+ * most loaded node is remembered as well as the time (jiffies). In the
+ * following calls to the load_balancer the time is compared with
+ * POOL_DELAY_BUSY (if load is around the average) or POOL_DELAY_IDLE (if own
+ * node is unloaded) if the most loaded node didn't change. This gives less 
+ * loaded nodes the chance to approach the average load but doesn't exclude
+ * busy nodes from stealing (just in case the cpus_allowed mask isn't good
+ * for the idle nodes).
+ * This concept can be extended easilly to more than two levels (multi-level
+ * scheduler), e.g.: CPU -> node -> supernode... by implementing node-distance
+ * dependent steal delays.
+ *							<efocht@ess.nec.de>
+ */
+static inline 
+int scan_other_pools(int *max_cpu_load, int this_pool_load,
+		     int this_pool, int this_cpu, int idle)
+{
+	int i, imax, max_pool_load, max_pool_idx, best_cpu=-1;
+	int pool, pool_load, cpu_load, steal_delay, avg_load;
+	runqueue_t *this_rq = cpu_rq(this_cpu);
+
+#define POOLS_BALANCED(comp,this) (((comp) -(this)) < 50)
+	best_cpu = -1;
+	max_pool_load = this_pool_load;
+	max_pool_idx = this_pool;
+	avg_load = max_pool_load * pool_nr_cpus[this_pool];
+	for (i = 1; i < numpools; i++) {
+		pool = (i + this_pool) % numpools;
+		imax = calc_pool_load(&pool_load, &cpu_load, this_cpu, pool, idle);
+		avg_load += pool_load*pool_nr_cpus[pool];
+		if (pool_load > max_pool_load) {
+			max_pool_load = pool_load;
+			*max_cpu_load = cpu_load;
+			max_pool_idx = pool;
+			best_cpu = imax;
+		}
+	}
+	/* Exit if not enough imbalance on any remote node. */
+	if ((best_cpu < 0) || (max_pool_load <= 100) ||
+	    POOLS_BALANCED(max_pool_load,this_pool_load)) {
+		this_rq->wait_node = -1;
+		return -1;
+	}
+	avg_load /= num_online_cpus();
+	/* Wait longer before stealing if own pool's load is average. */
+	if (POOLS_BALANCED(avg_load,this_pool_load))
+		steal_delay = POOL_DELAY_BUSY;
+	else
+		steal_delay = POOL_DELAY_IDLE;
+	/* if we have a new most loaded node: just mark it */
+	if (this_rq->wait_node != max_pool_idx) {
+		this_rq->wait_node = max_pool_idx;
+		this_rq->wait_time = jiffies;
+		return -1;
+	} else
+		/* old most loaded node: check if waited enough */
+		if (jiffies - this_rq->wait_time < steal_delay)
+			return -1;
+	return best_cpu;
+}
+#endif
+
+/*
+ * Find a runqueue from which to steal a task. We try to do this as locally as
+ * possible because we don't want to let tasks get far from their node.
+ * This is done in two steps:
+ * 1. First try to find a runqueue within the own CPU pool (AKA node) with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and its
+ * most loaded CPU. This is handled in scan_other_pools().
+ *                                                         <efocht@ess.nec.de>
+ */
+static inline runqueue_t *find_busiest_queue(int this_cpu, int idle, int *nr_running)
+{
+	runqueue_t *busiest = NULL, *this_rq = cpu_rq(this_cpu);
+	int best_cpu, max_cpu_load;
+	int this_pool, this_pool_load;
+
+	/* Need at least ~25% imbalance to trigger balancing. */
+#define CPUS_BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
+
+	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+		*nr_running = this_rq->nr_running;
+	else
+		*nr_running = this_rq->prev_nr_running[this_cpu];
+
+	this_pool = (numpools == 1 ? 0 : cpu_to_node(this_cpu));
+	best_cpu = calc_pool_load(&this_pool_load, &max_cpu_load, this_cpu, this_pool, idle);
+	if (best_cpu != this_cpu)
+		if (!CPUS_BALANCED(max_cpu_load,*nr_running)) {
+			busiest = cpu_rq(best_cpu);
+			this_rq->wait_node = -1;
+			goto out;
+		}
+#ifdef CONFIG_NUMA
+	if (numpools > 1) {
+		best_cpu = scan_other_pools(&max_cpu_load, this_pool_load, this_pool, this_cpu, idle);
+		if ((best_cpu >= 0) &&
+		    (!CPUS_BALANCED(max_cpu_load,*nr_running))) {
+			busiest = cpu_rq(best_cpu);
+			this_rq->wait_node = -1;
+		}
+	}
+#endif
+ out:
+	return busiest;
+}
+
+/*
+ * Find a task to steal from the busiest RQ. The busiest->lock must be held
+ * while calling this routine. 
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline task_t *task_to_steal(runqueue_t *busiest, int this_cpu)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+	int idx;
+	task_t *next = NULL, *tmp;
+	prio_array_t *array;
+	struct list_head *head, *curr;
+	int weight, maxweight=0;
 
 	/*
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
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed.
 	 */
-	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
-		nr_running = this_rq->nr_running;
-	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
 
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
+		((jiffies - (p)->sleep_timestamp > cache_decay_ticks) && \
+		p != rq->curr && \
+		 ((p)->cpus_allowed & (1UL<<(this_cpu))))
 
-		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
-			load = rq_src->nr_running;
-		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
+	/*
+	 * We first consider expired tasks. Those will likely not be
+	 * executed in the near future, and they are most likely to
+	 * be cache-cold, thus switching CPUs has the least effect
+	 * on them.
+	 */
+	if (busiest->expired->nr_active)
+		array = busiest->expired;
+	else
+		array = busiest->active;
 
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
+new_array:
+	/* Start searching at priority 0: */
+	idx = 0;
+skip_bitmap:
+	if (!idx)
+		idx = sched_find_first_bit(array->bitmap);
+	else
+		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
+	if (idx == MAX_PRIO) {
+		if (array == busiest->expired) {
+			array = busiest->active;
+			goto new_array;
 		}
-	}
-
-	if (likely(!busiest))
 		goto out;
+	}
 
-	*imbalance = (max_load - nr_running) / 2;
+	head = array->queue + idx;
+	curr = head->prev;
+skip_queue:
+	tmp = list_entry(curr, task_t, run_list);
 
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest = NULL;
-		goto out;
+	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
+		if (weight > maxweight) {
+			maxweight = weight;
+			next = tmp;
+		}
 	}
+	curr = curr->next;
+	if (curr != head)
+		goto skip_queue;
+	idx++;
+	goto skip_bitmap;
 
-	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <= nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest = NULL;
-	}
-out:
-	return busiest;
+ out:
+	return next;
 }
 
 /*
@@ -741,75 +982,28 @@ static inline void pull_task(runqueue_t 
  */
 static void load_balance(runqueue_t *this_rq, int idle)
 {
-	int imbalance, idx, this_cpu = smp_processor_id();
-	runqueue_t *busiest;
-	prio_array_t *array;
-	struct list_head *head, *curr;
+	int nr_running, this_cpu = task_cpu(this_rq->curr);
 	task_t *tmp;
+	runqueue_t *busiest;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	/* avoid deadlock by timer interrupt on own cpu */
+	if (pooldata_is_locked()) return;
+	busiest = find_busiest_queue(this_cpu, idle, &nr_running);
 	if (!busiest)
 		goto out;
 
+	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
 	/*
-	 * We first consider expired tasks. Those will likely not be
-	 * executed in the near future, and they are most likely to
-	 * be cache-cold, thus switching CPUs has the least effect
-	 * on them.
+	 * Make sure nothing changed since we checked the
+	 * runqueue length.
 	 */
-	if (busiest->expired->nr_active)
-		array = busiest->expired;
-	else
-		array = busiest->active;
-
-new_array:
-	/* Start searching at priority 0: */
-	idx = 0;
-skip_bitmap:
-	if (!idx)
-		idx = sched_find_first_bit(array->bitmap);
-	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx == MAX_PRIO) {
-		if (array == busiest->expired) {
-			array = busiest->active;
-			goto new_array;
-		}
+	if (busiest->nr_running <= nr_running + 1)
 		goto out_unlock;
-	}
-
-	head = array->queue + idx;
-	curr = head->prev;
-skip_queue:
-	tmp = list_entry(curr, task_t, run_list);
 
-	/*
-	 * We do not migrate tasks that are:
-	 * 1) running (obviously), or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
-	 * 3) are cache-hot on their current CPU.
-	 */
-
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
-
-	curr = curr->prev;
-
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
-	}
-	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
-	}
+	tmp = task_to_steal(busiest, this_cpu);
+	if (!tmp)
+		goto out_unlock;
+	pull_task(busiest, tmp->array, tmp, this_rq, this_cpu);
 out_unlock:
 	spin_unlock(&busiest->lock);
 out:
@@ -822,10 +1016,10 @@ out:
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
@@ -2033,10 +2227,11 @@ static int migration_thread(void * data)
 		}
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
-		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+		spin_unlock_irqrestore(&rq->lock, flags);
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
@@ -2135,7 +2330,17 @@ void __init sched_init(void)
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
+#ifdef CONFIG_NUMA
+		pool_cpus[i] = i;
+#endif
 	}
+	numpools = 1;
+	pool_ptr[0] = 0;
+	pool_ptr[1] = NR_CPUS;
+	pool_mask[0] = -1L;
+	pool_nr_cpus[0] = NR_CPUS;
+	if (!cache_decay_ticks)
+		cache_decay_ticks=1;
 	/*
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.

--------------Boundary-00=_5ZSJOKQKKB2E6WAW0JIP--

