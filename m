Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUILXrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUILXrP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUILXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:47:15 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:32233 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264377AbUILXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:41:05 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][3/3] ide: convert ide_hwif_t->ide_dma_begin() to ->dma_start()
Date: Mon, 13 Sep 2004 01:34:01 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Cc: "Mikael Starvik" <mikael.starvik@axis.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409130134.01477.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: convert ide_hwif_t->ide_dma_begin() to ->dma_start()

Make ->ide_dma_begin() functions void and rename them to ->dma_start().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk18-bzolnier/arch/cris/arch-v10/drivers/ide.c |    7 +++----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/arm/icside.c         |    5 ++---
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-cd.c             |    3 ++-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-disk.c           |    2 +-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-dma.c            |    9 ++++-----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-floppy.c         |    2 +-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-tape.c           |    2 +-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-taskfile.c       |    4 ++--
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide.c                |    2 +-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/hpt366.c         |    8 ++++----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/pdc202xx_old.c   |    6 +++---
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sgiioc4.c        |    7 ++-----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sl82c105.c       |    8 +++-----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/trm290.c         |    5 ++---
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ppc/pmac.c           |    8 +++-----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/scsi/ide-scsi.c          |    3 ++-
 linux-2.6.9-rc1-bk18-bzolnier/include/linux/ide.h              |    4 ++--
 17 files changed, 38 insertions(+), 47 deletions(-)

diff -puN arch/cris/arch-v10/drivers/ide.c~ide_dma_start arch/cris/arch-v10/drivers/ide.c
--- linux-2.6.9-rc1-bk18/arch/cris/arch-v10/drivers/ide.c~ide_dma_start	2004-09-13 00:04:35.266463160 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/arch/cris/arch-v10/drivers/ide.c	2004-09-13 00:04:35.362448568 +0200
@@ -208,7 +208,7 @@ etrax100_ide_inb(ide_ioreg_t reg)
 #define ATA_PIO0_HOLD    4
 
 static int e100_dma_check (ide_drive_t *drive);
-static int e100_dma_begin (ide_drive_t *drive);
+static void e100_dma_start(ide_drive_t *drive);
 static int e100_dma_end (ide_drive_t *drive);
 static void e100_ide_input_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_ide_output_data (ide_drive_t *drive, void *, unsigned int);
@@ -335,7 +335,7 @@ init_e100_ide (void)
                 hwif->ide_dma_end = &e100_dma_end;
 		hwif->dma_setup = &e100_dma_setup;
 		hwif->dma_exec_cmd = &e100_dma_exec_cmd;
-		hwif->ide_dma_begin = &e100_dma_begin;
+		hwif->dma_start = &e100_dma_start;
 		hwif->OUTB = &etrax100_ide_outb;
 		hwif->OUTW = &etrax100_ide_outw;
 		hwif->OUTBSYNC = &etrax100_ide_outbsync;
@@ -815,7 +815,7 @@ static int e100_dma_end(ide_drive_t *dri
 	return 0;
 }
 
-static int e100_dma_begin(ide_drive_t *drive)
+static void e100_dma_start(ide_drive_t *drive)
 {
 	if (e100_read_command) {
 		/* begin DMA */
@@ -872,5 +872,4 @@ static int e100_dma_begin(ide_drive_t *d
 
 		D(printk("dma write of %d bytes.\n", ata_tot_size));
 	}
-	return 0;
 }
diff -puN drivers/ide/arm/icside.c~ide_dma_start drivers/ide/arm/icside.c
--- linux-2.6.9-rc1-bk18/drivers/ide/arm/icside.c~ide_dma_start	2004-09-13 00:04:35.269462704 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/arm/icside.c	2004-09-13 00:04:35.363448416 +0200
@@ -404,14 +404,13 @@ static int icside_dma_end(ide_drive_t *d
 	return get_dma_residue(hwif->hw.dma) != 0;
 }
 
-static int icside_dma_begin(ide_drive_t *drive)
+static void icside_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 
 	/* We can not enable DMA on both channels simultaneously. */
 	BUG_ON(dma_channel_active(hwif->hw.dma));
 	enable_dma(hwif->hw.dma);
-	return 0;
 }
 
 /*
@@ -564,7 +563,7 @@ static int icside_dma_init(ide_hwif_t *h
 	hwif->ide_dma_on	= icside_dma_on;
 	hwif->dma_setup		= icside_dma_setup;
 	hwif->dma_exec_cmd	= icside_dma_exec_cmd;
-	hwif->ide_dma_begin	= icside_dma_begin;
+	hwif->dma_start		= icside_dma_start;
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
 	hwif->ide_dma_verbose	= icside_dma_verbose;
diff -puN drivers/ide/ide.c~ide_dma_start drivers/ide/ide.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide.c~ide_dma_start	2004-09-13 00:04:35.271462400 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide.c	2004-09-13 00:04:35.366447960 +0200
@@ -687,7 +687,7 @@ static void ide_hwif_restore(ide_hwif_t 
 
 	hwif->dma_setup			= tmp_hwif->dma_setup;
 	hwif->dma_exec_cmd		= tmp_hwif->dma_exec_cmd;
-	hwif->ide_dma_begin		= tmp_hwif->ide_dma_begin;
+	hwif->dma_start			= tmp_hwif->dma_start;
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
 	hwif->ide_dma_check		= tmp_hwif->ide_dma_check;
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
diff -puN drivers/ide/ide-cd.c~ide_dma_start drivers/ide/ide-cd.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-cd.c~ide_dma_start	2004-09-13 00:04:35.274461944 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-cd.c	2004-09-13 00:04:35.369447504 +0200
@@ -910,6 +910,7 @@ static ide_startstop_t cdrom_transfer_pa
 					  struct request *rq,
 					  ide_handler_t *handler)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	int cmd_len;
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
@@ -941,7 +942,7 @@ static ide_startstop_t cdrom_transfer_pa
 
 	/* Start the DMA if need be */
 	if (info->dma)
-		(void) HWIF(drive)->ide_dma_begin(drive);
+		hwif->dma_start(drive);
 
 	return ide_started;
 }
diff -puN drivers/ide/ide-disk.c~ide_dma_start drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-disk.c~ide_dma_start	2004-09-13 00:04:35.277461488 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-disk.c	2004-09-13 00:04:35.372447048 +0200
@@ -224,7 +224,7 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 					command = lba48 ? WIN_READ_EXT: WIN_READ;
 			}
 			hwif->dma_exec_cmd(drive, command);
-			hwif->ide_dma_begin(drive);
+			hwif->dma_start(drive);
 			return ide_started;
 		}
 		/* fallback to PIO */
diff -puN drivers/ide/ide-dma.c~ide_dma_start drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-dma.c~ide_dma_start	2004-09-13 00:04:35.279461184 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-dma.c	2004-09-13 00:04:35.373446896 +0200
@@ -641,7 +641,7 @@ static void ide_dma_exec_cmd(ide_drive_t
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
 }
 
-int __ide_dma_begin (ide_drive_t *drive)
+void ide_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_cmd		= hwif->INB(hwif->dma_command);
@@ -655,10 +655,9 @@ int __ide_dma_begin (ide_drive_t *drive)
 	hwif->OUTB(dma_cmd|1, hwif->dma_command);
 	hwif->dma = 1;
 	wmb();
-	return 0;
 }
 
-EXPORT_SYMBOL(__ide_dma_begin);
+EXPORT_SYMBOL_GPL(ide_dma_start);
 
 /* returns 1 on error, 0 otherwise */
 int __ide_dma_end (ide_drive_t *drive)
@@ -953,8 +952,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->dma_setup = &ide_dma_setup;
 	if (!hwif->dma_exec_cmd)
 		hwif->dma_exec_cmd = &ide_dma_exec_cmd;
-	if (!hwif->ide_dma_begin)
-		hwif->ide_dma_begin = &__ide_dma_begin;
+	if (!hwif->dma_start)
+		hwif->dma_start = &ide_dma_start;
 	if (!hwif->ide_dma_end)
 		hwif->ide_dma_end = &__ide_dma_end;
 	if (!hwif->ide_dma_test_irq)
