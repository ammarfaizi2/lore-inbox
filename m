Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbTF3D3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 23:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbTF3D3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 23:29:23 -0400
Received: from crack.them.org ([146.82.138.56]:36800 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S265659AbTF3D3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 23:29:19 -0400
Date: Sun, 29 Jun 2003 23:43:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PTRACE PATCH] Report detached thread exit to the debugger
Message-ID: <20030630034333.GA22830@nevyn.them.org>
Mail-Followup-To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, CLONE_DETACHED threads silently vanish from GDB's sight when
they exit.  This patch lets the thread report its exit to the debugger,
and then be auto-reaped as soon as it is collected, instead of being
reaped as soon as it exits and not reported at all.

GDB works either way, but this is more correct and will be useful for some
later GDB patches.

Please apply - thanks!

diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Sat Jun 21 21:50:35 2003
+++ b/kernel/exit.c	Sat Jun 21 21:50:35 2003
@@ -651,6 +651,8 @@
 	if (tsk->exit_signal != -1) {
 		int signal = tsk->parent == tsk->real_parent ? tsk->exit_signal : SIGCHLD;
 		do_notify_parent(tsk, signal);
+	} else if (tsk->ptrace) {
+		do_notify_parent(tsk, SIGCHLD);
 	}
 
 	tsk->state = TASK_ZOMBIE;
@@ -715,7 +717,7 @@
 	tsk->exit_code = code;
 	exit_notify(tsk);
 
-	if (tsk->exit_signal == -1)
+	if (tsk->exit_signal == -1 && tsk->ptrace == 0)
 		release_task(tsk);
 
 	schedule();
@@ -859,7 +861,7 @@
 		BUG_ON(state != TASK_DEAD);
 		return 0;
 	}
-	if (unlikely(p->exit_signal == -1))
+	if (unlikely(p->exit_signal == -1 && p->ptrace == 0))
 		/*
 		 * This can only happen in a race with a ptraced thread
 		 * dying on another processor.
@@ -889,8 +891,12 @@
 		/* Double-check with lock held.  */
 		if (p->real_parent != p->parent) {
 			__ptrace_unlink(p);
-			do_notify_parent(p, p->exit_signal);
 			p->state = TASK_ZOMBIE;
+			/* If this is a detached thread, this is where it goes away.  */
+			if (p->exit_signal == -1)
+				release_task (p);
+			else
+				do_notify_parent(p, p->exit_signal);
 			p = NULL;
 		}
 		write_unlock_irq(&tasklist_lock);

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
