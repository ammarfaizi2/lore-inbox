Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSD3QTz>; Tue, 30 Apr 2002 12:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSD3QTy>; Tue, 30 Apr 2002 12:19:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46092 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313026AbSD3QTk>; Tue, 30 Apr 2002 12:19:40 -0400
Message-ID: <3CCEB568.7040201@evision-ventures.com>
Date: Tue, 30 Apr 2002 17:16:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: [PATCH] 2.5.11 IDE 48
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080805050903090105040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805050903090105040204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

So dear Jens, here it comes in it's whole glory.
I hope it will make your life easier.

It's fixing the "performance" degradation partially,
becouse we don't miss that many jiffies in choose_urgent_device()
anymore. However choose_urgent_device has to be fixed for
the off by one error to don't loop for a whole 1/100 second before
submitting the next request.

Tue Apr 30 13:23:13 CEST 2002 ide-clean-48

- Include small declaration bits for Jens. (WIN_NOP fix in esp.)

- Fix ide-pmac to conform to the recent API changes.

- Prepare and improve the handling of the request queue. It sucks now as many
   request as possible. This is improving the performance.

--------------080805050903090105040204
Content-Type: text/plain;
 name="ide-clean-48.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-48.diff"

diff -urN linux-2.5.11/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.11/drivers/ide/ide.c	2002-04-30 18:05:44.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-04-30 17:52:45.000000000 +0200
@@ -1190,12 +1190,49 @@
 	drive->PADAM_sleep = timeout + jiffies;
 }
 
+
+/*
+ * Determine the longes sleep time for the devices in our hwgroup.
+ */
+static unsigned long longest_sleep(struct ata_channel *channel)
+{
+	unsigned long sleep = 0;
+	int i;
+
+	for (i = 0; i < MAX_HWIFS; ++i) {
+		int unit;
+		struct ata_channel *ch = &ide_hwifs[i];
+
+		if (!ch->present)
+			continue;
+
+		if (ch->hwgroup != channel->hwgroup)
+			continue;
+
+		for (unit = 0; unit < MAX_DRIVES; ++unit) {
+			struct ata_device *drive = &ch->drives[unit];
+
+			if (!drive->present)
+				continue;
+
+			/* This device is sleeping and waiting to be serviced
+			 * later than any other device we checked thus far.
+			 */
+			if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
+				sleep = drive->PADAM_sleep;
+		}
+	}
+
+	return sleep;
+}
+
 /*
  * Select the next device which will be serviced.
  */
 static struct ata_device *choose_urgent_device(struct ata_channel *channel)
 {
-	struct ata_device *best = NULL;
+	struct ata_device *choice = NULL;
+	unsigned long sleep = 0;
 	int i;
 
 	for (i = 0; i < MAX_HWIFS; ++i) {
@@ -1227,54 +1264,152 @@
 			/* Take this device, if there is no device choosen thus far or
 			 * it's more urgent.
 			 */
-			if (!best || (drive->PADAM_sleep && (!best->PADAM_sleep || time_after(best->PADAM_sleep, drive->PADAM_sleep))))
+			if (!choice || (drive->PADAM_sleep && (!choice->PADAM_sleep || time_after(choice->PADAM_sleep, drive->PADAM_sleep))))
 			{
 				if (!blk_queue_plugged(&drive->queue))
-					best = drive;
+					choice = drive;
 			}
 		}
 	}
 
-	return best;
+	if (choice)
+		return choice;
+
+	channel->hwgroup->rq = NULL;
+	sleep = longest_sleep(channel);
+
+	if (sleep) {
+
+		/*
+		 * Take a short snooze, and then wake up again.  Just in case
+		 * there are big differences in relative throughputs.. don't
+		 * want to hog the cpu too much.
+		 */
+
+		if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
+		    sleep = jiffies + WAIT_MIN_SLEEP;
+#if 1
+		if (timer_pending(&channel->hwgroup->timer))
+			printk(KERN_ERR "ide_set_handler: timer already active\n");
+#endif
+		set_bit(IDE_SLEEP, &channel->hwgroup->flags);
+		mod_timer(&channel->hwgroup->timer, sleep);
+		/* we purposely leave hwgroup busy while sleeping */
+	} else {
+		/* Ugly, but how can we sleep for the lock otherwise? perhaps
+		 * from tq_disk? */
+		ide_release_lock(&irq_lock);/* for atari only */
+		clear_bit(IDE_BUSY, &channel->hwgroup->flags);
+	}
+
+	return NULL;
 }
 
+
+/* Place holders for later expansion of functionality.
+ */
+#define ata_pending_commands(drive)	(0)
+#define ata_can_queue(drive)		(1)
+
 /*
- * Determine the longes sleep time for the devices in our hwgroup.
+ * Feed commands to a drive until it barfs.  Called with ide_lock/DRIVE_LOCK
+ * held and busy channel.
  */
-static unsigned long longest_sleep(struct ata_channel *channel)
+
+static void queue_commands(struct ata_device *drive, int masked_irq)
 {
-	unsigned long sleep = 0;
-	int i;
+	ide_hwgroup_t *hwgroup = drive->channel->hwgroup;
+	ide_startstop_t startstop = -1;
 
-	for (i = 0; i < MAX_HWIFS; ++i) {
-		int unit;
-		struct ata_channel *ch = &ide_hwifs[i];
+	for (;;) {
+		struct request *rq = NULL;
 
-		if (!ch->present)
-			continue;
+		if (!test_bit(IDE_BUSY, &hwgroup->flags))
+			printk(KERN_ERR"%s: hwgroup not busy while queueing\n", drive->name);
 
-		if (ch->hwgroup != channel->hwgroup)
-			continue;
+		/* Abort early if we can't queue another command. for non
+		 * tcq, ata_can_queue is always 1 since we never get here
+		 * unless the drive is idle.
+		 */
+		if (!ata_can_queue(drive)) {
+			if (!ata_pending_commands(drive))
+				clear_bit(IDE_BUSY, &hwgroup->flags);
+			break;
+		}
 
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			struct ata_device *drive = &ch->drives[unit];
+		drive->PADAM_sleep = 0;
 
-			if (!drive->present)
-				continue;
+		if (test_bit(IDE_DMA, &hwgroup->flags)) {
+			printk("ide_do_request: DMA in progress...\n");
+			break;
+		}
 
-			/* This device is sleeping and waiting to be serviced
-			 * later than any other device we checked thus far.
-			 */
-			if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
-				sleep = drive->PADAM_sleep;
+		/* There's a small window between where the queue could be
+		 * replugged while we are in here when using tcq (in which
+		 * case the queue is probably empty anyways...), so check
+		 * and leave if appropriate. When not using tcq, this is
+		 * still a severe BUG!
+		 */
+		if (blk_queue_plugged(&drive->queue)) {
+			BUG();
+			break;
 		}
-	}
 
-	return sleep;
+		if (!(rq = elv_next_request(&drive->queue))) {
+			if (!ata_pending_commands(drive))
+				clear_bit(IDE_BUSY, &hwgroup->flags);
+			hwgroup->rq = NULL;
+			break;
+		}
+
+		/* If there are queued commands, we can't start a non-fs
+		 * request (really, a non-queuable command) until the
+		 * queue is empty.
+		 */
+		if (!(rq->flags & REQ_CMD) && ata_pending_commands(drive))
+			break;
+
+		hwgroup->rq = rq;
+
+		/* Some systems have trouble with IDE IRQs arriving while the
+		 * driver is still setting things up.  So, here we disable the
+		 * IRQ used by this interface while the request is being
+		 * started.  This may look bad at first, but pretty much the
+		 * same thing happens anyway when any interrupt comes in, IDE
+		 * or otherwise -- the kernel masks the IRQ while it is being
+		 * handled.
+		 */
+
+		if (masked_irq && drive->channel->irq != masked_irq)
+			disable_irq_nosync(drive->channel->irq);
+
+		spin_unlock(&ide_lock);
+		ide__sti();	/* allow other IRQs while we start this request */
+		startstop = start_request(drive, rq);
+
+		spin_lock_irq(&ide_lock);
+		if (masked_irq && drive->channel->irq != masked_irq)
+			enable_irq(drive->channel->irq);
+
+		/* command started, we are busy */
+		if (startstop == ide_started)
+			break;
+
+		/* start_request() can return either ide_stopped (no command
+		 * was started), ide_started (command started, don't queue
+		 * more), or ide_released (command started, try and queue
+		 * more).
+		 */
+#if 0
+		if (startstop == ide_stopped)
+			set_bit(IDE_BUSY, &hwgroup->flags);
+#endif
+
+	}
 }
 
 /*
- * Issue a new request to a drive from hwgroup.
+ * Issue a new request.
  * Caller must have already done spin_lock_irqsave(&ide_lock, ...)
  *
  * A hwgroup is a serialized group of IDE interfaces.  Usually there is
@@ -1312,42 +1447,14 @@
 
 	while (!test_and_set_bit(IDE_BUSY, &hwgroup->flags)) {
 		struct ata_channel *ch;
-		ide_startstop_t	startstop;
-		struct ata_device *drive = choose_urgent_device(channel);
-
-		if (drive == NULL) {
-			unsigned long sleep = 0;
+		struct ata_device *drive;
 
-			hwgroup->rq = NULL;
-			sleep = longest_sleep(channel);
-
-			if (sleep) {
-
-				/*
-				 * Take a short snooze, and then wake up again.
-				 * Just in case there are big differences in
-				 * relative throughputs.. don't want to hog the
-				 * cpu too much.
-				 */
+		/* this will clear IDE_BUSY, if appropriate */
+		drive = choose_urgent_device(channel);
 
-				if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
-					sleep = jiffies + WAIT_MIN_SLEEP;
-#if 1
-				if (timer_pending(&hwgroup->timer))
-					printk("ide_set_handler: timer already active\n");
-#endif
-				set_bit(IDE_SLEEP, &hwgroup->flags);
-				mod_timer(&hwgroup->timer, sleep);
-				/* we purposely leave hwgroup busy while sleeping */
-			} else {
-				/* Ugly, but how can we sleep for the lock
-				 * otherwise? perhaps from tq_disk? */
-				ide_release_lock(&irq_lock);/* for atari only */
-				clear_bit(IDE_BUSY, &hwgroup->flags);
-			}
+		if (!drive)
+			break;
 
-			return;
-		}
 		ch = drive->channel;
 
 		if (hwgroup->XXX_drive->channel->sharing_irq && ch != hwgroup->XXX_drive->channel && ch->io_ports[IDE_CONTROL_OFFSET]) {
@@ -1364,51 +1471,10 @@
 		 */
 		hwgroup->XXX_drive = drive;
 
-		/* Reset wait timeout.
-		 */
-		drive->PADAM_sleep = 0;
-
-		if (blk_queue_plugged(&drive->queue))
-			BUG();
-
-		/* Just continuing an interrupted request maybe.
-		 */
-		hwgroup->rq = elv_next_request(&drive->queue);
-
-		/*
-		 * Some systems have trouble with IDE IRQs arriving while the
-		 * driver is still setting things up.  So, here we disable the
-		 * IRQ used by this interface while the request is being
-		 * started.  This may look bad at first, but pretty much the
-		 * same thing happens anyway when any interrupt comes in, IDE
-		 * or otherwise -- the kernel masks the IRQ while it is being
-		 * handled.
-		 */
-
-		if (masked_irq && ch->irq != masked_irq)
-			disable_irq_nosync(ch->irq);
-		spin_unlock(&ide_lock);
-		ide__sti();	/* allow other IRQs while we start this request */
-		startstop = start_request(drive, hwgroup->rq);
-		spin_lock_irq(&ide_lock);
-		if (masked_irq && ch->irq != masked_irq)
-			enable_irq(ch->irq);
-		if (startstop == ide_stopped)
-			clear_bit(IDE_BUSY, &hwgroup->flags);
+		queue_commands(drive, masked_irq);
 	}
 }
 
-/*
- * Returns the queue which corresponds to a given device.
- */
-request_queue_t *ide_get_queue(kdev_t dev)
-{
-	struct ata_channel *ch = (struct ata_channel *)blk_dev[major(dev)].data;
-
-	/* FIXME: ALLERT: This discriminates between master and slave! */
-	return &ch->drives[DEVICE_NR(dev) & 1].queue;
-}
-
 void do_ide_request(request_queue_t *q)
 {
 	ide_do_request(q->queuedata, 0);
@@ -1419,20 +1485,20 @@
  * retry the current request in PIO mode instead of risking tossing it
  * all away
  */
-static void dma_timeout_retry(ide_drive_t *drive, struct request *rq)
+static void dma_timeout_retry(struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 
 	/*
 	 * end current dma transaction
 	 */
-	hwif->udma(ide_dma_end, drive, rq);
+	ch->udma(ide_dma_end, drive, rq);
 
 	/*
 	 * complain a little, later we might remove some of this verbosity
 	 */
 	printk("%s: timeout waiting for DMA\n", drive->name);
-	hwif->udma(ide_dma_timeout, drive, rq);
+	ch->udma(ide_dma_timeout, drive, rq);
 
 	/*
 	 * Disable dma for now, but remember that we did so because of
@@ -1441,7 +1507,7 @@
 	 */
 	drive->retry_pio++;
 	drive->state = DMA_PIO_RETRY;
-	hwif->udma(ide_dma_off_quietly, drive, rq);
+	ch->udma(ide_dma_off_quietly, drive, rq);
 
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
@@ -1713,11 +1779,11 @@
 	int h;
 
 	for (h = 0; h < MAX_HWIFS; ++h) {
-		struct ata_channel *hwif = &ide_hwifs[h];
-		if (hwif->present && major == hwif->major) {
+		struct ata_channel *ch = &ide_hwifs[h];
+		if (ch->present && major == ch->major) {
 			int unit = DEVICE_NR(i_rdev);
 			if (unit < MAX_DRIVES) {
-				struct ata_device *drive = &hwif->drives[unit];
+				struct ata_device *drive = &ch->drives[unit];
 				if (drive->present)
 					return drive;
 			}
@@ -2029,7 +2095,7 @@
 	int unit, i;
 	unsigned long flags;
 	unsigned int p, minor;
-	struct ata_channel old_hwif;
+	struct ata_channel old;
 	int n = 0;
 
 	spin_lock_irqsave(&ide_lock, flags);
@@ -2156,40 +2222,41 @@
 	 * it.
 	 */
 
-	old_hwif = *ch;
+	old = *ch;
 	init_hwif_data(ch, ch->index);
-	ch->hwgroup = old_hwif.hwgroup;
-	ch->tuneproc = old_hwif.tuneproc;
-	ch->speedproc = old_hwif.speedproc;
-	ch->selectproc = old_hwif.selectproc;
-	ch->resetproc = old_hwif.resetproc;
-	ch->intrproc = old_hwif.intrproc;
-	ch->maskproc = old_hwif.maskproc;
-	ch->quirkproc = old_hwif.quirkproc;
-	ch->rwproc	= old_hwif.rwproc;
-	ch->ata_read = old_hwif.ata_read;
-	ch->ata_write = old_hwif.ata_write;
-	ch->atapi_read = old_hwif.atapi_read;
-	ch->atapi_write = old_hwif.atapi_write;
-	ch->udma = old_hwif.udma;
-	ch->busproc = old_hwif.busproc;
-	ch->bus_state = old_hwif.bus_state;
-	ch->dma_base = old_hwif.dma_base;
-	ch->dma_extra = old_hwif.dma_extra;
-	ch->config_data = old_hwif.config_data;
-	ch->select_data = old_hwif.select_data;
-	ch->proc = old_hwif.proc;
+	ch->hwgroup = old.hwgroup;
+	ch->tuneproc = old.tuneproc;
+	ch->speedproc = old.speedproc;
+	ch->selectproc = old.selectproc;
+	ch->resetproc = old.resetproc;
+	ch->intrproc = old.intrproc;
+	ch->maskproc = old.maskproc;
+	ch->quirkproc = old.quirkproc;
+	ch->rwproc	= old.rwproc;
+	ch->ata_read = old.ata_read;
+	ch->ata_write = old.ata_write;
+	ch->atapi_read = old.atapi_read;
+	ch->atapi_write = old.atapi_write;
+	ch->udma = old.udma;
+	ch->busproc = old.busproc;
+	ch->bus_state = old.bus_state;
+	ch->dma_base = old.dma_base;
+	ch->dma_extra = old.dma_extra;
+	ch->config_data = old.config_data;
+	ch->select_data = old.select_data;
+	ch->proc = old.proc;
+	/* FIXME: most propably this is always right:! */
 #ifndef CONFIG_BLK_DEV_IDECS
-	ch->irq = old_hwif.irq;
+	ch->irq = old.irq;
 #endif
-	ch->major = old_hwif.major;
-	ch->chipset = old_hwif.chipset;
-	ch->autodma = old_hwif.autodma;
-	ch->udma_four = old_hwif.udma_four;
+	ch->major = old.major;
+	ch->chipset = old.chipset;
+	ch->autodma = old.autodma;
+	ch->udma_four = old.udma_four;
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	ch->pci_dev = old_hwif.pci_dev;
+	ch->pci_dev = old.pci_dev;
 #endif
-	ch->straight8 = old_hwif.straight8;
+	ch->straight8 = old.straight8;
 
 abort:
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -3352,7 +3419,6 @@
 EXPORT_SYMBOL(ide_lock);
 EXPORT_SYMBOL(drive_is_flashcard);
 EXPORT_SYMBOL(ide_timer_expiry);
-EXPORT_SYMBOL(ide_get_queue);
 EXPORT_SYMBOL(ide_add_generic_settings);
 EXPORT_SYMBOL(do_ide_request);
 /*
diff -urN linux-2.5.11/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.11/drivers/ide/ide-pmac.c	2002-04-30 18:05:41.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-04-30 14:32:06.000000000 +0200
@@ -27,6 +27,7 @@
  *    symbols or by storing hooks at arch level).
  *
  */
+
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -77,8 +78,8 @@
 	struct scatterlist*		sg_table;
 	int				sg_nents;
 	int				sg_dma_direction;
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
-	
+#endif
+
 } pmac_ide[MAX_HWIFS] __pmacdata;
 
 static int pmac_ide_count;
@@ -255,11 +256,11 @@
 #define IDE_WAKEUP_DELAY_MS	2000
 
 static void pmac_ide_setup_dma(struct device_node *np, int ix);
-static int pmac_ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive);
-static int pmac_ide_build_dmatable(ide_drive_t *drive, int ix, int wr);
-static int pmac_ide_tune_chipset(ide_drive_t *drive, byte speed);
-static void pmac_ide_tuneproc(ide_drive_t *drive, byte pio);
-static void pmac_ide_selectproc(ide_drive_t *drive);
+static int pmac_ide_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq);
+static int pmac_ide_build_dmatable(struct ata_device *drive, struct request *rq, int ix, int wr);
+static int pmac_ide_tune_chipset(struct ata_device *drive, byte speed);
+static void pmac_ide_tuneproc(struct ata_device *drive, byte pio);
+static void pmac_ide_selectproc(struct ata_device *drive);
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
@@ -322,7 +323,7 @@
 	ide_hwifs[ix].selectproc = pmac_ide_selectproc;
 	ide_hwifs[ix].speedproc = &pmac_ide_tune_chipset;
 	if (pmac_ide[ix].dma_regs && pmac_ide[ix].dma_table_cpu) {
-		ide_hwifs[ix].dmaproc = &pmac_ide_dmaproc;
+		ide_hwifs[ix].udma = pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 		if (!noautodma)
 			ide_hwifs[ix].autodma = 1;
@@ -405,7 +406,7 @@
 {
 	int result = 1;
 	unsigned long flags;
-	struct ata_channel *hwif = HWIF(drive);
+	struct ata_channel *hwif = drive->channel;
 	
 	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
@@ -431,7 +432,7 @@
 	if (result)
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready after SET_FEATURE !\n");
 out:
-	SELECT_MASK(HWIF(drive), drive, 0);
+	SELECT_MASK(drive->channel, drive, 0);
 	if (result == 0) {
 		drive->id->dma_ultra &= ~0xFF00;
 		drive->id->dma_mword &= ~0x0F00;
@@ -1024,7 +1025,7 @@
 				    	pmif->dma_table_cpu, pmif->dma_table_dma);
 		return;
 	}
-	ide_hwifs[ix].dmaproc = &pmac_ide_dmaproc;
+	ide_hwifs[ix].udma = pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
 		ide_hwifs[ix].autodma = 1;
@@ -1092,11 +1093,10 @@
  * for a transfer and sets the DBDMA channel to point to it.
  */
 static int
-pmac_ide_build_dmatable(ide_drive_t *drive, int ix, int wr)
+pmac_ide_build_dmatable(struct ata_device *drive, struct request *rq, int ix, int wr)
 {
 	struct dbdma_cmd *table;
 	int i, count = 0;
-	struct request *rq = HWGROUP(drive)->rq;
 	volatile struct dbdma_regs *dma = pmac_ide[ix].dma_regs;
 	struct scatterlist *sg;
 
@@ -1166,7 +1166,7 @@
 static void
 pmac_ide_destroy_dmatable (ide_drive_t *drive, int ix)
 {
-	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	struct pci_dev *dev = drive->channel->pci_dev;
 	struct scatterlist *sg = pmac_ide[ix].sg_table;
 	int nents = pmac_ide[ix].sg_nents;
 
@@ -1326,17 +1326,17 @@
 {
 	dma64_addr_t addr = BLK_BOUNCE_HIGH;
 
-	if (on && drive->type == ATA_DISK && HWIF(drive)->highmem) {
+	if (on && drive->type == ATA_DISK && drive->channel->highmem) {
 		if (!PCI_DMA_BUS_IS_PHYS)
 			addr = BLK_BOUNCE_ANY;
 		else
-			addr = HWIF(drive)->pci_dev->dma_mask;
+			addr = drive->channel->pci_dev->dma_mask;
 	}
 
 	blk_queue_bounce_limit(&drive->queue, addr);
 }
 
-int pmac_ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+static int pmac_ide_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	int ix, dstat, reading, ata4;
 	volatile struct dbdma_regs *dma;
@@ -1369,10 +1369,10 @@
 	case ide_dma_write:
 		/* this almost certainly isn't needed since we don't
 		   appear to have a rwproc */
-		if (HWIF(drive)->rwproc)
-			HWIF(drive)->rwproc(drive, func);
+		if (drive->channel->rwproc)
+			drive->channel->rwproc(drive, func);
 		reading = (func == ide_dma_read);
-		if (!pmac_ide_build_dmatable(drive, ix, !reading))
+		if (!pmac_ide_build_dmatable(drive, rq, ix, !reading))
 			return 1;
 		/* Apple adds 60ns to wrDataSetup on reads */
 		if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
@@ -1385,9 +1385,9 @@
 		if (drive->type != ATA_DISK)
 			return 0;
 		ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
-		if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_ACB) &&
+		if ((rq->flags & REQ_DRIVE_ACB) &&
 		    (drive->addressing == 1)) {
-			struct ata_taskfile *args = HWGROUP(drive)->rq->special;
+			struct ata_taskfile *args = rq->special;
 			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 		} else if (drive->addressing) {
 			OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
diff -urN linux-2.5.11/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.11/drivers/ide/ide-probe.c	2002-04-30 18:05:44.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-04-30 17:55:04.000000000 +0200
@@ -829,6 +829,20 @@
 	return;
 }
 
+/*
+ * Returns the queue which corresponds to a given device.
+ *
+ * FIXME: this should take struct block_device * as argument in future.
+ */
+
+static request_queue_t *ata_get_queue(kdev_t dev)
+{
+	struct ata_channel *ch = (struct ata_channel *)blk_dev[major(dev)].data;
+
+	/* FIXME: ALLERT: This discriminates between master and slave! */
+	return &ch->drives[DEVICE_NR(dev) & 1].queue;
+}
+
 static void channel_init(struct ata_channel *ch)
 {
 	if (!ch->present)
@@ -882,7 +896,7 @@
 
 	init_gendisk(ch);
 	blk_dev[ch->major].data = ch;
-	blk_dev[ch->major].queue = ide_get_queue;
+	blk_dev[ch->major].queue = ata_get_queue;
 
 	/* all went well, flag this channel entry as valid */
 	ch->present = 1;
diff -urN linux-2.5.11/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.11/drivers/ide/ide-taskfile.c	2002-04-30 18:05:41.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-04-30 16:36:59.000000000 +0200
@@ -522,9 +522,12 @@
 
 	ide__sti();	/* local CPU only */
 
-	if (!OK_STAT(stat = GET_STAT(), READY_STAT, BAD_STAT))
-		return ide_error(drive, "task_no_data_intr", stat);
-		/* calls ide_end_drive_cmd */
+	if (!OK_STAT(stat = GET_STAT(), READY_STAT, BAD_STAT)) {
+		/* Keep quite for NOP becouse they are expected to fail. */
+		if (args && args->taskfile.command != WIN_NOP)
+			return ide_error(drive, "task_no_data_intr", stat);
+	}
+
 	if (args)
 		ide_end_drive_cmd (drive, stat, GET_ERR());
 
@@ -854,6 +857,7 @@
 			return;
 
 		case WIN_NOP:
+			args->handler = task_no_data_intr;
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
diff -urN linux-2.5.11/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.11/include/linux/hdreg.h	2002-04-29 05:12:40.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-04-30 13:23:57.000000000 +0200
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
+ * sector count bits
+ */
+#define NSEC_CD			0x01
+#define NSEC_IO			0x02
+#define NSEC_REL		0x04
+
+/*
  * Command Header sizes for IOCTL commands
  */
 

--------------080805050903090105040204--

