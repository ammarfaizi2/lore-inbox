Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTFDNBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTFDNBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:01:46 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:54491 "EHLO gaston")
	by vger.kernel.org with ESMTP id S262763AbTFDNBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:01:32 -0400
Subject: IDE Power Management (Was: software suspend in 2.5.70-mm3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hugang <hugang@soulinfo.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054659866.20839.10.camel@gaston>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	 <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk>
	 <20030603223511.155ea2cc.hugang@soulinfo.com>
	 <1054649308.9233.26.camel@dhcp22.swansea.linux.org.uk>
	 <1054659866.20839.10.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054732481.20839.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Jun 2003 15:14:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 19:04, Benjamin Herrenschmidt wrote:
> On Tue, 2003-06-03 at 16:08, Alan Cox wrote:

> > Still races. Ben's stuff is needed
> 
> I have it working with some fixes from what I sent earlier, I'll
> repost that tonight or tomorrow, I need to extract that from
> a half-broken tree ;)

Ok, here is it. It still need a bit of cleanup (removal of magic
number for "steps" -> enum, etc...) and we may want to do more
things on wakeup especially for ide-cd, Also I don't deal with
ide-tape or ide-floppy in there and haven't fully studied the
impact with ide-scsi....

So it's not meant to be merged as-is, though I'd appreciate to
know if it helps for you.

Bartolomiej: Any comments appreciated, I won't do the ide-tape/floppy
part as I don't know/own these, I think i'll let you decide if
anything more is needed on the wakeup path for ide-cd... Once I
have enough feedback, I'll send you a cleanified version as
candidate for upstream merge.

===== drivers/ide/ide-cd.c 1.49 vs edited =====
--- 1.49/drivers/ide/ide-cd.c	Sun Jun  1 21:55:45 2003
+++ edited/drivers/ide/ide-cd.c	Wed Jun  4 14:53:38 2003
@@ -3253,6 +3253,46 @@
 
 static int ide_cdrom_attach (ide_drive_t *drive);
 
+static void ide_cdrom_complete_power_step (ide_drive_t *drive, ide_power_state_t *state, u8 stat, u8 error)
+{
+}
+
+/* Power Management state machine. 
+ *
+ * We don't do much for CDs right now
+ */
+static ide_startstop_t ide_cdrom_start_power_step (ide_drive_t *drive, ide_power_state_t *state)
+{
+	ide_task_t args;
+
+	memset(&args, 0, sizeof(ide_task_t));
+
+	if (state->step == 0) {
+		state->step = state->suspend ? 1 : 101;
+		return ide_stopped;
+	}
+	switch(state->step) {
+	case 1:
+		break;
+
+	case 101: /* Resume step 1 (restore DMA) */
+		/* Right now, all we do is call ide_dma_check for the HWIF,
+		 * we could be smarter and check for current xfer_speed
+		 * in struct drive etc...
+		 * Also, this step could be implemented as a generic helper
+		 * as most subdrivers will use it
+		 */
+		if (!drive->id || !(drive->id->capability & 1))
+			break;
+		if (HWIF(drive)->ide_dma_check == NULL)
+			break;
+		HWIF(drive)->ide_dma_check(drive);
+		break;
+	}
+	state->step = ide_power_state_completed;
+	return ide_stopped;
+}
+
 static ide_driver_t ide_cdrom_driver = {
 	.owner			= THIS_MODULE,
 	.name			= "ide-cdrom",
@@ -3269,6 +3309,12 @@
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
===== drivers/ide/ide-disk.c 1.45 vs edited =====
--- 1.45/drivers/ide/ide-disk.c	Sun Jun  1 21:55:48 2003
+++ edited/drivers/ide/ide-disk.c	Wed Jun  4 14:54:24 2003
@@ -138,8 +138,6 @@
 
 #ifndef CONFIG_IDE_TASKFILE_IO
 
-static int driver_blocked;
-
 /*
  * read_intr() is the handler for disk read/multread interrupts
  */
@@ -364,9 +362,6 @@
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
-	if (driver_blocked)
-		panic("Request while ide driver is blocked?");
-
 	if (drive->using_tcq && idedisk_start_tag(drive, rq)) {
 		if (!ata_pending_commands(drive))
 			BUG();
@@ -1392,21 +1387,6 @@
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
@@ -1505,37 +1485,66 @@
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
-
-	if (level != SUSPEND_SAVE_STATE)
-		return 0;
-
-	/* set the drive to standby */
-	printk(KERN_INFO "suspending: %s ", drive->name);
-	do_idedisk_standby(drive);
-	drive->blocked = 1;
 
-	BUG_ON (HWGROUP(drive)->handler);
-	return 0;
+static void idedisk_complete_power_step (ide_drive_t *drive, ide_power_state_t *state, u8 stat, u8 error)
+{
+	switch(state->step) {
+	case 1: /* Suspend step 1 (flush cache) complete */
+		state->step = 2;
+		break;
+	case 2: /* Suspend step 2 (standby) complete */
+		state->step = ide_power_state_completed;
+		break;
+	}
 }
 
-static int idedisk_resume(struct device *dev, u32 level)
+/* Power Management state machine. This one is rather trivial for now,
+ * we should probably add more, like switching back to PIO on suspend
+ * to help some BIOSes, re-do the door locking on resume, etc...
+ */
+static ide_startstop_t idedisk_start_power_step (ide_drive_t *drive, ide_power_state_t *state)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_task_t args;
 
-	if (level != RESUME_RESTORE_STATE)
-		return 0;
-	BUG_ON(!drive->blocked);
-	drive->blocked = 0;
-	return 0;
+	memset(&args, 0, sizeof(ide_task_t));
+
+	if (state->step == 0) {
+		state->step = state->suspend ? 1 : 101;
+		return ide_stopped;
+	}
+	switch(state->step) {
+	case 1: /* Suspend step 1 (flush cache) */
+		if (!drive->wcache) {
+			idedisk_complete_power_step(drive, state, 0, 0);
+			return ide_stopped;
+		}
+		if (drive->id->cfs_enable_2 & 0x2400)
+			args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
+		else
+			args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
+		args.command_type		 		= ide_cmd_type_parser(&args);
+		return do_rw_taskfile(drive, &args);
+	case 2: /* Suspend step 2 (standby) */
+		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_STANDBYNOW1;
+		args.command_type			= ide_cmd_type_parser(&args);
+		return do_rw_taskfile(drive, &args);
+
+	case 101: /* Resume step 1 (restore DMA) */
+		/* Right now, all we do is call ide_dma_check for the HWIF,
+		 * we could be smarter and check for current xfer_speed
+		 * in struct drive etc...
+		 * Also, this step could be implemented as a generic helper
+		 * as most subdrivers will use it
+		 */
+		if (!drive->id || !(drive->id->capability & 1))
+			break;
+		if (HWIF(drive)->ide_dma_check == NULL)
+			break;
+		HWIF(drive)->ide_dma_check(drive);
+		break;
+	}
+	state->step = ide_power_state_completed;
+	return ide_stopped;
 }
 
 static void idedisk_setup (ide_drive_t *drive)
@@ -1681,9 +1690,11 @@
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
 
===== drivers/ide/ide-io.c 1.11 vs edited =====
--- 1.11/drivers/ide/ide-io.c	Mon May 12 02:09:46 2003
+++ edited/drivers/ide/ide-io.c	Wed Jun  4 14:55:06 2003
@@ -139,6 +139,39 @@
 EXPORT_SYMBOL(ide_end_request);
 
 /**
+ *	ide_complete_pm_request	-	end the current Power Management request
+ *	@drive: target drive 
+ *	@rq: request
+ *
+ *	This function cleans up the current PM request and stops the queue
+ *	if necessary. 
+ */
+ 
+static void ide_complete_pm_request (ide_drive_t *drive, struct request *rq)
+{
+	ide_power_state_t *state = (ide_power_state_t *)rq->special;
+	unsigned long flags;
+	int suspend = state->suspend;
+
+#ifdef DEBUG_PM
+	printk("%s: completing PM request, suspend: %d\n", drive->name, state->suspend);
+#endif	
+	spin_lock_irqsave(&ide_lock, flags);
+	if (suspend)
+		__blk_stop_queue(&drive->queue);
+	else
+		drive->blocked = 0;
+	blkdev_dequeue_request(rq);
+	HWGROUP(drive)->rq = NULL;
+	end_that_request_last(rq);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	/* Hrm... there is no __blk_start_queue... */
+	if (!suspend)
+		blk_start_queue(&drive->queue);
+}
+
+
+/**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
  *	@stat: status bits
@@ -214,6 +247,17 @@
 				args->hobRegister[IDE_HCYL_OFFSET_HOB]    = hwif->INB(IDE_HCYL_REG);
 			}
 		}
+	} else if (rq->flags & REQ_POWER_MANAGEMENT) {
+		ide_power_state_t *state = (ide_power_state_t *)rq->special;
+
+#ifdef DEBUG_PM
+		printk("%s: complete_power_step(susp: %d, step: %d, stat: %x, err: %x)\n",
+			drive->name, state->suspend, state->step, stat, err);
+#endif
+		DRIVER(drive)->complete_power_step(drive, state, stat, err);
+		if (state->step == ide_power_state_completed)
+			ide_complete_pm_request(drive, rq);
+		return;
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
@@ -615,7 +659,37 @@
 	while ((read_timer() - HWIF(drive)->last_time) < DISK_RECOVERY_TIME);
 #endif
 
-	SELECT_DRIVE(drive);
+	if (rq->flags & REQ_POWER_MANAGEMENT) {
+		ide_power_state_t *state = (ide_power_state_t *)rq->special;
+		int rc;
+
+		/* Mark drive blocked when starting the suspend sequence */
+		if (state->suspend && state->step == 0)
+			drive->blocked = 1;
+		/* If this is a power management wakeup request, the first thing
+		 * we do is to wait for BSY bit to go away (with a looong timeout)
+		 * as a drive on this hwif may just be POSTing itself. We do that
+		 * before even selecting as the "other" device on the bus may be
+		 * broken enough to walk on our toes at this point.
+		 */
+		if (state->suspend != 0 || state->step != 0)
+			goto dont_wait;
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
+	} else {
+dont_wait:	
+		SELECT_DRIVE(drive);
+	}
+	
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat, BUSY_STAT|DRQ_STAT, WAIT_READY)) {
 		printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
 		return startstop;
@@ -625,6 +699,19 @@
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
+		else if (rq->flags & REQ_POWER_MANAGEMENT) {
+			ide_power_state_t *state = (ide_power_state_t *)rq->special;
+
+#ifdef DEBUG_PM
+			printk("%s: start_power_step(susp: %d, step: %d)\n", drive->name, state->suspend, state->step);
+#endif
+			startstop = DRIVER(drive)->start_power_step(drive, state);
+			if (startstop == ide_stopped && state->step == ide_power_state_completed) {
+				ide_complete_pm_request(drive, rq);
+				return ide_stopped;
+			} else
+				return startstop;
+		}
 		return (DRIVER(drive)->do_request(drive, rq, block));
 	}
 	return do_special(drive);
@@ -837,6 +924,22 @@
 			break;
 		}
 
+		/* Sanity: don't accept a request that isn't a PM request
+		 * if we are currently power managed. This is very important as
+		 * blk_stop_queue() doesn't prevent the elv_next_request() above
+		 * to return us whatever is in the queue. Since we call ide_do_request()
+		 * ourselves, we end up taking requests while the queue is blocked...
+		 */
+		if (drive->blocked && !(rq->flags & REQ_POWER_MANAGEMENT)) {
+#ifdef DEBUG_PM
+			printk("%s: a request made it's way while we are power managing...\n", drive->name);
+#endif
+			/* We clear busy, there should be no pending ATA command at this point
+			 */
+			hwgroup->busy = 0;
+			break;			
+		}
+
 		if (!rq->bio && ata_pending_commands(drive))
 			break;
 
@@ -1282,12 +1385,16 @@
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	DECLARE_COMPLETION(wait);
 	int insert_end = 1, err;
-
+	int must_wait = (action == ide_wait || action == ide_head_wait);
+	
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
@@ -1301,13 +1408,13 @@
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
 	}
@@ -1316,7 +1423,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	err = 0;
-	if (action == ide_wait) {
+	if (must_wait) {
 		wait_for_completion(&wait);
 		if (rq->errors)
 			err = -EIO;
===== drivers/ide/ide-iops.c 1.17 vs edited =====
--- 1.17/drivers/ide/ide-iops.c	Tue Mar 25 12:56:05 2003
+++ edited/drivers/ide/ide-iops.c	Wed Jun  4 14:55:13 2003
@@ -1318,5 +1318,32 @@
 	return do_reset1(drive, 0);
 }
 
+/*
+ * This function waits for the hwif to report a non-busy status
+ * see comments in probe_hwif()
+ */
+int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
+{
+	u8 stat = 0;
+	
+	while(timeout--) {
+		/* Turn this into a schedule() sleep once I'm sure
+		 * about locking issues (2.5 work ?)
+		 */
+		mdelay(1);
+		stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if ((stat & BUSY_STAT) == 0)
+			break;
+		/* Assume a value of 0xff means nothing is connected to
+		 * the interface and it doesn't implement the pull-down
+		 * resistor on D7
+		 */
+		if (stat == 0xff)
+			break;
+	}
+	return ((stat & BUSY_STAT) == 0) ? 0 : -EBUSY;
+}
+
+
 EXPORT_SYMBOL(ide_do_reset);
 
===== drivers/ide/ide-probe.c 1.49 vs edited =====
--- 1.49/drivers/ide/ide-probe.c	Tue May 27 02:48:43 2003
+++ edited/drivers/ide/ide-probe.c	Wed Jun  4 14:56:08 2003
@@ -723,35 +723,6 @@
 
 //EXPORT_SYMBOL(hwif_register);
 
-/* Enable code below on all archs later, for now, I want it on PPC
- */
-#ifdef CONFIG_PPC
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
@@ -766,7 +737,7 @@
 	 * I know of at least one disk who takes 31 seconds, I use 35
 	 * here to be safe
 	 */
-	rc = wait_not_busy(hwif, 35000);
+	rc = ide_wait_not_busy(hwif, 35000);
 	if (rc)
 		return rc;
 
@@ -774,20 +745,19 @@
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
 
 /*
  * This routine only knows how to look for drive units 0 and 1
===== drivers/ide/ide.c 1.70 vs edited =====
--- 1.70/drivers/ide/ide.c	Sun Jun  1 21:50:38 2003
+++ edited/drivers/ide/ide.c	Wed Jun  4 14:56:33 2003
@@ -1441,6 +1441,52 @@
 
 EXPORT_SYMBOL(ata_attach);
 
+int generic_ide_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+	struct request rq;
+	ide_power_state_t args;
+
+	if (level == dev->power_state || level != SUSPEND_SAVE_STATE)
+		return 0;
+
+	/* The suspend request is a state machine of taskfile requests */
+	memset(&rq, 0, sizeof(rq));
+	memset(&args, 0, sizeof(args));
+	rq.flags = REQ_POWER_MANAGEMENT;
+	rq.special = &args;
+	args.step = 0;
+	args.suspend = 1;
+
+	/* Start it */
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
+}
+
+EXPORT_SYMBOL(generic_ide_suspend);
+
+int generic_ide_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+	struct request rq;
+	ide_power_state_t args;
+
+	if (level == dev->power_state || level != RESUME_RESTORE_STATE)
+		return 0;
+
+	/* The suspend request is a state machine of taskfile requests */
+	memset(&rq, 0, sizeof(rq));
+	memset(&args, 0, sizeof(args));
+	rq.flags = REQ_POWER_MANAGEMENT;
+	rq.special = &args;
+	args.step = 0;
+	args.suspend = 0;
+
+	/* Start it */
+	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+}
+
+EXPORT_SYMBOL(generic_ide_resume);
+
 int generic_ide_ioctl(struct block_device *bdev, unsigned int cmd,
 			unsigned long arg)
 {
===== include/linux/blkdev.h 1.106 vs edited =====
--- 1.106/include/linux/blkdev.h	Tue May 27 22:15:31 2003
+++ edited/include/linux/blkdev.h	Wed Jun  4 14:58:00 2003
@@ -130,6 +130,7 @@
 	__REQ_DRIVE_CMD,
 	__REQ_DRIVE_TASK,
 	__REQ_DRIVE_TASKFILE,
+	__REQ_POWER_MANAGEMENT,
 	__REQ_NR_BITS,	/* stops here */
 };
 
