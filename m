Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271166AbUJVB5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271166AbUJVB5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271160AbUJVByQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:54:16 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:903 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S271119AbUJVBuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:50:05 -0400
Message-ID: <4178674C.60903@rtr.ca>
Date: Thu, 21 Oct 2004 21:50:04 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.9-ac3] delkin_cb: new driver for Cardbus IDE CF Adapter
References: <1098400086.18025.0.camel@localhost.localdomain>
In-Reply-To: <1098400086.18025.0.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------080902030102050701010504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080902030102050701010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is the first 2.6 release of a PCI-IDE module to support
the Delkin/ASKA/Workbit Cardbus CompactFlash<-->IDE adaptor.
It may (or not) also work for other versions of this hardware (eg. SD).

This module is based on the existing ide-cs module,
and works fine for me (with other fixes previously posted for -ac3).

Patch is against 2.6.9-ac3.

Signed-off-by: Mark Lord <lkml@rtr.ca>
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

--------------080902030102050701010504
Content-Type: text/plain;
 name="delkin_cb-2.6.9-ac3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delkin_cb-2.6.9-ac3.patch"

diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/drivers/ide/Kconfig linux/drivers/ide/Kconfig
--- linux-2.6.9-ac3/drivers/ide/Kconfig	2004-10-21 20:45:22.000000000 -0400
+++ linux/drivers/ide/Kconfig	2004-10-21 20:25:05.000000000 -0400
@@ -166,6 +166,13 @@
 	  Support for outboard IDE disks, tape drives, and CD-ROM drives
 	  connected through a  PCMCIA card.
 
