Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWFVI1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWFVI1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFVI1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:27:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54202 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932337AbWFVI1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:27:22 -0400
Date: Thu, 22 Jun 2006 10:22:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch] lock validator: reenable NMIs
Message-ID: <20060622082221.GA25222@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: reenable NMIs
From: Ingo Molnar <mingo@elte.hu>

- not touch the irqtrace state in NMI handlers
- re-enable NMIs and oprofile on i386 and x86_64

i have tested this with high-rate (10 KHz per CPU) NMI load on the 
kernel, and while previously we'd quickly get the irqtrace state 
confused and a lock validator bug message, with this patch applied it's 
now working fine.

(note that on x86_64 we only build one variant of the paranoid-exit
codepath if IRQTRACE is disabled - so there should be no difference
in code generated, as long as the validator is disabled)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/nmi.c       |   10 ---
 arch/i386/oprofile/Kconfig   |    2 
 arch/x86_64/kernel/entry.S   |  133 ++++++++++++++++++++++++-------------------
 arch/x86_64/kernel/nmi.c     |   11 ---
 arch/x86_64/oprofile/Kconfig |    2 
 include/linux/hardirq.h      |    4 -
 kernel/lockdep.c             |   16 ++---
 7 files changed, 89 insertions(+), 89 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -747,16 +747,6 @@ void setup_apic_nmi_watchdog (void *unus
 {
 	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 
-#ifdef CONFIG_LOCKDEP
-	/*
-	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
-	 * so it's not lockdep-safe:
-	 */
-	nmi_watchdog = NMI_NONE;
-	printk("lockdep: disabled NMI watchdog.\n");
-
-	return;
-#endif
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
Index: linux/arch/i386/oprofile/Kconfig
===================================================================
--- linux.orig/arch/i386/oprofile/Kconfig
+++ linux/arch/i386/oprofile/Kconfig
@@ -7,7 +7,7 @@ config PROFILING
 
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING && !LOCKDEP
+	depends on PROFILING
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -718,7 +718,7 @@ END(spurious_interrupt)
 
 	/* error code is on the stack already */
 	/* handle NMI like exceptions that can happen everywhere */
-	.macro paranoidentry sym, ist=0
+	.macro paranoidentry sym, ist=0, irqtrace=1
 	SAVE_ALL
 	cld
 	movl $1,%ebx
@@ -743,9 +743,73 @@ END(spurious_interrupt)
 	addq	$EXCEPTION_STKSZ, per_cpu__init_tss + TSS_ist + (\ist - 1) * 8(%rbp)
 	.endif
 	cli
+	.if \irqtrace
 	TRACE_IRQS_OFF
+	.endif
 	.endm
-	
+
+	/*
+ 	 * "Paranoid" exit path from exception stack.
+  	 * Paranoid because this is used by NMIs and cannot take
+	 * any kernel state for granted.
+	 * We don't do kernel preemption checks here, because only
+	 * NMI should be common and it does not enable IRQs and
+	 * cannot get reschedule ticks.
+	 *
+	 * "trace" is 0 for the NMI handler only, because irq-tracing
+	 * is fundamentally NMI-unsafe. (we cannot change the soft and
+	 * hard flags at once, atomically)
+	 */
+	.macro paranoidexit trace=1
+	/* ebx:	no swapgs flag */
+paranoid_exit\trace:
+	testl %ebx,%ebx				/* swapgs needed? */
+	jnz paranoid_restore\trace
+	testl $3,CS(%rsp)
+	jnz   paranoid_userspace\trace
+paranoid_swapgs\trace:
+	TRACE_IRQS_IRETQ 0
+	swapgs
+paranoid_restore\trace:
+	RESTORE_ALL 8
+	iretq
+paranoid_userspace\trace:
+	GET_THREAD_INFO(%rcx)
+	movl threadinfo_flags(%rcx),%ebx
+	andl $_TIF_WORK_MASK,%ebx
+	jz paranoid_swapgs\trace
+	movq %rsp,%rdi			/* &pt_regs */
+	call sync_regs
+	movq %rax,%rsp			/* switch stack for scheduling */
+	testl $_TIF_NEED_RESCHED,%ebx
+	jnz paranoid_schedule\trace
+	movl %ebx,%edx			/* arg3: thread flags */
+	.if \trace
+	TRACE_IRQS_ON
+	.endif
+	sti
+	xorl %esi,%esi 			/* arg2: oldset */
+	movq %rsp,%rdi 			/* arg1: &pt_regs */
+	call do_notify_resume
+	cli
+	.if \trace
+	TRACE_IRQS_OFF
+	.endif
+	jmp paranoid_userspace\trace
+paranoid_schedule\trace:
+	.if \trace
+	TRACE_IRQS_ON
+	.endif
+	sti
+	call schedule
+	cli
+	.if \trace
+	TRACE_IRQS_OFF
+	.endif
+	jmp paranoid_userspace\trace
+	CFI_ENDPROC
+	.endm
+
 /*
  * Exception entry point. This expects an error code/orig_rax on the stack
  * and the exception handler in %rax.	
@@ -974,8 +1038,7 @@ KPROBE_ENTRY(debug)
 	pushq $0
 	CFI_ADJUST_CFA_OFFSET 8		
 	paranoidentry do_debug, DEBUG_STACK
-	jmp paranoid_exit
-	CFI_ENDPROC
+	paranoidexit
 END(debug)
 	.previous .text
 
@@ -984,54 +1047,12 @@ KPROBE_ENTRY(nmi)
 	INTR_FRAME
 	pushq $-1
 	CFI_ADJUST_CFA_OFFSET 8
-	paranoidentry do_nmi
-	/*
- 	 * "Paranoid" exit path from exception stack.
-  	 * Paranoid because this is used by NMIs and cannot take
-	 * any kernel state for granted.
-	 * We don't do kernel preemption checks here, because only
-	 * NMI should be common and it does not enable IRQs and
-	 * cannot get reschedule ticks.
-	 */
-	/* ebx:	no swapgs flag */
-paranoid_exit:
-	testl %ebx,%ebx				/* swapgs needed? */
-	jnz paranoid_restore
-	testl $3,CS(%rsp)
-	jnz   paranoid_userspace
-paranoid_swapgs:	
-	TRACE_IRQS_IRETQ 0
-	swapgs
-paranoid_restore:	
-	RESTORE_ALL 8
-	iretq
-paranoid_userspace:	
-	GET_THREAD_INFO(%rcx)
-	movl threadinfo_flags(%rcx),%ebx
-	andl $_TIF_WORK_MASK,%ebx
-	jz paranoid_swapgs
-	movq %rsp,%rdi			/* &pt_regs */
-	call sync_regs
-	movq %rax,%rsp			/* switch stack for scheduling */
-	testl $_TIF_NEED_RESCHED,%ebx
-	jnz paranoid_schedule
-	movl %ebx,%edx			/* arg3: thread flags */
-	TRACE_IRQS_ON
-	sti
-	xorl %esi,%esi 			/* arg2: oldset */
-	movq %rsp,%rdi 			/* arg1: &pt_regs */
-	call do_notify_resume
-	cli
-	TRACE_IRQS_OFF
-	jmp paranoid_userspace
-paranoid_schedule:
-	TRACE_IRQS_ON
-	sti
-	call schedule
-	cli
-	TRACE_IRQS_OFF
-	jmp paranoid_userspace
-	CFI_ENDPROC
+	paranoidentry do_nmi, 0, 0
+#ifdef CONFIG_TRACE_IRQFLAGS
+	paranoidexit 0
+#else
+	paranoidexit 1
+#endif
 END(nmi)
 	.previous .text
 
@@ -1040,7 +1061,7 @@ KPROBE_ENTRY(int3)
  	pushq $0
  	CFI_ADJUST_CFA_OFFSET 8
  	paranoidentry do_int3, DEBUG_STACK
- 	jmp paranoid_exit
+ 	jmp paranoid_exit1
  	CFI_ENDPROC
 END(int3)
 	.previous .text
@@ -1069,7 +1090,7 @@ END(reserved)
 ENTRY(double_fault)
 	XCPT_FRAME
 	paranoidentry do_double_fault
-	jmp paranoid_exit
+	jmp paranoid_exit1
 	CFI_ENDPROC
 END(double_fault)
 
@@ -1085,7 +1106,7 @@ END(segment_not_present)
 ENTRY(stack_segment)
 	XCPT_FRAME
 	paranoidentry do_stack_segment
-	jmp paranoid_exit
+	jmp paranoid_exit1
 	CFI_ENDPROC
 END(stack_segment)
 
@@ -1113,7 +1134,7 @@ ENTRY(machine_check)
 	pushq $0
 	CFI_ADJUST_CFA_OFFSET 8	
 	paranoidentry do_machine_check
-	jmp paranoid_exit
+	jmp paranoid_exit1
 	CFI_ENDPROC
 END(machine_check)
 #endif
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -674,17 +674,6 @@ void setup_apic_nmi_watchdog(void *unuse
 {
 	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 
-#ifdef CONFIG_LOCKDEP
-	/*
-	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
-	 * so it's not lockdep-safe:
-	 */
-	nmi_watchdog = NMI_NONE;
-	printk("lockdep: disabled NMI watchdog.\n");
-
-	return;
-#endif
-
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
Index: linux/arch/x86_64/oprofile/Kconfig
===================================================================
--- linux.orig/arch/x86_64/oprofile/Kconfig
+++ linux/arch/x86_64/oprofile/Kconfig
@@ -7,7 +7,7 @@ config PROFILING
 
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING && !LOCKDEP
+	depends on PROFILING
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
Index: linux/include/linux/hardirq.h
===================================================================
--- linux.orig/include/linux/hardirq.h
+++ linux/include/linux/hardirq.h
@@ -122,7 +122,7 @@ static inline void account_system_vtime(
  */
 extern void irq_exit(void);
 
-#define nmi_enter()		irq_enter()
-#define nmi_exit()		__irq_exit()
+#define nmi_enter()		do { lockdep_off(); irq_enter(); } while (0)
+#define nmi_exit()		do { __irq_exit(); lockdep_on(); } while (0)
 
 #endif /* LINUX_HARDIRQ_H */
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1869,7 +1869,7 @@ void trace_hardirqs_on(void)
 	struct task_struct *curr = current;
 	unsigned long ip;
 
-	if (unlikely(!debug_locks))
+	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
 	if (DEBUG_WARN_ON(unlikely(!early_boot_irqs_enabled)))
@@ -1916,7 +1916,7 @@ void trace_hardirqs_off(void)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks))
+	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
 	if (DEBUG_WARN_ON(!irqs_disabled()))
@@ -2488,16 +2488,16 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	if (unlikely(current->lockdep_recursion))
+		return;
+
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	if (unlikely(current->lockdep_recursion))
-		goto out;
 	current->lockdep_recursion = 1;
 	__lock_acquire(lock, subtype, trylock, read, check,
 		       irqs_disabled_flags(flags), ip);
 	current->lockdep_recursion = 0;
-out:
 	raw_local_irq_restore(flags);
 }
 
@@ -2507,14 +2507,14 @@ void lock_release(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	if (unlikely(current->lockdep_recursion))
+		return;
+
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	if (unlikely(current->lockdep_recursion))
-		goto out;
 	current->lockdep_recursion = 1;
 	__lock_release(lock, nested, ip);
 	current->lockdep_recursion = 0;
-out:
 	raw_local_irq_restore(flags);
 }
 
