Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbSJGN4O>; Mon, 7 Oct 2002 09:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbSJGN4O>; Mon, 7 Oct 2002 09:56:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263055AbSJGNzT>;
	Mon, 7 Oct 2002 09:55:19 -0400
Date: Mon, 7 Oct 2002 16:00:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [patch] ide tcq support, 2.5.40-bk
Message-ID: <20021007140054.GD1160@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tagged command queueing support for IDE is available again. It has a few
rough edges from a source style POV, nothing that should impact
stability though.

Patch against 2.5.40-BK attached.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.776   -> 1.777  
#	drivers/ide/ide-taskfile.c	1.5     -> 1.6    
#	drivers/ide/Config.in	1.5     -> 1.6    
#	   drivers/ide/ide.c	1.24    -> 1.25   
#	 include/linux/ide.h	1.21    -> 1.22   
#	drivers/ide/ide-disk.c	1.18    -> 1.19   
#	drivers/ide/ide-dma.c	1.4     -> 1.5    
#	drivers/ide/Makefile	1.5     -> 1.6    
#	drivers/ide/ide-probe.c	1.17    -> 1.18   
#	drivers/ide/Config.help	1.27    -> 1.28   
#	               (new)	        -> 1.1     drivers/ide/ide-tcq.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/07	axboe@burns.home.kernel.dk	1.777
# Tagged command queueing for IDE, 2.5.40-BK
# --------------------------------------------
#
diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/Config.help	Mon Oct  7 12:02:43 2002
@@ -258,6 +258,37 @@
 
   If in doubt, say N.
 
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
 CONFIG_BLK_DEV_OFFBOARD
   Normally, IDE controllers built into the motherboard (on-board
   controllers) are assigned to ide0 and ide1 while those on add-in PCI
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/Config.in	Mon Oct  7 12:02:43 2002
@@ -36,6 +36,11 @@
 	    dep_bool '    Generic PCI IDE Chipset Support' CONFIG_BLK_DEV_GENERIC $CONFIG_BLK_DEV_IDEPCI
 	    bool '    Sharing PCI IDE interrupts support' CONFIG_IDEPCI_SHARE_IRQ
 	    bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	    if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
+		int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
+	    fi
 	    bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
 	    dep_bool '      Force enable legacy 2.0.X HOSTS to use DMA' CONFIG_BLK_DEV_IDEDMA_FORCED $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
diff -Nru a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/Makefile	Mon Oct  7 12:02:43 2002
@@ -22,6 +22,7 @@
 
 obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
 obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+= ide-tcq.o
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/ide-disk.c	Mon Oct  7 12:02:43 2002
@@ -352,6 +352,26 @@
 	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
 }
 
