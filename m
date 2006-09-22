Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWIVLzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWIVLzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWIVLzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:55:13 -0400
Received: from ozlabs.org ([203.10.76.45]:24300 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932312AbWIVLzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:55:10 -0400
Subject: [PATCH 2/7]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <1158925997.26261.6.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 21:55:05 +1000
Message-Id: <1158926106.26261.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements save/restore of %gs in the kernel, so it can be
used for per-cpu data.  This is not cheap, and we do it for UP as well
as SMP, which is stupid.  Benchmarks, anyone?

Based on this patch by Jeremy Fitzhardinge:

From: Jeremy Fitzhardinge <jeremy@goop.org>
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

And

+From: Ingo Molnar <mingo@elte.hu>

in the syscall exit path the %gs selector has to be restored _after_ the
last kernel function has been called. If lockdep is enabled then this
kernel function is TRACE_IRQS_ON.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-pda-gs/arch/i386/kernel/asm-offsets.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/asm-offsets.c	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/asm-offsets.c	2006-09-20 16:40:18.000000000 +1000
@@ -67,6 +67,7 @@
 	OFFSET(PT_EAX, pt_regs, eax);
 	OFFSET(PT_DS,  pt_regs, xds);
 	OFFSET(PT_ES,  pt_regs, xes);
+	OFFSET(PT_GS,  pt_regs, xgs);
 	OFFSET(PT_ORIG_EAX, pt_regs, orig_eax);
 	OFFSET(PT_EIP, pt_regs, eip);
 	OFFSET(PT_CS,  pt_regs, xcs);
Index: ak-pda-gs/arch/i386/kernel/cpu/common.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/cpu/common.c	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/cpu/common.c	2006-09-20 16:40:18.000000000 +1000
@@ -579,6 +579,15 @@
 	disable_pse = 1;
 #endif
 }
+
+/* Make sure %gs is initialized properly in idle threads */
+struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
+{
+	memset(regs, 0, sizeof(struct pt_regs));
+	regs->xgs = __KERNEL_PERCPU;
+	return regs;
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -641,8 +650,8 @@
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
 
-	/* Clear %fs and %gs. */
-	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
+	/* Clear %fs. */
+	asm volatile ("mov %0, %%fs" : : "r" (0));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);
Index: ak-pda-gs/arch/i386/kernel/entry.S
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/entry.S	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/entry.S	2006-09-20 16:40:18.000000000 +1000
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
@@ -91,6 +92,9 @@
 
 #define SAVE_ALL \
 	cld; \
+	pushl %gs; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	/*CFI_REL_OFFSET gs, 0;*/\
 	pushl %es; \
 	CFI_ADJUST_CFA_OFFSET 4;\
 	/*CFI_REL_OFFSET es, 0;*/\
@@ -120,7 +124,9 @@
 	CFI_REL_OFFSET ebx, 0;\
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
-	movl %edx, %es;
+	movl %edx, %es; \
+	movl $(__KERNEL_PERCPU), %edx; \
+	movl %edx, %gs
 
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
@@ -153,17 +159,22 @@
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-.section .fixup,"ax";	\
-3:	movl $0,(%esp);	\
-	jmp 1b;		\
+3:	popl %gs;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	/*CFI_RESTORE gs;*/\
+.pushsection .fixup,"ax";	\
 4:	movl $0,(%esp);	\
+	jmp 1b;		\
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
@@ -320,11 +331,18 @@
 /* if something modifies registers it must also disable sysexit */
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
-	xorl %ebp,%ebp
 	TRACE_IRQS_ON
+1:	mov  PT_GS(%esp), %gs
+	xorl %ebp,%ebp
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
@@ -370,7 +388,7 @@
 	TRACE_IRQS_IRET
 restore_nocheck_notrace:
 	RESTORE_REGS
-	addl $4, %esp
+	addl $4, %esp			# skip orig_eax/error_code
 	CFI_ADJUST_CFA_OFFSET -4
 1:	INTERRUPT_RETURN
 .section .fixup,"ax"
@@ -512,14 +530,12 @@
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
@@ -588,13 +604,15 @@
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
@@ -607,7 +625,6 @@
 	pushl %edx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET edx, 0
-	decl %eax			# eax = -1
 	pushl %ecx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ecx, 0
@@ -615,21 +632,17 @@
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
+	movl $(__KERNEL_PERCPU), %ecx
+	movl %ecx, %gs
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
 	jmp ret_from_exception
@@ -939,6 +952,7 @@
 	movl	%ebx, PT_EAX(%edx)
 	movl	$__USER_DS, PT_DS(%edx)
 	movl	$__USER_DS, PT_ES(%edx)
+	movl	$0, PT_GS(%edx)
 	movl	%ebx, PT_ORIG_EAX(%edx)
 	movl	%ecx, PT_EIP(%edx)
 	movl	12(%esp), %ecx
