Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUEYKzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUEYKzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 06:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUEYKzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 06:55:54 -0400
Received: from ozlabs.org ([203.10.76.45]:30922 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263003AbUEYKzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 06:55:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16563.9827.783950.254480@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 20:56:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IRQ stacks for PPC64
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even with a 16kB stack, we have been seeing stack overflows on PPC64
under stress.  This patch implements separate per-cpu stacks for
processing interrupts and softirqs, along the lines of the
CONFIG_4KSTACKS stuff on x86.  At the moment the stacks are still 16kB
but I hope we can reduce that to 8kB in future.  (Gcc is capable of
adding instructions to the function prolog to check the stack pointer
whenever it moves it downwards, and I want to use that when I try
using 8kB stacks so I can be confident that we aren't overflowing the
stack.)

Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/Kconfig test25/arch/ppc64/Kconfig
--- linux-2.5/arch/ppc64/Kconfig	2004-05-15 13:32:15.000000000 +1000
+++ test25/arch/ppc64/Kconfig	2004-05-25 17:31:51.258948280 +1000
@@ -417,6 +417,13 @@
 	  debugging info resulting in a larger kernel image.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
+
+config IRQSTACKS
+	bool "Use separate kernel stacks when processing interrupts"
+	help
+	  If you say Y here the kernel will use separate kernel stacks
+	  for handling hard and soft interrupts.  This can help avoid
+	  overflowing the process kernel stacks.
 	  
 endmenu
 
diff -urN linux-2.5/arch/ppc64/kernel/irq.c test25/arch/ppc64/kernel/irq.c
--- linux-2.5/arch/ppc64/kernel/irq.c	2004-05-20 08:06:38.000000000 +1000
+++ test25/arch/ppc64/kernel/irq.c	2004-05-25 17:49:37.234918552 +1000
@@ -370,8 +370,7 @@
 	return 0;
 }
 
-static inline int handle_irq_event(int irq, struct pt_regs *regs,
-				   struct irqaction *action)
+int handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
 {
 	int status = 0;
 	int retval = 0;
@@ -482,6 +481,9 @@
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = get_irq_desc(irq);
 	irqreturn_t action_ret;
+#ifdef CONFIG_IRQSTACKS
+	struct thread_info *curtp, *irqtp;
+#endif
 
 	kstat_cpu(cpu).irqs[irq]++;
 
@@ -548,7 +550,22 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		action_ret = handle_irq_event(irq, regs, action);
+
+#ifdef CONFIG_IRQSTACKS
+		/* Switch to the irq stack to handle this */
+		curtp = current_thread_info();
+		irqtp = hardirq_ctx[smp_processor_id()];
+		if (curtp != irqtp) {
+			irqtp->task = curtp->task;
+			irqtp->flags = 0;
+			action_ret = call_handle_irq_event(irq, regs, action, irqtp);
+			irqtp->task = NULL;
+			if (irqtp->flags)
+				set_bits(irqtp->flags, &curtp->flags);
+		} else
+#endif
+			action_ret = handle_irq_event(irq, regs, action);
+
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
@@ -690,6 +707,7 @@
 	once++;
 
 	ppc_md.init_IRQ();
+	irq_ctx_init();
 }
 
 static struct proc_dir_entry * root_irq_dir;
@@ -973,4 +991,51 @@
 
 }
 
-#endif
+#endif /* CONFIG_PPC_ISERIES */
+
+#ifdef CONFIG_IRQSTACKS
+struct thread_info *softirq_ctx[NR_CPUS];
+struct thread_info *hardirq_ctx[NR_CPUS];
+
+void irq_ctx_init(void)
+{
+	struct thread_info *tp;
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
+		tp = softirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = SOFTIRQ_OFFSET;
+
+		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
+		tp = hardirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = HARDIRQ_OFFSET;
+	}
+}
+
+void do_softirq(void)
+{
+	unsigned long flags;
+	struct thread_info *curtp, *irqtp;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	if (local_softirq_pending()) {
+		curtp = current_thread_info();
+		irqtp = softirq_ctx[smp_processor_id()];
+		irqtp->task = curtp->task;
+		call_do_softirq(irqtp);
+		irqtp->task = NULL;
+	}
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(do_softirq);
+
+#endif /* CONFIG_IRQSTACKS */
+
diff -urN linux-2.5/arch/ppc64/kernel/misc.S test25/arch/ppc64/kernel/misc.S
--- linux-2.5/arch/ppc64/kernel/misc.S	2004-05-23 17:45:55.000000000 +1000
+++ test25/arch/ppc64/kernel/misc.S	2004-05-25 17:31:51.272946152 +1000
@@ -102,6 +102,30 @@
 	blr
 #endif /* CONFIG_PPC_ISERIES */
 
+#ifdef CONFIG_IRQSTACKS
+_GLOBAL(call_do_softirq)
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,THREAD_SIZE-112(r3)
+	mr	r1,r3
+	bl	.__do_softirq
+	ld	r1,0(r1)
+	ld	r0,16(r1)
+	mtlr	r0
+	blr
+
+_GLOBAL(call_handle_irq_event)
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,THREAD_SIZE-112(r6)
+	mr	r1,r6
+	bl	.handle_irq_event
+	ld	r1,0(r1)
+	ld	r0,16(r1)
+	mtlr	r0
+	blr
+#endif /* CONFIG_IRQSTACKS */
+
 /*
  * Flush instruction cache.
  */
diff -urN linux-2.5/arch/ppc64/kernel/process.c test25/arch/ppc64/kernel/process.c
--- linux-2.5/arch/ppc64/kernel/process.c	2004-05-25 15:23:48.000000000 +1000
+++ test25/arch/ppc64/kernel/process.c	2004-05-25 18:10:18.969914992 +1000
@@ -466,6 +466,18 @@
 	    && sp <= stack_page + THREAD_SIZE - nbytes)
 		return 1;
 
