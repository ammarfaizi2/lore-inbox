Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWHJT4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWHJT4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWHJTzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:55:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:17297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932659AbWHJThN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:13 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [113/145] i386: Do stacktracer conversion too
Message-Id: <20060810193711.DB8AD13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:11 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Following x86-64 patches. Reuses code from them in fact.

Convert the standard backtracer to do all output using
callbacks.   Use the x86-64 stack tracer implementation
that uses these callbacks to implement the stacktrace interface.

This allows to use the new dwarf2 unwinder for stacktrace
and get better backtraces.

Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/Makefile     |    1 
 arch/i386/kernel/stacktrace.c |   93 ------------------------------------
 arch/i386/kernel/traps.c      |  108 +++++++++++++++++++++++++++++++-----------
 include/asm-i386/stacktrace.h |    1 
 4 files changed, 83 insertions(+), 120 deletions(-)

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile
+++ linux/arch/i386/kernel/Makefile
@@ -82,4 +82,5 @@ $(obj)/vsyscall-syms.o: $(src)/vsyscall.
 	$(call if_changed,syscall)
 
 k8-y                      += ../../x86_64/kernel/k8.o
+stacktrace-y		  += ../../x86_64/kernel/stacktrace.o
 
Index: linux/arch/i386/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/i386/kernel/stacktrace.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * arch/i386/kernel/stacktrace.c
- *
- * Stack trace management functions
- *
- *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- */
-#include <linux/sched.h>
-#include <linux/stacktrace.h>
-
-static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
-{
-	return	p > (void *)tinfo &&
-		p < (void *)tinfo + THREAD_SIZE - 3;
-}
-
-/*
- * Save stack-backtrace addresses into a stack_trace buffer:
- */
-static inline unsigned long
-save_context_stack(struct stack_trace *trace, unsigned int skip,
-		   struct thread_info *tinfo, unsigned long *stack,
-		   unsigned long ebp)
-{
-	unsigned long addr;
-
-#ifdef CONFIG_FRAME_POINTER
-	while (valid_stack_ptr(tinfo, (void *)ebp)) {
-		addr = *(unsigned long *)(ebp + 4);
-		if (!skip)
-			trace->entries[trace->nr_entries++] = addr;
-		else
-			skip--;
-		if (trace->nr_entries >= trace->max_entries)
-			break;
-		/*
-		 * break out of recursive entries (such as
-		 * end_of_stack_stop_unwind_function):
-	 	 */
-		if (ebp == *(unsigned long *)ebp)
-			break;
-
-		ebp = *(unsigned long *)ebp;
-	}
-#else
-	while (valid_stack_ptr(tinfo, stack)) {
-		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			if (!skip)
-				trace->entries[trace->nr_entries++] = addr;
-			else
-				skip--;
-			if (trace->nr_entries >= trace->max_entries)
-				break;
-		}
-	}
-#endif
-
-	return ebp;
-}
-
-/*
- * Save stack-backtrace addresses into a stack_trace buffer.
- */
-void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
-{
-	unsigned long ebp;
-	unsigned long *stack = &ebp;
-
-	WARN_ON(trace->nr_entries || !trace->max_entries);
-
-	if (!task || task == current) {
-		/* Grab ebp right from our regs: */
-		asm ("movl %%ebp, %0" : "=r" (ebp));
-	} else {
-		/* ebp is the last reg pushed by switch_to(): */
-		ebp = *(unsigned long *) task->thread.esp;
-	}
-
-	while (1) {
-		struct thread_info *context = (struct thread_info *)
-				((unsigned long)stack & (~(THREAD_SIZE - 1)));
-
-		ebp = save_context_stack(trace, trace->skip, context, stack, ebp);
-		stack = (unsigned long *)context->previous_esp;
-		if (!stack || trace->nr_entries >= trace->max_entries)
-			break;
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
-		if (trace->nr_entries >= trace->max_entries)
-			break;
-	}
-}
-
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
+#include <asm/stacktrace.h>
 
 #include <linux/module.h>
 
@@ -114,26 +115,16 @@ static inline int valid_stack_ptr(struct
 		p < (void *)tinfo + THREAD_SIZE - 3;
 }
 
