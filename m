Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSDYPfE>; Thu, 25 Apr 2002 11:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313194AbSDYPfD>; Thu, 25 Apr 2002 11:35:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16901 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313189AbSDYPem>; Thu, 25 Apr 2002 11:34:42 -0400
Message-ID: <3CC8136B.2060705@evision-ventures.com>
Date: Thu, 25 Apr 2002 16:32:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.10 IDE 41
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070604030102050904030708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604030102050904030708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue Apr 23 00:27:55 CEST 2002 ide-clean-41

- Revoke the TCQ stuff. Well having it for some time showed just nicely what
   has to be done before it can be included cleanly. But it's just not ready
   jet.

   For more explanations please simply track the usage of the special field of
   struct request - *both* in the generic request handling code and in overall
   driver code.

--------------070604030102050904030708
Content-Type: text/plain;
 name="ide-clean-41.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-41.diff"

diff -urN linux-2.5.10/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.10/drivers/ide/Config.help	2002-04-23 00:29:44.000000000 +0200
+++ linux/drivers/ide/Config.help	2002-04-25 15:35:49.000000000 +0200
@@ -749,35 +749,6 @@
 
   Generally say N here.
 
-CONFIG_BLK_DEV_IDE_TCQ
-  Support for tagged command queueing on ATA disk drives. This enables
-  the IDE layer to have multiple in-flight requests on hardware that
-  supports it. For now this includes the IBM Deskstar series drives,
-  such as the 22GXP, 75GXP, 40GV, 60GXP, and 120GXP (ie any Deskstar made
-  in the last couple of years), and at least some of the Western
-  Digital drives in the Expert series.
-
-  If you have such a drive, say Y here.
-
-CONFIG_BLK_DEV_IDE_TCQ_DEPTH
-  Maximum size of commands to enable per-drive. Any value between 1
-  and 32 is valid, with 32 being the maxium that the hardware supports.
-
-  You probably just want the default of 32 here. If you enter an invalid
-  number, the default value will be used.
-
-CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-  Enabled tagged command queueing unconditionally on drives that report
-  support for it. Regardless of the chosen value here, tagging can be
-  controlled at run time:
-
-  echo "using_tcq:32" > /proc/ide/hdX/settings
-
-  where any value between 1-32 selects chosen queue depth and enables
-  TCQ, and 0 disables it.
-
-  Generally say Y here.
-
 CONFIG_BLK_DEV_IT8172
   Say Y here to support the on-board IDE controller on the Integrated
   Technology Express, Inc. ITE8172 SBC.  Vendor page at
diff -urN linux-2.5.10/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.10/drivers/ide/Config.in	2002-04-23 00:29:45.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-04-25 14:17:08.000000000 +0200
@@ -47,11 +47,6 @@
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
-	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
-	 dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
-	 if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
-	    int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
-	 fi
 	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
diff -urN linux-2.5.10/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.10/drivers/ide/ide.c	2002-04-23 00:29:02.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-04-25 17:09:29.000000000 +0200
@@ -368,40 +368,6 @@
 	return 0;	/* no, it is not a flash memory card */
 }
 
-void ide_end_queued_request(ide_drive_t *drive, int uptodate, struct request *rq)
-{
-	unsigned long flags;
-
-	BUG_ON(!(rq->flags & REQ_STARTED));
-	BUG_ON(!rq->special);
-
-	if (!end_that_request_first(rq, uptodate, rq->hard_nr_sectors)) {
-		struct ata_request *ar = rq->special;
-
-		add_blkdev_randomness(major(rq->rq_dev));
-
-		spin_lock_irqsave(&ide_lock, flags);
-
-		if ((jiffies - ar->ar_time > ATA_AR_MAX_TURNAROUND) && drive->queue_depth > 1) {
-			printk(KERN_INFO "%s: exceeded max command turn-around time (%d seconds)\n", drive->name, ATA_AR_MAX_TURNAROUND / HZ);
-			drive->queue_depth >>= 1;
-		}
-
-		if (jiffies - ar->ar_time > drive->tcq->oldest_command)
-			drive->tcq->oldest_command = jiffies - ar->ar_time;
-
-		ata_ar_put(drive, ar);
-		end_that_request_last(rq);
-		/*
-		 * IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG) will do this
-		 * too, but it really belongs here. assumes that the
-		 * ended request is the active one.
-		 */
-		HWGROUP(drive)->rq = NULL;
-		spin_unlock_irqrestore(&ide_lock, flags);
-	}
-}
-
 int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs)
 {
 	struct request *rq;
@@ -430,17 +396,9 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
-		struct ata_request *ar = rq->special;
-
 		add_blkdev_randomness(major(rq->rq_dev));
-		/*
-		 * request with ATA_AR_QUEUED set have already been
-		 * dequeued, but doing it twice is ok
-		 */
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
-		if (ar)
-			ata_ar_put(drive, ar);
 		end_that_request_last(rq);
 		ret = 0;
 	}
@@ -776,11 +734,8 @@
 			args[6] = IN_BYTE(IDE_SELECT_REG);
 		}
 	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
-		struct ata_request *ar = rq->special;
-		struct ata_taskfile *args = &ar->ar_task;
-
+		struct ata_taskfile *args = rq->special;
 		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
-
 		if (args) {
 			args->taskfile.feature = err;
 			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
@@ -803,7 +758,6 @@
 				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
-		ata_ar_put(drive, ar);
 	}
 
 	blkdev_dequeue_request(rq);
@@ -920,11 +874,6 @@
 	struct request *rq;
 	byte err;
 
