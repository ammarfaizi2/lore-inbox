Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWEPOVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWEPOVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWEPOVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:21:36 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25788
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751136AbWEPOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:21:35 -0400
Message-Id: <4469FC41.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 16:22:25 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH 3/3] reliable stack trace support (i386)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the i386-specific pieces to enable reliable stack traces. This is
going to be even more useful once CFI annotations get added to he assembly
code, namely to entry.S (a patch for that had been submitted several times).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.17-rc4/arch/i386/kernel/entry.S	2006-05-16 15:15:29.000000000 +0200
+++ 2.6.17-rc4-unwind-i386/arch/i386/kernel/entry.S	2006-05-16 15:16:46.000000000 +0200
@@ -663,6 +663,35 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+#ifdef CONFIG_STACK_UNWIND
+ENTRY(arch_unwind_init_running)
+	movl	4(%esp), %edx
+	movl	(%esp), %ecx
+	leal	4(%esp), %eax
+	movl	%ebx, EBX(%edx)
+	xorl	%ebx, %ebx
+	movl	%ebx, ECX(%edx)
+	movl	%ebx, EDX(%edx)
+	movl	%esi, ESI(%edx)
+	movl	%edi, EDI(%edx)
+	movl	%ebp, EBP(%edx)
+	movl	%ebx, EAX(%edx)
+	movl	$__USER_DS, DS(%edx)
+	movl	$__USER_DS, ES(%edx)
+	movl	%ebx, ORIG_EAX(%edx)
+	movl	%ecx, EIP(%edx)
+	movl	12(%esp), %ecx
+	movl	$__KERNEL_CS, CS(%edx)
+	movl	%ebx, EFLAGS(%edx)
+	movl	%eax, OLDESP(%edx)
+	movl	8(%esp), %eax
+	movl	%ecx, 8(%esp)
+	movl	EBX(%edx), %ebx
+	movl	$__KERNEL_DS, OLDSS(%edx)
+	jmpl	*%eax
+ENDPROC(arch_unwind_init_running)
+#endif
+
 .section .rodata,"a"
 #include "syscall_table.S"
 
--- linux-2.6.17-rc4/arch/i386/kernel/process.c	2006-05-16 15:15:29.000000000 +0200
+++ 2.6.17-rc4-unwind-i386/arch/i386/kernel/process.c	2006-05-16 15:16:46.000000000 +0200
@@ -312,7 +312,7 @@ void show_regs(struct pt_regs * regs)
 	cr3 = read_cr3();
 	cr4 = read_cr4_safe();
 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
-	show_trace(NULL, &regs->esp);
+	show_trace(NULL, regs, &regs->esp);
 }
 
 /*
--- linux-2.6.17-rc4/arch/i386/kernel/traps.c	2006-05-16 15:15:29.000000000 +0200
+++ 2.6.17-rc4-unwind-i386/arch/i386/kernel/traps.c	2006-05-16 15:42:38.000000000 +0200
@@ -47,7 +47,7 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 #include <asm/nmi.h>
-
+#include <asm/unwind.h>
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
@@ -165,14 +165,43 @@ static inline unsigned long print_contex
 	return ebp;
 }
 
-static void show_trace_log_lvl(struct task_struct *task,
+static asmlinkage void show_trace_unwind(struct unwind_frame_info *info, void *log_lvl)
+{
+	int printed = 0; /* nr of entries already printed on current line */
+
+	while (unwind(info) == 0 && UNW_PC(info)) {
+		printed = print_addr_and_symbol(UNW_PC(info), log_lvl, printed);
+		if (arch_unw_user_mode(info))
+			break;
+	}
+	if (printed)
+		printk("\n");
+}
+
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			       unsigned long *stack, char *log_lvl)
 {
 	unsigned long ebp;
+	struct unwind_frame_info info;
 
 	if (!task)
 		task = current;
 
+	if (regs) {
+		if (unwind_init_frame_info(&info, task, regs) == 0) {
+			show_trace_unwind(&info, log_lvl);
+			return;
+		}
+	} else if (task == current) {
+		if (unwind_init_running(&info, show_trace_unwind, log_lvl) == 0)
+			return;
+	} else {
+		if (unwind_init_blocked(&info, task) == 0) {
+			show_trace_unwind(&info, log_lvl);
+			return;
+		}
+	}
+
 	if (task == current) {
 		/* Grab ebp right from our regs */
 		asm ("movl %%ebp, %0" : "=r" (ebp) : );
@@ -193,13 +222,13 @@ static void show_trace_log_lvl(struct ta
 	}
 }
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+void show_trace(struct task_struct *task, struct pt_regs *regs, unsigned long * stack)
 {
-	show_trace_log_lvl(task, stack, "");
+	show_trace_log_lvl(task, regs, stack, "");
 }
 
-static void show_stack_log_lvl(struct task_struct *task, unsigned long *esp,
-			       char *log_lvl)
+static void show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
+			       unsigned long *esp, char *log_lvl)
 {
 	unsigned long *stack;
 	int i;
@@ -221,13 +250,13 @@ static void show_stack_log_lvl(struct ta
 		printk("%08lx ", *stack++);
 	}
 	printk("\n%sCall Trace:\n", log_lvl);
-	show_trace_log_lvl(task, esp, log_lvl);
+	show_trace_log_lvl(task, regs, esp, log_lvl);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
 	printk("       ");
-	show_stack_log_lvl(task, esp, "");
+	show_stack_log_lvl(task, NULL, esp, "");
 }
 
 /*
@@ -237,7 +266,7 @@ void dump_stack(void)
 {
 	unsigned long stack;
 
-	show_trace(current, &stack);
+	show_trace(current, NULL, &stack);
 }
 
 EXPORT_SYMBOL(dump_stack);
@@ -280,7 +309,7 @@ void show_registers(struct pt_regs *regs
 		u8 __user *eip;
 
 		printk("\n" KERN_EMERG "Stack: ");
-		show_stack_log_lvl(NULL, (unsigned long *)esp, KERN_EMERG);
+		show_stack_log_lvl(NULL, regs, (unsigned long *)esp, KERN_EMERG);
 
 		printk(KERN_EMERG "Code: ");
 
--- linux-2.6.17-rc4/arch/i386/kernel/vmlinux.lds.S	2006-05-16 15:15:29.000000000 +0200
+++ 2.6.17-rc4-unwind-i386/arch/i386/kernel/vmlinux.lds.S	2006-05-16 15:16:46.000000000 +0200
@@ -64,6 +64,15 @@ SECTIONS
   .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
   _edata = .;			/* End of data section */
 
