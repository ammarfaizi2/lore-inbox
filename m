Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263559AbTDNQ1D (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263560AbTDNQ1D (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:27:03 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:9203 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263559AbTDNQ0i (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:26:38 -0400
Date: Mon, 14 Apr 2003 18:49:21 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: frankeh@watson.ibm.com, rml@tech9.net, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, frankeh@optonline.net,
       nagar.us.ibm.com@elinux01.watson.ibm.com
Subject: fairsched-A5 for 2.5.66
Message-ID: <20030414164921.GF14552@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is a forward port of the fairsched-2.4.19 patch by Rik van Riel, which
ensures all competing users get an equal share of cpu time.

Since the earlier patch applied to the classic O(n) process scheduler,
and this one applies to the standard 2.5 O(1) one, the mapping isn't
one-to-one but rather more complex.

The news:

Original 2.4.19 version:       Rik van Riel, riel@surriel.com
Forward ported 2.5.66 version: Antonio Vargas, wind@cocodriloo.com

A0: initial layout for code and data

A1: introduce runqueue handling related to per-user cpu share

A2: add proper locking and O(1) behaviour

A3: perform all work with a kernel thread

A4: introduced a new priority array to park pending tasks,
    works when running in debug mode using printk

A5: A4 never worked when using printk. It works for user==root,
    but fails when we introduce any other user in the system.
    Added lotsa printk to trace the thing, but I don't know
    why it fails or how to make it work. HELP!!!

I've put it up on this URL:

http://www.cocodriloo.com/~wind/fairsched/index.html


Hope a more scheduler-related experienced kernel hacker can help me
on this issue.

Greets, Antonio.


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fairsched-2.5.66-A5-patch"



This patch is a forward port of the fairsched-2.4.19 patch by Rik van Riel, which
ensures all competing users get an equal share of cpu time.

Since the earlier patch applied to the classic O(n) process scheduler,
and this one applies to the standard 2.5 O(1) one, the mapping isn't
one-to-one but rather more complex.

Original 2.4.19 version:       Rik van Riel, riel@surriel.com
Forward ported 2.5.66 version: Antonio Vargas, wind@cocodriloo.com

A0: initial layout for code and data

A1: introduce runqueue handling related to per-user cpu share

A2: add proper locking and O(1) behaviour

A3: perform all work with a kernel thread

A4: introduced a new priority array to park pending tasks,
    works when running in debug mode using printk

A5: A4 never worked when using printk. It works for user==root,
    but fails when we introduce any other user in the system.
    Added lotsa printk to trace the thing, but I don't know
    why it fails or how to make it work. HELP!!!


 include/linux/init_task.h |    2 
 include/linux/sched.h     |   14 ++
 include/linux/sysctl.h    |    1 
 kernel/fork.c             |    1 
 kernel/sched.c            |  120 +++++++++++++++++++-
 kernel/sysctl.c           |    3 
 kernel/user.c             |  265 +++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 397 insertions(+), 9 deletions(-)

diff -puN include/linux/init_task.h~fairsched-A5 include/linux/init_task.h
--- 25/include/linux/init_task.h~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/include/linux/init_task.h	Thu Apr 10 20:58:19 2003
@@ -73,6 +73,8 @@
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.time_slice	= HZ,						\
+	.reserved_time_slice	= HZ,					\
+	.user_tasks	= LIST_HEAD_INIT(tsk.user_tasks),		\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
diff -puN include/linux/sched.h~fairsched-A5 include/linux/sched.h
--- 25/include/linux/sched.h~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/include/linux/sched.h	Thu Apr 10 20:58:19 2003
@@ -280,6 +280,16 @@ struct user_struct {
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
 	uid_t uid;
+
+	/* User list */
+	struct list_head user_list;
+
+	/* Task list for this user, and protecting spinlock */
+	struct list_head task_list;
+	spinlock_t task_list_lock;
+
+	/* Per-user timeslice management */
+	unsigned int time_slice;
 };
 
 #define get_current_user() ({ 				\
@@ -333,7 +343,11 @@ struct task_struct {
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	unsigned int reserved_time_slice;
+
+	struct work_struct work_to_user;
 
+	struct list_head user_tasks;
 	struct list_head tasks;
 	struct list_head ptrace_children;
 	struct list_head ptrace_list;
diff -puN include/linux/sysctl.h~fairsched-A5 include/linux/sysctl.h
--- 25/include/linux/sysctl.h~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/include/linux/sysctl.h	Thu Apr 10 20:58:19 2003
@@ -129,6 +129,7 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_FAIRSCHED=57,	/* switch per-user fair cpu scheduler*/
 };
 
 
diff -puN kernel/fork.c~fairsched-A5 kernel/fork.c
--- 25/kernel/fork.c~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/kernel/fork.c	Thu Apr 10 20:58:19 2003
@@ -917,6 +917,7 @@ static struct task_struct *copy_process(
 	 * the parent if the child exits early enough.
 	 */
 	p->first_time_slice = 1;
+	p->reserved_time_slice = 0;
 	current->time_slice >>= 1;
 	p->last_run = jiffies;
 	if (!current->time_slice) {
diff -puN kernel/sched.c~fairsched-A5 kernel/sched.c
--- 25/kernel/sched.c~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/kernel/sched.c	Mon Apr 14 17:47:23 2003
@@ -33,6 +33,12 @@
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
 
+/*
+ * Switch per-user fair scheduler on/off
+ */
+int fairsched = 0;
+int fairdebug = 1;
+
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
@@ -159,7 +165,7 @@ struct runqueue {
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
+	prio_array_t *active, *expired, *pending, arrays[3];
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
@@ -1182,6 +1188,60 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
+ * Per-user fair cpu scheduler:
+ * We need two basic primitives:
+ *   1. Send a task from the runqueue to the user queue
+ *   2. Send a task from the user queue to the runqueue
+ */
+extern void send_task_to_user(void *);
+
+void send_task_to_expired(void *data)
+{
+	task_t *p = data;
+	runqueue_t *rq, *rq1;
+
+	if(fairdebug)
+	printk("A10: send_task_to_expired %p enter\n", p);
+
+retry:
+	rq1 = this_rq();
+
+	if(fairdebug)
+	printk("A20: before lock rq %p\n", rq1);
+
+	rq = this_rq_lock();
+
+	if(fairdebug)
+	printk("A30: lock rq %p\n", rq);
+
+	if(rq1 != rq){
+		rq_unlock(rq);
+		goto retry;
+	}
+
+	if(fairdebug) {
+	printk("A33:  p->array   %p\n", p->array);
+	printk("A34: rq->active  %p\n", rq->active);
+	printk("A35: rq->expired %p\n", rq->expired);
+	printk("A36: rq->pending %p\n", rq->pending);
+
+	printk("A37:");
+	printk("A37: p->array->nr_active %d\n", p->array->nr_active);
+	}
+
+	if(p->array)
+		dequeue_task(p, p->array);
+
+	enqueue_task(p, rq->expired);
+	set_tsk_need_resched(p);
+
+	rq_unlock(rq);
+
+	if(fairdebug)
+	printk("A40: unlock rq %p\n", rq);
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -1193,6 +1253,8 @@ void scheduler_tick(int user_ticks, int 
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	prio_array_t *target;
+	int send_to_user = 0;
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
@@ -1219,7 +1281,15 @@ void scheduler_tick(int user_ticks, int 
 		set_tsk_need_resched(p);
 		return;
 	}
+
+	if(fairdebug)
+	printk("B10: before lock rq %p\n", rq);
+
 	spin_lock(&rq->lock);
+
+	if(fairdebug)
+	printk("B20: lock rq %p\n", rq);
+
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter and the sleep average. Note: we
@@ -1246,9 +1316,11 @@ void scheduler_tick(int user_ticks, int 
 		}
 		goto out;
 	}
-	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
-		set_tsk_need_resched(p);
+
+	if (p->time_slice)
+		--p->time_slice;
+
+	if(!p->time_slice) {
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
@@ -1256,13 +1328,44 @@ void scheduler_tick(int user_ticks, int 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+
+			if(p->user->uid && fairsched) {
+				p->reserved_time_slice += p->time_slice;
+				p->time_slice = 0;
+				target = rq->pending;
+
+				deactivate_task(p, rq);
+
+				send_to_user = 1;
+			}else{
+				target = rq->expired;
+			}
+		} else {
+			target = rq->active;
+		}
+
+		if(!send_to_user){
+			dequeue_task(p, rq->active);
+		}
+		set_tsk_need_resched(p);
+		enqueue_task(p, target);
 	}
 out:
 	spin_unlock(&rq->lock);
+	if(fairdebug)
+	printk("B30: unlock rq %p\n", rq);
 	rebalance_tick(rq, 0);
+
+	if(send_to_user) {
+		if(fairdebug)
+		printk("B40: send_task_to_user %p\n", p);
+
+		INIT_WORK(&p->work_to_user, send_task_to_user, p);
+		schedule_work(&p->work_to_user);
+
+		if(fairdebug)
+		printk("B50: send_task_to_user %p done\n", p);
+	}
 }
 
 void scheduling_functions_start_here(void) { }
@@ -2514,12 +2617,13 @@ void __init sched_init(void)
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+		rq->pending = rq->arrays + 2;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
 		nr_running_init(rq);
 
-		for (j = 0; j < 2; j++) {
+		for (j = 0; j < 3; j++) {
 			array = rq->arrays + j;
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
diff -puN kernel/sysctl.c~fairsched-A5 kernel/sysctl.c
--- 25/kernel/sysctl.c~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/kernel/sysctl.c	Thu Apr 10 20:58:19 2003
@@ -57,6 +57,7 @@ extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int fairsched;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -263,6 +264,8 @@ static ctl_table kern_table[] = {
 #endif
 	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
 	 0600, NULL, &proc_dointvec},
+	{KERN_FAIRSCHED, "fairsched", &fairsched, sizeof (int),
+	 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -puN kernel/user.c~fairsched-A5 kernel/user.c
--- 25/kernel/user.c~fairsched-A5	Thu Apr 10 20:58:19 2003
+++ 25-wind/kernel/user.c	Mon Apr 14 17:41:08 2003
@@ -12,6 +12,10 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/pid.h>
+
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -26,23 +30,30 @@
 static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
 static spinlock_t uidhash_lock = SPIN_LOCK_UNLOCKED;
+struct list_head user_list;
 
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.time_slice	= 1
 };
 
+extern int fairsched;
+extern int fairdebug;
+
 /*
  * These routines must be called with the uidhash spinlock held!
  */
 static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
 {
 	list_add(&up->uidhash_list, hashent);
+	list_add(&up->user_list, &user_list);
 }
 
 static inline void uid_hash_remove(struct user_struct *up)
 {
+	list_del(&up->user_list);
 	list_del(&up->uidhash_list);
 }
 
@@ -71,10 +82,19 @@ struct user_struct *find_user(uid_t uid)
 
 void free_uid(struct user_struct *up)
 {
+	if(fairdebug)
+	printk("G10: perhaps lock uidhash\n");
+
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
+		if(fairdebug)
+		printk("G20: lock uidhash\n");
+
 		uid_hash_remove(up);
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
+
+		if(fairdebug)
+		printk("G30: unlock uidhash\n");
 	}
 }
 
@@ -83,10 +103,16 @@ struct user_struct * alloc_uid(uid_t uid
 	struct list_head *hashent = uidhashentry(uid);
 	struct user_struct *up;
 
+	if(fairdebug)
+	printk("F10: lock uidhash\n");
+
 	spin_lock(&uidhash_lock);
 	up = uid_hash_find(uid, hashent);
 	spin_unlock(&uidhash_lock);
 
+	if(fairdebug)
+	printk("F20: unlock uidhash\n");
+
 	if (!up) {
 		struct user_struct *new;
 
@@ -97,11 +123,23 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		new->time_slice = 1;
+
+		INIT_LIST_HEAD(&new->user_list);
+		INIT_LIST_HEAD(&new->task_list);
+		spin_lock_init(&new->task_list_lock);
 
 		/*
 		 * Before adding this, check whether we raced
 		 * on adding the same user already..
 		 */
+
+		if(fairdebug)
+		printk("F25: new user %d\n", new->uid);
+
+		if(fairdebug)
+		printk("F30: lock uidhash\n");
+
 		spin_lock(&uidhash_lock);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
@@ -112,6 +150,9 @@ struct user_struct * alloc_uid(uid_t uid
 		}
 		spin_unlock(&uidhash_lock);
 
+		if(fairdebug)
+		printk("F40: unlock uidhash\n");
+
 	}
 	return up;
 }
@@ -134,6 +175,218 @@ void switch_uid(struct user_struct *new_
 }
 
 
+extern void send_task_to_expired(void *);
+extern asmlinkage long sys_sched_setscheduler(
+	pid_t pid, int policy, struct sched_param *param);
+
+/*
+ * fairsched_thread - this is a highprio system thread that gives
+ * out timeslices to users and passes user' timeslices to tasks
+ */
+static int fairsched_thread(void *data)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
+	int cpu = (long) data;
+
+	daemonize("fairsched/%d", cpu);
+	set_fs(KERNEL_DS);
+
+	sys_sched_setscheduler(0, SCHED_FIFO, &param);
+
+	for(;;) {
+		struct user_struct *u;
+		task_t *p;
+
+		int num_tasks,uid;
+
+		while(!fairsched){
+			/* Sleep until we are switched on */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(8);
+		}
+
+		/* Wake up every HZ ticks */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(8);
+
+		/*
+		 * Get user
+		 */
+		if(list_empty(&user_list)) goto no_user;
+		u = list_entry(user_list.next, struct user_struct, user_list);
+		if(u == &root_user) goto no_user;
+
+		atomic_inc(&u->__count);
+
+		uid = u->uid;
+		if(fairdebug)
+		printk("C1: inc user %d\n", uid);
+
+		/*
+		 * Update user time slice count
+		 */
+		u->time_slice += 8;
+		if(u->time_slice > 12)
+			u->time_slice = 12;
+
+		if(fairdebug)
+		printk("C2: before spin_lock user task_list\n");
+
+		spin_lock(&u->task_list_lock);
+
+		if(fairdebug)
+		printk("C3: spin_lock user task_list\n");
+
+		num_tasks = atomic_read(&u->processes);
+
+		if(fairdebug)
+		printk("C4: %d has %d ticks for %d tasks\n",
+			u->uid, u->time_slice, num_tasks);
+
+		while(u->time_slice && num_tasks--) {
+			int giveout;
+
+			if(fairdebug)
+			printk("C5: read user task list\n");
+
+			if(list_empty(&u->task_list)) goto end_user;
+			p = list_entry(u->task_list.next, task_t, user_tasks);
+
+			if(fairdebug)
+			printk("C6: got task %p, with %d reserved ticks\n",
+				p, p->reserved_time_slice);
+
+			/* Get timeslices from user and task reserve */
+			giveout = min(u->time_slice, p->reserved_time_slice);
+			if(giveout) {
+				/*
+				 * Give the timeslice to the task,
+				 * and queue the task into the expired array.
+				 */
+				u->time_slice -= giveout;
+				p->reserved_time_slice -= giveout;
+				p->time_slice += giveout;
+
+				if(fairdebug)
+				printk("C7: user %d has %d ticks now\n",
+					u->uid, u->time_slice);
+
+				if(fairdebug)
+				printk("C8: task %p has %d ticks now\n",
+					p, p->time_slice);
+
+				if(fairdebug)
+				printk("C9: send_task_to_expired %p\n", p);
+
+				list_del(&p->user_tasks);
+
+				INIT_WORK(&p->work_to_user, send_task_to_expired, p);
+				schedule_work(&p->work_to_user);
+			} else {
+				if(fairdebug)
+				printk("C10: round robin task %p\n", p);
+
+				/* Round-robin per-user task list */
+				list_del(&p->user_tasks);
+				list_add_tail(&p->user_tasks, &u->task_list);
+			}
+		}
+
+end_user:
+
+		spin_unlock(&u->task_list_lock);
+
+		if(fairdebug)
+		printk("C11: spin_unlock user task_list\n");
+
+		/* Round-robin user list */
+		list_del(&u->user_list);
+		list_add_tail(&u->user_list, &user_list);
+
+		atomic_dec(&u->__count);
+
+		if(fairdebug)
+		printk("C12: dec user %d\n", uid);
+no_user:
+	}
+}
+
+
+void debug_d10(void){}
+void debug_d90(void){}
+
+
+void send_task_to_user(void *data)
+{
+	task_t *p = data;
+	struct user_struct *u;
+	int send_to_expired = 0;
+	int uid;
+
+	debug_d10();
+
+	if(fairdebug)
+	printk("D10: send_task_to_user %p enter\n", p);
+
+	u = p->user;
+
+	if(fairdebug)
+	printk("D20: before lock uidhash\n");
+
+	spin_lock(&uidhash_lock);
+
+	if(fairdebug)
+	printk("D30: lock uidhash\n");
+
+	atomic_inc(&u->__count);
+	uid = u->uid;
+
+	if(fairdebug)
+	printk("D40: inc user %d\n", uid);
+
+	spin_unlock(&uidhash_lock);
+
+	if(fairdebug)
+	printk("D50: unlock uidhash\n");
+
+	if(p->user == &root_user){
+		send_to_expired = 1;
+		goto out_user;
+	}
+
+	/* add task to user's expired task list */
+
+	if(fairdebug)
+	printk("D60: before lock task_list %d\n", uid);
+
+	spin_lock(&u->task_list_lock);
+
+	if(fairdebug)
+	printk("D70: lock task_list %d\n", uid);
+
+	list_del(&p->user_tasks);
+	list_add_tail(&p->user_tasks,&u->task_list);
+
+	spin_unlock(&u->task_list_lock);
+
+	if(fairdebug)
+	printk("D80: unlock task_list %d\n", uid);
+
+out_user:
+	atomic_dec(&u->__count);
+
+	if(fairdebug)
+	printk("D90: dec user %d\n", uid);
+
+	debug_d90();
+
+	if(send_to_expired) {
+		send_task_to_expired(p);
+	}
+
+	set_tsk_need_resched(p);
+}
+
 static int __init uid_cache_init(void)
 {
 	int n;
@@ -147,8 +400,18 @@ static int __init uid_cache_init(void)
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_LIST_HEAD(uidhash_table + n);
 
+	INIT_LIST_HEAD(&user_list);
+	INIT_LIST_HEAD(&root_user.user_list);
+	INIT_LIST_HEAD(&root_user.task_list);
+	spin_lock_init(&root_user.task_list_lock);
+
+	list_add(&root_user.user_list, &user_list);
+
 	/* Insert the root user immediately - init already runs with this */
 	uid_hash_insert(&root_user, uidhashentry(0));
+
+	kernel_thread(fairsched_thread, 0, CLONE_KERNEL);
+
 	return 0;
 }
 

_

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fairsched-2.5.66-A5-debug"
Content-Transfer-Encoding: quoted-printable

Script started on Mon Apr 14 18:21:05 2003
=1B]0;wind@wind.cocodriloo.com: /home/wind/src/kernel/compile=07compile$ um=
l-run=0D
core file size        (blocks, -c) 4096=0D
data seg size         (kbytes, -d) unlimited=0D
file size             (blocks, -f) unlimited=0D
max locked memory     (kbytes, -l) unlimited=0D
max memory size       (kbytes, -m) unlimited=0D
open files                    (-n) 1024=0D
pipe size          (512 bytes, -p) 8=0D
stack size            (kbytes, -s) 8192=0D
cpu time             (seconds, -t) unlimited=0D
max user processes            (-u) 1023=0D
virtual memory        (kbytes, -v) unlimited=0D
Checking for the skas3 patch in the host...found=0D
Checking for /proc/mm...found=0D
Linux version 2.5.66-1um (wind@wind.cocodriloo.com) (gcc version 2.95.4 200=
11002 (Debian prerelease)) #17 SMP Mon Apr 14 17:48:16 CEST 2003=0D
On node 0 totalpages: 8192=0D
  DMA zone: 8192 pages, LIFO batch:2=0D
  Normal zone: 0 pages, LIFO batch:1=0D
  HighMem zone: 0 pages, LIFO batch:1=0D
Building zonelist for node : 0=0D
Kernel command line: root=3D/dev/ubd0 ubd0=3D../root init=3D/init.sh=0D
PID hash table entries: 16 (order 4: 128 bytes)=0D
Calibrating delay loop... 792.99 BogoMIPS=0D
Memory: 29800k available=0D
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)=0D
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)=0D
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=0D
-> /dev=0D
-> /dev/console=0D
-> /root=0D
Checking for host processor cmov support...No=0D
Checking for host processor xmm support...No=0D
Checking that ptrace can change system call numbers...OK=0D
Checking that host ptys support output SIGIO...Yes=0D
Checking that host ptys support SIGIO on close...No, enabling workaround=0D
POSIX conformance testing by UNIFIX=0D
os_set_fd_async : Failed to fcntl F_SETOWN (or F_SETSIG) fd 4 to pid -15772=
23120, errno =3D 1=0D
Starting migration thread for cpu 0=0D
G10: perhaps lock uidhash=0D
G10: perhaps lock uidhash=0D
CPUS done 32=0D
Linux NoNET1.0 for Linux 2.6=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
G10: perhaps lock uidhash=0D
BIO: pool of 256 setup, 14Kb (56 bytes/bio)=0D
biovec pool[0]:   1 bvecs:  56 entries (12 bytes)=0D
biovec pool[1]:   4 bvecs:  28 entries (48 bytes)=0D
biovec pool[2]:  16 bvecs:  14 entries (192 bytes)=0D
biovec pool[3]:  64 bvecs:   7 entries (768 bytes)=0D
biovec pool[4]: 128 bvecs:   3 entries (1536 bytes)=0D
biovec pool[5]: 256 bvecs:   1 entries (3072 bytes)=0D
block request queues:=0D
 4/16384 requests per read queue=0D
 4/16384 requests per write queue=0D
 enter congestion at 2047=0D
 exit congestion at 2049=0D
mconsole (version 2) initialized on /home/wind/.uml/sAhrcA/mconsole=0D
Initializing stdio console driver=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
G10: perhaps lock uidhash=0D
G10: perhaps lock uidhash=0D
G10: perhaps lock uidhash=0D
G10: perhaps lock uidhash=0D
G10: perhaps lock uidhash=0D
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0D
blk_init_queue: queue a024c500 inited=0D
 ubd0: unknown partition table=0D
VFS: Mounted root (ext2 filesystem) readonly.=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
root@(none):/# su user1=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
su[15]: + console root-user1=0D
=0D=0D
PAM_unix[15]: (su) session opened for user user1 by (uid=3D0)=0D=0D
F10: lock uidhash=0D
F20: unlock uidhash=0D
F25: new user 1001=0D
F30: lock uidhash=0D
F40: unlock uidhash=0D
G10: perhaps lock uidhash=0D
B10: before lock rq a0170b20=0D
B20: lock rq a0170b20=0D
B30: unlock rq a0170b20=0D
B40: send_task_to_user a02e9814=0D
B50: send_task_to_user a02e9814 done=0D
D10: send_task_to_user a02e9814 enter=0D
D20: before lock uidhash=0D
D30: lock uidhash=0D
D40: inc user 1001=0D
D50: unlock uidhash=0D
D60: before lock task_list 1001=0D
D70: lock task_list 1001=0D
D80: unlock task_list 1001=0D
D90: dec user 1001=0D
Kernel panic: Segfault with no mm=0D
=1B]0;wind@wind.cocodriloo.com: /home/wind/src/kernel/compile=07compile$ ex=
it=0D

Script done on Mon Apr 14 18:21:31 2003

--BXVAT5kNtrzKuDFl--
