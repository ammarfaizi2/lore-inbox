Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUKFAxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUKFAxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUKFAxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:53:37 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:59366 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261295AbUKFAvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:51:24 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [BK PATCHES] ide-2.6 update
Date: Sat, 6 Nov 2004 01:54:06 +0100
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411060154.06397.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus!

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/ide-probe.c     |   63 +++++++++++++++++++++++++--------
 drivers/ide/ide.c           |   14 +++++--
 drivers/ide/legacy/ide-cs.c |    2 -
 drivers/ide/pci/cs5520.c    |    2 -
 drivers/ide/pci/ns87415.c   |   83 +++++++++++++++++++++++++++++++++++++++++---
 drivers/ide/pci/siimage.c   |   54 ++++++++++++++++------------
 drivers/ide/setup-pci.c     |    4 +-
 include/linux/ata.h         |    8 +++-
 include/linux/hdreg.h       |   23 +-----------
 include/linux/ide.h         |   31 ++--------------
 10 files changed, 186 insertions(+), 98 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/11/06 1.2474)
   [ide] siimage: fix the various SI3112 hangs
   
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   (some changes by me - bart)
   
   The current driver looks at fields before it is safe to, we move the
   mod15rm bug handler to be a fixup and this ensures the probe has been
   completed before we use the ident data.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/06 1.2473)
   [ide] apply undecoded slave fixup only for ide-cs
   
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   (some changes by me - bart)
   
   We add probe_hwif_init_with_fixup (seperate naming as requested by
   Bartlomiej). This runs a fixup on present interfaces before attaching
   the drives. In order to be useful we need also an _with_fixup version
   of ide_register_hw function. 
   
   The sometimes troublesome undecoded slave detector is moved to its own
   function and exported so that ide-cs and the upcoming delkin_cb can both
   use it (along with any arch specific cf/pcmcia drivers I don't know
   about). The non-relevant checks for this scenario are removed.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/05 1.2472)
   [ide] remove debugging delay from CS5520 driver
   
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/05 1.2471)
   [ide] (partially) unify hdreg.h & ata.h
   
   Signed-off-by: Chris Wedgwood <cw@f00f.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/05 1.2470)
   [ide] remove some cruft from ide.h
   
   From: Chris Wedgwood <cw@f00f.org>
   (minor changes by me - bart)
   
   Remove some accumulated (unused) cruft from ide.h
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/05 1.2469)
   [ide] ns87415: small cleanup
   
   ide_hwif_setup_dma() calls pci_set_master() if necessary.
   pci_set_master() (indirectly via pcibios_set_master()) sets
   PCI_LATENCY_TIMER to a "reasonable" value.
   
   Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/05 1.2468)
   [ide] ns87415: PA-RISC update
   
   From: Grant Grundler <grundler@parisc-linux.org>
   (minor changes by me - bart)
   
   Move Superio (NatSem 87560) IDE hacks into the ns87415 driver
   instead of exporting IDE data structures.
   
   To date, only PA-RISC port is known to use the 87560 chip.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/05 1.2467)
   [ide] shrink hw_regs_t
   
   sata_[misc,scr] and priv are write-only
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/ide-probe.c	2004-11-06 01:28:50 +01:00
@@ -652,6 +652,43 @@
 	return rc;
 }
 
+/**
+ *	ide_undecoded_slave	-	look for bad CF adapters
+ *	@hwif: interface
+ *
+ *	Analyse the drives on the interface and attempt to decide if we
+ *	have the same drive viewed twice. This occurs with crap CF adapters
+ *	and PCMCIA sometimes.
+ */
+
+void ide_undecoded_slave(ide_hwif_t *hwif)
+{
+	ide_drive_t *drive0 = &hwif->drives[0];
+	ide_drive_t *drive1 = &hwif->drives[1];
+
+	if (drive0->present == 0 || drive1->present == 0)
+		return;
+
+	/* If the models don't match they are not the same product */
+	if (strcmp(drive0->id->model, drive1->id->model))
+		return;
+
+	/* Serial numbers do not match */
+	if (strncmp(drive0->id->serial_no, drive1->id->serial_no, 20))
+		return;
+
+	/* No serial number, thankfully very rare for CF */
+	if (drive0->id->serial_no[0] == 0)
+		return;
+
+	/* Appears to be an IDE flash adapter with decode bugs */
+	printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
+
+	drive1->present = 0;
+}
+
+EXPORT_SYMBOL_GPL(ide_undecoded_slave);
+
 /*
  * This routine only knows how to look for drive units 0 and 1
  * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
@@ -723,20 +760,6 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
-		if (drive->present && hwif->present && unit == 1) {
-			if (strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
-			    /* Don't do this for noprobe or non ATA */
-			    strcmp(drive->id->model, "UNKNOWN") &&
-			    /* And beware of confused Maxtor drives that go "M0000000000"
-			      "The SN# is garbage in the ID block..." [Eric] */
-			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&
-			    /* Same goes for another set of Maxtor drives that say "D3000000" */
-			    strncmp(drive->id->serial_no, "D3000000", 8) &&
-			    strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0) {
-				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
-				drive->present = 0;
-			}
-		}
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives ||
@@ -810,9 +833,14 @@
 }
 
 static int hwif_init(ide_hwif_t *hwif);
-int probe_hwif_init (ide_hwif_t *hwif)
+
+int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
 {
 	probe_hwif(hwif);
+
+	if (fixup)
+		fixup(hwif);
+
 	hwif_init(hwif);
 
 	if (hwif->present) {
@@ -828,6 +856,11 @@
 		}
 	}
 	return 0;
+}
+
+int probe_hwif_init(ide_hwif_t *hwif)
+{
+	return probe_hwif_init_with_fixup(hwif, NULL);
 }
 
 EXPORT_SYMBOL(probe_hwif_init);
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/ide.c	2004-11-06 01:28:50 +01:00
@@ -985,9 +985,10 @@
 }
 
 /**
- *	ide_register_hw		-	register IDE interface
+ *	ide_register_hw_with_fixup	-	register IDE interface
  *	@hw: hardware registers
  *	@hwifp: pointer to returned hwif
+ *	@fixup: fixup function
  *
  *	Register an IDE interface, specifying exactly the registers etc.
  *	Set init=1 iff calling before probes have taken place.
@@ -995,7 +996,7 @@
  *	Returns -1 on error.
  */
 
-int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
+int ide_register_hw_with_fixup(hw_regs_t *hw, ide_hwif_t **hwifp, void(*fixup)(ide_hwif_t *hwif))
 {
 	int index, retry = 1;
 	ide_hwif_t *hwif;
@@ -1034,7 +1035,7 @@
 	hwif->chipset = hw->chipset;
 
 	if (!initializing) {
-		probe_hwif_init(hwif);
+		probe_hwif_init_with_fixup(hwif, fixup);
 		create_proc_ide_interfaces();
 	}
 
@@ -1042,6 +1043,13 @@
 		*hwifp = hwif;
 
 	return (initializing || hwif->present) ? index : -1;
+}
+
+EXPORT_SYMBOL(ide_register_hw_with_fixup);
+
+int ide_register_hw(hw_regs_t *hw, ide_hwif_t **hwifp)
+{
+	return ide_register_hw_with_fixup(hw, hwifp, NULL);
 }
 
 EXPORT_SYMBOL(ide_register_hw);
diff -Nru a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/legacy/ide-cs.c	2004-11-06 01:28:50 +01:00
@@ -206,7 +206,7 @@
     ide_init_hwif_ports(&hw, io, ctl, NULL);
     hw.irq = irq;
     hw.chipset = ide_pci;
