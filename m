Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJ1RUf>; Mon, 28 Oct 2002 12:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJ1RUf>; Mon, 28 Oct 2002 12:20:35 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:62343 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261363AbSJ1RU2>; Mon, 28 Oct 2002 12:20:28 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Mon, 28 Oct 2002 18:26:37 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200210280132.33624.efocht@ess.nec.de> <200210281734.41115.efocht@ess.nec.de> <524720000.1035824241@flay>
In-Reply-To: <524720000.1035824241@flay>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DGCPZTTZF56GQGMWNU79"
Message-Id: <200210281826.37451.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DGCPZTTZF56GQGMWNU79
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 28 October 2002 17:57, Martin J. Bligh wrote:
> > I'm preparing a core patch which doesn't need the pool_lock. I'll sen=
d it
> > out today.
>
> Cool! Thanks,

OK, here it comes. The core doesn't use the loop_over_nodes() macro any
more. There's one big loop over the CPUs for computing node loads and
the most loaded CPUs in find_busiest_queue. The call to build_cpus()
isn't critical any more. Functionality is the same as in the previous
patch (i.e. steal delays, ranking of task_to_steal, etc...).

I kept the loop_over_node() macro for compatibility reasons with the
additional patches. You might need to replace in the additional patches:
numpools -> numpools()
pool_nr_cpus[] -> pool_ncpus()

I'm puzzled about the initial load balancing impact and have to think
about the results I've seen from you so far... In the environments I am
used to, the frequency of exec syscalls is rather low, therefore I didn't
care too much about the sched_balance_exec performance and prefered to
try harder to achieve good distribution across the nodes.

Regards,
Erich

--------------Boundary-00=_DGCPZTTZF56GQGMWNU79
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01-numa_sched_core-2.5.39-12b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-numa_sched_core-2.5.39-12b.patch"

diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Fri Sep 27 23:49:54 2002
+++ b/arch/i386/kernel/smpboot.c	Mon Oct 28 10:15:28 2002
@@ -1194,6 +1194,9 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	build_pools();
+#endif
 }
 
 void __init smp_intr_init()
