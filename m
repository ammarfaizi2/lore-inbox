Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTDXMsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTDXMsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:48:08 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:20430 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263646AbTDXMrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:47:55 -0400
Subject: [RFC/PATCH] IDE Power Management try 1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-9MLVWkDD6xuVH+0nPjmO"
Organization: 
Message-Id: <1051189194.13267.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 14:59:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9MLVWkDD6xuVH+0nPjmO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is a first try at implementing proper IDE power management.
It's not intended to be merged as-is, there is some uglyness here or
there, it's here for comments and discussion.

The point is to pipe the power management requests through the request
queue for proper locking. Since those requests involve several
operations that have to be tied together with the queue beeing locked
for further 'user' requests, they are implemented as a state machine
with specific callbacks in the subdrivers.

The guts of the patch is the core changes. I did the actual
implementation for ide-disk & ide-cd as a way to quickly validate it (it
works), but I'm sure we want to do more than just what I implemented
here. At least it's ok for PPC, but I beleive some x86 will want you to
do more (Alan suggested reverting to PIO for example, to please some
BIOSes, though that would suck badly for suspend-to-disk, there may be
more involved regarding recovering from errors in flush too).

One thing that should probably be cleaned up is the difference between
the suspend and the resume request. I didn't want to implement 2
different request bits to avoid using too much of that bit-space, and
because most of the core handling is the same. So right now, I carry in
the special structure attached to the request, 2 fields. An int
indicating if we are doing a suspend or a resume op, and an int that is
the actual state machine step.

However, for convenience, my ide-cd and ide-disk implementation
implement resume just as different step number in the same routine...

So we could either get rid of the "int suspend" field completely and
just define 2 different ranges for "step". Or we could keep "suspend",
but then it may make sense to split the sub-driver ops in 2
(suspend/suspend_completion & resume/resume_completion).

Waiting for feedback...

Ben.



--=-9MLVWkDD6xuVH+0nPjmO
Content-Disposition: attachment; filename=ide-pm.diff
Content-Type: text/plain; name=ide-pm.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D drivers/ide/ide-cd.c 1.43 vs edited =3D=3D=3D=3D=3D
--- 1.43/drivers/ide/ide-cd.c	Sat Apr 19 23:18:27 2003
+++ edited/drivers/ide/ide-cd.c	Thu Apr 24 14:19:32 2003
@@ -3242,6 +3242,46 @@
=20
 static int ide_cdrom_attach (ide_drive_t *drive);
=20
+static void ide_cdrom_complete_power_step (ide_drive_t *drive, ide_power_s=
tate_t *state, u8 stat, u8 error)
+{
+}
+
+/* Power Management state machine.=20
+ *
+ * We don't do much for CDs right now
+ */
+static ide_startstop_t ide_cdrom_start_power_step (ide_drive_t *drive, ide=
_power_state_t *state)
+{
+	ide_task_t args;
+
+	memset(&args, 0, sizeof(ide_task_t));
+
+	if (state->step =3D=3D 0) {
+		state->step =3D state->suspend ? 1 : 101;
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
+		if (HWIF(drive)->ide_dma_check =3D=3D NULL)
+			break;
+		HWIF(drive)->ide_dma_check(drive);
+		break;
+	}
+	state->step =3D ide_power_state_completed;
+	return ide_stopped;
+}
+
 static ide_driver_t ide_cdrom_driver =3D {
 	.owner			=3D THIS_MODULE,
 	.name			=3D "ide-cdrom",
@@ -3258,6 +3298,12 @@
 	.capacity		=3D ide_cdrom_capacity,
 	.attach			=3D ide_cdrom_attach,
 	.drives			=3D LIST_HEAD_INIT(ide_cdrom_driver.drives),
+	.start_power_step	=3D ide_cdrom_start_power_step,
+	.complete_power_step	=3D ide_cdrom_complete_power_step,
+	.gen_driver		=3D {
+		.suspend	=3D generic_ide_suspend,
+		.resume		=3D generic_ide_resume,
+	}
 };
=20
 static int idecd_open(struct inode * inode, struct file * file)
=3D=3D=3D=3D=3D drivers/ide/ide-disk.c 1.38 vs edited =3D=3D=3D=3D=3D
--- 1.38/drivers/ide/ide-disk.c	Mon Apr 21 12:32:44 2003
+++ edited/drivers/ide/ide-disk.c	Thu Apr 24 14:37:22 2003
@@ -72,8 +72,6 @@
=20
 #include "legacy/pdc4030.h"
=20
-static int driver_blocked;
-
 static inline u32 idedisk_read_24 (ide_drive_t *drive)
 {
 	u8 hcyl =3D HWIF(drive)->INB(IDE_HCYL_REG);
@@ -372,9 +370,6 @@
=20
 	nsectors.all		=3D (u16) rq->nr_sectors;
=20
-	if (driver_blocked)
-		panic("Request while ide driver is blocked?");
-
 #if defined(CONFIG_BLK_DEV_PDC4030) || defined(CONFIG_BLK_DEV_PDC4030_MODU=
LE)
 	if (IS_PDC4030_DRIVE)
 		return promise_rw_disk(drive, rq, block);
@@ -1398,21 +1393,6 @@
 	return 0;
 }
=20
-static int call_idedisk_standby (ide_drive_t *drive, int arg)
-{
-	ide_task_t args;
-	u8 standby =3D (arg) ? WIN_STANDBYNOW2 : WIN_STANDBYNOW1;
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D standby;
-	args.command_type			=3D ide_cmd_type_parser(&args);
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
@@ -1511,37 +1491,66 @@
 #endif
 }
=20
-static int idedisk_suspend(struct device *dev, u32 state, u32 level)
-{
-	ide_drive_t *drive =3D dev->driver_data;
-
-	printk("Suspending device %p\n", dev->driver_data);
-
-	/* I hope that every freeze operation from the upper levels have
-	 * already been done...
-	 */
-
-	if (level !=3D SUSPEND_SAVE_STATE)
-		return 0;
-
-	/* set the drive to standby */
-	printk(KERN_INFO "suspending: %s ", drive->name);
-	do_idedisk_standby(drive);
-	drive->blocked =3D 1;
=20
-	BUG_ON (HWGROUP(drive)->handler);
-	return 0;
+static void idedisk_complete_power_step (ide_drive_t *drive, ide_power_sta=
te_t *state, u8 stat, u8 error)
+{
+	switch(state->step) {
+	case 1: /* Suspend step 1 (flush cache) complete */
+		state->step =3D 2;
+		break;
+	case 2: /* Suspend step 2 (standby) complete */
+		state->step =3D ide_power_state_completed;
+		break;
+	}
 }
=20
-static int idedisk_resume(struct device *dev, u32 level)
+/* Power Management state machine. This one is rather trivial for now,
+ * we should probably add more, like switching back to PIO on suspend
+ * to help some BIOSes, re-do the door locking on resume, etc...
+ */
+static ide_startstop_t idedisk_start_power_step (ide_drive_t *drive, ide_p=
ower_state_t *state)
 {
-	ide_drive_t *drive =3D dev->driver_data;
+	ide_task_t args;
=20
-	if (level !=3D RESUME_RESTORE_STATE)
-		return 0;
-	BUG_ON(!drive->blocked);
-	drive->blocked =3D 0;
-	return 0;
+	memset(&args, 0, sizeof(ide_task_t));
+
+	if (state->step =3D=3D 0) {
+		state->step =3D state->suspend ? 1 : 101;
+		return ide_stopped;
+	}
+	switch(state->step) {
+	case 1: /* Suspend step 1 (flush cache) */
+		if (!drive->wcache) {
+			idedisk_complete_power_step(drive, state, 0, 0);
+			return ide_stopped;
+		}
+		if (drive->id->cfs_enable_2 & 0x2400)
+			args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_FLUSH_CACHE_EXT;
+		else
+			args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_FLUSH_CACHE;
+		args.command_type		 		=3D ide_cmd_type_parser(&args);
+		return do_rw_taskfile(drive, &args);
+	case 2: /* Suspend step 2 (standby) */
+		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_STANDBYNOW1;
+		args.command_type			=3D ide_cmd_type_parser(&args);
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
+		if (HWIF(drive)->ide_dma_check =3D=3D NULL)
+			break;
+		HWIF(drive)->ide_dma_check(drive);
+		break;
+	}
+	state->step =3D ide_power_state_completed;
+	return ide_stopped;
 }
=20
 static void idedisk_setup (ide_drive_t *drive)
@@ -1680,9 +1689,11 @@
 	.proc			=3D idedisk_proc,
 	.attach			=3D idedisk_attach,
 	.drives			=3D LIST_HEAD_INIT(idedisk_driver.drives),
+	.start_power_step	=3D idedisk_start_power_step,
+	.complete_power_step	=3D idedisk_complete_power_step,
 	.gen_driver		=3D {
-		.suspend	=3D idedisk_suspend,
-		.resume		=3D idedisk_resume,
+		.suspend	=3D generic_ide_suspend,
+		.resume		=3D generic_ide_resume,
 	}
 };
