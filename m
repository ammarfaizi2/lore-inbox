Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbUJZDYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUJZDYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUJZDWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:22:33 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:61068 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262149AbUJZCxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:53:07 -0400
Message-ID: <417DBC0D.9050105@rtr.ca>
Date: Mon, 25 Oct 2004 22:53:01 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 2.4.28] delkin_cb: new carbus IDE driver
Content-Type: multipart/mixed;
 boundary="------------090707010106030300040609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090707010106030300040609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

This new driver is also ready to go into 2.4.xx.
It is completely stand-alone, with no code impact
to any existing drivers, and so should be pretty safe.

Changes since last posting: fixed handling of module load errors.

Signed-off-by:  Mark Lord <mlord@pobox.com>
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

--------------090707010106030300040609
Content-Type: text/plain;
 name="delkin_cb-2.4.28-bk4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delkin_cb-2.4.28-bk4.patch"

diff -u --recursive --new-file --exclude='.*' linux-2.4.28-pre4-bk6/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.28-pre4-bk6/Documentation/Configure.help	2004-10-21 11:02:17.000000000 -0400
+++ linux/Documentation/Configure.help	2004-10-21 19:38:35.000000000 -0400
@@ -781,6 +781,13 @@
   <file:Documentation/modules.txt>. The module will be called
   ide-cs.o
 
+Cardbus IDE support (Delkin/ASKA/Workbit)
+CONFIG_BLK_DEV_DELKIN
+  Support for Delkin/ASKA/Workbit cardbus CompactFlash Adapters.
+  This may also work for similar SD and XD adapters.  If you want
+  to be able to use one of these, then say M here.  The module will
+  be called delkin_cb.o
+
 Include IDE/ATAPI CD-ROM support
 CONFIG_BLK_DEV_IDECD
   If you have a CD-ROM drive using the ATAPI protocol, say Y. ATAPI is
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
+++ linux/drivers/ide/pci/delkin_cb.c	2004-10-21 17:47:33.000000000 -0400
@@ -0,0 +1,149 @@
+/*
+ *  linux/drivers/ide/pci/delkin_cb.c
+ *
+ *  Created 25 Oct 2004 by Mark Lord
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
+	ide_init_hwif_ports(&hw, (ide_ioreg_t)(base + 0x10),
+				 (ide_ioreg_t)(base + 0x1e), NULL);
+	hw.irq = dev->irq;
+	hw.chipset = ide_pci;		/* this enables IRQ sharing */
+
+	rc = ide_register_hw(&hw, &hwif);
+	if (rc < 0)	/* ide_register_hw likes to be invoked twice (buggy) */
+		rc = ide_register_hw(&hw, &hwif);
+	if (rc < 0) {
+		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
+		pci_disable_device(dev);
+		return -ENODEV;
+	}
+	MOD_INC_USE_COUNT;
+	pci_set_drvdata(dev, hwif);
+	hwif->pci_dev = dev;
+	drive = &hwif->drives[0];
+	if (drive->present) {
+		drive->id->csfo = 0; /* workaround for idedisk_open bug */
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

--------------090707010106030300040609--
