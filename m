Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFFVMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFFVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:12:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53172 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262283AbTFFVMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:12:32 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] IDE Power Management, try 3
Date: Fri, 6 Jun 2003 23:25:23 +0200
User-Agent: KMail/1.4.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306062325.23317.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have corrected it a bit and I am going to submit it, any comments?

Ben, can you verify my changes and check that it still works after 'fixing'?
:-)

List of (trivial) changes:
- in generic_ide_resume(): memset() &rqpm, not &args
- don't check for drive->id, it is always present
- in -bk tree __blk_stop_queue() is gone and blk_[start,stop]_queue()
  has to be called with queue lock held, so update ide_complete_pm_request()
- fix ide_wait_not_busy() for stat == 0xff (previously returned -EBUSY)
- export ide_wait_not_busy(), it is used by ide-probe-mod when ide is modular
- readd #ifdef CONFIG_PPC around wait_hwif_ready() for now
- make pm_state u32 (was int) to match ->suspend() and ->resume()
- blk_request_is_pm() -> blk_pm_request() to match blkdev.h naming scheme
- add blk_pm_suspend_request() and blk_pm_resume_request() macros
- coding style and whitespace fixups

Incremental patch:
http://home.elka.pw.edu.pl/~bzolnier/ide-pm-3-4.patch

--
Bartlomiej


IDE Power Management

Patch by Benjamin Herrenschmidt, minor fixes by me.

 drivers/ide/ide-cd.c    |   45 +++++++++++++++++++
 drivers/ide/ide-disk.c  |  112 ++++++++++++++++++++++++++++--------------------
 drivers/ide/ide-io.c    |  110 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/ide/ide-iops.c  |   28 ++++++++++++
 drivers/ide/ide-probe.c |   36 +--------------
 drivers/ide/ide.c       |   48 ++++++++++++++++++++
 include/linux/blkdev.h  |   33 ++++++++++++++
 include/linux/ide.h     |   41 +++++++++++++++++
 8 files changed, 372 insertions(+), 81 deletions(-)

diff -puN drivers/ide/ide.c~ide-pm-4 drivers/ide/ide.c
--- linux-2.5.70-bk11/drivers/ide/ide.c~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide.c	Fri Jun  6 22:12:42 2003
@@ -1441,6 +1441,54 @@ int ata_attach(ide_drive_t *drive)
 
 EXPORT_SYMBOL(ata_attach);
 
