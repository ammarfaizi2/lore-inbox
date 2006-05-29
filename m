Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWE2VnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWE2VnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWE2Vmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:42:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:22200 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751335AbWE2VYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:17 -0400
Date: Mon, 29 May 2006 23:24:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 18/61] lock validator: irqtrace: core
Message-ID: <20060529212432.GR3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

accurate hard-IRQ-flags state tracing. This allows us to attach
extra functionality to IRQ flags on/off events (such as trace-on/off).

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/kernel/entry.S       |   25 ++++++-
 arch/i386/kernel/irq.c         |    6 +
 arch/x86_64/ia32/ia32entry.S   |   19 +++++
 arch/x86_64/kernel/entry.S     |   54 +++++++++++++++-
 arch/x86_64/kernel/irq.c       |    4 -
 include/asm-i386/irqflags.h    |   56 ++++++++++++++++
 include/asm-i386/spinlock.h    |    5 +
 include/asm-i386/system.h      |   20 -----
 include/asm-powerpc/irqflags.h |   31 +++++++++
 include/asm-x86_64/irqflags.h  |   54 ++++++++++++++++
 include/asm-x86_64/system.h    |   38 -----------
 include/linux/hardirq.h        |   13 +++
 include/linux/init_task.h      |    1 
 include/linux/interrupt.h      |   11 +--
 include/linux/sched.h          |   15 ++++
 include/linux/trace_irqflags.h |   87 ++++++++++++++++++++++++++
 kernel/fork.c                  |   20 +++++
 kernel/sched.c                 |    4 -
 kernel/softirq.c               |  137 +++++++++++++++++++++++++++++++++++------
 lib/locking-selftest.c         |    3 
 20 files changed, 513 insertions(+), 90 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -43,6 +43,7 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
+#include <asm/irqflags.h>
 #include <asm/errno.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
@@ -76,7 +77,7 @@ NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli
+#define preempt_stop		cli; TRACE_IRQS_OFF
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -186,6 +187,10 @@ need_resched:
 ENTRY(sysenter_entry)
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
+	/*
+	 * No need to follow this irqs on/off section: the syscall
+	 * disabled irqs and here we enable it straight after entry:
+	 */
 	sti
 	pushl $(__USER_DS)
 	pushl %ebp
@@ -217,6 +222,7 @@ sysenter_past_esp:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
 	cli
+	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
@@ -224,6 +230,7 @@ sysenter_past_esp:
 	movl EIP(%esp), %edx
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
+	TRACE_IRQS_ON
 	sti
 	sysexit
 
@@ -250,6 +257,7 @@ syscall_exit:
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
+	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
@@ -265,11 +273,14 @@ restore_all:
 	cmpl $((4 << 8) | 3), %eax
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
+	TRACE_IRQS_ON
+restore_nocheck_notrace:
 	RESTORE_REGS
 	addl $4, %esp
 1:	iret
 .section .fixup,"ax"
 iret_exc:
+	TRACE_IRQS_ON
 	sti
 	pushl $0			# no error code
 	pushl $do_iret_error
@@ -293,10 +304,12 @@ ldt_ss:
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
 	cli
+	TRACE_IRQS_OFF
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
 	 * and a switch16 pointer on top of the current frame. */
 	call setup_x86_bogus_stack
+	TRACE_IRQS_ON
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
 1:	iret
@@ -315,6 +328,7 @@ work_resched:
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
+	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
 					# than syscall tracing?
@@ -364,6 +378,7 @@ syscall_trace_entry:
 syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
+	TRACE_IRQS_ON
 	sti				# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
@@ -425,9 +440,14 @@ ENTRY(irq_entries_start)
 vector=vector+1
 .endr
 
+/*
+ * the CPU automatically disables interrupts when executing an IRQ vector,
+ * so IRQ-flags tracing has to follow that:
+ */
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	TRACE_IRQS_OFF
 	movl %esp,%eax
 	call do_IRQ
 	jmp ret_from_intr
@@ -436,6 +456,7 @@ common_interrupt:
 ENTRY(name)				\
 	pushl $~(nr);			\
 	SAVE_ALL			\
+	TRACE_IRQS_OFF			\
 	movl %esp,%eax;			\
 	call smp_/**/name;		\
 	jmp ret_from_intr;
@@ -565,7 +586,7 @@ nmi_stack_correct:
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
-	jmp restore_all
+	jmp restore_nocheck_notrace
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -147,7 +147,7 @@ void irq_ctx_init(int cpu)
 	irqctx->tinfo.task              = NULL;
 	irqctx->tinfo.exec_domain       = NULL;
 	irqctx->tinfo.cpu               = cpu;
-	irqctx->tinfo.preempt_count     = SOFTIRQ_OFFSET;
+	irqctx->tinfo.preempt_count     = 0;
 	irqctx->tinfo.addr_limit        = MAKE_MM_SEG(0);
 
 	softirq_ctx[cpu] = irqctx;
