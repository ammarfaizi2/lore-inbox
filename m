Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315872AbSEGQGU>; Tue, 7 May 2002 12:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315875AbSEGQGT>; Tue, 7 May 2002 12:06:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14607 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315872AbSEGQGN>; Tue, 7 May 2002 12:06:13 -0400
Message-ID: <3CD7ECB9.9050606@evision-ventures.com>
Date: Tue, 07 May 2002 17:03:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE 58
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070207040105090108060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070207040105090108060702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue May  7 14:28:47 CEST 2002 ide-clean-58

- Apply m68k fixes by Roman Zippel.

- Apply CDROM PIO mode fix by Osamu Tamita.
   (You are true "Hawk-eye" hovering over my head! Respect - and many Thanks.)

- Virtualize the udma_enable method as well to help ARM and PPC people.  Please
   please if you would like to have some other methods virtualized in a similar
   way - just tell me or even better do it yourself at the end of ide-dma.c.
   I *don't mind* patches.

- Fix the pmac code to adhere to the new API. It's supposed to work again.
   However this is blind coding... I give myself 80% chances for it to work ;-).




--------------070207040105090108060702
Content-Type: text/plain;
 name="ide-clean-58.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-58.diff"

diff -urN linux-2.5.14/drivers/ide/buddha.c linux/drivers/ide/buddha.c
--- linux-2.5.14/drivers/ide/buddha.c	2002-05-06 05:38:01.000000000 +0200
+++ linux/drivers/ide/buddha.c	2002-05-07 15:41:02.000000000 +0200
@@ -1,10 +1,10 @@
 /*
  *  linux/drivers/ide/buddha.c -- Amiga Buddha, Catweasel and X-Surf IDE Driver
  *
- *	Copyright (C) 1997 by Geert Uytterhoeven
+ *	Copyright (C) 1997, 2001 by Geert Uytterhoeven and others
  *
- *  This driver was written by based on the specifications in README.buddha and
- *  the X-Surf info from Inside_XSurf.txt available at 
+ *  This driver was written based on the specifications in README.buddha and
+ *  the X-Surf info from Inside_XSurf.txt available at
  *  http://www.jschoenfeld.com
  *
  *  This file is subject to the terms and conditions of the GNU General Public
@@ -52,7 +52,7 @@
     BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
 };
 
-static const u_int xsurf_bases[XSURF_NUM_HWIFS] __initdata = {
+static u_int xsurf_bases[XSURF_NUM_HWIFS] __initdata = {
      XSURF_BASE1, XSURF_BASE2
 };
 
@@ -97,7 +97,7 @@
     BUDDHA_IRQ1, BUDDHA_IRQ2, BUDDHA_IRQ3
 };
 
-static const int xsurf_irqports[XSURF_NUM_HWIFS] __initdata = {
+static int xsurf_irqports[XSURF_NUM_HWIFS] __initdata = {
     XSURF_IRQ1, XSURF_IRQ2
 };
 
@@ -108,8 +108,9 @@
      *  Board information
      */
 
-enum BuddhaType_Enum {BOARD_BUDDHA, BOARD_CATWEASEL, BOARD_XSURF};
-typedef enum BuddhaType_Enum BuddhaType;
+typedef enum BuddhaType_Enum {
+    BOARD_BUDDHA, BOARD_CATWEASEL, BOARD_XSURF
+} BuddhaType;
 
 
     /*
@@ -175,15 +176,20 @@
 			if (!request_mem_region(board+XSURF_BASE1, 0x1000, "IDE"))
 				continue;
 			if (!request_mem_region(board+XSURF_BASE2, 0x1000, "IDE"))
+				goto fail_base2;
+			if (!request_mem_region(board+XSURF_IRQ1, 0x8, "IDE")) {
+				release_mem_region(board+XSURF_BASE2, 0x1000);
+fail_base2:
+				release_mem_region(board+XSURF_BASE1, 0x1000);
 				continue;
-			if (!request_mem_region(board+XSURF_IRQ1, 0x8, "IDE"))
-				continue;
+			}
 		}	  
 		buddha_board = ZTWO_VADDR(board);
 		
 		/* write to BUDDHA_IRQ_MR to enable the board IRQ */
 		/* X-Surf doesn't have this.  IRQs are always on */
-		if(type != BOARD_XSURF) *(char *)(buddha_board+BUDDHA_IRQ_MR) = 0;
+		if (type != BOARD_XSURF)
+			z_writeb(0, buddha_board+BUDDHA_IRQ_MR);
 		
 		for(i=0;i<buddha_num_hwifs;i++) {
 			if(type != BOARD_XSURF) {
diff -urN linux-2.5.14/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.14/drivers/ide/Config.in	2002-05-07 17:56:57.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-05-07 15:41:02.000000000 +0200
@@ -103,7 +103,7 @@
       dep_mbool '    Amiga IDE Doubler support (EXPERIMENTAL)' CONFIG_BLK_DEV_IDEDOUBLER $CONFIG_BLK_DEV_GAYLE $CONFIG_EXPERIMENTAL
    fi
    if [ "$CONFIG_ZORRO" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
-      dep_mbool '  Buddha/Catweasel IDE interface support (EXPERIMENTAL)' CONFIG_BLK_DEV_BUDDHA $CONFIG_ZORRO $CONFIG_EXPERIMENTAL
+      dep_mbool '  Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)' CONFIG_BLK_DEV_BUDDHA $CONFIG_ZORRO $CONFIG_EXPERIMENTAL
    fi
    if [ "$CONFIG_ATARI" = "y" ]; then
       dep_bool '  Falcon IDE interface support' CONFIG_BLK_DEV_FALCON_IDE $CONFIG_ATARI
diff -urN linux-2.5.14/drivers/ide/falconide.c linux/drivers/ide/falconide.c
--- linux-2.5.14/drivers/ide/falconide.c	2002-05-06 05:38:01.000000000 +0200
+++ linux/drivers/ide/falconide.c	2002-05-07 15:41:02.000000000 +0200
@@ -7,7 +7,7 @@
  *  License.  See the file COPYING in the main directory of this archive for
  *  more details.
  */
-#include <linux/config.h>
+
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
diff -urN linux-2.5.14/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.14/drivers/ide/ide.c	2002-05-07 17:57:04.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-07 15:48:53.000000000 +0200
@@ -2097,6 +2097,7 @@
 	ch->atapi_read = old.atapi_read;
 	ch->atapi_write = old.atapi_write;
 	ch->XXX_udma = old.XXX_udma;
+	ch->udma_enable = old.udma_enable;
 	ch->udma_start = old.udma_start;
 	ch->udma_stop = old.udma_stop;
 	ch->udma_read = old.udma_read;
diff -urN linux-2.5.14/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.14/drivers/ide/ide-cd.c	2002-05-07 17:57:04.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-07 15:43:27.000000000 +0200
@@ -962,7 +962,7 @@
 
 	/* First, figure out if we need to bit-bucket
 	   any of the leading sectors. */
-	nskip = MIN(rq->current_nr_sectors - bio_sectors(rq->bio), sectors_to_transfer);
+	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);
 
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
diff -urN linux-2.5.14/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.14/drivers/ide/ide-dma.c	2002-05-07 17:56:57.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-07 15:49:00.000000000 +0200
@@ -533,8 +533,20 @@
 {
 	struct ata_channel *ch = drive->channel;
 	int set_high = 1;
-	u8 unit = (drive->select.b.unit & 0x01);
-	u64 addr = BLK_BOUNCE_HIGH;
+	u8 unit;
+	u64 addr;
+
+
+	/* Method overloaded by host chip specific code. */
+	if (ch->udma_enable) {
+		ch->udma_enable(drive, on, verbose);
+
+		return;
+	}
+
+	/* Fall back to the default implementation. */
+	unit = (drive->select.b.unit & 0x01);
+	addr = BLK_BOUNCE_HIGH;
 
 	if (!on) {
 		if (verbose)
diff -urN linux-2.5.14/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.14/drivers/ide/ide-pmac.c	2002-05-06 05:38:04.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-07 17:52:35.000000000 +0200
@@ -256,7 +256,15 @@
 #define IDE_WAKEUP_DELAY_MS	2000
 
 static void pmac_ide_setup_dma(struct device_node *np, int ix);
-static int pmac_ide_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq);
+
+static void pmac_udma_enable(struct ata_device *drive, int on, int verbose);
+static int pmac_udma_start(struct ata_device *drive, struct request *rq);
+static int pmac_udma_stop(struct ata_device *drive);
+static int pmac_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq);
+static int pmac_udma_read(struct ata_device *drive, struct request *rq);
+static int pmac_udma_write(struct ata_device *drive, struct request *rq);
+static int pmac_udma_irq_status(struct ata_device *drive);
+static int pmac_ide_dmaproc(struct ata_device *drive);
 static int pmac_ide_build_dmatable(struct ata_device *drive, struct request *rq, int ix, int wr);
 static int pmac_ide_tune_chipset(struct ata_device *drive, byte speed);
 static void pmac_ide_tuneproc(struct ata_device *drive, byte pio);
@@ -323,7 +331,13 @@
 	ide_hwifs[ix].selectproc = pmac_ide_selectproc;
 	ide_hwifs[ix].speedproc = &pmac_ide_tune_chipset;
 	if (pmac_ide[ix].dma_regs && pmac_ide[ix].dma_table_cpu) {
-		ide_hwifs[ix].udma = pmac_ide_dmaproc;
+		ide_hwifs[ix].udma_enable = pmac_udma_enable;
+		ide_hwifs[ix].udma_start = pmac_udma_start;
+		ide_hwifs[ix].udma_stop = pmac_udma_stop;
+		ide_hwifs[ix].udma_read = pmac_udma_read;
+		ide_hwifs[ix].udma_write = pmac_udma_write;
+		ide_hwifs[ix].udma_irq_status = pmac_udma_irq_status;
+		ide_hwifs[ix].XXX_udma = pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 		if (!noautodma)
 			ide_hwifs[ix].autodma = 1;
@@ -1025,7 +1039,13 @@
 				    	pmif->dma_table_cpu, pmif->dma_table_dma);
 		return;
 	}
-	ide_hwifs[ix].udma = pmac_ide_dmaproc;
+	ide_hwifs[ix].udma_enable = pmac_udma_enable;
+	ide_hwifs[ix].udma_start = pmac_udma_start;
+	ide_hwifs[ix].udma_stop = pmac_udma_stop;
+	ide_hwifs[ix].udma_read = pmac_udma_read;
+	ide_hwifs[ix].udma_write = pmac_udma_write;
+	ide_hwifs[ix].udma_irq_status = pmac_udma_irq_status;
+	ide_hwifs[ix].XXX_udma = pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
 		ide_hwifs[ix].autodma = 1;
@@ -1336,130 +1356,178 @@
 	blk_queue_bounce_limit(&drive->queue, addr);
 }
 
-static int pmac_ide_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static void pmac_udma_enable(struct ata_device *drive, int on, int verbose)
+{
+	if (verbose) {
+		printk(KERN_INFO "%s: DMA disabled\n", drive->name);
+	}
+
+	drive->using_dma = 0;
+	ide_toggle_bounce(drive, 0);
+}
+
+static int pmac_udma_start(struct ata_device *drive, struct request *rq)
 {
-	int ix, dstat, reading, ata4;
+	int ix, ata4;
+	volatile struct dbdma_regs *dma;
+
+	/* Can we stuff a pointer to our intf structure in config_data
+	 * or select_data in hwif ?
+	 */
+	ix = pmac_ide_find(drive);
+	if (ix < 0)
+		return 0;
+	dma = pmac_ide[ix].dma_regs;
+	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
+		pmac_ide[ix].kind == controller_kl_ata4_80);
+
+	out_le32(&dma->control, (RUN << 16) | RUN);
+	/* Make sure it gets to the controller right now */
+	(void)in_le32(&dma->control);
+	return 0;
+}
+
+static int pmac_udma_stop(struct ata_device *drive)
+{
+	int ix, dstat, ata4;
+	volatile struct dbdma_regs *dma;
+
+	/* Can we stuff a pointer to our intf structure in config_data
+	 * or select_data in hwif ?
+	 */
+	ix = pmac_ide_find(drive);
+	if (ix < 0)
+		return 0;
+	dma = pmac_ide[ix].dma_regs;
+	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
+		pmac_ide[ix].kind == controller_kl_ata4_80);
+
+	drive->waiting_for_dma = 0;
+	dstat = in_le32(&dma->status);
+	out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
+	pmac_ide_destroy_dmatable(drive->channel, ix);
+	/* verify good dma status */
+	return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
+}
+
+static int pmac_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+{
+	int ix, ata4;
 	volatile struct dbdma_regs *dma;
 	byte unit = (drive->select.b.unit & 0x01);
-	
+
 	/* Can we stuff a pointer to our intf structure in config_data
 	 * or select_data in hwif ?
 	 */
 	ix = pmac_ide_find(drive);
 	if (ix < 0)
-		return 0;		
+		return 0;
 	dma = pmac_ide[ix].dma_regs;
 	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
 		pmac_ide[ix].kind == controller_kl_ata4_80);
-	
-	switch (func) {
-	case ide_dma_off:
-		printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-	case ide_dma_off_quietly:
-		drive->using_dma = 0;
-		ide_toggle_bounce(drive, 0);
-		break;
-	case ide_dma_on:
-	case ide_dma_check:
-		/* Change this to better match ide-dma.c */
-		pmac_ide_check_dma(drive);
-		ide_toggle_bounce(drive, drive->using_dma);
-		break;
-	case ide_dma_read:
-	case ide_dma_write:
-		reading = (func == ide_dma_read);
-		if (!pmac_ide_build_dmatable(drive, rq, ix, !reading))
-			return 1;
-		/* Apple adds 60ns to wrDataSetup on reads */
-		if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
-			out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
-				pmac_ide[ix].timings[unit] + 
-				((func == ide_dma_read) ? 0x00800000UL : 0));
-			(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
-		}
-		drive->waiting_for_dma = 1;
-		if (drive->type != ATA_DISK)
-			return 0;
-		ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
-		if ((rq->flags & REQ_DRIVE_ACB) &&
-		    (drive->addressing == 1)) {
-			struct ata_taskfile *args = rq->special;
-			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
-		} else if (drive->addressing) {
-			OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-		} else {
-			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-		}
-		/* fall through */
-	case ide_dma_begin:
-		out_le32(&dma->control, (RUN << 16) | RUN);
-		/* Make sure it gets to the controller right now */
-		(void)in_le32(&dma->control);
-		break;
-	case ide_dma_end: /* returns 1 on error, 0 otherwise */
-		drive->waiting_for_dma = 0;
-		dstat = in_le32(&dma->status);
-		out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
-		pmac_ide_destroy_dmatable(drive->channel, ix);
-		/* verify good dma status */
-		return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
-	case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
-		/* We have to things to deal with here:
-		 * 
-		 * - The dbdma won't stop if the command was started
-		 * but completed with an error without transfering all
-		 * datas. This happens when bad blocks are met during
-		 * a multi-block transfer.
-		 * 
-		 * - The dbdma fifo hasn't yet finished flushing to
-		 * to system memory when the disk interrupt occurs.
-		 * 
-		 * The trick here is to increment drive->waiting_for_dma,
-		 * and return as if no interrupt occured. If the counter
-		 * reach a certain timeout value, we then return 1. If
-		 * we really got the interrupt, it will happen right away
-		 * again.
-		 * Apple's solution here may be more elegant. They issue
-		 * a DMA channel interrupt (a separate irq line) via a DBDMA
-		 * NOP command just before the STOP, and wait for both the
-		 * disk and DBDMA interrupts to have completed.
-		 */
-		 
-		/* If ACTIVE is cleared, the STOP command have passed and
-		 * transfer is complete.
-		 */
-		if (!(in_le32(&dma->status) & ACTIVE))
-			return 1;
-		if (!drive->waiting_for_dma)
-			printk(KERN_WARNING "ide%d, ide_dma_test_irq \
-				called while not waiting\n", ix);
 
-		/* If dbdma didn't execute the STOP command yet, the
-		 * active bit is still set */
-		drive->waiting_for_dma++;
-		if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
-			printk(KERN_WARNING "ide%d, timeout waiting \
-				for dbdma command stop\n", ix);
-			return 1;
-		}
-		udelay(1);
+	if (!pmac_ide_build_dmatable(drive, rq, ix, !reading))
+		return 1;
+	/* Apple adds 60ns to wrDataSetup on reads */
+	if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
+		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+			pmac_ide[ix].timings[unit] + 
+			((reading) ? 0x00800000UL : 0));
+		(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
+	}
+	drive->waiting_for_dma = 1;
+	if (drive->type != ATA_DISK)
+		return 0;
+	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
+	if ((rq->flags & REQ_DRIVE_ACB) &&
+		(drive->addressing == 1)) {
+		struct ata_taskfile *args = rq->special;
+		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+	} else if (drive->addressing) {
+		OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+	} else {
+		OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+	}
+
+	return udma_start(drive, rq);
+}
+
+static int pmac_udma_read(struct ata_device *drive, struct request *rq)
+{
+	return pmac_do_udma(1, drive, rq);
+}
+
+static int pmac_udma_write(struct ata_device *drive, struct request *rq)
+{
+	return pmac_do_udma(0, drive, rq);
+}
+
+/*
+ * FIXME: This should be attached to a channel as we can see now!
+ */
+static int pmac_udma_irq_status(struct ata_device *drive)
+{
+	int ix, ata4;
+	volatile struct dbdma_regs *dma;
+
+	/* Can we stuff a pointer to our intf structure in config_data
+	 * or select_data in hwif ?
+	 */
+	ix = pmac_ide_find(drive);
+	if (ix < 0)
 		return 0;
+	dma = pmac_ide[ix].dma_regs;
+	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
+		pmac_ide[ix].kind == controller_kl_ata4_80);
+
+	/* We have to things to deal with here:
+	 *
+	 * - The dbdma won't stop if the command was started but completed with
+	 * an error without transfering all datas. This happens when bad blocks
+	 * are met during a multi-block transfer.
+	 *
+	 * - The dbdma fifo hasn't yet finished flushing to to system memory
+	 * when the disk interrupt occurs.
+	 *
+	 * The trick here is to increment drive->waiting_for_dma, and return as
+	 * if no interrupt occured. If the counter reach a certain timeout
+	 * value, we then return 1. If we really got the interrupt, it will
+	 * happen right away again.  Apple's solution here may be more elegant.
+	 * They issue a DMA channel interrupt (a separate irq line) via a DBDMA
+	 * NOP command just before the STOP, and wait for both the disk and
+	 * DBDMA interrupts to have completed.
+	 */
 
-		/* Let's implement tose just in case someone wants them */
-	case ide_dma_bad_drive:
-	case ide_dma_good_drive:
-		return check_drive_lists(drive, (func == ide_dma_good_drive));
-	case ide_dma_lostirq:
-	case ide_dma_timeout:
-		printk(KERN_WARNING "ide_pmac_dmaproc: chipset supported func only: %d\n", func);
+	/* If ACTIVE is cleared, the STOP command have passed and
+	 * transfer is complete.
+	 */
+	if (!(in_le32(&dma->status) & ACTIVE))
 		return 1;
-	default:
-		printk(KERN_WARNING "ide_pmac_dmaproc: unsupported func: %d\n", func);
+	if (!drive->waiting_for_dma)
+		printk(KERN_WARNING "ide%d, ide_dma_test_irq \
+				called while not waiting\n", ix);
+
+	/* If dbdma didn't execute the STOP command yet, the
+	 * active bit is still set */
+	drive->waiting_for_dma++;
+	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
+		printk(KERN_WARNING "ide%d, timeout waiting \
+				for dbdma command stop\n", ix);
 		return 1;
 	}
+	udelay(1);
 	return 0;
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+
+static int pmac_ide_dmaproc(struct ata_device *drive)
+{
+	/* Change this to better match ide-dma.c */
+	pmac_ide_check_dma(drive);
+	ide_toggle_bounce(drive, drive->using_dma);
+
+	return 0;
+}
+#endif
 
 static void idepmac_sleep_device(ide_drive_t *drive, int i, unsigned base)
 {
diff -urN linux-2.5.14/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.14/drivers/ide/ide-taskfile.c	2002-05-07 17:57:01.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-07 15:41:02.000000000 +0200
@@ -39,8 +39,6 @@
 #define DTF(x...)
 #endif
 
-#define SUPPORT_VLB_SYNC 1
-
 /*
  * for now, taskfile requests are special :/
  */
diff -urN linux-2.5.14/include/asm-m68k/ide.h linux/include/asm-m68k/ide.h
--- linux-2.5.14/include/asm-m68k/ide.h	2002-05-07 17:56:58.000000000 +0200
+++ linux/include/asm-m68k/ide.h	2002-05-07 15:41:02.000000000 +0200
@@ -121,6 +121,7 @@
 #define inb(p)     in_8(ADDR_TRANS_B(p))
 #define inb_p(p)     in_8(ADDR_TRANS_B(p))
 #define inw(p)     in_be16(ADDR_TRANS_W(p))
+#define inw_p(p)     in_be16(ADDR_TRANS_W(p))
 #define outb(v,p)  out_8(ADDR_TRANS_B(p),v)
 #define outb_p(v,p)  out_8(ADDR_TRANS_B(p),v)
 #define outw(v,p)  out_be16(ADDR_TRANS_W(p),v)
diff -urN linux-2.5.14/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.14/include/linux/ide.h	2002-05-07 17:57:04.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-07 15:48:57.000000000 +0200
@@ -459,6 +459,8 @@
 
 	int (*XXX_udma)(struct ata_device *);
 
+	void (*udma_enable)(struct ata_device *, int, int);
+
 	int (*udma_start) (struct ata_device *, struct request *rq);
 	int (*udma_stop) (struct ata_device *);
 

--------------070207040105090108060702--