+int generic_ide_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+	struct request rq;
+	struct request_pm_state rqpm;
+	ide_task_t args;
+
+	if (level == dev->power_state || level != SUSPEND_SAVE_STATE)
+		return 0;
+
+	memset(&rq, 0, sizeof(rq));
+	memset(&rqpm, 0, sizeof(rqpm));
+	memset(&args, 0, sizeof(args));
+	rq.flags = REQ_PM_SUSPEND;
+	rq.special = &args;
+	rq.pm = &rqpm;
+	rqpm.pm_step = ide_pm_state_start_suspend;
+	rqpm.pm_state = state;
+
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
+}
+
+EXPORT_SYMBOL(generic_ide_suspend);
+
+int generic_ide_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+	struct request rq;
+	struct request_pm_state rqpm;
+	ide_task_t args;
+
+	if (level == dev->power_state || level != RESUME_RESTORE_STATE)
+		return 0;
+
+	memset(&rq, 0, sizeof(rq));
+	memset(&rqpm, 0, sizeof(rqpm));
+	memset(&args, 0, sizeof(args));
+	rq.flags = REQ_PM_RESUME;
+	rq.special = &args;
+	rq.pm = &rqpm;
+	rqpm.pm_step = ide_pm_state_start_resume;
+	rqpm.pm_state = 0;
+
+	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+}
+
+EXPORT_SYMBOL(generic_ide_resume);
+
 int generic_ide_ioctl(struct block_device *bdev, unsigned int cmd,
 			unsigned long arg)
 {
diff -puN drivers/ide/ide-cd.c~ide-pm-4 drivers/ide/ide-cd.c
--- linux-2.5.70-bk11/drivers/ide/ide-cd.c~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-cd.c	Fri Jun  6 22:18:01 2003
@@ -3253,6 +3253,45 @@ int ide_cdrom_cleanup(ide_drive_t *drive
 
 static int ide_cdrom_attach (ide_drive_t *drive);
 
+/*
+ * Power Management state machine.
+ *
+ * We don't do much for CDs right now.
+ */
+
+static void ide_cdrom_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
+{
+}
+
+static ide_startstop_t ide_cdrom_start_power_step (ide_drive_t *drive, struct request *rq)
+{
+	ide_task_t *args = rq->special;
+
+	memset(args, 0, sizeof(*args));
+
+	switch (rq->pm->pm_step) {
+	case ide_pm_state_start_suspend:
+		break;
+
+	case ide_pm_state_start_resume:	/* Resume step 1 (restore DMA) */
+		/*
+		 * Right now, all we do is call hwif->ide_dma_check(drive),
+		 * we could be smarter and check for current xfer_speed
+		 * in struct drive etc...
+		 * Also, this step could be implemented as a generic helper
+		 * as most subdrivers will use it.
+		 */
+		if ((drive->id->capability & 1) == 0)
+			break;
+		if (HWIF(drive)->ide_dma_check == NULL)
+			break;
+		HWIF(drive)->ide_dma_check(drive);
+		break;
+	}
+	rq->pm->pm_step = ide_pm_state_completed;
+	return ide_stopped;
+}
+
 static ide_driver_t ide_cdrom_driver = {
 	.owner			= THIS_MODULE,
 	.name			= "ide-cdrom",
@@ -3269,6 +3308,12 @@ static ide_driver_t ide_cdrom_driver = {
 	.capacity		= ide_cdrom_capacity,
 	.attach			= ide_cdrom_attach,
 	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
+	.start_power_step	= ide_cdrom_start_power_step,
+	.complete_power_step	= ide_cdrom_complete_power_step,
+	.gen_driver		= {
+		.suspend	= generic_ide_suspend,
+		.resume		= generic_ide_resume,
+	}
 };
 
 static int idecd_open(struct inode * inode, struct file * file)
diff -puN drivers/ide/ide-disk.c~ide-pm-4 drivers/ide/ide-disk.c
--- linux-2.5.70-bk11/drivers/ide/ide-disk.c~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-disk.c	Fri Jun  6 22:18:23 2003
@@ -138,8 +138,6 @@ static int idedisk_start_tag(ide_drive_t
 
 #ifndef CONFIG_IDE_TASKFILE_IO
 
-static int driver_blocked;
-
 /*
  * read_intr() is the handler for disk read/multread interrupts
  */
@@ -364,9 +362,6 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
-	if (driver_blocked)
-		panic("Request while ide driver is blocked?");
-
 	if (drive->using_tcq && idedisk_start_tag(drive, rq)) {
 		if (!ata_pending_commands(drive))
 			BUG();
@@ -1392,21 +1387,6 @@ static int write_cache (ide_drive_t *dri
 	return 0;
 }
 
-static int call_idedisk_standby (ide_drive_t *drive, int arg)
-{
-	ide_task_t args;
-	u8 standby = (arg) ? WIN_STANDBYNOW2 : WIN_STANDBYNOW1;
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_COMMAND_OFFSET]	= standby;
-	args.command_type			= ide_cmd_type_parser(&args);
-	return ide_raw_taskfile(drive, &args, NULL);
-}
-
-static int do_idedisk_standby (ide_drive_t *drive)
-{
-	return call_idedisk_standby(drive, 0);
-}
-
 static int do_idedisk_flushcache (ide_drive_t *drive)
 {
 	ide_task_t args;
@@ -1505,37 +1485,75 @@ static void idedisk_add_settings(ide_dri
 #endif
 }
 
-static int idedisk_suspend(struct device *dev, u32 state, u32 level)
-{
-	ide_drive_t *drive = dev->driver_data;
-
-	printk("Suspending device %p\n", dev->driver_data);
-
-	/* I hope that every freeze operation from the upper levels have
-	 * already been done...
-	 */
+/*
+ * Power Management state machine. This one is rather trivial for now,
+ * we should probably add more, like switching back to PIO on suspend
+ * to help some BIOSes, re-do the door locking on resume, etc...
+ */
 
-	if (level != SUSPEND_SAVE_STATE)
-		return 0;
+enum {
+	idedisk_pm_flush_cache	= ide_pm_state_start_suspend,
+	idedisk_pm_standby,
 
-	/* set the drive to standby */
-	printk(KERN_INFO "suspending: %s ", drive->name);
-	do_idedisk_standby(drive);
-	drive->blocked = 1;
+	idedisk_pm_restore_dma	= ide_pm_state_start_resume,
+};
 
-	BUG_ON (HWGROUP(drive)->handler);
-	return 0;
+static void idedisk_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
+{
+	switch (rq->pm->pm_step) {
+	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
+		if (rq->pm->pm_state == 4)
+			rq->pm->pm_step = ide_pm_state_completed;
+		else
+			rq->pm->pm_step = idedisk_pm_standby;
+		break;
+	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
+		rq->pm->pm_step = ide_pm_state_completed;
+		break;
+	}
 }
 
-static int idedisk_resume(struct device *dev, u32 level)
+static ide_startstop_t idedisk_start_power_step (ide_drive_t *drive, struct request *rq)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_task_t *args = rq->special;
 
-	if (level != RESUME_RESTORE_STATE)
-		return 0;
-	BUG_ON(!drive->blocked);
-	drive->blocked = 0;
-	return 0;
+	memset(args, 0, sizeof(*args));
+
+	switch (rq->pm->pm_step) {
+	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) */
+		/* Not supported? Switch to next step now. */
+		if (!drive->wcache) {
+			idedisk_complete_power_step(drive, rq, 0, 0);
+			return ide_stopped;
+		}
+		if (drive->id->cfs_enable_2 & 0x2400)
+			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+		else
+			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+		args->command_type = ide_cmd_type_parser(args);
+		return do_rw_taskfile(drive, args);
+	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
+		args->command_type = ide_cmd_type_parser(args);
+		return do_rw_taskfile(drive, args);
+
+	case idedisk_pm_restore_dma:	/* Resume step 1 (restore DMA) */
+		/*
+		 * Right now, all we do is call hwif->ide_dma_check(drive),
+		 * we could be smarter and check for current xfer_speed
+		 * in struct drive etc...
+		 * Also, this step could be implemented as a generic helper
+		 * as most subdrivers will use it
+		 */
+		if ((drive->id->capability & 1) == 0)
+			break;
+		if (HWIF(drive)->ide_dma_check == NULL)
+			break;
+		HWIF(drive)->ide_dma_check(drive);
+		break;
+	}
+	rq->pm->pm_step = ide_pm_state_completed;
+	return ide_stopped;
 }
 
 static void idedisk_setup (ide_drive_t *drive)
@@ -1681,9 +1699,11 @@ static ide_driver_t idedisk_driver = {
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
+	.start_power_step	= idedisk_start_power_step,
+	.complete_power_step	= idedisk_complete_power_step,
 	.gen_driver		= {
-		.suspend	= idedisk_suspend,
-		.resume		= idedisk_resume,
+		.suspend	= generic_ide_suspend,
+		.resume		= generic_ide_resume,
 	}
 };
 
diff -puN drivers/ide/ide-io.c~ide-pm-4 drivers/ide/ide-io.c
--- linux-2.5.70-bk11/drivers/ide/ide-io.c~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-io.c	Fri Jun  6 22:11:10 2003
@@ -139,6 +139,35 @@ int ide_end_request (ide_drive_t *drive,
 EXPORT_SYMBOL(ide_end_request);
 
 /**
+ *	ide_complete_pm_request - end the current Power Management request
+ *	@drive: target drive
+ *	@rq: request
+ *
+ *	This function cleans up the current PM request and stops the queue
+ *	if necessary.
+ */
+static void ide_complete_pm_request (ide_drive_t *drive, struct request *rq)
+{
+	unsigned long flags;
+
+#ifdef DEBUG_PM
+	printk("%s: completing PM request, %s\n", drive->name,
+	       blk_pm_suspend_request(rq) ? "suspend" : "resume");
+#endif
+	spin_lock_irqsave(&ide_lock, flags);
+	if (blk_pm_suspend_request(rq)) {
+		blk_stop_queue(&drive->queue);
+	} else {
+		drive->blocked = 0;
+		blk_start_queue(&drive->queue);
+	}
+	blkdev_dequeue_request(rq);
+	HWGROUP(drive)->rq = NULL;
+	end_that_request_last(rq);
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+/**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
  *	@stat: status bits
@@ -214,6 +243,15 @@ void ide_end_drive_cmd (ide_drive_t *dri
 				args->hobRegister[IDE_HCYL_OFFSET_HOB]    = hwif->INB(IDE_HCYL_REG);
 			}
 		}
+	} else if (blk_pm_request(rq)) {
+#ifdef DEBUG_PM
+		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
+			drive->name, rq->pm->pm_step, stat, err);
+#endif
+		DRIVER(drive)->complete_power_step(drive, rq, stat, err);
+		if (rq->pm->pm_step == ide_pm_state_completed)
+			ide_complete_pm_request(drive, rq);
+		return;
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
@@ -615,6 +653,34 @@ ide_startstop_t start_request (ide_drive
 	while ((read_timer() - HWIF(drive)->last_time) < DISK_RECOVERY_TIME);
 #endif
 
+	if (blk_pm_suspend_request(rq) &&
+	    rq->pm->pm_step == ide_pm_state_start_suspend)
+		/* Mark drive blocked when starting the suspend sequence. */
+		drive->blocked = 1;
+	else if (blk_pm_resume_request(rq) &&
+		 rq->pm->pm_step == ide_pm_state_start_resume) {
+		/* 
+		 * The first thing we do on wakeup is to wait for BSY bit to
+		 * go away (with a looong timeout) as a drive on this hwif may
+		 * just be POSTing itself.
+		 * We do that before even selecting as the "other" device on
+		 * the bus may be broken enough to walk on our toes at this
+		 * point.
+		 */
+		int rc;
+#ifdef DEBUG_PM
+		printk("%s: Wakeup request inited, waiting for !BSY...\n", drive->name);
+#endif
+		rc = ide_wait_not_busy(HWIF(drive), 35000);
+		if (rc)
+			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
+		SELECT_DRIVE(drive);
+		HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
+		rc = ide_wait_not_busy(HWIF(drive), 10000);
+		if (rc)
+			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
+	}
+
 	SELECT_DRIVE(drive);
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat, BUSY_STAT|DRQ_STAT, WAIT_READY)) {
 		printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
@@ -625,6 +691,17 @@ ide_startstop_t start_request (ide_drive
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
+		else if (blk_pm_request(rq)) {
+#ifdef DEBUG_PM
+			printk("%s: start_power_step(step: %d)\n",
+				drive->name, rq->pm->pm_step);
+#endif
+			startstop = DRIVER(drive)->start_power_step(drive, rq);
+			if (startstop == ide_stopped &&
+			    rq->pm->pm_step == ide_pm_state_completed)
+				ide_complete_pm_request(drive, rq);
+			return startstop;
+		}
 		return (DRIVER(drive)->do_request(drive, rq, block));
 	}
 	return do_special(drive);
@@ -837,6 +914,28 @@ queue_next:
 			break;
 		}
 
+		/*
+		 * Sanity: don't accept a request that isn't a PM request
+		 * if we are currently power managed. This is very important as
+		 * blk_stop_queue() doesn't prevent the elv_next_request()
+		 * above to return us whatever is in the queue. Since we call
+		 * ide_do_request() ourselves, we end up taking requests while
+		 * the queue is blocked...
+		 * 
+		 * We let requests forced at head of queue with ide-preempt
+		 * though. I hope that doesn't happen too much, hopefully not
+		 * unless the subdriver triggers such a thing in it's own PM
+		 * state machine.
+		 */
+		if (drive->blocked && !blk_pm_request(rq) && !(rq->flags & REQ_PREEMPT)) {
+#ifdef DEBUG_PM
+			printk("%s: a request made it's way while we are power managing...\n", drive->name);
+#endif
+			/* We clear busy, there should be no pending ATA command at this point. */
+			hwgroup->busy = 0;
+			break;
+		}
+
 		if (!rq->bio && ata_pending_commands(drive))
 			break;
 
@@ -1282,12 +1381,16 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	DECLARE_COMPLETION(wait);
 	int insert_end = 1, err;
+	int must_wait = (action == ide_wait || action == ide_head_wait);
 
 #ifdef CONFIG_BLK_DEV_PDC4030
 	/*
 	 *	FIXME: there should be a drive or hwif->special
 	 *	handler that points here by default, not hacks
 	 *	in the ide-io.c code
+	 *
+	 *	FIXME2: That code breaks power management if used with
+	 *	this chipset, that really doesn't belong here !
 	 */
 	if (HWIF(drive)->chipset == ide_pdc4030 && rq->buffer != NULL)
 		return -ENOSYS;  /* special drive cmds not supported */
@@ -1301,22 +1404,23 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	 * we need to hold an extra reference to request for safe inspection
 	 * after completion
 	 */
-	if (action == ide_wait) {
+	if (must_wait) {
 		rq->ref_count++;
 		rq->waiting = &wait;
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
-	if (action == ide_preempt) {
+	if (action == ide_preempt || action == ide_head_wait) {
 		hwgroup->rq = NULL;
 		insert_end = 0;
+		rq->flags |= REQ_PREEMPT;
 	}
 	__elv_add_request(&drive->queue, rq, insert_end, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	err = 0;
-	if (action == ide_wait) {
+	if (must_wait) {
 		wait_for_completion(&wait);
 		if (rq->errors)
 			err = -EIO;
diff -puN drivers/ide/ide-iops.c~ide-pm-4 drivers/ide/ide-iops.c
--- linux-2.5.70-bk11/drivers/ide/ide-iops.c~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-iops.c	Fri Jun  6 19:28:30 2003
@@ -1320,3 +1320,31 @@ ide_startstop_t ide_do_reset (ide_drive_
 
 EXPORT_SYMBOL(ide_do_reset);
 
+/*
+ * ide_wait_not_busy() waits for the currently selected device on the hwif
+ * to report a non-busy status, see comments in probe_hwif().
+ */
+int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
+{
+	u8 stat = 0;
+
+	while(timeout--) {
+		/*
+		 * Turn this into a schedule() sleep once I'm sure
+		 * about locking issues (2.5 work ?).
+		 */
+		mdelay(1);
+		stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		/*
+		 * Assume a value of 0xff means nothing is connected to
+		 * the interface and it doesn't implement the pull-down
+		 * resistor on D7.
+		 */
+		if ((stat & BUSY_STAT) == 0 || stat == 0xff)
+			return 0;
+	}
+	return -EBUSY;
+}
+
+EXPORT_SYMBOL_GPL(ide_wait_not_busy);
+
diff -puN drivers/ide/ide-probe.c~ide-pm-4 drivers/ide/ide-probe.c
--- linux-2.5.70-bk11/drivers/ide/ide-probe.c~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-probe.c	Fri Jun  6 19:29:07 2003
@@ -723,35 +723,7 @@ static void hwif_register (ide_hwif_t *h
 
 //EXPORT_SYMBOL(hwif_register);
 
-/* Enable code below on all archs later, for now, I want it on PPC
- */
 #ifdef CONFIG_PPC
-/*
- * This function waits for the hwif to report a non-busy status
- * see comments in probe_hwif()
- */
-static int wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
-{
-	u8 stat = 0;
-	
-	while(timeout--) {
-		/* Turn this into a schedule() sleep once I'm sure
-		 * about locking issues (2.5 work ?)
-		 */
-		mdelay(1);
-		stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
-		if ((stat & BUSY_STAT) == 0)
-			break;
-		/* Assume a value of 0xff means nothing is connected to
-		 * the interface and it doesn't implement the pull-down
-		 * resistor on D7
-		 */
-		if (stat == 0xff)
-			break;
-	}
-	return ((stat & BUSY_STAT) == 0) ? 0 : -EBUSY;
-}
-
 static int wait_hwif_ready(ide_hwif_t *hwif)
 {
 	int rc;
@@ -766,7 +738,7 @@ static int wait_hwif_ready(ide_hwif_t *h
 	 * I know of at least one disk who takes 31 seconds, I use 35
 	 * here to be safe
 	 */
-	rc = wait_not_busy(hwif, 35000);
+	rc = ide_wait_not_busy(hwif, 35000);
 	if (rc)
 		return rc;
 
@@ -774,20 +746,20 @@ static int wait_hwif_ready(ide_hwif_t *h
 	SELECT_DRIVE(&hwif->drives[0]);
 	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 	mdelay(2);
-	rc = wait_not_busy(hwif, 10000);
+	rc = ide_wait_not_busy(hwif, 10000);
 	if (rc)
 		return rc;
 	SELECT_DRIVE(&hwif->drives[1]);
 	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 	mdelay(2);
-	rc = wait_not_busy(hwif, 10000);
+	rc = ide_wait_not_busy(hwif, 10000);
 
 	/* Exit function with master reselected (let's be sane) */
 	SELECT_DRIVE(&hwif->drives[0]);
 	
 	return rc;
 }
-#endif /* CONFIG_PPC */
+#endif
 
 /*
  * This routine only knows how to look for drive units 0 and 1
diff -puN include/linux/blkdev.h~ide-pm-4 include/linux/blkdev.h
--- linux-2.5.70-bk11/include/linux/blkdev.h~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/include/linux/blkdev.h	Fri Jun  6 23:09:44 2003
@@ -19,6 +19,7 @@ struct request_queue;
 typedef struct request_queue request_queue_t;
 struct elevator_s;
 typedef struct elevator_s elevator_t;
+struct request_pm_state;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128
@@ -102,6 +103,11 @@ struct request {
 	void *sense;
 
 	unsigned int timeout;
+
+	/*
+	 * For Power Management requests
+	 */
+	struct request_pm_state *pm;
 };
 
 /*
@@ -130,6 +136,10 @@ enum rq_flag_bits {
 	__REQ_DRIVE_CMD,
 	__REQ_DRIVE_TASK,
 	__REQ_DRIVE_TASKFILE,
+	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
+	__REQ_PM_SUSPEND,	/* suspend request */
+	__REQ_PM_RESUME,	/* resume request */
+	__REQ_PM_SHUTDOWN,	/* shutdown request */
 	__REQ_NR_BITS,	/* stops here */
 };
 
@@ -151,6 +161,23 @@ enum rq_flag_bits {
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
 #define REQ_DRIVE_TASK	(1 << __REQ_DRIVE_TASK)
 #define REQ_DRIVE_TASKFILE	(1 << __REQ_DRIVE_TASKFILE)
+#define REQ_PREEMPT	(1 << __REQ_PREEMPT)
+#define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
+#define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
+#define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
+
+/*
+ * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
+ * requests. Some step values could eventually be made generic.
+ */
+struct request_pm_state
+{
+	/* PM state machine step value, currently driver specific */
+	int	pm_step;
+	/* requested PM state value (S1, S2, S3, S4, ...) */
+	u32	pm_state;
+	void*	data;		/* for driver use */
+};
 
 #include <linux/elevator.h>
 
@@ -277,6 +304,12 @@ struct request_queue
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
+
+#define blk_pm_suspend_request(rq)	((rq)->flags & REQ_PM_SUSPEND)
+#define blk_pm_resume_request(rq)	((rq)->flags & REQ_PM_RESUME)
+#define blk_pm_request(rq)	\
+	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
+
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		((rq)->flags & 1)
diff -puN include/linux/ide.h~ide-pm-4 include/linux/ide.h
--- linux-2.5.70-bk11/include/linux/ide.h~ide-pm-4	Fri Jun  6 18:46:53 2003
+++ linux-2.5.70-bk11-root/include/linux/ide.h	Fri Jun  6 23:21:06 2003
@@ -23,6 +23,8 @@
 #include <asm/hdreg.h>
 #include <asm/io.h>
 
+#define DEBUG_PM
+
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
  * It supports up to four IDE interfaces, on one or more IRQs (usually 14 & 15).
@@ -1143,6 +1145,39 @@ read_proc_t proc_ide_read_geometry;
 #endif
 
 /*
+ * Power Management step value (rq->pm->pm_step).
+ *
+ * The step value starts at 0 (ide_pm_state_start_suspend) for a
+ * suspend operation or 1000 (ide_pm_state_start_resume) for a
+ * resume operation.
+ *
+ * For each step, the core calls the subdriver start_power_step() first.
+ * This can return:
+ *	- ide_stopped :	In this case, the core calls us back again unless
+ *			step have been set to ide_power_state_completed.
+ *	- ide_started :	In this case, the channel is left busy until an
+ *			async event (interrupt) occurs.
+ * Typically, start_power_step() will issue a taskfile request with
+ * do_rw_taskfile().
+ *
+ * Upon reception of the interrupt, the core will call complete_power_step()
+ * with the error code if any. This routine should update the step value
+ * and return. It should not start a new request. The core will call
+ * start_power_step for the new step value, unless step have been set to
+ * ide_power_state_completed.
+ *
+ * Subdrivers are expected to define their own additional power
+ * steps from 1..999 for suspend and from 1001..1999 for resume,
+ * other values are reserved for future use.
+ */
+
+enum {
+	ide_pm_state_completed		= -1,
+	ide_pm_state_start_suspend	= 0,
+	ide_pm_state_start_resume	= 1000,
+};
+
+/*
  * Subdrivers support.
  */
 #define IDE_SUBDRIVER_VERSION	1
@@ -1171,6 +1206,8 @@ typedef struct ide_driver_s {
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
+	ide_startstop_t	(*start_power_step)(ide_drive_t *, struct request *);
+	void		(*complete_power_step)(ide_drive_t *, struct request *, u8, u8);
 	struct device_driver	gen_driver;
 	struct list_head drives;
 	struct list_head drivers;
@@ -1179,6 +1216,8 @@ typedef struct ide_driver_s {
 #define DRIVER(drive)		((drive)->driver)
 
 extern int generic_ide_ioctl(struct block_device *, unsigned, unsigned long);
+extern int generic_ide_suspend(struct device *dev, u32 state, u32 level);
+extern int generic_ide_resume(struct device *dev, u32 level);
 
 /*
  * IDE modules.
@@ -1320,6 +1359,7 @@ typedef enum {
 	ide_wait,	/* insert rq at end of list, and wait for it */
 	ide_next,	/* insert rq immediately after current request */
 	ide_preempt,	/* insert rq in front of current request */
+	ide_head_wait,	/* insert rq in front of current request and wait for it */
 	ide_end		/* insert rq at end of list, but don't wait for it */
 } ide_action_t;
 
@@ -1530,6 +1570,7 @@ extern u8 eighty_ninty_three (ide_drive_
 extern int set_transfer(ide_drive_t *, ide_task_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
 
+extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
 ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block);
 
 /*

_

