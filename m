Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269973AbUJHNiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269973AbUJHNiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269976AbUJHNhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:37:40 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:35291 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S269957AbUJHNfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:35:13 -0400
Message-ID: <4166978E.1C7C1B25@tv-sign.ru>
Date: Fri, 08 Oct 2004 17:35:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][RESEND] show_trace() in irq context with CONFIG_4KSTACKS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. valid_stack_ptr() erroneously assumes that stack always
lives in task_struct->thread_info.

2. the main loop in show_trace() does not recalc ebp after
stack switching. With CONFIG_FRAME_POINTER every call to
print_context_stack() will produce the same output.

There is a Kirill's patch in mm tree which solves 1, but not 2.

With this patch, show_trace() does not use task argument in the
main loop. Instead, it converts stack to thread_info* context,
and passes it to print_context_stack() and (implicitly) to
valid_stack_ptr().

valid_stack_ptr() now does bounds checking against proper context.

Please note, i simply deleted this printk("Stack pointer is garbage"),
it can be restored, if neccessary.

Against 2.6.9-rc3.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.9-rc3/arch/i386/kernel/traps.c~	Sun Oct  3 18:45:52 2004
+++ 2.6.9-rc3/arch/i386/kernel/traps.c	Fri Oct  8 14:29:57 2004
@@ -107,36 +107,27 @@ int register_die_notifier(struct notifie
 	return err;
 }
 
-static int valid_stack_ptr(struct task_struct *task, void *p)
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
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
-			 unsigned long ebp)
+static inline unsigned long print_context_stack(struct thread_info *tinfo,
+				unsigned long *stack, unsigned long ebp)
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
@@ -144,8 +135,9 @@ static void print_context_stack(struct t
 			printk("\n");
 		}
 	}
-}
 #endif
+	return ebp;
+}
 
 void show_trace(struct task_struct *task, unsigned long * stack)
 {
@@ -154,11 +146,6 @@ void show_trace(struct task_struct *task
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
@@ -171,7 +158,7 @@ void show_trace(struct task_struct *task
 		struct thread_info *context;
 		context = (struct thread_info *)
 			((unsigned long)stack & (~(THREAD_SIZE - 1)));
-		print_context_stack(task, stack, ebp);
+		ebp = print_context_stack(context, stack, ebp);
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
