Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUILXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUILXoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUILXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:44:45 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:32233 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264147AbUILXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:41:05 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][2/3] ide: add ide_hwif_t->dma_exec_cmd()
Date: Mon, 13 Sep 2004 01:33:55 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Cc: "Mikael Starvik" <mikael.starvik@axis.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409130133.55663.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: add ide_hwif_t->dma_exec_cmd()

- split off ->dma_exec_cmd() from ->ide_dma_[read,write] functions
- choose command to execute by ->dma_exec_cmd() in higher layers
  and remove ->ide_dma_[read,write]

Some real bugs are also fixed:
- in Etrax ide.c driver REQ_DRIVE_TASKFILE requests weren't
  handled properly for drive->addressing == 0
- in trm290.c read and write commands were interchanged
- in sgiioc4.c commands weren't sent to disk devices

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk18-bzolnier/arch/cris/arch-v10/drivers/ide.c |   77 +---------
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/arm/icside.c         |   62 --------
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-disk.c           |   10 +
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-dma.c            |   46 -----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-taskfile.c       |   15 -
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide.c                |    3 
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sgiioc4.c        |    7 
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/trm290.c         |   54 -------
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ppc/pmac.c           |   51 ------
 linux-2.6.9-rc1-bk18-bzolnier/include/linux/ide.h              |    3 
 10 files changed, 36 insertions(+), 292 deletions(-)

diff -puN arch/cris/arch-v10/drivers/ide.c~ide_dma_exec_cmd arch/cris/arch-v10/drivers/ide.c
--- linux-2.6.9-rc1-bk18/arch/cris/arch-v10/drivers/ide.c~ide_dma_exec_cmd	2004-09-12 23:42:16.910924128 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/arch/cris/arch-v10/drivers/ide.c	2004-09-12 23:47:20.166822224 +0200
@@ -210,8 +210,6 @@ etrax100_ide_inb(ide_ioreg_t reg)
 static int e100_dma_check (ide_drive_t *drive);
 static int e100_dma_begin (ide_drive_t *drive);
 static int e100_dma_end (ide_drive_t *drive);
-static int e100_dma_read (ide_drive_t *drive);
-static int e100_dma_write (ide_drive_t *drive);
 static void e100_ide_input_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_ide_output_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_atapi_input_bytes(ide_drive_t *drive, void *, unsigned int);
@@ -305,6 +303,15 @@ static int e100_dma_setup(ide_drive_t *d
 	return 0;
 }
 
