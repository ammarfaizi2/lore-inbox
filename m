Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUAFFmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUAFFmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:42:08 -0500
Received: from dp.samba.org ([66.70.73.150]:17828 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265340AbUAFFmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:42:01 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove redundant code in workqueue.c
Date: Tue, 06 Jan 2004 16:39:30 +1100
Message-Id: <20040106054159.8DDAD2C061@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please chew.

As discovered some time back, workqueue.c never receives SIGCHLD,
because it sets the signal handler to SIG_IGN.  From
kernel/signal.c:do_notify_parent():

	psig = tsk->parent->sighand;
	spin_lock_irqsave(&psig->siglock, flags);
	if (sig == SIGCHLD && tsk->state != TASK_STOPPED &&
	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
		/*
		 * We are exiting and our parent doesn't care.  POSIX.1
		 * defines special semantics for setting SIGCHLD to SIG_IGN
		 * or setting the SA_NOCLDWAIT flag: we should be reaped
		 * automatically and not left for our parent's wait4 call.
		 * Rather than having the parent do it as a magic kind of
		 * signal handler, we just set this to tell do_exit that we
		 * can be cleaned up without becoming a zombie.  Note that
		 * we still call __wake_up_parent in this case, because a
		 * blocked sys_wait4 might now return -ECHILD.
		 *
		 * Whether we send SIGCHLD or not for SA_NOCLDWAIT
		 * is implementation-defined: we do (if you don't want
		 * it, just use SIG_IGN instead).
		 */
		tsk->exit_signal = -1;
		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
			sig = 0;
	}
	if (sig > 0 && sig <= _NSIG)
		__group_send_sig_info(sig, &info, tsk->parent);

Since it only wants to reap children, that's fine.  Simply remove the
(never called) wait loop.

(I'm doing this now, because it also simplifies the patch to make
workqueues use kthread).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Simplified Workqueue Child Reaping
Author: Rusty Russell
Status: Tested on 2.6.1-rc1-bk6

D: It turns out that run_workqueue never has signal_pending(), since
D: setting the handler to SIG_IGN means "don't make zombies, I'm ignoring
D: them".  Fix the comment, don't allow the signal, and remove the unused
D: waitpid loop.
D: 
D: This also allows simpler conversion of workueues to the kthread
D: mechanism, which uses signals to indicate it's time to stop.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32296-linux-2.6.1-rc1-bk6/kernel/workqueue.c .32296-linux-2.6.1-rc1-bk6.updated/kernel/workqueue.c
--- .32296-linux-2.6.1-rc1-bk6/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ .32296-linux-2.6.1-rc1-bk6.updated/kernel/workqueue.c	2004-01-06 15:25:39.000000000 +1100
@@ -14,13 +14,10 @@
  *   Theodore Ts'o <tytso@mit.edu>
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/unistd.h>
 #include <linux/signal.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
@@ -171,7 +168,6 @@ static int worker_thread(void *__startup
 	struct k_sigaction sa;
 
 	daemonize("%s/%d", startup->name, cpu);
-	allow_signal(SIGCHLD);
 	current->flags |= PF_IOTHREAD;
 	cwq->thread = current;
 
@@ -180,7 +176,7 @@ static int worker_thread(void *__startup
 
 	complete(&startup->done);
 
-	/* Install a handler so SIGCLD is delivered */
+	/* SIG_IGN makes children autoreap: see do_notify_parent(). */
 	sa.sa.sa_handler = SIG_IGN;
 	sa.sa.sa_flags = 0;
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
@@ -200,14 +196,6 @@ static int worker_thread(void *__startup
 
 		if (!list_empty(&cwq->worklist))
 			run_workqueue(cwq);
-
-		if (signal_pending(current)) {
-			while (waitpid(-1, NULL, __WALL|WNOHANG) > 0)
-				/* SIGCHLD - auto-reaping */ ;
-
-			/* zap all other signals */
-			flush_signals(current);
-		}
 	}
 	remove_wait_queue(&cwq->more_work, &wait);
 	complete(&cwq->exit);
