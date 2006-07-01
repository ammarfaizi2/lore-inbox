Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWGAPG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWGAPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWGAPGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:06:25 -0400
Received: from www.osadl.org ([213.239.205.134]:63396 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751901AbWGAO5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:34 -0400
Message-Id: <20060701145227.547438000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:03 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, greg@kroah.com
Subject: [RFC][patch 37/44] pci: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-pci.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/pci/hotplug/cpci_hotplug_core.c |    2 +-
 drivers/pci/hotplug/cpcihp_zt5550.c     |    4 ++--
 drivers/pci/hotplug/cpqphp_core.c       |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c        |    2 +-
 drivers/pci/hotplug/shpchp_hpc.c        |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.git/drivers/pci/hotplug/cpci_hotplug_core.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/hotplug/cpci_hotplug_core.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/pci/hotplug/cpci_hotplug_core.c	2006-07-01 16:51:46.000000000 +0200
@@ -347,7 +347,7 @@ cpci_hp_intr(int irq, void *data, struct
 	dbg("entered cpci_hp_intr");
 
 	/* Check to see if it was our interrupt */
-	if ((controller->irq_flags & SA_SHIRQ) &&
+	if ((controller->irq_flags & IRQF_SHARED) &&
 	    !controller->ops->check_irq(controller->dev_id)) {
 		dbg("exited cpci_hp_intr, not our interrupt");
 		return IRQ_NONE;
Index: linux-2.6.git/drivers/pci/hotplug/cpcihp_zt5550.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/hotplug/cpcihp_zt5550.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/pci/hotplug/cpcihp_zt5550.c	2006-07-01 16:51:46.000000000 +0200
@@ -35,7 +35,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
-#include <linux/signal.h>	/* SA_SHIRQ */
+#include <linux/signal.h>	/* IRQF_SHARED */
 #include "cpci_hotplug.h"
 #include "cpcihp_zt5550.h"
 
@@ -219,7 +219,7 @@ static int zt5550_hc_init_one (struct pc
 	zt5550_hpc.ops = &zt5550_hpc_ops;
 	if(!poll) {
 		zt5550_hpc.irq = hc_dev->irq;
-		zt5550_hpc.irq_flags = SA_SHIRQ;
+		zt5550_hpc.irq_flags = IRQF_SHARED;
 		zt5550_hpc.dev_id = hc_dev;
 
 		zt5550_hpc_ops.enable_irq = zt5550_hc_enable_irq;
Index: linux-2.6.git/drivers/pci/hotplug/cpqphp_core.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/hotplug/cpqphp_core.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/pci/hotplug/cpqphp_core.c	2006-07-01 16:51:46.000000000 +0200
@@ -1188,7 +1188,7 @@ static int cpqhpc_probe(struct pci_dev *
 	/* set up the interrupt */
 	dbg("HPC interrupt = %d \n", ctrl->interrupt);
 	if (request_irq(ctrl->interrupt, cpqhp_ctrl_intr,
-			SA_SHIRQ, MY_NAME, ctrl)) {
+			IRQF_SHARED, MY_NAME, ctrl)) {
 		err("Can't get irq %d for the hotplug pci controller\n",
 			ctrl->interrupt);
 		rc = -ENODEV;
Index: linux-2.6.git/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/hotplug/pciehp_hpc.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/pci/hotplug/pciehp_hpc.c	2006-07-01 16:51:46.000000000 +0200
@@ -1458,7 +1458,7 @@ int pcie_init(struct controller * ctrl, 
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-		rc = request_irq(php_ctlr->irq, pcie_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
+		rc = request_irq(php_ctlr->irq, pcie_isr, IRQF_SHARED, MY_NAME, (void *) ctrl);
 		dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
 		if (rc) {
 			err("Can't get irq %d for the hotplug controller\n", php_ctlr->irq);
Index: linux-2.6.git/drivers/pci/hotplug/shpchp_hpc.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/hotplug/shpchp_hpc.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/pci/hotplug/shpchp_hpc.c	2006-07-01 16:51:46.000000000 +0200
@@ -1246,7 +1246,7 @@ int shpc_init(struct controller * ctrl, 
 		} else
 			php_ctlr->irq = pdev->irq;
 		
-		rc = request_irq(php_ctlr->irq, shpc_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
+		rc = request_irq(php_ctlr->irq, shpc_isr, IRQF_SHARED, MY_NAME, (void *) ctrl);
 		dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
 		if (rc) {
 			err("Can't get irq %d for the hotplug controller\n", php_ctlr->irq);

--

