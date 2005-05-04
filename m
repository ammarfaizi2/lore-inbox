Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVEDHIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVEDHIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVEDHHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:07:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:6117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262053AbVEDHCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:25 -0400
Cc: bunk@stusta.de
Subject: [PATCH] PCI: drivers/pci/pci.c: remove pci_dac_set_dma_mask
In-Reply-To: <1115190139219@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:19 -0700
Message-Id: <11151901392923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: drivers/pci/pci.c: remove pci_dac_set_dma_mask

pci_dac_set_dma_mask is currently completely unused.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9171078ab5a0bbb516029cfc61378e0350a7b30d
tree c0748641f2574f1621bb1f78d14c70c49805e4dd
parent b308240b49ff5a1bddc6e10513c2c83f37a0bc78
author Adrian Bunk <bunk@stusta.de> 1114955588 +0200
committer Greg KH <gregkh@suse.de> 1115189117 -0700

Index: arch/arm/mach-ixp4xx/common-pci.c
===================================================================
--- 7fda5a4f25632d19ae03589bee0d920efe8026c3/arch/arm/mach-ixp4xx/common-pci.c  (mode:100644 sha1:94bcdb933e41f1f0065b12154f9d1a5f3f7c7e36)
+++ c0748641f2574f1621bb1f78d14c70c49805e4dd/arch/arm/mach-ixp4xx/common-pci.c  (mode:100644 sha1:aa92e3708838ed31fadbead7b073cfc7a3894578)
@@ -502,15 +502,6 @@
 }
     
 int
-pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (mask >= SZ_64M - 1 )
-		return 0;
-
-	return -EIO;
-}
-
-int
 pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	if (mask >= SZ_64M - 1 )
@@ -520,7 +511,6 @@
 }
 
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
Index: drivers/pci/pci.c
===================================================================
--- 7fda5a4f25632d19ae03589bee0d920efe8026c3/drivers/pci/pci.c  (mode:100644 sha1:88cbe5b5b3f3f60fbee7915ba3339d2f2f4dc5cf)
+++ c0748641f2574f1621bb1f78d14c70c49805e4dd/drivers/pci/pci.c  (mode:100644 sha1:f04b9ffe41539a1a2a1acafa6ea5d16b15fbd64b)
@@ -749,17 +749,6 @@
 }
     
 int
-pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (!pci_dac_dma_supported(dev, mask))
-		return -EIO;
-
-	dev->dma_mask = mask;
-
-	return 0;
-}
-
-int
 pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	if (!pci_dma_supported(dev, mask))
@@ -821,7 +810,6 @@
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
Index: include/linux/pci.h
===================================================================
--- 7fda5a4f25632d19ae03589bee0d920efe8026c3/include/linux/pci.h  (mode:100644 sha1:cff5ba3ac8ce816c8261dd588be17f488de89507)
+++ c0748641f2574f1621bb1f78d14c70c49805e4dd/include/linux/pci.h  (mode:100644 sha1:b5238bd188302be2bf941a11594a61814c40120f)
@@ -811,7 +811,6 @@
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
-int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
@@ -942,7 +941,6 @@
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
-static inline int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }

