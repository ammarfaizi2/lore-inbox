Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTKDWPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTKDWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:15:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:22769 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261976AbTKDWPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:15:36 -0500
Subject: [RFC] Smarter stack traces using the frame pointer
From: Adam Litke <agl@us.ibm.com>
To: mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Nov 2003 14:13:49 -0800
Message-Id: <1067984031.544.23.camel@agtpad>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was working on this for the mjb tree but I thought I'd throw it out
here in case anyone else finds it interesting.  This simple change to
the stack trace code uses the frame pointer to do the trace instead of
assuming any kernel address on the stack is a return address.  It makes
for much more readable stack traces.

diff -purN linux-2.6.0-test9-virgin/arch/i386/kernel/traps.c linux-2.6.0-test9-stack/arch/i386/kernel/traps.c
--- linux-2.6.0-test9-virgin/arch/i386/kernel/traps.c	2003-11-03 10:34:18.000000000 -0800
+++ linux-2.6.0-test9-stack/arch/i386/kernel/traps.c	2003-11-04 13:51:20.000000000 -0800
@@ -93,17 +93,36 @@ asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+#ifdef CONFIG_FRAME_POINTER
+void show_trace_fp(struct task_struct *task)
+{
+	unsigned long addr, ebp;
+
+	if (task == current) {
+		/* Grab ebp right from our regs */
+		asm ("movl %%ebp, %0" : "=r" (ebp) : );
+	} else {
+		/* ebp is the last reg pushed by switch_to */
+		ebp = *(unsigned long *) task->thread.esp;
+	}
+	
+	while (ebp) {
+		addr = *(unsigned long *) (ebp + 4);
+		if (!kernel_text_address(addr))
+			return;
+		printk(" [<%08lx>] ", addr);
+		print_symbol("%s\n", addr);
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
@@ -111,6 +130,20 @@ void show_trace(struct task_struct *task
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
+	show_trace_fp(task);
+#else
+	show_trace_guess(stack);
+#endif
 	printk("\n");
 } 
-- 
Adam Litke (agl at us.ibm.com)
IBM Linux Technology Center
(503) 578 - 3283 t/l 775 - 3283