+#ifdef CONFIG_IRQSTACKS
+	stack_page = (unsigned long) hardirq_ctx[task_cpu(p)];
+	if (sp >= stack_page + sizeof(struct thread_struct)
+	    && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+
+	stack_page = (unsigned long) softirq_ctx[task_cpu(p)];
+	if (sp >= stack_page + sizeof(struct thread_struct)
+	    && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+#endif
+
 	return 0;
 }
 
diff -urN linux-2.5/arch/ppc64/kernel/setup.c test25/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2004-05-23 17:45:55.000000000 +1000
+++ test25/arch/ppc64/kernel/setup.c	2004-05-25 17:51:55.875878208 +1000
@@ -572,6 +572,23 @@
 
 extern void (*calibrate_delay)(void);
 
+#ifdef CONFIG_IRQSTACKS
+static void __init irqstack_early_init(void)
+{
+	int i;
+
+	/* interrupt stacks must be under 256MB, we cannot afford to take SLB misses on them */
+	for (i = 0; i < NR_CPUS; i++) {
+		softirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
+					THREAD_SIZE, 0x10000000));
+		hardirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
+					THREAD_SIZE, 0x10000000));
+	}
+}
+#else
+#define irqstack_early_init()
+#endif
+
 /*
  * Called into from start_kernel, after lock_kernel has been called.
  * Initializes bootmem, which is unsed to manage page allocation until
@@ -617,6 +634,8 @@
 	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));
 	*cmdline_p = cmd_line;
 
+	irqstack_early_init();
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 
diff -urN linux-2.5/include/asm-ppc64/bitops.h test25/include/asm-ppc64/bitops.h
--- linux-2.5/include/asm-ppc64/bitops.h	2003-07-02 11:55:58.000000000 +1000
+++ test25/include/asm-ppc64/bitops.h	2004-05-25 17:31:51.286944024 +1000
@@ -154,6 +154,20 @@
 	return (old & mask) != 0;
 }
 
+static __inline__ void set_bits(unsigned long mask, unsigned long *addr)
+{
+	unsigned long old;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%3		# set_bit\n\
+	or	%0,%0,%2\n\
+	stdcx.	%0,0,%3\n\
+	bne-	1b"
+	: "=&r" (old), "=m" (*addr)
+	: "r" (mask), "r" (addr), "m" (*addr)
+	: "cc");
+}
+
 /*
  * non-atomic versions
  */
diff -urN linux-2.5/include/asm-ppc64/irq.h test25/include/asm-ppc64/irq.h
--- linux-2.5/include/asm-ppc64/irq.h	2004-04-13 09:25:10.000000000 +1000
+++ test25/include/asm-ppc64/irq.h	2004-05-25 17:31:51.292943112 +1000
@@ -9,6 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/threads.h>
 #include <asm/atomic.h>
 
 /*
@@ -77,7 +78,26 @@
 
 struct irqaction;
 struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
+int handle_irq_event(int, struct pt_regs *, struct irqaction *);
+
+#ifdef CONFIG_IRQSTACKS
+/*
+ * Per-cpu stacks for handling hard and soft interrupts.
+ */
+extern struct thread_info *hardirq_ctx[NR_CPUS];
+extern struct thread_info *softirq_ctx[NR_CPUS];
+
+extern void irq_ctx_init(void);
+extern void call_do_softirq(struct thread_info *tp);
+extern int call_handle_irq_event(int irq, struct pt_regs *regs,
+			struct irqaction *action, struct thread_info *tp);
+
+#define __ARCH_HAS_DO_SOFTIRQ
+
+#else
+#define irq_ctx_init()
+
+#endif /* CONFIG_IRQSTACKS */
 
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */
