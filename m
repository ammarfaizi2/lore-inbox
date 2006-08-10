Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWHJTvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWHJTvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWHJThU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:13969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932663AbWHJThI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:08 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [108/145] x86_64: Some preparationary cleanup for stack trace
Message-Id: <20060810193706.8DDA613C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:06 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

- Remove unused all_contexts parameter 
No caller used it
- Move skip argument into the structure (needed for
followon patches)

Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/stacktrace.c   |   11 +++--------
 arch/x86_64/kernel/stacktrace.c |   14 +++++---------
 include/linux/stacktrace.h      |    7 ++++---
 kernel/lockdep.c                |    5 ++++-
 4 files changed, 16 insertions(+), 21 deletions(-)

Index: linux/arch/i386/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/i386/kernel/stacktrace.c
+++ linux/arch/i386/kernel/stacktrace.c
@@ -61,12 +61,8 @@ save_context_stack(struct stack_trace *t
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
- * If all_contexts is set, all contexts (hardirq, softirq and process)
- * are saved. If not set then only the current context is saved.
  */
-void save_stack_trace(struct stack_trace *trace,
-		      struct task_struct *task, int all_contexts,
-		      unsigned int skip)
+void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
 	unsigned long ebp;
 	unsigned long *stack = &ebp;
@@ -85,10 +81,9 @@ void save_stack_trace(struct stack_trace
 		struct thread_info *context = (struct thread_info *)
 				((unsigned long)stack & (~(THREAD_SIZE - 1)));
 
-		ebp = save_context_stack(trace, skip, context, stack, ebp);
+		ebp = save_context_stack(trace, trace->skip, context, stack, ebp);
 		stack = (unsigned long *)context->previous_esp;
-		if (!all_contexts || !stack ||
-				trace->nr_entries >= trace->max_entries)
+		if (!stack || trace->nr_entries >= trace->max_entries)
 			break;
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 		if (trace->nr_entries >= trace->max_entries)
Index: linux/arch/x86_64/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/stacktrace.c
+++ linux/arch/x86_64/kernel/stacktrace.c
@@ -109,9 +109,10 @@ out_restore:
  * Save stack-backtrace addresses into a stack_trace buffer:
  */
 static inline unsigned long
-save_context_stack(struct stack_trace *trace, unsigned int skip,
+save_context_stack(struct stack_trace *trace,
 		   unsigned long stack, unsigned long stack_end)
 {
+	int skip = trace->skip;
 	unsigned long addr;
 
 #ifdef CONFIG_FRAME_POINTER
@@ -159,12 +160,8 @@ save_context_stack(struct stack_trace *t
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
- * If all_contexts is set, all contexts (hardirq, softirq and process)
- * are saved. If not set then only the current context is saved.
  */
-void save_stack_trace(struct stack_trace *trace,
-		      struct task_struct *task, int all_contexts,
-		      unsigned int skip)
+void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
 	unsigned long stack = (unsigned long)&stack;
 	int i, nr_stacks = 0, stacks_done[MAX_STACKS];
@@ -207,9 +204,8 @@ void save_stack_trace(struct stack_trace
 				return;
 		stacks_done[nr_stacks] = stack_end;
 
-		stack = save_context_stack(trace, skip, stack, stack_end);
-		if (!all_contexts || !stack ||
-				trace->nr_entries >= trace->max_entries)
+		stack = save_context_stack(trace, stack, stack_end);
+		if (!stack || trace->nr_entries >= trace->max_entries)
 			return;
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 		if (trace->nr_entries >= trace->max_entries)
Index: linux/include/linux/stacktrace.h
===================================================================
--- linux.orig/include/linux/stacktrace.h
+++ linux/include/linux/stacktrace.h
@@ -5,15 +5,16 @@
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
+	int skip;	/* input argument: How many entries to skip */
+	int all_contexts; /* input argument: if true do than one stack */
 };
 
 extern void save_stack_trace(struct stack_trace *trace,
-			     struct task_struct *task, int all_contexts,
-			     unsigned int skip);
+			     struct task_struct *task);
 
 extern void print_stack_trace(struct stack_trace *trace, int spaces);
 #else
-# define save_stack_trace(trace, task, all, skip)	do { } while (0)
+# define save_stack_trace(trace, task)			do { } while (0)
 # define print_stack_trace(trace)			do { } while (0)
 #endif
 
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -224,7 +224,10 @@ static int save_trace(struct stack_trace
 	trace->max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
 	trace->entries = stack_trace + nr_stack_trace_entries;
 
-	save_stack_trace(trace, NULL, 0, 3);
+	trace->skip = 3;
+	trace->all_contexts = 0;
+
+	save_stack_trace(trace, NULL);
 
 	trace->max_entries = trace->nr_entries;
 
