Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUBIOuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUBIOuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:50:00 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42980 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265267AbUBIOs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:48:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] make __ide_dma_off() generic and remove ide_hwif_t->ide_dma_off
Date: Mon, 9 Feb 2004 15:54:15 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402091554.16016.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental to "[PATCH] remove __ide_dma_count() and ide_hwif_t->ide_dma_count".

Move ide-dma.c:__ide_dma_off() outside of #ifdef CONFIG_BLK_DEV_IDEDMA_PCI,
so it can be used for all DMA capable hosts.  Remove ide_hwif_t->ide_dma_off.

 linux-2.6.3-rc1-bk1-root/drivers/ide/arm/icside.c   |    7 -------
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-cd.c       |    6 +++---
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-dma.c      |   14 +++++++-------
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-floppy.c   |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-iops.c     |    2 +-
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-tape.c     |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide.c          |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sgiioc4.c  |    9 ---------
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sl82c105.c |   17 -----------------
 linux-2.6.3-rc1-bk1-root/drivers/ide/ppc/pmac.c     |    1 -
 linux-2.6.3-rc1-bk1-root/include/linux/ide.h        |    4 +---
 11 files changed, 18 insertions(+), 54 deletions(-)

diff -puN drivers/ide/arm/icside.c~ide_dma_off_cleanup drivers/ide/arm/icside.c
--- linux-2.6.3-rc1-bk1/drivers/ide/arm/icside.c~ide_dma_off_cleanup	2004-02-09 15:46:54.387152496 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/arm/icside.c	2004-02-09 15:46:54.450142920 +0100
@@ -341,12 +341,6 @@ static int icside_dma_off_quietly(ide_dr
 	return icside_dma_host_off(drive);
 }
 
-static int icside_dma_off(ide_drive_t *drive)
-{
-	printk("%s: DMA disabled\n", drive->name);
-	return icside_dma_off_quietly(drive);
-}
-
 static int icside_dma_host_on(ide_drive_t *drive)
 {
 	return 0;
@@ -643,7 +637,6 @@ static int icside_dma_init(ide_hwif_t *h
 	hwif->ide_dma_check	= icside_dma_check;
 	hwif->ide_dma_host_off	= icside_dma_host_off;
 	hwif->ide_dma_off_quietly = icside_dma_off_quietly;
-	hwif->ide_dma_off	= icside_dma_off;
 	hwif->ide_dma_host_on	= icside_dma_host_on;
 	hwif->ide_dma_on	= icside_dma_on;
 	hwif->ide_dma_read	= icside_dma_read;
diff -puN drivers/ide/ide.c~ide_dma_off_cleanup drivers/ide/ide.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide.c~ide_dma_off_cleanup	2004-02-09 15:46:54.391151888 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide.c	2004-02-09 15:46:54.452142616 +0100
@@ -839,7 +839,6 @@ void ide_unregister (unsigned int index)
 	hwif->ide_dma_end		= old_hwif.ide_dma_end;
 	hwif->ide_dma_check		= old_hwif.ide_dma_check;
 	hwif->ide_dma_on		= old_hwif.ide_dma_on;
-	hwif->ide_dma_off		= old_hwif.ide_dma_off;
 	hwif->ide_dma_off_quietly	= old_hwif.ide_dma_off_quietly;
 	hwif->ide_dma_test_irq		= old_hwif.ide_dma_test_irq;
 	hwif->ide_dma_host_on		= old_hwif.ide_dma_host_on;
@@ -1329,7 +1328,8 @@ static int set_using_dma (ide_drive_t *d
 		if (HWIF(drive)->ide_dma_check(drive)) return -EIO;
 		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
 	} else {
-		if (HWIF(drive)->ide_dma_off(drive)) return -EIO;
+		if (__ide_dma_off(drive))
+			return -EIO;
 	}
 	return 0;
 }
diff -puN drivers/ide/ide-cd.c~ide_dma_off_cleanup drivers/ide/ide-cd.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-cd.c~ide_dma_off_cleanup	2004-02-09 15:46:54.395151280 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-cd.c	2004-02-09 15:46:54.456142008 +0100
@@ -1101,7 +1101,7 @@ static ide_startstop_t cdrom_read_intr (
 	if (dma) {
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive)))
-			HWIF(drive)->ide_dma_off(drive);
+			__ide_dma_off(drive);
 	}
 
 	if (cdrom_decode_status(drive, 0, &stat))
