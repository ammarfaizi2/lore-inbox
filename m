Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbTGCISt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTGCISs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:18:48 -0400
Received: from dp.samba.org ([66.70.73.150]:49029 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265563AbTGCISj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:18:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Remove softirq_pending cpu arg.
Date: Thu, 03 Jul 2003 18:28:20 +1000
Message-Id: <20030703083305.A2D902C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every user of softirq_pending(cpu) could be using
local_softirq_pending, since it only really makes sense to ask about
your own softirq state (and that's what every user does).  This also
makes the future per-cpu-ification of the irq_cpustat_t more efficient.

Name: Remove softirq_pending.
Author: Rusty Russell
Status: Tested on 2.5.74
Depends: Percpu/softirq_local.patch.gz

D: Every user of softirq_pending(cpu) could be using
D: local_softirq_pending, since it only really makes sense to ask
D: about your own softirq state (and that's what every user does).
D: This also makes the future per-cpu-ification of the irq_cpustat_t
D: more efficient.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/cris/kernel/irq.c .15631-linux-2.5.74.updated/arch/cris/kernel/irq.c
--- .15631-linux-2.5.74/arch/cris/kernel/irq.c	2003-03-18 12:21:30.000000000 +1100
+++ .15631-linux-2.5.74.updated/arch/cris/kernel/irq.c	2003-07-03 16:24:21.000000000 +1000
@@ -284,7 +284,7 @@ asmlinkage void do_IRQ(int irq, struct p
         }
         irq_exit(cpu);
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
                 do_softirq();
 
         /* unmasking and bottom half handling is done magically for us. */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/mips/au1000/common/time.c .15631-linux-2.5.74.updated/arch/mips/au1000/common/time.c
--- .15631-linux-2.5.74/arch/mips/au1000/common/time.c	2003-07-03 09:43:41.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/mips/au1000/common/time.c	2003-07-03 16:24:21.000000000 +1000
@@ -102,7 +102,7 @@ void mips_timer_interrupt(struct pt_regs
 
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 	return;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/mips/kernel/time.c .15631-linux-2.5.74.updated/arch/mips/kernel/time.c
--- .15631-linux-2.5.74/arch/mips/kernel/time.c	2003-07-03 09:43:42.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/mips/kernel/time.c	2003-07-03 16:24:21.000000000 +1000
@@ -441,7 +441,7 @@ asmlinkage void ll_timer_interrupt(int i
 
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
@@ -457,7 +457,7 @@ asmlinkage void ll_local_timer_interrupt
 
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/mips/mips-boards/sead/sead_time.c .15631-linux-2.5.74.updated/arch/mips/mips-boards/sead/sead_time.c
--- .15631-linux-2.5.74/arch/mips/mips-boards/sead/sead_time.c	2003-07-03 09:43:43.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/mips/mips-boards/sead/sead_time.c	2003-07-03 16:24:21.000000000 +1000
@@ -84,7 +84,7 @@ void mips_timer_interrupt(struct pt_regs
 	         - r4k_cur) < 0x7fffffff);
 
 	irq_exit();
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/mips/sgi-ip22/ip22-time.c .15631-linux-2.5.74.updated/arch/mips/sgi-ip22/ip22-time.c
--- .15631-linux-2.5.74/arch/mips/sgi-ip22/ip22-time.c	2003-07-03 09:43:43.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/mips/sgi-ip22/ip22-time.c	2003-07-03 16:24:21.000000000 +1000
@@ -193,7 +193,7 @@ void indy_r4k_timer_interrupt(struct pt_
 	timer_interrupt(irq, NULL, regs);
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/mips/sgi-ip27/ip27-timer.c .15631-linux-2.5.74.updated/arch/mips/sgi-ip27/ip27-timer.c
--- .15631-linux-2.5.74/arch/mips/sgi-ip27/ip27-timer.c	2003-07-03 09:43:43.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/mips/sgi-ip27/ip27-timer.c	2003-07-03 16:24:21.000000000 +1000
@@ -136,7 +136,7 @@ again:
 	write_sequnlock(&xtime_lock);
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/mips64/kernel/time.c .15631-linux-2.5.74.updated/arch/mips64/kernel/time.c
--- .15631-linux-2.5.74/arch/mips64/kernel/time.c	2003-07-03 09:43:44.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/mips64/kernel/time.c	2003-07-03 16:24:21.000000000 +1000
@@ -441,7 +441,7 @@ asmlinkage void ll_timer_interrupt(int i
 
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
@@ -457,7 +457,7 @@ asmlinkage void ll_local_timer_interrupt
 
 	irq_exit();
 
-	if (softirq_pending(cpu))
+	if (local_softirq_pending())
 		do_softirq();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-alpha/hardirq.h .15631-linux-2.5.74.updated/include/asm-alpha/hardirq.h
--- .15631-linux-2.5.74/include/asm-alpha/hardirq.h	2003-05-27 15:02:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-alpha/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -90,7 +90,7 @@ typedef struct {
 do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;		\
 		if (!in_interrupt() &&				\
-		    softirq_pending(smp_processor_id()))	\
+		    local_softirq_pending())			\
 			do_softirq();				\
 		preempt_enable_no_resched();			\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-arm/hardirq.h .15631-linux-2.5.74.updated/include/asm-arm/hardirq.h
--- .15631-linux-2.5.74/include/asm-arm/hardirq.h	2003-05-05 12:37:11.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-arm/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -83,7 +83,7 @@ typedef struct {
 #define irq_exit()							\
 	do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			__asm__("bl	__do_softirq": : : "lr", "cc");/* out of line */\
 		preempt_enable_no_resched();				\
 	} while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-arm/mach/irq.h .15631-linux-2.5.74.updated/include/asm-arm/mach/irq.h
--- .15631-linux-2.5.74/include/asm-arm/mach/irq.h	2003-02-18 11:18:56.000000000 +1100
+++ .15631-linux-2.5.74.updated/include/asm-arm/mach/irq.h	2003-07-03 16:24:22.000000000 +1000
@@ -104,7 +104,7 @@ static inline void call_irq(struct pt_re
 	desc->handle(irq, desc, regs);
 	spin_unlock(&irq_controller_lock);
 
-	if (softirq_pending(smp_processor_id()))
+	if (local_softirq_pending()
 		do_softirq();
 }
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-arm26/hardirq.h .15631-linux-2.5.74.updated/include/asm-arm26/hardirq.h
--- .15631-linux-2.5.74/include/asm-arm26/hardirq.h	2003-06-15 11:30:06.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-arm26/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -80,7 +80,7 @@ typedef struct {
 #define irq_exit()							\
 	do {								\
 		preempt_count() -= HARDIRQ_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
 		preempt_enable_no_resched();				\
 	} while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-arm26/irqchip.h .15631-linux-2.5.74.updated/include/asm-arm26/irqchip.h
--- .15631-linux-2.5.74/include/asm-arm26/irqchip.h	2003-06-15 11:30:06.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-arm26/irqchip.h	2003-07-03 16:24:22.000000000 +1000
@@ -97,7 +97,7 @@ static inline void call_irq(struct pt_re
 	desc->handle(irq, desc, regs);
 	spin_unlock(&irq_controller_lock);
 
-	if (softirq_pending(smp_processor_id()))
+	if (local_softirq_pending())
 		do_softirq();
 }
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-arm26/softirq.h .15631-linux-2.5.74.updated/include/asm-arm26/softirq.h
--- .15631-linux-2.5.74/include/asm-arm26/softirq.h	2003-06-15 11:30:06.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-arm26/softirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -12,7 +12,7 @@
 #define local_bh_enable()						\
 do {									\
 	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
+	if (unlikely(!in_interrupt() && local_softirq_pending())	\
 		__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
 	preempt_check_resched();					\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-h8300/hardirq.h .15631-linux-2.5.74.updated/include/asm-h8300/hardirq.h
--- .15631-linux-2.5.74/include/asm-h8300/hardirq.h	2003-05-27 15:02:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-h8300/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -91,7 +91,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-h8300/softirq.h .15631-linux-2.5.74.updated/include/asm-h8300/softirq.h
--- .15631-linux-2.5.74/include/asm-h8300/softirq.h	2003-04-20 18:05:12.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-h8300/softirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -12,7 +12,7 @@
 #define local_bh_enable()						\
 do {									\
 	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
+	if (unlikely(!in_interrupt() && local_softirq_pending()))	\
 		do_softirq();						\
 	preempt_check_resched();					\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-i386/hardirq.h .15631-linux-2.5.74.updated/include/asm-i386/hardirq.h
--- .15631-linux-2.5.74/include/asm-i386/hardirq.h	2003-07-03 16:24:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-i386/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -86,7 +86,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-ia64/hardirq.h .15631-linux-2.5.74.updated/include/asm-ia64/hardirq.h
--- .15631-linux-2.5.74/include/asm-ia64/hardirq.h	2003-06-15 11:30:07.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-ia64/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -19,7 +19,6 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define softirq_pending(cpu)		(cpu_data(cpu)->softirq_pending)
 #define syscall_count(cpu)		/* unused on IA-64 */
 #define ksoftirqd_task(cpu)		(cpu_data(cpu)->ksoftirqd)
 #define nmi_count(cpu)			0
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-m68k/hardirq.h .15631-linux-2.5.74.updated/include/asm-m68k/hardirq.h
--- .15631-linux-2.5.74/include/asm-m68k/hardirq.h	2003-05-27 15:02:20.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-m68k/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -83,7 +83,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-m68knommu/hardirq.h .15631-linux-2.5.74.updated/include/asm-m68knommu/hardirq.h
--- .15631-linux-2.5.74/include/asm-m68knommu/hardirq.h	2003-05-27 15:02:20.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-m68knommu/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -89,7 +89,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-mips/hardirq.h .15631-linux-2.5.74.updated/include/asm-mips/hardirq.h
--- .15631-linux-2.5.74/include/asm-mips/hardirq.h	2003-07-03 09:43:56.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-mips/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -91,7 +91,7 @@ typedef struct {
 #define irq_exit()                                                     \
 do {                                                                   \
 	preempt_count() -= IRQ_EXIT_OFFSET;                     \
-	if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+	if (!in_interrupt() && local_softirq_pending())		\
 		do_softirq();                                   \
 	preempt_enable_no_resched();                            \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-mips/softirq.h .15631-linux-2.5.74.updated/include/asm-mips/softirq.h
--- .15631-linux-2.5.74/include/asm-mips/softirq.h	2003-07-03 09:43:57.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-mips/softirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -12,7 +12,7 @@
 #define local_bh_enable()						\
 do {									\
 	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
+	if (unlikely(!in_interrupt() && local_softirq_pending()))	\
 		do_softirq();						\
 	preempt_check_resched();					\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-mips64/hardirq.h .15631-linux-2.5.74.updated/include/asm-mips64/hardirq.h
--- .15631-linux-2.5.74/include/asm-mips64/hardirq.h	2003-07-03 09:43:58.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-mips64/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -91,7 +91,7 @@ typedef struct {
 #define irq_exit()                                                     \
 do {                                                                   \
 	preempt_count() -= IRQ_EXIT_OFFSET;                     \
-	if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+	if (!in_interrupt() && local_softirq_pending())		\
 		do_softirq();                                   \
 	preempt_enable_no_resched();                            \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-mips64/softirq.h .15631-linux-2.5.74.updated/include/asm-mips64/softirq.h
--- .15631-linux-2.5.74/include/asm-mips64/softirq.h	2003-07-03 09:43:58.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-mips64/softirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -12,7 +12,7 @@
 #define local_bh_enable()						\
 do {									\
 	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
+	if (unlikely(!in_interrupt() && local_softirq_pending()))	\
 		do_softirq();						\
 	preempt_check_resched();					\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-parisc/hardirq.h .15631-linux-2.5.74.updated/include/asm-parisc/hardirq.h
--- .15631-linux-2.5.74/include/asm-parisc/hardirq.h	2003-05-27 15:02:20.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-parisc/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -99,7 +99,7 @@ typedef struct {
 #define irq_exit()								\
 do {										\
 		preempt_count() -= IRQ_EXIT_OFFSET;				\
-		if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		if (!in_interrupt() && local_softirq_pending()))		\
 			do_softirq();						\
 		preempt_enable_no_resched();					\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-ppc/hardirq.h .15631-linux-2.5.74.updated/include/asm-ppc/hardirq.h
--- .15631-linux-2.5.74/include/asm-ppc/hardirq.h	2003-07-03 09:43:58.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-ppc/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -93,7 +93,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+	if (!in_interrupt() && local_softirq_pending())			\
 		do_softirq();						\
 	preempt_enable_no_resched();					\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-ppc64/hardirq.h .15631-linux-2.5.74.updated/include/asm-ppc64/hardirq.h
--- .15631-linux-2.5.74/include/asm-ppc64/hardirq.h	2003-02-25 10:11:06.000000000 +1100
+++ .15631-linux-2.5.74.updated/include/asm-ppc64/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -92,7 +92,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-s390/hardirq.h .15631-linux-2.5.74.updated/include/asm-s390/hardirq.h
--- .15631-linux-2.5.74/include/asm-s390/hardirq.h	2003-07-03 09:43:58.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-s390/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -93,7 +93,7 @@ extern void do_call_softirq(void);
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+	if (!in_interrupt() && local_softirq_pending())			\
 		/* Use the async. stack for softirq */			\
 		do_call_softirq();					\
 	preempt_enable_no_resched();					\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-sparc/hardirq.h .15631-linux-2.5.74.updated/include/asm-sparc/hardirq.h
--- .15631-linux-2.5.74/include/asm-sparc/hardirq.h	2003-05-27 15:02:20.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-sparc/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -99,7 +99,7 @@ typedef struct {
 #define irq_exit()                                                      \
 do {                                                                    \
                 preempt_count() -= IRQ_EXIT_OFFSET;                     \
-                if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+                if (!in_interrupt() && local_softirq_pending())		\
                         do_softirq();                                   \
                 preempt_enable_no_resched();                            \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-sparc64/hardirq.h .15631-linux-2.5.74.updated/include/asm-sparc64/hardirq.h
--- .15631-linux-2.5.74/include/asm-sparc64/hardirq.h	2003-05-27 15:02:20.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-sparc64/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -94,7 +94,7 @@ typedef struct {
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-v850/hardirq.h .15631-linux-2.5.74.updated/include/asm-v850/hardirq.h
--- .15631-linux-2.5.74/include/asm-v850/hardirq.h	2003-06-23 10:52:57.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-v850/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -83,7 +83,7 @@ typedef struct {
 #define irq_exit()							      \
 do {									      \
 	preempt_count() -= IRQ_EXIT_OFFSET;				      \
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	      \
+	if (!in_interrupt() && local_softirq_pending())			      \
 		do_softirq();						      \
 	preempt_enable_no_resched();					      \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-x86_64/hardirq.h .15631-linux-2.5.74.updated/include/asm-x86_64/hardirq.h
--- .15631-linux-2.5.74/include/asm-x86_64/hardirq.h	2003-06-15 11:30:08.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-x86_64/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -87,7 +87,7 @@
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+		if (!in_interrupt() && local_softirq_pending())		\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/linux/irq_cpustat.h .15631-linux-2.5.74.updated/include/linux/irq_cpustat.h
--- .15631-linux-2.5.74/include/linux/irq_cpustat.h	2003-07-03 16:24:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/linux/irq_cpustat.h	2003-07-03 16:24:22.000000000 +1000
@@ -18,7 +19,6 @@
 #endif
 
   /* arch independent irq_stat fields */
-#define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
-#define local_softirq_pending()	softirq_pending(smp_processor_id())
+#define local_softirq_pending()	__IRQ_STAT(smp_processor_id(), __softirq_pending)
 
   /* arch dependent irq_stat fields */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/linux/netdevice.h .15631-linux-2.5.74.updated/include/linux/netdevice.h
--- .15631-linux-2.5.74/include/linux/netdevice.h	2003-07-03 16:24:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/linux/netdevice.h	2003-07-03 16:24:22.000000000 +1000
@@ -648,7 +648,7 @@ extern int		netdev_nit;
 static inline int netif_rx_ni(struct sk_buff *skb)
 {
        int err = netif_rx(skb);
-       if (softirq_pending(smp_processor_id()))
+       if (local_softirq_pending())
                do_softirq();
        return err;
 }
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
