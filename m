Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSIORT4>; Sun, 15 Sep 2002 13:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSIORT4>; Sun, 15 Sep 2002 13:19:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12462 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318134AbSIORTu>;
	Sun, 15 Sep 2002 13:19:50 -0400
Date: Sun, 15 Sep 2002 19:31:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209151902560.7866-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151929480.8676-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached new version of the patch fixes a release_task() crash under
heavy exec and procps load:

--- linux/include/linux/sched.h.orig	Sun Sep 15 17:26:41 2002
+++ linux/include/linux/sched.h	Sun Sep 15 18:03:35 2002
@@ -232,6 +232,8 @@
 	/* thread group exit support */
 	int			group_exit;
 	int			group_exit_code;
+
+	struct task_struct	*group_exit_task;
 };
 
 /*
@@ -562,6 +564,7 @@
 extern void block_all_signals(int (*notifier)(void *priv), void *priv,
 			      sigset_t *mask);
 extern void unblock_all_signals(void);
+extern void release_task(struct task_struct * p);
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
--- linux/fs/exec.c.orig	Sun Sep 15 17:10:23 2002
+++ linux/fs/exec.c	Sun Sep 15 19:26:59 2002
@@ -40,6 +40,7 @@
 #define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/namei.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -493,52 +494,151 @@
 	return 0;
 }
 
+static struct dentry *clean_proc_dentry(struct task_struct *p)
+{
+	struct dentry *proc_dentry = p->proc_dentry;
+
+	if (proc_dentry) {
+		spin_lock(&dcache_lock);
+		if (!list_empty(&proc_dentry->d_hash)) {
+			dget_locked(proc_dentry);
+			list_del_init(&proc_dentry->d_hash);
+		} else
+			proc_dentry = NULL;
+		spin_unlock(&dcache_lock);
+	}
+	return proc_dentry;
+}
+
+static inline void put_proc_dentry(struct dentry *dentry)
+{
+	if (dentry) {
+		shrink_dcache_parent(dentry);
+		dput(dentry);
+	}
+}
+
 /*
  * This function makes sure the current process has its own signal table,
  * so that flush_signal_handlers can later reset the handlers without
  * disturbing other processes.  (Other processes might share the signal
  * table via the CLONE_SIGNAL option to clone().)
  */
- 
-static inline int make_private_signals(void)
+static inline int de_thread(struct signal_struct *oldsig)
 {
-	struct signal_struct * newsig;
-
-	remove_thread_group(current, current->sig);
+	struct signal_struct *newsig;
+	int count;
 
 	if (atomic_read(&current->sig->count) <= 1)
 		return 0;
+
 	newsig = kmem_cache_alloc(sigact_cachep, GFP_KERNEL);
-	if (newsig == NULL)
+	if (!newsig)
 		return -ENOMEM;
+
+	if (list_empty(&current->thread_group))
+		goto out;
+	/*
+	 * Kill all other threads in the thread group:
+	 */
+	spin_lock_irq(&oldsig->siglock);
+	if (oldsig->group_exit) {
+		/*
+		 * Another group action in progress, just
+		 * return so that the signal is processed.
+		 */
+		spin_unlock_irq(&oldsig->siglock);
+		kmem_cache_free(sigact_cachep, newsig);
+		return -EAGAIN;
+	}
+	oldsig->group_exit = 1;
+	__broadcast_thread_group(current, SIGKILL);
+
+	/*
+	 * Account for the thread group leader hanging around:
+	 */
+	count = 2;
+	if (current->pid == current->tgid)
+		count = 1;
+	while (atomic_read(&oldsig->count) > count) {
+		oldsig->group_exit_task = current;
+		current->state = TASK_UNINTERRUPTIBLE;
+		spin_unlock_irq(&oldsig->siglock);
+		schedule();
+		spin_lock_irq(&oldsig->siglock);
+		if (oldsig->group_exit_task)
+			BUG();
+	}
+	spin_unlock_irq(&oldsig->siglock);
+
+	/*
+	 * At this point all other threads have exited, all we have to
+	 * do is to wait for the thread group leader to become inactive,
+	 * and to assume its PID:
+	 */
+	if (current->pid != current->tgid) {
+		struct task_struct *leader = current->group_leader;
+		struct dentry *proc_dentry1, *proc_dentry2;
+		unsigned long state;
+
+		wait_task_inactive(leader);
+
+		write_lock_irq(&tasklist_lock);
+		proc_dentry1 = clean_proc_dentry(current);
+		proc_dentry2 = clean_proc_dentry(leader);
+
+		if (leader->tgid != current->tgid)
+			BUG();
+		if (current->pid == current->tgid)
+			BUG();
+		/*
+		 * An exec() starts a new thread group with the
+		 * TGID of the previous thread group. Rehash the
+		 * two threads with a switched PID, and release
+		 * the former thread group leader:
+		 */
+		unhash_pid(current);
+		unhash_pid(leader);
+		leader->pid = leader->tgid = current->pid;
+		current->pid = current->tgid;
+		hash_pid(current);
+		hash_pid(leader);
+		
+		list_add_tail(&current->tasks, &init_task.tasks);
+		state = leader->state;
+		write_unlock_irq(&tasklist_lock);
+
+		if (state == TASK_ZOMBIE)
+			release_task(leader);
+
+		put_proc_dentry(proc_dentry1);
+		put_proc_dentry(proc_dentry2);
+        }
+
+out:
 	spin_lock_init(&newsig->siglock);
 	atomic_set(&newsig->count, 1);
 	newsig->group_exit = 0;
 	newsig->group_exit_code = 0;
+	newsig->group_exit_task = NULL;
 	memcpy(newsig->action, current->sig->action, sizeof(newsig->action));
 	init_sigpending(&newsig->shared_pending);
 
+	remove_thread_group(current, current->sig);
 	spin_lock_irq(&current->sigmask_lock);
 	current->sig = newsig;
 	spin_unlock_irq(&current->sigmask_lock);
-	return 0;
-}
-	
-/*
- * If make_private_signals() made a copy of the signal table, decrement the
- * refcount of the original table, and free it if necessary.
- * We don't do that in make_private_signals() so that we can back off
- * in flush_old_exec() if an error occurs after calling make_private_signals().
- */
 
