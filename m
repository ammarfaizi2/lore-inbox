Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVFLLYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVFLLYU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVFLLXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:23:20 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16101 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261949AbVFLLUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:20:50 -0400
Date: Sun, 12 Jun 2005 13:20:35 +0200 (MEST)
Message-Id: <200506121120.j5CBKZH1019741@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 6/9] gcc4: fix x86_64 sys_iopl() bug
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 sys_iopl() becomes a no-op when compiled with gcc4.
This breaks the X server, causing its PCI probing to fail.

This is caused by a bug. sys_iopl() receives a struct pt_regs as
a formal parameter, and updates it expecting those updates to
remain when it returns. This is incorrect as the calling convention
rules say that a function's formal parameters are initialised
copies that disappear when the function returns.

The fix (backport from 2.6) is to pass the pt_regs by reference.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/x86_64/ia32/ia32entry.S |   11 ++++++++++-
 arch/x86_64/kernel/entry.S   |   11 ++++++++++-
 arch/x86_64/kernel/ioport.c  |    6 +++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff -rupN linux-2.4.31/arch/x86_64/ia32/ia32entry.S linux-2.4.31.gcc4-x86_64-iopl-bug/arch/x86_64/ia32/ia32entry.S
--- linux-2.4.31/arch/x86_64/ia32/ia32entry.S	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.31.gcc4-x86_64-iopl-bug/arch/x86_64/ia32/ia32entry.S	2005-06-12 11:46:56.000000000 +0200
@@ -113,9 +113,18 @@ quiet_ni_syscall:
 	PTREGSCALL stub32_fork, sys32_fork
 	PTREGSCALL stub32_clone, sys32_clone
 	PTREGSCALL stub32_vfork, sys32_vfork
-	PTREGSCALL stub32_iopl, sys_iopl
 	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend
 
+	.macro PTREGSCALL3 label, func, arg
+	.globl \label
+\label:
+	leaq \func(%rip),%rax
+	leaq -ARGOFFSET+8(%rsp),\arg	/* 8 for return address */
+	jmp  ia32_ptregs_common	
+	.endm
+
+	PTREGSCALL3 stub32_iopl, sys_iopl, %rsi
+
 ENTRY(ia32_ptregs_common)
 	popq %r11
 	SAVE_REST
diff -rupN linux-2.4.31/arch/x86_64/kernel/entry.S linux-2.4.31.gcc4-x86_64-iopl-bug/arch/x86_64/kernel/entry.S
--- linux-2.4.31/arch/x86_64/kernel/entry.S	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.31.gcc4-x86_64-iopl-bug/arch/x86_64/kernel/entry.S	2005-06-12 11:46:56.000000000 +0200
@@ -249,7 +249,16 @@ intret_signal_test:		
 	PTREGSCALL stub_vfork, sys_vfork
 	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend
 	PTREGSCALL stub_sigaltstack, sys_sigaltstack
-	PTREGSCALL stub_iopl, sys_iopl
+
+	.macro PTREGSCALL3 label,func,arg
+	.globl \label
+\label:
+	leaq	\func(%rip),%rax
+	leaq    -ARGOFFSET+8(%rsp),\arg /* 8 for return address */
+	jmp	ptregscall_common
+	.endm
+
+	PTREGSCALL3 stub_iopl, sys_iopl, %rsi
 
 ENTRY(ptregscall_common)
 	popq %r11
diff -rupN linux-2.4.31/arch/x86_64/kernel/ioport.c linux-2.4.31.gcc4-x86_64-iopl-bug/arch/x86_64/kernel/ioport.c
--- linux-2.4.31/arch/x86_64/kernel/ioport.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.31.gcc4-x86_64-iopl-bug/arch/x86_64/kernel/ioport.c	2005-06-12 11:46:56.000000000 +0200
@@ -81,9 +81,9 @@ asmlinkage long sys_ioperm(unsigned long
  * code.
  */
 
-asmlinkage long sys_iopl(unsigned int level, struct pt_regs regs)
+asmlinkage long sys_iopl(unsigned int level, struct pt_regs *regs)
 {
-	unsigned int old = (regs.eflags >> 12) & 3;
+	unsigned int old = (regs->eflags >> 12) & 3;
 
 	if (level > 3)
 		return -EINVAL;
@@ -92,6 +92,6 @@ asmlinkage long sys_iopl(unsigned int le
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	regs.eflags = (regs.eflags & 0xffffffffffffcfff) | (level << 12);
+	regs->eflags = (regs->eflags &~ 0x3000UL) | (level << 12);
 	return 0;
 }
