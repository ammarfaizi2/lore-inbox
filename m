Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263841AbUDTWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263841AbUDTWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbUDTWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:01:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44017 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264483AbUDTU37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 16:29:59 -0400
Subject: Re: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq
	shows impossible call stack)
From: Adam Litke <agl@us.ibm.com>
To: Roland Dreier <roland@topspin.com>
Cc: Eli Cohen <mlxk@mellanox.co.il>, linux-kernel@vger.kernel.org
In-Reply-To: <5265buzgfn.fsf_-_@topspin.com>
References: <408545AA.6030807@mellanox.co.il> <52ekqizkd2.fsf@topspin.com>
	 <40855F95.7080003@mellanox.co.il>  <5265buzgfn.fsf_-_@topspin.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1082492730.716.76.camel@agtpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Apr 2004 13:26:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 10:51, Roland Dreier wrote:
> Your question prompted me to look at show_trace() in
> arch/i386/kernel/traps.c.  I see that even in kernels as new as 2.6.5,
> there is no attempt to use frame pointers for stack dumps even when
> CONFIG_FRAME_POINTER is set.  I seem to remember some patches to do
> this floating around a while ago.  How did that discussion end up?

This problem was annoying me a few months ago so I coded up a stack
trace patch that actually uses the frame pointer.  It is currently
maintained in -mjb but I have pasted below.  Hope this helps.

diff -upN reference/arch/i386/kernel/traps.c current/arch/i386/kernel/traps.c
--- reference/arch/i386/kernel/traps.c	2004-04-09 11:53:00.000000000 -0700
+++ current/arch/i386/kernel/traps.c	2004-04-09 11:53:04.000000000 -0700
@@ -124,20 +124,62 @@ void breakpoint(void)
 #define	CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,after)
 #endif
 
+#define STACK_PRINT_DEPTH 32
 
-static int kstack_depth_to_print = 24;
+#ifdef CONFIG_FRAME_POINTER
+#define valid_stack_ptr(task, p) \
+	((p > (unsigned long)task->thread_info) && \
+	 (p < (unsigned long)task->thread_info+THREAD_SIZE))
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+void show_stack_frame(unsigned long start, unsigned long end)
+{
+	int i;
+
+	printk("              ");
+	for (i = start; i < end; i += 4) {
+		if ((i - start) && ((i - start)%24 == 0))
+			printk("\n              ");
+		printk("%08lx ", *(unsigned long *) i);
+	}
+	printk("\n");
+}
+		
+void show_trace_fp(struct task_struct *task, unsigned long * stack)
+{
+	unsigned long addr, ebp;
+
+	if (!task)
+		task = current;
+	
+	if (task == current) {
+		/* Grab ebp right from our regs */
+		asm ("movl %%ebp, %0" : "=r" (ebp) : );
+	} else {
+		/* ebp is the last reg pushed by switch_to */
+		ebp = *(unsigned long *) task->thread.esp;
+	}
+
+	show_stack_frame((unsigned long) stack, ebp+4);
+	while (valid_stack_ptr(task, ebp)) {
+		addr = *(unsigned long *) (ebp + 4);
+		printk(" [<%08lx>] ", addr);
+		print_symbol("%s\n", addr);
+
+		/* Show the stack frame starting with args */
+		show_stack_frame(ebp + 8, (*(unsigned long *) ebp) + 4);
+		ebp = *(unsigned long *) ebp;
+	}
+}
+
+#else /* !CONFIG_FRAME_POINTER */
+
+void show_trace_guess(unsigned long * stack)
 {
 	unsigned long addr;
 
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace:");
-#ifdef CONFIG_KALLSYMS
-	printk("\n");
-#endif
 	while (1) {
 		struct thread_info *context;
 		context = (struct thread_info*) ((unsigned long)stack & (~(THREAD_SIZE - 1)));
@@ -153,6 +195,20 @@ void show_trace(struct task_struct *task
 			break;
 		printk(" =======================\n");
 	}
+}
+#endif
+
+void show_trace(struct task_struct *task, unsigned long * stack)
+{
+	printk("Call Trace:");
+#ifdef CONFIG_KALLSYMS
+	printk("\n");
+#endif
+#ifdef CONFIG_FRAME_POINTER
+	show_trace_fp(task, stack);
+#else
+	show_trace_guess(stack);
+#endif
 	printk("\n");
 }
 
@@ -168,8 +224,10 @@ void show_trace_task(struct task_struct 
 
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
+#ifndef CONFIG_FRAME_POINTER
 	unsigned long *stack;
 	int i;
+#endif
 
 	if (esp == NULL) {
 		if (task)
@@ -178,8 +236,9 @@ void show_stack(struct task_struct *task
 			esp = (unsigned long *)&esp;
 	}
 
+#ifndef CONFIG_FRAME_POINTER
 	stack = esp;
-	for(i = 0; i < kstack_depth_to_print; i++) {
+	for(i = 0; i < STACK_PRINT_DEPTH; i++) {
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % 8) == 0))
@@ -187,6 +246,7 @@ void show_stack(struct task_struct *task
 		printk("%08lx ", *stack++);
 	}
 	printk("\n");
+#endif
 	show_trace(task, esp);
 }
 

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

