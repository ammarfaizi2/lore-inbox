Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311670AbSDPKY2>; Tue, 16 Apr 2002 06:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSDPKY1>; Tue, 16 Apr 2002 06:24:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:51208 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311670AbSDPKYV>; Tue, 16 Apr 2002 06:24:21 -0400
Message-ID: <3CBBED42.50003@evision-ventures.com>
Date: Tue, 16 Apr 2002 11:22:10 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8 IDE 37
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000601010309070302080701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000601010309070302080701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue Apr 16 07:10:23 CEST 2002 ide-clean-37

- Don't abuse the sense field for passing failed packet_commands in struct
   packet_command use a new field instead.

- Apply minor bits forwarded by Dave Jones to me.

- Fix ide_raw_taskfile() to flag the ar used there to be no subject of free_req
   list management. This solvs the "hang after /proc/ide read" problem, which
   was in fact a memory corruption problem.

--------------000601010309070302080701
Content-Type: text/plain;
 name="ide-clean-37.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-37.diff"

diff -urN linux-2.5.8/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.8/drivers/ide/Config.help	Tue Apr 16 11:58:06 2002
+++ linux/drivers/ide/Config.help	Tue Apr 16 09:24:10 2002
@@ -160,7 +160,7 @@
   you can then use this emulation together with an appropriate SCSI
   device driver. In order to do this, say Y here and to "SCSI support"
   and "SCSI generic support", below. You must then provide the kernel
-  command line "hdx=scsi" (try "man bootparam" or see the
+  command line "hdx=ide-scsi" (try "man bootparam" or see the
   documentation of your boot loader (lilo or loadlin) about how to
   pass options to the kernel at boot time) for devices if you want the
   native EIDE sub-drivers to skip over the native support, so that
@@ -543,13 +543,13 @@
 
 CONFIG_BLK_DEV_PDC4030
   This driver provides support for the secondary IDE interface and
-  cache of Promise IDE chipsets, e.g. DC4030 and DC5030.  This driver
-  is known to incur timeouts/retries during heavy I/O to drives
-  attached to the secondary interface.  CD-ROM and TAPE devices are
-  not supported yet.  This driver is enabled at runtime using the
-  "ide0=dc4030" kernel boot parameter.  See the
-  <file:Documentation/ide.txt> and <file:drivers/ide/pdc4030.c> files
-  for more info.
+  cache of the original Promise IDE chipsets, e.g. DC4030 and DC5030.
+  It is nothing to do with the later range of Promise UDMA chipsets -
+  see the PDC_202XX support for these. CD-ROM and TAPE devices are not
+  supported (and probably never will be since I don't think the cards
+  support them). This driver is enabled at runtime using the "ide0=dc4030"
+  or "ide1=dc4030" kernel boot parameter. See the
+  <file:drivers/ide/pdc4030.c> file for more info.
 
 CONFIG_BLK_DEV_QD65XX
   This driver is enabled at runtime using the "ide0=qd65xx" kernel
@@ -629,6 +629,11 @@
   devices (hard disks, CD-ROM drives, etc.) that are connected to the
   builtin IDE interface.
 
+CONFIG_BLK_DEV_Q40IDE
+  Enable the on-board IDE controller in the Q40/Q60.  This should
+  normally be on; disable it only if you are running a custom hard
+  drive subsystem through an expansion card.
+
 CONFIG_BLK_DEV_IDE_ICSIDE
   On Acorn systems, say Y here if you wish to use the ICS IDE
   interface card.  This is not required for ICS partition support.
diff -urN linux-2.5.8/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.8/drivers/ide/ide-cd.c	Tue Apr 16 11:58:09 2002
+++ linux/drivers/ide/ide-cd.c	Tue Apr 16 11:42:44 2002
@@ -337,7 +337,9 @@
 	int log = 0;
 	/* FIXME --mdcki */
 	struct packet_command *pc = (struct packet_command *) rq->special;
-	struct packet_command *failed_command = (struct packet_command *) pc->sense;
+	struct packet_command *failed_command = pc->failed_command;
+
+	/* Decode sense data from drive */
 	struct request_sense *sense = (struct request_sense *) (pc->buffer - rq->cmd[4]);
 	unsigned char fail_cmd;
 
@@ -526,10 +528,10 @@
 	if (sense == NULL)
 		sense = &info->sense_data;
 
-	memset(pc, 0, sizeof(struct packet_command));
+	memset(pc, 0, sizeof(*pc));
 	pc->buffer = (void *) sense;
 	pc->buflen = 18;
-	pc->sense = (struct request_sense *) failed_command;
+	pc->failed_command = failed_command;
 
 	/* stuff the sense request in front of our current request */
 	rq = &info->request_sense_request;
@@ -598,6 +600,7 @@
 		pc->stat = 1;
 		cdrom_end_request(drive, 1);
 		*startstop = ide_error (drive, "request sense failure", stat);
+
 		return 1;
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
 		/* All other functions, except for READ. */
@@ -635,6 +638,10 @@
 		pc->stat = 1;
 		cdrom_end_request(drive, 1);
 
+		/* FIXME: this is the only place where pc->sense get's used.
+		 * Think hard about how to get rid of it...
+		 */
+
 		if ((stat & ERR_STAT) != 0)
 			cdrom_queue_request_sense(drive, wait, pc->sense, pc);
 	} else if (rq->flags & REQ_CMD) {
@@ -728,27 +735,26 @@
 		return startstop;
 
 	if (info->dma) {
-		if (info->cmd == READ) {
+		if (info->cmd == READ)
 			info->dma = !drive->channel->dmaproc(ide_dma_read, drive);
-		} else if (info->cmd == WRITE) {
+		else if (info->cmd == WRITE)
 			info->dma = !drive->channel->dmaproc(ide_dma_write, drive);
-		} else {
+		else
 			printk("ide-cd: DMA set, but not allowed\n");
-		}
 	}
 
 	/* Set up the controller registers. */
-	OUT_BYTE (info->dma, IDE_FEATURE_REG);
-	OUT_BYTE (0, IDE_NSECTOR_REG);
-	OUT_BYTE (0, IDE_SECTOR_REG);
+	OUT_BYTE(info->dma, IDE_FEATURE_REG);
+	OUT_BYTE(0, IDE_NSECTOR_REG);
+	OUT_BYTE(0, IDE_SECTOR_REG);
 
-	OUT_BYTE (xferlen & 0xff, IDE_LCYL_REG);
-	OUT_BYTE (xferlen >> 8  , IDE_HCYL_REG);
+	OUT_BYTE(xferlen & 0xff, IDE_LCYL_REG);
+	OUT_BYTE(xferlen >> 8  , IDE_HCYL_REG);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE (drive->ctl, IDE_CONTROL_REG);
 
 	if (info->dma)
-		(void) drive->channel->dmaproc(ide_dma_begin, drive);
+		drive->channel->dmaproc(ide_dma_begin, drive);
 
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		BUG_ON(HWGROUP(drive)->handler);
@@ -1386,17 +1392,13 @@
 }
 
 static
-int cdrom_queue_packet_command(ide_drive_t *drive, unsigned char *cmd, struct packet_command *pc)
+int cdrom_queue_packet_command(ide_drive_t *drive, unsigned char *cmd,
+		struct request_sense *sense, struct packet_command *pc)
 {
-	struct request_sense sense;
 	struct request rq;
 	int retries = 10;
 
 	memcpy(rq.cmd, cmd, CDROM_PACKET_SIZE);
-
-	if (pc->sense == NULL)
-		pc->sense = &sense;
-
 	/* Start of retry loop. */
 	do {
 		ide_init_drive_cmd(&rq);
@@ -1408,18 +1410,25 @@
 		if (ide_do_drive_cmd(drive, &rq, ide_wait)) {
 			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
 				drive->name, rq.buffer[0], rq.buffer[1]);
+
 			/* FIXME: we should probably abort/retry or something */
+			if (sense) {
+
+				/* Decode the error here at least for error
+				 * reporting to upper layers.!
+				 */
+
+			}
 		}
 		if (pc->stat != 0) {
 			/* The request failed.  Retry if it was due to a unit
 			   attention status
 			   (usually means media was changed). */
-			struct request_sense *reqbuf = pc->sense;
 
-			if (reqbuf->sense_key == UNIT_ATTENTION)
+			if (sense && sense->sense_key == UNIT_ATTENTION)
 				cdrom_saw_media_change (drive);
-			else if (reqbuf->sense_key == NOT_READY &&
-				 reqbuf->asc == 4 && reqbuf->ascq != 4) {
+			else if (sense && sense->sense_key == NOT_READY &&
+				 sense->asc == 4 && sense->ascq != 4) {
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
@@ -1753,7 +1762,7 @@
         cmd[7] = cdi->sanyo_slot % 3;
 #endif
 
-	return cdrom_queue_packet_command(drive, cmd, &pc);
+	return cdrom_queue_packet_command(drive, cmd, sense, &pc);
 }
 
 
@@ -1774,7 +1783,7 @@
 		pc.sense = sense;
 		cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
 		cmd[4] = lockflag ? 1 : 0;
-		stat = cdrom_queue_packet_command(drive, cmd, &pc);
+		stat = cdrom_queue_packet_command(drive, cmd, sense, &pc);
 	}
 
 	/* If we got an illegal field error, the drive
@@ -1819,7 +1828,7 @@
 
 	cmd[0] = GPCMD_START_STOP_UNIT;
 	cmd[4] = 0x02 + (ejectflag != 0);
-	return cdrom_queue_packet_command(drive, cmd, &pc);
+	return cdrom_queue_packet_command(drive, cmd, sense, &pc);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
@@ -1840,7 +1849,7 @@
 	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
 	pc.buffer = (char *)&capbuf;
 	pc.buflen = sizeof(capbuf);
-	stat = cdrom_queue_packet_command(drive, cmd, &pc);
+	stat = cdrom_queue_packet_command(drive, cmd, sense, &pc);
 	if (stat == 0)
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 
@@ -1869,7 +1878,7 @@
 	cmd[8] = (buflen & 0xff);
 	cmd[9] = (format << 6);
 
-	return cdrom_queue_packet_command(drive, cmd, &pc);
+	return cdrom_queue_packet_command(drive, cmd, sense, &pc);
 }
 
 
@@ -2046,7 +2055,7 @@
 	cmd[7] = (buflen >> 8);
 	cmd[8] = (buflen & 0xff);
 
-	return cdrom_queue_packet_command(drive, cmd, &pc);
+	return cdrom_queue_packet_command(drive, cmd, sense, &pc);
 }
 
 /* ATAPI cdrom drives are free to select the speed you request or any slower
@@ -2078,7 +2087,7 @@
 		cmd[5] = speed & 0xff;
        }
 
-	return cdrom_queue_packet_command(drive, cmd, &pc);
+	return cdrom_queue_packet_command(drive, cmd, sense, &pc);
 }
 
 static int cdrom_play_audio(ide_drive_t *drive, int lba_start, int lba_end)
@@ -2094,7 +2103,7 @@
 	lba_to_msf(lba_start, &cmd[3], &cmd[4], &cmd[5]);
 	lba_to_msf(lba_end-1, &cmd[6], &cmd[7], &cmd[8]);
 
-	return cdrom_queue_packet_command(drive, cmd, &pc);
+	return cdrom_queue_packet_command(drive, cmd, &sense, &pc);
 }
 
 static int cdrom_get_toc_entry(ide_drive_t *drive, int track,
@@ -2143,7 +2152,7 @@
 	pc.quiet = cgc->quiet;
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
-	cgc->stat = cdrom_queue_packet_command(drive, cgc->cmd, &pc);
+	cgc->stat = cdrom_queue_packet_command(drive, cgc->cmd, cgc->sense, &pc);
 	if (!cgc->stat)
 		cgc->buflen -= pc.buflen;
 
diff -urN linux-2.5.8/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- linux-2.5.8/drivers/ide/ide-cd.h	Tue Apr 16 11:58:02 2002
+++ linux/drivers/ide/ide-cd.h	Tue Apr 16 11:36:58 2002
@@ -104,6 +104,15 @@
 	int quiet;
 	int timeout;
 	struct request_sense *sense;
+
+	/* This is currently used to pass failed commands through the request
+	 * queue.  Is this for asynchronos error reporting?
+	 *
+	 * Can we always be sure that this didn't valish from stack beneath us
+	 * - we can't!
+	 */
+
+	struct packet_command *failed_command;
 };
 
 /* Structure of a MSF cdrom address. */
diff -urN linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8/drivers/ide/ide-dma.c	Tue Apr 16 11:58:06 2002
+++ linux/drivers/ide/ide-dma.c	Tue Apr 16 06:35:57 2002
@@ -372,10 +372,10 @@
 }
 
 /* Teardown mappings after DMA has completed.  */
-void ide_destroy_dmatable (ide_drive_t *drive)
+void ide_destroy_dmatable(struct ata_device *d)
 {
-	struct pci_dev *dev = drive->channel->pci_dev;
-	struct ata_request *ar = IDE_CUR_AR(drive);
+	struct pci_dev *dev = d->channel->pci_dev;
+	struct ata_request *ar = IDE_CUR_AR(d);
 
 	pci_unmap_sg(dev, ar->ar_sg_table, ar->ar_sg_nents, ar->ar_sg_ddir);
 }
diff -urN linux-2.5.8/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.8/drivers/ide/ide-floppy.c	Tue Apr 16 11:58:09 2002
+++ linux/drivers/ide/ide-floppy.c	Tue Apr 16 09:24:10 2002
@@ -1,8 +1,8 @@
 /*
- * linux/drivers/ide/ide-floppy.c	Version 0.97.sv	Jan 14 2001
+ * linux/drivers/ide/ide-floppy.c	Version 0.99	Feb 24 2002
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
- * Copyright (C) 2000 - 2001 Paul Bristow <paul@paulbristow.net>
+ * Copyright (C) 2000 - 2002 Paul Bristow <paul@paulbristow.net>
  */
 
 /*
@@ -13,7 +13,7 @@
  *
  * This driver supports the following IDE floppy drives:
  *
- * LS-120 SuperDisk
+ * LS-120/240 SuperDisk
  * Iomega Zip 100/250
  * Iomega PC Card Clik!/PocketZip
  *
@@ -76,9 +76,11 @@
  *                        bit was being deasserted by my IOMEGA ATAPI ZIP 100
  *                        drive before the drive was actually ready.
  * Ver 0.98a Oct 29 01   Expose delay value so we can play.
+ * Ver 0.99  Feb 24 02   Remove duplicate code, modify clik! detection code
+ *                       to support new PocketZip drives
  */
 
-#define IDEFLOPPY_VERSION "0.98a"
+#define IDEFLOPPY_VERSION "0.99"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -1070,8 +1072,8 @@
 	 */
 	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive,
-	  &idefloppy_pc_intr,		/* service routine for packet command */
-	  floppy->ticks,			/* wait this long before "failing" */
+	  &idefloppy_pc_intr, 		/* service routine for packet command */
+	  floppy->ticks,		/* wait this long before "failing" */
 	  &idefloppy_transfer_pc2);	/* fail == transfer_pc2 */
 
 	return ide_started;
@@ -2005,7 +2007,7 @@
 	*      above fix.  It makes nasty clicking noises without
 	*      it, so please don't remove this.
 	*/
-	if (strcmp(drive->id->model, "IOMEGA Clik! 40 CZ ATAPI") == 0) {
+	if (strncmp(drive->id->model, "IOMEGA Clik!", 11) == 0) {
 		blk_queue_max_sectors(&drive->queue, 64);
 		set_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags);
 	}
diff -urN linux-2.5.8/drivers/ide/ide-m8xx.c linux/drivers/ide/ide-m8xx.c
--- linux-2.5.8/drivers/ide/ide-m8xx.c	Mon Mar 18 21:37:14 2002
+++ linux/drivers/ide/ide-m8xx.c	Tue Apr 16 09:24:10 2002
@@ -1,8 +1,14 @@
 /*
- *
- *
  *  linux/drivers/ide/ide-m8xx.c
  *
+ *  Copyright (C) 2000, 2001 Wolfgang Denk, wd@denx.de
+ *  Modified for direct IDE interface
+ *	by Thomas Lange, thomas@corelatus.com
+ *  Modified for direct IDE interface on 8xx without using the PCMCIA
+ *  controller
+ *	by Steven.Scholz@imc-berlin.de
+ *  Moved out of arch/ppc/kernel/m8xx_setup.c, other minor cleanups
+ *	by Mathew Locke <mattl@mvista.com>
  */
 
 #include <linux/config.h>
diff -urN linux-2.5.8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8/drivers/ide/ide-taskfile.c	Tue Apr 16 11:58:09 2002
+++ linux/drivers/ide/ide-taskfile.c	Tue Apr 16 11:49:42 2002
@@ -34,7 +34,7 @@
 #define DEBUG_TASKFILE	0	/* unset when fixed */
 
 #if DEBUG_TASKFILE
-#define DTF(x...) printk(x)
+#define DTF(x...) printk(##x)
 #else
 #define DTF(x...)
 #endif
@@ -901,20 +901,25 @@
 int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
-	struct ata_request ar;
+	struct ata_request star;
+
+	ata_ar_init(drive, &star);
+
+	/* Don't put this request on free_req list after usage.
+	 */
+	star.ar_flags |= ATA_AR_STATIC;
 
-	ata_ar_init(drive, &ar);
 	init_taskfile_request(&rq);
 	rq.buffer = buf;
 
-	memcpy(&ar.ar_task, args, sizeof(*args));
+	memcpy(&star.ar_task, args, sizeof(*args));
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
 		rq.current_nr_sectors = rq.nr_sectors
 			= (args->hobfile.sector_count << 8)
 			| args->taskfile.sector_count;
 
-	rq.special = &ar;
+	rq.special = &star;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Tue Apr 16 11:58:09 2002
+++ linux/drivers/ide/ide.c	Tue Apr 16 10:35:40 2002
@@ -1729,20 +1729,23 @@
 	 * handle the unexpected interrupt
 	 */
 	do {
-		if (hwif->irq == irq) {
-			stat = IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
-			if (!OK_STAT(stat, READY_STAT, BAD_STAT)) {
-				/* Try to not flood the console with msgs */
-				static unsigned long last_msgtime, count;
-				++count;
-				if (0 < (signed long)(jiffies - (last_msgtime + HZ))) {
-					last_msgtime = jiffies;
-					printk("%s%s: unexpected interrupt, status=0x%02x, count=%ld\n",
-					 hwif->name, (hwif->next == hwgroup->hwif) ? "" : "(?)", stat, count);
-				}
+		if (hwif->irq != irq)
+			continue;
+
+		stat = IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if (!OK_STAT(stat, READY_STAT, BAD_STAT)) {
+			/* Try to not flood the console with msgs */
+			static unsigned long last_msgtime;
+			static int count;
+			++count;
+			if (time_after(jiffies, last_msgtime + HZ)) {
+				last_msgtime = jiffies;
+				printk("%s%s: unexpected interrupt, status=0x%02x, count=%d\n",
+						hwif->name, (hwif->next == hwgroup->hwif) ? "" : "(?)", stat, count);
 			}
 		}
-	} while ((hwif = hwif->next) != hwgroup->hwif);
+		hwif = hwif->next;
+	} while (hwif != hwgroup->hwif);
 }
 
 /*
@@ -1764,7 +1767,8 @@
 		goto out_lock;
 
 	if ((handler = hwgroup->handler) == NULL || hwgroup->poll_timeout != 0) {
-		printk("ide: unexpected interrupt\n");
+		printk(KERN_INFO "ide: unexpected interrupt %d %d\n", hwif->unit, irq);
+
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
diff -urN linux-2.5.8/drivers/ide/it8172.c linux/drivers/ide/it8172.c
--- linux-2.5.8/drivers/ide/it8172.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/it8172.c	Tue Apr 16 09:24:10 2002
@@ -50,7 +50,7 @@
 #if defined(CONFIG_BLK_DEV_IDEDMA) && defined(CONFIG_IT8172_TUNING)
 static byte it8172_dma_2_pio (byte xfer_rate);
 static int it8172_tune_chipset (ide_drive_t *drive, byte speed);
-static int it8172_config_drive_for_dma (ide_drive_t *drive);
+static int it8172_config_chipset_for_dma (ide_drive_t *drive);
 static int it8172_dmaproc(ide_dma_action_t func, ide_drive_t *drive);
 #endif
 void __init ide_init_it8172(struct ata_channel *channel);
@@ -59,16 +59,14 @@
 static void it8172_tune_drive (ide_drive_t *drive, byte pio)
 {
     unsigned long flags;
-    u16 master_data;
-    u32 slave_data;
+    u16 drive_enables;
+    u32 drive_timing;
     int is_slave	= (&drive->channel->drives[1] == drive);
-    int master_port	= 0x40;
-    int slave_port      = 0x44;
-
-    if (pio == 255)
-	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-    else
-       pio = min_t(byte, pio, 4);
+    
+	if (pio == 255)
+		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+	else
+		pio = min_t(byte, pio, 4);
 
     pci_read_config_word(drive->channel->pci_dev, master_port, &master_data);
     pci_read_config_dword(drive->channel->pci_dev, slave_port, &slave_data);
@@ -77,19 +75,27 @@
      * FIX! The DIOR/DIOW pulse width and recovery times in port 0x44
      * are being left at the default values of 8 PCI clocks (242 nsec
      * for a 33 MHz clock). These can be safely shortened at higher
-     * PIO modes.
+     * PIO modes. The DIOR/DIOW pulse width and recovery times only
+     * apply to PIO modes, not to the DMA modes.
      */
     
+    /*
+     * Enable port 0x44. The IT8172G spec is confused; it calls
+     * this register the "Slave IDE Timing Register", but in fact,
+     * it controls timing for both master and slave drives.
+     */
+    drive_enables |= 0x4000;
+
     if (is_slave) {
-	master_data |= 0x4000;
+	drive_enables &= 0xc006;
 	if (pio > 1)
-	    /* enable PPE and IE */
-	    master_data |= 0x0060;
+	    /* enable prefetch and IORDY sample-point */
+	    drive_enables |= 0x0060;
     } else {
-	master_data &= 0xc060;
+	drive_enables &= 0xc060;
 	if (pio > 1)
-	    /* enable PPE and IE */
-	    master_data |= 0x0006;
+	    /* enable prefetch and IORDY sample-point */
+	    drive_enables |= 0x0006;
     }
 
     save_flags(flags);
@@ -163,6 +169,7 @@
     case XFER_UDMA_0:	u_speed = 0 << (drive->dn * 4); break;
     case XFER_MW_DMA_2:
     case XFER_MW_DMA_1:
+    case XFER_MW_DMA_0:
     case XFER_SW_DMA_2:	break;
     default:		return -1;
     }
@@ -185,7 +192,7 @@
     return err;
 }
 
-static int it8172_config_drive_for_dma(ide_drive_t *drive)
+static int it8172_config_chipset_for_dma(ide_drive_t *drive)
 {
     struct hd_driveid *id = drive->id;
     byte speed;
@@ -205,7 +212,7 @@
 {
     switch (func) {
     case ide_dma_check:
-	return ide_dmaproc((ide_dma_action_t)it8172_config_drive_for_dma(drive),
+	return ide_dmaproc((ide_dma_action_t)it8172_config_chipset_for_dma(drive),
 			   drive);
     default :
 	break;
diff -urN linux-2.5.8/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.8/drivers/ide/pdc4030.c	Tue Apr 16 11:58:09 2002
+++ linux/drivers/ide/pdc4030.c	Tue Apr 16 09:24:54 2002
@@ -1,7 +1,7 @@
 /*  -*- linux-c -*-
- *  linux/drivers/ide/pdc4030.c		Version 0.90  May 27, 1999
+ *  linux/drivers/ide/pdc4030.c		Version 0.92  Jan 15, 2002
  *
- *  Copyright (C) 1995-1999  Linus Torvalds & authors (see below)
+ *  Copyright (C) 1995-2002  Linus Torvalds & authors (see below)
  */
 
 /*
@@ -37,6 +37,8 @@
  *			Autodetection code added.
  *
  *  Version 0.90	Transition to BETA code. No lost/unexpected interrupts
+ *  Version 0.91	Bring in line with new bio code in 2.5.1
+ *  Version 0.92	Update for IDE driver taskfile changes
  */
 
 /*
@@ -72,8 +74,8 @@
  * effects.
  */
 
-#define DEBUG_READ
-#define DEBUG_WRITE
+#undef DEBUG_READ
+#undef DEBUG_WRITE
 
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -91,6 +93,10 @@
 
 #include "pdc4030.h"
 
+#if SUPPORT_VLB_SYNC != 1
+#error This driver will not work unless SUPPORT_VLB_SYNC is 1
+#endif
+
 /*
  * promise_selectproc() is invoked by ide.c
  * in preparation for access to the specified drive.
@@ -229,12 +235,12 @@
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 
-/* Shift the remaining interfaces down by one */
+/* Shift the remaining interfaces up by one */
 	for (i=MAX_HWIFS-1 ; i > hwif->index+1 ; i--) {
 		struct ata_channel *h = &ide_hwifs[i];
 
 #ifdef DEBUG
-		printk(KERN_DEBUG "Shifting i/f %d values to i/f %d\n",i-1,i);
+		printk(KERN_DEBUG "pdc4030: Shifting i/f %d values to i/f %d\n",i-1,i);
 #endif
 		ide_init_hwif_ports(&h->hw, (h-1)->io_ports[IDE_DATA_OFFSET], 0, NULL);
 		memcpy(h->io_ports, h->hw.io_ports, sizeof(h->io_ports));
@@ -652,8 +658,8 @@
 	   are distinguished by writing the drive number (0-3) to the
 	   Feature register.
 	   FIXME: Is promise_selectproc now redundant??
-	 */
-	taskfile.feature    = (drive->channel->unit << 1) + drive->select.b.unit;
+	*/
+	taskfile.feature	= (drive->channel->unit << 1) + drive->select.b.unit;
 	taskfile.sector_count	= rq->nr_sectors;
 	taskfile.sector_number	= block;
 	taskfile.low_cylinder	= (block>>=8);
diff -urN linux-2.5.8/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8/include/linux/ide.h	Tue Apr 16 11:58:09 2002
+++ linux/include/linux/ide.h	Tue Apr 16 11:18:42 2002
@@ -975,6 +975,7 @@
 #define ATA_AR_QUEUED	1
 #define ATA_AR_SETUP	2
 #define ATA_AR_RETURN	4
+#define ATA_AR_STATIC	8
 
 /*
  * if turn-around time is longer than this, halve queue depth
@@ -1015,7 +1016,8 @@
 
 static inline void ata_ar_put(ide_drive_t *drive, struct ata_request *ar)
 {
-	list_add(&ar->ar_queue, &drive->free_req);
+	if (!(ar->ar_flags & ATA_AR_STATIC))
+	    list_add(&ar->ar_queue, &drive->free_req);
 
 	if (ar->ar_flags & ATA_AR_QUEUED) {
 		/* clear the tag */

--------------000601010309070302080701--

