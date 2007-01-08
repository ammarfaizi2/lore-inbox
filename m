Return-Path: <linux-kernel-owner+w=401wt.eu-S1161300AbXAHNvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbXAHNvq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbXAHNvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:51:46 -0500
Received: from verein.lst.de ([213.95.11.210]:35910 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161300AbXAHNvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:51:45 -0500
Date: Mon, 8 Jan 2007 14:51:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] simplify the stacktrace code
Message-ID: <20070108135128.GA23152@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the stacktrace code:

 - remove the unused task argument to save_stack_trace, it's always
   current
 - remove the all_contexts flag, it's alwasy 0


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/mips/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/stacktrace.c	2006-12-25 12:57:06.000000000 +0100
+++ linux-2.6/arch/mips/kernel/stacktrace.c	2006-12-25 12:58:15.000000000 +0100
@@ -31,8 +31,7 @@
 	}
 }
 
-static void save_context_stack(struct stack_trace *trace,
-	struct task_struct *task, struct pt_regs *regs)
+static void save_context_stack(struct stack_trace *trace, struct pt_regs *regs)
 {
 	unsigned long sp = regs->regs[29];
 #ifdef CONFIG_KALLSYMS
@@ -41,7 +40,7 @@
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
 		unsigned long stack_page =
-			(unsigned long)task_stack_page(task);
+			(unsigned long)task_stack_page(current);
 		if (stack_page && sp >= stack_page &&
 		    sp <= stack_page + THREAD_SIZE - 32)
 			save_raw_context_stack(trace, sp);
@@ -54,7 +53,7 @@
 			trace->entries[trace->nr_entries++] = pc;
 		if (trace->nr_entries >= trace->max_entries)
 			break;
-		pc = unwind_stack(task, &sp, pc, &ra);
+		pc = unwind_stack(current, &sp, pc, &ra);
 	} while (pc);
 #else
 	save_raw_context_stack(trace, sp);
@@ -64,22 +63,13 @@
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
-void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
+void save_stack_trace(struct stack_trace *trace)
 {
 	struct pt_regs dummyregs;
 	struct pt_regs *regs = &dummyregs;
 
 	WARN_ON(trace->nr_entries || !trace->max_entries);
 
-	if (task && task != current) {
-		regs->regs[29] = task->thread.reg29;
-		regs->regs[31] = 0;
-		regs->cp0_epc = task->thread.reg31;
-	} else {
-		if (!task)
-			task = current;
-		prepare_frametrace(regs);
-	}
-
-	save_context_stack(trace, task, regs);
+	prepare_frametrace(regs);
+	save_context_stack(trace, regs);
 }
Index: linux-2.6/arch/s390/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/stacktrace.c	2006-12-25 12:54:49.000000000 +0100
+++ linux-2.6/arch/s390/kernel/stacktrace.c	2006-12-25 12:58:48.000000000 +0100
@@ -59,7 +59,7 @@
 	}
 }
 
-void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
+void save_stack_trace(struct stack_trace *trace)
 {
 	register unsigned long sp asm ("15");
 	unsigned long orig_sp, new_sp;
@@ -69,20 +69,16 @@
 	new_sp = save_context_stack(trace, &trace->skip, orig_sp,
 				S390_lowcore.panic_stack - PAGE_SIZE,
 				S390_lowcore.panic_stack);
-	if ((new_sp != orig_sp) && !trace->all_contexts)
+	if (new_sp != orig_sp)
 		return;
 	new_sp = save_context_stack(trace, &trace->skip, new_sp,
 				S390_lowcore.async_stack - ASYNC_SIZE,
 				S390_lowcore.async_stack);
-	if ((new_sp != orig_sp) && !trace->all_contexts)
+	if (new_sp != orig_sp)
 		return;
-	if (task)
-		save_context_stack(trace, &trace->skip, new_sp,
-				   (unsigned long) task_stack_page(task),
-				   (unsigned long) task_stack_page(task) + THREAD_SIZE);
-	else
-		save_context_stack(trace, &trace->skip, new_sp,
-				   S390_lowcore.thread_info,
-				   S390_lowcore.thread_info + THREAD_SIZE);
+
+	save_context_stack(trace, &trace->skip, new_sp,
+			   S390_lowcore.thread_info,
+			   S390_lowcore.thread_info + THREAD_SIZE);
 	return;
 }
Index: linux-2.6/arch/sh/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/stacktrace.c	2006-12-25 12:57:06.000000000 +0100
+++ linux-2.6/arch/sh/kernel/stacktrace.c	2006-12-25 12:59:04.000000000 +0100
@@ -19,14 +19,7 @@
  */
 void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
