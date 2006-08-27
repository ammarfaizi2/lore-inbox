Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWH0JZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWH0JZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWH0JZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:25:33 -0400
Received: from 32.sub-70-198-1.myvzw.com ([70.198.1.32]:53954 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751355AbWH0JZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:25:32 -0400
Message-Id: <20060827084451.492329798@goop.org>
References: <20060827084417.918992193@goop.org>
User-Agent: quilt/0.45-1
Date: Sun, 27 Aug 2006 01:44:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
Content-Disposition: inline; filename=i386-pda-use-gs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the meat of the PDA change.  This patch makes several
related changes:

1: Most significantly, %gs is now used in the kernel.  This means that on
   entry, the old value of %gs is saved away, and it is reloaded with
   __KERNEL_PDA.

2: entry.S constructs the stack in the shape of struct pt_regs, and this
   is passed around the kernel so that the process's saved register
   state can be accessed.

   Unfortunately struct pt_regs doesn't currently have space for %gs
   (or %fs). This patch extends pt_regs to add space for fs and gs,
   though only gs is actually saved/restored from it (reserving space
   for fs makes simplifies the changes to ptrace).

3: Because %gs is now saved on the stack like %ds, %es and the integer
   registers, there are a number of places where it no longer needs to
   be handled specially.

4: And since kernel threads run in kernel space and call normal kernel
   code, they need to be created with their %gs == __KERNEL_PDA.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>




---
 arch/i386/kernel/cpu/common.c  |    7 ++-
 arch/i386/kernel/entry.S       |   92 +++++++++++++++++++++++++++-------------
 arch/i386/kernel/process.c     |   27 +++++------
 arch/i386/kernel/signal.c      |    6 --
 arch/i386/kernel/vm86.c        |    4 -
 include/asm-i386/mmu_context.h |    4 -
 include/asm-i386/pda.h         |    2 
 include/asm-i386/processor.h   |    4 +
 include/asm-i386/ptrace-abi.h  |    2 
 9 files changed, 93 insertions(+), 55 deletions(-)


===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -717,8 +717,11 @@ old_gdt:
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
 
-	/* Clear %fs and %gs. */
-	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
+	/* Clear %fs. */
+	asm volatile ("mov %0, %%fs" : : "r" (0));
+
+	/* Set %gs for this CPU's PDA */
+	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);
===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -30,12 +30,14 @@
  *	18(%esp) - %eax
  *	1C(%esp) - %ds
  *	20(%esp) - %es
- *	24(%esp) - orig_eax
- *	28(%esp) - %eip
- *	2C(%esp) - %cs
- *	30(%esp) - %eflags
- *	34(%esp) - %oldesp
- *	38(%esp) - %oldss
+ *	24(%esp) - %fs	(not saved/restored)
+ *	28(%esp) - %gs
+ *	2C(%esp) - orig_eax
+ *	30(%esp) - %eip
+ *	34(%esp) - %cs
+ *	38(%esp) - %eflags
+ *	3C(%esp) - %oldesp
+ *	40(%esp) - %oldss
  *
  * "current" is in register %ebx during any slow entries.
  */
@@ -62,12 +64,14 @@ EAX		= 0x18
 EAX		= 0x18
 DS		= 0x1C
 ES		= 0x20
-ORIG_EAX	= 0x24
-EIP		= 0x28
-CS		= 0x2C
-EFLAGS		= 0x30
-OLDESP		= 0x34
-OLDSS		= 0x38
+FS		= 0x24
+GS		= 0x28
+ORIG_EAX	= 0x2C
+EIP		= 0x30
+CS		= 0x34
+EFLAGS		= 0x38
+OLDESP		= 0x3C
+OLDSS		= 0x40
 
 CF_MASK		= 0x00000001
 TF_MASK		= 0x00000100
@@ -107,6 +111,11 @@ 1:
 
 #define SAVE_ALL \
 	cld; \
+	pushl %gs; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	/*CFI_REL_OFFSET gs, 0;*/\
+	subl $4, %esp; /* %fs */\
+	CFI_ADJUST_CFA_OFFSET 4;\
 	pushl %es; \
 	CFI_ADJUST_CFA_OFFSET 4;\
 	/*CFI_REL_OFFSET es, 0;*/\
