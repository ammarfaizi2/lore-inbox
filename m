Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTANPqK>; Tue, 14 Jan 2003 10:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTANPqK>; Tue, 14 Jan 2003 10:46:10 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:32907 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264644AbTANPpz>; Tue, 14 Jan 2003 10:45:55 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [PATCH 2.5.58] new NUMA scheduler 
Date: Tue, 14 Jan 2003 16:55:06 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <352680000.1042520180@titus> <200301141214.12323.efocht@ess.nec.de>
In-Reply-To: <200301141214.12323.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_U7OP5W46087DBQCSGE6M"
Message-Id: <200301141655.06660.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_U7OP5W46087DBQCSGE6M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here's the new version of the NUMA scheduler built on top of the
miniature scheduler of Martin. I incorporated Michael's ideas and
Christoph's suggestions and rediffed for 2.5.58.=20

The whole patch is really tiny: 9.5k. This time I attached the numa
scheduler in form of two patches:

numa-sched-2.5.58.patch     (7k) : components 01, 02, 03
numa-sched-add-2.5.58.patch (3k) : components 04, 05

The single components are also attached in a small tgz archive:

01-minisched-2.5.58.patch : the miniature scheduler from
Martin. Balances strictly within a node. Removed the
find_busiest_in_mask() function.

02-initial-lb-2.5.58.patch : Michael's initial load balancer at
exec(). Cosmetic corrections sugegsted by Christoph.

03-internode-lb-2.5.58.patch : internode load balancer core. Called
after NODE_BALANCE_RATE calls of the inter-node load balancer. Tunable
parameters:
  NODE_BALANCE_RATE  (default: 10)
  NODE_THRESHOLD     (default: 125) : consider only nodes with load
                     above NODE_THRESHOLD/100 * own_node_load
  I added the constant factor of 4 suggested by Michael, but I'm not
  really happy with it. This should be nr_cpus_in_node, but we don't
  have that info in topology.h

04-smooth-node-load-2.5.58.patch : The node load measure is smoothed
by adding half of the previous node load (and 1/4 of the one before,
etc..., as discussed in the LSE call). This should improve a bit the
behavior in case of short timed load peaks and avoid bouncing tasks
between nodes.

05-var-intnode-lb-2.5.58.patch : Replaces the fixed NODE_BALANCE_RATE
interval (between cross-node balancer calls) by a variable
node-specific interval. Currently only two values used:
   NODE_BALANCE_MIN : 10
   NODE_BALANCE_MAX : 40
If the node load is less than avg_node_load/2, we switch to
NODE_BALANCE_MIN, otherwise we use the large interval.
I also added a function to reduce the number of tasks stolen from
remote nodes.

Regards,
Erich

--------------Boundary-00=_U7OP5W46087DBQCSGE6M
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="numa-sched-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa-sched-2.5.58.patch"