@@ -192,6 +192,10 @@ asmlinkage void do_softirq(void)
 			: "0"(isp)
 			: "memory", "cc", "edx", "ecx", "eax"
 		);
+		/*
+		 * Shouldnt happen, we returned above if in_interrupt():
+	 	 */
+		WARN_ON_ONCE(softirq_count());
 	}
 
 	local_irq_restore(flags);
Index: linux/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32entry.S
+++ linux/arch/x86_64/ia32/ia32entry.S
@@ -13,6 +13,7 @@
 #include <asm/thread_info.h>	
 #include <asm/segment.h>
 #include <asm/vsyscall32.h>
+#include <asm/irqflags.h>
 #include <linux/linkage.h>
 
 #define IA32_NR_syscalls ((ia32_syscall_end - ia32_sys_call_table)/8)
@@ -75,6 +76,10 @@ ENTRY(ia32_sysenter_target)
 	swapgs
 	movq	%gs:pda_kernelstack, %rsp
 	addq	$(PDA_STACKOFFSET),%rsp	
+	/*
+	 * No need to follow this irqs on/off section: the syscall
+	 * disabled irqs, here we enable it straight after entry:
+	 */
 	sti	
  	movl	%ebp,%ebp		/* zero extension */
 	pushq	$__USER32_DS
@@ -118,6 +123,7 @@ sysenter_do_call:	
 	movq	%rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
 	cli
+	TRACE_IRQS_OFF
 	testl	$_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
 	jnz	int_ret_from_sys_call
 	andl    $~TS_COMPAT,threadinfo_status(%r10)
@@ -132,6 +138,7 @@ sysenter_do_call:	
 	CFI_REGISTER rsp,rcx
 	movl	$VSYSCALL32_SYSEXIT,%edx	/* User %eip */
 	CFI_REGISTER rip,rdx
+	TRACE_IRQS_ON
 	swapgs
 	sti		/* sti only takes effect after the next instruction */
 	/* sysexit */
@@ -186,6 +193,10 @@ ENTRY(ia32_cstar_target)
 	movl	%esp,%r8d
 	CFI_REGISTER	rsp,r8
 	movq	%gs:pda_kernelstack,%rsp
+	/*
+	 * No need to follow this irqs on/off section: the syscall
+	 * disabled irqs and here we enable it straight after entry:
+	 */
 	sti
 	SAVE_ARGS 8,1,1
 	movl 	%eax,%eax	/* zero extension */
@@ -220,6 +231,7 @@ cstar_do_call:	
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
 	cli
+	TRACE_IRQS_OFF
 	testl $_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
 	jnz  int_ret_from_sys_call
 	andl $~TS_COMPAT,threadinfo_status(%r10)
@@ -228,6 +240,7 @@ cstar_do_call:	
 	CFI_REGISTER rip,rcx
 	movl EFLAGS-ARGOFFSET(%rsp),%r11d	
 	/*CFI_REGISTER rflags,r11*/
+	TRACE_IRQS_ON
 	movl RSP-ARGOFFSET(%rsp),%esp
 	CFI_RESTORE rsp
 	swapgs
@@ -286,7 +299,11 @@ ENTRY(ia32_syscall)
 	/*CFI_REL_OFFSET	rflags,EFLAGS-RIP*/
 	/*CFI_REL_OFFSET	cs,CS-RIP*/
 	CFI_REL_OFFSET	rip,RIP-RIP
-	swapgs	
+	swapgs
+	/*
+	 * No need to follow this irqs on/off section: the syscall
+	 * disabled irqs and here we enable it straight after entry:
+	 */
 	sti
 	movl %eax,%eax
 	pushq %rax
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -42,13 +42,14 @@
 #include <asm/thread_info.h>
 #include <asm/hw_irq.h>
 #include <asm/page.h>
+#include <asm/irqflags.h>
 
 	.code64
 
 #ifndef CONFIG_PREEMPT
 #define retint_kernel retint_restore_args
 #endif	
-	
+
 /*
  * C code is not supposed to know about undefined top of stack. Every time 
  * a C function with an pt_regs argument is called from the SYSCALL based 
@@ -195,6 +196,10 @@ ENTRY(system_call)
 	swapgs
 	movq	%rsp,%gs:pda_oldrsp 
 	movq	%gs:pda_kernelstack,%rsp
+	/*
+	 * No need to follow this irqs off/on section - it's straight
+	 * and short:
+	 */
 	sti					
 	SAVE_ARGS 8,1
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) 
@@ -220,10 +225,15 @@ ret_from_sys_call:
 sysret_check:		
 	GET_THREAD_INFO(%rcx)
 	cli
+	TRACE_IRQS_OFF
 	movl threadinfo_flags(%rcx),%edx
 	andl %edi,%edx
 	CFI_REMEMBER_STATE
 	jnz  sysret_careful 
