Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSIOH2D>; Sun, 15 Sep 2002 03:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSIOH2D>; Sun, 15 Sep 2002 03:28:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26330 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317931AbSIOH2C>;
	Sun, 15 Sep 2002 03:28:02 -0400
Date: Sun, 15 Sep 2002 09:39:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] wait4-fix-2.5.34-A0, BK-curr
Message-ID: <Pine.LNX.4.44.0209150933390.9242-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes a sys_wait4() bug noticed by
Ulrich Drepper. The kernel would not block properly if there are eligible
children delayed due to the new delayed thread-group-leader logic. The
solution is to introduce a new type of 'eligible child' type - and skip
over delayed children but set the wait4 flag nevertheless.

The libpthreads testcase that failed due to it now it works fine.

	Ingo

--- linux/kernel/exit.c.orig	Sun Sep 15 09:29:51 2002
+++ linux/kernel/exit.c	Sun Sep 15 09:26:42 2002
@@ -731,7 +731,7 @@
 	 * in a non-empty thread group:
 	 */
 	if (current->tgid != p->tgid && delay_group_leader(p))
-		return 0;
+		return 2;
 
 	if (security_ops->task_wait(p))
 		return 0;
@@ -757,11 +757,21 @@
 	do {
 		struct task_struct *p;
 		struct list_head *_p;
+		int ret;
+
 		list_for_each(_p,&tsk->children) {
 			p = list_entry(_p,struct task_struct,sibling);
-			if (!eligible_child(pid, options, p))
+
+			ret = eligible_child(pid, options, p);
+			if (!ret)
 				continue;
 			flag = 1;
+			/*
+			 * Eligible but we cannot release it yet:
+			 */
+			if (ret == 2)
+				continue;
+
 			switch (p->state) {
 			case TASK_STOPPED:
 				if (!p->exit_code)