@@ -1720,7 +1720,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	if (dma) {
 		if (dma_error) {
 			printk("ide-cd: dma error\n");
-			HWIF(drive)->ide_dma_off(drive);
+			__ide_dma_off(drive);
 			return DRIVER(drive)->error(drive, "dma error", stat);
 		}
 
@@ -1847,7 +1847,7 @@ static ide_startstop_t cdrom_write_intr(
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
 			printk("ide-cd: write dma error\n");
-			HWIF(drive)->ide_dma_off(drive);
+			__ide_dma_off(drive);
 		}
 	}
 
diff -puN drivers/ide/ide-dma.c~ide_dma_off_cleanup drivers/ide/ide-dma.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-dma.c~ide_dma_off_cleanup	2004-02-09 15:46:54.412148696 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-dma.c	2004-02-09 15:46:54.458141704 +0100
@@ -414,7 +414,7 @@ static int config_drive_for_dma (ide_dri
 	if ((id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (__ide_dma_bad_drive(drive))
-			return hwif->ide_dma_off(drive);
+			return __ide_dma_off(drive);
 
 		/*
 		 * Enable DMA on any drive that has
@@ -520,13 +520,14 @@ int __ide_dma_off_quietly (ide_drive_t *
 }
 
 EXPORT_SYMBOL(__ide_dma_off_quietly);
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 /**
- *	__ide_dma_host_off	-	Generic DMA kill
- *	@drive: drive to control
+ *	__ide_dma_off	-	disable DMA on a device
+ *	@drive: drive to disable DMA on
  *
- *	Turn off the current DMA on this IDE controller. Inform the
- *	user that DMA has been disabled. 
+ *	Disable IDE DMA for a device on this IDE controller.
+ *	Inform the user that DMA has been disabled.
  */
 
 int __ide_dma_off (ide_drive_t *drive)
@@ -537,6 +538,7 @@ int __ide_dma_off (ide_drive_t *drive)
 
 EXPORT_SYMBOL(__ide_dma_off);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	__ide_dma_host_on	-	Enable DMA on a host
  *	@drive: drive to enable for DMA
@@ -1049,8 +1051,6 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 	if (!(hwif->dma_prdtable))
 		hwif->dma_prdtable	= (hwif->dma_base + 4);
 
-	if (!hwif->ide_dma_off)
-		hwif->ide_dma_off = &__ide_dma_off;
 	if (!hwif->ide_dma_off_quietly)
 		hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
 	if (!hwif->ide_dma_host_off)
diff -puN drivers/ide/ide-floppy.c~ide_dma_off_cleanup drivers/ide/ide-floppy.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-floppy.c~ide_dma_off_cleanup	2004-02-09 15:46:54.418147784 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-floppy.c	2004-02-09 15:46:54.460141400 +0100
@@ -830,7 +830,7 @@ static ide_startstop_t idefloppy_pc_intr
 	if (test_and_clear_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
 		printk(KERN_ERR "ide-floppy: The floppy wants to issue "
 			"more interrupts in DMA mode\n");
-		(void) HWIF(drive)->ide_dma_off(drive);
+		(void)__ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
 
@@ -1045,7 +1045,7 @@ static ide_startstop_t idefloppy_issue_p
 	bcount.all = min(pc->request_transfer, 63 * 1024);
 
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
-		(void) HWIF(drive)->ide_dma_off(drive);
+		(void)__ide_dma_off(drive);
 	}
 	feature.all = 0;
 
diff -puN drivers/ide/ide-iops.c~ide_dma_off_cleanup drivers/ide/ide-iops.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-iops.c~ide_dma_off_cleanup	2004-02-09 15:46:54.422147176 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-iops.c	2004-02-09 15:46:54.463140944 +0100
@@ -1130,7 +1130,7 @@ void check_dma_crc (ide_drive_t *drive)
 		if (drive->current_speed >= XFER_SW_DMA_0)
 			(void) HWIF(drive)->ide_dma_on(drive);
 	} else {
-		(void) HWIF(drive)->ide_dma_off(drive);
+		(void)__ide_dma_off(drive);
 	}
 }
 
diff -puN drivers/ide/ide-tape.c~ide_dma_off_cleanup drivers/ide/ide-tape.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-tape.c~ide_dma_off_cleanup	2004-02-09 15:46:54.427146416 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-tape.c	2004-02-09 15:46:54.470139880 +0100
@@ -2198,7 +2198,7 @@ static ide_startstop_t idetape_pc_intr (
 		printk(KERN_ERR "ide-tape: The tape wants to issue more "
 				"interrupts in DMA mode\n");
 		printk(KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
-		(void) HWIF(drive)->ide_dma_off(drive);
+		(void)__ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
 	/* Get the number of bytes to transfer on this interrupt. */
@@ -2411,7 +2411,7 @@ static ide_startstop_t idetape_issue_pac
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
 		printk(KERN_WARNING "ide-tape: DMA disabled, "
 				"reverting to PIO\n");
-		(void) HWIF(drive)->ide_dma_off(drive);
+		(void)__ide_dma_off(drive);
 	}
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
 		if (test_bit(PC_WRITING, &pc->flags))
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_off_cleanup drivers/ide/pci/sgiioc4.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sgiioc4.c~ide_dma_off_cleanup	2004-02-09 15:46:54.433145504 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sgiioc4.c	2004-02-09 15:46:54.471139728 +0100
@@ -303,14 +303,6 @@ sgiioc4_ide_dma_on(ide_drive_t * drive)
 }
 
 static int
-sgiioc4_ide_dma_off(ide_drive_t * drive)
-{
-	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-
-	return HWIF(drive)->ide_dma_off_quietly(drive);
-}
-
-static int
 sgiioc4_ide_dma_off_quietly(ide_drive_t * drive)
 {
 	drive->using_dma = 0;
@@ -644,7 +636,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
 	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
-	hwif->ide_dma_off = &sgiioc4_ide_dma_off;
 	hwif->ide_dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
diff -puN drivers/ide/pci/sl82c105.c~ide_dma_off_cleanup drivers/ide/pci/sl82c105.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sl82c105.c~ide_dma_off_cleanup	2004-02-09 15:46:54.437144896 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sl82c105.c	2004-02-09 15:46:54.472139576 +0100
@@ -272,22 +272,6 @@ static int sl82c105_ide_dma_on (ide_driv
 	return __ide_dma_on(drive);
 }
 
-static int sl82c105_ide_dma_off (ide_drive_t *drive)
-{
-	u8 speed = XFER_PIO_0;
-	int rc;
-	
-	DBG(("sl82c105_ide_dma_off(drive:%s)\n", drive->name));
-
-	rc = __ide_dma_off(drive);
-	if (drive->pio_speed)
-		speed = drive->pio_speed - XFER_PIO_0;
-	config_for_pio(drive, speed, 0, 1);
-	drive->current_speed = drive->pio_speed;
-
-	return rc;
-}
-
 static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
 {
 	u8 speed = XFER_PIO_0;
@@ -485,7 +469,6 @@ static void __init init_hwif_sl82c105(id
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->ide_dma_check = &sl82c105_check_drive;
 	hwif->ide_dma_on = &sl82c105_ide_dma_on;
-	hwif->ide_dma_off = &sl82c105_ide_dma_off;
 	hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
 	hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
 	hwif->ide_dma_begin = &sl82c105_ide_dma_begin;
diff -puN drivers/ide/ppc/pmac.c~ide_dma_off_cleanup drivers/ide/ppc/pmac.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ppc/pmac.c~ide_dma_off_cleanup	2004-02-09 15:46:54.440144440 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ppc/pmac.c	2004-02-09 15:46:54.474139272 +0100
@@ -2142,7 +2142,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 				    	pmif->dma_table_cpu, pmif->dma_table_dma);
 		return;
 	}
-	hwif->ide_dma_off = &__ide_dma_off;
 	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
diff -puN include/linux/ide.h~ide_dma_off_cleanup include/linux/ide.h
--- linux-2.6.3-rc1-bk1/include/linux/ide.h~ide_dma_off_cleanup	2004-02-09 15:46:54.447143376 +0100
+++ linux-2.6.3-rc1-bk1-root/include/linux/ide.h	2004-02-09 15:46:54.478138664 +0100
@@ -790,7 +790,6 @@ typedef struct ide_dma_ops_s {
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_check)(ide_drive_t *drive);
 	int (*ide_dma_on)(ide_drive_t *drive);
-	int (*ide_dma_off)(ide_drive_t *drive);
 	int (*ide_dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
@@ -926,7 +925,6 @@ typedef struct hwif_s {
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_check)(ide_drive_t *drive);
 	int (*ide_dma_on)(ide_drive_t *drive);
-	int (*ide_dma_off)(ide_drive_t *drive);
 	int (*ide_dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
@@ -1594,6 +1592,7 @@ extern void ide_setup_pci_devices(struct
 #ifdef CONFIG_BLK_DEV_IDEDMA
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
+int __ide_dma_off(ide_drive_t *);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 extern int ide_build_sglist(ide_drive_t *, struct request *);
@@ -1607,7 +1606,6 @@ extern int ide_start_dma(ide_hwif_t *, i
 
 extern int __ide_dma_host_off(ide_drive_t *);
 extern int __ide_dma_off_quietly(ide_drive_t *);
-extern int __ide_dma_off(ide_drive_t *);
 extern int __ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
 extern int __ide_dma_check(ide_drive_t *);

_

