Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTKJRtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTKJRtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:49:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:46231 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264030AbTKJRtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:49:01 -0500
Subject: Re: [RFC] Smarter stack traces using the frame pointer
From: Adam Litke <agl@us.ibm.com>
To: bryanh@giraffe-data.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1067984031.544.23.camel@agtpad>
References: <1067984031.544.23.camel@agtpad>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Nov 2003 09:46:28 -0800
Message-Id: <1068486393.7741.4.camel@agtpad>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-04 at 14:13, Adam Litke wrote:
> I was working on this for the mjb tree but I thought I'd throw it out
> here in case anyone else finds it interesting.  This simple change to
> the stack trace code uses the frame pointer to do the trace instead of
> assuming any kernel address on the stack is a return address.  It makes
> for much more readable stack traces.
Here is an updated patch that fixes a very stupid NULL pointer
dereference.  Also, it now avoids contradictory stack data when thread
== current.

diff -purN linux-2.6.0-test9-virgin/arch/i386/kernel/traps.c linux-2.6.0-test9-stack/arch/i386/kernel/traps.c
--- linux-2.6.0-test9-virgin/arch/i386/kernel/traps.c	2003-11-03 10:34:18.000000000 -0800
+++ linux-2.6.0-test9-stack/arch/i386/kernel/traps.c	2003-11-06 09:47:19.000000000 -0800
@@ -91,19 +91,58 @@ asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
-static int kstack_depth_to_print = 24;
+static int kstack_depth_to_print = 128;
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+#ifdef CONFIG_FRAME_POINTER
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
+	while (ebp) {
+		addr = *(unsigned long *) (ebp + 4);
+		if (!kernel_text_address(addr))
+			return;
+		printk(" [<%08lx>] ", addr);
+		print_symbol("%s\n", addr);
+
+		/* Show the stack frame starting with args */
+		show_stack_frame(ebp + 8, (*(unsigned long *) ebp) + 4);
+		ebp = *(unsigned long *) ebp;
+	}
+}
+#else
+void show_trace_guess(unsigned long * stack)
 {
 	unsigned long addr;
 
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace:");
-#ifdef CONFIG_KALLSYMS
-	printk("\n");
-#endif
 	while (!kstack_end(stack)) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
@@ -111,6 +150,20 @@ void show_trace(struct task_struct *task
 			print_symbol("%s\n", addr);
 		}
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
 
@@ -136,6 +189,7 @@ void show_stack(struct task_struct *task
 			esp = (unsigned long *)&esp;
 	}
 
+#ifndef CONFIG_FRAME_POINTER
 	stack = esp;
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
@@ -145,6 +199,7 @@ void show_stack(struct task_struct *task
 		printk("%08lx ", *stack++);
 	}
 	printk("\n");
+#endif
 	show_trace(task, esp);
 }
-- 
Adam Litke (agl at us.ibm.com)
IBM Linux Technology Center
(503) 578 - 3283 t/l 775 - 3283

