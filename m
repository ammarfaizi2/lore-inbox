Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbTCTEQ3>; Wed, 19 Mar 2003 23:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCTEQ3>; Wed, 19 Mar 2003 23:16:29 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:42417 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261345AbTCTEQX>; Wed, 19 Mar 2003 23:16:23 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: elenstev@mesatop.com, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.65-mm2
Date: Wed, 19 Mar 2003 23:27:45 -0500
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030319012115.466970fd.akpm@digeo.com> <20030319163337.602160d8.akpm@digeo.com> <1048117516.1602.6.camel@spc1.esa.lanl.gov>
In-Reply-To: <1048117516.1602.6.camel@spc1.esa.lanl.gov>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BNUe+BXViARa3wg"
Message-Id: <200303192327.45883.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BNUe+BXViARa3wg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On March 19, 2003 06:45 pm, Steven P. Cole wrote:
> On Wed, 2003-03-19 at 17:33, Andrew Morton wrote:
> > "Steven P. Cole" <elenstev@mesatop.com> wrote:
> > > > Summary: using ext3, the simple window shake and scrollbar wiggle
> > > > tests were much improved, but really using Evolution left much to be
> > > > desired.
> > >
> > > Replying to myself for a followup,
> > >
> > > I repeated the tests with 2.5.65-mm2 elevator=deadline and the
> > > situation was similar to elevator=as.  Running dbench on ext3, the
> > > response to desktop switches and window wiggles was improved over
> > > running dbench on reiserfs, but typing in Evolution was subject to long
> > > delays with dbench clients greater than 16.
> >
> > OK, final question before I get off my butt and find a way to reproduce
> > this:
> >
> > Does reverting
> >
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/broken-ou
> >t/sched-2.5.64-D3.patch
> >
> > help?
>
> Sorry, didn't have much time for a lot of testing, but no miracles
> occurred.  With 5 minutes of testing 2.5.65-mm2 and dbench 24 on ext3
> and that patch reverted (first hunk had to be manually fixed), I don't
> see any improvement.  Still the same long long delays in trying to use
> Evolution.

Steven,

Do things improve with the patch below applied?  You have to backout the 
schedule-tuneables patch before appling it.

Ed Tomlinson
--Boundary-00=_BNUe+BXViARa3wg
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ptg-D3-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ptg-D3-mm2"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1087  -> 1.1088 
#	include/linux/sched.h	1.137   -> 1.138  
#	       kernel/fork.c	1.112   -> 1.113  
#	       kernel/user.c	1.6     -> 1.7    
#	      kernel/sched.c	1.163   -> 1.164  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/07	ed@oscar.et.ca	1.1088
# Add user and thread group governors to prevent either from monoplizing
# the system.  The governors work by limiting the sum of the timeslices
# of active tasks in a group to <n> timeslices.  The defaults set <n> to
# 1.5 for thread groups and to 10 for user tasks.
# 
# For numa systems the governors are per node.  Idealy the storage
# should also be local to the node however, we do not have dynamic per
# node storage yet...
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat Mar  8 14:18:48 2003
+++ b/include/linux/sched.h	Sat Mar  8 14:18:48 2003
@@ -178,6 +178,11 @@
 
 #include <linux/aio.h>
 
+struct ptg_struct {		/* pseudo thread groups */
+	atomic_t active[MAX_NUMNODES];
+        atomic_t count;         /* number of refs */
+};
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -278,6 +283,7 @@
 struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
+	atomic_t active[MAX_NUMNODES];
 	atomic_t files;		/* How many open files does this user have? */
 
 	/* Hash table maintenance information */
@@ -344,6 +350,8 @@
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	struct ptg_struct * ptgroup;		/* pseudo thread group for this task */
+	atomic_t *governor;			/* the atomic_t that governs this task */
 
 /* task state */
 	struct linux_binfmt *binfmt;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Sat Mar  8 14:18:48 2003
+++ b/kernel/fork.c	Sat Mar  8 14:18:48 2003
@@ -96,12 +96,24 @@
 	}
 }
 
