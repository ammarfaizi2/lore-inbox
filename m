Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTDHThv (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbTDHThv (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:37:51 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:65265 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261651AbTDHThO (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:37:14 -0400
Date: Tue, 8 Apr 2003 21:58:07 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: linux-kernel@vger.kernel.org
Subject: fairsched-A4 for 2.5.66
Message-ID: <20030408195807.GA21496@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After some more work, I'm releasing the fourth version of the
fairsched patch for O(1) enabled kernels.

The patch has been tested _not_ to work, but I hope that
by relasing it some more experienced hackers could help
on debugging it.

I've put up a page explaining the background and the
intended design of the patch at this link:
http://www.cocodriloo.com/~wind/fairsched/

Right now, I've managed to boot it and get running on
a plain system, by using this shell script as init:

#!/bin/sh
mount /proc
mount -n -o remount,rw /
#nice su user1 -c "/cpuhog.sh 1"
#nice su user2 -c "/cpuhog.sh 2"
#nice su user3 -c "/cpuhog.sh 3"
( sleep 2 && echo 1 > fairsched ) &
/bin/bash --login
EOF

cpuhog.sh: this launches $1 parallel gzips

#!/bin/sh
N=$1
while [ $N -ne 0 ]; do
  gzip -c </dev/zero >/dev/null &
  N=$(($N - 1))
done
EOF


If I uncomment any of the "su" commands, I get two possible outcomes:

(states identified by the printk codes for the patch)

a. It enters state Dn and sends the task to the per-user list.
   Then, state Cn (the kernel thread), notices it and activates it.

b. It enters state Dn and then locks up solid.

c. It goes kaboom and gives a "scheduling with no mm" message


I don't really know how to continue this debugging, any ideas?

Greets, Antonio

ps. The page explains some ideas for futher design, mostly whishful
thinking, but perhaps useful.

---


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
    somewhat works when running in debug mode using printk


 include/linux/init_task.h |    2 
 include/linux/sched.h     |   14 ++
 include/linux/sysctl.h    |    1 
 kernel/fork.c             |    1 
 kernel/sched.c            |   89 ++++++++++++++++--
 kernel/sysctl.c           |    3 
 kernel/user.c             |  225 +++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 327 insertions(+), 8 deletions(-)

diff -puN include/linux/init_task.h~fairsched-A4 include/linux/init_task.h
--- 25/include/linux/init_task.h~fairsched-A4	Tue Apr  8 17:49:32 2003
+++ 25-wind/include/linux/init_task.h	Tue Apr  8 17:49:33 2003
@@ -73,6 +73,8 @@
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.time_slice	= HZ,						\
+	.reserved_time_slice	= HZ,					\
+	.user_tasks	= LIST_HEAD_INIT(tsk.user_tasks),		\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
diff -puN include/linux/sched.h~fairsched-A4 include/linux/sched.h
--- 25/include/linux/sched.h~fairsched-A4	Tue Apr  8 17:49:32 2003
+++ 25-wind/include/linux/sched.h	Tue Apr  8 17:49:33 2003
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
diff -puN include/linux/sysctl.h~fairsched-A4 include/linux/sysctl.h
--- 25/include/linux/sysctl.h~fairsched-A4	Tue Apr  8 17:49:32 2003
+++ 25-wind/include/linux/sysctl.h	Tue Apr  8 17:49:33 2003
@@ -129,6 +129,7 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_FAIRSCHED=57,	/* switch per-user fair cpu scheduler*/
 };
 
 
diff -puN kernel/fork.c~fairsched-A4 kernel/fork.c
--- 25/kernel/fork.c~fairsched-A4	Tue Apr  8 17:49:32 2003
+++ 25-wind/kernel/fork.c	Tue Apr  8 17:49:33 2003
@@ -917,6 +917,7 @@ static struct task_struct *copy_process(
 	 * the parent if the child exits early enough.
 	 */
 	p->first_time_slice = 1;
+	p->reserved_time_slice = 0;
 	current->time_slice >>= 1;
 	p->last_run = jiffies;
 	if (!current->time_slice) {
diff -puN kernel/sched.c~fairsched-A4 kernel/sched.c
--- 25/kernel/sched.c~fairsched-A4	Tue Apr  8 17:49:33 2003
+++ 25-wind/kernel/sched.c	Tue Apr  8 21:04:41 2003
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
@@ -1182,6 +1188,39 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
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
+	printk("A1: send_task_to_expired %p enter\n", p);
+
+retry:
+	rq1 = this_rq();
+	printk("A2: before lock rq %p\n", rq1);
+	rq = this_rq_lock();
+	printk("A3: lock rq %p\n", rq);
+
+	if(rq1 != rq){
+		rq_unlock(rq);
+		goto retry;
+	}
+
+	dequeue_task(p, rq->pending);
+	enqueue_task(p, rq->expired);
+
+	rq_unlock(rq);
+	printk("A4: unlock rq %p\n", rq);
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -1193,6 +1232,8 @@ void scheduler_tick(int user_ticks, int 
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	prio_array_t *target;
+	int send_to_user = 0;
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
@@ -1219,7 +1260,9 @@ void scheduler_tick(int user_ticks, int 
 		set_tsk_need_resched(p);
 		return;
 	}
+	//if(fairdebug) printk("B1: before lock rq %p\n", rq);
 	spin_lock(&rq->lock);
+	//if(fairdebug) printk("B2: lock rq %p\n", rq);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter and the sleep average. Note: we
@@ -1246,8 +1289,9 @@ void scheduler_tick(int user_ticks, int 
 		}
 		goto out;
 	}
-	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
+	if (p->time_slice) {
+		--p->time_slice;
+		dequeue_task(p, target);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
@@ -1256,13 +1300,36 @@ void scheduler_tick(int user_ticks, int 
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
+				send_to_user = 1;
+			}else{
+				target = rq->expired;
+			}
+		} else {
+			target = rq->active;
+		}
+
+		enqueue_task(p, target);
 	}
 out:
 	spin_unlock(&rq->lock);
+	//if(fairdebug) printk("B3: unlock rq %p\n", rq);
 	rebalance_tick(rq, 0);
+
+	if(send_to_user) {
+		if(fairdebug)
+			printk("B4: send_task_to_user %p\n", p);
+
+		INIT_WORK(&p->work_to_user, send_task_to_user, p);
+		schedule_work(&p->work_to_user);
+
+		if(fairdebug)
+			printk("B5: send_task_to_user %p done\n", p);
+	}
 }
 
 void scheduling_functions_start_here(void) { }
@@ -1345,6 +1412,13 @@ pick_next_task:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+	if(0 && fairsched && !next->time_slice){
+		printk("E: send task %p to pending\n", next);
+		dequeue_task(next, array);
+		enqueue_task(next, rq->pending);
+		goto pick_next_task;
+	}
+
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
@@ -2514,12 +2588,13 @@ void __init sched_init(void)
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
diff -puN kernel/sysctl.c~fairsched-A4 kernel/sysctl.c
--- 25/kernel/sysctl.c~fairsched-A4	Tue Apr  8 17:49:33 2003
+++ 25-wind/kernel/sysctl.c	Tue Apr  8 17:49:33 2003
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
 
diff -puN kernel/user.c~fairsched-A4 kernel/user.c
--- 25/kernel/user.c~fairsched-A4	Tue Apr  8 17:49:33 2003
+++ 25-wind/kernel/user.c	Tue Apr  8 20:45:23 2003
@@ -12,6 +12,9 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/pid.h>
+
+#include <asm/uaccess.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -26,23 +29,30 @@
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
 
@@ -97,6 +107,11 @@ struct user_struct * alloc_uid(uid_t uid
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
@@ -134,6 +149,204 @@ void switch_uid(struct user_struct *new_
 }
 
 
+extern void send_task_to_expired(void *);
+
+/*
+ * fairsched_thread - this is a highprio system thread that gives
+ * out timeslices to users and passes user' timeslices to tasks
+ */
+static int fairsched_thread(void *data)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
+	int cpu = (long) data;
+	int ret;
+
+	daemonize("fairsched/%d", cpu);
+	set_fs(KERNEL_DS);
+
+	if(0) ret = sys_sched_setscheduler(0, SCHED_FIFO, &param);
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
+			schedule_timeout(HZ);
+		}
+
+		/* Wake up every HZ ticks */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(8*HZ);
+
+		preempt_disable();
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
+			printk("C1: inc user %d\n", uid);
+
+		/*
+		 * Update user time slice count
+		 */
+		u->time_slice += 4;
+		if(u->time_slice > 8)
+			u->time_slice = 8;
+
+		if(fairdebug)
+			printk("C2: before spin_lock task_list\n");
+		spin_lock(&u->task_list_lock);
+
+		if(fairdebug)
+			printk("C3: spin_lock tasklist\n");
+
+		num_tasks = atomic_read(&u->processes);
+
+		if(fairdebug)
+			printk("C4: %d has %d ticks for %d tasks\n",
+				u->uid, u->time_slice, num_tasks);
+
+		while(u->time_slice && num_tasks--) {
+			int giveout;
+
+			if(fairdebug)
+				printk("C5: get per-user task list\n");
+
+			if(list_empty(&u->task_list)) goto end_user;
+			p = list_entry(u->task_list.next, task_t, user_tasks);
+
+			if(fairdebug)
+				printk("C6: got task %p, with %d reserved ticks\n",
+					p, p->reserved_time_slice);
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
+					printk("C7: user %d has %d ticks now\n",
+						u->uid, u->time_slice);
+
+				if(fairdebug)
+					printk("C8: task %p has %d ticks now\n",
+					p, p->time_slice);
+
+				if(fairdebug)
+					printk("C9: send_task_to_expired %p\n", p);
+
+				list_del(&p->user_tasks);
+#if 1
+				INIT_WORK(&p->work_to_user, send_task_to_expired, p);
+				schedule_work(&p->work_to_user);
+#else
+				send_task_to_expired(p);
+#endif
+			} else {
+				if(fairdebug)
+					printk("C10: round robin task %p\n", p);
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
+		if(fairdebug)
+			printk("C11: spin_unlock task_list\n");
+		/* Round-robin user list */
+		list_del(&u->user_list);
+		list_add_tail(&u->user_list, &user_list);
+
+		atomic_dec(&u->__count);
+		if(fairdebug)
+			printk("C12: dec user %d\n", uid);
+no_user:
+		preempt_enable();
+	}
+}
+
+void send_task_to_user(void *data)
+{
+	task_t *p = data;
+	struct user_struct *u;
+	int uid;
+	
+	if(fairdebug)
+		printk("D1: send_task_to_user %p enter\n", p);
+
+	u = p->user;
+
+	if(fairdebug)
+		printk("D1: before lock uidhash\n");
+	spin_lock(&uidhash_lock);
+
+	if(fairdebug)
+		printk("D2: lock uidhash\n");
+
+	atomic_inc(&u->__count);
+	uid = u->uid;
+
+	if(fairdebug)
+		printk("D3: inc user %d\n", uid);
+
+	spin_unlock(&uidhash_lock);
+
+	if(fairdebug)
+		printk("D4: unlock uidhash\n");
+
+	if(&p->user == &root_user){
+		send_task_to_expired(p);
+		//INIT_WORK(&p->work_to_user, send_task_to_expired, p);
+		//schedule_work(&p->work_to_user);
+		goto out_user;
+	}
+
+	/* add task to user's expired task list */
+
+	if(fairdebug)
+		printk("D6: before lock task_list %d\n", uid);
+
+	spin_lock(&u->task_list_lock);
+
+	if(fairdebug)
+		printk("D6: lock task_list %d\n", uid);
+
+	list_del(&p->user_tasks);
+	list_add_tail(&p->user_tasks,&u->task_list);
+
+	spin_unlock(&u->task_list_lock);
+
+	if(fairdebug)
+		printk("D7: unlock task_list %d\n", uid);
+
+out_user:
+	atomic_dec(&u->__count);
+
+	if(fairdebug)
+		printk("D8: dec user %d\n", uid);
+}
+
 static int __init uid_cache_init(void)
 {
 	int n;
@@ -147,8 +360,18 @@ static int __init uid_cache_init(void)
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
