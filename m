Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSFKHrT>; Tue, 11 Jun 2002 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSFKHrS>; Tue, 11 Jun 2002 03:47:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9999 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316891AbSFKHqY>;
	Tue, 11 Jun 2002 03:46:24 -0400
Message-ID: <3D05AACD.2080504@evision-ventures.com>
Date: Tue, 11 Jun 2002 09:46:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 IDE 87
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080500030802030501000007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500030802030501000007
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Sun Jun  9 15:31:56 CEST 2002 ide-clean-87

- Sync with 2.5.21

- Don't call put_device inside idedisk_cleanup(). This is apparently triggering
   some bug inside the handling of device trees. Or we don't register the device
   properly within the tree. Check this later.

- Further work on the channel register file access locking.  Push the locking
   out from __ide_end_request to ide_end_request.  Rename those functions to
   respective __ata_end_request() and ata_end_request().

- Move ide_wait_status to device.c rename it to ata_status_poll().

- Further work on locking scope issues.

- devfs showed us once again that it changed the policy from agnostic numbers
   to unpleasant string names. What a piece of crap!

--------------080500030802030501000007
Content-Type: text/plain;
 name="ide-clean-87.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-87.diff"

diff -urN linux-2.5.21/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.21/drivers/ide/device.c	2002-06-09 07:28:51.000000000 +0200
+++ linux/drivers/ide/device.c	2002-06-11 00:17:34.000000000 +0200
@@ -80,7 +80,29 @@
 }
 
 /*
+ * Spin until the drive is no longer busy.
+ *
+ * Not exported, since it's not used within any modules.
+ */
+int ata_busy_poll(struct ata_device *drive, unsigned long timeout)
+{
+	/* spec allows drive 400ns to assert "BUSY" */
+	udelay(1);
+	if (!ata_status(drive, 0, BUSY_STAT)) {
+		timeout += jiffies;
+		while (!ata_status(drive, 0, BUSY_STAT)) {
+			if (time_after(jiffies, timeout))
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
  * Check the state of the status register.
+ *
+ * FIXME: Channel lock should be held.
  */
 int ata_status(struct ata_device *drive, u8 good, u8 bad)
 {
@@ -94,6 +116,57 @@
 EXPORT_SYMBOL(ata_status);
 
 /*
+ * Busy-wait for the drive status to be not "busy".  Check then the status for
+ * all of the "good" bits and none of the "bad" bits, and if all is okay it
+ * returns 0.  All other cases return 1 after invoking error handler -- caller
+ * should just return.
+ *
+ * This routine should get fixed to not hog the cpu during extra long waits..
+ * That could be done by busy-waiting for the first jiffy or two, and then
+ * setting a timer to wake up at half second intervals thereafter, until
+ * timeout is achieved, before timing out.
+ *
+ * FIXME: Channel lock should be held.
+ */
+
+int ata_status_poll(struct ata_device *drive, u8 good, u8 bad,
+		unsigned long timeout,
+		struct request *rq, ide_startstop_t *startstop)
+{
+	int i;
+
+	/* bail early if we've exceeded max_failures */
+	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		*startstop = ide_stopped;
+
+		return 1;
+	}
+
+	if (ata_busy_poll(drive, timeout)) {
+		*startstop = ata_error(drive, rq, "status timeout");
+
+		return 1;
+	}
+
+	/*
+	 * Allow status to settle, then read it again.  A few rare drives
+	 * vastly violate the 400ns spec here, so we'll wait up to 10usec for a
+	 * "good" status rather than expensively fail things immediately.  This
+	 * fix courtesy of Matthew Faupel & Niccolo Rigacci.
+	 */
+	for (i = 0; i < 10; i++) {
+		udelay(1);
+		if (ata_status(drive, good, bad))
+			return 0;
+	}
+	*startstop = ata_error(drive, rq, "status error");
+
+	return 1;
+}
+
+EXPORT_SYMBOL(ata_status_poll);
+
+/*
  * Handle the nIEN - negated Interrupt ENable of the drive.
  * This is controlling whatever the drive will acnowlenge commands
  * with interrupts or not.
@@ -160,7 +233,7 @@
 }
 
 /*
- * Output a complete register file.
+ * Input a complete register file.
  */
 void ata_in_regfile(struct ata_device *drive, struct hd_drive_task_hdr *rf)
 {
diff -urN linux-2.5.21/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.21/drivers/ide/ide.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-11 01:02:30.000000000 +0200
@@ -106,18 +106,19 @@
 	return 0;
 }
 
-int __ide_end_request(struct ata_device *drive, struct request *rq, int uptodate, unsigned int nr_secs)
+/*
+ * Not locking variabt of the end_request method.
+ *
+ * Channel lock should be held.
+ */
+int __ata_end_request(struct ata_device *drive, struct request *rq, int uptodate, unsigned int nr_secs)
 {
-	unsigned long flags;
 	int ret = 1;
 
-	spin_lock_irqsave(drive->channel->lock, flags);
-
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
-	/*
-	 * small hack to eliminate locking from ide_end_request to grab
-	 * the first segment number of sectors
+	/* FIXME: Make this "small" hack to eliminate locking from
+	 * ata_end_request to grab the first segment number of sectors go away.
 	 */
 	if (!nr_secs)
 		nr_secs = rq->hard_cur_sectors;
@@ -126,7 +127,6 @@
 	 * Decide whether to reenable DMA -- 3 is a random magic for now,
 	 * if we DMA timeout more than 3 times, just stay in PIO.
 	 */
-
 	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
 		drive->state = 0;
 		udma_enable(drive, 1, 1);
@@ -143,15 +143,24 @@
 		ret = 0;
 	}
 
-	spin_unlock_irqrestore(drive->channel->lock, flags);
 
 	return ret;
 }
 
-/* This is the default end request function as well */
-int ide_end_request(struct ata_device *drive, struct request *rq, int uptodate)
+/*
+ * This is the default end request function as well
+ */
+int ata_end_request(struct ata_device *drive, struct request *rq, int uptodate)
 {
-	return __ide_end_request(drive, rq, uptodate, 0);
+	unsigned long flags;
+	struct ata_channel *ch = drive->channel;
+	int ret;
+
+	spin_lock_irqsave(ch->lock, flags);
+	ret = __ata_end_request(drive, rq, uptodate, 0);
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+
+	return ret;
 }
 
 /*
@@ -260,24 +269,25 @@
 	struct ata_channel *ch = drive->channel;
 	int ret = ide_stopped;
 
+	spin_lock_irqsave(ch->lock, flags);
 	ata_select(drive, 10);
-
 	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
-			spin_lock_irqsave(ch->lock, flags);
 			ata_set_handler(drive, atapi_reset_pollfunc, HZ/20, NULL);
-			spin_unlock_irqrestore(ch->lock, flags);
 			ret = ide_started;	/* continue polling */
 		} else {
 			ch->poll_timeout = 0;	/* end of polling */
 			printk("%s: ATAPI reset timed out, status=0x%02x\n", drive->name, drive->status);
 
-			ret = do_reset1(drive, 1);	/* do it the old fashioned way */
+			ret = do_reset1(drive, 0);	/* do it the old fashioned way */
 		}
 	} else {
 		printk("%s: ATAPI reset complete\n", drive->name);
 		ch->poll_timeout = 0;	/* done polling */
+
+		ret = ide_stopped;
 	}
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -289,20 +299,20 @@
  */
 static ide_startstop_t reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
