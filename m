Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVIGGd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVIGGd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVIGGd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 02:33:59 -0400
Received: from serv01.siteground.net ([70.85.91.68]:648 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750944AbVIGGd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 02:33:57 -0400
Date: Tue, 6 Sep 2005 23:33:56 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 2/4] ide: Break ide_lock -- replace ide_lock with hwgroup->lock in core ide
Message-ID: <20050907063356.GA4000@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050906234028.GC3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906234028.GC3642@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 04:40:28PM -0700, Ravikiran G Thirumalai wrote:
> Patch to convert ide core code to use hwgroup lock instead of a global
> ide_lock.
>  
> Index: linux-2.6.13/drivers/ide/ide-io.c
> ===================================================================
> --- linux-2.6.13.orig/drivers/ide/ide-io.c	2005-09-06 11:22:29.000000000 -0700
> @@ -1211,11 +1214,11 @@
>  		 */
>  		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
>  			disable_irq_nosync(hwif->irq);
> -		spin_unlock(&ide_lock);
> +		spin_unlock(&hwgroup->lock);
>  		local_irq_enable();
>  			/* allow other IRQs while we start this request */
>  		startstop = start_request(drive, rq);
> -		spin_lock_irq(&ide_lock);
> +		spin_unlock_irq(&hwgroup->lock);
		^^^^^^^^^^^^^^^^^^^^^^^

My bad,
Fixed patch attached.

Thanks,
Kiran


Patch to convert ide core code to use hwgroup lock instead of a global
ide_lock.

Signed-off-by: Vaibhav V. Nivargi <vaibhav.nivargi@gmail.com>
Signed-off-by: Alok N. Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.13/drivers/ide/ide-cd.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-cd.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-cd.c	2005-09-06 15:16:15.000000000 -0700
@@ -590,7 +590,8 @@
 
 static void cdrom_end_request (ide_drive_t *drive, int uptodate)
 {
-	struct request *rq = HWGROUP(drive)->rq;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct request *rq = hwgroup->rq;
 	int nsectors = rq->hard_cur_sectors;
 
 	if ((rq->flags & REQ_SENSE) && uptodate) {
@@ -612,10 +613,10 @@
 			/*
 			 * now end failed request
 			 */
-			spin_lock_irqsave(&ide_lock, flags);
+			spin_lock_irqsave(&hwgroup->lock, flags);
 			end_that_request_chunk(failed, 0, failed->data_len);
 			end_that_request_last(failed);
-			spin_unlock_irqrestore(&ide_lock, flags);
+			spin_unlock_irqrestore(&hwgroup->lock, flags);
 		}
 
 		cdrom_analyze_sense_data(drive, failed, sense);
@@ -636,7 +637,8 @@
    Returns 1 if the request was ended. */
 static int cdrom_decode_status(ide_drive_t *drive, int good_stat, int *stat_ret)
 {
-	struct request *rq = HWGROUP(drive)->rq;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct request *rq = hwgroup->rq;
 	int stat, err, sense_key;
 	
 	/* Check for errors. */
@@ -698,10 +700,10 @@
 		 * request sense has completed
 		 */
 		if (stat & ERR_STAT) {
-			spin_lock_irqsave(&ide_lock, flags);
+			spin_lock_irqsave(&hwgroup->lock, flags);
 			blkdev_dequeue_request(rq);
 			HWGROUP(drive)->rq = NULL;
-			spin_unlock_irqrestore(&ide_lock, flags);
+			spin_unlock_irqrestore(&hwgroup->lock, flags);
 
 			cdrom_queue_request_sense(drive, rq->sense, rq);
 		} else
@@ -741,9 +743,9 @@
 					 * take a breather relying on the
 					 * unplug timer to kick us again
 					 */
-					spin_lock_irqsave(&ide_lock, flags);
+					spin_lock_irqsave(&hwgroup->lock, flags);
 					blk_plug_device(drive->queue);
-					spin_unlock_irqrestore(&ide_lock,flags);
+					spin_unlock_irqrestore(&hwgroup->lock, flags);
 					return 1;
 				}
 			}
@@ -839,6 +841,7 @@
 	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
