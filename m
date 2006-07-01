Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWGAO5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWGAO5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWGAO5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:15 -0400
Received: from www.osadl.org ([213.239.205.134]:41892 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751720AbWGAO5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:12 -0400
Message-Id: <20060701145225.529391000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:42 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, davem@davemloft.net
Subject: [RFC][patch 20/44] SPARC64: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-sparc64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/sparc64/kernel/ebus.c       |    2 +-
 arch/sparc64/kernel/pci_psycho.c |    8 ++++----
 arch/sparc64/kernel/pci_sabre.c  |    6 +++---
 arch/sparc64/kernel/pci_schizo.c |   20 ++++++++++----------
 arch/sparc64/kernel/sbus.c       |    6 +++---
 include/asm-sparc64/floppy.h     |    2 +-
 include/asm-sparc64/signal.h     |    3 ---
 7 files changed, 22 insertions(+), 25 deletions(-)

Index: linux-2.6.git/include/asm-sparc64/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-sparc64/floppy.h	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/include/asm-sparc64/floppy.h	2006-07-01 16:51:37.000000000 +0200
@@ -267,7 +267,7 @@ static int sun_fd_request_irq(void)
 		once = 1;
 
 		error = request_irq(FLOPPY_IRQ, sparc_floppy_irq, 
-				    SA_INTERRUPT, "floppy", NULL);
+				    IRQF_DISABLED, "floppy", NULL);
 
 		return ((error == 0) ? 0 : -1);
 	}
