Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUILLcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUILLcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUILLbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:31:02 -0400
Received: from verein.lst.de ([213.95.11.210]:48810 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268672AbUILL0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:26:20 -0400
Date: Sun, 12 Sep 2004 13:25:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: spyro@f2s.com, rmk@arm.linux.org.uk, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] irq_enter/irq_exit consolidation
Message-ID: <20040912112554.GA32550@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org, spyro@f2s.com,
	rmk@arm.linux.org.uk, linux390@de.ibm.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move irq_enter/irq_exit from <asm/hardirq.h> to <linux/hardirq.h>.
There some fishy things going on with the do_softirq invokation on
arm, arm26 and s390.

arm calls __do_softirq directly without local irq disabling which looks
like a real bug to me.

arm26 has a duplicate __do_softirq entry point (which makes me wonder
whether it still compiles with any 2.6 tree since a few month)

s390 has an assembly wrapper around do_softirq.

I've extended the invoke_softirq mechanism used by s390 (also called
by ksoftirqd) to the two arm variants, but the right thing to do is
probably to use the normal do_softirq call in arm and set
__ARCH_HAS_DO_SOFTIRQ + providing a per-arch do_softirq for all callers
for s390 and maybe arm26.

--- 1.20/arch/ia64/kernel/irq_ia64.c	2004-05-15 04:00:12 +02:00
+++ edited/arch/ia64/kernel/irq_ia64.c	2004-09-11 21:06:21 +02:00
@@ -59,21 +59,6 @@
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
===== include/asm-alpha/hardirq.h 1.9 vs edited =====
--- 1.9/include/asm-alpha/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-alpha/hardirq.h	2004-09-11 21:14:41 +02:00
@@ -50,14 +50,4 @@
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
===== include/asm-arm/hardirq.h 1.13 vs edited =====
--- 1.13/include/asm-arm/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-arm/hardirq.h	2004-09-11 21:09:10 +02:00
@@ -50,18 +50,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifndef CONFIG_SMP
 extern asmlinkage void __do_softirq(void);
-
-#define irq_exit()							\
-	do {								\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && local_softirq_pending())		\
-			__do_softirq();					\
-		preempt_enable_no_resched();				\
-	} while (0)
-#endif
+#define invoke_softirq()	__do_softirq()
 
 #endif /* __ASM_HARDIRQ_H */
--- 1.3/include/asm-arm26/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-arm26/hardirq.h	2004-09-11 21:09:41 +02:00
@@ -41,17 +41,6 @@
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
+#define invoke_softirq()	__asm__("bl%? __do_softirq": : : "lr")
 
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-cris/hardirq.h 1.4 vs edited =====
--- 1.4/include/asm-cris/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-cris/hardirq.h	2004-09-11 21:15:19 +02:00
@@ -49,13 +49,4 @@
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
===== include/asm-h8300/hardirq.h 1.5 vs edited =====
--- 1.5/include/asm-h8300/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-h8300/hardirq.h	2004-09-11 21:09:54 +02:00
@@ -47,13 +47,4 @@
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
===== include/asm-i386/hardirq.h 1.22 vs edited =====
--- 1.22/include/asm-i386/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-i386/hardirq.h	2004-09-11 21:25:23 +02:00
@@ -46,16 +46,4 @@
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
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-m68k/hardirq.h 1.7 vs edited =====
--- 1.7/include/asm-m68k/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-m68k/hardirq.h	2004-09-11 21:10:09 +02:00
@@ -44,13 +44,4 @@
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
===== include/asm-m68knommu/hardirq.h 1.4 vs edited =====
--- 1.4/include/asm-m68knommu/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-m68knommu/hardirq.h	2004-09-11 21:10:17 +02:00
@@ -45,13 +45,4 @@
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
===== include/asm-mips/hardirq.h 1.9 vs edited =====
--- 1.9/include/asm-mips/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-mips/hardirq.h	2004-09-11 21:10:24 +02:00
@@ -52,13 +52,4 @@
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
===== include/asm-parisc/hardirq.h 1.4 vs edited =====
--- 1.4/include/asm-parisc/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-parisc/hardirq.h	2004-09-11 21:10:30 +02:00
@@ -59,13 +59,4 @@
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
===== include/asm-ppc/hardirq.h 1.25 vs edited =====
--- 1.25/include/asm-ppc/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-ppc/hardirq.h	2004-09-11 21:11:01 +02:00
@@ -53,14 +53,5 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-		do_softirq();						\
-	preempt_enable_no_resched();					\
-} while (0)
-
 #endif /* __ASM_HARDIRQ_H */
 #endif /* __KERNEL__ */