+	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
+	int ret;
 
+	spin_lock_irqsave(ch->lock, flags);
 	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
-			unsigned long flags;
-
-			spin_lock_irqsave(ch->lock, flags);
 			ata_set_handler(drive, reset_pollfunc, HZ/20, NULL);
-			spin_unlock_irqrestore(ch->lock, flags);
-
-			return ide_started;	/* continue polling */
+			ret = ide_started;	/* continue polling */
+		} else {
+			printk("%s: reset timed out, status=0x%02x\n", ch->name, drive->status);
+			++drive->failures;
+			ret = ide_stopped;
 		}
-		printk("%s: reset timed out, status=0x%02x\n", ch->name, drive->status);
-		++drive->failures;
 	} else  {
 		u8 stat;
 
@@ -333,8 +343,11 @@
 			printk(KERN_ERR "%s error [%02x]\n", msg, stat);
 			++drive->failures;
 		}
+
+		ret = ide_stopped;
 	}
 	ch->poll_timeout = 0;	/* done polling */
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_stopped;
 }
@@ -357,7 +370,7 @@
  * Channel lock should be held.
  */
 
-static ide_startstop_t do_reset1(struct ata_device *drive, int do_not_try_atapi)
+static ide_startstop_t do_reset1(struct ata_device *drive, int try_atapi)
 {
 	unsigned int unit;
 	unsigned long flags;
@@ -367,15 +380,17 @@
 	__cli();		/* local CPU only */
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
-	if (drive->type != ATA_DISK && !do_not_try_atapi) {
-		check_crc_errors(drive);
-		ata_select(drive, 20);
-		OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
-		ch->poll_timeout = jiffies + WAIT_WORSTCASE;
-		ata_set_handler(drive, atapi_reset_pollfunc, HZ/20, NULL);
-		__restore_flags(flags);	/* local CPU only */
+	if (try_atapi) {
+		if (drive->type != ATA_DISK) {
+			check_crc_errors(drive);
+			ata_select(drive, 20);
+			OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
+			ch->poll_timeout = jiffies + WAIT_WORSTCASE;
+			ata_set_handler(drive, atapi_reset_pollfunc, HZ/20, NULL);
+			__restore_flags(flags);	/* local CPU only */
 
-		return ide_started;
+			return ide_started;
+		}
 	}
 
 	/*
@@ -572,6 +587,7 @@
 
 		return ide_stopped;
 	}
+
 	/* other bits are useless when BUSY */
 	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr))
 		rq->errors |= ERROR_RESET; /* FIXME: What's that?! */
@@ -598,14 +614,15 @@
 
 	if (rq->errors >= ERROR_MAX) {
 		printk(KERN_ERR "%s: max number of retries exceeded!\n", drive->name);
+		/* FIXME: make sure all end_request implementations are lock free */
 		if (ata_ops(drive) && ata_ops(drive)->end_request)
 			ata_ops(drive)->end_request(drive, rq, 0);
 		else
-			ide_end_request(drive, rq, 0);
+			__ata_end_request(drive, rq, 0, 0);
 	} else {
 		++rq->errors;
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET)
-			return do_reset1(drive, 0);
+			return do_reset1(drive, 1);
 		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
 			return do_recalibrate(drive);
 	}
@@ -614,60 +631,6 @@
 }
 
 /*
- * Busy-wait for the drive status to be not "busy".  Check then the status for
- * all of the "good" bits and none of the "bad" bits, and if all is okay it
- * returns 0.  All other cases return 1 after invoking error handler -- caller
- * should just return.
- *
- * This routine should get fixed to not hog the cpu during extra long waits..
- * That could be done by busy-waiting for the first jiffy or two, and then
- * setting a timer to wake up at half second intervals thereafter, until
- * timeout is achieved, before timing out.
- *
- * FIXME: Channel lock should be held.
- */
-int ide_wait_stat(ide_startstop_t *startstop,
-		struct ata_device *drive, struct request *rq,
-		byte good, byte bad, unsigned long timeout)
-{
-	int i;
-
-	/* bail early if we've exceeded max_failures */
-	if (drive->max_failures && (drive->failures > drive->max_failures)) {
-		*startstop = ide_stopped;
-
-		return 1;
-	}
-
-	/* spec allows drive 400ns to assert "BUSY" */
-	udelay(1);
-	if (!ata_status(drive, 0, BUSY_STAT)) {
-		timeout += jiffies;
-		while (!ata_status(drive, 0, BUSY_STAT)) {
-			if (time_after(jiffies, timeout)) {
-				*startstop = ata_error(drive, rq, "status timeout");
-				return 1;
-			}
-		}
-	}
-
-	/*
-	 * Allow status to settle, then read it again.  A few rare drives
-	 * vastly violate the 400ns spec here, so we'll wait up to 10usec for a
-	 * "good" status rather than expensively fail things immediately.  This
-	 * fix courtesy of Matthew Faupel & Niccolo Rigacci.
-	 */
-	for (i = 0; i < 10; i++) {
-		udelay(1);
-		if (ata_status(drive, good, bad))
-			return 0;
-	}
-	*startstop = ata_error(drive, rq, "status error");
-
-	return 1;
-}
-
-/*
  * This initiates handling of a new I/O request.
  */
 static ide_startstop_t start_request(struct ata_device *drive, struct request *rq)
@@ -710,8 +673,8 @@
 		ide_startstop_t res;
 
 		ata_select(drive, 0);
-		if (ide_wait_stat(&res, drive, rq, drive->ready_stat,
-					BUSY_STAT|DRQ_STAT, WAIT_READY)) {
+		if (ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
+					WAIT_READY, rq, &res)) {
 			printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
 
 			return res;
@@ -731,7 +694,7 @@
 		if (ata_ops(drive)->do_request)
 			return ata_ops(drive)->do_request(drive, rq, block);
 		else {
-			ide_end_request(drive, rq, 0);
+			ata_end_request(drive, rq, 0);
 
 			return ide_stopped;
 		}
@@ -748,7 +711,7 @@
 	if (ata_ops(drive) && ata_ops(drive)->end_request)
 		ata_ops(drive)->end_request(drive, rq, 0);
 	else
-		ide_end_request(drive, rq, 0);
+		ata_end_request(drive, rq, 0);
 
 	return ide_stopped;
 }
