Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264621AbSJNLFA>; Mon, 14 Oct 2002 07:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSJNLE7>; Mon, 14 Oct 2002 07:04:59 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:18820 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264621AbSJNLEX>; Mon, 14 Oct 2002 07:04:23 -0400
From: Erich Focht <efocht@ess.nec.de>
Subject: [PATCH] node affine NUMA scheduler 3/5
Date: Mon, 14 Oct 2002 13:09:00 +0200
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0NXYDEDCDF10Q8ZOODQR"
Message-Id: <200210141309.00244.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_0NXYDEDCDF10Q8ZOODQR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

----------  Resent Message  ----------

Subject: [PATCH] node affine NUMA scheduler 3/5
Date: Fri, 11 Oct 2002 19:58:14 +0200

This is the third part of the node affine NUMA scheduler.

> 03-node_affine-2.5.39-10.patch :
>        This is the heart of the node affine part of the patch. Tasks
>        are assigned a homenode during initial load balancing and they
>        are attracted to the homenode.

Erich

--------------Boundary-00=_0NXYDEDCDF10Q8ZOODQR
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="03-node_affine-2.5.39-10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03-node_affine-2.5.39-10.patch"

diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Oct 11 17:44:26 2002
+++ b/include/linux/sched.h	Fri Oct 11 19:32:47 2002
@@ -301,6 +301,7 @@ struct task_struct {
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	int node;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -462,8 +463,14 @@ extern void build_pools(void);
 extern void pooldata_lock(void);
 extern void pooldata_unlock(void);
 extern void sched_balance_exec(void);
+extern void set_task_node(task_t *p, int node);
+# define homenode_inc(rq,node) (rq)->nr_homenode[node]++
+# define homenode_dec(rq,node) (rq)->nr_homenode[node]--
 #else
 #define sched_balance_exec() {}
+#define set_task_node(p,n) {}
+# define homenode_inc(rq,node) {}
+# define homenode_dec(rq,node) {}
 #endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Oct 11 17:44:26 2002
+++ b/kernel/sched.c	Fri Oct 11 19:35:58 2002
@@ -156,6 +156,7 @@ struct runqueue {
 
 	unsigned long wait_time;
 	int wait_node;
+	short nr_homenode[MAX_NUMNODES];
 
 } ____cacheline_aligned;
 
@@ -201,11 +202,13 @@ static spinlock_t pool_lock = SPIN_LOCK_
 
 /* Avoid zeroes in integer divides for load calculations */
 #define BALANCE_FACTOR 100
+#define MAX_CACHE_WEIGHT 100
 
 #ifdef CONFIG_NUMA
 int pool_cpus[NR_CPUS];
 #define POOL_DELAY_IDLE  (1*HZ/1000)
 #define POOL_DELAY_BUSY  (20*HZ/1000)
+#define pool_weight(a,b) ((a)==(b)?MAX_CACHE_WEIGHT:0)
 #define loop_over_node(i,cpu,n) \
 	for(i=pool_ptr[n], cpu=pool_cpus[i]; i<pool_ptr[n+1]; i++, cpu=pool_cpus[i])
 
@@ -244,8 +247,10 @@ void build_pools(void)
 		mask = pool_mask[n] = __node_to_cpu_mask(n) & cpu_online_map;
 		pool_ptr[n] = ptr;
 		for (cpu=0; cpu<NR_CPUS; cpu++)
-			if (mask  & (1UL << cpu))
+			if (mask  & (1UL << cpu)) {
 				pool_cpus[ptr++] = cpu;
+				cpu_rq(cpu)->idle->node = n;
+			}
 		pool_nr_cpus[n] = ptr - pool_ptr[n];
 	}
 	numpools=numnodes;
@@ -265,6 +270,7 @@ void build_pools(void)
 #else
 #define POOL_DELAY_IDLE 0
 #define POOL_DELAY_BUSY 0
+#define pool_weight(a,b) (0)
 #define loop_over_node(i,cpu,n) for(cpu=0; cpu<NR_CPUS; cpu++)
 #endif
 