+	/*
+	 * sysretq will re-enable interrupts:
+	 */
+	TRACE_IRQS_ON
 	movq RIP-ARGOFFSET(%rsp),%rcx
 	CFI_REGISTER	rip,rcx
 	RESTORE_ARGS 0,-ARG_SKIP,1
@@ -238,6 +248,7 @@ sysret_careful:
 	CFI_RESTORE_STATE
 	bt $TIF_NEED_RESCHED,%edx
 	jnc sysret_signal
+	TRACE_IRQS_ON
 	sti
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
@@ -248,6 +259,7 @@ sysret_careful:
 
 	/* Handle a signal */ 
 sysret_signal:
+	TRACE_IRQS_ON
 	sti
 	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
 	jz    1f
@@ -262,6 +274,7 @@ sysret_signal:
 	/* Use IRET because user could have changed frame. This
 	   works because ptregscall_common has called FIXUP_TOP_OF_STACK. */
 	cli
+	TRACE_IRQS_OFF
 	jmp int_with_check
 	
 badsys:
@@ -315,6 +328,7 @@ ENTRY(int_ret_from_sys_call)
 	CFI_REL_OFFSET	r10,R10-ARGOFFSET
 	CFI_REL_OFFSET	r11,R11-ARGOFFSET
 	cli
+	TRACE_IRQS_OFF
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_restore_args
 	movl $_TIF_ALLWORK_MASK,%edi
@@ -333,6 +347,7 @@ int_with_check:
 int_careful:
 	bt $TIF_NEED_RESCHED,%edx
 	jnc  int_very_careful
+	TRACE_IRQS_ON
 	sti
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
@@ -340,10 +355,12 @@ int_careful:
 	popq %rdi
 	CFI_ADJUST_CFA_OFFSET -8
 	cli
+	TRACE_IRQS_OFF
 	jmp int_with_check
 
 	/* handle signals and tracing -- both require a full stack frame */
 int_very_careful:
+	TRACE_IRQS_ON
 	sti
 	SAVE_REST
 	/* Check for syscall exit trace */	
@@ -357,6 +374,7 @@ int_very_careful:
 	CFI_ADJUST_CFA_OFFSET -8
 	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
 	cli
+	TRACE_IRQS_OFF
 	jmp int_restore_rest
 	
 int_signal:
@@ -369,6 +387,7 @@ int_signal:
 int_restore_rest:
 	RESTORE_REST
 	cli
+	TRACE_IRQS_OFF
 	jmp int_with_check
 	CFI_ENDPROC
 END(int_ret_from_sys_call)
@@ -501,6 +520,11 @@ END(stub_rt_sigreturn)
 #ifndef CONFIG_DEBUG_INFO
 	CFI_ADJUST_CFA_OFFSET	8
 #endif
+	/*
+	 * We entered an interrupt context - irqs are off:
+	 */
+	TRACE_IRQS_OFF
+
 	call \func
 	.endm
 
@@ -514,6 +538,7 @@ ret_from_intr:
 	CFI_ADJUST_CFA_OFFSET	-8
 #endif
 	cli	
+	TRACE_IRQS_OFF
 	decl %gs:pda_irqcount
 #ifdef CONFIG_DEBUG_INFO
 	movq RBP(%rdi),%rbp
@@ -538,9 +563,21 @@ retint_check:
 	CFI_REMEMBER_STATE
 	jnz  retint_careful
 retint_swapgs:	 	
+	/*
+	 * The iretq will re-enable interrupts:
+	 */
+	cli
+	TRACE_IRQS_ON
 	swapgs 
+	jmp restore_args
+
 retint_restore_args:				
 	cli
+	/*
+	 * The iretq will re-enable interrupts:
+	 */
+	TRACE_IRQS_ON
+restore_args:
 	RESTORE_ARGS 0,8,0						
 iret_label:	
 	iretq
@@ -553,6 +590,7 @@ iret_label:	
 	/* running with kernel gs */
 bad_iret:
 	movq $11,%rdi	/* SIGSEGV */
+	TRACE_IRQS_ON
 	sti
 	jmp do_exit			
 	.previous	
@@ -562,6 +600,7 @@ retint_careful:
 	CFI_RESTORE_STATE
 	bt    $TIF_NEED_RESCHED,%edx
 	jnc   retint_signal
+	TRACE_IRQS_ON
 	sti
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET	8
@@ -570,11 +609,13 @@ retint_careful:
 	CFI_ADJUST_CFA_OFFSET	-8
 	GET_THREAD_INFO(%rcx)
 	cli
+	TRACE_IRQS_OFF
 	jmp retint_check
 	
 retint_signal:
 	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
 	jz    retint_swapgs
+	TRACE_IRQS_ON
 	sti
 	SAVE_REST
 	movq $-1,ORIG_RAX(%rsp) 			
@@ -583,6 +624,7 @@ retint_signal:
 	call do_notify_resume
 	RESTORE_REST
 	cli
+	TRACE_IRQS_OFF
 	movl $_TIF_NEED_RESCHED,%edi
 	GET_THREAD_INFO(%rcx)
 	jmp retint_check
@@ -714,6 +756,7 @@ END(spurious_interrupt)
 	addq	$EXCEPTION_STKSZ, per_cpu__init_tss + TSS_ist + (\ist - 1) * 8(%rbp)
 	.endif
 	cli
+	TRACE_IRQS_OFF
 	.endm
 	
 /*
@@ -771,6 +814,7 @@ error_exit:		
 	movl %ebx,%eax		
 	RESTORE_REST
 	cli
+	TRACE_IRQS_OFF
 	GET_THREAD_INFO(%rcx)	
 	testl %eax,%eax
 	jne  retint_kernel
@@ -778,6 +822,10 @@ error_exit:		
 	movl  $_TIF_WORK_MASK,%edi
 	andl  %edi,%edx
 	jnz  retint_careful
+	/*
+	 * The iret will restore flags:
+	 */
+	TRACE_IRQS_ON
 	swapgs 
 	RESTORE_ARGS 0,8,0						
 	jmp iret_label
@@ -980,16 +1028,20 @@ paranoid_userspace:	
 	testl $_TIF_NEED_RESCHED,%ebx
 	jnz paranoid_schedule
 	movl %ebx,%edx			/* arg3: thread flags */
+	TRACE_IRQS_ON
 	sti
 	xorl %esi,%esi 			/* arg2: oldset */
 	movq %rsp,%rdi 			/* arg1: &pt_regs */
 	call do_notify_resume
 	cli
+	TRACE_IRQS_OFF
 	jmp paranoid_userspace
 paranoid_schedule:
+	TRACE_IRQS_ON
 	sti
 	call schedule
 	cli
+	TRACE_IRQS_OFF
 	jmp paranoid_userspace
 	CFI_ENDPROC
 END(nmi)
Index: linux/arch/x86_64/kernel/irq.c
===================================================================
--- linux.orig/arch/x86_64/kernel/irq.c
+++ linux/arch/x86_64/kernel/irq.c
@@ -145,8 +145,10 @@ asmlinkage void do_softirq(void)
  	local_irq_save(flags);
  	pending = local_softirq_pending();
  	/* Switch to interrupt stack */
- 	if (pending)
+ 	if (pending) {
 		call_softirq();
+		WARN_ON_ONCE(softirq_count());
+	}
  	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(do_softirq);
Index: linux/include/asm-i386/irqflags.h
===================================================================
--- /dev/null
+++ linux/include/asm-i386/irqflags.h
@@ -0,0 +1,56 @@
+/*
+ * include/asm-i386/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+#define raw_local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
+#define raw_local_irq_restore(x) do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+#define raw_local_irq_disable()	__asm__ __volatile__("cli": : :"memory")
+#define raw_local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+/* used in the idle loop; sti takes one instruction cycle to complete */
+#define raw_safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
+/* used when interrupts are already enabled or to shutdown the processor */
+#define halt()			__asm__ __volatile__("hlt": : :"memory")
+
+#define raw_irqs_disabled_flags(flags)	(!((flags) & (1<<9)))
+
+/* For spinlocks etc */
+#define raw_local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+/*
+ * Do the CPU's IRQ-state tracing from assembly code. We call a
+ * C function, so save all the C-clobbered registers:
+ */
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+# define TRACE_IRQS_ON				\
+	pushl %eax;				\
+	pushl %ecx;				\
+	pushl %edx;				\
+	call trace_hardirqs_on;			\
+	popl %edx;				\
+	popl %ecx;				\
+	popl %eax;
+
+# define TRACE_IRQS_OFF				\
+	pushl %eax;				\
+	pushl %ecx;				\
+	pushl %edx;				\
+	call trace_hardirqs_off;		\
+	popl %edx;				\
+	popl %ecx;				\
+	popl %eax;
+
+#else
+# define TRACE_IRQS_ON
+# define TRACE_IRQS_OFF
+#endif
+
+#endif
Index: linux/include/asm-i386/spinlock.h
===================================================================
--- linux.orig/include/asm-i386/spinlock.h
+++ linux/include/asm-i386/spinlock.h
@@ -31,6 +31,11 @@
 	"jmp 1b\n" \
 	"3:\n\t"
 
+/*
+ * NOTE: there's an irqs-on section here, which normally would have to be
+ * irq-traced, but on CONFIG_TRACE_IRQFLAGS we never use
+ * __raw_spin_lock_string_flags().
+ */
 #define __raw_spin_lock_string_flags \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
