Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUAPK7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUAPK7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:59:15 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:8848 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265371AbUAPK7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:59:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16391.50173.379099.96560@gargle.gargle.HOWL>
Date: Fri, 16 Jan 2004 05:59:09 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, jbarnes@sgi.com, jeremy@sgi.com
Subject: [patch] 2.6.1-mm4 sgiioc4.c cleanup weak symbol and error numbers
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The included patch removes the usage of weak symbols from sgiioc4.c now
that we have the Kconfig issue sorted as well as cleans up the error no
handling (instead of return 1 on error) and adds a check for the return
value on snia_pci_endian_set as suggested by Christoph.

Cheers,
Jes

--- orig/linux-2.6.1-mm4/drivers/ide/pci/sgiioc4.c	Sun Jan 11 07:00:35 2004
+++ linux-2.6.1-mm4/drivers/ide/pci/sgiioc4.c	Fri Jan 16 02:54:10 2004
@@ -23,7 +23,6 @@
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -686,7 +685,7 @@
 			"0x%p to 0x%p ALREADY in use\n",
 		       __FUNCTION__, hwif->name, (void *) base,
 		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
-		return 1;
+		return -ENOMEM;
 	}
 
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
@@ -726,20 +725,21 @@
 	PCIDMA_ENDIAN_BIG,
 	PCIDMA_ENDIAN_LITTLE
 } pciio_endian_t;
-pciio_endian_t __attribute__ ((weak)) snia_pciio_endian_set(struct pci_dev
-					    *pci_dev, pciio_endian_t device_end,
-					    pciio_endian_t desired_end);
+pciio_endian_t snia_pciio_endian_set(struct pci_dev
+				     *pci_dev, pciio_endian_t device_end,
+				     pciio_endian_t desired_end);
 
 static unsigned int __init
 pci_init_sgiioc4(struct pci_dev *dev, ide_pci_device_t * d)
 {
 	unsigned int class_rev;
+	pciio_endian_t endian_status;
 
 	if (pci_enable_device(dev)) {
 		printk(KERN_ERR
 		       "Failed to enable device %s at slot %s\n",
 		       d->name, dev->slot_name);
-		return 1;
+		return -ENODEV;
 	}
 	pci_set_master(dev);
 
@@ -751,18 +751,17 @@
 		printk(KERN_ERR "Skipping %s IDE controller in slot %s: "
 			"firmware is obsolete - please upgrade to revision"
 			"46 or higher\n", d->name, dev->slot_name);
-		return 1;
+		return -ENODEV;
 	}
 
 	/* Enable Byte Swapping in the PIC... */
-	if (snia_pciio_endian_set) {
-		snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
-				      PCIDMA_ENDIAN_BIG);
-	} else {
+	endian_status = snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
+					      PCIDMA_ENDIAN_BIG);
+	if (endian_status != PCIDMA_ENDIAN_BIG) {
 		printk(KERN_ERR
 		       "Failed to set endianness for device %s at slot %s\n",
 		       d->name, dev->slot_name);
-		return 1;
+		return -ENODEV;
 	}
 
 	return sgiioc4_ide_setup_pci_device(dev, d);
