Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279579AbRJXTQm>; Wed, 24 Oct 2001 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279577AbRJXTQe>; Wed, 24 Oct 2001 15:16:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14734 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S279576AbRJXTQ2>;
	Wed, 24 Oct 2001 15:16:28 -0400
Date: Wed, 24 Oct 2001 14:16:55 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Separate CLONE_PARENT and CLONE_THREAD behavior
Message-ID: <117830000.1003951015@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Several versions back you added code that forces CLONE_PARENT behavior
whenever CLONE_THREAD is specified.  This unnecesarily forces a particular
multi-threading model at the application level, and in fact breaks some
ways of doing multi-threading.

In particular, it requires that at least one task in an application *not*
be part of the thread group, and that the pid returned by the original
fork() can not be the thread group id itself.

It would still be entirely possible to code an application or threading
library in the way you envision by specifying CLONE_PARENT and CLONE_THREAD
together.  However, there's no good reason for forcing this model.

A patch to remove that restriction is below.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

----------

--- linux-2.4.13/kernel/fork.c	Tue Oct 23 19:44:15 2001
+++ linux-2.4.13-signal/kernel/fork.c	Wed Oct 24 11:46:09 2001
@@ -700,10 +721,10 @@
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 
-	/* CLONE_PARENT and CLONE_THREAD re-use the old parent */
+	/* CLONE_PARENT re-uses the old parent */
 	p->p_opptr = current->p_opptr;
 	p->p_pptr = current->p_pptr;
-	if (!(clone_flags & (CLONE_PARENT | CLONE_THREAD))) {
+	if (!(clone_flags & CLONE_PARENT)) {
 		p->p_opptr = current;
 		if (!(p->ptrace & PT_PTRACED))
 			p->p_pptr = current;