@@ -151,6 +152,7 @@
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
 #define REQ_DRIVE_TASK	(1 << __REQ_DRIVE_TASK)
 #define REQ_DRIVE_TASKFILE	(1 << __REQ_DRIVE_TASKFILE)
+#define REQ_POWER_MANAGEMENT	(1 << __REQ_POWER_MANAGEMENT)
 
 #include <linux/elevator.h>
 
===== include/linux/ide.h 1.54 vs edited =====
--- 1.54/include/linux/ide.h	Thu May 29 21:04:47 2003
+++ edited/include/linux/ide.h	Wed Jun  4 14:57:33 2003
@@ -23,6 +23,8 @@
 #include <asm/hdreg.h>
 #include <asm/io.h>
 
+#define DEBUG_PM
+
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
  * It supports up to four IDE interfaces, on one or more IRQs (usually 14 & 15).
@@ -1144,6 +1146,39 @@
 #endif
 
 /*
+ * Power Management related definitions
+ */
+typedef struct ide_power_state_s
+{
+	int	suspend;	/* 1 = suspending, 0 = resuming */
+	int	step;		/* Step in PM state machine */
+	void*	data;		/* Any additional data the subdriver wants */
+} ide_power_state_t;
+
+#define ide_power_state_completed	-1
+#define ide_power_state_first		0
+//#define ide_power_state_core_first	100
+//#define ide_power_state_core_last	199
+
+/* The step value starts at 0 (ide_power_state_first). 
+ * 
+ * For each step, the core calls the subdriver start_power_step()
+ * first. This can return
+ *   - ide_stopped : In this case, the core calls us back again unless
+ *     step have been set to ide_power_state_completed
+ *   - ide_started : In this case, the channel is left busy until an
+ *     async event (interrupt) occurs.
+ * Typically, start_power_step() will issue a taskfile request with
+ * do_rw_taskfile().
+ * 
+ * Upon reception of the interrupt, the core will call complete_power_step()
+ * with the error code if any. This routine should update the step value
+ * and return. It should not start a new request. The core will call
+ * start_power_step for the new step value, unless step have been set to
+ * ide_power_state_completed.
+ */
+
+/*
  * Subdrivers support.
  */
 #define IDE_SUBDRIVER_VERSION	1
