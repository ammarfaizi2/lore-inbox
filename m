Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270814AbUJUSwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270814AbUJUSwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270819AbUJUStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:49:39 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:32390 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270812AbUJUSqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:46:31 -0400
Message-ID: <41780393.3000606@rtr.ca>
Date: Thu, 21 Oct 2004 14:44:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4.28-pre4-bk6] delkin_cb:  new driver for Cardbus IDE CF
 adaptor
Content-Type: multipart/mixed;
 boundary="------------070500030806070904060109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070500030806070904060109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is the first release of a PCI-IDE module to support
the Delkin/ASKA/Workbit Cardbus CompactFlash<-->IDE adaptor.
It may (or not) also work for other versions of this hardware (eg. SD).

This module is based on the existing ide-cs module,
and works fine for me.

Patch is against 2.4.28-pre5-bk6, and it would be good if possible
to include this in the next issue of 2.4.xx (Marcelo?).

An equivalent patch for 2.6.xx is being worked on.

Signed-off-by: Mark Lord <lkml@rtr.ca>
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

--------------070500030806070904060109
Content-Type: text/plain;
 name="delkin_cb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delkin_cb.patch"

diff -u --recursive --new-file --exclude='.*' linux-2.4.28-pre4-bk6/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.4.28-pre4-bk6/drivers/ide/Config.in	2004-10-21 11:02:18.000000000 -0400
+++ linux/drivers/ide/Config.in	2004-10-21 11:46:05.000000000 -0400
@@ -18,6 +18,7 @@
    dep_mbool '    Auto-Geometry Resizing support' CONFIG_IDEDISK_STROKE $CONFIG_BLK_DEV_IDEDISK
 
    dep_tristate '  PCMCIA IDE support' CONFIG_BLK_DEV_IDECS $CONFIG_BLK_DEV_IDE $CONFIG_PCMCIA
+   dep_tristate '  Cardbus IDE support (Delkin/ASKA/Workbit)' CONFIG_BLK_DEV_DELKIN $CONFIG_BLK_DEV_IDE $CONFIG_PCMCIA $CONFIG_PCI
    dep_tristate '  Include IDE/ATAPI CDROM support' CONFIG_BLK_DEV_IDECD $CONFIG_BLK_DEV_IDE
    dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
    dep_tristate '  Include IDE/ATAPI FLOPPY support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_BLK_DEV_IDE
diff -u --recursive --new-file --exclude='.*' linux-2.4.28-pre4-bk6/drivers/ide/pci/delkin_cb.c linux/drivers/ide/pci/delkin_cb.c
--- linux-2.4.28-pre4-bk6/drivers/ide/pci/delkin_cb.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/drivers/ide/pci/delkin_cb.c	2004-10-21 14:24:18.000000000 -0400
@@ -0,0 +1,147 @@
+/*
+ *  linux/drivers/ide/pci/delkin_cb.c
+ *
+ *  Created 20 Oct 2004 by Mark Lord
+ *
+ *  Basic support for Delkin/ASKA/Workbit Cardbus CompactFlash adaptor
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
+	int i, rc;
+
+	MOD_INC_USE_COUNT;
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
+	ide_init_hwif_ports(&hw, (ide_ioreg_t)(base + 0x10),
+				 (ide_ioreg_t)(base + 0x1e), NULL);
+	hw.irq = dev->irq;
+	hw.chipset = ide_pci;		/* this enables IRQ sharing */
+	pci_release_regions(dev);	/* IDE layer handles regions itself */
+
+	rc = ide_register_hw(&hw, NULL);
+	if (rc < 0)	/* ide_register_hw likes to be invoked twice (buggy) */
+		rc = ide_register_hw(&hw, NULL);
+	if (rc < 0) {
+		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
+		MOD_DEC_USE_COUNT;
+		return -ENODEV;
+	} else {
+		ide_hwif_t  *hwif  = &ide_hwifs[rc];
+		ide_drive_t *drive = &hwif->drives[0];
+		pci_set_drvdata(dev, hwif);
+		hwif->pci_dev = dev;
+		if (drive->present) {
+			drive->id->csfo = 0; /* workaround for idedisk_open bug */
+			drive->io_32bit = 1;
+			drive->unmask   = 1;
+		}
+		return 0;
+	}
+}
+
+static void
+delkin_cb_remove (struct pci_dev *dev)
+{
+	ide_hwif_t *hwif = pci_get_drvdata(dev);
+
+	if (hwif) {
+		ide_unregister(hwif->index);
+		MOD_DEC_USE_COUNT;
+	}
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
+EXPORT_NO_SYMBOLS;
+
diff -u --recursive --new-file --exclude='.*' linux-2.4.28-pre4-bk6/drivers/ide/pci/Makefile linux/drivers/ide/pci/Makefile
--- linux-2.4.28-pre4-bk6/drivers/ide/pci/Makefile	2004-04-14 09:05:29.000000000 -0400
+++ linux/drivers/ide/pci/Makefile	2004-10-21 11:46:20.000000000 -0400
@@ -34,6 +34,7 @@
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
 obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via82cxxx.o
 obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
+obj-$(CONFIG_BLK_DEV_DELKIN)		+= delkin_cb.o
 
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)		+= generic.o
diff -u --recursive --new-file --exclude='.*' linux-2.4.28-pre4-bk6/drivers/scsi/nsp32.h linux/drivers/scsi/nsp32.h
--- linux-2.4.28-pre4-bk6/drivers/scsi/nsp32.h	2003-11-28 13:26:20.000000000 -0500
+++ linux/drivers/scsi/nsp32.h	2004-10-21 11:31:03.000000000 -0400
@@ -22,7 +22,6 @@
  * VENDOR/DEVICE ID
  */
 #define PCI_VENDOR_ID_IODATA  0x10fc
-#define PCI_VENDOR_ID_WORKBIT 0x1145
 
 #define PCI_DEVICE_ID_NINJASCSI_32BI_CBSC_II   0x0005
 #define PCI_DEVICE_ID_NINJASCSI_32BI_KME       0xf007
diff -u --recursive --new-file --exclude='.*' linux-2.4.28-pre4-bk6/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.4.28-pre4-bk6/include/linux/pci_ids.h	2004-10-21 11:02:21.000000000 -0400
+++ linux/include/linux/pci_ids.h	2004-10-21 11:16:32.000000000 -0400
@@ -2057,3 +2057,6 @@
 #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
 #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
 #define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
+
+#define PCI_VENDOR_ID_WORKBIT		0x1145
+#define PCI_DEVICE_ID_WORKBIT_CB	0xf021

--------------070500030806070904060109--