+	ide_hwgroup_t *hwgroup = hwif->hwgroup;
 
 	/* Wait for the controller to be idle. */
 	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
@@ -866,10 +869,10 @@
 		unsigned long flags;
 
 		/* packet command */
-		spin_lock_irqsave(&ide_lock, flags);
+		spin_lock_irqsave(&hwgroup->lock, flags);
 		hwif->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
 		ndelay(400);
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 
 		return (*handler) (drive);
 	}
@@ -1609,7 +1612,8 @@
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct request *rq = HWGROUP(drive)->rq;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct request *rq = hwgroup->rq;
 	int dma_error, dma, stat, ireason, len, thislen;
 	u8 lowcyl, highcyl;
 	xfer_func_t *xferfunc;
@@ -1737,11 +1741,11 @@
 	if (!rq->data_len)
 		post_transform_command(rq);
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	blkdev_dequeue_request(rq);
 	end_that_request_last(rq);
 	HWGROUP(drive)->rq = NULL;
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 	return ide_stopped;
 }
 
Index: linux-2.6.13/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-disk.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-disk.c	2005-09-06 15:16:15.000000000 -0700
@@ -786,11 +786,12 @@
 
 static int set_nowerr(ide_drive_t *drive, int arg)
 {
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	if (ide_spin_wait_hwgroup(drive))
 		return -EBUSY;
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(&hwgroup->lock);
 	return 0;
 }
 
Index: linux-2.6.13/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-io.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-io.c	2005-09-06 22:35:09.000000000 -0700
@@ -112,9 +112,10 @@
 	struct request *rq;
 	unsigned long flags;
 	int ret = 1;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
-	spin_lock_irqsave(&ide_lock, flags);
-	rq = HWGROUP(drive)->rq;
+	spin_lock_irqsave(&hwgroup->lock, flags);
+	rq = hwgroup->rq;
 
 	if (!nr_sectors)
 		nr_sectors = rq->hard_cur_sectors;
@@ -124,7 +125,7 @@
 	else
 		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ide_end_request);