+config BLK_DEV_DELKIN
+	tristate "Cardbus IDE support (Delkin/ASKA/Workbit)"
+	depends on PCMCIA && PCI
+	help
+	  Support for Delkin, ASKA, and Workbit Cardbus CompactFlash
+	  Adapters.  This may also work for similar SD and XD adapters.
+
 config BLK_DEV_IDECD
 	tristate "Include IDE/ATAPI CDROM support"
 	---help---
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/drivers/ide/pci/delkin_cb.c linux/drivers/ide/pci/delkin_cb.c
--- linux-2.6.9-ac3/drivers/ide/pci/delkin_cb.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/drivers/ide/pci/delkin_cb.c	2004-10-21 21:44:45.000000000 -0400
@@ -0,0 +1,139 @@
+/*
+ *  linux/drivers/ide/pci/delkin_cb.c
+ *
+ *  Created 20 Oct 2004 by Mark Lord
+ *
+ *  Basic support for Delkin/ASKA/Workbit Cardbus CompactFlash adapter
+ *
+ *  Modeled after the 16-bit PCMCIA driver: ide-cs.c
+ *
+ *  This is slightly peculiar, in that it is a PCI driver,
+ *  but is NOT an IDE PCI driver -- the IDE layer does not directly
+ *  support hot insertion/removal of PCI interfaces, so this driver
+ *  is unable to use the IDE PCI interfaces.  Instead, it uses the
+ *  same interfaces as the ide-cs (PCMCIA) driver uses.
+ *  On the plus side, the driver is also smaller/simpler this way.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+/*
+ * No chip documentation has yet been found,
+ * so these configuration values were pulled from
+ * a running Win98 system using "debug".
+ * This gives around 3MByte/second read performance,
+ * which is about 2/3 of what the chip is capable of.
+ *
+ * There is also a 4KByte mmio region on the card,
+ * but its purpose has yet to be reverse-engineered.
+ */
+static const u8 setup[] = {
+	0x00, 0x05, 0xbe, 0x01, 0x20, 0x8f, 0x00, 0x00,
+	0xa4, 0x1f, 0xb3, 0x1b, 0x00, 0x00, 0x00, 0x80,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xa4, 0x83, 0x02, 0x13,
+};
+
+static int __devinit
+delkin_cb_probe (struct pci_dev *dev, const struct pci_device_id *id)
+{
+	unsigned long base;
+	hw_regs_t hw;
+	ide_hwif_t *hwif = NULL;
+	ide_drive_t *drive;
+	int i, rc;
+
+	rc = pci_enable_device(dev);
+	if (rc) {
+		printk(KERN_ERR "delkin_cb: pci_enable_device failed (%d)\n", rc);
+		return rc;
+	}
+	rc = pci_request_regions(dev, "delkin_cb");
+	if (rc) {
+		printk(KERN_ERR "delkin_cb: pci_request_regions failed (%d)\n", rc);
+		pci_disable_device(dev);
+		return rc;
+	}
+	base = pci_resource_start(dev, 0);
+	outb(0x02, base + 0x1e);	/* set nIEN to block interrupts */
+	inb(base + 0x17);		/* read status to clear interrupts */
+	for (i = 0; i < sizeof(setup); ++i) {
+		if (setup[i])
+			outb(setup[i], base + i);
+	}
+	pci_release_regions(dev);	/* IDE layer handles regions itself */
+
+	memset(&hw, 0, sizeof(hw));
+	ide_std_init_ports(&hw, base + 0x10, base + 0x1e);
+	hw.irq = dev->irq;
+	hw.chipset = ide_pci;		/* this enables IRQ sharing */
+
+	rc = ide_register_hw(&hw, &hwif);
+	if (rc < 0) {
+		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
+		return -ENODEV;
+	}
+	pci_set_drvdata(dev, hwif);
+	hwif->pci_dev = dev;
+	drive = &hwif->drives[0];
+	if (drive->present) {
+		drive->io_32bit = 1;
+		drive->unmask   = 1;
+	}
+	return 0;
+}
+
+static void
+delkin_cb_remove (struct pci_dev *dev)
+{
+	ide_hwif_t *hwif = pci_get_drvdata(dev);
+
+	if (hwif)
+		ide_unregister_hwif(hwif);
+	pci_disable_device(dev);
+}
+
+static struct pci_device_id delkin_cb_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_WORKBIT, PCI_DEVICE_ID_WORKBIT_CB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, delkin_cb_pci_tbl);
+
+static struct pci_driver driver = {
+	.name		= "Delkin/ASKA/Workbit Cardbus IDE",
+	.id_table	= delkin_cb_pci_tbl,
+	.probe		= delkin_cb_probe,
+	.remove		= delkin_cb_remove,
+};
+
+static int
+delkin_cb_init (void)
+{
+	return pci_module_init(&driver);
+}
+
+static void
+delkin_cb_exit (void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(delkin_cb_init);
+module_exit(delkin_cb_exit);
+
+MODULE_AUTHOR("Mark Lord");
+MODULE_DESCRIPTION("Basic support for Delkin/ASKA/Workbit Cardbus IDE");
+MODULE_LICENSE("GPL");
+
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/drivers/ide/pci/Makefile linux/drivers/ide/pci/Makefile
--- linux-2.6.9-ac3/drivers/ide/pci/Makefile	2004-10-18 17:53:42.000000000 -0400
+++ linux/drivers/ide/pci/Makefile	2004-10-21 19:32:57.000000000 -0400
@@ -9,6 +9,7 @@
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
+obj-$(CONFIG_BLK_DEV_DELKIN)		+= delkin_cb.o
 obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 #obj-$(CONFIG_BLK_DEV_HPT37X)		+= hpt37x.o
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/drivers/scsi/nsp32.h linux/drivers/scsi/nsp32.h
--- linux-2.6.9-ac3/drivers/scsi/nsp32.h	2004-10-18 17:53:05.000000000 -0400
+++ linux/drivers/scsi/nsp32.h	2004-10-21 19:32:57.000000000 -0400
@@ -22,7 +22,6 @@
  * VENDOR/DEVICE ID
  */
 #define PCI_VENDOR_ID_IODATA  0x10fc
-#define PCI_VENDOR_ID_WORKBIT 0x1145
 
 #define PCI_DEVICE_ID_NINJASCSI_32BI_CBSC_II   0x0005
 #define PCI_DEVICE_ID_NINJASCSI_32BI_KME       0xf007
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.6.9-ac3/include/linux/pci_ids.h	2004-10-21 20:45:22.000000000 -0400
+++ linux/include/linux/pci_ids.h	2004-10-21 20:25:05.000000000 -0400
@@ -2331,3 +2331,6 @@
 #define PCI_DEVICE_ID_ARK_STING		0xa091
 #define PCI_DEVICE_ID_ARK_STINGARK	0xa099
 #define PCI_DEVICE_ID_ARK_2000MT	0xa0a1
+
+#define PCI_VENDOR_ID_WORKBIT		0x1145
+#define PCI_DEVICE_ID_WORKBIT_CB	0xf021

--------------080902030102050701010504--
