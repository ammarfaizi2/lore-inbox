Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTLNWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 17:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTLNWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 17:10:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:47582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262705AbTLNWK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 17:10:56 -0500
Date: Sun, 14 Dec 2003 14:10:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312142205050.13533@earth>
Message-ID: <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312142205050.13533@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo,

I'm being anal for 2.6.0 again and trying to think of all the
ramifications of the changes, and I found a serious bug in your patch:

Even though the parent ignores SIGCHLD it _can_ be running on another CPU
in "wait4()". And since we drop the tasklist lock before we do the
"release_task()" on the leader, and since the leader is still marked
TASK_ZOMBIE, we may have _two_ different people trying to release it.
First the parent, and then the last thread that still remembers the
leader.

Note that we at this point have not unhashed the thread group leader yet:
we just unhashed the last thread. So we're dropping the task list lock,
and the leader pointer is _not_ safe to keep that way.

We've had that race before, and the fix is to mark the leader TASK_DEAD
while still under the tasklist lock - that way the parent won't see the
soon-to-be-reaped leader even if it were to happen to be in the middle of
a wait4() call and get in while the tasklist lock is released.

So how about this patch? It has this bug fixed, and is otherwise a mix of
your two patches, along with an added sanity check ("the exit_signal for a
thread group leader cannot be -1 until the last thread exited"), which
makes the test make a whole lot more sense in my opinion (the previous
test for "exit_signal != -1" looks nonsensical, and appears to be a
cut-and-paste from somewhere else).

Roland, Petr, comments? Can you see any hole in my logic?

		Linus

----
--- 1.119/kernel/exit.c	Mon Oct 27 11:49:59 2003
+++ edited/kernel/exit.c	Sun Dec 14 14:00:10 2003
@@ -49,9 +49,11 @@

 void release_task(struct task_struct * p)
 {
+	int zap_leader;
 	task_t *leader;
 	struct dentry *proc_dentry;
-
+
+repeat:
 	BUG_ON(p->state < TASK_ZOMBIE);

 	atomic_dec(&p->user->processes);
@@ -70,10 +72,24 @@
 	 * group, and the leader is zombie, then notify the
 	 * group leader's parent process. (if it wants notification.)
 	 */
+	zap_leader = 0;
 	leader = p->group_leader;
-	if (leader != p && thread_group_empty(leader) &&
-		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1)
+	if (leader != p && thread_group_empty(leader) && leader->state == TASK_ZOMBIE) {
+		BUG_ON(leader->exit_signal == -1);
 		do_notify_parent(leader, leader->exit_signal);
+		/*
+		 * If we were the last child thread and the leader has
+		 * exited already, and the leader's parent ignores SIGCHLD,
+		 * then we are the one who should release the leader.
+		 *
+		 * do_notify_parent() will have marked it self-reaping in
+		 * that case.
+		 */
+		if (leader->exit_signal == -1) {
+			zap_leader = 1;
+			leader->state = TASK_DEAD;
+		}
+	}

 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
@@ -88,6 +104,10 @@
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
 	put_task_struct(p);
+
+	p = leader;
+	if (zap_leader)
+		goto repeat;
 }

 /* we are using it only for SMP init */
