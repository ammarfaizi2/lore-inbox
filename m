Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319398AbSILBY7>; Wed, 11 Sep 2002 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319401AbSILBY6>; Wed, 11 Sep 2002 21:24:58 -0400
Received: from [61.149.34.176] ([61.149.34.176]:16396 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S319398AbSILBY5>;
	Wed, 11 Sep 2002 21:24:57 -0400
Date: Thu, 12 Sep 2002 09:19:29 +0800
From: Hu Gang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: back port piix ide fixup to 2.4.19.
Message-Id: <20020912091929.285cc8d7.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.7.8claws9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

My hardware is "00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)",

In 2.4.19 without this patch, the hdparm can get only ~5M/sec.
In 2.4.19 with this patch, the hdparm can get data up to 20M/sec.

The old code is in 2.5.34.

Please test it. 
-------
--- drivers/ide/ide-pci.c	Wed Aug  7 19:28:13 2002
+++ drivers/ide/ide-pci.c.old	Wed Sep 11 13:42:15 2002
@@ -951,6 +951,42 @@
 	ide_setup_pci_device(dev2, d2);
 }
 
+inline void ide_register_xp_fix(struct pci_dev *dev)
+{
+        int i;
+        unsigned short cmd;
+        unsigned long flags;
+        unsigned long base_address[4] = { 0x1f0, 0x3f4, 0x170, 0x374 };
+
+        local_irq_save(flags);
+        pci_read_config_word(dev, PCI_COMMAND, &cmd);
+        pci_write_config_word(dev, PCI_COMMAND, cmd & ~PCI_COMMAND_IO);
+        for (i=0; i<4; i++) {
+                dev->resource[i].start = 0;
+                dev->resource[i].end = 0;
+                dev->resource[i].flags = 0;
+        }                                                                        
+        for (i=0; i<4; i++) {                                                    
+                dev->resource[i].start = base_address[i];
+                dev->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
+                pci_write_config_dword(dev,
+                        (PCI_BASE_ADDRESS_0 + (i * 4)),
+                        dev->resource[i].start);
+        }
+        pci_write_config_word(dev, PCI_COMMAND, cmd);
+        local_irq_restore(flags);
+}
+
+void __init fixup_device_piix (struct pci_dev *dev, ide_pci_device_t *d)
+{
+        if (dev->resource[0].start != 0x01F1)
+                ide_register_xp_fix(dev);
+        printk("%s: IDE controller on PCI bus %02x dev %02x\n",
+                d->name, dev->bus->number, dev->devfn);
+        ide_setup_pci_device(dev, d);
+
+}
+
 /*
  * ide_scan_pcibus() gets invoked at boot time from ide.c.
  * It finds all PCI IDE controllers and calls ide_setup_pci_device for them.
@@ -977,6 +1013,8 @@
 		hpt366_device_order_fixup(dev, d);
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20270))
 		pdc20270_device_order_fixup(dev, d);
+        else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_ICH3M))
+                fixup_device_piix(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
 			printk("%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",

-- 
		--- Hu Gang
