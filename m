Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSDIMob>; Tue, 9 Apr 2002 08:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSDIMoa>; Tue, 9 Apr 2002 08:44:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28174 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293680AbSDIMoQ>;
	Tue, 9 Apr 2002 08:44:16 -0400
Date: Tue, 9 Apr 2002 14:44:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, apj@mutt.dk
Subject: [PATCH][CFT] IDE TCQ #2
Message-ID: <20020409124417.GK25984@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 2 is ready. Changes since last time:

- Check if we are using TCQ before doing BUG() if we encounter a
  plugged queue in ide_do_request(). If so, we just need to quit.
  SMP race posted yesterday.

- Clean /proc/ide/hdX/tcq output

- Add queue depth controls in /proc/ide/hdX/setting:

  echo "using_tcq:0" > /proc/ide/hdX/setting

  will disable TCQ and revert to DMA,

  echo "using_tcq:32" > /proc/ide/hdX/setting

  will set queue depth to 32, any value in between the two are of course
  also allowed. The driver will print enable/disable info to the kernel
  log.

- Include the get_request() starvation from akpm, bump queue size a bit
  as well.

- Correctly use other depths that none or full.

- Make the current depth and int not atomic_t, access is serialized to
  it.

- Remove 'unexpected interrupt' warnings at boot

- Cleanup service and interrupt handling

- Make the initial tcq enable much nicer

This make look like a lot of stuff, but the only real bug fixed is the
SMP race mentioned yesterday. Rest is just features and cleanup. The
code has taken quite a lot of beating, so I'm ready to call this beta
and ask for more testers. No malfunctions have been detected here. Stuff
to still look out for:

- Don't enable TCQ on both master/slave on a channel! That mode is not
  supported yet, only enable TCQ on one of them at the time.

- SMP seems to have minor performance regression, performance testing
  should be UP only for now. Also note that I haven't really done any
  performance testing yet, just data integrity and stability work.

Enjoy!

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/block/ll_rw_blk.c	Mon Mar 18 21:37:05 2002
+++ linux/drivers/block/ll_rw_blk.c	Tue Apr  9 10:35:20 2002
@@ -857,10 +857,10 @@
 	spin_lock_prefetch(q->queue_lock);
 
 	generic_unplug_device(q);
-	add_wait_queue(&rl->wait, &wait);
+	add_wait_queue_exclusive(&rl->wait, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (rl->count < batch_requests)
+		if (!rl->count)
 			schedule();
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
@@ -1683,9 +1683,11 @@
 	 * Free request slots per queue.
 	 * (Half for reads, half for writes)
 	 */
-	queue_nr_requests = 64;
-	if (total_ram > MB(32))
-		queue_nr_requests = 256;
+	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
+	if (queue_nr_requests < 32)
+		queue_nr_requests = 32;
+	if (queue_nr_requests > 256)
+		queue_nr_requests = 256;
 
 	/*
 	 * Batch frees according to queue length
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/Config.help linux/drivers/ide/Config.help
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/Config.help	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/Config.help	Mon Apr  8 13:27:12 2002
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/Config.in linux/drivers/ide/Config.in
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/Config.in	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/Config.in	Tue Apr  2 09:03:38 2002
@@ -47,6 +47,11 @@
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    IDE tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
+	   dep_bool '    TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	   if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
+		int '    Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
+	   fi
 	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/Makefile linux/drivers/ide/Makefile
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/Makefile	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/Makefile	Tue Apr  2 09:03:38 2002
@@ -45,6 +45,7 @@
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ide-pmac.o
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-disk.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/ide-disk.c	Tue Apr  9 10:29:46 2002
@@ -26,9 +26,10 @@
  * Version 1.11		Highmem I/O support, Jens Axboe <axboe@suse.de>
  * Version 1.12		added 48-bit lba
  * Version 1.13		adding taskfile io access method
+ * Version 1.14		Added tcq support, Jens Axboe <axboe@suse.de>
  */
 
-#define IDEDISK_VERSION	"1.13"
+#define IDEDISK_VERSION	"1.14"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -109,53 +110,64 @@
 static u8 get_command(ide_drive_t *drive, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
+	int command = WIN_NOP;
 
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
+static ide_startstop_t chs_do_request(ide_drive_t *drive, ata_request_t *ar, sector_t block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
-	int				sectors;
+	ide_task_t			*args = &ar->ar_task;
+	struct request			*rq = ar->ar_rq;
+	int				sectors = rq->nr_sectors;
 
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
@@ -165,11 +177,20 @@
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
-	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	taskfile.sector_count	= sectors;
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		unsigned long flags;
+
+		taskfile.feature = sectors;
+		taskfile.sector_count = ar->ar_tag << 3;
+
+		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	} else
+		taskfile.sector_count   = sectors;
 
 	taskfile.sector_number	= sect;
 	taskfile.low_cylinder	= cyl;
@@ -177,45 +198,57 @@
 
 	taskfile.device_head	= head;
 	taskfile.device_head	|= drive->select.all;
-	taskfile.command	=  get_command(drive, rq_data_dir(rq));
+	taskfile.command	= get_command(drive, rq_data_dir(rq));
 
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
+	memcpy(&args->taskfile, &taskfile, sizeof(struct hd_drive_task_hdr));
+	memcpy(&args->hobfile, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	ide_cmd_type_parser(args);
+
+	args->ar = ar;
+	rq->special = ar;
 
 	return ata_taskfile(drive,
-			&args.taskfile,
-			&args.hobfile,
-			args.handler,
-			args.prehandler,
+			&args->taskfile,
+			&args->hobfile,
+			args->handler,
+			args->prehandler,
 			rq);
 }
 
-static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t lba28_do_request(ide_drive_t *drive, ata_request_t *ar, sector_t block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
-	int				sectors;
+	ide_task_t			*args = &ar->ar_task;
+	struct request			*rq = ar->ar_rq;
+	int				sectors = rq->nr_sectors;
 
-	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
-	taskfile.sector_count	= sectors;
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		unsigned long flags;
+
+		taskfile.feature = sectors;
+		taskfile.sector_count = ar->ar_tag << 3;
+
+		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	} else
+		taskfile.sector_count   = sectors;
+
 	taskfile.sector_number	= block;
 	taskfile.low_cylinder	= (block >>= 8);
 
@@ -228,22 +261,21 @@
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
+	memcpy(&args->taskfile, &taskfile, sizeof(struct hd_drive_task_hdr));
+	memcpy(&args->hobfile, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	ide_cmd_type_parser(args);
+	args->ar = ar;
+	rq->special = ar;
 
 	return ata_taskfile(drive,
-			&args.taskfile,
-			&args.hobfile,
-			args.handler,
-			args.prehandler,
+			&args->taskfile,
+			&args->hobfile,
+			args->handler,
+			args->prehandler,
 			rq);
 }
 
@@ -253,26 +285,33 @@
  * 1073741822 == 549756 MB or 48bit addressing fake drive
  */
 
-static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct request *rq, unsigned long long block)
+static ide_startstop_t lba48_do_request(ide_drive_t *drive, ata_request_t *ar, sector_t block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
-	int				sectors;
+	ide_task_t			*args = &ar->ar_task;
+	struct request			*rq = ar->ar_rq;
+	int				sectors = rq->nr_sectors;
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
-	sectors = rq->nr_sectors;
 	if (sectors == 65536)
 		sectors = 0;
 
-	taskfile.sector_count	= sectors;
-	hobfile.sector_count	= sectors >> 8;
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+		unsigned long flags;
 
-	if (rq->nr_sectors == 65536) {
-		taskfile.sector_count	= 0x00;
-		hobfile.sector_count	= 0x00;
+		taskfile.feature = sectors;
+		hobfile.feature = sectors >> 8;
+		taskfile.sector_count = ar->ar_tag << 3;
+
+		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	} else {
+		taskfile.sector_count = sectors;
+		hobfile.sector_count	= sectors >> 8;
 	}
 
 	taskfile.sector_number	= block;		/* low lba */
@@ -291,22 +330,21 @@
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
+	memcpy(&args->taskfile, &taskfile, sizeof(struct hd_drive_task_hdr));
+	memcpy(&args->taskfile, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	ide_cmd_type_parser(args);
+	args->ar = ar;
+	rq->special = ar;
 
 	return ata_taskfile(drive,
-			&args.taskfile,
-			&args.hobfile,
-			args.handler,
-			args.prehandler,
+			&args->taskfile,
+			&args->hobfile,
+			args->handler,
+			args->prehandler,
 			rq);
 }
 
@@ -315,8 +353,11 @@
  * otherwise, to address sectors.  It also takes care of issuing special
  * DRIVE_CMDs.
  */
-static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, sector_t block)
 {
+	unsigned long flags;
+	ata_request_t *ar;
+
 	/*
 	 * Wait until all request have bin finished.
 	 */
@@ -338,16 +379,42 @@
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
+		IDE_SET_TAG(drive, ar, tag);
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
@@ -830,11 +897,71 @@
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
+		ata_request_t *ar = IDE_GET_AR(drive, i);
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
 
@@ -914,6 +1041,22 @@
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
@@ -946,6 +1089,9 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
 	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
+#endif
 }
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-dma.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/ide-dma.c	Mon Apr  8 17:08:08 2002
@@ -82,6 +82,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/ide.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -219,46 +220,49 @@
 	return ide_error(drive, "dma_intr", stat);
 }
 
