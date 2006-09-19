Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752032AbWISTzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWISTzt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWISTzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:55:49 -0400
Received: from av1.karneval.cz ([81.27.192.123]:5678 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1752032AbWISTzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:55:31 -0400
Message-id: <91292new449121291221@karneval.cz>
Subject: [PATCH 3/3] pmc551 pci cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Mark Ferrell <mferrell@mvista.com>
Cc: <linux-mtd@lists.infradead.org>
Date: Tue, 19 Sep 2006 21:55:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmc551 pci cleanup

Use pci_resource_start for getting start of regions and pci_iomap to not
doing this directly by using dev->resource... (Thanks to Rolf Eike Beer)

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f168fc8e075580212def9c838b21824faf516cf4
tree 41bdcab4eb268c8022d6eb370aed06688a599d5e
parent eb0edd8068cde9b5e6afaf09065a94cb83c10efd
author Jiri Slaby <jirislaby@gmail.com> Tue, 19 Sep 2006 21:48:40 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 21:48:40 +0200

 drivers/mtd/devices/pmc551.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 62a9188..354e165 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -568,8 +568,7 @@ #ifdef CONFIG_MTD_PMC551_DEBUG
 		size >> 10 : size >> 20,
 		(size < 1024) ? 'B' : (size < 1048576) ? 'K' : 'M', size,
 		((dcmd & (0x1 << 3)) == 0) ? "non-" : "",
-		(unsigned long long)((dev->resource[0].start) &
-				    PCI_BASE_ADDRESS_MEM_MASK));
+		(unsigned long long)pci_resource_start(dev, 0));
 
 	/*
 	 * Check to see the state of the memory
@@ -705,7 +704,7 @@ static int __init init_pmc551(void)
 		}
 
 		printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%llx\n",
-			(unsigned long long)PCI_Device->resource[0].start);
+			(unsigned long long)pci_resource_start(PCI_Device, 0));
 
 		/*
 		 * The PMC551 device acts VERY weird if you don't init it
@@ -762,9 +761,7 @@ static int __init init_pmc551(void)
 				"size %dM\n", asize >> 20);
 			priv->asize = asize;
 		}
-		priv->start = ioremap(((PCI_Device->resource[0].start)
-					& PCI_BASE_ADDRESS_MEM_MASK),
-				      priv->asize);
+		priv->start = pci_iomap(PCI_Device, 0, priv->asize);
 
 		if (!priv->start) {
 			printk(KERN_NOTICE "pmc551: Unable to map IO space\n");
@@ -805,7 +802,7 @@ #endif
 		if (add_mtd_device(mtd)) {
 			printk(KERN_NOTICE "pmc551: Failed to register new "
 				"device\n");
-			iounmap(priv->start);
+			pci_iounmap(PCI_Device, priv->start);
 			kfree(mtd->priv);
 			kfree(mtd);
 			break;
@@ -856,7 +853,7 @@ static void __exit cleanup_pmc551(void)
 		if (priv->start) {
 			printk(KERN_DEBUG "pmc551: unmapping %dM starting at "
 				"0x%p\n", priv->asize >> 20, priv->start);
-			iounmap(priv->start);
+			pci_iounmap(priv->dev, priv->start);
 		}
 		pci_dev_put(priv->dev);
 
