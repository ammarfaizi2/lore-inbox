Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWGLR5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWGLR5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWGLR5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:57:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8066 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932205AbWGLR5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:57:17 -0400
From: John Keller <jpk@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, John Keller <jpk@sgi.com>
Date: Wed, 12 Jul 2006 12:57:14 -0500
Message-Id: <20060712175714.16943.10799.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sgiioc4.c had been recently converted to using mmio ops.
There are still a few issues to cleanup.

Signed-off-by: jpk@sgi.com

--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c	2006-07-11 11:34:42.135934603 -0500
+++ linux-2.6/drivers/ide/pci/sgiioc4.c	2006-07-12 09:17:02.316590824 -0500
@@ -372,7 +372,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
 	printk(KERN_INFO "%s: BM-DMA at 0x%04lx-0x%04lx\n", hwif->name,
 	       dma_base, dma_base + num_ports - 1);
 
-	if (!request_region(dma_base, num_ports, hwif->name)) {
+	if (!request_mem_region(dma_base, num_ports, hwif->name)) {
 		printk(KERN_ERR
 		       "%s(%s) -- ERROR, Addresses 0x%p to 0x%p "
 		       "ALREADY in use\n",
@@ -381,7 +381,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
 		goto dma_alloc_failure;
 	}
 
-	hwif->dma_base = dma_base;
+	hwif->dma_base = (unsigned long) ioremap(dma_base, num_ports);
 	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
 					  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 					  &hwif->dmatable_dma);
@@ -607,18 +607,14 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 
-	/*
-	 * The IOC4 uses MMIO rather than Port IO.
-	 * It also needs special workarounds for INB.
-	 */
-	default_hwif_mmiops(hwif);
 	hwif->INB = &sgiioc4_INB;
 }
 
 static int __devinit
 sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t * d)
 {
-	unsigned long base, ctl, dma_base, irqport;
+	unsigned long ctl, dma_base, irqport;
+	unsigned long bar0, cmd_base, cmd_phys_base, virt_base;
 	ide_hwif_t *hwif;
 	int h;
 
@@ -636,23 +632,27 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	}
 
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
-	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
-	ctl = pci_resource_start(dev, 0) + IOC4_CTRL_OFFSET;
-	irqport = pci_resource_start(dev, 0) + IOC4_INTR_OFFSET;
+	bar0 = pci_resource_start(dev, 0);
+	virt_base = (unsigned long) ioremap(bar0, pci_resource_len(dev, 0));
+	cmd_base = virt_base + IOC4_CMD_OFFSET;
+	ctl = virt_base + IOC4_CTRL_OFFSET;
+	irqport = virt_base + IOC4_INTR_OFFSET;
 	dma_base = pci_resource_start(dev, 0) + IOC4_DMA_OFFSET;
 
-	if (!request_region(base, IOC4_CMD_CTL_BLK_SIZE, hwif->name)) {
+	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
+	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
+	    hwif->name)) {
 		printk(KERN_ERR
-			"%s : %s -- ERROR, Port Addresses "
+			"%s : %s -- ERROR, Addresses "
 			"0x%p to 0x%p ALREADY in use\n",
-		       __FUNCTION__, hwif->name, (void *) base,
-		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
+		       __FUNCTION__, hwif->name, (void *) cmd_phys_base,
+		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
 		return -ENOMEM;
 	}
 
-	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
+	if (hwif->io_ports[IDE_DATA_OFFSET] != cmd_base) {
 		/* Initialize the IO registers */
-		sgiioc4_init_hwif_ports(&hwif->hw, base, ctl, irqport);
+		sgiioc4_init_hwif_ports(&hwif->hw, cmd_base, ctl, irqport);
 		memcpy(hwif->io_ports, hwif->hw.io_ports,
 		       sizeof (hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
@@ -665,6 +665,9 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	hwif->cds = (struct ide_pci_device_s *) d;
 	hwif->gendev.parent = &dev->dev;/* setup proper ancestral information */
 
+	/* The IOC4 uses MMIO rather than Port IO. */
+	default_hwif_mmiops(hwif);
+
 	/* Initializing chipset IRQ Registers */
 	hwif->OUTL(0x03, irqport + IOC4_INTR_SET * 4);
 
