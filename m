Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTKECV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 21:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTKECV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 21:21:59 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:32215 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262709AbTKECVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 21:21:55 -0500
Date: Wed, 5 Nov 2003 13:21:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Adam Litke <agl@us.ibm.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [RFC] Smarter stack traces using the frame pointer
Message-Id: <20031105132138.59326dd4.sfr@canb.auug.org.au>
In-Reply-To: <1067984031.544.23.camel@agtpad>
References: <1067984031.544.23.camel@agtpad>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Nov 2003 14:13:49 -0800 Adam Litke <agl@us.ibm.com> wrote:
>
> I was working on this for the mjb tree but I thought I'd throw it out
> here in case anyone else finds it interesting.  This simple change to
> the stack trace code uses the frame pointer to do the trace instead of
> assuming any kernel address on the stack is a return address.  It makes
> for much more readable stack traces.

I was asked by a colleague to do the same thing and came up with this
alternative version which, I think, gets it mostly right - I am not
sure about the stack trace from an OOPS.

Don't bother to tell me this is a bit of a hack - I know :-)

Patch relative to 2.6.0-test9.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.0-test9/arch/i386/kernel/process.c 2.6.0-test9-sfr.1/arch/i386/kernel/process.c
--- 2.6.0-test9/arch/i386/kernel/process.c	2003-10-09 10:22:41.000000000 +1000
+++ 2.6.0-test9-sfr.1/arch/i386/kernel/process.c	2003-10-28 17:00:40.000000000 +1100
@@ -243,7 +243,7 @@
 		".previous			\n"
 		: "=r" (cr4): "0" (0));
 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
-	show_trace(NULL, &regs->esp);
+	show_trace(&regs->esp, (unsigned long *)regs->ebp);
 }
 
 /*
diff -ruN 2.6.0-test9/arch/i386/kernel/traps.c 2.6.0-test9-sfr.1/arch/i386/kernel/traps.c
--- 2.6.0-test9/arch/i386/kernel/traps.c	2003-10-20 11:35:54.000000000 +1000
+++ 2.6.0-test9-sfr.1/arch/i386/kernel/traps.c	2003-10-29 15:45:50.000000000 +1100
@@ -91,9 +91,11 @@
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
+#define DECLARE_EBP	register unsigned long *ebp asm("ebp")
+
 static int kstack_depth_to_print = 24;
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+void show_trace(unsigned long *stack, unsigned long *frame)
 {
 	unsigned long addr;
 
@@ -106,10 +108,24 @@
 #endif
 	while (!kstack_end(stack)) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (
+#ifdef CONFIG_FRAME_POINTER
+			/*
+			 * The plus 2 is because the return address
+			 * is immediately above where the frame pointer 
+			 * points and we incremented the stack pointer
+			 * above ...
+			 */
+			(!frame || (stack == (frame + 2))) &&
+#endif
+			kernel_text_address(addr)) {
 			printk(" [<%08lx>] ", addr);
 			print_symbol("%s\n", addr);
 		}
+#ifdef CONFIG_FRAME_POINTER
+		if (frame && (stack == (frame + 2)))
+			frame = (unsigned long *)*frame;
+#endif
 	}
 	printk("\n");
 }
@@ -121,19 +137,45 @@
 	/* User space on another CPU? */
 	if ((esp ^ (unsigned long)tsk->thread_info) & (PAGE_MASK<<1))
 		return;
-	show_trace(tsk, (unsigned long *)esp);
+	/*
+	 * switch_to pushes the frame pointer just before saving
+	 * the stack pointer.
+	 */
+	show_trace((unsigned long *)esp, (unsigned long *)*(unsigned long *)esp);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
 	unsigned long *stack;
 	int i;
+	DECLARE_EBP;
+	unsigned long *frame;
 
 	if (esp == NULL) {
-		if (task)
+		if (task && (task != current)) {
 			esp = (unsigned long*)task->thread.esp;
-		else
+			/*
+			 * switch_to pushes the frame pointer just before
+			 * saving the stack pointer.
+			 */
+			frame = (unsigned long *)*esp;
+		} else {
 			esp = (unsigned long *)&esp;
+			frame = ebp;
+#ifdef CONFIG_FRAME_POINTER
+			/* we want the enclosing frame ... */
+			frame = (unsigned long *)*ebp;
+#endif
+		}
+	} else {
+		/*
+		 * The only place that calls show_stack with task == NULL
+		 * and esp != NULL is show_registers below, where esp
+		 * points at the esp field of a pt_regs structure on the
+		 * stack.  So this gets us the saved ebp value.
+		 */
+		frame = ((struct pt_regs *)((unsigned char *)esp -
+				offsetof(struct pt_regs, esp)))->ebp;
 	}
 
 	stack = esp;
@@ -145,7 +187,7 @@
 		printk("%08lx ", *stack++);
 	}
 	printk("\n");
-	show_trace(task, esp);
+	show_trace(esp, frame);
 }
 
 /*
@@ -154,8 +196,9 @@
 void dump_stack(void)
 {
 	unsigned long stack;
+	DECLARE_EBP;
 
-	show_trace(current, &stack);
+	show_trace(&stack, ebp);
 }
 
 EXPORT_SYMBOL(dump_stack);
diff -ruN 2.6.0-test9/include/asm-i386/processor.h 2.6.0-test9-sfr.1/include/asm-i386/processor.h
--- 2.6.0-test9/include/asm-i386/processor.h	2003-10-20 11:36:07.000000000 +1000
+++ 2.6.0-test9-sfr.1/include/asm-i386/processor.h	2003-10-28 16:57:42.000000000 +1100
@@ -492,7 +492,7 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
-void show_trace(struct task_struct *task, unsigned long *stack);
+void show_trace(unsigned long *stack, unsigned long *frame);
 
 unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
