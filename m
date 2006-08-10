Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWHJT6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWHJT6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWHJT5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:57:50 -0400
Received: from mail.suse.de ([195.135.220.2]:16529 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932667AbWHJThM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:12 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [112/145] x86_64: Merge stacktrace and show_trace
Message-Id: <20060810193710.CDACD13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:10 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This unifies the standard backtracer and the new stacktrace
in memory backtracer. The standard one is converted to use callbacks
and then reimplement stacktrace using new callbacks.

The main advantage is that stacktrace can now use the new dwarf2 unwinder
and avoid false positives in many cases.

I kept it simple to make sure the standard backtracer stays reliable.

Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/stacktrace.c |  214 ++++------------------------------------
 arch/x86_64/kernel/traps.c      |  103 ++++++++++++++-----
 include/asm-x86_64/stacktrace.h |   18 +++
 3 files changed, 124 insertions(+), 211 deletions(-)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -45,6 +45,7 @@
 #include <asm/pda.h>
 #include <asm/proto.h>
 #include <asm/nmi.h>
+#include <asm/stacktrace.h>
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -138,7 +139,7 @@ void printk_address(unsigned long addres
 #endif
 
 static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
-					unsigned *usedp, const char **idp)
+					unsigned *usedp, char **idp)
 {
 	static char ids[][8] = {
 		[DEBUG_STACK - 1] = "#DB",
@@ -230,13 +231,19 @@ static unsigned long *in_exception_stack
 	return NULL;
 }
 
-static int show_trace_unwind(struct unwind_frame_info *info, void *context)
+struct ops_and_data {
+	struct stacktrace_ops *ops;
+	void *data;
+};
+
+static int dump_trace_unwind(struct unwind_frame_info *info, void *context)
 {
+	struct ops_and_data *oad = (struct ops_and_data *)context;
 	int n = 0;
 
 	while (unwind(info) == 0 && UNW_PC(info)) {
 		n++;
-		printk_address(UNW_PC(info));
+		oad->ops->address(oad->data, UNW_PC(info));
 		if (arch_unw_user_mode(info))
 			break;
 	}
@@ -248,49 +255,59 @@ static int show_trace_unwind(struct unwi
  * process stack
  * interrupt stack
  * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
+ * See Documentation/x86_64/kernelstacks for more details.
  */
-
-void show_trace(struct task_struct *tsk, struct pt_regs *regs, unsigned long * stack)
+void dump_trace(struct task_struct *tsk, struct pt_regs *regs,
+		unsigned long *stack,
+		struct stacktrace_ops *ops, void *data)
 {
 	const unsigned cpu = safe_smp_processor_id();
 	unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
 	unsigned used = 0;
 
-	printk("\nCall Trace:\n");
-
 	if (!tsk)
 		tsk = current;
 
 	if (call_trace >= 0) {
 		int unw_ret = 0;
 		struct unwind_frame_info info;
+		struct ops_and_data oad = { .ops = ops, .data = data };
 
 		if (regs) {
 			if (unwind_init_frame_info(&info, tsk, regs) == 0)
-				unw_ret = show_trace_unwind(&info, NULL);
+				unw_ret = dump_trace_unwind(&info, &oad);
 		} else if (tsk == current)
-			unw_ret = unwind_init_running(&info, show_trace_unwind, NULL);
+			unw_ret = unwind_init_running(&info, dump_trace_unwind, &oad);
 		else {
 			if (unwind_init_blocked(&info, tsk) == 0)
-				unw_ret = show_trace_unwind(&info, NULL);
+				unw_ret = dump_trace_unwind(&info, &oad);
 		}
 		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
 #ifdef CONFIG_STACK_UNWIND
 			unsigned long rip = info.regs.rip;
-			print_symbol("DWARF2 unwinder stuck at %s\n", rip);
+			ops->warning_symbol(data,
+					    "DWARF2 unwinder stuck at %s", rip);
 			if (call_trace == 1) {
-				printk("Leftover inexact backtrace:\n");
+				ops->warning(data, "Leftover inexact backtrace:");
 				stack = (unsigned long *)info.regs.rsp;
 			} else if (call_trace > 1)
 				return;
 			else
-				printk("Full inexact backtrace again:\n");
+				ops->warning(data,
+					    "Full inexact backtrace again:");
 #else
-			printk("Inexact backtrace:\n");
+			ops->warning(data, "Inexact backtrace:");
 #endif
 		}
 	}
 
+	if (!stack) {
+		unsigned long dummy;
+		stack = &dummy;
+		if (tsk && tsk != current)
+			stack = (unsigned long *)tsk->thread.rsp;
+	}
+
 	/*
 	 * Print function call entries within a stack. 'cond' is the
 	 * "end of stackframe" condition, that the 'stack++'
@@ -308,7 +325,7 @@ void show_trace(struct task_struct *tsk,
 			 * down the cause of the crash will be able to figure \
 			 * out the call path that was taken. \
 			 */ \
-			printk_address(addr); \
+			ops->address(data, addr);   \
 		} \
 	} while (0)
 
@@ -317,16 +334,17 @@ void show_trace(struct task_struct *tsk,
 	 * current stack address. If the stacks consist of nested
 	 * exceptions
 	 */
-	for ( ; ; ) {
-		const char *id;
+	for (;;) {
+		char *id;
 		unsigned long *estack_end;
 		estack_end = in_exception_stack(cpu, (unsigned long)stack,
 						&used, &id);
 
 		if (estack_end) {
-			printk(" <%s>", id);
+			if (ops->stack(data, id) < 0)
+				break;
 			HANDLE_STACK (stack < estack_end);
-			printk(" <EOE>");
+			ops->stack(data, "<EOE>");
 			/*
 			 * We link to the next stack via the
 			 * second-to-last pointer (index -2 to end) in the
@@ -341,7 +359,8 @@ void show_trace(struct task_struct *tsk,
 				(IRQSTACKSIZE - 64) / sizeof(*irqstack);
 
 			if (stack >= irqstack && stack < irqstack_end) {
-				printk(" <IRQ>");
+				if (ops->stack(data, "IRQ") < 0)
+					break;
 				HANDLE_STACK (stack < irqstack_end);
 				/*
 				 * We link to the next stack (which would be
@@ -350,7 +369,7 @@ void show_trace(struct task_struct *tsk,
 				 */
 				stack = (unsigned long *) (irqstack_end[-1]);
 				irqstack_end = NULL;
-				printk(" <EOI>");
+				ops->stack(data, "EOI");
 				continue;
 			}
 		}
@@ -358,15 +377,53 @@ void show_trace(struct task_struct *tsk,
 	}
 
 	/*
-	 * This prints the process stack:
+	 * This handles the process stack:
 	 */
 	HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
 #undef HANDLE_STACK
+}
+EXPORT_SYMBOL(dump_trace);
+
+static void
+print_trace_warning_symbol(void *data, char *msg, unsigned long symbol)
+{
+	print_symbol(msg, symbol);
+	printk("\n");
+}
 
+static void print_trace_warning(void *data, char *msg)
+{
+	printk("%s\n", msg);
+}
+
+static int print_trace_stack(void *data, char *name)
+{
+	printk(" <%s> ", name);
+	return 0;
+}
+
+static void print_trace_address(void *data, unsigned long addr)
+{
+	printk_address(addr);
+}
+
+static struct stacktrace_ops print_trace_ops = {
+	.warning = print_trace_warning,
+	.warning_symbol = print_trace_warning_symbol,
+	.stack = print_trace_stack,
+	.address = print_trace_address,
+};
+
+void
+show_trace(struct task_struct *tsk, struct pt_regs *regs, unsigned long *stack)
+{
+	printk("\nCall Trace:\n");
+	dump_trace(tsk, regs, stack, &print_trace_ops, NULL);
 	printk("\n");
 }
 
-static void _show_stack(struct task_struct *tsk, struct pt_regs *regs, unsigned long * rsp)
+static void
+_show_stack(struct task_struct *tsk, struct pt_regs *regs, unsigned long *rsp)
 {
 	unsigned long *stack;
 	int i;
Index: linux/include/asm-x86_64/stacktrace.h
===================================================================
--- /dev/null
+++ linux/include/asm-x86_64/stacktrace.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_STACKTRACE_H
+#define _ASM_STACKTRACE_H 1
+
+/* Generic stack tracer with callbacks */
+
+struct stacktrace_ops {
+	void (*warning)(void *data, char *msg);
+	/* msg must contain %s for the symbol */
+	void (*warning_symbol)(void *data, char *msg, unsigned long symbol);
+	void (*address)(void *data, unsigned long address);
+	/* On negative return stop dumping */
+	int (*stack)(void *data, char *name);
+};
+
+void dump_trace(struct task_struct *tsk, struct pt_regs *regs, unsigned long *stack,
+		struct stacktrace_ops *ops, void *data);
+
+#endif
Index: linux/arch/x86_64/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/stacktrace.c
+++ linux/arch/x86_64/kernel/stacktrace.c
@@ -7,211 +7,49 @@
  */
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include <linux/module.h>
+#include <asm/stacktrace.h>
 
-#include <asm/smp.h>
-
-static inline int
-in_range(unsigned long start, unsigned long addr, unsigned long end)
+static void save_stack_warning(void *data, char *msg)
 {
-	return addr >= start && addr <= end;
 }
 
-static unsigned long
-get_stack_end(struct task_struct *task, unsigned long stack)
+static void
+save_stack_warning_symbol(void *data, char *msg, unsigned long symbol)
 {
-	unsigned long stack_start, stack_end, flags;
-	int i, cpu;
-
-	/*
-	 * The most common case is that we are in the task stack:
-	 */
-	stack_start = (unsigned long)task->thread_info;
-	stack_end = stack_start + THREAD_SIZE;
-
-	if (in_range(stack_start, stack, stack_end))
-		return stack_end;
-
-	/*
-	 * We are in an interrupt if irqstackptr is set:
-	 */
-	raw_local_irq_save(flags);
-	cpu = safe_smp_processor_id();
-	stack_end = (unsigned long)cpu_pda(cpu)->irqstackptr;
-
-	if (stack_end) {
-		stack_start = stack_end & ~(IRQSTACKSIZE-1);
-		if (in_range(stack_start, stack, stack_end))
-			goto out_restore;
-		/*
-		 * We get here if we are in an IRQ context but we
-		 * are also in an exception stack.
-		 */
-	}
-
-	/*
-	 * Iterate over all exception stacks, and figure out whether
-	 * 'stack' is in one of them:
-	 */
-	for (i = 0; i < N_EXCEPTION_STACKS; i++) {
-		/*
-		 * set 'end' to the end of the exception stack.
-		 */
-		stack_end = per_cpu(init_tss, cpu).ist[i];
-		stack_start = stack_end - EXCEPTION_STKSZ;
-
-		/*
-		 * Is 'stack' above this exception frame's end?
-		 * If yes then skip to the next frame.
-		 */
-		if (stack >= stack_end)
-			continue;
-		/*
-		 * Is 'stack' above this exception frame's start address?
-		 * If yes then we found the right frame.
-		 */
-		if (stack >= stack_start)
-			goto out_restore;
-
-		/*
-		 * If this is a debug stack, and if it has a larger size than
-		 * the usual exception stacks, then 'stack' might still
-		 * be within the lower portion of the debug stack:
-		 */
-#if DEBUG_STKSZ > EXCEPTION_STKSZ
-		if (i == DEBUG_STACK - 1 && stack >= stack_end - DEBUG_STKSZ) {
-			/*
-			 * Black magic. A large debug stack is composed of
-			 * multiple exception stack entries, which we
-			 * iterate through now. Dont look:
-			 */
-			do {
-				stack_end -= EXCEPTION_STKSZ;
-				stack_start -= EXCEPTION_STKSZ;
-			} while (stack < stack_start);
-
-			goto out_restore;
-		}
-#endif
-	}
-	/*
-	 * Ok, 'stack' is not pointing to any of the system stacks.
-	 */
-	stack_end = 0;
-
-out_restore:
-	raw_local_irq_restore(flags);
-
-	return stack_end;
 }
 
-
-/*
- * Save stack-backtrace addresses into a stack_trace buffer:
- */
-static inline unsigned long
-save_context_stack(struct stack_trace *trace,
-		   unsigned long stack, unsigned long stack_end)
+static int save_stack_stack(void *data, char *name)
 {
-	int skip = trace->skip;
-	unsigned long addr;
-
-#ifdef CONFIG_FRAME_POINTER
-	unsigned long prev_stack = 0;
+	struct stack_trace *trace = (struct stack_trace *)data;
+	return trace->all_contexts ? 0 : -1;
+}
 
-	while (in_range(prev_stack, stack, stack_end)) {
-		pr_debug("stack:          %p\n", (void *)stack);
-		addr = (unsigned long)(((unsigned long *)stack)[1]);
-		pr_debug("addr:           %p\n", (void *)addr);
-		if (!skip)
-			trace->entries[trace->nr_entries++] = addr-1;
-		else
-			skip--;
-		if (trace->nr_entries >= trace->max_entries)
-			break;
-		if (!addr)
-			return 0;
-		/*
-		 * Stack frames must go forwards (otherwise a loop could
-		 * happen if the stackframe is corrupted), so we move
-		 * prev_stack forwards:
-		 */
-		prev_stack = stack;
-		stack = (unsigned long)(((unsigned long *)stack)[0]);
-	}
-	pr_debug("invalid:        %p\n", (void *)stack);
-#else
-	while (stack < stack_end) {
-		addr = ((unsigned long *)stack)[0];
-		stack += sizeof(long);
-		if (__kernel_text_address(addr)) {
-			if (!skip)
-				trace->entries[trace->nr_entries++] = addr-1;
-			else
-				skip--;
-			if (trace->nr_entries >= trace->max_entries)
-				break;
-		}
+static void save_stack_address(void *data, unsigned long addr)
+{
+	struct stack_trace *trace = (struct stack_trace *)data;
+	if (trace->skip > 0) {
+		trace->skip--;
+		return;
 	}
-#endif
-	return stack;
+	if (trace->nr_entries < trace->max_entries - 1)
+		trace->entries[trace->nr_entries++] = addr;
 }
 
-#define MAX_STACKS 10
+static struct stacktrace_ops save_stack_ops = {
+	.warning = save_stack_warning,
+	.warning_symbol = save_stack_warning_symbol,
+	.stack = save_stack_stack,
+	.address = save_stack_address,
+};
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
 void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
-	unsigned long stack = (unsigned long)&stack;
-	int i, nr_stacks = 0, stacks_done[MAX_STACKS];
-
-	WARN_ON(trace->nr_entries || !trace->max_entries);
-
-	if (!task)
-		task = current;
-
-	pr_debug("task: %p, ti: %p\n", task, task->thread_info);
-
-	if (!task || task == current) {
-		/* Grab rbp right from our regs: */
-		asm ("mov %%rbp, %0" : "=r" (stack));
-		pr_debug("rbp:            %p\n", (void *)stack);
-	} else {
-		/* rbp is the last reg pushed by switch_to(): */
-		stack = task->thread.rsp;
-		pr_debug("other task rsp: %p\n", (void *)stack);
-		stack = (unsigned long)(((unsigned long *)stack)[0]);
-		pr_debug("other task rbp: %p\n", (void *)stack);
-	}
-
-	while (1) {
-		unsigned long stack_end = get_stack_end(task, stack);
-
-		pr_debug("stack:          %p\n", (void *)stack);
-		pr_debug("stack end:      %p\n", (void *)stack_end);
-
-		/*
-		 * Invalid stack addres?
-		 */
-		if (!stack_end)
-			return;
-		/*
-		 * Were we in this stack already? (recursion)
-		 */
-		for (i = 0; i < nr_stacks; i++)
-			if (stacks_done[i] == stack_end)
-				return;
-		stacks_done[nr_stacks] = stack_end;
-
-		stack = save_context_stack(trace, stack, stack_end);
-		if (!stack || trace->nr_entries >= trace->max_entries)
-			return;
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
-		if (trace->nr_entries >= trace->max_entries)
-			return;
-		if (++nr_stacks >= MAX_STACKS)
-			return;
-	}
+	dump_trace(task, NULL, NULL, &save_stack_ops, trace);
+	trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
+EXPORT_SYMBOL(save_stack_trace);
 
