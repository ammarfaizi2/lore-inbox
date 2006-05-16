Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWEPOVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWEPOVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWEPOVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:21:06 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20156
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751131AbWEPOVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:21:05 -0400
Message-Id: <4469FC22.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 16:21:54 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH 2/3] reliable stack trace support (x86-64)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the x86_64-specific pieces to enable reliable stack traces. The
only restriction with this is that it currently cannot unwind across the
interrupt->normal stack boundary, as that transition is lacking proper
annotation.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.17-rc4/arch/x86_64/kernel/entry.S	2006-05-16 15:15:32.000000000 +0200
+++ 2.6.17-rc4-unwind-x86_64/arch/x86_64/kernel/entry.S	2006-05-16 15:16:38.000000000 +0200
@@ -1051,3 +1051,36 @@ ENTRY(call_softirq)
 	decl %gs:pda_irqcount
 	ret
 	CFI_ENDPROC
+
+#ifdef CONFIG_STACK_UNWIND
+ENTRY(arch_unwind_init_running)
+	CFI_STARTPROC
+	movq	%r15, R15(%rdi)
+	movq	%r14, R14(%rdi)
+	xchgq	%rsi, %rdx
+	movq	%r13, R13(%rdi)
+	movq	%r12, R12(%rdi)
+	xorl	%eax, %eax
+	movq	%rbp, RBP(%rdi)
+	movq	%rbx, RBX(%rdi)
+	movq	(%rsp), %rcx
+	movq	%rax, R11(%rdi)
+	movq	%rax, R10(%rdi)
+	movq	%rax, R9(%rdi)
+	movq	%rax, R8(%rdi)
+	movq	%rax, RAX(%rdi)
+	movq	%rax, RCX(%rdi)
+	movq	%rax, RDX(%rdi)
+	movq	%rax, RSI(%rdi)
+	movq	%rax, RDI(%rdi)
+	movq	%rax, ORIG_RAX(%rdi)
+	movq	%rcx, RIP(%rdi)
+	leaq	8(%rsp), %rcx
+	movq	$__KERNEL_CS, CS(%rdi)
+	movq	%rax, EFLAGS(%rdi)
+	movq	%rcx, RSP(%rdi)
+	movq	$__KERNEL_DS, SS(%rdi)
+	jmpq	*%rdx
+	CFI_ENDPROC
+ENDPROC(arch_unwind_init_running)
+#endif
--- linux-2.6.17-rc4/arch/x86_64/kernel/process.c	2006-05-16 15:15:32.000000000 +0200
+++ 2.6.17-rc4-unwind-x86_64/arch/x86_64/kernel/process.c	2006-05-16 15:16:38.000000000 +0200
@@ -335,7 +335,7 @@ void show_regs(struct pt_regs *regs)
 {
 	printk("CPU %d:", smp_processor_id());
 	__show_regs(regs);
-	show_trace(&regs->rsp);
+	show_trace(NULL, regs, (void *)(regs + 1));
 }
 
 /*
--- linux-2.6.17-rc4/arch/x86_64/kernel/traps.c	2006-05-16 15:15:32.000000000 +0200
+++ 2.6.17-rc4-unwind-x86_64/arch/x86_64/kernel/traps.c	2006-05-16 15:16:38.000000000 +0200
@@ -41,7 +41,7 @@
 #include <asm/i387.h>
 #include <asm/kdebug.h>
 #include <asm/processor.h>
-
+#include <asm/unwind.h>
 #include <asm/smp.h>
 #include <asm/pgalloc.h>
 #include <asm/pda.h>
@@ -189,6 +189,23 @@ static unsigned long *in_exception_stack
 	return NULL;
 }
 
+static void show_trace_unwind(struct unwind_frame_info *info, void *context)
+{
+	int i = 11;
+
+	while (unwind(info) == 0 && UNW_PC(info)) {
+		if (i > 50) {
+			printk("\n       ");
+			i = 7;
+		} else
+			i += printk(" ");
+		i += printk_address(UNW_PC(info));
+		if (arch_unw_user_mode(info))
+			break;
+	}
+	printk("\n");
+}
+
 /*
  * x86-64 can have upto three kernel stacks: 
  * process stack
@@ -196,15 +213,34 @@ static unsigned long *in_exception_stack
  * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
  */
 
-void show_trace(unsigned long *stack)
+void show_trace(struct task_struct *tsk, struct pt_regs *regs, unsigned long * stack)
 {
 	const unsigned cpu = safe_smp_processor_id();
 	unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
 	int i;
 	unsigned used = 0;
+	struct unwind_frame_info info;
 
 	printk("\nCall Trace:");
 
+	if (!tsk)
+		tsk = current;
+
+	if (regs) {
+		if (unwind_init_frame_info(&info, tsk, regs) == 0) {
+			show_trace_unwind(&info, NULL);
+			return;
+		}
+	} else if (tsk == current) {
+		if (unwind_init_running(&info, show_trace_unwind, NULL) == 0)
+			return;
+	} else {
+		if (unwind_init_blocked(&info, tsk) == 0) {
+			show_trace_unwind(&info, NULL);
+			return;
+		}
+	}
+
 #define HANDLE_STACK(cond) \
 	do while (cond) { \
 		unsigned long addr = *stack++; \
@@ -262,7 +298,7 @@ void show_trace(unsigned long *stack)
 	printk("\n");
 }
 
-void show_stack(struct task_struct *tsk, unsigned long * rsp)
+static void _show_stack(struct task_struct *tsk, struct pt_regs *regs, unsigned long * rsp)
 {
 	unsigned long *stack;
 	int i;
@@ -296,7 +332,12 @@ void show_stack(struct task_struct *tsk,
 		printk("%016lx ", *stack++);
 		touch_nmi_watchdog();
 	}
-	show_trace((unsigned long *)rsp);
+	show_trace(tsk, regs, rsp);
+}
+
+void show_stack(struct task_struct *tsk, unsigned long * rsp)
+{
+	_show_stack(tsk, NULL, rsp);
 }
 
 /*
@@ -305,7 +346,7 @@ void show_stack(struct task_struct *tsk,
 void dump_stack(void)
 {
 	unsigned long dummy;
-	show_trace(&dummy);
+	show_trace(NULL, NULL, &dummy);
 }
 
 EXPORT_SYMBOL(dump_stack);
@@ -332,7 +373,7 @@ void show_registers(struct pt_regs *regs
 	if (in_kernel) {
 
 		printk("Stack: ");
-		show_stack(NULL, (unsigned long*)rsp);
+		_show_stack(NULL, regs, (unsigned long*)rsp);
 
 		printk("\nCode: ");
 		if (regs->rip < PAGE_OFFSET)
--- linux-2.6.17-rc4/arch/x86_64/kernel/vmlinux.lds.S	2006-05-16 15:15:32.000000000 +0200
+++ 2.6.17-rc4-unwind-x86_64/arch/x86_64/kernel/vmlinux.lds.S	2006-05-16 15:16:38.000000000 +0200
@@ -45,6 +45,15 @@ SECTIONS
 
   RODATA
 
+#ifdef CONFIG_STACK_UNWIND
+  . = ALIGN(8);
+  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
+	__start_unwind = .;
+  	*(.eh_frame)
+	__end_unwind = .;
+  }
+#endif
+
 				/* Data */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
--- linux-2.6.17-rc4/include/asm-x86_64/proto.h	2006-05-16 15:15:48.000000000 +0200
+++ 2.6.17-rc4-unwind-x86_64/include/asm-x86_64/proto.h	2006-05-16 15:16:38.000000000 +0200
@@ -75,7 +75,7 @@ extern void main_timer_handler(struct pt
 
 extern unsigned long end_pfn_map; 
 
-extern void show_trace(unsigned long * rsp);
+extern void show_trace(struct task_struct *, struct pt_regs *, unsigned long * rsp);
 extern void show_registers(struct pt_regs *regs);
 
 extern void exception_table_check(void);
--- linux-2.6.17-rc4/include/asm-x86_64/unwind.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.17-rc4-unwind-x86_64/include/asm-x86_64/unwind.h	2006-05-16 15:46:46.000000000 +0200
@@ -0,0 +1,99 @@
+#ifndef _ASM_X86_64_UNWIND_H
+#define _ASM_X86_64_UNWIND_H
+
+/*
+ * Copyright (C) 2002-2006 Novell, Inc.
+ *	Jan Beulich <jbeulich@novell.com>
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_STACK_UNWIND
+
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+
+struct unwind_frame_info {
+	struct pt_regs regs;
+	struct task_struct *task;
+};
+
+#define UNW_PC(frame) (frame)->regs.rip
+#define UNW_SP(frame) (frame)->regs.rsp
+#ifdef CONFIG_FRAME_POINTER
+#define UNW_FP(frame) (frame)->regs.rbp
+#define FRAME_RETADDR_OFFSET 8
+#define FRAME_LINK_OFFSET 0
+#define STACK_BOTTOM(tsk) (((tsk)->thread.rsp0 - 1) & ~(THREAD_SIZE - 1))
+#define STACK_TOP(tsk) ((tsk)->thread.rsp0)
+#endif
+
+#define UNW_REGISTER_INFO \
+	PTREGS_INFO(rax), \
+	PTREGS_INFO(rdx), \
+	PTREGS_INFO(rcx), \
+	PTREGS_INFO(rbx), \
+	PTREGS_INFO(rsi), \
+	PTREGS_INFO(rdi), \
+	PTREGS_INFO(rbp), \
+	PTREGS_INFO(rsp), \
+	PTREGS_INFO(r8), \
+	PTREGS_INFO(r9), \
+	PTREGS_INFO(r10), \
+	PTREGS_INFO(r11), \
+	PTREGS_INFO(r12), \
+	PTREGS_INFO(r13), \
+	PTREGS_INFO(r14), \
+	PTREGS_INFO(r15), \
+	PTREGS_INFO(rip)
+
+static inline void
+arch_unw_init_frame_info(struct unwind_frame_info *info, /*const*/ struct pt_regs *regs)
+{
+	info->regs = *regs;
+}
+
+static inline void
+arch_unw_init_blocked(struct unwind_frame_info *info)
+{
+	extern const char thread_return[];
+
+	memset(&info->regs, 0, sizeof(info->regs));
+	info->regs.rip = (unsigned long)thread_return;
+	info->regs.cs = __KERNEL_CS;
+	__get_user(info->regs.rbp, (unsigned long *)info->task->thread.rsp);
+	info->regs.rsp = info->task->thread.rsp;
+	info->regs.ss = __KERNEL_DS;
+}
+
+extern void
+arch_unwind_init_running(struct unwind_frame_info *,
+                         void (*callback)(struct unwind_frame_info *, void *arg),
+                         void *arg);
+
+static inline int
+arch_unw_user_mode(const struct unwind_frame_info *info)
+{
+#if 0 /* This can only work when selector register saves/restores
+         are properly annotated (and tracked in UNW_REGISTER_INFO). */
+	return user_mode(&info->regs);
+#else
+	return (long)info->regs.rip >= 0;
+#endif
+}
+
+#else
+
+#define UNW_PC(frame) ((void)(frame), 0)
+
+static inline int
+arch_unw_user_mode(const void *info)
+{
+	return 0;
+}
+
+#endif
+
+#include <asm-generic/unwind.h>
+
+#endif /* _ASM_X86_64_UNWIND_H */
--- linux-2.6.17-rc4/lib/Kconfig.debug	2006-05-16 15:15:49.000000000 +0200
+++ 2.6.17-rc4-unwind-x86_64/lib/Kconfig.debug	2006-05-16 15:16:46.000000000 +0200
@@ -199,7 +199,7 @@ config UNWIND_INFO
 config STACK_UNWIND
 	bool "Stack unwind support"
 	depends on UNWIND_INFO
-	depends on n
+	depends on X86_64
 	help
 	  This enables more precise stack traces, omitting all unrelated
 	  occurrences of pointers into kernel code from the dump.


