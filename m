Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbVJ2Weq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVJ2Weq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVJ2Weq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:34:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932705AbVJ2Wep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:34:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix signal->live leak in copy_process()
In-Reply-To: Oleg Nesterov's message of  Saturday, 29 October 2005 19:37:40 +0400 <43639744.94BA6AA4@tv-sign.ru>
X-Shopping-List: (1) Anonymous insurgent fads
   (2) Courageous tampons
   (3) Chromatic riots
Message-Id: <20051029223431.645351809AC@magilla.sf.frob.com>
Date: Sat, 29 Oct 2005 15:34:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks right to me.  exit_signal really could use a comment explaining that
the error path is the only place it gets called, or perhaps it would be
cleaner just to do away with it and have do_fork do that work directly in
its error path (i.e. at bad_fork_cleanup_signal: label).  It's less than
obvious when we have the inc in fork.c, the normal case dec in exit.c, and
the error path dec in signal.c.  The following is the same as Oleg's except
for this cosmetic cleanup.


Thanks,
Roland


---
diff-tree a1955c794d1aa805c09cd1c50022ac115438f1e2 (from f0ec9bce933e45bdf732b7a9b27a43d53f3de247)
tree 87c15be65e9ed71feb40f88661490df1c7f30f8d
parent f0ec9bce933e45bdf732b7a9b27a43d53f3de247
author Roland McGrath <roland@redhat.com> 1130625045 -0700
committer Roland McGrath <roland@magilla.sf.frob.com> 1130625045 -0700

    Fix signal->live leak in copy_process
    
    Oleg Nesterov pointed out that ->signal->live will be incremented and then
    never decremented in certain error paths out of do_fork, leading to leaks
    when cleanup is never done after the last thread in the group dies.
    
    This patch fixes that with a bit of cleanup.  The only caller of
    exit_signal was in this error path.  I've removed that function and moved
    its replacement into fork.c, so the decrement and the increment are done in
    the same source file where it's easier to follow what's going on.
    
    Signed-off-by: Roland McGrath <roland@redhat.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1093,7 +1093,6 @@ extern void flush_thread(void);
 extern void exit_thread(void);
 
 extern void exit_files(struct task_struct *);
-extern void exit_signal(struct task_struct *);
 extern void __exit_signal(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
diff --git a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -844,6 +844,22 @@ static inline int copy_signal(unsigned l
 	return 0;
 }
 
+/*
+ * Called for error cleanup after copy_signal succeeded.
+ */
+static inline void uncopy_signal(struct task_struct *tsk)
+{
+	/*
+	 * This decrement would ordinarily be done by do_exit.
+	 * We know it won't hit zero for a shared signal_struct,
+	 * because the current thread is still live.
+	 */
+	atomic_dec(&tsk->signal->live);
+	write_lock_irq(&tasklist_lock);
+	__exit_signal(tsk);
+	write_unlock_irq(&tasklist_lock);
+}
+
 static inline void copy_flags(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long new_flags = p->flags;
@@ -1167,7 +1183,7 @@ bad_fork_cleanup_mm:
 	if (p->mm)
 		mmput(p->mm);
 bad_fork_cleanup_signal:
-	exit_signal(p);
+	uncopy_signal(p);
 bad_fork_cleanup_sighand:
 	exit_sighand(p);
 bad_fork_cleanup_fs:
diff --git a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -405,13 +405,6 @@ void __exit_signal(struct task_struct *t
 	}
 }
 
-void exit_signal(struct task_struct *tsk)
-{
-	write_lock_irq(&tasklist_lock);
-	__exit_signal(tsk);
-	write_unlock_irq(&tasklist_lock);
-}
-
 /*
  * Flush all handlers for a task.
  */

