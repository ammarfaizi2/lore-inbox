Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSECLHR>; Fri, 3 May 2002 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSECLHQ>; Fri, 3 May 2002 07:07:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29449 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315629AbSECLG7>;
	Fri, 3 May 2002 07:06:59 -0400
Date: Fri, 3 May 2002 13:06:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux IDE <linux-ide@vger.kernel.org>
Subject: [PATCH] IDE TCQ #2
Message-ID: <20020503110652.GF839@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.13 now has the generic tag support that I wrote included, here's an
IDE TCQ that uses that. Changes since the version posted for 2.5.12:

- Fix the ide_tcq_invalidate_queue() WIN_NOP usage needed to clear the
  internal queue on errors. It was disabled in the last version due to
  the ata_request changes, it should work now.

- Remove Promise tcq disable check, it works just fine on Promise as
  long as we handle the two-drives-with-tcq case like we currently do.

That's about it, code should be solid.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.514   -> 1.515  
#	drivers/ide/ide-probe.c	1.42    -> 1.43   
#	drivers/ide/ide-disk.c	1.42    -> 1.43   
#	drivers/ide/ide-dma.c	1.34    -> 1.35   
#	 include/linux/ide.h	1.51    -> 1.52   
#	   drivers/ide/ide.c	1.71    -> 1.72   
#	drivers/ide/ide-taskfile.c	1.28    -> 1.29   
#	drivers/ide/Makefile	1.14    -> 1.15   
#	drivers/ide/Config.help	1.15    -> 1.16   
#	drivers/ide/Config.in	1.18    -> 1.19   
#	               (new)	        -> 1.1     drivers/ide/ide-tcq.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/03	axboe@burns.home.kernel.dk	1.515
# IDE TCQ support
# --------------------------------------------
#
diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Fri May  3 13:01:45 2002
+++ b/drivers/ide/Config.help	Fri May  3 13:01:45 2002
@@ -751,6 +751,37 @@
 
   Generally say N here.
 
