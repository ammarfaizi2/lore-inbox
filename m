Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTJDR0y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 13:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTJDR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 13:26:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41972 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262611AbTJDR0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 13:26:47 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Aniket Malatpure <aniket@sgi.com>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Sat, 4 Oct 2003 19:30:15 +0200
User-Agent: KMail/1.5.4
Cc: akmp@osdl.org, gwh@sgi.com, jeremy@sgi.com, jbarnes@sgi.com,
       aniket_m@hotmail.com, linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com> <200310031645.57341.bzolnier@elka.pw.edu.pl> <3F7E1509.7D08EC2D@sgi.com>
In-Reply-To: <3F7E1509.7D08EC2D@sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nOwf/JhWnrfRCKf"
Message-Id: <200310041930.15385.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nOwf/JhWnrfRCKf
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,

Patch looks better, but there are still some issues to be resolved.

> + *
> + *     This code is identical to ide_raw_build_sglist in ide-dma.c
> + *     however that it not exported and even if it were would create
> + *     dependancy problems for modular drivers.
> + */
>
> >What problems?
> >BTW during coping tabs were replaced by spaces in these functions.
>
> Actually what I meant by problems was that, when this driver is compiled as
> a module and the earlier functions are not exported, the driver fails to
> find them. I have removed the earlier line from the new patch.

Okay, please apply attached patch first.
It exports ide_build_sglist() and ide_raw_build_sglist().

I've noticed that descriptions of these functions are slightly incorrect
in your patch, there is no hwif argument etc.

> +       return p - buffer;
> +}
>
> >Do you really need /proc/ide/sgiioc4?
> >You can print revision number during init.
>
> It has been helpful to be able to see the firmware revision num anytime
> during system operation.
> So the new patch still creates the above entry.

I don't buy this, lspci can be used :-).

> +                                           int ddir);
> +static unsigned int __init pci_init_sgiioc4(struct pci_dev
> *dev,ide_pci_device_t *d);
>
> >Most of this declarations are not needed as sgiioc4.h is only included
> > from shiioc4.c.
>
> The sgiioc4.h file has been removed in the new patch.

sgiioc4.h was removed, but declarations weren't.
You can shuffle code around to get rid of them.

> Please merge this patch if there are no other issues.

ide_dma_sgiioc4():
+	if (!request_region(dma_base, num_ports, hwif->name)) {
+		printk(KERN_ERR
+		       "%s(%s) -- WARNING, Addresses 0x%p to 0x%p ALREADY in use\n",
+		       __FUNCTION__, hwif->name, (void *) dma_base,
+		       (void *) dma_base + num_ports - 1);
+	}
+

Driver can't just warn if addresses are already in use, it should fail.
There is one more request_region() with this problem in the driver.

