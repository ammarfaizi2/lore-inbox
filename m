Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbUD2BeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUD2BeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUD2BeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:34:10 -0400
Received: from ozlabs.org ([203.10.76.45]:32959 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262866AbUD2Bbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:31:32 -0400
Date: Thu, 29 Apr 2004 11:27:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Fix overeager stack-expansion on ppc64
Message-ID: <20040429012755.GA6053@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

This fix is from Paul Mackerras and was applied in 2.4 sometime late
last year.

On ppc64, touching addresses between the highest other mapping and the
stack can cause the stack to be extended way, way down, rather than
causing a SEGV as you would expect.  This patch only allows the stack
mapping to be extended to cover addresses actually within the stack
(as determined by looking at the process's r1).  This fix is ported
from 2.4

This fixes failures on the LTP's shmdt01, munmap01 and munmap02 tests.


diff -urN ppc64-linux-2.5/arch/ppc64/mm/fault.c ppc64-2.5-pseries/arch/ppc64/mm/fault.c
--- ppc64-linux-2.5/arch/ppc64/mm/fault.c	2004-04-13 14:06:33.000000000 +1000
+++ ppc64-2.5-pseries/arch/ppc64/mm/fault.c	2004-04-27 13:31:43.000000000 +1000
@@ -38,6 +38,44 @@
 #include <asm/uaccess.h>
 
 /*
+ * Check whether the instruction at regs->nip is a store using
+ * an update addressing form which will update r1.
+ */
+static int store_updates_sp(struct pt_regs *regs)
+{
+	unsigned int inst;
+
+	if (get_user(inst, (unsigned int *)regs->nip))
+		return 0;
+	/* check for 1 in the rA field */
+	if (((inst >> 16) & 0x1f) != 1)
+		return 0;
+	/* check major opcode */
+	switch (inst >> 26) {
+	case 37:	/* stwu */
+	case 39:	/* stbu */
+	case 45:	/* sthu */
+	case 53:	/* stfsu */
+	case 55:	/* stfdu */
+		return 1;
+	case 62:	/* std or stdu */
+		return (inst & 3) == 1;
+	case 31:
+		/* check minor opcode */
+		switch ((inst >> 1) & 0x3ff) {
+		case 181:	/* stdux */
+		case 183:	/* stwux */
+		case 247:	/* stbux */
+		case 439:	/* sthux */
+		case 695:	/* stfsux */
+		case 759:	/* stfdux */
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
  * The error_code parameter is
  *  - DSISR for a non-SLB data access fault,
  *  - SRR1 & 0x08000000 for a non-SLB instruction access fault
@@ -82,6 +120,39 @@
 	}
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
+
+	/*
+	 * N.B. The POWER/Open ABI allows programs to access up to
+	 * 288 bytes below the stack pointer.
+	 * The kernel signal delivery code writes up to about 1.5kB
+	 * below the stack pointer (r1) before decrementing it.
+	 * The exec code can write slightly over 640kB to the stack
+	 * before setting the user r1.  Thus we allow the stack to
+	 * expand to 1MB without further checks.
+	 */
+	if (address + 0x100000 < vma->vm_end) {
+		/* get user regs even if this fault is in kernel mode */
+		struct pt_regs *uregs = current->thread.regs;
+		if (uregs == NULL)
+			goto bad_area;
+
+		/*
+		 * A user-mode access to an address a long way below
+		 * the stack pointer is only valid if the instruction
+		 * is one which would update the stack pointer to the
+		 * address accessed if the instruction completed,
+		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
+		 * (or the byte, halfword, float or double forms).
+		 *
+		 * If we don't check this then any write to the area
+		 * between the last mapped region and the stack will
+		 * expand the stack rather than segfaulting.
+		 */
+		if (address + 2048 < uregs->gpr[1]
+		    && (!user_mode(regs) || !store_updates_sp(regs)))
+			goto bad_area;
+	}
+
 	if (expand_stack(vma, address))
 		goto bad_area;
 


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
