Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVCVUbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVCVUbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCVU3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:29:01 -0500
Received: from aun.it.uu.se ([130.238.12.36]:17284 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261937AbVCVUXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:23:37 -0500
Date: Tue, 22 Mar 2005 21:23:30 +0100 (MET)
Message-Id: <200503222023.j2MKNUfE011646@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.30-rc1] v10 of gcc4 fixes (solves X crash on x86_64)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2005 17:26:27 +0100 (MET), I wrote:
>Here is a new set of patches to allow gcc-4.0 (20050312)
>to compile the 2.4.30-rc1 kernel.
...
> The only known problem is
>that the X server segfaults during PCI probing on x86-64. I'm
>currently debugging that.

Problem solved. There was a bug in x86_64's sys_iopl() which
allowed the compiler to not perform certain side-effects.
The bug was fixed in 2.6.9, as part of a big calling convention
change for all system calls that took a struct pt_regs parameter
on the stack.

v10 of the gcc4 fixes for 2.4.30-rc1 is now available in
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/>.
An incremental diff for the sys_iopl() fix is included below.

/Mikael

diff -rupN linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/ia32/ia32entry.S linux-2.4.30-rc1.gcc4-fixes-v10/arch/x86_64/ia32/ia32entry.S
--- linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/ia32/ia32entry.S	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v10/arch/x86_64/ia32/ia32entry.S	2005-03-22 21:00:17.000000000 +0100
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
diff -rupN linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/kernel/entry.S linux-2.4.30-rc1.gcc4-fixes-v10/arch/x86_64/kernel/entry.S
--- linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/kernel/entry.S	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v10/arch/x86_64/kernel/entry.S	2005-03-22 21:00:17.000000000 +0100
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
diff -rupN linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/kernel/ioport.c linux-2.4.30-rc1.gcc4-fixes-v10/arch/x86_64/kernel/ioport.c
--- linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/kernel/ioport.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v10/arch/x86_64/kernel/ioport.c	2005-03-22 21:00:17.000000000 +0100
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
