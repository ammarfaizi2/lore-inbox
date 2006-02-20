Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWBTOqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWBTOqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWBTOqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:46:18 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:43474 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932537AbWBTOqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:46:17 -0500
Message-ID: <43F9E841.FD560455@tv-sign.ru>
Date: Mon, 20 Feb 2006 19:03:13 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 1/2] copy_process: cleanup bad_fork_cleanup_sighand
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of exit_sighand(tsk) is copy_process's error path.
We can call __exit_sighand() directly and kill exit_sighand().

This 'tsk' was not yet registered in pid_hash[] or init_task.tasks,
it has no external references, nobody can see it, and

	IF (clone_flags & CLONE_SIGHAND)
		At least 'current' has a reference to ->sighand, this
		means atomic_dec_and_test(sighand->count) can't be true.

	ELSE
		Nobody can see this ->sighand, this means we can free it
		without any locking.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/include/linux/sched.h~1_SIGH	2006-02-18 22:13:44.000000000 +0300
+++ 2.6.16-rc3/include/linux/sched.h	2006-02-20 00:38:57.000000000 +0300
@@ -1143,7 +1143,6 @@ extern void exit_thread(void);
 extern void exit_files(struct task_struct *);
 extern void exit_signal(struct task_struct *);
 extern void __exit_signal(struct task_struct *);
-extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
--- 2.6.16-rc3/kernel/signal.c~1_SIGH	2006-02-19 21:08:23.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-20 00:37:34.000000000 +0300
@@ -336,20 +336,6 @@ void __exit_sighand(struct task_struct *
 		kmem_cache_free(sighand_cachep, sighand);
 }
 
-void exit_sighand(struct task_struct *tsk)
-{
-	write_lock_irq(&tasklist_lock);
-	rcu_read_lock();
-	if (tsk->sighand != NULL) {
-		struct sighand_struct *sighand = rcu_dereference(tsk->sighand);
-		spin_lock(&sighand->siglock);
-		__exit_sighand(tsk);
-		spin_unlock(&sighand->siglock);
-	}
-	rcu_read_unlock();
-	write_unlock_irq(&tasklist_lock);
-}
-
 /*
  * This function expects the tasklist_lock write-locked.
  */
--- 2.6.16-rc3/kernel/fork.c~1_SIGH	2006-02-18 01:11:59.000000000 +0300
+++ 2.6.16-rc3/kernel/fork.c	2006-02-20 00:38:39.000000000 +0300
@@ -1196,7 +1196,8 @@ bad_fork_cleanup_mm:
 bad_fork_cleanup_signal:
 	exit_signal(p);
 bad_fork_cleanup_sighand:
-	exit_sighand(p);
+	if (p->sighand)
+		__exit_sighand(p);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