-	/*
-	 * FIXME: remember to invalidate tcq queue when drive->using_tcq
-	 * and atomic_read(&drive->tcq->queued) /jens
-	 */
-
 	err = ide_dump_status(drive, msg, stat);
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
@@ -1127,14 +1076,11 @@
 			 */
 
 			if (rq->flags & REQ_DRIVE_TASKFILE) {
-				struct ata_request *ar = rq->special;
-				struct ata_taskfile *args;
+				struct ata_taskfile *args = rq->special;
 
-				if (!ar)
+				if (!(args))
 					goto args_error;
 
-				args = &ar->ar_task;
-
 				ata_taskfile(drive, args, NULL);
 
 				if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
@@ -1258,170 +1204,25 @@
 /*
  * Select the next drive which will be serviced.
  */
-static ide_drive_t *choose_drive(ide_hwgroup_t *hwgroup)
+static inline ide_drive_t *choose_drive(ide_hwgroup_t *hwgroup)
 {
-	ide_drive_t *tmp;
-	ide_drive_t *drive = NULL;
-	unsigned long sleep = 0;
+	ide_drive_t *drive, *best;
 
-	tmp = hwgroup->drive;
+	best = NULL;
+	drive = hwgroup->drive;
 	do {
-		if (!list_empty(&tmp->queue.queue_head)
-		&& (!tmp->PADAM_sleep || time_after_eq(tmp->PADAM_sleep, jiffies))) {
-			if (!drive
-			 || (tmp->PADAM_sleep && (!drive->PADAM_sleep || time_after(drive->PADAM_sleep, tmp->PADAM_sleep)))
-			 || (!drive->PADAM_sleep && time_after(drive->PADAM_service_start + 2 * drive->PADAM_service_time, tmp->PADAM_service_start + 2 * tmp->PADAM_service_time)))
+		if (!list_empty(&drive->queue.queue_head)
+		&& (!drive->PADAM_sleep	|| time_after_eq(drive->PADAM_sleep, jiffies))) {
+			if (!best
+			 || (drive->PADAM_sleep && (!best->PADAM_sleep || time_after(best->PADAM_sleep, drive->PADAM_sleep)))
+			 || (!best->PADAM_sleep && time_after(best->PADAM_service_start + 2 * best->PADAM_service_time, drive->PADAM_service_start + 2 * drive->PADAM_service_time)))
 			{
-				if (!blk_queue_plugged(&tmp->queue))
-					drive = tmp;
+				if (!blk_queue_plugged(&drive->queue))
+					best = drive;
 			}
 		}
-		tmp = tmp->next;
-	} while (tmp != hwgroup->drive);
-
-	if (drive)
-		return drive;
-
-	hwgroup->rq = NULL;
-	drive = hwgroup->drive;
-	do {
-		if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
-			sleep = drive->PADAM_sleep;
 	} while ((drive = drive->next) != hwgroup->drive);
-
-	if (sleep) {
-		/*
-		 * Take a short snooze, and then wake up this hwgroup
-		 * again.  This gives other hwgroups on the same a
-		 * chance to play fairly with us, just in case there
-		 * are big differences in relative throughputs.. don't
-		 * want to hog the cpu too much.
-		 */
-		if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
-			sleep = jiffies + WAIT_MIN_SLEEP;
-
-		if (timer_pending(&hwgroup->timer))
-			printk("ide_set_handler: timer already active\n");
-
-		set_bit(IDE_SLEEP, &hwgroup->flags);
-		mod_timer(&hwgroup->timer, sleep);
-		/* we purposely leave hwgroup busy while
-		 * sleeping */
-	} else {
-		/* Ugly, but how can we sleep for the lock
-		 * otherwise? perhaps from tq_disk? */
-		ide_release_lock(&ide_intr_lock);/* for atari only */
-		clear_bit(IDE_BUSY, &hwgroup->flags);
-	}
-
-	return NULL;
-}
-
-/*
- * feed commands to a drive until it barfs. used to be part of ide_do_request.
- * called with ide_lock/DRIVE_LOCK held and busy hwgroup
- */
-static void ide_queue_commands(ide_drive_t *drive, int masked_irq)
-{
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	ide_startstop_t startstop = -1;
-	struct request *rq;
-
-	do {
-		rq = NULL;
-
-		if (!test_bit(IDE_BUSY, &hwgroup->flags))
-			printk("%s: hwgroup not busy while queueing\n", drive->name);
-
-		/*
-		 * abort early if we can't queue another command. for non
-		 * tcq, ide_can_queue is always 1 since we never get here
-		 * unless the drive is idle.
-		 */
-		if (!ide_can_queue(drive)) {
-			if (!ide_pending_commands(drive))
-				clear_bit(IDE_BUSY, &hwgroup->flags);
-			break;
-		}
-
-		drive->PADAM_sleep = 0;
-		drive->PADAM_service_start = jiffies;
-
-		if (test_bit(IDE_DMA, &hwgroup->flags)) {
-			printk("ide_do_request: DMA in progress...\n");
-			break;
-		}
-
-		/*
-		 * there's a small window between where the queue could be
-		 * replugged while we are in here when using tcq (in which
-		 * case the queue is probably empty anyways...), so check
-		 * and leave if appropriate. When not using tcq, this is
-		 * still a severe BUG!
-		 */
-		if (blk_queue_plugged(&drive->queue)) {
-			BUG_ON(!drive->using_tcq);
-			break;
-		}
-
-		if (!(rq = elv_next_request(&drive->queue))) {
-			if (!ide_pending_commands(drive))
-				clear_bit(IDE_BUSY, &hwgroup->flags);
-			hwgroup->rq = NULL;
-			break;
-		}
-
-		/*
-		 * if there are queued commands, we can't start a non-fs
-		 * request (really, a non-queuable command) until the
-		 * queue is empty
-		 */
-		if (!(rq->flags & REQ_CMD) && ide_pending_commands(drive))
-			break;
-
-		hwgroup->rq = rq;
-
-		/*
-		 * Some systems have trouble with IDE IRQs arriving while
-		 * the driver is still setting things up.  So, here we disable
-		 * the IRQ used by this interface while the request is being
-		 * started.  This may look bad at first, but pretty much the
-		 * same thing happens anyway when any interrupt comes in, IDE
-		 * or otherwise -- the kernel masks the IRQ while it is being
-		 * handled.
-		 */
-		if (masked_irq && HWIF(drive)->irq != masked_irq)
-			disable_irq_nosync(HWIF(drive)->irq);
-
-		spin_unlock(&ide_lock);
-		ide__sti();	/* allow other IRQs while we start this request */
-		startstop = start_request(drive, rq);
-
-		spin_lock_irq(&ide_lock);
-		if (masked_irq && HWIF(drive)->irq != masked_irq)
-			enable_irq(HWIF(drive)->irq);
-
-		/*
-		 * command started, we are busy
-		 */
-		if (startstop == ide_started)
-			break;
-
-		/*
-		 * start_request() can return either ide_stopped (no command
-		 * was started), ide_started (command started, don't queue
-		 * more), or ide_released (command started, try and queue
-		 * more).
-		 */
-#if 0
-		if (startstop == ide_stopped)
-			set_bit(IDE_BUSY, &hwgroup->flags);
-#endif
-
-	} while (1);
-
-	if (startstop == ide_started)
-		return;
+	return best;
 }
 
 /*
@@ -1458,34 +1259,86 @@
 {
 	ide_drive_t *drive;
 	struct ata_channel *hwif;
+	ide_startstop_t	startstop;
+	struct request	*rq;
 
 	ide_get_lock(&ide_intr_lock, ide_intr, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 
 	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, &hwgroup->flags)) {
-
-		/*
-		 * will clear IDE_BUSY, if appropriate
-		 */
-		if ((drive = choose_drive(hwgroup)) == NULL)
-			break;
-
+		drive = choose_drive(hwgroup);
+		if (drive == NULL) {
+			unsigned long sleep = 0;
+			hwgroup->rq = NULL;
+			drive = hwgroup->drive;
+			do {
+				if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
+					sleep = drive->PADAM_sleep;
+			} while ((drive = drive->next) != hwgroup->drive);
+			if (sleep) {
+				/*
+				 * Take a short snooze, and then wake up this hwgroup again.
+				 * This gives other hwgroups on the same a chance to
+				 * play fairly with us, just in case there are big differences
+				 * in relative throughputs.. don't want to hog the cpu too much.
+				 */
+				if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
+					sleep = jiffies + WAIT_MIN_SLEEP;
+#if 1
+				if (timer_pending(&hwgroup->timer))
+					printk("ide_set_handler: timer already active\n");
+#endif
+				set_bit(IDE_SLEEP, &hwgroup->flags);
+				mod_timer(&hwgroup->timer, sleep);
+				/* we purposely leave hwgroup busy while sleeping */
+			} else {
+				/* Ugly, but how can we sleep for the lock otherwise? perhaps from tq_disk? */
+				ide_release_lock(&ide_intr_lock);/* for atari only */
+				clear_bit(IDE_BUSY, &hwgroup->flags);
+			}
+			return;		/* no more work for this hwgroup (for now) */
+		}
 		hwif = drive->channel;
-		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif && IDE_CONTROL_REG) {
+		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif && hwif->io_ports[IDE_CONTROL_OFFSET]) {
 			/* set nIEN for previous hwif */
+
 			if (hwif->intrproc)
 				hwif->intrproc(drive);
 			else
-				OUT_BYTE(drive->ctl|2, IDE_CONTROL_REG);
+				OUT_BYTE((drive)->ctl|2, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
+		drive->PADAM_sleep = 0;
+		drive->PADAM_service_start = jiffies;
+
+		if (blk_queue_plugged(&drive->queue))
+			BUG();
+
+		/*
+		 * just continuing an interrupted request maybe
+		 */
+		rq = hwgroup->rq = elv_next_request(&drive->queue);
 
 		/*
-		 * main queueing loop
+		 * Some systems have trouble with IDE IRQs arriving while
+		 * the driver is still setting things up.  So, here we disable
+		 * the IRQ used by this interface while the request is being started.
+		 * This may look bad at first, but pretty much the same thing
+		 * happens anyway when any interrupt comes in, IDE or otherwise
+		 *  -- the kernel masks the IRQ while it is being handled.
 		 */
-		ide_queue_commands(drive, masked_irq);
+		if (masked_irq && hwif->irq != masked_irq)
+			disable_irq_nosync(hwif->irq);
+		spin_unlock(&ide_lock);
+		ide__sti();	/* allow other IRQs while we start this request */
+		startstop = start_request(drive, rq);
+		spin_lock_irq(&ide_lock);
+		if (masked_irq && hwif->irq != masked_irq)
+			enable_irq(hwif->irq);
+		if (startstop == ide_stopped)
+			clear_bit(IDE_BUSY, &hwgroup->flags);
 	}
 }
 
@@ -1512,39 +1365,21 @@
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
  * retry the current request in PIO mode instead of risking tossing it
  * all away
- *
- * FIXME: needs a bit of tcq work
  */
 void ide_dma_timeout_retry(ide_drive_t *drive)
 {
 	struct ata_channel *hwif = drive->channel;
-	struct request *rq = NULL;
-	struct ata_request *ar = NULL;
-
-	if (drive->using_tcq) {
-		if (drive->tcq->active_tag != -1) {
-			ar = IDE_CUR_AR(drive);
-			rq = ar->ar_rq;
-		}
-	} else {
-		rq = HWGROUP(drive)->rq;
-		ar = rq->special;
-	}
+	struct request *rq;
 
 	/*
 	 * end current dma transaction
 	 */
-	if (rq)
-		hwif->dmaproc(ide_dma_end, drive);
+	hwif->dmaproc(ide_dma_end, drive);
 
 	/*
 	 * complain a little, later we might remove some of this verbosity
 	 */
-	printk("%s: timeout waiting for DMA", drive->name);
-	if (drive->using_tcq)
-		printk(" queued, active tag %d", drive->tcq->active_tag);
-	printk("\n");
-
+	printk("%s: timeout waiting for DMA\n", drive->name);
 	hwif->dmaproc(ide_dma_timeout, drive);
 
 	/*
@@ -1560,25 +1395,15 @@
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
 	 * make sure request is sane
 	 */
+	rq = HWGROUP(drive)->rq;
 	HWGROUP(drive)->rq = NULL;
 
-	if (!rq)
-		return;
-
 	rq->errors = 0;
 	if (rq->bio) {
 		rq->sector = rq->bio->bi_sector;
 		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
 		rq->buffer = NULL;
 	}
-
-	/*
-	 *  this request was not on the queue any more
-	 */
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-		ata_ar_put(drive, ar);
-		_elv_add_request(&drive->queue, rq, 0, 0);
-	}
 }
 
 /*
@@ -1814,16 +1639,13 @@
 	set_recovery_timer(drive->channel);
 	drive->PADAM_service_time = jiffies - drive->PADAM_service_start;
 	if (startstop == ide_stopped) {
-		if (hwgroup->handler == NULL) { /* paranoia */
+		if (hwgroup->handler == NULL) {	/* paranoia */
 			clear_bit(IDE_BUSY, &hwgroup->flags);
-			if (test_bit(IDE_DMA, &hwgroup->flags))
-				printk("ide_intr: illegal clear\n");
 			ide_do_request(hwgroup, hwif->irq);
 		} else {
 			printk("%s: ide_intr: huh? expected NULL handler on exit\n", drive->name);
 		}
-	} else if (startstop == ide_released)
-		ide_queue_commands(drive, hwif->irq);
+	}
 
 out_lock:
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -1898,7 +1720,6 @@
 	if (drive->channel->chipset == ide_pdc4030 && rq->buffer != NULL)
 		return -ENOSYS;  /* special drive cmds not supported */
 #endif
-	rq->flags |= REQ_STARTED;
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
@@ -2222,7 +2043,6 @@
 		}
 		drive->present = 0;
 		blk_cleanup_queue(&drive->queue);
-		ide_teardown_commandlist(drive);
 	}
 	if (d->present)
 		hwgroup->drive = d;
@@ -2775,86 +2595,6 @@
 	}
 }
 
-int ide_build_commandlist(ide_drive_t *drive)
-{
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	struct pci_dev *pdev = drive->channel->pci_dev;
-#else
-	struct pci_dev *pdev = NULL;
-#endif
-	struct list_head *p;
-	unsigned long flags;
-	struct ata_request *ar;
-	int i, cur;
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	cur = 0;
-	list_for_each(p, &drive->free_req)
-		cur++;
-
-	/*
-	 * for now, just don't shrink it...
-	 */
-	if (drive->queue_depth <= cur) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 0;
-	}
-
-	for (i = cur; i < drive->queue_depth; i++) {
-		ar = kmalloc(sizeof(*ar), GFP_ATOMIC);
-		if (!ar)
-			break;
-
-		memset(ar, 0, sizeof(*ar));
-		INIT_LIST_HEAD(&ar->ar_queue);
-
-		ar->ar_sg_table = kmalloc(PRD_SEGMENTS * sizeof(struct scatterlist), GFP_ATOMIC);
-		if (!ar->ar_sg_table) {
-			kfree(ar);
-			break;
-		}
-
-		ar->ar_dmatable_cpu = pci_alloc_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, &ar->ar_dmatable);
-		if (!ar->ar_dmatable_cpu) {
-			kfree(ar->ar_sg_table);
-			kfree(ar);
-			break;
-		}
-
-		/*
-		 * pheew, all done, add to list
-		 */
-		list_add_tail(&ar->ar_queue, &drive->free_req);
-		++cur;
-	}
-	drive->queue_depth = cur;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 0;
-}
-
-int ide_init_commandlist(ide_drive_t *drive)
-{
-	INIT_LIST_HEAD(&drive->free_req);
-
-	return ide_build_commandlist(drive);
-}
-
-void ide_teardown_commandlist(ide_drive_t *drive)
-{
-	struct pci_dev *pdev= drive->channel->pci_dev;
-	struct list_head *entry;
-
-	list_for_each(entry, &drive->free_req) {
-		struct ata_request *ar = list_ata_entry(entry);
-
-		list_del(&ar->ar_queue);
-		kfree(ar->ar_sg_table);
-		pci_free_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, ar->ar_dmatable_cpu, ar->ar_dmatable);
-		kfree(ar);
-	}
-}
-
 static int ide_check_media_change (kdev_t i_rdev)
 {
 	ide_drive_t *drive;
@@ -3426,9 +3166,6 @@
 
 			drive->channel->dmaproc(ide_dma_off_quietly, drive);
 			drive->channel->dmaproc(ide_dma_check, drive);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-			drive->channel->dmaproc(ide_dma_queued_on, drive);
-#endif /* CONFIG_BLK_DEV_IDE_TCQ_DEFAULT */
 		}
 		/* Only CD-ROMs and tape drives support DSC overlap. */
 		drive->dsc_overlap = (drive->next != drive
diff -urN linux-2.5.10/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.10/drivers/ide/ide-cd.c	2002-04-23 00:28:59.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-04-25 16:05:40.000000000 +0200
@@ -558,10 +558,6 @@
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
-#if 0
-	/* FIXME --mdcki */
-	HWGROUP(drive)->rq->special = NULL;
-#endif
 	ide_end_request(drive, uptodate);
 }
 
@@ -1217,22 +1213,13 @@
 /*
  * Start a read request from the CD-ROM.
  */
-static ide_startstop_t cdrom_start_read(struct ata_device *drive, struct ata_request *ar, unsigned int block)
+static ide_startstop_t cdrom_start_read (ide_drive_t *drive, unsigned int block)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct request *rq = ar->ar_rq;
-
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-//		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-		blkdev_dequeue_request(rq);
-//		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-	}
-
+	struct request *rq = HWGROUP(drive)->rq;
 
 	restore_request(rq);
 