-	unsigned long *sp;
-
-	if (!task)
-		task = current;
-	if (task == current)
-		sp = (unsigned long *)current_stack_pointer;
-	else
-		sp = (unsigned long *)task->thread.sp;
+	unsigned long *sp = (unsigned long *)current_stack_pointer;
 
 	while (!kstack_end(sp)) {
 		unsigned long addr = *sp++;
Index: linux-2.6/arch/sparc64/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/stacktrace.c	2006-12-25 12:57:06.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/stacktrace.c	2006-12-25 12:59:39.000000000 +0100
@@ -3,22 +3,16 @@
 #include <linux/thread_info.h>
 #include <asm/ptrace.h>
 
-void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
+void save_stack_trace(struct stack_trace *trace)
 {
 	unsigned long ksp, fp, thread_base;
-	struct thread_info *tp;
+	struct thread_info *tp = task_thread_info(current);
 
-	if (!task)
-		task = current;
-	tp = task_thread_info(task);
-	if (task == current) {
-		flushw_all();
-		__asm__ __volatile__(
-			"mov	%%fp, %0"
-			: "=r" (ksp)
-		);
-	} else
-		ksp = tp->ksp;
+	flushw_all();
+	__asm__ __volatile__(
+		"mov	%%fp, %0"
+		: "=r" (ksp)
+	);
 
 	fp = ksp + STACK_BIAS;
 	thread_base = (unsigned long) tp;
Index: linux-2.6/arch/x86_64/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/stacktrace.c	2006-12-25 12:54:49.000000000 +0100
+++ linux-2.6/arch/x86_64/kernel/stacktrace.c	2006-12-25 12:59:54.000000000 +0100
@@ -21,8 +21,7 @@
 
 static int save_stack_stack(void *data, char *name)
 {
-	struct stack_trace *trace = (struct stack_trace *)data;
-	return trace->all_contexts ? 0 : -1;
+	return -1;
 }
 
 static void save_stack_address(void *data, unsigned long addr)
@@ -46,9 +45,9 @@
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
-void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
+void save_stack_trace(struct stack_trace *trace)
 {
-	dump_trace(task, NULL, NULL, &save_stack_ops, trace);
+	dump_trace(current, NULL, NULL, &save_stack_ops, trace);
 	trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL(save_stack_trace);
Index: linux-2.6/include/linux/stacktrace.h
===================================================================
--- linux-2.6.orig/include/linux/stacktrace.h	2006-12-25 12:54:49.000000000 +0100
+++ linux-2.6/include/linux/stacktrace.h	2006-12-25 13:00:06.000000000 +0100
@@ -6,15 +6,13 @@
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
 	int skip;	/* input argument: How many entries to skip */
-	int all_contexts; /* input argument: if true do than one stack */
 };
 
-extern void save_stack_trace(struct stack_trace *trace,
-			     struct task_struct *task);
+extern void save_stack_trace(struct stack_trace *trace);
 
 extern void print_stack_trace(struct stack_trace *trace, int spaces);
 #else
-# define save_stack_trace(trace, task)			do { } while (0)
+# define save_stack_trace(trace)			do { } while (0)
 # define print_stack_trace(trace)			do { } while (0)
 #endif
 
Index: linux-2.6/kernel/lockdep.c
===================================================================
--- linux-2.6.orig/kernel/lockdep.c	2006-12-25 12:54:50.000000000 +0100
+++ linux-2.6/kernel/lockdep.c	2006-12-25 13:00:12.000000000 +0100
@@ -254,9 +254,8 @@
 	trace->entries = stack_trace + nr_stack_trace_entries;
 
 	trace->skip = 3;
-	trace->all_contexts = 0;
 
-	save_stack_trace(trace, NULL);
+	save_stack_trace(trace);
 
 	trace->max_entries = trace->nr_entries;
 
Index: linux-2.6/lib/fault-inject.c
===================================================================
--- linux-2.6.orig/lib/fault-inject.c	2006-12-25 12:54:50.000000000 +0100
+++ linux-2.6/lib/fault-inject.c	2006-12-25 13:00:19.000000000 +0100
@@ -72,9 +72,8 @@
 	trace.entries = entries;
 	trace.max_entries = depth;
 	trace.skip = 1;
-	trace.all_contexts = 0;
 
-	save_stack_trace(&trace, NULL);
+	save_stack_trace(&trace);
 	for (n = 0; n < trace.nr_entries; n++) {
 		if (attr->reject_start <= entries[n] &&
 			       entries[n] < attr->reject_end)
