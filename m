Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTIWOtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTIWOtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:49:08 -0400
Received: from verein.lst.de ([212.34.189.10]:39604 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261506AbTIWOsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:48:51 -0400
Date: Tue, 23 Sep 2003 16:48:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] softirq_pending()
Message-ID: <20030923144847.GA16139@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 currently ignores the cpu argument to softirq_pending() and
always uses smp_processor_id().  And indeed that's the only possible
argument.  So consolidate the old softirq_pending() and
local_softirq_pending() into a single one.


--- 1.11/arch/cris/kernel/irq.c	Fri Jul  4 12:27:52 2003
+++ edited/arch/cris/kernel/irq.c	Tue Sep 23 10:27:30 2003
@@ -153,7 +153,7 @@
         }
         irq_exit();
 
-	if (softirq_pending(cpu))
+	if (softirq_pending())
                 do_softirq();
 
         /* unmasking and bottom half handling is done magically for us. */
--- 1.15/arch/ia64/kernel/irq_ia64.c	Wed Aug 20 08:13:39 2003
+++ edited/arch/ia64/kernel/irq_ia64.c	Tue Sep 23 10:28:00 2003
@@ -141,7 +141,7 @@
 	 * handler needs to be able to wait for further keyboard interrupts, which can't
 	 * come through until ia64_eoi() has been done.
 	 */
-	if (local_softirq_pending())
+	if (softirq_pending())
 		do_softirq();
 }
 
--- 1.23/arch/sparc/kernel/irq.c	Mon Apr 21 08:43:42 2003
+++ edited/arch/sparc/kernel/irq.c	Tue Sep 23 10:27:45 2003
@@ -452,7 +452,7 @@
 	irq_exit();
 	enable_pil_irq(irq);
 	// XXX Eek, it's totally changed with preempt_count() and such
-	// if (softirq_pending(cpu))
+	// if (softirq_pending())
 	//	do_softirq();
 }
 #endif
--- 1.8/include/asm-alpha/hardirq.h	Tue May 13 03:59:24 2003
+++ edited/include/asm-alpha/hardirq.h	Tue Sep 23 10:24:44 2003
@@ -89,8 +89,7 @@
 #define irq_exit()						\
 do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;		\
-		if (!in_interrupt() &&				\
-		    softirq_pending(smp_processor_id()))	\
+		if (!in_interrupt() &&	softirq_pending())	\
 			do_softirq();				\
 		preempt_enable_no_resched();			\
 } while (0)
--- 1.9/include/asm-arm/hardirq.h	Sun Apr 27 17:43:38 2003
+++ edited/include/asm-arm/hardirq.h	Tue Sep 23 10:18:42 2003
@@ -83,7 +83,7 @@
 #define irq_exit()							\
 	do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && softirq_pending())		\
 			__asm__("bl	__do_softirq": : : "lr", "cc");/* out of line */\
 		preempt_enable_no_resched();				\
 	} while (0)
--- 1.8/include/asm-arm/mach/irq.h	Tue Aug  5 21:35:12 2003
+++ edited/include/asm-arm/mach/irq.h	Tue Sep 23 10:27:20 2003
@@ -109,7 +109,7 @@
 	desc->handle(irq, desc, regs);
 	spin_unlock(&irq_controller_lock);
 
-	if (softirq_pending(smp_processor_id()))
+	if (softirq_pending())
 		do_softirq();
 }
 #endif
--- 1.1/include/asm-arm26/hardirq.h	Wed Jun  4 13:14:10 2003
+++ edited/include/asm-arm26/hardirq.h	Tue Sep 23 10:18:51 2003
@@ -80,7 +80,7 @@
 #define irq_exit()							\
 	do {								\
 		preempt_count() -= HARDIRQ_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && softirq_pending())		\
 			__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
 		preempt_enable_no_resched();				\
 	} while (0)
--- 1.1/include/asm-arm26/irqchip.h	Wed Jun  4 13:14:10 2003
+++ edited/include/asm-arm26/irqchip.h	Tue Sep 23 10:28:23 2003
@@ -97,7 +97,7 @@
 	desc->handle(irq, desc, regs);
 	spin_unlock(&irq_controller_lock);
 
-	if (softirq_pending(smp_processor_id()))
+	if (softirq_pending())
 		do_softirq();
 }
 #endif
