Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTDDLSH (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTDDLNJ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:13:09 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:59890 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263623AbTDDLHh (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 06:07:37 -0500
Date: Fri, 4 Apr 2003 13:27:04 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Antonio Vargas <wind@cocodriloo.com>,
       Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030404112704.GA15864@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <200304021144.21924.frankeh@watson.ibm.com> <20030403125355.GA12001@wind.cocodriloo.com> <20030403192241.GB1828@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20030403192241.GB1828@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2003 at 11:22:41AM -0800, William Lee Irwin III wrote:
> On Thu, Apr 03, 2003 at 02:53:55PM +0200, Antonio Vargas wrote:
> > Sorry for not answering sooner, but I had my mail pointing at
> > the lkml instead of my personal email.
> > Last night I continued coding up but I think I've it a deadlock:
> > it seems the system stops calling schedule_tick() when there are
> > no more tasks to run, and it's there where I use a workqueue so
> > that I can update the user timeslices out of interrupt context.
> > I think that because if I put printk's on my code, it continues to
> > run OK, but if I remove them it freezes hard.
> 
> Use spin_lock_irq(&uidhash_lock) or you will deadlock if you hold it
> while you take a timer tick, but it's wrong anyway. it's O(N) with
> respect to number of users present. An O(1) algorithm could easily
> make use of reference counts held by tasks.
> 
> 
> On Thu, Apr 03, 2003 at 02:53:55PM +0200, Antonio Vargas wrote:
> > About giving ticks to users, I've got an idea: assuming there are N
> > total processes in the system and an user has got M processes, we should
> > give N * max_timeslice ticks to each user every M * max_timeslice *
> > num_users ticks. I've been thinking about it and it seems it would
> > balance the ticks correctly.
> > About the starvation for low-priority processes, I can get and
> > example.. assume user A has process X Y and user B has process Z,
> > and max_timeslice = 2:
> > max_timeslice = 2 and 4 total processes ==>
> > give 2 * 3 = 6 ticks to user A every 2 * 2 * 2 =  8 ticks
> > give 2 * 3 = 6 ticks to user B every 1 * 2 * 2 =  4 ticks
> 
> This isn't right, when expiration happens needs to be tracked by both
> user and task. Basically which tasks are penalized when the user
> expiration happens? The prediction is the same set of tasks will always
> be the target of the penalty.

Just out of experimenting, I've coded something that looks reasonable
and would not experience starvation.

In the normal scheduler, a non-interactive task will, when used all his
timeslice, reset p->time_slice and queue onto the expired array. I'm
now reseting p->reserved_time_slice instead and queuing the task
onto a per-user pending task queue.

A separate kernel thread walks the user list, calculates the user timeslice
and distributes it to it's pending tasks. When a task receives timeslices,
it's moved from the per-user pending queue to the expired array of the runqueue,
thus preparing it to run on the next array-switch.

If the user has many timeslices, he can give timeslices to many tasks, thus
getting more work done.

While the implementation may not be good enough, due to locking problems and
the use of a kernel-thread, I think the fundamental algorithm feels right.

William, should I take the lock on the uidhash_list when adding a task
to a per-user task list?

Greets, Antonio.

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fairsched-A3.patch"



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


 include/linux/init_task.h |    2 
 include/linux/sched.h     |   13 ++++
 include/linux/sysctl.h    |    1 
 kernel/fork.c             |    1 
 kernel/sched.c            |   53 +++++++++++++++++++-
 kernel/sysctl.c           |    3 +
 kernel/user.c             |  120 +++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 191 insertions(+), 2 deletions(-)

diff -puN include/linux/init_task.h~fairsched-A3 include/linux/init_task.h
--- 25/include/linux/init_task.h~fairsched-A3	Fri Apr  4 12:02:44 2003
+++ 25-wind/include/linux/init_task.h	Fri Apr  4 12:02:45 2003
@@ -73,6 +73,8 @@
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.time_slice	= HZ,						\
+	.reserved_time_slice	= HZ,					\
+	.user_tasks	= LIST_HEAD_INIT(tsk.user_tasks),		\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
diff -puN include/linux/sched.h~fairsched-A3 include/linux/sched.h
--- 25/include/linux/sched.h~fairsched-A3	Fri Apr  4 12:02:45 2003
+++ 25-wind/include/linux/sched.h	Fri Apr  4 12:02:45 2003
@@ -280,6 +280,15 @@ struct user_struct {
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
 	uid_t uid;
+
+	/* User list */
+	struct list_head user_list;
+
+	/* Task list for this user */
+	struct list_head task_list;
+
+	/* Per-user timeslice management */
+	unsigned int time_slice;
 };
 
 #define get_current_user() ({ 				\
@@ -333,7 +342,11 @@ struct task_struct {
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
diff -puN include/linux/sysctl.h~fairsched-A3 include/linux/sysctl.h
--- 25/include/linux/sysctl.h~fairsched-A3	Fri Apr  4 12:02:45 2003
+++ 25-wind/include/linux/sysctl.h	Fri Apr  4 12:02:45 2003
@@ -129,6 +129,7 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_FAIRSCHED=57,	/* switch per-user fair cpu scheduler*/
 };
 
 
diff -puN kernel/fork.c~fairsched-A3 kernel/fork.c
--- 25/kernel/fork.c~fairsched-A3	Fri Apr  4 12:02:45 2003
+++ 25-wind/kernel/fork.c	Fri Apr  4 12:02:45 2003
@@ -917,6 +917,7 @@ static struct task_struct *copy_process(
 	 * the parent if the child exits early enough.
 	 */
 	p->first_time_slice = 1;
+	p->reserved_time_slice = 0;
 	current->time_slice >>= 1;
 	p->last_run = jiffies;
 	if (!current->time_slice) {
diff -puN kernel/sched.c~fairsched-A3 kernel/sched.c
--- 25/kernel/sched.c~fairsched-A3	Fri Apr  4 12:02:45 2003
+++ 25-wind/kernel/sched.c	Fri Apr  4 13:23:07 2003
@@ -33,6 +33,11 @@
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
 
+/*
+ * Switch per-user fair scheduler on/off
+ */
+int fairsched = 0;
+
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
@@ -1181,6 +1186,18 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
+extern void add_task_to_user(void *);
+
+void user_task_to_expired(task_t *p)
+{
+	runqueue_t *rq = this_rq();
+
+	spin_lock_irq(&rq->lock);
+	list_del(&p->user_tasks);
+	enqueue_task(p, rq->expired);
+	spin_unlock_irq(&rq->lock);
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1250,15 +1267,43 @@ void scheduler_tick(int user_ticks, int 
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
+		/*
+		 * Never apply fairsched to root user
+		 */
+		if(p->user->uid && fairsched) {
+			/*
+			 * If not interactive, reserve the timeslice
+			 * and queue the task to the user
+			 */
+			if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+				p->reserved_time_slice += task_timeslice(p);
+				if (!rq->expired_timestamp)
+					rq->expired_timestamp = jiffies;
+				INIT_WORK(&p->work_to_user, add_task_to_user, p);
+				schedule_work(&p->work_to_user);
+			} else {
+				/*
+				 * Interactive work isn't altered by fairsched
+				 */
+				p->time_slice += task_timeslice(p);
+				enqueue_task(p, rq->active);
+			}
+			goto did_fairsched;
+		}
+
+		/*
+		 * Do usual work when root user or fairsched is disabled
+		 */
+		p->time_slice += task_timeslice(p);
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+did_fairsched:
 	}
 out:
 	spin_unlock(&rq->lock);
@@ -1344,6 +1389,12 @@ pick_next_task:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
+
+	if(!next->time_slice){
+		dequeue_task(next, array);
+		enqueue_task(next, rq->expired);
+		goto pick_next_task;
+	}
 
 switch_tasks:
 	prefetch(next);
diff -puN kernel/sysctl.c~fairsched-A3 kernel/sysctl.c
--- 25/kernel/sysctl.c~fairsched-A3	Fri Apr  4 12:02:45 2003
+++ 25-wind/kernel/sysctl.c	Fri Apr  4 12:02:45 2003
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
 
diff -puN kernel/user.c~fairsched-A3 kernel/user.c
--- 25/kernel/user.c~fairsched-A3	Fri Apr  4 12:02:45 2003
+++ 25-wind/kernel/user.c	Fri Apr  4 13:04:30 2003
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 
+#include <asm/uaccess.h>
+
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
  * when changing user ID's (ie setuid() and friends).
@@ -26,11 +28,13 @@
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
 
 /*
@@ -39,10 +43,12 @@ struct user_struct root_user = {
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
 
@@ -97,6 +103,10 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		new->time_slice = 1;
+
+		INIT_LIST_HEAD(&new->user_list);
+		INIT_LIST_HEAD(&new->task_list);
 
 		/*
 		 * Before adding this, check whether we raced
@@ -134,6 +144,105 @@ void switch_uid(struct user_struct *new_
 }
 
 
+extern void user_task_to_expired(task_t *);
+
+/*
+ * fairsched_thread - this is a highprio system thread that gives
+ * out timeslices to users and passes user' timeslices to tasks
+ */
+static int fairsched_thread(void *data)
+{
+	int cpu = (long) data;
+	extern int fairsched;
+
+	daemonize("fairsched/%d", cpu);
+	set_fs(KERNEL_DS);
+
+	for(;;) {
+		struct user_struct *u;
+		task_t *p;
+
+		int num_tasks;
+
+		/* Wake up every 4 ticks */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(4);
+
+		while(!fairsched){
+			/* Sleep until we are switched on */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ);
+		}
+
+		/* Get user */
+		spin_lock(&uidhash_lock);
+		u = list_entry(&user_list, struct user_struct, user_list);
+		if(!u) goto no_user;
+		atomic_inc(&u->__count);
+		spin_unlock(&uidhash_lock);
+
+		if(u == &root_user)
+			goto root_user;
+
+		/*
+		 * Update user time slice count
+		 */
+		u->time_slice += 4 * nr_running();
+		num_tasks = 1 + atomic_read(&u->processes);
+
+		read_lock(&tasklist_lock);
+
+		while(u->time_slice && --num_tasks) {
+			int giveout;
+
+			p = list_entry(&u->task_list, task_t, user_tasks);
+			if(!p) goto end_user;
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
+				user_task_to_expired(p);
+			} else {
+				/* Round-robin per-user task list */
+				list_del(&p->user_tasks);
+				list_add_tail(&p->user_tasks, &u->task_list);
+			}
+		}
+
+end_user:
+		read_unlock(&tasklist_lock);
+root_user:
+		spin_lock(&uidhash_lock);
+
+		/* Round-robin user list */
+		list_del(&u->uidhash_list);
+		list_add_tail(&u->user_list, &user_list);
+		atomic_dec(&u->__count);
+no_user:
+		spin_unlock(&uidhash_lock);
+	}
+}
+
+void add_task_to_user(void *data)
+{
+	task_t *p = data;
+
+	/* add task to user's expired task list */
+
+	spin_lock(&uidhash_lock);
+	INIT_LIST_HEAD(&p->user_tasks);
+	list_add_tail(&p->user_tasks,&p->user->task_list);
+	spin_unlock(&uidhash_lock);
+}
+
 static int __init uid_cache_init(void)
 {
 	int n;
@@ -147,8 +256,17 @@ static int __init uid_cache_init(void)
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_LIST_HEAD(uidhash_table + n);
 
+	INIT_LIST_HEAD(&user_list);
+	INIT_LIST_HEAD(&root_user.user_list);
+	INIT_LIST_HEAD(&root_user.task_list);
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

--a8Wt8u1KmwUX3Y2C--
