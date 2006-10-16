Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWJPPFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWJPPFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWJPPFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:05:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45217 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932111AbWJPPFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:05:54 -0400
Subject: [PATCH] esb2rom: use hotplug safe interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:32:32 +0100
Message-Id: <1161012752.24237.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly self explanatory. Keep a reference initially, drop it when we
free up the driver resources.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/mtd/maps/esb2rom.c linux-2.6.19-rc1-mm1/drivers/mtd/maps/esb2rom.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/mtd/maps/esb2rom.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/mtd/maps/esb2rom.c	2006-10-14 21:32:12.000000000 +0100
@@ -140,8 +140,8 @@
 		window->virt = NULL;
 		window->phys = 0;
 		window->size = 0;
-		window->pdev = NULL;
 	}
+	pci_dev_put(window->pdev);
 }
 
 static int __devinit esb2rom_init_one(struct pci_dev *pdev,
@@ -164,7 +164,7 @@
 	 * Also you can page firmware hubs if an 8MB window isn't enough
 	 * but don't currently handle that case either.
 	 */
-	window->pdev = pdev;
+	window->pdev = pci_dev_get(pdev);
 
 	/* RLG:  experiment 2.  Force the window registers to the widest values */
 
@@ -418,7 +418,7 @@
 	pdev = NULL;
 	for (id = esb2rom_pci_tbl; id->vendor; id++) {
 		printk(KERN_DEBUG "device id = %x\n", id->device);
-		pdev = pci_find_device(id->vendor, id->device, NULL);
+		pdev = pci_get_device(id->vendor, id->device, NULL);
 		if (pdev) {
 			printk(KERN_DEBUG "matched device = %x\n", id->device);
 			break;
@@ -427,6 +427,7 @@
 	if (pdev) {
 		printk(KERN_DEBUG "matched device id %x\n", id->device);
 		retVal = esb2rom_init_one(pdev, &esb2rom_pci_tbl[0]);
+		pci_dev_put(pdev);
 		printk(KERN_DEBUG "retVal = %d\n", retVal);
 		return retVal;
 	}

