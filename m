Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289413AbSA1UlQ>; Mon, 28 Jan 2002 15:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289462AbSA1UlH>; Mon, 28 Jan 2002 15:41:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:56793 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289413AbSA1Uk5>; Mon, 28 Jan 2002 15:40:57 -0500
Date: Mon, 28 Jan 2002 14:40:55 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix unnecessary tying of CLONE_THREAD and CLONE_PARENT
Message-ID: <90500000.1012250455@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Code was added in about 2.4.7 that forced CLONE_PARENT behavior whenever
CLONE_THREAD was specified.  This was to work around a bug in exit that has
since been fixed.  It's unnecessary to force this behavior, and in fact
breaks some thread programming models.  Anyone who wants it can still
specify the flags separately.

Here's the patch to put it back the way it should be.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--------

--- linux-2.4.17/./kernel/fork.c	Wed Nov 21 12:18:42 2001
+++ linux-2.4.17-clone/./kernel/fork.c	Mon Jan 28 14:32:48 2002
@@ -700,10 +700,10 @@
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

