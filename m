Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUJDIQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUJDIQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUJDIQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:16:03 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:34529 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S267785AbUJDIPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:15:44 -0400
Message-ID: <41610845.E03B482D@tv-sign.ru>
Date: Mon, 04 Oct 2004 12:22:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, torvalds@osdl.org
Subject: Re: [PATCH] alternate stack dump fix.
References: <41602238.A828A852@tv-sign.ru> <20041003100603.6429acdd.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> But it conflicts in a big way with Kirill's patch.  Could you redo it
> against 2.6.9-rc3-mm1, or against just
>
> fix-of-stack-dump-in-soft-hardirqs.patch
> fix-of-stack-dump-in-soft-hardirqs-cleanup.patch
> fix-of-stack-dump-in-soft-hardirqs-build-fix.patch
>

Rediffed against rc3-mm1.

For your convenience, i will post the same patch against mm tree with those
3 patches reverted in a separate message.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -rup rc3-mm1-clean/arch/i386/kernel/irq.c rc3-mm1-trace/arch/i386/kernel/irq.c
--- rc3-mm1-clean/arch/i386/kernel/irq.c	2004-10-04 10:26:26.000000000 +0400
+++ rc3-mm1-trace/arch/i386/kernel/irq.c	2004-10-04 10:38:06.000000000 +0400
@@ -10,14 +10,12 @@
  * io_apic.c.)
  */
 
+#include <asm/uaccess.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
-
 #ifdef CONFIG_4KSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
@@ -178,23 +176,8 @@ asmlinkage void do_softirq(void)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(do_softirq);
-
-int is_irq_stack_ptr(struct task_struct *task, void *p)
-{
-	unsigned long off;
-
-	off = task->thread_info->cpu * THREAD_SIZE;
-	if (p >= (void *)hardirq_stack + off &&
-	    p < (void *)hardirq_stack + off + THREAD_SIZE)
-		return 1;
-	if (p >= (void *)softirq_stack + off &&
-	    p < (void *)softirq_stack + off + THREAD_SIZE)
-		return 1;
-
-	return 0;
-}
 
+EXPORT_SYMBOL(do_softirq);
 #endif
 
 /*
diff -rup rc3-mm1-clean/arch/i386/kernel/traps.c rc3-mm1-trace/arch/i386/kernel/traps.c
--- rc3-mm1-clean/arch/i386/kernel/traps.c	2004-10-04 10:26:26.000000000 +0400
+++ rc3-mm1-trace/arch/i386/kernel/traps.c	2004-10-04 10:55:03.000000000 +0400
@@ -50,7 +50,6 @@
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
-#include <asm/hardirq.h>
 
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -106,18 +105,6 @@ int register_die_notifier(struct notifie
 	return err;
 }
 
-static int valid_stack_ptr(struct task_struct *task, void *p)
-{
-	if (is_irq_stack_ptr(task, p))
-		return 1;
-	if (p >= (void *)task->thread_info &&
-	    p < (void *)task->thread_info + THREAD_SIZE &&
-	    !kstack_end(p))
-		return 1;
-
-	return 0;
-}
-
 #ifdef CONFIG_KGDB
 extern void sysenter_past_esp(void);
 #include <asm/kgdb.h>
@@ -151,28 +138,27 @@ void breakpoint(void)
 #define	CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,after)
 #endif
 
+static int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
+}
 
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
@@ -180,8 +166,9 @@ static void print_context_stack(struct t
 			printk("\n");
 		}
 	}
-}
 #endif
+	return ebp;
+}
 
 void show_trace(struct task_struct *task, unsigned long * stack)
 {
@@ -190,11 +177,6 @@ void show_trace(struct task_struct *task
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
@@ -207,7 +189,7 @@ void show_trace(struct task_struct *task
 		struct thread_info *context;
 		context = (struct thread_info *)
 			((unsigned long)stack & (~(THREAD_SIZE - 1)));
-		print_context_stack(task, stack, ebp);
+		ebp = print_context_stack(context, stack, ebp);
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
diff -rup rc3-mm1-clean/include/asm-i386/hardirq.h rc3-mm1-trace/include/asm-i386/hardirq.h
--- rc3-mm1-clean/include/asm-i386/hardirq.h	2004-10-04 10:26:41.000000000 +0400
+++ rc3-mm1-trace/include/asm-i386/hardirq.h	2004-10-04 10:38:04.000000000 +0400
@@ -36,15 +36,4 @@ static inline void ack_bad_irq(unsigned 
 #endif
 }
 
-struct task_struct;
-
-#ifdef CONFIG_4KSTACKS
-int is_irq_stack_ptr(struct task_struct *task, void *p);
-#else
-static inline int is_irq_stack_ptr(struct task_struct *task, void *p)
-{
-	return 0;
-}
-#endif
-
 #endif /* __ASM_HARDIRQ_H */
