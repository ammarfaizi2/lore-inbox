Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUIIXa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUIIXa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUIIXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:30:28 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:56056 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266894AbUIIX0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:26:42 -0400
Date: Thu, 9 Sep 2004 16:26:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/3] Remove CONFIG_I386_IRQSTACKS completely
Message-ID: <20040909232606.GB13572@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless the embedded people really disagree violently we should just
use IRQ-stacks all the time.  Depends on the previous posted patch.

 arch/i386/Kconfig.debug |    7 -------
 arch/i386/kernel/irq.c  |   22 ----------------------
 include/asm-i386/irq.h  |    4 ----
 3 files changed, 33 deletions(-)

Signed-off-by: Chris Wedgwood <cw@f00f.org>



diff -Nru a/arch/i386/Kconfig.debug b/arch/i386/Kconfig.debug
--- a/arch/i386/Kconfig.debug	2004-09-09 16:05:58 -07:00
+++ b/arch/i386/Kconfig.debug	2004-09-09 16:05:58 -07:00
@@ -55,13 +55,6 @@
 	  running more threads on a system and also reduces the pressure
 	  on the VM subsystem for higher order allocations.
 
-config I386_IRQSTACKS
-	bool "Allocate separate IRQ stacks"
-	default y
-	help
-	  If you say Y here the kernel will allocate and use separate
-	  stacks for interrupts.
-
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
 	depends on DEBUG_KERNEL && PROC_FS
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2004-09-09 16:05:58 -07:00
+++ b/arch/i386/kernel/irq.c	2004-09-09 16:05:58 -07:00
@@ -76,10 +76,8 @@
 /*
  * per-CPU IRQ handling stacks
  */
-#ifdef CONFIG_I386_IRQSTACKS
 union irq_ctx *hardirq_ctx[NR_CPUS];
 union irq_ctx *softirq_ctx[NR_CPUS];
-#endif /* CONFIG_I386_IRQSTACKS */
 
 /*
  * Special irq handlers.
@@ -489,7 +487,6 @@
 	 * useful for irq hardware that does not mask cleanly in an
 	 * SMP environment.
 	 */
-#ifdef CONFIG_I386_IRQSTACKS
 
 	for (;;) {
 		irqreturn_t action_ret;
@@ -542,23 +539,6 @@
 		desc->status &= ~IRQ_PENDING;
 	}
 
-#else /* not using CONFIG_I386_IRQSTACKS */
-
-	for (;;) {
-		irqreturn_t action_ret;
-
-		spin_unlock(&desc->lock);
-
-		action_ret = handle_IRQ_event(irq, &regs, action);
-
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
-		if (likely(!(desc->status & IRQ_PENDING)))
-			break;
-		desc->status &= ~IRQ_PENDING;
-	}
-#endif /* CONFIG_I386_IRQSTACKS */
 	desc->status &= ~IRQ_INPROGRESS;
 
 out:
@@ -1077,7 +1057,6 @@
 }
 
 
-#ifdef CONFIG_I386_IRQSTACKS
 /*
  * These should really be __section__(".bss.page_aligned") as well, but
  * gcc's 3.0 and earlier don't handle that correctly.
@@ -1155,4 +1134,3 @@
 }
 
 EXPORT_SYMBOL(do_softirq);
-#endif /* CONFIG_I386_IRQSTACKS */
diff -Nru a/include/asm-i386/irq.h b/include/asm-i386/irq.h
--- a/include/asm-i386/irq.h	2004-09-09 16:05:58 -07:00
+++ b/include/asm-i386/irq.h	2004-09-09 16:05:58 -07:00
@@ -31,7 +31,6 @@
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
-#ifdef CONFIG_I386_IRQSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
  */
@@ -46,9 +45,6 @@
 extern void irq_ctx_init(int cpu);
 
 #define __ARCH_HAS_DO_SOFTIRQ
-#else /* not using CONFIG_I386_IRQSTACKS */
-#define irq_ctx_init(cpu) do { ; } while (0)
-#endif /* CONFIG_I386_IRQSTACKS */
 
 struct irqaction;
 struct pt_regs;