-	rq->special = ar;
-
 	/* Satisfy whatever we can of this request from our cached sector. */
 	if (cdrom_read_from_buffer(drive))
 		return ide_stopped;
@@ -1665,30 +1652,8 @@
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap)
 			action = cdrom_start_seek (drive, block);
 		else {
-			unsigned long flags;
-			struct ata_request *ar;
-
-			/*
-			 * get a new command (push ar further down to avoid grabbing lock here
-			 */
-			spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-
-			ar = ata_ar_get(drive);
-
-			/*
-			 * we've reached maximum queue depth, bail
-			 */
-			if (!ar) {
-				spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-
-				return ide_started;
-			}
-
-			ar->ar_rq = rq;
-			spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-
 			if (rq_data_dir(rq) == READ)
-				action = cdrom_start_read(drive, ar, block);
+				action = cdrom_start_read(drive, block);
 			else
 				action = cdrom_start_write(drive, rq);
 		}
diff -urN linux-2.5.10/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.10/drivers/ide/ide-disk.c	2002-04-23 00:27:41.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-04-25 17:09:29.000000000 +0200
@@ -88,162 +88,135 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
-/*
- * Determine the apriopriate hardware command correspnding to the action in
- * question, depending upon the device capabilities and setup.
- */
 static u8 get_command(ide_drive_t *drive, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
-	/* Well, calculating the command in this variable may be an
-	 * overoptimization. */
-	u8 command = WIN_NOP;
 
 #if 1
 	lba48bit = drive->addressing;
 #endif
 
-	/*
-	 * 48-bit commands are pretty sanely laid out
-	 */
 	if (lba48bit) {
-		command = cmd == READ ? WIN_READ_EXT : WIN_WRITE_EXT;
-
-		if (drive->using_dma) {
-			command++;		/* WIN_*DMA_EXT */
-			if (drive->using_tcq)
-				command++;	/* WIN_*DMA_QUEUED_EXT */
-		} else if (drive->mult_count)
-			command += 5;		/* WIN_MULT*_EXT */
-
-		return command;
-	}
-
-	/*
-	 * 28-bit commands seem not to be, though...
-	 */
-	if (cmd == READ) {
-		if (drive->using_dma) {
-			if (drive->using_tcq)
-				command = WIN_READDMA_QUEUED;
+		if (cmd == READ) {
+			if (drive->using_dma)
+				return WIN_READDMA_EXT;
+			else if (drive->mult_count)
+				return WIN_MULTREAD_EXT;
 			else
-				command = WIN_READDMA;
-		} else if (drive->mult_count)
-			command = WIN_MULTREAD;
-		else
-			command = WIN_READ;
+				return WIN_READ_EXT;
+		} else if (cmd == WRITE) {
+			if (drive->using_dma)
+				return WIN_WRITEDMA_EXT;
+			else if (drive->mult_count)
+				return WIN_MULTWRITE_EXT;
+			else
+				return WIN_WRITE_EXT;
+		}
 	} else {
-		if (drive->using_dma) {
-			if (drive->using_tcq)
-				command = WIN_WRITEDMA_QUEUED;
+		if (cmd == READ) {
+			if (drive->using_dma)
+				return WIN_READDMA;
+			else if (drive->mult_count)
+				return WIN_MULTREAD;
+			else
+				return WIN_READ;
+		} else if (cmd == WRITE) {
+			if (drive->using_dma)
+				return WIN_WRITEDMA;
+			else if (drive->mult_count)
+				return WIN_MULTWRITE;
 			else
-				command = WIN_WRITEDMA;
-		} else if (drive->mult_count)
-			command = WIN_MULTWRITE;
-		else
-			command = WIN_WRITE;
+				return WIN_WRITE;
+		}
 	}
-
-	return command;
+	return WIN_NOP;
 }
 
-static ide_startstop_t chs_do_request(ide_drive_t *drive, struct ata_request *ar, sector_t block)
+static ide_startstop_t chs_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	struct ata_taskfile *args = &ar->ar_task;
-	struct request *rq = ar->ar_rq;
-	int sectors = rq->nr_sectors;
+	struct hd_drive_task_hdr	taskfile;
+	struct hd_drive_hob_hdr		hobfile;
+	struct ata_taskfile		args;
+	int				sectors;
 
-	unsigned int track = (block / drive->sect);
-	unsigned int sect = (block % drive->sect) + 1;
-	unsigned int head = (track % drive->head);
-	unsigned int cyl = (track / drive->head);
+	unsigned int track	= (block / drive->sect);
+	unsigned int sect	= (block % drive->sect) + 1;
+	unsigned int head	= (track % drive->head);
+	unsigned int cyl	= (track / drive->head);
 
-	memset(&args->taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&args->hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
+	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-		unsigned long flags;
+	taskfile.sector_count	= sectors;
 
-		args->taskfile.feature = sectors;
-		args->taskfile.sector_count = ar->ar_tag << 3;
-
-		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-		blkdev_dequeue_request(rq);
-		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-	} else
-		args->taskfile.sector_count   = sectors;
-
-	args->taskfile.sector_number = sect;
-	args->taskfile.low_cylinder = cyl;
-	args->taskfile.high_cylinder = (cyl>>8);
-
-	args->taskfile.device_head = head;
-	args->taskfile.device_head |= drive->select.all;
-	args->taskfile.command = get_command(drive, rq_data_dir(rq));
+	taskfile.sector_number	= sect;
+	taskfile.low_cylinder	= cyl;
+	taskfile.high_cylinder	= (cyl>>8);
+
+	taskfile.device_head	= head;
+	taskfile.device_head	|= drive->select.all;
+	taskfile.command	=  get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
 		(rq_data_dir(rq)==READ) ? "read" : "writ");
+	if (lba)	printk("LBAsect=%lld, ", block);
+	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	ide_cmd_type_parser(args);
-	args->ar = ar;
-	rq->special = ar;
+	args.taskfile = taskfile;
+	args.hobfile = hobfile;
+	ide_cmd_type_parser(&args);
+	rq->special = &args;
 
-	return ata_taskfile(drive, args, rq);
+	return ata_taskfile(drive, &args, rq);
 }
 
-static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct ata_request *ar, sector_t block)
+static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	struct ata_taskfile *args = &ar->ar_task;
-	struct request *rq = ar->ar_rq;
-	int sectors = rq->nr_sectors;
+	struct hd_drive_task_hdr	taskfile;
+	struct hd_drive_hob_hdr		hobfile;
+	struct ata_taskfile		args;
+	int				sectors;
 
+	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	memset(&args->taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&args->hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-		unsigned long flags;
-
-		args->taskfile.feature = sectors;
-		args->taskfile.sector_count = ar->ar_tag << 3;
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
-		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-		blkdev_dequeue_request(rq);
-		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-	} else
-		args->taskfile.sector_count = sectors;
-
-	args->taskfile.sector_number = block;
-	args->taskfile.low_cylinder = (block >>= 8);
-
-	args->taskfile.high_cylinder = (block >>= 8);
-
-	args->taskfile.device_head = ((block >> 8) & 0x0f);
-	args->taskfile.device_head |= drive->select.all;
-	args->taskfile.command = get_command(drive, rq_data_dir(rq));
+	taskfile.sector_count	= sectors;
+	taskfile.sector_number	= block;
+	taskfile.low_cylinder	= (block >>= 8);
+
+	taskfile.high_cylinder	= (block >>= 8);
+
+	taskfile.device_head	= ((block >> 8) & 0x0f);
+	taskfile.device_head	|= drive->select.all;
+	taskfile.command	= get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
 		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	printk("sector=%lx, sectors=%ld, ", block, rq->nr_sectors);
+	if (lba)	printk("LBAsect=%lld, ", block);
+	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
+	printk("sectors=%ld, ", rq->nr_sectors);
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	ide_cmd_type_parser(args);
-	args->ar = ar;
-	rq->special = ar;
+	args.taskfile = taskfile;
+	args.hobfile = hobfile;
+	ide_cmd_type_parser(&args);
+	rq->special = &args;
 
-	return ata_taskfile(drive, args, rq);
+	return ata_taskfile(drive, &args, rq);
 }
 
 /*
@@ -251,58 +224,57 @@
  * 320173056  == 163929 MB or 48bit addressing
  * 1073741822 == 549756 MB or 48bit addressing fake drive
  */
-static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct ata_request *ar, sector_t block)
+
+static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct request *rq, unsigned long long block)
 {
-	struct ata_taskfile *args = &ar->ar_task;
-	struct request *rq = ar->ar_rq;
-	int sectors = rq->nr_sectors;
+	struct hd_drive_task_hdr	taskfile;
+	struct hd_drive_hob_hdr		hobfile;
+	struct ata_taskfile		args;
+	int				sectors;
 
-	memset(&args->taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&args->hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
+	sectors = rq->nr_sectors;
 	if (sectors == 65536)
 		sectors = 0;
 
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-		unsigned long flags;
-
-		args->taskfile.feature = sectors;
-		args->hobfile.feature = sectors >> 8;
-		args->taskfile.sector_count = ar->ar_tag << 3;
-
-		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-		blkdev_dequeue_request(rq);
-		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-	} else {
-		args->taskfile.sector_count = sectors;
-		args->hobfile.sector_count = sectors >> 8;
-	}
+	taskfile.sector_count	= sectors;
+	hobfile.sector_count	= sectors >> 8;
 
-	args->taskfile.sector_number = block;
-	args->taskfile.low_cylinder = (block >>= 8);
-	args->taskfile.high_cylinder = (block >>= 8);
-
-	args->hobfile.sector_number = (block >>= 8);
-	args->hobfile.low_cylinder = (block >>= 8);
-	args->hobfile.high_cylinder = (block >>= 8);
-
-	args->taskfile.device_head = drive->select.all;
-	args->hobfile.device_head = args->taskfile.device_head;
-	args->hobfile.control = (drive->ctl|0x80);
-	args->taskfile.command = get_command(drive, rq_data_dir(rq));
+	if (rq->nr_sectors == 65536) {
+		taskfile.sector_count	= 0x00;
+		hobfile.sector_count	= 0x00;
+	}
+
+	taskfile.sector_number	= block;		/* low lba */
+	taskfile.low_cylinder	= (block >>= 8);	/* mid lba */
+	taskfile.high_cylinder	= (block >>= 8);	/* hi  lba */
+
+	hobfile.sector_number	= (block >>= 8);	/* low lba */
+	hobfile.low_cylinder	= (block >>= 8);	/* mid lba */
+	hobfile.high_cylinder	= (block >>= 8);	/* hi  lba */
+
+	taskfile.device_head	= drive->select.all;
+	hobfile.device_head	= taskfile.device_head;
+	hobfile.control		= (drive->ctl|0x80);
+	taskfile.command	= get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
 		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	printk("sector=%lx, sectors=%ld, ", block, rq->nr_sectors);
+	if (lba)	printk("LBAsect=%lld, ", block);
+	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
+	printk("sectors=%ld, ", rq->nr_sectors);
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	ide_cmd_type_parser(args);
-	args->ar = ar;
-	rq->special = ar;
+	args.taskfile = taskfile;
+	args.hobfile = hobfile;
+	ide_cmd_type_parser(&args);
+	rq->special = &args;
 
-	return ata_taskfile(drive, args, rq);
+	return ata_taskfile(drive, &args, rq);
 }
 
 /*
@@ -310,11 +282,8 @@
  * otherwise, to address sectors.  It also takes care of issuing special
  * DRIVE_CMDs.
  */
-static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, sector_t block)
+static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	unsigned long flags;
-	struct ata_request *ar;
-
 	/*
 	 * Wait until all request have bin finished.
 	 */
