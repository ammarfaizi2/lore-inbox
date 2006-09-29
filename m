Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161717AbWI2RJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161717AbWI2RJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161557AbWI2RJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:09:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44948 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161772AbWI2RIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:08:45 -0400
Subject: [PATCH] IDE: more pci_find cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 18:33:45 +0100
Message-Id: <1159551225.13029.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ide/pci/cs5530.c linux-2.6.18-mm2/drivers/ide/pci/cs5530.c
--- linux.vanilla-2.6.18-mm2/drivers/ide/pci/cs5530.c	2006-09-20 04:42:06.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ide/pci/cs5530.c	2006-09-25 12:19:18.000000000 +0100
@@ -222,23 +222,23 @@
 	unsigned long flags;
 
 	dev = NULL;
-	while ((dev = pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_ANY_ID, dev)) != NULL) {
 		switch (dev->device) {
 			case PCI_DEVICE_ID_CYRIX_PCI_MASTER:
-				master_0 = dev;
+				master_0 = pci_dev_get(dev);
 				break;
 			case PCI_DEVICE_ID_CYRIX_5530_LEGACY:
-				cs5530_0 = dev;
+				cs5530_0 = pci_dev_get(dev);
 				break;
 		}
 	}
 	if (!master_0) {
 		printk(KERN_ERR "%s: unable to locate PCI MASTER function\n", name);
-		return 0;
+		goto out;
 	}
 	if (!cs5530_0) {
 		printk(KERN_ERR "%s: unable to locate CS5530 LEGACY function\n", name);
-		return 0;
+		goto out;
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
@@ -296,6 +296,9 @@
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 
+out:
+	pci_dev_put(master_0);
+	pci_dev_put(cs5530_0);
 	return 0;
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ide/pci/cy82c693.c linux-2.6.18-mm2/drivers/ide/pci/cy82c693.c
--- linux.vanilla-2.6.18-mm2/drivers/ide/pci/cy82c693.c	2006-09-20 04:42:06.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ide/pci/cy82c693.c	2006-09-25 12:19:18.000000000 +0100
@@ -281,7 +281,7 @@
 
 	/* select primary or secondary channel */
 	if (hwif->index > 0) {  /* drive is on the secondary channel */
-		dev = pci_find_slot(dev->bus->number, dev->devfn+1);
+		dev = pci_get_slot(dev->bus, dev->devfn+1);
 		if (!dev) {
 			printk(KERN_ERR "%s: tune_drive: "
 				"Cannot find secondary interface!\n",
@@ -500,8 +500,9 @@
 	   Function 1 is primary IDE channel, function 2 - secondary. */
         if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE &&
 	    PCI_FUNC(dev->devfn) == 1) {
-		dev2 = pci_find_slot(dev->bus->number, dev->devfn + 1);
+		dev2 = pci_get_slot(dev->bus, dev->devfn + 1);
 		ret = ide_setup_pci_devices(dev, dev2, d);
+		/* We leak pci refs here but thats ok - we can't be unloaded */
 	}
 	return ret;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ide/pci/via82cxxx.c linux-2.6.18-mm2/drivers/ide/pci/via82cxxx.c
--- linux.vanilla-2.6.18-mm2/drivers/ide/pci/via82cxxx.c	2006-09-20 04:42:06.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ide/pci/via82cxxx.c	2006-09-25 12:20:06.000000000 +0100
@@ -248,7 +248,7 @@
 	u8 t;
 
 	for (via_config = via_isa_bridges; via_config->id; via_config++)
-		if ((*isa = pci_find_device(PCI_VENDOR_ID_VIA +
+		if ((*isa = pci_get_device(PCI_VENDOR_ID_VIA +
 			!!(via_config->flags & VIA_BAD_ID),
 			via_config->id, NULL))) {
 
@@ -256,6 +256,7 @@
 			if (t >= via_config->rev_min &&
 			    t <= via_config->rev_max)
 				break;
+			pci_dev_put(*isa);
 		}
 
 	return via_config;
@@ -283,6 +284,7 @@
 	via_config = via_config_find(&isa);
 	if (!via_config->id) {
 		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, disabling DMA.\n");
+		pci_dev_put(isa);
 		return -ENODEV;
 	}
 
@@ -361,6 +363,7 @@
 		via_dma[via_config->flags & VIA_UDMA],
 		pci_name(dev));
 
+	pci_dev_put(isa);
 	return 0;
 }
 

