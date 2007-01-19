Return-Path: <linux-kernel-owner+w=401wt.eu-S932675AbXASA2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbXASA2j (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbXASA2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:28:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675AbXASA2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=WYe2Q+4BRTmVLk9oQoVDU8BzVXh/Q406ncEkh/21WdDTCX9sF5uM69m8L/KzlNskYpyV2B/wcfYkeTSrOxYd6okgip5RRhLIHeHkLlOlK/YqA1DRcrXFHtIZ1LSewfbpR/qeRlovSw9AJ0K2Dk4sfa1NmuQH6PxE+Pb0TDZYc58=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:13 +0100
Message-Id: <20070119003213.14846.1366.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 11/15] ide: make ide_hwif_t.ide_dma_{host_off,off_quietly} void
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: make ide_hwif_t.ide_dma_{host_off,off_quietly} void

* since ide_hwif_t.ide_dma_{host_off,off_quietly} always return '0'
  make these functions void and while at it drop "ide_" prefix
* fix comment for __ide_dma_off_quietly()
* make __ide_dma_{host_off,off_quietly,off}() void and drop "__" prefix

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/icside.c      |   10 ++++------
 drivers/ide/cris/ide-cris.c   |   14 ++++++--------
 drivers/ide/ide-cd.c          |    6 +++---
 drivers/ide/ide-dma.c         |   39 ++++++++++++++++++---------------------
 drivers/ide/ide-floppy.c      |    8 ++++----
 drivers/ide/ide-io.c          |    2 +-
 drivers/ide/ide-iops.c        |    8 ++++----
 drivers/ide/ide-probe.c       |    2 +-
 drivers/ide/ide-tape.c        |    4 ++--
 drivers/ide/ide.c             |   10 ++++------
 drivers/ide/mips/au1xxx-ide.c |   11 ++++-------
 drivers/ide/pci/atiixp.c      |    6 +++---
 drivers/ide/pci/cs5530.c      |    2 +-
 drivers/ide/pci/it821x.c      |    2 +-
 drivers/ide/pci/sc1200.c      |    6 +++---
 drivers/ide/pci/sgiioc4.c     |   14 +++++---------
 drivers/ide/pci/sl82c105.c    |   14 ++++++--------
 drivers/ide/ppc/pmac.c        |    8 +++-----
 include/linux/ide.h           |   12 ++++++------
 19 files changed, 79 insertions(+), 99 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -307,15 +307,13 @@ static int icside_set_speed(ide_drive_t 
 	return on;
 }
 
-static int icside_dma_host_off(ide_drive_t *drive)
+static void icside_dma_host_off(ide_drive_t *drive)
 {
-	return 0;
 }
 
-static int icside_dma_off_quietly(ide_drive_t *drive)
+static void icside_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
-	return icside_dma_host_off(drive);
 }
 
 static int icside_dma_host_on(ide_drive_t *drive)
@@ -494,8 +492,8 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->autodma		= autodma;
 
 	hwif->ide_dma_check	= icside_dma_check;
-	hwif->ide_dma_host_off	= icside_dma_host_off;
-	hwif->ide_dma_off_quietly = icside_dma_off_quietly;
+	hwif->dma_host_off	= icside_dma_host_off;
+	hwif->dma_off_quietly	= icside_dma_off_quietly;
 	hwif->ide_dma_host_on	= icside_dma_host_on;
 	hwif->ide_dma_on	= icside_dma_on;
 	hwif->dma_setup		= icside_dma_setup;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -682,9 +682,12 @@ static void cris_ide_input_data (ide_dri
 static void cris_ide_output_data (ide_drive_t *drive, void *, unsigned int);
 static void cris_atapi_input_bytes(ide_drive_t *drive, void *, unsigned int);
 static void cris_atapi_output_bytes(ide_drive_t *drive, void *, unsigned int);
-static int cris_dma_off (ide_drive_t *drive);
 static int cris_dma_on (ide_drive_t *drive);
 
+static void cris_dma_off(ide_drive_t *drive)
+{
+}
+
 static void tune_cris_ide(ide_drive_t *drive, u8 pio)
 {
 	int setup, strobe, hold;
@@ -814,9 +817,9 @@ init_e100_ide (void)
 		hwif->OUTBSYNC = &cris_ide_outbsync;
 		hwif->INB = &cris_ide_inb;
 		hwif->INW = &cris_ide_inw;
-		hwif->ide_dma_host_off = &cris_dma_off;
+		hwif->dma_host_off = &cris_dma_off;
 		hwif->ide_dma_host_on = &cris_dma_on;
-		hwif->ide_dma_off_quietly = &cris_dma_off;
+		hwif->dma_off_quietly = &cris_dma_off;
 		hwif->udma_four = 0;
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
@@ -838,11 +841,6 @@ init_e100_ide (void)
 	cris_ide_set_speed(TYPE_UDMA, ATA_UDMA2_CYC, ATA_UDMA2_DVS, 0);
 }
 
-static int cris_dma_off (ide_drive_t *drive)
-{
-	return 0;
-}
-
 static int cris_dma_on (ide_drive_t *drive)
 {
 	return 0;
Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1103,7 +1103,7 @@ static ide_startstop_t cdrom_read_intr (
 	if (dma) {
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive)))
-			__ide_dma_off(drive);
+			ide_dma_off(drive);
 	}
 
 	if (cdrom_decode_status(drive, 0, &stat))
