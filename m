Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWBTOqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWBTOqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWBTOql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:46:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:49362 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932616AbWBTOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:46:30 -0500
Message-ID: <43F9E85E.4D7C2967@tv-sign.ru>
Date: Mon, 20 Feb 2006 19:03:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 2/2] copy_process: cleanup bad_fork_cleanup_signal
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__exit_signal() does important cleanups atomically under ->siglock.
It is also called from copy_process's error path. This is not good,
for example we can't move __unhash_process() under ->siglock for
that reason.

We should not mix these 2 paths, just look at ugly 'if (p->sighand)'
under 'bad_fork_cleanup_sighand:' label. For copy_process() case it
is sufficient to just backout copy_signal(), nothing more.

Again, nobody can see this task yet. For CLONE_THREAD case we just
decrement signal->count, otherwise nobody can see this ->signal and
we can free it lockless.

This patch assumes it is safe to do exit_thread_group_keys() without
tasklist_lock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/include/linux/sched.h~2_SGNL	2006-02-20 00:38:57.000000000 +0300
+++ 2.6.16-rc3/include/linux/sched.h	2006-02-20 02:01:27.000000000 +0300
@@ -1141,7 +1141,7 @@ extern void flush_thread(void);
 extern void exit_thread(void);
 
 extern void exit_files(struct task_struct *);
-extern void exit_signal(struct task_struct *);
+extern void __cleanup_signal(struct signal_struct *);
 extern void __exit_signal(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
--- 2.6.16-rc3/kernel/fork.c~2_SGNL	2006-02-20 00:38:39.000000000 +0300
+++ 2.6.16-rc3/kernel/fork.c	2006-02-20 02:02:38.000000000 +0300
@@ -870,6 +870,22 @@ static inline int copy_signal(unsigned l
 	return 0;
 }
 
+void __cleanup_signal(struct signal_struct *sig)
+{
+	exit_thread_group_keys(sig);
+	kmem_cache_free(signal_cachep, sig);
+}
+
+static inline void cleanup_signal(struct task_struct *tsk)
+{
+	struct signal_struct *sig = tsk->signal;
+
+	atomic_dec(&sig->live);
+
+	if (atomic_dec_and_test(&sig->count))
+		__cleanup_signal(sig);
+}
+
 static inline void copy_flags(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long new_flags = p->flags;
@@ -1194,10 +1210,9 @@ bad_fork_cleanup_mm:
 	if (p->mm)
 		mmput(p->mm);
 bad_fork_cleanup_signal:
-	exit_signal(p);
+	cleanup_signal(p);
 bad_fork_cleanup_sighand:
-	if (p->sighand)
-		__exit_sighand(p);
+	__exit_sighand(p);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
--- 2.6.16-rc3/kernel/signal.c~2_SGNL	2006-02-20 00:37:34.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-20 02:02:03.000000000 +0300
@@ -395,23 +395,10 @@ void __exit_signal(struct task_struct *t
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
 	if (sig) {
-		/*
-		 * We are cleaning up the signal_struct here.
-		 */
-		exit_thread_group_keys(sig);
-		kmem_cache_free(signal_cachep, sig);
+		__cleanup_signal(sig);
 	}
 }
 
-void exit_signal(struct task_struct *tsk)
-{
-	atomic_dec(&tsk->signal->live);
-
-	write_lock_irq(&tasklist_lock);
-	__exit_signal(tsk);
-	write_unlock_irq(&tasklist_lock);
-}
-
 /*
  * Flush all handlers for a task.
  */
