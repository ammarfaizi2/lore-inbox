Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbTDCMfK>; Thu, 3 Apr 2003 07:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263377AbTDCMfK>; Thu, 3 Apr 2003 07:35:10 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:4077 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263375AbTDCMeo>;
	Thu, 3 Apr 2003 07:34:44 -0500
Date: Thu, 3 Apr 2003 14:53:55 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030403125355.GA12001@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <200304021144.21924.frankeh@watson.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <200304021144.21924.frankeh@watson.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2003 at 11:44:21AM -0500, Hubertus Franke wrote:
> On Tuesday 01 April 2003 17:19, Antonio Vargas wrote:
> > On Tue, Apr 01, 2003 at 08:41:26AM -0800, William Lee Irwin III wrote:
> > > On Tue, Apr 01, 2003 at 02:51:59PM +0200, Antonio Vargas wrote:
> 
> To add to my previous reply...
> In your approach you might have a problem with starvation.
> High priority processes simply can eat all the ticks allocated to 
> a user and when lower priority tasks pop up at the top of
> the active list they are move to the inactive list. This could happen
> over and over again, thus starving those tasks.

Sorry for not answering sooner, but I had my mail pointing at
the lkml instead of my personal email.

Last night I continued coding up but I think I've it a deadlock:
it seems the system stops calling schedule_tick() when there are
no more tasks to run, and it's there where I use a workqueue so
that I can update the user timeslices out of interrupt context.

I think that because if I put printk's on my code, it continues to
run OK, but if I remove them it freezes hard.

About giving ticks to users, I've got an idea: assuming there are N
total processes in the system and an user has got M processes, we should
give N * max_timeslice ticks to each user every M * max_timeslice *
num_users ticks. I've been thinking about it and it seems it would
balance the ticks correctly.

About the starvation for low-priority processes, I can get and
example.. assume user A has process X Y and user B has process Z,
and max_timeslice = 2:

max_timeslice = 2 and 4 total processes ==>
give 2 * 3 = 6 ticks to user A every 2 * 2 * 2 =  8 ticks
give 2 * 3 = 6 ticks to user B every 1 * 2 * 2 =  4 ticks

running		revised		nr. of ticks for each
task		user		for each entity after executing

			A	B	X	Y	Z
-		-	6	6	2	2	2
X		A1	5	6	1	2	2
X		B1	4	6	0	2	2
Y		A2	3	6	0	1	2
Y		B2	2	6	0	0	2
Z		A3	2	5	0	0	1
Z		B3	2	4	0	0	0

reset_tasks	-	2	4	2	2	2

X		A4	1	4	1	2	2
X		B4	0	4	0	2	2

reset_user	B4	0	10	0	2	2

Z		A5	0	9	0	2	1
Z		B1	0	8	0	2	0

reset_tasks	-	0	8	2	2	2

Z		A6	0	7	2	2	1
Z		B2	0	6	2	2	0

reset_tasks	-	0	6	2	2	2

Z		A7	0	5	2	2	1
Z		B3	0	4	2	2	0

reset_tasks	-	0	4	2	2	2

Z		A8	0	3	2	2	1

reset_user	A8	6	3	2	2	1

Z		B4	6	2	2	2	0

reset_user	B4	6	8	2	2	0

A		A1	5	8	1	2	0
A		B1	4	8	0	2	0
B		A2	3	8	0	1	0
B		B2	2	8	0	0	0

reset_tasks	-	2	8	2	2	2

Z		A3	2	7	2	2	1
Z		B3	2	6	2	2	0
A		A4	1	6	1	2	0
A		B4	0	6	0	2	0

... ad infinitum ...

probably getting a graph out of this would be good :)

I will attach my current not-so-working patch and will try
this scheme later at night.

Note there are some spourius calls to run my workqueue due to debugging
tests.

Greets, Antonio.


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fairsched-A2.patch~uml-2.5.66-1"



This patch is a forward port of the fairsched-2.4.19 patch by Rik van Riel, which
ensures all competing users get an equal share of cpu time.

Since the earlier patch applied to the classic O(n) process scheduler,
and this one applies to the standard 2.5 O(1) one, the mapping isn't
one-to-one but rather more complex.

Original 2.4.19 version:       Rik van Riel, riel@surriel.com
Forward ported 2.5.66 version: Antonio Vargas, wind@cocodriloo.com

A0: initial layout for code and data
A1: introduce runqueue handling related to per-user cpu share


 include/linux/sched.h  |    6 +++
 include/linux/sysctl.h |    2 +
 kernel/sched.c         |   97 ++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c        |    6 +++
 kernel/user.c          |   10 ++++-
 5 files changed, 119 insertions(+), 2 deletions(-)

diff -puN include/linux/sched.h~fairsched-A1 include/linux/sched.h
--- 25/include/linux/sched.h~fairsched-A1	Wed Apr  2 13:17:44 2003
+++ 25-wind/include/linux/sched.h	Wed Apr  2 13:17:44 2003
@@ -280,6 +280,12 @@ struct user_struct {
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
 	uid_t uid;
+
+	/* List maintenance information */
+	struct list_head uid_list;
+
+	/* Per-user timeslice management */
+	unsigned int time_slice;
 };
 
 #define get_current_user() ({ 				\
diff -puN include/linux/sysctl.h~fairsched-A1 include/linux/sysctl.h
--- 25/include/linux/sysctl.h~fairsched-A1	Wed Apr  2 13:17:44 2003
+++ 25-wind/include/linux/sysctl.h	Wed Apr  2 13:17:44 2003
@@ -129,6 +129,8 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_FAIRSCHED=57,		/* turn per-user fair cpu scheduler on/off */
+	KERN_MAX_TIMESLICE_USER=58,	/* maximum user timeslice */
 };
 
 
diff -puN kernel/sched.c~fairsched-A1 kernel/sched.c
--- 25/kernel/sched.c~fairsched-A1	Wed Apr  2 13:17:44 2003
+++ 25-wind/kernel/sched.c	Thu Apr  3 00:41:26 2003
@@ -33,6 +33,13 @@
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
 
+/*
+ * turn per-user fair scheduler on/off
+ */
+
+int fairsched = 0;
+
+
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
@@ -75,6 +82,9 @@
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
+int max_timeslice_user = (200 * HZ) / 100;
+#define MAX_TIMESLICE_USER	(max_timeslice_user)
+
 /*
  * If a task is 'interactive' then we reinsert it in the active
  * array after it has expired its current timeslice. (it will not
@@ -317,6 +327,10 @@ static int effective_prio(task_t *p)
 	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
+	if(fairsched){
+		/* special processing for per-user fair scheduler */
+	}
+
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
@@ -1188,12 +1202,17 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
  * It also gets called by the fork code, when changing the parent's
  * timeslices.
  */
+
+static struct user_struct fairsched_last_user = 0;
+
 void scheduler_tick(int user_ticks, int sys_ticks)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	unsigned int user_time_slice;
+
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
@@ -1246,7 +1265,16 @@ void scheduler_tick(int user_ticks, int 
 		}
 		goto out;
 	}
