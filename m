Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbSI2J0n>; Sun, 29 Sep 2002 05:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262429AbSI2J0n>; Sun, 29 Sep 2002 05:26:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20461 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262428AbSI2J0m>;
	Sun, 29 Sep 2002 05:26:42 -0400
Date: Sun, 29 Sep 2002 11:41:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Mosberger <davidm@napali.hpl.hp.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] sigfix-2.5.39-A1
Message-ID: <Pine.LNX.4.44.0209291139280.15032-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the bug reported by David Mosberger,
force_sig_info() dropped the siginfo structure, which broke things like
SIGFPU or alignment-error exceptions.  This bug was introduced by the
threading signal changes. (The patch also fixes signal declaration
whitespaces in sched.h.)

	Ingo

--- linux/include/linux/sched.h.orig	Sun Sep 29 11:25:06 2002
+++ linux/include/linux/sched.h	Sun Sep 29 11:27:58 2002
@@ -226,15 +226,15 @@
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
 
-        /* current thread group signal load-balancing target: */
-        task_t                  *curr_target;
+	/* current thread group signal load-balancing target: */
+	task_t			*curr_target;
 
+	/* shared signal handling: */
 	struct sigpending	shared_pending;
 
 	/* thread group exit support */
 	int			group_exit;
 	int			group_exit_code;
-
 	struct task_struct	*group_exit_task;
 };
 
--- linux/kernel/signal.c.orig	Sun Sep 29 11:28:25 2002
+++ linux/kernel/signal.c	Sun Sep 29 11:31:53 2002
@@ -781,7 +781,7 @@
 	recalc_sigpending_tsk(t);
 	spin_unlock_irqrestore(&t->sigmask_lock, flags);
 
-	return send_sig_info(sig, (void *)1, t);
+	return send_sig_info(sig, info, t);
 }
 
 static int

