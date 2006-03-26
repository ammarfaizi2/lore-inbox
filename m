Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWCYXuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWCYXuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWCYXuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:50:07 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:22939 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750709AbWCYXuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:50:06 -0500
Date: Sun, 26 Mar 2006 06:47:11 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH 2.6.16-mm1] send_sigqueue: simplify and fix the race
Message-ID: <20060326024711.GA9300@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

send_sigqueue() checks PF_EXITING, then locks p->sighand->siglock.
This is unsafe: 'p' can exit in between and set ->sighand = NULL.
The race is theoretical, the window is tiny and irqs are disabled
by the caller, so I don't think we need the fix for -stable tree.

Convert send_sigqueue() to use lock_task_sighand() helper.

Also, delete 'p->flags & PF_EXITING' re-check, it is unneeded and
the comment is wrong.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/signal.c~5_SSQ	2006-03-24 21:24:33.000000000 +0300
+++ MM/kernel/signal.c	2006-03-25 20:18:38.000000000 +0300
@@ -1309,12 +1309,10 @@ void sigqueue_free(struct sigqueue *q)
 	__sigqueue_free(q);
 }
 
-int
-send_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
+int send_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
 {
 	unsigned long flags;
 	int ret = 0;
-	struct sighand_struct *sh;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
 
@@ -1328,48 +1326,17 @@ send_sigqueue(int sig, struct sigqueue *
 	 */
 	rcu_read_lock();
 
-	if (unlikely(p->flags & PF_EXITING)) {
+	if (!likely(lock_task_sighand(p, &flags))) {
 		ret = -1;
 		goto out_err;
 	}
 
-retry:
-	sh = rcu_dereference(p->sighand);
-
-	spin_lock_irqsave(&sh->siglock, flags);
-	if (p->sighand != sh) {
-		/* We raced with exec() in a multithreaded process... */
-		spin_unlock_irqrestore(&sh->siglock, flags);
-		goto retry;
-	}
-
-	/*
-	 * We do the check here again to handle the following scenario:
-	 *
-	 * CPU 0		CPU 1
-	 * send_sigqueue
-	 * check PF_EXITING
-	 * interrupt		exit code running
-	 *			__exit_signal
-	 *			lock sighand->siglock
-	 *			unlock sighand->siglock
-	 * lock sh->siglock
-	 * add(tsk->pending) 	flush_sigqueue(tsk->pending)
-	 *
-	 */
-
-	if (unlikely(p->flags & PF_EXITING)) {
-		ret = -1;
-		goto out;
-	}
-
 	if (unlikely(!list_empty(&q->list))) {
 		/*
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		if (q->info.si_code != SI_TIMER)
-			BUG();
+		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		goto out;
 	}
@@ -1385,7 +1352,7 @@ retry:
 		signal_wake_up(p, sig == SIGKILL);
 
 out:
-	spin_unlock_irqrestore(&sh->siglock, flags);
+	unlock_task_sighand(p, &flags);
 out_err:
 	rcu_read_unlock();
 

