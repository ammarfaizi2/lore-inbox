Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313133AbSDJOSx>; Wed, 10 Apr 2002 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313168AbSDJOSx>; Wed, 10 Apr 2002 10:18:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48902 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313133AbSDJOS2>; Wed, 10 Apr 2002 10:18:28 -0400
Message-ID: <3CB43B2B.40407@evision-ventures.com>
Date: Wed, 10 Apr 2002 15:16:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8-pre3 IDE 31
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090807040403060105090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807040403060105090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tought this patch was done against 2.5.8-pre2 it still
applyes cleanly to 2.5.8-pre3

Tue Apr  9 20:53:16 CEST 2002 ide-clean-31

- Integrate the TCQ stuff from Jens Axboe. Deal with the conflicts, apply some
   cosmetic changes. We are still not at a stage where we could immediately
   integrate ata_request and ata_taskfile but we are no longer far away.

- Clean up the data transfer function in ide-disk to use ata_request structures
   directly.

- Kill useless leading version information in ide-disk.c

- Replace the ATA_AR_INIT macro with inline ata_ar_init() function.

- Replace IDE_CLEAR_TAG with ata_clear_tag().

- Replace IDE_SET_TAG with ata_set_tag().

- Kill georgeous ide_dmafunc_verbose().

- Fix typo in ide_enable_queued() (ide-tcq.c!)

Apparently there still problems with a TCQ enabled device and a not enabled
device on the same channel, but let's first synchronize up with Jens.

OK more then enough for the next patch stage.

--------------090807040403060105090506
Content-Type: text/plain;
 name="ide-clean-31.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-31.diff"

diff -urN linux-2.5.8-pre2/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.8-pre2/drivers/ide/Config.help	Mon Mar 18 21:37:18 2002
+++ linux/drivers/ide/Config.help	Tue Apr  9 21:12:05 2002
@@ -744,6 +744,28 @@
 
   Generally say N here.
 
+CONFIG_BLK_DEV_IDE_TCQ
+  Support for tagged command queueing on ATA disk drives. This enables
+  the IDE layer to have multiple in-flight requests on hardware that
+  supports it. For now this includes the IBM Deskstar series drives,
+  such as the GXP75, 40GV, GXP60, and GXP120 (ie any Deskstar made in
+  the last couple of years).
+
+  If you have such a drive, say Y here.
+
+CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+  Enabled tagged command queueing unconditionally on drives that report
+  support for it.
+
+  Generally say Y here.
+
+CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+  Maximum size of commands to enable per-drive. Any value between 1
+  and 32 is valid, with 32 being the maxium that the hardware supports.
+
+  You probably just want the default of 32 here. If you enter an invalid
+  number, the default value will be used.
+
 CONFIG_BLK_DEV_IT8172
   Say Y here to support the on-board IDE controller on the Integrated
   Technology Express, Inc. ITE8172 SBC.  Vendor page at
diff -urN linux-2.5.8-pre2/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.8-pre2/drivers/ide/Config.in	Mon Mar 18 21:37:18 2002
+++ linux/drivers/ide/Config.in	Wed Apr 10 00:00:37 2002
@@ -47,6 +47,11 @@
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
+	   dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	   if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
+		int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
+	   fi
 	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
diff -urN linux-2.5.8-pre2/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.8-pre2/drivers/ide/Makefile	Mon Mar 18 21:37:05 2002
+++ linux/drivers/ide/Makefile	Tue Apr  9 21:12:05 2002
@@ -45,6 +45,7 @@
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ide-pmac.o
diff -urN linux-2.5.8-pre2/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.8-pre2/drivers/ide/hpt366.c	Tue Apr  9 20:36:00 2002
+++ linux/drivers/ide/hpt366.c	Wed Apr 10 01:10:06 2002
@@ -75,8 +75,6 @@
 #include <linux/proc_fs.h>
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
-
 const char *quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
 	"QUANTUM FIREBALLP KA6.4",
@@ -815,10 +813,8 @@
 			pci_read_config_byte(drive->channel->pci_dev, 0x50, &reg50h);
 			pci_read_config_byte(drive->channel->pci_dev, 0x52, &reg52h);
 			pci_read_config_byte(drive->channel->pci_dev, 0x5a, &reg5ah);
-			printk("%s: (%s)  reg50h=0x%02x, reg52h=0x%02x, reg5ah=0x%02x\n",
-				drive->name,
-				ide_dmafunc_verbose(func),
-				reg50h, reg52h, reg5ah);
+			printk("%s: (ide_dma_lostirq)  reg50h=0x%02x, reg52h=0x%02x, reg5ah=0x%02x\n",
+				drive->name, reg50h, reg52h, reg5ah);
 			if (reg5ah & 0x10)
 				pci_write_config_byte(drive->channel->pci_dev, 0x5a, reg5ah & ~0x10);
 			/* fall through to a reset */
diff -urN linux-2.5.8-pre2/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.8-pre2/drivers/ide/icside.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/icside.c	Wed Apr 10 01:10:29 2002
@@ -27,7 +27,6 @@
 #include <asm/io.h>
 
 extern char *ide_xfer_verbose (byte xfer_rate);
-extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
 
 /*
  * Maximum number of interfaces per card
@@ -467,8 +466,7 @@
 
 	case ide_dma_timeout:
 	default:
-		printk("icside_dmaproc: unsupported %s func: %d\n",
-			ide_dmafunc_verbose(func), func);
+		printk("icside_dmaproc: unsupported function: %d\n", func);
 	}
 	return 1;
 }
diff -urN linux-2.5.8-pre2/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.8-pre2/drivers/ide/ide-disk.c	Wed Apr 10 01:45:01 2002
+++ linux/drivers/ide/ide-disk.c	Wed Apr 10 00:55:16 2002
@@ -1,34 +1,16 @@
 /*
- *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
+ *  Copyright (C) 1994-1998  Linus Torvalds and authors:
  *
- *  Mostly written by Mark Lord <mlord@pobox.com>
- *                and Gadi Oxman <gadio@netvision.net.il>
- *                and Andre Hedrick <andre@linux-ide.org>
+ *	Mark Lord <mlord@pobox.com>
+ *	Gadi Oxman <gadio@netvision.net.il>
+ *	Andre Hedrick <andre@linux-ide.org>
+ *	Jens Axboe <axboe@suse.de>
+ *	Marcin Dalecki <dalecki@evision.ag>
  *
- * This is the IDE/ATA disk driver, as evolved from hd.c and ide.c.
- *
- * Version 1.00		move disk only code from ide.c to ide-disk.c
- *			support optional byte-swapping of all data
- * Version 1.01		fix previous byte-swapping code
- * Version 1.02		remove ", LBA" from drive identification msgs
- * Version 1.03		fix display of id->buf_size for big-endian
- * Version 1.04		add /proc configurable settings and S.M.A.R.T support
- * Version 1.05		add capacity support for ATA3 >= 8GB
- * Version 1.06		get boot-up messages to show full cyl count
- * Version 1.07		disable door-locking if it fails
- * Version 1.08		fixed CHS/LBA translations for ATA4 > 8GB,
- *			process of adding new ATA4 compliance.
- *			fixed problems in allowing fdisk to see
- *			the entire disk.
- * Version 1.09		added increment of rq->sector in ide_multwrite
- *			added UDMA 3/4 reporting
- * Version 1.10		request queue changes, Ultra DMA 100
- * Version 1.11		Highmem I/O support, Jens Axboe <axboe@suse.de>
- * Version 1.12		added 48-bit lba
- * Version 1.13		adding taskfile io access method
+ * This is the ATA disk device driver, as evolved from hd.c and ide.c.
  */
 
-#define IDEDISK_VERSION	"1.13"
+#define IDEDISK_VERSION	"1.14"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -57,7 +39,7 @@
 #endif
 
 /*
- * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
+ * Perform a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
  *
  * Returns:	1 if lba_capacity looks sensible
@@ -65,7 +47,7 @@
  *
  * It is called only once for each drive.
  */
-static int lba_capacity_is_ok (struct hd_driveid *id)
+static int lba_capacity_is_ok(struct hd_driveid *id)
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
@@ -106,135 +88,163 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
+/*
+ * Determine the apriopriate hardware command correspnding to the action in
+ * question, depending upon the device capabilities and setup.
+ */
 static u8 get_command(ide_drive_t *drive, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
+	/* Well, calculating the command in this variable may be an
+	 * overoptimization. */
+	u8 command = WIN_NOP;
 
 #if 1
 	lba48bit = drive->addressing;
 #endif
 
+	/*
+	 * 48-bit commands are pretty sanely laid out
+	 */
 	if (lba48bit) {
-		if (cmd == READ) {
-			if (drive->using_dma)
-				return WIN_READDMA_EXT;
-			else if (drive->mult_count)
-				return WIN_MULTREAD_EXT;
-			else
-				return WIN_READ_EXT;
-		} else if (cmd == WRITE) {
-			if (drive->using_dma)
-				return WIN_WRITEDMA_EXT;
-			else if (drive->mult_count)
-				return WIN_MULTWRITE_EXT;
-			else
-				return WIN_WRITE_EXT;
-		}
+		if (cmd == READ)
+			command = WIN_READ_EXT;
+		else
+			command = WIN_WRITE_EXT;
+
+		if (drive->using_dma) {
+			command++;		/* WIN_*DMA_EXT */
+			if (drive->using_tcq)
+				command++;	/* WIN_*DMA_QUEUED_EXT */
+		} else if (drive->mult_count)
+			command += 5;		/* WIN_MULT*_EXT */
 	} else {
+		/*
+		 * 28-bit commands seem not to be, though...
+		 */
 		if (cmd == READ) {
-			if (drive->using_dma)
-				return WIN_READDMA;
-			else if (drive->mult_count)
-				return WIN_MULTREAD;
+			if (drive->using_dma) {
+				if (drive->using_tcq)
+					command = WIN_READDMA_QUEUED;
+				else
+					command = WIN_READDMA;
+			} else if (drive->mult_count)
+				command = WIN_MULTREAD;
 			else
-				return WIN_READ;
-		} else if (cmd == WRITE) {
-			if (drive->using_dma)
-				return WIN_WRITEDMA;
-			else if (drive->mult_count)
-				return WIN_MULTWRITE;
+				command = WIN_READ;
+		} else {
+			if (drive->using_dma) {
+				if (drive->using_tcq)
+					command = WIN_WRITEDMA_QUEUED;
+				else
+					command = WIN_WRITEDMA;
+			} else if (drive->mult_count)
+				command = WIN_MULTWRITE;
 			else
-				return WIN_WRITE;
+				command = WIN_WRITE;
 		}
 	}
-	return WIN_NOP;
+
+	return command;
 }
 
