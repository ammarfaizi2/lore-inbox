Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSLBMyS>; Mon, 2 Dec 2002 07:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSLBMyS>; Mon, 2 Dec 2002 07:54:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15594 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262877AbSLBMyP>;
	Mon, 2 Dec 2002 07:54:15 -0500
Date: Mon, 2 Dec 2002 15:19:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] tcore-fixes-2.5.50-E6
Message-ID: <Pine.LNX.4.44.0212021433240.676-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes threaded coredumps and streamlines the code. The
old code caused crashes and hung coredumps. The new code has been tested
for some time already and appears to be robust. Changes:

- the code now uses completions instead of a semaphore and a waitqueue,
  attached to mm_struct:

        /* coredumping support */
        int core_waiters;
        struct completion *core_startup_done, core_done;

- extended the completion concept with a 'complete all' call - all pending
  threads are woken up in that case.

- core_waiters is a plain integer now - it's always accessed from under
  the mmap_sem. It's also used as the fastpath-check in the sys_exit() 
  path, instead of ->dumpable (which was incorrect).

- got rid of the ->core_waiter task flag - it's not needed anymore.

	Ingo


--- linux/fs/exec.c.orig	2002-12-02 08:36:35.000000000 +0100
+++ linux/fs/exec.c	2002-12-02 14:48:57.000000000 +0100
@@ -1235,49 +1235,58 @@
 {
 	struct task_struct *g, *p;
 
-	/* give other threads a chance to run: */
-	yield();
-
 	read_lock(&tasklist_lock);
 	do_each_thread(g,p)
-		if (mm == p->mm && !p->core_waiter)
+		if (mm == p->mm && p != current) {
 			force_sig_specific(SIGKILL, p);
+			mm->core_waiters++;
+		}
 	while_each_thread(g,p);
+
 	read_unlock(&tasklist_lock);
 }
 
 static void coredump_wait(struct mm_struct *mm)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	DECLARE_COMPLETION(startup_done);
+
+	mm->core_waiters++; /* let other threads block */
+	mm->core_startup_done = &startup_done;
+
+	/* give other threads a chance to run: */
+	yield();
 
-	atomic_inc(&mm->core_waiters);
-	add_wait_queue(&mm->core_wait, &wait);
 	zap_threads(mm);
-	current->state = TASK_UNINTERRUPTIBLE;
-	if (atomic_read(&mm->core_waiters) != atomic_read(&mm->mm_users))
-		schedule();
-	else
-		current->state = TASK_RUNNING;
+	if (--mm->core_waiters) {
+		up_write(&mm->mmap_sem);
+		wait_for_completion(&startup_done);
+	} else
+		up_write(&mm->mmap_sem);
+	BUG_ON(mm->core_waiters);
 }
 
 int do_coredump(long signr, struct pt_regs * regs)
 {
-	struct linux_binfmt * binfmt;
 	char corename[CORENAME_MAX_SIZE + 1];
-	struct file * file;
+	struct mm_struct *mm = current->mm;
+	struct linux_binfmt * binfmt;
 	struct inode * inode;
+	struct file * file;
 	int retval = 0;
 
 	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
-	if (!current->mm->dumpable)
+	down_write(&mm->mmap_sem);
+	if (!mm->dumpable) {
+		up_write(&mm->mmap_sem);
 		goto fail;
-	current->mm->dumpable = 0;
-	if (down_trylock(&current->mm->core_sem))
-		BUG();
-	coredump_wait(current->mm);
+	}
+	mm->dumpable = 0;
+	init_completion(&mm->core_done);
+	coredump_wait(mm);
+
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail_unlock;
 
@@ -1305,7 +1314,7 @@
 close_fail:
 	filp_close(file, NULL);
 fail_unlock:
-	up(&current->mm->core_sem);
+	complete_all(&mm->core_done);
 fail:
 	unlock_kernel();
 	return retval;
--- linux/include/linux/sched.h.orig	2002-12-02 09:48:09.000000000 +0100
+++ linux/include/linux/sched.h	2002-12-02 14:43:49.000000000 +0100
@@ -203,9 +203,8 @@
 	mm_context_t context;
 
 	/* coredumping support */
-	struct semaphore core_sem;
-	atomic_t core_waiters;
-	wait_queue_head_t core_wait;
+	int core_waiters;
+	struct completion *core_startup_done, core_done;
 
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
@@ -397,8 +396,6 @@
 	void *journal_info;
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
-/* threaded coredumping support */
-	int core_waiter;
 
 	unsigned long ptrace_message;
 };
--- linux/include/linux/completion.h.orig	2002-12-02 14:05:12.000000000 +0100
+++ linux/include/linux/completion.h	2002-12-02 14:05:17.000000000 +0100
@@ -29,6 +29,7 @@
 
 extern void FASTCALL(wait_for_completion(struct completion *));
 extern void FASTCALL(complete(struct completion *));
+extern void FASTCALL(complete_all(struct completion *));
 
 #define INIT_COMPLETION(x)	((x).done = 0)
 
--- linux/kernel/sched.c.orig	2002-12-02 13:54:08.000000000 +0100
+++ linux/kernel/sched.c	2002-12-02 14:06:13.000000000 +0100
@@ -1192,6 +1192,16 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
+void complete_all(struct completion *x)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&x->wait.lock, flags);
+	x->done += UINT_MAX/2;
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, 0);
+	spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+
 void wait_for_completion(struct completion *x)
 {
 	might_sleep();
--- linux/kernel/exit.c.orig	2002-12-02 09:50:27.000000000 +0100
+++ linux/kernel/exit.c	2002-12-02 14:44:31.000000000 +0100
@@ -425,14 +425,13 @@
 	/*
 	 * Serialize with any possible pending coredump:
 	 */
-	if (!mm->dumpable) {
-		current->core_waiter = 1;
-		atomic_inc(&mm->core_waiters);
-		if (atomic_read(&mm->core_waiters) ==atomic_read(&mm->mm_users))
-			wake_up(&mm->core_wait);
-		down(&mm->core_sem);
-		up(&mm->core_sem);
-		atomic_dec(&mm->core_waiters);
+	if (mm->core_waiters) {
+		down_write(&mm->mmap_sem);
+		if (!--mm->core_waiters)
+			complete(mm->core_startup_done);
+		up_write(&mm->mmap_sem);
+
+		wait_for_completion(&mm->core_done);
 	}
 	atomic_inc(&mm->mm_count);
 	if (mm != tsk->active_mm) BUG();
--- linux/kernel/fork.c.orig	2002-12-02 09:54:59.000000000 +0100
+++ linux/kernel/fork.c	2002-12-02 14:43:59.000000000 +0100
@@ -328,9 +328,7 @@
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
-	init_MUTEX(&mm->core_sem);
-	init_waitqueue_head(&mm->core_wait);
-	atomic_set(&mm->core_waiters, 0);
+	mm->core_waiters = 0;
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
@@ -799,7 +797,6 @@
 	p->start_time = jiffies;
 	p->security = NULL;
 
-	p->core_waiter = 0;
 	retval = -ENOMEM;
 	if (security_task_alloc(p))
 		goto bad_fork_cleanup;

