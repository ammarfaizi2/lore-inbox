Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUJCPyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUJCPyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUJCPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:54:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:4298 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S267985AbUJCPyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:54:14 -0400
Message-ID: <41602238.A828A852@tv-sign.ru>
Date: Sun, 03 Oct 2004 20:00:56 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] alternate stack dump fix.
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kirill Korotaev wrote:
>
> This patch fixes incorrect check for stack ptr in
> show_trace()->valid_stack_ptr(). When called from hardirq/softirq
> show_trace() prints "Stack pointer is garbage, not printing trace"
> message instead of call traces.

There is another problem in show_trace(). With CONFIG_FRAME_POINTER
every call to print_context_stack() will now print entire call chain,
switching the stacks transparently, beacause valid_stack_ptr()
now accepts ebp in irq stack.

Then show trace switch the stack, and calls print_context_stack()
again with the same value in ebp, and we have the same dump
after printk(" =======================\n").

What do you think about the following patch?

Against 2.6.9-rc3.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.9-rc3/arch/i386/kernel/traps.c~	Sun Oct  3 18:45:52 2004
+++ 2.6.9-rc3/arch/i386/kernel/traps.c	Sun Oct  3 19:54:07 2004
@@ -107,36 +107,27 @@ int register_die_notifier(struct notifie
 	return err;
 }
 
-static int valid_stack_ptr(struct task_struct *task, void *p)
+static int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
-	if (p <= (void *)task->thread_info)
-		return 0;
-	if (kstack_end(p))
-		return 0;
-	return 1;
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
 }
 
-#ifdef CONFIG_FRAME_POINTER
-static void print_context_stack(struct task_struct *task, unsigned long *stack,
+static unsigned long print_context_stack(struct thread_info *tinfo, unsigned long *stack,
 			 unsigned long ebp)
 {
 	unsigned long addr;
 
-	while (valid_stack_ptr(task, (void *)ebp)) {
+#ifdef	CONFIG_FRAME_POINTER
+	while (valid_stack_ptr(tinfo, (void *)ebp)) {
 		addr = *(unsigned long *)(ebp + 4);
 		printk(" [<%08lx>] ", addr);
 		print_symbol("%s", addr);
 		printk("\n");
 		ebp = *(unsigned long *)ebp;
 	}
-}
 #else
-static void print_context_stack(struct task_struct *task, unsigned long *stack,
-			 unsigned long ebp)
-{
-	unsigned long addr;
-
-	while (!kstack_end(stack)) {
+	while (valid_stack_ptr(tinfo, stack)) {
 		addr = *stack++;
 		if (__kernel_text_address(addr)) {
 			printk(" [<%08lx>]", addr);
@@ -144,9 +135,11 @@ static void print_context_stack(struct t
 			printk("\n");
 		}
 	}
-}
 #endif
 
+	return ebp;
+}
+
 void show_trace(struct task_struct *task, unsigned long * stack)
 {
 	unsigned long ebp;
@@ -154,11 +147,6 @@ void show_trace(struct task_struct *task
 	if (!task)
 		task = current;
 
-	if (!valid_stack_ptr(task, stack)) {
-		printk("Stack pointer is garbage, not printing trace\n");
-		return;
-	}
-
 	if (task == current) {
 		/* Grab ebp right from our regs */
 		asm ("movl %%ebp, %0" : "=r" (ebp) : );
@@ -171,7 +159,7 @@ void show_trace(struct task_struct *task
 		struct thread_info *context;
 		context = (struct thread_info *)
 			((unsigned long)stack & (~(THREAD_SIZE - 1)));
-		print_context_stack(task, stack, ebp);
+		ebp = print_context_stack(context, stack, ebp);
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
