Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWGAPBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWGAPBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWGAO5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:46 -0400
Received: from www.osadl.org ([213.239.205.134]:27556 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751497AbWGAO47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:59 -0400
Message-Id: <20060701145224.140343000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 08/44] I386: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/i386/mach-default/setup.c |    2 +-
 arch/i386/mach-visws/setup.c   |    2 +-
 arch/i386/mach-voyager/setup.c |    2 +-
 arch/i386/pci/irq.c            |    2 +-
 include/asm-i386/floppy.h      |    8 ++++----
 include/asm-i386/signal.h      |    2 --
 6 files changed, 8 insertions(+), 10 deletions(-)

Index: linux-2.6.git/include/asm-i386/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/floppy.h	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/include/asm-i386/floppy.h	2006-07-01 16:51:33.000000000 +0200
@@ -144,11 +144,11 @@ static int vdma_get_dma_residue(unsigned
 static int fd_request_irq(void)
 {
 	if(can_use_virtual_dma)
-		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
-						   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_hardint,
+				   IRQF_DISABLED, "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
-				   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_interrupt,
+				   IRQF_DISABLED, "floppy", NULL);
 
 }
 
Index: linux-2.6.git/include/asm-i386/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/signal.h	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/include/asm-i386/signal.h	2006-07-01 16:51:33.000000000 +0200
@@ -77,7 +77,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -97,7 +96,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/i386/mach-default/setup.c
===================================================================
--- linux-2.6.git.orig/arch/i386/mach-default/setup.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/i386/mach-default/setup.c	2006-07-01 16:51:33.000000000 +0200
@@ -79,7 +79,7 @@ void __init trap_init_hook(void)
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL};
 
 /**
  * time_init_hook - do any specific initialisations for the system timer.
Index: linux-2.6.git/arch/i386/mach-visws/setup.c
===================================================================
--- linux-2.6.git.orig/arch/i386/mach-visws/setup.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/i386/mach-visws/setup.c	2006-07-01 16:51:33.000000000 +0200
@@ -115,7 +115,7 @@ void __init pre_setup_arch_hook()
 
 static struct irqaction irq0 = {
 	.handler =	timer_interrupt,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"timer",
 };
 
Index: linux-2.6.git/arch/i386/mach-voyager/setup.c
===================================================================
--- linux-2.6.git.orig/arch/i386/mach-voyager/setup.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/i386/mach-voyager/setup.c	2006-07-01 16:51:33.000000000 +0200
@@ -40,7 +40,7 @@ void __init trap_init_hook(void)
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL};
 
 void __init time_init_hook(void)
 {
Index: linux-2.6.git/arch/i386/pci/irq.c
===================================================================
--- linux-2.6.git.orig/arch/i386/pci/irq.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/i386/pci/irq.c	2006-07-01 16:51:33.000000000 +0200
@@ -864,7 +864,7 @@ static int pcibios_lookup_irq(struct pci
 		for (i = 0; i < 16; i++) {
 			if (!(mask & (1 << i)))
 				continue;
-			if (pirq_penalty[i] < pirq_penalty[newirq] && can_request_irq(i, SA_SHIRQ))
+			if (pirq_penalty[i] < pirq_penalty[newirq] && can_request_irq(i, IRQF_SHARED))
 				newirq = i;
 		}
 	}

--

