Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUJDLpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUJDLpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUJDLpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:45:31 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:38789 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S268024AbUJDLpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:45:25 -0400
Message-ID: <4161396A.F27113FF@tv-sign.ru>
Date: Mon, 04 Oct 2004 15:52:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] kill thread_info.previous_esp
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

current_stack_pointer() can be saved in irq_ctx->stack after stack
switching.

Personally, i think it is a more natural way. It is a matter of taste,
of course, so feel free to ignore this.

This irq_previous_esp() is based on Kirill's is_irq_stack_ptr() idea.

On top of the "alternate stack dump fix", see
http://marc.theaimsgroup.com/?l=linux-kernel&m=109687808210397

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -rup rc3-mm1-trace/arch/i386/kernel/irq.c rc3-mm1-noesp/arch/i386/kernel/irq.c
--- rc3-mm1-trace/arch/i386/kernel/irq.c	2004-10-04 10:38:06.000000000 +0400
+++ rc3-mm1-noesp/arch/i386/kernel/irq.c	2004-10-04 14:49:45.000000000 +0400
@@ -74,8 +74,8 @@ asmlinkage unsigned int do_IRQ(struct pt
 		/* build the stack frame on the IRQ stack */
 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
 		irqctx->tinfo.task = curctx->tinfo.task;
-		irqctx->tinfo.previous_esp = current_stack_pointer();
 
+		*--isp = (u32) current_stack_pointer();
 		*--isp = (u32) &regs;
 		*--isp = (u32) irq;
 
@@ -109,6 +109,24 @@ static char softirq_stack[NR_CPUS * THRE
 static char hardirq_stack[NR_CPUS * THREAD_SIZE]
 		__attribute__((__aligned__(THREAD_SIZE)));
 
+
+unsigned long irq_previous_esp(struct thread_info *context)
+{
+	union irq_ctx *irqctx;
+
+	irqctx = hardirq_ctx[context->cpu];
+	if (&irqctx->tinfo == context)
+		goto ok;
+
+	irqctx = softirq_ctx[context->cpu];
+	if (&irqctx->tinfo == context)
+		goto ok;
+
+	return 0;
+ok:
+	return irqctx->stack[ARRAY_SIZE(irqctx->stack) - 1];
+}
+
 /*
  * allocate per-cpu stacks for hardirq and for softirq processing
  */
@@ -159,11 +177,12 @@ asmlinkage void do_softirq(void)
 		curctx = current_thread_info();
 		irqctx = softirq_ctx[smp_processor_id()];
 		irqctx->tinfo.task = curctx->task;
-		irqctx->tinfo.previous_esp = current_stack_pointer();
 
 		/* build the stack frame on the softirq stack */
 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
 
+		*--isp = (u32) current_stack_pointer();
+
 		asm volatile(
 			"       xchgl   %%ebx,%%esp     \n"
 			"       call    __do_softirq    \n"
diff -rup rc3-mm1-trace/arch/i386/kernel/traps.c rc3-mm1-noesp/arch/i386/kernel/traps.c
--- rc3-mm1-trace/arch/i386/kernel/traps.c	2004-10-04 10:55:03.000000000 +0400
+++ rc3-mm1-noesp/arch/i386/kernel/traps.c	2004-10-04 14:50:20.000000000 +0400
@@ -190,7 +190,7 @@ void show_trace(struct task_struct *task
 		context = (struct thread_info *)
 			((unsigned long)stack & (~(THREAD_SIZE - 1)));
 		ebp = print_context_stack(context, stack, ebp);
-		stack = (unsigned long*)context->previous_esp;
+		stack = (unsigned long*)irq_previous_esp(context);
 		if (!stack)
 			break;
 		printk(" =======================\n");
diff -rup rc3-mm1-trace/include/asm-i386/irq.h rc3-mm1-noesp/include/asm-i386/irq.h
--- rc3-mm1-trace/include/asm-i386/irq.h	2004-10-04 10:26:41.000000000 +0400
+++ rc3-mm1-noesp/include/asm-i386/irq.h	2004-10-04 14:49:45.000000000 +0400
@@ -29,9 +29,14 @@ extern void release_vm86_irqs(struct tas
 
 #ifdef CONFIG_4KSTACKS
   extern void irq_ctx_init(int cpu);
+unsigned long irq_previous_esp(struct thread_info *context);
 # define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
+static inline unsigned long irq_previous_esp(struct thread_info *context)
+{
+	return 0;
+}
 #endif
 
 #endif /* _ASM_IRQ_H */
diff -rup rc3-mm1-trace/include/asm-i386/thread_info.h rc3-mm1-noesp/include/asm-i386/thread_info.h
--- rc3-mm1-trace/include/asm-i386/thread_info.h	2004-09-13 09:31:43.000000000 +0400
+++ rc3-mm1-noesp/include/asm-i386/thread_info.h	2004-10-04 14:43:01.000000000 +0400
@@ -39,9 +39,6 @@ struct thread_info {
 						*/
 	struct restart_block    restart_block;
 
-	unsigned long           previous_esp;   /* ESP of the previous stack in case
-						   of nested (IRQ) stacks
-						*/
 	__u8			supervisor_stack[0];
 };
