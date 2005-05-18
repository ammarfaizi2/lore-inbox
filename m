Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVERBBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVERBBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVERBBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:01:09 -0400
Received: from graphe.net ([209.204.138.32]:17680 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262011AbVERBAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:00:45 -0400
Date: Tue, 17 May 2005 18:00:39 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, shai@scalex86.org
Subject: Re: [PATCH] Optimize sys_times for a single thread process
In-Reply-To: <20050518010337.GB44089@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.62.0505171759320.18365@graphe.net>
References: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
 <20050518010337.GB44089@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Mitchell Blank Jr wrote:

> Maybe #ifdef CONFIG_SMP around this?  On uniproc you're still saving the
> sti/cli around reading the tsk->signal stuff but that's probably not
> enough to warrant the code bloat.
> 
> Or maybe this is a small enough amount of code not to matter... just a
> suggestion.

Here is the patch with more explanations and #ifdef CONFIG_SMP
Avoid taking the tasklist_lock in sys_times if the process is
single threaded. In a NUMA system taking the tasklist_lock may
cause a bouncing cacheline if multiple independent processes
continually call sys_times to measure their performance.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/kernel/sys.c
===================================================================
--- linux-2.6.11.orig/kernel/sys.c	2005-05-17 15:21:50.000000000 -0700
+++ linux-2.6.11/kernel/sys.c	2005-05-17 17:00:42.000000000 -0700
@@ -894,35 +894,69 @@ asmlinkage long sys_times(struct tms __u
 	 */
 	if (tbuf) {
 		struct tms tmp;
-		struct task_struct *tsk = current;
-		struct task_struct *t;
 		cputime_t utime, stime, cutime, cstime;
 
-		read_lock(&tasklist_lock);
-		utime = tsk->signal->utime;
-		stime = tsk->signal->stime;
-		t = tsk;
-		do {
-			utime = cputime_add(utime, t->utime);
-			stime = cputime_add(stime, t->stime);
-			t = next_thread(t);
-		} while (t != tsk);
-
-		/*
-		 * While we have tasklist_lock read-locked, no dying thread
-		 * can be updating current->signal->[us]time.  Instead,
-		 * we got their counts included in the live thread loop.
-		 * However, another thread can come in right now and
-		 * do a wait call that updates current->signal->c[us]time.
-		 * To make sure we always see that pair updated atomically,
-		 * we take the siglock around fetching them.
-		 */
-		spin_lock_irq(&tsk->sighand->siglock);
-		cutime = tsk->signal->cutime;
-		cstime = tsk->signal->cstime;
-		spin_unlock_irq(&tsk->sighand->siglock);
-		read_unlock(&tasklist_lock);
+#ifdef CONFIG_SMP
+		if (current == next_thread(current)) {
+			/*
+			 * Single thread case without the use of any locks.
+			 *
+			 * We may race with release_task if two threads are
+			 * executing. However, release task first adds up the
+			 * counters (__exit_signal) before  removing the task
+			 * from the process tasklist (__unhash_process).
+			 * __exit_signal also acquires and releases the
+			 * siglock which results in the proper memory ordering
+			 * so that the list modifications are always visible
+			 * after the counters have been updated.
+			 *
+			 * If the counters have been updated by the second thread
+			 * but the thread has not yet been removed from the list
+			 * then the other branch will be executing which will
+			 * block on tasklist_lock until the exit handling of the
+			 * other task is finished.
+			 *
+			 * This also implies that the sighand->siglock cannot
+			 * be held by another processor. So we can also
+			 * skip acquiring that lock.
+			 */
+			utime = cputime_add(current->signal->utime, current->utime);
+			stime = cputime_add(current->signal->utime, current->stime);
+			cutime = current->signal->cutime;
+			cstime = current->signal->cstime;
+		} else
+#endif
+		{
 
+			/* Process with multiple threads */
+			struct task_struct *tsk = current;
+			struct task_struct *t;
+
+			read_lock(&tasklist_lock);
+			utime = tsk->signal->utime;
+			stime = tsk->signal->stime;
+			t = tsk;
+			do {
+				utime = cputime_add(utime, t->utime);
+				stime = cputime_add(stime, t->stime);
+				t = next_thread(t);
+			} while (t != tsk);
+
+			/*
+			 * While we have tasklist_lock read-locked, no dying thread
+			 * can be updating current->signal->[us]time.  Instead,
+			 * we got their counts included in the live thread loop.
+			 * However, another thread can come in right now and
+			 * do a wait call that updates current->signal->c[us]time.
+			 * To make sure we always see that pair updated atomically,
+			 * we take the siglock around fetching them.
+			 */
+			spin_lock_irq(&tsk->sighand->siglock);
+			cutime = tsk->signal->cutime;
+			cstime = tsk->signal->cstime;
+			spin_unlock_irq(&tsk->sighand->siglock);
+			read_unlock(&tasklist_lock);
+		}
 		tmp.tms_utime = cputime_to_clock_t(utime);
 		tmp.tms_stime = cputime_to_clock_t(stime);
 		tmp.tms_cutime = cputime_to_clock_t(cutime);
