Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUIXXM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUIXXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUIXXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:12:26 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:57985 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S269043AbUIXXMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:12:23 -0400
Date: Fri, 24 Sep 2004 16:12:19 -0700
Message-Id: <200409242312.i8ONCJ6w004680@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix PTRACE_ATTACH race with real parent's wait calls
X-Fcc: ~/Mail/linus
X-Windows: a terminal disease.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between PTRACE_ATTACH and the real parent calling wait.
For a moment, the task is put in PT_PTRACED but with its parent still
pointing to its real_parent.  In this circumstance, if the real parent
calls wait without the WUNTRACED flag, he can see a stopped child status,
which wait should never return without WUNTRACED when the caller is not
using ptrace.  Here it is not the caller that is using ptrace, but some
third party.

This patch avoids this race condition by only setting PT_PTRACED while
holding the tasklist_lock.

ptrace_attach used task_lock for this, and a comment in sched.h says that
it covers ->ptrace.  But in fact, no other users of ->ptrace use task_lock
for synchronization.  The places that clear ->ptrace all do so while
holding tasklist_lock for write.  That seems appropriate to me, as there
are encoded assumptions that ->ptrace and the parent links get updated
atomically.  Using tasklist_lock here makes the assumptions in the wait
code work right, so that the race window I described above can't happen.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

Index: 2.6/kernel/ptrace.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/ptrace.c,v
retrieving revision 1.36
diff -B -b -p -u -r1.36 ptrace.c
--- 2.6/kernel/ptrace.c 23 Sep 2004 23:35:16 -0000 1.36
+++ 2.6/kernel/ptrace.c 24 Sep 2004 22:46:40 -0000
@@ -129,14 +129,22 @@ int ptrace_attach(struct task_struct *ta
 	retval = security_ptrace(current, task);
 	if (retval)
 		goto bad;
+	task_unlock(task);
+
+	retval = capable(CAP_SYS_PTRACE); /* Hold no locks while calling.  */
+
+	write_lock_irq(&tasklist_lock);
+
+	/* Re-check with tasklist_lock held. */
+	if (unlikely(task->ptrace & PT_PTRACED)) {
+		write_unlock_irq(&tasklist_lock);
+		return -EPERM;
+	}
 
 	/* Go */
 	task->ptrace |= PT_PTRACED;
-	if (capable(CAP_SYS_PTRACE))
+	if (retval)
 		task->ptrace |= PT_PTRACE_CAP;
-	task_unlock(task);
-
-	write_lock_irq(&tasklist_lock);
 	__ptrace_link(task, current);
 	write_unlock_irq(&tasklist_lock);
 