diff -urNp a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Tue Oct 22 15:46:38 2002
+++ b/arch/ia64/kernel/smpboot.c	Mon Oct 28 10:15:28 2002
@@ -397,7 +397,7 @@ unsigned long cache_decay_ticks;	/* # of
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -508,6 +508,9 @@ smp_cpus_done (unsigned int dummy)
 
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+#ifdef CONFIG_NUMA
+	build_pools();
+#endif
 }
 
 int __devinit
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Oct  8 15:03:54 2002
+++ b/include/linux/sched.h	Mon Oct 28 12:12:22 2002
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
@@ -457,6 +457,9 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void build_pools(void);
+#endif
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Sep 27 23:50:27 2002
+++ b/kernel/sched.c	Mon Oct 28 16:59:23 2002
@@ -154,6 +154,9 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
+	unsigned long wait_time;
+	int wait_node;
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -173,6 +176,62 @@ static struct runqueue runqueues[NR_CPUS
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+#define cpu_to_node(cpu) __cpu_to_node(cpu)
+
+#ifdef CONFIG_NUMA
+/* Number of CPUs per pool: sane values until all CPUs are up */
+int _pool_nr_cpus[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = NR_CPUS };
+int pool_cpus[NR_CPUS];		/* list of cpus sorted by node number */
+int pool_ptr[MAX_NUMNODES+1];	/* pointer into the sorted list */
+unsigned long pool_mask[MAX_NUMNODES];
+#define numpools() numnodes
+#define pool_ncpus(pool)  _pool_nr_cpus[pool]
+
+#define POOL_DELAY_IDLE  (1*HZ/1000)
+#define POOL_DELAY_BUSY  (20*HZ/1000)
+
+#define loop_over_node(i,cpu,n) \
+	for(i=pool_ptr[n], cpu=pool_cpus[i]; i<pool_ptr[n+1]; \
+		    i++, cpu=pool_cpus[i])
+
+
+/*
+ * Build pool data after all CPUs have come up.
+ */
+void build_pools(void)
+{
+	int n, cpu, ptr;
+	unsigned long mask;
+
+	ptr=0;
+	for (n=0; n<numnodes; n++) {
+		mask = pool_mask[n] = __node_to_cpu_mask(n) & cpu_online_map;
+		pool_ptr[n] = ptr;
+		for (cpu=0; cpu<NR_CPUS; cpu++)
+			if (mask  & (1UL << cpu))
+				pool_cpus[ptr++] = cpu;
+		pool_ncpus(n) = ptr - pool_ptr[n];;
+	}
+	printk("CPU pools : %d\n",numpools());
+	for (n=0;n<numpools();n++)
+		printk("pool %d : %lx\n",n,pool_mask[n]);
+	if (cache_decay_ticks==1)
+		printk("WARNING: cache_decay_ticks=1, probably unset by platform. Running with poor CPU affinity!\n");
+#ifdef CONFIG_X86_NUMAQ
+	/* temporarilly set this to a reasonable value for NUMAQ */
+	cache_decay_ticks=8;
+#endif
+}
+
+#else
+#define numpools() 1
+#define pool_ncpus(pool)  num_online_cpus()
+#define POOL_DELAY_IDLE 0
+#define POOL_DELAY_BUSY 0
+#define loop_over_node(i,cpu,n) for(cpu=0; cpu<NR_CPUS; cpu++)
+#endif
+
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -632,121 +691,146 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
- */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
-{
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+ * Find a runqueue from which to steal a task. We try to do this as locally as
+ * possible because we don't want to let tasks get far from their node.
+ * 
+ * 1. First try to find a runqueue within the own CPU pool (AKA node) with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and its
+ * most loaded CPU.
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
+ *
+ *                                                         <efocht@ess.nec.de>
+ */
+static inline runqueue_t *find_busiest_queue(int this_cpu, int idle, int *nr_running)
+{
+	runqueue_t *busiest = NULL, *this_rq = cpu_rq(this_cpu), *src_rq;
+	int best_cpu, this_pool, max_pool_load, pool_idx;
+	int pool_load[MAX_NUMNODES], cpu_load[MAX_NUMNODES];
+	int cpu_idx[MAX_NUMNODES];
+	int cpu, pool, load, avg_load, i, steal_delay;
+
+	/* Need at least ~25% imbalance to trigger balancing. */
+#define CPUS_BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
 
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
-
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+		*nr_running = this_rq->prev_nr_running[this_cpu];
 
-		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
-			load = rq_src->nr_running;
+	/* compute all pool loads and save their max cpu loads */
+	for (pool=0; pool<MAX_NUMNODES; pool++)
+		cpu_load[pool] = -1;
+
+	for (cpu=0; cpu<NR_CPUS; cpu++) {
+		if (!cpu_online(cpu)) continue;
+		pool = cpu_to_node(cpu);
+		src_rq = cpu_rq(cpu);
+		if (idle || (src_rq->nr_running < this_rq->prev_nr_running[cpu]))
+			load = src_rq->nr_running;
 		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
+			load = this_rq->prev_nr_running[cpu];
+		this_rq->prev_nr_running[cpu] = src_rq->nr_running;
 
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
+		pool_load[pool] += load;
+		if (load > cpu_load[pool]) {
+			cpu_load[pool] = load;
+			cpu_idx[pool] = cpu;
 		}
 	}
 
-	if (likely(!busiest))
-		goto out;
+	this_pool = cpu_to_node(this_cpu);
+	best_cpu = cpu_idx[this_pool];
+	if (best_cpu != this_cpu)
+		if (!CPUS_BALANCED(cpu_load[this_pool],*nr_running)) {
+			busiest = cpu_rq(best_cpu);
+			this_rq->wait_node = -1;
+			goto out;
+		}
+#ifdef CONFIG_NUMA
 
-	*imbalance = (max_load - nr_running) / 2;
+#define POOLS_BALANCED(comp,this) (((comp) -(this)) < 50)
+	avg_load = pool_load[this_pool];
+	pool_load[this_pool] = max_pool_load = 
+		pool_load[this_pool]*100/pool_ncpus(this_pool);
+	pool_idx = this_pool;
+	for (i = 1; i < numpools(); i++) {
+		pool = (i + this_pool) % numpools();
+		avg_load += pool_load[pool];
+		pool_load[pool]=pool_load[pool]*100/pool_ncpus(pool);
+		if (pool_load[pool] > max_pool_load) {
+			max_pool_load = pool_load[pool];
+			pool_idx = pool;
+		}
+	}
 
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest = NULL;
+	best_cpu = (pool_idx==this_pool) ? -1 : cpu_idx[pool_idx];
+	/* Exit if not enough imbalance on any remote node. */
+	if ((best_cpu < 0) || (max_pool_load <= 100) ||
+	    POOLS_BALANCED(max_pool_load,pool_load[this_pool])) {
+		this_rq->wait_node = -1;
 		goto out;
 	}
-
-	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <= nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest = NULL;
+	avg_load = avg_load*100/num_online_cpus();
+	/* Wait longer before stealing if own pool's load is average. */
+	if (POOLS_BALANCED(avg_load,pool_load[this_pool]))
+		steal_delay = POOL_DELAY_BUSY;
+	else
+		steal_delay = POOL_DELAY_IDLE;
+	/* if we have a new most loaded node: just mark it */
+	if (this_rq->wait_node != pool_idx) {
+		this_rq->wait_node = pool_idx;
+		this_rq->wait_time = jiffies;
+		goto out;
+	} else
+		/* old most loaded node: check if waited enough */
+		if (jiffies - this_rq->wait_time < steal_delay)
+			goto out;
+
+	if ((best_cpu >= 0) &&
+	    (!CPUS_BALANCED(cpu_load[pool_idx],*nr_running))) {
+		busiest = cpu_rq(best_cpu);
+		this_rq->wait_node = -1;
 	}
-out:
+#endif
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
@@ -772,7 +856,7 @@ skip_bitmap:
 			array = busiest->active;
 			goto new_array;
 		}
-		goto out_unlock;
+		goto out;
 	}
 
 	head = array->queue + idx;
@@ -780,33 +864,72 @@ skip_bitmap:
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
+	busiest = find_busiest_queue(this_cpu, idle, &nr_running);
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
@@ -819,10 +942,10 @@ out:
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
@@ -2027,7 +2150,8 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
@@ -2130,6 +2254,8 @@ void __init sched_init(void)
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
+	if (cache_decay_ticks)
+		cache_decay_ticks=1;
 	/*
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.

--------------Boundary-00=_DGCPZTTZF56GQGMWNU79--