-    return ide_register_hw(&hw, NULL);
+    return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
 
 /*======================================================================
diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/pci/cs5520.c	2004-11-06 01:28:50 +01:00
@@ -241,8 +241,6 @@
 
 	ide_pci_setup_ports(dev, d, 14, &index);
 
-	printk("Index.b %d %d\n", index.b.low, index.b.high);
-	mdelay(2000);
 	if((index.b.low & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index.b.low]);
 	if((index.b.high & 0xf0) != 0xf0)
diff -Nru a/drivers/ide/pci/ns87415.c b/drivers/ide/pci/ns87415.c
--- a/drivers/ide/pci/ns87415.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/pci/ns87415.c	2004-11-06 01:28:50 +01:00
@@ -4,6 +4,7 @@
  * Copyright (C) 1997-1998	Mark Lord <mlord@pobox.com>
  * Copyright (C) 1998		Eddie C. Dost <ecd@skynet.be>
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 2004		Grant Grundler <grundler at parisc-linux.org>
  *
  * Inspired by an earlier effort from David S. Miller <davem@redhat.com>
  */
@@ -25,6 +26,81 @@
 
 #include <asm/io.h>
 
+#ifdef CONFIG_SUPERIO
+/* SUPERIO 87560 is a PoS chip that NatSem denies exists.
+ * Unfortunately, it's built-in on all Astro-based PA-RISC workstations
+ * which use the integrated NS87514 cell for CD-ROM support.
+ * i.e we have to support for CD-ROM installs.
+ * See drivers/parisc/superio.c for more gory details.
+ */
+#include <asm/superio.h>
+
+static unsigned long superio_ide_status[2];
+static unsigned long superio_ide_select[2];
+static unsigned long superio_ide_dma_status[2];
+
+#define SUPERIO_IDE_MAX_RETRIES 25
+
+/* Because of a defect in Super I/O, all reads of the PCI DMA status 
+ * registers, IDE status register and the IDE select register need to be 
+ * retried
+ */
+static u8 superio_ide_inb (unsigned long port)
+{
+	if (port == superio_ide_status[0] ||
+	    port == superio_ide_status[1] ||
+	    port == superio_ide_select[0] ||
+	    port == superio_ide_select[1] ||
+	    port == superio_ide_dma_status[0] ||
+	    port == superio_ide_dma_status[1]) {
+		u8 tmp;
+		int retries = SUPERIO_IDE_MAX_RETRIES;
+
+		/* printk(" [ reading port 0x%x with retry ] ", port); */
+
+		do {
+			tmp = inb(port);
+			if (tmp == 0)
+				udelay(50);
+		} while (tmp == 0 && retries-- > 0);
+
+		return tmp;
+	}
+
+	return inb(port);
+}
+
+static void __devinit superio_ide_init_iops (struct hwif_s *hwif)
+{
+	u32 base, dmabase;
+	u8 tmp;
+	struct pci_dev *pdev = hwif->pci_dev;
+	u8 port = hwif->channel;
+
+	base = pci_resource_start(pdev, port * 2) & ~3;
+	dmabase = pci_resource_start(pdev, 4) & ~3;
+
+	superio_ide_status[port] = base + IDE_STATUS_OFFSET;
+	superio_ide_select[port] = base + IDE_SELECT_OFFSET;
+	superio_ide_dma_status[port] = dmabase + (!port ? 2 : 0xa);
+
+	/* Clear error/interrupt, enable dma */
+	tmp = superio_ide_inb(superio_ide_dma_status[port]);
+	outb(tmp | 0x66, superio_ide_dma_status[port]);
+
+	/* We need to override inb to workaround a SuperIO errata */
+	hwif->INB = superio_ide_inb;
+}
+
+static void __devinit init_iops_ns87415(ide_hwif_t *hwif)
+{
+	if (PCI_SLOT(hwif->pci_dev->devfn) == 0xE) {
+		/* Built-in - assume it's under superio. */
+		superio_ide_init_iops(hwif);
+	}
+}
+#endif
+
 static unsigned int ns87415_count = 0, ns87415_control[MAX_HWIFS] = { 0 };
 
 /*
@@ -132,10 +208,6 @@
 	hwif->autodma = 0;
 	hwif->selectproc = &ns87415_selectproc;
 
-	/* Set a good latency timer and cache line size value. */
-	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
-	/* FIXME: use pci_set_master() to ensure good latency timer value */
-
 	/*
 	 * We cannot probe for IRQ: both ports share common IRQ on INTA.
 	 * Also, leave IRQ masked during drive probing, to prevent infinite
@@ -205,6 +277,9 @@
 
 static ide_pci_device_t ns87415_chipset __devinitdata = {
 	.name		= "NS87415",
+#ifdef CONFIG_SUPERIO
+	.init_iops	= init_iops_ns87415,
+#endif
 	.init_hwif	= init_hwif_ns87415,
 	.channels	= 2,
 	.autodma	= AUTODMA,
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/pci/siimage.c	2004-11-06 01:28:50 +01:00
@@ -871,12 +871,11 @@
 	 *	the MMIO layout isnt the same as the the standard port
 	 *	based I/O
 	 */
