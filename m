Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTDGXET (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTDGXCd (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:02:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50048
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263791AbTDGW4q (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:56:46 -0400
Date: Tue, 8 Apr 2003 01:15:38 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080015.h380Fc34009018@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: clean up pci interrupt line whacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/hpt366.c linux-2.5.67-ac1/drivers/ide/pci/hpt366.c
--- linux-2.5.67/drivers/ide/pci/hpt366.c	2003-03-26 19:59:51.000000000 +0000
+++ linux-2.5.67-ac1/drivers/ide/pci/hpt366.c	2003-04-06 23:03:51.000000000 +0100
@@ -1106,13 +1106,10 @@
 		    ((findev->devfn - dev->devfn) == 1) &&
 		    (PCI_FUNC(findev->devfn) & 1)) {
 			u8 irq = 0, irq2 = 0;
-			pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-			pci_read_config_byte(findev, PCI_INTERRUPT_LINE, &irq2);
-			if (irq != irq2) {
-				pci_write_config_byte(findev,
-						PCI_INTERRUPT_LINE, irq);
+			if (findev->irq != dev->irq) {
+				/* FIXME: we need a core pci_set_interrupt() */
 				findev->irq = dev->irq;
-				printk("%s: pci-config space interrupt "
+				printk(KERN_WARNING "%s: pci-config space interrupt "
 					"fixed.\n", d->name);
 			}
 			ide_setup_pci_devices(dev, findev, d);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/pdc202xx_new.c linux-2.5.67-ac1/drivers/ide/pci/pdc202xx_new.c
--- linux-2.5.67/drivers/ide/pci/pdc202xx_new.c	2003-03-26 19:59:51.000000000 +0000
+++ linux-2.5.67-ac1/drivers/ide/pci/pdc202xx_new.c	2003-04-06 23:04:50.000000000 +0100
@@ -592,15 +592,8 @@
 			if ((findev->vendor == dev->vendor) &&
 			    (findev->device == dev->device) &&
 			    (PCI_SLOT(findev->devfn) & 2)) {
-				u8 irq = 0, irq2 = 0;
-				pci_read_config_byte(dev,
-					PCI_INTERRUPT_LINE, &irq);
-				pci_read_config_byte(findev,
-					PCI_INTERRUPT_LINE, &irq2);
-				if (irq != irq2) {
+				if (findev->irq != dev->irq) {
 					findev->irq = dev->irq;
-					pci_write_config_byte(findev,
-						PCI_INTERRUPT_LINE, irq);
 				}
 				ide_setup_pci_devices(dev, findev, d);
 				return;