+CONFIG_BLK_DEV_IDE_TCQ
+  Support for tagged command queueing on ATA disk drives. This enables
+  the IDE layer to have multiple in-flight requests on hardware that
+  supports it. For now this includes the IBM Deskstar series drives,
+  such as the 22GXP, 75GXP, 40GV, 60GXP, and 120GXP (ie any Deskstar made
+  in the last couple of years), and at least some of the Western
+  Digital drives in the Expert series (by nature of really being IBM
+  drives).
+
+  If you have such a drive, say Y here.
+
+CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+  Maximum size of commands to enable per-drive. Any value between 1
+  and 32 is valid, with 32 being the maxium that the hardware supports.
+
+  You probably just want the default of 32 here. If you enter an invalid
+  number, the default value will be used.
+
+CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+  Enabled tagged command queueing unconditionally on drives that report
+  support for it. Regardless of the chosen value here, tagging can be
+  controlled at run time:
+
+  echo "using_tcq:32" > /proc/ide/hdX/settings
+
+  where any value between 1-32 selects chosen queue depth and enables
+  TCQ, and 0 disables it. hdparm version 4.7 an above also support
+  TCQ manipulations.
+
+  Generally say Y here.
+
 CONFIG_BLK_DEV_IT8172
   Say Y here to support the on-board IDE controller on the Integrated
   Technology Express, Inc. ITE8172 SBC.  Vendor page at
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Fri May  3 13:01:45 2002
+++ b/drivers/ide/Config.in	Fri May  3 13:01:45 2002
@@ -47,6 +47,11 @@
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	 if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
+	    int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
+	 fi
 	 dep_bool '    Good-Bad DMA Model-Firmware (EXPERIMENTAL)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_EXPERIMENTAL
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
diff -Nru a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	Fri May  3 13:01:45 2002
+++ b/drivers/ide/Makefile	Fri May  3 13:01:45 2002
@@ -44,6 +44,7 @@
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ide-pmac.o
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Fri May  3 13:01:45 2002
+++ b/drivers/ide/ide-disk.c	Fri May  3 13:01:45 2002
@@ -98,6 +98,8 @@
 
 	if (lba48bit) {
 		if (cmd == READ) {
+			if (drive->using_tcq)
+				return WIN_READDMA_QUEUED_EXT;
 			if (drive->using_dma)
 				return WIN_READDMA_EXT;
 			else if (drive->mult_count)
@@ -105,6 +107,8 @@
 			else
 				return WIN_READ_EXT;
 		} else if (cmd == WRITE) {
+			if (drive->using_tcq)
+				return WIN_WRITEDMA_QUEUED_EXT;
 			if (drive->using_dma)
 				return WIN_WRITEDMA_EXT;
 			else if (drive->mult_count)
@@ -114,6 +118,8 @@
 		}
 	} else {
 		if (cmd == READ) {
+			if (drive->using_tcq)
+				return WIN_READDMA_QUEUED;
 			if (drive->using_dma)
 				return WIN_READDMA;
 			else if (drive->mult_count)
@@ -121,6 +127,8 @@
 			else
 				return WIN_READ;
 		} else if (cmd == WRITE) {
+			if (drive->using_tcq)
+				return WIN_WRITEDMA_QUEUED;
 			if (drive->using_dma)
 				return WIN_WRITEDMA;
 			else if (drive->mult_count)
@@ -148,7 +156,11 @@
 
 	memset(&args, 0, sizeof(args));
 
-	args.taskfile.sector_count = sectors;
+	if (blk_rq_tagged(rq)) {
+		args.taskfile.feature = sectors;
+		args.taskfile.sector_count = rq->tag << 3;
+	} else
+		args.taskfile.sector_count = sectors;
 
 	args.taskfile.sector_number = sect;
 	args.taskfile.low_cylinder = cyl;
@@ -184,7 +196,12 @@
 
 	memset(&args, 0, sizeof(args));
 
-	args.taskfile.sector_count = sectors;
+	if (blk_rq_tagged(rq)) {
+		args.taskfile.feature = sectors;
+		args.taskfile.sector_count = rq->tag << 3;
+	} else
+		args.taskfile.sector_count = sectors;
+
 	args.taskfile.sector_number = block;
 	args.taskfile.low_cylinder = (block >>= 8);
 
@@ -226,8 +243,14 @@
 
 	memset(&args, 0, sizeof(args));
 
-	args.taskfile.sector_count = sectors;
-	args.hobfile.sector_count = sectors >> 8;
+	if (blk_rq_tagged(rq)) {
+		args.taskfile.feature = sectors;
+		args.hobfile.feature = sectors >> 8;
+		args.taskfile.sector_count = rq->tag << 3;
+	} else {
+		args.taskfile.sector_count = sectors;
+		args.hobfile.sector_count = sectors >> 8;
+	}
 
 	args.taskfile.sector_number = block;		/* low lba */
 	args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
@@ -285,6 +308,30 @@
 		return promise_rw_disk(drive, rq, block);
 	}
 
+	/*
+	 * start a tagged operation
+	 */
+	if (drive->using_tcq) {
+		unsigned long flags;
+		int ret;
+
+		spin_lock_irqsave(&ide_lock, flags);
+
+		ret = blk_queue_start_tag(&drive->queue, rq);
+
+		if (ata_pending_commands(drive) > drive->max_depth)
+			drive->max_depth = ata_pending_commands(drive);
+		if (ata_pending_commands(drive) > drive->max_last_depth)
+			drive->max_last_depth = ata_pending_commands(drive);
+
+		spin_unlock_irqrestore(&ide_lock, flags);
+
+		if (ret) {
+			BUG_ON(!ata_pending_commands(drive));
+			return ide_started;
+		}
+	}
+
 	/* 48-bit LBA */
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
 		return lba48_do_request(drive, rq, block);
@@ -542,11 +589,61 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int proc_idedisk_read_tcq
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *) data;
+	char		*out = page;
+	int		len, cmds, i;
+	unsigned long	flags;
+
+	if (!blk_queue_tagged(&drive->queue)) {
+		len = sprintf(out, "not configured\n");
+		PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	}
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	len = sprintf(out, "TCQ currently on:\t%s\n", drive->using_tcq ? "yes" : "no");
+	len += sprintf(out+len, "Max queue depth:\t%d\n",drive->queue_depth);
+	len += sprintf(out+len, "Max achieved depth:\t%d\n",drive->max_depth);
+	len += sprintf(out+len, "Max depth since last:\t%d\n",drive->max_last_depth);
+	len += sprintf(out+len, "Current depth:\t\t%d\n", ata_pending_commands(drive));
+	len += sprintf(out+len, "Active tags:\t\t[ ");
+	for (i = 0, cmds = 0; i < drive->queue_depth; i++) {
+		struct request *rq = blk_queue_tag_request(&drive->queue, i);
+
+		if (!rq)
+			continue;
+
+		len += sprintf(out+len, "%d, ", i);
+		cmds++;
+	}
+	len += sprintf(out+len, "]\n");
+
+	len += sprintf(out+len, "Queue:\t\t\treleased [ %lu ] - started [ %lu ]\n", drive->immed_rel, drive->immed_comp);
+
+	if (ata_pending_commands(drive) != cmds)
+		len += sprintf(out+len, "pending request and queue count mismatch (counted: %d)\n", cmds);
+
+	len += sprintf(out+len, "DMA status:\t\t%srunning\n", test_bit(IDE_DMA, &HWGROUP(drive)->flags) ? "" : "not ");
+
+	drive->max_last_depth = 0;
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
+	{ "tcq",		S_IFREG|S_IRUSR,	proc_idedisk_read_tcq,			NULL },
+#endif
 	{ NULL, 0, NULL, NULL }
 };
 
@@ -633,6 +730,32 @@
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int set_using_tcq(ide_drive_t *drive, int arg)
+{
+	if (!drive->driver)
+		return -EPERM;
+	if (!drive->channel->udma)
+		return -EPERM;
+	if (arg == drive->queue_depth && drive->using_tcq)
+		return 0;
+
+	/*
+	 * set depth, but check also id for max supported depth
+	 */
+	drive->queue_depth = arg ? arg : 1;
+	if (drive->id) {
+		if (drive->queue_depth > drive->id->queue_depth + 1)
+			drive->queue_depth = drive->id->queue_depth + 1;
+	}
+
+	if (drive->channel->udma(arg ? ide_dma_queued_on : ide_dma_queued_off, drive, NULL))
+		return -EIO;
+
+	return 0;
+}
+#endif
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -664,6 +787,9 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
 	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
+#endif
 }
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Fri May  3 13:01:45 2002
+++ b/drivers/ide/ide-dma.c	Fri May  3 13:01:45 2002
@@ -522,6 +522,32 @@
 	blk_queue_bounce_limit(&drive->queue, addr);
 }
 
+int ide_start_dma(ide_dma_action_t func, struct ata_device *drive)
+{
+	struct ata_channel *hwif = drive->channel;
+	unsigned long dma_base = hwif->dma_base;
+	unsigned int reading = 0;
+
+	if (rq_data_dir(HWGROUP(drive)->rq) == READ)
+		reading = 1 << 3;
+
+	/* active tuning based on IO direction */
+	if (hwif->rwproc)
+		hwif->rwproc(drive, func);
+
+	/*
+	 * try PIO instead of DMA
+	 */
+	if (!ide_build_dmatable(drive, func))
+		return 1;
+
+	outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+	drive->waiting_for_dma = 1;
+	return 0;
+}
+
 /*
  * This initiates/aborts DMA read/write operations on a drive.
  *
@@ -543,7 +569,7 @@
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
 	byte unit = (drive->select.b.unit & 0x01);
-	unsigned int count, reading = 0, set_high = 1;
+	unsigned int reading = 0, set_high = 1;
 	byte dma_stat;
 
 	switch (func) {
@@ -552,27 +578,27 @@
 		case ide_dma_off_quietly:
 			set_high = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+			hwif->udma(ide_dma_queued_off, drive, rq);
+#endif
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
 			drive->using_dma = (func == ide_dma_on);
-			if (drive->using_dma)
+			if (drive->using_dma) {
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+				hwif->udma(ide_dma_queued_on, drive, rq);
+#endif
+			}
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
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
+			if (ide_start_dma(func, drive))
+				return 1;
+
 			if (drive->type != ATA_DISK)
 				return 0;
 
@@ -587,6 +613,14 @@
 				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			}
 			return drive->channel->udma(ide_dma_begin, drive, NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		case ide_dma_queued_on:
+		case ide_dma_queued_off:
+		case ide_dma_read_queued:
+		case ide_dma_write_queued:
+		case ide_dma_queued_start:
+			return ide_tcq_dmaproc(func, drive, rq);
+#endif
 		case ide_dma_begin:
 			/* Note that this is done *after* the cmd has
 			 * been issued to the drive, as per the BM-IDE spec.
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Fri May  3 13:01:45 2002
+++ b/drivers/ide/ide-probe.c	Fri May  3 13:01:45 2002
@@ -198,6 +198,16 @@
 	if (drive->channel->quirkproc)
 		drive->quirk_list = drive->channel->quirkproc(drive);
 
+	/* Initialize queue depth settings */
+	drive->queue_depth = 1;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+	drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
+#else
+	drive->queue_depth = drive->id->queue_depth + 1;
+#endif
+	if (drive->queue_depth < 1 || drive->queue_depth > IDE_MAX_TAG)
+		drive->queue_depth = IDE_MAX_TAG;
+
 	return;
 
 err_misc:
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Fri May  3 13:01:45 2002
+++ b/drivers/ide/ide-taskfile.c	Fri May  3 13:01:45 2002
@@ -456,11 +456,39 @@
 		if (args->prehandler != NULL)
 			return args->prehandler(drive, rq);
 	} else {
-		/* for dma commands we down set the handler */
-		if (drive->using_dma &&
-		!(drive->channel->udma(((args->taskfile.command == WIN_WRITEDMA)
-					|| (args->taskfile.command == WIN_WRITEDMA_EXT))
-					? ide_dma_write : ide_dma_read, drive, rq)));
+		ide_dma_action_t dma_act;
+		int tcq = 0;
+
+		if (!drive->using_dma)
+			return ide_started;
+
+		/* for dma commands we don't set the handler */
+		if (args->taskfile.command == WIN_WRITEDMA || args->taskfile.command == WIN_WRITEDMA_EXT)
+			dma_act = ide_dma_write;
+		else if (args->taskfile.command == WIN_READDMA || args->taskfile.command == WIN_READDMA_EXT)
+			dma_act = ide_dma_read;
+		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT) {
+			tcq = 1;
+			dma_act = ide_dma_write_queued;
+		} else if (args->taskfile.command == WIN_READDMA_QUEUED || args->taskfile.command == WIN_READDMA_QUEUED_EXT) {
+			tcq = 1;
+			dma_act = ide_dma_read_queued;
+		} else {
+			printk("ata_taskfile: unknown command %x\n", args->taskfile.command);
+			return ide_stopped;
+		}
+
+		/*
+		 * FIXME: this is a gross hack, need to unify tcq dma proc and
+		 * regular dma proc -- basically split stuff that needs to act
+		 * on a request from things like ide_dma_check etc.
+		 */
+		if (tcq)
+			return drive->channel->udma(dma_act, drive, rq);
+		else {
+			if (drive->channel->udma(dma_act, drive, rq))
+				return ide_stopped;
+		}
 	}
 
 	return ide_started;
@@ -523,7 +551,7 @@
 	ide__sti();	/* local CPU only */
 
 	if (!OK_STAT(stat = GET_STAT(), READY_STAT, BAD_STAT)) {
-		/* Keep quite for NOP becouse they are expected to fail. */
+		/* Keep quiet for NOP because it is expected to fail. */
 		if (args && args->taskfile.command != WIN_NOP)
 			return ide_error(drive, "task_no_data_intr", stat);
 	}
diff -Nru a/drivers/ide/ide-tcq.c b/drivers/ide/ide-tcq.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/ide/ide-tcq.c	Fri May  3 13:01:45 2002
@@ -0,0 +1,638 @@
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
+ * warning: it will be _very_ verbose if defined
+ */
+#undef IDE_TCQ_DEBUG
+
+#ifdef IDE_TCQ_DEBUG
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
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive, struct request *rq);
+ide_startstop_t ide_service(ide_drive_t *drive);
+
+static inline void drive_ctl_nien(ide_drive_t *drive, int set)
+{
+#ifdef IDE_TCQ_NIEN
+	if (IDE_CONTROL_REG) {
+		int mask = set ? 0x02 : 0x00;
+
+		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
+	}
+#endif
+}
+
+static ide_startstop_t ide_tcq_nop_handler(struct ata_device *drive, struct request *rq)
+{
+	struct ata_taskfile *args = rq->special;
+
+	ide__sti();
+	ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+	kfree(args);
+	return ide_stopped;
+}
+
+/*
+ * if we encounter _any_ error doing I/O to one of the tags, we must
+ * invalidate the pending queue. clear the software busy queue and requeue
+ * on the request queue for restart. issue a WIN_NOP to clear hardware queue
+ */
+static void ide_tcq_invalidate_queue(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	request_queue_t *q = &drive->queue;
+	struct ata_taskfile *args;
+	struct request *rq;
+	unsigned long flags;
+
+	printk("%s: invalidating pending queue (%d)\n", drive->name, ata_pending_commands(drive));
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	del_timer(&hwgroup->timer);
+
+	if (test_bit(IDE_DMA, &hwgroup->flags))
+		drive->channel->udma(ide_dma_end, drive, hwgroup->rq);
+
+	blk_queue_invalidate_tags(q);
+
+	drive->using_tcq = 0;
+	drive->queue_depth = 1;
+	clear_bit(IDE_BUSY, &hwgroup->flags);
+	clear_bit(IDE_DMA, &hwgroup->flags);
+	hwgroup->handler = NULL;
+
+	/*
+	 * do some internal stuff -- we really need this command to be
+	 * executed before any new commands are started. issue a NOP
+	 * to clear internal queue on drive
+	 */
+	args = kmalloc(sizeof(*args), GFP_ATOMIC);
+	if (!args) {
+		printk("%s: failed to issue NOP\n", drive->name);
+		goto out;
+	}
+	
+	rq = blk_get_request(&drive->queue, READ, GFP_ATOMIC);
+	if (!rq)
+		rq = blk_get_request(&drive->queue, WRITE, GFP_ATOMIC);
+
+	/*
+	 * blk_queue_invalidate_tags() just added back at least one command
+	 * to the free list, so there _must_ be at least one free
+	 */
+	BUG_ON(!rq);
+
+	rq->special = args;
+	args->taskfile.command = WIN_NOP;
+	args->handler = ide_tcq_nop_handler;
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+
+	rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
+	_elv_add_request(q, rq, 0, 0);
+
+	/*
+	 * make sure that nIEN is cleared
+	 */
+out:
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
+	ide_drive_t *drive = (ide_drive_t *) data;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	unsigned long flags;
+
+	printk("ide_tcq_intr_timeout: timeout waiting for interrupt...\n");
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if (test_and_set_bit(IDE_BUSY, &hwgroup->flags))
+		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
+	if (hwgroup->handler == NULL)
+		printk("ide_tcq_intr_timeout: missing isr!\n");
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	/*
+	 * if pending commands, try service before giving up
+	 */
+	if (ata_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
+		if (ide_service(drive) == ide_started)
+			return;
+
+	if (drive)
+		ide_tcq_invalidate_queue(drive);
+}
+
+void ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ata_handler_t *handler)
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
+	hwgroup->timer.data = (unsigned long) hwgroup->XXX_drive;
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
+	int i = 0;
+
+	udelay(1);
+
+	while ((*stat = GET_ALTSTAT()) & busy_mask) {
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	}
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
+	struct request *rq;
+	byte feat, stat;
+	int tag;
+
+	TCQ_PRINTK("%s: started service\n", drive->name);
+
+	/*
+	 * could be called with IDE_DMA in-progress from invalidate
+	 * handler, refuse to do anything
+	 */
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		return ide_stopped;
+
+	/*
+	 * need to select the right drive first...
+	 */
+	if (drive != HWGROUP(drive)->XXX_drive) {
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
+		ide_dump_status(drive, "ide_service", stat);
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
+		ide_dump_status(drive, "ide_service", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	/*
+	 * should not happen, a buggy device could introduce loop
+	 */
+	if ((feat = GET_FEAT()) & NSEC_REL) {
+		HWGROUP(drive)->rq = NULL;
+		printk("%s: release in service\n", drive->name);
+		return ide_stopped;
+	}
+
+	tag = feat >> 3;
+
+	TCQ_PRINTK("ide_service: stat %x, feat %x\n", stat, feat);
+
+	rq = blk_queue_tag_request(&drive->queue, tag);
+	if (!rq) {
+		printk("ide_service: missing request for tag %d\n", tag);
+		return ide_stopped;
+	}
+
+	HWGROUP(drive)->rq = rq;
+
+	/*
+	 * we'll start a dma read or write, device will trigger
+	 * interrupt to indicate end of transfer, release is not allowed
+	 */
+	TCQ_PRINTK("ide_service: starting command %x\n", stat);
+	return drive->channel->udma(ide_dma_queued_start, drive, rq);
+}
+
+ide_startstop_t ide_check_service(ide_drive_t *drive)
+{
+	byte stat;
+
+	TCQ_PRINTK("%s: ide_check_service\n", drive->name);
+
+	if (!ata_pending_commands(drive))
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
+ide_startstop_t ide_dmaq_complete(ide_drive_t *drive, struct request *rq, byte stat)
+{
+	byte dma_stat;
+
+	/*
+	 * transfer was in progress, stop DMA engine
+	 */
+	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
+
+	/*
+	 * must be end of I/O, check status and complete as necessary
+	 */
+	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
+		printk("ide_dmaq_intr: %s: error status %x\n",drive->name,stat);
+		ide_dump_status(drive, "ide_dmaq_intr", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	if (dma_stat)
+		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
+
+	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", rq, rq->tag);
+	__ide_end_request(drive, rq, !dma_stat, rq->nr_sectors);
+
+	/*
+	 * we completed this command, check if we can service a new command
+	 */
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
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive, struct request *rq)
+{
+	byte stat = GET_STAT();
+
+	TCQ_PRINTK("ide_dmaq_intr: stat=%x\n", stat);
+
+	/*
+	 * if a command completion interrupt is pending, do that first and
+	 * check service afterwards
+	 */
+	if (rq)
+		return ide_dmaq_complete(drive, rq, stat);
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
+ * check if the ata adapter this drive is attached to supports the
+ * NOP auto-poll for multiple tcq enabled drives on one channel
+ */
+static int ide_tcq_check_autopoll(ide_drive_t *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	struct ata_taskfile args;
+	int drives = 0, i;
+
+	/*
+	 * only need to probe if both drives on a channel support tcq
+	 */
+	for (i = 0; i < MAX_DRIVES; i++)
+		if (drive->channel->drives[i].present &&drive->type == ATA_DISK)
+			drives++;
+
+	if (drives <= 1)
+		return 0;
+
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.feature = 0x01;
+	args.taskfile.command = WIN_NOP;
+	ide_cmd_type_parser(&args);
+
+	/*
+	 * do taskfile and check ABRT bit -- intelligent adapters will not
+	 * pass NOP with sub-code 0x01 to device, so the command will not
+	 * fail there
+	 */
+	ide_raw_taskfile(drive, &args, NULL);
+	if (args.taskfile.feature & ABRT_ERR)
+		return 1;
+
+	ch->auto_poll = 1;
+	printk("%s: NOP Auto-poll enabled\n", ch->name);
+	return 0;
+}
+
+/*
+ * configure the drive for tcq
+ */
+static int ide_tcq_configure(ide_drive_t *drive)
+{
+	int tcq_mask = 1 << 1 | 1 << 14;
+	int tcq_bits = tcq_mask | 1 << 15;
+	struct ata_taskfile args;
+
+	/*
+	 * bit 14 and 1 must be set in word 83 of the device id to indicate
+	 * support for dma queued protocol, and bit 15 must be cleared
+	 */
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
+		return -EIO;
+
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_EN_WCACHE;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
+		printk("%s: failed to enable write cache\n", drive->name);
+		return 1;
+	}
+
+	/*
+	 * disable RELease interrupt, it's quicker to poll this after
+	 * having sent the command opcode
+	 */
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_DIS_RI;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
+		printk("%s: disabling release interrupt fail\n", drive->name);
+		return 1;
+	}
+
+#ifdef IDE_TCQ_FIDDLE_SI
+	/*
+	 * enable SERVICE interrupt
+	 */
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_EN_SI;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
+		printk("%s: enabling service interrupt fail\n", drive->name);
+		return 1;
+	}
+#endif
+
+	return 0;
+}
+
+/*
+ * for now assume that command list is always as big as we need and don't
+ * attempt to shrink it on tcq disable
+ */
+static int ide_enable_queued(ide_drive_t *drive, int on)
+{
+	int depth = drive->using_tcq ? drive->queue_depth : 0;
+
+	/*
+	 * disable or adjust queue depth
+	 */
+	if (!on) {
+		if (drive->using_tcq)
+			printk("%s: TCQ disabled\n", drive->name);
+		drive->using_tcq = 0;
+		return 0;
+	}
+
+	if (ide_tcq_configure(drive)) {
+		drive->using_tcq = 0;
+		return 1;
+	}
+
+	/*
+	 * enable block tagging
+	 */
+	if (!blk_queue_tagged(&drive->queue))
+		blk_queue_init_tags(&drive->queue, IDE_MAX_TAG);
+
+	/*
+	 * check auto-poll support
+	 */
+	ide_tcq_check_autopoll(drive);
+
+	if (depth != drive->queue_depth)
+		printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
+
+	drive->using_tcq = 1;
+	return 0;
+}
+
+int ide_tcq_wait_dataphase(ide_drive_t *drive)
+{
+	byte stat;
+	int i;
+
+	while ((stat = GET_STAT()) & BUSY_STAT)
+		udelay(10);
+
+	if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
+		return 0;
+
+	i = 0;
+	udelay(1);
+	while (!OK_STAT(GET_STAT(), READY_STAT | DRQ_STAT, drive->bad_wstat)) {
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	}
+
+	return 0;
+}
+
+ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive, struct request *rq)
+{
+	struct ata_channel *hwif = drive->channel;
+	unsigned int enable_tcq = 1;
+	byte stat, feat;
+
+	switch (func) {
+		/*
+		 * invoked from a SERVICE interrupt, command etc already known.
+		 * just need to start the dma engine for this tag
+		 */
+		case ide_dma_queued_start:
+			TCQ_PRINTK("ide_dma: setting up queued %d\n", rq->tag);
+			if (!test_bit(IDE_BUSY, &HWGROUP(drive)->flags))
+				printk("queued_rw: IDE_BUSY not set\n");
+
+			if (ide_tcq_wait_dataphase(drive))
+				return ide_stopped;
+
+			if (ide_start_dma(func, drive))
+				return ide_stopped;
+
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+			if (!hwif->udma(ide_dma_begin, drive, rq))
+				return ide_started;
+
+			return ide_stopped;
+
+			/*
+			 * start a queued command from scratch
+			 */
+		case ide_dma_read_queued:
+		case ide_dma_write_queued: {
+			struct ata_taskfile *args = rq->special;
+
+			TCQ_PRINTK("%s: start tag %d\n", drive->name, rq->tag);
+
+			/*
+			 * set nIEN, tag start operation will enable again when
+			 * it is safe
+			 */
+			drive_ctl_nien(drive, 1);
+
+			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+
+			if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
+				ide_dump_status(drive, "queued start", stat);
+				ide_tcq_invalidate_queue(drive);
+				return ide_stopped;
+			}
+
+			drive_ctl_nien(drive, 0);
+
+			if (stat & ERR_STAT) {
+				ide_dump_status(drive, "tcq_start", stat);
+				return ide_stopped;
+			}
+
+			/*
+			 * drive released the bus, clear active tag and
+			 * check for service
+			 */
+			if ((feat = GET_FEAT()) & NSEC_REL) {
+				drive->immed_rel++;
+				HWGROUP(drive)->rq = NULL;
+				ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+
+				TCQ_PRINTK("REL in queued_start\n");
+
+				if ((stat = GET_STAT()) & SERVICE_STAT)
+					return ide_service(drive);
+
+				return ide_released;
+			}
+
+			TCQ_PRINTK("IMMED in queued_start\n");
+			drive->immed_comp++;
+			return hwif->udma(ide_dma_queued_start, drive, rq);
+			}
+
+		case ide_dma_queued_off:
+			enable_tcq = 0;
+		case ide_dma_queued_on:
+			if (enable_tcq && !drive->using_dma)
+				return 1;
+			return ide_enable_queued(drive, enable_tcq);
+		default:
+			break;
+	}
+
+	return 1;
+}
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Fri May  3 13:01:45 2002
+++ b/drivers/ide/ide.c	Fri May  3 13:01:45 2002
@@ -397,7 +397,10 @@
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
 		add_blkdev_randomness(major(rq->rq_dev));
-		blkdev_dequeue_request(rq);
+		if (!blk_rq_tagged(rq))
+			blkdev_dequeue_request(rq);
+		else
+			blk_queue_end_tag(&drive->queue, rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
 		ret = 0;
@@ -1305,11 +1308,6 @@
 }
 
 
-/* Place holders for later expansion of functionality.
- */
-#define ata_pending_commands(drive)	(0)
-#define ata_can_queue(drive)		(1)
-
 /*
  * Feed commands to a drive until it barfs.  Called with ide_lock/DRIVE_LOCK
  * held and busy channel.
@@ -1349,7 +1347,7 @@
 		 * still a severe BUG!
 		 */
 		if (blk_queue_plugged(&drive->queue)) {
-			BUG();
+			BUG_ON(!drive->using_tcq);
 			break;
 		}
 
@@ -1761,7 +1759,8 @@
 		} else {
 			printk("%s: %s: huh? expected NULL handler on exit\n", drive->name, __FUNCTION__);
 		}
-	}
+	} else if (startstop == ide_released)
+		queue_commands(drive, ch->irq);
 
 out_lock:
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -3290,6 +3289,9 @@
 
 			drive->channel->udma(ide_dma_off_quietly, drive, NULL);
 			drive->channel->udma(ide_dma_check, drive, NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+			drive->channel->udma(ide_dma_queued_on, drive, NULL);
+#endif
 		}
 
 		/* Only CD-ROMs and tape drives support DSC overlap.  But only
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Fri May  3 13:01:45 2002
+++ b/include/linux/ide.h	Fri May  3 13:01:45 2002
@@ -297,6 +297,7 @@
 	u8 tune_req;			/* requested drive tuning setting */
 
 	byte     using_dma;		/* disk is using dma for read/write */
