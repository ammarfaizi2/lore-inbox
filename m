Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUKNKXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUKNKXo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 05:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUKNKXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 05:23:44 -0500
Received: from verein.lst.de ([213.95.11.210]:62645 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261276AbUKNKXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 05:23:09 -0500
Date: Sun, 14 Nov 2004 11:22:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move irq_enter and irq_exit to common code
Message-ID: <20041114102257.GA31844@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code is the same for all architectures with the following
invariants:

 - arm gurantees irqs are disabled when calling irq_exit so it can call
   __do_softirq directly instead of do_softirq
 - arm26 is totally broken for about half a year, I didn't care for it
 - some architectures use softirq_pending(smp_processor_id()) instead
   of local_softirq_pending, but they always evaluate to the same
 
This patch moves the out of line irq_exit implementation from
kernel/irq/handle.c which depends on CONFIG_GENERIC_HARDIRQS to
kernel/softirq.c which is always compiled, tweaks it for the arm
special case and moves the irq_enter/irq_exit/nmi_enter/nmi_exit bits
from asm-*/hardirq.h to linux/hardirq.h


--- 1.22/arch/ia64/kernel/irq_ia64.c	2004-10-20 10:37:14 +02:00
+++ edited/arch/ia64/kernel/irq_ia64.c	2004-11-14 10:23:16 +01:00
@@ -60,21 +60,6 @@
 };
 EXPORT_SYMBOL(isa_irq_to_vector_map);
 
-static inline void
-irq_enter (void)
-{
-	preempt_count() += HARDIRQ_OFFSET;
-}
-
-static inline void
-irq_exit (void)
-{
-	preempt_count() -= IRQ_EXIT_OFFSET;
-	if (!in_interrupt() && local_softirq_pending())
-		do_softirq();
-	preempt_enable_no_resched();
-}
-
 int
 assign_irq_vector (int irq)
 {
--- 1.10/include/asm-alpha/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-alpha/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -29,14 +29,4 @@
 #error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()						\
-do {								\
-		preempt_count() -= IRQ_EXIT_OFFSET;		\
-		if (!in_interrupt() &&				\
-		    softirq_pending(smp_processor_id()))	\
-			do_softirq();				\
-		preempt_enable_no_resched();			\
-} while (0)
-
 #endif /* _ALPHA_HARDIRQ_H */
--- 1.15/include/asm-arm/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-arm/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -27,16 +27,6 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-extern asmlinkage void __do_softirq(void);
-
-#define irq_exit()							\
-	do {								\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && local_softirq_pending())		\
-			__do_softirq();					\
-		preempt_enable_no_resched();				\
-	} while (0)
+#define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 #endif /* __ASM_HARDIRQ_H */
--- 1.4/include/asm-arm26/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-arm26/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -26,17 +26,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifndef CONFIG_SMP
-#define irq_exit()							\
-	do {								\
-		preempt_count() -= HARDIRQ_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
-		preempt_enable_no_resched();				\
-	} while (0)
-
-#endif
-
 #endif /* __ASM_HARDIRQ_H */
--- 1.5/include/asm-cris/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-cris/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -28,13 +28,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif /* __ASM_HARDIRQ_H */
--- 1.6/include/asm-h8300/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-h8300/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -26,13 +26,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif
--- 1.4/include/asm-m32r/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-m32r/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -28,16 +28,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define nmi_enter()		(irq_enter())
-#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
-
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif /* __ASM_HARDIRQ_H */
--- 1.8/include/asm-m68k/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-m68k/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -23,13 +23,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif
--- 1.5/include/asm-m68knommu/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-m68knommu/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -24,13 +24,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif /* __M68K_HARDIRQ_H */
--- 1.10/include/asm-mips/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-mips/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -31,13 +31,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()                                                     \
-do {                                                                   \
-	preempt_count() -= IRQ_EXIT_OFFSET;                     \
-	if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-		do_softirq();                                   \
-	preempt_enable_no_resched();                            \
-} while (0)
-
 #endif /* _ASM_HARDIRQ_H */
