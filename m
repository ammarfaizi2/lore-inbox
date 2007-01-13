Return-Path: <linux-kernel-owner+w=401wt.eu-S1422711AbXAMQ7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbXAMQ7t (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 11:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbXAMQ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 11:59:49 -0500
Received: from rtr.ca ([64.26.128.89]:4407 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422711AbXAMQ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 11:59:49 -0500
X-Greylist: delayed 2047 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jan 2007 11:59:48 EST
From: Mark Lord <liml@rtr.ca>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] IDE Driver for Delkin/Lexar/etc.. cardbus CF adapter
Date: Sat, 13 Jan 2007 11:25:38 -0500
User-Agent: KMail/1.9.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701131125.38882.liml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 23:17, Bartlomiej Zolnierkiewicz wrote:
> 
> My working IDE tree (against Linus' tree) now resides here:
> 
> 	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/

Bart, here's a driver I've been keeping out-of-tree for the past couple of years.
This is for the Delking/Lexar/ASKA/etc.. 32-bit cardbus IDE CompactFlash adapter card.

It's probably way out of sync with the latest driver model (??), but it still builds/works.
I'm not interested in doing much of a rewrite, other than for libata someday,
as I no longer use the card myself.

But lots of other people do seem to use it, so it might be nice to see it "in-tree".

Signed-off-by:  Mark Lord <mlord@pobox.com>

---
--- linux-2.6.11/drivers/ide/Kconfig	2005-03-02 10:07:37.000000000 -0500
+++ linux/drivers/ide/Kconfig	2005-03-02 10:11:54.000000000 -0500
@@ -166,6 +166,13 @@
 	  Support for outboard IDE disks, tape drives, and CD-ROM drives
 	  connected through a CARDBUS card.
 
+config BLK_DEV_DELKIN
+	tristate "Cardbus IDE support (Delkin/ASKA/Workbit)"
+	depends on CARDBUS && PCI
+	help
+	  Support for Delkin, ASKA, and Workbit Cardbus CompactFlash
+	  Adapters.  This may also work for similar SD and XD adapters.
+
 config BLK_DEV_IDECD
 	tristate "Include IDE/ATAPI CDROM support"
 	---help---
--- linux-2.6.11/drivers/ide/pci/delkin_cb.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/drivers/ide/pci/delkin_cb.c	2005-02-14 11:58:59.000000000 -0500
@@ -0,0 +1,140 @@
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
+#include <linux/autoconf.h>
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
+	rc = ide_register_hw_with_fixup(&hw, &hwif, ide_undecoded_slave);
+	if (rc < 0) {
+		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
+		pci_disable_device(dev);
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
+		ide_unregister(hwif->index);
+	pci_disable_device(dev);
+}
+
+static struct pci_device_id delkin_cb_pci_tbl[] __devinitdata = {
+	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, delkin_cb_pci_tbl);
+
+static struct pci_driver driver = {
+	.name		= "Delkin-ASKA-Workbit Cardbus IDE",
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
--- linux-2.6.11/drivers/ide/pci/Makefile	2005-03-02 10:07:37.000000000 -0500
+++ linux/drivers/ide/pci/Makefile	2005-03-02 10:11:54.000000000 -0500
@@ -8,6 +8,7 @@
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
+obj-$(CONFIG_BLK_DEV_DELKIN)		+= delkin_cb.o
 obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 #obj-$(CONFIG_BLK_DEV_HPT37X)		+= hpt37x.o
