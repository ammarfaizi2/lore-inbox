Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVJIU3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVJIU3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVJIU3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:29:20 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:15375 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932227AbVJIU3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:29:20 -0400
Message-Id: <200510092011.j99KBjq6006572@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
Subject: [PATCH] UML - fix x86_64 with !CONFIG_FRAME_POINTER
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Oct 2005 16:11:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a must-fix for 2.6.14.  UML/x86_64 doesn't run when built with 
frame pointers disabled.  There was an implicit frame pointer assumption
in the stub segfault handler.  With frame pointers disabled, UML dies on
handling its first page fault.

The container-of part of this is from Paolo Giarrusso <blaisorblade@yahoo.it>.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14-rc3/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/um/sys-x86_64/stub_segv.c	2005-10-09 15:50:01.000000000 -0400
+++ linux-2.6.14-rc3/arch/um/sys-x86_64/stub_segv.c	2005-10-09 16:00:52.000000000 -0400
@@ -10,6 +10,22 @@
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
+#include <stddef.h>
+
+/* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
+ * in the libc headers anywhere.
+ */
+struct rt_sigframe
+{
+	char *pretcode;
+	struct ucontext uc;
+	struct siginfo info;
+};
+
+/* Copied here from <linux/kernel.h> - we're userspace. */
+#define container_of(ptr, type, member) ({                   \
+	const typeof( ((type *)0)->member ) *__mptr = (ptr); \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
 
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig)
@@ -17,16 +33,19 @@
 	struct ucontext *uc;
 
 	__asm__("movq %%rdx, %0" : "=g" (uc) :);
-        GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
-                              &uc->uc_mcontext);
+	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
+			      &uc->uc_mcontext);
 
-	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));
+	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));	
 	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
-		"syscall": : "g" (__NR_kill), "g" (SIGUSR1));
-	/* Two popqs to restore the stack to the state just before entering
-	 * the handler, one pops the return address, the other pops the frame
-	 * pointer.
+		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) : 
+		"%rdi", "%rax", "%rsi");
+	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
+	 * the signal frame.  So, we use the ucontext pointer, which we know
+	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("popq %%rax ; popq %%rax ; movq %0, %%rax ; syscall" : : "g"
-		(__NR_rt_sigreturn));
+	__asm__("movq %0, %%rsp": : 
+		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
+						  uc) + 8));
+	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
 }

