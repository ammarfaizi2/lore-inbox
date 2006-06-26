Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWFZNnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWFZNnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWFZNnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:43:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37095 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030187AbWFZNnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:43:45 -0400
Subject: PATCH: Clean up pdc202xx_old so its more readable (done so I could
	work on libata ports)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 14:59:44 +0100
Message-Id: <1151330384.27147.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sets the new fifo flag so that we don't hang on some errors with
this chipset.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/pdc202xx_old.c linux-2.6.17/drivers/ide/pci/pdc202xx_old.c
--- linux.vanilla-2.6.17/drivers/ide/pci/pdc202xx_old.c	2006-06-19 17:29:46.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/pdc202xx_old.c	2006-06-26 13:47:18.508579000 +0100
@@ -101,31 +101,6 @@
 #define	MC1		0x02	/* DMA"C" timing */
 #define	MC0		0x01	/* DMA"C" timing */
 
-#if 0
-	unsigned long bibma  = pci_resource_start(dev, 4);
-	u8 hi = 0, lo = 0;
-
-	u8 sc1c	= inb_p((u16)bibma + 0x1c); 
-	u8 sc1e	= inb_p((u16)bibma + 0x1e);
-	u8 sc1f	= inb_p((u16)bibma + 0x1f);
-
-	p += sprintf(p, "Host Mode                            : %s\n",
-		(sc1f & 0x08) ? "Tri-Stated" : "Normal");
-	p += sprintf(p, "Bus Clocking                         : %s\n",
-		((sc1f & 0xC0) == 0xC0) ? "100 External" :
-		((sc1f & 0x80) == 0x80) ? "66 External" :
-		((sc1f & 0x40) == 0x40) ? "33 External" : "33 PCI Internal");
-	p += sprintf(p, "IO pad select                        : %s mA\n",
-		((sc1c & 0x03) == 0x03) ? "10" :
-		((sc1c & 0x02) == 0x02) ? "8" :
-		((sc1c & 0x01) == 0x01) ? "6" :
-		((sc1c & 0x00) == 0x00) ? "4" : "??");
-	hi = sc1e >> 4;
-	lo = sc1e & 0xf;
-	p += sprintf(p, "Status Polling Period                : %d\n", hi);
-	p += sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);
-#endif
-
 static u8 pdc202xx_ratemask (ide_drive_t *drive)
 {
 	u8 mode;
@@ -516,38 +486,7 @@
 	
 	pdc202xx_reset_host(hwif);
 	pdc202xx_reset_host(mate);
-#if 0
-	/*
-	 * FIXME: Have to kick all the drives again :-/
-	 * What a pain in the ACE!
-	 */
-	if (hwif->present) {
-		u16 hunit = 0;
-		for (hunit = 0; hunit < MAX_DRIVES; ++hunit) {
-			ide_drive_t *hdrive = &hwif->drives[hunit];
-			if (hdrive->present) {
-				if (hwif->ide_dma_check)
-					hwif->ide_dma_check(hdrive);
-				else
-					hwif->tuneproc(hdrive, 5);
-			}
-		}
-	}
-	if (mate->present) {
-		u16 munit = 0;
-		for (munit = 0; munit < MAX_DRIVES; ++munit) {
-			ide_drive_t *mdrive = &mate->drives[munit];
-			if (mdrive->present) {
-				if (mate->ide_dma_check) 
-					mate->ide_dma_check(mdrive);
-				else
-					mate->tuneproc(mdrive, 5);
-			}
-		}
-	}
-#else
 	hwif->tuneproc(drive, 5);
-#endif
 }
 
 /*
@@ -558,15 +497,12 @@
 static int pdc202xx_tristate (ide_drive_t * drive, int state)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
 	unsigned long high_16	= hwif->dma_master;
 	u8 sc1f			= hwif->INB(high_16|0x001f);
 
 	if (!hwif)
 		return -EINVAL;
 
-//	hwif->bus_state = state;
-
 	if (state) {
 		hwif->OUTB(sc1f | 0x08, (high_16|0x001f));
 	} else {
@@ -577,37 +513,13 @@
 
 static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev, const char *name)
 {
+	/* This doesn't appear needed */
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
-
-	/*
-	 * software reset -  this is required because the bios
-	 * will set UDMA timing on if the hdd supports it. The
-	 * user may want to turn udma off. A bug in the pdc20262
-	 * is that it cannot handle a downgrade in timing from
-	 * UDMA to DMA. Disk accesses after issuing a set
-	 * feature command will result in errors. A software
-	 * reset leaves the timing registers intact,
-	 * but resets the drives.
-	 */
-#if 0
-	if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
-	    (dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
-	    (dev->device == PCI_DEVICE_ID_PROMISE_20263) ||
-	    (dev->device == PCI_DEVICE_ID_PROMISE_20262)) {
-		unsigned long high_16	= pci_resource_start(dev, 4);
-		byte udma_speed_flag	= inb(high_16 + 0x001f);
-		outb(udma_speed_flag | 0x10, high_16 + 0x001f);
-		mdelay(100);
-		outb(udma_speed_flag & ~0x10, high_16 + 0x001f);
-		mdelay(2000);	/* 2 seconds ?! */
-	}
-
-#endif
 	return dev->irq;
 }
 
@@ -637,6 +549,8 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
+	hwif->err_stops_fifo = 1;
+
 	hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
 	hwif->ide_dma_lostirq = &pdc202xx_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &pdc202xx_ide_dma_timeout;
@@ -725,19 +639,6 @@
 				"mirror fixed.\n", d->name);
 		}
 	}
-
-#if 0
-        if (dev->device == PCI_DEVICE_ID_PROMISE_20262)
-        if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
-             (tmp & e->mask) != e->val))
-
-        if (d->enablebits[0].reg != d->enablebits[1].reg) {
-                d->enablebits[0].reg    = d->enablebits[1].reg;
-                d->enablebits[0].mask   = d->enablebits[1].mask;
-                d->enablebits[0].val    = d->enablebits[1].val;
-        }
-#endif
-
 	return ide_setup_pci_device(dev, d);
 }
 
@@ -752,22 +653,6 @@
 			"attached to I2O RAID controller.\n");
 		return -ENODEV;
 	}
-
-#if 0
-        {
-                u8 pri = 0, sec = 0;
-
-        if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
-             (tmp & e->mask) != e->val))
-
-        if (d->enablebits[0].reg != d->enablebits[1].reg) {
-                d->enablebits[0].reg    = d->enablebits[1].reg;
-                d->enablebits[0].mask   = d->enablebits[1].mask;
-                d->enablebits[0].val    = d->enablebits[1].val;
-        }
-        }
-#endif
-
 	return ide_setup_pci_device(dev, d);
 }
 
 	pci_write_config_word(dev, master_port, master_data);

