Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTI3VSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbTI3VSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:18:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61893 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261768AbTI3VS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:18:28 -0400
Date: Tue, 30 Sep 2003 22:18:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove ELF_CORE_SYNC
Message-ID: <20030930211827.GE24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ELF_CORE_SYNC and dump_smp_unlazy_fpu seem to have been introduced
by Ingo around 2.5.43, but as far as I can tell, never used.

Index: linux-2.6/include/asm-i386/elf.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/elf.h,v
retrieving revision 1.1
diff -u -p -r1.1 elf.h
--- linux-2.6/include/asm-i386/elf.h	29 Jul 2003 17:01:54 -0000	1.1
+++ linux-2.6/include/asm-i386/elf.h	30 Sep 2003 21:11:46 -0000
@@ -127,11 +127,6 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
 
-#ifdef CONFIG_SMP
-extern void dump_smp_unlazy_fpu(void);
-#define ELF_CORE_SYNC dump_smp_unlazy_fpu
-#endif
-
 #define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
 #define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
 #define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
Index: linux-2.6/include/asm-ppc64/elf.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc64/elf.h,v
retrieving revision 1.1
diff -u -p -r1.1 elf.h
--- linux-2.6/include/asm-ppc64/elf.h	29 Jul 2003 17:02:04 -0000	1.1
+++ linux-2.6/include/asm-ppc64/elf.h	30 Sep 2003 21:11:46 -0000
@@ -128,11 +128,6 @@ static inline int dump_task_regs(struct 
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *); 
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 
-#ifdef CONFIG_SMP
-extern void dump_smp_unlazy_fpu(void);
-#define ELF_CORE_SYNC dump_smp_unlazy_fpu
-#endif
-
 #endif
 
 /* This yields a mask that user programs can use to figure out what
Index: linux-2.6/include/asm-x86_64/elf.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-x86_64/elf.h,v
retrieving revision 1.1
diff -u -p -r1.1 elf.h
--- linux-2.6/include/asm-x86_64/elf.h	29 Jul 2003 17:02:10 -0000	1.1
+++ linux-2.6/include/asm-x86_64/elf.h	30 Sep 2003 21:11:46 -0000
@@ -150,11 +150,6 @@ extern int dump_task_fpu (struct task_st
 #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 
-#ifdef CONFIG_SMP
-extern void dump_smp_unlazy_fpu(void);
-#define ELF_CORE_SYNC dump_smp_unlazy_fpu
-#endif
-
 #endif
 
 #endif
Index: linux-2.6/arch/i386/kernel/i387.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/i387.c,v
retrieving revision 1.1
diff -u -p -r1.1 i387.c
--- linux-2.6/arch/i386/kernel/i387.c	29 Jul 2003 17:00:24 -0000	1.1
+++ linux-2.6/arch/i386/kernel/i387.c	30 Sep 2003 21:11:46 -0000
@@ -549,13 +549,3 @@ int dump_task_extended_fpu(struct task_s
 	}
 	return fpvalid;
 }
-
-
-#ifdef CONFIG_SMP
-void dump_smp_unlazy_fpu(void)
-{
-	unlazy_fpu(current);
-	return;
-}
-#endif
-
Index: linux-2.6/arch/ppc64/kernel/process.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/kernel/process.c,v
retrieving revision 1.2.2.1
diff -u -p -r1.2.2.1 process.c
--- linux-2.6/arch/ppc64/kernel/process.c	28 Sep 2003 02:26:37 -0000	1.2.2.1
+++ linux-2.6/arch/ppc64/kernel/process.c	30 Sep 2003 21:11:46 -0000
@@ -70,23 +70,6 @@ enable_kernel_fp(void)
 #endif /* CONFIG_SMP */
 }
 
-#ifdef CONFIG_SMP
-static void smp_unlazy_onefpu(void *arg)
-{
-	struct pt_regs *regs = current->thread.regs;
-
-	if (!regs)
-		return;
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-}
-
-void dump_smp_unlazy_fpu(void)
-{
-	smp_call_function(smp_unlazy_onefpu, NULL, 1, 1);
-}
-#endif
-
 int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 {
 	struct pt_regs *regs = tsk->thread.regs;
Index: linux-2.6/arch/x86_64/kernel/i387.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/kernel/i387.c,v
retrieving revision 1.1
diff -u -p -r1.1 i387.c
--- linux-2.6/arch/x86_64/kernel/i387.c	29 Jul 2003 17:00:57 -0000	1.1
+++ linux-2.6/arch/x86_64/kernel/i387.c	30 Sep 2003 21:11:46 -0000
@@ -138,12 +138,3 @@ int dump_task_fpu(struct task_struct *ts
 }
 	return fpvalid;
 }
-
-#ifdef CONFIG_SMP
-void dump_smp_unlazy_fpu(void)
-{
-	unlazy_fpu(current);
-	return;
-}
-#endif
-

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