-/*
- * Print one address/symbol entries per line.
- */
-static inline void print_addr_and_symbol(unsigned long addr, char *log_lvl)
-{
-	printk(" [<%08lx>] ", addr);
-
-	print_symbol("%s\n", addr);
-}
-
 static inline unsigned long print_context_stack(struct thread_info *tinfo,
 				unsigned long *stack, unsigned long ebp,
-				char *log_lvl)
+				struct stacktrace_ops *ops, void *data)
 {
 	unsigned long addr;
 
 #ifdef	CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
 		addr = *(unsigned long *)(ebp + 4);
-		print_addr_and_symbol(addr, log_lvl);
+		ops->address(data, addr);
 		/*
 		 * break out of recursive entries (such as
 		 * end_of_stack_stop_unwind_function):
@@ -146,28 +137,35 @@ static inline unsigned long print_contex
 	while (valid_stack_ptr(tinfo, stack)) {
 		addr = *stack++;
 		if (__kernel_text_address(addr))
-			print_addr_and_symbol(addr, log_lvl);
+			ops->address(data, addr);
 	}
 #endif
 	return ebp;
 }
 
+struct ops_and_data {
+	struct stacktrace_ops *ops;
+	void *data;
+};
+
 static asmlinkage int
-show_trace_unwind(struct unwind_frame_info *info, void *log_lvl)
+dump_trace_unwind(struct unwind_frame_info *info, void *data)
 {
+	struct ops_and_data *oad = (struct ops_and_data *)data;
 	int n = 0;
 
 	while (unwind(info) == 0 && UNW_PC(info)) {
 		n++;
-		print_addr_and_symbol(UNW_PC(info), log_lvl);
+		oad->ops->address(oad->data, UNW_PC(info));
 		if (arch_unw_user_mode(info))
 			break;
 	}
 	return n;
 }
 
-static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			       unsigned long *stack, char *log_lvl)
+void dump_trace(struct task_struct *task, struct pt_regs *regs,
+	        unsigned long *stack,
+		struct stacktrace_ops *ops, void *data)
 {
 	unsigned long ebp;
 
@@ -177,34 +175,42 @@ static void show_trace_log_lvl(struct ta
 	if (call_trace >= 0) {
 		int unw_ret = 0;
 		struct unwind_frame_info info;
+		struct ops_and_data oad = { .ops = ops, .data = data };
 
 		if (regs) {
 			if (unwind_init_frame_info(&info, task, regs) == 0)
-				unw_ret = show_trace_unwind(&info, log_lvl);
+				unw_ret = dump_trace_unwind(&info, &oad);
 		} else if (task == current)
-			unw_ret = unwind_init_running(&info, show_trace_unwind, log_lvl);
+			unw_ret = unwind_init_running(&info, dump_trace_unwind, &oad);
 		else {
 			if (unwind_init_blocked(&info, task) == 0)
-				unw_ret = show_trace_unwind(&info, log_lvl);
+				unw_ret = dump_trace_unwind(&info, &oad);
 		}
 		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
 #ifdef CONFIG_STACK_UNWIND
-			print_symbol("DWARF2 unwinder stuck at %s\n",
+			ops->warning_symbol(data, "DWARF2 unwinder stuck at %s",
 				     UNW_PC(&info));
 			if (call_trace == 1) {
-				printk("Leftover inexact backtrace:\n");
+				ops->warning(data, "Leftover inexact backtrace:");
 				if (UNW_SP(&info))
 					stack = (void *)UNW_SP(&info);
 			} else if (call_trace > 1)
 				return;
 			else
-				printk("Full inexact backtrace again:\n");
+				ops->warning(data, "Full inexact backtrace again:");
 #else
-			printk("Inexact backtrace:\n");
+			ops->warning(data, "Inexact backtrace:");
 #endif
 		}
 	}
 
+	if (!stack) {
+		unsigned long dummy;
+		stack = &dummy;
+		if (task && task != current)
+			stack = (unsigned long *)task->thread.esp;
+	}
+
 	if (task == current) {
 		/* Grab ebp right from our regs */
 		asm ("movl %%ebp, %0" : "=r" (ebp) : );
@@ -217,15 +223,63 @@ static void show_trace_log_lvl(struct ta
 		struct thread_info *context;
 		context = (struct thread_info *)
 			((unsigned long)stack & (~(THREAD_SIZE - 1)));
-		ebp = print_context_stack(context, stack, ebp, log_lvl);
+		ebp = print_context_stack(context, stack, ebp, ops, data);
+		/* Should be after the line below, but somewhere
+		   in early boot context comes out corrupted and we
+		   can't reference it -AK */
+		if (ops->stack(data, "IRQ") < 0)
+			break;
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
-		printk("%s =======================\n", log_lvl);
 	}
 }
+EXPORT_SYMBOL(dump_trace);
+
+static void
+print_trace_warning_symbol(void *data, char *msg, unsigned long symbol)
+{
+	printk(data);
+	print_symbol(msg, symbol);
+	printk("\n");
+}
+
+static void print_trace_warning(void *data, char *msg)
+{
+	printk("%s%s\n", (char *)data, msg);
+}
+
+static int print_trace_stack(void *data, char *name)
+{
+	return 0;
+}
+
+/*
+ * Print one address/symbol entries per line.
+ */
+static void print_trace_address(void *data, unsigned long addr)
+{
+	printk("%s [<%08lx>] ", (char *)data, addr);
+	print_symbol("%s\n", addr);
+}
+
+static struct stacktrace_ops print_trace_ops = {
+	.warning = print_trace_warning,
+	.warning_symbol = print_trace_warning_symbol,
+	.stack = print_trace_stack,
+	.address = print_trace_address,
+};
+
+static void
+show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+		   unsigned long * stack, char *log_lvl)
+{
+	dump_trace(task, regs, stack, &print_trace_ops, log_lvl);
+	printk("%s =======================\n", log_lvl);
+}
 
-void show_trace(struct task_struct *task, struct pt_regs *regs, unsigned long * stack)
+void show_trace(struct task_struct *task, struct pt_regs *regs,
+		unsigned long * stack)
 {
 	show_trace_log_lvl(task, regs, stack, "");
 }
Index: linux/include/asm-i386/stacktrace.h
===================================================================
--- /dev/null
+++ linux/include/asm-i386/stacktrace.h
@@ -0,0 +1 @@
+#include <asm-x86_64/stacktrace.h>
