Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbULDWye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbULDWye (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbULDWyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:54:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35260 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261187AbULDWyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:54:18 -0500
Date: Sat, 4 Dec 2004 14:54:12 -0800
Message-Id: <200412042254.iB4MsC7K024974@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] move waitchld_exit from task_struct to signal_struct
X-Fcc: ~/Mail/linus
Emacs: the Swiss Army of Editors.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is really no point in each task_struct having its own waitchld_exit.
In the only use of it, the waitchld_exit of each thread in a group gets
woken up at the same time.  So, there might as well just be one wait queue
for the whole thread group.  This patch does that by moving the field from
task_struct to signal_struct.  It should have no effect on the behavior,
but saves a little work and a little storage in the multithreaded case.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/security/selinux/hooks.c
+++ linux-2.6/security/selinux/hooks.c
@@ -1914,7 +1914,7 @@ static void selinux_bprm_apply_creds(str
 
 		/* Wake up the parent if it is waiting so that it can
 		   recheck wait permission to the new task SID. */
-		wake_up_interruptible(&current->parent->wait_chldexit);
+		wake_up_interruptible(&current->parent->signal->wait_chldexit);
 
 lock_out:
 		task_lock(current);
--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -1317,7 +1317,7 @@ static long do_wait(pid_t pid, int optio
 	struct task_struct *tsk;
 	int flag, retval;
 
-	add_wait_queue(&current->wait_chldexit,&wait);
+	add_wait_queue(&current->signal->wait_chldexit,&wait);
 repeat:
 	flag = 0;
 	current->state = TASK_INTERRUPTIBLE;
@@ -1420,7 +1420,7 @@ check_continued:
 	retval = -ECHILD;
 end:
 	current->state = TASK_RUNNING;
-	remove_wait_queue(&current->wait_chldexit,&wait);
+	remove_wait_queue(&current->signal->wait_chldexit,&wait);
 	if (infop) {
 		if (retval > 0)
 		retval = 0;
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -1407,28 +1408,12 @@ out:
 }
 
 /*
- * Joy. Or not. Pthread wants us to wake up every thread
- * in our parent group.
+ * Wake up any threads in the parent blocked in wait* syscalls.
  */
-static void __wake_up_parent(struct task_struct *p,
+static inline void __wake_up_parent(struct task_struct *p,
 				    struct task_struct *parent)
 {
-	struct task_struct *tsk = parent;
-
-	/*
-	 * Fortunately this is not necessary for thread groups:
-	 */
-	if (p->tgid == tsk->tgid) {
-		wake_up_interruptible_sync(&tsk->wait_chldexit);
-		return;
-	}
-
-	do {
-		wake_up_interruptible_sync(&tsk->wait_chldexit);
-		tsk = next_thread(tsk);
-		if (tsk->signal != parent->signal)
-			BUG();
-	} while (tsk != parent);
+	wake_up_interruptible_sync(&parent->signal->wait_chldexit);
 }
 
 /*
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -729,6 +729,7 @@ static inline int copy_signal(unsigned l
 		return -ENOMEM;
 	atomic_set(&sig->count, 1);
 	atomic_set(&sig->live, 1);
+	init_waitqueue_head(&sig->wait_chldexit);
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
 	sig->group_exit_task = NULL;
@@ -856,7 +858,6 @@ static task_t *copy_process(unsigned lon
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
-	init_waitqueue_head(&p->wait_chldexit);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
 	spin_lock_init(&p->proc_lock);
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -269,6 +269,8 @@ struct signal_struct {
 	atomic_t		count;
 	atomic_t		live;
 
+	wait_queue_head_t	wait_chldexit;	/* for wait4() */
+
 	/* current thread group signal load-balancing target: */
 	task_t			*curr_target;
 
@@ -574,7 +585,6 @@ struct task_struct {
 	/* PID/PID hash table linkage. */
 	struct pid pids[PIDTYPE_MAX];
 
-	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 	int __user *set_child_tid;		/* CLONE_CHILD_SETTID */
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
--- linux-2.6/include/linux/init_task.h
+++ linux-2.6/include/linux/init_task.h
@@ -46,6 +46,7 @@
 
 #define INIT_SIGNALS(sig) {	\
 	.count		= ATOMIC_INIT(1), 		\
+	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(sig.wait_chldexit),\
 	.shared_pending	= { 				\
 		.list = LIST_HEAD_INIT(sig.shared_pending.list),	\
 		.signal =  {{0}}}, \
@@ -88,7 +89,6 @@ extern struct group_info init_groups;
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
 	.group_leader	= &tsk,						\
-	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
--- linux-2.6/arch/mips/kernel/irixsig.c
+++ linux-2.6/arch/mips/kernel/irixsig.c
@@ -586,7 +586,7 @@ asmlinkage int irix_waitsys(int type, in
 		retval = -EINVAL;
 		goto out;
 	}
-	add_wait_queue(&current->wait_chldexit, &wait);
+	add_wait_queue(&current->signal->wait_chldexit, &wait);
 repeat:
 	flag = 0;
 	current->state = TASK_INTERRUPTIBLE;
@@ -675,7 +675,7 @@ repeat:
 	retval = -ECHILD;
 end_waitsys:
 	current->state = TASK_RUNNING;
-	remove_wait_queue(&current->wait_chldexit, &wait);
+	remove_wait_queue(&current->signal->wait_chldexit, &wait);
 
 out:
 	return retval;
