Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUIKH7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUIKH7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 03:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUIKH7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 03:59:24 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:62898 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S267638AbUIKH7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 03:59:08 -0400
Date: Sat, 11 Sep 2004 00:59:05 -0700
Message-Id: <200409110759.i8B7x5OH019867@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] exec: fix posix-timers leak and pending signal loss
X-Fcc: ~/Mail/linus
X-Zippy-Says: Remember, in 2039, MOUSSE & PASTA will be available ONLY by prescription!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found some problems with exec and fixed them with this patch to de_thread.

The first problem is that exec fails to clean up posix-timers.  This
manifests itself in two ways, one worse than the other.  In the
single-threaded case, it just fails to clear out the timers on exec.
POSIX says that exec clears out the timers from timer_create (though not
the setitimer ones), so it's wrong that a lingering timer could fire after
exec and kill the process with a signal it's not expecting.  In the
multi-threaded case, it not only leaves lingering timers, but it leaks
them entirely when it replaces signal_struct, so they will never be freed
by the process exiting after that exec.  The new per-user
RLIMIT_SIGPENDING actually limits the damage here, because a UID will fill
up its quota with leaked timers and then never be able to use timer_create
again (that's what my test program does).  But if you have many many
untrusted UIDs, this leak could be considered a DoS risk.

The second problem is that a multithreaded exec loses all pending signals.
This is violation of POSIX rules.  But a moment's thought will show it's
also just not desireable: if you send a process a SIGTERM while it's in
the middle of calling exec, you expect either the original program in that
process or the new program being exec'd to handle that signal or be killed
by it.  As it stands now, you can try to kill a process and have that
signal just evaporate if it's multithreaded and calls exec just then.  
I really don't know what the rationale was behind the de_thread code that
allocates a new signal_struct.  It doesn't make any sense now.  The other
code there ensures that the old signal_struct is no longer shared.  Except
for posix-timers, all the state there is stuff you want to keep.  So my
changes just keep the old structs when they are no longer shared, and all
the right state is retained (after clearing out posix-timers).

The final bug is that the cumulative statistics of dead threads and dead
child processes are lost in the abandoned signal_struct.  This is also
fixed by holding on to it instead of replacing it.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- vanilla-linux-2.6/fs/exec.c	2004-08-30 17:47:11.000000000 -0700
+++ linux-2.6/fs/exec.c	2004-09-11 00:24:42.819002437 -0700
@@ -564,7 +564,7 @@ static int exec_mmap(struct mm_struct *m
  */
 static inline int de_thread(struct task_struct *tsk)
 {
-	struct signal_struct *newsig, *oldsig = tsk->signal;
+	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *newsighand, *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
 	int count;
@@ -573,43 +573,16 @@ static inline int de_thread(struct task_
 	 * If we don't share sighandlers, then we aren't sharing anything
 	 * and we can just re-use it all.
 	 */
-	if (atomic_read(&oldsighand->count) <= 1)
+	if (atomic_read(&oldsighand->count) <= 1) {
+		BUG_ON(atomic_read(&sig->count) != 1);
+		exit_itimers(sig);
 		return 0;
+	}
 
 	newsighand = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
 	if (!newsighand)
 		return -ENOMEM;
 
-	spin_lock_init(&newsighand->siglock);
-	atomic_set(&newsighand->count, 1);
-	memcpy(newsighand->action, oldsighand->action, sizeof(newsighand->action));
-
-	/*
-	 * See if we need to allocate a new signal structure
-	 */
-	newsig = NULL;
-	if (atomic_read(&oldsig->count) > 1) {
-		newsig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
-		if (!newsig) {
-			kmem_cache_free(sighand_cachep, newsighand);
-			return -ENOMEM;
-		}
-		atomic_set(&newsig->count, 1);
-		newsig->group_exit = 0;
-		newsig->group_exit_code = 0;
-		newsig->group_exit_task = NULL;
-		newsig->group_stop_count = 0;
-		newsig->curr_target = NULL;
-		init_sigpending(&newsig->shared_pending);
-		INIT_LIST_HEAD(&newsig->posix_timers);
-
-		newsig->tty = oldsig->tty;
-		newsig->pgrp = oldsig->pgrp;
-		newsig->session = oldsig->session;
-		newsig->leader = oldsig->leader;
-		newsig->tty_old_pgrp = oldsig->tty_old_pgrp;
-	}
-
 	if (thread_group_empty(current))
 		goto no_thread_group;
 
@@ -619,7 +592,7 @@ static inline int de_thread(struct task_
 	 */
 	read_lock(&tasklist_lock);
 	spin_lock_irq(lock);
-	if (oldsig->group_exit) {
+	if (sig->group_exit) {
 		/*
 		 * Another group action in progress, just
 		 * return so that the signal is processed.
@@ -627,11 +600,9 @@ static inline int de_thread(struct task_
 		spin_unlock_irq(lock);
 		read_unlock(&tasklist_lock);
 		kmem_cache_free(sighand_cachep, newsighand);
-		if (newsig)
-			kmem_cache_free(signal_cachep, newsig);
 		return -EAGAIN;
 	}
-	oldsig->group_exit = 1;
+	sig->group_exit = 1;
 	zap_other_threads(current);
 	read_unlock(&tasklist_lock);
 
@@ -641,14 +612,16 @@ static inline int de_thread(struct task_
 	count = 2;
 	if (current->pid == current->tgid)
 		count = 1;
-	while (atomic_read(&oldsig->count) > count) {
-		oldsig->group_exit_task = current;
-		oldsig->notify_count = count;
+	while (atomic_read(&sig->count) > count) {
+		sig->group_exit_task = current;
+		sig->notify_count = count;
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(lock);
 		schedule();
 		spin_lock_irq(lock);
 	}
+	sig->group_exit_task = NULL;
+	sig->notify_count = 0;
 	spin_unlock_irq(lock);
 
 	/*
@@ -723,29 +696,46 @@ static inline int de_thread(struct task_
 		release_task(leader);
         }
 
+	/*
+	 * Now there are really no other threads at all,
+	 * so it's safe to stop telling them to kill themselves.
+	 */
+	sig->group_exit = 0;
+
 no_thread_group:
+	BUG_ON(atomic_read(&sig->count) != 1);
+	exit_itimers(sig);
 
-	write_lock_irq(&tasklist_lock);
-	spin_lock(&oldsighand->siglock);
-	spin_lock(&newsighand->siglock);
-
-	if (current == oldsig->curr_target)
-		oldsig->curr_target = next_thread(current);
-	if (newsig)
-		current->signal = newsig;
-	current->sighand = newsighand;
-	init_sigpending(&current->pending);
-	recalc_sigpending();
-
-	spin_unlock(&newsighand->siglock);
-	spin_unlock(&oldsighand->siglock);
-	write_unlock_irq(&tasklist_lock);
+	if (atomic_read(&oldsighand->count) == 1) {
+		/*
+		 * Now that we nuked the rest of the thread group,
+		 * it turns out we are not sharing sighand any more either.
+		 * So we can just keep it.
+		 */
+		kmem_cache_free(sighand_cachep, newsighand);
+	} else {
+		/*
+		 * Move our state over to newsighand and switch it in.
+		 */
+		spin_lock_init(&newsighand->siglock);
+		atomic_set(&newsighand->count, 1);
+		memcpy(newsighand->action, oldsighand->action,
+		       sizeof(newsighand->action));
+
+		write_lock_irq(&tasklist_lock);
+		spin_lock(&oldsighand->siglock);
+		spin_lock(&newsighand->siglock);
 
-	if (newsig && atomic_dec_and_test(&oldsig->count))
-		kmem_cache_free(signal_cachep, oldsig);
+		current->sighand = newsighand;
+		recalc_sigpending();
 
-	if (atomic_dec_and_test(&oldsighand->count))
-		kmem_cache_free(sighand_cachep, oldsighand);
+		spin_unlock(&newsighand->siglock);
+		spin_unlock(&oldsighand->siglock);
+		write_unlock_irq(&tasklist_lock);
+
+		if (atomic_dec_and_test(&oldsighand->count))
+			kmem_cache_free(sighand_cachep, oldsighand);
+	}
 
 	if (!thread_group_empty(current))
 		BUG();