-static ide_startstop_t chs_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t chs_do_request(ide_drive_t *drive, struct ata_request *ar, sector_t block)
 {
-	struct hd_drive_task_hdr	taskfile;
-	struct hd_drive_hob_hdr		hobfile;
-	struct ata_taskfile		args;
-	int				sectors;
+	struct ata_taskfile *args = &ar->ar_task;
+	struct request *rq = ar->ar_rq;
+	int sectors = rq->nr_sectors;
 
-	unsigned int track	= (block / drive->sect);
-	unsigned int sect	= (block % drive->sect) + 1;
-	unsigned int head	= (track % drive->head);
-	unsigned int cyl	= (track / drive->head);
+	unsigned int track = (block / drive->sect);
+	unsigned int sect = (block % drive->sect) + 1;
+	unsigned int head = (track % drive->head);
+	unsigned int cyl = (track / drive->head);
 
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	memset(&args->taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&args->hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
-	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	taskfile.sector_count	= sectors;
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		unsigned long flags;
+
+		args->taskfile.feature = sectors;
+		args->taskfile.sector_count = ar->ar_tag << 3;
 
-	taskfile.sector_number	= sect;
-	taskfile.low_cylinder	= cyl;
-	taskfile.high_cylinder	= (cyl>>8);
-
-	taskfile.device_head	= head;
-	taskfile.device_head	|= drive->select.all;
-	taskfile.command	=  get_command(drive, rq_data_dir(rq));
+		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	} else
+		args->taskfile.sector_count   = sectors;
+
+	args->taskfile.sector_number = sect;
+	args->taskfile.low_cylinder = cyl;
+	args->taskfile.high_cylinder = (cyl>>8);
+
+	args->taskfile.device_head = head;
+	args->taskfile.device_head |= drive->select.all;
+	args->taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
 		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("sectors=%ld, ", rq->nr_sectors);
+	printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	args.taskfile = taskfile;
-	args.hobfile = hobfile;
-	ide_cmd_type_parser(&args);
-	rq->special = &args;
+	ide_cmd_type_parser(args);
+	args->ar = ar;
+	rq->special = ar;
 
-	return ata_taskfile(drive, &args, rq);
+	return ata_taskfile(drive, args, rq);
 }
 
-static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct ata_request *ar, sector_t block)
 {
-	struct hd_drive_task_hdr	taskfile;
-	struct hd_drive_hob_hdr		hobfile;
-	struct ata_taskfile		args;
-	int				sectors;
+	struct ata_taskfile *args = &ar->ar_task;
+	struct request *rq = ar->ar_rq;
+	int sectors = rq->nr_sectors;
 
-	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	memset(&args->taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&args->hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		unsigned long flags;
+
+		args->taskfile.feature = sectors;
+		args->taskfile.sector_count = ar->ar_tag << 3;
 
-	taskfile.sector_count	= sectors;
-	taskfile.sector_number	= block;
-	taskfile.low_cylinder	= (block >>= 8);
-
-	taskfile.high_cylinder	= (block >>= 8);
-
-	taskfile.device_head	= ((block >> 8) & 0x0f);
-	taskfile.device_head	|= drive->select.all;
-	taskfile.command	= get_command(drive, rq_data_dir(rq));
+		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	} else
+		args->taskfile.sector_count = sectors;
+
+	args->taskfile.sector_number = block;
+	args->taskfile.low_cylinder = (block >>= 8);
+
+	args->taskfile.high_cylinder = (block >>= 8);
+
+	args->taskfile.device_head = ((block >> 8) & 0x0f);
+	args->taskfile.device_head |= drive->select.all;
+	args->taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
 		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
-	printk("sectors=%ld, ", rq->nr_sectors);
+	printk("sector=%lx, sectors=%ld, ", block, rq->nr_sectors);
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	args.taskfile = taskfile;
-	args.hobfile = hobfile;
-	ide_cmd_type_parser(&args);
-	rq->special = &args;
+	ide_cmd_type_parser(args);
+	args->ar = ar;
+	rq->special = ar;
 
-	return ata_taskfile(drive, &args, rq);
+	return ata_taskfile(drive, args, rq);
 }
 
 /*
@@ -242,57 +252,58 @@
  * 320173056  == 163929 MB or 48bit addressing
  * 1073741822 == 549756 MB or 48bit addressing fake drive
  */
-
-static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct request *rq, unsigned long long block)
+static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct ata_request *ar, sector_t block)
 {
-	struct hd_drive_task_hdr	taskfile;
-	struct hd_drive_hob_hdr		hobfile;
-	struct ata_taskfile		args;
-	int				sectors;
+	struct ata_taskfile *args = &ar->ar_task;
+	struct request *rq = ar->ar_rq;
+	int sectors = rq->nr_sectors;
 
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	memset(&args->taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&args->hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
-	sectors = rq->nr_sectors;
 	if (sectors == 65536)
 		sectors = 0;
 
-	taskfile.sector_count	= sectors;
-	hobfile.sector_count	= sectors >> 8;
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		unsigned long flags;
+
+		args->taskfile.feature = sectors;
+		args->hobfile.feature = sectors >> 8;
+		args->taskfile.sector_count = ar->ar_tag << 3;
+
+		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	} else {
+		args->taskfile.sector_count = sectors;
+		args->hobfile.sector_count = sectors >> 8;
+	}
 
-	if (rq->nr_sectors == 65536) {
-		taskfile.sector_count	= 0x00;
-		hobfile.sector_count	= 0x00;
-	}
-
-	taskfile.sector_number	= block;		/* low lba */
-	taskfile.low_cylinder	= (block >>= 8);	/* mid lba */
-	taskfile.high_cylinder	= (block >>= 8);	/* hi  lba */
-
-	hobfile.sector_number	= (block >>= 8);	/* low lba */
-	hobfile.low_cylinder	= (block >>= 8);	/* mid lba */
-	hobfile.high_cylinder	= (block >>= 8);	/* hi  lba */
-
-	taskfile.device_head	= drive->select.all;
-	hobfile.device_head	= taskfile.device_head;
-	hobfile.control		= (drive->ctl|0x80);
-	taskfile.command	= get_command(drive, rq_data_dir(rq));
+	args->taskfile.sector_number = block;
+	args->taskfile.low_cylinder = (block >>= 8);
+	args->taskfile.high_cylinder = (block >>= 8);
+
+	args->hobfile.sector_number = (block >>= 8);
+	args->hobfile.low_cylinder = (block >>= 8);
+	args->hobfile.high_cylinder = (block >>= 8);
+
+	args->taskfile.device_head = drive->select.all;
+	args->hobfile.device_head = args->taskfile.device_head;
+	args->hobfile.control = (drive->ctl|0x80);
+	args->taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
 		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
-	printk("sectors=%ld, ", rq->nr_sectors);
+	printk("sector=%lx, sectors=%ld, ", block, rq->nr_sectors);
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	args.taskfile = taskfile;
-	args.hobfile = hobfile;
-	ide_cmd_type_parser(&args);
-	rq->special = &args;
+	ide_cmd_type_parser(args);
+	args->ar = ar;
+	rq->special = ar;
 
-	return ata_taskfile(drive, &args, rq);
+	return ata_taskfile(drive, args, rq);
 }
 
 /*
@@ -300,8 +311,11 @@
  * otherwise, to address sectors.  It also takes care of issuing special
  * DRIVE_CMDs.
  */
-static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, sector_t block)
 {
+	unsigned long flags;
+	struct ata_request *ar;
+
 	/*
 	 * Wait until all request have bin finished.
 	 */
@@ -323,16 +337,49 @@
 		return promise_rw_disk(drive, rq, block);
 	}
 
+	/*
+	 * get a new command (push ar further down to avoid grabbing lock here
+	 */
+	spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+
+	ar = ata_ar_get(drive);
+
+	/*
+	 * we've reached maximum queue depth, bail
+	 */
+	if (!ar) {
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+		return ide_started;
+	}
+
+	ar->ar_rq = rq;
+
+	if (drive->using_tcq) {
+		int tag = ide_get_tag(drive);
+
+		BUG_ON(drive->tcq->active_tag != -1);
+
+		/* Set the tag: */
+		ar->ar_flags |= ATA_AR_QUEUED;
+		ar->ar_tag = tag;
+		drive->tcq->ar[tag] = ar;
+		drive->tcq->active_tag = tag;
+		ar->ar_time = jiffies;
+		drive->tcq->queued++;
+	}
+
+	spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+
 	/* 48-bit LBA */
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
-		return lba48_do_request(drive, rq, block);
+		return lba48_do_request(drive, ar, block);
 
 	/* 28-bit LBA */
 	if (drive->select.b.lba)
-		return lba28_do_request(drive, rq, block);
+		return lba28_do_request(drive, ar, block);
 
 	/* 28-bit CHS */
-	return chs_do_request(drive, rq, block);
+	return chs_do_request(drive, ar, block);
 }
 
 static int idedisk_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
@@ -411,7 +458,6 @@
  */
 static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
 {
-	/* FIXME: This is on stack! */
 	struct ata_taskfile args;
 	unsigned long addr = 0;
 
@@ -814,11 +860,71 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int proc_idedisk_read_tcq
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *) data;
+	char		*out = page;
+	int		len, cmds, i;
+	unsigned long tag_mask = 0, flags, cur_jif = jiffies, max_jif;
+
+	if (!drive->tcq) {
+		len = sprintf(out, "not configured\n");
+		PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	}
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	len = sprintf(out, "TCQ currently on:\t%s\n", drive->using_tcq ? "yes" : "no");
+	len += sprintf(out+len, "Max queue depth:\t%d\n",drive->queue_depth);
+	len += sprintf(out+len, "Max achieved depth:\t%d\n",drive->tcq->max_depth);
+	len += sprintf(out+len, "Max depth since last:\t%d\n",drive->tcq->max_last_depth);
+	len += sprintf(out+len, "Current depth:\t\t%d\n", drive->tcq->queued);
+	max_jif = 0;
+	len += sprintf(out+len, "Active tags:\t\t[ ");
+	for (i = 0, cmds = 0; i < drive->queue_depth; i++) {
+		struct ata_request *ar = IDE_GET_AR(drive, i);
+
+		if (!ar)
+			continue;
+
+		__set_bit(i, &tag_mask);
+		len += sprintf(out+len, "%d, ", i);
+		if (ar->ar_time > max_jif)
+			max_jif = ar->ar_time;
+		cmds++;
+	}
+	len += sprintf(out+len, "]\n");
+
+	if (drive->tcq->queued != cmds)
+		len += sprintf(out+len, "pending request and queue count mismatch (%d)\n", cmds);
+
+	if (tag_mask != drive->tcq->tag_mask)
+		len += sprintf(out+len, "tag masks differ (counted %lx != %lx\n", tag_mask, drive->tcq->tag_mask);
+
+	len += sprintf(out+len, "DMA status:\t\t%srunning\n", test_bit(IDE_DMA, &HWGROUP(drive)->flags) ? "" : "not ");
+
+	if (max_jif)
+		len += sprintf(out+len, "Oldest command:\t\t%lu\n", cur_jif - max_jif);
+
+	len += sprintf(out+len, "immed rel %d, immed comp %d\n", drive->tcq->immed_rel, drive->tcq->immed_comp);
+
+	drive->tcq->max_last_depth = 0;
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+}
+#endif
+
 static ide_proc_entry_t idedisk_proc[] = {
 	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
 	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
 	{ "smart_values",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_values,		NULL },
 	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	{ "tcq",		S_IFREG|S_IRUSR,	proc_idedisk_read_tcq,	NULL },
+#endif
 	{ NULL, 0, NULL, NULL }
 };
 
@@ -855,7 +961,7 @@
 	return 0;
 }
 
-static int write_cache (ide_drive_t *drive, int arg)
+static int write_cache(ide_drive_t *drive, int arg)
 {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_hob_hdr hobfile;
@@ -872,7 +978,7 @@
 	return 0;
 }
 
-static int idedisk_standby (ide_drive_t *drive)
+static int idedisk_standby(ide_drive_t *drive)
 {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_hob_hdr hobfile;
@@ -882,7 +988,7 @@
 	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
 }
 