+static int idedisk_start_tag(ide_drive_t *drive, struct request *rq)
+{
+	unsigned long flags;
+	int ret = 1, nr_commands;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if (ata_pending_commands(drive) < drive->queue_depth) {
+		ret = blk_queue_start_tag(&drive->queue, rq);
+
+		nr_commands = ata_pending_commands(drive);
+		if (nr_commands > drive->max_depth)
+			drive->max_depth = nr_commands;
+		if (nr_commands > drive->max_last_depth)
+			drive->max_last_depth = nr_commands;
+	}
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return ret;
+}
 
 /*
  * do_rw_disk() issues READ and WRITE commands to a disk,
@@ -375,6 +395,13 @@
 		return promise_rw_disk(drive, rq, block);
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 
+	if (drive->using_tcq && idedisk_start_tag(drive, rq)) {
+		if (!ata_pending_commands(drive))
+			BUG();
+
+		return ide_started;
+	}
+
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
@@ -382,10 +409,18 @@
 		if (drive->addressing == 1) {
 			task_ioreg_t tasklets[10];
 
-			tasklets[0] = 0;
-			tasklets[1] = 0;
-			tasklets[2] = nsectors.b.low;
-			tasklets[3] = nsectors.b.high;
+			if (blk_rq_tagged(rq)) {
+				tasklets[0] = nsectors.b.low;
+				tasklets[1] = nsectors.b.high;
+				tasklets[2] = rq->tag << 3;
+				tasklets[3] = 0;
+			} else {
+				tasklets[0] = 0;
+				tasklets[1] = 0;
+				tasklets[2] = nsectors.b.low;
+				tasklets[3] = nsectors.b.high;
+			}
+
 			tasklets[4] = (task_ioreg_t) block;
 			tasklets[5] = (task_ioreg_t) (block>>8);
 			tasklets[6] = (task_ioreg_t) (block>>16);
@@ -398,7 +433,7 @@
 			printk("%s: %sing: LBAsect=%lu, sectors=%ld, "
 				"buffer=0x%08lx, LBAsect=0x%012lx\n",
 				drive->name,
-				(rq->cmd==READ)?"read":"writ",
+				rq_data_dir(rq)==READ?"read":"writ",
 				block,
 				rq->nr_sectors,
 				(unsigned long) rq->buffer,
@@ -422,14 +457,20 @@
 			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
 		} else {
 #ifdef DEBUG
-			printk("%s: %sing: LBAsect=%ld, sectors=%ld, "
+			printk("%s: %sing: LBAsect=%ld, sectors=%d, "
 				"buffer=0x%08lx\n",
-				drive->name, (rq->cmd==READ)?"read":"writ",
-				block, rq->nr_sectors,
+				drive->name,rq_data_dir(rq)==READ?"read":"writ",
+				block, nsectors.b.low,
 				(unsigned long) rq->buffer);
 #endif
-			hwif->OUTB(0x00, IDE_FEATURE_REG);
-			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+			if (blk_rq_tagged(rq)) {
+				hwif->OUTB(nsectors.b.low, IDE_FEATURE_REG);
+				hwif->OUTB(rq->tag << 3, IDE_NSECTOR_REG);
+			} else {
+				hwif->OUTB(0x00, IDE_FEATURE_REG);
+				hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+			}
+
 			hwif->OUTB(block, IDE_SECTOR_REG);
 			hwif->OUTB(block>>=8, IDE_LCYL_REG);
 			hwif->OUTB(block>>=8, IDE_HCYL_REG);
@@ -443,23 +484,31 @@
 		head  = track % drive->head;
 		cyl   = track / drive->head;
 
-		hwif->OUTB(0x00, IDE_FEATURE_REG);
-		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+		if (blk_rq_tagged(rq)) {
+			hwif->OUTB(nsectors.b.low, IDE_FEATURE_REG);
+			hwif->OUTB(rq->tag << 3, IDE_NSECTOR_REG);
+		} else {
+			hwif->OUTB(0x00, IDE_FEATURE_REG);
+			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+		}
+
 		hwif->OUTB(cyl, IDE_LCYL_REG);
 		hwif->OUTB(cyl>>8, IDE_HCYL_REG);
 		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
 #ifdef DEBUG
 		printk("%s: %sing: CHS=%d/%d/%d, sectors=%ld, buffer=0x%08lx\n",
-			drive->name, (rq->cmd==READ)?"read":"writ", cyl,
+			drive->name, rq_data_dir(rq)==READ?"read":"writ", cyl,
 			head, sect, rq->nr_sectors, (unsigned long) rq->buffer);
 #endif
 	}
 
 	if (rq_data_dir(rq) == READ) {
-#ifdef CONFIG_BLK_DEV_IDEDMA
+		if (blk_rq_tagged(rq))
+			return hwif->ide_dma_queued_read(drive);
+
 		if (drive->using_dma && !hwif->ide_dma_read(drive))
 			return ide_started;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+
 		if (HWGROUP(drive)->handler != NULL)
 			BUG();
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
@@ -471,10 +520,12 @@
 		return ide_started;
 	} else if (rq_data_dir(rq) == WRITE) {
 		ide_startstop_t startstop;
-#ifdef CONFIG_BLK_DEV_IDEDMA
+
+		if (blk_rq_tagged(rq))
+			return hwif->ide_dma_queued_write(drive);
+
 		if (drive->using_dma && !(HWIF(drive)->ide_dma_write(drive)))
 			return ide_started;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 		command = ((drive->mult_count) ?
 			   ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
@@ -562,6 +613,13 @@
                 return promise_rw_disk(drive, rq, block);
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 
+	if (drive->using_tcq && idedisk_start_tag(drive, rq)) {
+		if (!ata_pending_commands(drive))
+			BUG();
+
+		return ide_started;
+	}
+
 	if (drive->addressing == 1)		/* 48-bit LBA */
 		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
@@ -579,12 +637,16 @@
 	lba48bit = (drive->addressing == 1) ? 1 : 0;
 #endif
 
+	if ((cmd == READ) && drive->using_tcq)
+		return lba48bit ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
 	if ((cmd == READ) && (drive->using_dma))
 		return (lba48bit) ? WIN_READDMA_EXT : WIN_READDMA;
 	else if ((cmd == READ) && (drive->mult_count))
 		return (lba48bit) ? WIN_MULTREAD_EXT : WIN_MULTREAD;
 	else if (cmd == READ)
 		return (lba48bit) ? WIN_READ_EXT : WIN_READ;
+	else if ((cmd == WRITE) && drive->using_tcq)
+		return lba48bit ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
 	else if ((cmd == WRITE) && (drive->using_dma))
 		return (lba48bit) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	else if ((cmd == WRITE) && (drive->mult_count))
@@ -618,7 +680,13 @@
 	memset(&args, 0, sizeof(ide_task_t));
 
 	sectors	= (rq->nr_sectors == 256) ? 0x00 : rq->nr_sectors;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= sectors;
+
+	if (blk_rq_tagged(rq)) {
+		args.tfRegister[IDE_FEATURE_OFFSET] = sectors;
+		args.tfRegister[IDE_NSECTOR_OFFSET] = rq->tag << 3;
+	} else
+		args.tfRegister[IDE_NSECTOR_OFFSET] = sectors;
+
 	args.tfRegister[IDE_SECTOR_OFFSET]	= sect;
 	args.tfRegister[IDE_LCYL_OFFSET]	= cyl;
 	args.tfRegister[IDE_HCYL_OFFSET]	= (cyl>>8);
@@ -650,7 +718,13 @@
 	memset(&args, 0, sizeof(ide_task_t));
 
 	sectors = (rq->nr_sectors == 256) ? 0x00 : rq->nr_sectors;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= sectors;
+
+	if (blk_rq_tagged(rq)) {
+		args.tfRegister[IDE_FEATURE_OFFSET] = sectors;
+		args.tfRegister[IDE_NSECTOR_OFFSET] = rq->tag << 3;
+	} else
+		args.tfRegister[IDE_NSECTOR_OFFSET] = sectors;
+
 	args.tfRegister[IDE_SECTOR_OFFSET]	= block;
 	args.tfRegister[IDE_LCYL_OFFSET]	= (block>>=8);
 	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);