+void free_ptgroup(struct task_struct *tsk)
+{
+	if (tsk->ptgroup && atomic_sub_and_test(1,&tsk->ptgroup->count)) {
+                kfree(tsk->ptgroup);
+                tsk->ptgroup = NULL;
+                tsk->governor = &tsk->user->active[cpu_to_node(task_cpu(tsk))];
+                if (tsk == current)
+                        atomic_inc(tsk->governor);
+        }
+}
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!(tsk->state & (TASK_DEAD | TASK_ZOMBIE)));
 	WARN_ON(atomic_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	free_ptgroup(tsk);
 	security_task_free(tsk);
 	free_uid(tsk->user);
 	free_task_struct(tsk);
@@ -469,6 +481,7 @@
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
+	tsk->ptgroup = NULL;
 
 	/*
 	 * Are we cloning a kernel thread?
@@ -734,6 +747,32 @@
 	p->flags = new_flags;
 }
 
+static inline int setup_governor(unsigned long clone_flags, struct task_struct *p)
+{
+	if ( ((clone_flags & CLONE_VM) && (clone_flags & CLONE_FILES)) ||
+	     (clone_flags & CLONE_THREAD)) {
+		if (current->ptgroup)
+			atomic_inc(&current->ptgroup->count);
+		else {
+			int i;
+			current->ptgroup = kmalloc(sizeof(struct ptg_struct), GFP_ATOMIC);
+			if (!current->ptgroup)
+				return 1;
+			/* printk(KERN_INFO "ptgroup - pid %u\n",current->pid); */
+			atomic_set(&current->ptgroup->count,2);
+			for(i=0; i < MAX_NUMNODES; i++)
+				atomic_set(&current->ptgroup->active[i], 0);
+			atomic_set(&current->ptgroup->active[numa_node_id()], 1);
+			atomic_dec(current->governor);
+			current->governor = &current->ptgroup->active[numa_node_id()];
+		}
+		p->ptgroup = current->ptgroup;
+		p->governor = &p->ptgroup->active[numa_node_id()];
+	} else
+		p->governor = &p->user->active[numa_node_id()];
+	return 0;
+}
+
 asmlinkage int sys_set_tid_address(int *tidptr)
 {
 	current->clear_child_tid = tidptr;
@@ -876,6 +915,12 @@
 		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
+		goto bad_fork_cleanup_namespace;
+	/*
+	 * Setup the governor pointer for the new process, allocating a new ptg as
+	 * required if the process is a thread. 
+	 */
+	if (setup_governor(clone_flags, p))
 		goto bad_fork_cleanup_namespace;
 
 	if (clone_flags & CLONE_CHILD_SETTID)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Mar  8 14:18:48 2003
+++ b/kernel/sched.c	Sat Mar  8 14:18:48 2003
@@ -68,6 +68,9 @@
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define THREAD_GOVERNOR		15      /* allow threads groups 1.5 full timeslices */
+#define USER_GOVERNOR		100     /* allow user 10 full timeslices */
+
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -123,7 +126,26 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	int slice = BASE_TIMESLICE(p);
+	int threads = atomic_read(p->governor) * 10;
+	int govern = threads;
+	if (p->user->uid)
+		govern = (p->ptgroup) ? THREAD_GOVERNOR : USER_GOVERNOR;
+	if (threads > govern) {
+		slice = (slice * govern) / threads;
+		slice = (slice > MIN_TIMESLICE) ? slice : MIN_TIMESLICE;
+	}
+#if 0
+	{
+		static int next;
+		if (time_after(jiffies, next)) {
+			printk(KERN_INFO "uid %d pid %d nod %d ptg %x gov %x threads %d lim %d slice %d\n",
+			  p->uid, p->pid, numa_node_id(), p->ptgroup, p->governor, threads/10, govern, slice);
+			next = jiffies + HZ*300;
+		}
+	}
+#endif
+	return slice;
 }
 
 /*
@@ -197,16 +219,18 @@
 	rq->node_nr_running = &node_nr_running[0];
 }
 
-static inline void nr_running_inc(runqueue_t *rq)
+static inline void nr_running_inc(task_t *p, runqueue_t *rq)
 {
 	atomic_inc(rq->node_nr_running);
 	rq->nr_running++;
+	atomic_inc(p->governor);
 }
 
-static inline void nr_running_dec(runqueue_t *rq)
+static inline void nr_running_dec(task_t *p, runqueue_t *rq)
 {
 	atomic_dec(rq->node_nr_running);
 	rq->nr_running--;
+	atomic_dec(p->governor);
 }
 
 __init void node_nr_running_init(void)
@@ -220,8 +244,8 @@
 #else /* !CONFIG_NUMA */
 
 # define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_inc(p, rq)    do { (rq)->nr_running++; atomic_inc((p)->governor); } while (0)
+# define nr_running_dec(p, rq)    do { (rq)->nr_running--; atomic_dec((p)->governor); } while (0)
 
 #endif /* CONFIG_NUMA */
 
@@ -326,7 +350,7 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	nr_running_inc(rq);
+	nr_running_inc(p, rq);
 }
 
 /*
@@ -387,7 +411,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	nr_running_dec(rq);
+	nr_running_dec(p, rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -586,7 +610,7 @@
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
 		p->array->nr_active++;
-		nr_running_inc(rq);
+		nr_running_inc(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
 }
@@ -1004,9 +1028,15 @@
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	nr_running_dec(src_rq);
+	nr_running_dec(p, src_rq);
 	set_task_cpu(p, this_cpu);
-	nr_running_inc(this_rq);
+#ifdef CONFIG_NUMA
+        if (p->ptgroup)
+                p->governor = &p->ptgroup->active[cpu_to_node(this_cpu)];
+        else
+                p->governor = &p->user->active[cpu_to_node(this_cpu)];
+#endif
+	nr_running_inc(p, this_rq);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -2521,6 +2551,8 @@
 	rq->curr = current;
 	rq->idle = current;
 	set_task_cpu(current, smp_processor_id());
+        current->governor = &current->user->active[numa_node_id()];
+	atomic_inc(current->governor);
 	wake_up_forked_process(current);
 	current->prio = MAX_PRIO;
 
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c	Sat Mar  8 14:18:48 2003
+++ b/kernel/user.c	Sat Mar  8 14:18:48 2003
@@ -30,6 +30,7 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
+	.active		= {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)},
 	.files		= ATOMIC_INIT(0)
 };
 
@@ -89,6 +90,7 @@
 
 	if (!up) {
 		struct user_struct *new;
+		int i;
 
 		new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
 		if (!new)
@@ -96,6 +98,8 @@
 		new->uid = uid;
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
+		for(i=0; i < MAX_NUMNODES; i++)
+			atomic_set(&new->active[i], 0);
 		atomic_set(&new->files, 0);
 
 		/*
@@ -130,6 +134,11 @@
 	atomic_inc(&new_user->processes);
 	atomic_dec(&old_user->processes);
 	current->user = new_user;
+	if (!current->ptgroup) {
+		atomic_dec(current->governor);
+		current->governor = &current->user->active[numa_node_id()];
+		atomic_inc(current->governor);
+	}
 	free_uid(old_user);
 }
 

--Boundary-00=_BNUe+BXViARa3wg--

