Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSEONHv>; Wed, 15 May 2002 09:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSEONHu>; Wed, 15 May 2002 09:07:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:265 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S312254AbSEONHc>;
	Wed, 15 May 2002 09:07:32 -0400
Message-ID: <3CE24EC8.3030202@evision-ventures.com>
Date: Wed, 15 May 2002 14:04:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.15 IDE 64
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020500080700050704030602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020500080700050704030602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue May 14 13:35:04 CEST 2002 ide-clean-64:

Let's just get over with  this before queue handling will be targeted again...

- Implement suggestions by Russel King for improved portability and separation
   between PCI and non PCI host code.

- pdc202xxx updates from Thierry Vignaud.

- Tinny PIO fix from Tomita.


--------------020500080700050704030602
Content-Type: text/plain;
 name="ide-clean-64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-64.diff"

diff -urN linux-2.5.15/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.15/drivers/ide/ide.c	2002-05-15 14:55:12.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-15 13:34:25.000000000 +0200
@@ -1145,7 +1145,7 @@
 }
 
 /*
- * Select the next device which will be serviced.  This selects onlt between
+ * Select the next device which will be serviced.  This selects only between
  * devices on the same channel, since everything else will be scheduled on the
  * queue level.
  */
diff -urN linux-2.5.15/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.15/drivers/ide/ide-dma.c	2002-05-15 14:55:05.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,866 +0,0 @@
-/**** vi:set ts=8 sts=8 sw=8:************************************************
- *
- *  Copyright (c) 1999-2000  Andre Hedrick <andre@linux-ide.org>
- *  Copyright (c) 1995-1998  Mark Lord
- *
- *  May be copied or modified under the terms of the GNU General Public License
- *
- *  Special Thanks to Mark for his Six years of work.
- *
- * This module provides support for the bus-master IDE DMA functions
- * of various PCI chipsets, including the Intel PIIX (i82371FB for
- * the 430 FX chipset), the PIIX3 (i82371SB for the 430 HX/VX and
- * 440 chipsets), and the PIIX4 (i82371AB for the 430 TX chipset)
- * ("PIIX" stands for "PCI ISA IDE Xcellerator").
- *
- * Pretty much the same code works for other IDE PCI bus-mastering chipsets.
- *
- * DMA is supported for all IDE devices (disk drives, cdroms, tapes, floppies).
- *
- * By default, DMA support is prepared for use, but is currently enabled only
- * for drives which already have DMA enabled (UltraDMA or mode 2 multi/single),
- * or which are recognized as "good" (see table below).  Drives with only mode0
- * or mode1 (multi/single) DMA should also work with this chipset/driver
- * (eg. MC2112A) but are not enabled by default.
- *
- * Use "hdparm -i" to view modes supported by a given drive.
- *
- * The hdparm-3.5 (or later) utility can be used for manually enabling/disabling
- * DMA support, but must be (re-)compiled against this kernel version or later.
- *
- * To enable DMA, use "hdparm -d1 /dev/hd?" on a per-drive basis after booting.
- * If problems arise, ide.c will disable DMA operation after a few retries.
- * This error recovery mechanism works and has been extremely well exercised.
- *
- * IDE drives, depending on their vintage, may support several different modes
- * of DMA operation.  The boot-time modes are indicated with a "*" in
- * the "hdparm -i" listing, and can be changed with *knowledgeable* use of
- * the "hdparm -X" feature.  There is seldom a need to do this, as drives
- * normally power-up with their "best" PIO/DMA modes enabled.
- *
- * Testing has been done with a rather extensive number of drives,
- * with Quantum & Western Digital models generally outperforming the pack,
- * and Fujitsu & Conner (and some Seagate which are really Conner) drives
- * showing more lackluster throughput.
- *
- * Keep an eye on /var/adm/messages for "DMA disabled" messages.
- *
- * Some people have reported trouble with Intel Zappa motherboards.
- * This can be fixed by upgrading the AMI BIOS to version 1.00.04.BS0,
- * available from ftp://ftp.intel.com/pub/bios/10004bs0.exe
- * (thanks to Glen Morrell <glen@spin.Stanford.edu> for researching this).
- *
- * Thanks to "Christopher J. Reimer" <reimer@doe.carleton.ca> for
- * fixing the problem with the BIOS on some Acer motherboards.
- *
- * Thanks to "Benoit Poulot-Cazajous" <poulot@chorus.fr> for testing
- * "TX" chipset compatibility and for providing patches for the "TX" chipset.
- *
- * Thanks to Christian Brunner <chb@muc.de> for taking a good first crack
- * at generic DMA -- his patches were referred to when preparing this code.
- *
- * Most importantly, thanks to Robert Bringman <rob@mars.trion.com>
- * for supplying a Promise UDMA board & WD UDMA drive for this work!
- *
- * And, yes, Intel Zappa boards really *do* use both PIIX IDE ports.
- *
- * ATA-66/100 and recovery functions, I forgot the rest......
- */
-
-#include <linux/config.h>
-#define __NO_VERSION__
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/ide.h>
-#include <linux/delay.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-/*
- * Long lost data from 2.0.34 that is now in 2.0.39
- *
- * This was used in ./drivers/block/triton.c to do DMA Base address setup
- * when PnP failed.  Oh the things we forget.  I believe this was part
- * of SFF-8038i that has been withdrawn from public access... :-((
- */
-#define DEFAULT_BMIBA	0xe800	/* in case BIOS did not init it */
-#define DEFAULT_BMCRBA	0xcc00	/* VIA's default value */
-#define DEFAULT_BMALIBA	0xd400	/* ALI's default value */
-
-#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
-
-struct drive_list_entry {
-	char * id_model;
-	char * id_firmware;
-};
-
-struct drive_list_entry drive_whitelist[] = {
-	{ "Micropolis 2112A", NULL },
-	{ "CONNER CTMA 4000", NULL },
-	{ "CONNER CTT8000-A", NULL },
-	{ "ST34342A", NULL },
-	{ NULL, NULL }
-};
-
-struct drive_list_entry drive_blacklist[] = {
-
-	{ "WDC AC11000H", NULL },
-	{ "WDC AC22100H", NULL },
-	{ "WDC AC32500H", NULL },
-	{ "WDC AC33100H", NULL },
-	{ "WDC AC31600H", NULL },
-	{ "WDC AC32100H", "24.09P07" },
-	{ "WDC AC23200L", "21.10N21" },
-	{ "Compaq CRD-8241B", NULL },
-	{ "CRD-8400B", NULL },
-	{ "CRD-8480B", NULL },
-	{ "CRD-8480C", NULL },
-	{ "CRD-8482B", NULL },
-	{ "CRD-84", NULL },
-	{ "SanDisk SDP3B", NULL },
-	{ "SanDisk SDP3B-64", NULL },
-	{ "SANYO CD-ROM CRD", NULL },
-	{ "HITACHI CDR-8", NULL },
-	{ "HITACHI CDR-8335", NULL },
-	{ "HITACHI CDR-8435", NULL },
-	{ "Toshiba CD-ROM XM-6202B", NULL },
-	{ "CD-532E-A", NULL },
-	{ "E-IDE CD-ROM CR-840", NULL },
-	{ "CD-ROM Drive/F5A", NULL },
-	{ "RICOH CD-R/RW MP7083A", NULL },
-	{ "WPI CDD-820", NULL },
-	{ "SAMSUNG CD-ROM SC-148C", NULL },
-	{ "SAMSUNG CD-ROM SC-148F", NULL },
-	{ "SAMSUNG CD-ROM SC", NULL },
-	{ "SanDisk SDP3B-64", NULL },
-	{ "SAMSUNG CD-ROM SN-124", NULL },
-	{ "PLEXTOR CD-R PX-W8432T", NULL },
-	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM", NULL },
-	{ "_NEC DV5800A", NULL },
-	{ NULL,	NULL }
-
-};
-
-static int in_drive_list(struct hd_driveid *id, struct drive_list_entry * drive_table)
-{
-	for ( ; drive_table->id_model ; drive_table++)
-		if ((!strcmp(drive_table->id_model, id->model)) &&
-		    ((drive_table->id_firmware && !strstr(drive_table->id_firmware, id->fw_rev)) ||
-		     (!drive_table->id_firmware)))
-			return 1;
-	return 0;
-}
-
-#else
-
-/*
- * good_dma_drives() lists the model names (from "hdparm -i")
- * of drives which do not support mode2 DMA but which are
- * known to work fine with this interface under Linux.
- */
-const char *good_dma_drives[] = {"Micropolis 2112A",
-				 "CONNER CTMA 4000",
-				 "CONNER CTT8000-A",
-				 "ST34342A",	/* for Sun Ultra */
-				 NULL};
-
-/*
- * bad_dma_drives() lists the model names (from "hdparm -i")
- * of drives which supposedly support (U)DMA but which are
- * known to corrupt data with this interface under Linux.
- *
- * This is an empirical list. Its generated from bug reports. That means
- * while it reflects actual problem distributions it doesn't answer whether
- * the drive or the controller, or cabling, or software, or some combination
- * thereof is the fault. If you don't happen to agree with the kernel's
- * opinion of your drive - use hdparm to turn DMA on.
- */
-const char *bad_dma_drives[] = {"WDC AC11000H",
-				"WDC AC22100H",
-				"WDC AC32100H",
-				"WDC AC32500H",
-				"WDC AC33100H",
-				"WDC AC31600H",
-				NULL};
-
-#endif
-
-/*
- * This is the handler for disk read/write DMA interrupts.
- */
-ide_startstop_t ide_dma_intr(struct ata_device *drive, struct request *rq)
-{
-	u8 stat, dma_stat;
-
-	dma_stat = udma_stop(drive);
-	if (OK_STAT(stat = GET_STAT(),DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
-		if (!dma_stat) {
-			__ide_end_request(drive, rq, 1, rq->nr_sectors);
-			return ide_stopped;
-		}
-		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
-		       drive->name, dma_stat);
-	}
-	return ide_error(drive, rq, "dma_intr", stat);
-}
-
-/*
- * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
- * FIXME: I agree with Jens --mdcki!
- */
-static int build_sglist(struct ata_channel *ch, struct request *rq)
-{
-	struct scatterlist *sg = ch->sg_table;
-	int nents = 0;
-
-	if (rq->flags & REQ_DRIVE_ACB) {
-		struct ata_taskfile *args = rq->special;
-#if 1
-		unsigned char *virt_addr = rq->buffer;
-		int sector_count = rq->nr_sectors;
-#else
-		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
-
-		if (nents > rq->nr_segments)
-			printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
-#endif
-
-		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-			ch->sg_dma_direction = PCI_DMA_TODEVICE;
-		else
-			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
-
-		/*
-		 * FIXME: This depends upon a hard coded page size!
-		 */
-		if (sector_count > 128) {
-			memset(&sg[nents], 0, sizeof(*sg));
-
-			sg[nents].page = virt_to_page(virt_addr);
-			sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
-			sg[nents].length = 128  * SECTOR_SIZE;
-			++nents;
-			virt_addr = virt_addr + (128 * SECTOR_SIZE);
-			sector_count -= 128;
-		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
-		sg[nents].length =  sector_count  * SECTOR_SIZE;
-		++nents;
-	} else {
-		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
-
-		if (rq->q && nents > rq->nr_phys_segments)
-			printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
-
-		if (rq_data_dir(rq) == READ)
-			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
-		else
-			ch->sg_dma_direction = PCI_DMA_TODEVICE;
-
-	}
-	return pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
-}
-
-/*
- *  For both Blacklisted and Whitelisted drives.
- *  This is setup to be called as an extern for future support
- *  to other special driver code.
- */
-int check_drive_lists(struct ata_device *drive, int good_bad)
-{
-	struct hd_driveid *id = drive->id;
-
-#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
-	if (good_bad) {
-		return in_drive_list(id, drive_whitelist);
-	} else {
-		int blacklist = in_drive_list(id, drive_blacklist);
-		if (blacklist)
-			printk("%s: Disabling (U)DMA for %s\n", drive->name, id->model);
-		return(blacklist);
-	}
-#else
-	const char **list;
-
-	if (good_bad) {
-		/* Consult the list of known "good" drives */
-		list = good_dma_drives;
-		while (*list) {
-			if (!strcmp(*list++,id->model))
-				return 1;
-		}
-	} else {
-		/* Consult the list of known "bad" drives */
-		list = bad_dma_drives;
-		while (*list) {
-			if (!strcmp(*list++,id->model)) {
-				printk("%s: Disabling (U)DMA for %s\n",
-					drive->name, id->model);
-				return 1;
-			}
-		}
-	}
-#endif
-	return 0;
-}
-
-static int config_drive_for_dma(struct ata_device *drive)
-{
-	int config_allows_dma = 1;
-	struct hd_driveid *id = drive->id;
-	struct ata_channel *ch = drive->channel;
-
-#ifdef CONFIG_IDEDMA_ONLYDISK
-	if (drive->type != ATA_DISK)
-		config_allows_dma = 0;
-#endif
-
-	if (id && (id->capability & 1) && ch->autodma && config_allows_dma) {
-		/* Consult the list of known "bad" drives */
-		if (udma_black_list(drive)) {
-			udma_enable(drive, 0, 1);
-
-			return 0;
-		}
-
-		/* Enable DMA on any drive that has UltraDMA (mode 6/7/?) enabled */
-		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
-			if ((id->dma_ultra & (id->dma_ultra >> 14) & 2)) {
-				udma_enable(drive, 1, 1);
-
-				return 0;
-			}
-		/* Enable DMA on any drive that has UltraDMA (mode 3/4/5) enabled */
-		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
-			if ((id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
-				udma_enable(drive, 1, 1);
-
-				return 0;
-			}
-		/* Enable DMA on any drive that has UltraDMA (mode 0/1/2) enabled */
-		if (id->field_valid & 4)	/* UltraDMA */
-			if ((id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
-				udma_enable(drive, 1, 1);
-
-				return 0;
-			}
-		/* Enable DMA on any drive that has mode2 DMA (multi or single) enabled */
-		if (id->field_valid & 2)	/* regular DMA */
-			if ((id->dma_mword & 0x404) == 0x404 || (id->dma_1word & 0x404) == 0x404) {
-				udma_enable(drive, 1, 1);
-
-				return 0;
-			}
-		/* Consult the list of known "good" drives */
-		if (udma_white_list(drive)) {
-			udma_enable(drive, 1, 1);
-
-			return 0;
-		}
-	}
-	udma_enable(drive, 0, 0);
-
-	return 0;
-}
-
-/*
- * 1 dma-ing, 2 error, 4 intr
- */
-static int dma_timer_expiry(struct ata_device *drive, struct request *rq)
-{
-	/* FIXME: What's that? */
-	u8 dma_stat = inb(drive->channel->dma_base+2);
-
-#ifdef DEBUG
-	printk("%s: dma_timer_expiry: dma status == 0x%02x\n", drive->name, dma_stat);
-#endif
-
-#if 0
-	drive->expiry = NULL;	/* one free ride for now */
-#endif
-
-	if (dma_stat & 2) {	/* ERROR */
-		u8 stat = GET_STAT();
-		return ide_error(drive, rq, "dma_timer_expiry", stat);
-	}
-	if (dma_stat & 1)	/* DMAing */
-		return WAIT_CMD;
-	return 0;
-}
-
-int ata_start_dma(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-	unsigned int reading = 0;
-
-	if (rq_data_dir(rq) == READ)
-		reading = 1 << 3;
-
-	/* try PIO instead of DMA */
-	if (!udma_new_table(ch, rq))
-		return 1;
-
-	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
-	outb(reading, dma_base);		/* specify r/w */
-	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
-	drive->waiting_for_dma = 1;
-	return 0;
-}
-
-/*
- * This initiates/aborts DMA read/write operations on a drive.
- *
- * The caller is assumed to have selected the drive and programmed the drive's
- * sector address using CHS or LBA.  All that remains is to prepare for DMA
- * and then issue the actual read/write DMA/PIO command to the drive.
- *
- * For ATAPI devices, we just prepare for DMA and return. The caller should
- * then issue the packet command to the drive and call us again with
- * udma_start afterwards.
- *
- * Returns 0 if all went well.
- * Returns 1 if DMA read/write could not be started, in which case
- * the caller should revert to PIO for the current request.
- * May also be invoked from trm290.c
- */
-int XXX_ide_dmaproc(struct ata_device *drive)
-{
-	return config_drive_for_dma(drive);
-}
-
-/*
- * Needed for allowing full modular support of ide-driver
- */
-void ide_release_dma(struct ata_channel *ch)
-{
-	if (!ch->dma_base)
-		return;
-
-	if (ch->dmatable_cpu) {
-		pci_free_consistent(ch->pci_dev,
-				    PRD_ENTRIES * PRD_BYTES,
-				    ch->dmatable_cpu,
-				    ch->dmatable_dma);
-		ch->dmatable_cpu = NULL;
-	}
-	if (ch->sg_table) {
-		kfree(ch->sg_table);
-		ch->sg_table = NULL;
-	}
-	if ((ch->dma_extra) && (ch->unit == 0))
-		release_region((ch->dma_base + 16), ch->dma_extra);
-	release_region(ch->dma_base, 8);
-	ch->dma_base = 0;
-}
-
-/*
- * This can be called for a dynamically installed interface. Don't __init it
- */
-void ata_init_dma(struct ata_channel *ch, unsigned long dma_base)
-{
-	if (!request_region(dma_base, 8, ch->name)) {
-		printk(KERN_ERR "ATA: ERROR: BM DMA portst already in use!\n");
-
-		return;
-	}
-	printk(KERN_INFO"    %s: BM-DMA at 0x%04lx-0x%04lx", ch->name, dma_base, dma_base + 7);
-	ch->dma_base = dma_base;
-	ch->dmatable_cpu = pci_alloc_consistent(ch->pci_dev,
-						  PRD_ENTRIES * PRD_BYTES,
-						  &ch->dmatable_dma);
-	if (ch->dmatable_cpu == NULL)
-		goto dma_alloc_failure;
-
-	ch->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
-				 GFP_KERNEL);
-	if (ch->sg_table == NULL) {
-		pci_free_consistent(ch->pci_dev, PRD_ENTRIES * PRD_BYTES,
-				    ch->dmatable_cpu, ch->dmatable_dma);
-		goto dma_alloc_failure;
-	}
-
-	if (!ch->XXX_udma)
-		ch->XXX_udma = XXX_ide_dmaproc;
-
-	if (ch->chipset != ide_trm290) {
-		u8 dma_stat = inb(dma_base+2);
-		printk(", BIOS settings: %s:%s, %s:%s",
-		       ch->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       ch->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
-	}
-	printk("\n");
-	return;
-
-dma_alloc_failure:
-	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
-}
-
-/****************************************************************************
- * UDMA function which should have architecture specific counterparts where
- * neccessary.
- *
- * The intention is that at some point in time we will move this whole to
- * architecture specific kernel sections. For now I would love the architecture
- * maintainers to just #ifdef #endif this stuff directly here. I have for now
- * tryed to update as much as I could in the architecture specific code.  But
- * of course I may have done mistakes, so please bear with me and update it
- * here the proper way.
- *
- * Thank you a lot in advance!
- *
- * Sat May  4 20:29:46 CEST 2002 Marcin Dalecki.
- */
-
-/*
- * This is the generic part of the DMA setup used by the host chipset drivers
- * in the corresponding DMA setup method.
- *
- * FIXME: there are some places where this gets used driectly for "error
- * recovery" in the ATAPI drivers. This was just plain wrong before, in esp.
- * not portable, and just got uncovered now.
- */
-void udma_enable(struct ata_device *drive, int on, int verbose)
-{
-	struct ata_channel *ch = drive->channel;
-	int set_high = 1;
-	u8 unit;
-	u64 addr;
-
-
-	/* Method overloaded by host chip specific code. */
-	if (ch->udma_enable) {
-		ch->udma_enable(drive, on, verbose);
-
-		return;
-	}
-
-	/* Fall back to the default implementation. */
-	unit = (drive->select.b.unit & 0x01);
-	addr = BLK_BOUNCE_HIGH;
-
-	if (!on) {
-		if (verbose)
-			printk("%s: DMA disabled\n", drive->name);
-		set_high = 0;
-		outb(inb(ch->dma_base + 2) & ~(1 << (5 + unit)), ch->dma_base + 2);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-		udma_tcq_enable(drive, 0);
-#endif
-	}
-
-	/* toggle bounce buffers */
-
-	if (on && drive->type == ATA_DISK && drive->channel->highmem) {
-		if (!PCI_DMA_BUS_IS_PHYS)
-			addr = BLK_BOUNCE_ANY;
-		else
-			addr = drive->channel->pci_dev->dma_mask;
-	}
-
-	blk_queue_bounce_limit(&drive->queue, addr);
-
-	drive->using_dma = on;
-
-	if (on) {
-		outb(inb(ch->dma_base + 2) | (1 << (5 + unit)), ch->dma_base + 2);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-		udma_tcq_enable(drive, 1);
-#endif
-	}
-}
-
-/*
- * This prepares a dma request.  Returns 0 if all went okay, returns 1
- * otherwise.  May also be invoked from trm290.c
- */
-int udma_new_table(struct ata_channel *ch, struct request *rq)
-{
-	unsigned int *table = ch->dmatable_cpu;
-#ifdef CONFIG_BLK_DEV_TRM290
-	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
-#else
-	const int is_trm290_chipset = 0;
-#endif
-	unsigned int count = 0;
-	int i;
-	struct scatterlist *sg;
-
-	ch->sg_nents = i = build_sglist(ch, rq);
-	if (!i)
-		return 0;
-
-	sg = ch->sg_table;
-	while (i) {
-		u32 cur_addr;
-		u32 cur_len;
-
-		cur_addr = sg_dma_address(sg);
-		cur_len = sg_dma_len(sg);
-
-		/*
-		 * Fill in the dma table, without crossing any 64kB boundaries.
-		 * Most hardware requires 16-bit alignment of all blocks,
-		 * but the trm290 requires 32-bit alignment.
-		 */
-
-		while (cur_len) {
-			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
-
-			if (count++ >= PRD_ENTRIES) {
-				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
-						count, ch->sg_nents, cur_len, cur_addr);
-				BUG();
-			}
-
-			if (bcount > cur_len)
-				bcount = cur_len;
-			*table++ = cpu_to_le32(cur_addr);
-			xcount = bcount & 0xffff;
-			if (is_trm290_chipset)
-				xcount = ((xcount >> 2) - 1) << 16;
-			if (xcount == 0x0000) {
-		        /*
-			 * Most chipsets correctly interpret a length of
-			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
-			 * misinterprets it as zero (!). So here we break
-			 * the 64KB entry into two 32KB entries instead.
-			 */
-				if (count++ >= PRD_ENTRIES) {
-					pci_unmap_sg(ch->pci_dev, sg,
-						     ch->sg_nents,
-						     ch->sg_dma_direction);
-					return 0;
-				}
-
-				*table++ = cpu_to_le32(0x8000);
-				*table++ = cpu_to_le32(cur_addr + 0x8000);
-				xcount = 0x8000;
-			}
-			*table++ = cpu_to_le32(xcount);
-			cur_addr += bcount;
-			cur_len -= bcount;
-		}
-
-		sg++;
-		i--;
-	}
-
-	if (!count)
-		printk(KERN_ERR "%s: empty DMA table?\n", ch->name);
-	else if (!is_trm290_chipset)
-		*--table |= cpu_to_le32(0x80000000);
-
-	return count;
-}
-
-/* Teardown mappings after DMA has completed.  */
-void udma_destroy_table(struct ata_channel *ch)
-{
-	pci_unmap_sg(ch->pci_dev, ch->sg_table, ch->sg_nents, ch->sg_dma_direction);
-}
-
-void udma_print(struct ata_device *drive)
-{
-#ifdef CONFIG_ARCH_ACORN
-	printk(", DMA");
-#else
-	struct hd_driveid *id = drive->id;
-	char *str = NULL;
-
-	if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-	    (id->dma_ultra & (id->dma_ultra >> 14) & 3)) {
-		if ((id->dma_ultra >> 15) & 1)
-			str = ", UDMA(mode 7)";	/* UDMA BIOS-enabled! */
-		else
-			str = ", UDMA(133)";	/* UDMA BIOS-enabled! */
-	} else if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-		  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
-		if ((id->dma_ultra >> 13) & 1) {
-			str = ", UDMA(100)";	/* UDMA BIOS-enabled! */
-		} else if ((id->dma_ultra >> 12) & 1) {
-			str = ", UDMA(66)";	/* UDMA BIOS-enabled! */
-		} else {
-			str = ", UDMA(44)";	/* UDMA BIOS-enabled! */
-		}
-	} else if ((id->field_valid & 4) &&
-		   (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
-		if ((id->dma_ultra >> 10) & 1) {
-			str = ", UDMA(33)";	/* UDMA BIOS-enabled! */
-		} else if ((id->dma_ultra >> 9) & 1) {
-			str = ", UDMA(25)";	/* UDMA BIOS-enabled! */
-		} else {
-			str = ", UDMA(16)";	/* UDMA BIOS-enabled! */
-		}
-	} else if (id->field_valid & 4)
-		str = ", (U)DMA";	/* Can be BIOS-enabled! */
-	else
-		str = ", DMA";
-
-	printk(str);
-#endif
-}
-
-/*
- * Drive back/white list handling for UDMA capability:
- */
-
-int udma_black_list(struct ata_device *drive)
-{
-	return check_drive_lists(drive, 0);
-}
-
-int udma_white_list(struct ata_device *drive)
-{
-	return check_drive_lists(drive, 1);
-}
-
-/*
- * Generic entry points for functions provided possibly by the host chip set
- * drivers.
- */
-
-/*
- * Prepare the channel for a DMA startfer. Please note that only the broken
- * Pacific Digital host chip needs the reques to be passed there to decide
- * about addressing modes.
- */
-
-int udma_start(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-
-	if (ch->udma_start)
-		return ch->udma_start(drive, rq);
-
-	/* Note that this is done *after* the cmd has
-	 * been issued to the drive, as per the BM-IDE spec.
-	 * The Promise Ultra33 doesn't work correctly when
-	 * we do this part before issuing the drive cmd.
-	 */
-	outb(inb(dma_base)|1, dma_base);		/* start DMA */
-	return 0;
-}
-
-int udma_stop(struct ata_device *drive)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-	u8 dma_stat;
-
-	if (ch->udma_stop)
-		return ch->udma_stop(drive);
-
-	drive->waiting_for_dma = 0;
-	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-	dma_stat = inb(dma_base+2);		/* get DMA status */
-	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
-	udma_destroy_table(ch);			/* purge DMA mappings */
-
-	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
-}
-
-/*
- * This is the default read write function.
- *
- * It's exported only for host chips which use it for fallback or (too) late
- * capability checking.
- */
-
-int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
-{
-	if (ata_start_dma(drive, rq))
-		return 1;
-
-	if (drive->type != ATA_DISK)
-		return 0;
-
-	reading <<= 3;
-
-	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-	if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
-		struct ata_taskfile *args = rq->special;
-
-		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
-	} else if (drive->addressing) {
-		OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-	} else {
-		OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-	}
-
-	return udma_start(drive, rq);
-}
-
-int udma_read(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-
-	if (ch->udma_read)
-		return ch->udma_read(drive, rq);
-
-	return ata_do_udma(1, drive, rq);
-}
-
-int udma_write(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-
-	if (ch->udma_write)
-		return ch->udma_write(drive, rq);
-
-	return ata_do_udma(0, drive, rq);
-}
-
-/*
- * FIXME: This should be attached to a channel as we can see now!
- */
-int udma_irq_status(struct ata_device *drive)
-{
-	struct ata_channel *ch = drive->channel;
-	u8 dma_stat;
-
-	if (ch->udma_irq_status)
-		return ch->udma_irq_status(drive);
-
-	/* default action */
-	dma_stat = inb(ch->dma_base + 2);
-
-	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-}
-
-void udma_timeout(struct ata_device *drive)
-{
-	printk(KERN_ERR "ATA: UDMA timeout occured %s!\n", drive->name);
-
-	/* Invoke the chipset specific handler now. */
-	if (drive->channel->udma_timeout)
-		drive->channel->udma_timeout(drive);
-
-}
-
-void udma_irq_lost(struct ata_device *drive)
-{
-	if (drive->channel->udma_irq_lost)
-		drive->channel->udma_irq_lost(drive);
-}
-
-EXPORT_SYMBOL(udma_enable);
-EXPORT_SYMBOL(udma_start);
-EXPORT_SYMBOL(udma_stop);
-EXPORT_SYMBOL(udma_read);
-EXPORT_SYMBOL(udma_write);
-EXPORT_SYMBOL(ata_do_udma);
-EXPORT_SYMBOL(udma_irq_status);
-EXPORT_SYMBOL(udma_print);
-EXPORT_SYMBOL(udma_black_list);
-EXPORT_SYMBOL(udma_white_list);
diff -urN linux-2.5.15/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.15/drivers/ide/ide-taskfile.c	2002-05-15 14:55:12.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-15 14:07:43.000000000 +0200
@@ -562,7 +562,7 @@
 		if (!ide_end_request(drive, rq, 1))
 			return ide_stopped;
 
-	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
+	if ((rq->nr_sectors == 1) != (stat & DRQ_STAT)) {
 		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
diff -urN linux-2.5.15/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.15/drivers/ide/Makefile	2002-05-15 14:55:12.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-05-14 17:10:48.000000000 +0200
@@ -10,7 +10,7 @@
 
 O_TARGET := idedriver.o
 
-export-objs	:= ide-taskfile.o ide.o ide-features.o ide-probe.o ide-dma.o ataraid.o
+export-objs	:= ide-taskfile.o ide.o ide-features.o ide-probe.o quirks.o pcidma.o ataraid.o
 
 obj-y		:=
 obj-m		:=
@@ -43,7 +43,8 @@
 ide-obj-$(CONFIG_BLK_DEV_HPT366)	+= hpt366.o
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
-ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_IDEDMA)	+= quirks.o
+ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= pcidma.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= tcq.o
 ide-obj-$(CONFIG_PCI)			+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
diff -urN linux-2.5.15/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.15/drivers/ide/pcidma.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/ide/pcidma.c	2002-05-15 13:28:50.000000000 +0200
@@ -0,0 +1,555 @@
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
+ *  Copyright (C) 2002	     Marcin Dalecki <martin@dalecki.de>
+ *
+ *  Based on previous work by:
+ *
+ *  Copyright (c) 1999-2000  Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (c) 1995-1998  Mark Lord
+ *
+ *  May be copied or modified under the terms of the GNU General Public License
+ */
+
+/*
+ * Those are the generic BM DMA support functions for PCI bus based systems.
+ */
+
+#include <linux/config.h>
+#define __NO_VERSION__
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#define DEFAULT_BMIBA	0xe800	/* in case BIOS did not init it */
+#define DEFAULT_BMCRBA	0xcc00	/* VIA's default value */
+#define DEFAULT_BMALIBA	0xd400	/* ALI's default value */
+
+/*
+ * This is the handler for disk read/write DMA interrupts.
+ */
+ide_startstop_t ide_dma_intr(struct ata_device *drive, struct request *rq)
+{
+	u8 stat, dma_stat;
+
+	dma_stat = udma_stop(drive);
+	if (OK_STAT(stat = GET_STAT(),DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
+		if (!dma_stat) {
+			__ide_end_request(drive, rq, 1, rq->nr_sectors);
+			return ide_stopped;
+		}
+		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
+		       drive->name, dma_stat);
+	}
+	return ide_error(drive, rq, "dma_intr", stat);
+}
+
+/*
+ * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
+ * FIXME: I agree with Jens --mdcki!
+ */
+static int build_sglist(struct ata_channel *ch, struct request *rq)
+{
+	struct scatterlist *sg = ch->sg_table;
+	int nents = 0;
+
+	if (rq->flags & REQ_DRIVE_ACB) {
+		struct ata_taskfile *args = rq->special;
+#if 1
+		unsigned char *virt_addr = rq->buffer;
+		int sector_count = rq->nr_sectors;
+#else
+		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
+
+		if (nents > rq->nr_segments)
+			printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
+#endif
+
+		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+			ch->sg_dma_direction = PCI_DMA_TODEVICE;
+		else
+			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
+		/*
+		 * FIXME: This depends upon a hard coded page size!
+		 */
+		if (sector_count > 128) {
+			memset(&sg[nents], 0, sizeof(*sg));
+
+			sg[nents].page = virt_to_page(virt_addr);
+			sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+			sg[nents].length = 128  * SECTOR_SIZE;
+			++nents;
+			virt_addr = virt_addr + (128 * SECTOR_SIZE);
+			sector_count -= 128;
+		}
+		memset(&sg[nents], 0, sizeof(*sg));
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+		sg[nents].length =  sector_count  * SECTOR_SIZE;
+		++nents;
+	} else {
+		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
+
+		if (rq->q && nents > rq->nr_phys_segments)
+			printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+
+		if (rq_data_dir(rq) == READ)
+			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		else
+			ch->sg_dma_direction = PCI_DMA_TODEVICE;
+
+	}
+
+	return pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
+}
+
+/*
+ * 1 dma-ing, 2 error, 4 intr
+ */
+static int dma_timer_expiry(struct ata_device *drive, struct request *rq)
+{
+	/* FIXME: What's that? */
+	u8 dma_stat = inb(drive->channel->dma_base+2);
+
+#ifdef DEBUG
+	printk("%s: dma_timer_expiry: dma status == 0x%02x\n", drive->name, dma_stat);
+#endif
+
+#if 0
+	drive->expiry = NULL;	/* one free ride for now */
+#endif
+
+	if (dma_stat & 2) {	/* ERROR */
+		u8 stat = GET_STAT();
+		return ide_error(drive, rq, "dma_timer_expiry", stat);
+	}
+	if (dma_stat & 1)	/* DMAing */
+		return WAIT_CMD;
+	return 0;
+}
+
+int ata_start_dma(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	unsigned int reading = 0;
+
+	if (rq_data_dir(rq) == READ)
+		reading = 1 << 3;
+
+	/* try PIO instead of DMA */
+	if (!udma_new_table(ch, rq))
+		return 1;
+
+	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+	drive->waiting_for_dma = 1;
+
+	return 0;
+}
+
+/*
+ * Configure a device for DMA operation.
+ */
+int XXX_ide_dmaproc(struct ata_device *drive)
+{
+	int config_allows_dma = 1;
+	struct hd_driveid *id = drive->id;
+	struct ata_channel *ch = drive->channel;
+
+#ifdef CONFIG_IDEDMA_ONLYDISK
+	if (drive->type != ATA_DISK)
+		config_allows_dma = 0;
+#endif
+
+	if (id && (id->capability & 1) && ch->autodma && config_allows_dma) {
+		/* Consult the list of known "bad" drives */
+		if (udma_black_list(drive)) {
+			udma_enable(drive, 0, 1);
+
+			return 0;
+		}
+
+		/* Enable DMA on any drive that has UltraDMA (mode 6/7/?) enabled */
+		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
+			if ((id->dma_ultra & (id->dma_ultra >> 14) & 2)) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
+		/* Enable DMA on any drive that has UltraDMA (mode 3/4/5) enabled */
+		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
+			if ((id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
+		/* Enable DMA on any drive that has UltraDMA (mode 0/1/2) enabled */
+		if (id->field_valid & 4)	/* UltraDMA */
+			if ((id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
+		/* Enable DMA on any drive that has mode2 DMA (multi or single) enabled */
+		if (id->field_valid & 2)	/* regular DMA */
+			if ((id->dma_mword & 0x404) == 0x404 || (id->dma_1word & 0x404) == 0x404) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
+		/* Consult the list of known "good" drives */
+		if (udma_white_list(drive)) {
+			udma_enable(drive, 1, 1);
+
+			return 0;
+		}
+	}
+	udma_enable(drive, 0, 0);
+
+	return 0;
+}
+
+/*
+ * Needed for allowing full modular support of ide-driver
+ */
+void ide_release_dma(struct ata_channel *ch)
+{
+	if (!ch->dma_base)
+		return;
+
+	if (ch->dmatable_cpu) {
+		pci_free_consistent(ch->pci_dev,
+				    PRD_ENTRIES * PRD_BYTES,
+				    ch->dmatable_cpu,
+				    ch->dmatable_dma);
+		ch->dmatable_cpu = NULL;
+	}
+	if (ch->sg_table) {
+		kfree(ch->sg_table);
+		ch->sg_table = NULL;
+	}
+	if ((ch->dma_extra) && (ch->unit == 0))
+		release_region((ch->dma_base + 16), ch->dma_extra);
+	release_region(ch->dma_base, 8);
+	ch->dma_base = 0;
+}
+
+/****************************************************************************
+ * PCI specific UDMA channel method implementations.
+ */
+
+/*
+ * This is the generic part of the DMA setup used by the host chipset drivers
+ * in the corresponding DMA setup method.
+ *
+ * FIXME: there are some places where this gets used driectly for "error
+ * recovery" in the ATAPI drivers. This was just plain wrong before, in esp.
+ * not portable, and just got uncovered now.
+ */
+static void udma_pci_enable(struct ata_device *drive, int on, int verbose)
+{
+	struct ata_channel *ch = drive->channel;
+	int set_high = 1;
+	u8 unit;
+	u64 addr;
+
+	/* Fall back to the default implementation. */
+	unit = (drive->select.b.unit & 0x01);
+	addr = BLK_BOUNCE_HIGH;
+
+	if (!on) {
+		if (verbose)
+			printk("%s: DMA disabled\n", drive->name);
+		set_high = 0;
+		outb(inb(ch->dma_base + 2) & ~(1 << (5 + unit)), ch->dma_base + 2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		udma_tcq_enable(drive, 0);
+#endif
+	}
+
+	/* toggle bounce buffers */
+
+	if (on && drive->type == ATA_DISK && drive->channel->highmem) {
+		if (!PCI_DMA_BUS_IS_PHYS)
+			addr = BLK_BOUNCE_ANY;
+		else
+			addr = drive->channel->pci_dev->dma_mask;
+	}
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+
+	drive->using_dma = on;
+
+	if (on) {
+		outb(inb(ch->dma_base + 2) | (1 << (5 + unit)), ch->dma_base + 2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+		udma_tcq_enable(drive, 1);
+#endif
+	}
+}
+
+/*
+ * This prepares a dma request.  Returns 0 if all went okay, returns 1
+ * otherwise.  May also be invoked from trm290.c
+ */
+int udma_new_table(struct ata_channel *ch, struct request *rq)
+{
+	unsigned int *table = ch->dmatable_cpu;
+#ifdef CONFIG_BLK_DEV_TRM290
+	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
+#else
+	const int is_trm290_chipset = 0;
+#endif
+	unsigned int count = 0;
+	int i;
+	struct scatterlist *sg;
+
+	ch->sg_nents = i = build_sglist(ch, rq);
+	if (!i)
+		return 0;
+
+	sg = ch->sg_table;
+	while (i) {
+		u32 cur_addr;
+		u32 cur_len;
+
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		/*
+		 * Fill in the dma table, without crossing any 64kB boundaries.
+		 * Most hardware requires 16-bit alignment of all blocks,
+		 * but the trm290 requires 32-bit alignment.
+		 */
+
+		while (cur_len) {
+			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
+
+			if (count++ >= PRD_ENTRIES) {
+				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
+						count, ch->sg_nents, cur_len, cur_addr);
+				BUG();
+			}
+
+			if (bcount > cur_len)
+				bcount = cur_len;
+			*table++ = cpu_to_le32(cur_addr);
+			xcount = bcount & 0xffff;
+			if (is_trm290_chipset)
+				xcount = ((xcount >> 2) - 1) << 16;
+			if (xcount == 0x0000) {
+		        /*
+			 * Most chipsets correctly interpret a length of
+			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
+			 * misinterprets it as zero (!). So here we break
+			 * the 64KB entry into two 32KB entries instead.
+			 */
+				if (count++ >= PRD_ENTRIES) {
+					pci_unmap_sg(ch->pci_dev, sg,
+						     ch->sg_nents,
+						     ch->sg_dma_direction);
+					return 0;
+				}
+
+				*table++ = cpu_to_le32(0x8000);
+				*table++ = cpu_to_le32(cur_addr + 0x8000);
+				xcount = 0x8000;
+			}
+			*table++ = cpu_to_le32(xcount);
+			cur_addr += bcount;
+			cur_len -= bcount;
+		}
+
+		sg++;
+		i--;
+	}
+
+	if (!count)
+		printk(KERN_ERR "%s: empty DMA table?\n", ch->name);
+	else if (!is_trm290_chipset)
+		*--table |= cpu_to_le32(0x80000000);
+
+	return count;
+}
+
+/* Teardown mappings after DMA has completed.  */
+void udma_destroy_table(struct ata_channel *ch)
+{
+	pci_unmap_sg(ch->pci_dev, ch->sg_table, ch->sg_nents, ch->sg_dma_direction);
+}
+
+/*
+ * Prepare the channel for a DMA startfer. Please note that only the broken
+ * Pacific Digital host chip needs the reques to be passed there to decide
+ * about addressing modes.
+ */
+
+static int udma_pci_start(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+
+	/* Note that this is done *after* the cmd has
+	 * been issued to the drive, as per the BM-IDE spec.
+	 * The Promise Ultra33 doesn't work correctly when
+	 * we do this part before issuing the drive cmd.
+	 */
+	outb(inb(dma_base)|1, dma_base);		/* start DMA */
+	return 0;
+}
+
+static int udma_pci_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* purge DMA mappings */
+
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
+}
+
+static int udma_pci_read(struct ata_device *drive, struct request *rq)
+{
+	return ata_do_udma(1, drive, rq);
+}
+
+static int udma_pci_write(struct ata_device *drive, struct request *rq)
+{
+	return ata_do_udma(0, drive, rq);
+}
+
+/*
+ * FIXME: This should be attached to a channel as we can see now!
+ */
+static int udma_pci_irq_status(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	u8 dma_stat;
+
+	/* default action */
+	dma_stat = inb(ch->dma_base + 2);
+
+	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
+}
+
+static void udma_pci_timeout(struct ata_device *drive)
+{
+	printk(KERN_ERR "ATA: UDMA timeout occured %s!\n", drive->name);
+}
+
+static void udma_pci_irq_lost(struct ata_device *drive)
+{
+}
+
+/*
+ * This can be called for a dynamically installed interface. Don't __init it
+ */
+void ata_init_dma(struct ata_channel *ch, unsigned long dma_base)
+{
+	if (!request_region(dma_base, 8, ch->name)) {
+		printk(KERN_ERR "ATA: ERROR: BM DMA portst already in use!\n");
+
+		return;
+	}
+	printk(KERN_INFO"    %s: BM-DMA at 0x%04lx-0x%04lx", ch->name, dma_base, dma_base + 7);
+	ch->dma_base = dma_base;
+	ch->dmatable_cpu = pci_alloc_consistent(ch->pci_dev,
+						  PRD_ENTRIES * PRD_BYTES,
+						  &ch->dmatable_dma);
+	if (ch->dmatable_cpu == NULL)
+		goto dma_alloc_failure;
+
+	ch->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
+				 GFP_KERNEL);
+	if (ch->sg_table == NULL) {
+		pci_free_consistent(ch->pci_dev, PRD_ENTRIES * PRD_BYTES,
+				    ch->dmatable_cpu, ch->dmatable_dma);
+		goto dma_alloc_failure;
+	}
+
+	/*
+	 * We could just assign them, and then leave it up to the chipset
+	 * specific code to override these after they've called this function.
+	 */
+	if (!ch->XXX_udma)
+		ch->XXX_udma = XXX_ide_dmaproc;
+	if (!ch->udma_enable)
+		ch->udma_enable = udma_pci_enable;
+	if (!ch->udma_start)
+		ch->udma_start = udma_pci_start;
+	if (!ch->udma_stop)
+		ch->udma_stop = udma_pci_stop;
+	if (!ch->udma_read)
+		ch->udma_read = udma_pci_read;
+	if (!ch->udma_write)
+		ch->udma_write = udma_pci_write;
+	if (!ch->udma_irq_status)
+		ch->udma_irq_status = udma_pci_irq_status;
+	if (!ch->udma_timeout)
+		ch->udma_timeout = udma_pci_timeout;
+	if (!ch->udma_irq_lost)
+		ch->udma_irq_lost = udma_pci_irq_lost;
+
+	if (ch->chipset != ide_trm290) {
+		u8 dma_stat = inb(dma_base+2);
+		printk(", BIOS settings: %s:%s, %s:%s",
+		       ch->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
+		       ch->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
+	}
+	printk("\n");
+	return;
+
+dma_alloc_failure:
+	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
+}
+
+/*
+ * This is the default read write function.
+ *
+ * It's exported only for host chips which use it for fallback or (too) late
+ * capability checking.
+ */
+
+int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+{
+	if (ata_start_dma(drive, rq))
+		return 1;
+
+	if (drive->type != ATA_DISK)
+		return 0;
+
+	reading <<= 3;
+
+	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
+	if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
+		struct ata_taskfile *args = rq->special;
+
+		outb(args->taskfile.command, IDE_COMMAND_REG);
+	} else if (drive->addressing) {
+		outb(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+	} else {
+		outb(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+	}
+
+	return udma_start(drive, rq);
+}
+
+EXPORT_SYMBOL(ata_do_udma);
+EXPORT_SYMBOL(ide_dma_intr);
diff -urN linux-2.5.15/drivers/ide/pcihost.h linux/drivers/ide/pcihost.h
--- linux-2.5.15/drivers/ide/pcihost.h	2002-05-15 14:55:12.000000000 +0200
+++ linux/drivers/ide/pcihost.h	2002-05-15 13:29:10.000000000 +0200
@@ -10,10 +10,6 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 /*
diff -urN linux-2.5.15/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.15/drivers/ide/pdc202xx.c	2002-05-15 14:55:05.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-15 13:45:41.000000000 +0200
@@ -53,220 +53,10 @@
 #define PDC202XX_DEBUG_DRIVE_INFO		0
 #define PDC202XX_DECODE_REGISTER_INFO		0
 
-#undef DISPLAY_PDC202XX_TIMINGS
-
 #ifndef SPLIT_BYTE
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
 #endif
 
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static int pdc202xx_get_info(char *, char **, off_t, int);
-extern int (*pdc202xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-static struct pci_dev *bmide_dev;
-
-char *pdc202xx_pio_verbose (u32 drive_pci)
-{
-	if ((drive_pci & 0x000ff000) == 0x000ff000) return("NOTSET");
-	if ((drive_pci & 0x00000401) == 0x00000401) return("PIO 4");
-	if ((drive_pci & 0x00000602) == 0x00000602) return("PIO 3");
-	if ((drive_pci & 0x00000803) == 0x00000803) return("PIO 2");
-	if ((drive_pci & 0x00000C05) == 0x00000C05) return("PIO 1");
-	if ((drive_pci & 0x00001309) == 0x00001309) return("PIO 0");
-	return("PIO ?");
-}
-
-char *pdc202xx_dma_verbose (u32 drive_pci)
-{
-	if ((drive_pci & 0x00036000) == 0x00036000) return("MWDMA 2");
-	if ((drive_pci & 0x00046000) == 0x00046000) return("MWDMA 1");
-	if ((drive_pci & 0x00056000) == 0x00056000) return("MWDMA 0");
-	if ((drive_pci & 0x00056000) == 0x00056000) return("SWDMA 2");
-	if ((drive_pci & 0x00068000) == 0x00068000) return("SWDMA 1");
-	if ((drive_pci & 0x000BC000) == 0x000BC000) return("SWDMA 0");
-	return("PIO---");
-}
-
-char *pdc202xx_ultra_verbose (u32 drive_pci, u16 slow_cable)
-{
-	if ((drive_pci & 0x000ff000) == 0x000ff000)
-		return("NOTSET");
-	if ((drive_pci & 0x00012000) == 0x00012000)
-		return((slow_cable) ? "UDMA 2" : "UDMA 4");
-	if ((drive_pci & 0x00024000) == 0x00024000)
-		return((slow_cable) ? "UDMA 1" : "UDMA 3");
-	if ((drive_pci & 0x00036000) == 0x00036000)
-		return("UDMA 0");
-	return(pdc202xx_dma_verbose(drive_pci));
-}
-
-static char * pdc202xx_info (char *buf, struct pci_dev *dev)
-{
-	char *p = buf;
-
-	u32 bibma  = pci_resource_start(dev, 4);
-	u32 reg60h = 0, reg64h = 0, reg68h = 0, reg6ch = 0;
-	u16 reg50h = 0, pmask = (1<<10), smask = (1<<11);
-	u8 hi = 0, lo = 0;
-
-        /*
-         * at that point bibma+0x2 et bibma+0xa are byte registers
-         * to investigate:
-         */
-	u8 c0	= inb_p((unsigned short)bibma + 0x02);
-	u8 c1	= inb_p((unsigned short)bibma + 0x0a);
-
-	u8 sc11	= inb_p((unsigned short)bibma + 0x11);
-	u8 sc1a	= inb_p((unsigned short)bibma + 0x1a);
-	u8 sc1b	= inb_p((unsigned short)bibma + 0x1b);
-	u8 sc1c	= inb_p((unsigned short)bibma + 0x1c); 
-	u8 sc1d	= inb_p((unsigned short)bibma + 0x1d);
-	u8 sc1e	= inb_p((unsigned short)bibma + 0x1e);
-	u8 sc1f	= inb_p((unsigned short)bibma + 0x1f);
-
-	pci_read_config_word(dev, 0x50, &reg50h);
-	pci_read_config_dword(dev, 0x60, &reg60h);
-	pci_read_config_dword(dev, 0x64, &reg64h);
-	pci_read_config_dword(dev, 0x68, &reg68h);
-	pci_read_config_dword(dev, 0x6c, &reg6ch);
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20267:
-			p += sprintf(p, "\n                                PDC20267 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20265:
-			p += sprintf(p, "\n                                PDC20265 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20262:
-			p += sprintf(p, "\n                                PDC20262 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20246:
-			p += sprintf(p, "\n                                PDC20246 Chipset.\n");
-			reg50h |= 0x0c00;
-			break;
-		default:
-			p += sprintf(p, "\n                                PDC202XX Chipset.\n");
-			break;
-	}
-
-	p += sprintf(p, "------------------------------- General Status ---------------------------------\n");
-	p += sprintf(p, "Burst Mode                           : %sabled\n", (sc1f & 0x01) ? "en" : "dis");
-	p += sprintf(p, "Host Mode                            : %s\n", (sc1f & 0x08) ? "Tri-Stated" : "Normal");
-	p += sprintf(p, "Bus Clocking                         : %s\n",
-		((sc1f & 0xC0) == 0xC0) ? "100 External" :
-		((sc1f & 0x80) == 0x80) ? "66 External" :
-		((sc1f & 0x40) == 0x40) ? "33 External" : "33 PCI Internal");
-	p += sprintf(p, "IO pad select                        : %s mA\n",
-		((sc1c & 0x03) == 0x03) ? "10" :
-		((sc1c & 0x02) == 0x02) ? "8" :
-		((sc1c & 0x01) == 0x01) ? "6" :
-		((sc1c & 0x00) == 0x00) ? "4" : "??");
-	SPLIT_BYTE(sc1e, hi, lo);
-	p += sprintf(p, "Status Polling Period                : %d\n", hi);
-	p += sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);
-	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	p += sprintf(p, "                %s                         %s\n",
-		(c0&0x80)?"disabled":"enabled ",
-		(c1&0x80)?"disabled":"enabled ");
-	p += sprintf(p, "66 Clocking     %s                         %s\n",
-		(sc11&0x02)?"enabled ":"disabled",
-		(sc11&0x08)?"enabled ":"disabled");
-	p += sprintf(p, "           Mode %s                      Mode %s\n",
-		(sc1a & 0x01) ? "MASTER" : "PCI   ",
-		(sc1b & 0x01) ? "MASTER" : "PCI   ");
-	p += sprintf(p, "                %s                     %s\n",
-		(sc1d & 0x08) ? "Error       " :
-		((sc1d & 0x05) == 0x05) ? "Not My INTR " :
-		(sc1d & 0x04) ? "Interrupting" :
-		(sc1d & 0x02) ? "FIFO Full   " :
-		(sc1d & 0x01) ? "FIFO Empty  " : "????????????",
-		(sc1d & 0x80) ? "Error       " :
-		((sc1d & 0x50) == 0x50) ? "Not My INTR " :
-		(sc1d & 0x40) ? "Interrupting" :
-		(sc1d & 0x20) ? "FIFO Full   " :
-		(sc1d & 0x10) ? "FIFO Empty  " : "????????????");
-	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-		(c0&0x20)?"yes":"no ",(c0&0x40)?"yes":"no ",(c1&0x20)?"yes":"no ",(c1&0x40)?"yes":"no ");
-	p += sprintf(p, "DMA Mode:       %s           %s          %s            %s\n",
-		pdc202xx_ultra_verbose(reg60h, (reg50h & pmask)),
-		pdc202xx_ultra_verbose(reg64h, (reg50h & pmask)),
-		pdc202xx_ultra_verbose(reg68h, (reg50h & smask)),
-		pdc202xx_ultra_verbose(reg6ch, (reg50h & smask)));
-	p += sprintf(p, "PIO Mode:       %s            %s           %s            %s\n",
-		pdc202xx_pio_verbose(reg60h),
-		pdc202xx_pio_verbose(reg64h),
-		pdc202xx_pio_verbose(reg68h),
-		pdc202xx_pio_verbose(reg6ch));
-#if 0
-	p += sprintf(p, "--------------- Can ATAPI DMA ---------------\n");
-#endif
-	return (char *)p;
-}
-
-static char * pdc202xx_info_new (char *buf, struct pci_dev *dev)
-{
-	char *p = buf;
-//	u32 bibma = pci_resource_start(dev, 4);
-
-//	u32 reg60h = 0, reg64h = 0, reg68h = 0, reg6ch = 0;
-//	u16 reg50h = 0, word88 = 0;
-//	int udmasel[4]={0,0,0,0}, piosel[4]={0,0,0,0}, i=0, hd=0;
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20275:
-			p += sprintf(p, "\n                                PDC20275 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20276:
-			p += sprintf(p, "\n                                PDC20276 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20269:
-			p += sprintf(p, "\n                                PDC20269 TX2 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-			p += sprintf(p, "\n                                PDC20268 TX2 Chipset.\n");
-			break;
-default:
-			p += sprintf(p, "\n                                PDC202XX Chipset.\n");
-			break;
-	}
-	return (char *)p;
-}
-
-static int pdc202xx_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20275:
-		case PCI_DEVICE_ID_PROMISE_20276:
-		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-			p = pdc202xx_info_new(buffer, bmide_dev);
-			break;
-		default:
-			p = pdc202xx_info(buffer, bmide_dev);
-			break;
-	}
-	return p-buffer;	/* => must be less than 4k! */
-}
-#endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */
-
-byte pdc202xx_proc = 0;
-
-const char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
 extern char *ide_xfer_verbose (byte xfer_rate);
 
 /* A Register */
@@ -322,7 +112,6 @@
 
 	switch(registers) {
 		case REG_A:
-			bit2 = 0;
 			printk("A Register ");
 			if (value & 0x80) printk("SYNC_IN ");
 			if (value & 0x40) printk("ERRDY_EN ");
@@ -335,7 +124,6 @@
 			printk("PIO(A) = %d ", bit2);
 			break;
 		case REG_B:
-			bit1 = 0;bit2 = 0;
 			printk("B Register ");
 			if (value & 0x80) { printk("MB2 ");bit1 |= 0x80; }
 			if (value & 0x40) { printk("MB1 ");bit1 |= 0x40; }
@@ -349,7 +137,6 @@
 			printk("PIO(B) = %d ", bit2);
 			break;
 		case REG_C:
-			bit2 = 0;
 			printk("C Register ");
 			if (value & 0x80) printk("DMARQp ");
 			if (value & 0x40) printk("IORDYp ");
@@ -379,23 +166,22 @@
 
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 
-static int check_in_drive_lists(struct ata_device *drive, const char **list)
-{
+int check_in_drive_lists(struct ata_device *drive) {
+	const char *pdc_quirk_drives[] = {
+		"QUANTUM FIREBALLlct08 08",
+		"QUANTUM FIREBALLP KA6.4",
+		"QUANTUM FIREBALLP LM20.4",
+		"QUANTUM FIREBALLP KX20.5",
+		"QUANTUM FIREBALLP KX27.3",
+		"QUANTUM FIREBALLP LM20.5",
+		NULL
+	};
+     const char**list = pdc_quirk_drives;
 	struct hd_driveid *id = drive->id;
 
-	if (pdc_quirk_drives == list) {
-		while (*list) {
-			if (strstr(id->model, *list++)) {
-				return 2;
-			}
-		}
-	} else {
-		while (*list) {
-			if (!strcmp(*list++,id->model)) {
-				return 1;
-			}
-		}
-	}
+	while (*list)
+		if (strstr(id->model, *list++))
+			return 2;
 	return 0;
 }
 
@@ -523,6 +309,15 @@
 	return err;
 }
 
+#define set_2regs(a, b) \
+        OUT_BYTE((a + adj), indexreg); \
+	OUT_BYTE(b, datareg);
+
+#define set_reg_and_wait(value, reg, delay) \
+	OUT_BYTE(value, reg); \
+        mdelay(delay);
+
+
 static int pdc202xx_new_tune_chipset(struct ata_device *drive, byte speed)
 {
 	struct ata_channel *hwif = drive->channel;
@@ -549,121 +344,79 @@
 		case XFER_UDMA_7:
 			speed = XFER_UDMA_6;
 		case XFER_UDMA_6:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x01, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcb, datareg);
+			set_2regs(0x10, 0x1a);
+			set_2regs(0x11, 0x01);
+			set_2regs(0x12, 0xcb);
 			break;
 		case XFER_UDMA_5:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x02, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcb, datareg);
+			set_2regs(0x10, 0x1a);
+			set_2regs(0x11, 0x02);
+			set_2regs(0x12, 0xcb);
 			break;
 		case XFER_UDMA_4:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x03, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcd, datareg);
+			set_2regs(0x10, 0x1a);
+			set_2regs(0x11, 0x03);
+			set_2regs(0x12, 0xcd);
 			break;
 		case XFER_UDMA_3:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x05, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcd, datareg);
+			set_2regs(0x10, 0x1a);
+			set_2regs(0x11, 0x05);
+			set_2regs(0x12, 0xcd);
 			break;
 		case XFER_UDMA_2:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x2a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x07, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcd, datareg);
+			set_2regs(0x10, 0x2a);
+			set_2regs(0x11, 0x07);
+			set_2regs(0x12, 0xcd);
 			break;
 		case XFER_UDMA_1:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x3a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x0a, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xd0, datareg);
+			set_2regs(0x10, 0x3a);
+			set_2regs(0x11, 0x0a);
+			set_2regs(0x12, 0xd0);
 			break;
 		case XFER_UDMA_0:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x4a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x0f, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xd5, datareg);
+			set_2regs(0x10, 0x4a);
+			set_2regs(0x11, 0x0f);
+			set_2regs(0x12, 0xd5);
 			break;
 		case XFER_MW_DMA_2:
-			OUT_BYTE((0x0e + adj), indexreg);
-			OUT_BYTE(0x69, datareg);
-			OUT_BYTE((0x0f + adj), indexreg);
-			OUT_BYTE(0x25, datareg);
+			set_2regs(0x0e, 0x69);
+			set_2regs(0x0f, 0x25);
 			break;
 		case XFER_MW_DMA_1:
-			OUT_BYTE((0x0e + adj), indexreg);
-			OUT_BYTE(0x6b, datareg);
-			OUT_BYTE((0x0f+ adj), indexreg);
-			OUT_BYTE(0x27, datareg);
+			set_2regs(0x0e, 0x6b);
+			set_2regs(0x0f, 0x27);
 			break;
 		case XFER_MW_DMA_0:
-			OUT_BYTE((0x0e + adj), indexreg);
-			OUT_BYTE(0xdf, datareg);
-			OUT_BYTE((0x0f + adj), indexreg);
-			OUT_BYTE(0x5f, datareg);
+			set_2regs(0x0e, 0xdf);
+			set_2regs(0x0f, 0x5f);
 			break;
 #else
 	switch (speed) {
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 		case XFER_PIO_4:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x23, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x09, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0x25, datareg);
+			set_2regs(0x0c, 0x23);
+			set_2regs(0x0d, 0x09);
+			set_2regs(0x13, 0x25);
 			break;
 		case XFER_PIO_3:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x27, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x0d, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0x35, datareg);
+			set_2regs(0x0c, 0x27);
+			set_2regs(0x0d, 0x0d);
+			set_2regs(0x13, 0x35);
 			break;
 		case XFER_PIO_2:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x23, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x26, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0x64, datareg);
+			set_2regs(0x0c, 0x23);
+			set_2regs(0x0d, 0x26);
+			set_2regs(0x13, 0x64);
 			break;
 		case XFER_PIO_1:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x46, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x29, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0xa4, datareg);
+			set_2regs(0x0c, 0x46);
+			set_2regs(0x0d, 0x29);
+			set_2regs(0x13, 0xa4);
 			break;
 		case XFER_PIO_0:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0xfb, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x2b, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0xac, datareg);
+			set_2regs(0x0c, 0xfb);
+			set_2regs(0x0d, 0x2b);
+			set_2regs(0x13, 0xac);
 			break;
 		default:
 			;
@@ -684,21 +437,15 @@
  * 180, 120,  90,  90,  90,  60,  30
  *  11,   5,   4,   3,   2,   1,   0
  */
-static int config_chipset_for_pio(struct ata_device *drive, byte pio)
+static void config_chipset_for_pio(struct ata_device *drive, byte pio)
 {
-	byte speed = 0x00;
+	byte speed;
 
 	if (pio == 255)
 		speed = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
-	else
-		speed = XFER_PIO_0 + min_t(byte, pio, 4);
+	else	speed = XFER_PIO_0 + min_t(byte, pio, 4);
 
-	return ((int) pdc202xx_tune_chipset(drive, speed));
-}
-
-static void pdc202xx_tune_drive(struct ata_device *drive, byte pio)
-{
-	(void) config_chipset_for_pio(drive, pio);
+	pdc202xx_tune_chipset(drive, speed);
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -833,8 +580,7 @@
 		if (drive->type != ATA_DISK)
 			return 0;
 		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
-			OUT_BYTE((iordy + adj), indexreg);
-			OUT_BYTE((IN_BYTE(datareg)|0x03), datareg);
+			set_2regs(iordy, (IN_BYTE(datareg)|0x03));
 		}
 		goto jumpbit_is_set;
 	}
@@ -971,7 +717,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-		(void) config_chipset_for_pio(drive, 5);
+		config_chipset_for_pio(drive, 5);
 	}
 
 	udma_enable(drive, on, verbose);
@@ -979,11 +725,6 @@
 	return 0;
 }
 
-int pdc202xx_quirkproc(struct ata_device *drive)
-{
-	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
-}
-
 static int pdc202xx_udma_start(struct ata_device *drive, struct request *rq)
 {
 	u8 clock		= 0;
@@ -1119,15 +860,7 @@
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
-static void pdc202xx_udma_timeout(struct ata_device *drive)
-{
-	if (!drive->channel->resetproc)
-		return;
-	/* Assume naively that resetting the drive may help. */
-	drive->channel->resetproc(drive);
-}
-
-static void pdc202xx_udma_irq_lost(struct ata_device *drive)
+static void pdc202xx_bug (struct ata_device *drive)
 {
 	if (!drive->channel->resetproc)
 		return;
@@ -1143,10 +876,8 @@
 
 void pdc202xx_new_reset(struct ata_device *drive)
 {
-	OUT_BYTE(0x04,IDE_CONTROL_REG);
-	mdelay(1000);
-	OUT_BYTE(0x00,IDE_CONTROL_REG);
-	mdelay(1000);
+	set_reg_and_wait(0x04,IDE_CONTROL_REG, 1000);
+	set_reg_and_wait(0x00,IDE_CONTROL_REG, 1000);
 	printk("PDC202XX: %s channel reset.\n",
 		drive->channel->unit ? "Secondary" : "Primary");
 }
@@ -1156,40 +887,12 @@
 	unsigned long high_16	= pci_resource_start(drive->channel->pci_dev, 4);
 	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
 
-	OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-	mdelay(100);
-	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-	mdelay(2000);		/* 2 seconds ?! */
+	set_reg_and_wait(udma_speed_flag | 0x10, high_16 + 0x001f, 100);
+	set_reg_and_wait(udma_speed_flag & ~0x10, high_16 + 0x001f, 2000);		/* 2 seconds ?! */
 	printk("PDC202XX: %s channel reset.\n",
 		drive->channel->unit ? "Secondary" : "Primary");
 }
 
-/*
- * Since SUN Cobalt is attempting to do this operation, I should disclose
- * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
- * HOTSWAP ATA Infrastructure.
- */
-static int pdc202xx_tristate(struct ata_device * drive, int state)
-{
-#if 0
-	struct ata_channel *hwif = drive->channel;
-	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
-	byte sc1f		= inb(high_16 + 0x001f);
-
-	if (!hwif)
-		return -EINVAL;
-
-//	hwif->bus_state = state;
-
-	if (state) {
-		outb(sc1f | 0x08, high_16 + 0x001f);
-	} else {
-		outb(sc1f & ~0x08, high_16 + 0x001f);
-	}
-#endif
-	return 0;
-}
-
 static unsigned int __init pdc202xx_init_chipset(struct pci_dev *dev)
 {
 	unsigned long high_16	= pci_resource_start(dev, 4);
@@ -1213,10 +916,8 @@
 			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
-			OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-			mdelay(100);
-			OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-			mdelay(2000);   /* 2 seconds ?! */
+			set_reg_and_wait(udma_speed_flag | 0x10, high_16 + 0x001f, 100);
+			set_reg_and_wait(udma_speed_flag & ~0x10, high_16 + 0x001f, 2000);   /* 2 seconds ?! */
 			break;
 		case PCI_DEVICE_ID_PROMISE_20262:
 			/*
@@ -1229,10 +930,8 @@
 			 * reset leaves the timing registers intact,
 			 * but resets the drives.
 			 */
-			OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-			mdelay(100);
-			OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-			mdelay(2000);	/* 2 seconds ?! */
+			set_reg_and_wait(udma_speed_flag | 0x10, high_16 + 0x001f, 100);
+			set_reg_and_wait(udma_speed_flag & ~0x10, high_16 + 0x001f, 2000);	/* 2 seconds ?! */
 		default:
 			if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
 				byte irq = 0, irq2 = 0;
@@ -1265,31 +964,7 @@
 	}
 #endif /* CONFIG_PDC202XX_BURST */
 
-#ifdef CONFIG_PDC202XX_MASTER
-	if (!(primary_mode & 1)) {
-		printk("%s: FORCING PRIMARY MODE BIT 0x%02x -> 0x%02x ",
-			dev->name, primary_mode, (primary_mode|1));
-		OUT_BYTE(primary_mode|1, high_16 + 0x001a);
-		printk("%s\n", (IN_BYTE(high_16 + 0x001a) & 1) ? "MASTER" : "PCI");
-	}
-
-	if (!(secondary_mode & 1)) {
-		printk("%s: FORCING SECONDARY MODE BIT 0x%02x -> 0x%02x ",
-			dev->name, secondary_mode, (secondary_mode|1));
-		OUT_BYTE(secondary_mode|1, high_16 + 0x001b);
-		printk("%s\n", (IN_BYTE(high_16 + 0x001b) & 1) ? "MASTER" : "PCI");
-	}
-#endif
-
 fttk_tx_series:
-
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!pdc202xx_proc) {
-		pdc202xx_proc = 1;
-		bmide_dev = dev;
-		pdc202xx_display_info = &pdc202xx_get_info;
-	}
-#endif
 	return dev->irq;
 }
 
@@ -1314,8 +989,8 @@
 
 static void __init ide_init_pdc202xx(struct ata_channel *hwif)
 {
-	hwif->tuneproc  = &pdc202xx_tune_drive;
-	hwif->quirkproc = &pdc202xx_quirkproc;
+	hwif->tuneproc  = &config_chipset_for_pio;
+	hwif->quirkproc = &check_in_drive_lists;
 
         switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
@@ -1329,7 +1004,6 @@
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
 		case PCI_DEVICE_ID_PROMISE_20262:
-			hwif->busproc   = &pdc202xx_tristate;
 			hwif->resetproc	= &pdc202xx_reset;
 		case PCI_DEVICE_ID_PROMISE_20246:
 			hwif->speedproc = &pdc202xx_tune_chipset;
@@ -1337,19 +1011,13 @@
 			break;
 	}
 
-#undef CONFIG_PDC202XX_32_UNMASK
-#ifdef CONFIG_PDC202XX_32_UNMASK
-	hwif->io_32bit = 1;
-	hwif->unmask = 1;
-#endif
-
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->udma_start = pdc202xx_udma_start;
 		hwif->udma_stop = pdc202xx_udma_stop;
 		hwif->udma_irq_status = pdc202xx_udma_irq_status;
-		hwif->udma_irq_lost = pdc202xx_udma_irq_lost;
-		hwif->udma_timeout = pdc202xx_udma_timeout;
+		hwif->udma_irq_lost = pdc202xx_bug;
+		hwif->udma_timeout = pdc202xx_bug;
 		hwif->XXX_udma = pdc202xx_dmaproc;
 		hwif->highmem = 1;
 		if (!noautodma)
@@ -1509,7 +1177,7 @@
 
 int __init init_pdc202xx(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(chipsets); ++i) {
 		ata_register_chipset(&chipsets[i]);
diff -urN linux-2.5.15/drivers/ide/quirks.c linux/drivers/ide/quirks.c
--- linux-2.5.15/drivers/ide/quirks.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/ide/quirks.c	2002-05-15 13:26:34.000000000 +0200
@@ -0,0 +1,231 @@
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
+ *  Copyright (C) 2002 Marcin Dalecki <martin@dalecki.de>
+ *
+ *  Copyright (c) 1999-2000  Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (c) 1995-1998  Mark Lord
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/*
+ *  Just the black and white list handling for BM-DMA operation.
+ */
+
+#include <linux/config.h>
+#define __NO_VERSION__
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
+
+struct drive_list_entry {
+	char * id_model;
+	char * id_firmware;
+};
+
+struct drive_list_entry drive_whitelist[] = {
+	{ "Micropolis 2112A", NULL },
+	{ "CONNER CTMA 4000", NULL },
+	{ "CONNER CTT8000-A", NULL },
+	{ "ST34342A", NULL },
+	{ NULL, NULL }
+};
+
+struct drive_list_entry drive_blacklist[] = {
+
+	{ "WDC AC11000H", NULL },
+	{ "WDC AC22100H", NULL },
+	{ "WDC AC32500H", NULL },
+	{ "WDC AC33100H", NULL },
+	{ "WDC AC31600H", NULL },
+	{ "WDC AC32100H", "24.09P07" },
+	{ "WDC AC23200L", "21.10N21" },
+	{ "Compaq CRD-8241B", NULL },
+	{ "CRD-8400B", NULL },
+	{ "CRD-8480B", NULL },
+	{ "CRD-8480C", NULL },
+	{ "CRD-8482B", NULL },
+	{ "CRD-84", NULL },
+	{ "SanDisk SDP3B", NULL },
+	{ "SanDisk SDP3B-64", NULL },
+	{ "SANYO CD-ROM CRD", NULL },
+	{ "HITACHI CDR-8", NULL },
+	{ "HITACHI CDR-8335", NULL },
+	{ "HITACHI CDR-8435", NULL },
+	{ "Toshiba CD-ROM XM-6202B", NULL },
+	{ "CD-532E-A", NULL },
+	{ "E-IDE CD-ROM CR-840", NULL },
+	{ "CD-ROM Drive/F5A", NULL },
+	{ "RICOH CD-R/RW MP7083A", NULL },
+	{ "WPI CDD-820", NULL },
+	{ "SAMSUNG CD-ROM SC-148C", NULL },
+	{ "SAMSUNG CD-ROM SC-148F", NULL },
+	{ "SAMSUNG CD-ROM SC", NULL },
+	{ "SanDisk SDP3B-64", NULL },
+	{ "SAMSUNG CD-ROM SN-124", NULL },
+	{ "PLEXTOR CD-R PX-W8432T", NULL },
+	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM", NULL },
+	{ "_NEC DV5800A", NULL },
+	{ NULL,	NULL }
+
+};
+
+static int in_drive_list(struct hd_driveid *id, struct drive_list_entry * drive_table)
+{
+	for ( ; drive_table->id_model ; drive_table++)
+		if ((!strcmp(drive_table->id_model, id->model)) &&
+		    ((drive_table->id_firmware && !strstr(drive_table->id_firmware, id->fw_rev)) ||
+		     (!drive_table->id_firmware)))
+			return 1;
+	return 0;
+}
+
+#else
+
+/*
+ * good_dma_drives() lists the model names (from "hdparm -i")
+ * of drives which do not support mode2 DMA but which are
+ * known to work fine with this interface under Linux.
+ */
+const char *good_dma_drives[] = {"Micropolis 2112A",
+				 "CONNER CTMA 4000",
+				 "CONNER CTT8000-A",
+				 "ST34342A",	/* for Sun Ultra */
+				 NULL};
+
+/*
+ * bad_dma_drives() lists the model names (from "hdparm -i")
+ * of drives which supposedly support (U)DMA but which are
+ * known to corrupt data with this interface under Linux.
+ *
+ * This is an empirical list. Its generated from bug reports. That means
+ * while it reflects actual problem distributions it doesn't answer whether
+ * the drive or the controller, or cabling, or software, or some combination
+ * thereof is the fault. If you don't happen to agree with the kernel's
+ * opinion of your drive - use hdparm to turn DMA on.
+ */
+const char *bad_dma_drives[] = {"WDC AC11000H",
+				"WDC AC22100H",
+				"WDC AC32100H",
+				"WDC AC32500H",
+				"WDC AC33100H",
+				"WDC AC31600H",
+				NULL};
+
+#endif
+
+/*
+ *  For both Blacklisted and Whitelisted drives.
+ *  This is setup to be called as an extern for future support
+ *  to other special driver code.
+ */
+int check_drive_lists(struct ata_device *drive, int good_bad)
+{
+	struct hd_driveid *id = drive->id;
+
+#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
+	if (good_bad) {
+		return in_drive_list(id, drive_whitelist);
+	} else {
+		int blacklist = in_drive_list(id, drive_blacklist);
+		if (blacklist)
+			printk("%s: Disabling (U)DMA for %s\n", drive->name, id->model);
+		return(blacklist);
+	}
+#else
+	const char **list;
+
+	if (good_bad) {
+		/* Consult the list of known "good" drives */
+		list = good_dma_drives;
+		while (*list) {
+			if (!strcmp(*list++,id->model))
+				return 1;
+		}
+	} else {
+		/* Consult the list of known "bad" drives */
+		list = bad_dma_drives;
+		while (*list) {
+			if (!strcmp(*list++,id->model)) {
+				printk("%s: Disabling (U)DMA for %s\n",
+					drive->name, id->model);
+				return 1;
+			}
+		}
+	}
+#endif
+	return 0;
+}
+
+void udma_print(struct ata_device *drive)
+{
+#ifdef CONFIG_ARCH_ACORN
+	printk(", DMA");
+#else
+	struct hd_driveid *id = drive->id;
+	char *str = NULL;
+
+	if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
+	    (id->dma_ultra & (id->dma_ultra >> 14) & 3)) {
+		if ((id->dma_ultra >> 15) & 1)
+			str = ", UDMA(mode 7)";	/* UDMA BIOS-enabled! */
+		else
+			str = ", UDMA(133)";	/* UDMA BIOS-enabled! */
+	} else if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
+		  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
+		if ((id->dma_ultra >> 13) & 1) {
+			str = ", UDMA(100)";	/* UDMA BIOS-enabled! */
+		} else if ((id->dma_ultra >> 12) & 1) {
+			str = ", UDMA(66)";	/* UDMA BIOS-enabled! */
+		} else {
+			str = ", UDMA(44)";	/* UDMA BIOS-enabled! */
+		}
+	} else if ((id->field_valid & 4) &&
+		   (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
+		if ((id->dma_ultra >> 10) & 1) {
+			str = ", UDMA(33)";	/* UDMA BIOS-enabled! */
+		} else if ((id->dma_ultra >> 9) & 1) {
+			str = ", UDMA(25)";	/* UDMA BIOS-enabled! */
+		} else {
+			str = ", UDMA(16)";	/* UDMA BIOS-enabled! */
+		}
+	} else if (id->field_valid & 4)
+		str = ", (U)DMA";	/* Can be BIOS-enabled! */
+	else
+		str = ", DMA";
+
+	printk(str);
+#endif
+}
+
+/*
+ * Drive back/white list handling for UDMA capability:
+ */
+
+int udma_black_list(struct ata_device *drive)
+{
+	return check_drive_lists(drive, 0);
+}
+
+int udma_white_list(struct ata_device *drive)
+{
+	return check_drive_lists(drive, 1);
+}
+
+EXPORT_SYMBOL(udma_print);
+EXPORT_SYMBOL(udma_black_list);
+EXPORT_SYMBOL(udma_white_list);
diff -urN linux-2.5.15/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.15/include/linux/ide.h	2002-05-15 14:55:12.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-15 14:14:15.000000000 +0200
@@ -820,22 +820,55 @@
 
 void __init ide_scan_pcibus(int scan_direction);
 #endif
+
+static inline void udma_enable(struct ata_device *drive, int on, int verbose)
+{
+	drive->channel->udma_enable(drive, on, verbose);
+}
+
+static inline int udma_start(struct ata_device *drive, struct request *rq)
+{
+	return drive->channel->udma_start(drive, rq);
+}
+
+static inline int udma_stop(struct ata_device *drive)
+{
+	return drive->channel->udma_stop(drive);
+}
+
+static inline int udma_read(struct ata_device *drive, struct request *rq)
+{
+	return drive->channel->udma_read(drive, rq);
+}
+
+static inline int udma_write(struct ata_device *drive, struct request *rq)
+{
+	return drive->channel->udma_write(drive, rq);
+}
+
+static inline int udma_irq_status(struct ata_device *drive)
+{
+	return drive->channel->udma_irq_status(drive);
+}
+
+static inline void udma_timeout(struct ata_device *drive)
+{
+	return drive->channel->udma_timeout(drive);
+}
+
+static inline void udma_irq_lost(struct ata_device *drive)
+{
+	return drive->channel->udma_irq_lost(drive);
+}
+
 #ifdef CONFIG_BLK_DEV_IDEDMA
 
 extern int udma_new_table(struct ata_channel *, struct request *);
 extern void udma_destroy_table(struct ata_channel *);
 extern void udma_print(struct ata_device *);
 
-extern void udma_enable(struct ata_device *, int, int);
 extern int udma_black_list(struct ata_device *);
 extern int udma_white_list(struct ata_device *);
-extern void udma_timeout(struct ata_device *);
-extern void udma_irq_lost(struct ata_device *);
-extern int udma_start(struct ata_device *, struct request *rq);
-extern int udma_stop(struct ata_device *);
-extern int udma_read(struct ata_device *, struct request *rq);
-extern int udma_write(struct ata_device *, struct request *rq);
-extern int udma_irq_status(struct ata_device *);
 
 extern int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq);
 

--------------020500080700050704030602--