-	if (!--p->time_slice) {
+
+	/* Update per-user timeslice */
+	if(fairsched) {
+		user_time_slice = p->user->time_slice;
+		fairsched_last_user = p->user;
+	}else
+		user_time_slice = 1;
+
+	/* Update per-process timeslice and queue the task when used up */
+	if (!--p->time_slice || !user_time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
@@ -1268,6 +1296,57 @@ out:
 void scheduling_functions_start_here(void) { }
 
 /*
+ * Gime more timeslices to users on each array switch
+ */
+static inline void update_user_timeslices(void)
+{
+	extern struct list_head user_list;
+	struct list_head *entry;
+	struct user_struct *user;
+	unsigned int old_user_time_slice;
+	unsigned int new_user_time_slice;
+
+	if(!fairsched) return;
+
+	/* Take the lock */
+
+	spin_lock(&uidhash_lock);
+
+	/* Decrement user timeslice for last user who got a tick */
+
+	user = fairsched_last_user;
+	if(user)
+		if(user->time_slice > 0)
+			user->time_slice--;
+
+	/* Get head of user list */
+
+	entry = user_list.next;
+	user = list_entry(entry, struct user_struct, uid_list);
+	if(!user)
+		goto out:
+
+	/* Calculate new timeslice for user */
+
+	old_user_time_slice = user->time_slice;
+	new_user_time_slice = old_user_time_slice + 1;
+
+	if(new_user_time_slice > MAX_TIMESLICE_USER)
+		new_user_time_slice = MAX_TIMESLICE_USER;
+
+	if(old_user_time_slice != new_user_time_slice)
+			user->time_slice = new_user_time_slice;
+
+	/* Reinsert at the end of the user list */
+
+	list_del(&user->uid_list);
+	list_add_tail(&user->uid_list,&uid_list);
+
+out:
+	spin_unlock(&uidhash_lock);
+}
+
+/*
  * schedule() is the main scheduler function.
  */
 asmlinkage void schedule(void)
@@ -1339,11 +1418,27 @@ pick_next_task:
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
+
+		/*
+		 * Give new timeslices to users
+		 */
+		update_user_timeslices();
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
+
+	/*
+	 * If next task' user has used all his timeslice,
+	 * send his task to the expired array.
+	 */
+
+	if(fairsched && !next->user->time_slice){
+		dequeue_task(next, array);
+		enqueue_task(next, rq->expired);
+		goto pick_next_task;
+	}
 
 switch_tasks:
 	prefetch(next);
diff -puN kernel/sysctl.c~fairsched-A1 kernel/sysctl.c
--- 25/kernel/sysctl.c~fairsched-A1	Wed Apr  2 13:17:44 2003
+++ 25-wind/kernel/sysctl.c	Wed Apr  2 23:15:00 2003
@@ -57,6 +57,8 @@ extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int fairsched;
+extern int max_timeslice_user;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -263,6 +265,10 @@ static ctl_table kern_table[] = {
 #endif
 	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
 	 0600, NULL, &proc_dointvec},
+	{KERN_FAIRSCHED, "fairsched", &fairsched, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_MAX_TIMESLICE_USER, "max_timeslice_user", &max_timeslice_user, sizeof (int),
+	 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -puN kernel/user.c~fairsched-A1 kernel/user.c
--- 25/kernel/user.c~fairsched-A1	Wed Apr  2 13:17:44 2003
+++ 25-wind/kernel/user.c	Wed Apr  2 13:17:44 2003
@@ -27,10 +27,13 @@ static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
 static spinlock_t uidhash_lock = SPIN_LOCK_UNLOCKED;
 
+struct list_head user_list;
+
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.time_slice	= 1
 };
 
 /*
@@ -39,10 +42,12 @@ struct user_struct root_user = {
 static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
 {
 	list_add(&up->uidhash_list, hashent);
+	list_add(&up->uid_list, &user_list);
 }
 
 static inline void uid_hash_remove(struct user_struct *up)
 {
+	list_del(&up->uid_list);
 	list_del(&up->uidhash_list);
 }
 
@@ -97,6 +102,7 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		new->time_slice = 1;
 
 		/*
 		 * Before adding this, check whether we raced
@@ -146,6 +152,8 @@ static int __init uid_cache_init(void)
 
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_LIST_HEAD(uidhash_table + n);
+
+	INIT_LIST_HEAD(&user_list);
 
 	/* Insert the root user immediately - init already runs with this */
 	uid_hash_insert(&root_user, uidhashentry(0));

_

--IS0zKkzwUGydFO0o--