-static int ide_build_sglist(struct ata_channel *hwif, struct request *rq)
+int ide_build_sglist (struct ata_channel *hwif, struct request *rq)
 {
 	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
-	struct scatterlist *sg = hwif->sg_table;
-	int nents;
+	ata_request_t *ar = rq->special;
 
-	nents = blk_rq_map_sg(q, rq, hwif->sg_table);
+	if (!(ar->ar_flags & ATA_AR_SETUP)) {
+		ar->ar_flags |= ATA_AR_SETUP;
+		ar->ar_sg_nents = blk_rq_map_sg(q, rq, ar->ar_sg_table);
+	}
 
-	if (rq->q && nents > rq->nr_phys_segments)
-		printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+	if (rq->q && ar->ar_sg_nents > rq->nr_phys_segments) {
+		printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, ar->ar_sg_nents);
+		return 0;
+	} else if (!ar->ar_sg_nents) {
+		printk("ide-dma: zero segments in request\n");
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
 
+/*
+ * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
+ */
 static int ide_raw_build_sglist(struct ata_channel *hwif, struct request *rq)
 {
-	struct scatterlist *sg = hwif->sg_table;
-	int nents = 0;
-	ide_task_t *args = rq->special;
-#if 1
+	ata_request_t *ar = rq->special;
+	struct scatterlist *sg = ar->ar_sg_table;
+	ide_task_t *args = &ar->ar_task;
 	unsigned char *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
-#else
-        nents = blk_rq_map_sg(rq->q, rq, hwif->sg_table);
-
-	if (nents > rq->nr_segments)
-		printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
-#endif
+	int nents = 0;
 
 	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+		ar->ar_sg_ddir = PCI_DMA_TODEVICE;
 	else
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		ar->ar_sg_ddir = PCI_DMA_FROMDEVICE;
 
-#if 1	
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
 		sg[nents].page = virt_to_page(virt_addr);
@@ -273,9 +277,8 @@
 	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
- #endif
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+	return pci_map_sg(hwif->pci_dev, sg, nents, ar->ar_sg_ddir);
 }
 
 /*
@@ -283,10 +286,10 @@
  * Returns 0 if all went okay, returns 1 otherwise.
  * May also be invoked from trm290.c
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
@@ -295,16 +298,19 @@
 	unsigned int count = 0;
 	int i;
 	struct scatterlist *sg;
+	ata_request_t *ar = rq->special;
+	unsigned int *table = ar->ar_dmatable_cpu;
 
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-		hwif->sg_nents = i = ide_raw_build_sglist(hwif, HWGROUP(drive)->rq);
-	} else {
-		hwif->sg_nents = i = ide_build_sglist(hwif, HWGROUP(drive)->rq);
-	}
-	if (!i)
+	if (rq->flags & REQ_DRIVE_TASKFILE)
+		ar->ar_sg_nents = ide_raw_build_sglist(hwif, rq);
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
@@ -323,7 +329,7 @@
 
 			if (count++ >= PRD_ENTRIES) {
 				printk("ide-dma: req %p\n", HWGROUP(drive)->rq);
-				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, hwif->sg_nents, cur_len, cur_addr);
+				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, ar->ar_sg_nents, cur_len, cur_addr);
 				BUG();
 			}
 
@@ -342,8 +348,8 @@
 			 */
 				if (count++ >= PRD_ENTRIES) {
 					pci_unmap_sg(hwif->pci_dev, sg,
-						     hwif->sg_nents,
-						     hwif->sg_dma_direction);
+						     ar->ar_sg_nents,
+						     ar->ar_sg_ddir);
 					return 0;
 				}
 
