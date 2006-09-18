Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWIRWr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWIRWr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWIRWr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:47:57 -0400
Received: from av2.karneval.cz ([81.27.192.122]:18459 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030210AbWIRWrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:47:49 -0400
Message-id: <91292449121291221@karneval.cz>
Subject: [PATCH 4/4] pmc551 pci cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Mark Ferrell <mferrell@mvista.com>
Cc: <linux-mtd@lists.infradead.org>
Date: Tue, 19 Sep 2006 00:47:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmc551 pci cleanup

use pci_get_device -- refcounting, release it by pci_dev_put. Use
pci_resource_start for getting start of regions.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 6fe18c54c93d38eec34ca0776da60fc355968f6b
tree 5bf3cf8fe213de770c7c7a1279eafb3937f4c386
parent 912ff3e53f760cb166988fcd46fc173f8e4c22e7
author Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 00:39:08 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 00:39:08 +0200

 drivers/mtd/devices/pmc551.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 5f5de9c..d1ba4b9 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -563,7 +563,7 @@ #ifdef CONFIG_MTD_PMC551_DEBUG
 		size >> 10 : size >> 20,
 		(size < 1024) ? 'B' : (size < 1048576) ? 'K' : 'M', size,
 		((dcmd & (0x1 << 3)) == 0) ? "non-" : "",
-		(unsigned long long)((dev->resource[0].start) &
+		(unsigned long long)(pci_resource_start(dev, 0) &
 				    PCI_BASE_ADDRESS_MEM_MASK));
 
 	/*
@@ -693,13 +693,13 @@ static int __init init_pmc551(void)
 	 */
 	for (count = 0; count < MAX_MTD_DEVICES; count++) {
 
-		if ((PCI_Device = pci_find_device(PCI_VENDOR_ID_V3_SEMI,
-						  PCI_DEVICE_ID_V3_SEMI_V370PDC,
-						  PCI_Device)) == NULL)
+		if ((PCI_Device = pci_get_device(PCI_VENDOR_ID_V3_SEMI,
+				PCI_DEVICE_ID_V3_SEMI_V370PDC,
+				PCI_Device)) == NULL)
 			break;
 
 		printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%llx\n",
-			(unsigned long long)PCI_Device->resource[0].start);
+			(unsigned long long)pci_resource_start(PCI_Device, 0));
 
 		/*
 		 * The PMC551 device acts VERY weird if you don't init it
@@ -711,6 +711,7 @@ static int __init init_pmc551(void)
 		 */
 		if ((length = fixup_pmc551(PCI_Device)) <= 0) {
 			printk(KERN_NOTICE "pmc551: Cannot init SDRAM\n");
+			pci_dev_put(PCI_Device);
 			break;
 		}
 
@@ -729,6 +730,7 @@ static int __init init_pmc551(void)
 		if (!mtd) {
 			printk(KERN_NOTICE "pmc551: Cannot allocate new MTD "
 				"device.\n");
+			pci_dev_put(PCI_Device);
 			break;
 		}
 
@@ -737,6 +739,7 @@ static int __init init_pmc551(void)
 			printk(KERN_NOTICE "pmc551: Cannot allocate new MTD "
 				"device.\n");
 			kfree(mtd);
+			pci_dev_put(PCI_Device);
 			break;
 		}
 		mtd->priv = priv;
@@ -755,14 +758,14 @@ static int __init init_pmc551(void)
 				"size %dM\n", asize >> 20);
 			priv->asize = asize;
 		}
-		priv->start = ioremap(((PCI_Device->resource[0].start)
-					& PCI_BASE_ADDRESS_MEM_MASK),
-				      priv->asize);
+		priv->start = ioremap(pci_resource_start(PCI_Device, 0) &
+				PCI_BASE_ADDRESS_MEM_MASK, priv->asize);
 
 		if (!priv->start) {
 			printk(KERN_NOTICE "pmc551: Unable to map IO space\n");
 			kfree(mtd->priv);
 			kfree(mtd);
+			pci_dev_put(PCI_Device);
 			break;
 		}
 #ifdef CONFIG_MTD_PMC551_DEBUG
@@ -801,6 +804,7 @@ #endif
 			iounmap(priv->start);
 			kfree(mtd->priv);
 			kfree(mtd);
+			pci_dev_put(PCI_Device);
 			break;
 		}
 		printk(KERN_NOTICE "Registered pmc551 memory device.\n");
@@ -844,6 +848,7 @@ static void __exit cleanup_pmc551(void)
 			iounmap(priv->start);
 		}
 
+		pci_dev_put(priv->dev);
 		kfree(mtd->priv);
 		del_mtd_device(mtd);
 		kfree(mtd);