@@ -136,8 +145,10 @@ 1:
 	CFI_REL_OFFSET ebx, 0;\
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
-	movl %edx, %es;
-
+	movl %edx, %es; \
+	movl $(__KERNEL_PDA), %edx; \
+	movl %edx, %gs
+	
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
@@ -169,17 +180,24 @@ 2:	popl %es;	\
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-.section .fixup,"ax";	\
-3:	movl $0,(%esp);	\
+	addl $4,%esp;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+3:	popl %gs;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	/*CFI_RESTORE gs;*/\
+.pushsection .fixup,"ax";	\
+4:	movl $0,(%esp);	\
 	jmp 1b;		\
-4:	movl $0,(%esp);	\
+5:	movl $0,(%esp);	\
 	jmp 2b;		\
-.previous;		\
+6:	movl $0,(%esp);	\
+	jmp 3b;		\
 .section __ex_table,"a";\
 	.align 4;	\
-	.long 1b,3b;	\
-	.long 2b,4b;	\
-.previous
+	.long 1b,4b;	\
+	.long 2b,5b;	\
+	.long 3b,6b;	\
+.popsection
 
 #define RING0_INT_FRAME \
 	CFI_STARTPROC simple;\
@@ -239,6 +257,7 @@ check_userspace:
 	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
 	cmpl $USER_RPL, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
+
 ENTRY(resume_userspace)
  	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -332,11 +351,18 @@ 1:	movl (%ebp),%ebp
 /* if something modifies registers it must also disable sysexit */
 	movl EIP(%esp), %edx
 	movl OLDESP(%esp), %ecx
+1:	movw GS(%esp), %gs
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
-
+.pushsection .fixup,"ax";	\
+2:	movl $0,GS(%esp);	\
+	jmp 1b;			\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,2b;	\
+.popsection
 
 	# system call handler stub
 ENTRY(system_call)
@@ -600,6 +626,10 @@ KPROBE_ENTRY(page_fault)
 	CFI_ADJUST_CFA_OFFSET 4
 	ALIGN
 error_code:
+	subl $4, %esp
+	CFI_ADJUST_CFA_OFFSET 4
+	pushl %es
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl %ds
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ds, 0*/
@@ -627,21 +657,23 @@ error_code:
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebx, 0
 	cld
-	pushl %es
-	CFI_ADJUST_CFA_OFFSET 4
-	/*CFI_REL_OFFSET es, 0*/
+	pushl %gs
+	CFI_ADJUST_CFA_OFFSET 4
+	/*CFI_REL_OFFSET gs, 0*/
 	UNWIND_ESPFIX_STACK
 	popl %ecx
 	CFI_ADJUST_CFA_OFFSET -4