@@ -233,12 +234,13 @@
 static void ide_complete_pm_request (ide_drive_t *drive, struct request *rq)
 {
 	unsigned long flags;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
 #ifdef DEBUG_PM
 	printk("%s: completing PM request, %s\n", drive->name,
 	       blk_pm_suspend_request(rq) ? "suspend" : "resume");
 #endif
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	if (blk_pm_suspend_request(rq)) {
 		blk_stop_queue(drive->queue);
 	} else {
@@ -248,7 +250,7 @@
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 /*
@@ -305,10 +307,11 @@
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
-	spin_lock_irqsave(&ide_lock, flags);
-	rq = HWGROUP(drive)->rq;
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
+	rq = hwgroup->rq;
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 
 	if (rq->flags & REQ_DRIVE_CMD) {
 		u8 *args = (u8 *) rq->buffer;
@@ -375,12 +378,12 @@
 		return;
 	}
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	blkdev_dequeue_request(rq);
-	HWGROUP(drive)->rq = NULL;
+	hwgroup->rq = NULL;
 	rq->errors = err;
 	end_that_request_last(rq);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 EXPORT_SYMBOL(ide_end_drive_cmd);
@@ -1062,7 +1065,7 @@
 
 /*
  * Issue a new request to a drive from hwgroup
- * Caller must have already done spin_lock_irqsave(&ide_lock, ..);
+ * Caller must have already done spin_lock_irqsave(&hwgroup->lock, ..);
  *
  * A hwgroup is a serialized group of IDE interfaces.  Usually there is
  * exactly one hwif (interface) per hwgroup, but buggy controllers (eg. CMD640)
@@ -1074,7 +1077,7 @@
  * possibly along with many other devices.  This is especially common in
  * PCI-based systems with off-board IDE controller cards.
  *
- * The IDE driver uses the single global ide_lock spinlock to protect
+ * The IDE driver uses a per-hwgroup spinlock to protect
  * access to the request queues, and to protect the hwgroup->busy flag.
  *
  * The first thread into the driver for a particular hwgroup sets the
@@ -1090,7 +1093,7 @@
  * will start the next request from the queue.  If no more work remains,
  * the driver will clear the hwgroup->busy flag and exit.
  *
- * The ide_lock (spinlock) is used to protect all access to the
+ * The per-hwgroup spinlock(hwgroup->lock) is used to protect all access to the
  * hwgroup->busy flag, but is otherwise not needed for most processing in
  * the driver.  This makes the driver much more friendlier to shared IRQs
  * than previous designs, while remaining 100% (?) SMP safe and capable.
@@ -1105,7 +1108,7 @@
 	/* for atari only: POSSIBLY BROKEN HERE(?) */
 	ide_get_lock(ide_intr, hwgroup);
 
-	/* caller must own ide_lock */
+	/* caller must own hwgroup->lock */
 	BUG_ON(!irqs_disabled());
 
 	while (!hwgroup->busy) {
@@ -1211,11 +1214,11 @@
 		 */
 		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
-		spin_unlock(&ide_lock);
+		spin_unlock(&hwgroup->lock);
 		local_irq_enable();
 			/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
-		spin_lock_irq(&ide_lock);
+		spin_lock_irq(&hwgroup->lock);
 		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
 		if (startstop == ide_stopped)
@@ -1309,7 +1312,7 @@
 	unsigned long	flags;
 	unsigned long	wait = -1;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 
 	if ((handler = hwgroup->handler) == NULL) {
 		/*
@@ -1340,7 +1343,7 @@
 					/* reset timer */
 					hwgroup->timer.expires  = jiffies + wait;
 					add_timer(&hwgroup->timer);
-					spin_unlock_irqrestore(&ide_lock, flags);
+					spin_unlock_irqrestore(&hwgroup->lock, flags);
 					return;
 				}
 			}
@@ -1350,7 +1353,7 @@
 			 * the handler() function, which means we need to
 			 * globally mask the specific IRQ:
 			 */
-			spin_unlock(&ide_lock);
+			spin_unlock(&hwgroup->lock);
 			hwif  = HWIF(drive);
 #if DISABLE_IRQ_NOSYNC
 			disable_irq_nosync(hwif->irq);
@@ -1377,14 +1380,14 @@
 					ide_error(drive, "irq timeout", hwif->INB(IDE_STATUS_REG));
 			}
 			drive->service_time = jiffies - drive->service_start;
-			spin_lock_irq(&ide_lock);
+			spin_lock_irq(&hwgroup->lock);
 			enable_irq(hwif->irq);
 			if (startstop == ide_stopped)
 				hwgroup->busy = 0;
 		}
 	}
 	ide_do_request(hwgroup, IDE_NO_IRQ);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 /**
@@ -1481,11 +1484,11 @@
 	ide_handler_t *handler;
 	ide_startstop_t startstop;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	hwif = hwgroup->hwif;
 
 	if (!ide_ack_intr(hwif)) {
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 		return IRQ_NONE;
 	}
 
@@ -1523,7 +1526,7 @@
 			(void) hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 		}
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 		return IRQ_NONE;
 	}
 	drive = hwgroup->drive;
@@ -1534,7 +1537,7 @@
 		 *
 		 * [Note - this can occur if the drive is hot unplugged]
 		 */
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 		return IRQ_HANDLED;
 	}
 	if (!drive_is_ready(drive)) {
@@ -1545,7 +1548,7 @@
 		 * their status register is up to date.  Hopefully we have
 		 * enough advance overhead that the latter isn't a problem.
 		 */
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 		return IRQ_NONE;
 	}
 	if (!hwgroup->busy) {
@@ -1554,13 +1557,13 @@
 	}
 	hwgroup->handler = NULL;
 	del_timer(&hwgroup->timer);
-	spin_unlock(&ide_lock);
+	spin_unlock(&hwgroup->lock);
 
 	if (drive->unmask)
 		local_irq_enable();
 	/* service this interrupt, may set handler for next interrupt */
 	startstop = handler(drive);
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(&hwgroup->lock);
 
 	/*
 	 * Note that handler() may have set things up for another
@@ -1579,7 +1582,7 @@
 				"on exit\n", drive->name);
 		}
 	}
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -1654,7 +1657,7 @@
 		rq->end_io = blk_end_sync_rq;
 	}
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	if (action == ide_preempt)
 		hwgroup->rq = NULL;
 	if (action == ide_preempt || action == ide_head_wait) {
@@ -1663,7 +1666,7 @@
 	}
 	__elv_add_request(drive->queue, rq, where, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 
 	err = 0;
 	if (must_wait) {
Index: linux-2.6.13/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-iops.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-iops.c	2005-09-06 15:16:15.000000000 -0700
@@ -945,9 +945,10 @@
 		      unsigned int timeout, ide_expiry_t *expiry)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ide_lock, flags);
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	__ide_set_handler(drive, handler, timeout, expiry);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 EXPORT_SYMBOL(ide_set_handler);
@@ -972,7 +973,7 @@
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	ide_hwif_t *hwif = HWIF(drive);
 	
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 	
 	if(hwgroup->handler)
 		BUG();
@@ -988,7 +989,7 @@
 	   devices 
 	*/
 	ndelay(400);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 EXPORT_SYMBOL(ide_execute_command);
@@ -1168,10 +1169,11 @@
 	ide_hwif_t *hwif;
 	ide_hwgroup_t *hwgroup;
 	
-	spin_lock_irqsave(&ide_lock, flags);
 	hwif = HWIF(drive);
 	hwgroup = HWGROUP(drive);
 
+	spin_lock_irqsave(&hwgroup->lock, flags);
+
 	/* We must not reset with running handlers */
 	if(hwgroup->handler != NULL)
 		BUG();
@@ -1186,7 +1188,7 @@
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 		hwgroup->polling = 1;
 		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 		return ide_started;
 	}
 
@@ -1199,7 +1201,7 @@
 
 #if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 		return ide_stopped;
 	}
 
@@ -1239,7 +1241,7 @@
 	
 #endif	/* OK_TO_RESET_CONTROLLER */
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 	return ide_started;
 }
 
Index: linux-2.6.13/drivers/ide/ide-lib.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-lib.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-lib.c	2005-09-06 15:16:15.000000000 -0700
@@ -450,12 +450,11 @@
 	struct request *rq;
 	u8 opcode = 0;
 	int found = 0;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
-	spin_lock(&ide_lock);
-	rq = NULL;
-	if (HWGROUP(drive))
-		rq = HWGROUP(drive)->rq;
-	spin_unlock(&ide_lock);
+	spin_lock(&hwgroup->lock);
+	rq = hwgroup->rq;
+	spin_unlock(&hwgroup->lock);
 	if (!rq)
 		return;
 	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
Index: linux-2.6.13/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-probe.c	2005-09-06 15:12:58.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-probe.c	2005-09-06 15:16:15.000000000 -0700
@@ -985,7 +985,8 @@
 	 *	do not.
 	 */
 
-	q = blk_init_queue_node(do_ide_request, &ide_lock, hwif_to_node(hwif));
+	q = blk_init_queue_node(do_ide_request, &(HWGROUP(drive)->lock), 
+				hwif_to_node(hwif));
 	if (!q)
 		return 1;
 
@@ -1099,10 +1100,10 @@
 		 * linked list, the first entry is the hwif that owns
 		 * hwgroup->handler - do not change that.
 		 */
-		spin_lock_irq(&ide_lock);
+		spin_lock_irq(&hwgroup->lock);
 		hwif->next = hwgroup->hwif->next;
 		hwgroup->hwif->next = hwif;
-		spin_unlock_irq(&ide_lock);
+		spin_unlock_irq(&hwgroup->lock);
 	} else {
 		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
 					hwif_to_node(hwif->drives[0].hwif));
@@ -1112,6 +1113,7 @@
 		hwif->hwgroup = hwgroup;
 
 		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
+		spin_lock_init(&hwgroup->lock);
 		hwgroup->hwif     = hwif->next = hwif;
 		hwgroup->rq       = NULL;
 		hwgroup->handler  = NULL;
@@ -1159,7 +1161,7 @@
 			printk(KERN_ERR "ide: failed to init %s\n",drive->name);
 			continue;
 		}