=20
=3D=3D=3D=3D=3D drivers/ide/ide-io.c 1.8 vs edited =3D=3D=3D=3D=3D
--- 1.8/drivers/ide/ide-io.c	Sun Apr 20 23:14:28 2003
+++ edited/drivers/ide/ide-io.c	Thu Apr 24 14:36:57 2003
@@ -139,6 +139,39 @@
 EXPORT_SYMBOL(ide_end_request);
=20
 /**
+ *	ide_complete_pm_request	-	end the current Power Management request
+ *	@drive: target drive=20
+ *	@rq: request
+ *
+ *	This function cleans up the current PM request and stops the queue
+ *	if necessary.=20
+ */
+=20
+static void ide_complete_pm_request (ide_drive_t *drive, struct request *r=
q)
+{
+	ide_power_state_t *state =3D (ide_power_state_t *)rq->special;
+	unsigned long flags;
+	int suspend =3D state->suspend;
+
+#ifdef DEBUG_PM
+	printk("%s: completing PM request, suspend: %d\n", drive->name, state->su=
spend);
+#endif=09
+	spin_lock_irqsave(&ide_lock, flags);
+	if (suspend)
+		__blk_stop_queue(&drive->queue);
+	else
+		drive->blocked =3D 0;
+	blkdev_dequeue_request(rq);
+	HWGROUP(drive)->rq =3D NULL;
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
  *	@drive: command=20
  *	@stat: status bits
@@ -214,6 +247,17 @@
 				args->hobRegister[IDE_HCYL_OFFSET_HOB]    =3D hwif->INB(IDE_HCYL_REG);
 			}
 		}
+	} else if (rq->flags & REQ_POWER_MANAGEMENT) {
+		ide_power_state_t *state =3D (ide_power_state_t *)rq->special;
+
+#ifdef DEBUG_PM
+		printk("%s: complete_power_step(susp: %d, step: %d, stat: %x, err: %x)\n=
",
+			drive->name, state->suspend, state->step, stat, err);
+#endif
+		DRIVER(drive)->complete_power_step(drive, state, stat, err);
+		if (state->step =3D=3D ide_power_state_completed)
+			ide_complete_pm_request(drive, rq);
+		return;
 	}
=20
 	spin_lock_irqsave(&ide_lock, flags);
@@ -615,7 +659,37 @@
 	while ((read_timer() - HWIF(drive)->last_time) < DISK_RECOVERY_TIME);
 #endif