--- 1.3/include/asm-cris/hardirq.h	Wed Apr  9 09:25:27 2003
+++ edited/include/asm-cris/hardirq.h	Tue Sep 23 10:19:00 2003
@@ -87,7 +87,7 @@
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
--- 1.3/include/asm-h8300/hardirq.h	Thu Aug 21 17:55:15 2003
+++ edited/include/asm-h8300/hardirq.h	Tue Sep 23 10:19:11 2003
@@ -82,12 +82,12 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.21/include/asm-i386/hardirq.h	Tue Aug  5 19:36:52 2003
+++ edited/include/asm-i386/hardirq.h	Tue Sep 23 10:19:21 2003
@@ -84,12 +84,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.14/include/asm-ia64/hardirq.h	Fri Aug  8 15:00:23 2003
+++ edited/include/asm-ia64/hardirq.h	Tue Sep 23 10:19:51 2003
@@ -19,12 +19,11 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define softirq_pending(cpu)		(cpu_data(cpu)->softirq_pending)
 #define syscall_count(cpu)		/* unused on IA-64 */
 #define ksoftirqd_task(cpu)		(cpu_data(cpu)->ksoftirqd)
 #define nmi_count(cpu)			0
 
-#define local_softirq_pending()		(local_cpu_data->softirq_pending)
+#define softirq_pending()		(local_cpu_data->softirq_pending)
 #define local_syscall_count()		/* unused on IA-64 */
 #define local_ksoftirqd_task()		(local_cpu_data->ksoftirqd)
 #define local_nmi_count()		0
@@ -100,7 +99,7 @@
 #define irq_exit()						\
 do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;		\
-		if (!in_interrupt() && local_softirq_pending())	\
+		if (!in_interrupt() && softirq_pending())	\
 			do_softirq();				\
 		preempt_enable_no_resched();			\
 } while (0)
