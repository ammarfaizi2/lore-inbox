Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268160AbUIKUl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbUIKUl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIKUl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:41:56 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:11951 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268160AbUIKUla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:41:30 -0400
Date: Sat, 11 Sep 2004 13:41:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjanv@redhat.com>
Subject: [PATCH] Kill CONFIG_4KSTACKS
Message-ID: <20040911204125.GA26179@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://linux.bkbits.net:8080/linux-2.5/cset@407af9a3SmWwuO0CEQwLmAZoLXAcCA
seems to indicate 8K stacks are deprecated.  This removes the option
completely so were now use 4k-process + 4k-irq stacks all the time.

Probably a bit premature...



 arch/i386/Kconfig.debug        |    9 ---------
 arch/i386/defconfig            |    1 -
 arch/i386/kernel/irq.c         |   24 +-----------------------
 include/asm-i386/irq.h         |    4 ----
 include/asm-i386/module.h      |    8 +-------
 include/asm-i386/thread_info.h |    4 ----
 6 files changed, 2 insertions(+), 48 deletions(-)


===== arch/i386/Kconfig.debug 1.3 vs edited =====
--- 1.3/arch/i386/Kconfig.debug	2004-08-31 00:55:12 -07:00
+++ edited/arch/i386/Kconfig.debug	2004-09-11 13:11:39 -07:00
@@ -46,15 +46,6 @@
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
-config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
-	help
-	  If you say Y here the kernel will use a 4Kb stacksize for the
-	  kernel stack attached to each process/thread. This facilitates
-	  running more threads on a system and also reduces the pressure
-	  on the VM subsystem for higher order allocations. This option
-	  will also use IRQ stacks to compensate for the reduced stackspace.
-
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
 	depends on DEBUG_KERNEL && PROC_FS
===== arch/i386/defconfig 1.113 vs edited =====
--- 1.113/arch/i386/defconfig	2004-06-27 00:19:31 -07:00
+++ edited/arch/i386/defconfig	2004-09-11 12:58:09 -07:00
@@ -1221,7 +1221,6 @@
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_FRAME_POINTER is not set
-CONFIG_4KSTACKS=y
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
 
===== arch/i386/kernel/irq.c 1.59 vs edited =====
--- 1.59/arch/i386/kernel/irq.c	2004-08-31 00:57:57 -07:00
+++ edited/arch/i386/kernel/irq.c	2004-09-11 13:15:23 -07:00
@@ -76,10 +76,8 @@
 /*
  * per-CPU IRQ handling stacks
  */
-#ifdef CONFIG_4KSTACKS
 union irq_ctx *hardirq_ctx[NR_CPUS];
 union irq_ctx *softirq_ctx[NR_CPUS];
-#endif
 
 /*
  * Special irq handlers.
@@ -435,7 +433,7 @@
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-	/* Debugging check for stack overflow: is there less than 1KB free? */
+	/* Debugging check for stack overflow */
 	{
 		long esp;
 
@@ -489,7 +487,6 @@
 	 * useful for irq hardware that does not mask cleanly in an
 	 * SMP environment.
 	 */
-#ifdef CONFIG_4KSTACKS
 
 	for (;;) {
 		irqreturn_t action_ret;
@@ -542,23 +539,6 @@
 		desc->status &= ~IRQ_PENDING;
 	}
 
-#else
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
-#endif
 	desc->status &= ~IRQ_INPROGRESS;
 
 out:
@@ -1077,7 +1057,6 @@
 }
 
 
-#ifdef CONFIG_4KSTACKS
 /*
  * These should really be __section__(".bss.page_aligned") as well, but
  * gcc's 3.0 and earlier don't handle that correctly.
@@ -1155,4 +1134,3 @@
 }
 
 EXPORT_SYMBOL(do_softirq);
-#endif
===== include/asm-i386/irq.h 1.11 vs edited =====
--- 1.11/include/asm-i386/irq.h	2004-04-12 10:54:45 -07:00
+++ edited/include/asm-i386/irq.h	2004-09-11 12:58:19 -07:00
@@ -31,7 +31,6 @@
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
-#ifdef CONFIG_4KSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
  */
@@ -46,9 +45,6 @@
 extern void irq_ctx_init(int cpu);
 
 #define __ARCH_HAS_DO_SOFTIRQ
-#else
-#define irq_ctx_init(cpu) do { ; } while (0)
-#endif
 
 struct irqaction;
 struct pt_regs;
===== include/asm-i386/module.h 1.11 vs edited =====
--- 1.11/include/asm-i386/module.h	2004-04-12 10:54:45 -07:00
+++ edited/include/asm-i386/module.h	2004-09-11 13:01:43 -07:00
@@ -60,12 +60,6 @@
 #define MODULE_REGPARM ""
 #endif
 
-#ifdef CONFIG_4KSTACKS
-#define MODULE_STACKSIZE "4KSTACKS "
-#else
-#define MODULE_STACKSIZE ""
-#endif
-
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE
+#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM
 
 #endif /* _ASM_I386_MODULE_H */
===== include/asm-i386/thread_info.h 1.20 vs edited =====
--- 1.20/include/asm-i386/thread_info.h	2004-08-23 01:14:45 -07:00
+++ edited/include/asm-i386/thread_info.h	2004-09-11 13:01:43 -07:00
@@ -52,11 +52,7 @@
 #endif
 
 #define PREEMPT_ACTIVE		0x4000000
-#ifdef CONFIG_4KSTACKS
 #define THREAD_SIZE            (4096)
-#else
-#define THREAD_SIZE		(8192)
-#endif
 
 #define STACK_WARN             (THREAD_SIZE/8)
 /*

