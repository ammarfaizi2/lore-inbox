Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWBVWgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWBVWgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWBVWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:36:18 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:60646 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751572AbWBVWgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:36:15 -0500
Message-ID: <43FCE6AC.ED8BC108@tv-sign.ru>
Date: Thu, 23 Feb 2006 01:33:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: [PATCH 2/3] revert "Optimize sys_times for a single thread process"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reverts 'CONFIG_SMP && thread_group_empty()'
optimization in sys_times(). The reason is that the next
patch breaks memory ordering which is needed for that
optimization.

tasklist_lock in sys_times() will be eliminated completely
by further patch.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/exit.c~2_REVERT	2006-02-23 00:32:46.000000000 +0300
+++ 2.6.16-rc3/kernel/exit.c	2006-02-23 00:54:28.000000000 +0300
@@ -137,11 +137,7 @@ repeat:
 	ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
-	/*
-	 * Note that the fastpath in sys_times depends on __exit_signal having
-	 * updated the counters before a task is removed from the tasklist of
-	 * the process by __unhash_process.
-	 */
+
 	__unhash_process(p);
 
 	/*
--- 2.6.16-rc3/kernel/sys.c~2_REVERT	2006-02-13 21:47:19.000000000 +0300
+++ 2.6.16-rc3/kernel/sys.c	2006-02-23 00:55:56.000000000 +0300
@@ -1009,69 +1009,35 @@ asmlinkage long sys_times(struct tms __u
 	 */
 	if (tbuf) {
 		struct tms tmp;
+		struct task_struct *tsk = current;
+		struct task_struct *t;
 		cputime_t utime, stime, cutime, cstime;
 
-#ifdef CONFIG_SMP
-		if (thread_group_empty(current)) {
-			/*
-			 * Single thread case without the use of any locks.
-			 *
-			 * We may race with release_task if two threads are
-			 * executing. However, release task first adds up the
-			 * counters (__exit_signal) before  removing the task
-			 * from the process tasklist (__unhash_process).
-			 * __exit_signal also acquires and releases the
-			 * siglock which results in the proper memory ordering
-			 * so that the list modifications are always visible
-			 * after the counters have been updated.
-			 *
-			 * If the counters have been updated by the second thread
-			 * but the thread has not yet been removed from the list
-			 * then the other branch will be executing which will
-			 * block on tasklist_lock until the exit handling of the
-			 * other task is finished.
-			 *
-			 * This also implies that the sighand->siglock cannot
-			 * be held by another processor. So we can also
-			 * skip acquiring that lock.
-			 */
-			utime = cputime_add(current->signal->utime, current->utime);
-			stime = cputime_add(current->signal->utime, current->stime);
-			cutime = current->signal->cutime;
-			cstime = current->signal->cstime;
-		} else
-#endif
-		{
-
-			/* Process with multiple threads */
-			struct task_struct *tsk = current;
-			struct task_struct *t;
+		read_lock(&tasklist_lock);
+		utime = tsk->signal->utime;
+		stime = tsk->signal->stime;
+		t = tsk;
+		do {
+			utime = cputime_add(utime, t->utime);
+			stime = cputime_add(stime, t->stime);
+			t = next_thread(t);
+		} while (t != tsk);
 
-			read_lock(&tasklist_lock);
-			utime = tsk->signal->utime;
-			stime = tsk->signal->stime;
-			t = tsk;
-			do {
-				utime = cputime_add(utime, t->utime);
-				stime = cputime_add(stime, t->stime);
-				t = next_thread(t);
-			} while (t != tsk);
+		/*
+		 * While we have tasklist_lock read-locked, no dying thread
+		 * can be updating current->signal->[us]time.  Instead,
+		 * we got their counts included in the live thread loop.
+		 * However, another thread can come in right now and
+		 * do a wait call that updates current->signal->c[us]time.
+		 * To make sure we always see that pair updated atomically,
+		 * we take the siglock around fetching them.
+		 */
+		spin_lock_irq(&tsk->sighand->siglock);
+		cutime = tsk->signal->cutime;
+		cstime = tsk->signal->cstime;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
 
-			/*
-			 * While we have tasklist_lock read-locked, no dying thread
-			 * can be updating current->signal->[us]time.  Instead,
-			 * we got their counts included in the live thread loop.
-			 * However, another thread can come in right now and
-			 * do a wait call that updates current->signal->c[us]time.
-			 * To make sure we always see that pair updated atomically,
-			 * we take the siglock around fetching them.
-			 */
-			spin_lock_irq(&tsk->sighand->siglock);
-			cutime = tsk->signal->cutime;
-			cstime = tsk->signal->cstime;
-			spin_unlock_irq(&tsk->sighand->siglock);
-			read_unlock(&tasklist_lock);
-		}
 		tmp.tms_utime = cputime_to_clock_t(utime);
 		tmp.tms_stime = cputime_to_clock_t(stime);
 		tmp.tms_cutime = cputime_to_clock_t(cutime);
