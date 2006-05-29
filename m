Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWE2Vmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWE2Vmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWE2VYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:11704 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751326AbWE2VXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:55 -0400
Date: Mon, 29 May 2006 23:24:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 14/61] lock validator: stacktrace
Message-ID: <20060529212414.GN3155@elte.hu>
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

framework to generate and save stacktraces quickly, without printing
anything to the console.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/kernel/Makefile       |    2 
 arch/i386/kernel/stacktrace.c   |   98 +++++++++++++++++
 arch/x86_64/kernel/Makefile     |    2 
 arch/x86_64/kernel/stacktrace.c |  219 ++++++++++++++++++++++++++++++++++++++++
 include/linux/stacktrace.h      |   15 ++
 kernel/Makefile                 |    2 
 kernel/stacktrace.c             |   26 ++++
 7 files changed, 361 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile
+++ linux/arch/i386/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y := head.o init_task.o vmlinux.lds
 
-obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
+obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o stacktrace.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bootflag.o \
 		quirks.o i8237.o topology.o alternative.o i8253.o tsc.o
Index: linux/arch/i386/kernel/stacktrace.c
===================================================================
--- /dev/null
+++ linux/arch/i386/kernel/stacktrace.c
@@ -0,0 +1,98 @@
+/*
+ * arch/i386/kernel/stacktrace.c
+ *
+ * Stack trace management functions
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer:
+ */
+static inline unsigned long
+save_context_stack(struct stack_trace *trace, unsigned int skip,
+		   struct thread_info *tinfo, unsigned long *stack,
+		   unsigned long ebp)
+{
+	unsigned long addr;
+
+#ifdef CONFIG_FRAME_POINTER
+	while (valid_stack_ptr(tinfo, (void *)ebp)) {
+		addr = *(unsigned long *)(ebp + 4);
+		if (!skip)
+			trace->entries[trace->nr_entries++] = addr;
+		else
+			skip--;
+		if (trace->nr_entries >= trace->max_entries)
+			break;
+		/*
+		 * break out of recursive entries (such as
+		 * end_of_stack_stop_unwind_function):
+	 	 */
+		if (ebp == *(unsigned long *)ebp)
+			break;
+
+		ebp = *(unsigned long *)ebp;
+	}
+#else
+	while (valid_stack_ptr(tinfo, stack)) {
+		addr = *stack++;
+		if (__kernel_text_address(addr)) {
+			if (!skip)
+				trace->entries[trace->nr_entries++] = addr;
+			else
+				skip--;
+			if (trace->nr_entries >= trace->max_entries)
+				break;
+		}
+	}
+#endif
+
+	return ebp;
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ * If all_contexts is set, all contexts (hardirq, softirq and process)
+ * are saved. If not set then only the current context is saved.
+ */
+void save_stack_trace(struct stack_trace *trace,
+		      struct task_struct *task, int all_contexts,
+		      unsigned int skip)
+{
+	unsigned long ebp;
+	unsigned long *stack = &ebp;
+
+	WARN_ON(trace->nr_entries || !trace->max_entries);
+
+	if (!task || task == current) {
+		/* Grab ebp right from our regs: */
+		asm ("movl %%ebp, %0" : "=r" (ebp));
+	} else {
+		/* ebp is the last reg pushed by switch_to(): */
+		ebp = *(unsigned long *) task->thread.esp;
+	}
+
+	while (1) {
+		struct thread_info *context = (struct thread_info *)
+				((unsigned long)stack & (~(THREAD_SIZE - 1)));
+
+		ebp = save_context_stack(trace, skip, context, stack, ebp);
+		stack = (unsigned long *)context->previous_esp;
+		if (!all_contexts || !stack ||
+				trace->nr_entries >= trace->max_entries)
+			break;
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+		if (trace->nr_entries >= trace->max_entries)
+			break;
+	}
+}
+
Index: linux/arch/x86_64/kernel/Makefile
===================================================================
--- linux.orig/arch/x86_64/kernel/Makefile
+++ linux/arch/x86_64/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
-obj-y	:= process.o signal.o entry.o traps.o irq.o \
+obj-y	:= process.o signal.o entry.o traps.o irq.o stacktrace.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
Index: linux/arch/x86_64/kernel/stacktrace.c
===================================================================
--- /dev/null
+++ linux/arch/x86_64/kernel/stacktrace.c
@@ -0,0 +1,219 @@
+/*
+ * arch/x86_64/kernel/stacktrace.c
+ *
+ * Stack trace management functions
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+
+#include <asm/smp.h>
+
+static inline int
+in_range(unsigned long start, unsigned long addr, unsigned long end)
+{
+	return addr >= start && addr <= end;
+}
+
+static unsigned long
+get_stack_end(struct task_struct *task, unsigned long stack)
+{
+	unsigned long stack_start, stack_end, flags;
+	int i, cpu;
+
+	/*
+	 * The most common case is that we are in the task stack:
+	 */
+	stack_start = (unsigned long)task->thread_info;
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (in_range(stack_start, stack, stack_end))
+		return stack_end;
+
+	/*
+	 * We are in an interrupt if irqstackptr is set:
+	 */
+	raw_local_irq_save(flags);
+	cpu = safe_smp_processor_id();
+	stack_end = (unsigned long)cpu_pda(cpu)->irqstackptr;
+
+	if (stack_end) {
+		stack_start = stack_end & ~(IRQSTACKSIZE-1);
+		if (in_range(stack_start, stack, stack_end))
+			goto out_restore;
+		/*
+		 * We get here if we are in an IRQ context but we
+		 * are also in an exception stack.
+		 */
+	}
+
+	/*
+	 * Iterate over all exception stacks, and figure out whether
+	 * 'stack' is in one of them:
+	 */
+	for (i = 0; i < N_EXCEPTION_STACKS; i++) {
+		/*
+		 * set 'end' to the end of the exception stack.
+		 */
+		stack_end = per_cpu(init_tss, cpu).ist[i];
+		stack_start = stack_end - EXCEPTION_STKSZ;
+
+		/*
+		 * Is 'stack' above this exception frame's end?
+		 * If yes then skip to the next frame.
+		 */
+		if (stack >= stack_end)
+			continue;
+		/*
+		 * Is 'stack' above this exception frame's start address?
+		 * If yes then we found the right frame.
+		 */
+		if (stack >= stack_start)
+			goto out_restore;
+
+		/*
+		 * If this is a debug stack, and if it has a larger size than
+		 * the usual exception stacks, then 'stack' might still
+		 * be within the lower portion of the debug stack:
+		 */
+#if DEBUG_STKSZ > EXCEPTION_STKSZ
+		if (i == DEBUG_STACK - 1 && stack >= stack_end - DEBUG_STKSZ) {
+			/*
+			 * Black magic. A large debug stack is composed of
+			 * multiple exception stack entries, which we
+			 * iterate through now. Dont look:
+			 */
+			do {
+				stack_end -= EXCEPTION_STKSZ;
+				stack_start -= EXCEPTION_STKSZ;
+			} while (stack < stack_start);
+
+			goto out_restore;
+		}
+#endif
+	}
+	/*
+	 * Ok, 'stack' is not pointing to any of the system stacks.
+	 */
+	stack_end = 0;
+
+out_restore:
+	raw_local_irq_restore(flags);
+
+	return stack_end;
+}
+
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer:
+ */
+static inline unsigned long
+save_context_stack(struct stack_trace *trace, unsigned int skip,
+		   unsigned long stack, unsigned long stack_end)
+{
+	unsigned long addr, prev_stack = 0;
+
+#ifdef CONFIG_FRAME_POINTER
+	while (in_range(prev_stack, (unsigned long)stack, stack_end)) {
+		pr_debug("stack:          %p\n", (void *)stack);
+		addr = (unsigned long)(((unsigned long *)stack)[1]);
+		pr_debug("addr:           %p\n", (void *)addr);
+		if (!skip)
+			trace->entries[trace->nr_entries++] = addr-1;
+		else
+			skip--;
+		if (trace->nr_entries >= trace->max_entries)
+			break;
+		if (!addr)
+			return 0;
+		/*
+		 * Stack frames must go forwards (otherwise a loop could
+		 * happen if the stackframe is corrupted), so we move
+		 * prev_stack forwards:
+		 */
+		prev_stack = stack;
+		stack = (unsigned long)(((unsigned long *)stack)[0]);
+	}
+	pr_debug("invalid:        %p\n", (void *)stack);
+#else
+	while (stack < stack_end) {
+		addr = (unsigned long *)stack[0];
+		stack += sizeof(long);
+		if (__kernel_text_address(addr)) {
+			if (!skip)
+				trace->entries[trace->nr_entries++] = addr-1;
+			else
+				skip--;
+			if (trace->nr_entries >= trace->max_entries)
+				break;
+		}
+	}
+#endif
+	return stack;
+}
+
+#define MAX_STACKS 10
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ * If all_contexts is set, all contexts (hardirq, softirq and process)
+ * are saved. If not set then only the current context is saved.
+ */
+void save_stack_trace(struct stack_trace *trace,
+		      struct task_struct *task, int all_contexts,
+		      unsigned int skip)
+{
+	unsigned long stack = (unsigned long)&stack;
+	int i, nr_stacks = 0, stacks_done[MAX_STACKS];
+
+	WARN_ON(trace->nr_entries || !trace->max_entries);
+
+	if (!task)
+		task = current;
+
+	pr_debug("task: %p, ti: %p\n", task, task->thread_info);
+
+	if (!task || task == current) {
+		/* Grab rbp right from our regs: */
+		asm ("mov %%rbp, %0" : "=r" (stack));
+		pr_debug("rbp:            %p\n", (void *)stack);
+	} else {
+		/* rbp is the last reg pushed by switch_to(): */
+		stack = task->thread.rsp;
+		pr_debug("other task rsp: %p\n", (void *)stack);
+		stack = (unsigned long)(((unsigned long *)stack)[0]);
+		pr_debug("other task rbp: %p\n", (void *)stack);
+	}
+
+	while (1) {
+		unsigned long stack_end = get_stack_end(task, stack);
+
+		pr_debug("stack:          %p\n", (void *)stack);
+		pr_debug("stack end:      %p\n", (void *)stack_end);
+
+		/*
+		 * Invalid stack addres?
+		 */
+		if (!stack_end)
+			return;
+		/*
+		 * Were we in this stack already? (recursion)
+		 */
+		for (i = 0; i < nr_stacks; i++)
+			if (stacks_done[i] == stack_end)
+				return;
+		stacks_done[nr_stacks] = stack_end;
+
+		stack = save_context_stack(trace, skip, stack, stack_end);
+		if (!all_contexts || !stack ||
+				trace->nr_entries >= trace->max_entries)
+			return;
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+		if (trace->nr_entries >= trace->max_entries)
+			return;
+		if (++nr_stacks >= MAX_STACKS)
+			return;
+	}
+}
+
Index: linux/include/linux/stacktrace.h
===================================================================
--- /dev/null
+++ linux/include/linux/stacktrace.h
@@ -0,0 +1,15 @@
+#ifndef __LINUX_STACKTRACE_H
+#define __LINUX_STACKTRACE_H
+
+struct stack_trace {
+	unsigned int nr_entries, max_entries;
+	unsigned long *entries;
+};
+
+extern void save_stack_trace(struct stack_trace *trace,
+			     struct task_struct *task, int all_contexts,
+			     unsigned int skip);
+
+extern void print_stack_trace(struct stack_trace *trace, int spaces);
+
+#endif
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o nsproxy.o
+	    hrtimer.o nsproxy.o stacktrace.o
 
 obj-y += time/
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
Index: linux/kernel/stacktrace.c
===================================================================
--- /dev/null
+++ linux/kernel/stacktrace.c
@@ -0,0 +1,26 @@
+/*
+ * kernel/stacktrace.c
+ *
+ * Stack trace management functions
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+#include <linux/sched.h>
+#include <linux/kallsyms.h>
+#include <linux/stacktrace.h>
+
+void print_stack_trace(struct stack_trace *trace, int spaces)
+{
+	int i, j;
+
+	for (i = 0; i < trace->nr_entries; i++) {
+		unsigned long ip = trace->entries[i];
+
+		for (j = 0; j < spaces + 1; j++)
+			printk(" ");
+
+		printk("[<%08lx>]", ip);
+		print_symbol(" %s\n", ip);
+	}
+}
+
