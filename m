Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbUBZBgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUBZBgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:36:01 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:27322 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262603AbUBZBew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:34:52 -0500
Subject: [PATCH] move dma_consistent_dma_mask to the generic device
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       willy@debian.org, Jes Sorensen <jes@wildopensource.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Feb 2004 19:34:45 -0600
Message-Id: <1077759287.14081.24.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_dev.consistent_dma_mask was introduced to get around problems in the
IA64 Altix machine. 

Now, we have a use for it in x86: the aacraid needs coherent memory in a
31 bit address range (2GB).  Unfortunately, x86 is converted to the dma
model, so it can't see the pci_dev by the time coherent memory is
allocated. 

The solution to all of this is to move pci_dev.consistent_dma_mask to
dev.coherent_dma_mask and make x86 use it in the dma_alloc_coherent()
calls. 

This should allow me to make the aacraid set the coherent mask instead
of using it's current dma_mask juggling. 

I copied Matthew because parisc also has a parisc_device that needed to
be converted over. 

James 

===== arch/i386/kernel/pci-dma.c 1.11 vs edited =====
--- 1.11/arch/i386/kernel/pci-dma.c	Mon Jan 13 10:28:47 2003
+++ edited/arch/i386/kernel/pci-dma.c	Wed Feb 25 14:58:56 2004
@@ -20,8 +20,10 @@
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff)) {
+	  printk("COHERENT MASK 0x%llx\n", dev->coherent_dma_mask);
 		gfp |= GFP_DMA;
+	}
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
 	if (ret != NULL) {
===== arch/parisc/kernel/drivers.c 1.10 vs edited =====
--- 1.10/arch/parisc/kernel/drivers.c	Fri Feb  6 08:23:39 2004
+++ edited/arch/parisc/kernel/drivers.c	Wed Feb 25 15:11:50 2004
@@ -618,6 +618,7 @@
 		 tmp1);
 	/* make the generic dma mask a pointer to the parisc one */
 	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.coherent_dma_mask = dev->dma_mask;
 	pr_debug("device_register(%s)\n", dev->dev.bus_id);
 	device_register(&dev->dev);
 }
===== arch/parisc/kernel/pci-dma.c 1.7 vs edited =====
--- 1.7/arch/parisc/kernel/pci-dma.c	Tue Feb  3 23:41:56 2004
+++ edited/arch/parisc/kernel/pci-dma.c	Wed Feb 25 15:15:00 2004
@@ -372,7 +372,7 @@
 ** ISA cards will certainly only support 24-bit DMA addressing.
 ** Not clear if we can, want, or need to support ISA.
 */
-	if (!dev || *dev->dma_mask != 0xffffffff)
+	if (!dev || *dev->coherent_dma_mask < 0xffffffff)
 		gfp |= GFP_DMA;
 #endif
 	return (void *)vaddr;
===== drivers/eisa/eisa-bus.c 1.14 vs edited =====
--- 1.14/drivers/eisa/eisa-bus.c	Sun Oct  5 03:07:57 2003
+++ edited/drivers/eisa/eisa-bus.c	Wed Feb 25 14:58:57 2004
@@ -187,6 +187,7 @@
 	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
 	edev->dev.dma_mask = &edev->dma_mask;
+	edev->dev.coherent_dma_mask = edev->dma_mask;
 	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
 	for (i = 0; i < EISA_MAX_RESOURCES; i++) {
===== drivers/mca/mca-bus.c 1.5 vs edited =====
--- 1.5/drivers/mca/mca-bus.c	Sun Aug 17 13:44:15 2003
+++ edited/drivers/mca/mca-bus.c	Wed Feb 25 14:58:58 2004
@@ -106,6 +106,7 @@
 	sprintf (mca_dev->dev.bus_id, "%02d:%02X", bus, mca_dev->slot);
 	mca_dev->dma_mask = mca_bus->default_dma_mask;
 	mca_dev->dev.dma_mask = &mca_dev->dma_mask;
+	mca_dev->dev.coherent_dma_mask = mca_dev->dma_mask;
 
 	if (device_register(&mca_dev->dev))
 		return 0;
===== drivers/pci/pci.c 1.61 vs edited =====
--- 1.61/drivers/pci/pci.c	Tue Feb 10 12:01:13 2004
+++ edited/drivers/pci/pci.c	Wed Feb 25 14:58:58 2004
@@ -691,7 +691,7 @@
 	if (!pci_dma_supported(dev, mask))
 		return -EIO;
 
-	dev->consistent_dma_mask = mask;
+	dev->dev.coherent_dma_mask = mask;
 
 	return 0;
 }
===== drivers/pci/probe.c 1.59 vs edited =====
--- 1.59/drivers/pci/probe.c	Wed Feb 18 21:42:58 2004
+++ edited/drivers/pci/probe.c	Wed Feb 25 14:59:00 2004
@@ -566,7 +566,6 @@
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
 	dev->dma_mask = 0xffffffff;
-	dev->consistent_dma_mask = 0xffffffff;
 	if (pci_setup_device(dev) < 0) {
 		kfree(dev);
 		return NULL;
@@ -578,6 +577,7 @@
 	pci_name_device(dev);
 
 	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.coherent_dma_mask = 0xffffffffull;
 
 	return dev;
 }
===== include/linux/device.h 1.115 vs edited =====
--- 1.115/include/linux/device.h	Mon Feb  9 17:40:25 2004
+++ edited/include/linux/device.h	Wed Feb 25 14:59:35 2004
@@ -285,6 +285,12 @@
 					   detached from its driver. */
 
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	u64		coherent_dma_mask;/* Like dma_mask, but for
+					     alloc_coherent mappings as
+					     not all hardware supports
+					     64 bit addresses for consistent
+					     allocations such descriptors. */
+
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
 	void	(*release)(struct device * dev);
===== include/linux/pci.h 1.117 vs edited =====
--- 1.117/include/linux/pci.h	Tue Feb 10 11:51:08 2004
+++ edited/include/linux/pci.h	Wed Feb 25 14:59:03 2004
@@ -392,11 +392,6 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
-	u64		consistent_dma_mask;/* Like dma_mask, but for
-					       pci_alloc_consistent mappings as
-					       not all hardware supports
-					       64 bit addresses for consistent
-					       allocations such descriptors. */
 	u32             current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */

