Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbRE1SmM>; Mon, 28 May 2001 14:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbRE1SmC>; Mon, 28 May 2001 14:42:02 -0400
Received: from [209.10.41.242] ([209.10.41.242]:61417 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263117AbRE1Slr>;
	Mon, 28 May 2001 14:41:47 -0400
Date: Mon, 28 May 2001 20:34:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Andre M. Hedrick" <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch]: ide dma timeout retry in pio
Message-ID: <20010528203421.N9102@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We have the current problem of ide dma possibly tossing out a complete
request, when we hit a dma timout. In this case, what we really want to
do is retry the request in pio mode and revert to normal dma operations
later again.

This patch catches the dma timout. It clears the dma engine, turns dma
off, sanity checks the request, and makes sure that the ide request
handler restarts the request (now in pio mode). When the first chunk of
the request is finished, return to dma mode. If the dma timeouts keep
happening, stay in pio mode.

Patch is untested for obvious reason, against 2.4.5-ac3

-- 
Jens Axboe


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-dma-timeout-1

--- ../linux-2.4.5-ac3-clean/drivers/ide/ide.c	Mon May 28 20:28:05 2001
+++ drivers/ide/ide.c	Mon May 28 20:21:48 2001
@@ -543,10 +543,20 @@
 {
 	struct request *rq;
 	unsigned long flags;
+	ide_drive_t *drive = hwgroup->drive;
 
 	spin_lock_irqsave(&io_request_lock, flags);
 	rq = hwgroup->rq;
 
+	/*
+	 * decide whether to reenable DMA -- 3 is a random magic for now,
+	 * if we DMA timeout more than 3 times, just stay in PIO
+	 */
+	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
+		drive->state = 0;
+		hwgroup->hwif->dmaproc(ide_dma_on, drive);
+	}
+
 	if (!end_that_request_first(rq, uptodate, hwgroup->drive->name)) {
 		add_blkdev_randomness(MAJOR(rq->rq_dev));
 		blkdev_dequeue_request(rq);
@@ -1419,6 +1429,49 @@
 }
 
 /*
+ * un-busy the hwgroup etc, and clear any pending DMA status. we want to
+ * retry the current request in pio mode instead of risking tossing it
+ * all away
+ */
+void ide_dma_timeout_retry(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct request *rq;
+
+	/*
+	 * end current dma transaction
+	 */
+	(void) hwif->dmaproc(ide_dma_end, drive);
+
+	/*
+	 * complain a little, later we might remove some of this verbosity
+	 */
+	printk("%s: timeout waiting for DMA\n", drive->name);
+	(void) hwif->dmaproc(ide_dma_timeout, drive);
+
+	/*
+	 * disable dma for now, but remember that we did so because of
+	 * a timeout -- we'll reenable after we finish this next request
+	 * (or rather the first chunk of it) in pio.
+	 */
+	drive->retry_pio++;
+	drive->state = DMA_PIO_RETRY;
+	(void) hwif->dmaproc(ide_dma_off_quietly, drive);
+
+	/*
+	 * un-busy drive etc (hwgroup->busy is cleared on return) and
+	 * make sure request is sane
+	 */
+	rq = HWGROUP(drive)->rq;
+	HWGROUP(drive)->rq = NULL;
+
+	rq->errors = 0;
+	rq->sector = rq->bh->b_rsector;
+	rq->current_nr_sectors = rq->bh->b_size >> 9;
+	rq->buffer = rq->bh->b_data;
+}
+
+/*
  * ide_timer_expiry() is our timeout function for all drive operations.
  * But note that it can also be invoked as a result of a "sleep" operation
  * triggered by the mod_timer() call in ide_do_request.
@@ -1491,11 +1544,10 @@
 				startstop = handler(drive);
 			} else {
 				if (drive->waiting_for_dma) {
-					(void) hwgroup->hwif->dmaproc(ide_dma_end, drive);
-					printk("%s: timeout waiting for DMA\n", drive->name);
-					(void) hwgroup->hwif->dmaproc(ide_dma_timeout, drive);
-				}
-				startstop = ide_error(drive, "irq timeout", GET_STAT());
+					startstop = ide_stopped;
+					ide_dma_timeout_retry(drive);
+				} else
+					startstop = ide_error(drive, "irq timeout", GET_STAT());
 			}
 			set_recovery_timer(hwif);
 			drive->service_time = jiffies - drive->service_start;
--- ../linux-2.4.5-ac3-clean/include/linux/ide.h	Mon May 28 20:28:13 2001
+++ include/linux/ide.h	Mon May 28 20:21:18 2001
@@ -87,6 +87,11 @@
 #define ERROR_RECAL	1	/* Recalibrate every 2nd retry */
 
 /*
+ * state flags
+ */
+#define DMA_PIO_RETRY	1	/* retrying in PIO */
+
+/*
  * Ensure that various configuration flags have compatible settings
  */
 #ifdef REALLY_SLOW_IO
@@ -299,6 +304,8 @@
 	special_t	special;	/* special action flags */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
+	byte	 retry_pio;		/* retrying dma capable host in pio */
+	byte	 state;			/* retry state */
 	byte     waiting_for_dma;	/* dma currently in progress */
 	byte     unmask;		/* flag: okay to unmask other irqs */
 	byte     slow;			/* flag: slow data port */

--sm4nu43k4a2Rpi4c--
