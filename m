Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130141AbRCBAcR>; Thu, 1 Mar 2001 19:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130176AbRCBAb5>; Thu, 1 Mar 2001 19:31:57 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:39182 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130141AbRCBAby>;
	Thu, 1 Mar 2001 19:31:54 -0500
Date: Thu, 1 Mar 2001 19:31:53 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] pci_set_dma_mask() + doc :)
Message-ID: <20010301193153.A377@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please feel free to flame or apply, I'm not sure I'm really fond of the
code example..

- z

--- linux-2.4.2/include/linux/pci.h.dmasup	Wed Feb 28 10:26:14 2001
+++ linux-2.4.2/include/linux/pci.h	Wed Feb 28 10:30:12 2001
@@ -527,6 +527,7 @@
 
 int pci_enable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
+int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask);
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
--- linux-2.4.2/include/asm-i386/pci.h.dmasup	Wed Feb 28 10:19:01 2001
+++ linux-2.4.2/include/asm-i386/pci.h	Wed Feb 28 10:25:40 2001
@@ -152,6 +152,14 @@
  */
 extern inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
 {
+        /*
+         * we fall back to GFP_DMA when the mask isn't all 1s,
+         * so we can't guarantee allocations that must be
+         * within a tighter range than GFP_DMA..
+         */
+        if(mask < 0x00ffffff)
+                return 0;
+
 	return 1;
 }
 
--- linux-2.4.2/drivers/pci/pci.c.dmasup	Wed Feb 28 10:26:34 2001
+++ linux-2.4.2/drivers/pci/pci.c	Thu Mar  1 19:04:35 2001
@@ -518,6 +518,18 @@
 	pcibios_set_master(dev);
 }
 
+int
+pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask)
+{
+    if(! pci_dma_supported(dev, mask))
+        return -EIO;
+
+    dev->dma_mask = mask;
+
+    return 0;
+}
+    
+
 /*
  * Translate the low bits of the PCI base
  * to the resource type
@@ -1206,6 +1218,7 @@
 EXPORT_SYMBOL(pci_find_slot);
 EXPORT_SYMBOL(pci_find_subsys);
 EXPORT_SYMBOL(pci_set_master);
+EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_register_driver);
--- linux-2.4.2/Documentation/DMA-mapping.txt.dmasup	Wed Feb 28 23:03:04 2001
+++ linux-2.4.2/Documentation/DMA-mapping.txt	Thu Mar  1 19:29:38 2001
@@ -71,12 +71,35 @@
 	if (! pci_dma_supported(pdev, 0x00ffffff))
 		goto ignore_this_device;
 
+When DMA is possible for a given mask, the PCI layer must be informed of the
+mask for later allocation operations on the device.  This is achieved by
+setting the dma_mask member of the pci_dev structure, like so:
+
+#define MY_HW_DMA_MASK 0x00ffffff
+
+	if (! pci_dma_supported(pdev, MY_HW_DMA_MASK))
+		goto ignore_this_device;
+
+	pdev->dma_mask = MY_HW_DMA_MASK;
+
+A helper function is provided which performs this common code sequence:
+
+	int pci_set_dma_mask(struct pci_dev *pdev, dma_addr_t device_mask)
+
+Unlike pci_dma_supported(), this returns -EIO when the PCI layer will not be
+able to DMA with addresses restricted by that mask, and returns 0 when DMA
+transfers are possible.  If the call succeeds, the dma_mask will have been
+updated so that your driver need not worry about it.
+
 There is a case which we are aware of at this time, which is worth
 mentioning in this documentation.  If your device supports multiple
 functions (for example a sound card provides playback and record
 functions) and the various different functions have _different_
 DMA addressing limitations, you may wish to probe each mask and
-only provide the functionality which the machine can handle.
+only provide the functionality which the machine can handle.  It
+is important that the last call to pci_set_dma_mask() be for the 
+most specific mask.
+
 Here is pseudo-code showing how this might be done:
 
 	#define PLAYBACK_ADDRESS_BITS	0xffffffff
@@ -86,14 +109,14 @@
 	struct pci_dev *pdev;
 
 	...
-	if (pci_dma_supported(pdev, PLAYBACK_ADDRESS_BITS)) {
+	if (pci_set_dma_mask(pdev, PLAYBACK_ADDRESS_BITS)) {
 		card->playback_enabled = 1;
 	} else {
 		card->playback_enabled = 0;
 		printk(KERN_WARN "%s: Playback disabled due to DMA limitations.\n",
 		       card->name);
 	}
-	if (pci_dma_supported(pdev, RECORD_ADDRESS_BITS)) {
+	if (pci_set_dma_mask(pdev, RECORD_ADDRESS_BITS)) {
 		card->record_enabled = 1;
 	} else {
 		card->record_enabled = 0;
