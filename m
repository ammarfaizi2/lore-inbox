Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318685AbSHAJky>; Thu, 1 Aug 2002 05:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318692AbSHAJky>; Thu, 1 Aug 2002 05:40:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13316 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318685AbSHAJjq>; Thu, 1 Aug 2002 05:39:46 -0400
Message-ID: <3D488A2A.7050503@evision.ag>
Date: Thu, 01 Aug 2002 03:08:58 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.29 IDE 111
Content-Type: multipart/mixed;
 boundary="------------030703070404030507000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030703070404030507000204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Change over queuedata to carry the device instead of the channel
   information.

--------------030703070404030507000204
Content-Type: text/plain;
 name="ide-111.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-111.diff"

diff -durNp -X /tmp/diff.904AxP linux-2.5.29/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.29/drivers/ide/ide.c	2002-08-01 02:38:35.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-08-01 02:46:53.000000000 +0200
@@ -505,27 +505,13 @@ ide_startstop_t ata_error(struct ata_dev
  */
 void do_ide_request(request_queue_t *q)
 {
-	/* FIXME: queuedata should contain the device instead.
-	 */
-	struct ata_channel *channel = q->queuedata;
+	struct ata_device *drive = q->queuedata;
+	struct ata_channel *ch = drive->channel;
 
-	while (!test_and_set_bit(IDE_BUSY, channel->active)) {
-		struct ata_device *drive = NULL;
+	while (!test_and_set_bit(IDE_BUSY, ch->active)) {
 		unsigned int unit;
 		ide_startstop_t ret;
 
-		/*
-		 * Select the device corresponding to the queue.
-		 */
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			struct ata_device *tmp = &channel->drives[unit];
-
-			if (&tmp->queue == q) {
-				drive = tmp;
-				break;
-			}
-		}
-
 		if (drive) {
 			/* No request pending?! */
 			if (blk_queue_empty(&drive->queue))
@@ -542,7 +528,7 @@ void do_ide_request(request_queue_t *q)
 			 */
 			// printk(KERN_INFO "no device found!\n");
 			for (unit = 0; unit < MAX_DRIVES; ++unit) {
-				struct ata_device *tmp = &channel->drives[unit];
+				struct ata_device *tmp = &ch->drives[unit];
 
 				if (!tmp->present)
 					continue;
@@ -567,7 +553,7 @@ void do_ide_request(request_queue_t *q)
 			 */
 
 			ide_release_lock(&ide_irq_lock);/* for atari only */
-			clear_bit(IDE_BUSY, channel->active);
+			clear_bit(IDE_BUSY, ch->active);
 
 			/* All requests are done.
 			 *
@@ -576,15 +562,15 @@ void do_ide_request(request_queue_t *q)
 			 * are not prepared to take them.
 			 */
 
-			if (channel->drive && !channel->drive->using_tcq)
-				ata_irq_enable(channel->drive, 0);
+			if (ch->drive && !ch->drive->using_tcq)
+				ata_irq_enable(ch->drive, 0);
 
 			return;
 		}
 
 		/* Remember the last drive we where acting on.
 		 */
-		channel->drive = drive;
+		ch->drive = drive;
 
 		/* Feed commands to a drive until it barfs.
 		 */
@@ -598,14 +584,14 @@ void do_ide_request(request_queue_t *q)
 
 			if (!ata_can_queue(drive)) {
 				if (!ata_pending_commands(drive)) {
-					clear_bit(IDE_BUSY, channel->active);
+					clear_bit(IDE_BUSY, ch->active);
 					if (drive->using_tcq)
 						ata_irq_enable(drive, 0);
 				}
 				break;
 			}
 
-			if (test_bit(IDE_DMA, channel->active)) {
+			if (test_bit(IDE_DMA, ch->active)) {
 				printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
 				break;
 			}
@@ -624,7 +610,7 @@ void do_ide_request(request_queue_t *q)
 
 			if (!(rq = elv_next_request(&drive->queue))) {
 				if (!ata_pending_commands(drive)) {
-					clear_bit(IDE_BUSY, channel->active);
+					clear_bit(IDE_BUSY, ch->active);
 					if (drive->using_tcq)
 						ata_irq_enable(drive, 0);
 				}
@@ -642,7 +628,7 @@ void do_ide_request(request_queue_t *q)
 
 			drive->rq = rq;
 
-			spin_unlock(channel->lock);
+			spin_unlock(ch->lock);
 			/* allow other IRQs while we start this request */
 			local_irq_enable();
 
@@ -687,7 +673,7 @@ kill_rq:
 				ret = ATA_OP_FINISHED;
 
 			}
-			spin_lock_irq(channel->lock);
+			spin_lock_irq(ch->lock);
 			/* continue if command started, so we are busy */
 		} while (ret != ATA_OP_CONTINUES);
 	}
diff -durNp -X /tmp/diff.904AxP linux-2.5.29/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.29/drivers/ide/probe.c	2002-08-01 02:38:36.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-08-01 02:41:57.000000000 +0200
@@ -977,23 +977,24 @@ static int init_irq(struct ata_channel *
 			ch->drive = drive;
 
 		/*
-		 * Init the per device request queue
+		 * Init the per device request queue.
 		 */
 
 		q = &drive->queue;
-		q->queuedata = drive->channel;
+		q->queuedata = drive;
 		blk_init_queue(q, do_ide_request, drive->channel->lock);
 		blk_queue_segment_boundary(q, ch->seg_boundary_mask);
 		blk_queue_max_segment_size(q, ch->max_segment_size);
 
-		/* ATA can do up to 128K per request, pdc4030 needs smaller limit */
+		/* ATA can do up to 128K per request, pdc4030 needs smaller
+		 * limit. */
 #ifdef CONFIG_BLK_DEV_PDC4030
 		if (drive->channel->chipset == ide_pdc4030)
 			max_sectors = 127;
 #endif
 		blk_queue_max_sectors(q, max_sectors);
 
-		/* IDE DMA can do PRD_ENTRIES number of segments. */
+		/* ATA DMA can do PRD_ENTRIES number of segments. */
 		blk_queue_max_hw_segments(q, PRD_ENTRIES);
 
 		/* FIXME: This is a driver limit and could be eliminated. */

--------------030703070404030507000204--