@@ -1008,64 +971,24 @@
 }
 
 /*
- * Un-busy the hwgroup etc, and clear any pending DMA status. we want to
- * retry the current request in PIO mode instead of risking tossing it
- * all away
- */
-static void dma_timeout_retry(struct ata_device *drive, struct request *rq)
-{
-	/*
-	 * end current dma transaction
-	 */
-	udma_stop(drive);
-	udma_timeout(drive);
-
-	/*
-	 * Disable dma for now, but remember that we did so because of
-	 * a timeout -- we'll reenable after we finish this next request
-	 * (or rather the first chunk of it) in pio.
-	 */
-	drive->retry_pio++;
-	drive->state = DMA_PIO_RETRY;
-	udma_enable(drive, 0, 0);
-
-	/*
-	 * un-busy drive etc (hwgroup->busy is cleared on return) and
-	 * make sure request is sane
-	 */
-	drive->rq = NULL;
-
-	rq->errors = 0;
-	if (rq->bio) {
-		rq->sector = rq->bio->bi_sector;
-		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
-		rq->buffer = NULL;
-	}
-}
-
-/*
  * This is our timeout function for all drive operations.  But note that it can
  * also be invoked as a result of a "sleep" operation triggered by the
  * mod_timer() call in do_request.
+ *
+ * FIXME: this should take a drive context instead of a channel.
  */
 void ide_timer_expiry(unsigned long data)
 {
-	struct ata_channel *ch = (struct ata_channel *) data;
-	ata_handler_t *handler;
-	ata_expiry_t *expiry;
 	unsigned long flags;
-	unsigned long wait;
-
-	/*
-	 * A global lock protects timers etc -- shouldn't get contention
-	 * worth mentioning.
-	 */
+	struct ata_channel *ch = (struct ata_channel *) data;
 
 	spin_lock_irqsave(ch->lock, flags);
 	del_timer(&ch->timer);
 
-	handler = ch->handler;
-	if (!handler) {
+	if (!ch->drive) {
+		printk(KERN_ERR "%s: IRQ handler was NULL\n", __FUNCTION__);
+		ch->handler = NULL;
+	} else if (!ch->handler) {
 
 		/*
 		 * Either a marginal timeout occurred (got the interrupt just
@@ -1078,69 +1001,103 @@
 			clear_bit(IDE_BUSY, ch->active);
 	} else {
 		struct ata_device *drive = ch->drive;
-		if (!drive) {
-			printk(KERN_ERR "ide_timer_expiry: IRQ handler was NULL\n");
-			ch->handler = NULL;
-		} else {
-			ide_startstop_t startstop;
+		ide_startstop_t ret;
+		ata_handler_t *handler;
 
-			/* paranoia */
-			if (!test_and_set_bit(IDE_BUSY, ch->active))
-				printk(KERN_ERR "%s: ide_timer_expiry: IRQ handler was not busy??\n", drive->name);
-			if ((expiry = ch->expiry) != NULL) {
-				/* continue */
-				if ((wait = expiry(drive, drive->rq)) != 0) {
-					/* reengage timer */
-					ch->timer.expires  = jiffies + wait;
-					add_timer(&ch->timer);
+		/* paranoia */
+		if (!test_and_set_bit(IDE_BUSY, ch->active))
+			printk(KERN_ERR "%s: %s: IRQ handler was not busy?!\n",
+					drive->name, __FUNCTION__);
+
+		if (ch->expiry) {
+			unsigned long wait;
+
+			/* continue */
+			if ((wait = ch->expiry(drive, drive->rq)) != 0) {
+				/* reengage timer */
+				ch->timer.expires  = jiffies + wait;
+				add_timer(&ch->timer);
 
-					spin_unlock_irqrestore(ch->lock, flags);
+				spin_unlock_irqrestore(ch->lock, flags);
 
-					return;
-				}
+				return;
 			}
-			ch->handler = NULL;
-			/*
-			 * We need to simulate a real interrupt when invoking
-			 * the handler() function, which means we need to globally
-			 * mask the specific IRQ:
-			 */
+		}
+
+		/*
+		 * We need to simulate a real interrupt when invoking the
+		 * handler() function, which means we need to globally mask the
+		 * specific IRQ:
+		 */
 
-			spin_unlock(ch->lock);
+		handler = ch->handler;
+		ch->handler = NULL;
+		spin_unlock(ch->lock);
 
-			ch = drive->channel;
+		ch = drive->channel;
 #if DISABLE_IRQ_NOSYNC
-			disable_irq_nosync(ch->irq);
+		disable_irq_nosync(ch->irq);
 #else
-			disable_irq(ch->irq);	/* disable_irq_nosync ?? */
+		disable_irq(ch->irq);	/* disable_irq_nosync ?? */
 #endif
-			__cli();	/* local CPU only, as if we were handling an interrupt */
-			if (ch->poll_timeout != 0) {
-				startstop = handler(drive, drive->rq);
-			} else if (drive_is_ready(drive)) {
-				if (drive->waiting_for_dma)
-					udma_irq_lost(drive);
-				(void) ide_ack_intr(ch);
-				printk("%s: lost interrupt\n", drive->name);
-				startstop = handler(drive, drive->rq);
-			} else {
-				if (drive->waiting_for_dma) {
-					startstop = ide_stopped;
-					dma_timeout_retry(drive, drive->rq);
-				} else
-					startstop = ata_error(drive, drive->rq, "irq timeout");
+		__cli();	/* local CPU only, as if we were handling an interrupt */
+		if (ch->poll_timeout) {
+			ret = handler(drive, drive->rq);
+		} else if (drive_is_ready(drive)) {
+			if (drive->waiting_for_dma)
+				udma_irq_lost(drive);
+			(void) ide_ack_intr(ch);
+			printk("%s: lost interrupt\n", drive->name);
+			ret = handler(drive, drive->rq);
+		} else if (drive->waiting_for_dma) {
+			struct request *rq = drive->rq;
+
+			/*
+			 * Un-busy the hwgroup etc, and clear any pending DMA
+			 * status. we want to retry the current request in PIO
+			 * mode instead of risking tossing it all away.
+			 */
+
+			udma_stop(drive);
+			udma_timeout(drive);
+
+			/* Disable dma for now, but remember that we did so
+			 * because of a timeout -- we'll reenable after we
+			 * finish this next request (or rather the first chunk
+			 * of it) in pio.
+			 */
+
+			drive->retry_pio++;
+			drive->state = DMA_PIO_RETRY;
+			udma_enable(drive, 0, 0);
+
+			/* Un-busy drive etc (hwgroup->busy is cleared on
+			 * return) and make sure request is sane.
+			 */
+
+			drive->rq = NULL;
+
+			rq->errors = 0;
+			if (rq->bio) {
+				rq->sector = rq->bio->bi_sector;
+				rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
+				rq->buffer = NULL;
 			}
-			enable_irq(ch->irq);
+			ret = ide_stopped;
+		} else
+			ret = ata_error(drive, drive->rq, "irq timeout");
 
-			spin_lock_irq(ch->lock);
+		enable_irq(ch->irq);
 
-			if (startstop == ide_stopped)
-				clear_bit(IDE_BUSY, ch->active);
-		}
-	}
+		spin_lock_irq(ch->lock);
+
+		if (ret == ide_stopped)
+			clear_bit(IDE_BUSY, ch->active);
 
-	do_request(ch->drive->channel);
 
+		/* Reenter the request handling engine */
+		do_request(ch);
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 }
 
@@ -1440,11 +1397,10 @@
 EXPORT_SYMBOL(ata_dump);
 EXPORT_SYMBOL(ata_error);
 
-EXPORT_SYMBOL(ide_wait_stat);
 /* FIXME: this is a trully bad name */
 EXPORT_SYMBOL(restart_request);
-EXPORT_SYMBOL(__ide_end_request);
-EXPORT_SYMBOL(ide_end_request);
+EXPORT_SYMBOL(ata_end_request);
+EXPORT_SYMBOL(__ata_end_request);
 EXPORT_SYMBOL(ide_stall_queue);
 
 EXPORT_SYMBOL(ide_setup_ports);
diff -urN linux-2.5.21/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.21/drivers/ide/ide-cd.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-11 00:02:07.000000000 +0200
@@ -556,7 +556,7 @@
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
-	ide_end_request(drive, rq, uptodate);
+	ata_end_request(drive, rq, uptodate);
 }
 
 
@@ -734,7 +734,7 @@
 	struct cdrom_info *info = drive->driver_data;
 
 	/* Wait for the controller to be idle. */
-	if (ide_wait_stat(&startstop, drive, rq, 0, BUSY_STAT, WAIT_READY))
+	if (ata_status_poll(drive, 0, BUSY_STAT, WAIT_READY, rq, &startstop))
 		return startstop;
 
 	spin_lock_irqsave(ch->lock, flags);
@@ -798,7 +798,8 @@
 			return startstop;
 	} else {
 		/* Otherwise, we must wait for DRQ to get set. */
-		if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY))
+		if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
+					WAIT_READY, rq, &startstop))
 			return startstop;
 	}
 