+#ifdef CONFIG_STACK_UNWIND
+  . = ALIGN(4);
+  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
+	__start_unwind = .;
+  	*(.eh_frame)
+	__end_unwind = .;
+  }
+#endif
+
   . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
--- linux-2.6.17-rc4/include/asm-i386/processor.h	2006-05-16 15:15:47.000000000 +0200
+++ 2.6.17-rc4-unwind-i386/include/asm-i386/processor.h	2006-05-16 15:16:46.000000000 +0200
@@ -555,7 +555,7 @@ extern void prepare_to_copy(struct task_
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
-void show_trace(struct task_struct *task, unsigned long *stack);
+void show_trace(struct task_struct *task, struct pt_regs *regs, unsigned long *stack);
 
 unsigned long get_wchan(struct task_struct *p);
 
--- linux-2.6.17-rc4/include/asm-i386/unwind.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.17-rc4-unwind-i386/include/asm-i386/unwind.h	2006-05-16 15:47:41.000000000 +0200
@@ -0,0 +1,97 @@
+#ifndef _ASM_I386_UNWIND_H
+#define _ASM_I386_UNWIND_H
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
+#define UNW_PC(frame) (frame)->regs.eip
+#define UNW_SP(frame) (frame)->regs.esp
+#ifdef CONFIG_FRAME_POINTER
+#define UNW_FP(frame) (frame)->regs.ebp
+#define FRAME_RETADDR_OFFSET 4
+#define FRAME_LINK_OFFSET 0
+#define STACK_BOTTOM(tsk) (((tsk)->thread.esp0 - 1) & ~(THREAD_SIZE - 1))
+#define STACK_TOP(tsk) ((tsk)->thread.esp0)
+#endif
+
+#define UNW_REGISTER_INFO \
+	PTREGS_INFO(eax), \
+	PTREGS_INFO(ecx), \
+	PTREGS_INFO(edx), \
+	PTREGS_INFO(ebx), \
+	PTREGS_INFO(esp), \
+	PTREGS_INFO(ebp), \
+	PTREGS_INFO(esi), \
+	PTREGS_INFO(edi), \
+	PTREGS_INFO(eip)
+
+static inline void
+arch_unw_init_frame_info(struct unwind_frame_info *info, /*const*/ struct pt_regs *regs)
+{
+	if (user_mode_vm(regs))
+		info->regs = *regs;
+	else {
+		memcpy(&info->regs, regs, offsetof(struct pt_regs, esp));
+		info->regs.esp = (unsigned long)&regs->esp;
+		info->regs.xss = __KERNEL_DS;
+	}
+}
+
+static inline void
+arch_unw_init_blocked(struct unwind_frame_info *info)
+{
+	memset(&info->regs, 0, sizeof(info->regs));
+	info->regs.eip = info->task->thread.eip;
+	info->regs.xcs = __KERNEL_CS;
+	__get_user(info->regs.ebp, (long *)info->task->thread.esp);
+	info->regs.esp = info->task->thread.esp;
+	info->regs.xss = __KERNEL_DS;
+	info->regs.xds = __USER_DS;
+	info->regs.xes = __USER_DS;
+}
+
+extern asmlinkage void
+arch_unwind_init_running(struct unwind_frame_info *,
+                         asmlinkage void (*callback)(struct unwind_frame_info *, void *arg),
+                         void *arg);
+
+static inline int
+arch_unw_user_mode(const struct unwind_frame_info *info)
+{
+#if 0 /* This can only work when selector register and EFLAGS saves/restores
+         are properly annotated (and tracked in UNW_REGISTER_INFO). */
+	return user_mode_vm(&info->regs);
+#else
+	return info->regs.eip < PAGE_OFFSET;
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
+#endif /* _ASM_I386_UNWIND_H */
--- linux-2.6.17-rc4/lib/Kconfig.debug	2006-05-16 15:15:49.000000000 +0200
+++ 2.6.17-rc4-unwind-i386/lib/Kconfig.debug	2006-05-16 15:16:46.000000000 +0200
@@ -199,7 +199,7 @@ config UNWIND_INFO
 config STACK_UNWIND
 	bool "Stack unwind support"
 	depends on UNWIND_INFO
-	depends on X86_64
+	depends on X86
 	help
 	  This enables more precise stack traces, omitting all unrelated
 	  occurrences of pointers into kernel code from the dump.