-	 
+
 	memset(&hw, 0, sizeof(hw_regs_t));
-	hw.priv				= addr;
 
-	base				= (unsigned long)addr;
-	if(ch)
+	base = (unsigned long)addr;
+	if (ch)
 		base += 0xC0;
 	else
 		base += 0x80;
@@ -901,16 +900,16 @@
 
 	hw.io_ports[IDE_IRQ_OFFSET]	= 0;
 
-        if (pdev_is_sata(dev)) {
-        	base = (unsigned long) addr;
-        	if(ch)
-        		base += 0x80;
-		hw.sata_scr[SATA_STATUS_OFFSET]	= base + 0x104;
-		hw.sata_scr[SATA_ERROR_OFFSET]	= base + 0x108;
-		hw.sata_scr[SATA_CONTROL_OFFSET]= base + 0x100;
-		hw.sata_misc[SATA_MISC_OFFSET]	= base + 0x140;
-		hw.sata_misc[SATA_PHY_OFFSET]	= base + 0x144;
-		hw.sata_misc[SATA_IEN_OFFSET]	= base + 0x148;
+	if (pdev_is_sata(dev)) {
+		base = (unsigned long)addr;
+		if (ch)
+			base += 0x80;
+		hwif->sata_scr[SATA_STATUS_OFFSET]	= base + 0x104;
+		hwif->sata_scr[SATA_ERROR_OFFSET]	= base + 0x108;
+		hwif->sata_scr[SATA_CONTROL_OFFSET]	= base + 0x100;
+		hwif->sata_misc[SATA_MISC_OFFSET]	= base + 0x140;
+		hwif->sata_misc[SATA_PHY_OFFSET]	= base + 0x144;
+		hwif->sata_misc[SATA_IEN_OFFSET]	= base + 0x148;
 	}
 
 	hw.irq				= hwif->pci_dev->irq;
@@ -918,11 +917,6 @@
 	memcpy(&hwif->hw, &hw, sizeof(hw));
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 
-	if (is_sata(hwif)) {
-		memcpy(hwif->sata_scr, hwif->hw.sata_scr, sizeof(hwif->hw.sata_scr));
-		memcpy(hwif->sata_misc, hwif->hw.sata_misc, sizeof(hwif->hw.sata_misc));
-	}
-
 	hwif->irq			= hw.irq;
 
        	base = (unsigned long) addr;
@@ -961,6 +955,22 @@
 }
 
 /**
+ *	siimage_fixup		-	post probe fixups
+ *	@hwif: interface to fix up
+ *
+ *	Called after drive probe we use this to decide whether the
+ *	Seagate fixup must be applied. This used to be in init_iops but
+ *	that can occur before we know what drives are present.
+ */
+
+static void __devinit siimage_fixup(ide_hwif_t *hwif)
+{
+	/* Try and raise the rqsize */
+	if (!is_sata(hwif) || !is_dev_seagate_sata(&hwif->drives[0]))
+		hwif->rqsize = 128;
+}
+
+/**
  *	init_iops_siimage	-	set up iops
  *	@hwif: interface to set up
  *
@@ -980,9 +990,8 @@
 	
 	hwif->hwif_data = NULL;
 
-	hwif->rqsize = 128;
-	if (is_sata(hwif) && is_dev_seagate_sata(&hwif->drives[0]))
-		hwif->rqsize = 15;
+	/* Pessimal until we finish probing */
+	hwif->rqsize = 15;
 
 	if (pci_get_drvdata(dev) == NULL)
 		return;
