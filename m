Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275889AbSIUJ6P>; Sat, 21 Sep 2002 05:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275890AbSIUJ6P>; Sat, 21 Sep 2002 05:58:15 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:38805 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S275889AbSIUJ6H>; Sat, 21 Sep 2002 05:58:07 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] node affine NUMA scheduler
Date: Sat, 21 Sep 2002 12:02:13 +0200
User-Agent: KMail/1.4.1
Cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <200209211159.41751.efocht@ess.nec.de>
In-Reply-To: <200209211159.41751.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_P79SV8D04B7JY1LDF6VL"
Message-Id: <200209211202.13298.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_P79SV8D04B7JY1LDF6VL
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Here comes the second part of the node affine NUMA scheduler.

> The patch comes in two parts. The first part is the core NUMA scheduler=
,
> it is functional without the second part and provides following feature=
s:
>  - Node aware scheduler (implemented CPU pools).
>  - Scheduler behaves like O(1) scheduler within a node.
>  - Equal load among nodes is targeted, stealing tasks from remote nodes
>    is delayed more if the current node is averagely loaded, less if it'=
s
>    unloaded.
>  - Multi-level node hierarchies are supported by stealing delays adjust=
ed
>    by the relative "node-distance" (memory access latency ratio).
>
> The second part of the patch extends the pooling NUMA scheduler to
> have node affine tasks:
>  - Each process has a homenode assigned to it at creation time
>    (initial load balancing). Memory will be allocated from this node.
>  - Each process is preferentially scheduled on its homenode and
>    attracted back to it if scheduled away for some reason. For
>    multi-level node hierarchies the task is attracted to its
>    supernode, too.

Regards,
Erich

--------------Boundary-00=_P79SV8D04B7JY1LDF6VL
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="02-numa_sched_affine-2.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-numa_sched_affine-2.5.patch"

diff -urNp a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Sat Sep 21 11:44:48 2002
+++ b/arch/i386/config.in	Sat Sep 21 11:56:23 2002
@@ -177,7 +177,7 @@ else
      fi
      # Common NUMA Features
      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
-        bool 'Enable NUMA scheduler' CONFIG_NUMA_SCHED
+        bool 'Enable node affine NUMA scheduler' CONFIG_NUMA_SCHED
         bool 'Numa Memory Allocation Support' CONFIG_NUMA
         if [ "$CONFIG_NUMA" = "y" ]; then
            define_bool CONFIG_DISCONTIGMEM y
diff -urNp a/arch/ia64/config.in b/arch/ia64/config.in
--- a/arch/ia64/config.in	Sat Sep 21 11:44:48 2002
+++ b/arch/ia64/config.in	Sat Sep 21 11:56:23 2002
@@ -67,13 +67,13 @@ fi
 if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_DIG" = "y" -o "$CONFIG_IA64_HP_ZX1" = "y" ];
 then
 	bool '  Enable IA-64 Machine Check Abort' CONFIG_IA64_MCA
-   	bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
+   	bool '  Enable node affine NUMA scheduler' CONFIG_NUMA_SCHED
 	define_bool CONFIG_PM y
 fi
 
 if [ "$CONFIG_IA64_SGI_SN1" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ]; then
 	define_bool CONFIG_IA64_SGI_SN y
-   	bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
+   	bool '  Enable node affine NUMA scheduler' CONFIG_NUMA_SCHED
 	bool '  Enable extra debugging code' CONFIG_IA64_SGI_SN_DEBUG
 	bool '  Enable SGI Medusa Simulator Support' CONFIG_IA64_SGI_SN_SIM
 	bool '  Enable autotest (llsc). Option to run cache test instead of booting' \
diff -urNp a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri Sep 20 17:20:23 2002
+++ b/fs/exec.c	Sat Sep 21 11:56:23 2002
@@ -995,6 +995,9 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	if (current->node_policy == NODPOL_EXEC)
+		sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp a/include/asm-i386/mmzone.h b/include/asm-i386/mmzone.h
--- a/include/asm-i386/mmzone.h	Fri Sep 20 17:20:26 2002
+++ b/include/asm-i386/mmzone.h	Sat Sep 21 11:56:23 2002
@@ -20,7 +20,11 @@
 #endif /* CONFIG_X86_NUMAQ */
 
 #ifdef CONFIG_NUMA
+#ifdef CONFIG_NUMA_SCHED
+#define numa_node_id() (current->node)
+#else
 #define numa_node_id() _cpu_to_node(smp_processor_id())
+#endif
 #endif /* CONFIG_NUMA */
 
 extern struct pglist_data *node_data[];
diff -urNp a/include/linux/prctl.h b/include/linux/prctl.h
--- a/include/linux/prctl.h	Fri Sep 20 17:20:30 2002
+++ b/include/linux/prctl.h	Sat Sep 21 11:56:23 2002
@@ -34,4 +34,10 @@
 # define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
 # define PR_FP_EXC_PRECISE	3	/* precise exception mode */
 
