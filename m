Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSLaO0F>; Tue, 31 Dec 2002 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSLaO0E>; Tue, 31 Dec 2002 09:26:04 -0500
Received: from services.cam.org ([198.73.180.252]:12748 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S263137AbSLaOZ5> convert rfc822-to-8bit;
	Tue, 31 Dec 2002 09:25:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Date: Tue, 31 Dec 2002 09:33:39 -0500
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
References: <200212301645.50278.tomlins@cam.org> <1041288608.13956.173.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1041288608.13956.173.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <200212310933.39727.tomlins@cam.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2002 05:50 pm, Alan Cox wrote:
> Very interesting, but I'll note there are actually two groupings to
> solve - per user and per threadgroup. Also for small numbers of threads
> you don't want to punish a task and ruin its balancing across CPUs
>
> Have you looked at the per user fair share stuff too ?

Two changes here.  First I have modified the timeslice compression 
calculation to make it more understandable.  Now 100/penalty gives 
the number of timeslices to distribute equally among the processes 
in the tread group or processes of a user.  For thread groups its 
now set so the time for 2 timeslices is distributed equally to the 
members of the group. 

The second changes add a user throttle.  It would be better to get the 
USER_PENALTY from a per user source - suggestions?  Since limiting 
users is not a problem here, I have set the limit so a normal user 
can have 10 active process in runqueues before the timeslice compression 
starts.  Root is excluded from this logic.  

In effect of this patch is to lower the priority of a user's processes
or threads in a group.  It uses the same technique that O(1) uses
for priorities to do this.  

Comments
Ed Tomlinson

PS. Its trivial to factor user vs thread group limits if required

diffstat ptg_B0
 include/linux/sched.h |    7 +++++++
 kernel/fork.c         |   22 ++++++++++++++++++++++
 kernel/sched.c        |   22 +++++++++++++++++++++-
 kernel/user.c         |    2 ++
 4 files changed, 52 insertions(+), 1 deletion(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.922   -> 1.925  
#	include/linux/sched.h	1.116   -> 1.118  
#	       kernel/fork.c	1.93    -> 1.96   
#	       kernel/user.c	1.5     -> 1.6    
#	      kernel/sched.c	1.145   -> 1.148  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/30	ed@oscar.et.ca	1.923
# Allow heavily threaded task to run with normal priorities without 
# destroying responsiviness.  This is done by throttling the threads 
# in a group when many are active (in a runqueue) at the same time.
# --------------------------------------------
# 02/12/30	ed@oscar.et.ca	1.924
# remove printks, adjust THREAD_PENALTY and respect MIN_TIMESLICE
# --------------------------------------------
# 02/12/31	ed@oscar.et.ca	1.925
# Add user throttling
# Improve the timeslice caculations for throttling
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Dec 31 08:53:27 2002
+++ b/include/linux/sched.h	Tue Dec 31 08:53:27 2002
@@ -172,6 +172,11 @@
 
 #include <linux/aio.h>
 
+struct ptg_struct {		/* pseudo thread groups */
+        atomic_t active;        /* number of tasks in run queues */
+        atomic_t count;         /* number of refs */
+};
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -256,6 +261,7 @@
 struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
+	atomic_t active;	/* How many active processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 
 	/* Hash table maintenance information */
@@ -301,6 +307,7 @@
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	struct ptg_struct * ptgroup;		/* pseudo thread group for this task */
 
 /* task state */
 	struct linux_binfmt *binfmt;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Tue Dec 31 08:53:27 2002
+++ b/kernel/fork.c	Tue Dec 31 08:53:27 2002
@@ -59,6 +59,11 @@
 
 void __put_task_struct(struct task_struct *tsk)
 {
+	if (tsk->ptgroup && atomic_sub_and_test(1,&tsk->ptgroup->count)) {
+		kfree(tsk->ptgroup);
+		tsk->ptgroup = NULL;
+	}
+
 	if (tsk != current) {
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
@@ -432,6 +437,7 @@
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
+	tsk->ptgroup = NULL;
 
 	/*
 	 * Are we cloning a kernel thread?
@@ -819,6 +825,22 @@
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
+
+	/* detect a 'thread' and link to the ptg block for group */
+	if ( ((clone_flags & CLONE_VM) && (clone_flags & CLONE_FILES)) ||
+	     (clone_flags & CLONE_THREAD)) {
+		if (current->ptgroup)
+			atomic_inc(&current->ptgroup->count);
+		else {
+			current->ptgroup = kmalloc(sizeof(struct ptg_struct), GFP_ATOMIC);
+			if likely(current->ptgroup) {
+				atomic_set(&current->ptgroup->count,2);
+				atomic_set(&current->ptgroup->active,1);
+				/* printk(KERN_INFO "ptgroup - pid %u\n",current->pid); */
+			}
+		} 
+		p->ptgroup = current->ptgroup;
+	}
 
 	if (clone_flags & CLONE_CHILD_SETTID)
 		p->set_child_tid = child_tidptr;
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Dec 31 08:53:27 2002
+++ b/kernel/sched.c	Tue Dec 31 08:53:27 2002
@@ -62,6 +62,8 @@
 #define MAX_TIMESLICE		(300 * HZ / 1000)
 #define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
+#define THREAD_PENALTY		50	/* allow threads groups 2 full timeslices */
+#define USER_PENALTY		10	/* allow user 10 full timeslices */
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
@@ -122,7 +124,19 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	int work , slice, weight = 100;
+	if (p->ptgroup) {
+		work = atomic_read(&p->ptgroup->active) * THREAD_PENALTY;
+		if (work > weight)
+			weight = work;
+	}
+	if (p->user->uid) {
+		work = atomic_read(&p->user->active) * USER_PENALTY;
+		if (work > weight)
+			weight = work;
+	}
+	slice = 100 * BASE_TIMESLICE(p) / weight;
+	return slice > MIN_TIMESLICE ? slice : MIN_TIMESLICE;
 }
 
 /*
@@ -295,6 +309,9 @@
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	if (p->ptgroup)
+		atomic_inc(&p->ptgroup->active);
+	atomic_inc(&p->user->active);
 }
 
 /*
@@ -302,6 +319,9 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	atomic_dec(&p->user->active);
+	if (p->ptgroup)
+		atomic_dec(&p->ptgroup->active);
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c	Tue Dec 31 08:53:27 2002
+++ b/kernel/user.c	Tue Dec 31 08:53:27 2002
@@ -30,6 +30,7 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
+	.active		= ATOMIC_INIT(1),
 	.files		= ATOMIC_INIT(0)
 };
 
@@ -96,6 +97,7 @@
 		new->uid = uid;
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
+		atomic_set(&new->active, 0);
 		atomic_set(&new->files, 0);
 
 		/*
--------------


