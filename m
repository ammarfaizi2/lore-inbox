Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbTBMNIl>; Thu, 13 Feb 2003 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268035AbTBMNIl>; Thu, 13 Feb 2003 08:08:41 -0500
Received: from services.cam.org ([198.73.180.252]:43767 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S268033AbTBMNIc>;
	Thu, 13 Feb 2003 08:08:32 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
Date: Thu, 13 Feb 2003 08:18:24 -0500
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (1-2) governors for 60-bk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302130818.24529.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch for governors

ptg-C4

Ed Tomlinson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.994   -> 1.995  
#	include/linux/sched.h	1.129   -> 1.130  
#	       kernel/fork.c	1.104   -> 1.105  
#	       kernel/user.c	1.6     -> 1.7    
#	      kernel/sched.c	1.158   -> 1.159  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/12	ed@oscar.et.ca	1.995
# governors for thread groups and users
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Wed Feb 12 12:13:01 2003
+++ b/include/linux/sched.h	Wed Feb 12 12:13:01 2003
@@ -177,6 +177,11 @@
 
 #include <linux/aio.h>
 
+struct ptg_struct {		/* pseudo thread groups */
+        atomic_t active;        /* number of tasks in run queues */
+        atomic_t count;         /* number of refs */
+};
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -277,6 +282,7 @@
 struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
+	atomic_t active;	/* How many active processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 
 	/* Hash table maintenance information */
@@ -322,6 +328,8 @@
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	struct ptg_struct * ptgroup;		/* pseudo thread group for this task */
+	atomic_t *governor;			/* the atomic_t that governs this task */
 
 /* task state */
 	struct linux_binfmt *binfmt;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Wed Feb 12 12:13:01 2003
+++ b/kernel/fork.c	Wed Feb 12 12:13:01 2003
@@ -74,6 +74,14 @@
 
 void __put_task_struct(struct task_struct *tsk)
 {
+	if (tsk->ptgroup && atomic_sub_and_test(1,&tsk->ptgroup->count)) {
+		kfree(tsk->ptgroup);
+		tsk->ptgroup = NULL;
+		tsk->governor = &tsk->user->active;
+		if (tsk == current)
+			atomic_inc(tsk->governor);
+	}
chedule_tunables-C4
 	if (tsk != current) {
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
@@ -450,6 +458,7 @@
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
+	tsk->ptgroup = NULL;
 
 	/*
 	 * Are we cloning a kernel thread?
@@ -715,6 +724,29 @@
 	p->flags = new_flags;
 }
 
+static inline int setup_governor(unsigned long clone_flags, struct task_struct *p)
+{
+	if ( ((clone_flags & CLONE_VM) && (clone_flags & CLONE_FILES)) ||
+	     (clone_flags & CLONE_THREAD)) {
+		if (current->ptgroup)
+			atomic_inc(&current->ptgroup->count);
+		else {
+			current->ptgroup = kmalloc(sizeof(struct ptg_struct), GFP_ATOMIC);
+			if (!current->ptgroup)
+				return 1;
+			/* printk(KERN_INFO "ptgroup - pid %u\n",current->pid); */
+			atomic_set(&current->ptgroup->count,2);
+			atomic_set(&current->ptgroup->active,1);
+			atomic_dec(current->governor);
+			current->governor = &current->ptgroup->active;
+		}
+		p->ptgroup = current->ptgroup;
+		p->governor = &p->ptgroup->active;
+	} else
+		p->governor = &p->user->active;
+	return 0;
+}
+
 asmlinkage int sys_set_tid_address(int *tidptr)
 {
 	current->clear_child_tid = tidptr;
@@ -855,6 +887,12 @@
 		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
+		goto bad_fork_cleanup_namespace;
+	/*
+	 * Setup the governor pointer for the new process, allocating a new ptg as
+	 * required if the process is a member of a thread group. 
+	 */
+	if (setup_governor(clone_flags, p))
 		goto bad_fork_cleanup_namespace;
 
 	if (clone_flags & CLONE_CHILD_SETTID)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Feb 12 12:13:01 2003
+++ b/kernel/sched.c	Wed Feb 12 12:13:01 2003
@@ -62,6 +62,8 @@
 #define MAX_TIMESLICE		(300 * HZ / 1000)
 #define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
+#define THREAD_GOVERNOR		15	/* allow threads groups 1.5 full timeslices */
+#define USER_GOVERNOR		300	/* allow user 30 full timeslices */
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
@@ -121,9 +123,23 @@
 #define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
 	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
 
+static int next;
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
+/*	if (jiffies > next) {
+		printk(KERN_INFO "uid %d pid %d ptg %x gov %x threads %d lim %d slice %d\n",p->uid, p->pid, p->ptgroup, p->governor, threads/10, govern, slice);
+		next = jiffies + HZ*300;
+	} */
+	return slice;
 }
 
 /*
@@ -196,16 +212,18 @@
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
@@ -219,8 +237,8 @@
 #else /* !CONFIG_NUMA */
 
 # define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_inc(p, rq)    do { (rq)->nr_running++; atomic_inc((p)->governor); } while (0)
+# define nr_running_dec(p, rq)    do { (rq)->nr_running--; atomic_dec((p)->governor); } while (0)
 
 #endif /* CONFIG_NUMA */
 
@@ -341,7 +359,7 @@
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	nr_running_inc(rq);
+	nr_running_inc(p, rq);
 }
 
 /*
@@ -349,7 +367,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	nr_running_dec(rq);
+	nr_running_dec(p, rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -910,9 +928,9 @@
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	nr_running_dec(src_rq);
+	nr_running_dec(p, src_rq);
 	set_task_cpu(p, this_cpu);
-	nr_running_inc(this_rq);
+	nr_running_inc(p, this_rq);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -2450,6 +2468,7 @@
 	rq->curr = current;
 	rq->idle = current;
 	set_task_cpu(current, smp_processor_id());
+	current->governor = &current->user->active;
 	wake_up_forked_process(current);
 
 	init_timers();
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c	Wed Feb 12 12:13:01 2003
+++ b/kernel/user.c	Wed Feb 12 12:13:01 2003
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
@@ -130,6 +132,11 @@
 	atomic_inc(&new_user->processes);
 	atomic_dec(&old_user->processes);
 	current->user = new_user;
+	if (!current->ptgroup) {
+		atomic_dec(current->governor);
+		current->governor = &current->user->active;
+		atomic_inc(current->governor);
+	}
 	free_uid(old_user);
 }
 