@@ -1070,6 +1079,7 @@
 		.init_chipset	= init_chipset_siimage,	\
 		.init_iops	= init_iops_siimage,	\
 		.init_hwif	= init_hwif_siimage,	\
+		.fixup		= siimage_fixup,	\
 		.channels	= 2,			\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	2004-11-06 01:28:50 +01:00
+++ b/drivers/ide/setup-pci.c	2004-11-06 01:28:50 +01:00
@@ -707,9 +707,9 @@
 	ata_index_t index_list = do_ide_setup_pci_device(dev, d, 1);
 
 	if ((index_list.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.low]);
+		probe_hwif_init_with_fixup(&ide_hwifs[index_list.b.low], d->fixup);
 	if ((index_list.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.high]);
+		probe_hwif_init_with_fixup(&ide_hwifs[index_list.b.high], d->fixup);
 
 	create_proc_ide_interfaces();
 }
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-11-06 01:28:50 +01:00
+++ b/include/linux/ata.h	2004-11-06 01:28:50 +01:00
@@ -33,8 +33,6 @@
 	ATA_MAX_DEVICES		= 2,	/* per bus/port */
 	ATA_MAX_PRD		= 256,	/* we could make these 256/256 */
 	ATA_SECT_SIZE		= 512,
-	ATA_SECT_SIZE_MASK	= (ATA_SECT_SIZE - 1),
-	ATA_SECT_DWORDS		= ATA_SECT_SIZE / sizeof(u32),
 
 	ATA_ID_WORDS		= 256,
 	ATA_ID_PROD_OFS		= 27,
@@ -142,6 +140,12 @@
 	XFER_PIO_2		= 0x0A,
 	XFER_PIO_1		= 0x09,
 	XFER_PIO_0		= 0x08,
+
+	/* legacy IDE 'stuff' */
+	XFER_SW_DMA_2		= 0x12,
+	XFER_SW_DMA_1		= 0x11,
+	XFER_SW_DMA_0		= 0x10,
+	XFER_PIO_SLOW		= 0x00,
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
diff -Nru a/include/linux/hdreg.h b/include/linux/hdreg.h
--- a/include/linux/hdreg.h	2004-11-06 01:28:50 +01:00
+++ b/include/linux/hdreg.h	2004-11-06 01:28:50 +01:00
@@ -1,6 +1,8 @@
 #ifndef _LINUX_HDREG_H
 #define _LINUX_HDREG_H
 
+#include <linux/ata.h>
+
 /*
  * This file contains some defines for the AT-hd-controller.
  * Various sources.
@@ -328,27 +330,6 @@
 /* WIN_SETFEATURES sub-commands */
 #define SETFEATURES_EN_8BIT	0x01	/* Enable 8-Bit Transfers */
 #define SETFEATURES_EN_WCACHE	0x02	/* Enable write cache */
