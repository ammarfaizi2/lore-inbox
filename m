Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264617AbUDVS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264617AbUDVS1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUDVS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:27:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27073 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264617AbUDVS0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:26:20 -0400
Subject: Re: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq
	shows impossible call stack)
From: Adam Litke <agl@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: roland@topspin.com, mlxk@mellanox.co.il, linux-kernel@vger.kernel.org
In-Reply-To: <20040421165059.4579e64d.akpm@osdl.org>
References: <408545AA.6030807@mellanox.co.il> <52ekqizkd2.fsf@topspin.com>
	 <40855F95.7080003@mellanox.co.il> <5265buzgfn.fsf_-_@topspin.com>
	 <1082492730.716.76.camel@agtpad> <52llkqw5me.fsf@topspin.com>
	 <20040420183915.4eee560c.akpm@osdl.org>
	 <20040420184109.6876b3d9.akpm@osdl.org> <1082590136.715.190.camel@agtpad>
	 <20040421165059.4579e64d.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1082658310.715.224.camel@agtpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 11:25:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 16:50, Andrew Morton wrote:
> Adam Litke <agl@us.ibm.com> wrote:
> >
> > On Tue, 2004-04-20 at 18:41, Andrew Morton wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > Roland Dreier <roland@topspin.com> wrote:
> > > >  >
> > > >  >     Adam> This problem was annoying me a few months ago so I coded up
> > > >  >     Adam> a stack trace patch that actually uses the frame pointer.
> > > >  >     Adam> It is currently maintained in -mjb but I have pasted below.
> > > >  >     Adam> Hope this helps.
> > > >  > 
> > > >  > Thanks, that looks really useful.  What is the chance of this moving
> > > >  > from -mjb to mainline?
> > > > 
> > > >  Good, but it needs to be updated to do the right thing with 4k stacks when
> > > >  called from interrupt context.
> > 
> > The show_trace() for the CONFIG_FRAME_POINTER case will now be called
> > the same way as the existing code.
> 
> I still don't see any code in there to handle the transition from the
> interrupt stack page to the non-interrupt stack page in the 4k-stacks case?

Ok here is the latest version of the patch.  I added support for the
4k-stacks interrupt stack case.  I also moved some things around to
minimize code duplication.  Andrew, how does this look?

diff -purN linux-2.6.5-bk/arch/i386/kernel/traps.c linux-2.6.5-bk-stack/arch/i386/kernel/traps.c
--- linux-2.6.5-bk/arch/i386/kernel/traps.c	Thu Apr 22 09:10:57 2004
+++ linux-2.6.5-bk-stack/arch/i386/kernel/traps.c	Thu Apr 22 10:57:39 2004
@@ -92,29 +92,84 @@ asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
-static int kstack_depth_to_print = 24;
+#define valid_stack_ptr(task, p) \
+	((struct thread_info*)p > task->thread_info) && \
+	 !kstack_end((unsigned long*)p)
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+#ifdef CONFIG_FRAME_POINTER
+void show_stack_frame(unsigned long start, unsigned long end)
+{
+	unsigned long i;
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
+void print_context_stack(struct task_struct *task, unsigned long * stack, 
+			 unsigned long ebp)
 {
 	unsigned long addr;
 
-	if (!stack)
-		stack = (unsigned long*)&stack;
+	show_stack_frame((unsigned long) stack, ebp + 4);
+	while (valid_stack_ptr(task, ebp)) {
+		addr = *(unsigned long *) (ebp + 4);
+		printk(" [<%08lx>] ", addr);
+		print_symbol("%s", addr);
+		printk("\n");
+
+		/* Show the stack frame (excluding the frame pointer) */
+		show_stack_frame(ebp + 8, (*(unsigned long *) ebp) + 4);
+		ebp = *(unsigned long *) ebp;
+	}
+}
+#else
+int kstack_depth_to_print = 24;
+
+void print_context_stack(struct task_struct *task, unsigned long * stack,
+			 unsigned long ebp)
+{
+	unsigned long addr;
 
-	printk("Call Trace:");
-#ifdef CONFIG_KALLSYMS
-	printk("\n");
+	while (!kstack_end(stack)) {
+		addr = *stack++;
+		if (kernel_text_address(addr)) {
+			printk(" [<%08lx>] ", addr);
+			print_symbol("%s\n", addr);
+		}
+	}
+}
 #endif
+
+void show_trace(struct task_struct *task, unsigned long * stack)
+{
+	unsigned long ebp;
+
+	if (!task)
+		task = current;
+	
+	if (!valid_stack_ptr(task, stack)) {
+		printk("Stack pointer is garbage, not printing trace\n");
+		return;
+	}
+	
+	if (task == current) {
+		/* Grab ebp right from our regs */
+		asm ("movl %%ebp, %0" : "=r" (ebp) : );
+	} else {
+		/* ebp is the last reg pushed by switch_to */
+		ebp = *(unsigned long *) task->thread.esp;
+	}
+	
 	while (1) {
 		struct thread_info *context;
-		context = (struct thread_info*) ((unsigned long)stack & (~(THREAD_SIZE - 1)));
-		while (!kstack_end(stack)) {
-			addr = *stack++;
-			if (kernel_text_address(addr)) {
-				printk(" [<%08lx>] ", addr);
-				print_symbol("%s\n", addr);
-			}
-		}
+		context = (struct thread_info*) 
+			((unsigned long)stack & (~(THREAD_SIZE - 1)));
+		print_context_stack(task, stack, ebp);
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
@@ -135,9 +190,6 @@ void show_trace_task(struct task_struct 
 
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
-	unsigned long *stack;
-	int i;
-
 	if (esp == NULL) {
 		if (task)
 			esp = (unsigned long*)task->thread.esp;
@@ -145,6 +197,10 @@ void show_stack(struct task_struct *task
 			esp = (unsigned long *)&esp;
 	}
 
+#ifndef CONFIG_FRAME_POINTER
+	{
+	unsigned long *stack;
+	int i;
 	stack = esp;
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
@@ -154,6 +210,8 @@ void show_stack(struct task_struct *task
 		printk("%08lx ", *stack++);
 	}
 	printk("\n");
+	}
+#endif
 	show_trace(task, esp);
 }
 

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