-		spin_lock_irq(&ide_lock);
+		spin_lock_irq(&hwgroup->lock);
 		if (!hwgroup->drive) {
 			/* first drive for hwgroup. */
 			drive->next = drive;
@@ -1169,7 +1171,7 @@
 			drive->next = hwgroup->drive->next;
 			hwgroup->drive->next = drive;
 		}
-		spin_unlock_irq(&ide_lock);
+		spin_unlock_irq(&hwgroup->lock);
 	}
 
 #if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
@@ -1193,13 +1195,13 @@
 	up(&ide_cfg_sem);
 	return 0;
 out_unlink:
-	spin_lock_irq(&ide_lock);
 	if (hwif->next == hwif) {
 		BUG_ON(match);
 		BUG_ON(hwgroup->hwif != hwif);
 		kfree(hwgroup);
 	} else {
 		ide_hwif_t *g;
+		spin_lock_irq(&hwgroup->lock);
 		g = hwgroup->hwif;
 		while (g->next != hwif)
 			g = g->next;
@@ -1210,8 +1212,8 @@
 			hwgroup->hwif = g;
 		}
 		BUG_ON(hwgroup->hwif == hwif);
+		spin_unlock_irq(&hwgroup->lock);
 	}
-	spin_unlock_irq(&ide_lock);
 out_up:
 	up(&ide_cfg_sem);
 	return 1;
@@ -1316,8 +1318,9 @@
 static void drive_release_dev (struct device *dev)
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(&hwgroup->lock);
 	if (drive->devfs_name[0] != '\0') {
 		devfs_remove(drive->devfs_name);
 		drive->devfs_name[0] = '\0';
@@ -1329,11 +1332,11 @@
 	}
 	drive->present = 0;
 	/* Messed up locking ... */
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(&hwgroup->lock);
 	blk_cleanup_queue(drive->queue);
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(&hwgroup->lock);
 	drive->queue = NULL;
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(&hwgroup->lock);
 
 	up(&drive->gendev_rel_sem);
 }
Index: linux-2.6.13/drivers/ide/ide.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide.c	2005-09-06 15:16:15.000000000 -0700
@@ -175,7 +175,13 @@
 static int initializing;	/* set while initializing built-in drivers */
 
 DECLARE_MUTEX(ide_cfg_sem);
- __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
+
+/* 
+ * Global ide_lock is broken down to per HWGROUP lock. For controller 
+ * serialization when hwgroups are not present, use per-controller
+ * spinlocks.  See drivers/ide/pci/piix.c
+ */
+ __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock __deprecated);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
@@ -587,10 +593,15 @@
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());
 	down(&ide_cfg_sem);
-	spin_lock_irq(&ide_lock);
 	hwif = &ide_hwifs[index];
-	if (!hwif->present)
-		goto abort;
+	hwgroup = hwif->hwgroup;
+	spin_lock_irq(&hwgroup->lock);
+	if (!hwif->present) {
+		spin_unlock_irq(&hwgroup->lock);
+		up(&ide_cfg_sem);
+		return;
+	}
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present) {
@@ -600,18 +611,17 @@
 			}
 			continue;
 		}
-		spin_unlock_irq(&ide_lock);
+		spin_unlock_irq(&hwgroup->lock);
 		device_unregister(&drive->gendev);
 		down(&drive->gendev_rel_sem);
-		spin_lock_irq(&ide_lock);
+		spin_lock_irq(&hwgroup->lock);
 	}
 	hwif->present = 0;
 
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(&hwgroup->lock);
 
 	destroy_proc_ide_interface(hwif);
 
-	hwgroup = hwif->hwgroup;
 	/*
 	 * free the irq if we were the only hwif using it
 	 */
@@ -624,7 +634,7 @@
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(&hwgroup->lock);
 	/*
 	 * Note that we only release the standard ports,
 	 * and do not even try to handle any extra ports
@@ -638,6 +648,7 @@
 	 */
 	if (hwif->next == hwif) {
 		BUG_ON(hwgroup->hwif != hwif);
+		spin_unlock_irq(&hwgroup->lock);
 		kfree(hwgroup);
 	} else {
 		/* There is another interface in hwgroup.
@@ -657,10 +668,9 @@
 			hwgroup->hwif = g;
 		}
 		BUG_ON(hwgroup->hwif == hwif);
+		spin_unlock_irq(&hwgroup->lock);
 	}
 
-	/* More messed up locking ... */
-	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
 	down(&hwif->gendev_rel_sem);
 
@@ -670,7 +680,6 @@
 	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
 	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
-	spin_lock_irq(&ide_lock);
 
 	if (hwif->dma_base) {
 		(void) ide_release_dma(hwif);
@@ -692,9 +701,6 @@
 	init_hwif_default(hwif, index);
 
 	ide_hwif_restore(hwif, &tmp_hwif);
-
-abort:
-	spin_unlock_irq(&ide_lock);
 	up(&ide_cfg_sem);
 }
 
@@ -1012,9 +1018,10 @@
 {
 	int		val = -EINVAL;
 	unsigned long	flags;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
 	if ((setting->rw & SETTING_READ)) {
-		spin_lock_irqsave(&ide_lock, flags);
+		spin_lock_irqsave(&hwgroup->lock, flags);
 		switch(setting->data_type) {
 			case TYPE_BYTE:
 				val = *((u8 *) setting->data);
@@ -1027,7 +1034,7 @@
 				val = *((u32 *) setting->data);
 				break;
 		}
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&hwgroup->lock, flags);
 	}
 	return val;
 }
@@ -1037,7 +1044,7 @@
  *	@drive: drive in the group
  *
  *	Wait for an IDE device group to go non busy and then return
- *	holding the ide_lock which guards the hwgroup->busy status
+ *	holding the hwgroup->lock which guards the hwgroup->busy status
  *	and right to use it.
  */
 
@@ -1046,11 +1053,11 @@
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long timeout = jiffies + (3 * HZ);
 
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(&hwgroup->lock);
 
 	while (hwgroup->busy) {
 		unsigned long lflags;
-		spin_unlock_irq(&ide_lock);
+		spin_unlock_irq(&hwgroup->lock);
 		local_irq_set(lflags);
 		if (time_after(jiffies, timeout)) {
 			local_irq_restore(lflags);
@@ -1058,7 +1065,7 @@
 			return -EBUSY;
 		}
 		local_irq_restore(lflags);
-		spin_lock_irq(&ide_lock);
+		spin_lock_irq(&hwgroup->lock);
 	}
 	return 0;
 }
@@ -1087,6 +1094,7 @@
 {
 	int i;
 	u32 *p;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -1114,7 +1122,7 @@
 				*p = val;
 			break;
 	}
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(&hwgroup->lock);
 	return 0;
 }
 
@@ -1260,6 +1268,7 @@
 	ide_driver_t *drv;
 	int err = 0;
 	void __user *p = (void __user *)arg;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
 	down(&ide_setting_sem);
 	if ((setting = ide_find_setting_by_ioctl(drive, cmd)) != NULL) {
@@ -1377,18 +1386,18 @@
 			 *	spot if we miss one somehow
 			 */
 
-			spin_lock_irqsave(&ide_lock, flags);
+			spin_lock_irqsave(&hwgroup->lock, flags);
 
 			ide_abort(drive, "drive reset");
 
-			if(HWGROUP(drive)->handler)
+			if(hwgroup->handler)
 				BUG();
 				
 			/* Ensure nothing gets queued after we
 			   drop the lock. Reset will clear the busy */
 		   
-			HWGROUP(drive)->busy = 1;
-			spin_unlock_irqrestore(&ide_lock, flags);
+			hwgroup->busy = 1;
+			spin_unlock_irqrestore(&hwgroup->lock, flags);
 			(void) ide_do_reset(drive);
 
 			return 0;
@@ -1874,21 +1883,22 @@
  *	Disconnect a drive from the driver it was attached to and then
  *	clean up the various proc files and other objects attached to it.
  *
- *	Takes ide_setting_sem and ide_lock.
+ *	Takes ide_setting_sem and hwgroup->lock.
  *	Caller must hold none of the locks.
  */
 
 void ide_unregister_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	
 	down(&ide_setting_sem);
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
 #ifdef CONFIG_PROC_FS
 	ide_remove_proc_entries(drive->proc, driver->proc);
 #endif
 	auto_remove_settings(drive);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 	up(&ide_setting_sem);
 }
 