@@ -336,49 +305,16 @@
 		return promise_rw_disk(drive, rq, block);
 	}
 
-	/*
-	 * get a new command (push ar further down to avoid grabbing lock here
-	 */
-	spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-
-	ar = ata_ar_get(drive);
-
-	/*
-	 * we've reached maximum queue depth, bail
-	 */
-	if (!ar) {
-		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-		return ide_started;
-	}
-
-	ar->ar_rq = rq;
-
-	if (drive->using_tcq) {
-		int tag = ide_get_tag(drive);
-
-		BUG_ON(drive->tcq->active_tag != -1);
-
-		/* Set the tag: */
-		ar->ar_flags |= ATA_AR_QUEUED;
-		ar->ar_tag = tag;
-		drive->tcq->ar[tag] = ar;
-		drive->tcq->active_tag = tag;
-		ar->ar_time = jiffies;
-		drive->tcq->queued++;
-	}
-
-	spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-
 	/* 48-bit LBA */
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
-		return lba48_do_request(drive, ar, block);
+		return lba48_do_request(drive, rq, block);
 
 	/* 28-bit LBA */
 	if (drive->select.b.lba)
-		return lba28_do_request(drive, ar, block);
+		return lba28_do_request(drive, rq, block);
 
 	/* 28-bit CHS */
-	return chs_do_request(drive, ar, block);
+	return chs_do_request(drive, rq, block);
 }
 
 static int idedisk_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
@@ -861,71 +797,11 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-static int proc_idedisk_read_tcq
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	char		*out = page;
-	int		len, cmds, i;
-	unsigned long tag_mask = 0, flags, cur_jif = jiffies, max_jif;
-
-	if (!drive->tcq) {
-		len = sprintf(out, "not configured\n");
-		PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
-	}
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	len = sprintf(out, "TCQ currently on:\t%s\n", drive->using_tcq ? "yes" : "no");
-	len += sprintf(out+len, "Max queue depth:\t%d\n",drive->queue_depth);
-	len += sprintf(out+len, "Max achieved depth:\t%d\n",drive->tcq->max_depth);
-	len += sprintf(out+len, "Max depth since last:\t%d\n",drive->tcq->max_last_depth);
-	len += sprintf(out+len, "Current depth:\t\t%d\n", drive->tcq->queued);
-	max_jif = 0;
-	len += sprintf(out+len, "Active tags:\t\t[ ");
-	for (i = 0, cmds = 0; i < drive->queue_depth; i++) {
-		struct ata_request *ar = IDE_GET_AR(drive, i);
-
-		if (!ar)
-			continue;
-
-		__set_bit(i, &tag_mask);
-		len += sprintf(out+len, "%d, ", i);
-		if (cur_jif - ar->ar_time > max_jif)
-			max_jif = cur_jif - ar->ar_time;
-		cmds++;
-	}
-	len += sprintf(out+len, "]\n");
-
-	len += sprintf(out+len, "Queue:\t\t\treleased [ %d ] - started [ %d ]\n", drive->tcq->immed_rel, drive->tcq->immed_comp);
-
-	if (drive->tcq->queued != cmds)
-		len += sprintf(out+len, "pending request and queue count mismatch (counted: %d)\n", cmds);
-
-	if (tag_mask != drive->tcq->tag_mask)
-		len += sprintf(out+len, "tag masks differ (counted %lx != %lx\n", tag_mask, drive->tcq->tag_mask);
-
-	len += sprintf(out+len, "DMA status:\t\t%srunning\n", test_bit(IDE_DMA, &HWGROUP(drive)->flags) ? "" : "not ");
-
-	len += sprintf(out+len, "Oldest command:\t\t%lu jiffies\n", max_jif);
-	len += sprintf(out+len, "Oldest command ever:\t%lu\n", drive->tcq->oldest_command);
-
-	drive->tcq->max_last_depth = 0;
-
-	spin_unlock_irqrestore(&ide_lock, flags);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
-}
-#endif
-
 static ide_proc_entry_t idedisk_proc[] = {
 	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
 	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
 	{ "smart_values",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_values,		NULL },
 	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	{ "tcq",		S_IFREG|S_IRUSR,	proc_idedisk_read_tcq,	NULL },
-#endif
 	{ NULL, 0, NULL, NULL }
 };
 
@@ -1007,24 +883,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-static int set_using_tcq(ide_drive_t *drive, int arg)
-{
-	if (!drive->driver)
-		return -EPERM;
-	if (!drive->channel->dmaproc)
-		return -EPERM;
-	if (arg == drive->queue_depth && drive->using_tcq)
-		return 0;
-
-	drive->queue_depth = arg ? arg : 1;
-	if (drive->channel->dmaproc(arg ? ide_dma_queued_on : ide_dma_queued_off, drive))
-		return -EIO;
-
-	return 0;
-}
-#endif
-
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -1056,9 +914,6 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
 	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
-#endif
 }
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
diff -urN linux-2.5.10/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.10/drivers/ide/ide-dma.c	2002-04-23 00:28:11.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-04-25 16:42:48.000000000 +0200
@@ -209,36 +209,29 @@
 			__ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
-		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
+		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
 		       drive->name, dma_stat);
 	}
 	return ide_error(drive, "dma_intr", stat);
 }
 
-int ide_build_sglist(struct ata_channel *hwif, struct request *rq)
+static int ide_build_sglist(struct ata_channel *hwif, struct request *rq)
 {
 	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
-	struct ata_request *ar = rq->special;
+	struct scatterlist *sg = hwif->sg_table;
+	int nents;
 
-	if (!(ar->ar_flags & ATA_AR_SETUP)) {
-		ar->ar_flags |= ATA_AR_SETUP;
-		ar->ar_sg_nents = blk_rq_map_sg(q, rq, ar->ar_sg_table);
-	}
+	nents = blk_rq_map_sg(q, rq, hwif->sg_table);
 
-	if (rq->q && ar->ar_sg_nents > rq->nr_phys_segments) {
-		printk("%s: received %d phys segments, build %d\n", __FILE__, rq->nr_phys_segments, ar->ar_sg_nents);
-		return 0;
-	} else if (!ar->ar_sg_nents) {
-		printk("%s: zero segments in request\n", __FILE__);
-		return 0;
-	}
+	if (rq->q && nents > rq->nr_phys_segments)
+		printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
 
 	if (rq_data_dir(rq) == READ)
-		ar->ar_sg_ddir = PCI_DMA_FROMDEVICE;
+		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
-		ar->ar_sg_ddir = PCI_DMA_TODEVICE;
+		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
 
-	return pci_map_sg(hwif->pci_dev, ar->ar_sg_table, ar->ar_sg_nents, ar->ar_sg_ddir);
+	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
 /*
@@ -247,17 +240,23 @@
  */
 static int raw_build_sglist(struct ata_channel *ch, struct request *rq)
 {
-	struct ata_request *ar = rq->special;
-	struct scatterlist *sg = ar->ar_sg_table;
-	struct ata_taskfile *args = &ar->ar_task;
+	struct scatterlist *sg = ch->sg_table;
+	int nents = 0;
+	struct ata_taskfile *args = rq->special;
+#if 1
 	unsigned char *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
-	int nents = 0;
+#else
+        nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
+
+	if (nents > rq->nr_segments)
+		printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
+#endif
 
 	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		ar->ar_sg_ddir = PCI_DMA_TODEVICE;
+		ch->sg_dma_direction = PCI_DMA_TODEVICE;
 	else
-		ar->ar_sg_ddir = PCI_DMA_FROMDEVICE;
+		ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
 
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
@@ -275,18 +274,18 @@
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
 
-	return pci_map_sg(ch->pci_dev, sg, nents, ar->ar_sg_ddir);
+	return pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
 }
 
 /*
- * Prepare a dma request.
+ * ide_build_dmatable() prepares a dma request.
  * Returns 0 if all went okay, returns 1 otherwise.
- * This may also be invoked from trm290.c
+ * May also be invoked from trm290.c
  */
-int ide_build_dmatable(ide_drive_t *drive, struct request *rq,
-		       ide_dma_action_t func)
+int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func)
 {
 	struct ata_channel *hwif = drive->channel;
+	unsigned int *table = hwif->dmatable_cpu;
 #ifdef CONFIG_BLK_DEV_TRM290
 	unsigned int is_trm290_chipset = (hwif->chipset == ide_trm290);
 #else
@@ -295,19 +294,16 @@
 	unsigned int count = 0;
 	int i;
 	struct scatterlist *sg;
-	struct ata_request *ar = rq->special;
-	unsigned int *table = ar->ar_dmatable_cpu;
-
-	if (rq->flags & REQ_DRIVE_TASKFILE)
-		ar->ar_sg_nents = raw_build_sglist(hwif, rq);
-	else
-		ar->ar_sg_nents = ide_build_sglist(hwif, rq);
 
-	if (!ar->ar_sg_nents)
+	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
+		hwif->sg_nents = i = raw_build_sglist(hwif, HWGROUP(drive)->rq);
+	} else {
+		hwif->sg_nents = i = ide_build_sglist(hwif, HWGROUP(drive)->rq);
+	}
+	if (!i)
 		return 0;
 
-	sg = ar->ar_sg_table;
-	i = ar->ar_sg_nents;
+	sg = hwif->sg_table;
 	while (i) {
 		u32 cur_addr;
 		u32 cur_len;
@@ -326,7 +322,7 @@
 
 			if (count++ >= PRD_ENTRIES) {
 				printk("ide-dma: req %p\n", HWGROUP(drive)->rq);
-				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, ar->ar_sg_nents, cur_len, cur_addr);
+				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, hwif->sg_nents, cur_len, cur_addr);
 				BUG();
 			}
 
@@ -337,7 +333,7 @@
 			if (is_trm290_chipset)
 				xcount = ((xcount >> 2) - 1) << 16;
 			if (xcount == 0x0000) {
-		        /*
+		        /* 
 			 * Most chipsets correctly interpret a length of
 			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
 			 * misinterprets it as zero (!). So here we break
@@ -345,8 +341,8 @@
 			 */
 				if (count++ >= PRD_ENTRIES) {
 					pci_unmap_sg(hwif->pci_dev, sg,
-						     ar->ar_sg_nents,
-						     ar->ar_sg_ddir);
+						     hwif->sg_nents,
+						     hwif->sg_dma_direction);
 					return 0;
 				}
 
@@ -372,12 +368,13 @@
 }
 
 /* Teardown mappings after DMA has completed.  */
-void ide_destroy_dmatable(struct ata_device *d)
+void ide_destroy_dmatable (ide_drive_t *drive)
 {
-	struct pci_dev *dev = d->channel->pci_dev;
-	struct ata_request *ar = IDE_CUR_AR(d);
+	struct pci_dev *dev = drive->channel->pci_dev;
+	struct scatterlist *sg = drive->channel->sg_table;
+	int nents = drive->channel->sg_nents;
 
-	pci_unmap_sg(dev, ar->ar_sg_table, ar->ar_sg_nents, ar->ar_sg_ddir);
+	pci_unmap_sg(dev, sg, nents, drive->channel->sg_dma_direction);
 }
 
 /*
@@ -435,7 +432,7 @@
 			printk(", UDMA(133)");	/* UDMA BIOS-enabled! */
 		}
 	} else if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-		  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
+	  	  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
 		if ((id->dma_ultra >> 13) & 1) {
 			printk(", UDMA(100)");	/* UDMA BIOS-enabled! */
 		} else if ((id->dma_ultra >> 12) & 1) {
@@ -538,41 +535,6 @@
 }
 
 /*
- * Start DMA engine.
- */
-int ide_start_dma(struct ata_channel *hwif, ide_drive_t *drive, ide_dma_action_t func)
-{
-	unsigned int reading = 0, count;
-	unsigned long dma_base = hwif->dma_base;
-	struct ata_request *ar = IDE_CUR_AR(drive);
-
-	/* This can happen with drivers abusing the special request field.
-	 */
-
-	if (!ar) {
-		printk(KERN_ERR "DMA without ATA request\n");
-
-		return 1;
-	}
-
-	if (rq_data_dir(ar->ar_rq) == READ)
-		reading = 1 << 3;
-
-	if (hwif->rwproc)
-		hwif->rwproc(drive, func);
-
-	if (!(count = ide_build_dmatable(drive, ar->ar_rq, func)))
-		return 1;	/* try PIO instead of DMA */
-
-	ar->ar_flags |= ATA_AR_SETUP;
-	outl(ar->ar_dmatable, dma_base + 4);	/* PRD table */
-	outb(reading, dma_base);		/* specify r/w */
-	outb(inb(dma_base + 2) | 6, dma_base+2);/* clear INTR & ERROR flags */
-	drive->waiting_for_dma = 1;
-	return 0;
-}
-
-/*
  * ide_dmaproc() initiates/aborts DMA read/write operations on a drive.
  *
  * The caller is assumed to have selected the drive and programmed the drive's
@@ -592,10 +554,9 @@
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
-	u8 unit = (drive->select.b.unit & 0x01);
-	unsigned int reading = 0, set_high = 1;
-	struct ata_request *ar;
-	u8 dma_stat;
+	byte unit = (drive->select.b.unit & 0x01);
+	unsigned int count, reading = 0, set_high = 1;
+	byte dma_stat;
 
 	switch (func) {
 		case ide_dma_off:
@@ -603,68 +564,54 @@
 		case ide_dma_off_quietly:
 			set_high = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-			hwif->dmaproc(ide_dma_queued_off, drive);
-#endif
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
 			drive->using_dma = (func == ide_dma_on);
-			if (drive->using_dma) {
+			if (drive->using_dma)
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-				hwif->dmaproc(ide_dma_queued_on, drive);
-#endif
-			}
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
-		case ide_dma_begin:
-			if (test_and_set_bit(IDE_DMA, &HWGROUP(drive)->flags))
-				BUG();
-			/* Note that this is done *after* the cmd has
-			 * been issued to the drive, as per the BM-IDE spec.
-			 * The Promise Ultra33 doesn't work correctly when
-			 * we do this part before issuing the drive cmd.
-			 */
-			outb(inb(dma_base)|1, dma_base);		/* start DMA */
-			return 0;
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-		case ide_dma_queued_on:
-		case ide_dma_queued_off:
-		case ide_dma_read_queued:
-		case ide_dma_write_queued:
-		case ide_dma_queued_start:
-			return ide_tcq_dmaproc(func, drive);
-#endif
-
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			ar = IDE_CUR_AR(drive);
-
-			if (ide_start_dma(hwif, drive, func))
-				return 1;
-
+			/* active tuning based on IO direction */
+			if (hwif->rwproc)
+				hwif->rwproc(drive, func);
+
+			if (!(count = ide_build_dmatable(drive, func)))
+				return 1;	/* try PIO instead of DMA */
+			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+			outb(reading, dma_base);			/* specify r/w */
+			outb(inb(dma_base+2)|6, dma_base+2);		/* clear INTR & ERROR flags */
+			drive->waiting_for_dma = 1;
 			if (drive->type != ATA_DISK)
 				return 0;
+
 			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-			if ((ar->ar_rq->flags & REQ_DRIVE_TASKFILE) &&
+			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
 			    (drive->addressing == 1)) {
-				struct ata_taskfile *args = &ar->ar_task;
+				struct ata_taskfile *args = HWGROUP(drive)->rq->special;
 				OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 			} else if (drive->addressing) {
 				OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
 			} else {
 				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			}
-			return hwif->dmaproc(ide_dma_begin, drive);
+			return drive->channel->dmaproc(ide_dma_begin, drive);
+		case ide_dma_begin:
+			/* Note that this is done *after* the cmd has
+			 * been issued to the drive, as per the BM-IDE spec.
+			 * The Promise Ultra33 doesn't work correctly when
+			 * we do this part before issuing the drive cmd.
+			 */
+			outb(inb(dma_base)|1, dma_base);		/* start DMA */
+			return 0;
 		case ide_dma_end: /* returns 1 on error, 0 otherwise */
-			if (!test_and_clear_bit(IDE_DMA, &HWGROUP(drive)->flags))
-				BUG();
 			drive->waiting_for_dma = 0;
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-			dma_stat = inb(dma_base+2);	/* get DMA status */
+			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
 			ide_destroy_dmatable(drive);	/* purge DMA mappings */
 			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
@@ -687,7 +634,7 @@
 			return 1;
 		case ide_dma_retune:
 		case ide_dma_lostirq:
-			printk(KERN_ERR "%s: chipset supported func only: %d\n", __FUNCTION__, func);
+			printk(KERN_ERR "%s: chipset supported func only: %d\n", __FUNCTION__,  func);
 			return 1;
 		default:
 			printk(KERN_ERR "%s: unsupported func: %d\n", __FUNCTION__, func);
@@ -703,6 +650,17 @@
 	if (!hwif->dma_base)
 		return;
 
+	if (hwif->dmatable_cpu) {
+		pci_free_consistent(hwif->pci_dev,
+				    PRD_ENTRIES * PRD_BYTES,
+				    hwif->dmatable_cpu,
+				    hwif->dmatable_dma);
+		hwif->dmatable_cpu = NULL;
+	}
+	if (hwif->sg_table) {
+		kfree(hwif->sg_table);
+		hwif->sg_table = NULL;
+	}
 	if ((hwif->dma_extra) && (hwif->unit == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
@@ -721,6 +679,20 @@
 	}
 	request_region(dma_base, num_ports, hwif->name);
 	hwif->dma_base = dma_base;
+	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
+						  PRD_ENTRIES * PRD_BYTES,
+						  &hwif->dmatable_dma);
+	if (hwif->dmatable_cpu == NULL)
+		goto dma_alloc_failure;
+
+	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
+				 GFP_KERNEL);
+	if (hwif->sg_table == NULL) {
+		pci_free_consistent(hwif->pci_dev, PRD_ENTRIES * PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
+		goto dma_alloc_failure;
+	}
+
 	hwif->dmaproc = &ide_dmaproc;
 
 	if (hwif->chipset != ide_trm290) {
@@ -731,4 +703,7 @@
 	}
 	printk("\n");
 	return;
+
+dma_alloc_failure:
+	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
 }
diff -urN linux-2.5.10/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.10/drivers/ide/ide-probe.c	2002-04-23 00:27:40.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-04-25 16:25:18.000000000 +0200
@@ -168,9 +168,6 @@
 		}
 		printk (" drive\n");
 		drive->type = type;
-
-		goto init_queue;
-
 		return;
 	}
 
@@ -201,22 +198,6 @@
 	if (drive->channel->quirkproc)
 		drive->quirk_list = drive->channel->quirkproc(drive);
 
-init_queue:
-	/*
-	 * it's an ata drive, build command list
-	 */
-	drive->queue_depth = 1;
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEPTH
-	drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
-#else
-	drive->queue_depth = drive->id->queue_depth + 1;
-#endif
-	if (drive->queue_depth < 1 || drive->queue_depth > IDE_MAX_TAG)
-		drive->queue_depth = IDE_MAX_TAG;
-
-	if (ide_init_commandlist(drive))
-		goto err_misc;
-
 	return;
 
 err_misc:
diff -urN linux-2.5.10/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.10/drivers/ide/ide-taskfile.c	2002-04-23 00:29:15.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-04-25 16:25:18.000000000 +0200
@@ -308,8 +308,7 @@
 
 static ide_startstop_t pre_task_mulout_intr(ide_drive_t *drive, struct request *rq)
 {
-	struct ata_request *ar = rq->special;
-	struct ata_taskfile *args = &ar->ar_task;
+	struct ata_taskfile *args = rq->special;
 	ide_startstop_t startstop;
 
 	/*
@@ -464,35 +463,11 @@
 		if (args->prehandler != NULL)
 			return args->prehandler(drive, rq);
 	} else {
-		ide_dma_action_t dmaaction;
-		u8 command;
-
-		if (!drive->using_dma)
-			return ide_started;
-
-		command = args->taskfile.command;
-
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-		if (drive->using_tcq) {
-			if (command == WIN_READDMA_QUEUED
-			    || command == WIN_READDMA_QUEUED_EXT
-			    || command == WIN_WRITEDMA_QUEUED
-			    || command == WIN_READDMA_QUEUED_EXT)
-				return ide_start_tag(ide_dma_queued_start, drive, rq->special);
-		}
-#endif
-
-		if (command == WIN_WRITEDMA || command == WIN_WRITEDMA_EXT)
-			dmaaction = ide_dma_write;
-		else if (command == WIN_READDMA || command == WIN_READDMA_EXT)
-			dmaaction = ide_dma_read;
-		else
-			return ide_stopped;
-
-		if (!drive->channel->dmaproc(dmaaction, drive))
-			return ide_started;
-
-		return ide_stopped;
+		/* for dma commands we down set the handler */
+		if (drive->using_dma &&
+		!(drive->channel->dmaproc(((args->taskfile.command == WIN_WRITEDMA)
+					|| (args->taskfile.command == WIN_WRITEDMA_EXT))
+					? ide_dma_write : ide_dma_read, drive)));
 	}
 
 	return ide_started;
