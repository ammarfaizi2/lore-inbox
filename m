Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJHR2s>; Tue, 8 Oct 2002 13:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSJHR2s>; Tue, 8 Oct 2002 13:28:48 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:55986 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261246AbSJHR2i>; Tue, 8 Oct 2002 13:28:38 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Tue, 8 Oct 2002 19:33:06 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210072209.41880.efocht@ess.nec.de> <1420721189.1034032091@[10.10.2.3]>
In-Reply-To: <1420721189.1034032091@[10.10.2.3]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_6FBORG4IHQPHJ5YCXP28"
Message-Id: <200210081933.06677.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6FBORG4IHQPHJ5YCXP28
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 October 2002 08:08, Martin J. Bligh wrote:
> I did:
>
> 1. remove asm/numa.h declaration (you need to work out something
> generic here ... mmzone.h should include it, I think?)
> 2. changed NR_NODES to MAX_NUMNODES everywhere.
> 3. Put in an extern declartion into fs/exec.c for sched_balance_exec
>
> Then I got bored around the linking problem. Does this compile for
> you somehow?

Aaargh, you got the wrong second patch :-( Sorry for that...

Thanks for the hints, I cleaned up the first patch, too. No
CONFIG_NUMA_SCHED any more, switched to MAX_NUMNODES, including
asm/numa.h from asm/topology.h, so no need for you to see it.

Erich

--------------Boundary-00=_6FBORG4IHQPHJ5YCXP28
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01-numa_sched_core6-2.5.39.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-numa_sched_core6-2.5.39.patch"

diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Fri Sep 27 23:49:54 2002
+++ b/arch/i386/kernel/smpboot.c	Tue Oct  8 11:37:56 2002
@@ -1194,6 +1194,11 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	pooldata_lock();
+	bld_pools();
+	pooldata_unlock();
+#endif
 }
 
 void __init smp_intr_init()
diff -urNp a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Tue Oct  8 10:57:10 2002
+++ b/arch/ia64/kernel/smpboot.c	Tue Oct  8 11:38:17 2002
@@ -397,7 +397,7 @@ unsigned long cache_decay_ticks;	/* # of
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -508,6 +508,11 @@ smp_cpus_done (unsigned int dummy)
 
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+#ifdef CONFIG_NUMA
+	pooldata_lock();
+	bld_pools();
+	pooldata_unlock();
+#endif
 }
 
 int __devinit
diff -urNp a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
--- a/include/asm-i386/atomic.h	Fri Sep 27 23:49:16 2002
+++ b/include/asm-i386/atomic.h	Tue Oct  8 10:59:13 2002
@@ -111,6 +111,18 @@ static __inline__ void atomic_inc(atomic
 }
 
 /**
+ * atomic_inc_return - increment atomic variable and return new value
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1 and return it's new value.  Note that
+ * the guaranteed useful range of an atomic_t is only 24 bits.
+ */
+static inline int atomic_inc_return(atomic_t *v){
+	atomic_inc(v);
+	return v->counter;
+}
+
+/**
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t
  * 
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Oct  8 10:56:28 2002
+++ b/include/linux/sched.h	Tue Oct  8 11:30:21 2002
@@ -22,6 +22,7 @@ extern unsigned long event;
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
+#include <asm/topology.h>
 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
@@ -167,7 +168,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -457,6 +457,12 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void pooldata_lock(void);
+extern void pooldata_unlock(void);
+#endif
+extern void sched_migrate_task(task_t *p, int cpu);
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Sep 27 23:50:27 2002
+++ b/kernel/sched.c	Tue Oct  8 11:19:40 2002
@@ -154,6 +154,10 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
+	unsigned long wait_time;
+	int wait_node;
+	int load[2][NR_CPUS];
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -174,6 +178,95 @@ static struct runqueue runqueues[NR_CPUS
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
+ * Example: loop over all CPUs in a pool p:
+ * loop_over_node(i,node) {
+ *      cpu = pool_cpu(i);
+ *      ...
+ * }
+ *                                                      <efocht@ess.nec.de>
+ */
+int numpools, pool_ptr[MAX_NUMNODES+1], pool_cpus[NR_CPUS], pool_nr_cpus[MAX_NUMNODES];
+unsigned long pool_mask[MAX_NUMNODES];
+static atomic_t pool_lock = ATOMIC_INIT(0);
+#define cpu_to_node(cpu) __cpu_to_node(cpu)
+
+/* Avoid zeroes in integer divides for load calculations */
+#define BALANCE_FACTOR 100
+
+#ifdef CONFIG_NUMA
+#define POOL_DELAY     (100)
+#define loop_over_node(i,n) for(i=pool_ptr[n]; i<pool_ptr[n+1]; i++)
+#define pool_cpu(i) pool_cpus[i]
+
+void pooldata_lock(void)
+{
+	int i;
+ retry:
+	while (atomic_read(&pool_lock));
+	if (atomic_inc_return(&pool_lock) > 1) {
+		atomic_dec(&pool_lock);
+		goto retry;
+	}
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
+	atomic_dec(&pool_lock);
+}
+
+/*
+ * Call pooldata_lock() before calling this function and
+ * pooldata_unlock() after!
+ */
+void bld_pools(void)
+{
+	int n, cpu, ptr, i;
+	unsigned long mask;
+
+	ptr=0;
+	for (n=0; n<numnodes; n++) {
+		mask = pool_mask[n] = __node_to_cpu_mask(n) & cpu_online_map;
+		pool_ptr[n] = ptr;
+		for (cpu=0; cpu<NR_CPUS; cpu++)
+			if (mask  & (1UL << cpu))
+				pool_cpu(ptr++) = cpu;
+		pool_nr_cpus[n] = ptr - pool_ptr[n];
+	}
+	numpools=numnodes;
+	pool_ptr[numpools]=ptr;
+	printk("CPU pools : %d\n",numpools);
+	for (n=0;n<numpools;n++) {
+		printk("pool %d :",n);
+		loop_over_node(i,n)
+			printk("%d ",pool_cpu(i));
+		printk("\n");
+	}
+}
+
+#else
+#define POOL_DELAY  (0)
+#define loop_over_node(i,n) for(i=0; i<NR_CPUS; i++)
+#define pool_cpu(i) (i)
+#endif
+
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -632,121 +725,144 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * Calculate load of a CPU pool, store results in data[][NR_CPUS].
+ * Return the index of the most loaded runqueue.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static int calc_pool_load(int data[][NR_CPUS], int this_cpu, int pool, int idle)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
-
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
-	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
-		nr_running = this_rq->nr_running;
-	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
+	runqueue_t *rq_src, *this_rq = cpu_rq(this_cpu);
+	int i, ii, idx=-1, refload, load;
 
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	data[1][pool] = 0;
+	refload = -1;
 