@@ -926,7 +927,14 @@
 
 	if (dma) {
 		if (!dma_error) {
-			__ide_end_request(drive, rq, 1, rq->nr_sectors);
+			/* FIXME: this locking should encompass the above register
+			 * file access too.
+			 */
+
+			spin_lock_irqsave(ch->lock, flags);
+			__ata_end_request(drive, rq, 1, rq->nr_sectors);
+			spin_unlock_irqrestore(ch->lock, flags);
+
 			return ide_stopped;
 		} else
 			return ata_error(drive, rq, "dma error");
@@ -1518,7 +1526,14 @@
 		if (dma_error)
 			return ata_error(drive, rq, "dma error");
 
-		__ide_end_request(drive, rq, 1, rq->nr_sectors);
+		/* FIXME: this locking should encompass the above register
+		 * file access too.
+		 */
+
+		spin_lock_irqsave(ch->lock, flags);
+		__ata_end_request(drive, rq, 1, rq->nr_sectors);
+		spin_unlock_irqrestore(ch->lock, flags);
+
 		return ide_stopped;
 	}
 
diff -urN linux-2.5.21/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.21/drivers/ide/ide-disk.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-11 02:02:50.000000000 +0200
@@ -91,104 +91,99 @@
 }
 
 /*
- * Handler for command with PIO data-in phase
+ * Handler for command with PIO data-in phase.
  */
 static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
 {
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
-	char *buf = NULL;
+	int ret;
+
+	spin_lock_irqsave(ch->lock, flags);
 
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT))
+		if (drive->status & (ERR_STAT|DRQ_STAT)) {
+			spin_unlock_irqrestore(ch->lock, flags);
+
 			return ata_error(drive, rq, __FUNCTION__);
+		}
 
 		if (!(drive->status & BUSY_STAT)) {
-#if 0
-			printk("task_in_intr to Soon wait for next interrupt\n");
-#endif
-
-			/* FIXME: this locking should encompass the above register
-			 * file access too.
-			 */
-
-			spin_lock_irqsave(ch->lock, flags);
+//			printk("task_in_intr to Soon wait for next interrupt\n");
 			ata_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
 			spin_unlock_irqrestore(ch->lock, flags);
 
 			return ide_started;
 		}
 	}
-	buf = ide_map_rq(rq, &flags);
-#if 0
-	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
-#endif
 
-	ata_read(drive, buf, SECTOR_WORDS);
-	ide_unmap_rq(rq, buf, &flags);
+//	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
+	{
+		unsigned long flags;
+		char *buf;
+
+		buf = ide_map_rq(rq, &flags);
+		ata_read(drive, buf, SECTOR_WORDS);
+		ide_unmap_rq(rq, buf, &flags);
+	}
 
 	/* First segment of the request is complete. note that this does not
 	 * necessarily mean that the entire request is done!! this is only true
-	 * if ide_end_request() returns 0.
+	 * if ata_end_request() returns 0.
 	 */
 
-	if (--rq->current_nr_sectors <= 0) {
-#if 0
-		printk("Request Ended stat: %02x\n", drive->status);
-#endif
-		if (!ide_end_request(drive, rq, 1))
-			return ide_stopped;
-	}
-
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
+	if (--rq->current_nr_sectors <= 0 && !__ata_end_request(drive, rq, 1, 0)) {
+//		printk("Request Ended stat: %02x\n", drive->status);
+		ret = ide_stopped;
+	} else {
+		/* still data left to transfer */
+		ata_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
 
-	spin_lock_irqsave(ch->lock, flags);
-	/* still data left to transfer */
-	ata_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
+		ret = ide_started;
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 /*
- * Handler for command with PIO data-out phase
+ * Handler for command with PIO data-out phase.
  */
 static ide_startstop_t task_out_intr(struct ata_device *drive, struct request *rq)
 {
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
-	char *buf = NULL;
+	int ret;
 
-	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat))
-		return ata_error(drive, rq, __FUNCTION__);
+	spin_lock_irqsave(ch->lock, flags);
+	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat)) {
+		spin_unlock_irqrestore(ch->lock, flags);
 
-	if (!rq->current_nr_sectors)
-		if (!ide_end_request(drive, rq, 1))
-			return ide_stopped;
+		return ata_error(drive, rq, __FUNCTION__);
+	}
 
