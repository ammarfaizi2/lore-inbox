Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUDUXai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUDUXai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUDUXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 19:30:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50822 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263045AbUDUXaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 19:30:19 -0400
Subject: Re: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq
	shows impossible call stack)
From: Adam Litke <agl@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: roland@topspin.com, mlxk@mellanox.co.il, linux-kernel@vger.kernel.org
In-Reply-To: <20040420184109.6876b3d9.akpm@osdl.org>
References: <408545AA.6030807@mellanox.co.il> <52ekqizkd2.fsf@topspin.com>
	 <40855F95.7080003@mellanox.co.il> <5265buzgfn.fsf_-_@topspin.com>
	 <1082492730.716.76.camel@agtpad> <52llkqw5me.fsf@topspin.com>
	 <20040420183915.4eee560c.akpm@osdl.org>
	 <20040420184109.6876b3d9.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1082590136.715.190.camel@agtpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Apr 2004 16:28:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 18:41, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Roland Dreier <roland@topspin.com> wrote:
> >  >
> >  >     Adam> This problem was annoying me a few months ago so I coded up
> >  >     Adam> a stack trace patch that actually uses the frame pointer.
> >  >     Adam> It is currently maintained in -mjb but I have pasted below.
> >  >     Adam> Hope this helps.
> >  > 
> >  > Thanks, that looks really useful.  What is the chance of this moving
> >  > from -mjb to mainline?
> > 
> >  Good, but it needs to be updated to do the right thing with 4k stacks when
> >  called from interrupt context.

The show_trace() for the CONFIG_FRAME_POINTER case will now be called
the same way as the existing code.  This brings up a question though. 
It doesn't appear to me that anyone is actually calling
show_trace_task() yet.  Am I missing something or should we change all
the callers of show_trace() to use show_trace_task()?

> 
> Also, I'd like to be convinced that it does the right thing across assembly
> code which doesn't set up a correct frame pointer, such as down().
> 
> I assume it will simply skip that frame altogether?

I hacked read_profile() a bit so I could catch it inside down().  This
looks good to me.  In fact, even the inline asm functions were
recognized.  

cat           D 00000246     0   215    212                     (NOTLB)
Call Trace:
              f296feec 00000086 f296ff60 00000246 f296ff10 f681dd60
              00000004 f2b59ce8 f2b59d6c f296fed0 c04b4c80 c04b6680
              f296fee4 c01d7f2a bffffafc f296ff08 002e58e9 08848a79
              00000018 c1a0cbe0 f29a2160 f29a2328 f296ff18
 [<c01079b2>] __down+0x76/0xe0
              00000400 00000000 0804c038 f29a2160 00000001 f29a2160
              c0118c8c f296ff6c f296ff6c f296ff2c
 [<c0107b7f>] __down_failed+0xb/0x14
              f296ff60 f296ff68 f296ff6c f296ff74
 [<c017887e>] .text.lock.proc_misc+0xf/0x21
              00000000 f2a851e0 f2a85200 000011b4 00000000 40869be4
              15b4a440 40869be4 15b4a440 40869be4 00000004 ffffffff
              00000001 00000001 f296ff10 f296ff10 f296ff98
 [<c014a62e>] vfs_read+0x9e/0xd0
              f2a851e0 0804c038 00000400 f2a85200 f2a851e0 fffffff7
              0804c038 f296ffbc
 [<c014a810>] sys_read+0x30/0x50
              f2a851e0 0804c038 00000400 f2a85200 00000003 00000400
              00000000 f296e000
 [<c0108aff>] syscall_call+0x7/0xb

The top stack frame is defined to be all values from esp to ebp. 
Subsequent frames are defined as ebp to *ebp (if ebp is a valid stack
address).  Therefore in the worst case, a stack frame may include data
from two "logical functions" if a new frame was not defined (but we will
not lose any data).  GCC seems to be generating frame-pointer enabled
code even for inline asm calls so we should only see this "worst-case"
behavior around actual assembly functions.

Here is the updated patch (2.6.5)...

diff -purN linux-2.6.5/arch/i386/kernel/traps.c linux-2.6.5+stack/arch/i386/kernel/traps.c
--- linux-2.6.5/arch/i386/kernel/traps.c	Mon Apr  5 16:26:55 2004
+++ linux-2.6.5+stack/arch/i386/kernel/traps.c	Wed Apr 21 15:24:04 2004
@@ -92,6 +92,58 @@ asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
+#ifdef CONFIG_FRAME_POINTER
+#define valid_stack_ptr(task, p) \
+	((p > (unsigned long)task->thread_info) && \
+	 (p < (unsigned long)task->thread_info+THREAD_SIZE))
+
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
+void show_trace(struct task_struct *task, unsigned long * stack)
+{
+	unsigned long addr, ebp;
+
+	if (!task)
+		task = current;
+
+	if (!valid_stack_ptr(task, (unsigned long)stack)) {
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
+	printk("Call Trace:\n");
+	show_stack_frame((unsigned long) stack, ebp+4);
+	while (valid_stack_ptr(task, ebp)) {
+		addr = *(unsigned long *) (ebp + 4);
+		printk(" [<%08lx>] ", addr);
+		print_symbol("%s", addr);
+		printk("\n");
+
+		/* Show the stack frame starting with args */
+		show_stack_frame(ebp + 8, (*(unsigned long *) ebp) + 4);
+		ebp = *(unsigned long *) ebp;
+	}
+}
+#else
 static int kstack_depth_to_print = 24;
 
 void show_trace(struct task_struct *task, unsigned long * stack)
@@ -101,10 +153,7 @@ void show_trace(struct task_struct *task
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace:");
-#ifdef CONFIG_KALLSYMS
-	printk("\n");
-#endif
+	printk("Call Trace:\n");
 	while (!kstack_end(stack)) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
@@ -114,6 +163,7 @@ void show_trace(struct task_struct *task
 	}
 	printk("\n");
 }
+#endif
 
 void show_trace_task(struct task_struct *tsk)
 {
@@ -127,9 +177,6 @@ void show_trace_task(struct task_struct 
 
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
-	unsigned long *stack;
-	int i;
-
 	if (esp == NULL) {
 		if (task)
 			esp = (unsigned long*)task->thread.esp;
@@ -137,6 +184,10 @@ void show_stack(struct task_struct *task
 			esp = (unsigned long *)&esp;
 	}
 
+#ifndef CONFIG_FRAME_POINTER
+	{
+	unsigned long *stack;
+	int i;
 	stack = esp;
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
@@ -146,6 +197,8 @@ void show_stack(struct task_struct *task
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

