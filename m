Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbUBZQyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBZQyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:54:41 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:1925 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262839AbUBZQx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:53:58 -0500
Subject: [PATCH] move consistent_dma_mask to the generic device
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, willy@debian.org,
       Jes Sorensen <jes@wildopensource.com>,
       Grant Grundler <grundler@parisc-linux.org>, alex.williamson@hp.com,
       jbarnes@sgi.com, jeremy@sgi.com, ak@muc.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Feb 2004 10:53:12 -0600
Message-Id: <1077814394.2662.86.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reroll of the previous patch.  It fixes up badness in the
sound drivers which were accessing the dma_mask directly instead of
using the accessor functions.

It also modifies the arch's that were using consistent_dma_mask:

x86_64, ia64 (both sn and hp) and parisc

Here's the previous description:


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

James

===== arch/i386/kernel/pci-dma.c 1.11 vs edited =====
--- 1.11/arch/i386/kernel/pci-dma.c	Mon Jan 13 10:28:47 2003
+++ edited/arch/i386/kernel/pci-dma.c	Thu Feb 26 10:26:01 2004
@@ -20,8 +20,9 @@
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
+
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
 	if (ret != NULL) {
===== arch/ia64/hp/common/sba_iommu.c 1.37 vs edited =====
--- 1.37/arch/ia64/hp/common/sba_iommu.c	Mon Feb  2 09:58:46 2004
+++ edited/arch/ia64/hp/common/sba_iommu.c	Thu Feb 26 10:21:49 2004
@@ -1055,13 +1055,13 @@
 	*dma_handle = virt_to_phys(addr);
 
 #ifdef ALLOW_IOV_BYPASS
-	ASSERT(to_pci_dev(dev)->consistent_dma_mask);
+	ASSERT(dev->coherent_dma_mask);
 	/*
  	** Check if the PCI device can DMA to ptr... if so, just return ptr
  	*/
-	if (likely((*dma_handle & ~to_pci_dev(dev)->consistent_dma_mask) == 0)) {
+	if (likely((*dma_handle & ~dev->coherent_dma_mask) == 0)) {
 		DBG_BYPASS("sba_alloc_coherent() bypass mask/addr: 0x%lx/0x%lx\n",
-		           to_pci_dev(dev)->consistent_dma_mask, *dma_handle);
+		           dev->coherent_dma_mask, *dma_handle);
 
 		return addr;
 	}
===== arch/ia64/sn/io/machvec/pci_dma.c 1.26 vs edited =====
--- 1.26/arch/ia64/sn/io/machvec/pci_dma.c	Fri Feb 20 10:35:57 2004
+++ edited/arch/ia64/sn/io/machvec/pci_dma.c	Thu Feb 26 10:21:49 2004
@@ -152,7 +152,7 @@
 	 *   pcibr_dmatrans_addr ignores a missing PCIIO_DMA_A64 flag on
 	 *   PCI-X buses.
 	 */
-	if (hwdev->consistent_dma_mask == ~0UL)
+	if (hwdev->dev.coherent_dma_mask == ~0UL)
 		*dma_handle = pcibr_dmatrans_addr(vhdl, NULL, phys_addr, size,
 					  PCIIO_DMA_CMD | PCIIO_DMA_A64);
 	else {
@@ -169,7 +169,7 @@
 		}
 	}
 
