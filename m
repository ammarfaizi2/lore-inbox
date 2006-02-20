Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWBTOrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWBTOrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWBTOrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:47:23 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:1747 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932623AbWBTOrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:47:20 -0500
Message-ID: <43F9E890.B8550676@tv-sign.ru>
Date: Mon, 20 Feb 2006 19:04:32 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 4/4] rename __exit_sighand to cleanup_sighand
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic, rename __exit_sighand to cleanup_sighand and move
it close to copy_sighand().

This matches copy_signal/cleanup_signal naming, and I think
it is easier to follow.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/include/linux/sched.h~4_ESGH	2006-02-20 02:01:27.000000000 +0300
+++ 2.6.16-rc3/include/linux/sched.h	2006-02-20 21:00:09.000000000 +0300
@@ -1142,8 +1142,8 @@ extern void exit_thread(void);
 
 extern void exit_files(struct task_struct *);
 extern void __cleanup_signal(struct signal_struct *);
+extern void cleanup_sighand(struct task_struct *);
 extern void __exit_signal(struct task_struct *);
-extern void __exit_sighand(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern NORET_TYPE void do_group_exit(int);
--- 2.6.16-rc3/kernel/fork.c~4_ESGH	2006-02-20 02:02:38.000000000 +0300
+++ 2.6.16-rc3/kernel/fork.c	2006-02-20 21:14:25.000000000 +0300
@@ -801,6 +801,16 @@ static inline int copy_sighand(unsigned 
 	return 0;
 }
 
+void cleanup_sighand(struct task_struct *tsk)
+{
+	struct sighand_struct * sighand = tsk->sighand;
+
+	/* Ok, we're done with the signal handlers */
+	tsk->sighand = NULL;
+	if (atomic_dec_and_test(&sighand->count))
+		kmem_cache_free(sighand_cachep, sighand);
+}
+
 static inline int copy_signal(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct signal_struct *sig;
@@ -1212,7 +1222,7 @@ bad_fork_cleanup_mm:
 bad_fork_cleanup_signal:
 	cleanup_signal(p);
 bad_fork_cleanup_sighand:
-	__exit_sighand(p);
+	cleanup_sighand(p);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
--- 2.6.16-rc3/kernel/signal.c~4_ESGH	2006-02-20 20:55:50.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-20 21:06:49.000000000 +0300
@@ -310,9 +310,7 @@ static void flush_sigqueue(struct sigpen
 /*
  * Flush all pending signals for a task.
  */
-
-void
-flush_signals(struct task_struct *t)
+void flush_signals(struct task_struct *t)
 {
 	unsigned long flags;
 
@@ -326,19 +324,6 @@ flush_signals(struct task_struct *t)
 /*
  * This function expects the tasklist_lock write-locked.
  */
-void __exit_sighand(struct task_struct *tsk)
-{
-	struct sighand_struct * sighand = tsk->sighand;
-
-	/* Ok, we're done with the signal handlers */
-	tsk->sighand = NULL;
-	if (atomic_dec_and_test(&sighand->count))
-		kmem_cache_free(sighand_cachep, sighand);
-}
-
-/*
- * This function expects the tasklist_lock write-locked.
- */
 void __exit_signal(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
@@ -386,7 +371,7 @@ void __exit_signal(struct task_struct *t
 	}
 
 	tsk->signal = NULL;
-	__exit_sighand(tsk);
+	cleanup_sighand(tsk);
 	spin_unlock(&sighand->siglock);
 	rcu_read_unlock();