+static void e100_dma_exec_cmd(ide_drive_t *drive, u8 command)
+{
+	/* set the irq handler which will finish the request when DMA is done */
+	ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
+
+	/* issue cmd to drive */
+	etrax100_ide_outb(command, IDE_COMMAND_REG);
+}
+
 void __init
 init_e100_ide (void)
 {
@@ -327,8 +334,7 @@ init_e100_ide (void)
                 hwif->ide_dma_check = &e100_dma_check;
                 hwif->ide_dma_end = &e100_dma_end;
 		hwif->dma_setup = &e100_dma_setup;
-		hwif->ide_dma_write = &e100_dma_write;
-		hwif->ide_dma_read = &e100_dma_read;
+		hwif->dma_exec_cmd = &e100_dma_exec_cmd;
 		hwif->ide_dma_begin = &e100_dma_begin;
 		hwif->OUTB = &etrax100_ide_outb;
 		hwif->OUTW = &etrax100_ide_outw;
@@ -809,27 +815,9 @@ static int e100_dma_end(ide_drive_t *dri
 	return 0;
 }
 
-static int e100_start_dma(ide_drive_t *drive, int atapi, int reading)
+static int e100_dma_begin(ide_drive_t *drive)
 {
-	if(reading) {
-
-		if(!atapi) {
-			/* set the irq handler which will finish the request when DMA is done */
-
-			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-
-			/* issue cmd to drive */
-                        if ((HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE) &&
-			    (drive->addressing == 1)) {
-				ide_task_t *args = HWGROUP(drive)->rq->special;
-				etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
-			} else if (drive->addressing) {
-				etrax100_ide_outb(WIN_READDMA_EXT, IDE_COMMAND_REG);
-			} else {
-				etrax100_ide_outb(WIN_READDMA, IDE_COMMAND_REG);
-			}
-		}
-
+	if (e100_read_command) {
 		/* begin DMA */
 
 		/* need to do this before RX DMA due to a chip bug
@@ -862,24 +850,6 @@ static int e100_start_dma(ide_drive_t *d
 
 	} else {
 		/* writing */
-
-		if(!atapi) {
-			/* set the irq handler which will finish the request when DMA is done */
-
-			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-
-			/* issue cmd to drive */
-			if ((HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE) &&
-			    (drive->addressing == 1)) {
-				ide_task_t *args = HWGROUP(drive)->rq->special;
-				etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
-			} else if (drive->addressing) {
-				etrax100_ide_outb(WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-			} else {
-				etrax100_ide_outb(WIN_WRITEDMA, IDE_COMMAND_REG);
-			}
-		}
-
 		/* begin DMA */
 
 		*R_DMA_CH2_FIRST = virt_to_phys(ata_descrs);
@@ -904,26 +874,3 @@ static int e100_start_dma(ide_drive_t *d
 	}
 	return 0;
 }
-
-static int e100_dma_write(ide_drive_t *drive)
-{
-	return e100_start_dma(drive, 0, 0);
-}
-
-static int e100_dma_read(ide_drive_t *drive)
-{
-	return e100_start_dma(drive, 0, 1);
-}
-
-static int e100_dma_begin(ide_drive_t *drive)
-{
-	/* begin DMA, used by ATAPI devices which want to issue the
-	 * appropriate IDE command themselves.
-	 *
-	 * they have already called ->dma_setup to set the
-	 * static reading flag, now they call ide_dma_begin to do
-	 * the real stuff. we tell our code below not to issue
-	 * any IDE commands itself and jump into it.
-	 */
-	 return e100_start_dma(drive, 1, e100_read_command);
-}
diff -puN drivers/ide/arm/icside.c~ide_dma_exec_cmd drivers/ide/arm/icside.c
--- linux-2.6.9-rc1-bk18/drivers/ide/arm/icside.c~ide_dma_exec_cmd	2004-09-12 23:42:16.912923824 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/arm/icside.c	2004-09-12 23:47:20.168821920 +0200
@@ -489,67 +489,10 @@ static int icside_dma_setup(ide_drive_t 
 	return 0;
 }
 
-static int icside_dma_read(ide_drive_t *drive)
+static void icside_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	struct request *rq = HWGROUP(drive)->rq;
-	task_ioreg_t cmd;
-
-	BUG_ON(HWGROUP(drive)->handler != NULL);
-
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
-		cmd = WIN_READDMA_EXT;
-	} else {
-		cmd = WIN_READDMA;
-	}
-#endif
-	/* issue cmd to drive */
-	ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
-
-	return icside_dma_begin(drive);
-}
-
-static int icside_dma_write(ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	task_ioreg_t cmd;
-
-	BUG_ON(HWGROUP(drive)->handler != NULL);
-
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
-		cmd = WIN_WRITEDMA_EXT;
-	} else {
-		cmd = WIN_WRITEDMA;
-	}
-#endif
-
 	/* issue cmd to drive */
 	ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
-
-	return icside_dma_begin(drive);
 }
 
 static int icside_dma_test_irq(ide_drive_t *drive)
@@ -620,8 +563,7 @@ static int icside_dma_init(ide_hwif_t *h
 	hwif->ide_dma_host_on	= icside_dma_host_on;
 	hwif->ide_dma_on	= icside_dma_on;
 	hwif->dma_setup		= icside_dma_setup;
-	hwif->ide_dma_read	= icside_dma_read;
-	hwif->ide_dma_write	= icside_dma_write;
+	hwif->dma_exec_cmd	= icside_dma_exec_cmd;
 	hwif->ide_dma_begin	= icside_dma_begin;
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
diff -puN drivers/ide/ide.c~ide_dma_exec_cmd drivers/ide/ide.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide.c~ide_dma_exec_cmd	2004-09-12 23:42:16.917923064 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide.c	2004-09-12 23:47:20.171821464 +0200
@@ -686,8 +686,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->atapi_output_bytes	= tmp_hwif->atapi_output_bytes;
 
 	hwif->dma_setup			= tmp_hwif->dma_setup;
-	hwif->ide_dma_read		= tmp_hwif->ide_dma_read;
-	hwif->ide_dma_write		= tmp_hwif->ide_dma_write;
+	hwif->dma_exec_cmd		= tmp_hwif->dma_exec_cmd;
 	hwif->ide_dma_begin		= tmp_hwif->ide_dma_begin;
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
 	hwif->ide_dma_check		= tmp_hwif->ide_dma_check;
diff -puN drivers/ide/ide-disk.c~ide_dma_exec_cmd drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-disk.c~ide_dma_exec_cmd	2004-09-12 23:42:16.919922760 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-disk.c	2004-09-12 23:47:20.177820552 +0200
@@ -215,10 +215,16 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
 			if (rq_data_dir(rq)) {
-				hwif->ide_dma_write(drive);
+				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+				if (drive->vdma)
+					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
 			} else {
-				hwif->ide_dma_read(drive);
+				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
+				if (drive->vdma)
+					command = lba48 ? WIN_READ_EXT: WIN_READ;
 			}
+			hwif->dma_exec_cmd(drive, command);
+			hwif->ide_dma_begin(drive);
 			return ide_started;
 		}
 		/* fallback to PIO */
diff -puN drivers/ide/ide-dma.c~ide_dma_exec_cmd drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-dma.c~ide_dma_exec_cmd	2004-09-12 23:42:16.922922304 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-dma.c	2004-09-12 23:47:20.179820248 +0200
@@ -635,48 +635,10 @@ int ide_dma_setup(ide_drive_t *drive)
 
 EXPORT_SYMBOL_GPL(ide_dma_setup);
 
-static int __ide_dma_read(ide_drive_t *drive)
+static void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
-
-	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
-	
-	if (drive->vdma)
-		command = (lba48) ? WIN_READ_EXT: WIN_READ;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
-	/* issue cmd to drive */
-	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
-	return hwif->ide_dma_begin(drive);
-}
-
-static int __ide_dma_write(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
-
-	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-	if (drive->vdma)
-		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
-
-	return hwif->ide_dma_begin(drive);
 }
 
 int __ide_dma_begin (ide_drive_t *drive)