@@ -387,6 +393,7 @@ static inline void activate_task(task_t 
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	homenode_inc(rq,p->node);
 }
 
 /*
@@ -394,6 +401,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	homenode_dec(rq,p->node);
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
@@ -736,6 +744,7 @@ static int calc_pool_load(int *pool_load
 {
 	runqueue_t *rq_src, *this_rq = cpu_rq(this_cpu);
 	int i, cpu, idx=-1, refload, load;
+	int this_pool = cpu_to_node(this_cpu);
 
 	*pool_load = 0;
 	refload = -1;
@@ -747,6 +756,9 @@ static int calc_pool_load(int *pool_load
 		else
 			load = this_rq->prev_nr_running[cpu];
 		this_rq->prev_nr_running[cpu] = rq_src->nr_running;
+		/* prefer cpus running tasks from this node */
+		if (pool != this_pool)
+			load += rq_src->nr_homenode[this_pool];
 		*pool_load += load;
 		if (load > refload) {
 			idx = cpu;
@@ -880,6 +892,7 @@ static inline runqueue_t *find_busiest_q
 static inline task_t *task_to_steal(runqueue_t *busiest, int this_cpu)
 {
 	int idx;
+	int this_pool = cpu_to_node(this_cpu);
 	task_t *next = NULL, *tmp;
 	prio_array_t *array;
 	struct list_head *head, *curr;
@@ -930,6 +943,13 @@ skip_queue:
 
 	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
+		/* limit weight influence of sleep_time and cache coolness */
+		if (weight >= MAX_CACHE_WEIGHT) weight=MAX_CACHE_WEIGHT-1;
+		/* weight depending on homenode of task */
+		weight += pool_weight(this_pool,tmp->node);
+		/* task gets bonus if running on its homenode */
+		if (tmp->node == cpu_to_node(task_cpu(busiest->curr)))
+			weight -= MAX_CACHE_WEIGHT;
 		if (weight > maxweight) {
 			maxweight = weight;
 			next = tmp;
@@ -964,6 +984,35 @@ static inline void pull_task(runqueue_t 
 		set_need_resched();
 }
 
+static inline void
+try_push_home(runqueue_t *this_rq, int this_cpu, int nr_running)
+{
+	task_t *p;
+	int tgt_pool, i, cpu;
+	runqueue_t *rq;
+	static int sched_push_task(task_t *p, int cpu_dest);
+
+	if ((nr_running != 1) || (current->active_mm == &init_mm))
+		return;
+	p = this_rq->curr;
+	tgt_pool = p->node;
+	if (tgt_pool != cpu_to_node(this_cpu)) {
+		/* compute how many own tasks run on the tgt node */
+		unsigned long load = 0, tot_load = 0, mask;
+		mask = p->cpus_allowed & pool_mask[tgt_pool] & cpu_online_map;
+		loop_over_node(i,cpu,tgt_pool) {
+			rq = cpu_rq(cpu);
+			if (rq->nr_homenode[tgt_pool]) {
+				load += rq->nr_homenode[tgt_pool];
+				mask &= ~(1UL<<cpu);
+			}
+			tot_load += rq->nr_running;
+		}
+		if (mask && tot_load > load)
+			sched_push_task(p, __ffs(mask));
+	}
+}
+
 /*
  * Current runqueue is empty, or rebalance tick: if there is an
  * inbalance (current runqueue is too short) then pull from
@@ -981,8 +1030,10 @@ static void load_balance(runqueue_t *thi
 	/* avoid deadlock by timer interrupt on own cpu */
 	if (pooldata_is_locked()) return;
 	busiest = find_busiest_queue(this_cpu, idle, &nr_running);
-	if (!busiest)
+	if (!busiest) {
+		try_push_home(this_rq, this_cpu, nr_running);
 		goto out;
+	}
 
 	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
 	/*
@@ -2167,6 +2218,20 @@ out:
 }
 
 #ifdef CONFIG_NUMA
+void set_task_node(task_t *p, int node)
+{
+	runqueue_t *rq;
+	unsigned long flags;
+
+	if (node < 0 || node >= numpools) return;
+	rq = task_rq_lock(p, &flags);
+	if (p->array) {
+		homenode_dec(rq, p->node);
+		homenode_inc(rq, node);
+	}
+	p->node = node;
+	task_rq_unlock(rq, &flags);
+}
 /* used as counter for round-robin node-scheduling */
 static atomic_t sched_node=ATOMIC_INIT(0);
 
@@ -2231,6 +2296,8 @@ void sched_balance_exec(void)
 		cpu_relax();
 	if (numpools > 1) {
 		new_node = sched_best_node(current);
+		if (new_node != current->node)
+			set_task_node(current, new_node);
 	} 
 	new_cpu = sched_best_cpu(current, new_node);
 	if (new_cpu != smp_processor_id())
@@ -2238,6 +2305,41 @@ void sched_balance_exec(void)
 }
 #endif
 
+/*
+ * Static per cpu migration request structures for pushing the current
+ * process to another CPU from within load_balance().
+ */
+static migration_req_t migr_req[NR_CPUS];
+
+/*
+ * Push the current task to another cpu asynchronously. To be used from within
+ * load_balance() to push tasks running alone on a remote node back to their
+ * homenode. The RQ lock must be held when calling this function, it protects
+ * migr_req[cpu]. Function should not be preempted!
+ */
+static int sched_push_task(task_t *p, int cpu_dest)
+{
+	int cpu = smp_processor_id();
+	runqueue_t *rq = this_rq();
+
+	if (migr_req[cpu].task)
+		return -1;
+	else {
+		migr_req[cpu].task = p;
+		migr_req[cpu].cpu_dest = cpu_dest;
+		migr_req[cpu].sync = 0;
+		list_add(&migr_req[cpu].list, &rq->migration_queue);
+
+		if (!rq->migration_thread->array) {
+			activate_task(rq->migration_thread, rq);
+			if (rq->migration_thread->prio < rq->curr->prio)
+				resched_task(rq->curr);
+		}
+		rq->migration_thread->state = TASK_RUNNING;
+		return 0;
+	}
+}
+
 void sched_migrate_task(task_t *p, int dest_cpu)
 {
 	unsigned long old_mask;
@@ -2265,6 +2367,7 @@ static int migration_thread(void * data)
 	set_fs(KERNEL_DS);
 
 	set_cpus_allowed(current, 1UL << cpu);
+	set_task_node(current, cpu_to_node(cpu));
 
 	/*
 	 * Migration can happen without a migration thread on the
diff -urNp a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Tue Oct  8 15:03:55 2002
+++ b/kernel/softirq.c	Fri Oct 11 17:44:53 2002
@@ -368,6 +368,7 @@ static int ksoftirqd(void * __bind_cpu)
 	set_cpus_allowed(current, 1UL << cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
+	set_task_node(current, __cpu_to_node(cpu));
 
 	sprintf(current->comm, "ksoftirqd_CPU%d", cpu);
 

--------------Boundary-00=_0NXYDEDCDF10Q8ZOODQR--