-	if ((rq->nr_sectors == 1) != (drive->status & DRQ_STAT)) {
-		buf = ide_map_rq(rq, &flags);
-#if 0
-		printk("write: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
-#endif
+	if (!rq->current_nr_sectors && !__ata_end_request(drive, rq, 1, 0)) {
+		ret = ide_stopped;
+	} else {
+		if ((rq->nr_sectors == 1) != (drive->status & DRQ_STAT)) {
+			unsigned long flags;
+			char *buf;
 
-		ata_write(drive, buf, SECTOR_WORDS);
-		ide_unmap_rq(rq, buf, &flags);
-		rq->errors = 0;
-		rq->current_nr_sectors--;
-	}
+//			printk("write: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
+			buf = ide_map_rq(rq, &flags);
+			ata_write(drive, buf, SECTOR_WORDS);
+			ide_unmap_rq(rq, buf, &flags);
 
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
+			rq->errors = 0;
+			--rq->current_nr_sectors;
+		}
+		ata_set_handler(drive, task_out_intr, WAIT_CMD, NULL);
 
-	spin_lock_irqsave(ch->lock, flags);
-	ata_set_handler(drive, task_out_intr, WAIT_CMD, NULL);
+		ret = ide_started;
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 /*
@@ -198,63 +193,68 @@
 {
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
-	char *buf = NULL;
-	unsigned int msect;
-	unsigned int nsect;
+	int ret;
 
+	spin_lock_irqsave(ch->lock, flags);
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT))
-			return ata_error(drive, rq, __FUNCTION__);
+		if (drive->status & (ERR_STAT|DRQ_STAT)) {
+			spin_unlock_irqrestore(ch->lock, flags);
 
-		/* FIXME: this locking should encompass the above register
-		 * file access too.
-		 */
+			return ata_error(drive, rq, __FUNCTION__);
+		}
 
-		spin_lock_irqsave(ch->lock, flags);
 		/* no data yet, so wait for another interrupt */
 		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
-		spin_unlock_irqrestore(ch->lock, flags);
 
-		return ide_started;
-	}
+		ret = ide_started;
+	} else {
+		unsigned int msect;
 
-	/* (ks/hs): Fixed Multi-Sector transfer */
-	msect = drive->mult_count;
+		/* (ks/hs): Fixed Multi-Sector transfer */
+		msect = drive->mult_count;
 
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
+		do {
+			unsigned int nsect;
 
-		buf = ide_map_rq(rq, &flags);
+			nsect = rq->current_nr_sectors;
+			if (nsect > msect)
+				nsect = msect;
 
 #if 0
-		printk("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
-			buf, nsect, rq->current_nr_sectors);
+			printk("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
+					buf, nsect, rq->current_nr_sectors);
 #endif
-		ata_read(drive, buf, nsect * SECTOR_WORDS);
-		ide_unmap_rq(rq, buf, &flags);
-		rq->errors = 0;
-		rq->current_nr_sectors -= nsect;
-		msect -= nsect;
-		if (!rq->current_nr_sectors) {
-			if (!ide_end_request(drive, rq, 1))
-				return ide_stopped;
-		}
-	} while (msect);
+			{
+				unsigned long flags;
+				char *buf;
+
+				buf = ide_map_rq(rq, &flags);
+				ata_read(drive, buf, nsect * SECTOR_WORDS);
+				ide_unmap_rq(rq, buf, &flags);
+			}
 
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
+			rq->errors = 0;
+			rq->current_nr_sectors -= nsect;
+			msect -= nsect;
+
+			/* FIXME: this seems buggy */
+			if (!rq->current_nr_sectors) {
+				if (!__ata_end_request(drive, rq, 1, 0)) {
+					spin_unlock_irqrestore(ch->lock, flags);
 
-	spin_lock_irqsave(ch->lock, flags);
-	/*
-	 * more data left
-	 */
-	ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+					return ide_stopped;
+				}
+			}
+		} while (msect);
+
+		/* more data left */
+		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+
+		ret = ide_started;
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
@@ -262,9 +262,9 @@
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ok;
-	int mcount = drive->mult_count;
-	ide_startstop_t startstop;
+	int ret;
 
+	spin_lock_irqsave(ch->lock, flags);
 
 	/*
 	 * FIXME: the drive->status checks here seem to be messy.
@@ -277,80 +277,67 @@
 
 	if (!ok || !rq->nr_sectors) {
 		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			startstop = ata_error(drive, rq, __FUNCTION__);
+			spin_unlock_irqrestore(ch->lock, flags);
 
-			return startstop;
+			return ata_error(drive, rq, __FUNCTION__);
 		}
 	}
-
 	if (!rq->nr_sectors) {
-		__ide_end_request(drive, rq, 1, rq->hard_nr_sectors);
+		__ata_end_request(drive, rq, 1, rq->hard_nr_sectors);
 		rq->bio = NULL;
-
-		return ide_stopped;
-	}
-
-	if (!ok) {
+		ret = ide_stopped;
+	} else if (!ok) {
 		/* no data yet, so wait for another interrupt */
-		if (!ch->handler) {
-			/* FIXME: this locking should encompass the above register
-			 * file access too.
-			 */
-
-			spin_lock_irqsave(ch->lock, flags);
+		if (!ch->handler)
 			ata_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
-			spin_unlock_irqrestore(ch->lock, flags);
-		}
+		ret = ide_started;
+	} else {
+		int mcount = drive->mult_count;
 
-		return ide_started;
-	}
+		do {
+			char *buf;
+			int nsect = rq->current_nr_sectors;
+			unsigned long flags;
+
+			if (nsect > mcount)
+				nsect = mcount;
+			mcount -= nsect;
+
+			buf = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
+			rq->sector += nsect;
+			rq->nr_sectors -= nsect;
+			rq->current_nr_sectors -= nsect;
+
+			/* Do we move to the next bio after this? */
+			if (!rq->current_nr_sectors) {
+				/* remember to fix this up /jens */
+				struct bio *bio = rq->bio->bi_next;
+
+				/* end early if we ran out of requests */
+				if (!bio) {
+					mcount = 0;
+				} else {
+					rq->bio = bio;
+					rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+				}
+			}
 
-	do {
-		char *buffer;
-		int nsect = rq->current_nr_sectors;
-		unsigned long flags;
+			/*
+			 * Ok, we're all setup for the interrupt re-entering us on the
+			 * last transfer.
+			 */
+			ata_write(drive, buf, nsect * SECTOR_WORDS);
+			bio_kunmap_irq(buffer, &flags);
+		} while (mcount);
 
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-
-		buffer = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
-		rq->sector += nsect;
-		rq->nr_sectors -= nsect;
-		rq->current_nr_sectors -= nsect;
-
-		/* Do we move to the next bio after this? */
-		if (!rq->current_nr_sectors) {
-			/* remember to fix this up /jens */
-			struct bio *bio = rq->bio->bi_next;
-
-			/* end early if we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
-			}
-		}
+		rq->errors = 0;
 
-		/*
-		 * Ok, we're all setup for the interrupt re-entering us on the
-		 * last transfer.
-		 */
-		ata_write(drive, buffer, nsect * SECTOR_WORDS);
-		bio_kunmap_irq(buffer, &flags);
-	} while (mcount);
-
-	rq->errors = 0;
-	if (!ch->handler) {
-		/* FIXME: this locking should encompass the above register
-		 * file access too.
-		 */
+		if (!ch->handler)
+			ata_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
 
-		spin_lock_irqsave(ch->lock, flags);
-		ata_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
-		spin_unlock_irqrestore(ch->lock, flags);
+		ret = ide_started;
 	}
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_started;
 }
@@ -571,24 +558,34 @@
  */
 static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	/*
-	 * Wait until all request have bin finished.
-	 */
+	unsigned long flags;
+	struct ata_channel *ch = drive->channel;
+	int ret;
 
+	/* make sure all request have bin finished
+	 * FIXME: this check doesn't make sense go! */
 	while (drive->blocked) {
 		yield();
 		printk(KERN_ERR "ide: Request while drive blocked?");
 	}
 
+	/* FIXME: Move this lock entiery upstream. */
+	spin_lock_irqsave(ch->lock, flags);
+
+	/* FIXME: this check doesn't make sense */
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
-		ide_end_request(drive, rq, 0);
+		__ata_end_request(drive, rq, 0, 0);
+		spin_unlock_irqrestore(ch->lock, flags);
+
 		return ide_stopped;
 	}
 
 	if (IS_PDC4030_DRIVE) {
 		extern ide_startstop_t promise_do_request(struct ata_device *, struct request *, sector_t);
 
+		spin_unlock_irqrestore(drive->channel->lock, flags);
+
 		return promise_do_request(drive, rq, block);
 	}
 