@@ -688,13 +762,22 @@
 	memset(&args, 0, sizeof(ide_task_t));
 
 	sectors = (rq->nr_sectors == 65536) ? 0 : rq->nr_sectors;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= sectors;
+
+	if (blk_rq_tagged(rq)) {
+		args.tfRegister[IDE_FEATURE_OFFSET] = sectors;
+		args.tfRegister[IDE_NSECTOR_OFFSET] = rq->tag << 3;
+		args.hobRegister[IDE_FEATURE_OFFSET_HOB] = sectors >> 8;
+		args.hobRegister[IDE_NSECT_OFFSET_HOB] = 0;
+	} else {
+		args.tfRegister[IDE_NSECTOR_OFFSET] = sectors;
+		args.hobRegister[IDE_NSECTOR_OFFSET_HOB] = sectors >> 8;
+	}
+
 	args.tfRegister[IDE_SECTOR_OFFSET]	= block;	/* low lba */
 	args.tfRegister[IDE_LCYL_OFFSET]	= (block>>=8);	/* mid lba */
 	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);	/* hi  lba */
 	args.tfRegister[IDE_SELECT_OFFSET]	= drive->select.all;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
-	args.hobRegister[IDE_NSECTOR_OFFSET_HOB]= sectors >> 8;
 	args.hobRegister[IDE_SECTOR_OFFSET_HOB]	= (block>>=8);	/* low lba */
 	args.hobRegister[IDE_LCYL_OFFSET_HOB]	= (block>>=8);	/* mid lba */
 	args.hobRegister[IDE_HCYL_OFFSET_HOB]	= (block>>=8);	/* hi  lba */
@@ -1306,11 +1389,61 @@
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
+		struct request *rq = blk_queue_find_tag(&drive->queue, i);
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
+	len += sprintf(out+len, "DMA status:\t\t%srunning\n", HWIF(drive)->dma ? "" : "not ");
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
 
@@ -1460,6 +1593,37 @@
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int set_using_tcq(ide_drive_t *drive, int arg)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	int ret;
+
+	if (!drive->driver)
+		return -EPERM;
+	if (!hwif->ide_dma_queued_on || !hwif->ide_dma_queued_off)
+		return -ENXIO;
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
+	if (arg)
+		ret = HWIF(drive)->ide_dma_queued_on(drive);
+	else
+		ret = HWIF(drive)->ide_dma_queued_off(drive);
+
+	return ret ? -EIO : 0;
+}
+#endif
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -1494,6 +1658,9 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
  	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
+#endif
 }
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/ide-dma.c	Mon Oct  7 12:02:43 2002
@@ -461,7 +461,14 @@
 {
 	drive->using_dma = 0;
 	ide_toggle_bounce(drive, 0);
-	return HWIF(drive)->ide_dma_host_off(drive);
+
+	if (HWIF(drive)->ide_dma_host_off(drive))
+		return 1;
+
+	if (drive->queue_setup)
+		HWIF(drive)->ide_dma_queued_off(drive);
+
+	return 0;
 }
 
 EXPORT_SYMBOL(__ide_dma_off_quietly);
@@ -493,7 +500,14 @@
 {
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
-	return HWIF(drive)->ide_dma_host_on(drive);
+
+	if (HWIF(drive)->ide_dma_host_on(drive))
+		return 1;
+
+	if (drive->queue_setup)
+		HWIF(drive)->ide_dma_queued_on(drive);
+
+	return 0;
 }
 
 EXPORT_SYMBOL(__ide_dma_on);
@@ -505,50 +519,58 @@
 
 EXPORT_SYMBOL(__ide_dma_check);
 
-int __ide_dma_read (ide_drive_t *drive /*, struct request *rq */)
+int ide_start_dma(ide_hwif_t *hwif, ide_drive_t *drive, int reading)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-//	ide_task_t *args	= rq->special;
-	unsigned int reading	= 1 << 3;
-	unsigned int count	= 0;
-	u8 dma_stat = 0, lba48	= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
+	struct request *rq = HWGROUP(drive)->rq;
+	u8 dma_stat;
 
-	if (!(count = ide_build_dmatable(drive, rq)))
-		/* try PIO instead of DMA */
+	/* fall back to pio! */
+	if (!ide_build_dmatable(drive, rq))
 		return 1;
+
 	/* PRD table */
 	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
+
 	/* specify r/w */
 	hwif->OUTB(reading, hwif->dma_command);
+
 	/* read dma_status for INTR & ERROR flags */
 	dma_stat = hwif->INB(hwif->dma_status);
+
 	/* clear INTR & ERROR flags */
 	hwif->OUTB(dma_stat|6, hwif->dma_status);
 	drive->waiting_for_dma = 1;
+	return 0;
+}
+
+EXPORT_SYMBOL(ide_start_dma);
+
+int __ide_dma_read (ide_drive_t *drive /*, struct request *rq */)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct request *rq	= HWGROUP(drive)->rq;
+	unsigned int reading	= 1 << 3;
+	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	task_ioreg_t command	= WIN_NOP;
+
+	/* try pio */
+	if (ide_start_dma(hwif, drive, reading))
+		return 1;
+
 	if (drive->media != ide_disk)
 		return 0;
+
 	/* paranoia check */
 	if (HWGROUP(drive)->handler != NULL)
 		BUG();
 	ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
 
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
 	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
-#endif
+
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
 
@@ -561,47 +583,31 @@
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
-//	ide_task_t *args	= rq->special;
 	unsigned int reading	= 0;
-	unsigned int count	= 0;
-	u8 dma_stat = 0, lba48	= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	if (!(count = ide_build_dmatable(drive, rq)))
-		/* try PIO instead of DMA */
+	/* try PIO instead of DMA */
+	if (ide_start_dma(hwif, drive, reading))
 		return 1;
-	/* PRD table */
-	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
-	/* specify r/w */
-	hwif->OUTB(reading, hwif->dma_command);
-	/* read dma_status for INTR & ERROR flags */
-	dma_stat = hwif->INB(hwif->dma_status);
-	/* clear INTR & ERROR flags */
-	hwif->OUTB(dma_stat|6, hwif->dma_status);
-	drive->waiting_for_dma = 1;
+
 	if (drive->media != ide_disk)
 		return 0;
+
 	/* paranoia check */
 	if (HWGROUP(drive)->handler != NULL)
 		BUG();
 	ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
+
 	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
-#endif
+
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
+
 	return HWIF(drive)->ide_dma_count(drive);
 }
 
@@ -619,6 +625,8 @@
 	 */
 	/* start DMA */
 	hwif->OUTB(dma_cmd|1, hwif->dma_command);
+	hwif->dma = 1;
+	wmb();
 	return 0;
 }
 
@@ -642,6 +650,8 @@
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);
 	/* verify good DMA status */
+	hwif->dma = 0;
+	wmb();
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
 }
 
@@ -998,6 +1008,23 @@
 		hwif->ide_dma_retune = &__ide_dma_retune;
 	if (!hwif->ide_dma_lostirq)
 		hwif->ide_dma_lostirq = &__ide_dma_lostirq;
+
+	/*
+	 * dma queued ops. if tcq isn't set, queued on and off are just
+	 * dummy functions. cuts down on ifdef hell
+	 */
+	if (!hwif->ide_dma_queued_on)
+		hwif->ide_dma_queued_on = __ide_dma_queued_on;
+	if (!hwif->ide_dma_queued_off)
+		hwif->ide_dma_queued_off = __ide_dma_queued_off;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	if (!hwif->ide_dma_queued_read)
+		hwif->ide_dma_queued_read = __ide_dma_queued_read;
+	if (!hwif->ide_dma_queued_write)
+		hwif->ide_dma_queued_write = __ide_dma_queued_write;
+	if (!hwif->ide_dma_queued_start)
+		hwif->ide_dma_queued_start = __ide_dma_queued_start;
+#endif
 
 	if (hwif->chipset != ide_trm290) {
 		u8 dma_stat = hwif->INB(hwif->dma_status);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/ide-probe.c	Mon Oct  7 12:02:43 2002
@@ -221,6 +221,17 @@
 	drive->media = ide_disk;
 	printk("%s DISK drive\n", (drive->is_flash) ? "CFA" : "ATA" );
 	QUIRK_LIST(drive);
+
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
@@ -776,6 +787,7 @@
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request, &ide_lock);
+	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);
 
 #ifdef CONFIG_BLK_DEV_PDC4030
@@ -792,6 +804,10 @@
 	blk_queue_max_phys_segments(q, PRD_ENTRIES);
 
 	ide_toggle_bounce(drive, 1);
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+	HWIF(drive)->ide_dma_queued_on(drive);
+#endif
 }
 
 /*
@@ -917,8 +933,11 @@
 			hwgroup->drive = drive;
 		drive->next = hwgroup->drive->next;
 		hwgroup->drive->next = drive;
+		spin_unlock_irqrestore(&ide_lock, flags);
 		ide_init_queue(drive);
+		spin_lock_irqsave(&ide_lock, flags);
 	}
+
 	if (!hwgroup->hwif) {
 		hwgroup->hwif = HWIF(hwgroup->drive);
 #ifdef DEBUG
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/ide-taskfile.c	Mon Oct  7 12:02:43 2002
@@ -201,6 +201,12 @@
 			if (hwif->ide_dma_read(drive))
 				return ide_stopped;
 			break;
+		case WIN_READDMA_QUEUED:
+		case WIN_READDMA_QUEUED_EXT:
+			return hwif->ide_dma_queued_read(drive);
+		case WIN_WRITEDMA_QUEUED:
+		case WIN_WRITEDMA_QUEUED_EXT:
+			return hwif->ide_dma_queued_write(drive);
 		default:
 			if (task->handler == NULL)
 				return ide_stopped;
diff -Nru a/drivers/ide/ide-tcq.c b/drivers/ide/ide-tcq.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/ide/ide-tcq.c	Mon Oct  7 12:02:43 2002
@@ -0,0 +1,719 @@
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
+#include <linux/ide.h>
+
+#include <asm/io.h>
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
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
+ide_startstop_t ide_service(ide_drive_t *drive);
+
+static inline void drive_ctl_nien(ide_drive_t *drive, int set)
+{
+#ifdef IDE_TCQ_NIEN
+	if (IDE_CONTROL_REG) {
+		int mask = set ? 0x02 : 0x00;
+
+		hwif->OUTB(drive->ctl | mask, IDE_CONTROL_REG);
+	}
+#endif
+}
+
+static ide_startstop_t ide_tcq_nop_handler(ide_drive_t *drive)
+{
+	ide_task_t *args = HWGROUP(drive)->rq->special;
+	ide_hwif_t *hwif = HWIF(drive);
+	int auto_poll_check = 0;
+	u8 stat, err;
+
+	if (args->tfRegister[IDE_FEATURE_OFFSET] & 0x01)
+		auto_poll_check = 1;
+
+	local_irq_enable();
+
+	stat = hwif->INB(IDE_STATUS_REG);
+	err = hwif->INB(IDE_ERROR_REG);
+	ide_end_drive_cmd(drive, stat, err);
+
+	/*
+	 * do taskfile and check ABRT bit -- intelligent adapters will not
+	 * pass NOP with sub-code 0x01 to device, so the command will not
+	 * fail there
+	 */
+	if (auto_poll_check) {
+		if (!(args->tfRegister[IDE_FEATURE_OFFSET] & ABRT_ERR)) {
+			HWIF(drive)->auto_poll = 1;
+			printk("%s: NOP Auto-poll enabled\n",HWIF(drive)->name);
+		}
+	}
+
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
+	struct request *rq;
+	unsigned long flags;
+
+	printk("%s: invalidating tag queue (%d commands)\n", drive->name, ata_pending_commands(drive));
+
+	/*
+	 * first kill timer and block queue
+	 */
+	spin_lock_irqsave(&ide_lock, flags);
+
+	del_timer(&hwgroup->timer);
+
+	if (HWIF(drive)->dma)
+		HWIF(drive)->ide_dma_end(drive);
+
+	blk_queue_invalidate_tags(q);
+
+	drive->using_tcq = 0;
+	drive->queue_depth = 1;
+	hwgroup->busy = 0;
+	hwgroup->handler = NULL;
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	/*
+	 * now kill hardware queue with a NOP
+	 */
+	rq = &hwgroup->wrq;
+	ide_init_drive_cmd(rq);
+	rq->buffer = hwgroup->cmd_buf;
+	memset(rq->buffer, 0, sizeof(hwgroup->cmd_buf));
+	rq->buffer[0] = WIN_NOP;
+	ide_do_drive_cmd(drive, rq, ide_preempt);
+}
+
+void ide_tcq_intr_timeout(unsigned long data)
+{
+	ide_drive_t *drive = (ide_drive_t *) data;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long flags;
+
+	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt\n", hwgroup->rq ? "completion" : "service");
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if (!hwgroup->busy)
+		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
+	if (hwgroup->handler == NULL)
+		printk("ide_tcq_intr_timeout: missing isr!\n");
+
+	hwgroup->busy = 1;
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	/*
+	 * if pending commands, try service before giving up
+	 */
+	if (ata_pending_commands(drive)) {
+		u8 stat = hwif->INB(IDE_STATUS_REG);
+
+		if ((stat & SRV_STAT) && (ide_service(drive) == ide_started))
+			return;
+	}
+
+	if (drive)
+		ide_tcq_invalidate_queue(drive);
+}
+
+void __ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ide_handler_t *handler)
+{
+	/*
+	 * always just bump the timer for now, the timeout handling will
+	 * have to be changed to be per-command
+	 */
+	hwgroup->timer.function = ide_tcq_intr_timeout;
+	hwgroup->timer.data = (unsigned long) hwgroup->drive;
+	mod_timer(&hwgroup->timer, jiffies + 5 * HZ);
+
+	hwgroup->handler = handler;
+}
+
+void ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ide_handler_t *handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	__ide_tcq_set_intr(hwgroup, handler);
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+/*
+ * wait 400ns, then poll for busy_mask to clear from alt status
+ */
+#define IDE_TCQ_WAIT	(10000)
+int ide_tcq_wait_altstat(ide_drive_t *drive, byte *stat, byte busy_mask)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	int i = 0;
+
+	udelay(1);
+
+	do {
+		*stat = hwif->INB(IDE_ALTSTATUS_REG);
+
+		if (!(*stat & busy_mask))
+			break;
+
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	} while (1);
+
+	return 0;
+}
+
+/*
+ * issue SERVICE command to drive -- drive must have been selected first,
+ * and it must have reported a need for service (status has SRV_STAT set)
+ *
+ * Also, nIEN must be set as not to need protection against ide_dmaq_intr
+ */
+ide_startstop_t ide_service(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long flags;
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
+	if (hwif->dma)
+		return ide_stopped;
+
+	/*
+	 * need to select the right drive first...
+	 */
+	if (drive != HWGROUP(drive)->drive) {
+		SELECT_DRIVE(drive);
+		udelay(10);
+	}
+
+	drive_ctl_nien(drive, 1);
+
+	/*
+	 * send SERVICE, wait 400ns, wait for BUSY_STAT to clear
+	 */
+	hwif->OUTB(WIN_QUEUED_SERVICE, IDE_COMMAND_REG);
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
+	feat = hwif->INB(IDE_NSECTOR_REG);
+	if (feat & REL) {
+		HWGROUP(drive)->rq = NULL;
+		printk("%s: release in service\n", drive->name);
+		return ide_stopped;
+	}
+
+	tag = feat >> 3;
+
+	TCQ_PRINTK("ide_service: stat %x, feat %x\n", stat, feat);
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if ((rq = blk_queue_find_tag(&drive->queue, tag))) {
+		HWGROUP(drive)->rq = rq;
+
+		/*
+		 * we'll start a dma read or write, device will trigger
+		 * interrupt to indicate end of transfer, release is not
+		 * allowed
+		 */
+		TCQ_PRINTK("ide_service: starting command, stat=%x\n", stat);
+		spin_unlock_irqrestore(&ide_lock, flags);
+		return HWIF(drive)->ide_dma_queued_start(drive);
+	}
+
+	printk("ide_service: missing request for tag %d\n", tag);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return ide_stopped;
+}
+
+ide_startstop_t ide_check_service(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	byte stat;
+
+	TCQ_PRINTK("%s: ide_check_service\n", drive->name);
+
+	if (!ata_pending_commands(drive))
+		return ide_stopped;
+
+	stat = hwif->INB(IDE_STATUS_REG);
+	if (stat & SRV_STAT)
+		return ide_service(drive);
+
+	/*
+	 * we have pending commands, wait for interrupt
+	 */
+	TCQ_PRINTK("%s: wait for service interrupt\n", drive->name);
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
+	dma_stat = HWIF(drive)->ide_dma_end(drive);
+
+	/*
+	 * must be end of I/O, check status and complete as necessary
+	 */
+	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
+		printk("ide_dmaq_intr: %s: error status %x\n",drive->name,stat);
+		ide_dump_status(drive, "ide_dmaq_complete", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	if (dma_stat)
+		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
+
+	TCQ_PRINTK("ide_dmaq_complete: ending %p, tag %d\n", rq, rq->tag);
+	ide_end_request(drive, 1, rq->nr_sectors);
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
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive)
+{
+	struct request *rq = HWGROUP(drive)->rq;
+	ide_hwif_t *hwif = HWIF(drive);
+	byte stat = hwif->INB(IDE_STATUS_REG);
+
+	TCQ_PRINTK("ide_dmaq_intr: stat=%x\n", stat);
+
+	/*
+	 * if a command completion interrupt is pending, do that first and
+	 * check service afterwards
+	 */
+	if (rq) {
+		TCQ_PRINTK("ide_dmaq_intr: completion\n");
+		return ide_dmaq_complete(drive, rq, stat);
+	}
+
+	/*
+	 * service interrupt
+	 */
+	if (stat & SRV_STAT) {
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
+	ide_task_t *args;
+	int i, drives;
+
+	/*
+	 * only need to probe if both drives on a channel support tcq
+	 */
+	for (i = 0, drives = 0; i < MAX_DRIVES; i++)
+		if (HWIF(drive)->drives[i].present && drive->media == ide_disk)
+			drives++;
+
+	if (drives <= 1)
+		return 0;
+
+	/*
+	 * what a mess...
+	 */
+	args = kmalloc(sizeof(*args), GFP_ATOMIC);
+	if (!args)
+		return 1;
+
+	memset(args, 0, sizeof(*args));
+
+	args->tfRegister[IDE_FEATURE_OFFSET] = 0x01;
+	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_NOP;
+	args->command_type = ide_cmd_type_parser(args);
+	args->handler = ide_tcq_nop_handler;
+	return ide_raw_taskfile(drive, args, NULL);
+}
+
+/*
+ * configure the drive for tcq
+ */
+static int ide_tcq_configure(ide_drive_t *drive)
+{
+	int tcq_mask = 1 << 1 | 1 << 14;
+	int tcq_bits = tcq_mask | 1 << 15;
+	ide_task_t *args;
+
+	/*
+	 * bit 14 and 1 must be set in word 83 of the device id to indicate
+	 * support for dma queued protocol, and bit 15 must be cleared
+	 */
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
+		return -EIO;
+
+	args = kmalloc(sizeof(*args), GFP_ATOMIC);
+	if (!args)
+		return -ENOMEM;
+
+	memset(args, 0, sizeof(ide_task_t));
+	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETFEATURES;
+	args->tfRegister[IDE_FEATURE_OFFSET] = SETFEATURES_EN_WCACHE;
+	args->command_type = ide_cmd_type_parser(args);
+
+	if (ide_raw_taskfile(drive, args, NULL)) {
+		printk("%s: failed to enable write cache\n", drive->name);
+		goto err;
+	}
+
+	/*
+	 * disable RELease interrupt, it's quicker to poll this after
+	 * having sent the command opcode
+	 */
+	memset(args, 0, sizeof(ide_task_t));
+	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETFEATURES;
+	args->tfRegister[IDE_FEATURE_OFFSET] = SETFEATURES_DIS_RI;
+	args->command_type = ide_cmd_type_parser(args);
+
+	if (ide_raw_taskfile(drive, args, NULL)) {
+		printk("%s: disabling release interrupt fail\n", drive->name);
+		goto err;
+	}
+
+#ifdef IDE_TCQ_FIDDLE_SI
+	/*
+	 * enable SERVICE interrupt
+	 */
+	memset(args, 0, sizeof(ide_task_t));
+	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETFEATURES;
+	args->tfRegister[IDE_FEATURE_OFFSET] = SETFEATURES_EN_SI;
+	args->command_type = ide_cmd_type_parser(args);
+
+	if (ide_raw_taskfile(drive, args, NULL)) {
+		printk("%s: enabling service interrupt fail\n", drive->name);
+		goto err;
+	}
+#endif
+
+	kfree(args);
+	return 0;
+err:
+	kfree(args);
+	return 1;
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
+	ide_hwif_t *hwif = HWIF(drive);
+	byte stat;
+	int i;
+
+	do {
+		stat = hwif->INB(IDE_STATUS_REG);
+		if (!(stat & BUSY_STAT))
+			break;
+
+		udelay(10);
+	} while (1);
+
+	if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
+		return 0;
+
+	i = 0;
+	udelay(1);
+	do {
+		stat = hwif->INB(IDE_STATUS_REG);
+
+		if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
+			break;
+
+		++i;
+		if (unlikely(i >= IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	} while (1);
+
+	return 0;
+}
+
+int __ide_dma_queued_on(ide_drive_t *drive)
+{
+	if (!drive->using_dma)
+		return 1;
+
+#if 1
+	if (ata_pending_commands(drive)) {
+		printk("ide-tcq; can't toggle tcq feature on busy drive\n");
+		return 1;
+	}
+#endif
+
+	return ide_enable_queued(drive, 1);
+}
+
+int __ide_dma_queued_off(ide_drive_t *drive)
+{
+#if 1
+	if (ata_pending_commands(drive)) {
+		printk("ide-tcq; can't toggle tcq feature on busy drive\n");
+		return 1;
+	}
+#endif
+
+	return ide_enable_queued(drive, 0);
+}
+
+static ide_startstop_t ide_dma_queued_rw(ide_drive_t *drive, u8 command)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long flags;
+	byte stat, feat;
+
+	TCQ_PRINTK("%s: starting tag\n", drive->name);
+
+	/*
+	 * set nIEN, tag start operation will enable again when
+	 * it is safe
+	 */
+	drive_ctl_nien(drive, 1);
+
+	TCQ_PRINTK("%s: sending cmd=%x\n", drive->name, command);
+	hwif->OUTB(command, IDE_COMMAND_REG);
+
+	if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
+		printk("%s: alt stat timeout\n", drive->name);
+		goto err;
+	}
+
+	drive_ctl_nien(drive, 0);
+
+	if (stat & ERR_STAT)
+		goto err;
+
+	/*
+	 * bus not released, start dma
+	 */
+	feat = hwif->INB(IDE_NSECTOR_REG);
+	if (!(feat & REL)) {
+		TCQ_PRINTK("IMMED in queued_start, feat=%x\n", feat);
+		drive->immed_comp++;
+		return hwif->ide_dma_queued_start(drive);
+	}
+
+	/*
+	 * drive released the bus, clear active request and check for service
+	 */
+	drive->immed_rel++;
+	spin_lock_irqsave(&ide_lock, flags);
+	HWGROUP(drive)->rq = NULL;
+	__ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	TCQ_PRINTK("REL in queued_start\n");
+
+	stat = hwif->INB(IDE_STATUS_REG);
+	if (stat & SRV_STAT)
+		return ide_service(drive);
+
+	return ide_released;
+err:
+	ide_dump_status(drive, "rw_queued", stat);
+	ide_tcq_invalidate_queue(drive);
+	return ide_stopped;
+}
+
+ide_startstop_t __ide_dma_queued_read(ide_drive_t *drive)
+{
+	u8 command = WIN_READDMA_QUEUED;
+
+	if (drive->addressing == 1)
+		 command = WIN_READDMA_QUEUED_EXT;
+
+	return ide_dma_queued_rw(drive, command);
+}
+
+ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive)
+{
+	u8 command = WIN_WRITEDMA_QUEUED;
+
+	if (drive->addressing == 1)
+		 command = WIN_WRITEDMA_QUEUED_EXT;
+
+	return ide_dma_queued_rw(drive, command);
+}
+
+ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct request *rq = hwgroup->rq;
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned int reading = 0;
+
+	TCQ_PRINTK("ide_dma: setting up queued tag=%d\n", rq->tag);
+
+	if (!hwgroup->busy)
+		printk("queued_rw: hwgroup not busy\n");
+
+	if (ide_tcq_wait_dataphase(drive)) {
+		printk("timeout waiting for data phase\n");
+		return ide_stopped;
+	}
+
+	if (rq_data_dir(rq) == READ)
+		reading = 1 << 3;
+
+	if (ide_start_dma(hwif, drive, reading))
+		return ide_stopped;
+
+	ide_tcq_set_intr(hwgroup, ide_dmaq_intr);
+
+	if (!hwif->ide_dma_begin(drive))
+		return ide_started;
+
+	return ide_stopped;
+}
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Mon Oct  7 12:02:43 2002
+++ b/drivers/ide/ide.c	Mon Oct  7 12:02:43 2002
@@ -407,7 +407,10 @@
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
 		add_blkdev_randomness(major(rq->rq_dev));
-		blkdev_dequeue_request(rq);
+		if (!blk_rq_tagged(rq))
+			blkdev_dequeue_request(rq);
+		else
+			blk_queue_end_tag(&drive->queue, rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
 		ret = 0;
@@ -1117,9 +1120,30 @@
 		drive->sleep = 0;
 		drive->service_start = jiffies;
 
-		BUG_ON(blk_queue_plugged(&drive->queue));
+queue_next:
+		if (!ata_can_queue(drive)) {
+			if (!ata_pending_commands(drive))
+				hwgroup->busy = 0;
+
+			break;
+		}
+
+		if (blk_queue_plugged(&drive->queue)) {
+			if (drive->using_tcq)
+				break;
+
+			printk("ide: huh? queue was plugged!\n");
+			break;
+		}
+
+		rq = elv_next_request(&drive->queue);
+		if (!rq)
+			break;
+
+		if (!rq->bio && ata_pending_commands(drive))
+			break;
 
-		rq = hwgroup->rq = elv_next_request(&drive->queue);
+		hwgroup->rq = rq;
 
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
@@ -1138,6 +1162,8 @@
 		spin_lock_irq(&ide_lock);
 		if (masked_irq && hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
+		if (startstop == ide_released)
+			goto queue_next;
 		if (startstop == ide_stopped)
 			hwgroup->busy = 0;
 	}
@@ -1379,6 +1405,7 @@
 
 	if ((handler = hwgroup->handler) == NULL ||
 	    hwgroup->poll_timeout != 0) {
+		printk("ide: unexpected interrupt\n");
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Mon Oct  7 12:02:43 2002
+++ b/include/linux/ide.h	Mon Oct  7 12:02:43 2002
@@ -213,14 +213,6 @@
 #define PRD_ENTRIES     (PAGE_SIZE / (2 * PRD_BYTES))
 
 /*
- * sector count bits
- */
-#define NSEC_CD			0x01
-#define NSEC_IO			0x02
-#define NSEC_REL		0x04
-
-
-/*
  * Our Physical Region Descriptor (PRD) table should be large enough
  * to handle the biggest I/O request we are likely to see.  Since requests
  * can have no more than 256 sectors, and since the typical blocksize is
@@ -689,6 +681,15 @@
 	} b;
 } atapi_select_t;
 
+/*
+ * Status returned from various ide_ functions
+ */
+typedef enum {
+	ide_stopped,	/* no drive operation was started */
+	ide_started,	/* a drive operation was started, handler was set */
+	ide_released,	/* as ide_started, but bus also released */
+} ide_startstop_t;
+
 struct ide_driver_s;
 struct ide_settings_s;
 
@@ -775,6 +776,7 @@
 	u8	sect;		/* "real" sectors per track */
 	u8	bios_head;	/* BIOS/fdisk/LILO number of heads */
 	u8	bios_sect;	/* BIOS/fdisk/LILO sectors per track */
+	u8	queue_depth;	/* max queue depth */
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
@@ -792,6 +794,16 @@
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct gendisk *disk;
+
+	/*
+	 * tcq statistics
+	 */
+	unsigned long	immed_rel;
+	unsigned long	immed_comp;
+	int		max_last_depth;
+	int		max_depth;
+
+	int		queue_setup;
 } ide_drive_t;
 
 typedef struct ide_pio_ops_s {
@@ -822,6 +834,12 @@
 	int (*ide_dma_retune)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
+	/* dma queued operations */
+	int (*ide_dma_queued_on)(ide_drive_t *drive);
+	int (*ide_dma_queued_off)(ide_drive_t *drive);
+	ide_startstop_t (*ide_dma_queued_read)(ide_drive_t *drive);
+	ide_startstop_t (*ide_dma_queued_write)(ide_drive_t *drive);
+	ide_startstop_t (*ide_dma_queued_start)(ide_drive_t *drive);
 } ide_dma_ops_t;
 
 /*
@@ -958,6 +976,13 @@
 	int (*ide_dma_retune)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
+
+	/* dma queued operations */
+	int (*ide_dma_queued_on)(ide_drive_t *drive);
+	int (*ide_dma_queued_off)(ide_drive_t *drive);
+	ide_startstop_t (*ide_dma_queued_read)(ide_drive_t *drive);
+	ide_startstop_t (*ide_dma_queued_write)(ide_drive_t *drive);
+	ide_startstop_t (*ide_dma_queued_start)(ide_drive_t *drive);
 #endif
 
 #if 0
@@ -1016,21 +1041,15 @@
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* auto-attempt using DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
-	unsigned	highmem    : 1;	/* can do full 32-bit dma */
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
+	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 
 	struct device	gendev;
 
 	void		*hwif_data;	/* extra hwif data */
-} ide_hwif_t;
 
