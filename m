Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317730AbSGZNgf>; Fri, 26 Jul 2002 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317731AbSGZNgf>; Fri, 26 Jul 2002 09:36:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20234 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317730AbSGZNgS>; Fri, 26 Jul 2002 09:36:18 -0400
Message-ID: <3D414FE7.2070807@evision.ag>
Date: Fri, 26 Jul 2002 15:34:31 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE 107
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020604080700070101000503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604080700070101000503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix "temporal anomaly" in do_ide_request pointed out by Petr
   Vandrovec. Thanks Petr!


--------------020604080700070101000503
Content-Type: text/plain;
 name="ide-107.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-107.diff"

diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.28/drivers/ide/ide.c	2002-07-26 09:50:43.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-07-26 14:30:05.000000000 +0200
@@ -517,258 +517,251 @@ void ide_stall_queue(struct ata_device *
  * Issue a new request.
  * Caller must have already done spin_lock_irqsave(channel->lock, ...)
  */
-static void do_request(struct ata_channel *channel)
+void do_ide_request(request_queue_t *q)
 {
-	struct ata_channel *ch;
-	struct ata_device *drive = NULL;
-	unsigned int unit;
-	ide_startstop_t ret;
+	struct ata_channel *channel = q->queuedata;
 
-	local_irq_disable();	/* necessary paranoia */
+	while (!test_and_set_bit(IDE_BUSY, channel->active)) {
+		struct ata_channel *ch;
+		struct ata_device *drive = NULL;
+		unsigned int unit;
+		ide_startstop_t ret;
 
-	/*
-	 * Select the next device which will be serviced.  This selects
-	 * only between devices on the same channel, since everything
-	 * else will be scheduled on the queue level.
-	 */
+		/*
+		 * Select the next device which will be serviced.  This selects
+		 * only between devices on the same channel, since everything
+		 * else will be scheduled on the queue level.
+		 */
 
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		struct ata_device *tmp = &channel->drives[unit];
+		for (unit = 0; unit < MAX_DRIVES; ++unit) {
+			struct ata_device *tmp = &channel->drives[unit];
 
-		if (!tmp->present)
-			continue;
+			if (!tmp->present)
+				continue;
 
-		/* There are no requests pending for this device.
-		 */
-		if (blk_queue_empty(&tmp->queue))
-			continue;
+			/* There are no requests pending for this device.
+			 */
+			if (blk_queue_empty(&tmp->queue))
+				continue;
 
 
-		/* This device still wants to remain idle.
-		 */
-		if (tmp->sleep && time_after(tmp->sleep, jiffies))
-			continue;
+			/* This device still wants to remain idle.
+			 */
+			if (tmp->sleep && time_after(tmp->sleep, jiffies))
+				continue;
 
-		/* Take this device, if there is no device choosen thus
-		 * far or which is more urgent.
-		 */
-		if (!drive || (tmp->sleep && (!drive->sleep || time_after(drive->sleep, tmp->sleep)))) {
-			if (!blk_queue_plugged(&tmp->queue))
-				drive = tmp;
+			/* Take this device, if there is no device choosen thus
+			 * far or which is more urgent.
+			 */
+			if (!drive || (tmp->sleep && (!drive->sleep || time_after(drive->sleep, tmp->sleep)))) {
+				if (!blk_queue_plugged(&tmp->queue))
+					drive = tmp;
+			}
 		}
-	}
 
-	if (!drive) {
-		unsigned long sleep = 0;
+		if (!drive) {
+			unsigned long sleep = 0;
 
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			struct ata_device *tmp = &channel->drives[unit];
+			for (unit = 0; unit < MAX_DRIVES; ++unit) {
+				struct ata_device *tmp = &channel->drives[unit];
 
-			if (!tmp->present)
-				continue;
+				if (!tmp->present)
+					continue;
 
-			/* This device is sleeping and waiting to be serviced
-			 * earlier than any other device we checked thus far.
-			 */
-			if (tmp->sleep && (!sleep || time_after(sleep, tmp->sleep)))
-				sleep = tmp->sleep;
-		}
+				/* This device is sleeping and waiting to be serviced
+				 * earlier than any other device we checked thus far.
+				 */
+				if (tmp->sleep && (!sleep || time_after(sleep, tmp->sleep)))
+					sleep = tmp->sleep;
+			}
 
-		if (sleep) {
-			/*
-			 * Take a short snooze, and then wake up again.  Just
-			 * in case there are big differences in relative
-			 * throughputs.. don't want to hog the cpu too much.
-			 */
+			if (sleep) {
+				/*
+				 * Take a short snooze, and then wake up again.  Just
+				 * in case there are big differences in relative
+				 * throughputs.. don't want to hog the cpu too much.
+				 */
 
-			if (time_after(jiffies, sleep - WAIT_MIN_SLEEP))
-				sleep = jiffies + WAIT_MIN_SLEEP;
+				if (time_after(jiffies, sleep - WAIT_MIN_SLEEP))
+					sleep = jiffies + WAIT_MIN_SLEEP;
 #if 1
-			if (timer_pending(&channel->timer))
-				printk(KERN_ERR "%s: timer already active\n", __FUNCTION__);
+				if (timer_pending(&channel->timer))
+					printk(KERN_ERR "%s: timer already active\n", __FUNCTION__);
 #endif
-			set_bit(IDE_SLEEP, channel->active);
-			mod_timer(&channel->timer, sleep);
-
-			/*
-			 * We purposely leave us busy while sleeping becouse we
-			 * are prepared to handle the IRQ from it.
-			 *
-			 * FIXME: Make sure sleeping can't interferre with
-			 * operations of other devices on the same channel.
-			 */
-		} else {
-			/* FIXME: use queue plugging instead of active to block
-			 * upper layers from stomping on us */
-			/* Ugly, but how can we sleep for the lock otherwise?
-			 * */
+				set_bit(IDE_SLEEP, channel->active);
+				mod_timer(&channel->timer, sleep);
 
-			ide_release_lock(&ide_irq_lock);/* for atari only */
-			clear_bit(IDE_BUSY, channel->active);
+				/*
+				 * We purposely leave us busy while sleeping becouse we
+				 * are prepared to handle the IRQ from it.
+				 *
+				 * FIXME: Make sure sleeping can't interferre with
+				 * operations of other devices on the same channel.
+				 */
+			} else {
+				/* FIXME: use queue plugging instead of active to block
+				 * upper layers from stomping on us */
+				/* Ugly, but how can we sleep for the lock otherwise?
+				 * */
 
-			/* All requests are done.
-			 *
-			 * Disable IRQs from the last drive on this channel, to
-			 * make sure that it wan't throw stones at us when we
-			 * are not prepared to take them.
-			 */
+				ide_release_lock(&ide_irq_lock);/* for atari only */
+				clear_bit(IDE_BUSY, channel->active);
 
-			if (channel->drive && !channel->drive->using_tcq)
-				ata_irq_enable(channel->drive, 0);
-		}
+				/* All requests are done.
+				 *
+				 * Disable IRQs from the last drive on this channel, to
+				 * make sure that it wan't throw stones at us when we
+				 * are not prepared to take them.
+				 */
 
-		return;
-	}
+				if (channel->drive && !channel->drive->using_tcq)
+					ata_irq_enable(channel->drive, 0);
+			}
 
-	/* Remember the last drive we where acting on.
-	 */
-	ch = drive->channel;
-	ch->drive = drive;
+			return;
+		}
 
-	/* Feed commands to a drive until it barfs.
-	 */
-	do {
-		struct request *rq = NULL;
-		sector_t block;
+		/* Remember the last drive we where acting on.
+		 */
+		ch = drive->channel;
+		ch->drive = drive;
 
-		/* Abort early if we can't queue another command. for non tcq,
-		 * ata_can_queue is always 1 since we never get here unless the
-		 * drive is idle.
+		/* Feed commands to a drive until it barfs.
 		 */
+		do {
+			struct request *rq = NULL;
+			sector_t block;
 
-		if (!ata_can_queue(drive)) {
-			if (!ata_pending_commands(drive)) {
-				clear_bit(IDE_BUSY, ch->active);
-				if (drive->using_tcq)
-					ata_irq_enable(drive, 0);
-			}
-			break;
-		}
+			/* Abort early if we can't queue another command. for non tcq,
+			 * ata_can_queue is always 1 since we never get here unless the
+			 * drive is idle.
+			 */
 
-		drive->sleep = 0;
+			if (!ata_can_queue(drive)) {
+				if (!ata_pending_commands(drive)) {
+					clear_bit(IDE_BUSY, ch->active);
+					if (drive->using_tcq)
+						ata_irq_enable(drive, 0);
+				}
+				break;
+			}
 
-		if (test_bit(IDE_DMA, ch->active)) {
-			printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
-			break;
-		}
+			drive->sleep = 0;
 
-		/* There's a small window between where the queue could be
-		 * replugged while we are in here when using tcq (in which case
-		 * the queue is probably empty anyways...), so check and leave
-		 * if appropriate. When not using tcq, this is still a severe
-		 * BUG!
-		 */
+			if (test_bit(IDE_DMA, ch->active)) {
+				printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
+				break;
+			}
 
-		if (blk_queue_plugged(&drive->queue)) {
-			BUG_ON(!drive->using_tcq);
-			break;
-		}
+			/* There's a small window between where the queue could be
+			 * replugged while we are in here when using tcq (in which case
+			 * the queue is probably empty anyways...), so check and leave
+			 * if appropriate. When not using tcq, this is still a severe
+			 * BUG!
+			 */
 
-		if (!(rq = elv_next_request(&drive->queue))) {
-			if (!ata_pending_commands(drive)) {
-				clear_bit(IDE_BUSY, ch->active);
-				if (drive->using_tcq)
-					ata_irq_enable(drive, 0);
+			if (blk_queue_plugged(&drive->queue)) {
+				BUG_ON(!drive->using_tcq);
+				break;
 			}
-			drive->rq = NULL;
 
-			break;
-		}
+			if (!(rq = elv_next_request(&drive->queue))) {
+				if (!ata_pending_commands(drive)) {
+					clear_bit(IDE_BUSY, ch->active);
+					if (drive->using_tcq)
+						ata_irq_enable(drive, 0);
+				}
+				drive->rq = NULL;
 
-		/* If there are queued commands, we can't start a
-		 * non-fs request (really, a non-queuable command)
-		 * until the queue is empty.
-		 */
-		if (!(rq->flags & REQ_CMD) && ata_pending_commands(drive))
-			break;
+				break;
+			}
 
-		drive->rq = rq;
+			/* If there are queued commands, we can't start a
+			 * non-fs request (really, a non-queuable command)
+			 * until the queue is empty.
+			 */
+			if (!(rq->flags & REQ_CMD) && ata_pending_commands(drive))
+				break;
 
-		spin_unlock(ch->lock);
-		/* allow other IRQs while we start this request */
-		local_irq_enable();
+			drive->rq = rq;
 
-		/*
-		 * This initiates handling of a new I/O request.
-		 */
+			spin_unlock(ch->lock);
+			/* allow other IRQs while we start this request */
+			local_irq_enable();
 
-		BUG_ON(!(rq->flags & REQ_STARTED));
+			/*
+			 * This initiates handling of a new I/O request.
+			 */
+
+			BUG_ON(!(rq->flags & REQ_STARTED));
 
 #ifdef DEBUG
-		printk("%s: %s: current=0x%08lx\n", ch->name, __FUNCTION__, (unsigned long) rq);
+			printk("%s: %s: current=0x%08lx\n", ch->name, __FUNCTION__, (unsigned long) rq);
 #endif
 
-		/* bail early if we've exceeded max_failures */
-		if (drive->max_failures && (drive->failures > drive->max_failures))
-			goto kill_rq;
+			/* bail early if we've exceeded max_failures */
+			if (drive->max_failures && (drive->failures > drive->max_failures))
+				goto kill_rq;
 
-		block = rq->sector;
+			block = rq->sector;
 
-		/* Strange disk manager remap.
-		 */
-		if (rq->flags & REQ_CMD)
-			if (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)
-				block += drive->sect0;
+			/* Strange disk manager remap.
+			 */
+			if (rq->flags & REQ_CMD)
+				if (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)
+					block += drive->sect0;
 
-		/* Yecch - this will shift the entire interval, possibly killing some
-		 * innocent following sector.
-		 */
-		if (block == 0 && drive->remap_0_to_1 == 1)
-			block = 1;  /* redirect MBR access to EZ-Drive partn table */
+			/* Yecch - this will shift the entire interval, possibly killing some
+			 * innocent following sector.
+			 */
+			if (block == 0 && drive->remap_0_to_1 == 1)
+				block = 1;  /* redirect MBR access to EZ-Drive partn table */
 
-		ata_select(drive, 0);
-		ret = ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
-				WAIT_READY, rq);
+			ata_select(drive, 0);
+			ret = ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
+					WAIT_READY, rq);
 
-		if (ret != ATA_OP_READY) {
-			printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
+			if (ret != ATA_OP_READY) {
+				printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
 
-			goto kill_rq;
-		}
+				goto kill_rq;
+			}
 
-		if (!ata_ops(drive)) {
-			printk(KERN_WARNING "%s: device type %d not supported\n",
-					drive->name, drive->type);
-			goto kill_rq;
-		}
+			if (!ata_ops(drive)) {
+				printk(KERN_WARNING "%s: device type %d not supported\n",
+						drive->name, drive->type);
+				goto kill_rq;
+			}
 
-		/* The normal way of execution is to pass and execute the request
-		 * handler down to the device type driver.
-		 */
+			/* The normal way of execution is to pass and execute the request
+			 * handler down to the device type driver.
+			 */
 
-		if (ata_ops(drive)->do_request) {
-			ret = ata_ops(drive)->do_request(drive, rq, block);
-		} else {
+			if (ata_ops(drive)->do_request) {
+				ret = ata_ops(drive)->do_request(drive, rq, block);
+			} else {
 kill_rq:
-			if (ata_ops(drive) && ata_ops(drive)->end_request)
-				ata_ops(drive)->end_request(drive, rq, 0);
-			else
-				ata_end_request(drive, rq, 0, 0);
-			ret = ATA_OP_FINISHED;
-
-		}
-		spin_lock_irq(ch->lock);
-
-		/* continue if command started, so we are busy */
-	} while (ret != ATA_OP_CONTINUES);
-	/* make sure the BUSY bit is set */
-	/* FIXME: perhaps there is some place where we miss to set it? */
-//		set_bit(IDE_BUSY, ch->active);
-}
+				if (ata_ops(drive) && ata_ops(drive)->end_request)
+					ata_ops(drive)->end_request(drive, rq, 0);
+				else
+					ata_end_request(drive, rq, 0, 0);
+				ret = ATA_OP_FINISHED;
 
-void do_ide_request(request_queue_t *q)
-{
-	struct ata_channel *ch = q->queuedata;
+			}
+			spin_lock_irq(ch->lock);
 
-	while (!test_and_set_bit(IDE_BUSY, ch->active)) {
-		do_request(ch);
+			/* continue if command started, so we are busy */
+		} while (ret != ATA_OP_CONTINUES);
+		/* make sure the BUSY bit is set */
+		/* FIXME: perhaps there is some place where we miss to set it? */
+		//		set_bit(IDE_BUSY, ch->active);
 	}
 }
 
 /*
  * This is our timeout function for all drive operations.  But note that it can
  * also be invoked as a result of a "sleep" operation triggered by the
- * mod_timer() call in do_request.
+ * mod_timer() call in do_ide_request.
  *
  * FIXME: This should take a drive context instead of a channel.
  * FIXME: This should not explicitly reenter the request handling engine.
@@ -893,7 +886,8 @@ void ide_timer_expiry(unsigned long data
 
 		if (ret == ATA_OP_FINISHED) {
 			/* Reenter the request handling engine. */
-			do_request(ch);
+			clear_bit(IDE_BUSY, ch->active);
+			do_ide_request(&drive->queue);
 		}
 	}
 	spin_unlock_irqrestore(ch->lock, flags);
@@ -1050,9 +1044,10 @@ void ata_irq_request(int irq, void *data
 		 * another interrupt.
 		 */
 
-		if (!ch->handler)
-			do_request(ch);
-		else
+		if (!ch->handler) {
+			clear_bit(IDE_BUSY, ch->active);
+			do_ide_request(&drive->queue);
+		} else
 			printk("%s: %s: huh? expected NULL handler on exit\n",
 					drive->name, __FUNCTION__);
 	}

--------------020604080700070101000503--

