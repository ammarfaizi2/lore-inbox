Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWGXN46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWGXN46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGXN46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:56:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51607 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932170AbWGXN45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:56:57 -0400
From: John Keller <jpk@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, John Keller <jpk@sgi.com>
Date: Mon, 24 Jul 2006 08:56:51 -0500
Message-Id: <20060724135651.9866.68897.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend #3

 - Add iounmap() call for dma failure case.
   This driver cannot be unloaded, so no additional
   iounmap calls needed.

Resend #2 changes include:

- use 'void __iomem *' for ioremap() return values,
  and handle error cases.

sgiioc4.c had been recently converted to using mmio ops.
There are still a few issues to cleanup.

Signed-off-by: jpk@sgi.com


Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c	2006-07-21 13:03:29.120164007 -0500
+++ linux-2.6/drivers/ide/pci/sgiioc4.c	2006-07-21 13:03:48.058314086 -0500
@@ -367,12 +367,13 @@ sgiioc4_INB(unsigned long port)
 static void __devinit
 ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base)
 {
+	void __iomem *virt_dma_base;
 	int num_ports = sizeof (ioc4_dma_regs_t);
 
 	printk(KERN_INFO "%s: BM-DMA at 0x%04lx-0x%04lx\n", hwif->name,
 	       dma_base, dma_base + num_ports - 1);
 
-	if (!request_region(dma_base, num_ports, hwif->name)) {
+	if (!request_mem_region(dma_base, num_ports, hwif->name)) {
 		printk(KERN_ERR
 		       "%s(%s) -- ERROR, Addresses 0x%p to 0x%p "
 		       "ALREADY in use\n",
@@ -381,13 +382,21 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
 		goto dma_alloc_failure;
 	}
 
-	hwif->dma_base = dma_base;
+	virt_dma_base = ioremap(dma_base, num_ports);
+	if (virt_dma_base == NULL) {
+		printk(KERN_ERR
+		       "%s(%s) -- ERROR, Unable to map addresses 0x%lx to 0x%lx\n",
+		       __FUNCTION__, hwif->name, dma_base, dma_base + num_ports - 1);
+		goto dma_remap_failure;
+	}
+	hwif->dma_base = (unsigned long) virt_dma_base;
+
 	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
 					  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 					  &hwif->dmatable_dma);
 
 	if (!hwif->dmatable_cpu)
-		goto dma_alloc_failure;
+		goto dma_pci_alloc_failure;
 
 	hwif->sg_max_nents = IOC4_PRD_ENTRIES;
 
@@ -411,6 +420,12 @@ dma_base2alloc_failure:
 	printk(KERN_INFO
 	       "Changing from DMA to PIO mode for Drive %s\n", hwif->name);
 
+dma_pci_alloc_failure:
+	iounmap(virt_dma_base);
+
+dma_remap_failure:
+	release_mem_region(dma_base, num_ports);
+
 dma_alloc_failure:
 	/* Disable DMA because we couldnot allocate any DMA maps */
 	hwif->autodma = 0;
@@ -607,18 +622,15 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
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
+	unsigned long cmd_base, dma_base, irqport;
+	unsigned long bar0, cmd_phys_base, ctl;
+	void __iomem *virt_base;
 	ide_hwif_t *hwif;
 	int h;
 
@@ -636,23 +648,32 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	}
 
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
-	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
-	ctl = pci_resource_start(dev, 0) + IOC4_CTRL_OFFSET;
-	irqport = pci_resource_start(dev, 0) + IOC4_INTR_OFFSET;
+	bar0 = pci_resource_start(dev, 0);
+	virt_base = ioremap(bar0, pci_resource_len(dev, 0));
+	if (virt_base == NULL) {
+		printk(KERN_ERR "%s: Unable to remap BAR 0 address: 0x%lx\n",
+			d->name, bar0);
+		return -ENOMEM;
+	}
+	cmd_base = (unsigned long) virt_base + IOC4_CMD_OFFSET;
+	ctl = (unsigned long) virt_base + IOC4_CTRL_OFFSET;
+	irqport = (unsigned long) virt_base + IOC4_INTR_OFFSET;
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
@@ -665,6 +686,9 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	hwif->cds = (struct ide_pci_device_s *) d;
 	hwif->gendev.parent = &dev->dev;/* setup proper ancestral information */
 
+	/* The IOC4 uses MMIO rather than Port IO. */
+	default_hwif_mmiops(hwif);
+
 	/* Initializing chipset IRQ Registers */
 	hwif->OUTL(0x03, irqport + IOC4_INTR_SET * 4);
 
