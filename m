Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130236AbRB1PiC>; Wed, 28 Feb 2001 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130237AbRB1Phs>; Wed, 28 Feb 2001 10:37:48 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:49414 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130236AbRB1Ph2>;
	Wed, 28 Feb 2001 10:37:28 -0500
Date: Wed, 28 Feb 2001 10:37:27 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] pci_dma_set_mask()
Message-ID: <20010228103727.I23735@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch really has two parts.  Most of it adds a helper function that
does the 

	if(pci_dma_supported()) { ->dma_mask = mask }

code path.  I was using the api today and didn't realize that I had to
set the mask myself, I assumed the _supported call would do it.   If
people prefer the struct setting api, thats fine with me :)  

It also seems goofy that pci_dma_supported() unconditionally return true
on x86.  If a device needs a mask smaller than GFP_DMA (admitedly probably
won't exist in the real world, one hopes), they're going to have troubles
because x86 just falls back to GFP_DMA when the mask isn't 0xffffffff..

all totally untested, of course..

-- 
 zach

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
+++ linux-2.4.2/drivers/pci/pci.c	Wed Feb 28 10:27:34 2001
@@ -518,6 +518,18 @@
 	pcibios_set_master(dev);
 }
 
+int
+pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask)
+{
+    if(! pci_dma_supported(dev, mask))
+        return 0;
+
+    dev->dma_mask = mask;
+
+    return 1;
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