Index: ak-pda-gs/arch/i386/kernel/process.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/process.c	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/process.c	2006-09-20 16:40:18.000000000 +1000
@@ -336,6 +336,7 @@
 
 	regs.xds = __USER_DS;
 	regs.xes = __USER_DS;
+	regs.xgs = __KERNEL_PERCPU;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS | get_kernel_rpl();
@@ -421,7 +422,6 @@
 	p->thread.eip = (unsigned long) ret_from_fork;
 
 	savesegment(fs,p->thread.fs);
-	savesegment(gs,p->thread.gs);
 
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
@@ -645,16 +645,16 @@
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
@@ -662,16 +662,13 @@
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
 
 	/*
 	 * Restore IOPL if needed.
Index: ak-pda-gs/arch/i386/kernel/signal.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/signal.c	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/signal.c	2006-09-20 16:40:18.000000000 +1000
@@ -128,7 +128,7 @@
 			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
 			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
 
-	GET_SEG(gs);
+	COPY_SEG(gs);
 	GET_SEG(fs);
 	COPY_SEG(es);
 	COPY_SEG(ds);
@@ -244,9 +244,7 @@
 {
 	int tmp, err = 0;
 
-	tmp = 0;
-	savesegment(gs, tmp);
-	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
+	err |= __put_user(regs->xgs, (unsigned int __user *)&sc->gs);
 	savesegment(fs, tmp);
 	err |= __put_user(tmp, (unsigned int __user *)&sc->fs);
 
Index: ak-pda-gs/include/asm-i386/mmu_context.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/mmu_context.h	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/include/asm-i386/mmu_context.h	2006-09-20 16:40:18.000000000 +1000
@@ -62,8 +62,8 @@
 #endif
 }
 
-#define deactivate_mm(tsk, mm) \
-	asm("movl %0,%%fs ; movl %0,%%gs": :"r" (0))
+#define deactivate_mm(tsk, mm)			\
+	asm("movl %0,%%fs": :"r" (0));
 
 #define activate_mm(prev, next) \
 	switch_mm((prev),(next),NULL)
Index: ak-pda-gs/include/asm-i386/processor.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/processor.h	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/include/asm-i386/processor.h	2006-09-20 16:40:18.000000000 +1000
@@ -477,6 +477,7 @@
 	.vm86_info = NULL,						\
 	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
+	.gs = __KERNEL_PERCPU,						\
 }
 
 /*
@@ -504,7 +505,8 @@
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
-	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
+	__asm__("movl %0,%%fs": :"r" (0));			\
+	regs->xgs = 0;						\
 	set_fs(USER_DS);					\
 	regs->xds = __USER_DS;					\
 	regs->xes = __USER_DS;					\
Index: ak-pda-gs/kernel/fork.c
===================================================================
--- ak-pda-gs.orig/kernel/fork.c	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/kernel/fork.c	2006-09-20 16:40:18.000000000 +1000
@@ -1299,7 +1299,7 @@
 	return ERR_PTR(retval);
 }
 
-struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
+noinline struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
 	return regs;
Index: ak-pda-gs/include/asm-i386/ptrace.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/ptrace.h	2006-09-20 16:40:06.000000000 +1000
+++ ak-pda-gs/include/asm-i386/ptrace.h	2006-09-20 16:40:18.000000000 +1000
@@ -33,6 +33,8 @@
 	long eax;
 	int  xds;
 	int  xes;
+	/* int  xfs; */
+	int  xgs;
 	long orig_eax;
 	long eip;
 	int  xcs;
Index: ak-pda-gs/include/asm-i386/segment.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/segment.h	2006-09-20 16:40:01.000000000 +1000
+++ ak-pda-gs/include/asm-i386/segment.h	2006-09-20 16:40:18.000000000 +1000
@@ -39,7 +39,7 @@
  *  25 - APM BIOS support 
  *
  *  26 - ESPFIX small SS
- *  27 - unused
+ *  27 - PERCPU				[ offset segment for per-cpu area ]
  *  28 - unused
  *  29 - unused
  *  30 - unused
@@ -74,6 +74,9 @@
 #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
 
+#define GDT_ENTRY_PERCPU		(GDT_ENTRY_KERNEL_BASE + 15)
+#define __KERNEL_PERCPU (GDT_ENTRY_PERCPU * 8)
+
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*
Index: ak-pda-gs/include/asm-i386/unwind.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/unwind.h	2006-09-20 16:40:01.000000000 +1000
+++ ak-pda-gs/include/asm-i386/unwind.h	2006-09-20 16:40:18.000000000 +1000
@@ -64,6 +64,7 @@
 	info->regs.xss = __KERNEL_DS;
 	info->regs.xds = __USER_DS;
 	info->regs.xes = __USER_DS;
+	info->regs.xgs = __KERNEL_PERCPU;
 }
 
 extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