@@ -989,10 +951,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_check = &__ide_dma_check;
 	if (!hwif->dma_setup)
 		hwif->dma_setup = &ide_dma_setup;
-	if (!hwif->ide_dma_read)
-		hwif->ide_dma_read = &__ide_dma_read;
-	if (!hwif->ide_dma_write)
-		hwif->ide_dma_write = &__ide_dma_write;
+	if (!hwif->dma_exec_cmd)
+		hwif->dma_exec_cmd = &ide_dma_exec_cmd;
 	if (!hwif->ide_dma_begin)
 		hwif->ide_dma_begin = &__ide_dma_begin;
 	if (!hwif->ide_dma_end)
diff -puN drivers/ide/ide-taskfile.c~ide_dma_exec_cmd drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-taskfile.c~ide_dma_exec_cmd	2004-09-12 23:42:16.925921848 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-taskfile.c	2004-09-12 23:47:20.190818576 +0200
@@ -178,17 +178,13 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
-			if (!hwif->dma_setup(drive)) {
-				hwif->ide_dma_write(drive);
-				return ide_started;
-			}
-			break;
 		case WIN_READDMA_ONCE:
 		case WIN_READDMA:
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
 			if (!hwif->dma_setup(drive)) {
-				hwif->ide_dma_read(drive);
+				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->ide_dma_begin(drive);
 				return ide_started;
 			}
 			break;
@@ -930,14 +926,11 @@ ide_startstop_t flagged_taskfile (ide_dr
 
    	        case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
-			hwif->dma_setup(drive);
-			hwif->ide_dma_write(drive);
-			break;
-
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
 			hwif->dma_setup(drive);
-			hwif->ide_dma_read(drive);
+			hwif->dma_exec_cmd(drive, taskfile->command);
+			hwif->ide_dma_begin(drive);
 			break;
 
 	        default:
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_exec_cmd drivers/ide/pci/sgiioc4.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/sgiioc4.c~ide_dma_exec_cmd	2004-09-12 23:42:16.939919720 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sgiioc4.c	2004-09-12 23:47:20.195817816 +0200
@@ -603,11 +603,6 @@ static int sgiioc4_ide_dma_setup(ide_dri
 	return 0;
 }
 
-static int sgiioc4_ide_dma_dummy(ide_drive_t *drive)
-{
-	return 0;
-}
-
 static void __init
 ide_init_sgiioc4(ide_hwif_t * hwif)
 {
@@ -631,8 +626,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->busproc = NULL;
 
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
-	hwif->ide_dma_read = &sgiioc4_ide_dma_dummy;
-	hwif->ide_dma_write = &sgiioc4_ide_dma_dummy;
 	hwif->ide_dma_begin = &sgiioc4_ide_dma_begin;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
diff -puN drivers/ide/pci/trm290.c~ide_dma_exec_cmd drivers/ide/pci/trm290.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/trm290.c~ide_dma_exec_cmd	2004-09-12 23:42:16.941919416 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/trm290.c	2004-09-12 23:47:20.197817512 +0200
@@ -179,64 +179,15 @@ static void trm290_selectproc (ide_drive
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int trm290_ide_dma_write (ide_drive_t *drive /*, struct request *rq */)
+static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-//	ide_task_t *args	= rq->special;
-	task_ioreg_t command	= WIN_NOP;
 
 	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
 		BUG();
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	command = /* (lba48) ? WIN_READDMA_EXT : */ WIN_READDMA;
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#endif
-	/* issue cmd to drive */
-	hwif->OUTB(command, IDE_COMMAND_REG);
-	return hwif->ide_dma_begin(drive);
-}
-
-static int trm290_ide_dma_read (ide_drive_t *drive  /*, struct request *rq */)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-//	ide_task_t *args	= rq->special;
-	task_ioreg_t command	= WIN_NOP;
-
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
-	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	command = /* (lba48) ? WIN_WRITEDMA_EXT : */ WIN_WRITEDMA;
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#endif
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
-	return hwif->ide_dma_begin(drive);
 }
 
 static int trm290_ide_dma_setup(ide_drive_t *drive)
@@ -343,8 +294,7 @@ void __devinit init_hwif_trm290(ide_hwif
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->dma_setup = &trm290_ide_dma_setup;
-	hwif->ide_dma_write = &trm290_ide_dma_write;
-	hwif->ide_dma_read = &trm290_ide_dma_read;
+	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
 	hwif->ide_dma_begin = &trm290_ide_dma_begin;
 	hwif->ide_dma_end = &trm290_ide_dma_end;
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
diff -puN drivers/ide/ppc/pmac.c~ide_dma_exec_cmd drivers/ide/ppc/pmac.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ppc/pmac.c~ide_dma_exec_cmd	2004-09-12 23:42:16.944918960 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ppc/pmac.c	2004-09-12 23:47:20.200817056 +0200
@@ -1916,55 +1916,11 @@ pmac_ide_dma_setup(ide_drive_t *drive)
 	return 0;
 }
 
-/*
- * Start a DMA READ command
- */
-static int __pmac
-pmac_ide_dma_read(ide_drive_t *drive)
+static void __pmac
+pmac_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	struct request *rq = HWGROUP(drive)->rq;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command = WIN_NOP;
-
-	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
-	
-	if (drive->vdma)
-		command = (lba48) ? WIN_READ_EXT: WIN_READ;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
-
-	return pmac_ide_dma_begin(drive);
-}
-
-/*
- * Start a DMA WRITE command
- */
-static int __pmac
-pmac_ide_dma_write (ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command = WIN_NOP;
-
-	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-	if (drive->vdma)
-		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
-	/* issue cmd to drive */
-	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
-
-	return pmac_ide_dma_begin(drive);
 }
 
 /*
@@ -2139,8 +2095,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
 	hwif->dma_setup = &pmac_ide_dma_setup;
-	hwif->ide_dma_read = &pmac_ide_dma_read;
-	hwif->ide_dma_write = &pmac_ide_dma_write;
+	hwif->dma_exec_dma = &pmac_ide_dma_exec_cmd;
 	hwif->ide_dma_begin = &pmac_ide_dma_begin;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
diff -puN include/linux/ide.h~ide_dma_exec_cmd include/linux/ide.h
--- linux-2.6.9-rc1-bk18/include/linux/ide.h~ide_dma_exec_cmd	2004-09-12 23:42:16.947918504 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/include/linux/ide.h	2004-09-12 23:47:20.203816600 +0200
@@ -874,8 +874,7 @@ typedef struct hwif_s {
 	void (*atapi_output_bytes)(ide_drive_t *, void *, u32);
 
 	int (*dma_setup)(ide_drive_t *);
-	int (*ide_dma_read)(ide_drive_t *drive);
-	int (*ide_dma_write)(ide_drive_t *drive);
+	void (*dma_exec_cmd)(ide_drive_t *, u8);
 	int (*ide_dma_begin)(ide_drive_t *drive);
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_check)(ide_drive_t *drive);
_
