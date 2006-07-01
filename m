Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWGAPGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGAPGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWGAO5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:34 -0400
Received: from www.osadl.org ([213.239.205.134]:39588 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751634AbWGAO5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:11 -0400
Message-Id: <20060701145225.299472000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:40 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, lethal@linux-sh.org
Subject: [RFC][patch 18/44] SH64: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-sh64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/sh64/kernel/dma.c      |    4 ++--
 arch/sh64/kernel/pci_sh5.c  |    4 ++--
 arch/sh64/kernel/time.c     |    4 ++--
 arch/sh64/mach-cayman/irq.c |    4 ++--
 include/asm-sh64/keyboard.h |    2 +-
 include/asm-sh64/signal.h   |    2 --
 6 files changed, 9 insertions(+), 11 deletions(-)

Index: linux-2.6.git/include/asm-sh64/keyboard.h
===================================================================
--- linux-2.6.git.orig/include/asm-sh64/keyboard.h	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/include/asm-sh64/keyboard.h	2006-07-01 16:51:36.000000000 +0200
@@ -65,7 +65,7 @@ extern unsigned char pckbd_sysrq_xlate[1
 #endif
 
 #define aux_request_irq(hand, dev_id)					\
-	request_irq(AUX_IRQ, hand, SA_SHIRQ, "PS2 Mouse", dev_id)
+	request_irq(AUX_IRQ, hand, IRQF_SHARED, "PS2 Mouse", dev_id)
 
 #define aux_free_irq(dev_id) free_irq(AUX_IRQ, dev_id)
 
Index: linux-2.6.git/include/asm-sh64/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-sh64/signal.h	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/include/asm-sh64/signal.h	2006-07-01 16:51:36.000000000 +0200
@@ -74,7 +74,6 @@ typedef struct {
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -94,7 +93,6 @@ typedef struct {
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/sh64/kernel/dma.c
===================================================================
--- linux-2.6.git.orig/arch/sh64/kernel/dma.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh64/kernel/dma.c	2006-07-01 16:51:36.000000000 +0200
@@ -115,7 +115,7 @@ static irqreturn_t dma_mte(int irq, void
 
 static struct irqaction irq_dmte = {
 	.handler	= dma_mte,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "DMA MTE",
 };
 
@@ -152,7 +152,7 @@ static irqreturn_t dma_err(int irq, void
 
 static struct irqaction irq_derr = {
 	.handler	= dma_err,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "DMA Error",
 };
 
Index: linux-2.6.git/arch/sh64/kernel/pci_sh5.c
===================================================================
--- linux-2.6.git.orig/arch/sh64/kernel/pci_sh5.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh64/kernel/pci_sh5.c	2006-07-01 16:51:36.000000000 +0200
@@ -473,13 +473,13 @@ static void __init pcibios_size_bridges(
 static int __init pcibios_init(void)
 {
         if (request_irq(IRQ_ERR, pcish5_err_irq,
-                        SA_INTERRUPT, "PCI Error",NULL) < 0) {
+                        IRQF_DISABLED, "PCI Error",NULL) < 0) {
                 printk(KERN_ERR "PCISH5: Cannot hook PCI_PERR interrupt\n");
                 return -EINVAL;
         }
 
         if (request_irq(IRQ_SERR, pcish5_serr_irq,
-                        SA_INTERRUPT, "PCI SERR interrupt", NULL) < 0) {
+                        IRQF_DISABLED, "PCI SERR interrupt", NULL) < 0) {
                 printk(KERN_ERR "PCISH5: Cannot hook PCI_SERR interrupt\n");
                 return -EINVAL;
         }
Index: linux-2.6.git/arch/sh64/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/sh64/kernel/time.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh64/kernel/time.c	2006-07-01 16:51:36.000000000 +0200
@@ -484,8 +484,8 @@ static irqreturn_t sh64_rtc_interrupt(in
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
-static struct irqaction irq1  = { sh64_rtc_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "rtc", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq1  = { sh64_rtc_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "rtc", NULL, NULL};
 
 void __init time_init(void)
 {
Index: linux-2.6.git/arch/sh64/mach-cayman/irq.c
===================================================================
--- linux-2.6.git.orig/arch/sh64/mach-cayman/irq.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh64/mach-cayman/irq.c	2006-07-01 16:51:36.000000000 +0200
@@ -44,13 +44,13 @@ static irqreturn_t cayman_interrupt_pci2
 static struct irqaction cayman_action_smsc = {
 	.name		= "Cayman SMSC Mux",
 	.handler	= cayman_interrupt_smsc,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 };
 
 static struct irqaction cayman_action_pci2 = {
 	.name		= "Cayman PCI2 Mux",
 	.handler	= cayman_interrupt_pci2,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 };
 
 static void enable_cayman_irq(unsigned int irq)

--