===== include/asm-ppc64/hardirq.h 1.14 vs edited =====
--- 1.14/include/asm-ppc64/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-ppc64/hardirq.h	2004-09-11 21:11:12 +02:00
@@ -51,13 +51,4 @@
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
===== include/asm-s390/hardirq.h 1.14 vs edited =====
--- 1.14/include/asm-s390/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-s390/hardirq.h	2004-09-11 21:11:28 +02:00
@@ -66,17 +66,4 @@
 
 #define invoke_softirq() do_call_softirq()
 
-#define irq_enter()							\
-do {									\
-	(preempt_count() += HARDIRQ_OFFSET);				\
-} while(0)
-#define irq_exit()							\
-do {									\
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && local_softirq_pending())			\
-		/* Use the async. stack for softirq */			\
-		do_call_softirq();					\
-	preempt_enable_no_resched();					\
-} while (0)
-
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-sh/hardirq.h 1.7 vs edited =====
--- 1.7/include/asm-sh/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-sh/hardirq.h	2004-09-11 21:25:35 +02:00
@@ -44,16 +44,4 @@
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
===== include/asm-sparc/hardirq.h 1.15 vs edited =====
--- 1.15/include/asm-sparc/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-sparc/hardirq.h	2004-09-11 21:12:26 +02:00
@@ -42,13 +42,4 @@
 #define SOFTIRQ_SHIFT   (PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT   (SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
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
===== include/asm-sparc64/hardirq.h 1.19 vs edited =====
--- 1.19/include/asm-sparc64/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-sparc64/hardirq.h	2004-09-11 21:12:43 +02:00
@@ -41,13 +41,4 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
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
===== include/asm-v850/hardirq.h 1.5 vs edited =====
--- 1.5/include/asm-v850/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-v850/hardirq.h	2004-09-11 21:13:01 +02:00
@@ -45,13 +45,4 @@
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
===== include/asm-x86_64/hardirq.h 1.7 vs edited =====
--- 1.7/include/asm-x86_64/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-x86_64/hardirq.h	2004-09-11 21:26:04 +02:00
@@ -46,16 +46,4 @@
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
 #endif /* __ASM_HARDIRQ_H */
===== include/linux/hardirq.h 1.1 vs edited =====
--- 1.1/include/linux/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/linux/hardirq.h	2004-09-11 21:26:28 +02:00
@@ -41,6 +36,22 @@
 # define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef invoke_softirq
+#define invoke_softirq() do_softirq()
+#endif
+
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define irq_exit()						\
+do {								\
+	preempt_count() -= IRQ_EXIT_OFFSET;			\
+	if (!in_interrupt() && local_softirq_pending())		\
+		invoke_softirq();				\
+	preempt_enable_no_resched();				\
+} while (0)
+
+#define nmi_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
 #ifdef CONFIG_SMP
 extern void synchronize_irq(unsigned int irq);
===== include/linux/interrupt.h 1.30 vs edited =====
--- 1.30/include/linux/interrupt.h	2004-09-08 08:32:57 +02:00
+++ edited/include/linux/interrupt.h	2004-09-11 21:24:23 +02:00
@@ -100,11 +100,6 @@
 extern void FASTCALL(raise_softirq_irqoff(unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
-#ifndef invoke_softirq
-#define invoke_softirq() do_softirq()
-#endif
-
-
 /* Tasklets --- multithreaded analogue of BHs.
 
    Main feature differing them of generic softirqs: tasklet
