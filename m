Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSIOOTa>; Sun, 15 Sep 2002 10:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSIOOTa>; Sun, 15 Sep 2002 10:19:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10656 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318058AbSIOOT3>;
	Sun, 15 Sep 2002 10:19:29 -0400
Date: Sun, 15 Sep 2002 16:30:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] exit-fix-2.5.34-C0, BK-curr
Message-ID: <Pine.LNX.4.44.0209151624080.4707-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (ontop of the previous exit.c patches), fixes one more
exit-time resource accounting issue - and it's also a speedup and a
thread-tree (to-be thread-aware pstree) visual improvement.

in the current code we reparent detached threads to the init thread. This
worked but was not very nice in ps output: threads showed up as being
related to init. There was also a resource-accounting issue, upon exit
they update their parent's (ie. init's) rusage fields - effectively losing
these statistics. Eg. 'time' under-reports CPU usage if the threaded app
is Ctrl-C-ed prematurely.

the solution is to reparent threads to the group leader - this is now very
easy since we have p->group_leader cached and it's also valid all the
time. It's also somewhat faster for applications that use CLONE_THREAD but
do not use the CLONE_DETACHED feature.

	Ingo

--- linux/kernel/exit.c.orig	Sun Sep 15 15:01:48 2002
+++ linux/kernel/exit.c	Sun Sep 15 16:23:49 2002
@@ -447,11 +447,7 @@
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p;
 
-	if (father->exit_signal != -1)
-		reaper = prev_thread(reaper);
-	else
-		reaper = child_reaper;
-
+	reaper = father->group_leader;
 	if (reaper == father)
 		reaper = child_reaper;
 