@@ -1172,6 +1207,8 @@
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
+	ide_startstop_t	(*start_power_step)(ide_drive_t *, ide_power_state_t *state);
+	void		(*complete_power_step)(ide_drive_t *, ide_power_state_t *state, u8 stat, u8 error);
 	struct device_driver	gen_driver;
 	struct list_head drives;
 	struct list_head drivers;
@@ -1180,6 +1217,8 @@
 #define DRIVER(drive)		((drive)->driver)
 
 extern int generic_ide_ioctl(struct block_device *, unsigned, unsigned long);
+extern int generic_ide_suspend(struct device *dev, u32 state, u32 level);
+extern int generic_ide_resume(struct device *dev, u32 level);
 
 /*
  * IDE modules.
@@ -1321,6 +1360,7 @@
 	ide_wait,	/* insert rq at end of list, and wait for it */
 	ide_next,	/* insert rq immediately after current request */
 	ide_preempt,	/* insert rq in front of current request */
+	ide_head_wait,	/* insert rq in front of current request and wait for it */
 	ide_end		/* insert rq at end of list, but don't wait for it */
 } ide_action_t;
 
@@ -1531,6 +1571,7 @@
 extern int set_transfer(ide_drive_t *, ide_task_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
 
+extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
 ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block);
 
 /*