@@ -545,30 +520,12 @@
 }
 
 /*
- * Quiet handler for commands without a data phase -- handy instead of
- * task_no_data_intr() for commands we _know_ will fail (such as WIN_NOP)
- */
-ide_startstop_t task_no_data_quiet_intr(ide_drive_t *drive)
-{
-	struct ata_request *ar = IDE_CUR_AR(drive);
-	struct ata_taskfile *args = &ar->ar_task;
-
-	ide__sti();	/* local CPU only */
-
-	if (args)
-		ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
-
-	return ide_stopped;
-}
-
-/*
  * Handler for commands without a data phase
  */
 ide_startstop_t task_no_data_intr (ide_drive_t *drive)
 {
-	struct ata_request *ar = IDE_CUR_AR(drive);
-	struct ata_taskfile *args = &ar->ar_task;
-	u8 stat = GET_STAT();
+	struct ata_taskfile *args = HWGROUP(drive)->rq->special;
+	byte stat		= GET_STAT();
 
 	ide__sti();	/* local CPU only */
 
@@ -628,8 +585,7 @@
 
 static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 {
-	struct ata_request *ar = rq->special;
-	struct ata_taskfile *args = &ar->ar_task;
+	struct ata_taskfile *args = rq->special;
 	ide_startstop_t startstop;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
@@ -909,7 +865,6 @@
 			return;
 
 		case WIN_NOP:
-			args->handler = task_no_data_quiet_intr;
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
@@ -927,7 +882,7 @@
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-void init_taskfile_request(struct request *rq)
+static void init_taskfile_request(struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_TASKFILE;
@@ -936,29 +891,18 @@
 int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
-	struct ata_request star;
-	int ret;
-
-	ata_ar_init(drive, &star);
 	init_taskfile_request(&rq);
-	rq.buffer = buf;
 
-	memcpy(&star.ar_task, args, sizeof(*args));
+	rq.buffer = buf;
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
 		rq.current_nr_sectors = rq.nr_sectors
 			= (args->hobfile.sector_count << 8)
 			| args->taskfile.sector_count;
 
-	rq.special = &star;
+	rq.special = args;
 
-	ret = ide_do_drive_cmd(drive, &rq, ide_wait);
-
-	/*
-	 * copy back status etc
-	 */
-	memcpy(args, &star.ar_task, sizeof(*args));
-	return ret;
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
 /*
diff -urN linux-2.5.10/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- linux-2.5.10/drivers/ide/ide-tcq.c	2002-04-23 00:29:44.000000000 +0200
+++ linux/drivers/ide/ide-tcq.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,689 +0,0 @@
-/*
- * Copyright (C) 2001, 2002 Jens Axboe <axboe@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * Support for the DMA queued protocol, which enables ATA disk drives to
- * use tagged command queueing.
- */
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/ide.h>
-
-#include <asm/delay.h>
-
-/*
- * warning: it will be _very_ verbose if defined
- */
-#undef IDE_TCQ_DEBUG
-
-#ifdef IDE_TCQ_DEBUG
-#define TCQ_PRINTK printk
-#else
-#define TCQ_PRINTK(x...)
-#endif
-
-/*
- * use nIEN or not
- */
-#undef IDE_TCQ_NIEN
-
-/*
- * we are leaving the SERVICE interrupt alone, IBM drives have it
- * on per default and it can't be turned off. Doesn't matter, this
- * is the sane config.
- */
-#undef IDE_TCQ_FIDDLE_SI
-
-ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
-ide_startstop_t ide_service(ide_drive_t *drive);
-
-static inline void drive_ctl_nien(ide_drive_t *drive, int set)
-{
-#ifdef IDE_TCQ_NIEN
-	if (IDE_CONTROL_REG) {
-		int mask = set ? 0x02 : 0x00;
-
-		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
-	}
-#endif
-}
-
-/*
- * if we encounter _any_ error doing I/O to one of the tags, we must
- * invalidate the pending queue. clear the software busy queue and requeue
- * on the request queue for restart. issue a WIN_NOP to clear hardware queue
- */
-static void ide_tcq_invalidate_queue(ide_drive_t *drive)
-{
-	request_queue_t *q = &drive->queue;
-	unsigned long flags;
-	struct ata_request *ar;
-	int i;
-
-	printk("%s: invalidating pending queue (%d)\n", drive->name, drive->tcq->queued);
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	del_timer(&HWGROUP(drive)->timer);
-
-	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
-		drive->channel->dmaproc(ide_dma_end, drive);
-
-	/*
-	 * assume oldest commands have the higher tags... doesn't matter
-	 * much. shove requests back into request queue.
-	 */
-	for (i = drive->queue_depth - 1; i; i--) {
-		ar = drive->tcq->ar[i];
-		if (!ar)
-			continue;
-
-		ar->ar_rq->special = NULL;
-		ar->ar_rq->flags &= ~REQ_STARTED;
-		_elv_add_request(q, ar->ar_rq, 0, 0);
-		ata_ar_put(drive, ar);
-	}
-
-	drive->tcq->queued = 0;
-	drive->using_tcq = 0;
-	drive->queue_depth = 1;
-	clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
-	clear_bit(IDE_DMA, &HWGROUP(drive)->flags);
-	HWGROUP(drive)->handler = NULL;
-
-	/*
-	 * do some internal stuff -- we really need this command to be
-	 * executed before any new commands are started. issue a NOP
-	 * to clear internal queue on drive
-	 */
-	ar = ata_ar_get(drive);
-
-	memset(&ar->ar_task, 0, sizeof(ar->ar_task));
-	AR_TASK_CMD(ar) = WIN_NOP;
-	ide_cmd_type_parser(&ar->ar_task);
-	ar->ar_rq = &HWGROUP(drive)->wrq;
-	init_taskfile_request(ar->ar_rq);
-	ar->ar_rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
-	ar->ar_rq->special = ar;
-	_elv_add_request(q, ar->ar_rq, 0, 0);
-
-	/*
-	 * make sure that nIEN is cleared
-	 */
-	drive_ctl_nien(drive, 0);
-
-	/*
-	 * start doing stuff again
-	 */
-	q->request_fn(q);
-	spin_unlock_irqrestore(&ide_lock, flags);
-	printk("ide_tcq_invalidate_queue: done\n");
-}
-
-void ide_tcq_intr_timeout(unsigned long data)
-{
-	ide_hwgroup_t *hwgroup = (ide_hwgroup_t *) data;
-	unsigned long flags;
-	ide_drive_t *drive;
-
-	printk("ide_tcq_intr_timeout: timeout waiting for interrupt...\n");
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	if (test_and_set_bit(IDE_BUSY, &hwgroup->flags))
-		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
-	if (hwgroup->handler == NULL)
-		printk("ide_tcq_intr_timeout: missing isr!\n");
-	if ((drive = hwgroup->drive) == NULL)
-		printk("ide_tcq_intr_timeout: missing drive!\n");
-
-	spin_unlock_irqrestore(&ide_lock, flags);
-
-	/*
-	 * if pending commands, try service before giving up
-	 */
-	if (ide_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
-		if (ide_service(drive) == ide_started)
-			return;
-
-	if (drive)
-		ide_tcq_invalidate_queue(drive);
-}
-
-void ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ide_handler_t *handler)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	/*
-	 * always just bump the timer for now, the timeout handling will
-	 * have to be changed to be per-command
-	 */
-	hwgroup->timer.function = ide_tcq_intr_timeout;
-	hwgroup->timer.data = (unsigned long) hwgroup;
-	mod_timer(&hwgroup->timer, jiffies + 5 * HZ);
-
-	hwgroup->handler = handler;
-	spin_unlock_irqrestore(&ide_lock, flags);
-}
-
-/*
- * wait 400ns, then poll for busy_mask to clear from alt status
- */
-#define IDE_TCQ_WAIT	(10000)
-int ide_tcq_wait_altstat(ide_drive_t *drive, byte *stat, byte busy_mask)
-{
-	int i = 0;
-
-	udelay(1);
-
-	while ((*stat = GET_ALTSTAT()) & busy_mask) {
-		udelay(10);
-
-		if (unlikely(i++ > IDE_TCQ_WAIT))
-			return 1;
-	}
-
-	return 0;
-}
-
-/*
- * issue SERVICE command to drive -- drive must have been selected first,
- * and it must have reported a need for service (status has SERVICE_STAT set)
- *
- * Also, nIEN must be set as not to need protection against ide_dmaq_intr
- */
-ide_startstop_t ide_service(ide_drive_t *drive)
-{
-	struct ata_request *ar;
-	byte feat, stat;
-	int tag, ret;
-
-	TCQ_PRINTK("%s: started service\n", drive->name);
-
-	/*
-	 * could be called with IDE_DMA in-progress from invalidate
-	 * handler, refuse to do anything
-	 */
-	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
-		return ide_stopped;
-
-	/*
-	 * need to select the right drive first...
-	 */
-	if (drive != HWGROUP(drive)->drive) {
-		SELECT_DRIVE(drive->channel, drive);
-		udelay(10);
-	}
-
-	drive_ctl_nien(drive, 1);
-
-	/*
-	 * send SERVICE, wait 400ns, wait for BUSY_STAT to clear
-	 */
-	OUT_BYTE(WIN_QUEUED_SERVICE, IDE_COMMAND_REG);
-
-	if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
-		printk("ide_service: BUSY clear took too long\n");
-		ide_dump_status(drive, "ide_service", stat);
-		ide_tcq_invalidate_queue(drive);
-		return ide_stopped;
-	}
-
-	drive_ctl_nien(drive, 0);
-
-	/*
-	 * FIXME, invalidate queue
-	 */
-	if (stat & ERR_STAT) {
-		ide_dump_status(drive, "ide_service", stat);
-		ide_tcq_invalidate_queue(drive);
-		return ide_stopped;
-	}
-
-	/*
-	 * should not happen, a buggy device could introduce loop
-	 */
-	if ((feat = GET_FEAT()) & NSEC_REL) {
-		printk("%s: release in service\n", drive->name);
-		IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
-		return ide_stopped;
-	}
-
-	tag = feat >> 3;
-	IDE_SET_CUR_TAG(drive, tag);
-
-	TCQ_PRINTK("ide_service: stat %x, feat %x\n", stat, feat);
-
-	if ((ar = IDE_CUR_TAG(drive)) == NULL) {
-		printk("ide_service: missing request for tag %d\n", tag);
-		return ide_stopped;
-	}
-
-	HWGROUP(drive)->rq = ar->ar_rq;
-
-	/*
-	 * we'll start a dma read or write, device will trigger
-	 * interrupt to indicate end of transfer, release is not allowed
-	 */
-	if (rq_data_dir(ar->ar_rq) == READ) {
-		TCQ_PRINTK("ide_service: starting READ %x\n", stat);
-		ret = drive->channel->dmaproc(ide_dma_read_queued, drive);
-	} else {
-		TCQ_PRINTK("ide_service: starting WRITE %x\n", stat);
-		ret = drive->channel->dmaproc(ide_dma_write_queued, drive);
-	}
-
-	/*
-	 * dmaproc set intr handler
-	 */
-	return !ret ? ide_started : ide_stopped;
-}
-
-ide_startstop_t ide_check_service(ide_drive_t *drive)
-{
-	byte stat;
-
-	TCQ_PRINTK("%s: ide_check_service\n", drive->name);
-
-	if (!ide_pending_commands(drive))
-		return ide_stopped;
-
-	if ((stat = GET_STAT()) & SERVICE_STAT)
-		return ide_service(drive);
-
-	/*
-	 * we have pending commands, wait for interrupt
-	 */
-	ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
-	return ide_started;
-}
-
-ide_startstop_t ide_dmaq_complete(ide_drive_t *drive, byte stat)
-{
-	struct ata_request *ar = IDE_CUR_TAG(drive);
-	byte dma_stat;
-
-	/*
-	 * transfer was in progress, stop DMA engine
-	 */
-	dma_stat = drive->channel->dmaproc(ide_dma_end, drive);
-
-	/*
-	 * must be end of I/O, check status and complete as necessary
-	 */
-	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
-		printk("ide_dmaq_intr: %s: error status %x\n", drive->name, stat);
-		ide_dump_status(drive, "ide_dmaq_intr", stat);
-		ide_tcq_invalidate_queue(drive);
-		return ide_stopped;
-	}
-
-	if (dma_stat)
-		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
-
-	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", ar, ar->ar_tag);
-	ide_end_queued_request(drive, !dma_stat, ar->ar_rq);
-
-	/*
-	 * we completed this command, set tcq inactive and check if we
-	 * can service a new command
-	 */
-	IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
-	return ide_check_service(drive);
-}
-
-/*
- * intr handler for queued dma operations. this can be entered for two
- * reasons:
- *
- * 1) device has completed dma transfer
- * 2) service request to start a command
- *
- * if the drive has an active tag, we first complete that request before
- * processing any pending SERVICE.
- */
-ide_startstop_t ide_dmaq_intr(ide_drive_t *drive)
-{
-	byte stat = GET_STAT();
-
-	TCQ_PRINTK("ide_dmaq_intr: stat=%x, tag %d\n", stat, drive->tcq->active_tag);
-
-	/*
-	 * if a command completion interrupt is pending, do that first and
-	 * check service afterwards
-	 */
-	if (drive->tcq->active_tag != IDE_INACTIVE_TAG)
-		return ide_dmaq_complete(drive, stat);
-
-	/*
-	 * service interrupt
-	 */
-	if (stat & SERVICE_STAT) {
-		TCQ_PRINTK("ide_dmaq_intr: SERV (stat=%x)\n", stat);
-		return ide_service(drive);
-	}
-
-	printk("ide_dmaq_intr: stat=%x, not expected\n", stat);
-	return ide_check_service(drive);
-}
-
-/*
- * check if the ata adapter this drive is attached to supports the
- * NOP auto-poll for multiple tcq enabled drives on one channel
- */
-static int ide_tcq_check_autopoll(ide_drive_t *drive)
-{
-	struct ata_channel *ch = HWIF(drive);
-	struct ata_taskfile args;
-	ide_drive_t *next;
-
-	/*
-	 * only need to probe if both drives on a channel support tcq
-	 */
-	next = drive->next;
-	if (next == drive || !next->using_tcq)
-		return 0;
-
-	memset(&args, 0, sizeof(args));
-
-	args.taskfile.feature = 0x01;
-	args.taskfile.command = WIN_NOP;
-	ide_cmd_type_parser(&args);
-
-	/*
-	 * do taskfile and check ABRT bit -- intelligent adapters will not
-	 * pass NOP with sub-code 0x01 to device, so the command will not
-	 * fail there
-	 */
-	ide_raw_taskfile(drive, &args, NULL);
-	if (args.taskfile.feature & ABRT_ERR)
-		return 1;
-
-	ch->auto_poll = 1;
-	printk("%s: NOP Auto-poll enabled\n", ch->name);
-	return 0;
-}
-
-/*
- * configure the drive for tcq
- */
-static int ide_tcq_configure(ide_drive_t *drive)
-{
-	int tcq_mask = 1 << 1 | 1 << 14;
-	int tcq_bits = tcq_mask | 1 << 15;
-	struct ata_taskfile args;
-
-	/*
-	 * bit 14 and 1 must be set in word 83 of the device id to indicate
-	 * support for dma queued protocol, and bit 15 must be cleared
-	 */
-	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
-		return -EIO;
-
-	memset(&args, 0, sizeof(args));
-	args.taskfile.feature = SETFEATURES_EN_WCACHE;
-	args.taskfile.command = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
-
-	if (ide_raw_taskfile(drive, &args, NULL)) {
-		printk("%s: failed to enable write cache\n", drive->name);
-		return 1;
-	}
-
-	/*
-	 * disable RELease interrupt, it's quicker to poll this after
-	 * having sent the command opcode
-	 */
-	memset(&args, 0, sizeof(args));
-	args.taskfile.feature = SETFEATURES_DIS_RI;
-	args.taskfile.command = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
-
-	if (ide_raw_taskfile(drive, &args, NULL)) {
-		printk("%s: disabling release interrupt fail\n", drive->name);
-		return 1;
-	}
-
-#ifdef IDE_TCQ_FIDDLE_SI
-	/*
-	 * enable SERVICE interrupt
-	 */
-	memset(&args, 0, sizeof(args));
-	args.taskfile.feature = SETFEATURES_EN_SI;
-	args.taskfile.command = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
-
-	if (ide_raw_taskfile(drive, &args, NULL)) {
-		printk("%s: enabling service interrupt fail\n", drive->name);
-		return 1;
-	}
-#endif
-
-	if (!drive->tcq) {
-		drive->tcq = kmalloc(sizeof(ide_tag_info_t), GFP_ATOMIC);
-		if (!drive->tcq)
-			return -ENOMEM;
-
-		memset(drive->tcq, 0, sizeof(ide_tag_info_t));
-		drive->tcq->active_tag = IDE_INACTIVE_TAG;
-	}
-
-	return 0;
-}
-
-/*
- * for now assume that command list is always as big as we need and don't
- * attempt to shrink it on tcq disable
- */
-static int ide_enable_queued(ide_drive_t *drive, int on)
-{
-	int depth = drive->using_tcq ? drive->queue_depth : 0;
-
-	/*
-	 * disable or adjust queue depth
-	 */
-	if (!on) {
-		if (drive->using_tcq)
-			printk("%s: TCQ disabled\n", drive->name);
-		drive->using_tcq = 0;
-		return 0;
-	}
-
-	if (ide_tcq_configure(drive)) {
-		drive->using_tcq = 0;
-		return 1;
-	}
-
-	/*
-	 * possibly expand command list
-	 */
-	if (ide_build_commandlist(drive))
-		return 1;
-
-	/*
-	 * check auto-poll support
-	 */
-	ide_tcq_check_autopoll(drive);
-
-	if (depth != drive->queue_depth)
-		printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
-
-	drive->using_tcq = 1;
-
-	/*
-	 * clear stats
-	 */
-	drive->tcq->max_depth = 0;
-	return 0;
-}
-
-int ide_tcq_wait_dataphase(ide_drive_t *drive)
-{
-	ide_startstop_t foo;
-
-	if (ide_wait_stat(&foo, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
-		printk("%s: timeout waiting for data phase\n", drive->name);
-		return 1;
-	}
-
-	return 0;
-}
-
-int ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
-{
-	struct ata_channel *hwif = drive->channel;
-	unsigned int reading = 0, enable_tcq = 1;
-	struct ata_request *ar;
-	byte stat, feat;
-
-	switch (func) {
-		/*
-		 * invoked from a SERVICE interrupt, command etc already known.
-		 * just need to start the dma engine for this tag
-		 */
-		case ide_dma_read_queued:
-			reading = 1 << 3;
-		case ide_dma_write_queued:
-			TCQ_PRINTK("ide_dma: setting up queued %d\n", drive->tcq->active_tag);
-			BUG_ON(drive->tcq->active_tag == IDE_INACTIVE_TAG);
-
-			if (!test_bit(IDE_BUSY, &HWGROUP(drive)->flags))
-				printk("queued_rw: IDE_BUSY not set\n");
-
-			if (ide_tcq_wait_dataphase(drive))
-				return ide_stopped;
-
-			if (ide_start_dma(hwif, drive, func))
-				return 1;
-
-			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
-			return hwif->dmaproc(ide_dma_begin, drive);
-
-			/*
-			 * start a queued command from scratch
-			 */
-		case ide_dma_queued_start:
-			BUG_ON(drive->tcq->active_tag == IDE_INACTIVE_TAG);
-			ar = IDE_CUR_TAG(drive);
-
-			/*
-			 * set nIEN, tag start operation will enable again when
-			 * it is safe
-			 */
-			drive_ctl_nien(drive, 1);
-
-			OUT_BYTE(AR_TASK_CMD(ar), IDE_COMMAND_REG);
-
-			if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
-				ide_dump_status(drive, "queued start", stat);
-				ide_tcq_invalidate_queue(drive);
-				return ide_stopped;
-			}
-
-			drive_ctl_nien(drive, 0);
-
-			if (stat & ERR_STAT) {
-				ide_dump_status(drive, "tcq_start", stat);
-				return ide_stopped;
-			}
-
-			/*
-			 * drive released the bus, clear active tag and
-			 * check for service
-			 */
-			if ((feat = GET_FEAT()) & NSEC_REL) {
-				IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
-				drive->tcq->immed_rel++;
-
-				ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
-
-				TCQ_PRINTK("REL in queued_start\n");
-
-				if ((stat = GET_STAT()) & SERVICE_STAT)
-					return ide_service(drive);
-
-				return ide_released;
-			}
-
-			drive->tcq->immed_comp++;
-
-			if (ide_tcq_wait_dataphase(drive))
-				return ide_stopped;
-
-			if (ide_start_dma(hwif, drive, func))
-				return ide_stopped;
-
-			TCQ_PRINTK("IMMED in queued_start\n");
-
-			/*
-			 * need to arm handler before starting dma engine,
-			 * transfer could complete right away
-			 */
-			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
-
-			if (hwif->dmaproc(ide_dma_begin, drive))
-				return ide_stopped;
-
-			/*
-			 * wait for SERVICE or completion interrupt
-			 */
-			return ide_started;
-
-		case ide_dma_queued_off:
-			enable_tcq = 0;
-		case ide_dma_queued_on:
-			if (enable_tcq && !drive->using_dma)
-				return 1;
-			return ide_enable_queued(drive, enable_tcq);
-		default:
-			break;
-	}
-
-	return 1;
-}
-
-int ide_build_sglist (struct ata_channel *hwif, struct request *rq);
-ide_startstop_t ide_start_tag(ide_dma_action_t func, ide_drive_t *drive,
-			      struct ata_request *ar)
-{
-	ide_startstop_t startstop;
-
-	TCQ_PRINTK("%s: ide_start_tag: begin tag %p/%d, rq %p\n", drive->name,ar,ar->ar_tag, ar->ar_rq);
-
-	/*
-	 * do this now, no need to run that with interrupts disabled
-	 */
-	if (!ide_build_sglist(drive->channel, ar->ar_rq))
-		return ide_stopped;
-
-	IDE_SET_CUR_TAG(drive, ar->ar_tag);
-	HWGROUP(drive)->rq = ar->ar_rq;
-
-	startstop = ide_tcq_dmaproc(func, drive);
-
-	if (unlikely(startstop == ide_stopped)) {
-		IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
-		HWGROUP(drive)->rq = NULL;
-	}
-
-	return startstop;
-}
diff -urN linux-2.5.10/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.10/drivers/ide/Makefile	2002-04-23 00:29:30.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-04-25 14:17:08.000000000 +0200
@@ -44,7 +44,6 @@
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
-ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ide-pmac.o
diff -urN linux-2.5.10/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.10/drivers/ide/pdc202xx.c	2002-04-23 00:29:48.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-04-25 15:39:33.000000000 +0200
@@ -1057,12 +1057,6 @@
 		case ide_dma_timeout:
 			if (drive->channel->resetproc != NULL)
 				drive->channel->resetproc(drive);
-		/*
-		 * we cannot support queued operations on promise, so fail to
-		 * to enable it...
-		 */
-		case ide_dma_queued_on:
-			return 1;
 		default:
 			break;
 	}
diff -urN linux-2.5.10/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.10/include/linux/hdreg.h	2002-04-23 00:29:02.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-04-25 15:39:33.000000000 +0200
@@ -34,7 +34,6 @@
 #define ECC_STAT		0x04	/* Corrected error */
 #define DRQ_STAT		0x08
 #define SEEK_STAT		0x10
-#define SERVICE_STAT		SEEK_STAT
 #define WRERR_STAT		0x20
 #define READY_STAT		0x40
 #define BUSY_STAT		0x80
@@ -51,13 +50,6 @@
 #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
 
 /*
- * bits of NSECTOR reg
- */
-#define NSEC_CD			0x1
-#define NSEC_IO			0x2
-#define NSEC_REL		0x4
-
-/*
  * Command Header sizes for IOCTL commands
  *	HDIO_DRIVE_CMD and HDIO_DRIVE_TASK
  */
diff -urN linux-2.5.10/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.10/include/linux/ide.h	2002-04-23 00:28:11.000000000 +0200
+++ linux/include/linux/ide.h	2002-04-25 16:28:19.000000000 +0200
@@ -273,45 +273,6 @@
 	} b;
 } special_t;
 
-#define IDE_MAX_TAG		(32)		/* spec says 32 max */
-#define IDE_INACTIVE_TAG	(-1)
-
-struct ata_request;
-typedef struct ide_tag_info_s {
-	unsigned long tag_mask;			/* next tag bit mask */
-	struct ata_request *ar[IDE_MAX_TAG];	/* in-progress requests */
-	int active_tag;				/* current active tag */
-
-	int queued;				/* current depth */
-
-	/*
-	 * stats ->
-	 */
-	int max_depth;				/* max depth ever */
-
-	int max_last_depth;			/* max since last check */
-
-	/*
-	 * Either the command completed immediately after being started
-	 * (immed_comp), or the device did a bus release before dma was
-	 * started (immed_rel).
-	 */
-	int immed_rel;
-	int immed_comp;
-	unsigned long oldest_command;
-} ide_tag_info_t;
-
-#define IDE_GET_AR(drive, tag)	((drive)->tcq->ar[(tag)])
-#define IDE_CUR_TAG(drive)	(IDE_GET_AR((drive), (drive)->tcq->active_tag))
-#define IDE_SET_CUR_TAG(drive, tag)	\
-	do {						\
-		((drive)->tcq->active_tag = (tag));	\
-		if ((tag) == IDE_INACTIVE_TAG)		\
-			HWGROUP((drive))->rq = NULL;	\
-	} while (0);
-
-#define IDE_CUR_AR(drive)	(HWGROUP((drive))->rq->special)
-
 struct ide_settings_s;
 /* structure describing an ATA/ATAPI device */
 typedef
