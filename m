Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262984AbTDBM2L>; Wed, 2 Apr 2003 07:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262985AbTDBM2L>; Wed, 2 Apr 2003 07:28:11 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:56308 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S262984AbTDBM1v>;
	Wed, 2 Apr 2003 07:27:51 -0500
Date: Wed, 2 Apr 2003 14:46:43 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030402124643.GA13168@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20030401221927.GA8904@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2003 at 12:19:27AM +0200, Antonio Vargas wrote:
> On Tue, Apr 01, 2003 at 08:41:26AM -0800, William Lee Irwin III wrote:
> > On Tue, Apr 01, 2003 at 02:51:59PM +0200, Antonio Vargas wrote:
> > +
> > +	if(fairsched){
> > +		/* special processing for per-user fair scheduler */
> > +	}
> > 
> > I suspect something more needs to happen there. =)
> 
>  :) I haven't even compiled with this patch, I'm just trying
> to get around my ideas and thus I posted so that:
> 
> a. We had an off-site backup
> 
> b. People with experience could shout out loud if they saw
>    some big-time silliness.
> 
> > I'd recommend a different approach, i.e. stratifying the queue into a
> > user top level and a task bottom level. The state is relatively well
> > encapsulated so it shouldn't be that far out.
> > 
> > 
> > -- wli
> 
> I suspect you mean the scheduler runqueues?
> 
> My initial idea runs as follows:
> 
> a. On each array switch, we add some fixed value
>    to user->ticks. (HZ perhaps?)
> 
> b. When adding, we cap at some maximum value.
>    (2*HZ perhaps?)
> 
> c. On each timer tick, we decrement current->user->ticks.
> 
> d. When decrementing, if it's below zero we just
>    end this thread. (user has expired)
> 
> e. When switching threads, we take the first one that belongs
>    to a non-expired user. I think this can be done by sending
>    the user-expired threads to the expired array, just like
>    when they expire themselves.
> 
> I'll try to code this tonight, so I'll post later on
> if I'm lucky.
> 
> I think this needs much less complexity for a first version,
> but I would try what you propose if I get intimate enough
> with the scheduler.
> 
> Greets, Antonio.

Ok, second try...

I have a doubt, do we need any locking for struct user when reading/writing
his priority or when surfing the user_list?

Greets, Antnonio.


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fairsched-A1.patch"



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
 kernel/sched.c         |   78 +++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c        |    6 +++
 kernel/user.c          |   10 +++++-
 5 files changed, 99 insertions(+), 3 deletions(-)

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
+++ 25-wind/kernel/sched.c	Wed Apr  2 14:02:29 2003
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
@@ -1194,6 +1208,8 @@ void scheduler_tick(int user_ticks, int 
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	unsigned int user_time_slice;
+
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
@@ -1246,14 +1262,24 @@ void scheduler_tick(int user_ticks, int 
 		}
 		goto out;
 	}
-	if (!--p->time_slice) {
+
+	/* Update per-user timeslice */
+	if(fairsched) {
+		if(p->user->time_slice > 0)
+			--p->user->time_slice;
+		user_time_slice = p->user->time_slice;
+	}else
+		user_time_slice = 1;
+
+	/* Update per-process timeslice and queue the task when used up */
+	if (!--p->time_slice || !user_time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq) || !user_time_slice) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
 			enqueue_task(p, rq->expired);
@@ -1268,6 +1294,38 @@ out:
 void scheduling_functions_start_here(void) { }
 
 /*
+ * Gime more timeslices to users on each array switch
+ */
+static inline void update_user_timeslices(void)
+{
+	extern struct list_head user_list;
+	struct list_head *entry;
+	struct user_struct *user;
+	unsigned int user_time_slice;
+
+	if(!fairsched) return;
+
+	list_for_each(entry, &user_list) {
+		user = list_entry(entry, struct user_struct, uid_list);
+
+		if(!user) continue;
+
+		if(0){
+			user_time_slice = user->time_slice;
+
+			user_time_slice += HZ;
+			if(user_time_slice > MAX_TIMESLICE_USER)
+				user_time_slice = MAX_TIMESLICE_USER;
+
+			if(user->time_slice != user_time_slice)
+				user->time_slice = user_time_slice;
+		}else{
+			user->time_slice += HZ;
+		}
+	}
+}
+
+/*
  * schedule() is the main scheduler function.
  */
 asmlinkage void schedule(void)
@@ -1339,11 +1397,27 @@ pick_next_task:
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
+++ 25-wind/kernel/sysctl.c	Wed Apr  2 13:17:44 2003
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
+	{KERN_FAIRSCHED, "fairsched", &pid_max, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_MAX_TIMESLICE_USER, "max_timeslice_user", &pid_max, sizeof (int),
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

--45Z9DzgjV8m4Oswq--