-	/*CFI_REGISTER es, ecx*/
-	movl ES(%esp), %edi		# get the function address
+	/*CFI_REGISTER gs, ecx*/
+	movl GS(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
 	movl %eax, ORIG_EAX(%esp)
-	movl %ecx, ES(%esp)
-	/*CFI_REL_OFFSET es, ES*/
+	movl %ecx, GS(%esp)
+	/*CFI_REL_OFFSET gs, GS*/
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
 	movl %ecx, %es
+	movl $(__KERNEL_PDA), %ecx
+	movl %ecx, %gs
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
 	jmp ret_from_exception
@@ -938,6 +970,8 @@ ENTRY(arch_unwind_init_running)
 	movl	%ebx, EAX(%edx)
 	movl	$__USER_DS, DS(%edx)
 	movl	$__USER_DS, ES(%edx)
+	movl	$0, FS(%edx)
+	movl	$0, GS(%edx)
 	movl	%ebx, ORIG_EAX(%edx)
 	movl	%ecx, EIP(%edx)
 	movl	12(%esp), %ecx
===================================================================
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -56,6 +56,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/pda.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
@@ -336,6 +337,7 @@ int kernel_thread(int (*fn)(void *), voi
 
 	regs.xds = __USER_DS;
 	regs.xes = __USER_DS;
+	regs.xgs = __KERNEL_PDA;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS | get_kernel_rpl();
@@ -421,7 +423,6 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.eip = (unsigned long) ret_from_fork;
 
 	savesegment(fs,p->thread.fs);
-	savesegment(gs,p->thread.gs);
 
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
@@ -652,16 +653,16 @@ struct task_struct fastcall * __switch_t
 	load_esp0(tss, next);
 
 	/*
-	 * Save away %fs and %gs. No need to save %es and %ds, as
-	 * those are always kernel segments while inside the kernel.
-	 * Doing this before setting the new TLS descriptors avoids
-	 * the situation where we temporarily have non-reloadable
-	 * segments in %fs and %gs.  This could be an issue if the
-	 * NMI handler ever used %fs or %gs (it does not today), or
-	 * if the kernel is running inside of a hypervisor layer.
+	 * Save away %fs. No need to save %gs, as it was saved on the
+	 * stack on entry.  No need to save %es and %ds, as those are
+	 * always kernel segments while inside the kernel.  Doing this
+	 * before setting the new TLS descriptors avoids the situation
+	 * where we temporarily have non-reloadable segments in %fs
+	 * and %gs.  This could be an issue if the NMI handler ever
+	 * used %fs or %gs (it does not today), or if the kernel is
+	 * running inside of a hypervisor layer.
 	 */
 	savesegment(fs, prev->fs);
-	savesegment(gs, prev->gs);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
@@ -669,16 +670,14 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 
 	/*
-	 * Restore %fs and %gs if needed.
+	 * Restore %fs if needed.
 	 *
-	 * Glibc normally makes %fs be zero, and %gs is one of
-	 * the TLS segments.
+	 * Glibc normally makes %fs be zero.
 	 */
 	if (unlikely(prev->fs | next->fs))
 		loadsegment(fs, next->fs);
 
-	if (prev->gs | next->gs)
-		loadsegment(gs, next->gs);
+	write_pda(pcurrent, next_p);
 
 	/*
 	 * Restore IOPL if needed.
===================================================================
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -128,7 +128,7 @@ restore_sigcontext(struct pt_regs *regs,
 			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
 			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
 
-	GET_SEG(gs);
+	COPY_SEG(gs);
 	GET_SEG(fs);
 	COPY_SEG(es);
 	COPY_SEG(ds);
@@ -244,9 +244,7 @@ setup_sigcontext(struct sigcontext __use
 {
 	int tmp, err = 0;
 
-	tmp = 0;
-	savesegment(gs, tmp);
-	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
+	err |= __put_user(regs->xgs, (unsigned int __user *)&sc->gs);
 	savesegment(fs, tmp);
 	err |= __put_user(tmp, (unsigned int __user *)&sc->fs);
 
===================================================================
--- a/arch/i386/kernel/vm86.c
+++ b/arch/i386/kernel/vm86.c
@@ -294,7 +294,7 @@ static void do_sys_vm86(struct kernel_vm
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
 	savesegment(fs, tsk->thread.saved_fs);
-	savesegment(gs, tsk->thread.saved_gs);
+	tsk->thread.saved_gs = info->regs32->xgs;
 
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
@@ -306,7 +306,7 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
-	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
+	__asm__ __volatile__("movl %0,%%fs\n\t" : : "r" (0));
 	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
 
 	/*call audit_syscall_exit since we do not exit via the normal paths */
===================================================================
--- a/include/asm-i386/mmu_context.h
+++ b/include/asm-i386/mmu_context.h
@@ -62,8 +62,8 @@ static inline void switch_mm(struct mm_s
 #endif
 }
 
-#define deactivate_mm(tsk, mm) \
-	asm("movl %0,%%fs ; movl %0,%%gs": :"r" (0))
+#define deactivate_mm(tsk, mm)			\
+	asm("movl %0,%%fs": :"r" (0));
 
 #define activate_mm(prev, next) \
 	switch_mm((prev),(next),NULL)
===================================================================
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -471,6 +471,7 @@ struct thread_struct {
 	.vm86_info = NULL,						\
 	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
+	.gs = __KERNEL_PDA,						\
 }
 
 /*
@@ -498,7 +499,8 @@ static inline void load_esp0(struct tss_
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
-	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
+	__asm__("movl %0,%%fs": :"r" (0));			\
+	regs->xgs = 0;						\
 	set_fs(USER_DS);					\
 	regs->xds = __USER_DS;					\
 	regs->xes = __USER_DS;					\
===================================================================
--- a/include/asm-i386/ptrace-abi.h
+++ b/include/asm-i386/ptrace-abi.h
@@ -33,6 +33,8 @@ struct pt_regs {
 	long eax;
 	int  xds;
 	int  xes;
+	int  xfs;
+	int  xgs;
 	long orig_eax;
 	long eip;
 	int  xcs;

--

