Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUKBU5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUKBU5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUKBU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:57:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:50369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261375AbUKBU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:56:57 -0500
Date: Tue, 2 Nov 2004 12:56:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: avoid asmlinkage on x86 traps/interrupts
Message-ID: <Pine.LNX.4.58.0411021250310.2187@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the second part of a gradual change from using stack argument
passing to using register argument passing for a number of assembly
interfaces. As covered in previous discussions, this has the advantage of
havign the caller/callee agree on the ownership of the arguments (well, at
least the three first ones), and thus gcc won't occasionally possibly 
corrupt the stack frame that assembly code believes it owns.

It also removes a few instructions when we can pass arguments in registers
in most places. In other places it adds a "movl %esp,%eax", though, as
some cases used to just rely on knowing the saved stack layout and use
that directly as the arguments.. So it's not really a big win either way,
and the real motivation for this is to move away from the argument
ownership questions.

No other architecture should care, since for most of them "asmlinkage" vs
"fastcall" is a no-op, and when that isn't true (like on ia64) as far as I 
can tell all the actual call-sites in this patch were all in C code for 
the routines that were changed. But architecture maintainers should 
probably take a quick look to verify.

		Linus

-----
===== arch/i386/kernel/entry.S 1.86 vs edited =====
--- 1.86/arch/i386/kernel/entry.S	2004-10-24 03:32:48 -07:00
+++ edited/arch/i386/kernel/entry.S	2004-11-02 10:56:48 -08:00
@@ -131,7 +131,7 @@
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es; \
-	pushl $11;	\
+	movl $11,%eax;	\
 	call do_exit;	\
 .previous;		\
 .section __ex_table,"a";\
@@ -291,8 +291,8 @@
 
 	ALIGN
 work_notifysig_v86:
-	pushl %ecx
-	call save_v86_state
+	pushl %ecx			# save ti_flags for do_notify_resume
+	call save_v86_state		# %eax contains pt_regs pointer
 	popl %ecx
 	movl %eax, %esp
 	xorl %edx, %edx
@@ -359,6 +359,7 @@
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	movl %esp,%eax
 	call do_IRQ
 	jmp ret_from_intr
 
@@ -366,7 +367,8 @@
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	movl %esp,%eax;			\
+	call smp_/**/name;		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */
@@ -389,18 +391,15 @@
 	pushl %ebx
 	cld
 	movl %es, %ecx
-	movl ORIG_EAX(%esp), %esi	# get the error code
 	movl ES(%esp), %edi		# get the function address
+	movl ORIG_EAX(%esp), %edx	# get the error code
 	movl %eax, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
-	movl %esp, %edx
-	pushl %esi			# push the error code
-	pushl %edx			# push the pt_regs pointer
-	movl $(__USER_DS), %edx
-	movl %edx, %ds
-	movl %edx, %es
+	movl $(__USER_DS), %ecx
+	movl %ecx, %ds
+	movl %ecx, %es
+	movl %esp,%eax			# pt_regs pointer
 	call *%edi
-	addl $8, %esp
 	jmp ret_from_exception
 
 ENTRY(coprocessor_error)
@@ -457,11 +456,9 @@
 debug_stack_correct:
 	pushl $-1			# mark this as an int
 	SAVE_ALL
-	movl %esp,%edx
-  	pushl $0
-	pushl %edx
+	xorl %edx,%edx			# error code 0
+	movl %esp,%eax			# pt_regs pointer
 	call do_debug
-	addl $8,%esp
 	testl %eax,%eax
 	jnz restore_all
 	jmp ret_from_exception
@@ -491,11 +488,9 @@
 nmi_stack_correct:
 	pushl %eax
 	SAVE_ALL
-	movl %esp, %edx
-	pushl $0
-	pushl %edx
+	xorl %edx,%edx		# zero error code
+	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
-	addl $8, %esp
 	RESTORE_ALL
 
 nmi_stack_fixup:
@@ -515,11 +510,9 @@
 ENTRY(int3)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
-	movl %esp,%edx
-	pushl $0
-	pushl %edx
+	xorl %edx,%edx		# zero error code
+	movl %esp,%eax		# pt_regs pointer
 	call do_int3
-	addl $8,%esp
 	testl %eax,%eax
 	jnz restore_all
 	jmp ret_from_exception
===== arch/i386/kernel/irq.c 1.60 vs edited =====
--- 1.60/arch/i386/kernel/irq.c	2004-10-18 22:26:39 -07:00
+++ edited/arch/i386/kernel/irq.c	2004-11-02 11:35:33 -08:00
@@ -45,10 +45,10 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+fastcall unsigned int do_IRQ(struct pt_regs *regs)
 {	
 	/* high bits used in ret_from_ code */
-	int irq = regs.orig_eax & 0xff;
+	int irq = regs->orig_eax & 0xff;
 #ifdef CONFIG_4KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
@@ -82,24 +82,24 @@
 	 * current stack (which is the irq stack already after all)
 	 */
 	if (curctx != irqctx) {
+		int arg1, arg2, ebx;
+
 		/* build the stack frame on the IRQ stack */
 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
 		irqctx->tinfo.task = curctx->tinfo.task;
 		irqctx->tinfo.previous_esp = current_stack_pointer();
 
-		*--isp = (u32) &regs;
-		*--isp = (u32) irq;
-
 		asm volatile(
 			"       xchgl   %%ebx,%%esp      \n"
 			"       call    __do_IRQ         \n"
-			"       xchgl   %%ebx,%%esp      \n"
-			: : "b"(isp)
-			: "memory", "cc", "eax", "edx", "ecx"
+			"       movl   %%ebx,%%esp      \n"
+			: "=a" (arg1), "=d" (arg2), "=b" (ebx)
+			:  "0" (irq),   "1" (regs),  "2" (isp)
+			: "memory", "cc", "ecx"
 		);
 	} else
 #endif
-		__do_IRQ(irq, &regs);
+		__do_IRQ(irq, regs);
 
 	irq_exit();
 
===== arch/i386/kernel/traps.c 1.87 vs edited =====
--- 1.87/arch/i386/kernel/traps.c	2004-10-18 22:26:45 -07:00
+++ edited/arch/i386/kernel/traps.c	2004-11-02 09:50:51 -08:00
@@ -404,7 +404,7 @@
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+fastcall void do_##name(struct pt_regs * regs, long error_code) \
 { \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
 						== NOTIFY_STOP) \
@@ -413,7 +413,7 @@
 }
 
 #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+fastcall void do_##name(struct pt_regs * regs, long error_code) \
 { \
 	siginfo_t info; \
 	info.si_signo = signr; \
@@ -427,7 +427,7 @@
 }
 
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+fastcall void do_##name(struct pt_regs * regs, long error_code) \
 { \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
 						== NOTIFY_STOP) \
@@ -436,7 +436,7 @@
 }
 
 #define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+fastcall void do_##name(struct pt_regs * regs, long error_code) \
 { \
 	siginfo_t info; \
 	info.si_signo = signr; \
@@ -462,7 +462,7 @@
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
 
-asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
+fastcall void do_general_protection(struct pt_regs * regs, long error_code)
 {
 	int cpu = get_cpu();
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
@@ -622,7 +622,7 @@
  
 static nmi_callback_t nmi_callback = dummy_nmi_callback;
  
-asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+fastcall void do_nmi(struct pt_regs * regs, long error_code)
 {
 	int cpu;
 
@@ -648,7 +648,7 @@
 }
 
 #ifdef CONFIG_KPROBES
-asmlinkage int do_int3(struct pt_regs *regs, long error_code)
+fastcall int do_int3(struct pt_regs *regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
 			== NOTIFY_STOP)
@@ -683,7 +683,7 @@
  * find every occurrence of the TF bit that could be saved away even
  * by user code)
  */
-asmlinkage void do_debug(struct pt_regs * regs, long error_code)
+fastcall void do_debug(struct pt_regs * regs, long error_code)
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
@@ -822,7 +822,7 @@
 	force_sig_info(SIGFPE, &info, task);
 }
 
-asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
+fastcall void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
 	ignore_fpu_irq = 1;
 	math_error((void __user *)regs->eip);
@@ -876,7 +876,7 @@
 	force_sig_info(SIGFPE, &info, task);
 }
 
-asmlinkage void do_simd_coprocessor_error(struct pt_regs * regs,
+fastcall void do_simd_coprocessor_error(struct pt_regs * regs,
 					  long error_code)
 {
 	if (cpu_has_xmm) {
@@ -900,7 +900,7 @@
 	}
 }
 
-asmlinkage void do_spurious_interrupt_bug(struct pt_regs * regs,
+fastcall void do_spurious_interrupt_bug(struct pt_regs * regs,
 					  long error_code)
 {
 #if 0
===== arch/i386/kernel/cpu/mcheck/p4.c 1.6 vs edited =====
--- 1.6/arch/i386/kernel/cpu/mcheck/p4.c	2004-10-19 02:40:29 -07:00
+++ edited/arch/i386/kernel/cpu/mcheck/p4.c	2004-11-02 10:17:55 -08:00
@@ -70,10 +70,10 @@
 /* Thermal interrupt handler for this CPU setup */
 static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
 
-asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
+fastcall void smp_thermal_interrupt(struct pt_regs *regs)
 {
 	irq_enter();
-	vendor_thermal_interrupt(&regs);
+	vendor_thermal_interrupt(regs);
 	irq_exit();
 }
 
===== arch/i386/mm/fault.c 1.40 vs edited =====
--- 1.40/arch/i386/mm/fault.c	2004-10-02 21:04:57 -07:00
+++ edited/arch/i386/mm/fault.c	2004-11-02 10:57:11 -08:00
@@ -201,7 +201,7 @@
 	return 0;
 } 
 
-asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
+fastcall void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -213,7 +213,7 @@
  *	bit 1 == 0 means read, 1 means write
  *	bit 2 == 0 means kernel, 1 means user-mode
  */
-asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+fastcall void do_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
===== include/asm-i386/hw_irq.h 1.33 vs edited =====
--- 1.33/include/asm-i386/hw_irq.h	2004-10-18 22:26:39 -07:00
+++ edited/include/asm-i386/hw_irq.h	2004-11-02 12:40:10 -08:00
@@ -32,16 +32,16 @@
 extern void (*interrupt[NR_IRQS])(void);
 
 #ifdef CONFIG_SMP
-asmlinkage void reschedule_interrupt(void);
-asmlinkage void invalidate_interrupt(void);
-asmlinkage void call_function_interrupt(void);
+fastcall void reschedule_interrupt(void);
+fastcall void invalidate_interrupt(void);
+fastcall void call_function_interrupt(void);
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-asmlinkage void apic_timer_interrupt(void);
-asmlinkage void error_interrupt(void);
-asmlinkage void spurious_interrupt(void);
-asmlinkage void thermal_interrupt(struct pt_regs);
+fastcall void apic_timer_interrupt(void);
+fastcall void error_interrupt(void);
+fastcall void spurious_interrupt(void);
+fastcall void thermal_interrupt(struct pt_regs *);
 #define platform_legacy_irq(irq)	((irq) < 16)
 #endif
 
===== include/linux/irq.h 1.12 vs edited =====
--- 1.12/include/linux/irq.h	2004-10-18 22:26:45 -07:00
+++ edited/include/linux/irq.h	2004-11-02 12:42:41 -08:00
@@ -79,9 +79,9 @@
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
-extern asmlinkage int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 				       struct irqaction *action);
-extern asmlinkage unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
+extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc, int action_ret);
 extern void report_bad_irq(unsigned int irq, irq_desc_t *desc, int action_ret);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
===== include/linux/kernel.h 1.56 vs edited =====
--- 1.56/include/linux/kernel.h	2004-10-19 02:40:29 -07:00
+++ edited/include/linux/kernel.h	2004-11-02 10:21:35 -08:00
@@ -68,7 +68,7 @@
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
-asmlinkage NORET_TYPE void do_exit(long error_code)
+fastcall NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
 	ATTRIB_NORET;
===== kernel/exit.c 1.165 vs edited =====
--- 1.165/kernel/exit.c	2004-10-25 13:06:46 -07:00
+++ edited/kernel/exit.c	2004-11-02 09:51:26 -08:00
@@ -780,7 +780,7 @@
 	tsk->flags |= PF_DEAD;
 }
 
-asmlinkage NORET_TYPE void do_exit(long code)
+fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
 	int group_dead;
===== kernel/irq/handle.c 1.2 vs edited =====
--- 1.2/kernel/irq/handle.c	2004-10-18 23:58:41 -07:00
+++ edited/kernel/irq/handle.c	2004-11-02 12:42:54 -08:00
@@ -86,7 +86,7 @@
 /*
  * Have got an event to handle:
  */
-asmlinkage int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 				struct irqaction *action)
 {
 	int ret, retval = 0, status = 0;
@@ -114,7 +114,7 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
+fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
