Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTE0IQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTE0IQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:16:15 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:31938 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S262798AbTE0IQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:16:07 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: LSE <lse-tech@lists.sourceforge.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Node affine NUMA scheduler extension
Date: Tue, 27 May 2003 10:31:55 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271031.55554.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an adaptation of the earlier work on the node affine
NUMA scheduler to the NUMA features meanwhile integrated into
2.5. Compared to the patch posted for 2.5.39 this one is much simpler
and easier to understand.

The main idea is (still) that tasks are assigned a homenode to which
they are preferentially scheduled. They are not only sticking as much
as possible to a node (as in the current 2.5 NUMA scheduler) but will
also be attracted back to their homenode if they had to be scheduled
away. Therefore the tasks can be called "affine" to the homenode.

The implementation is straight forward:
- Tasks have an additional element in their task structure (node).
- The scheduler keeps track of the homenodes of the tasks running in
each node and on each runqueue.
- At cross-node load balance time nodes/runqueues which run tasks
originating from the stealer node are preferred. They get a weight
bonus for each task with the homenode of the stealer.
- When stealing from a remote node one tries to get the own tasks (if
any) or tasks from other nodes (if any). This way tasks are kept on
their homenode as long as possible.

The selection of the homenode is currently done at initial load
balancing, i.e. at exec(). A smarter selection method might be needed
for improving the situation for multithreaded processes. An option is
the dynamic_homenode patch I posted for 2.5.39 or some other scheme
based on an RSS/node measure. But that's another story...

A node affine NUMA scheduler based on these principles is running very
successfully in production on NEC TX7 machines since 1 year. The
current patch was tested on a 32 CPU Itanium2 TX7 machine.

Curious about comments...
Erich

-----------------8<----- node_affine_sched-2.5.70-23.diff ---------
diff -urN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2003-05-27 03:00:23.000000000 +0200
+++ b/include/linux/sched.h	2003-05-27 09:42:05.000000000 +0200
@@ -340,6 +340,9 @@
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+#ifdef CONFIG_NUMA
+	int node; /* homenode: task will be preferrentially scheduled on it */
+#endif
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -489,9 +492,11 @@
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
diff -urN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2003-05-27 03:00:46.000000000 +0200
+++ b/kernel/sched.c	2003-05-27 09:42:05.000000000 +0200
@@ -164,6 +164,8 @@
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
+	int nr_homenode[MAX_NUMNODES]; /* nr of tasks per homenode in this rq */
+	atomic_t *node_nremote; /* tasks per homenode stats for this node */
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -197,36 +199,79 @@
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
 	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
 
+/*
+ * Keep track on tasks from other homenodes.
+ */
+static atomic_t node_nr_homenode[MAX_NUMNODES][MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ... MAX_NUMNODES-1][0 ... MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
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
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
+	for (i = 0; i < NR_CPUS; i++) {
 		cpu_rq(i)->node_nr_running = &node_nr_running[cpu_to_node(i)];
+		cpu_rq(i)->node_nremote = &node_nr_homenode[cpu_to_node(i)][0];
+	}
+}
+
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
+static inline int numa_should_migrate(task_t *p, runqueue_t *rq, int this_cpu)
+{
+	int src_cpu = rq - &runqueues[0];
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
 }
 
 #else /* !CONFIG_NUMA */
 
 # define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_inc(rq,n)  do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq,n)  do { (rq)->nr_running--; } while (0)
+# define homenode_set(p,n)     do { } while (0)
+# define numa_should_migrate(p,q,c) (1)
 
 #endif /* CONFIG_NUMA */
 
@@ -331,7 +376,7 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	nr_running_inc(rq);
+	nr_running_inc(rq, homenode(p));
 }
 
 /*
@@ -378,7 +423,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	nr_running_dec(rq);
+	nr_running_dec(rq, homenode(p));
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -557,7 +602,7 @@
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
 		p->array->nr_active++;
-		nr_running_inc(rq);
+		nr_running_inc(rq, homenode(p));
 	}
 	task_rq_unlock(rq, &flags);
 }
@@ -765,6 +810,21 @@
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
@@ -806,8 +866,11 @@
 
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
 
@@ -816,6 +879,9 @@
  * geometrically deccaying weight to the load measure:
  *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
  * This way sudden load peaks are flattened out a bit.
+ * Load measure of remote nodes is increased if they run tasks from this_node,
+ * thus such nodes are preferred as steal candidates and own tasks have more
+ * chances to return "home". [EF]
  */
 static int find_busiest_node(int this_node)
 {
@@ -828,7 +894,8 @@
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
-			+ atomic_read(&node_nr_running[i]);
+			+ atomic_read(&node_nr_running[i])
+			+ atomic_read(&node_nr_homenode[i][this_node]);
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
 			maxload = load;
@@ -872,7 +939,7 @@
  */
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
-	int nr_running, load, max_load, i;
+	int nr_running, load, max_load, i, this_node;
 	runqueue_t *busiest, *rq_src;
 
 	/*
@@ -903,6 +970,7 @@
 		nr_running = this_rq->prev_cpu_load[this_cpu];
 
 	busiest = NULL;
+	this_node = cpu_to_node(this_cpu);
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!((1UL << i) & cpumask))
@@ -913,6 +981,14 @@
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
@@ -952,9 +1028,9 @@
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	nr_running_dec(src_rq);
+	nr_running_dec(src_rq, homenode(p));
 	set_task_cpu(p, this_cpu);
-	nr_running_inc(this_rq);
+	nr_running_inc(this_rq,homenode(p));
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -1035,7 +1111,8 @@
 
 	curr = curr->prev;
 
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu) 
+	    || !numa_should_migrate(tmp, busiest, this_cpu)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -2225,6 +2302,7 @@
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
+	homenode_set(idle, cpu_to_node(cpu));
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	local_irq_restore(flags);