-	if (!*dma_handle || *dma_handle > hwdev->consistent_dma_mask) {
+	if (!*dma_handle || *dma_handle > hwdev->dev.coherent_dma_mask) {
 		if (dma_map) {
 			pcibr_dmamap_done(dma_map);
 			pcibr_dmamap_free(dma_map);
===== arch/parisc/kernel/drivers.c 1.10 vs edited =====
--- 1.10/arch/parisc/kernel/drivers.c	Fri Feb  6 08:23:39 2004
+++ edited/arch/parisc/kernel/drivers.c	Thu Feb 26 10:21:50 2004
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
+++ edited/arch/parisc/kernel/pci-dma.c	Thu Feb 26 10:21:50 2004
@@ -372,7 +372,7 @@
 ** ISA cards will certainly only support 24-bit DMA addressing.
 ** Not clear if we can, want, or need to support ISA.
 */
-	if (!dev || *dev->dma_mask != 0xffffffff)
+	if (!dev || *dev->coherent_dma_mask < 0xffffffff)
 		gfp |= GFP_DMA;
 #endif
 	return (void *)vaddr;
===== arch/x86_64/kernel/pci-gart.c 1.29 vs edited =====
--- 1.29/arch/x86_64/kernel/pci-gart.c	Tue Feb 17 20:14:37 2004
+++ edited/arch/x86_64/kernel/pci-gart.c	Thu Feb 26 10:21:51 2004
@@ -177,7 +177,7 @@
 		gfp |= GFP_DMA; 
 		dma_mask = 0xffffffff; 
 	} else {
-		dma_mask = hwdev->consistent_dma_mask; 
+		dma_mask = hwdev->dev.coherent_dma_mask; 
 	}
 
 	if (dma_mask == 0) 
===== drivers/eisa/eisa-bus.c 1.14 vs edited =====
--- 1.14/drivers/eisa/eisa-bus.c	Sun Oct  5 03:07:57 2003
+++ edited/drivers/eisa/eisa-bus.c	Thu Feb 26 10:21:51 2004
@@ -187,6 +187,7 @@
 	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
 	edev->dev.dma_mask = &edev->dma_mask;
+	edev->dev.coherent_dma_mask = edev->dma_mask;
 	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
 	for (i = 0; i < EISA_MAX_RESOURCES; i++) {
===== drivers/mca/mca-bus.c 1.5 vs edited =====
--- 1.5/drivers/mca/mca-bus.c	Sun Aug 17 13:44:15 2003
+++ edited/drivers/mca/mca-bus.c	Thu Feb 26 10:21:52 2004
@@ -106,6 +106,7 @@
 	sprintf (mca_dev->dev.bus_id, "%02d:%02X", bus, mca_dev->slot);
 	mca_dev->dma_mask = mca_bus->default_dma_mask;
 	mca_dev->dev.dma_mask = &mca_dev->dma_mask;
+	mca_dev->dev.coherent_dma_mask = mca_dev->dma_mask;
 
 	if (device_register(&mca_dev->dev))
 		return 0;
===== drivers/pci/pci.c 1.61 vs edited =====
--- 1.61/drivers/pci/pci.c	Tue Feb 10 12:01:13 2004
+++ edited/drivers/pci/pci.c	Thu Feb 26 10:21:52 2004
@@ -691,7 +691,7 @@
 	if (!pci_dma_supported(dev, mask))
 		return -EIO;
 
-	dev->consistent_dma_mask = mask;
+	dev->dev.coherent_dma_mask = mask;
 
 	return 0;
 }
===== drivers/pci/probe.c 1.59 vs edited =====
--- 1.59/drivers/pci/probe.c	Wed Feb 18 21:42:58 2004
+++ edited/drivers/pci/probe.c	Thu Feb 26 10:21:53 2004
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
+++ edited/include/linux/device.h	Thu Feb 26 10:21:53 2004
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
+++ edited/include/linux/pci.h	Thu Feb 26 10:21:54 2004
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
===== sound/core/memalloc.c 1.16 vs edited =====
--- 1.16/sound/core/memalloc.c	Mon Jan 19 04:37:35 2004
+++ edited/sound/core/memalloc.c	Thu Feb 26 10:21:54 2004
@@ -100,13 +100,13 @@
 	if (hwdev == NULL)
 		return pci_alloc_consistent(hwdev, size, dma_handle);
 	dma_mask = hwdev->dma_mask;
-	cdma_mask = hwdev->consistent_dma_mask;
+	cdma_mask = hwdev->dev.coherent_dma_mask;
 	mask = (unsigned long)dma_mask && (unsigned long)cdma_mask;
 	hwdev->dma_mask = 0xffffffff; /* do without masking */
-	hwdev->consistent_dma_mask = 0xffffffff; /* do without masking */
+	hwdev->dev.coherent_dma_mask = 0xffffffff; /* do without masking */
 	ret = pci_alloc_consistent(hwdev, size, dma_handle);
 	hwdev->dma_mask = dma_mask; /* restore */
-	hwdev->consistent_dma_mask = cdma_mask; /* restore */
+	hwdev->dev.coherent_dma_mask = cdma_mask; /* restore */
 	if (ret) {
 		/* obtained address is out of range? */
 		if (((unsigned long)*dma_handle + size - 1) & ~mask) {
@@ -648,7 +648,7 @@
 	dma_addr_t addr;
 	unsigned long mask;
 
-	mask = pci ? (unsigned long)pci->consistent_dma_mask : 0x00ffffffUL;
+	mask = pci ? (unsigned long)pci->dev.coherent_dma_mask : 0x00ffffffUL;
 	ptr = (void *)__get_free_page(GFP_KERNEL);
 	if (ptr) {
 		addr = virt_to_phys(ptr);