@@ -372,10 +378,9 @@
 void ide_destroy_dmatable (ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
-	struct scatterlist *sg = drive->channel->sg_table;
-	int nents = drive->channel->sg_nents;
+	ata_request_t *ar = IDE_CUR_AR(drive);
 
-	pci_unmap_sg(dev, sg, nents, drive->channel->sg_dma_direction);
+	pci_unmap_sg(dev, ar->ar_sg_table, ar->ar_sg_nents, ar->ar_sg_ddir);
 }
 
 /*
@@ -536,6 +541,32 @@
 }
 
 /*
+ * start DMA engine
+ */
+int ide_start_dma(struct ata_channel *hwif, ide_drive_t *drive, ide_dma_action_t func)
+{
+	unsigned int reading = 0, count;
+	unsigned long dma_base = hwif->dma_base;
+	ata_request_t *ar = IDE_CUR_AR(drive);
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
@@ -556,14 +587,16 @@
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
 	byte unit = (drive->select.b.unit & 0x01);
-	unsigned int count, reading = 0, set_high = 1;
+	unsigned int reading = 0, set_high = 1;
+	ata_request_t *ar;
 	byte dma_stat;
 
 	switch (func) {
 		case ide_dma_off:
 			printk("%s: DMA disabled\n", drive->name);
-			set_high = 0;
 		case ide_dma_off_quietly:
+			set_high = 0;
+			drive->using_tcq = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
@@ -573,48 +606,65 @@
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
+#endif /* CONFIG_BLK_DEV_IDE_TCQ */
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
-
 			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
+			if ((ar->ar_rq->flags & REQ_DRIVE_TASKFILE) &&
 			    (drive->addressing == 1)) {
-				ide_task_t *args = HWGROUP(drive)->rq->special;
+				ide_task_t *args = &ar->ar_task;
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
@@ -651,17 +701,6 @@
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
@@ -680,19 +719,6 @@
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
 
 	hwif->dmaproc = &ide_dmaproc;
 
@@ -704,7 +730,4 @@
 	}
 	printk("\n");
 	return;
-
-dma_alloc_failure:
-	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
 }
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-features.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/ide-features.c	Thu Apr  4 08:14:18 2002
@@ -75,10 +75,7 @@
 char *ide_dmafunc_verbose (ide_dma_action_t dmafunc)
 {
 	switch (dmafunc) {
-		case ide_dma_read:		return("ide_dma_read");
-		case ide_dma_write:		return("ide_dma_write");
 		case ide_dma_begin:		return("ide_dma_begin");
-		case ide_dma_end:		return("ide_dma_end:");
 		case ide_dma_check:		return("ide_dma_check");
 		case ide_dma_on:		return("ide_dma_on");
 		case ide_dma_off:		return("ide_dma_off");
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-probe.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/ide-probe.c	Tue Apr  9 13:58:09 2002
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-taskfile.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/ide-taskfile.c	Mon Apr  8 10:19:33 2002
@@ -291,7 +291,8 @@
 
 static ide_startstop_t pre_task_mulout_intr(ide_drive_t *drive, struct request *rq)
 {
-	ide_task_t *args = rq->special;
+	ata_request_t *ar = rq->special;
+	ide_task_t *args = &ar->ar_task;
 	ide_startstop_t startstop;
 
 	/*
@@ -438,8 +439,32 @@
 		if (prehandler != NULL)
 			return prehandler(drive, rq);
 	} else {
-		/* for dma commands we down set the handler */
-		if (drive->using_dma && !(drive->channel->dmaproc(((taskfile->command == WIN_WRITEDMA) || (taskfile->command == WIN_WRITEDMA_EXT)) ? ide_dma_write : ide_dma_read, drive)));
+		ide_dma_action_t dmaaction;
+
+		if (!drive->using_dma)
+			return ide_started;
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		if (drive->using_tcq) {
+			if (taskfile->command == WIN_READDMA_QUEUED
+			    || taskfile->command == WIN_READDMA_QUEUED_EXT
+			    || taskfile->command == WIN_WRITEDMA_QUEUED
+			    || taskfile->command == WIN_READDMA_QUEUED_EXT)
+				return ide_start_tag(ide_dma_queued_start, drive, rq->special);
+		}
+#endif /* CONFIG_BLK_DEV_IDE_TCQ */
+
+		if (taskfile->command == WIN_WRITEDMA || taskfile->command == WIN_WRITEDMA_EXT)
+			dmaaction = ide_dma_write;
+		else if (taskfile->command == WIN_READDMA || taskfile->command == WIN_READDMA_EXT)
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
@@ -496,7 +521,8 @@
  */
 ide_startstop_t task_no_data_intr (ide_drive_t *drive)
 {
-	ide_task_t *args	= HWGROUP(drive)->rq->special;
+	ata_request_t *ar	= HWGROUP(drive)->rq->special;
+	ide_task_t *args	= &ar->ar_task;
 	byte stat		= GET_STAT();
 
 	ide__sti();	/* local CPU only */
@@ -556,7 +582,8 @@
 
 static ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
 {
-	ide_task_t *args = rq->special;
+	ata_request_t *ar = rq->special;
+	ide_task_t *args = &ar->ar_task;
 	ide_startstop_t startstop;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
@@ -645,7 +672,7 @@
 
 		pBuf = ide_map_rq(rq, &flags);
 
-		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
+		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
 			pBuf, nsect, rq->current_nr_sectors);
 		drive->io_32bit = 0;
 		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
@@ -859,7 +886,7 @@
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-static void init_taskfile_request(struct request *rq)
+void init_taskfile_request(struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_TASKFILE;
@@ -877,22 +904,24 @@
 {
 	struct request rq;
 	/* FIXME: This is on stack! */
-	ide_task_t args;
+	ata_request_t ar;
+	ide_task_t *args = &ar.ar_task;
 
-	memset(&args, 0, sizeof(ide_task_t));
+	ATA_AR_INIT(drive, &ar);
 
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
@@ -900,15 +929,19 @@
 int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *args, byte *buf)
 {
 	struct request rq;
+	ata_request_t ar;
+
+	ATA_AR_INIT(drive, &ar);
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-tcq.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/ide/ide-tcq.c	Tue Apr  9 14:17:42 2002
@@ -0,0 +1,590 @@
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
+ * use tagged command queueing
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
+	ata_request_t *ar;
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
+	ata_request_t *ar;
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
+	ata_request_t *ar;
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
+		return 0;
+	} else if (on && drive->using_tcq) {
+		drive->queue_depth = drive->using_tcq;
+		goto out;
+	}
+
+	if (ide_tcq_configure(drive)) {
+		drive->using_tcq = 0;
+		return 1;
+	}
+
+out:
+	drive->tcq->max_depth = 0;
+
+	printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
+	drive->using_tcq = 1;
+	return 0;
+}
+
+int ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+{
+	struct ata_channel *hwif = drive->channel;
+	unsigned int reading = 0, enable_tcq = 1;
+	ide_startstop_t startstop;
+	ata_request_t *ar;
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
+			      ata_request_t *ar)
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide.c linux/drivers/ide/ide.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/ide.c	Tue Apr  9 14:05:35 2002
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
+		ata_request_t *ar = rq->special;
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
+		ata_request_t *ar = rq->special;
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
@@ -738,8 +765,11 @@
 			args[6] = IN_BYTE(IDE_SELECT_REG);
 		}
 	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = (ide_task_t *) rq->special;
+		ata_request_t *ar = rq->special;
+		ide_task_t *args = &ar->ar_task;
 		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
+		if (args && args->taskfile.command == WIN_NOP)
+			printk("ide_end_drive_cmd: NOP completed\n");
 		if (args) {
 			args->taskfile.feature = err;
 			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
@@ -762,6 +792,8 @@
 				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
+		if (ar->ar_flags & ATA_AR_RETURN)
+			ata_ar_put(drive, ar);
 	}
 
 	blkdev_dequeue_request(rq);
@@ -879,6 +911,11 @@
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
@@ -1063,7 +1100,11 @@
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
@@ -1083,11 +1124,14 @@
 			 */
 
 			if (rq->flags & REQ_DRIVE_TASKFILE) {
-				ide_task_t *args = rq->special;
+				ata_request_t *ar = rq->special;
+				ide_task_t *args;
 
-				if (!(args))
+				if (!ar)
 					goto args_error;
 
+				args = &ar->ar_task;
+
 				ata_taskfile(drive,
 						&args->taskfile,
 						&args->hobfile,
@@ -1321,16 +1365,37 @@
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
@@ -1341,14 +1406,22 @@
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
 
@@ -1375,21 +1448,39 @@
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
+	ata_request_t *ar = NULL;
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
@@ -1405,15 +1496,25 @@
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
@@ -1643,8 +1744,10 @@
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
@@ -1724,6 +1827,7 @@
 	if (drive->channel->chipset == ide_pdc4030 && rq->buffer != NULL)
 		return -ENOSYS;  /* special drive cmds not supported */
 #endif
+	rq->flags |= REQ_STARTED;
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
@@ -2047,6 +2151,7 @@
 		}
 		drive->present = 0;
 		blk_cleanup_queue(&drive->queue);
+		ide_teardown_commandlist(drive);
 	}
 	if (d->present)
 		hwgroup->drive = d;
@@ -2597,6 +2702,87 @@
 	}
 }
 
+void ide_teardown_commandlist(ide_drive_t *drive)
+{
+	struct pci_dev *pdev= drive->channel->pci_dev;
+	struct list_head *entry;
+
+	list_for_each(entry, &drive->free_req) {
+		ata_request_t *ar = list_ata_entry(entry);
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
+	ata_request_t *ar;
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
+		ar = kmalloc(sizeof(ata_request_t), GFP_ATOMIC);
+		if (!ar)
+			break;
+
+		memset(ar, 0, sizeof(ar));
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
@@ -3154,6 +3340,9 @@
 
 			drive->channel->dmaproc(ide_dma_off_quietly, drive);
 			drive->channel->dmaproc(ide_dma_check, drive);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+			drive->channel->dmaproc(ide_dma_queued_on, drive);
+#endif /* CONFIG_BLK_DEV_IDE_TCQ_DEFAULT */
 		}
 		/* Only CD-ROMs and tape drives support DSC overlap. */
 		drive->dsc_overlap = (drive->next != drive
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/pdc202xx.c	Tue Apr  9 11:41:13 2002
+++ linux/drivers/ide/pdc202xx.c	Thu Apr  4 09:39:18 2002
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/include/linux/hdreg.h linux/include/linux/hdreg.h
--- /opt/kernel/linux-2.5.8-pre2/include/linux/hdreg.h	Tue Apr  9 11:41:13 2002
+++ linux/include/linux/hdreg.h	Thu Apr  4 08:14:18 2002
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.5.8-pre2/include/linux/ide.h	Tue Apr  9 11:41:13 2002
+++ linux/include/linux/ide.h	Tue Apr  9 14:14:02 2002
@@ -13,7 +13,9 @@
 #include <linux/proc_fs.h>
 #include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/interrupt.h>
 #include <asm/hdreg.h>
+#include <asm/bitops.h>
 
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
@@ -111,6 +113,7 @@
 #define GET_ERR()		IN_BYTE(IDE_ERROR_REG)
 #define GET_STAT()		IN_BYTE(IDE_STATUS_REG)
 #define GET_ALTSTAT()		IN_BYTE(IDE_CONTROL_REG)
+#define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
 #define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
@@ -132,6 +135,7 @@
  */
 #define PRD_BYTES	8
 #define PRD_ENTRIES	(PAGE_SIZE / (2 * PRD_BYTES))
+#define PRD_SEGMENTS	32
 
 /*
  * Some more useful definitions
@@ -266,6 +270,39 @@
 	} b;
 } special_t;
 
+#define IDE_MAX_TAG	32		/* spec says 32 max */
+
+struct ata_request_s;
+typedef struct ide_tag_info_s {
+	unsigned long tag_mask;		/* next tag bit mask */
+	struct ata_request_s *ar[IDE_MAX_TAG]; /* in-progress requests */
+	int active_tag;			/* current active tag */
+
+	int queued;			/* current depth */
+
+	/*
+	 * stats ->
+	 */
+	int max_depth;			/* max depth ever */
+
+	int max_last_depth;		/* max since last check */
+
+	/*
+	 * either the command complete immediately after being started
+	 * (immed_comp), or the device did a bus release before dma was
+	 * started (immed_rel)
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
@@ -275,11 +312,13 @@
 	char type; /* distingiush different devices: disk, cdrom, tape, floppy, ... */
 
 	/* NOTE: If we had proper separation between channel and host chip, we
-	 * could move this to the chanell and many sync problems would
+	 * could move this to the channel and many sync problems would
 	 * magically just go away.
 	 */
 	request_queue_t	queue;	/* per device request queue */
 
+	struct list_head free_req; /* free ata requests */
+
 	struct ide_drive_s	*next;	/* circular list of hwgroup drives */
 
 	/* Those are directly injected jiffie values. They should go away and
@@ -294,6 +333,7 @@
 	special_t	special;	/* special action flags */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
+	byte	 using_tcq;		/* disk is using queued dma operations*/
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     unmask;		/* flag: okay to unmask other irqs */
@@ -369,6 +409,8 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct device	device;		/* global device tree handle */
+	unsigned int	queue_depth;
+	ide_tag_info_t	*tcq;
 } ide_drive_t;
 
 /*
@@ -387,7 +429,10 @@
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
@@ -462,11 +507,6 @@
 	ide_rw_proc_t	*rwproc;	/* adjust timing based upon rq->cmd direction */
 	ide_ideproc_t   *ideproc;       /* CPU-polled transfer routine */
 	ide_dmaproc_t	*dmaproc;	/* dma read/write/abort routine */
-	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
-	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
-	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
-	int sg_nents;			/* Current number of entries in it */
-	int sg_dma_direction;		/* dma transfer direction */
 	struct ata_channel *mate;	/* other hwif from same PCI chip */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned	dma_extra;	/* extra addr for dma ports */
@@ -505,12 +545,14 @@
  */
 typedef enum {
 	ide_stopped,	/* no drive operation was started */
-	ide_started	/* a drive operation was started, and a handler was set */
+	ide_started,	/* a drive operation was started, and a handler was set */
+	ide_released,	/* started and released bus */
 } ide_startstop_t;
 
 /*
  *  internal ide interrupt handler type
  */
+struct ide_task_s;
 typedef ide_startstop_t (ide_pre_handler_t)(ide_drive_t *, struct request *);
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef ide_startstop_t (ide_post_handler_t)(ide_drive_t *);
@@ -521,8 +563,9 @@
  */
 typedef int (ide_expiry_t)(ide_drive_t *);
 
-#define IDE_BUSY	0
+#define IDE_BUSY	0	/* hwgroup busy */
 #define IDE_SLEEP	1
+#define IDE_DMA		2	/* DMA in progress */
 
 typedef struct hwgroup_s {
 	ide_handler_t		*handler;/* irq handler, if active */
@@ -674,6 +717,7 @@
 
 extern int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs);
 extern int ide_end_request(ide_drive_t *drive, int uptodate);
+extern void ide_end_queued_request(ide_drive_t *drive, int, struct request *);
 
 /*
  * This is used on exit from the driver, to designate the next irq handler
@@ -739,6 +783,7 @@
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
 void ide_init_drive_cmd (struct request *rq);
+void init_taskfile_request(struct request *rq);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -768,8 +813,37 @@
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
+	struct ata_request_s	*ar;
 } ide_task_t;
 
+/*
+ * wrap this on top of struct request
+ */
+typedef struct ata_request_s {
+	struct request		*ar_rq;		/* real request */
+	struct ide_drive_s	*ar_drive;	/* associated drive */
+	unsigned long		ar_flags;	/* ATA_AR_* flags */
+	int			ar_tag;		/* tag number, if any */
+	struct list_head	ar_queue;	/* pending list */
+	ide_task_t		ar_task;	/* associated taskfile */
+	unsigned long		ar_time;
+
+	/*
+	 * dma stuff, pci layer
+	 */
+	struct scatterlist	*ar_sg_table;
+	int			ar_sg_nents;
+	int			ar_sg_ddir;
+
+	/*
+	 * cpu dma stuff
+	 */
+	unsigned int		*ar_dmatable_cpu;
+	dma_addr_t		ar_dmatable;
+} ata_request_t;
+
+#define AR_TASK_CMD(ar)	((ar)->ar_task.taskfile.command)
+
 void ata_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 void ata_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 void atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount);
@@ -886,8 +960,9 @@
 void __init ide_scan_pcibus(int scan_direction);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDMA
-int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func);
+int ide_build_dmatable (ide_drive_t *drive, struct request *rq, ide_dma_action_t func);
 void ide_destroy_dmatable (ide_drive_t *drive);
+int ide_start_dma(struct ata_channel *, ide_drive_t *, ide_dma_action_t);
 ide_startstop_t ide_dma_intr (ide_drive_t *drive);
 int check_drive_lists (ide_drive_t *drive, int good_bad);
 int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
@@ -898,7 +973,102 @@
 
 extern spinlock_t ide_lock;
 
+#define DRIVE_LOCK(drive)	((drive)->queue.queue_lock)
+
 extern int drive_is_ready(ide_drive_t *drive);
 extern void revalidate_drives(void);
 
+/*
+ * TCQ stuff...
+ */
+/*
+ * ata_request_ flag bits
+ */
+#define ATA_AR_QUEUED	1
+#define ATA_AR_SETUP	2
+#define ATA_AR_RETURN	4
+
+#define list_ata_entry(entry) list_entry((entry), ata_request_t, ar_queue)
+
+#define IDE_SET_TAG(drive, ar, tag) do {		\
+	(ar)->ar_flags |= ATA_AR_QUEUED;		\
+	(ar)->ar_tag = (tag);				\
+	(drive)->tcq->ar[(tag)] = (ar); 	 	\
+	(drive)->tcq->active_tag = (tag);		\
+	(ar)->ar_time = jiffies;			\
+	(drive)->tcq->queued++;				\
+} while (0)
+
+#define IDE_CLEAR_TAG(drive, tag) do {			\
+	(drive)->tcq->ar[(tag)] = NULL;			\
+	__clear_bit((tag), &(drive)->tcq->tag_mask);	\
+	(drive)->tcq->queued--;				\
+} while (0)
+
+#define ATA_AR_INIT(drive, ar) do {				\
+	(ar)->ar_rq = NULL;					\
+	(ar)->ar_drive = (drive);				\
+	(ar)->ar_flags = 0;					\
+	(ar)->ar_tag = 0;					\
+	memset(&(ar)->ar_task, 0, sizeof(ide_task_t));		\
+	(ar)->ar_sg_nents = 0;					\
+	(ar)->ar_sg_ddir = 0;					\
+} while (0)
+
+/*
+ * return a free command, automatically add it to busy list
+ */
+extern inline ata_request_t *ata_ar_get(ide_drive_t *drive)
+{
+	ata_request_t *ar = NULL;
+
+	if (drive->tcq && drive->tcq->queued >= drive->queue_depth)
+		return NULL;
+
+	if (!list_empty(&drive->free_req)) {
+		ar = list_ata_entry(drive->free_req.next);
+		list_del(&ar->ar_queue);
+		ATA_AR_INIT(drive, ar);
+	}
+
+	return ar;
+}
+
+extern inline void ata_ar_put(ide_drive_t *drive, ata_request_t *ar)
+{
+	list_add(&ar->ar_queue, &drive->free_req);
+
+	if (ar->ar_flags & ATA_AR_QUEUED)
+		IDE_CLEAR_TAG(drive, ar->ar_tag);
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
+#define ide_pending_commands(drive)	((drive)->using_tcq && (drive)->tcq->queued)
+#else
+#define ide_pending_commands(drive)	0
+#endif
+
+int ide_build_commandlist(ide_drive_t *);
+void ide_teardown_commandlist(ide_drive_t *);
+int ide_tcq_dmaproc(ide_dma_action_t, ide_drive_t *);
+ide_startstop_t ide_start_tag(ide_dma_action_t, ide_drive_t *, ata_request_t *);
+
 #endif /* _IDE_H */

-- 
Jens Axboe