@@ -326,11 +287,9 @@
 	 * could move this to the channel and many sync problems would
 	 * magically just go away.
 	 */
-	request_queue_t	queue;		/* per device request queue */
-
-	struct list_head free_req;	/* free ata requests */
+	request_queue_t	queue;	/* per device request queue */
 
-	struct ata_device *next;	/* circular list of hwgroup drives */
+	struct ata_device	*next;	/* circular list of hwgroup drives */
 
 	/* Those are directly injected jiffie values. They should go away and
 	 * we should use generic timers instead!!!
@@ -343,7 +302,6 @@
 
 	special_t	special;	/* special action flags */
 	byte     using_dma;		/* disk is using dma for read/write */
-	byte	 using_tcq;		/* disk is using queued dma operations*/
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     dsc_overlap;		/* flag: DSC overlap */
@@ -412,8 +370,6 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct device	device;		/* global device tree handle */
-	unsigned int	queue_depth;
-	ide_tag_info_t	*tcq;
 } ide_drive_t;
 
 /*
@@ -432,10 +388,7 @@
 		ide_dma_off,	ide_dma_off_quietly,	ide_dma_test_irq,
 		ide_dma_bad_drive,			ide_dma_good_drive,
 		ide_dma_verbose,			ide_dma_retune,
-		ide_dma_lostirq,			ide_dma_timeout,
-		ide_dma_read_queued,			ide_dma_write_queued,
-		ide_dma_queued_start,			ide_dma_queued_on,
-		ide_dma_queued_off,
+		ide_dma_lostirq,			ide_dma_timeout
 } ide_dma_action_t;
 
 typedef int (ide_dmaproc_t)(ide_dma_action_t, ide_drive_t *);
@@ -494,6 +447,11 @@
 	void (*atapi_write)(ide_drive_t *, void *, unsigned int);
 
 	ide_dmaproc_t	*dmaproc;	/* dma read/write/abort routine */
+	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
+	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
+	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
+	int sg_nents;			/* Current number of entries in it */
+	int sg_dma_direction;		/* dma transfer direction */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned	dma_extra;	/* extra addr for dma ports */
 	unsigned long	config_data;	/* for use by chipset-specific code */
@@ -517,7 +475,7 @@
 	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	unsigned no_unmask	   : 1;	/* disallow setting unmask bit */
 	byte		unmask;		/* flag: okay to unmask other irqs */
-	unsigned	auto_poll  : 1; /* supports nop auto-poll */
+
 #if (DISK_RECOVERY_TIME > 0)
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif
@@ -538,7 +496,7 @@
 typedef enum {
 	ide_stopped,	/* no drive operation was started */
 	ide_started,	/* a drive operation was started, and a handler was set */
-	ide_released,	/* started, handler set, bus released */
+	ide_released	/* started and released bus */
 } ide_startstop_t;
 
 /*
@@ -559,19 +517,21 @@
 #define IDE_DMA		2	/* DMA in progress */
 
 typedef struct hwgroup_s {
-	ide_handler_t		*handler;	/* irq handler, if active */
-	unsigned long		flags;		/* BUSY, SLEEPING */
-	ide_drive_t		*drive;		/* current drive */
-	struct ata_channel	*hwif;		/* ptr to current hwif in linked-list */
+	ide_handler_t		*handler;/* irq handler, if active */
+	unsigned long		flags;	/* BUSY, SLEEPING */
+	ide_drive_t		*drive;	/* current drive */
+	struct ata_channel	*hwif;	/* ptr to current hwif in linked-list */
 
-	struct request		*rq;		/* current request */
+	struct request		*rq;	/* current request */
 
-	struct timer_list	timer;		/* failsafe timer */
-	struct request		wrq;		/* local copy of current write rq */
+	struct timer_list	timer;	/* failsafe timer */
+	struct request		wrq;	/* local copy of current write rq */
 	unsigned long		poll_timeout;	/* timeout value during long polls */
 	ide_expiry_t		*expiry;	/* queried upon timeouts */
 } ide_hwgroup_t;
 
+/* structure attached to the request for IDE_TASK_CMDS */
+
 /*
  * configurable drive settings
  */
@@ -708,7 +668,6 @@
 
 extern int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs);
 extern int ide_end_request(ide_drive_t *drive, int uptodate);
-extern void ide_end_queued_request(ide_drive_t *drive, int, struct request *);
 
 /*
  * This is used on exit from the driver, to designate the next irq handler
@@ -804,33 +763,8 @@
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
-	struct ata_request	*ar;
-};
-
-/*
- * Merge this with the above struct soon.
- */
-struct ata_request {
-	struct request		*ar_rq;		/* real request */
-	struct ata_device	*ar_drive;	/* associated drive */
-	unsigned long		ar_flags;	/* ATA_AR_* flags */
-	int			ar_tag;		/* tag number, if any */
-	struct list_head	ar_queue;	/* pending list */
-	struct ata_taskfile	ar_task;	/* associated taskfile */
-	unsigned long		ar_time;
-
-	/* DMA stuff, PCI layer */
-	struct scatterlist	*ar_sg_table;
-	int			ar_sg_nents;
-	int			ar_sg_ddir;
-
-	/* CPU related DMA stuff  */
-	unsigned int		*ar_dmatable_cpu;
-	dma_addr_t		ar_dmatable;
 };
 
-#define AR_TASK_CMD(ar)	((ar)->ar_task.taskfile.command)
-
 extern void ata_read(ide_drive_t *drive, void *buffer, unsigned int wcount);
 extern void ata_write(ide_drive_t *drive, void *buffer, unsigned int wcount);
 
@@ -930,24 +864,22 @@
 extern int ide_unregister_subdriver(ide_drive_t *drive);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-# define ON_BOARD		1
-# define NEVER_BOARD		0
-# ifdef CONFIG_BLK_DEV_OFFBOARD
-#  define OFF_BOARD		ON_BOARD
-# else
-#  define OFF_BOARD		NEVER_BOARD
-# endif
+#define ON_BOARD		1
+#define NEVER_BOARD		0
+#ifdef CONFIG_BLK_DEV_OFFBOARD
+# define OFF_BOARD		ON_BOARD
+#else
+# define OFF_BOARD		NEVER_BOARD
+#endif
 
-/* FIXME: This should go away possible. */
-extern void __init ide_scan_pcibus(int scan_direction);
+void __init ide_scan_pcibus(int scan_direction);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDMA
-extern int ide_build_dmatable(ide_drive_t *drive, struct request *rq, ide_dma_action_t func);
-extern void ide_destroy_dmatable(ide_drive_t *drive);
-extern int ide_start_dma(struct ata_channel *, ide_drive_t *, ide_dma_action_t);
-extern ide_startstop_t ide_dma_intr(ide_drive_t *drive);
-extern int check_drive_lists(ide_drive_t *drive, int good_bad);
-extern int ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive);
+int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func);
+void ide_destroy_dmatable (ide_drive_t *drive);
+ide_startstop_t ide_dma_intr (ide_drive_t *drive);
+int check_drive_lists (ide_drive_t *drive, int good_bad);
+int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
 extern void ide_release_dma(struct ata_channel *hwif);
 extern void ide_setup_dma(struct ata_channel *hwif,
 		unsigned long dmabase, unsigned int num_ports) __init;
@@ -960,112 +892,4 @@
 extern int drive_is_ready(ide_drive_t *drive);
 extern void revalidate_drives(void);
 
-/*
- * Tagged Command Queueing:
- */
-
-/*
- * ata_request flag bits
- */
-#define ATA_AR_QUEUED	1	/* was queued */
-#define ATA_AR_SETUP	2	/* dma table mapped */
-#define ATA_AR_POOL	4	/* originated from drive pool */
-
-/*
- * if turn-around time is longer than this, halve queue depth
- */
-#define ATA_AR_MAX_TURNAROUND	(3 * HZ)
-
-#define list_ata_entry(entry) list_entry((entry), struct ata_request, ar_queue)
-
-static inline void ata_ar_init(ide_drive_t *drive, struct ata_request *ar)
-{
-	ar->ar_rq = NULL;
-	ar->ar_drive = drive;
-	ar->ar_flags = 0;
-	ar->ar_tag = 0;
-	memset(&ar->ar_task, 0, sizeof(ar->ar_task));
-	ar->ar_sg_nents = 0;
-	ar->ar_sg_ddir = 0;
-}
-
-/*
- * Return a free command, automatically add it to busy list.
- */
-static inline struct ata_request *ata_ar_get(ide_drive_t *drive)
-{
-	struct ata_request *ar = NULL;
-
-	if (drive->tcq && drive->tcq->queued >= drive->queue_depth)
-		return NULL;
-
-	if (!list_empty(&drive->free_req)) {
-		ar = list_ata_entry(drive->free_req.next);
-
-		list_del(&ar->ar_queue);
-		ata_ar_init(drive, ar);
-		ar->ar_flags |= ATA_AR_POOL;
-	}
-
-	return ar;
-}
-
-static inline void ata_ar_put(ide_drive_t *drive, struct ata_request *ar)
-{
-	if (ar->ar_flags & ATA_AR_POOL)
-		list_add(&ar->ar_queue, &drive->free_req);
-
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-		/* clear the tag */
-		drive->tcq->ar[ar->ar_tag] = NULL;
-		__clear_bit(ar->ar_tag, &drive->tcq->tag_mask);
-		drive->tcq->queued--;
-	}
-
-	ar->ar_rq = NULL;
-}
-
-static inline int ide_get_tag(ide_drive_t *drive)
-{
-	int tag = ffz(drive->tcq->tag_mask);
-
-	BUG_ON(drive->tcq->tag_mask == 0xffffffff);
-
-	__set_bit(tag, &drive->tcq->tag_mask);
-
-	if (tag + 1 > drive->tcq->max_depth)
-		drive->tcq->max_depth = tag + 1;
-	if (tag + 1 > drive->tcq->max_last_depth)
-		drive->tcq->max_last_depth = tag + 1;
-
-	return tag;
-}
-
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-static inline int ide_pending_commands(ide_drive_t *drive)
-{
-	if (!drive->tcq)
-		return 0;
-
-	return drive->tcq->queued;
-}
-
-static inline int ide_can_queue(ide_drive_t *drive)
-{
-	if (!drive->tcq)
-		return 1;
-
-	return drive->tcq->queued < drive->queue_depth;
-}
-#else
-#define ide_pending_commands(drive)	(0)
-#define ide_can_queue(drive)		(1)
-#endif
-
-int ide_build_commandlist(ide_drive_t *);
-int ide_init_commandlist(ide_drive_t *);
-void ide_teardown_commandlist(ide_drive_t *);
-int ide_tcq_dmaproc(ide_dma_action_t, ide_drive_t *);
-ide_startstop_t ide_start_tag(ide_dma_action_t, ide_drive_t *, struct ata_request *);
-
-#endif
+#endif /* _IDE_H */

--------------070604030102050904030708--

