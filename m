Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSIOM0F>; Sun, 15 Sep 2002 08:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSIOM0F>; Sun, 15 Sep 2002 08:26:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56961 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318028AbSIOM0E>;
	Sun, 15 Sep 2002 08:26:04 -0400
Date: Sun, 15 Sep 2002 14:37:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] wait4-fix-2.5.34-B2, BK-curr
Message-ID: <Pine.LNX.4.44.0209151433380.2604-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (ontop of the previous exit.c patch) fixes a number of
bugs that broke ptrace:

 - wait4 must not inhibit TASK_STOPPED processes even for thread group
   leaders.

 - do_notify_parent() should not delay the notification of parents if
   the thread in question is ptraced.

strace now works as expected for CLONE_THREAD applications as well.

	Ingo

--- linux/kernel/signal.c.orig	Sun Sep 15 14:24:21 2002
+++ linux/kernel/signal.c	Sun Sep 15 14:36:43 2002
@@ -1105,7 +1105,7 @@
 	struct siginfo info;
 	int why, status;
 
-	if (delay_group_leader(tsk))
+	if (!tsk->ptrace && delay_group_leader(tsk))
 		return;
 	if (sig == -1)
 		BUG();
--- linux/kernel/exit.c.orig	Sun Sep 15 14:10:07 2002
+++ linux/kernel/exit.c	Sun Sep 15 14:10:38 2002
@@ -770,11 +770,6 @@
 			if (!ret)
 				continue;
 			flag = 1;
-			/*
-			 * Eligible but we cannot release it yet:
-			 */
-			if (ret == 2)
-				continue;
 
 			switch (p->state) {
 			case TASK_STOPPED:
@@ -798,6 +793,11 @@
 				}
 				goto end_wait4;
 			case TASK_ZOMBIE:
+				/*
+				 * Eligible but we cannot release it yet:
+				 */
+				if (ret == 2)
+					continue;
 				read_unlock(&tasklist_lock);
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 				if (!retval && stat_addr) {