diff -puN drivers/ide/ide-floppy.c~ide_dma_start drivers/ide/ide-floppy.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-floppy.c~ide_dma_start	2004-09-13 00:04:35.282460728 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-floppy.c	2004-09-13 00:04:35.376446440 +0200
@@ -1063,7 +1063,7 @@ static ide_startstop_t idefloppy_issue_p
 
 	if (feature.b.dma) {	/* Begin DMA, if necessary */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->ide_dma_begin(drive));
+		hwif->dma_start(drive);
 	}
 
 	/* Can we transfer the packet when we get the interrupt or wait? */
diff -puN drivers/ide/ide-tape.c~ide_dma_start drivers/ide/ide-tape.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-tape.c~ide_dma_start	2004-09-13 00:04:35.285460272 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-tape.c	2004-09-13 00:04:35.383445376 +0200
@@ -2067,7 +2067,7 @@ static ide_startstop_t idetape_transfer_
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	/* Begin DMA, if necessary */
 	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags))
-		(void) (HWIF(drive)->ide_dma_begin(drive));
+		hwif->dma_start(drive);
 #endif
 	/* Send the actual packet */
 	HWIF(drive)->atapi_output_bytes(drive, pc->c, 12);
diff -puN drivers/ide/ide-taskfile.c~ide_dma_start drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-taskfile.c~ide_dma_start	2004-09-13 00:04:35.288459816 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-taskfile.c	2004-09-13 00:04:35.384445224 +0200
@@ -184,7 +184,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		case WIN_IDENTIFY_DMA:
 			if (!hwif->dma_setup(drive)) {
 				hwif->dma_exec_cmd(drive, taskfile->command);
-				hwif->ide_dma_begin(drive);
+				hwif->dma_start(drive);
 				return ide_started;
 			}
 			break;
