Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267546AbUHRTa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267546AbUHRTa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUHRTa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:30:26 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:24712 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S267546AbUHRTaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:30:21 -0400
Date: Wed, 18 Aug 2004 12:30:15 -0700
Message-Id: <200408181930.i7IJUF9g020402@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix MT reparenting when thread group leader dies
X-fcc: ~/Mail/linus
X-zippy-says: You can't hurt me!!  I have an ASSUMABLE MORTGAGE!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the initial thread in a multi-threaded program dies (the thread group
leader), its child processes are wrongly orphaned, and thereafter when
other threads die their child processes are also orphaned even though live
threads remain in the parent process that can call wait.  I have a small
(under 100 lines), POSIX-compliant test program that demonstrates this
using -lpthread (NPTL) if anyone is interested in seeing it.

The bug is that forget_original_parent moves children to the dead parent's
group leader if it's alive, but if not it orphans them.  I've changed it so
it instead reparents children to any other live thread in the dead parent's
group (not even preferring the group leader).  Children go to init only if
there are no live threads in the parent's group at all.  These are the
correct semantics for fork children of POSIX threads.  

The second part of the change is to do the CLONE_PARENT behavior always for
CLONE_THREAD, i.e. make sure that each new thread's parent link points to
the real parent of the process and never another thread in its own group.
Without this, when the group leader dies leaving a sole live thread in the
group, forget_original_parent will try to reparent that thread to itself
because it's a child of the dying group leader.  Rather handling this case
specially to reparent to the group leader's parent instead, it's more
efficient just to make sure that noone ever has a parent link to inside his
own thread group.  Now the reparenting work never needs to be done for
threads created in the same group when their creator thread dies.  The only
change from losing the who-created-whom information is when you look at
"PPid:" in /proc/PID/task/TID/status.  For purposes of all direct system
calls, it was already as if CLONE_THREAD threads had the parent of the
group leader.  (POSIX provides no way to keep track of which thread created
which other thread with pthread_create.)


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6.8.1-waitid/kernel/exit.c	2004-08-16 04:24:36.000000000 -0700
+++ linux-2.6/kernel/exit.c	2004-08-18 04:51:42.000000000 -0700
@@ -529,10 +523,8 @@ static inline void choose_new_parent(tas
 	 * Make sure we're not reparenting to ourselves and that
 	 * the parent is not a zombie.
 	 */
-	if (p == reaper || reaper->state >= TASK_ZOMBIE)
-		p->real_parent = child_reaper;
-	else
-		p->real_parent = reaper;
+	BUG_ON(p == reaper || reaper->state >= TASK_ZOMBIE);
+	p->real_parent = reaper;
 	if (p->parent == p->real_parent)
 		BUG();
 }
@@ -600,9 +592,13 @@ static inline void forget_original_paren
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p, *_n;
 
-	reaper = father->group_leader;
-	if (reaper == father)
-		reaper = child_reaper;
+	do {
+		reaper = next_thread(reaper);
+		if (reaper == father) {
+			reaper = child_reaper;
+			break;
+		}
+	} while (reaper->state >= TASK_ZOMBIE);
 
 	/*
 	 * There are only two places where our children can be:
--- linux-2.6.8.1-waitid/kernel/fork.c	2004-07-28 23:14:26.000000000 -0700
+++ linux-2.6/kernel/fork.c	2004-08-18 04:49:29.000000000 -0700
@@ -1043,7 +1045,7 @@ struct task_struct *copy_process(unsigne
 	}
 
 	/* CLONE_PARENT re-uses the old parent */
-	if (clone_flags & CLONE_PARENT)
+	if (clone_flags & (CLONE_PARENT|CLONE_THREAD))
 		p->real_parent = current->real_parent;
 	else
 		p->real_parent = current;
