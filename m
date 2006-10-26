Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWJZBmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWJZBmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 21:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWJZBmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 21:42:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965265AbWJZBmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 21:42:13 -0400
Message-Id: <200610260141.k9Q1fgUW026204@pasta.boston.redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: Roland McGrath <roland@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix for zeroed user-space tids in multi-threaded core dumps
Date: Wed, 25 Oct 2006 21:41:42 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.  Please consider the patch below for the next open 2.6 release.

The NPTL library uses the CLONE_CHILD_CLEARTID flag on clone() syscalls
on behalf of pthread_create() library calls.  This feature is used to
request that the kernel clear the thread-id in user space (at an address
provided in the syscall) when the thread disassociates itself from the
address space, which is done in mm_release().

Unfortunately, when a multi-threaded process incurs a core dump (such as
from a SIGSEGV), the core-dumping thread sends SIGKILL signals to all of
the other threads, which then proceed to clear their user-space tids
before synchronizing in exit_mm() with the start of core dumping.  This
misrepresents the state of process's address space at the time of the
SIGSEGV and makes it more difficult for someone to debug NPTL and glibc
problems (misleading him/her to conclude that the threads had gone away
before the fault).

The fix below is to simply avoid the CLONE_CHILD_CLEARTID action if a
core dump has been initiated.

Cheers.  -ernie



--- linux-2.6.18/kernel/fork.c.orig
+++ linux-2.6.18/kernel/fork.c
@@ -439,7 +439,9 @@ void mm_release(struct task_struct *tsk,
 		tsk->vfork_done = NULL;
 		complete(vfork_done);
 	}
-	if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
+	if (tsk->clear_child_tid &&
+	    mm->core_waiters == 0 &&
+	    atomic_read(&mm->mm_users) > 1) {
 		u32 __user * tidptr = tsk->clear_child_tid;
 		tsk->clear_child_tid = NULL;
 