Index: linux-2.6.13/drivers/scsi/ide-scsi.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/ide-scsi.c	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/drivers/scsi/ide-scsi.c	2005-09-06 15:16:15.000000000 -0700
@@ -956,6 +956,7 @@
 	ide_drive_t    *drive = scsi->drive;
 	int		busy;
 	int             ret   = FAILED;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
 	/* In idescsi_eh_abort we try to gently pry our command from the ide subsystem */
 
@@ -974,7 +975,7 @@
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 		printk (KERN_WARNING "ide-scsi: drive did%s become ready\n", busy?" not":"");
 
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(&hwgroup->lock);
 
 	/* If there is no pc running we're done (our interrupt took care of it) */
 	if (!scsi->pc) {
@@ -1000,7 +1001,7 @@
 	}
 
 ide_unlock:
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(&hwgroup->lock);
 no_drive:
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 		printk (KERN_WARNING "ide-scsi: abort returns %s\n", ret == SUCCESS?"success":"failed");
@@ -1015,6 +1016,7 @@
 	ide_drive_t    *drive = scsi->drive;
 	int             ready = 0;
 	int             ret   = SUCCESS;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
 	/* In idescsi_eh_reset we forcefully remove the command from the ide subsystem and reset the device. */
 
@@ -1028,11 +1030,11 @@
 	}
 
 	spin_lock_irq(cmd->device->host->host_lock);
-	spin_lock(&ide_lock);
+	spin_lock(&hwgroup->lock);
 
-	if (!scsi->pc || (req = scsi->pc->rq) != HWGROUP(drive)->rq || !HWGROUP(drive)->handler) {
+	if (!scsi->pc || (req = scsi->pc->rq) != hwgroup->rq || !hwgroup->handler) {
 		printk (KERN_WARNING "ide-scsi: No active request in idescsi_eh_reset\n");
-		spin_unlock(&ide_lock);
+		spin_unlock(&hwgroup->lock);
 		spin_unlock_irq(cmd->device->host->host_lock);
 		return FAILED;
 	}
@@ -1052,10 +1054,10 @@
 		end_that_request_last(req);
 	}
 
-	HWGROUP(drive)->rq = NULL;
-	HWGROUP(drive)->handler = NULL;
-	HWGROUP(drive)->busy = 1;		/* will set this to zero when ide reset finished */
-	spin_unlock(&ide_lock);
+	hwgroup->rq = NULL;
+	hwgroup->handler = NULL;
+	hwgroup->busy = 1;		/* will set this to zero when ide reset finished */
+	spin_unlock(&hwgroup->lock);
 
 	ide_do_reset(drive);
 
Index: linux-2.6.13/include/linux/ide.h
===================================================================
--- linux-2.6.13.orig/include/linux/ide.h	2005-09-06 15:08:07.000000000 -0700
+++ linux-2.6.13/include/linux/ide.h	2005-09-06 15:16:15.000000000 -0700
@@ -961,6 +961,7 @@
 	int pio_clock;
 
 	unsigned char cmd_buf[4];
+	spinlock_t lock;
 } ide_hwgroup_t;
 
 /* structure attached to the request for IDE_TASK_CMDS */
@@ -1480,12 +1481,12 @@
 /*
  * Structure locking:
  *
- * ide_cfg_sem and ide_lock together protect changes to
+ * ide_cfg_sem and hwgroup->lock together protect changes to
  * ide_hwif_t->{next,hwgroup}
  * ide_drive_t->next
  *
- * ide_hwgroup_t->busy: ide_lock
- * ide_hwgroup_t->hwif: ide_lock
+ * ide_hwgroup_t->busy: hwgroup->lock
+ * ide_hwgroup_t->hwif: hwgroup->lock
  * ide_hwif_t->mate: constant, no locking
  * ide_drive_t->hwif: constant, no locking
  */