=20
-	SELECT_DRIVE(drive);
+	if (rq->flags & REQ_POWER_MANAGEMENT) {
+		ide_power_state_t *state =3D (ide_power_state_t *)rq->special;
+		int rc;
+
+		/* Mark drive blocked when starting the suspend sequence */
+		if (state->suspend && state->step =3D=3D 0)
+			drive->blocked =3D 1;
+		/* If this is a power management wakeup request, the first thing
+		 * we do is to wait for BSY bit to go away (with a looong timeout)
+		 * as a drive on this hwif may just be POSTing itself. We do that
+		 * before even selecting as the "other" device on the bus may be
+		 * broken enough to walk on our toes at this point.
+		 */
+		if (state->suspend !=3D 0 || state->step !=3D 0)
+			goto dont_wait;
+#ifdef DEBUG_PM
+		printk("%s: Wakeup request inited, waiting for !BSY...\n", drive->name);
+#endif	=09
+		rc =3D ide_wait_not_busy(HWIF(drive), 35000);
+		if (rc)
+			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
+		SELECT_DRIVE(drive);
+		HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
+		rc =3D ide_wait_not_busy(HWIF(drive), 10000);
+		if (rc)
+			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
+	} else {
+dont_wait:=09
+		SELECT_DRIVE(drive);
+	}
+=09
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat, BUSY_STAT|DRQ_STA=
T, WAIT_READY)) {
 		printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
 		return startstop;
@@ -625,6 +699,19 @@
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
+		else if (rq->flags & REQ_POWER_MANAGEMENT) {
+			ide_power_state_t *state =3D (ide_power_state_t *)rq->special;
+
+#ifdef DEBUG_PM
+			printk("%s: start_power_step(susp: %d, step: %d)\n", drive->name, state=
->suspend, state->step);
+#endif
+			startstop =3D DRIVER(drive)->start_power_step(drive, state);
+			if (startstop =3D=3D ide_stopped && state->step =3D=3D ide_power_state_=
completed) {
+				ide_complete_pm_request(drive, rq);
+				return ide_stopped;
+			} else
+				return startstop;
+		}
 		return (DRIVER(drive)->do_request(drive, rq, block));
 	}
 	return do_special(drive);
@@ -835,6 +922,22 @@
 		if (!rq) {
 			hwgroup->busy =3D !!ata_pending_commands(drive);
 			break;
+		}
+
+		/* Sanity: don't accept a request that isn't a PM request
+		 * if we are currently power managed. This is very important as
+		 * blk_stop_queue() doesn't prevent the elv_next_request() above
+		 * to return us whatever is in the queue. Since we call ide_do_request()
+		 * ourselves, we end up taking requests while the queue is blocked...
+		 */
+		if (drive->blocked && !(rq->flags & REQ_POWER_MANAGEMENT)) {
+#ifdef DEBUG_PM
+			printk("%s: a request made it's way while we are power managing...\n", =
drive->name);
+#endif
+			/* We clear busy, there should be no pending ATA command at this point
+			 */
+			hwgroup->busy =3D 0;
+			break;		=09
 		}
=20
 		if (!rq->bio && ata_pending_commands(drive))
=3D=3D=3D=3D=3D drivers/ide/ide-iops.c 1.15 vs edited =3D=3D=3D=3D=3D
--- 1.15/drivers/ide/ide-iops.c	Wed Mar 26 21:05:24 2003
+++ edited/drivers/ide/ide-iops.c	Thu Apr 24 14:32:28 2003
@@ -1318,5 +1318,32 @@
 	return do_reset1(drive, 0);
 }
=20
+/*
+ * This function waits for the hwif to report a non-busy status
+ * see comments in probe_hwif()
+ */
+int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
+{
+	u8 stat =3D 0;
+=09
+	while(timeout--) {
+		/* Turn this into a schedule() sleep once I'm sure
+		 * about locking issues (2.5 work ?)
+		 */
+		mdelay(1);
+		stat =3D hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if ((stat & BUSY_STAT) =3D=3D 0)
+			break;
+		/* Assume a value of 0xff means nothing is connected to
+		 * the interface and it doesn't implement the pull-down
+		 * resistor on D7
+		 */
+		if (stat =3D=3D 0xff)
+			break;
+	}
+	return ((stat & BUSY_STAT) =3D=3D 0) ? 0 : -EBUSY;
+}
+
+
 EXPORT_SYMBOL(ide_do_reset);
