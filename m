Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSIPPuL>; Mon, 16 Sep 2002 11:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSIPPuL>; Mon, 16 Sep 2002 11:50:11 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:23057 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S262373AbSIPPuJ>;
	Mon, 16 Sep 2002 11:50:09 -0400
Message-ID: <3D86000D.311CAE4F@tv-sign.ru>
Date: Mon, 16 Sep 2002 20:00:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH,TRIVIAL] unused task_struct.shared_unblocked variable.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The task_struct.shared_unblocked variable is unused.

The 'old_state' variable in try_to_wake_up() is unneeded.

The third recheck of rq->nr_running after load_balance()
in schedule() is unneeded. Compiler should optimize it,
but it looks slightly confusing (imho).

2.5.34 introduced this change in force_sig_info()

-	return send_sig_info(sig, info, t);
+	return send_sig_info(sig, (void *)1, t);

I beleive, it is wrong, info can carry useful information
from do_page_fault, traps. And this (info *)1 does not
prevent send_signal() from allocation of siginfo struct.
Ingo, could you please clarify?

Oleg.

--- linux-2.5.35/include/linux/sched.h.orig	Mon Sep 16 18:11:32 2002
+++ linux-2.5.35/include/linux/sched.h	Mon Sep 16 18:12:21 2002
@@ -374,7 +374,7 @@
 	spinlock_t sigmask_lock;	/* Protects signal and blocked */
 	struct signal_struct *sig;
 
-	sigset_t blocked, real_blocked, shared_unblocked;
+	sigset_t blocked, real_blocked;
 	struct sigpending pending;
 
 	unsigned long sas_ss_sp;
--- linux-2.5.35/kernel/sched.c.orig	Mon Sep 16 13:36:59 2002
+++ linux-2.5.35/kernel/sched.c	Mon Sep 16 18:39:11 2002
@@ -401,12 +401,10 @@
 {
 	unsigned long flags;
 	int success = 0;
-	long old_state;
 	runqueue_t *rq;
 
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
-	old_state = p->state;
 	if (!p->array) {
 		/*
 		 * Fast-migrate the task if it's not running or runnable
@@ -420,7 +418,7 @@
 			task_rq_unlock(rq, &flags);
 			goto repeat_lock_task;
 		}
-		if (old_state == TASK_UNINTERRUPTIBLE)
+		if (p->state == TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
 
@@ -977,12 +975,13 @@
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
 		load_balance(rq, 1);
-		if (rq->nr_running)
-			goto pick_next_task;
+		if (!rq->nr_running)
 #endif
-		next = rq->idle;
-		rq->expired_timestamp = 0;
-		goto switch_tasks;
+		{
+			next = rq->idle;
+			rq->expired_timestamp = 0;
+			goto switch_tasks;
+		}
 	}
 
 	array = rq->active;
--- linux-2.5.35/kernel/signal.c.orig	Mon Sep 16 19:31:23 2002
+++ linux-2.5.35/kernel/signal.c	Mon Sep 16 19:32:53 2002
@@ -783,7 +783,7 @@
 	recalc_sigpending_tsk(t);
 	spin_unlock_irqrestore(&t->sigmask_lock, flags);
 
-	return send_sig_info(sig, (void *)1, t);
+	return send_sig_info(sig, info, t);
 }
 
 static int