-#define SETFEATURES_XFER	0x03	/* Set transfer mode */
-#	define XFER_UDMA_7	0x47	/* 0100|0111 */
-#	define XFER_UDMA_6	0x46	/* 0100|0110 */
-#	define XFER_UDMA_5	0x45	/* 0100|0101 */
-#	define XFER_UDMA_4	0x44	/* 0100|0100 */
-#	define XFER_UDMA_3	0x43	/* 0100|0011 */
-#	define XFER_UDMA_2	0x42	/* 0100|0010 */
-#	define XFER_UDMA_1	0x41	/* 0100|0001 */
-#	define XFER_UDMA_0	0x40	/* 0100|0000 */
-#	define XFER_MW_DMA_2	0x22	/* 0010|0010 */
-#	define XFER_MW_DMA_1	0x21	/* 0010|0001 */
-#	define XFER_MW_DMA_0	0x20	/* 0010|0000 */
-#	define XFER_SW_DMA_2	0x12	/* 0001|0010 */
-#	define XFER_SW_DMA_1	0x11	/* 0001|0001 */
-#	define XFER_SW_DMA_0	0x10	/* 0001|0000 */
-#	define XFER_PIO_4	0x0C	/* 0000|1100 */
-#	define XFER_PIO_3	0x0B	/* 0000|1011 */
-#	define XFER_PIO_2	0x0A	/* 0000|1010 */
-#	define XFER_PIO_1	0x09	/* 0000|1001 */
-#	define XFER_PIO_0	0x08	/* 0000|1000 */
-#	define XFER_PIO_SLOW	0x00	/* 0000|0000 */
 #define SETFEATURES_DIS_DEFECT	0x04	/* Disable Defect Management */
 #define SETFEATURES_EN_APM	0x05	/* Enable advanced power management */
 #define SETFEATURES_EN_SAME_R	0x22	/* for a region ATA-1 */
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-11-06 01:28:50 +01:00
+++ b/include/linux/ide.h	2004-11-06 01:28:50 +01:00
@@ -39,7 +39,6 @@
  *
  * REALLY_SLOW_IO can be defined in ide.c and ide-cd.c, if necessary
  */
-#define REALLY_FAST_IO			/* define if ide ports are perfect */
 #define INITIAL_MULT_COUNT	0	/* off=0; on=2,4,8,16,32, etc.. */
 
 #ifndef SUPPORT_SLOW_DATA_PORTS		/* 1 to support slow data ports */
@@ -64,18 +63,6 @@
 #define IDE_NO_IRQ		(-1)
 
 /*
- * IDE_DRIVE_CMD is used to implement many features of the hdparm utility
- */
-#define IDE_DRIVE_CMD			99	/* (magic) undef to reduce kernel size*/
-
-#define IDE_DRIVE_TASK			98
-
-/*
- * IDE_DRIVE_TASKFILE is used to implement many features needed for raw tasks
- */
-#define IDE_DRIVE_TASKFILE		97
-
-/*
  *  "No user-serviceable parts" beyond this point  :)
  *****************************************************************************/
 
@@ -101,13 +88,6 @@
 
 #define DMA_PIO_RETRY	1	/* retrying in PIO */
 
-/*
- * Ensure that various configuration flags have compatible settings
- */
-#ifdef REALLY_SLOW_IO
-#undef REALLY_FAST_IO
-#endif
-
 #define HWIF(drive)		((ide_hwif_t *)((drive)->hwif))
 #define HWGROUP(drive)		((ide_hwgroup_t *)(HWIF(drive)->hwgroup))
 
@@ -197,10 +177,7 @@
 /*
  * Some more useful definitions
  */
-#define IDE_MAJOR_NAME	"hd"	/* the same for all i/f; see also genhd.c */
-#define MAJOR_NAME	IDE_MAJOR_NAME
 #define PARTN_BITS	6	/* number of minor dev bits for partitions */
-#define PARTN_MASK	((1<<PARTN_BITS)-1)	/* a useful bit mask */
 #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
 #define SECTOR_SIZE	512
 #define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
@@ -256,16 +233,14 @@
 	int		irq;			/* our irq number */
 	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
-	void		*priv;			/* interface specific data */
 	hwif_chipset_t  chipset;
-	unsigned long	sata_scr[SATA_NR_PORTS];
-	unsigned long	sata_misc[SATA_NR_PORTS];
 } hw_regs_t;
 
 /*
  * Register new hardware with ide
  */
 int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
+int ide_register_hw_with_fixup(hw_regs_t *, struct hwif_s **, void (*)(struct hwif_s *));
 
 /*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
@@ -1453,6 +1428,7 @@
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
+	void			(*fixup)(ide_hwif_t *);
 	u8			channels;
 	u8			autodma;
 	ide_pci_enablebit_t	enablebits[2];
@@ -1513,6 +1489,9 @@
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);
 
+void ide_undecoded_slave(ide_hwif_t *);
+
+int probe_hwif_init_with_fixup(ide_hwif_t *, void (*)(ide_hwif_t *));
 extern int probe_hwif_init(ide_hwif_t *);
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