+/* Get/set node for node-affine scheduling */
+#define PR_GET_NODE       16
+#define PR_SET_NODE       17
+#define PR_GET_NODPOL     18
+#define PR_SET_NODPOL     19
+
 #endif /* _LINUX_PRCTL_H */
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat Sep 21 11:44:48 2002
+++ b/include/linux/sched.h	Sat Sep 21 11:56:23 2002
@@ -159,6 +159,15 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
+#ifdef CONFIG_NUMA_SCHED
+extern void sched_balance_exec(void);
+extern void sched_balance_fork(task_t *p);
+extern void set_task_node(task_t *p, int node);
+#else
+#define sched_balance_exec() {}
+#define sched_balance_fork(p) {}
+#define set_task_node(p,n) {}
+#endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
@@ -293,6 +302,8 @@ struct task_struct {
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	int node;
+	int node_policy;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -484,9 +495,13 @@ extern char lnode_number[NR_CPUS] __cach
 
 extern void pooldata_lock(void);
 extern void pooldata_unlock(void);
+# define HOMENODE_INC(rq,node) (rq)->nr_homenode[node]++
+# define HOMENODE_DEC(rq,node) (rq)->nr_homenode[node]--
 #else
 # define POOL_DELAY(x,y)  (0)
 # define CPU_TO_NODE(cpu) (0)
+# define HOMENODE_INC(rq,node) {}
+# define HOMENODE_DEC(rq,node) {}
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urNp a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Sep 20 17:20:16 2002
+++ b/kernel/fork.c	Sat Sep 21 11:56:23 2002
@@ -701,6 +701,9 @@ static struct task_struct *copy_process(
 #ifdef CONFIG_SMP
 	{
 		int i;
+		if (p->node_policy == NODPOL_FORK_ALL ||
+		    (p->node_policy == NODPOL_FORK && !(clone_flags & CLONE_VM)))
+				sched_balance_fork(p);
 
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < NR_CPUS; i++)
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Sep 21 11:44:48 2002
+++ b/kernel/sched.c	Sat Sep 21 11:56:23 2002
@@ -156,6 +156,7 @@ struct runqueue {
 
 	unsigned long wait_time;
 	int wait_node;
+	short nr_homenode[NR_NODES];
 	int load[2][NR_CPUS];
 
 } ____cacheline_aligned;
@@ -328,6 +329,7 @@ static inline void activate_task(task_t 
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	HOMENODE_INC(rq,p->node);
 }
 
 /*
@@ -335,6 +337,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	HOMENODE_DEC(rq,p->node);
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
@@ -696,6 +699,9 @@ static int calc_pool_load(int data[][NR_
 		else
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;
+		/* prefer cpus running tasks from this node */
+		if (pool != this_pool)
+			load += rq_src->nr_homenode[this_pool];
 
 		data[0][i] = load;
 		data[1][pool] += load;
@@ -851,6 +857,13 @@ skip_queue:
 
 	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
+		/* limit weight influence of sleep_time and cache coolness */
+		if (weight >= MAX_CACHE_WEIGHT) weight=MAX_CACHE_WEIGHT-1;
+		/* weight depending on homenode of task */
+		weight += POOL_WEIGHT(this_pool,tmp->node);
+		/* task gets bonus if running on its homenode */
+		if (tmp->node == CPU_TO_NODE(task_cpu(busiest->curr)))
+			weight -= MAX_CACHE_WEIGHT;
 		if (weight > maxweight) {
 			maxweight = weight;
 			next = tmp;
@@ -885,6 +898,36 @@ static inline void pull_task(runqueue_t 
 		set_need_resched();
 }
 
+static inline void
+try_push_home(runqueue_t *this_rq, int this_cpu, int nr_running)
+{
+	task_t *p;
+	int tgt_pool, tgt_cpu, i, ii;
+	runqueue_t *rq;
+	static int sched_push_task(task_t *p, int cpu_dest);
+
+	if (nr_running != 1)
+		return;
+	p = this_rq->curr;
+	tgt_pool = p->node;
+	if (tgt_pool != CPU_TO_NODE(this_cpu)) {
+		/* compute how many own tasks run on the tgt node */
+		int load = 0;
+		for (ii=pool_ptr[tgt_pool]; ii<pool_ptr[tgt_pool+1]; ii++) {
+			i = pool_cpus[ii];
+			rq = cpu_rq(i);
+			load += rq->nr_homenode[tgt_pool];
+		}
+		load = BALANCE_FACTOR * load / pool_nr_cpus[tgt_pool];
+		if (load < BALANCE_FACTOR/4) {
+			tgt_cpu = __ffs(p->cpus_allowed & pool_mask[tgt_pool]
+					& cpu_online_map);
+			if (tgt_cpu)
+				sched_push_task(p, tgt_cpu);
+		}
+	}
+}
+
 /*
  * Current runqueue is empty, or rebalance tick: if there is an
  * inbalance (current runqueue is too short) then pull from
@@ -902,6 +945,10 @@ static void load_balance(runqueue_t *thi
 	/* avoid deadlock by timer interrupt on own cpu */
 	if (atomic_read(&pool_lock)) return;
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &nr_running);
+	if (!busiest) {
+		try_push_home(this_rq, this_cpu, nr_running);
+		goto out;
+	}
 
 	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
 	/*
@@ -1972,6 +2019,102 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
+/* used as counter for round-robin node-scheduling */
+static atomic_t sched_node=ATOMIC_INIT(0);
+
+/*
+ * Find the least loaded CPU on the current node of the task.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int n, cpu, load, best_cpu = task_cpu(p);
+	
+	load = 1000000;
+	for (n = pool_ptr[p->node]; n < pool_ptr[p->node+1]; n++) {
+		cpu = pool_cpus[n];
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
+ * Find the node with fewest tasks assigned to it. Don't bother about the
+ * current load of the nodes, the load balancer should take care.
+ * The argument  flag  gives some options for initial load balancing:
+ *    flag = 0:  don't count own task (when balancing at do_exec())
+ *    flag = 1:  count own task (when balancing at do_fork())
+ */
+static int sched_best_node(struct task_struct *p, int flag)
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
+	for (n = 0; n < NR_CPUS; n++) {
+		if (!cpu_online(n)) continue;
+#if 1
+		for (pool = 0; pool < numpools; pool++)
+			load[pool] += cpu_rq(n)->nr_homenode[pool];
+#else
+		load[CPU_TO_NODE(n)] += cpu_rq(n)->nr_running;
+#endif
+	}
+
+	/* don't count own process, this one will be moved */
+	if (!flag)
+		--load[p->node];
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
+void sched_balance_exec(void)
+{
+	int new_cpu, new_node;
+
+	while (atomic_read(&pool_lock))
+		cpu_relax();
+	if (numpools > 1) {
+		new_node = sched_best_node(current, 0);
+		if (new_node != current->node) {
+			set_task_node(current, new_node);
+		}
+	}
+	new_cpu = sched_best_cpu(current);
+	if (new_cpu != smp_processor_id())
+		sched_migrate_task(current, new_cpu);
+}
+
+void sched_balance_fork(task_t *p)
+{
+	while (atomic_read(&pool_lock))
+		cpu_relax();
+	if (numpools > 1)
+		p->node = sched_best_node(p, 1);
+	set_task_cpu(p, sched_best_cpu(p));
+}
+
 #ifdef CONFIG_NUMA_SCHED
 void pools_info(void)
 {
@@ -2141,6 +2284,20 @@ void bld_pools(void)
 	init_pool_delay();
 }
 
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
 #endif /* CONFIG_NUMA_SCHED */
 void __init init_idle(task_t *idle, int cpu)
 {
@@ -2156,6 +2313,7 @@ void __init init_idle(task_t *idle, int 
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
+	idle->node = 0; /* was: SAPICID_TO_PNODE(cpu_physical_id(cpu)); */
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	local_irq_restore(flags);
@@ -2246,6 +2404,42 @@ out:
 	preempt_enable();
 }
 
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
+	unsigned long flags;
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
@@ -2273,6 +2467,7 @@ static int migration_thread(void * data)
 	set_fs(KERNEL_DS);
 
 	set_cpus_allowed(current, 1UL << cpu);
+	set_task_node(current, CPU_TO_NODE(cpu));
 
 	/*
 	 * Migration can happen without a migration thread on the
@@ -2420,6 +2615,9 @@ void __init sched_init(void)
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
+		for (j = 0; j < NR_NODES; j++)
+			rq->nr_homenode[j]=0;
+		pool_cpus[i] = i;
 	}
 #ifdef CONFIG_NUMA_SCHED
 	pool_ptr[0] = 0;
diff -urNp a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Fri Sep 20 17:20:20 2002
+++ b/kernel/softirq.c	Sat Sep 21 11:56:23 2002
@@ -365,6 +365,7 @@ static int ksoftirqd(void * __bind_cpu)
 	set_cpus_allowed(current, 1UL << cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
+	set_task_node(current, CPU_TO_NODE(cpu));
 
 	sprintf(current->comm, "ksoftirqd_CPU%d", cpu);
 
diff -urNp a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Fri Sep 20 17:20:16 2002
+++ b/kernel/sys.c	Sat Sep 21 11:56:23 2002
@@ -1309,6 +1309,8 @@ asmlinkage long sys_prctl(int option, un
 {
 	int error = 0;
 	int sig;
+	int pid;
+	struct task_struct *child;
 
 	error = security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
 	if (error)
@@ -1369,6 +1371,63 @@ asmlinkage long sys_prctl(int option, un
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
+					printk("setting node of pid %d to %d\n",pid,(int)arg2);
+					set_task_node(child,(int)arg2);
+				}
+			} else {
+				printk("prctl: could not find pid %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+
+		case PR_GET_NODPOL:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				error = put_user(child->node_policy,(int *)arg2);
+			} else {
+				printk("prctl: could not find pid %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+		case PR_SET_NODPOL:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				if (child->uid == current->uid || \
+				    current->uid == 0) {
+					printk("setting node policy of process %d to %d\n",pid,(int)arg2);
+					child->node_policy = (int) arg2;
+				}
+			} else {
+				printk("prctl: could not find pid %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
 		default:
 			error = -EINVAL;
 			break;

--------------Boundary-00=_P79SV8D04B7JY1LDF6VL--

