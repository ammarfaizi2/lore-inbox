Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSIZNGM>; Thu, 26 Sep 2002 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSIZNGM>; Thu, 26 Sep 2002 09:06:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40429 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261186AbSIZNGL>;
	Thu, 26 Sep 2002 09:06:11 -0400
Date: Thu, 26 Sep 2002 15:20:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: [patch] exit-fix-2.5.38-F0
Message-ID: <Pine.LNX.4.44.0209261518430.17662-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've attached a patch i got from Andrew - he found a couple of places
where we would enable interrupts while write-holding the tasklist_lock ...  
nasty.

against BK-curr, works as expected.

	Ingo

--- linux/kernel/sched.c.orig	Thu Sep 26 12:48:42 2002
+++ linux/kernel/sched.c	Thu Sep 26 13:00:39 2002
@@ -477,13 +477,15 @@
  */
 void sched_exit(task_t * p)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (p->first_time_slice) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
 			p->parent->time_slice = MAX_TIMESLICE;
 	}
-	local_irq_enable();
+	local_irq_restore(flags);
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
--- linux/kernel/signal.c.orig	Thu Sep 26 12:48:42 2002
+++ linux/kernel/signal.c	Thu Sep 26 13:00:39 2002
@@ -1086,6 +1086,7 @@
  */
 static inline void wake_up_parent(struct task_struct *p)
 {
+	unsigned long flags;
 	struct task_struct *parent = p->parent, *tsk = parent;
 
 	/*
@@ -1095,14 +1096,14 @@
 		wake_up_interruptible(&tsk->wait_chldexit);
 		return;
 	}
-	spin_lock_irq(&parent->sig->siglock);
+	spin_lock_irqsave(&parent->sig->siglock, flags);
 	do {
 		wake_up_interruptible(&tsk->wait_chldexit);
 		tsk = next_thread(tsk);
 		if (tsk->sig != parent->sig)
 			BUG();
 	} while (tsk != parent);
-	spin_unlock_irq(&parent->sig->siglock);
+	spin_unlock_irqrestore(&parent->sig->siglock, flags);
 }
 
 /*