diff -urNp 2.5.58/fs/exec.c 2.5.58-ms-ilb-nb/fs/exec.c
--- 2.5.58/fs/exec.c	2003-01-14 06:58:33.000000000 +0100
+++ 2.5.58-ms-ilb-nb/fs/exec.c	2003-01-14 16:31:08.000000000 +0100
@@ -1031,6 +1031,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp 2.5.58/include/linux/sched.h 2.5.58-ms-ilb-nb/include/linux/sched.h
--- 2.5.58/include/linux/sched.h	2003-01-14 06:58:06.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/linux/sched.h	2003-01-14 16:31:08.000000000 +0100
@@ -160,7 +160,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -444,6 +443,28 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+
+static inline void nr_running_inc(runqueue_t *rq)
+{
+	atomic_inc(rq->node_ptr);
+	rq->nr_running++;
+}
+
+static inline void nr_running_dec(runqueue_t *rq)
+{
+	atomic_dec(rq->node_ptr);
+	rq->nr_running--;
+}
+#else
+#define sched_balance_exec() {}
+#define node_nr_running_init() {}
+#define nr_running_inc(rq) rq->nr_running++
+#define nr_running_dec(rq) rq->nr_running--
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp 2.5.58/init/main.c 2.5.58-ms-ilb-nb/init/main.c
--- 2.5.58/init/main.c	2003-01-14 06:58:20.000000000 +0100
+++ 2.5.58-ms-ilb-nb/init/main.c	2003-01-14 16:31:08.000000000 +0100
@@ -495,6 +495,7 @@ static void do_pre_smp_initcalls(void)
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -urNp 2.5.58/kernel/sched.c 2.5.58-ms-ilb-nb/kernel/sched.c
--- 2.5.58/kernel/sched.c	2003-01-14 06:59:11.000000000 +0100
+++ 2.5.58-ms-ilb-nb/kernel/sched.c	2003-01-14 16:31:57.000000000 +0100
@@ -67,6 +67,8 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
+#define NODE_BALANCE_RATIO	10
+#define NODE_THRESHOLD          125
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -153,7 +155,10 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
-
+#ifdef CONFIG_NUMA
+	atomic_t * node_ptr;
+	unsigned int nr_balanced;
+#endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
@@ -294,7 +299,7 @@ static inline void activate_task(task_t 
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -302,7 +307,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -624,6 +629,105 @@ static inline void double_rq_unlock(runq
 		spin_unlock(&rq2->lock);
 }
 
+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
+}
+
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
+
+static int find_busiest_node(int this_node)
+{
+	int i, node = -1, load, this_load, maxload;
+	
+	this_load = maxload = atomic_read(&node_nr_running[this_node]);
+	for (i = 0; i < numnodes; i++) {
+		if (i == this_node)
+			continue;
+		load = atomic_read(&node_nr_running[i]);
+		if (load > maxload &&
+		    (100*load > ((NODE_THRESHOLD*100*this_load)/100))) {
+			maxload = load;
+			node = i;
+		}
+	}
+	if (maxload <= 4)
+		node = -1;
+	return node;
+}
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP
 
 /*
@@ -652,9 +756,9 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * find_busiest_queue - find the busiest runqueue among the cpus in cpumask
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -689,7 +793,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1UL << i) & cpumask) )
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -736,9 +840,9 @@ out:
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
@@ -763,8 +867,21 @@ static void load_balance(runqueue_t *thi
 	prio_array_t *array;
 	struct list_head *head, *curr;
 	task_t *tmp;
+	int this_node = __cpu_to_node(this_cpu);
+	unsigned long cpumask = __node_to_cpu_mask(this_node);
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+#if CONFIG_NUMA
+	/*
+	 * Avoid rebalancing between nodes too often.
+	 */
+	if (!(++(this_rq->nr_balanced) % NODE_BALANCE_RATIO)) {
+		int node = find_busiest_node(this_node);
+		if (node >= 0)
+			cpumask = __node_to_cpu_mask(node) | (1UL << this_cpu);
+	}
+#endif
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+				    cpumask);
 	if (!busiest)
 		goto out;
 
@@ -2231,6 +2348,10 @@ void __init sched_init(void)
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+#if CONFIG_NUMA
+		rq->node_ptr = &node_nr_running[0];
+#endif /* CONFIG_NUMA */
+
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--------------Boundary-00=_U7OP5W46087DBQCSGE6M
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="numa-sched-add-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa-sched-add-2.5.58.patch"

diff -urNp 2.5.58-ms-ilb-nb/kernel/sched.c 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c
--- 2.5.58-ms-ilb-nb/kernel/sched.c	2003-01-14 16:31:57.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c	2003-01-14 16:33:53.000000000 +0100
@@ -67,8 +67,9 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
-#define NODE_BALANCE_RATIO	10
 #define NODE_THRESHOLD          125
