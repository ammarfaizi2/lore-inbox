Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbTHQWgS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271108AbTHQWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:36:18 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:37840 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S271105AbTHQWgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:36:08 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] RFC: kills consistent_dma_mask
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Aug 2003 00:34:17 +0200
Message-ID: <m3oeynykuu.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

What do you think about this patch? It kills all references to
consistent_dma_mask in 2.6.0-test3 tree.

The consistent_dma_mask (and set_... function) is presumably a hack
which is currently not used by anything (at least in the official tree).
It's unneeded (it can be easily done in a driver, should a need arrive,
without polluting the PCI subsystem) and is not supported by "DMA" API.
It isn't even implemented on most platforms - only x86_64 and ia64 have
support for it, while on the remaining archs using it according to the
docs (with non-default value) could mean Oops or something like that.

This patch doesn't actually change any current kernel behaviour.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=kill-consistent-mask.patch

diff -ur linux-2.6.orig/Documentation/DMA-mapping.txt linux/Documentation/DMA-mapping.txt
--- linux-2.6.orig/Documentation/DMA-mapping.txt	2003-08-09 22:12:26.000000000 +0200
+++ linux/Documentation/DMA-mapping.txt	2003-08-17 23:55:13.000000000 +0200
@@ -87,10 +87,7 @@
 PCI-X specification requires PCI-X devices to support 64-bit
 addressing (DAC) for all transactions. And at least one platform (SGI
 SN2) requires 64-bit consistent allocations to operate correctly when
-the IO bus is in PCI-X mode. Therefore, like with pci_set_dma_mask(),
-it's good practice to call pci_set_consistent_dma_mask() to set the
-appropriate mask even if your device only supports 32-bit DMA
-(default) and especially if it's a PCI-X device.
+the IO bus is in PCI-X mode.
 
 For correct operation, you must interrogate the PCI layer in your
 device probe routine to see if the PCI controller on the machine can
@@ -103,11 +100,6 @@
 
 	int pci_set_dma_mask(struct pci_dev *pdev, u64 device_mask);
 
-The query for consistent allocations is performed via a a call to
-pci_set_consistent_dma_mask():
-
-	int pci_set_consistent_dma_mask(struct pci_dev *pdev, u64 device_mask);
-
 Here, pdev is a pointer to the PCI device struct of your device, and
 device_mask is a bit mask describing which bits of a PCI address your
 device supports.  It returns zero if your card can perform DMA
@@ -161,30 +153,6 @@
 		goto ignore_this_device;
 	}
 
-If a card is capable of using 64-bit consistent allocations as well,
-the case would look like this:
-
-	int using_dac, consistent_using_dac;
-
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
-		using_dac = 1;
-	   	consistent_using_dac = 1;
-		pci_set_consistent_dma_mask(pdev, 0xffffffffffffffff)
-	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
-		using_dac = 0;
-		consistent_using_dac = 0;
-		pci_set_consistent_dma_mask(pdev, 0xffffffff)
-	} else {
-		printk(KERN_WARNING
-		       "mydev: No suitable DMA available.\n");
-		goto ignore_this_device;
-	}
-
-pci_set_consistent_dma_mask() will always be able to set the same or a
-smaller mask as pci_set_dma_mask(). However for the rare case that a
-device driver only uses consistent allocations, one would have to
-check the return value from pci_set_consistent_dma_mask().
-
 If your 64-bit device is going to be an enormous consumer of DMA
 mappings, this can be problematic since the DMA mappings are a
 finite resource on many platforms.  Please see the "DAC Addressing
@@ -255,8 +223,7 @@
 
   The current default is to return consistent memory in the low 32
   bits of the PCI bus space.  However, for future compatibility you
-  should set the consistent mask even if this default is fine for your
-  driver.
+  should set the mask even if this default is fine for your driver.
 
   Good examples of what to use consistent mappings for are:
 
@@ -326,15 +293,6 @@
 driver needs regions sized smaller than a page, you may prefer using
 the pci_pool interface, described below.
 
-The consistent DMA mapping interfaces, for non-NULL dev, will by
-default return a DMA address which is SAC (Single Address Cycle)
-addressable.  Even if the device indicates (via PCI dma mask) that it
-may address the upper 32-bits and thus perform DAC cycles, consistent
-allocation will only return > 32-bit PCI addresses for DMA if the
-consistent dma mask has been explicitly changed via
-pci_set_consistent_dma_mask().  This is true of the pci_pool interface
-as well.
-
 pci_alloc_consistent returns two values: the virtual address which you
 can use to access it from the CPU and dma_handle which you pass to the
 card.
diff -ur linux-2.6.orig/arch/ia64/sn/io/machvec/pci_dma.c linux/arch/ia64/sn/io/machvec/pci_dma.c
--- linux-2.6.orig/arch/ia64/sn/io/machvec/pci_dma.c	2003-07-11 21:30:44.000000000 +0200
+++ linux/arch/ia64/sn/io/machvec/pci_dma.c	2003-08-18 00:00:32.000000000 +0200
@@ -190,7 +190,7 @@
 	 * automatically allocated a 64Bits DMA Address.  Error out if the 
 	 * device cannot support DAC.
 	 */
