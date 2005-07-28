Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVG1RM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVG1RM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVG1Qgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:36:55 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:49165 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261210AbVG1Qe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:34:56 -0400
Message-Id: <200507281626.j6SGQicv009476@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 2/7] UML - Fix skas0 stub return
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 12:26:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

It's wrong to pop a fixed number of words from stack before
calling sigreturn, as the number depends on what code is generated
by the compiler for the start of stub_segv_handler().
What we need is esp containing the address of sigcontext. So we
explicitly load that pointer into esp.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/sys-i386/stub_segv.c	2005-07-27 17:22:18.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/sys-i386/stub_segv.c	2005-07-28 10:35:18.000000000 -0400
@@ -21,10 +21,10 @@
 	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
 	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
 		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
-	/* Pop the frame pointer and return address since we need to leave
+	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("popl %%eax ; popl %%eax ; popl %%eax ; movl %0, %%eax ; "
-		"int $0x80" : : "g" (__NR_sigreturn));
+	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
+		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
 }

