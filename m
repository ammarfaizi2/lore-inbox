Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271841AbTGRQOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271835AbTGRQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:13:33 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:1965 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S271826AbTGRQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:11:32 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: LSE <lse-tech@lists.sourceforge.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.0-test1] node affine NUMA scheduler extension
Date: Fri, 18 Jul 2003 18:29:43 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3BCG/Nb9Ck/5tSi"
Message-Id: <200307181829.43097.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3BCG/Nb9Ck/5tSi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

No real change compared to the previous version, patch was only
adapted to fit into 2.6.0-test1. I append the description from my
previous posting.

The patch shows 5-8% gain in the numa_test benchmark on a TX7 Itanium2
machine with 8 CPUs/4 nodes. The interesting numbers are ElapsedTime
and TotalUserTime. In numa_test I changed the PROBLEMSIZE from 1000000
to 2000000 in order to get longer execution/test times. The results
are avergaes over 10 measurements, the standard deviation is in
brackets.

2.6.0-test1 kernel: original NUMA scheduler

Tasks   AverageUserTime   ElapsedTime   TotalUserTime    TotalSysTime
  4      52.67(3.51)      61.30(8.04)   210.70(14.05)     0.16(0.02)	
  8      50.29(1.85)      55.19(6.36)   402.38(14.78)     0.34(0.02)	
 16      53.27(2.30)     115.30(5.40)   852.40(36.75)     0.62(0.02)	
 32      51.92(1.13)     215.98(5.95)  1661.66(36.08)     1.21(0.04)	


2.6.0-test1 kernel: node affine NUMA scheduler

Tasks   AverageUserTime   ElapsedTime   TotalUserTime    TotalSysTime
  4      50.13(2.09)      56.72(8.46)   200.55(8.34)      0.15(0.01)	
  8      49.78(1.29)      54.43(4.90)   398.26(10.31)     0.34(0.02)	
 16      50.37(0.96)     110.79(8.46)   806.01(15.33)     0.63(0.03)	
 32      51.10(0.51)     210.18(3.27)  1635.40(16.16)     1.23(0.04)	

In order to see the UserTime / CPU one needs an additional patch which
gets back the per cpu times in /proc/pid/cpu. The patch comes in a
separate post.

> This patch is an adaptation of the earlier work on the node affine
> NUMA scheduler to the NUMA features meanwhile integrated into
> 2.5. Compared to the patch posted for 2.5.39 this one is much simpler
> and easier to understand.
> 
> The main idea is (still) that tasks are assigned a homenode to which
> they are preferentially scheduled. They are not only sticking as much
> as possible to a node (as in the current 2.5 NUMA scheduler) but will
> also be attracted back to their homenode if they had to be scheduled
> away. Therefore the tasks can be called "affine" to the homenode.
> 
> The implementation is straight forward:
> - Tasks have an additional element in their task structure (node).
> - The scheduler keeps track of the homenodes of the tasks running in
> each node and on each runqueue.
> - At cross-node load balance time nodes/runqueues which run tasks
> originating from the stealer node are preferred. They get a weight
> bonus for each task with the homenode of the stealer.
> - When stealing from a remote node one tries to get the own tasks (if
> any) or tasks from other nodes (if any). This way tasks are kept on
> their homenode as long as possible.
> 
> The selection of the homenode is currently done at initial load
> balancing, i.e. at exec(). A smarter selection method might be needed
> for improving the situation for multithreaded processes. An option is
> the dynamic_homenode patch I posted for 2.5.39 or some other scheme
> based on an RSS/node measure. But that's another story...

Regards,
Erich



--Boundary-00=_3BCG/Nb9Ck/5tSi
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="node_affine_sched-2.6.0t1-23.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="node_affine_sched-2.6.0t1-23.diff"

