Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUIJR0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUIJR0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIJRZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:25:42 -0400
Received: from [12.177.129.25] ([12.177.129.25]:24259 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267557AbUIJRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:24:50 -0400
Message-Id: <200409101828.i8AISD0O003428@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - fix scheduler race
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Sep 2004 14:28:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a use-after-free bug in the context switching.  A process going
out of context after exiting wakes up the next process and then kills
itself.  The problem is that when it gets around to killing itself is up to
the host and can happen a long time later, including after the incoming
process has freed its stack, and that memory is possibly being used for
something else.
The fix is to have the incoming process kill the exiting process just to
make sure it can't be running at the point that its stack is freed.

				Jeff

Index: um/arch/um/kernel/tt/process_kern.c
===================================================================
--- um.orig/arch/um/kernel/tt/process_kern.c	2004-09-09 19:31:38.000000000 -0400
+++ um/arch/um/kernel/tt/process_kern.c	2004-09-09 20:06:35.000000000 -0400
@@ -28,7 +28,7 @@
 
 void *switch_to_tt(void *prev, void *next, void *last)
 {
-	struct task_struct *from, *to;
+	struct task_struct *from, *to, *prev_sched;
 	unsigned long flags;
 	int err, vtalrm, alrm, prof, cpu;
 	char c;
@@ -72,6 +72,18 @@
 	if(err != sizeof(c))
 		panic("read of switch_pipe failed, errno = %d", -err);
 
+	/* If the process that we have just scheduled away from has exited,
+	 * then it needs to be killed here.  The reason is that, even though
+	 * it will kill itself when it next runs, that may be too late.  Its
+	 * stack will be freed, possibly before then, and if that happens,
+	 * we have a use-after-free situation.  So, it gets killed here
+	 * in case it has not already killed itself.
+	 */
+	prev_sched = current->thread.prev_sched;
+	if((prev_sched->state == TASK_ZOMBIE) || 
+	   (prev_sched->state == TASK_DEAD))
+		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
+
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
 	 * runs before the outgoing process reaches the read, and it makes

