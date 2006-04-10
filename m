Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWDKAiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWDKAiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDKAiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:38:55 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:13028 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932214AbWDKAiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:38:54 -0400
Message-Id: <200604102340.k3ANe2TW006880@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "S A" <sagarwal10@hotmail.com>
Subject: [PATCH 4/3] UML - Add missing __volatile__
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Apr 2006 19:40:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were missing __volatile__ on some bits of asm in the segfault
handlers.  On x86_64, this was messing up the move from %rdx to uc
because that was moved to after the GET_FAULTINFO_FROM_SC, which
changed %rdx.

Also changed the other bit of asm and the one in the i386 handler to
prevent any similar occurrences.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-x86_64/stub_segv.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-x86_64/stub_segv.c	2006-04-10 19:56:10.000000000 -0400
@@ -33,7 +33,7 @@ stub_segv_handler(int sig)
 	struct ucontext *uc;
         int pid;
 
-	__asm__("movq %%rdx, %0" : "=g" (uc) :);
+	__asm__ __volatile__("movq %%rdx, %0" : "=g" (uc) :);
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      &uc->uc_mcontext);
 
@@ -44,8 +44,8 @@ stub_segv_handler(int sig)
 	 * the signal frame.  So, we use the ucontext pointer, which we know
 	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("movq %0, %%rsp; movq %1, %%rax ; syscall": :
-		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
-						  uc) + 8),
-                "g" (__NR_rt_sigreturn));
+	__asm__ __volatile__("movq %0, %%rsp; movq %1, %%rax ; syscall": :
+                             "g" ((unsigned long)
+                                  container_of(uc, struct rt_sigframe, uc) + 8),
+                             "g" (__NR_rt_sigreturn));
 }
Index: linux-2.6.16-mm/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/stub_segv.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/stub_segv.c	2006-04-10 19:55:53.000000000 -0400
@@ -27,6 +27,6 @@ stub_segv_handler(int sig)
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
-		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
+	__asm__ __volatile__("mov %0,%%esp ; movl %1, %%eax ; "
+			     "int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
 }