+	byte	 using_tcq;		/* disk is using queueing */
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     dsc_overlap;		/* flag: DSC overlap */
@@ -359,9 +360,17 @@
 	byte		dn;		/* now wide spread use */
 	byte		wcache;		/* status of write cache */
 	byte		acoustic;	/* acoustic management */
+	byte		queue_depth;	/* max queue depth */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct device	device;		/* global device tree handle */
+	/*
+	 * tcq statistics
+	 */
+	unsigned long	immed_rel;	
+	unsigned long	immed_comp;
+	int		max_last_depth;
+	int		max_depth;
 } ide_drive_t;
 
 /*
@@ -380,7 +389,10 @@
 		ide_dma_off,	ide_dma_off_quietly,	ide_dma_test_irq,
 		ide_dma_bad_drive,			ide_dma_good_drive,
 		ide_dma_verbose,			ide_dma_retune,
-		ide_dma_lostirq,			ide_dma_timeout
+		ide_dma_lostirq,			ide_dma_timeout,
+		ide_dma_read_queued,			ide_dma_write_queued,
+		ide_dma_queued_start,			ide_dma_queued_on,
+		ide_dma_queued_off,
 } ide_dma_action_t;
 
 enum {
@@ -461,6 +473,7 @@
 	unsigned highmem	: 1;	/* can do full 32-bit dma */
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
+	unsigned auto_poll	: 1;	/* supports nop auto-poll */
 	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	byte		unmask;		/* flag: okay to unmask other irqs */
 	byte		slow;		/* flag: slow data port */
