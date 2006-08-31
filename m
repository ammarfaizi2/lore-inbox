Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWHaA2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWHaA2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 20:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWHaA2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 20:28:11 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:36006 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S932251AbWHaA2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 20:28:05 -0400
Message-Id: <20060831000514.762524757@goop.org>
References: <20060830235201.106319215@goop.org>
User-Agent: quilt/0.45-1
Date: Wed, 30 Aug 2006 16:52:05 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/8] Use %gs as the PDA base-segment in the kernel.
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
   (or %fs). This patch extends pt_regs to add space for gs (no space
   is allocated for %fs, since it won't be used, and it would just
   complicate the code in entry.S to work around the space).

3: Because %gs is now saved on the stack like %ds, %es and the integer
   registers, there are a number of places where it no longer needs to
   be handled specially; namely context switch, and saving/restoring the
   register state in a signal context.

4: And since kernel threads run in kernel space and call normal kernel
   code, they need to be created with their %gs == __KERNEL_PDA.

NOTE: even though it's called "ptrace-abi.h", this file does not
define a user-space visible ABI.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    1 
 arch/i386/kernel/cpu/common.c  |   21 +++++++++-
 arch/i386/kernel/entry.S       |   81 +++++++++++++++++++++++-----------------
 arch/i386/kernel/process.c     |   27 ++++++-------
 arch/i386/kernel/signal.c      |    6 --
 include/asm-i386/mmu_context.h |    4 -
 include/asm-i386/processor.h   |    4 +
 include/asm-i386/ptrace-abi.h  |    2 
 kernel/fork.c                  |    2 
 9 files changed, 91 insertions(+), 57 deletions(-)


===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -68,6 +68,7 @@ void foo(void)
 	OFFSET(PT_EAX, pt_regs, eax);
 	OFFSET(PT_DS,  pt_regs, xds);
 	OFFSET(PT_ES,  pt_regs, xes);
+	OFFSET(PT_GS,  pt_regs, xgs);
 	OFFSET(PT_ORIG_EAX, pt_regs, orig_eax);
 	OFFSET(PT_EIP, pt_regs, eip);
 	OFFSET(PT_CS,  pt_regs, xcs);
===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -587,6 +587,14 @@ void __init early_cpu_init(void)
 #endif
 }
 
+/* Make sure %gs it initialized properly in idle threads */
+struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
+{
+	memset(regs, 0, sizeof(struct pt_regs));
+	regs->xgs = __KERNEL_PDA;
+	return regs;
+}
+
 __cpuinit int alloc_gdt(int cpu)
 {
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
@@ -645,6 +653,14 @@ static __cpuinit void pda_init(int cpu, 
 	printk("cpu %d current %p\n", cpu, curr);
 }
 
+static inline void set_kernel_gs(void)
+{
+	/* Set %gs for this CPU's PDA.  Memory clobber is to create a
+	   barrier with respect to any PDA operations, so the compiler
+	   doesn't move any before here. */
+	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
+}
+
 /* Initialize the CPU's GDT and PDA */
 static __cpuinit void init_gdt(void)
 {
@@ -687,6 +703,7 @@ static __cpuinit void init_gdt(void)
 			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
 
 	load_gdt(cpu_gdt_descr);
+	set_kernel_gs();
 
 	/* Do this once everything GDT-related has been set up. */
 	pda_init(cpu, curr);
@@ -745,8 +762,8 @@ void __cpuinit cpu_init(void)
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
 
-	/* Clear %fs and %gs. */
-	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
+	/* Clear %fs. */
+	asm volatile ("mov %0, %%fs" : : "r" (0));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);
===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -30,12 +30,13 @@
  *	18(%esp) - %eax
  *	1C(%esp) - %ds
  *	20(%esp) - %es
- *	24(%esp) - orig_eax
- *	28(%esp) - %eip
- *	2C(%esp) - %cs
- *	30(%esp) - %eflags
- *	34(%esp) - %oldesp
- *	38(%esp) - %oldss
+ *	24(%esp) - %gs
+ *	28(%esp) - orig_eax
+ *	2C(%esp) - %eip
+ *	30(%esp) - %cs
+ *	34(%esp) - %eflags
+ *	38(%esp) - %oldesp
+ *	3C(%esp) - %oldss
  *
  * "current" is in register %ebx during any slow entries.
  */
@@ -91,6 +92,9 @@ 1:
 
 #define SAVE_ALL \
 	cld; \
+	pushl %gs; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	/*CFI_REL_OFFSET gs, 0;*/\
 	pushl %es; \
 	CFI_ADJUST_CFA_OFFSET 4;\
 	/*CFI_REL_OFFSET es, 0;*/\
@@ -120,8 +124,10 @@ 1:
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
@@ -153,17 +159,22 @@ 2:	popl %es;	\
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-.section .fixup,"ax";	\
-3:	movl $0,(%esp);	\
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
@@ -223,6 +234,7 @@ check_userspace:
 	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
 	cmpl $USER_RPL, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
+
 ENTRY(resume_userspace)
  	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -314,13 +326,20 @@ 1:	movl (%ebp),%ebp
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
 /* if something modifies registers it must also disable sysexit */
+1:	mov  PT_GS(%esp), %gs
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
-
+.pushsection .fixup,"ax";	\
+2:	movl $0,PT_GS(%esp);	\
+	jmp 1b;			\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,2b;	\
+.popsection
 
 	# system call handler stub
 ENTRY(system_call)
@@ -366,7 +385,7 @@ restore_nocheck:
 	TRACE_IRQS_IRET
 restore_nocheck_notrace:
 	RESTORE_REGS
-	addl $4, %esp
+	addl $4, %esp			# skip orig_eax/error_code
 	CFI_ADJUST_CFA_OFFSET -4
 1:	INTERRUPT_RETURN
 .section .fixup,"ax"
@@ -508,14 +527,12 @@ syscall_badsys:
 	/* put ESP to the proper location */ \
 	movl %eax, %esp;
 #define UNWIND_ESPFIX_STACK \
-	pushl %eax; \
 	CFI_ADJUST_CFA_OFFSET 4; \
 	movl %ss, %eax; \
 	/* see if on 16bit stack */ \
-	cmpw $__ESPFIX_SS, %ax; \
+	cmp $__ESPFIX_SS, %eax; \
 	je 28f; \
-27:	popl %eax; \
-	CFI_ADJUST_CFA_OFFSET -4; \
+27:	CFI_ADJUST_CFA_OFFSET -4; \
 .section .fixup,"ax"; \
 28:	movl $__KERNEL_DS, %eax; \
 	movl %eax, %ds; \
@@ -584,13 +601,15 @@ KPROBE_ENTRY(page_fault)
 	CFI_ADJUST_CFA_OFFSET 4
 	ALIGN
 error_code:
+	/* the function address is in %gs's slot on the stack */
+	pushl %es
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl %ds
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ds, 0*/
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET eax, 0
-	xorl %eax, %eax
 	pushl %ebp
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebp, 0
@@ -603,7 +622,6 @@ error_code:
 	pushl %edx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET edx, 0
-	decl %eax			# eax = -1
 	pushl %ecx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ecx, 0
@@ -611,21 +629,17 @@ error_code:
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebx, 0
 	cld
-	pushl %es
-	CFI_ADJUST_CFA_OFFSET 4
-	/*CFI_REL_OFFSET es, 0*/
 	UNWIND_ESPFIX_STACK
-	popl %ecx
-	CFI_ADJUST_CFA_OFFSET -4
-	/*CFI_REGISTER es, ecx*/
-	movl PT_ES(%esp), %edi		# get the function address
+	movl PT_GS(%esp), %edi		# get the function address
 	movl PT_ORIG_EAX(%esp), %edx	# get the error code
-	movl %eax, PT_ORIG_EAX(%esp)
-	movl %ecx, PT_ES(%esp)
-	/*CFI_REL_OFFSET es, ES*/
+	movl $-1, PT_ORIG_EAX(%esp)	# no syscall to restart
+	mov  %gs, PT_GS(%esp)
+	/*CFI_REL_OFFSET gs, GS*/
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
 	movl %ecx, %es
+	movl $(__KERNEL_PDA), %ecx
+	movl %ecx, %gs
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
 	jmp ret_from_exception
@@ -935,6 +949,7 @@ ENTRY(arch_unwind_init_running)
 	movl	%ebx, PT_EAX(%edx)
 	movl	$__USER_DS, PT_DS(%edx)
 	movl	$__USER_DS, PT_ES(%edx)
+	movl	$0, PT_GS(%edx)
 	movl	%ebx, PT_ORIG_EAX(%edx)
 	movl	%ecx, PT_EIP(%edx)
 	movl	12(%esp), %ecx
===================================================================
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -56,6 +56,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/pda.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
@@ -340,6 +341,7 @@ int kernel_thread(int (*fn)(void *), voi
 
 	regs.xds = __USER_DS;
 	regs.xes = __USER_DS;
+	regs.xgs = __KERNEL_PDA;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS | get_kernel_rpl();
@@ -425,7 +427,6 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.eip = (unsigned long) ret_from_fork;
 
 	savesegment(fs,p->thread.fs);
-	savesegment(gs,p->thread.gs);
 
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
@@ -656,16 +657,16 @@ struct task_struct fastcall * __switch_t
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
@@ -673,16 +674,14 @@ struct task_struct fastcall * __switch_t
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
@@ -473,6 +473,7 @@ struct thread_struct {
 	.vm86_info = NULL,						\
 	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
+	.gs = __KERNEL_PDA,						\
 }
 
 /*
@@ -500,7 +501,8 @@ static inline void load_esp0(struct tss_
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
+	/* int  xfs; */
+	int  xgs;
 	long orig_eax;
 	long eip;
 	int  xcs;
===================================================================
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1298,7 +1298,7 @@ fork_out:
 	return ERR_PTR(retval);
 }
 
-struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
+noinline struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
 	return regs;

--

