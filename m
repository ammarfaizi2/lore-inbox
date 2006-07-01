Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWGAPA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWGAPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWGAO5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:51 -0400
Received: from www.osadl.org ([213.239.205.134]:23972 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751407AbWGAO44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:56 -0400
Message-Id: <20060701145223.787017000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:24 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, bjorn@axis.com
Subject: [RFC][patch 05/44] CHRIS: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-cris.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/cris/arch-v10/drivers/gpio.c     |    4 ++--
 arch/cris/arch-v10/kernel/time.c      |    6 +++---
 arch/cris/arch-v32/drivers/gpio.c     |    4 ++--
 arch/cris/arch-v32/kernel/arbiter.c   |    2 +-
 arch/cris/arch-v32/kernel/fasttimer.c |    2 +-
 arch/cris/arch-v32/kernel/irq.c       |    2 +-
 arch/cris/arch-v32/kernel/smp.c       |    2 +-
 arch/cris/arch-v32/kernel/time.c      |   12 ++++++++----
 arch/cris/kernel/irq.c                |    2 +-
 include/asm-cris/arch-v10/irq.h       |    2 +-
 include/asm-cris/arch-v32/irq.h       |    2 +-
 include/asm-cris/signal.h             |    2 --
 12 files changed, 22 insertions(+), 20 deletions(-)

Index: linux-2.6.git/include/asm-cris/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-cris/signal.h	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/include/asm-cris/signal.h	2006-07-01 16:51:32.000000000 +0200
@@ -74,7 +74,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -95,7 +94,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/include/asm-cris/arch-v10/irq.h
===================================================================
--- linux-2.6.git.orig/include/asm-cris/arch-v10/irq.h	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/include/asm-cris/arch-v10/irq.h	2006-07-01 16:51:32.000000000 +0200
@@ -141,7 +141,7 @@ __asm__ ( \
  * it here, we would not get the multiple_irq at all.
  *
  * The non-blocking here is based on the knowledge that the timer interrupt is 
- * registred as a fast interrupt (SA_INTERRUPT) so that we _know_ there will not
+ * registred as a fast interrupt (IRQF_DISABLED) so that we _know_ there will not
  * be an sti() before the timer irq handler is run to acknowledge the interrupt.
  */
 
Index: linux-2.6.git/include/asm-cris/arch-v32/irq.h
===================================================================
--- linux-2.6.git.orig/include/asm-cris/arch-v32/irq.h	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/include/asm-cris/arch-v32/irq.h	2006-07-01 16:51:32.000000000 +0200
@@ -98,7 +98,7 @@ __asm__ (				\
  * if we had BLOCK'edit here, we would not get the multiple_irq at all.
  *
  * The non-blocking here is based on the knowledge that the timer interrupt is
- * registred as a fast interrupt (SA_INTERRUPT) so that we _know_ there will not
+ * registred as a fast interrupt (IRQF_DISABLED) so that we _know_ there will not
  * be an sti() before the timer irq handler is run to acknowledge the interrupt.
  */
 #define BUILD_TIMER_IRQ(nr, mask) 	\
Index: linux-2.6.git/arch/cris/arch-v10/drivers/gpio.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v10/drivers/gpio.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v10/drivers/gpio.c	2006-07-01 16:51:32.000000000 +0200
@@ -937,11 +937,11 @@ gpio_init(void)
 	 * in some tests.
 	 */  
 	if (request_irq(TIMER0_IRQ_NBR, gpio_poll_timer_interrupt,
-			SA_SHIRQ | SA_INTERRUPT,"gpio poll", NULL)) {
+			IRQF_SHARED | IRQF_DISABLED,"gpio poll", NULL)) {
 		printk(KERN_CRIT "err: timer0 irq for gpio\n");
 	}
 	if (request_irq(PA_IRQ_NBR, gpio_pa_interrupt,
-			SA_SHIRQ | SA_INTERRUPT,"gpio PA", NULL)) {
+			IRQF_SHARED | IRQF_DISABLED,"gpio PA", NULL)) {
 		printk(KERN_CRIT "err: PA irq for gpio\n");
 	}
 	
Index: linux-2.6.git/arch/cris/arch-v10/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v10/kernel/time.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v10/kernel/time.c	2006-07-01 16:51:32.000000000 +0200
@@ -251,11 +251,11 @@ timer_interrupt(int irq, void *dev_id, s
         return IRQ_HANDLED;
 }
 
-/* timer is SA_SHIRQ so drivers can add stuff to the timer irq chain
- * it needs to be SA_INTERRUPT to make the jiffies update work properly
+/* timer is IRQF_SHARED so drivers can add stuff to the timer irq chain
+ * it needs to be IRQF_DISABLED to make the jiffies update work properly
  */
 
-static struct irqaction irq2  = { timer_interrupt, SA_SHIRQ | SA_INTERRUPT,
+static struct irqaction irq2  = { timer_interrupt, IRQF_SHARED | IRQF_DISABLED,
 				  CPU_MASK_NONE, "timer", NULL, NULL};
 
 void __init
Index: linux-2.6.git/arch/cris/arch-v32/drivers/gpio.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/drivers/gpio.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v32/drivers/gpio.c	2006-07-01 16:51:32.000000000 +0200
@@ -744,11 +744,11 @@ gpio_init(void)
 	 * in some tests.
 	 */
 	if (request_irq(TIMER_INTR_VECT, gpio_poll_timer_interrupt,
-			SA_SHIRQ | SA_INTERRUPT,"gpio poll", &alarmlist)) {
+			IRQF_SHARED | IRQF_DISABLED,"gpio poll", &alarmlist)) {
 		printk("err: timer0 irq for gpio\n");
 	}
 	if (request_irq(GEN_IO_INTR_VECT, gpio_pa_interrupt,
-			SA_SHIRQ | SA_INTERRUPT,"gpio PA", &alarmlist)) {
+			IRQF_SHARED | IRQF_DISABLED,"gpio PA", &alarmlist)) {
 		printk("err: PA irq for gpio\n");
 	}
 	/* enable the gio and timer irq in global config */
