Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTAPS16>; Thu, 16 Jan 2003 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTAPS16>; Thu, 16 Jan 2003 13:27:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4484 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267160AbTAPS1l>;
	Thu, 16 Jan 2003 13:27:41 -0500
Date: Thu, 16 Jan 2003 10:29:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2/3) Initial load balancing
Message-ID: <3660000.1042741744@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Michael Hohnbaum

This adds a hook, sched_balance_exec(), to the exec code, to make it 
place the exec'ed task on the least loaded queue. We have less state
to move at exec time than fork time, so this is the cheapest point
to cross-node migrate. Experience in Dynix/PTX and testing on Linux
has confirmed that this is the cheapest time to move tasks between nodes. 

It also macro-wraps changes to nr_running, to allow us to keep track of
per-node nr_running as well. Again, no impact on non-NUMA machines.

diff -urpN -X /home/fletch/.diff.exclude numasched1/fs/exec.c numasched2/fs/exec.c
--- numasched1/fs/exec.c	Mon Jan 13 21:09:13 2003
+++ numasched2/fs/exec.c	Wed Jan 15 19:10:04 2003
@@ -1031,6 +1031,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urpN -X /home/fletch/.diff.exclude numasched1/include/linux/sched.h numasched2/include/linux/sched.h
--- numasched1/include/linux/sched.h	Mon Jan 13 21:09:28 2003
+++ numasched2/include/linux/sched.h	Wed Jan 15 19:10:04 2003
@@ -444,6 +444,14 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#else
+#define sched_balance_exec()   {}
+#define node_nr_running_init() {}
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urpN -X /home/fletch/.diff.exclude numasched1/init/main.c numasched2/init/main.c
--- numasched1/init/main.c	Thu Jan  9 19:16:15 2003
+++ numasched2/init/main.c	Wed Jan 15 19:10:04 2003
@@ -495,6 +495,7 @@ static void do_pre_smp_initcalls(void)
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -urpN -X /home/fletch/.diff.exclude numasched1/kernel/sched.c numasched2/kernel/sched.c
--- numasched1/kernel/sched.c	Wed Jan 15 19:52:07 2003
+++ numasched2/kernel/sched.c	Wed Jan 15 19:56:42 2003
@@ -153,7 +153,9 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
-
+#ifdef CONFIG_NUMA
+	atomic_t *node_nr_running;
+#endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
@@ -177,6 +179,48 @@ static struct runqueue runqueues[NR_CPUS
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+#ifdef CONFIG_NUMA
+
+/*
+ * Keep track of running tasks.
+ */
+
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+static inline void nr_running_init(struct runqueue *rq)
+{
+	rq->node_nr_running = &node_nr_running[0];
+}
+
+static inline void nr_running_inc(runqueue_t *rq)
+{
+	atomic_inc(rq->node_nr_running);
+	rq->nr_running++;
+}
+
+static inline void nr_running_dec(runqueue_t *rq)
+{
+	atomic_dec(rq->node_nr_running);
+	rq->nr_running--;
+}
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		cpu_rq(i)->node_nr_running = &node_nr_running[__cpu_to_node(i)];
+}
+
+#else /* !CONFIG_NUMA */
+
+# define nr_running_init(rq)   do { } while (0)
+# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+
+#endif /* CONFIG_NUMA */
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -294,7 +338,7 @@ static inline void activate_task(task_t 
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -302,7 +346,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -624,7 +668,72 @@ static inline void double_rq_unlock(runq
 		spin_unlock(&rq2->lock);
 }
 
-#ifdef CONFIG_NUMA
+#if CONFIG_NUMA
+/*
+ * If dest_cpu is allowed for this process, migrate the task to it.
+ * This is accomplished by forcing the cpu_allowed mask to only
+ * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
+ * the cpu_allowed mask is restored.
+ */
+static void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	/* force the process onto the specified CPU */
+	set_cpus_allowed(p, 1UL << dest_cpu);
+
+	/* restore the cpus allowed mask */
+	set_cpus_allowed(p, old_mask);
+}
+
+/*
+ * Find the least loaded CPU.  Slightly favor the current CPU by
+ * setting its runqueue length as the minimum to start.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int i, minload, load, best_cpu, node = 0;
+	unsigned long cpumask;
+
+	best_cpu = task_cpu(p);
+	if (cpu_rq(best_cpu)->nr_running <= 2)
+		return best_cpu;
+
+	minload = 10000000;
+	for (i = 0; i < numnodes; i++) {
+		load = atomic_read(&node_nr_running[i]);
+		if (load < minload) {
+			minload = load;
+			node = i;
+		}
+	}
+
+	minload = 10000000;
+	cpumask = __node_to_cpu_mask(node);
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!(cpumask & (1UL << i)))
+			continue;
+		if (cpu_rq(i)->nr_running < minload) {
+			best_cpu = i;
+			minload = cpu_rq(i)->nr_running;
+		}
+	}
+	return best_cpu;
+}
+
+void sched_balance_exec(void)
+{
+	int new_cpu;
+
+	if (numnodes > 1) {
+		new_cpu = sched_best_cpu(current);
+		if (new_cpu != smp_processor_id())
+			sched_migrate_task(current, new_cpu);
+	}
+}
 
 static inline unsigned long cpus_to_balance(int this_cpu)
 {
@@ -752,9 +861,9 @@ out:
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -2248,6 +2357,7 @@ void __init sched_init(void)
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+		nr_running_init(rq);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