Index: linux-2.6.git/include/asm-sparc64/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-sparc64/signal.h	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/include/asm-sparc64/signal.h	2006-07-01 16:51:37.000000000 +0200
@@ -133,16 +133,13 @@ struct sigstack {
  * usage of signal stacks by using the (now obsolete) sa_restorer field in
  * the sigaction structure as a stack pointer. This is now possible due to
  * the changes in signal handling. LBT 010493.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_SHIRQ flag is for shared interrupt support on PCI and EISA.
  */
 #define SA_NOCLDSTOP	_SV_IGNCHILD
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
 #define SA_ONESHOT	_SV_RESET
-#define SA_INTERRUPT	0x10u
 #define SA_NOMASK	0x20u
 #define SA_NOCLDWAIT    0x100u
 #define SA_SIGINFO      0x200u
Index: linux-2.6.git/arch/sparc64/kernel/ebus.c
===================================================================
--- linux-2.6.git.orig/arch/sparc64/kernel/ebus.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc64/kernel/ebus.c	2006-07-01 16:51:37.000000000 +0200
@@ -140,7 +140,7 @@ int ebus_dma_irq_enable(struct ebus_dma_
 
 	if (on) {
 		if (p->flags & EBUS_DMA_FLAG_USE_EBDMA_HANDLER) {
-			if (request_irq(p->irq, ebus_dma_irq, SA_SHIRQ, p->name, p))
+			if (request_irq(p->irq, ebus_dma_irq, IRQF_SHARED, p->name, p))
 				return -EBUSY;
 		}
 
Index: linux-2.6.git/arch/sparc64/kernel/pci_psycho.c
===================================================================
--- linux-2.6.git.orig/arch/sparc64/kernel/pci_psycho.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc64/kernel/pci_psycho.c	2006-07-01 16:51:37.000000000 +0200
@@ -863,11 +863,11 @@ static void psycho_register_error_handle
 	if (op->num_irqs < 6)
 		return;
 
-	request_irq(op->irqs[1], psycho_ue_intr, SA_SHIRQ, "PSYCHO UE", p);
-	request_irq(op->irqs[2], psycho_ce_intr, SA_SHIRQ, "PSYCHO CE", p);
-	request_irq(op->irqs[5], psycho_pcierr_intr, SA_SHIRQ,
+	request_irq(op->irqs[1], psycho_ue_intr, IRQF_SHARED, "PSYCHO UE", p);
+	request_irq(op->irqs[2], psycho_ce_intr, IRQF_SHARED, "PSYCHO CE", p);
+	request_irq(op->irqs[5], psycho_pcierr_intr, IRQF_SHARED,
 		    "PSYCHO PCIERR-A", &p->pbm_A);
-	request_irq(op->irqs[0], psycho_pcierr_intr, SA_SHIRQ,
+	request_irq(op->irqs[0], psycho_pcierr_intr, IRQF_SHARED,
 		    "PSYCHO PCIERR-B", &p->pbm_B);
 
 	/* Enable UE and CE interrupts for controller. */
Index: linux-2.6.git/arch/sparc64/kernel/pci_sabre.c
===================================================================
--- linux-2.6.git.orig/arch/sparc64/kernel/pci_sabre.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc64/kernel/pci_sabre.c	2006-07-01 16:51:37.000000000 +0200
@@ -854,14 +854,14 @@ static void sabre_register_error_handler
 		     SABRE_UEAFSR_SDRD | SABRE_UEAFSR_SDWR |
 		     SABRE_UEAFSR_SDTE | SABRE_UEAFSR_PDTE));
 
-	request_irq(op->irqs[1], sabre_ue_intr, SA_SHIRQ, "SABRE UE", p);
+	request_irq(op->irqs[1], sabre_ue_intr, IRQF_SHARED, "SABRE UE", p);
 
 	sabre_write(base + SABRE_CE_AFSR,
 		    (SABRE_CEAFSR_PDRD | SABRE_CEAFSR_PDWR |
 		     SABRE_CEAFSR_SDRD | SABRE_CEAFSR_SDWR));
 
-	request_irq(op->irqs[2], sabre_ce_intr, SA_SHIRQ, "SABRE CE", p);
-	request_irq(op->irqs[0], sabre_pcierr_intr, SA_SHIRQ,
+	request_irq(op->irqs[2], sabre_ce_intr, IRQF_SHARED, "SABRE CE", p);
+	request_irq(op->irqs[0], sabre_pcierr_intr, IRQF_SHARED,
 		    "SABRE PCIERR", p);
 
 	tmp = sabre_read(base + SABRE_PCICTRL);
Index: linux-2.6.git/arch/sparc64/kernel/pci_schizo.c
===================================================================
--- linux-2.6.git.orig/arch/sparc64/kernel/pci_schizo.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc64/kernel/pci_schizo.c	2006-07-01 16:51:37.000000000 +0200
@@ -998,32 +998,32 @@ static void tomatillo_register_error_han
 	pbm = pbm_for_ino(p, SCHIZO_UE_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[1], schizo_ue_intr, SA_SHIRQ,
+		request_irq(op->irqs[1], schizo_ue_intr, IRQF_SHARED,
 			    "TOMATILLO_UE", p);
 
 	pbm = pbm_for_ino(p, SCHIZO_CE_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[2], schizo_ce_intr, SA_SHIRQ,
+		request_irq(op->irqs[2], schizo_ce_intr, IRQF_SHARED,
 			    "TOMATILLO CE", p);
 
 	pbm = pbm_for_ino(p, SCHIZO_PCIERR_A_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[0], schizo_pcierr_intr, SA_SHIRQ,
+		request_irq(op->irqs[0], schizo_pcierr_intr, IRQF_SHARED,
 			    "TOMATILLO PCIERR-A", pbm);
 
 
 	pbm = pbm_for_ino(p, SCHIZO_PCIERR_B_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[0], schizo_pcierr_intr, SA_SHIRQ,
+		request_irq(op->irqs[0], schizo_pcierr_intr, IRQF_SHARED,
 			    "TOMATILLO PCIERR-B", pbm);
 
 	pbm = pbm_for_ino(p, SCHIZO_SERR_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[3], schizo_safarierr_intr, SA_SHIRQ,
+		request_irq(op->irqs[3], schizo_safarierr_intr, IRQF_SHARED,
 			    "TOMATILLO SERR", p);
 
 	/* Enable UE and CE interrupts for controller. */
@@ -1106,32 +1106,32 @@ static void schizo_register_error_handle
 	pbm = pbm_for_ino(p, SCHIZO_UE_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[1], schizo_ue_intr, SA_SHIRQ,
+		request_irq(op->irqs[1], schizo_ue_intr, IRQF_SHARED,
 			    "SCHIZO_UE", p);
 
 	pbm = pbm_for_ino(p, SCHIZO_CE_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[2], schizo_ce_intr, SA_SHIRQ,
+		request_irq(op->irqs[2], schizo_ce_intr, IRQF_SHARED,
 			    "SCHIZO CE", p);
 
 	pbm = pbm_for_ino(p, SCHIZO_PCIERR_A_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[0], schizo_pcierr_intr, SA_SHIRQ,
+		request_irq(op->irqs[0], schizo_pcierr_intr, IRQF_SHARED,
 			    "SCHIZO PCIERR-A", pbm);
 
 
 	pbm = pbm_for_ino(p, SCHIZO_PCIERR_B_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[0], schizo_pcierr_intr, SA_SHIRQ,
+		request_irq(op->irqs[0], schizo_pcierr_intr, IRQF_SHARED,
 			    "SCHIZO PCIERR-B", pbm);
 
 	pbm = pbm_for_ino(p, SCHIZO_SERR_INO);
 	op = of_find_device_by_node(pbm->prom_node);
 	if (op)
-		request_irq(op->irqs[3], schizo_safarierr_intr, SA_SHIRQ,
+		request_irq(op->irqs[3], schizo_safarierr_intr, IRQF_SHARED,
 			    "SCHIZO SERR", p);
 
 	/* Enable UE and CE interrupts for controller. */
Index: linux-2.6.git/arch/sparc64/kernel/sbus.c
===================================================================
--- linux-2.6.git.orig/arch/sparc64/kernel/sbus.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc64/kernel/sbus.c	2006-07-01 16:51:37.000000000 +0200
@@ -1065,7 +1065,7 @@ static void __init sysio_register_error_
 
 	irq = sbus_build_irq(sbus, SYSIO_UE_INO);
 	if (request_irq(irq, sysio_ue_handler,
-			SA_SHIRQ, "SYSIO UE", sbus) < 0) {
+			IRQF_SHARED, "SYSIO UE", sbus) < 0) {
 		prom_printf("SYSIO[%x]: Cannot register UE interrupt.\n",
 			    sbus->portid);
 		prom_halt();
@@ -1073,7 +1073,7 @@ static void __init sysio_register_error_
 
 	irq = sbus_build_irq(sbus, SYSIO_CE_INO);
 	if (request_irq(irq, sysio_ce_handler,
-			SA_SHIRQ, "SYSIO CE", sbus) < 0) {
+			IRQF_SHARED, "SYSIO CE", sbus) < 0) {
 		prom_printf("SYSIO[%x]: Cannot register CE interrupt.\n",
 			    sbus->portid);
 		prom_halt();
@@ -1081,7 +1081,7 @@ static void __init sysio_register_error_
 
 	irq = sbus_build_irq(sbus, SYSIO_SBUSERR_INO);
 	if (request_irq(irq, sysio_sbus_error_handler,
-			SA_SHIRQ, "SYSIO SBUS Error", sbus) < 0) {
+			IRQF_SHARED, "SYSIO SBUS Error", sbus) < 0) {
 		prom_printf("SYSIO[%x]: Cannot register SBUS Error interrupt.\n",
 			    sbus->portid);
 		prom_halt();

--