@@ -1699,7 +1699,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	if (dma) {
 		if (dma_error) {
 			printk(KERN_ERR "ide-cd: dma error\n");
-			__ide_dma_off(drive);
+			ide_dma_off(drive);
 			return ide_error(drive, "dma error", stat);
 		}
 
@@ -1825,7 +1825,7 @@ static ide_startstop_t cdrom_write_intr(
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
 			printk(KERN_ERR "ide-cd: write dma error\n");
-			__ide_dma_off(drive);
+			ide_dma_off(drive);
 		}
 	}
 
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -414,61 +414,57 @@ static int dma_timer_expiry (ide_drive_t
 }
 
 /**
- *	__ide_dma_host_off	-	Generic DMA kill
+ *	ide_dma_host_off	-	Generic DMA kill
  *	@drive: drive to control
  *
  *	Perform the generic IDE controller DMA off operation. This
  *	works for most IDE bus mastering controllers
  */
 
-int __ide_dma_host_off (ide_drive_t *drive)
+void ide_dma_host_off(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 dma_stat		= hwif->INB(hwif->dma_status);
 
 	hwif->OUTB((dma_stat & ~(1<<(5+unit))), hwif->dma_status);
-	return 0;
 }
 
-EXPORT_SYMBOL(__ide_dma_host_off);
+EXPORT_SYMBOL(ide_dma_host_off);
 
 /**
- *	__ide_dma_host_off_quietly	-	Generic DMA kill
+ *	ide_dma_off_quietly	-	Generic DMA kill
  *	@drive: drive to control
  *
  *	Turn off the current DMA on this IDE controller. 
  */
 
-int __ide_dma_off_quietly (ide_drive_t *drive)
+void ide_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
 	ide_toggle_bounce(drive, 0);
 
-	if (HWIF(drive)->ide_dma_host_off(drive))
-		return 1;
-
-	return 0;
+	drive->hwif->dma_host_off(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_off_quietly);
+EXPORT_SYMBOL(ide_dma_off_quietly);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 /**
- *	__ide_dma_off	-	disable DMA on a device
+ *	ide_dma_off	-	disable DMA on a device
  *	@drive: drive to disable DMA on
  *
  *	Disable IDE DMA for a device on this IDE controller.
  *	Inform the user that DMA has been disabled.
  */
 
-int __ide_dma_off (ide_drive_t *drive)
+void ide_dma_off(ide_drive_t *drive)
 {
 	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+	drive->hwif->dma_off_quietly(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_off);
+EXPORT_SYMBOL(ide_dma_off);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
@@ -758,7 +754,7 @@ void ide_dma_verbose(ide_drive_t *drive)
 	return;
 bug_dma_off:
 	printk(", BUG DMA OFF");
-	hwif->ide_dma_off_quietly(drive);
+	hwif->dma_off_quietly(drive);
 	return;
 }
 
@@ -773,7 +769,8 @@ int ide_set_dma(ide_drive_t *drive)
 
 	switch(rc) {
 	case -1: /* DMA needs to be disabled */
-		return hwif->ide_dma_off_quietly(drive);
+		hwif->dma_off_quietly(drive);
+		return 0;
 	case  0: /* DMA needs to be enabled */
 		return hwif->ide_dma_on(drive);
 	case  1: /* DMA setting cannot be changed */
@@ -937,10 +934,10 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 	if (!(hwif->dma_prdtable))
 		hwif->dma_prdtable	= (hwif->dma_base + 4);
 
-	if (!hwif->ide_dma_off_quietly)
-		hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
-	if (!hwif->ide_dma_host_off)
-		hwif->ide_dma_host_off = &__ide_dma_host_off;
+	if (!hwif->dma_off_quietly)
+		hwif->dma_off_quietly = &ide_dma_off_quietly;
+	if (!hwif->dma_host_off)
+		hwif->dma_host_off = &ide_dma_host_off;
 	if (!hwif->ide_dma_on)
 		hwif->ide_dma_on = &__ide_dma_on;
 	if (!hwif->ide_dma_host_on)
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -867,7 +867,7 @@ static ide_startstop_t idefloppy_pc_intr
 	if (test_and_clear_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
 		printk(KERN_ERR "ide-floppy: The floppy wants to issue "
 			"more interrupts in DMA mode\n");
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
 
@@ -1097,9 +1097,9 @@ static ide_startstop_t idefloppy_issue_p
 	pc->current_position = pc->buffer;
 	bcount.all = min(pc->request_transfer, 63 * 1024);
 
-	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
-		(void)__ide_dma_off(drive);
-	}
+	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags))
+		ide_dma_off(drive);
+
 	feature.all = 0;
 
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1351,7 +1351,7 @@ static ide_startstop_t ide_dma_timeout_r
 	 */
 	drive->retry_pio++;
 	drive->state = DMA_PIO_RETRY;
-	(void) hwif->ide_dma_off_quietly(drive);
+	hwif->dma_off_quietly(drive);
 
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -753,7 +753,7 @@ int ide_config_drive_speed (ide_drive_t 
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->ide_dma_check)	 /* check if host supports DMA */
-		hwif->ide_dma_host_off(drive);
+		hwif->dma_host_off(drive);
 #endif
 
 	/*
@@ -832,7 +832,7 @@ int ide_config_drive_speed (ide_drive_t 
 	if (speed >= XFER_SW_DMA_0)
 		hwif->ide_dma_host_on(drive);
 	else if (hwif->ide_dma_check)	/* check if host supports DMA */
-		hwif->ide_dma_off_quietly(drive);
+		hwif->dma_off_quietly(drive);
 #endif
 
 	switch(speed) {
@@ -1042,12 +1042,12 @@ static void check_dma_crc(ide_drive_t *d
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->crc_count) {
-		(void) HWIF(drive)->ide_dma_off_quietly(drive);
+		drive->hwif->dma_off_quietly(drive);
 		ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
 		if (drive->current_speed >= XFER_SW_DMA_0)
 			(void) HWIF(drive)->ide_dma_on(drive);
 	} else
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 #endif
 }
 
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -853,7 +853,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 				 * things, if not checked and cleared.
 				 *   PARANOIA!!!
 				 */
-				hwif->ide_dma_off_quietly(drive);
+				hwif->dma_off_quietly(drive);
 #ifdef CONFIG_IDEDMA_ONLYDISK
 				if (drive->media == ide_disk)
 #endif
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1970,7 +1970,7 @@ static ide_startstop_t idetape_pc_intr (
 		printk(KERN_ERR "ide-tape: The tape wants to issue more "
 				"interrupts in DMA mode\n");
 		printk(KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
 	/* Get the number of bytes to transfer on this interrupt. */
@@ -2176,7 +2176,7 @@ static ide_startstop_t idetape_issue_pac
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
 		printk(KERN_WARNING "ide-tape: DMA disabled, "
 				"reverting to PIO\n");
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 	}
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
 		dma_ok = !hwif->dma_setup(drive);
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -506,10 +506,10 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
 	hwif->ide_dma_check		= tmp_hwif->ide_dma_check;
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
-	hwif->ide_dma_off_quietly	= tmp_hwif->ide_dma_off_quietly;
+	hwif->dma_off_quietly		= tmp_hwif->dma_off_quietly;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
 	hwif->ide_dma_host_on		= tmp_hwif->ide_dma_host_on;
-	hwif->ide_dma_host_off		= tmp_hwif->ide_dma_host_off;
+	hwif->dma_host_off		= tmp_hwif->dma_host_off;
 	hwif->ide_dma_lostirq		= tmp_hwif->ide_dma_lostirq;
 	hwif->ide_dma_timeout		= tmp_hwif->ide_dma_timeout;
 
@@ -1137,10 +1137,8 @@ static int set_using_dma (ide_drive_t *d
 		if (ide_set_dma(drive))
 			return -EIO;
 		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
-	} else {
-		if (__ide_dma_off(drive))
-			return -EIO;
-	}
+	} else
+		ide_dma_off(drive);
 	return 0;
 #else
 	return -EPERM;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -449,16 +449,13 @@ static int auide_dma_on(ide_drive_t *dri
 	return auide_dma_host_on(drive);
 }
 
-
-static int auide_dma_host_off(ide_drive_t *drive)
+static void auide_dma_host_off(ide_drive_t *drive)
 {
-	return 0;
 }
 
-static int auide_dma_off_quietly(ide_drive_t *drive)
+static void auide_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
-	return auide_dma_host_off(drive);
 }
 
 static int auide_dma_lostirq(ide_drive_t *drive)
@@ -724,7 +721,7 @@ static int au_ide_probe(struct device *d
 	hwif->speedproc                 = &auide_tune_chipset;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-	hwif->ide_dma_off_quietly       = &auide_dma_off_quietly;
+	hwif->dma_off_quietly		= &auide_dma_off_quietly;
 	hwif->ide_dma_timeout           = &auide_dma_timeout;
 
 	hwif->ide_dma_check             = &auide_dma_check;
@@ -733,7 +730,7 @@ static int au_ide_probe(struct device *d
 	hwif->ide_dma_end               = &auide_dma_end;
 	hwif->dma_setup                 = &auide_dma_setup;
 	hwif->ide_dma_test_irq          = &auide_dma_test_irq;
-	hwif->ide_dma_host_off          = &auide_dma_host_off;
+	hwif->dma_host_off		= &auide_dma_host_off;
 	hwif->ide_dma_host_on           = &auide_dma_host_on;
 	hwif->ide_dma_lostirq           = &auide_dma_lostirq;
 	hwif->ide_dma_on                = &auide_dma_on;
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -121,7 +121,7 @@ static int atiixp_ide_dma_host_on(ide_dr
 	return __ide_dma_host_on(drive);
 }
 
-static int atiixp_ide_dma_host_off(ide_drive_t *drive)
+static void atiixp_ide_dma_host_off(ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
 	unsigned long flags;
@@ -135,7 +135,7 @@ static int atiixp_ide_dma_host_off(ide_d
 
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 
-	return __ide_dma_host_off(drive);
+	ide_dma_host_off(drive);
 }
 
 /**
@@ -306,7 +306,7 @@ static void __devinit init_hwif_atiixp(i
 		hwif->udma_four = 0;
 
 	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
-	hwif->ide_dma_host_off = &atiixp_ide_dma_host_off;
+	hwif->dma_host_off = &atiixp_ide_dma_host_off;
 	hwif->ide_dma_check = &atiixp_dma_check;
 	if (!noautodma)
 		hwif->autodma = 1;
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -109,7 +109,7 @@ static int cs5530_config_dma (ide_drive_
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
-	hwif->ide_dma_off_quietly(drive);
+	hwif->dma_off_quietly(drive);
 
 	/*
 	 * The CS5530 specifies that two drives sharing a cable cannot
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -606,7 +606,7 @@ static void __devinit it821x_fixups(ide_
 				printk(".\n");
 			/* Now the core code will have wrongly decided no DMA
 			   so we need to fix this */
-			hwif->ide_dma_off_quietly(drive);
+			hwif->dma_off_quietly(drive);
 #ifdef CONFIG_IDEDMA_ONLYDISK
 			if (drive->media == ide_disk)
 #endif
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -161,7 +161,7 @@ static int sc1200_config_dma2 (ide_drive
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
-	hwif->ide_dma_off_quietly(drive);			/* turn off DMA while we fiddle */
+	hwif->dma_off_quietly(drive);	/* turn off DMA while we fiddle */
 	outb(inb(hwif->dma_base+2)&~(unit?0x40:0x20), hwif->dma_base+2); /* clear DMA_capable bit */
 
 	/*
@@ -439,10 +439,10 @@ static int sc1200_resume (struct pci_dev
 			ide_drive_t *drive = &(hwif->drives[d]);
 			if (drive->present && !__ide_dma_bad_drive(drive)) {
 				int was_using_dma = drive->using_dma;
-				hwif->ide_dma_off_quietly(drive);
+				hwif->dma_off_quietly(drive);
 				sc1200_config_dma(drive);
 				if (!was_using_dma && drive->using_dma) {
-					hwif->ide_dma_off_quietly(drive);
+					hwif->dma_off_quietly(drive);
 				}
 			}
 		}
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -282,12 +282,11 @@ sgiioc4_ide_dma_on(ide_drive_t * drive)
 	return HWIF(drive)->ide_dma_host_on(drive);
 }
 
-static int
-sgiioc4_ide_dma_off_quietly(ide_drive_t * drive)
+static void sgiioc4_ide_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
 
-	return HWIF(drive)->ide_dma_host_off(drive);
+	drive->hwif->dma_host_off(drive);
 }
 
 static int sgiioc4_ide_dma_check(ide_drive_t *drive)
@@ -317,12 +316,9 @@ sgiioc4_ide_dma_host_on(ide_drive_t * dr
 	return 1;
 }
 
-static int
-sgiioc4_ide_dma_host_off(ide_drive_t * drive)
+static void sgiioc4_ide_dma_host_off(ide_drive_t * drive)
 {
 	sgiioc4_clearirq(drive);
-
-	return 0;
 }
 
 static int
@@ -612,10 +608,10 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
 	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
-	hwif->ide_dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
+	hwif->dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
-	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
+	hwif->dma_host_off = &sgiioc4_ide_dma_host_off;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -261,26 +261,24 @@ static int sl82c105_ide_dma_on (ide_driv
 
 	if (config_for_dma(drive)) {
 		config_for_pio(drive, 4, 0, 0);
-		return HWIF(drive)->ide_dma_off_quietly(drive);
+		drive->hwif->dma_off_quietly(drive);
+		return 0;
 	}
 	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
 	return __ide_dma_on(drive);
 }
 
-static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
+static void sl82c105_ide_dma_off_quietly(ide_drive_t *drive)
 {
 	u8 speed = XFER_PIO_0;
-	int rc;
-	
+
 	DBG(("sl82c105_ide_dma_off_quietly(drive:%s)\n", drive->name));
 
-	rc = __ide_dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 	if (drive->pio_speed)
 		speed = drive->pio_speed - XFER_PIO_0;
 	config_for_pio(drive, speed, 0, 1);
 	drive->current_speed = drive->pio_speed;
-
-	return rc;
 }
 
 /*
@@ -449,7 +447,7 @@ static void __devinit init_hwif_sl82c105
 
 		hwif->ide_dma_check = &sl82c105_check_drive;
 		hwif->ide_dma_on = &sl82c105_ide_dma_on;
-		hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
+		hwif->dma_off_quietly = &sl82c105_ide_dma_off_quietly;
 		hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
 		hwif->dma_start = &sl82c105_ide_dma_start;
 		hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1980,10 +1980,8 @@ pmac_ide_dma_test_irq (ide_drive_t *driv
 	return 1;
 }
 
-static int
-pmac_ide_dma_host_off (ide_drive_t *drive)
+static void pmac_ide_dma_host_off(ide_drive_t *drive)
 {
-	return 0;
 }
 
 static int
@@ -2035,7 +2033,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 		return;
 	}
 
-	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
+	hwif->dma_off_quietly = &ide_dma_off_quietly;
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
 	hwif->dma_setup = &pmac_ide_dma_setup;
@@ -2043,7 +2041,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->dma_start = &pmac_ide_dma_start;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
-	hwif->ide_dma_host_off = &pmac_ide_dma_host_off;
+	hwif->dma_host_off = &pmac_ide_dma_host_off;
 	hwif->ide_dma_host_on = &pmac_ide_dma_host_on;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -735,10 +735,10 @@ typedef struct hwif_s {
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_check)(ide_drive_t *drive);
 	int (*ide_dma_on)(ide_drive_t *drive);
-	int (*ide_dma_off_quietly)(ide_drive_t *drive);
+	void (*dma_off_quietly)(ide_drive_t *);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
-	int (*ide_dma_host_off)(ide_drive_t *drive);
+	void (*dma_host_off)(ide_drive_t *);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
 
@@ -1276,7 +1276,7 @@ int ide_in_drive_list(struct hd_driveid 
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
 int ide_use_dma(ide_drive_t *);
-int __ide_dma_off(ide_drive_t *);
+void ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
@@ -1288,8 +1288,8 @@ extern void ide_destroy_dmatable(ide_dri
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
 
-extern int __ide_dma_host_off(ide_drive_t *);
-extern int __ide_dma_off_quietly(ide_drive_t *);
+void ide_dma_host_off(ide_drive_t *);
+void ide_dma_off_quietly(ide_drive_t *);
 extern int __ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
 extern int __ide_dma_check(ide_drive_t *);
@@ -1302,7 +1302,7 @@ extern int __ide_dma_timeout(ide_drive_t
 
 #else
 static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
-static inline int __ide_dma_off(ide_drive_t *drive) { return 0; }
+static inline void ide_dma_off(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