+#define NODE_BALANCE_MIN	10
+#define NODE_BALANCE_MAX	40
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -158,6 +159,7 @@ struct runqueue {
 #ifdef CONFIG_NUMA
 	atomic_t * node_ptr;
 	unsigned int nr_balanced;
+	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -632,6 +634,8 @@ static inline void double_rq_unlock(runq
 #if CONFIG_NUMA
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
 	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+static int internode_lb[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = NODE_BALANCE_MAX};
 
 __init void node_nr_running_init(void)
 {
@@ -707,25 +711,54 @@ void sched_balance_exec(void)
 	}
 }
 
+/*
+ * Find the busiest node. All previous node loads contribute with a 
+ * geometrically deccaying weight to the load measure:
+ *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
+ * This way sudden load peaks are flattened out a bit.
+ */
 static int find_busiest_node(int this_node)
 {
 	int i, node = -1, load, this_load, maxload;
+	int avg_load;
 	
-	this_load = maxload = atomic_read(&node_nr_running[this_node]);
+	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
+		+ atomic_read(&node_nr_running[this_node]);
+	this_rq()->prev_node_load[this_node] = this_load;
+	avg_load = this_load;
 	for (i = 0; i < numnodes; i++) {
 		if (i == this_node)
 			continue;
-		load = atomic_read(&node_nr_running[i]);
+		load = (this_rq()->prev_node_load[i] >> 1)
+			+ atomic_read(&node_nr_running[i]);
+		avg_load += load;
+		this_rq()->prev_node_load[i] = load;
 		if (load > maxload &&
 		    (100*load > ((NODE_THRESHOLD*100*this_load)/100))) {
 			maxload = load;
 			node = i;
 		}
 	}
-	if (maxload <= 4)
+	avg_load = avg_load / (numnodes ? numnodes : 1);
+	if (this_load < (avg_load / 2)) {
+		if (internode_lb[this_node] == MAX_INTERNODE_LB)
+			internode_lb[this_node] = MIN_INTERNODE_LB;
+	} else
+		if (internode_lb[this_node] == MIN_INTERNODE_LB)
+			internode_lb[this_node] = MAX_INTERNODE_LB;
+	if (maxload <= 4+2+1 || this_load >= avg_load)
 		node = -1;
 	return node;
 }
+
+static inline int remote_steal_factor(runqueue_t *rq)
+{
+	int cpu = __cpu_to_node(task_cpu(rq->curr));
+
+	return (cpu == __cpu_to_node(smp_processor_id())) ? 1 : 2;
+}
+#else
+#define remote_steal_factor(rq) 1
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -938,7 +971,7 @@ skip_queue:
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
+	if (!idle && ((--imbalance)/remote_steal_factor(busiest))) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------Boundary-00=_U7OP5W46087DBQCSGE6M
Content-Type: application/x-tgz;
  name="numa-sched-patches.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="numa-sched-patches.tgz"

H4sIAM0uJD4CA+1be1PbSBLnX/Epeit1rI0tkOQnkHDrTdgNdQRS4Gxt3VZKJewxaJElI8mQVJbv
ft09o4dl2YY8NnV3nkpFlqanZ6anp/vXPYNh6mPXd6PBtRjq1k5rp9XdmTjx4Hrj6xXDNIx2s7lh
YOm05dNU71islmVtYIWJZKbZxN9m02i0NsDY+BvKNIqdEGBjFAyu46V0Iow2/ufK0B2NQJ+GpxOQ
q797I0JfeLusETsD9VUfR4WKTV3Xy5tolmE0dMPUzSYY7f3W3r5p7hhJgRqpw2atVlvIOs/AbOxb
nf1We47BTz+B3m5Z9T2oyQd+wKWM3QG4vuf6AqZ+5F75YojvMQyD6aUnbC8Y3NiXm/CwCZuwu72p
wzaMXH9oX04jV0SxfTsVUwE6f4T4WoCqgHDqc93OZu3JbcAZB/4VVw0m0wgHRM+xE91sAmzvbuqz
A0+a2TFsz3dUyVfH125kh7d1niO/IGP55g49IX9tu+NLx3P8gahu1v6uruqZ/D2avJpwdRM+bYJG
tH5oI3/f9a/qSOIM6zB2Ptjyl3uARPne1bjqsB3e2lE4OJAK0N2rd1AB+DGnAIsnh8yTNXoBp+9O
Tqi7pHf8ZNL7KAih4uKbcQAuPIfTc/vl23cX+FKrVXEWuqa5I6j8gDOzA+6x4lZRwmWf4a+/4IdK
xXx3As+fA75vpQIBFImmaYPAj11/Kg5IMzVNzhI7JzbhLbKQM+60G/Uu1Ohhmrkp3wXukKVoK/kX
1w6ZTkI3sJ0wdD7SN/5B84zicDqIwXNRMtcC579N/6OkB9MwJIIYh8lcxpMDnF66/n4wFDhCmxTB
jgN+rySaUSXSUhXgJkRLbagpfaykHKskAT23PiV6mepiTg9ZB7cyVaf+v5RJnVZT0wBLslwkEF5f
xYxX7yqIAwimMQ39v8v+G5aO7j92HU/3Lr8RAFju/02rYxnK/1tW0+qQ/zcb5tr/fxf/T+54FO2K
D2KQ9/66611m33POf4a+6Pq7+43Gctc/y7fo+bv7zb1Sz28aDbPehho/u2QHpZO3ic+dqAyucVHJ
TXvCd8a4p+WHbXCU8wlFfOd4B+qN3A1udcYfiQFlVhUyI+QLkBFakWAifPk94VyV9lqyQ4q3/XP7
6Pyc67GuVLyuP/CmQ7GLvmH6QYGe64JISmkKYi+lmV8Co/2IJVjJa/lytA3yw/Ro02KIDzEiOumU
ppOhEwt0hcKehMFARFFFeZwYFyNPyb1OPRHa6NFuKrQwtOv4TcKL6GMUizHJXLUrOBgHOdhDMSAP
h40idiWb8Gwo0P4L7U3vd/vi5eujV+9Ojuz+8Zujs3d97eTs9Fcba1KeeY6/9C76L3snJ5VkbMh3
LNDSV/JU6luVBuZEY5ThjXMlZidVoTflxJvNJilvs9moW92ivCIRkzOKbMfzgnsxrCTud1JHTXsG
ci7zZFjti3tbYophAJ/gAe6vSW8rBjqpZ8JHZSQ1f+aOkAe8PDv95fhX+/Tdm95mbW4ZZneBGvsM
GXvwDMPZ5EZSwiLOlC3yxIMZgBLeInD6hFvQiYOxO5D1t/ohdzKJQ/bm/CHlUavht4fVXaE6LO2K
65d3peuyq2fCiwQ+kiUoMRfw6SEjKBVRgaQgk9sqFKdZSixHXSTWdRokL3Rtc06reDP5LmLDnEqx
AtPH3K5ihEckhBgz4jKKWXaLLZ4b744d159zKbmaOeuW1szbNMt4lE0r5bDUkjX3Wrw18dEpwmt0
L5NQ2NF4wis5wJ0XSY1nHzB2r0IkDny1zgfppqtp5ZrA6Hvi3Pv2TRSMYje8HfJHik5L5bgoNufp
LozPPzPCnhfoEiYt5LBvmOXeodVg74APFaaz+U+j40+5GINiDgw9CIgfzIcsg9i9Q2e+LT5M3FBg
jMJV0R/W+8ST4wLd5QT9hwrasF4vt3yJGUD2kJiAg3QXZQPLVje+DjE+Ko2cMiKeGbkfEoC11yQB
WHvtsjCVdYunRn4y5mBIdkqhxUQ/JCEgtBCjkWAByG3J21FDVdFEYtyo6UQJBWv1MoupzVucgywf
QqNtGBaNtmE0nzpaymWUkQ/FbIPU/2M79ZtMUdFKc4xdYom1eTuYRGUoLeofsdoL6Pcu/mW/Oz0+
7SMge/e2f/zzyVFVxtbMcooM0JiF00nsXnqCpAPaUMzKEhkm4uSEg8Weu221693WAuGoVBNG8FOf
8k3sfajfaOL6ybet8NbSD+lnIn7SzlnVVLxTBS0YkT8IziDl6dmro4v3GFNjIE4AiEaCMOCD4zFE
wVUmkwUvUHCf/jBgZ2cn31A336Nu9fpnb45f2senx31ECw/swW22UqucvfSlCkRjq+VpE4qn04xG
5nOReqs4u9m0glt9n7h7VFNKwR2PUK8iBkHgRqBgEFD3FNCDApt1tSkFp99oWQFjdTeWebw+UVLr
wSAYT3Ajo2WDy4/EZeBmKbsEZMFYtQ987yMz4Ip0IHVCXINruHc9j3mIhAO2wGYJ3Q5gz8JnDqVd
4JBCpA3QyPFAd1NtyEE0NbGZTUj7iEMh1ZNan1mcHHhDxolywZI3XATU9jym5GwP5ToqKc0WJEms
tAeZ88IIaBr61GJ3Ozd1tQpy+vQhmoiBO3JxKKgVPDGtDMoWO5FDRdZKLFkydUZuC/klE6gWtOiX
JGfrCSeKOYMmh4ZLdIEb6Dr2UBucO9Yq7BHdk0Dx0tgvpQZgbzGpihtHmUvD4PAqvsZggFvRCct4
OibFoWxDXFhSjmwkllTTLbeQ+b1Gau3LXKn8/zJVQZWWMxYm4KQskwZIyt1Qt5NqsuRqkyZE1bwR
hucvwMotetq3ZKwGRmlUhQUOSsyCPx3TQKM0nYrsVDNl8MjLVubMgvuex8iDZPrniSQUk1z/9GBi
TcnE5Tdcf+1hyVCX5ilVinKJnavVXDUUuXcSdtnWcdWeySV9FXXeNubkXZxibu3klHIzKWWRn3fJ
qrE0lgZ/mepRkJmuNY05WUk4BFMNUNHgaAp6rfZPtoQJ5Q9IirhamYsgtF2EwlJIJcZOsakng2F+
DypGI+CGWCbvS3m3IRzPPOzFm7c5yNNptOkgqWt2JELFYH6/FMlMpp4nh5AHK1E44ETyLFqlr/xS
h5xxXnmkok5IikAk5cbATva4EhlJMhlnoFHM9nmW9GZ2aiArwaKiY4ZF1JnykCidaVC8oKGNPA3Y
/zryqAgkgo7g2rkT4LDYIBgBwZK358dn9cyJx6g4EkJbDUZeVsNs1U2DFokXRIEUqSM5VJLALT7w
4+9bNLYEcGkaQR375Piib78+6r2StQX4LgmVNUL5SSIUiRvcOy5qn0F6NwfbFMBcAm2M9wfLFZX6
Zfvyp7Qvf6IJsPAhLSUdF7EqYCULnIMgqMGfB08+fcAIjlEwDfFbnQCsOP9vNBu5/H+rRfn/Zruz
zv9/r/x/Saw/W6n7y7MNn5ssmMs4zHdU5NPcb3TK7wZ0OFDr8OlAmgIGjgZ7L/vHvx3Zr45O+j3N
yio5P3xydPTW7v32q6ZVrO3X/65m1Rf93vlvvf7x2SkajjfH/YQgzc9RQGX/3Dvpnb48ss+JUjON
QnX/9fnRxeuzk1eQFtNqKV8EMq5xZJyC9u9H3pzSov5IWNKHe4EY2PVRHdGaxnSXgCCmJFHpFk5h
ma1OEr/Pp1uWp0qgJFECCxIl2sw1C2SnsMMwS399aRKFPbTRoEl1jHbdaqfWfyFagUfjBk6hzKaR
49nTYhl/5g+9Z4G4wpa6mUBxpktvNCQgFP+lFUiualbB3bTP99XHomiCVS4lQPLjLYLNz4Lah+mo
t7aogpS3ghtuW9VWKrMqvk116aSru/iKyDeB6akAlsN07j4hxsijybNJhX6QAVr6xmAWFvpWmAOB
pFzdJhuLbseom+0nXqp49G0I+PzbECUYg8JXQlY9HmMo5AApWLgU8b0QUhoIoAKCVrHwd5h+N43o
a7VKHvUlu7YK/ygxY8mi8RaX85zfIvkxJ+ieaA9RW5UGrgys4K80SJq5SPKQy8h++aUOWH2pY+P/
pBhNPRoHQXytSwSIyv7VMeCq+5+ddivFfy3LRPqW1W6s8d/3xH/zyGuuHhVnJQr8TABXBgTnuyuy
au0bC64ntLoSEXUXIqLHIx5YgnhqOWBFDWg7zabpvzYq6tQti2BRt96wHgOLHtRhQzH9mRhVGvYO
9DyPZ+EG00gafJpJBAQhQvdyitH8vUv5TWAuVyIYC6ygE9GPMBSDgfORXNG9oAQqqMwvO/CxcKJp
KPa5HRf2r5/iBwUE8KduPuzipEi0LMUkA4FEWdL+HsPfaDocoqdjxhPh3ETghAJGnhOjw8P1CaYx
DvHSTRKu8BSIl+Lkx0I80JJMyhdBvHIOiWOrVOk8cEa/svZwSCk4crW1p3e5iveLbNJlt2PnkCiU
I9HZu67605DoamG4OSGskkLCdSm3BJ7CIhwMX4CDoQQHwwwOBo2PeB9QUmU4uPitZtVMlnEOH8Ms
Psb9n/fNLf3OCSkH9O0yQCv8f8swO5n/bxuU/+k0jLX//87+f97hlpGQ+jwGBnym+16ABEp6LbIz
963mosxQlzNDe988M6QvzwzBYzJD5dmlN8en87mltLL3u9Y0vmZOqd3g9Eu70ZS3bR9/7aEYusLX
vtUAT7nVkAMAadrb9i6/5lWK4ko88A3hR16mQJ/AuM7s1M0W4jrLqJvdR+C6bwpsJKp17q5S50/g
9YthCjwNpsBnwJSaloz628AXeBIkgcdDknTYtRws+H44RZ6RNujgrdZp7KkU7GOV7vGQRsKXmVVL
f+7mTpr/ma4X7KNkk0sLmU4+h0quoVXNp0bz+z6vOC/YyrMbYLGc/CxR5MIGgEZ4hp4zVSAvCa/u
rNB4ZWeFwR0sgH/0p2aZIA4zCa7GhXN3qeVfSoyDWNhRLBzPHqFPCMLy+9RELA/9CznQ5NSZUo2U
ga+q2zyq+wo3KrYquQ1QxXU3ccGt0tvYpeO8rYL55HTwXpP/qnCvY6p0wY07kVH3fvrHXvwNI8ux
M0muYWZ3A9I/VkyO/8fZ+Xjh5J2zjnwovrUFup79+Ror7ExtpZKv3y2bb5K+rOYsGEmcrldQFkHa
oGwCyS1VpBx+oBP/jXVZl3VZl3VZl3VZl3VZl3VZl3VZl3VZl3X53yr/AQs3nosAUAAA

--------------Boundary-00=_U7OP5W46087DBQCSGE6M--