-static int set_acoustic (ide_drive_t *drive, int arg)
+static int set_acoustic(ide_drive_t *drive, int arg)
 {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_hob_hdr hobfile;
@@ -898,6 +1004,22 @@
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int set_using_tcq(ide_drive_t *drive, int arg)
+{
+	if (!drive->driver)
+		return -EPERM;
+	if (!drive->channel->dmaproc)
+		return -EPERM;
+
+	drive->using_tcq = arg;
+	if (drive->channel->dmaproc(arg ? ide_dma_queued_on : ide_dma_queued_off, drive))
+		return -EIO;
+
+	return 0;
+}
+#endif
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -930,6 +1052,9 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
 	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
+#endif
 }
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
@@ -1025,12 +1150,12 @@
 	 */
 
 	if (drvid != -1) {
-	    sprintf(drive->device.bus_id, "%d", drvid);
-	    sprintf(drive->device.name, "ide-disk");
-	    drive->device.driver = &idedisk_devdrv;
-	    drive->device.parent = &drive->channel->dev;
-	    drive->device.driver_data = drive;
-	    device_register(&drive->device);
+		sprintf(drive->device.bus_id, "%d", drvid);
+		sprintf(drive->device.name, "ide-disk");
+		drive->device.driver = &idedisk_devdrv;
+		drive->device.parent = &drive->channel->dev;
+		drive->device.driver_data = drive;
+		device_register(&drive->device);
 	}
 
 	/* Extract geometry if we did not already have one for the drive */
@@ -1102,7 +1227,7 @@
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
-	(void) probe_lba_addressing(drive, 1);
+	probe_lba_addressing(drive, 1);
 }
 
 static int idedisk_cleanup(ide_drive_t *drive)
diff -urN linux-2.5.8-pre2/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8-pre2/drivers/ide/ide-dma.c	Wed Apr 10 01:45:01 2002
+++ linux/drivers/ide/ide-dma.c	Wed Apr 10 01:12:46 2002
@@ -1,13 +1,10 @@
 /*
- *  Copyright (c) 1999-2000	Andre Hedrick <andre@linux-ide.org>
- *  May be copied or modified under the terms of the GNU General Public License
- */
-
-/*
- *  Special Thanks to Mark for his Six years of work.
- *
+ *  Copyright (c) 1999-2000  Andre Hedrick <andre@linux-ide.org>
  *  Copyright (c) 1995-1998  Mark Lord
+ *
  *  May be copied or modified under the terms of the GNU General Public License
+ *
+ *  Special Thanks to Mark for his Six years of work.
  */
 
 /*
@@ -98,8 +95,6 @@
 #define DEFAULT_BMCRBA	0xcc00	/* VIA's default value */
 #define DEFAULT_BMALIBA	0xd400	/* ALI's default value */
 
-extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
-
 #ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
 
 struct drive_list_entry {
@@ -214,29 +209,36 @@
 			__ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
-		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
+		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
 	return ide_error(drive, "dma_intr", stat);
 }
 
-static int ide_build_sglist(struct ata_channel *hwif, struct request *rq)
+int ide_build_sglist(struct ata_channel *hwif, struct request *rq)
 {
 	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
-	struct scatterlist *sg = hwif->sg_table;
-	int nents;
+	struct ata_request *ar = rq->special;
 
-	nents = blk_rq_map_sg(q, rq, hwif->sg_table);
+	if (!(ar->ar_flags & ATA_AR_SETUP)) {
+		ar->ar_flags |= ATA_AR_SETUP;
+		ar->ar_sg_nents = blk_rq_map_sg(q, rq, ar->ar_sg_table);
+	}
 
-	if (rq->q && nents > rq->nr_phys_segments)
-		printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+	if (rq->q && ar->ar_sg_nents > rq->nr_phys_segments) {
+		printk("%s: received %d phys segments, build %d\n", __FILE__, rq->nr_phys_segments, ar->ar_sg_nents);
+		return 0;
+	} else if (!ar->ar_sg_nents) {
+		printk("%s: zero segments in request\n", __FILE__);
+		return 0;
+	}
 
 	if (rq_data_dir(rq) == READ)
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		ar->ar_sg_ddir = PCI_DMA_FROMDEVICE;
 	else
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+		ar->ar_sg_ddir = PCI_DMA_TODEVICE;
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+	return pci_map_sg(hwif->pci_dev, ar->ar_sg_table, ar->ar_sg_nents, ar->ar_sg_ddir);
 }
 
 /*
@@ -245,23 +247,17 @@
  */
 static int raw_build_sglist(struct ata_channel *ch, struct request *rq)
 {
-	struct scatterlist *sg = ch->sg_table;
-	int nents = 0;
-	struct ata_taskfile *args = rq->special;
-#if 1
+	struct ata_request *ar = rq->special;
+	struct scatterlist *sg = ar->ar_sg_table;
+	struct ata_taskfile *args = &ar->ar_task;
 	unsigned char *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
-#else
-        nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
-
-	if (nents > rq->nr_segments)
-		printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
-#endif
+	int nents = 0;
 
 	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		ch->sg_dma_direction = PCI_DMA_TODEVICE;
+		ar->ar_sg_ddir = PCI_DMA_TODEVICE;
 	else
-		ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		ar->ar_sg_ddir = PCI_DMA_FROMDEVICE;
 
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
@@ -279,18 +275,18 @@
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
 
-	return pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
+	return pci_map_sg(ch->pci_dev, sg, nents, ar->ar_sg_ddir);
 }
 
 /*
- * ide_build_dmatable() prepares a dma request.
+ * Prepare a dma request.
  * Returns 0 if all went okay, returns 1 otherwise.
- * May also be invoked from trm290.c
+ * This may also be invoked from trm290.c
  */
-int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func)
+int ide_build_dmatable(ide_drive_t *drive, struct request *rq,
+		       ide_dma_action_t func)
 {
 	struct ata_channel *hwif = drive->channel;
-	unsigned int *table = hwif->dmatable_cpu;
 #ifdef CONFIG_BLK_DEV_TRM290
 	unsigned int is_trm290_chipset = (hwif->chipset == ide_trm290);
 #else
@@ -299,16 +295,19 @@
 	unsigned int count = 0;
 	int i;
 	struct scatterlist *sg;
+	struct ata_request *ar = rq->special;
+	unsigned int *table = ar->ar_dmatable_cpu;
 
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-		hwif->sg_nents = i = raw_build_sglist(hwif, HWGROUP(drive)->rq);
-	} else {
-		hwif->sg_nents = i = ide_build_sglist(hwif, HWGROUP(drive)->rq);
-	}
-	if (!i)
+	if (rq->flags & REQ_DRIVE_TASKFILE)
+		ar->ar_sg_nents = raw_build_sglist(hwif, rq);
+	else
+		ar->ar_sg_nents = ide_build_sglist(hwif, rq);
+
+	if (!ar->ar_sg_nents)
 		return 0;
 
-	sg = hwif->sg_table;
+	sg = ar->ar_sg_table;
+	i = ar->ar_sg_nents;
 	while (i) {
 		u32 cur_addr;
 		u32 cur_len;
@@ -327,7 +326,7 @@
 
 			if (count++ >= PRD_ENTRIES) {
 				printk("ide-dma: req %p\n", HWGROUP(drive)->rq);
-				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, hwif->sg_nents, cur_len, cur_addr);
+				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, ar->ar_sg_nents, cur_len, cur_addr);
 				BUG();
 			}
 
@@ -338,7 +337,7 @@
 			if (is_trm290_chipset)
 				xcount = ((xcount >> 2) - 1) << 16;
 			if (xcount == 0x0000) {
-		        /* 
+		        /*
 			 * Most chipsets correctly interpret a length of
 			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
 			 * misinterprets it as zero (!). So here we break
@@ -346,8 +345,8 @@
 			 */
 				if (count++ >= PRD_ENTRIES) {
 					pci_unmap_sg(hwif->pci_dev, sg,
-						     hwif->sg_nents,
-						     hwif->sg_dma_direction);
+						     ar->ar_sg_nents,
+						     ar->ar_sg_ddir);
 					return 0;
 				}
 
@@ -376,10 +375,9 @@
 void ide_destroy_dmatable (ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
-	struct scatterlist *sg = drive->channel->sg_table;
-	int nents = drive->channel->sg_nents;
+	struct ata_request *ar = IDE_CUR_AR(drive);
 
-	pci_unmap_sg(dev, sg, nents, drive->channel->sg_dma_direction);
+	pci_unmap_sg(dev, ar->ar_sg_table, ar->ar_sg_nents, ar->ar_sg_ddir);
 }
 
 /*
@@ -437,7 +435,7 @@
 			printk(", UDMA(133)");	/* UDMA BIOS-enabled! */
 		}
 	} else if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-	  	  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
+		  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
 		if ((id->dma_ultra >> 13) & 1) {
 			printk(", UDMA(100)");	/* UDMA BIOS-enabled! */
 		} else if ((id->dma_ultra >> 12) & 1) {
@@ -540,6 +538,32 @@
 }
 
 /*
+ * Start DMA engine.
+ */
+int ide_start_dma(struct ata_channel *hwif, ide_drive_t *drive, ide_dma_action_t func)
+{
+	unsigned int reading = 0, count;
+	unsigned long dma_base = hwif->dma_base;
+	struct ata_request *ar = IDE_CUR_AR(drive);
+
+	if (rq_data_dir(ar->ar_rq) == READ)
+		reading = 1 << 3;
+
+	if (hwif->rwproc)
+		hwif->rwproc(drive, func);
+
+	if (!(count = ide_build_dmatable(drive, ar->ar_rq, func)))
+		return 1;	/* try PIO instead of DMA */
+
+	ar->ar_flags |= ATA_AR_SETUP;
+	outl(ar->ar_dmatable, dma_base + 4);	/* PRD table */
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base + 2) | 6, dma_base+2);/* clear INTR & ERROR flags */
+	drive->waiting_for_dma = 1;
+	return 0;
+}
+
+/*
  * ide_dmaproc() initiates/aborts DMA read/write operations on a drive.
  *
  * The caller is assumed to have selected the drive and programmed the drive's
@@ -559,15 +583,17 @@
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
-	byte unit = (drive->select.b.unit & 0x01);
-	unsigned int count, reading = 0, set_high = 1;
-	byte dma_stat;
+	u8 unit = (drive->select.b.unit & 0x01);
+	unsigned int reading = 0, set_high = 1;
+	struct ata_request *ar;
+	u8 dma_stat;
 
 	switch (func) {
 		case ide_dma_off:
 			printk("%s: DMA disabled\n", drive->name);
 		case ide_dma_off_quietly:
 			set_high = 0;
+			drive->using_tcq = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
@@ -577,48 +603,66 @@
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
+		case ide_dma_begin:
+#ifdef DEBUG
+			printk("ide_dma_begin: from %p\n", __builtin_return_address(0));
+#endif
+			if (test_and_set_bit(IDE_DMA, &HWGROUP(drive)->flags))
+				BUG();
+			/* Note that this is done *after* the cmd has
+			 * been issued to the drive, as per the BM-IDE spec.
+			 * The Promise Ultra33 doesn't work correctly when
+			 * we do this part before issuing the drive cmd.
+			 */
+			outb(inb(dma_base)|1, dma_base);		/* start DMA */
+			return 0;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		case ide_dma_queued_on:
+		case ide_dma_queued_off:
+		case ide_dma_read_queued:
+		case ide_dma_write_queued:
+		case ide_dma_queued_start:
+			return ide_tcq_dmaproc(func, drive);
+#endif
+
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			/* active tuning based on IO direction */
-			if (hwif->rwproc)
-				hwif->rwproc(drive, func);
-
-			if (!(count = ide_build_dmatable(drive, func)))
-				return 1;	/* try PIO instead of DMA */
-			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
-			outb(reading, dma_base);			/* specify r/w */
-			outb(inb(dma_base+2)|6, dma_base+2);		/* clear INTR & ERROR flags */
-			drive->waiting_for_dma = 1;
+			ar = HWGROUP(drive)->rq->special;
+
+			if (ide_start_dma(hwif, drive, func))
+				return 1;
+
 			if (drive->type != ATA_DISK)
 				return 0;
 
 			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
+			if ((ar->ar_rq->flags & REQ_DRIVE_TASKFILE) &&
 			    (drive->addressing == 1)) {
-				struct ata_taskfile *args = HWGROUP(drive)->rq->special;
+				struct ata_taskfile *args = &ar->ar_task;
 				OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 			} else if (drive->addressing) {
 				OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
 			} else {
 				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			}
-			return drive->channel->dmaproc(ide_dma_begin, drive);
-		case ide_dma_begin:
-			/* Note that this is done *after* the cmd has
-			 * been issued to the drive, as per the BM-IDE spec.
-			 * The Promise Ultra33 doesn't work correctly when
-			 * we do this part before issuing the drive cmd.
-			 */
-			outb(inb(dma_base)|1, dma_base);		/* start DMA */
-			return 0;
+			return hwif->dmaproc(ide_dma_begin, drive);
 		case ide_dma_end: /* returns 1 on error, 0 otherwise */
+#ifdef DEBUG
+			printk("ide_dma_end: from %p\n", __builtin_return_address(0));
+#endif
+			if (!test_and_clear_bit(IDE_DMA, &HWGROUP(drive)->flags)) {
+				printk("ide_dma_end: dma not going? %p\n", __builtin_return_address(0));
+				return 1;
+			}
 			drive->waiting_for_dma = 0;
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-			dma_stat = inb(dma_base+2);		/* get DMA status */
+			dma_stat = inb(dma_base+2);	/* get DMA status */
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
 			ide_destroy_dmatable(drive);	/* purge DMA mappings */
+			if (drive->tcq)
+				IDE_SET_CUR_TAG(drive, -1);
 			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
@@ -635,14 +679,14 @@
 		case ide_dma_verbose:
 			return report_drive_dmaing(drive);
 		case ide_dma_timeout:
-			printk("ide_dmaproc: DMA timeout occured!\n");
+			printk(KERN_ERR "%s: DMA timeout occured!\n", __FUNCTION__);
 			return 1;
 		case ide_dma_retune:
 		case ide_dma_lostirq:
-			printk("ide_dmaproc: chipset supported %s func only: %d\n", ide_dmafunc_verbose(func),  func);
+			printk(KERN_ERR "%s: chipset supported func only: %d\n", __FUNCTION__, func);
 			return 1;
 		default:
-			printk("ide_dmaproc: unsupported %s func: %d\n", ide_dmafunc_verbose(func), func);
+			printk(KERN_ERR "%s: unsupported func: %d\n", __FUNCTION__, func);
 			return 1;
 	}
 }
@@ -655,17 +699,6 @@
 	if (!hwif->dma_base)
 		return;
 
-	if (hwif->dmatable_cpu) {
-		pci_free_consistent(hwif->pci_dev,
-				    PRD_ENTRIES * PRD_BYTES,
-				    hwif->dmatable_cpu,
-				    hwif->dmatable_dma);
-		hwif->dmatable_cpu = NULL;
-	}
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
-	}
 	if ((hwif->dma_extra) && (hwif->unit == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
@@ -684,20 +717,6 @@
 	}
 	request_region(dma_base, num_ports, hwif->name);
 	hwif->dma_base = dma_base;
-	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
-						  PRD_ENTRIES * PRD_BYTES,
-						  &hwif->dmatable_dma);
-	if (hwif->dmatable_cpu == NULL)
-		goto dma_alloc_failure;
-
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
-				 GFP_KERNEL);
-	if (hwif->sg_table == NULL) {
-		pci_free_consistent(hwif->pci_dev, PRD_ENTRIES * PRD_BYTES,
-				    hwif->dmatable_cpu, hwif->dmatable_dma);
-		goto dma_alloc_failure;
-	}
-
 	hwif->dmaproc = &ide_dmaproc;
 
 	if (hwif->chipset != ide_trm290) {
@@ -708,7 +727,4 @@
 	}
 	printk("\n");
 	return;
-
-dma_alloc_failure:
-	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
 }
diff -urN linux-2.5.8-pre2/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.8-pre2/drivers/ide/ide-features.c	Wed Apr 10 01:45:01 2002
+++ linux/drivers/ide/ide-features.c	Wed Apr 10 01:13:51 2002
@@ -69,34 +69,6 @@
 	}
 }
 
-/*
- * A Verbose noise maker for debugging on the attempted dmaing calls.
- */
-char *ide_dmafunc_verbose (ide_dma_action_t dmafunc)
-{
-	switch (dmafunc) {
-		case ide_dma_read:		return("ide_dma_read");
-		case ide_dma_write:		return("ide_dma_write");
-		case ide_dma_begin:		return("ide_dma_begin");
-		case ide_dma_end:		return("ide_dma_end:");
-		case ide_dma_check:		return("ide_dma_check");
-		case ide_dma_on:		return("ide_dma_on");
-		case ide_dma_off:		return("ide_dma_off");
-		case ide_dma_off_quietly:	return("ide_dma_off_quietly");
-		case ide_dma_test_irq:		return("ide_dma_test_irq");
-		case ide_dma_bad_drive:		return("ide_dma_bad_drive");
-		case ide_dma_good_drive:	return("ide_dma_good_drive");
-		case ide_dma_verbose:		return("ide_dma_verbose");
-		case ide_dma_retune:		return("ide_dma_retune");
-		case ide_dma_lostirq:		return("ide_dma_lostirq");
-		case ide_dma_timeout:		return("ide_dma_timeout");
-		default:			return("unknown");
-	}
-}
-
-/*
- *
- */
 byte ide_auto_reduce_xfer (ide_drive_t *drive)
 {
 	if (!drive->crc_count)
@@ -122,9 +94,6 @@
 	}
 }
 
-/*
- * Update the 
- */
 int ide_driveid_update (ide_drive_t *drive)
 {
 	/*
@@ -195,10 +164,10 @@
 		}
 #ifndef CONFIG_IDEDMA_IVB
 		if ((drive->id->hw_config & 0x6000) == 0) {
-#else /* !CONFIG_IDEDMA_IVB */
+#else
 		if (((drive->id->hw_config & 0x2000) == 0) ||
 		    ((drive->id->hw_config & 0x4000) == 0)) {
-#endif /* CONFIG_IDEDMA_IVB */
+#endif
 			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->name);
 			return 1;
 		}
@@ -232,7 +201,7 @@
 	return ((byte) ((drive->channel->udma_four) &&
 #ifndef CONFIG_IDEDMA_IVB
 			(drive->id->hw_config & 0x4000) &&
-#endif /* CONFIG_IDEDMA_IVB */
+#endif
 			(drive->id->hw_config & 0x6000)) ? 1 : 0);
 }
 
diff -urN linux-2.5.8-pre2/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.8-pre2/drivers/ide/ide-pmac.c	Wed Apr 10 01:45:01 2002
+++ linux/drivers/ide/ide-pmac.c	Wed Apr 10 01:09:56 2002
@@ -52,7 +52,6 @@
 #endif
 #include "ata-timing.h"
 
-extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
 extern spinlock_t ide_lock;
 
 #undef IDE_PMAC_DEBUG
@@ -1460,10 +1459,10 @@
 	case ide_dma_retune:
 	case ide_dma_lostirq:
 	case ide_dma_timeout:
-		printk(KERN_WARNING "ide_pmac_dmaproc: chipset supported %s func only: %d\n", ide_dmafunc_verbose(func),  func);
+		printk(KERN_WARNING "ide_pmac_dmaproc: chipset supported func only: %d\n", func);
 		return 1;
 	default:
-		printk(KERN_WARNING "ide_pmac_dmaproc: unsupported %s func: %d\n", ide_dmafunc_verbose(func), func);
+		printk(KERN_WARNING "ide_pmac_dmaproc: unsupported func: %d\n", func);
 		return 1;
 	}
 	return 0;
diff -urN linux-2.5.8-pre2/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.8-pre2/drivers/ide/ide-probe.c	Tue Apr  9 20:36:00 2002
+++ linux/drivers/ide/ide-probe.c	Tue Apr  9 21:12:13 2002
@@ -189,6 +189,21 @@
 	if (drive->channel->quirkproc)
 		drive->quirk_list = drive->channel->quirkproc(drive);
 
+	/*
+	 * it's an ata drive, build command list
+	 */
+#ifndef CONFIG_BLK_DEV_IDE_TCQ
+	drive->queue_depth = 1;
+#else
+	drive->queue_depth = drive->id->queue_depth + 1;
+	if (drive->queue_depth > CONFIG_BLK_DEV_IDE_TCQ_DEPTH)
+		drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
+	if (drive->queue_depth < 1 || drive->queue_depth > IDE_MAX_TAG)
+		drive->queue_depth = IDE_MAX_TAG;
+#endif
+	if (ide_build_commandlist(drive))
+		goto err_misc;
+
 	return;
 
 err_misc:
@@ -593,10 +608,10 @@
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */
-	blk_queue_max_hw_segments(q, PRD_ENTRIES);
+	blk_queue_max_hw_segments(q, PRD_SEGMENTS);
 
 	/* This is a driver limit and could be eliminated. */
-	blk_queue_max_phys_segments(q, PRD_ENTRIES);
+	blk_queue_max_phys_segments(q, PRD_SEGMENTS);
 }
 
 #if MAX_HWIFS > 1
diff -urN linux-2.5.8-pre2/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8-pre2/drivers/ide/ide-taskfile.c	Wed Apr 10 01:45:01 2002
+++ linux/drivers/ide/ide-taskfile.c	Wed Apr 10 00:48:55 2002
@@ -291,7 +291,8 @@
 
 static ide_startstop_t pre_task_mulout_intr(ide_drive_t *drive, struct request *rq)
 {
-	struct ata_taskfile *args = rq->special;
+	struct ata_request *ar = rq->special;
+	struct ata_taskfile *args = &ar->ar_task;
 	ide_startstop_t startstop;
 
 	/*
@@ -434,11 +435,35 @@
 		if (args->prehandler != NULL)
 			return args->prehandler(drive, rq);
 	} else {
-		/* for dma commands we down set the handler */
-		if (drive->using_dma &&
-		!(drive->channel->dmaproc(((args->taskfile.command == WIN_WRITEDMA)
-					|| (args->taskfile.command == WIN_WRITEDMA_EXT))
-					? ide_dma_write : ide_dma_read, drive)));
+		ide_dma_action_t dmaaction;
+		u8 command;
+
+		if (!drive->using_dma)
+			return ide_started;
+
+		command = args->taskfile.command;
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		if (drive->using_tcq) {
+			if (command == WIN_READDMA_QUEUED
+			    || command == WIN_READDMA_QUEUED_EXT
+			    || command == WIN_WRITEDMA_QUEUED
+			    || command == WIN_READDMA_QUEUED_EXT)
+				return ide_start_tag(ide_dma_queued_start, drive, rq->special);
+		}
+#endif
+
+		if (command == WIN_WRITEDMA || command == WIN_WRITEDMA_EXT)
+			dmaaction = ide_dma_write;
+		else if (command == WIN_READDMA || command == WIN_READDMA_EXT)
+			dmaaction = ide_dma_read;
+		else
+			return ide_stopped;
+
+		if (!drive->channel->dmaproc(dmaaction, drive))
+			return ide_started;
+
+		return ide_stopped;
 	}
 
 	return ide_started;