diff -urNp 2.6.0-test1/include/linux/sched.h 2.6.0-test1-na/include/linux/sched.h
--- 2.6.0-test1/include/linux/sched.h	2003-07-14 05:30:40.000000000 +0200
+++ 2.6.0-test1-na/include/linux/sched.h	2003-07-17 17:13:57.000000000 +0200
@@ -343,6 +343,9 @@ struct task_struct {
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+#ifdef CONFIG_NUMA
+	int node; /* homenode: task will be preferrentially scheduled on it */
+#endif
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -499,9 +502,11 @@ static inline int set_cpus_allowed(task_
 #ifdef CONFIG_NUMA
 extern void sched_balance_exec(void);
 extern void node_nr_running_init(void);
+extern void set_task_node(task_t *p, int node);
 #else
 #define sched_balance_exec()   {}
 #define node_nr_running_init() {}
+#define set_task_node(p,n)     {}
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urNp 2.6.0-test1/kernel/sched.c 2.6.0-test1-na/kernel/sched.c
--- 2.6.0-test1/kernel/sched.c	2003-07-14 05:37:14.000000000 +0200
+++ 2.6.0-test1-na/kernel/sched.c	2003-07-17 17:36:07.000000000 +0200
@@ -166,6 +166,8 @@ struct runqueue {
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
+	int nr_homenode[MAX_NUMNODES]; /* nr of tasks per homenode in this rq */
+	atomic_t *node_nremote; /* tasks per homenode stats for this node */
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -199,21 +201,32 @@ static DEFINE_PER_CPU(struct runqueue, r
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
 	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
 
+/*
+ * Keep track on tasks from other homenodes.
+ */
+static atomic_t node_nr_homenode[MAX_NUMNODES][MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ... MAX_NUMNODES-1][0 ... MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
 static inline void nr_running_init(struct runqueue *rq)
 {
 	rq->node_nr_running = &node_nr_running[0];
+	rq->node_nremote = &node_nr_homenode[0][0];
 }
 
-static inline void nr_running_inc(runqueue_t *rq)
+static inline void nr_running_inc(runqueue_t *rq, int node)
 {
 	atomic_inc(rq->node_nr_running);
 	rq->nr_running++;
+	rq->nr_homenode[node]++;
+	atomic_inc(&rq->node_nremote[node]);
 }
 
-static inline void nr_running_dec(runqueue_t *rq)
+static inline void nr_running_dec(runqueue_t *rq, int node)
 {
 	atomic_dec(rq->node_nr_running);
 	rq->nr_running--;
+	rq->nr_homenode[node]--;
+	atomic_dec(&rq->node_nremote[node]);
 }
 
 __init void node_nr_running_init(void)
@@ -221,17 +234,49 @@ __init void node_nr_running_init(void)
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i))
+		if (cpu_possible(i)) {
 			cpu_rq(i)->node_nr_running =
 				&node_nr_running[cpu_to_node(i)];
+			cpu_rq(i)->node_nremote = 
+				&node_nr_homenode[cpu_to_node(i)][0];
+		}
 	}
 }
 
+#define homenode(p)          ((p)->node)
+#define homenode_set(p,n)    (p)->node = (n)
+
+/*
+ * Allow stealing a task from another CPU if:
+ * - the CPU is in the same node or
+ * - the task has its homenode on this_node
+ * - CPU runs only own tasks
+ * - the CPU has remote tasks and the task is from another node.
+ * Tasks will tend to return to their homenode and a runqueue will keep
+ * tasks belonging to its node as long as it has remote tasks running. [EF]
+ */
+static inline int numa_should_migrate(task_t *p, struct runqueue *rq, int this_cpu)
+{
+	int src_cpu = task_cpu(rq->curr);
+	int this_node = cpu_to_node(this_cpu);
+	int src_node = cpu_to_node(src_cpu);
+
+	if ((src_node == this_node) ||		/* same node */
+	    (homenode(p) == this_node) ||	/* task is from this_node */
+	    (rq->nr_running == rq->nr_homenode[src_node]) ||
+	    ((rq->nr_running > rq->nr_homenode[src_node]) &&
+	     (homenode(p) != src_node)))
+			return 1;
+	return 0;
+}
+
 #else /* !CONFIG_NUMA */
 
 # define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_inc(rq,n)  do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq,n)  do { (rq)->nr_running--; } while (0)
+# define homenode_set(p,n)     do { } while (0)
+# define numa_should_migrate(p,q,c) (1)
 
 #endif /* CONFIG_NUMA */
 
@@ -336,7 +381,7 @@ static int effective_prio(task_t *p)
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	nr_running_inc(rq);
+	nr_running_inc(rq, homenode(p));
 }
 
 /*
@@ -383,7 +428,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	nr_running_dec(rq);
+	nr_running_dec(rq, homenode(p));
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -562,7 +607,7 @@ void wake_up_forked_process(task_t * p)
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
 		p->array->nr_active++;
-		nr_running_inc(rq);
+		nr_running_inc(rq, homenode(p));
 	}
 	task_rq_unlock(rq, &flags);
 }
@@ -770,6 +815,21 @@ static void sched_migrate_task(task_t *p
 	set_cpus_allowed(p, old_mask);
 }
 
+void set_task_node(task_t *p, int node)
+{
+	runqueue_t *rq;
+	unsigned long flags;
+
+	if (node < 0 || node >= numnodes) return;
+	rq = task_rq_lock(p, &flags);
+	if (p->array) {
+		nr_running_dec(rq, homenode(p));
+		nr_running_inc(rq, node);
+	}
+	homenode_set(p,node);
+	task_rq_unlock(rq, &flags);
+}
+
 /*
  * Find the least loaded CPU.  Slightly favor the current CPU by
  * setting its runqueue length as the minimum to start.
@@ -817,8 +877,11 @@ void sched_balance_exec(void)
 
 	if (numnodes > 1) {
 		new_cpu = sched_best_cpu(current);
-		if (new_cpu != smp_processor_id())
+		if (new_cpu != smp_processor_id()) {
+			if (cpu_to_node(new_cpu) != homenode(current))
+				set_task_node(current, cpu_to_node(new_cpu));
 			sched_migrate_task(current, new_cpu);
+		}
 	}
 }
 
@@ -845,7 +908,8 @@ static int find_busiest_node(int this_no
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
-			+ (10 * atomic_read(&node_nr_running[i])
+			+ (10 * (atomic_read(&node_nr_running[i])
+				 + atomic_read(&node_nr_homenode[i][this_node]))
 			/ nr_cpus_node(i));
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
@@ -890,7 +954,7 @@ static inline unsigned int double_lock_b
  */
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
-	int nr_running, load, max_load, i;
+	int nr_running, load, max_load, i, this_node;
 	runqueue_t *busiest, *rq_src;
 
 	/*
@@ -921,6 +985,7 @@ static inline runqueue_t *find_busiest_q
 		nr_running = this_rq->prev_cpu_load[this_cpu];
 
 	busiest = NULL;
+	this_node = cpu_to_node(this_cpu);
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!((1UL << i) & cpumask))
@@ -931,6 +996,14 @@ static inline runqueue_t *find_busiest_q
 			load = rq_src->nr_running;
 		else
 			load = this_rq->prev_cpu_load[i];
+#ifdef CONFIG_NUMA
+		/*
+		 * Add relative load bonus if CPUs in remote node run tasks
+		 * with homenode == this_node such that these CPUs are prefered.
+		 */
+		if (this_node != cpu_to_node(i))
+			load += rq_src->nr_homenode[this_node];
+#endif
 		this_rq->prev_cpu_load[i] = rq_src->nr_running;
 
 		if ((load > max_load) && (rq_src != this_rq)) {
@@ -970,9 +1043,9 @@ out:
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	nr_running_dec(src_rq);
+	nr_running_dec(src_rq, homenode(p));
 	set_task_cpu(p, this_cpu);
-	nr_running_inc(this_rq);
+	nr_running_inc(this_rq, homenode(p));
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -1053,7 +1126,8 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu) 
+	    || !numa_should_migrate(tmp, busiest, this_cpu)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -2248,6 +2322,7 @@ void __init init_idle(task_t *idle, int 
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
+	homenode_set(idle, cpu_to_node(cpu));
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	local_irq_restore(flags);

--Boundary-00=_3BCG/Nb9Ck/5tSi--

