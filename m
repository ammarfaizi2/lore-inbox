Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSL3Vhm>; Mon, 30 Dec 2002 16:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSL3Vhm>; Mon, 30 Dec 2002 16:37:42 -0500
Received: from services.cam.org ([198.73.180.252]:36015 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262289AbSL3Vhg> convert rfc822-to-8bit;
	Mon, 30 Dec 2002 16:37:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH,RFC] fix o(1) handling of threads
Date: Mon, 30 Dec 2002 16:45:50 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Message-Id: <200212301645.50278.tomlins@cam.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The o(1) scheduler is an interesting beast.  It handles most workloads
well.  One, not uncommon, corner case is that of a heavily threaded 
application.  A common source of these is java.  In my case I want to 
run a freenet node.  This normally runs with 80-100 threads.  With o(1)
I get two choices.  Run the application nice 19, and wait when using it
(who wants to run a _server_ at nice 19?).  Alternately I can run it at
nice 10 or so and my box slows to a crawl when the node gets busy.  
When this happens the loadaverage can shoot up into the high teens or
more - which causes the crawl... (reported first Feb 2002).

Its a bit of a catch 22.  If the application kept a 'stable' number of 
threads active nice could be used to control it.  In reality from 1 to
20 or more threads are active (in a runqueue).

What this patches does is recognise threads as process that clone both
mm and files.  For these 'threads' it tracks how many are active in a 
given group.  When many are active it reduces their timeslices as below

weight = (threads active in group) * THREAD_PENALTY / 100
timeslice = BASE_TIMESLICE(p) / weight

Testing for a valid weight and respecting MIN_TIMESLICE.

The effect of this change is limit the amount of cpu used by threads
when many in a given thread group are active.  The amount they are
limited by is controlled by the THREAD_PENALTY tunable.

This seems quite effective here allowing freenet to run at nice 0 without
the system slowing down unreasonably when it gets active.

Patch is against 2.5.53-bk from Saturday.  A couple of comments.  

- I have tested UP with preempt enabled.  I am not sure of the locking with 
smp - there may be races possible when a ptg_struct is destroyed.  Think 
creation is probably ok.

- Should I respect the minimum timeslice?  Maybe it should be set lower, which
would help with very large active lists.  As its set now we need more than 18
active nice 0 threads in one group before this is an issue. 

- I suspect that most systems will have very few ptgs allocated - here two long
lived structures are normal.

Comments?
Ed Tomlinson


diffstat ptg_A1
 include/linux/sched.h |    6 ++++++
 kernel/fork.c         |   21 +++++++++++++++++++++
 kernel/sched.c        |   12 ++++++++++++
 3 files changed, 39 insertions(+)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.922   -> 1.924  
#	include/linux/sched.h	1.116   -> 1.117  
#	       kernel/fork.c	1.93    -> 1.95   
#	      kernel/sched.c	1.145   -> 1.147  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/30	ed@oscar.et.ca	1.923
# Allow heavily threaded task to run with normal priorities without 
# destroying responsiveness.  This is done by throttling the threads 
# in a group when many are active (in a runqueue) at the same time.
# --------------------------------------------
# 02/12/30	ed@oscar.et.ca	1.924
# remove printks, adjust THREAD_PENALTY and respect MIN_TIMESLICE
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Mon Dec 30 10:04:31 2002
+++ b/include/linux/sched.h	Mon Dec 30 10:04:31 2002
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
@@ -301,6 +306,7 @@
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	struct ptg_struct * ptgroup;		/* pseudo thread group for this task */
 
 /* task state */
 	struct linux_binfmt *binfmt;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Mon Dec 30 10:04:31 2002
+++ b/kernel/fork.c	Mon Dec 30 10:04:31 2002
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
@@ -819,6 +825,21 @@
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
+			}
+		} 
+		p->ptgroup = current->ptgroup;
+	}
 
 	if (clone_flags & CLONE_CHILD_SETTID)
 		p->set_child_tid = child_tidptr;
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Dec 30 10:04:31 2002
+++ b/kernel/sched.c	Mon Dec 30 10:04:31 2002
@@ -62,6 +62,7 @@
 #define MAX_TIMESLICE		(300 * HZ / 1000)
 #define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
+#define THREAD_PENALTY		80
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
@@ -122,6 +123,13 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
+	if (p->ptgroup) {
+		int weight = atomic_read(&p->ptgroup->active) * THREAD_PENALTY / 100;
+		if (weight > 1) {
+			int slice = BASE_TIMESLICE(p) / weight;
+			return slice > MIN_TIMESLICE ? slice : MIN_TIMESLICE;
+		}	
+	}
 	return BASE_TIMESLICE(p);
 }
 
@@ -295,6 +303,8 @@
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	if (p->ptgroup)
+		atomic_inc(&p->ptgroup->active);
 }
 
 /*
@@ -302,6 +312,8 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	if (p->ptgroup)
+		atomic_dec(&p->ptgroup->active);
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;


------------