-static inline void release_old_signals(struct signal_struct * oldsig)
-{
-	if (current->sig == oldsig)
-		return;
 	if (atomic_dec_and_test(&oldsig->count))
 		kmem_cache_free(sigact_cachep, oldsig);
-}
 
+	if (!list_empty(&current->thread_group))
+		BUG();
+	if (current->tgid != current->pid)
+		BUG();
+	return 0;
+}
+	
 /*
  * These functions flushes out all traces of the currently running executable
  * so that a new one can be started
@@ -572,44 +672,27 @@
 	write_unlock(&files->file_lock);
 }
 
-/*
- * An execve() will automatically "de-thread" the process.
- * - if a master thread (PID==TGID) is doing this, then all subsidiary threads
- *   will be killed (otherwise there will end up being two independent thread
- *   groups with the same TGID).
- * - if a subsidary thread is doing this, then it just leaves the thread group
- */
-static void de_thread(struct task_struct *tsk)
-{
-	if (!list_empty(&tsk->thread_group))
-		BUG();
-	/* An exec() starts a new thread group: */
-	tsk->tgid = tsk->pid;
-}
-
 int flush_old_exec(struct linux_binprm * bprm)
 {
 	char * name;
 	int i, ch, retval;
-	struct signal_struct * oldsig;
-
-	/*
-	 * Make sure we have a private signal table
-	 */
-	oldsig = current->sig;
-	retval = make_private_signals();
-	if (retval) goto flush_failed;
+	struct signal_struct * oldsig = current->sig;
 
 	/* 
 	 * Release all of the old mmap stuff
 	 */
 	retval = exec_mmap(bprm->mm);
-	if (retval) goto mmap_failed;
+	if (retval)
+		goto mmap_failed;
+	/*
+	 * Make sure we have a private signal table and that
+	 * we are unassociated from the previous thread group.
+	 */
+	retval = de_thread(oldsig);
+	if (retval)
+		goto flush_failed;
 
 	/* This is the point of no return */
-	de_thread(current);
-
-	release_old_signals(oldsig);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
--- linux/kernel/fork.c.orig	Sun Sep 15 17:28:02 2002
+++ linux/kernel/fork.c	Sun Sep 15 18:01:39 2002
@@ -633,6 +633,7 @@
 	atomic_set(&sig->count, 1);
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
+	sig->group_exit_task = NULL;
 	memcpy(sig->action, current->sig->action, sizeof(sig->action));
 	sig->curr_target = NULL;
 	init_sigpending(&sig->shared_pending);
--- linux/kernel/exit.c.orig	Sun Sep 15 18:03:05 2002
+++ linux/kernel/exit.c	Sun Sep 15 18:03:10 2002
@@ -49,7 +49,7 @@
 	return proc_dentry;
 }
 
-static void release_task(struct task_struct * p)
+void release_task(struct task_struct * p)
 {
 	struct dentry *proc_dentry;
 
--- linux/kernel/signal.c.orig	Sun Sep 15 17:35:20 2002
+++ linux/kernel/signal.c	Sun Sep 15 17:47:30 2002
@@ -273,6 +273,15 @@
 		kmem_cache_free(sigact_cachep, sig);
 	} else {
 		struct task_struct *leader = tsk->group_leader;
+
+		/*
+		 * If there is any task waiting for the group exit
+		 * then notify it:
+		 */
+		if (sig->group_exit_task && atomic_read(&sig->count) <= 2) {
+			wake_up_process(sig->group_exit_task);
+			sig->group_exit_task = NULL;
+		}
 		/*
 		 * If we are the last non-leader member of the thread
 		 * group, and the leader is zombie, then notify the
@@ -283,6 +292,7 @@
 		 */
 		if (atomic_read(&sig->count) == 1 &&
 					leader->state == TASK_ZOMBIE) {
+
 			__remove_thread_group(tsk, sig);
 			spin_unlock(&sig->siglock);
 			do_notify_parent(leader, leader->exit_signal);

