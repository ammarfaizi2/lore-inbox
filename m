Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVCGSPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVCGSPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVCGSMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:12:24 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:3077 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261212AbVCGSIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:08:39 -0500
Message-Id: <200503072038.j27Kcnbc004003@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 13/16] UML - Remove mm_indirect reference in modify_ldt
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted by Al Viro, there was some bogosity in the UML/x86_64 modify_ltd.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/syscalls.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/syscalls.c	2005-03-05 12:21:27.000000000 -0500
@@ -36,15 +36,11 @@
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-extern int userspace_pid;
-
-#ifndef __NR_mm_indirect
-#define __NR_mm_indirect 241
-#endif
+extern int userspace_pid[];
 
 long sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
 {
-	unsigned long args[6];
+	struct ptrace_ldt ldt;
         void *buf;
         int res, n;
 
@@ -66,12 +62,11 @@
                 goto out;
         }
 
-	args[0] = func;
-	args[1] = (unsigned long) buf;
-	args[2] = bytecount;
-	res = syscall(__NR_mm_indirect, &current->mm->context.u,
-		      __NR_modify_ldt, args);
-
+	ldt = ((struct ptrace_ldt) { .func	= func,
+				     .ptr	= buf,
+				     .bytecount = bytecount });
+#warning Need to look up userspace_pid by cpu
+	res = ptrace(PTRACE_LDT, userspace_pid[0], 0, (unsigned long) &ldt);
         if(res < 0)
                 goto out;
 