=20
=3D=3D=3D=3D=3D drivers/ide/ide-probe.c 1.40 vs edited =3D=3D=3D=3D=3D
--- 1.40/drivers/ide/ide-probe.c	Fri Apr 18 17:58:55 2003
+++ edited/drivers/ide/ide-probe.c	Thu Apr 24 14:32:04 2003
@@ -723,35 +723,6 @@
=20
 //EXPORT_SYMBOL(hwif_register);
=20
-/* Enable code below on all archs later, for now, I want it on PPC
- */
-#ifdef CONFIG_PPC
-/*
- * This function waits for the hwif to report a non-busy status
- * see comments in probe_hwif()
- */
-static int wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
-{
-	u8 stat =3D 0;
-=09
-	while(timeout--) {
-		/* Turn this into a schedule() sleep once I'm sure
-		 * about locking issues (2.5 work ?)
-		 */
-		mdelay(1);
-		stat =3D hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
-		if ((stat & BUSY_STAT) =3D=3D 0)
-			break;
-		/* Assume a value of 0xff means nothing is connected to
-		 * the interface and it doesn't implement the pull-down
-		 * resistor on D7
-		 */
-		if (stat =3D=3D 0xff)
-			break;
-	}
-	return ((stat & BUSY_STAT) =3D=3D 0) ? 0 : -EBUSY;
-}
-
 static int wait_hwif_ready(ide_hwif_t *hwif)
 {
 	int rc;
@@ -766,7 +737,7 @@
 	 * I know of at least one disk who takes 31 seconds, I use 35
 	 * here to be safe
 	 */
-	rc =3D wait_not_busy(hwif, 35000);
+	rc =3D ide_wait_not_busy(hwif, 35000);
 	if (rc)
 		return rc;
=20
@@ -774,20 +745,19 @@
 	SELECT_DRIVE(&hwif->drives[0]);
 	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 	mdelay(2);
-	rc =3D wait_not_busy(hwif, 10000);
+	rc =3D ide_wait_not_busy(hwif, 10000);
 	if (rc)
 		return rc;
 	SELECT_DRIVE(&hwif->drives[1]);
 	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 	mdelay(2);
-	rc =3D wait_not_busy(hwif, 10000);
+	rc =3D ide_wait_not_busy(hwif, 10000);
=20
 	/* Exit function with master reselected (let's be sane) */
 	SELECT_DRIVE(&hwif->drives[0]);
 =09
 	return rc;
 }
-#endif /* CONFIG_PPC */
=20
 /*
  * This routine only knows how to look for drive units 0 and 1
=3D=3D=3D=3D=3D drivers/ide/ide.c 1.58 vs edited =3D=3D=3D=3D=3D
--- 1.58/drivers/ide/ide.c	Fri Apr 18 17:57:08 2003
+++ edited/drivers/ide/ide.c	Thu Apr 24 14:31:26 2003
@@ -1448,6 +1448,52 @@
=20
 EXPORT_SYMBOL(ata_attach);
=20
+int generic_ide_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive =3D dev->driver_data;
+	struct request rq;
+	ide_power_state_t args;
+
+	if (level =3D=3D dev->power_state || level !=3D SUSPEND_SAVE_STATE)
+		return 0;
+
+	/* The suspend request is a state machine of taskfile requests */
+	memset(&rq, 0, sizeof(rq));
+	memset(&args, 0, sizeof(args));
+	rq.flags =3D REQ_POWER_MANAGEMENT;
+	rq.special =3D &args;
+	args.step =3D 0;
+	args.suspend =3D 1;
+
+	/* Start it */
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
+}
+
+EXPORT_SYMBOL(generic_ide_suspend);
+
+int generic_ide_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive =3D dev->driver_data;
+	struct request rq;
+	ide_power_state_t args;
+
+	if (level =3D=3D dev->power_state || level !=3D RESUME_RESTORE_STATE)
+		return 0;
+
+	/* The suspend request is a state machine of taskfile requests */
+	memset(&rq, 0, sizeof(rq));
+	memset(&args, 0, sizeof(args));
+	rq.flags =3D REQ_POWER_MANAGEMENT;
+	rq.special =3D &args;
+	args.step =3D 0;
+	args.suspend =3D 0;
+
+	/* Start it */
+	return ide_do_drive_cmd(drive, &rq, ide_preempt);
+}
+
+EXPORT_SYMBOL(generic_ide_resume);
+
 int generic_ide_ioctl(struct block_device *bdev, unsigned int cmd,
 			unsigned long arg)
 {
=3D=3D=3D=3D=3D include/linux/blkdev.h 1.100 vs edited =3D=3D=3D=3D=3D
--- 1.100/include/linux/blkdev.h	Sun Apr 20 18:20:10 2003
+++ edited/include/linux/blkdev.h	Thu Apr 24 14:30:50 2003
@@ -116,6 +116,7 @@
 	__REQ_DRIVE_CMD,
 	__REQ_DRIVE_TASK,
 	__REQ_DRIVE_TASKFILE,
+	__REQ_POWER_MANAGEMENT,
 	__REQ_NR_BITS,	/* stops here */
 };