--- 1.5/include/asm-m68k/hardirq.h	Fri Jul 11 15:54:47 2003
+++ edited/include/asm-m68k/hardirq.h	Tue Sep 23 10:20:00 2003
@@ -81,7 +81,7 @@
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
--- 1.3/include/asm-m68knommu/hardirq.h	Tue May 13 03:59:23 2003
+++ edited/include/asm-m68knommu/hardirq.h	Tue Sep 23 10:20:11 2003
@@ -86,12 +86,12 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.5/include/asm-mips/hardirq.h	Mon Jul 28 13:57:50 2003
+++ edited/include/asm-mips/hardirq.h	Tue Sep 23 10:20:53 2003
@@ -86,12 +86,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()                                                     \
-do {                                                                   \
-	preempt_count() -= IRQ_EXIT_OFFSET;                     \
-	if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-		do_softirq();                                   \
-	preempt_enable_no_resched();                            \
+#define irq_exit()					\
+do {							\
+	preempt_count() -= IRQ_EXIT_OFFSET;		\
+	if (!in_interrupt() && softirq_pending())	\
+		do_softirq();				\
+	preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.3/include/asm-parisc/hardirq.h	Tue May 13 03:59:23 2003
+++ edited/include/asm-parisc/hardirq.h	Tue Sep 23 10:21:15 2003
@@ -96,12 +96,12 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()								\
-do {										\
-		preempt_count() -= IRQ_EXIT_OFFSET;				\
-		if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-			do_softirq();						\
-		preempt_enable_no_resched();					\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifdef CONFIG_SMP
--- 1.23/include/asm-ppc/hardirq.h	Fri Sep 12 18:26:56 2003
+++ edited/include/asm-ppc/hardirq.h	Tue Sep 23 10:21:37 2003
@@ -88,12 +88,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()							\
-do {									\
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-		do_softirq();						\
-	preempt_enable_no_resched();					\
+#define irq_exit()					\
+do {							\
+	preempt_count() -= IRQ_EXIT_OFFSET;		\
+	if (!in_interrupt() && softirq_pending())	\
+		do_softirq();				\
+	preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.11/include/asm-ppc64/hardirq.h	Mon Feb 17 04:22:35 2003
+++ edited/include/asm-ppc64/hardirq.h	Tue Sep 23 10:21:51 2003
@@ -89,12 +89,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.10/include/asm-s390/hardirq.h	Fri Jun 27 18:04:36 2003
+++ edited/include/asm-s390/hardirq.h	Tue Sep 23 10:22:07 2003
@@ -90,13 +90,13 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()							\
-do {									\
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-		/* Use the async. stack for softirq */			\
-		do_call_softirq();					\
-	preempt_enable_no_resched();					\
+#define irq_exit()					\
+do {							\
+	preempt_count() -= IRQ_EXIT_OFFSET;		\
+	if (!in_interrupt() && softirq_pending())	\
+		/* Use the async. stack for softirq */	\
+		do_call_softirq();			\
+	preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.4/include/asm-sh/hardirq.h	Tue May  6 21:28:50 2003
+++ edited/include/asm-sh/hardirq.h	Tue Sep 23 10:22:23 2003
@@ -83,12 +83,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.12/include/asm-sparc/hardirq.h	Tue May 13 03:59:24 2003
+++ edited/include/asm-sparc/hardirq.h	Tue Sep 23 10:23:20 2003
@@ -96,12 +96,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()                                                      \
-do {                                                                    \
-                preempt_count() -= IRQ_EXIT_OFFSET;                     \
-                if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-                        do_softirq();                                   \
-                preempt_enable_no_resched();                            \
+#define irq_exit()						\
+do {								\
+                preempt_count() -= IRQ_EXIT_OFFSET;		\
+                if (!in_interrupt() && softirq_pending())	\
+                        do_softirq();				\
+                preempt_enable_no_resched();			\
 } while (0)
 
 #else
--- 1.16/include/asm-sparc64/hardirq.h	Tue Jul  8 10:37:32 2003
+++ edited/include/asm-sparc64/hardirq.h	Tue Sep 23 10:23:46 2003
@@ -85,12 +85,12 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.4/include/asm-v850/hardirq.h	Tue Jun 17 07:23:12 2003
+++ edited/include/asm-v850/hardirq.h	Tue Sep 23 10:24:30 2003
@@ -80,12 +80,12 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()							      \
-do {									      \
-	preempt_count() -= IRQ_EXIT_OFFSET;				      \
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	      \
-		do_softirq();						      \
-	preempt_enable_no_resched();					      \
+#define irq_exit()					\
+do {							\
+	preempt_count() -= IRQ_EXIT_OFFSET;		\
+	if (!in_interrupt() && softirq_pending())	\
+		do_softirq();				\
+	preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.5/include/asm-x86_64/hardirq.h	Thu Jun 12 04:53:38 2003
+++ edited/include/asm-x86_64/hardirq.h	Tue Sep 23 10:24:41 2003
@@ -84,12 +84,12 @@
 # define in_atomic()   (preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() && softirq_pending())	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
 } while (0)
 
 #ifndef CONFIG_SMP
--- 1.27/include/linux/interrupt.h	Tue Sep  9 00:00:28 2003
+++ edited/include/linux/interrupt.h	Tue Sep 23 10:26:22 2003
@@ -95,7 +95,7 @@
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
-#define __raise_softirq_irqoff(nr) do { local_softirq_pending() |= 1UL << (nr); } while (0)
+#define __raise_softirq_irqoff(nr) do { softirq_pending() |= 1UL << (nr); } while (0)
 extern void FASTCALL(raise_softirq_irqoff(unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
--- 1.10/include/linux/irq_cpustat.h	Tue Jul  1 07:26:58 2003
+++ edited/include/linux/irq_cpustat.h	Tue Sep 23 10:26:57 2003
@@ -27,8 +27,7 @@
 #endif
 
   /* arch independent irq_stat fields */
-#define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
-#define local_softirq_pending()	softirq_pending(smp_processor_id())
+#define softirq_pending()	__IRQ_STAT(smp_processor_id(), __softirq_pending)
 
   /* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
--- 1.58/include/linux/netdevice.h	Sat Sep 20 10:19:14 2003
+++ edited/include/linux/netdevice.h	Tue Sep 23 10:26:03 2003
@@ -657,7 +657,7 @@
 static inline int netif_rx_ni(struct sk_buff *skb)
 {
        int err = netif_rx(skb);
-       if (softirq_pending(smp_processor_id()))
+       if (softirq_pending())
                do_softirq();
        return err;
 }
--- 1.45/kernel/softirq.c	Wed Sep 10 08:41:39 2003
+++ edited/kernel/softirq.c	Tue Sep 23 10:25:35 2003
@@ -68,8 +68,7 @@
 
 	local_irq_save(flags);
 
-	pending = local_softirq_pending();
-
+	pending = softirq_pending();
 	if (pending) {
 		struct softirq_action *h;
 
@@ -77,7 +76,7 @@
 		local_bh_disable();
 restart:
 		/* Reset the pending bitmask before enabling irqs */
-		local_softirq_pending() = 0;
+		softirq_pending() = 0;
 
 		local_irq_enable();
 
@@ -92,7 +91,7 @@
 
 		local_irq_disable();
 
-		pending = local_softirq_pending();
+		pending = softirq_pending();
 		if (pending & mask) {
 			mask &= ~pending;
 			goto restart;
@@ -110,7 +109,7 @@
 	__local_bh_enable();
 	WARN_ON(irqs_disabled());
 	if (unlikely(!in_interrupt() &&
-		     local_softirq_pending()))
+		     softirq_pending()))
 		invoke_softirq();
 	preempt_check_resched();
 }
@@ -329,12 +328,12 @@
 	__get_cpu_var(ksoftirqd) = current;
 
 	for (;;) {
-		if (!local_softirq_pending())
+		if (!softirq_pending())
 			schedule();
 
 		__set_current_state(TASK_RUNNING);
 
-		while (local_softirq_pending()) {
+		while (softirq_pending()) {
 			do_softirq();
 			cond_resched();
 		}