Index: linux-2.6.git/arch/cris/arch-v32/kernel/arbiter.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/kernel/arbiter.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v32/kernel/arbiter.c	2006-07-01 16:51:32.000000000 +0200
@@ -119,7 +119,7 @@ static void crisv32_arbiter_init(void)
         crisv32_arbiter_config(EXT_REGION);
         crisv32_arbiter_config(INT_REGION);
 
-	if (request_irq(MEMARB_INTR_VECT, crisv32_arbiter_irq, SA_INTERRUPT,
+	if (request_irq(MEMARB_INTR_VECT, crisv32_arbiter_irq, IRQF_DISABLED,
                         "arbiter", NULL))
 		printk(KERN_ERR "Couldn't allocate arbiter IRQ\n");
 
Index: linux-2.6.git/arch/cris/arch-v32/kernel/fasttimer.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/kernel/fasttimer.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v32/kernel/fasttimer.c	2006-07-01 16:51:32.000000000 +0200
@@ -981,7 +981,7 @@ void fast_timer_init(void)
     proc_register_dynamic(&proc_root, &fasttimer_proc_entry);
 #endif
 #endif /* PROC_FS */
-    if(request_irq(TIMER_INTR_VECT, timer_trig_interrupt, SA_INTERRUPT,
+    if(request_irq(TIMER_INTR_VECT, timer_trig_interrupt, IRQF_DISABLED,
                    "fast timer int", NULL))
     {
       printk("err: timer1 irq\n");
Index: linux-2.6.git/arch/cris/arch-v32/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/kernel/irq.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v32/kernel/irq.c	2006-07-01 16:51:32.000000000 +0200
@@ -268,7 +268,7 @@ void
 crisv32_do_IRQ(int irq, int block, struct pt_regs* regs)
 {
 	/* Interrupts that may not be moved to another CPU and
-         * are SA_INTERRUPT may skip blocking. This is currently
+         * are IRQF_DISABLED may skip blocking. This is currently
          * only valid for the timer IRQ and the IPI and is used
          * for the timer interrupt to avoid watchdog starvation.
          */
Index: linux-2.6.git/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/kernel/smp.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v32/kernel/smp.c	2006-07-01 16:51:32.000000000 +0200
@@ -62,7 +62,7 @@ static unsigned long irq_regs[NR_CPUS] =
 
 static irqreturn_t crisv32_ipi_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static int send_ipi(int vector, int wait, cpumask_t cpu_mask);
-static struct irqaction irq_ipi  = { crisv32_ipi_interrupt, SA_INTERRUPT,
+static struct irqaction irq_ipi  = { crisv32_ipi_interrupt, IRQF_DISABLED,
                                      CPU_MASK_NONE, "ipi", NULL, NULL};
 
 extern void cris_mmu_init(void);
Index: linux-2.6.git/arch/cris/arch-v32/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/kernel/time.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/arch-v32/kernel/time.c	2006-07-01 16:51:32.000000000 +0200
@@ -241,12 +241,16 @@ timer_interrupt(int irq, void *dev_id, s
         return IRQ_HANDLED;
 }
 
-/* timer is SA_SHIRQ so drivers can add stuff to the timer irq chain
- * it needs to be SA_INTERRUPT to make the jiffies update work properly
+/* timer is IRQF_SHARED so drivers can add stuff to the timer irq chain
+ * it needs to be IRQF_DISABLED to make the jiffies update work properly
  */
 
-static struct irqaction irq_timer  = { timer_interrupt, SA_SHIRQ | SA_INTERRUPT,
-				  CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq_timer  = { 
+	.mask = timer_interrupt, 
+	.flags = IRQF_SHARED | IRQF_DISABLED,
+	.mask = CPU_MASK_NONE, 
+	.name = "timer"
+};
 
 void __init
 cris_timer_init(void)
Index: linux-2.6.git/arch/cris/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/cris/kernel/irq.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/cris/kernel/irq.c	2006-07-01 16:51:32.000000000 +0200
@@ -85,7 +85,7 @@ skip:
 /* called by the assembler IRQ entry functions defined in irq.h
  * to dispatch the interrupts to registred handlers
  * interrupts are disabled upon entry - depending on if the
- * interrupt was registred with SA_INTERRUPT or not, interrupts
+ * interrupt was registred with IRQF_DISABLED or not, interrupts
  * are re-enabled or not.
  */
 

--

