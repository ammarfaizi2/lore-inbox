Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263007AbSJBJSy>; Wed, 2 Oct 2002 05:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263019AbSJBJSy>; Wed, 2 Oct 2002 05:18:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11171 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263007AbSJBJSw>;
	Wed, 2 Oct 2002 05:18:52 -0400
Date: Wed, 2 Oct 2002 11:31:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sigfix-2.5.40-A0
Message-ID: <Pine.LNX.4.44.0210021129290.6714-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes yet another thread signal
detail, reported by Axel Zeuner (and also reproduced in Ulrich's thread
signal testcases) - sigwaiting threads do count as if they had those
signals unblocked. Fortunately fixing this means the removal of the
real_blocked field from task_struct.

	Ingo

--- linux/include/linux/sched.h.orig	Wed Oct  2 11:22:32 2002
+++ linux/include/linux/sched.h	Wed Oct  2 11:23:28 2002
@@ -378,7 +378,7 @@
 /* signal handlers */
 	struct signal_struct *sig;
 
-	sigset_t blocked, real_blocked, shared_unblocked;
+	sigset_t blocked, shared_unblocked;
 	struct sigpending pending;
 
 	unsigned long sas_ss_sp;
--- linux/kernel/signal.c.orig	Wed Oct  2 11:22:16 2002
+++ linux/kernel/signal.c	Wed Oct  2 11:23:22 2002
@@ -843,8 +843,7 @@
 	struct pid *pid;
 
 	for_each_task_pid(p->tgid, PIDTYPE_TGID, tmp, l, pid)
-		if (!sigismember(&tmp->blocked, signr) &&
-					!sigismember(&tmp->real_blocked, signr))
+		if (!sigismember(&tmp->blocked, signr))
 			return tmp;
 	return NULL;
 }
@@ -1482,7 +1481,8 @@
 			/* None ready -- temporarily unblock those we're
 			 * interested while we are sleeping in so that we'll
 			 * be awakened when they arrive.  */
-			current->real_blocked = current->blocked;
+			sigset_t orig_blocked = current->blocked;
+
 			sigandsets(&current->blocked, &current->blocked, &these);
 			recalc_sigpending();
 			spin_unlock_irq(&current->sig->siglock);
@@ -1494,8 +1494,7 @@
 			sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
 			if (!sig)
 				sig = dequeue_signal(&current->pending, &these, &info);
-			current->blocked = current->real_blocked;
-			siginitset(&current->real_blocked, 0);
+			current->blocked = orig_blocked;
 			recalc_sigpending();
 		}
 	}