--- 1.5/include/asm-parisc/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-parisc/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -38,13 +38,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()								\
-do {										\
-		preempt_count() -= IRQ_EXIT_OFFSET;				\
-		if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-			do_softirq();						\
-		preempt_enable_no_resched();					\
-} while (0)
-
 #endif /* _PARISC_HARDIRQ_H */
--- 1.16/include/asm-s390/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-s390/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -37,24 +37,10 @@
 }
 
 #define __ARCH_IRQ_STAT
+#define __ARCH_HAS_DO_SOFTIRQ
 
 #define HARDIRQ_BITS	8
 
 extern void account_ticks(struct pt_regs *);
-
-#define __ARCH_HAS_DO_SOFTIRQ
-
-#define irq_enter()							\
-do {									\
-	(preempt_count() += HARDIRQ_OFFSET);				\
-} while(0)
-#define irq_exit()							\
-do {									\
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && local_softirq_pending())			\
-		/* Use the async. stack for softirq */			\
-		do_softirq();						\
-	preempt_enable_no_resched();					\
-} while (0)
 
 #endif /* __ASM_HARDIRQ_H */
--- 1.8/include/asm-sh/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-sh/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -23,16 +23,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define nmi_enter()		(irq_enter())
-#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif /* __ASM_SH_HARDIRQ_H */
--- 1.16/include/asm-sparc/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-sparc/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -21,13 +21,4 @@
 
 #define HARDIRQ_BITS    8
 
-#define irq_enter()             (preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()                                                      \
-do {                                                                    \
-                preempt_count() -= IRQ_EXIT_OFFSET;                     \
-                if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-                        do_softirq();                                   \
-                preempt_enable_no_resched();                            \
-} while (0)
-
 #endif /* __SPARC_HARDIRQ_H */
--- 1.20/include/asm-sparc64/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-sparc64/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -20,13 +20,4 @@
 
 #define HARDIRQ_BITS	8
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 #endif /* !(__SPARC64_HARDIRQ_H) */
--- 1.6/include/asm-v850/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-v850/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -24,13 +24,4 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							      \
-do {									      \
-	preempt_count() -= IRQ_EXIT_OFFSET;				      \
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	      \
-		do_softirq();						      \
-	preempt_enable_no_resched();					      \
-} while (0)
-
 #endif /* __V850_HARDIRQ_H__ */
===== include/linux/hardirq.h 1.5 vs edited =====
--- 1.5/include/linux/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/linux/hardirq.h	2004-11-14 10:23:16 +01:00
@@ -77,12 +77,10 @@
 # define synchronize_irq(irq)	barrier()
 #endif
 
-#ifdef CONFIG_GENERIC_HARDIRQS
 #define nmi_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 extern void irq_exit(void);
-#endif
 
 #endif /* LINUX_HARDIRQ_H */
===== kernel/softirq.c 1.60 vs edited =====
--- 1.60/kernel/softirq.c	2004-10-28 09:40:00 +02:00
+++ edited/kernel/softirq.c	2004-11-14 10:23:16 +01:00
@@ -152,6 +152,23 @@
 }
 EXPORT_SYMBOL(local_bh_enable);
 
+#ifdef __ARCH_IRQ_EXIT_IRQS_DISABLED
+# define invoke_softirq()	__do_softirq()
+#else
+# define invoke_softirq()	do_softirq()
+#endif
+
+/*
+ * Exit an interrupt context. Process softirqs if needed and possible:
+ */
+void irq_exit(void)
+{
+	preempt_count() -= IRQ_EXIT_OFFSET;
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
+	preempt_enable_no_resched();
+}
+
 /*
  * This function must run with irqs disabled!
  */
===== kernel/irq/handle.c 1.3 vs edited =====
--- 1.3/kernel/irq/handle.c	2004-11-04 20:13:19 +01:00
+++ edited/kernel/irq/handle.c	2004-11-14 10:23:16 +01:00
@@ -73,17 +73,6 @@
 }
 
 /*
- * Exit an interrupt context. Process softirqs if needed and possible:
- */
-void irq_exit(void)
-{
-	preempt_count() -= IRQ_EXIT_OFFSET;
-	if (!in_interrupt() && local_softirq_pending())
-		do_softirq();
-	preempt_enable_no_resched();
-}
-
-/*
  * Have got an event to handle:
  */
 fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