@@ -500,6 +513,29 @@
 #define IDE_SLEEP	1
 #define IDE_DMA		2	/* DMA in progress */
 
+#define IDE_MAX_TAG	32
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static inline int ata_pending_commands(ide_drive_t *drive)
+{
+	if (drive->using_tcq)
+		return blk_queue_tag_depth(&drive->queue);
+
+	return 0;
+}
+
+static inline int ata_can_queue(ide_drive_t *drive)
+{
+	if (drive->using_tcq)
+		return blk_queue_tag_queue(&drive->queue);
+
+	return 1;
+}
+#else
+#define ata_pending_commands(drive)	(0)
+#define ata_can_queue(drive)		(1)
+#endif
+
 typedef struct hwgroup_s {
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
 	unsigned long flags;		/* BUSY, SLEEPING */
@@ -858,9 +894,11 @@
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 int check_drive_lists (ide_drive_t *drive, int good_bad);
 int ide_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *);
+ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *);
 extern void ide_release_dma(struct ata_channel *hwif);
 extern void ide_setup_dma(struct ata_channel *hwif,
 		unsigned long dmabase, unsigned int num_ports) __init;
+extern int ide_start_dma(ide_dma_action_t func, struct ata_device *drive);
 #endif
 
 extern spinlock_t ide_lock;

-- 
Jens Axboe