-/*
- * Status returned from various ide_ functions
- */
-typedef enum {
-	ide_stopped,	/* no drive operation was started */
-	ide_started	/* a drive operation was started, handler was set */
-} ide_startstop_t;
+	unsigned dma;
+} ide_hwif_t;
 
 /*
  *  internal ide interrupt handler type
@@ -1071,6 +1090,8 @@
 	int (*expiry)(ide_drive_t *);
 		/* ide_system_bus_speed */
 	int pio_clock;
+
+	unsigned char cmd_buf[4];
 } ide_hwgroup_t;
 
 /* structure attached to the request for IDE_TASK_CMDS */
@@ -1661,6 +1682,7 @@
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
+extern int ide_start_dma(ide_hwif_t *, ide_drive_t *, int);
 
 extern int __ide_dma_host_off(ide_drive_t *);
 extern int __ide_dma_off_quietly(ide_drive_t *);
@@ -1681,6 +1703,24 @@
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+extern int __ide_dma_queued_on(ide_drive_t *drive);
+extern int __ide_dma_queued_off(ide_drive_t *drive);
+extern ide_startstop_t __ide_dma_queued_read(ide_drive_t *drive);
+extern ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive);
+extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
+#else
+int __ide_dma_queued_on(ide_drive_t *drive)
+{
+	return 1;
+}
+
+int __ide_dma_queued_off(ide_drive_t *drive)
+{
+	return 1;
+}
+#endif
+
 extern void hwif_unregister(ide_hwif_t *);
 
 extern void export_ide_init_queue(ide_drive_t *);
@@ -1707,6 +1747,28 @@
 extern spinlock_t ide_lock;
 
 #define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)
+
+#define IDE_MAX_TAG	32
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
 
 extern struct bus_type ide_bus_type;
 

-- 
Jens Axboe