@@ -596,11 +593,8 @@
 	 * start a tagged operation
 	 */
 	if (drive->using_tcq) {
-		unsigned long flags;
 		int ret;
 
-		spin_lock_irqsave(drive->channel->lock, flags);
-
 		ret = blk_queue_start_tag(&drive->queue, rq);
 
 		if (ata_pending_commands(drive) > drive->max_depth)
@@ -608,27 +602,27 @@
 		if (ata_pending_commands(drive) > drive->max_last_depth)
 			drive->max_last_depth = ata_pending_commands(drive);
 
-		spin_unlock_irqrestore(drive->channel->lock, flags);
-
 		if (ret) {
 			BUG_ON(!ata_pending_commands(drive));
+			spin_unlock_irqrestore(ch->lock, flags);
+
 			return ide_started;
 		}
 	}
 
-	/* 48-bit LBA */
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
-		return lba48_do_request(drive, rq, block);
+		ret = lba48_do_request(drive, rq, block);
+	else if (drive->select.b.lba)
+		ret = lba28_do_request(drive, rq, block);
+	else
+		ret = chs_do_request(drive, rq, block);
 
-	/* 28-bit LBA */
-	if (drive->select.b.lba)
-		return lba28_do_request(drive, rq, block);
+	spin_unlock_irqrestore(ch->lock, flags);
 
-	/* 28-bit CHS */
-	return chs_do_request(drive, rq, block);
+	return ret;
 }
 
-static int idedisk_open (struct inode *inode, struct file *filp, struct ata_device *drive)
+static int idedisk_open(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
 	if (drive->removable && drive->usage == 1) {
@@ -648,10 +642,11 @@
 				drive->doorlocking = 0;
 		}
 	}
+
 	return 0;
 }
 
-static int idedisk_flushcache(struct ata_device *drive)
+static int flush_cache(struct ata_device *drive)
 {
 	struct ata_taskfile args;
 
@@ -661,6 +656,7 @@
 		args.cmd = WIN_FLUSH_CACHE_EXT;
 	else
 		args.cmd = WIN_FLUSH_CACHE;
+
 	return ide_raw_taskfile(drive, &args);
 }
 
