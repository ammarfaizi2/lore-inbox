Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275255AbRIZPTB>; Wed, 26 Sep 2001 11:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275256AbRIZPSv>; Wed, 26 Sep 2001 11:18:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48078 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275255AbRIZPSj>; Wed, 26 Sep 2001 11:18:39 -0400
Date: Wed, 26 Sep 2001 10:18:53 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Issue with change to CLONE_THREAD and CLONE_PARENT
Message-ID: <55630000.1001517533@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As you may or may not be aware, there is a project here at IBM to do a more 
POSIX-compliant pthread library for Linux, called NGPT.  While I am not 
part of the core project, I have been asked to help them with kernel issues.

This library uses thread groups to manage the kernel tasks it creates.  It 
was working all right until you introduced a change to how CLONE_THREAD 
works in 2.4.7 by making CLONE_THREAD imply CLONE_PARENT.  This change has 
some undesirable side effects.

I understand the model you're aiming for, where the task created by the 
original fork() is a monitor task and isn't part of the thread group. 
However this also means that the pid returned to the parent from fork() 
does not match what getpid() returns to the tasks inside the thread group. 
It also means it's no longer possible to use any model other than the one 
you envision.

The original bug reported that this change was intended to fix, where tasks 
can be parented to themselves, is not in fact fixed by this change.  It 
merely masks the problem by making it less likely to happen.  The real bug 
is in forget_original_parent in kernel/exit.c, where it's attempting to 
reparent children of the dying task to another task in the thread group. 
The bug is that it never checks to make sure the task it's reparenting is 
not the new parent.

Given that it's simple and straightforward to specify CLONE_THREAD and 
CLONE_PARENT together to produce the behavior you're looking for, I'm 
requesting that they be decoupled so those of us who don't want that 
behavior can still get it.  I've included a patch below that backs that 
change out and also fixes the problem in forget_original_parent.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

------------

--- linux-2.4.10/kernel/exit.c	Mon Sep 10 15:04:33 2001
+++ linux-2.4.10-tpatch/kernel/exit.c	Wed Sep 26 10:08:16 2001
@@ -170,7 +170,13 @@
 			/* We dont want people slaying init */
 			p->exit_signal = SIGCHLD;
 			p->self_exec_id++;
-			p->p_opptr = reaper;
+
+			/* Make sure we're not reparenting to ourselves */
+			if (p == reaper)
+				p->p_opptr = child_reaper;
+			else
+				p->p_opptr = reaper;
+
 			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
 		}
 	}
--- linux-2.4.10/kernel/fork.c	Mon Sep 17 23:46:04 2001
+++ linux-2.4.10-tpatch/kernel/fork.c	Wed Sep 26 10:04:15 2001
@@ -703,7 +703,7 @@
 	/* CLONE_PARENT and CLONE_THREAD re-use the old parent */
 	p->p_opptr = current->p_opptr;
 	p->p_pptr = current->p_pptr;
-	if (!(clone_flags & (CLONE_PARENT | CLONE_THREAD))) {
+	if (!(clone_flags & CLONE_PARENT)) {
 		p->p_opptr = current;
 		if (!(p->ptrace & PT_PTRACED))
 			p->p_pptr = current;