@@ -930,7 +930,7 @@ ide_startstop_t flagged_taskfile (ide_dr
 		case TASKFILE_IN_DMA:
 			hwif->dma_setup(drive);
 			hwif->dma_exec_cmd(drive, taskfile->command);
-			hwif->ide_dma_begin(drive);
+			hwif->dma_start(drive);
 			break;
 
 	        default:
diff -puN drivers/ide/pci/hpt366.c~ide_dma_start drivers/ide/pci/hpt366.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/hpt366.c~ide_dma_start	2004-09-13 00:04:35.290459512 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/hpt366.c	2004-09-13 00:04:35.386444920 +0200
@@ -577,7 +577,7 @@ static int hpt366_ide_dma_lostirq (ide_d
 	/* how about we flush and reset, mmmkay? */
 	pci_write_config_byte(dev, 0x51, 0x1F);
 	/* fall through to a reset */
-	case ide_dma_begin:
+	case dma_start:
 	case ide_dma_end:
 	/* reset the chips state over and over.. */
 	pci_write_config_byte(dev, 0x51, 0x13);
@@ -592,12 +592,12 @@ static void hpt370_clear_engine (ide_dri
 	udelay(10);
 }
 
-static int hpt370_ide_dma_begin (ide_drive_t *drive)
+static void hpt370_ide_dma_start(ide_drive_t *drive)
 {
 #ifdef HPT_RESET_STATE_ENGINE
 	hpt370_clear_engine(drive);
 #endif
-	return __ide_dma_begin(drive);
+	ide_dma_start(drive);
 }
 
 static int hpt370_ide_dma_end (ide_drive_t *drive)
@@ -1230,7 +1230,7 @@ static void __devinit init_hwif_hpt366(i
 		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
 	} else if (hpt_minimum_revision(dev,3)) {
-		hwif->ide_dma_begin = &hpt370_ide_dma_begin;
+		hwif->dma_start = &hpt370_ide_dma_start;
 		hwif->ide_dma_end = &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout = &hpt370_ide_dma_timeout;
 		hwif->ide_dma_lostirq = &hpt370_ide_dma_lostirq;
diff -puN drivers/ide/pci/pdc202xx_old.c~ide_dma_start drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/pdc202xx_old.c~ide_dma_start	2004-09-13 00:04:35.293459056 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/pdc202xx_old.c	2004-09-13 00:04:35.387444768 +0200
@@ -505,7 +505,7 @@ static int pdc202xx_quirkproc (ide_drive
 	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
 }
 
-static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
+static void pdc202xx_old_ide_dma_start(ide_drive_t *drive)
 {
 	if (drive->current_speed > XFER_UDMA_2)
 		pdc_old_enable_66MHz_clock(drive->hwif);
@@ -526,7 +526,7 @@ static int pdc202xx_old_ide_dma_begin(id
 					word_count | 0x06000000;
 		hwif->OUTL(word_count, atapi_reg);
 	}
-	return __ide_dma_begin(drive);
+	ide_dma_start(drive);
 }
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
@@ -747,7 +747,7 @@ static void __devinit init_hwif_pdc202xx
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
 		if (!(hwif->udma_four))
 			hwif->udma_four = (pdc202xx_old_cable_detect(hwif)) ? 0 : 1;
-		hwif->ide_dma_begin = &pdc202xx_old_ide_dma_begin;
+		hwif->dma_start = &pdc202xx_old_ide_dma_start;
 		hwif->ide_dma_end = &pdc202xx_old_ide_dma_end;
 	} 
 	hwif->ide_dma_test_irq = &pdc202xx_old_ide_dma_test_irq;
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_start drivers/ide/pci/sgiioc4.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/sgiioc4.c~ide_dma_start	2004-09-13 00:04:35.296458600 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sgiioc4.c	2004-09-13 00:04:35.389444464 +0200
@@ -192,16 +192,13 @@ sgiioc4_clearirq(ide_drive_t * drive)
 	return intr_reg & 3;
 }
 
-static int
-sgiioc4_ide_dma_begin(ide_drive_t * drive)
+static void sgiioc4_ide_dma_start(ide_drive_t * drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned int reg = hwif->INL(hwif->dma_base + IOC4_DMA_CTRL * 4);
 	unsigned int temp_reg = reg | IOC4_S_DMA_START;
 
 	hwif->OUTL(temp_reg, hwif->dma_base + IOC4_DMA_CTRL * 4);
-
-	return 0;
 }
 
 static u32
@@ -626,7 +623,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->busproc = NULL;
 
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
-	hwif->ide_dma_begin = &sgiioc4_ide_dma_begin;
+	hwif->dma_start = &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
 	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
diff -puN drivers/ide/pci/sl82c105.c~ide_dma_start drivers/ide/pci/sl82c105.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/sl82c105.c~ide_dma_start	2004-09-13 00:04:35.298458296 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sl82c105.c	2004-09-13 00:04:35.390444312 +0200
@@ -236,15 +236,13 @@ static int sl82c105_ide_dma_lost_irq(ide
  * The generic IDE core will have disabled the BMEN bit before this
  * function is called.
  */
-static int sl82c105_ide_dma_begin(ide_drive_t *drive)
+static void sl82c105_ide_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
 
-//	DBG(("sl82c105_ide_dma_begin(drive:%s)\n", drive->name));
-
 	sl82c105_reset_host(dev);
-	return __ide_dma_begin(drive);
+	ide_dma_start(drive);
 }
 
 static int sl82c105_ide_dma_timeout(ide_drive_t *drive)
@@ -469,7 +467,7 @@ static void __init init_hwif_sl82c105(id
 	hwif->ide_dma_on = &sl82c105_ide_dma_on;
 	hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
 	hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
-	hwif->ide_dma_begin = &sl82c105_ide_dma_begin;
+	hwif->dma_start = &sl82c105_ide_dma_start;
 	hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
 
 	if (!noautodma)
diff -puN drivers/ide/pci/trm290.c~ide_dma_start drivers/ide/pci/trm290.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/trm290.c~ide_dma_start	2004-09-13 00:04:35.301457840 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/trm290.c	2004-09-13 00:04:35.391444160 +0200
@@ -220,9 +220,8 @@ static int trm290_ide_dma_setup(ide_driv
 	return 0;
 }
 
-static int trm290_ide_dma_begin (ide_drive_t *drive)
+static void trm290_ide_dma_start(ide_drive_t *drive)
 {
-	return 0;
 }
 
 static int trm290_ide_dma_end (ide_drive_t *drive)
@@ -295,7 +294,7 @@ void __devinit init_hwif_trm290(ide_hwif
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->dma_setup = &trm290_ide_dma_setup;
 	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
-	hwif->ide_dma_begin = &trm290_ide_dma_begin;
+	hwif->dma_start = &trm290_ide_dma_start;
 	hwif->ide_dma_end = &trm290_ide_dma_end;
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
diff -puN drivers/ide/ppc/pmac.c~ide_dma_start drivers/ide/ppc/pmac.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ppc/pmac.c~ide_dma_start	2004-09-13 00:04:35.303457536 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ppc/pmac.c	2004-09-13 00:04:35.395443552 +0200
@@ -362,7 +362,6 @@ static int pmac_ide_tune_chipset(ide_dri
 static void pmac_ide_tuneproc(ide_drive_t *drive, u8 pio);
 static void pmac_ide_selectproc(ide_drive_t *drive);
 static void pmac_ide_kauai_selectproc(ide_drive_t *drive);
-static int pmac_ide_dma_begin (ide_drive_t *drive);
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
@@ -1927,8 +1926,8 @@ pmac_ide_dma_exec_cmd(ide_drive_t *drive
  * Kick the DMA controller into life after the DMA command has been issued
  * to the drive.
  */
-static int __pmac
-pmac_ide_dma_begin (ide_drive_t *drive)
+static void __pmac
+pmac_ide_dma_start(ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	volatile struct dbdma_regs *dma;
@@ -1938,7 +1937,6 @@ pmac_ide_dma_begin (ide_drive_t *drive)
 	writel((RUN << 16) | RUN, &dma->control);
 	/* Make sure it gets to the controller right now */
 	(void)readl(&dma->control);
-	return 0;
 }
 
 /*
@@ -2096,7 +2094,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_check = &pmac_ide_dma_check;
 	hwif->dma_setup = &pmac_ide_dma_setup;
 	hwif->dma_exec_dma = &pmac_ide_dma_exec_cmd;
-	hwif->ide_dma_begin = &pmac_ide_dma_begin;
+	hwif->dma_start = &pmac_ide_dma_start;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
 	hwif->ide_dma_host_off = &pmac_ide_dma_host_off;
diff -puN drivers/scsi/ide-scsi.c~ide_dma_start drivers/scsi/ide-scsi.c
--- linux-2.6.9-rc1-bk18/drivers/scsi/ide-scsi.c~ide_dma_start	2004-09-13 00:04:35.305457232 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/scsi/ide-scsi.c	2004-09-13 00:04:35.397443248 +0200
@@ -552,6 +552,7 @@ static ide_startstop_t idescsi_pc_intr (
 
 static ide_startstop_t idescsi_transfer_pc(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t *pc = scsi->pc;
 	atapi_ireason_t ireason;
@@ -576,7 +577,7 @@ static ide_startstop_t idescsi_transfer_
 	atapi_output_bytes(drive, scsi->pc->c, 12);
 	if (test_bit (PC_DMA_OK, &pc->flags)) {
 		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->ide_dma_begin(drive));
+		hwif->dma_start(drive);
 	}
 	return ide_started;
 }
diff -puN include/linux/ide.h~ide_dma_start include/linux/ide.h
--- linux-2.6.9-rc1-bk18/include/linux/ide.h~ide_dma_start	2004-09-13 00:04:35.308456776 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/include/linux/ide.h	2004-09-13 00:04:35.399442944 +0200
@@ -875,7 +875,7 @@ typedef struct hwif_s {
 
 	int (*dma_setup)(ide_drive_t *);
 	void (*dma_exec_cmd)(ide_drive_t *, u8);
-	int (*ide_dma_begin)(ide_drive_t *drive);
+	void (*dma_start)(ide_drive_t *);
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_check)(ide_drive_t *drive);
 	int (*ide_dma_on)(ide_drive_t *drive);
@@ -1516,7 +1516,7 @@ extern int __ide_dma_host_on(ide_drive_t
 extern int __ide_dma_on(ide_drive_t *);
 extern int __ide_dma_check(ide_drive_t *);
 extern int ide_dma_setup(ide_drive_t *);
-extern int __ide_dma_begin(ide_drive_t *);
+extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern int __ide_dma_test_irq(ide_drive_t *);
 extern int __ide_dma_verbose(ide_drive_t *);
_