-	if (*dma_handle > hwdev->consistent_dma_mask) {
+	if (*dma_handle > hwdev->dma_mask) {
 		free_pages((unsigned long) cpuaddr, get_order(size));
 		return NULL;
 	}
diff -ur linux-2.6.orig/arch/x86_64/kernel/pci-gart.c linux/arch/x86_64/kernel/pci-gart.c
--- linux-2.6.orig/arch/x86_64/kernel/pci-gart.c	2003-08-09 22:12:32.000000000 +0200
+++ linux/arch/x86_64/kernel/pci-gart.c	2003-08-18 00:01:03.000000000 +0200
@@ -142,7 +142,7 @@
 		gfp |= GFP_DMA; 
 		dma_mask = 0xffffffff; 
 	} else {
-		dma_mask = hwdev->consistent_dma_mask; 
+		dma_mask = hwdev->dma_mask; 
 	}
 	if (dma_mask == 0) 
 		dma_mask = 0xffffffff; 
diff -ur linux-2.6.orig/drivers/atm/lanai.c linux/drivers/atm/lanai.c
--- linux-2.6.orig/drivers/atm/lanai.c	2003-08-09 22:12:32.000000000 +0200
+++ linux/drivers/atm/lanai.c	2003-08-17 23:58:19.000000000 +0200
@@ -2039,11 +2039,6 @@
 		    "(itf %d): No suitable DMA available.\n", lanai->number);
 		return -EBUSY;
 	}
-	if (pci_set_consistent_dma_mask(pci, 0xFFFFFFFF) != 0) {
-		printk(KERN_WARNING DEV_LABEL
-		    "(itf %d): No suitable DMA available.\n", lanai->number);
-		return -EBUSY;
-	}
 	/* Get the pci revision byte */
 	result = pci_read_config_byte(pci, PCI_REVISION_ID,
 	    &lanai->pci_revision);
diff -ur linux-2.6.orig/drivers/net/tg3.c linux/drivers/net/tg3.c
--- linux-2.6.orig/drivers/net/tg3.c	2003-08-09 22:12:38.000000000 +0200
+++ linux/drivers/net/tg3.c	2003-08-17 23:57:53.000000000 +0200
@@ -6779,14 +6779,9 @@
 	}
 
 	/* Configure DMA attributes. */
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
+	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL))
 		pci_using_dac = 1;
-		if (pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL)) {
-			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
-			       "for consistent allocations\n");
-			goto err_out_free_res;
-		}
-	} else {
+	else {
 		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
 		if (err) {
 			printk(KERN_ERR PFX "No usable DMA configuration, "
diff -ur linux-2.6.orig/drivers/pci/pci.c linux/drivers/pci/pci.c
--- linux-2.6.orig/drivers/pci/pci.c	2003-08-09 22:12:40.000000000 +0200
+++ linux/drivers/pci/pci.c	2003-08-17 23:59:12.000000000 +0200
@@ -701,17 +701,6 @@
 	return 0;
 }
 
-int
-pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (!pci_dma_supported(dev, mask))
-		return -EIO;
-
-	dev->consistent_dma_mask = mask;
-
-	return 0;
-}
-     
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
@@ -763,7 +752,6 @@
 EXPORT_SYMBOL(pci_clear_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
-EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
 
diff -ur linux-2.6.orig/drivers/pci/probe.c linux/drivers/pci/probe.c
--- linux-2.6.orig/drivers/pci/probe.c	2003-08-09 22:12:40.000000000 +0200
+++ linux/drivers/pci/probe.c	2003-08-17 23:59:27.000000000 +0200
@@ -519,7 +519,6 @@
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
 	dev->dma_mask = 0xffffffff;
-	dev->consistent_dma_mask = 0xffffffff;
 	if (pci_setup_device(dev) < 0) {
 		kfree(dev);
 		return NULL;
diff -ur linux-2.6.orig/include/linux/pci.h linux/include/linux/pci.h
--- linux-2.6.orig/include/linux/pci.h	2003-08-09 22:12:47.000000000 +0200
+++ linux/include/linux/pci.h	2003-08-18 00:00:04.000000000 +0200
@@ -390,11 +390,6 @@
 					   or supports 64-bit transfers.  */
 	struct list_head pools;		/* pci_pools tied to this device */
 
-	u64		consistent_dma_mask;/* Like dma_mask, but for
-					       pci_alloc_consistent mappings as
-					       not all hardware supports
-					       64 bit addresses for consistent
-					       allocations such descriptors. */
 	u32             current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
@@ -621,7 +616,6 @@
 void pci_clear_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
-int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
 /* Power management related routines */

--=-=-=--