@@ -680,7 +676,7 @@
 		}
 	}
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-		if (idedisk_flushcache(drive))
+		if (flush_cache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
 	MOD_DEC_USE_COUNT;
@@ -1244,15 +1240,27 @@
 
 static int idedisk_cleanup(struct ata_device *drive)
 {
+	int ret;
+
 	if (!drive)
 	    return 0;
 
-	put_device(&drive->device);
-	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-		if (idedisk_flushcache(drive))
+	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache) {
+		if (flush_cache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
-	return ide_unregister_subdriver(drive);
+	}
+	ret = ide_unregister_subdriver(drive);
+
+	/* FIXME: This is killing the kernel with BUG 185 at asm/spinlocks.h
+	 * horribly.  Check whatever we did REGISTER the device properly
+	 * in front?
+	 */
+#if 0
+	put_device(&drive->device);
+#endif
+
+	return ret;
 }
 
 static int idedisk_ioctl(struct ata_device *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
diff -urN linux-2.5.21/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.21/drivers/ide/ide-floppy.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-10 23:58:47.000000000 +0200
@@ -608,7 +608,7 @@
 /*
  *	idefloppy_end_request is used to finish servicing a request.
  *
- *	For read/write requests, we will call ide_end_request to pass to the
+ *	For read/write requests, we will call ata_end_request to pass to the
  *	next buffer.
  */
 static int idefloppy_end_request(struct ata_device *drive, struct request *rq, int uptodate)
@@ -632,7 +632,7 @@
 		return 0;
 
 	if (!(rq->flags & REQ_SPECIAL)) {
-		ide_end_request(drive, rq, uptodate);
+		ata_end_request(drive, rq, uptodate);
 		return 0;
 	}
 
@@ -956,9 +956,12 @@
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_ireason_reg_t ireason;
+	int ret;
 
-	if (ide_wait_stat (&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
+				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
+
 		return startstop;
 	}
 
@@ -968,18 +971,18 @@
 
 	spin_lock_irqsave(ch->lock, flags);
 	ireason.all=IN_BYTE (IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
-		spin_unlock_irqrestore(ch->lock, flags);
 
+	if (!ireason.b.cod || ireason.b.io) {
 		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
-		return ide_stopped;
+		ret = ide_stopped;
+	} else {
+		ata_set_handler (drive, idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
+		atapi_write(drive, floppy->pc->c, 12); /* Send the actual packet */
+		ret = ide_started;
 	}
-
-	ata_set_handler (drive, idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
-	atapi_write(drive, floppy->pc->c, 12); /* Send the actual packet */
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 
@@ -1010,39 +1013,43 @@
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_startstop_t startstop;
 	idefloppy_ireason_reg_t ireason;
+	int ret;
 
-	if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
+				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
+
 		return startstop;
 	}
+
 	/* FIXME: this locking should encompass the above register
 	 * file access too.
 	 */
 
 	spin_lock_irqsave(ch->lock, flags);
-	ireason.all=IN_BYTE (IDE_IREASON_REG);
+	ireason.all=IN_BYTE(IDE_IREASON_REG);
 	if (!ireason.b.cod || ireason.b.io) {
-		spin_unlock_irqrestore(ch->lock, flags);
-
 		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
-		return ide_stopped;
-	}
+		ret = ide_stopped;
+	} else {
 
-	/*
-	 * The following delay solves a problem with ATAPI Zip 100 drives where
-	 * the Busy flag was apparently being deasserted before the unit was
-	 * ready to receive data. This was happening on a 1200 MHz Athlon
-	 * system. 10/26/01 25msec is too short, 40 and 50msec work well.
-	 * idefloppy_pc_intr will not be actually used until after the packet
-	 * is moved in about 50 msec.
-	 */
-	ata_set_handler(drive,
-			idefloppy_pc_intr,	/* service routine for packet command */
-			floppy->ticks,		/* wait this long before "failing" */
-			idefloppy_transfer_pc2);	/* fail == transfer_pc2 */
+		/*
+		 * The following delay solves a problem with ATAPI Zip 100 drives where
+		 * the Busy flag was apparently being deasserted before the unit was
+		 * ready to receive data. This was happening on a 1200 MHz Athlon
+		 * system. 10/26/01 25msec is too short, 40 and 50msec work well.
+		 * idefloppy_pc_intr will not be actually used until after the packet
+		 * is moved in about 50 msec.
+		 */
+		ata_set_handler(drive,
+				idefloppy_pc_intr,	/* service routine for packet command */
+				floppy->ticks,		/* wait this long before "failing" */
+				idefloppy_transfer_pc2);	/* fail == transfer_pc2 */
+		ret = ide_started;
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 /*
diff -urN linux-2.5.21/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.21/drivers/ide/ide-tape.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-11 00:18:38.000000000 +0200
@@ -2196,9 +2196,12 @@
 	idetape_ireason_reg_t ireason;
 	int retries = 100;
 	ide_startstop_t startstop;
+	int ret;
 
-	if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
+				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-tape: Strange, packet command initiated yet DRQ isn't asserted\n");
+
 		return startstop;
 	}
 
@@ -2220,16 +2223,16 @@
 	}
 	if (!ireason.b.cod || ireason.b.io) {
 		printk (KERN_ERR "ide-tape: (IO,CoD) != (0,1) while issuing a packet command\n");
-		spin_unlock_irqrestore(ch->lock, flags);
-
-		return ide_stopped;
+		ret = ide_stopped;
+	} else {
+		tape->cmd_start_time = jiffies;
+		ata_set_handler(drive, idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* Set the interrupt routine */
+		atapi_write(drive,pc->c,12);	/* Send the actual packet */
+		ret = ide_started;
 	}
-	tape->cmd_start_time = jiffies;
-	ata_set_handler(drive, idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* Set the interrupt routine */
-	atapi_write(drive,pc->c,12);	/* Send the actual packet */
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 static ide_startstop_t idetape_issue_packet_command(struct ata_device *drive,
@@ -2618,7 +2621,7 @@
 		 *	We do not support buffer cache originated requests.
 		 */
 		printk (KERN_NOTICE "ide-tape: %s: Unsupported command in request queue (%ld)\n", drive->name, rq->flags);
-		ide_end_request(drive, rq, 0);			/* Let the common code handle it */
+		ata_end_request(drive, rq, 0);			/* Let the common code handle it */
 		return ide_stopped;
 	}
 
diff -urN linux-2.5.21/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.21/drivers/ide/ide-taskfile.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-10 23:42:40.000000000 +0200
@@ -233,7 +233,8 @@
 		    ar->cmd == WIN_MULTWRITE_EXT) {
 			ide_startstop_t startstop;
 
-			if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
+			if (ata_status_poll(drive, DATA_READY, drive->bad_wstat,
+						WAIT_DRQ, rq, &startstop)) {
 				printk(KERN_ERR "%s: no DRQ after issuing %s\n",
 						drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
 				return startstop;
diff -urN linux-2.5.21/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.21/drivers/ide/main.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/main.c	2002-06-11 02:04:39.000000000 +0200
@@ -430,7 +430,7 @@
 		struct ata_device *drive = &ch->drives[i];
 
 		if (drive->de) {
-			devfs_unregister (drive->de);
+			devfs_unregister(drive->de);
 			drive->de = NULL;
 		}
 		if (!drive->present)
@@ -1246,7 +1246,7 @@
 			return NOTIFY_DONE;
 	}
 
-	printk("flushing ide devices: ");
+	printk(KERN_INFO "flushing ATA/ATAPI devices: ");
 
 	for (i = 0; i < MAX_HWIFS; i++) {
 		int unit;
@@ -1264,9 +1264,10 @@
 			/* set the drive to standby */
 			printk("%s ", drive->name);
 			if (ata_ops(drive)) {
-				if (event != SYS_RESTART)
+				if (event != SYS_RESTART) {
 					if (ata_ops(drive)->standby && ata_ops(drive)->standby(drive))
 						continue;
+				}
 
 				if (ata_ops(drive)->cleanup)
 					ata_ops(drive)->cleanup(drive);
@@ -1290,8 +1291,7 @@
 {
 	printk(KERN_INFO "ATA/ATAPI device driver v" VERSION "\n");
 
-	ide_devfs_handle = devfs_mk_dir(NULL, "ata", NULL);
-	devfs_mk_symlink(NULL, "ide", DEVFS_FL_DEFAULT, "ata", NULL, NULL);
+	ide_devfs_handle = devfs_mk_dir(NULL, "ide", NULL);
 
 	/*
 	 * Because most of the ATA adapters represent the timings in unit of
diff -urN linux-2.5.21/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.21/drivers/ide/pcidma.c	2002-06-11 02:11:03.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-10 03:24:16.000000000 +0200
@@ -44,7 +44,17 @@
 
 	if (ata_status(drive, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
-			__ide_end_request(drive, rq, 1, rq->nr_sectors);
+			unsigned long flags;
+			struct ata_channel *ch = drive->channel;
+
+			/* FIXME: this locking should encompass the above register
+			 * file access too.
+			 */
+
+			spin_lock_irqsave(ch->lock, flags);
+			__ata_end_request(drive, rq, 1, rq->nr_sectors);
+			spin_unlock_irqrestore(ch->lock, flags);
+
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
diff -urN linux-2.5.21/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.21/drivers/ide/pdc4030.c	2002-06-11 02:11:07.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-06-10 23:47:13.000000000 +0200
@@ -247,7 +247,8 @@
 	if (pdc4030_cmd(drive, PROMISE_GET_CONFIG)) {
 		return 0;
 	}
-	if (ide_wait_stat(&startstop, drive, NULL, DATA_READY,BAD_W_STAT,WAIT_DRQ)) {
+	if (ata_status_poll(drive, DATA_READY, BAD_W_STAT,
+				WAIT_DRQ, NULL, &startstop)) {
 		printk(KERN_INFO
 			"%s: Failed Promise read config!\n",hwif->name);
 		return 0;
@@ -407,7 +408,8 @@
 	rq->nr_sectors -= nsect;
 	total_remaining = rq->nr_sectors;
 	if ((rq->current_nr_sectors -= nsect) <= 0) {
-		ide_end_request(drive, rq, 1);
+		/* FIXME: no queue locking above! */
+		ata_end_request(drive, rq, 1);
 	}
 
 	/*
@@ -461,13 +463,11 @@
  */
 static ide_startstop_t promise_complete_pollfunc(struct ata_device *drive, struct request *rq)
 {
+	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 
 	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
-			unsigned long flags;
-			struct ata_channel *ch = drive->channel;
-
 			/* FIXME: this locking should encompass the above
 			 * register file access too.
 			 */
@@ -488,7 +488,13 @@
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Write complete - end_request\n", drive->name);
 #endif
-	__ide_end_request(drive, rq, 1, rq->nr_sectors);
+	/* FIXME: this locking should encompass the above
+	 * register file access too.
+	 */
+
+	spin_lock_irqsave(ch->lock, flags);
+	__ata_end_request(drive, rq, 1, rq->nr_sectors);
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_stopped;
 }
@@ -653,7 +659,7 @@
 	/* Check that it's a regular command. If not, bomb out early. */
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "pdc4030 bad flags");
-		ide_end_request(drive, rq, 0);
+		ata_end_request(drive, rq, 0);
 
 		return ide_stopped;
 	}
@@ -721,7 +727,8 @@
  *	call the promise_write function to deal with writing the data out
  * NOTE: No interrupts are generated on writes. Write completion must be polled
  */
-		if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
+		if (ata_status_poll(drive, DATA_READY, drive->bad_wstat,
+					WAIT_DRQ, rq, &startstop )) {
 			printk(KERN_ERR "%s: no DRQ after issuing "
 			       "PROMISE_WRITE\n", drive->name);
 			return startstop;
@@ -733,7 +740,8 @@
 
 	default:
 		printk(KERN_ERR "pdc4030: command not READ or WRITE! Huh?\n");
-		ide_end_request(drive, rq, 0);
+		/* FIXME: This should already run under the lock. */
+		ata_end_request(drive, rq, 0);
 		return ide_stopped;
 	}
 }
diff -urN linux-2.5.21/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.21/drivers/ide/probe.c	2002-06-09 07:26:25.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-06-11 00:18:00.000000000 +0200
@@ -307,16 +307,7 @@
 		(drive->id->hw_config & 0x6000)) ? 1 : 0);
 }
 
-/*
- * Similar to ide_wait_stat(), except it never calls ata_error internally.
- * This is a kludge to handle the new ide_config_drive_speed() function,
- * and should not otherwise be used anywhere.  Eventually, the tuneproc's
- * should be updated to return ide_startstop_t, in which case we can get
- * rid of this abomination again.  :)   -ml
- *
- * It is gone..........
- *
- * const char *msg == consider adding for verbose errors.
+/* FIXME: Channel lock should be held.
  */
 int ide_config_drive_speed(struct ata_device *drive, byte speed)
 {
@@ -329,12 +320,10 @@
 	outb(inb(ch->dma_base + 2) & ~(1 << (5 + unit)), ch->dma_base + 2);
 #endif
 
-	/*
-	 * Don't use ide_wait_cmd here - it will attempt to set_geometry and
+	/* Don't use ide_wait_cmd here - it will attempt to set_geometry and
 	 * recalibrate, but for some reason these don't work at this point
 	 * (lost interrupt).
-	 */
-        /*
+         *
          * Select the drive, and issue the SETFEATURES command
          */
 	disable_irq(ch->irq);	/* disable_irq_nosync ?? */
@@ -350,20 +339,7 @@
 		ata_irq_enable(drive, 1);
 	udelay(1);
 
-	/*
-	 * Wait for drive to become non-BUSY
-	 */
-	if (!ata_status(drive, 0, BUSY_STAT)) {
-		unsigned long flags, timeout;
-		__save_flags(flags);	/* local CPU only */
-		ide__sti();		/* local CPU only -- for jiffies */
-		timeout = jiffies + WAIT_CMD;
-		while (!ata_status(drive, 0, BUSY_STAT)) {
-			if (time_after(jiffies, timeout))
-				break;
-		}
-		__restore_flags(flags); /* local CPU only */
-	}
+	ata_busy_poll(drive, WAIT_CMD);
 
 	/*
 	 * Allow status to settle, then read it again.
diff -urN linux-2.5.21/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.21/drivers/ide/tcq.c	2002-06-11 02:11:07.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-10 03:25:55.000000000 +0200
@@ -327,6 +327,8 @@
 
 static ide_startstop_t dmaq_complete(struct ata_device *drive, struct request *rq)
 {
+	unsigned long flags;
+	struct ata_channel *ch = drive->channel;
 	u8 dma_stat;
 
 	/*
@@ -348,7 +350,14 @@
 		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
 
 	TCQ_PRINTK("%s: ending %p, tag %d\n", __FUNCTION__, rq, rq->tag);
-	__ide_end_request(drive, rq, !dma_stat, rq->nr_sectors);
+
+	/* FIXME: this locking should encompass the above register
+	 * file access too.
+	 */
+
+	spin_lock_irqsave(ch->lock, flags);
+	__ata_end_request(drive, rq, !dma_stat, rq->nr_sectors);
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	/*
 	 * we completed this command, check if we can service a new command
diff -urN linux-2.5.21/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.21/drivers/scsi/ide-scsi.c	2002-06-11 02:11:07.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-10 23:54:50.000000000 +0200
@@ -244,7 +244,7 @@
 	unsigned long flags;
 
 	if (!(rq->flags & REQ_PC)) {
-		ide_end_request(drive, rq, uptodate);
+		ata_end_request(drive, rq, uptodate);
 		return 0;
 	}
 
@@ -399,29 +399,33 @@
 	struct Scsi_Host *host = drive->driver_data;
 	idescsi_scsi_t *scsi = idescsi_private(host);
 	struct atapi_packet_command *pc = scsi->pc;
-	byte ireason;
+	u8 ireason;
 	ide_startstop_t startstop;
+	int ret;
 
-	if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
+				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-scsi: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason = IN_BYTE (IDE_IREASON_REG);
-	if ((ireason & (IDESCSI_IREASON_IO | IDESCSI_IREASON_COD)) != IDESCSI_IREASON_COD) {
-		printk (KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while issuing a packet command\n");
-		return ide_stopped;
-	}
 
 	/* FIXME: this locking should encompass the above register
 	 * file access too.
 	 */
-
 	spin_lock_irqsave(ch->lock, flags);
-	ata_set_handler(drive, idescsi_pc_intr, get_timeout(pc), NULL);	/* Set the interrupt routine */
+	ireason = IN_BYTE(IDE_IREASON_REG);
+
+	if ((ireason & (IDESCSI_IREASON_IO | IDESCSI_IREASON_COD)) != IDESCSI_IREASON_COD) {
+		printk (KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while issuing a packet command\n");
+		ret = ide_stopped;
+	} else {
+		ata_set_handler(drive, idescsi_pc_intr, get_timeout(pc), NULL);
+		atapi_write(drive, scsi->pc->c, 12);
+		ret = ide_started;
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	atapi_write(drive, scsi->pc->c, 12);			/* Send the actual packet */
-	return ide_started;
+	return ret;
 }
 
 /*
diff -urN linux-2.5.21/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.21/include/linux/ide.h	2002-06-11 02:11:07.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-11 00:17:30.000000000 +0200
@@ -601,8 +601,9 @@
 #define LOCAL_END_REQUEST	/* Don't generate end_request in blk.h */
 #include <linux/blk.h>
 
-extern int __ide_end_request(struct ata_device *, struct request *, int, unsigned int);
-extern int ide_end_request(struct ata_device *drive, struct request *, int);
+/* Not locking and locking variant: */
+extern int __ata_end_request(struct ata_device *, struct request *, int, unsigned int);
+extern int ata_end_request(struct ata_device *drive, struct request *, int);
 
 extern void ata_set_handler(struct ata_device *drive, ata_handler_t handler,
 		unsigned long timeout, ata_expiry_t expiry);
@@ -611,11 +612,6 @@
 extern ide_startstop_t ata_error(struct ata_device *, struct request *rq, const char *);
 
 extern void ide_fixstring(char *s, const int bytecount, const int byteswap);
-
-extern int ide_wait_stat(ide_startstop_t *,
-		struct ata_device *, struct request *rq,
-		byte, byte, unsigned long);
-
 extern int ide_wait_noerr(struct ata_device *, byte, byte, unsigned long);
 
 /*
@@ -831,7 +827,11 @@
 
 extern void ata_select(struct ata_device *, unsigned long);
 extern void ata_mask(struct ata_device *);
+extern int ata_busy_poll(struct ata_device *, unsigned long);
 extern int ata_status(struct ata_device *, u8, u8);
+extern int ata_status_poll( struct ata_device *, u8, u8,
+		unsigned long, struct request *rq, ide_startstop_t *);
+
 extern int ata_irq_enable(struct ata_device *, int);
 extern void ata_reset(struct ata_channel *);
 extern void ata_out_regfile(struct ata_device *, struct hd_drive_task_hdr *);

--------------080500030802030501000007--