Index: linux/include/asm-i386/system.h
===================================================================
--- linux.orig/include/asm-i386/system.h
+++ linux/include/asm-i386/system.h
@@ -456,25 +456,7 @@ static inline unsigned long long __cmpxc
 
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
-/* interrupt control.. */
-#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
-/* used in the idle loop; sti takes one instruction cycle to complete */
-#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
-/* used when interrupts are already enabled or to shutdown the processor */
-#define halt()			__asm__ __volatile__("hlt": : :"memory")
-
-#define irqs_disabled()			\
-({					\
-	unsigned long flags;		\
-	local_save_flags(flags);	\
-	!(flags & (1<<9));		\
-})
-
-/* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#include <linux/trace_irqflags.h>
 
 /*
  * disable hlt during certain critical i/o operations
Index: linux/include/asm-powerpc/irqflags.h
===================================================================
--- /dev/null
+++ linux/include/asm-powerpc/irqflags.h
@@ -0,0 +1,31 @@
+/*
+ * include/asm-powerpc/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+/*
+ * Get definitions for raw_local_save_flags(x), etc.
+ */
+#include <asm-powerpc/hw_irq.h>
+
+/*
+ * Do the CPU's IRQ-state tracing from assembly code. We call a
+ * C function, so save all the C-clobbered registers:
+ */
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+#error No support on PowerPC yet for CONFIG_TRACE_IRQFLAGS
+
+#else
+# define TRACE_IRQS_ON
+# define TRACE_IRQS_OFF
+#endif
+
+#endif
Index: linux/include/asm-x86_64/irqflags.h
===================================================================
--- /dev/null
+++ linux/include/asm-x86_64/irqflags.h
@@ -0,0 +1,54 @@
+/*
+ * include/asm-x86_64/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+/* interrupt control.. */
+#define raw_local_save_flags(x)	do { warn_if_not_ulong(x); __asm__ __volatile__("# save_flags \n\t pushfq ; popq %q0":"=g" (x): /* no input */ :"memory"); } while (0)
+#define raw_local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
+
+#ifdef CONFIG_X86_VSMP
+/* Interrupt control for VSMP  architecture */
+#define raw_local_irq_disable()	do { unsigned long flags; raw_local_save_flags(flags); raw_local_irq_restore((flags & ~(1 << 9)) | (1 << 18)); } while (0)
+#define raw_local_irq_enable()	do { unsigned long flags; raw_local_save_flags(flags); raw_local_irq_restore((flags | (1 << 9)) & ~(1 << 18)); } while (0)
+
+#define raw_irqs_disabled_flags(flags)	\
+({						\
+	(flags & (1<<18)) || !(flags & (1<<9));	\
+})
+
+/* For spinlocks etc */
+#define raw_local_irq_save(x)	do { raw_local_save_flags(x); raw_local_irq_restore((x & ~(1 << 9)) | (1 << 18)); } while (0)
+#else  /* CONFIG_X86_VSMP */
+#define raw_local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define raw_local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+
+#define raw_irqs_disabled_flags(flags)	\
+({						\
+	!(flags & (1<<9));			\
+})
+
+/* For spinlocks etc */
+#define raw_local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# raw_local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
+#endif
+
+#define raw_irqs_disabled()			\
+({						\
+	unsigned long flags;			\
+	raw_local_save_flags(flags);		\
+	raw_irqs_disabled_flags(flags);		\
+})
+
+/* used in the idle loop; sti takes one instruction cycle to complete */
+#define raw_safe_halt()	__asm__ __volatile__("sti; hlt": : :"memory")
+/* used when interrupts are already enabled or to shutdown the processor */
+#define halt()			__asm__ __volatile__("hlt": : :"memory")
+
+#endif
Index: linux/include/asm-x86_64/system.h
===================================================================
--- linux.orig/include/asm-x86_64/system.h
+++ linux/include/asm-x86_64/system.h
@@ -244,43 +244,7 @@ static inline unsigned long __cmpxchg(vo
 
 #define warn_if_not_ulong(x) do { unsigned long foo; (void) (&(x) == &foo); } while (0)
 
-/* interrupt control.. */
-#define local_save_flags(x)	do { warn_if_not_ulong(x); __asm__ __volatile__("# save_flags \n\t pushfq ; popq %q0":"=g" (x): /* no input */ :"memory"); } while (0)
-#define local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
-
-#ifdef CONFIG_X86_VSMP
-/* Interrupt control for VSMP  architecture */
-#define local_irq_disable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags & ~(1 << 9)) | (1 << 18)); } while (0)
-#define local_irq_enable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags | (1 << 9)) & ~(1 << 18)); } while (0)
-
-#define irqs_disabled()					\
-({							\
-	unsigned long flags;				\
-	local_save_flags(flags);			\
-	(flags & (1<<18)) || !(flags & (1<<9));		\
-})
-
-/* For spinlocks etc */
-#define local_irq_save(x)	do { local_save_flags(x); local_irq_restore((x & ~(1 << 9)) | (1 << 18)); } while (0)
-#else  /* CONFIG_X86_VSMP */
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
-
-#define irqs_disabled()			\
-({					\
-	unsigned long flags;		\
-	local_save_flags(flags);	\
-	!(flags & (1<<9));		\
-})
-
-/* For spinlocks etc */
-#define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
-#endif
-
-/* used in the idle loop; sti takes one instruction cycle to complete */
-#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
-/* used when interrupts are already enabled or to shutdown the processor */
-#define halt()			__asm__ __volatile__("hlt": : :"memory")
+#include <linux/trace_irqflags.h>
 
 void cpu_idle_wait(void);
 
Index: linux/include/linux/hardirq.h
===================================================================
--- linux.orig/include/linux/hardirq.h
+++ linux/include/linux/hardirq.h
@@ -87,7 +87,11 @@ extern void synchronize_irq(unsigned int
 #endif
 
 #define nmi_enter()		irq_enter()
-#define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
+#define nmi_exit()					\
+	do {						\
+		sub_preempt_count(HARDIRQ_OFFSET);	\
+		trace_hardirq_exit();			\
+	} while (0)
 
 struct task_struct;
 
@@ -97,10 +101,17 @@ static inline void account_system_vtime(
 }
 #endif
 
+/*
+ * It is safe to do non-atomic ops on ->hardirq_context,
+ * because NMI handlers may not preempt and the ops are
+ * always balanced, so the interrupted value of ->hardirq_context
+ * will always be restored.
+ */
 #define irq_enter()					\
 	do {						\
 		account_system_vtime(current);		\
 		add_preempt_count(HARDIRQ_OFFSET);	\
+		trace_hardirq_enter();			\
 	} while (0)
 
 extern void irq_exit(void);
Index: linux/include/linux/init_task.h
===================================================================
--- linux.orig/include/linux/init_task.h
+++ linux/include/linux/init_task.h
@@ -133,6 +133,7 @@ extern struct group_info init_groups;
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
+ 	INIT_TRACE_IRQFLAGS						\
 }
 
 
Index: linux/include/linux/interrupt.h
===================================================================
--- linux.orig/include/linux/interrupt.h
+++ linux/include/linux/interrupt.h
@@ -10,6 +10,7 @@
 #include <linux/irqreturn.h>
 #include <linux/hardirq.h>
 #include <linux/sched.h>
+#include <linux/trace_irqflags.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -72,13 +73,11 @@ static inline void __deprecated save_and
 #define save_and_cli(x)	save_and_cli(&x)
 #endif /* CONFIG_SMP */
 
-/* SoftIRQ primitives.  */
-#define local_bh_disable() \
-		do { add_preempt_count(SOFTIRQ_OFFSET); barrier(); } while (0)
-#define __local_bh_enable() \
-		do { barrier(); sub_preempt_count(SOFTIRQ_OFFSET); } while (0)
-
+extern void local_bh_disable(void);
+extern void __local_bh_enable(void);
+extern void _local_bh_enable(void);
 extern void local_bh_enable(void);
+extern void local_bh_enable_ip(unsigned long ip);
 
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
    frequency threaded job scheduling. For almost all the purposes
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -916,6 +916,21 @@ struct task_struct {
 	/* mutex deadlock detection */
 	struct mutex_waiter *blocked_on;
 #endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+	unsigned int irq_events;
+	int hardirqs_enabled;
+	unsigned long hardirq_enable_ip;
+	unsigned int hardirq_enable_event;
+	unsigned long hardirq_disable_ip;
+	unsigned int hardirq_disable_event;
+	int softirqs_enabled;
+	unsigned long softirq_disable_ip;
+	unsigned int softirq_disable_event;
+	unsigned long softirq_enable_ip;
+	unsigned int softirq_enable_event;
+	int hardirq_context;
+	int softirq_context;
+#endif
 
 /* journalling filesystem info */
 	void *journal_info;
Index: linux/include/linux/trace_irqflags.h
===================================================================
--- /dev/null
+++ linux/include/linux/trace_irqflags.h
@@ -0,0 +1,87 @@
+/*
+ * include/linux/trace_irqflags.h
+ *
+ * IRQ flags tracing: follow the state of the hardirq and softirq flags and
+ * provide callbacks for transitions between ON and OFF states.
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _LINUX_TRACE_IRQFLAGS_H
+#define _LINUX_TRACE_IRQFLAGS_H
+
+#include <asm/irqflags.h>
+
+/*
+ * The local_irq_*() APIs are equal to the raw_local_irq*()
+ * if !TRACE_IRQFLAGS.
+ */
+#ifdef CONFIG_TRACE_IRQFLAGS
+  extern void trace_hardirqs_on(void);
+  extern void trace_hardirqs_off(void);
+  extern void trace_softirqs_on(unsigned long ip);
+  extern void trace_softirqs_off(unsigned long ip);
+# define trace_hardirq_context(p)	((p)->hardirq_context)
+# define trace_softirq_context(p)	((p)->softirq_context)
+# define trace_hardirqs_enabled(p)	((p)->hardirqs_enabled)
+# define trace_softirqs_enabled(p)	((p)->softirqs_enabled)
+# define trace_hardirq_enter()	do { current->hardirq_context++; } while (0)
+# define trace_hardirq_exit()	do { current->hardirq_context--; } while (0)
+# define trace_softirq_enter()	do { current->softirq_context++; } while (0)
+# define trace_softirq_exit()	do { current->softirq_context--; } while (0)
+# define INIT_TRACE_IRQFLAGS	.softirqs_enabled = 1,
+
+#else
+# define trace_hardirqs_on()		do { } while (0)
+# define trace_hardirqs_off()		do { } while (0)
+# define trace_softirqs_on(ip)		do { } while (0)
+# define trace_softirqs_off(ip)		do { } while (0)
+# define trace_hardirq_context(p)	0
+# define trace_softirq_context(p)	0
+# define trace_hardirqs_enabled(p)	0
+# define trace_softirqs_enabled(p)	0
+# define trace_hardirq_enter()		do { } while (0)
+# define trace_hardirq_exit()		do { } while (0)
+# define trace_softirq_enter()		do { } while (0)
+# define trace_softirq_exit()		do { } while (0)
+# define INIT_TRACE_IRQFLAGS
+#endif
+
+#define local_irq_enable() \
+	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
+#define local_irq_disable() \
+	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+#define local_irq_save(flags) \
+	do { raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
+
+#define local_irq_restore(flags)				\
+	do {							\
+		if (raw_irqs_disabled_flags(flags)) {		\
+			raw_local_irq_restore(flags);		\
+			trace_hardirqs_off();			\
+		} else {					\
+			trace_hardirqs_on();			\
+			raw_local_irq_restore(flags);		\
+		}						\
+	} while (0)
+
+#define safe_halt()						\
+	do {							\
+		trace_hardirqs_on();				\
+		raw_safe_halt();				\
+	} while (0)
+
+#define local_save_flags(flags)		raw_local_save_flags(flags)
+
+#define irqs_disabled()						\
+({								\
+	unsigned long flags;					\
+								\
+	raw_local_save_flags(flags);				\
+	raw_irqs_disabled_flags(flags);				\
+})
+
+#define irqs_disabled_flags(flags)	raw_irqs_disabled_flags(flags)
+
+#endif
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -970,6 +970,10 @@ static task_t *copy_process(unsigned lon
 	if (!p)
 		goto fork_out;
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	DEBUG_WARN_ON(!p->hardirqs_enabled);
+	DEBUG_WARN_ON(!p->softirqs_enabled);
+#endif
 	retval = -EAGAIN;
 	if (atomic_read(&p->user->processes) >=
 			p->signal->rlim[RLIMIT_NPROC].rlim_cur) {
@@ -1051,7 +1055,21 @@ static task_t *copy_process(unsigned lon
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
-
+#ifdef CONFIG_TRACE_IRQFLAGS
+	p->irq_events = 0;
+	p->hardirqs_enabled = 0;
+	p->hardirq_enable_ip = 0;
+	p->hardirq_enable_event = 0;
+	p->hardirq_disable_ip = _THIS_IP_;
+	p->hardirq_disable_event = 0;
+	p->softirqs_enabled = 1;
+	p->softirq_enable_ip = _THIS_IP_;
+	p->softirq_enable_event = 0;
+	p->softirq_disable_ip = 0;
+	p->softirq_disable_event = 0;
+	p->hardirq_context = 0;
+	p->softirq_context = 0;
+#endif
 	p->tgid = p->pid;
 	if (clone_flags & CLONE_THREAD)
 		p->tgid = current->tgid;
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -4481,7 +4481,9 @@ int __sched cond_resched_softirq(void)
 	BUG_ON(!in_softirq());
 
 	if (need_resched()) {
-		__local_bh_enable();
+		raw_local_irq_disable();
+		_local_bh_enable();
+		raw_local_irq_enable();
 		__cond_resched();
 		local_bh_disable();
 		return 1;
Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -62,6 +62,119 @@ static inline void wakeup_softirqd(void)
 }
 
 /*
+ * This one is for softirq.c-internal use,
+ * where hardirqs are disabled legitimately:
+ */
+static void __local_bh_disable(unsigned long ip)
+{
+	unsigned long flags;
+
+	WARN_ON_ONCE(in_irq());
+
+	raw_local_irq_save(flags);
+	add_preempt_count(SOFTIRQ_OFFSET);
+	/*
+	 * Were softirqs turned off above:
+	 */
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		trace_softirqs_off(ip);
+	raw_local_irq_restore(flags);
+}
+
+void local_bh_disable(void)
+{
+	WARN_ON_ONCE(irqs_disabled());
+	__local_bh_disable((unsigned long)__builtin_return_address(0));
+}
+
+EXPORT_SYMBOL(local_bh_disable);
+
+void __local_bh_enable(void)
+{
+	WARN_ON_ONCE(in_irq());
+
+	/*
+	 * softirqs should never be enabled by __local_bh_enable(),
+	 * it always nests inside local_bh_enable() sections:
+	 */
+	WARN_ON_ONCE(softirq_count() == SOFTIRQ_OFFSET);
+
+	sub_preempt_count(SOFTIRQ_OFFSET);
+}
+
+EXPORT_SYMBOL(__local_bh_enable);
+
+/*
+ * Special-case - softirqs can safely be enabled in
+ * cond_resched_softirq(), or by __do_softirq(),
+ * without processing still-pending softirqs:
+ */
+void _local_bh_enable(void)
+{
+	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(!irqs_disabled());
+
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		trace_softirqs_on((unsigned long)__builtin_return_address(0));
+	sub_preempt_count(SOFTIRQ_OFFSET);
+}
+
+void local_bh_enable(void)
+{
+	unsigned long flags;
+
+	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(irqs_disabled());
+
+	local_irq_save(flags);
+	/*
+	 * Are softirqs going to be turned on now:
+	 */
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		trace_softirqs_on((unsigned long)__builtin_return_address(0));
+	/*
+	 * Keep preemption disabled until we are done with
+	 * softirq processing:
+ 	 */
+ 	sub_preempt_count(SOFTIRQ_OFFSET - 1);
+
+	if (unlikely(!in_interrupt() && local_softirq_pending()))
+		do_softirq();
+
+	dec_preempt_count();
+	local_irq_restore(flags);
+	preempt_check_resched();
+}
+EXPORT_SYMBOL(local_bh_enable);
+
+void local_bh_enable_ip(unsigned long ip)
+{
+	unsigned long flags;
+
+	WARN_ON_ONCE(in_irq());
+
+	local_irq_save(flags);
+	/*
+	 * Are softirqs going to be turned on now:
+	 */
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		trace_softirqs_on(ip);
+	/*
+	 * Keep preemption disabled until we are done with
+	 * softirq processing:
+ 	 */
+ 	sub_preempt_count(SOFTIRQ_OFFSET - 1);
+
+	if (unlikely(!in_interrupt() && local_softirq_pending()))
+		do_softirq();
+
+	dec_preempt_count();
+	local_irq_restore(flags);
+	preempt_check_resched();
+}
+EXPORT_SYMBOL(local_bh_enable_ip);
+
+/*
  * We restart softirq processing MAX_SOFTIRQ_RESTART times,
  * and we fall back to softirqd after that.
  *
@@ -80,8 +193,9 @@ asmlinkage void __do_softirq(void)
 	int cpu;
 
 	pending = local_softirq_pending();
+	__local_bh_disable((unsigned long)__builtin_return_address(0));
+	trace_softirq_enter();
 
-	local_bh_disable();
 	cpu = smp_processor_id();
 restart:
 	/* Reset the pending bitmask before enabling irqs */
@@ -109,7 +223,8 @@ restart:
 	if (pending)
 		wakeup_softirqd();
 
-	__local_bh_enable();
+	trace_softirq_exit();
+	_local_bh_enable();
 }
 
 #ifndef __ARCH_HAS_DO_SOFTIRQ
@@ -136,23 +251,6 @@ EXPORT_SYMBOL(do_softirq);
 
 #endif
 
-void local_bh_enable(void)
-{
-	WARN_ON(irqs_disabled());
-	/*
-	 * Keep preemption disabled until we are done with
-	 * softirq processing:
- 	 */
- 	sub_preempt_count(SOFTIRQ_OFFSET - 1);
-
-	if (unlikely(!in_interrupt() && local_softirq_pending()))
-		do_softirq();
-
-	dec_preempt_count();
-	preempt_check_resched();
-}
-EXPORT_SYMBOL(local_bh_enable);
-
 #ifdef __ARCH_IRQ_EXIT_IRQS_DISABLED
 # define invoke_softirq()	__do_softirq()
 #else
@@ -165,6 +263,7 @@ EXPORT_SYMBOL(local_bh_enable);
 void irq_exit(void)
 {
 	account_system_vtime(current);
+	trace_hardirq_exit();
 	sub_preempt_count(IRQ_EXIT_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -19,6 +19,7 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
+#include <linux/trace_irqflags.h>
 
 /*
  * Change this to 1 if you want to see the failure printouts:
@@ -157,9 +158,11 @@ static void init_shared_types(void)
 #define SOFTIRQ_ENTER()				\
 		local_bh_disable();		\
 		local_irq_disable();		\
+		trace_softirq_enter();		\
 		WARN_ON(!in_softirq());
 
 #define SOFTIRQ_EXIT()				\
+		trace_softirq_exit();		\
 		local_irq_enable();		\
 		local_bh_enable();
 