+	loop_over_node(ii, pool) {
+		i = pool_cpu(ii);
 		rq_src = cpu_rq(i);
 		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
 			load = rq_src->nr_running;
 		else
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;
-
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
+		data[0][i] = load;
+		data[1][pool] += load;
+		if (load > refload) {
+			idx = i;
+			refload = load;
 		}
 	}
+	data[1][pool] = data[1][pool] * BALANCE_FACTOR / pool_nr_cpus[pool];
+	return idx;
+}
 
-	if (likely(!busiest))
-		goto out;
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
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu,
+					     int idle, int *nr_running)
+{
+	runqueue_t *busiest = NULL;
+	int imax, best_cpu, pool, max_pool_load, max_pool_idx;
+	int i, del_shift;
+	int avg_load=-1, this_pool = cpu_to_node(this_cpu);
+
+	/* Need at least ~25% imbalance to trigger balancing. */
+#define BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
+
+	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+		*nr_running = this_rq->nr_running;
+	else
+		*nr_running = this_rq->prev_nr_running[this_cpu];
 
-	*imbalance = (max_load - nr_running) / 2;
+	best_cpu = calc_pool_load(this_rq->load, this_cpu, this_pool, idle);
+	
+	if (best_cpu != this_cpu)
+		goto check_out;
 
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest = NULL;
+ scan_all:
+	best_cpu = -1;
+	max_pool_load = this_rq->load[1][this_pool];
+	max_pool_idx = this_pool;
+	avg_load = max_pool_load * pool_nr_cpus[this_pool];
+	for (i = 1; i < numpools; i++) {
+		pool = (i + this_pool) % numpools;
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
 		goto out;
 	}
+	avg_load /= num_online_cpus();
+	/* Wait longer before stealing if load is average. */
+	if (BALANCED(avg_load,this_rq->load[1][this_pool]))
+		del_shift = 0;
+	else
+		del_shift = 6;
 
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
+	if (this_rq->wait_node != max_pool_idx) {
+		this_rq->wait_node = max_pool_idx;
+		this_rq->wait_time = jiffies;
+		goto out;
+	} else
+		if (jiffies - this_rq->wait_time < (POOL_DELAY >> del_shift))
+			goto out;
+
+ check_out:
+	/* Enough imbalance in the remote cpu loads? */
+	if (!BALANCED(this_rq->load[0][best_cpu],*nr_running)) {
+		busiest = cpu_rq(best_cpu);
+		this_rq->wait_node = -1;
+	} else if (avg_load == -1)
+		/* only scanned local pool, so let's look at all of them */
+		goto scan_all;
+ out:
 	return busiest;
 }
 
 /*
- * pull_task - move a task from a remote runqueue to the local runqueue.
- * Both runqueues must be locked.
+ * Find a task to steal from the busiest RQ. The busiest->lock must be held
+ * while calling this routine. 
  */