+	hwif->sg_table =
+	    kmalloc(sizeof (struct scatterlist) * IOC4_PRD_ENTRIES, GFP_KERNEL);
+
+	if (!hwif->sg_table) {
+		pci_free_consistent(hwif->pci_dev,
+				    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
+		goto dma_alloc_failure;
+	}
+
+	hwif->dma_base2 =
+	    (unsigned long) pci_alloc_consistent(hwif->pci_dev,
+						 IOC4_IDE_CACHELINE_SIZE,
+						 (dma_addr_t *) &(hwif->dma_status));
+
+	if (!hwif->dma_base2) {
+		pci_free_consistent(hwif->pci_dev,
+				    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
+		kfree(hwif->sg_table);
+		goto dma_alloc_failure;
+	}
+
+	return;
+
+      dma_alloc_failure:

Minor issue: you can move pci_free_consisten() after dma_alloc_failure label.

+static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
+	{
+	 /* Channel 0 */
+	 .vendor = PCI_VENDOR_ID_SGI,
+	 .device = PCI_DEVICE_ID_SGI_IOC4,
+	 .name = "SGIIOC4",
+	 .init_chipset = NULL,
+	 .init_iops = NULL,
+	 .init_hwif = ide_init_sgiioc4,
+	 .init_dma = ide_dma_sgiioc4,
+	 .channels = 1,
+	 .autodma = AUTODMA,
+	 .enablebits = {{0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}},
+	 .bootable = ON_BOARD,
+	 .extra = 0,
+	 }
+};

Minor issue: static variables are initialized to 0 by kernel,
so .init_{chipset, iops}, .enablebits and .extra lines should go away.

There are no .enablebits on SGI IOC4?  Please add a comment about it.

sgiioc4_init_one():
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;

Access to PCI devices before pci_enable_device()
(it is called later in pci_init_sgiioc4).

+static int
+sgiioc4_ide_dma_count(ide_drive_t * drive)
+{
+	return HWIF(drive)->ide_dma_begin(drive);
+}

This is identical to __ide_dma_count().

+static int
+sgiioc4_ide_dma_timeout(ide_drive_t * drive)
+{
+	printk(KERN_ERR "%s: timeout waiting for DMA\n", drive->name);
+	if (HWIF(drive)->ide_dma_test_irq(drive))
+		return 0;
+
+	return HWIF(drive)->ide_dma_end(drive);
+}

This is identical to __ide_dma_timeout().

+		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		count = 0;
+		do {
+			xide_delay(count);
+			ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+			count += 10;
+		} while ((ioc4_dma & IOC4_S_DMA_STOP) && (count < 100));

This is duplicated 3x (one time with "xide_delay()" and "hwif->INL()"
lines interchanged, maybe by a mistake?).

Can you make it a helper function, i.e. sgiioc4_ide_dma_stop_engine() ?

Thanks,
--bartlomiej

--Boundary-00=_nOwf/JhWnrfRCKf
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="ide-dma-sgiioc4-exports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-dma-sgiioc4-exports.patch"

 drivers/ide/arm/icside.c |    4 ++--
 drivers/ide/ide-dma.c    |   12 ++++++++----
 include/linux/ide.h      |    2 ++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff -puN drivers/ide/arm/icside.c~ide-dma-sgiioc4-exports drivers/ide/arm/icside.c
--- linux-2.6.0-test6-bk2/drivers/ide/arm/icside.c~ide-dma-sgiioc4-exports	2003-10-04 18:43:13.746819240 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/arm/icside.c	2003-10-04 18:43:50.765191592 +0200
@@ -214,7 +214,7 @@ static void icside_maskproc(ide_drive_t 
 #define NR_ENTRIES 256
 #define TABLE_SIZE (NR_ENTRIES * 8)
 
-static void ide_build_sglist(ide_drive_t *drive, struct request *rq)
+static void icside_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct icside_state *state = hwif->hwif_data;
@@ -543,7 +543,7 @@ icside_dma_common(ide_drive_t *drive, st
 	BUG_ON(hwif->sg_dma_active);
 	BUG_ON(dma_channel_active(hwif->hw.dma));
 
-	ide_build_sglist(drive, rq);
+	icside_build_sglist(drive, rq);
 
 	/*
 	 * Ensure that we have the right interrupt routed.
diff -puN drivers/ide/ide-dma.c~ide-dma-sgiioc4-exports drivers/ide/ide-dma.c
--- linux-2.6.0-test6-bk2/drivers/ide/ide-dma.c~ide-dma-sgiioc4-exports	2003-10-04 18:43:19.635923960 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/ide-dma.c	2003-10-04 18:45:28.323360496 +0200
@@ -200,8 +200,8 @@ EXPORT_SYMBOL_GPL(ide_dma_intr);
  *	kernel provide the necessary cache management so that we can
  *	operate in a portable fashion
  */
- 
-static int ide_build_sglist (ide_drive_t *drive, struct request *rq)
+
+int ide_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
@@ -220,6 +220,8 @@ static int ide_build_sglist (ide_drive_t
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
+EXPORT_SYMBOL_GPL(ide_build_sglist);
+
 /**
  *	ide_raw_build_sglist	-	map IDE scatter gather for DMA
  *	@drive: the drive to build the DMA table for
@@ -230,8 +232,8 @@ static int ide_build_sglist (ide_drive_t
  *	of the  kernel provide the necessary cache management so that we can
  *	operate in a portable fashion
  */
- 
-static int ide_raw_build_sglist (ide_drive_t *drive, struct request *rq)
+
+int ide_raw_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
@@ -270,6 +272,8 @@ static int ide_raw_build_sglist (ide_dri
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
+EXPORT_SYMBOL_GPL(ide_raw_build_sglist);
+
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
diff -puN include/linux/ide.h~ide-dma-sgiioc4-exports include/linux/ide.h
--- linux-2.6.0-test6-bk2/include/linux/ide.h~ide-dma-sgiioc4-exports	2003-10-04 18:43:32.105028368 +0200
+++ linux-2.6.0-test6-bk2-root/include/linux/ide.h	2003-10-04 18:47:04.251777160 +0200
@@ -1695,6 +1695,8 @@ extern void ide_setup_pci_devices(struct
 #define GOOD_DMA_DRIVE		1
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+extern int ide_build_sglist(ide_drive_t *, struct request *);
+extern int ide_raw_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);

_

--Boundary-00=_nOwf/JhWnrfRCKf--

