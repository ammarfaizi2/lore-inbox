Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVAPUYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVAPUYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVAPUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:24:06 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:35709 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262593AbVAPUXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:23:20 -0500
Date: Sun, 16 Jan 2005 21:23:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH-RFC] arch/i386/kernel/: kill some sparse warnings
Message-ID: <20050116202335.GA11791@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running
make C=2 arch/i386/kernel/
sparse complains about access past end of variable ''

The following patch silence these sparse warnings.
RELOC_HIDE uses an asm("") trick to hide the size of the variable for
sparse. I've cheched the generated code and with -O2 the code does not
change with or without RELOC_HIDE.

loadsegment take the pointer to second argument and cast it to unsigned
int *. Using a properly sized variable as argument to loadsegment kills
this warning.
For this fix I wonder what happened to the upper bits in the old
implmentation - they were undefined per definition.

This is the relevant code smippet from system.h:
		".align 4\n\t"			\
		".long 1b,3b\n"			\
		".previous"			\
		: :"m" (*(unsigned int *)&(value)))

'value' is the variable passed as second argument to loadsegment.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

===== arch/i386/kernel/ioport.c 1.14 vs edited =====
--- 1.14/arch/i386/kernel/ioport.c	2004-09-17 08:58:37 +02:00
+++ edited/arch/i386/kernel/ioport.c	2005-01-16 20:24:09 +01:00
@@ -129,7 +129,7 @@
 
 asmlinkage long sys_iopl(unsigned long unused)
 {
-	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
+	volatile struct pt_regs * regs = (struct pt_regs *) RELOC_HIDE(&unused, 0);
 	unsigned int level = regs->ebx;
 	unsigned int old = (regs->eflags >> 12) & 3;
 
===== arch/i386/kernel/signal.c 1.51 vs edited =====
--- 1.51/arch/i386/kernel/signal.c	2005-01-12 01:42:47 +01:00
+++ edited/arch/i386/kernel/signal.c	2005-01-16 21:16:43 +01:00
@@ -120,7 +120,7 @@
 sys_sigaltstack(unsigned long ebx)
 {
 	/* This is needed to make gcc realize it doesn't own the "struct pt_regs" */
-	struct pt_regs *regs = (struct pt_regs *)&ebx;
+	struct pt_regs *regs = (struct pt_regs *) RELOC_HIDE(&ebx, 0);
 	const stack_t __user *uss = (const stack_t __user *)ebx;
 	stack_t __user *uoss = (stack_t __user *)regs->ecx;
 
@@ -154,8 +154,10 @@
 
 #define GET_SEG(seg)							\
 	{ unsigned short tmp;						\
+	  unsigned int tmp2;						\
 	  err |= __get_user(tmp, &sc->seg);				\
-	  loadsegment(seg,tmp); }
+	  tmp2 = tmp;							\
+	  loadsegment(seg,tmp2); }
 
 #define	FIX_EFLAGS	(X86_EFLAGS_AC | X86_EFLAGS_OF | X86_EFLAGS_DF | \
 			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
@@ -208,7 +210,7 @@
 
 asmlinkage int sys_sigreturn(unsigned long __unused)
 {
-	struct pt_regs *regs = (struct pt_regs *) &__unused;
+	struct pt_regs *regs = (struct pt_regs *) RELOC_HIDE(&__unused, 0);
 	struct sigframe __user *frame = (struct sigframe __user *)(regs->esp - 8);
 	sigset_t set;
 	int eax;
@@ -238,7 +240,7 @@
 
 asmlinkage int sys_rt_sigreturn(unsigned long __unused)
 {
-	struct pt_regs *regs = (struct pt_regs *) &__unused;
+	struct pt_regs *regs = (struct pt_regs *) RELOC_HIDE(&__unused, 0);
 	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)(regs->esp - 4);
 	sigset_t set;
 	int eax;