-static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+static inline task_t *task_to_steal(runqueue_t *busiest, int this_cpu)
 {
-	dequeue_task(p, src_array);
-	src_rq->nr_running--;
-	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
-	enqueue_task(p, this_rq->active);
-	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
-	 * to be always true for them.
-	 */
-	if (p->prio < this_rq->curr->prio)
-		set_need_resched();
-}
-
-/*
- * Current runqueue is empty, or rebalance tick: if there is an
- * inbalance (current runqueue is too short) then pull from
- * busiest runqueue(s).
- *
- * We call this with the current runqueue locked,
- * irqs disabled.
- */
-static void load_balance(runqueue_t *this_rq, int idle)
-{
-	int imbalance, idx, this_cpu = smp_processor_id();
-	runqueue_t *busiest;
+	int idx;
+	task_t *next = NULL, *tmp;
 	prio_array_t *array;
 	struct list_head *head, *curr;
-	task_t *tmp;
+	int weight, maxweight=0;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
-	if (!busiest)
-		goto out;
+	/*
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed.
+	 */
+
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
+		((jiffies - (p)->sleep_timestamp > cache_decay_ticks) && \
+		p != rq->curr && \
+		 ((p)->cpus_allowed & (1UL<<(this_cpu))))
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -772,7 +888,7 @@ skip_bitmap:
 			array = busiest->active;
 			goto new_array;
 		}
-		goto out_unlock;
+		goto out;
 	}
 
 	head = array->queue + idx;
@@ -780,33 +896,74 @@ skip_bitmap:
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
 
+	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
+		if (weight > maxweight) {
+			maxweight = weight;
+			next = tmp;
+		}
+	}
+	curr = curr->next;
+	if (curr != head)
+		goto skip_queue;
+	idx++;
+	goto skip_bitmap;
+
+ out:
+	return next;
+}
+
+/*
+ * pull_task - move a task from a remote runqueue to the local runqueue.
+ * Both runqueues must be locked.
+ */
+static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+{
+	dequeue_task(p, src_array);
+	src_rq->nr_running--;
+	set_task_cpu(p, this_cpu);
+	this_rq->nr_running++;
+	enqueue_task(p, this_rq->active);
 	/*
-	 * We do not migrate tasks that are:
-	 * 1) running (obviously), or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
-	 * 3) are cache-hot on their current CPU.
+	 * Note that idle threads have a prio of MAX_PRIO, for this test
+	 * to be always true for them.
 	 */
+	if (p->prio < this_rq->curr->prio)
+		set_need_resched();
+}
 
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
+/*
+ * Current runqueue is empty, or rebalance tick: if there is an
+ * inbalance (current runqueue is too short) then pull from
+ * busiest runqueue(s).
+ *
+ * We call this with the current runqueue locked,
+ * irqs disabled.
+ */
+static void load_balance(runqueue_t *this_rq, int idle)
+{
+	int nr_running, this_cpu = task_cpu(this_rq->curr);
+	task_t *tmp;
+	runqueue_t *busiest;
+
+	/* avoid deadlock by timer interrupt on own cpu */
+	if (atomic_read(&pool_lock)) return;
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &nr_running);
+	if (!busiest)
+		goto out;
+
+	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
+	/*
+	 * Make sure nothing changed since we checked the
+	 * runqueue length.
+	 */
+	if (busiest->nr_running <= nr_running + 1)
+		goto out_unlock;
+
+	tmp = task_to_steal(busiest, this_cpu);
+	if (!tmp)
+		goto out_unlock;
+	pull_task(busiest, tmp->array, tmp, this_rq, this_cpu);
 out_unlock:
 	spin_unlock(&busiest->lock);
 out:
@@ -819,10 +976,10 @@ out:
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
@@ -1920,6 +2077,8 @@ typedef struct {
 	struct list_head list;
 	task_t *task;
 	struct completion done;
+	int cpu_dest;
+	int sync;
 } migration_req_t;
 
 /*
@@ -1965,6 +2124,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	}
 	init_completion(&req.done);
 	req.task = p;
+	req.sync = 1;
 	list_add(&req.list, &rq->migration_queue);
 	task_rq_unlock(rq, &flags);
 	wake_up_process(rq->migration_thread);
@@ -1974,6 +2134,17 @@ out:
 	preempt_enable();
 }
 
+void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	set_cpus_allowed(p, 1UL << dest_cpu);
+	set_cpus_allowed(p, old_mask);
+}
+
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
@@ -2009,7 +2180,7 @@ static int migration_thread(void * data)
 	for (;;) {
 		runqueue_t *rq_src, *rq_dest;
 		struct list_head *head;
-		int cpu_src, cpu_dest;
+		int cpu_src, cpu_dest, sync;
 		migration_req_t *req;
 		unsigned long flags;
 		task_t *p;
@@ -2024,10 +2195,17 @@ static int migration_thread(void * data)
 		}
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
-		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		sync = req->sync;
+		if (sync)
+			cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+		else {
+			cpu_dest = req->cpu_dest;
+			req->task = NULL;
+		}
+		spin_unlock_irqrestore(&rq->lock, flags);
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
@@ -2050,7 +2228,8 @@ repeat:
 		double_rq_unlock(rq_src, rq_dest);
 		local_irq_restore(flags);
 
-		complete(&req->done);
+		if (sync)
+			complete(&req->done);
 	}
 }
 
@@ -2130,6 +2309,15 @@ void __init sched_init(void)
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
+#ifdef CONFIG_NUMA
+	pool_ptr[0] = 0;
+	pool_ptr[1] = NR_CPUS;
+
+	numpools = 1;
+	pool_mask[0] = -1L;
+	pool_nr_cpus[0] = NR_CPUS;
+#endif
+
 	/*
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.

--------------Boundary-00=_6FBORG4IHQPHJ5YCXP28
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="02-numa_sched_ilb-2.5.39.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-numa_sched_ilb-2.5.39.patch"

diff -urNp a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Tue Oct  8 15:03:54 2002
+++ b/fs/exec.c	Tue Oct  8 15:08:22 2002
@@ -993,6 +993,7 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Oct  8 15:07:48 2002
+++ b/include/linux/sched.h	Tue Oct  8 15:09:27 2002
@@ -460,6 +460,9 @@ extern void set_cpus_allowed(task_t *p, 
 #ifdef CONFIG_NUMA
 extern void pooldata_lock(void);
 extern void pooldata_unlock(void);
+extern void sched_balance_exec(void);
+#else
+#define sched_balance_exec() {}
 #endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Oct  8 15:07:48 2002
+++ b/kernel/sched.c	Tue Oct  8 15:08:22 2002
@@ -2134,6 +2134,78 @@ out:
 	preempt_enable();
 }
 
+#ifdef CONFIG_NUMA
+/* used as counter for round-robin node-scheduling */
+static atomic_t sched_node=ATOMIC_INIT(0);
+
+/*
+ * Find the least loaded CPU on the current node of the task.
+ */
+static int sched_best_cpu(struct task_struct *p, int node)
+{
+	int n, cpu, load, best_cpu = task_cpu(p);
+	
+	load = 1000000;
+	loop_over_node(n,node) {
+		cpu = pool_cpu(n);
+		if (!(p->cpus_allowed & (1UL << cpu) & cpu_online_map))
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
+ * Find the node with fewest number of tasks running on it.
+ */
+static int sched_best_node(struct task_struct *p)
+{
+	int i, n, best_node=0, min_load, pool_load, min_pool=numa_node_id();
+	int cpu, pool, load;
+	unsigned long mask = p->cpus_allowed & cpu_online_map;
+
+	do {
+		best_node = atomic_inc_return(&sched_node) % numpools;
+	} while (!(pool_mask[best_node] & mask));
+
+	min_load = 100000000;
+	for (n = 0; n < numpools; n++) {
+		pool = (best_node + n) % numpools;
+		load = 0;
+		loop_over_node(i, pool) {
+			cpu=pool_cpu(i);
+			if (!cpu_online(cpu)) continue;
+			load += cpu_rq(cpu)->nr_running;
+		}
+		if (pool == numa_node_id()) load--;
+		pool_load = 100*load/pool_nr_cpus[pool];
+		if ((pool_load < min_load) && (pool_mask[pool] & mask)) {
+			min_load = pool_load;
+			min_pool = pool;
+		}
+	}
+	atomic_set(&sched_node, min_pool);
+	return min_pool;
+}
+
+void sched_balance_exec(void)
+{
+	int new_cpu, new_node=0;
+
+	while (atomic_read(&pool_lock))
+		cpu_relax();
+	if (numpools > 1) {
+		new_node = sched_best_node(current);
+	} 
+	new_cpu = sched_best_cpu(current, new_node);
+	if (new_cpu != smp_processor_id())
+		sched_migrate_task(current, new_cpu);
+}
+#endif
+
 void sched_migrate_task(task_t *p, int dest_cpu)
 {
 	unsigned long old_mask;

--------------Boundary-00=_6FBORG4IHQPHJ5YCXP28--