=20
@@ -137,6 +138,7 @@
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
 #define REQ_DRIVE_TASK	(1 << __REQ_DRIVE_TASK)
 #define REQ_DRIVE_TASKFILE	(1 << __REQ_DRIVE_TASKFILE)
+#define REQ_POWER_MANAGEMENT	(1 << __REQ_POWER_MANAGEMENT)
=20
 #include <linux/elevator.h>
=20
=3D=3D=3D=3D=3D include/linux/ide.h 1.46 vs edited =3D=3D=3D=3D=3D
--- 1.46/include/linux/ide.h	Mon Apr 21 01:21:19 2003
+++ edited/include/linux/ide.h	Thu Apr 24 14:31:07 2003
@@ -1160,6 +1160,39 @@
 #endif
=20
 /*
+ * Power Management related definitions
+ */
+typedef struct ide_power_state_s
+{
+	int	suspend;	/* 1 =3D suspending, 0 =3D resuming */
+	int	step;		/* Step in PM state machine */
+	void*	data;		/* Any additional data the subdriver wants */
+} ide_power_state_t;
+
+#define ide_power_state_completed	-1
+#define ide_power_state_first		0
+//#define ide_power_state_core_first	100
+//#define ide_power_state_core_last	199
+
+/* The step value starts at 0 (ide_power_state_first).=20
+ *=20
+ * For each step, the core calls the subdriver start_power_step()
+ * first. This can return
+ *   - ide_stopped : In this case, the core calls us back again unless
+ *     step have been set to ide_power_state_completed
+ *   - ide_started : In this case, the channel is left busy until an
+ *     async event (interrupt) occurs.
+ * Typically, start_power_step() will issue a taskfile request with
+ * do_rw_taskfile().
+ *=20
+ * Upon reception of the interrupt, the core will call complete_power_step=
()
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
@@ -1188,6 +1221,8 @@
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
+	ide_startstop_t	(*start_power_step)(ide_drive_t *, ide_power_state_t *sta=
te);
+	void		(*complete_power_step)(ide_drive_t *, ide_power_state_t *state, u8 =
stat, u8 error);
 	struct device_driver	gen_driver;
 	struct list_head drives;
 	struct list_head drivers;
@@ -1196,6 +1231,8 @@
 #define DRIVER(drive)		((drive)->driver)
=20
 extern int generic_ide_ioctl(struct block_device *, unsigned, unsigned lon=
g);
+extern int generic_ide_suspend(struct device *dev, u32 state, u32 level);
+extern int generic_ide_resume(struct device *dev, u32 level);
=20
 /*
  * IDE modules.
@@ -1550,6 +1587,8 @@
 extern u8 eighty_ninty_three (ide_drive_t *);
 extern int set_transfer(ide_drive_t *, ide_task_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
+
+extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
=20
 /*
  * ide_system_bus_speed() returns what we think is the system VESA/PCI

--=-9MLVWkDD6xuVH+0nPjmO--
