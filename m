Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUIIXcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUIIXcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIIXb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:31:28 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:3580 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267480AbUIIXaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:30:16 -0400
Date: Thu, 9 Sep 2004 16:25:32 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040909232532.GA13572@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now CONFIG_4KSTACKS implies IRQ-stacks.  Some people though
really need 8K stacks and it would be nice to have IRQ-stacks for them
too.

This splits the option in two with the intention of removing the
IRQ-stacks option completely.

 arch/i386/Kconfig.debug        |   13 ++++++++++---
 arch/i386/defconfig            |    1 -
 arch/i386/kernel/irq.c         |   14 +++++++-------
 include/asm-i386/irq.h         |    6 +++---
 include/asm-i386/module.h      |    6 +++---
 include/asm-i386/thread_info.h |    6 +++---
 6 files changed, 26 insertions(+), 20 deletions(-)

Signed-off-by: Chris Wedgwood <cw@f00f.org>



diff -Nru a/arch/i386/Kconfig.debug b/arch/i386/Kconfig.debug
--- a/arch/i386/Kconfig.debug	2004-09-09 16:06:04 -07:00
+++ b/arch/i386/Kconfig.debug	2004-09-09 16:06:04 -07:00
@@ -46,14 +46,21 @@
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
-config 4KSTACKS
+config I386_4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	default n
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates
 	  running more threads on a system and also reduces the pressure
-	  on the VM subsystem for higher order allocations. This option
-	  will also use IRQ stacks to compensate for the reduced stackspace.
+	  on the VM subsystem for higher order allocations.
+
+config I386_IRQSTACKS
+	bool "Allocate separate IRQ stacks"
+	default y
+	help
+	  If you say Y here the kernel will allocate and use separate
+	  stacks for interrupts.
 
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
diff -Nru a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	2004-09-09 16:06:04 -07:00
+++ b/arch/i386/defconfig	2004-09-09 16:06:04 -07:00
@@ -1221,7 +1221,6 @@
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_FRAME_POINTER is not set
-CONFIG_4KSTACKS=y
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
 
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2004-09-09 16:06:04 -07:00
+++ b/arch/i386/kernel/irq.c	2004-09-09 16:06:04 -07:00
@@ -76,10 +76,10 @@
 /*
  * per-CPU IRQ handling stacks
  */
-#ifdef CONFIG_4KSTACKS
+#ifdef CONFIG_I386_IRQSTACKS
 union irq_ctx *hardirq_ctx[NR_CPUS];
 union irq_ctx *softirq_ctx[NR_CPUS];
-#endif
+#endif /* CONFIG_I386_IRQSTACKS */
 
 /*
  * Special irq handlers.
@@ -489,7 +489,7 @@
 	 * useful for irq hardware that does not mask cleanly in an
 	 * SMP environment.
 	 */
-#ifdef CONFIG_4KSTACKS
+#ifdef CONFIG_I386_IRQSTACKS
 
 	for (;;) {
 		irqreturn_t action_ret;
@@ -542,7 +542,7 @@
 		desc->status &= ~IRQ_PENDING;
 	}
 
-#else
+#else /* not using CONFIG_I386_IRQSTACKS */
 
 	for (;;) {
 		irqreturn_t action_ret;
@@ -558,7 +558,7 @@
 			break;
 		desc->status &= ~IRQ_PENDING;
 	}
-#endif
+#endif /* CONFIG_I386_IRQSTACKS */
 	desc->status &= ~IRQ_INPROGRESS;
 
 out:
@@ -1077,7 +1077,7 @@
 }
 
 
-#ifdef CONFIG_4KSTACKS
+#ifdef CONFIG_I386_IRQSTACKS
 /*
  * These should really be __section__(".bss.page_aligned") as well, but
  * gcc's 3.0 and earlier don't handle that correctly.
@@ -1155,4 +1155,4 @@
 }
 
 EXPORT_SYMBOL(do_softirq);
-#endif
+#endif /* CONFIG_I386_IRQSTACKS */
diff -Nru a/include/asm-i386/irq.h b/include/asm-i386/irq.h
--- a/include/asm-i386/irq.h	2004-09-09 16:06:04 -07:00
+++ b/include/asm-i386/irq.h	2004-09-09 16:06:04 -07:00
@@ -31,7 +31,7 @@
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
-#ifdef CONFIG_4KSTACKS
+#ifdef CONFIG_I386_IRQSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
  */
@@ -46,9 +46,9 @@
 extern void irq_ctx_init(int cpu);
 
 #define __ARCH_HAS_DO_SOFTIRQ
-#else
+#else /* not using CONFIG_I386_IRQSTACKS */
 #define irq_ctx_init(cpu) do { ; } while (0)
-#endif
+#endif /* CONFIG_I386_IRQSTACKS */
 
 struct irqaction;
 struct pt_regs;
diff -Nru a/include/asm-i386/module.h b/include/asm-i386/module.h
--- a/include/asm-i386/module.h	2004-09-09 16:06:04 -07:00
+++ b/include/asm-i386/module.h	2004-09-09 16:06:04 -07:00
@@ -60,11 +60,11 @@
 #define MODULE_REGPARM ""
 #endif
 
-#ifdef CONFIG_4KSTACKS
+#ifdef CONFIG_I386_4KSTACKS
 #define MODULE_STACKSIZE "4KSTACKS "
-#else
+#else /* not using CONFIG_I386_4KSTACKS */
 #define MODULE_STACKSIZE ""
-#endif
+#endif /* CONFIG_I386_4KSTACKS */
 
 #define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE
 
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	2004-09-09 16:06:04 -07:00
+++ b/include/asm-i386/thread_info.h	2004-09-09 16:06:04 -07:00
@@ -52,11 +52,11 @@
 #endif
 
 #define PREEMPT_ACTIVE		0x4000000
-#ifdef CONFIG_4KSTACKS
+#ifdef CONFIG_I386_4KSTACKS
 #define THREAD_SIZE            (4096)
-#else
+#else /* not using CONFIG_I386_4KSTACKS */
 #define THREAD_SIZE		(8192)
-#endif
+#endif /* CONFIG_I386_4KSTACKS */
 
 #define STACK_WARN             (THREAD_SIZE/8)
 /*