@@ -495,8 +520,9 @@
  */
 ide_startstop_t task_no_data_intr (ide_drive_t *drive)
 {
-	struct ata_taskfile *args = HWGROUP(drive)->rq->special;
-	byte stat		= GET_STAT();
+	struct ata_request *ar = HWGROUP(drive)->rq->special;
+	struct ata_taskfile *args = &ar->ar_task;
+	u8 stat = GET_STAT();
 
 	ide__sti();	/* local CPU only */
 
@@ -555,7 +581,8 @@
 
 static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 {
-	struct ata_taskfile *args = rq->special;
+	struct ata_request *ar = rq->special;
+	struct ata_taskfile *args = &ar->ar_task;
 	ide_startstop_t startstop;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
@@ -644,7 +671,7 @@
 
 		pBuf = ide_map_rq(rq, &flags);
 
-		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
+		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
 			pBuf, nsect, rq->current_nr_sectors);
 		drive->io_32bit = 0;
 		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
@@ -858,7 +885,7 @@
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-static void init_taskfile_request(struct request *rq)
+void init_taskfile_request(struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_TASKFILE;
@@ -875,23 +902,24 @@
 int ide_wait_taskfile(ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, byte *buf)
 {
 	struct request rq;
-	/* FIXME: This is on stack! */
-	struct ata_taskfile args;
+	struct ata_request ar;
+	struct ata_taskfile *args = &ar.ar_task;
 
-	memset(&args, 0, sizeof(args));
+	ata_ar_init(drive, &ar);
 
-	args.taskfile = *taskfile;
-	args.hobfile = *hobfile;
+	memcpy(&args->taskfile, taskfile, sizeof(*taskfile));
+	if (hobfile)
+		memcpy(&args->hobfile, hobfile, sizeof(*hobfile));
 
 	init_taskfile_request(&rq);
 
 	/* This is kept for internal use only !!! */
-	ide_cmd_type_parser(&args);
-	if (args.command_type != IDE_DRIVE_TASK_NO_DATA)
+	ide_cmd_type_parser(args);
+	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
 		rq.current_nr_sectors = rq.nr_sectors = (hobfile->sector_count << 8) | taskfile->sector_count;
 
 	rq.buffer = buf;
-	rq.special = &args;
+	rq.special = &ar;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -899,15 +927,19 @@
 int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
+	struct ata_request ar;
+
+	ata_ar_init(drive, &ar);
 	init_taskfile_request(&rq);
 	rq.buffer = buf;
+	memcpy(&ar.ar_task, args, sizeof(*args));
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
 		rq.current_nr_sectors = rq.nr_sectors
 			= (args->hobfile.sector_count << 8)
 			| args->taskfile.sector_count;
 
-	rq.special = args;
+	rq.special = &ar;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff -urN linux-2.5.8-pre2/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- linux-2.5.8-pre2/drivers/ide/ide-tcq.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/ide/ide-tcq.c	Wed Apr 10 01:39:43 2002
@@ -0,0 +1,594 @@
+/*
+ * Copyright (C) 2001, 2002 Jens Axboe <axboe@suse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * Support for the DMA queued protocol, which enables ATA disk drives to
+ * use tagged command queueing.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ide.h>
+
+#include <asm/delay.h>
+
+/*
+ * warning: it will be _very_ verbose if set to 1
+ */
+#if 0
+#define TCQ_PRINTK printk
+#else
+#define TCQ_PRINTK(x...)
+#endif
+
+/*
+ * use nIEN or not
+ */
+#undef IDE_TCQ_NIEN
+
+/*
+ * we are leaving the SERVICE interrupt alone, IBM drives have it
+ * on per default and it can't be turned off. Doesn't matter, this
+ * is the sane config.
+ */
+#undef IDE_TCQ_FIDDLE_SI
+
+int ide_tcq_end(ide_drive_t *drive);
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
+
+static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
+{
+#ifdef IDE_TCQ_NIEN
+	int mask = clear ? 0 : 2;
+
+	if (IDE_CONTROL_REG)
+		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
+#endif
+}
+
+/*
+ * if we encounter _any_ error doing I/O to one of the tags, we must
+ * invalidate the pending queue. clear the software busy queue and requeue
+ * on the request queue for restart. issue a WIN_NOP to clear hardware queue
+ */
+static void ide_tcq_invalidate_queue(ide_drive_t *drive)
+{
+	request_queue_t *q = &drive->queue;
+	unsigned long flags;
+	struct ata_request *ar;
+	int i;
+
+	printk("%s: invalidating pending queue\n", drive->name);
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	del_timer(&HWGROUP(drive)->timer);
+
+	/*
+	 * assume oldest commands have the higher tags... doesn't matter
+	 * much. shove requests back into request queue.
+	 */
+	for (i = drive->queue_depth - 1; i; i--) {
+		ar = drive->tcq->ar[i];
+		if (!ar)
+			continue;
+
+		ar->ar_rq->special = NULL;
+		ar->ar_rq->flags &= ~REQ_STARTED;
+		_elv_add_request(q, ar->ar_rq, 0, 0);
+		ata_ar_put(drive, ar);
+	}
+
+	drive->tcq->queued = 0;
+	drive->using_tcq = 0;
+	drive->queue_depth = 1;
+	clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+	clear_bit(IDE_DMA, &HWGROUP(drive)->flags);
+	HWGROUP(drive)->handler = NULL;
+
+	/*
+	 * do some internal stuff -- we really need this command to be
+	 * executed before any new commands are started. issue a NOP
+	 * to clear internal queue on drive
+	 */
+	ar = ata_ar_get(drive);
+
+	memset(&ar->ar_task, 0, sizeof(ar->ar_task));
+	AR_TASK_CMD(ar) = WIN_NOP;
+	ide_cmd_type_parser(&ar->ar_task);
+	ar->ar_rq = &HWGROUP(drive)->wrq;
+	init_taskfile_request(ar->ar_rq);
+	ar->ar_rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
+	ar->ar_rq->special = ar;
+	ar->ar_flags |= ATA_AR_RETURN;
+	_elv_add_request(q, ar->ar_rq, 0, 0);
+
+	/*
+	 * make sure that nIEN is cleared
+	 */
+	drive_ctl_nien(drive, 0);
+
+	/*
+	 * start doing stuff again
+	 */
+	q->request_fn(q);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	printk("ide_tcq_invalidate_queue: done\n");
+}
+
+void ide_tcq_intr_timeout(unsigned long data)
+{
+	ide_hwgroup_t *hwgroup = (ide_hwgroup_t *) data;
+	unsigned long flags;
+	ide_drive_t *drive;
+
+	printk("ide_tcq_intr_timeout: timeout waiting for interrupt...\n");
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if (test_bit(IDE_BUSY, &hwgroup->flags))
+		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
+	if (hwgroup->handler == NULL)
+		printk("ide_tcq_intr_timeout: missing isr!\n");
+	if ((drive = hwgroup->drive) == NULL)
+		printk("ide_tcq_intr_timeout: missing drive!\n");
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	if (drive)
+		ide_tcq_invalidate_queue(drive);
+}
+
+void ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ide_handler_t *handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	/*
+	 * always just bump the timer for now, the timeout handling will
+	 * have to be changed to be per-command
+	 */
+	hwgroup->timer.function = ide_tcq_intr_timeout;
+	hwgroup->timer.data = (unsigned long) hwgroup;
+	mod_timer(&hwgroup->timer, jiffies + 5 * HZ);
+
+	hwgroup->handler = handler;
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+/*
+ * wait 400ns, then poll for busy_mask to clear from alt status
+ */
+#define IDE_TCQ_WAIT	(10000)
+int ide_tcq_wait_altstat(ide_drive_t *drive, byte *stat, byte busy_mask)
+{
+	int i;
+
+	/*
+	 * one initial udelay(1) should be enough, reading alt stat should
+	 * provide the required delay...
+	 */
+	*stat = 0;
+	i = 0;
+	do {
+		udelay(1);
+
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+	} while ((*stat = GET_ALTSTAT()) & busy_mask);
+
+	return 0;
+}
+
+/*
+ * issue SERVICE command to drive -- drive must have been selected first,
+ * and it must have reported a need for service (status has SERVICE_STAT set)
+ *
+ * Also, nIEN must be set as not to need protection against ide_dmaq_intr
+ */
+ide_startstop_t ide_service(ide_drive_t *drive)
+{
+	struct ata_request *ar;
+	byte feat, tag, stat;
+
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		printk("ide_service: DMA in progress\n");
+
+	/*
+	 * need to select the right drive first...
+	 */
+	if (drive != HWGROUP(drive)->drive) {
+		SELECT_DRIVE(drive->channel, drive);
+		udelay(10);
+	}
+
+	drive_ctl_nien(drive, 1);
+
+	/*
+	 * send SERVICE, wait 400ns, wait for BUSY_STAT to clear
+	 */
+	OUT_BYTE(WIN_QUEUED_SERVICE, IDE_COMMAND_REG);
+
+	if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
+		printk("ide_service: BUSY clear took too long\n");
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	drive_ctl_nien(drive, 0);
+
+	/*
+	 * FIXME, invalidate queue
+	 */
+	if (stat & ERR_STAT) {
+		printk("%s: error SERVICING drive (%x)\n", drive->name, stat);
+		ide_dump_status(drive, "ide_service", stat);
+		return ide_tcq_end(drive);
+	}
+
+	/*
+	 * should not happen, a buggy device could introduce loop
+	 */
+	if ((feat = GET_FEAT()) & NSEC_REL) {
+		printk("%s: release in service\n", drive->name);
+		IDE_SET_CUR_TAG(drive, -1);
+		return ide_stopped;
+	}
+
+	/*
+	 * start dma
+	 */
+	tag = feat >> 3;
+	IDE_SET_CUR_TAG(drive, tag);
+
+	TCQ_PRINTK("ide_service: stat %x, feat %x\n", stat, feat);
+
+	if ((ar = IDE_CUR_TAG(drive)) == NULL) {
+		printk("ide_service: missing request for tag %d\n", tag);
+		return ide_stopped;
+	}
+
+	/*
+	 * we'll start a dma read or write, device will trigger
+	 * interrupt to indicate end of transfer, release is not allowed
+	 */
+	if (rq_data_dir(ar->ar_rq) == READ) {
+		TCQ_PRINTK("ide_service: starting READ %x\n", stat);
+		drive->channel->dmaproc(ide_dma_read_queued, drive);
+	} else {
+		TCQ_PRINTK("ide_service: starting WRITE %x\n", stat);
+		drive->channel->dmaproc(ide_dma_write_queued, drive);
+	}
+
+	/*
+	 * dmaproc set intr handler
+	 */
+	return ide_started;
+}
+
+ide_startstop_t ide_check_service(ide_drive_t *drive)
+{
+	byte stat;
+
+	if (!ide_pending_commands(drive))
+		return ide_stopped;
+
+	if ((stat = GET_STAT()) & SERVICE_STAT)
+		return ide_service(drive);
+
+	/*
+	 * we have pending commands, wait for interrupt
+	 */
+	ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+	return ide_started;
+}
+
+int ide_tcq_end(ide_drive_t *drive)
+{
+	byte stat = GET_STAT();
+
+	if (stat & ERR_STAT) {
+		ide_dump_status(drive, "ide_tcq_end", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	} else if (stat & SERVICE_STAT) {
+		TCQ_PRINTK("ide_tcq_end: serv stat=%x\n", stat);
+		return ide_service(drive);
+	}
+
+	TCQ_PRINTK("ide_tcq_end: stat=%x, feat=%x\n", stat, GET_FEAT());
+	return ide_stopped;
+}
+
+ide_startstop_t ide_dmaq_complete(ide_drive_t *drive, byte stat)
+{
+	struct ata_request *ar;
+	byte dma_stat;
+
+#if 0
+	byte feat = GET_FEAT();
+
+	if ((feat & (NSEC_CD | NSEC_IO)) != (NSEC_CD | NSEC_IO))
+		printk("%s: C/D | I/O not set\n", drive->name);
+#endif
+
+	/*
+	 * transfer was in progress, stop DMA engine
+	 */
+	ar = IDE_CUR_TAG(drive);
+
+	dma_stat = drive->channel->dmaproc(ide_dma_end, drive);
+
+	/*
+	 * must be end of I/O, check status and complete as necessary
+	 */
+	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
+		printk("ide_dmaq_intr: %s: error status %x\n", drive->name, stat);
+		ide_dump_status(drive, "ide_dmaq_intr", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	if (dma_stat)
+		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
+
+	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", ar, ar->ar_tag);
+	ide_end_queued_request(drive, !dma_stat, ar->ar_rq);
+
+	IDE_SET_CUR_TAG(drive, -1);
+	return ide_check_service(drive);
+}
+
+/*
+ * intr handler for queued dma operations. this can be entered for two
+ * reasons:
+ *
+ * 1) device has completed dma transfer
+ * 2) service request to start a command
+ *
+ * if the drive has an active tag, we first complete that request before
+ * processing any pending SERVICE.
+ */
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive)
+{
+	byte stat = GET_STAT();
+
+	TCQ_PRINTK("ide_dmaq_intr: stat=%x, tag %d\n", stat, drive->tcq->active_tag);
+
+	/*
+	 * if a command completion interrupt is pending, do that first and
+	 * check service afterwards
+	 */
+	if (drive->tcq->active_tag != -1)
+		return ide_dmaq_complete(drive, stat);
+
+	/*
+	 * service interrupt
+	 */
+	if (stat & SERVICE_STAT) {
+		TCQ_PRINTK("ide_dmaq_intr: SERV (stat=%x)\n", stat);
+		return ide_service(drive);
+	}
+
+	printk("ide_dmaq_intr: stat=%x, not expected\n", stat);
+	return ide_check_service(drive);
+}
+
+/*
+ * configure the drive for tcq
+ */
+static int ide_tcq_configure(ide_drive_t *drive)
+{
+	struct hd_drive_task_hdr taskfile;
+	int tcq_supp = 1 << 1 | 1 << 14;
+
+	memset(&taskfile, 0, sizeof(taskfile));
+
+	/*
+	 * bit 14 and 1 must be set in word 83 of the device id to indicate
+	 * support for dma queued protocol
+	 */
+	if ((drive->id->command_set_2 & tcq_supp) != tcq_supp) {
+		printk("%s: queued feature set not supported\n", drive->name);
+		return 1;
+	}
+
+	taskfile.feature = SETFEATURES_EN_WCACHE;
+	taskfile.command = WIN_SETFEATURES;
+	if (ide_wait_taskfile(drive, &taskfile, NULL, NULL)) {
+		printk("%s: failed to enable write cache\n", drive->name);
+		return 1;
+	}
+
+	/*
+	 * disable RELease interrupt, it's quicker to poll this after
+	 * having sent the command opcode
+	 */
+	taskfile.feature = SETFEATURES_DIS_RI;
+	taskfile.command = WIN_SETFEATURES;
+	if (ide_wait_taskfile(drive, &taskfile, NULL, NULL)) {
+		printk("%s: disabling release interrupt fail\n", drive->name);
+		return 1;
+	}
+
+#ifdef IDE_TCQ_FIDDLE_SI
+	/*
+	 * enable SERVICE interrupt
+	 */
+	taskfile.feature = SETFEATURES_EN_SI;
+	taskfile.command = WIN_SETFEATURES;
+	if (ide_wait_taskfile(drive, &taskfile, NULL, NULL)) {
+		printk("%s: enabling service interrupt fail\n", drive->name);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+/*
+ * for now assume that command list is always as big as we need and don't
+ * attempt to shrink it on tcq disable
+ */
+static int ide_enable_queued(ide_drive_t *drive, int on)
+{
+	/*
+	 * disable or adjust queue depth
+	 */
+	if (!on) {
+		printk("%s: TCQ disabled\n", drive->name);
+		drive->using_tcq = 0;
+
+		return 0;
+	} else if (drive->using_tcq) {
+		drive->queue_depth = drive->using_tcq;
+
+		goto out;
+	}
+
+	if (ide_tcq_configure(drive)) {
+		drive->using_tcq = 0;
+
+		return 1;
+	}
+
+out:
+	drive->tcq->max_depth = 0;
+
+	printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
+	drive->using_tcq = 1;
+
+	return 0;
+}
+
+int ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+{
+	struct ata_channel *hwif = drive->channel;
+	unsigned int reading = 0, enable_tcq = 1;
+	ide_startstop_t startstop;
+	struct ata_request *ar;
+	byte stat, feat;
+
+	switch (func) {
+		/*
+		 * invoked from a SERVICE interrupt, command etc already known.
+		 * just need to start the dma engine for this tag
+		 */
+		case ide_dma_read_queued:
+			reading = 1 << 3;
+		case ide_dma_write_queued:
+			TCQ_PRINTK("ide_dma: setting up queued %d\n", drive->tcq->active_tag);
+			BUG_ON(drive->tcq->active_tag == -1);
+
+			if (!test_bit(IDE_BUSY, &HWGROUP(drive)->flags))
+				printk("queued_rw: IDE_BUSY not set\n");
+
+			if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+				printk("%s: timeout waiting for data phase\n", drive->name);
+				return startstop;
+			}
+
+			if (ide_start_dma(hwif, drive, func))
+				return 1;
+
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+			return hwif->dmaproc(ide_dma_begin, drive);
+
+			/*
+			 * start a queued command from scratch
+			 */
+		case ide_dma_queued_start:
+			BUG_ON(drive->tcq->active_tag == -1);
+			ar = IDE_CUR_TAG(drive);
+
+			/*
+			 * set nIEN, tag start operation will enable again when
+			 * it is safe
+			 */
+			drive_ctl_nien(drive, 1);
+
+			OUT_BYTE(AR_TASK_CMD(ar), IDE_COMMAND_REG);
+
+			if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
+				printk("ide_dma_queued_start: abort (stat=%x)\n", stat);
+				return ide_stopped;
+			}
+
+			drive_ctl_nien(drive, 0);
+
+			if (stat & ERR_STAT) {
+				printk("ide_dma_queued_start: abort (stat=%x)\n", stat);
+				return ide_stopped;
+			}
+
+			if ((feat = GET_FEAT()) & NSEC_REL) {
+				drive->tcq->immed_rel++;
+				TCQ_PRINTK("REL in queued_start\n");
+				IDE_SET_CUR_TAG(drive, -1);
+
+				if ((stat = GET_STAT()) & SERVICE_STAT)
+					return ide_service(drive);
+
+				ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+				return ide_released;
+			}
+
+			drive->tcq->immed_comp++;
+
+			if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+				printk("%s: timeout waiting for data phase\n", drive->name);
+				return startstop;
+			}
+
+			if (ide_start_dma(hwif, drive, func))
+				return ide_stopped;
+
+			if (hwif->dmaproc(ide_dma_begin, drive))
+				return ide_stopped;
+
+			/*
+			 * wait for SERVICE or completion interrupt
+			 */
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+			return ide_started;
+
+		case ide_dma_queued_off:
+			enable_tcq = 0;
+		case ide_dma_queued_on:
+			return ide_enable_queued(drive, enable_tcq);
+		default:
+			break;
+	}
+
+	return 1;
+}
+
+int ide_build_sglist (struct ata_channel *hwif, struct request *rq);
+ide_startstop_t ide_start_tag(ide_dma_action_t func, ide_drive_t *drive,
+			      struct ata_request *ar)
+{
+	/*
+	 * do this now, no need to run that with interrupts disabled
+	 */
+	if (!ide_build_sglist(drive->channel, ar->ar_rq))
+		return ide_stopped;
+
+	IDE_SET_CUR_TAG(drive, ar->ar_tag);
+	return ide_tcq_dmaproc(func, drive);
+}
diff -urN linux-2.5.8-pre2/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8-pre2/drivers/ide/ide.c	Wed Apr 10 01:45:01 2002
+++ linux/drivers/ide/ide.c	Wed Apr 10 00:20:02 2002
@@ -368,6 +368,25 @@
 	return 0;	/* no, it is not a flash memory card */
 }
 
+void ide_end_queued_request(ide_drive_t *drive, int uptodate, struct request *rq)
+{
+	unsigned long flags;
+
+	BUG_ON(!(rq->flags & REQ_STARTED));
+	BUG_ON(!rq->special);
+
+	if (!end_that_request_first(rq, uptodate, rq->hard_nr_sectors)) {
+		struct ata_request *ar = rq->special;
+
+		add_blkdev_randomness(major(rq->rq_dev));
+
+		spin_lock_irqsave(&ide_lock, flags);
+		ata_ar_put(drive, ar);
+		end_that_request_last(rq);
+		spin_unlock_irqrestore(&ide_lock, flags);
+	}
+}
+
 int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs)
 {
 	struct request *rq;
@@ -396,9 +415,17 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
+		struct ata_request *ar = rq->special;
+
 		add_blkdev_randomness(major(rq->rq_dev));
+		/*
+		 * request with ATA_AR_QUEUED set have already been
+		 * dequeued, but doing it twice is ok
+		 */
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
+		if (ar)
+			ata_ar_put(drive, ar);
 		end_that_request_last(rq);
 		ret = 0;
 	}
@@ -422,8 +449,8 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 	if (hwgroup->handler != NULL) {
-		printk("%s: ide_set_handler: handler not null; old=%p, new=%p\n",
-			drive->name, hwgroup->handler, handler);
+		printk("%s: ide_set_handler: handler not null; old=%p, new=%p, from %p\n",
+			drive->name, hwgroup->handler, handler, __builtin_return_address(0));
 	}
 	hwgroup->handler	= handler;
 	hwgroup->expiry		= expiry;
@@ -738,8 +765,12 @@
 			args[6] = IN_BYTE(IDE_SELECT_REG);
 		}
 	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
-		struct ata_taskfile *args = rq->special;
+		struct ata_request *ar = rq->special;
+		struct ata_taskfile *args = &ar->ar_task;
+
 		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
+		if (args && args->taskfile.command == WIN_NOP)
+			printk(KERN_INFO "%s: NOP completed\n", __FUNCTION__);
 		if (args) {
 			args->taskfile.feature = err;
 			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
@@ -762,6 +793,8 @@
 				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
+		if (ar->ar_flags & ATA_AR_RETURN)
+			ata_ar_put(drive, ar);
 	}
 
 	blkdev_dequeue_request(rq);
@@ -879,6 +912,11 @@
 	struct request *rq;
 	byte err;
 
+	/*
+	 * FIXME: remember to invalidate tcq queue when drive->using_tcq
+	 * and atomic_read(&drive->tcq->queued) /jens
+	 */
+
 	err = ide_dump_status(drive, msg, stat);
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
@@ -1063,7 +1101,11 @@
 	while ((read_timer() - hwif->last_time) < DISK_RECOVERY_TIME);
 #endif
 
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		printk("start_request: auch, DMA in progress 1\n");
 	SELECT_DRIVE(hwif, drive);
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		printk("start_request: auch, DMA in progress 2\n");
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat,
 			  BUSY_STAT|DRQ_STAT, WAIT_READY)) {
 		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
@@ -1083,11 +1125,14 @@
 			 */
 
 			if (rq->flags & REQ_DRIVE_TASKFILE) {
-				struct ata_taskfile *args = rq->special;
+				struct ata_request *ar = rq->special;
+				struct ata_taskfile *args;
 
-				if (!(args))
+				if (!ar)
 					goto args_error;
 
+				args = &ar->ar_task;
+
 				ata_taskfile(drive, args, NULL);
 
 				if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
@@ -1318,16 +1363,37 @@
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
 		drive->PADAM_sleep = 0;
+queue_next:
 		drive->PADAM_service_start = jiffies;
 
-		if (blk_queue_plugged(&drive->queue))
-			BUG();
+		if (test_bit(IDE_DMA, &hwgroup->flags)) {
+			printk("ide_do_request: DMA in progress...\n");
+			break;
+		}
+
+		/*
+		 * there's a small window between where the queue could be
+		 * replugged while we are in here when using tcq (in which
+		 * case the queue is probably empty anyways...), so check
+		 * and leave if appropriate. When not using tcq, this is
+		 * still a severe BUG!
+		 */
+		if (blk_queue_plugged(&drive->queue)) {
+			BUG_ON(!drive->using_tcq);
+			break;
+		}
 
 		/*
 		 * just continuing an interrupted request maybe
 		 */
 		rq = hwgroup->rq = elv_next_request(&drive->queue);
 
+		if (!rq) {
+			if (!ide_pending_commands(drive))
+				clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+			break;
+		}
+
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
 		 * the driver is still setting things up.  So, here we disable
@@ -1338,14 +1404,22 @@
 		 */
 		if (masked_irq && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
+
 		spin_unlock(&ide_lock);
 		ide__sti();	/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
+
 		spin_lock_irq(&ide_lock);
 		if (masked_irq && hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
-		if (startstop == ide_stopped)
+
+		if (startstop == ide_released)
+			goto queue_next;
+		else if (startstop == ide_stopped) {
+			if (test_bit(IDE_DMA, &hwgroup->flags))
+				printk("2nd illegal clear\n");
 			clear_bit(IDE_BUSY, &hwgroup->flags);
+		}
 	}
 }
 
@@ -1372,21 +1446,39 @@
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
  * retry the current request in PIO mode instead of risking tossing it
  * all away
+ *
+ * FIXME: needs a bit of tcq work
  */
 void ide_dma_timeout_retry(ide_drive_t *drive)
 {
 	struct ata_channel *hwif = drive->channel;
-	struct request *rq;
+	struct request *rq = NULL;
+	struct ata_request *ar = NULL;
+
+	if (drive->using_tcq) {
+		if (drive->tcq->active_tag != -1) {
+			ar = IDE_CUR_AR(drive);
+			rq = ar->ar_rq;
+		}
+	} else {
+		rq = HWGROUP(drive)->rq;
+		ar = rq->special;
+	}
 
 	/*
 	 * end current dma transaction
 	 */
-	hwif->dmaproc(ide_dma_end, drive);
+	if (rq)
+		hwif->dmaproc(ide_dma_end, drive);
 
 	/*
 	 * complain a little, later we might remove some of this verbosity
 	 */
-	printk("%s: timeout waiting for DMA\n", drive->name);
+	printk("%s: timeout waiting for DMA", drive->name);
+	if (drive->using_tcq)
+		printk(" queued, active tag %d", drive->tcq->active_tag);
+	printk("\n");
+
 	hwif->dmaproc(ide_dma_timeout, drive);
 
 	/*
@@ -1402,15 +1494,25 @@
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
 	 * make sure request is sane
 	 */
-	rq = HWGROUP(drive)->rq;
 	HWGROUP(drive)->rq = NULL;
 
+	if (!rq)
+		return;
+
 	rq->errors = 0;
 	if (rq->bio) {
 		rq->sector = rq->bio->bi_sector;
 		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
 		rq->buffer = NULL;
 	}
+
+	/*
+	 *  this request was not on the queue any more
+	 */
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		ata_ar_put(drive, ar);
+		_elv_add_request(&drive->queue, rq, 0, 0);
+	}
 }
 
 /*
@@ -1641,8 +1743,10 @@
 	set_recovery_timer(drive->channel);
 	drive->PADAM_service_time = jiffies - drive->PADAM_service_start;
 	if (startstop == ide_stopped) {
-		if (hwgroup->handler == NULL) {	/* paranoia */
+		if (hwgroup->handler == NULL) { /* paranoia */
 			clear_bit(IDE_BUSY, &hwgroup->flags);
+			if (test_bit(IDE_DMA, &hwgroup->flags))
+				printk("ide_intr: illegal clear\n");
 			ide_do_request(hwgroup, hwif->irq);
 		} else {
 			printk("%s: ide_intr: huh? expected NULL handler on exit\n", drive->name);
@@ -1722,6 +1826,7 @@
 	if (drive->channel->chipset == ide_pdc4030 && rq->buffer != NULL)
 		return -ENOSYS;  /* special drive cmds not supported */
 #endif
+	rq->flags |= REQ_STARTED;
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
@@ -2045,6 +2150,7 @@
 		}
 		drive->present = 0;
 		blk_cleanup_queue(&drive->queue);
+		ide_teardown_commandlist(drive);
 	}
 	if (d->present)
 		hwgroup->drive = d;
@@ -2595,6 +2701,89 @@
 	}
 }
 
+void ide_teardown_commandlist(ide_drive_t *drive)
+{
+	struct pci_dev *pdev= drive->channel->pci_dev;
+	struct list_head *entry;
+
+	list_for_each(entry, &drive->free_req) {
+		struct ata_request *ar = list_ata_entry(entry);
+
+		list_del(&ar->ar_queue);
+		kfree(ar->ar_sg_table);
+		pci_free_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, ar->ar_dmatable_cpu, ar->ar_dmatable);
+		kfree(ar);
+	}
+}
+
+int ide_build_commandlist(ide_drive_t *drive)
+{
+	struct pci_dev *pdev= drive->channel->pci_dev;
+	struct ata_request *ar;
+	ide_tag_info_t *tcq;
+	int i, err;
+
+	tcq = kmalloc(sizeof(ide_tag_info_t), GFP_ATOMIC);
+	if (!tcq)
+		return -ENOMEM;
+
+	drive->tcq = tcq;
+	memset(drive->tcq, 0, sizeof(ide_tag_info_t));
+
+	INIT_LIST_HEAD(&drive->free_req);
+	drive->using_tcq = 0;
+
+	err = -ENOMEM;
+	for (i = 0; i < drive->queue_depth; i++) {
+		/* Having kzmalloc would help reduce code size at quite
+		 * many places in kernel. */
+		ar = kmalloc(sizeof(*ar), GFP_ATOMIC);
+		if (!ar)
+			break;
+
+		memset(ar, 0, sizeof(*ar));
+		INIT_LIST_HEAD(&ar->ar_queue);
+
+		ar->ar_sg_table = kmalloc(PRD_SEGMENTS * sizeof(struct scatterlist), GFP_ATOMIC);
+		if (!ar->ar_sg_table) {
+			kfree(ar);
+			break;
+		}
+
+		ar->ar_dmatable_cpu = pci_alloc_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, &ar->ar_dmatable);
+		if (!ar->ar_dmatable_cpu) {
+			kfree(ar->ar_sg_table);
+			kfree(ar);
+			break;
+		}
+
+		
+
+		/*
+		 * pheew, all done, add to list
+		 */
+		list_add_tail(&ar->ar_queue, &drive->free_req);
+	}
+
+	if (i) {
+		drive->queue_depth = i;
+		if (i >= 1) {
+			drive->using_tcq = 1;
+			drive->tcq->queued = 0;
+			drive->tcq->active_tag = -1;
+			return 0;
+		}
+
+		kfree(drive->tcq);
+		drive->tcq = NULL;
+		err = 0;
+	}
+
+	kfree(drive->tcq);
+	drive->tcq = NULL;
+	return err;
+}
+
 static int ide_check_media_change (kdev_t i_rdev)
 {
 	ide_drive_t *drive;
@@ -3156,6 +3345,9 @@
 
 			drive->channel->dmaproc(ide_dma_off_quietly, drive);
 			drive->channel->dmaproc(ide_dma_check, drive);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+			drive->channel->dmaproc(ide_dma_queued_on, drive);
+#endif /* CONFIG_BLK_DEV_IDE_TCQ_DEFAULT */
 		}
 		/* Only CD-ROMs and tape drives support DSC overlap. */
 		drive->dsc_overlap = (drive->next != drive
diff -urN linux-2.5.8-pre2/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.8-pre2/drivers/ide/pdc202xx.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/pdc202xx.c	Tue Apr  9 21:12:13 2002
@@ -1057,6 +1057,12 @@
 		case ide_dma_timeout:
 			if (drive->channel->resetproc != NULL)
 				drive->channel->resetproc(drive);
+		/*
+		 * we cannot support queued operations on promise, so fail to
+		 * to enable it...
+		 */
+		case ide_dma_queued_on:
+			return 1;
 		default:
 			break;
 	}
diff -urN linux-2.5.8-pre2/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.8-pre2/include/linux/hdreg.h	Mon Apr  8 21:12:46 2002
+++ linux/include/linux/hdreg.h	Tue Apr  9 21:12:13 2002
@@ -34,6 +34,7 @@
 #define ECC_STAT		0x04	/* Corrected error */
 #define DRQ_STAT		0x08
 #define SEEK_STAT		0x10
+#define SERVICE_STAT		SEEK_STAT
 #define WRERR_STAT		0x20
 #define READY_STAT		0x40
 #define BUSY_STAT		0x80
@@ -50,6 +51,13 @@
 #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
 
 /*
+ * bits of NSECTOR reg
+ */
+#define NSEC_CD			0x1
+#define NSEC_IO			0x2
+#define NSEC_REL		0x4
+
+/*
  * Command Header sizes for IOCTL commands
  *	HDIO_DRIVE_CMD and HDIO_DRIVE_TASK
  */
diff -urN linux-2.5.8-pre2/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8-pre2/include/linux/ide.h	Wed Apr 10 01:45:01 2002
+++ linux/include/linux/ide.h	Wed Apr 10 01:01:22 2002
@@ -114,10 +114,13 @@
 #define GET_STAT()		IN_BYTE(IDE_STATUS_REG)
 #define GET_ALTSTAT()		IN_BYTE(IDE_CONTROL_REG)
 #define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
+
 #define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
+
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
 #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
+
 #define DRIVE_READY		(READY_STAT  | SEEK_STAT)
 #define DATA_READY		(DRQ_STAT)
 
@@ -270,6 +273,37 @@
 	} b;
 } special_t;
 
+#define IDE_MAX_TAG	32		/* spec says 32 max */
+
+struct ata_request;
+typedef struct ide_tag_info_s {
+	unsigned long tag_mask;			/* next tag bit mask */
+	struct ata_request *ar[IDE_MAX_TAG];	/* in-progress requests */
+	int active_tag;				/* current active tag */
+	int queued;				/* current depth */
+
+	/*
+	 * stats ->
+	 */
+	int max_depth;				/* max depth ever */
+	int max_last_depth;			/* max since last check */
+
+	/*
+	 * Either the command completed immediately after being started
+	 * (immed_comp), or the device did a bus release before dma was
+	 * started (immed_rel).
+	 */
+	int immed_rel;
+	int immed_comp;
+} ide_tag_info_t;
+
+#define IDE_GET_AR(drive, tag)	((drive)->tcq->ar[(tag)])
+#define IDE_CUR_TAG(drive)	(IDE_GET_AR((drive), (drive)->tcq->active_tag))
+#define IDE_SET_CUR_TAG(drive, tag)	((drive)->tcq->active_tag = (tag))
+
+#define IDE_CUR_AR(drive)	\
+	((drive)->using_tcq ? IDE_CUR_TAG((drive)) : HWGROUP((drive))->rq->special)
+
 struct ide_settings_s;
 
 typedef struct ide_drive_s {
@@ -284,6 +318,8 @@
 	 */
 	request_queue_t	queue;	/* per device request queue */
 
+	struct list_head free_req; /* free ata requests */
+
 	struct ide_drive_s	*next;	/* circular list of hwgroup drives */
 
 	/* Those are directly injected jiffie values. They should go away and
@@ -298,6 +334,7 @@
 	special_t	special;	/* special action flags */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
+	byte	 using_tcq;		/* disk is using queued dma operations*/
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     unmask;		/* flag: okay to unmask other irqs */
@@ -349,7 +386,7 @@
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 
-	char		name[4];	/* drive name, such as "hda" */
+	char		name[6];	/* drive name, such as "hda" */
 	struct ata_operations *driver;
 
 	void		*driver_data;	/* extra driver data */
@@ -373,6 +410,8 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct device	device;		/* global device tree handle */
+	unsigned int	queue_depth;
+	ide_tag_info_t	*tcq;
 } ide_drive_t;
 
 /*
@@ -391,7 +430,10 @@
 		ide_dma_off,	ide_dma_off_quietly,	ide_dma_test_irq,
 		ide_dma_bad_drive,			ide_dma_good_drive,
 		ide_dma_verbose,			ide_dma_retune,
-		ide_dma_lostirq,			ide_dma_timeout
+		ide_dma_lostirq,			ide_dma_timeout,
+		ide_dma_read_queued,			ide_dma_write_queued,
+		ide_dma_queued_start,			ide_dma_queued_on,
+		ide_dma_queued_off,
 } ide_dma_action_t;
 
 typedef int (ide_dmaproc_t)(ide_dma_action_t, ide_drive_t *);
@@ -466,11 +508,6 @@
 	ide_rw_proc_t	*rwproc;	/* adjust timing based upon rq->cmd direction */
 	ide_ideproc_t   *ideproc;       /* CPU-polled transfer routine */
 	ide_dmaproc_t	*dmaproc;	/* dma read/write/abort routine */
-	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
-	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
-	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
-	int sg_nents;			/* Current number of entries in it */
-	int sg_dma_direction;		/* dma transfer direction */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned	dma_extra;	/* extra addr for dma ports */
 	unsigned long	config_data;	/* for use by chipset-specific code */
@@ -530,21 +567,19 @@
 #define IDE_DMA		2	/* DMA in progress */
 
 typedef struct hwgroup_s {
-	ide_handler_t		*handler;/* irq handler, if active */
-	unsigned long		flags;	/* BUSY, SLEEPING */
-	ide_drive_t		*drive;	/* current drive */
-	struct ata_channel	*hwif;	/* ptr to current hwif in linked-list */
+	ide_handler_t		*handler;	/* irq handler, if active */
+	unsigned long		flags;		/* BUSY, SLEEPING */
+	ide_drive_t		*drive;		/* current drive */
+	struct ata_channel	*hwif;		/* ptr to current hwif in linked-list */
 
-	struct request		*rq;	/* current request */
+	struct request		*rq;		/* current request */
 
-	struct timer_list	timer;	/* failsafe timer */
-	struct request		wrq;	/* local copy of current write rq */
+	struct timer_list	timer;		/* failsafe timer */
+	struct request		wrq;		/* local copy of current write rq */
 	unsigned long		poll_timeout;	/* timeout value during long polls */
 	ide_expiry_t		*expiry;	/* queried upon timeouts */
 } ide_hwgroup_t;
 
-/* structure attached to the request for IDE_TASK_CMDS */
-
 /*
  * configurable drive settings
  */
@@ -617,7 +652,7 @@
 	return len;			\
 }
 #else
-#define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
+# define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 #endif
 
 /*
@@ -681,6 +716,7 @@
 
 extern int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs);
 extern int ide_end_request(ide_drive_t *drive, int uptodate);
+extern void ide_end_queued_request(ide_drive_t *drive, int, struct request *);
 
 /*
  * This is used on exit from the driver, to designate the next irq handler
@@ -703,7 +739,7 @@
  * Issue a simple drive command
  * The drive must be selected beforehand.
  */
-void ide_cmd (ide_drive_t *drive, byte cmd, byte nsect, ide_handler_t *handler);
+void ide_cmd(ide_drive_t *drive, byte cmd, byte nsect, ide_handler_t *handler);
 
 /*
  * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
@@ -711,7 +747,7 @@
  * It is primarily used to tidy up the model name/number fields as
  * returned by the WIN_[P]IDENTIFY commands.
  */
-void ide_fixstring (byte *s, const int bytecount, const int byteswap);
+void ide_fixstring(byte *s, const int bytecount, const int byteswap);
 
 /*
  * This routine busy-waits for the drive status to be not "busy".
@@ -721,31 +757,32 @@
  * caller should return the updated value of "startstop" in this case.
  * "startstop" is unchanged when the function returns 0;
  */
-int ide_wait_stat (ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout);
+int ide_wait_stat(ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout);
 
-int ide_wait_noerr (ide_drive_t *drive, byte good, byte bad, unsigned long timeout);
+int ide_wait_noerr(ide_drive_t *drive, byte good, byte bad, unsigned long timeout);
 
 /*
  * This routine is called from the partition-table code in genhd.c
  * to "convert" a drive to a logical geometry with fewer than 1024 cyls.
  */
-int ide_xlate_1024 (kdev_t, int, int, const char *);
+int ide_xlate_1024(kdev_t, int, int, const char *);
 
 /*
  * Convert kdev_t structure into ide_drive_t * one.
  */
-ide_drive_t *get_info_ptr (kdev_t i_rdev);
+ide_drive_t *get_info_ptr(kdev_t i_rdev);
 
 /*
  * Re-Start an operation for an IDE interface.
  * The caller should return immediately after invoking this.
  */
-ide_startstop_t restart_request (ide_drive_t *);
+ide_startstop_t restart_request(ide_drive_t *);
 
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-extern void ide_init_drive_cmd (struct request *rq);
+extern void ide_init_drive_cmd(struct request *rq);
+extern void init_taskfile_request(struct request *rq);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -775,8 +812,33 @@
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
+	struct ata_request	*ar;
 };
 
+/*
+ * Merge this with the above struct soon.
+ */
+struct ata_request {
+	struct request		*ar_rq;		/* real request */
+	struct ide_drive_s	*ar_drive;	/* associated drive */
+	unsigned long		ar_flags;	/* ATA_AR_* flags */
+	int			ar_tag;		/* tag number, if any */
+	struct list_head	ar_queue;	/* pending list */
+	struct ata_taskfile	ar_task;	/* associated taskfile */
+	unsigned long		ar_time;
+
+	/* DMA stuff, PCI layer */
+	struct scatterlist	*ar_sg_table;
+	int			ar_sg_nents;
+	int			ar_sg_ddir;
+
+	/* CPU related DMA stuff  */
+	unsigned int		*ar_dmatable_cpu;
+	dma_addr_t		ar_dmatable;
+};
+
+#define AR_TASK_CMD(ar)	((ar)->ar_task.taskfile.command)
+
 void ata_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 void ata_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 void atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount);
@@ -879,22 +941,24 @@
 extern int ide_unregister_subdriver(ide_drive_t *drive);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-#define ON_BOARD		1
-#define NEVER_BOARD		0
-#ifdef CONFIG_BLK_DEV_OFFBOARD
-# define OFF_BOARD		ON_BOARD
-#else
-# define OFF_BOARD		NEVER_BOARD
-#endif
+# define ON_BOARD		1
+# define NEVER_BOARD		0
+# ifdef CONFIG_BLK_DEV_OFFBOARD
+#  define OFF_BOARD		ON_BOARD
+# else
+#  define OFF_BOARD		NEVER_BOARD
+# endif
 
-void __init ide_scan_pcibus(int scan_direction);
+/* FIXME: This should go away possible. */
+extern void __init ide_scan_pcibus(int scan_direction);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDMA
-int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func);
-void ide_destroy_dmatable (ide_drive_t *drive);
-ide_startstop_t ide_dma_intr (ide_drive_t *drive);
-int check_drive_lists (ide_drive_t *drive, int good_bad);
-int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
+extern int ide_build_dmatable(ide_drive_t *drive, struct request *rq, ide_dma_action_t func);
+extern void ide_destroy_dmatable(ide_drive_t *drive);
+extern int ide_start_dma(struct ata_channel *, ide_drive_t *, ide_dma_action_t);
+extern ide_startstop_t ide_dma_intr(ide_drive_t *drive);
+extern int check_drive_lists(ide_drive_t *drive, int good_bad);
+extern int ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive);
 extern void ide_release_dma(struct ata_channel *hwif);
 extern void ide_setup_dma(struct ata_channel *hwif,
 		unsigned long dmabase, unsigned int num_ports) __init;
@@ -907,4 +971,88 @@
 extern int drive_is_ready(ide_drive_t *drive);
 extern void revalidate_drives(void);
 
-#endif /* _IDE_H */
+/*
+ * Tagged Command Queueing:
+ */
+
+/*
+ * ata_request flag bits
+ */
+#define ATA_AR_QUEUED	1
+#define ATA_AR_SETUP	2
+#define ATA_AR_RETURN	4
+
+#define list_ata_entry(entry) list_entry((entry), struct ata_request, ar_queue)
+
+static inline void ata_ar_init(ide_drive_t *drive, struct ata_request *ar)
+{
+	ar->ar_rq = NULL;
+	ar->ar_drive = drive;
+	ar->ar_flags = 0;
+	ar->ar_tag = 0;
+	memset(&ar->ar_task, 0, sizeof(ar->ar_task));
+	ar->ar_sg_nents = 0;
+	ar->ar_sg_ddir = 0;
+}
+
+/*
+ * Return a free command, automatically add it to busy list.
+ */
+static inline struct ata_request *ata_ar_get(ide_drive_t *drive)
+{
+	struct ata_request *ar = NULL;
+
+	if (drive->tcq && drive->tcq->queued >= drive->queue_depth)
+		return NULL;
+
+	if (!list_empty(&drive->free_req)) {
+		ar = list_ata_entry(drive->free_req.next);
+		list_del(&ar->ar_queue);
+		ata_ar_init(drive, ar);
+	}
+
+	return ar;
+}
+
+static inline void ata_ar_put(ide_drive_t *drive, struct ata_request *ar)
+{
+	list_add(&ar->ar_queue, &drive->free_req);
+
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		/* clear the tag */
+		drive->tcq->ar[ar->ar_tag] = NULL;
+		__clear_bit(ar->ar_tag, &drive->tcq->tag_mask);
+		drive->tcq->queued--;
+	}
+
+	ar->ar_rq = NULL;
+}
+
+extern inline int ide_get_tag(ide_drive_t *drive)
+{
+	int tag = ffz(drive->tcq->tag_mask);
+
+	BUG_ON(drive->tcq->tag_mask == 0xffffffff);
+
+	__set_bit(tag, &drive->tcq->tag_mask);
+
+	if (tag + 1 > drive->tcq->max_depth)
+		drive->tcq->max_depth = tag + 1;
+	if (tag + 1 > drive->tcq->max_last_depth)
+		drive->tcq->max_last_depth = tag + 1;
+
+	return tag;
+}
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+# define ide_pending_commands(drive)	((drive)->using_tcq && (drive)->tcq->queued)
+#else
+# define ide_pending_commands(drive)	0
+#endif
+
+int ide_build_commandlist(ide_drive_t *);
+void ide_teardown_commandlist(ide_drive_t *);
+int ide_tcq_dmaproc(ide_dma_action_t, ide_drive_t *);
+ide_startstop_t ide_start_tag(ide_dma_action_t, ide_drive_t *, struct ata_request *);
+
+#endif

--------------090807040403060105090506--

