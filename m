Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWDHUOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWDHUOW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWDHUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:14:22 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:14747 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751424AbWDHUOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:14:20 -0400
Date: Sun, 9 Apr 2006 04:11:20 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH rc1-mm 1/3] coredump: some code relocations
Message-ID: <20060409001120.GA98@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for the next patch. No functional changes.
Basically, this patch moves '->flags & SIGNAL_GROUP_EXIT' check
into zap_threads(), and 'complete(vfork_done)' into coredump_wait
outside of ->mmap_sem protected area.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/exec.c~1_clean	2006-04-07 01:32:02.000000000 +0400
+++ MM/fs/exec.c	2006-04-09 02:33:28.000000000 +0400
@@ -1405,20 +1405,22 @@ static void zap_process(struct task_stru
 	unlock_task_sighand(start, &flags);
 }
 
-static void zap_threads(struct mm_struct *mm)
+static inline int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
+				int exit_code)
 {
 	struct task_struct *g, *p;
-	struct task_struct *tsk = current;
-	struct completion *vfork_done = tsk->vfork_done;
+	int err = -EAGAIN;
 
-	/*
-	 * Make sure nobody is waiting for us to release the VM,
-	 * otherwise we can deadlock when we wait on each other
-	 */
-	if (vfork_done) {
-		tsk->vfork_done = NULL;
-		complete(vfork_done);
+	spin_lock_irq(&tsk->sighand->siglock);
+	if (!(tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+		tsk->signal->flags = SIGNAL_GROUP_EXIT;
+		tsk->signal->group_exit_code = exit_code;
+		tsk->signal->group_stop_count = 0;
+		err = 0;
 	}
+	spin_unlock_irq(&tsk->sighand->siglock);
+	if (err)
+		return err;
 
 	rcu_read_lock();
 	for_each_process(g) {
@@ -1432,22 +1434,43 @@ static void zap_threads(struct mm_struct
 		} while ((p = next_thread(p)) != g);
 	}
 	rcu_read_unlock();
+
+	return mm->core_waiters;
 }
 
-static void coredump_wait(struct mm_struct *mm)
+static int coredump_wait(int exit_code)
 {
-	DECLARE_COMPLETION(startup_done);
+	struct task_struct *tsk = current;
+	struct mm_struct *mm = tsk->mm;
+	struct completion startup_done;
+	struct completion *vfork_done;
 	int core_waiters;
 
+	init_completion(&mm->core_done);
+	init_completion(&startup_done);
 	mm->core_startup_done = &startup_done;
 
-	zap_threads(mm);
-	core_waiters = mm->core_waiters;
+	core_waiters = zap_threads(tsk, mm, exit_code);
 	up_write(&mm->mmap_sem);
 
+	if (unlikely(core_waiters < 0))
+		goto fail;
+
+	/*
+	 * Make sure nobody is waiting for us to release the VM,
+	 * otherwise we can deadlock when we wait on each other
+	 */
+	vfork_done = tsk->vfork_done;
+	if (vfork_done) {
+		tsk->vfork_done = NULL;
+		complete(vfork_done);
+	}
+
 	if (core_waiters)
 		wait_for_completion(&startup_done);
+fail:
 	BUG_ON(mm->core_waiters);
+	return core_waiters;
 }
 
 int do_coredump(long signr, int exit_code, struct pt_regs * regs)
@@ -1481,22 +1504,9 @@ int do_coredump(long signr, int exit_cod
 	}
 	mm->dumpable = 0;
 
-	retval = -EAGAIN;
-	spin_lock_irq(&current->sighand->siglock);
-	if (!(current->signal->flags & SIGNAL_GROUP_EXIT)) {
-		current->signal->flags = SIGNAL_GROUP_EXIT;
-		current->signal->group_exit_code = exit_code;
-		current->signal->group_stop_count = 0;
-		retval = 0;
-	}
-	spin_unlock_irq(&current->sighand->siglock);
-	if (retval) {
-		up_write(&mm->mmap_sem);
+	retval = coredump_wait(exit_code);
+	if (retval < 0)
 		goto fail;
-	}
-
-	init_completion(&mm->core_done);
-	coredump_wait(mm);
 
 	/*
 	 * Clear any false indication of pending signals that might

