Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbTBFWfA>; Thu, 6 Feb 2003 17:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbTBFWeK>; Thu, 6 Feb 2003 17:34:10 -0500
Received: from crack.them.org ([65.125.64.184]:15082 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267674AbTBFWds>;
	Thu, 6 Feb 2003 17:33:48 -0500
Date: Thu, 6 Feb 2003 17:43:24 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Ptrace updates: Prevent zombies when debugging LinuxThreads apps [5/5]
Message-ID: <20030206224324.GE22762@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030206223924.GA22688@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206223924.GA22688@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pretty old patch; the first version of it that I saw came from
Mark Kettenis about two and a half years ago, and Alan said he'd look at it
for the next 2.2 kernel at the time.  It got lost somewhere along the line.

The problem is that we check current->parent->self_exec_domain in
exit_notify, where we should be checking current->real_parent instead. 
Then, when that's fixed, we hardcode a SIGCHLD in sys_wait4 where we should
be using p->exit_signal.

Without both fixes, when debugging a LinuxThreads application, the manager
thread receives SIGCHLDs instead of SIGRTMIN+1's every time a thread exits;
and it never reaps them, so they stick around as zombies until the whole
process exits and init gets a chance to reap them.

# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/06	drow@nevyn.them.org	1.961
# Signal handling bugs for thread exit + ptrace
# --------------------------------------------

diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Thu Feb  6 16:57:26 2003
+++ b/kernel/exit.c	Thu Feb  6 16:57:26 2003
@@ -586,7 +586,7 @@
 	 * is about to become orphaned.
 	 */
 	 
-	t = current->parent;
+	t = current->real_parent;
 	
 	if ((t->pgrp != current->pgrp) &&
 	    (t->session == current->session) &&
@@ -619,8 +619,16 @@
 		current->exit_signal = SIGCHLD;
 
 
-	if (current->exit_signal != -1)
-		do_notify_parent(current, current->exit_signal);
+	/* If something other than our normal parent is ptracing us, then
+	 * send it a SIGCHLD instead of honoring exit_signal.  exit_signal
+	 * only has special meaning to our real parent.
+	 */
+	if (current->exit_signal != -1) {
+		if (current->parent == current->real_parent)
+			do_notify_parent(current, current->exit_signal);
+		else
+			do_notify_parent(current, SIGCHLD);
+	}
 
 	current->state = TASK_ZOMBIE;
 	/*
@@ -877,7 +885,7 @@
 				if (p->real_parent != p->parent) {
 					write_lock_irq(&tasklist_lock);
 					__ptrace_unlink(p);
-					do_notify_parent(p, SIGCHLD);
+					do_notify_parent(p, p->exit_signal);
 					p->state = TASK_ZOMBIE;
 					write_unlock_irq(&tasklist_lock);
 				} else

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
