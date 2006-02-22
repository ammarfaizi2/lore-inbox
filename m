Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWBVWfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWBVWfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWBVWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:35:54 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57830 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751575AbWBVWfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:35:52 -0500
Message-ID: <43FCE696.8947EA71@tv-sign.ru>
Date: Thu, 23 Feb 2006 01:32:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 1/3] move __exit_signal() to kernel/exit.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__exit_signal() is private to release_task() now.
I think it is better to make it static in kernel/exit.c
and export flush_sigqueue() instead - this function is
much more simple and straightforward.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/include/linux/sched.h~1_MOVE	2006-02-20 21:00:09.000000000 +0300
+++ 2.6.16-rc3/include/linux/sched.h	2006-02-23 00:23:40.000000000 +0300
@@ -1143,7 +1143,6 @@ extern void exit_thread(void);
 extern void exit_files(struct task_struct *);
 extern void __cleanup_signal(struct signal_struct *);
 extern void cleanup_sighand(struct task_struct *);
-extern void __exit_signal(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern NORET_TYPE void do_group_exit(int);
--- 2.6.16-rc3/include/linux/signal.h~1_MOVE	2006-01-19 18:13:07.000000000 +0300
+++ 2.6.16-rc3/include/linux/signal.h	2006-02-23 00:36:27.000000000 +0300
@@ -249,6 +249,8 @@ static inline void init_sigpending(struc
 	INIT_LIST_HEAD(&sig->list);
 }
 
+extern void flush_sigqueue(struct sigpending *queue);
+
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
 {
--- 2.6.16-rc3/kernel/exit.c~1_MOVE	2006-02-17 00:05:25.000000000 +0300
+++ 2.6.16-rc3/kernel/exit.c	2006-02-23 00:32:46.000000000 +0300
@@ -29,6 +29,7 @@
 #include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/posix-timers.h>
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
 
@@ -60,6 +61,68 @@ static void __unhash_process(struct task
 	remove_parent(p);
 }
 
+/*
+ * This function expects the tasklist_lock write-locked.
+ */
+static void __exit_signal(struct task_struct *tsk)
+{
+	struct signal_struct *sig = tsk->signal;
+	struct sighand_struct *sighand;
+
+	BUG_ON(!sig);
+	BUG_ON(!atomic_read(&sig->count));
+
+	rcu_read_lock();
+	sighand = rcu_dereference(tsk->sighand);
+	spin_lock(&sighand->siglock);
+
+	posix_cpu_timers_exit(tsk);
+	if (atomic_dec_and_test(&sig->count))
+		posix_cpu_timers_exit_group(tsk);
+	else {
+		/*
+		 * If there is any task waiting for the group exit
+		 * then notify it:
+		 */
+		if (sig->group_exit_task && atomic_read(&sig->count) == sig->notify_count) {
+			wake_up_process(sig->group_exit_task);
+			sig->group_exit_task = NULL;
+		}
+		if (tsk == sig->curr_target)
+			sig->curr_target = next_thread(tsk);
+		/*
+		 * Accumulate here the counters for all threads but the
+		 * group leader as they die, so they can be added into
+		 * the process-wide totals when those are taken.
+		 * The group leader stays around as a zombie as long
+		 * as there are other threads.  When it gets reaped,
+		 * the exit.c code will add its counts into these totals.
+		 * We won't ever get here for the group leader, since it
+		 * will have been the last reference on the signal_struct.
+		 */
+		sig->utime = cputime_add(sig->utime, tsk->utime);
+		sig->stime = cputime_add(sig->stime, tsk->stime);
+		sig->min_flt += tsk->min_flt;
+		sig->maj_flt += tsk->maj_flt;
+		sig->nvcsw += tsk->nvcsw;
+		sig->nivcsw += tsk->nivcsw;
+		sig->sched_time += tsk->sched_time;
+		sig = NULL; /* Marker for below. */
+	}
+
+	tsk->signal = NULL;
+	cleanup_sighand(tsk);
+	spin_unlock(&sighand->siglock);
+	rcu_read_unlock();
+
+	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
+	flush_sigqueue(&tsk->pending);
+	if (sig) {
+		flush_sigqueue(&sig->shared_pending);
+		__cleanup_signal(sig);
+	}
+}
+
 void release_task(struct task_struct * p)
 {
 	int zap_leader;
--- 2.6.16-rc3/kernel/signal.c~1_MOVE	2006-02-20 21:06:49.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-23 00:36:49.000000000 +0300
@@ -22,7 +22,6 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/ptrace.h>
-#include <linux/posix-timers.h>
 #include <linux/signal.h>
 #include <linux/audit.h>
 #include <linux/capability.h>
@@ -295,7 +294,7 @@ static void __sigqueue_free(struct sigqu
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
-static void flush_sigqueue(struct sigpending *queue)
+void flush_sigqueue(struct sigpending *queue)
 {
 	struct sigqueue *q;
 
@@ -322,68 +321,6 @@ void flush_signals(struct task_struct *t
 }
 
 /*
- * This function expects the tasklist_lock write-locked.
- */
-void __exit_signal(struct task_struct *tsk)
-{
-	struct signal_struct *sig = tsk->signal;
-	struct sighand_struct *sighand;
-
-	BUG_ON(!sig);
-	BUG_ON(!atomic_read(&sig->count));
-
-	rcu_read_lock();
-	sighand = rcu_dereference(tsk->sighand);
-	spin_lock(&sighand->siglock);
-
-	posix_cpu_timers_exit(tsk);
-	if (atomic_dec_and_test(&sig->count))
-		posix_cpu_timers_exit_group(tsk);
-	else {
-		/*
-		 * If there is any task waiting for the group exit
-		 * then notify it:
-		 */
-		if (sig->group_exit_task && atomic_read(&sig->count) == sig->notify_count) {
-			wake_up_process(sig->group_exit_task);
-			sig->group_exit_task = NULL;
-		}
-		if (tsk == sig->curr_target)
-			sig->curr_target = next_thread(tsk);
-		/*
-		 * Accumulate here the counters for all threads but the
-		 * group leader as they die, so they can be added into
-		 * the process-wide totals when those are taken.
-		 * The group leader stays around as a zombie as long
-		 * as there are other threads.  When it gets reaped,
-		 * the exit.c code will add its counts into these totals.
-		 * We won't ever get here for the group leader, since it
-		 * will have been the last reference on the signal_struct.
-		 */
-		sig->utime = cputime_add(sig->utime, tsk->utime);
-		sig->stime = cputime_add(sig->stime, tsk->stime);
-		sig->min_flt += tsk->min_flt;
-		sig->maj_flt += tsk->maj_flt;
-		sig->nvcsw += tsk->nvcsw;
-		sig->nivcsw += tsk->nivcsw;
-		sig->sched_time += tsk->sched_time;
-		sig = NULL; /* Marker for below. */
-	}
-
-	tsk->signal = NULL;
-	cleanup_sighand(tsk);
-	spin_unlock(&sighand->siglock);
-	rcu_read_unlock();
-
-	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
-	flush_sigqueue(&tsk->pending);
-	if (sig) {
-		flush_sigqueue(&sig->shared_pending);
-		__cleanup_signal(sig);
-	}
-}
-
-/*
  * Flush all handlers for a task.
  */
