Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSFQKPF>; Mon, 17 Jun 2002 06:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316891AbSFQKPE>; Mon, 17 Jun 2002 06:15:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46747 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316884AbSFQKPC>;
	Mon, 17 Jun 2002 06:15:02 -0400
Date: Mon, 17 Jun 2002 12:15:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] ide locking botch
Message-ID: <20020617101501.GA811@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin et al,

I took a quick look at why 2.5.21 hung at boot detecting partitions,
because a 2.5.22 did the exact same thing on my test box today... The
tcq locking is completely screwed now, and as I said before the weekend
I think the entire locking is just getting worse now.

Anyways, this patch at least attempts to make tcq follow the channel
lock usage to make it work for me.

--- /opt/kernel/linux-2.5.22/drivers/ide/tcq.c	Mon Jun 17 04:31:35 2002
+++ linux/drivers/ide/tcq.c	Mon Jun 17 12:09:08 2002
@@ -175,13 +175,8 @@
 		tcq_invalidate_queue(drive);
 }
 
-static void set_irq(struct ata_device *drive, ata_handler_t *handler)
+static void __set_irq(struct ata_channel *ch, ata_handler_t *handler)
 {
-	struct ata_channel *ch = drive->channel;
-	unsigned long flags;
-
-	spin_lock_irqsave(ch->lock, flags);
-
 	/*
 	 * always just bump the timer for now, the timeout handling will
 	 * have to be changed to be per-command
@@ -194,7 +189,15 @@
 	ch->timer.data = (unsigned long) ch->drive;
 	mod_timer(&ch->timer, jiffies + 5 * HZ);
 	ch->handler = handler;
+}
+
+static void set_irq(struct ata_device *drive, ata_handler_t *handler)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long flags;
 
+	spin_lock_irqsave(ch->lock, flags);
+	__set_irq(ch, handler);
 	spin_unlock_irqrestore(ch->lock, flags);
 }
 
@@ -230,8 +233,10 @@
  */
 static ide_startstop_t service(struct ata_device *drive, struct request *rq)
 {
-	u8 feat;
-	u8 stat;
+	struct ata_channel *ch = drive->channel;
+	ide_startstop_t ret;
+	unsigned long flags;
+	u8 feat, stat;
 	int tag;
 
 	TCQ_PRINTK("%s: started service\n", drive->name);
@@ -291,9 +296,12 @@
 
 	TCQ_PRINTK("%s: stat %x, feat %x\n", __FUNCTION__, stat, feat);
 
+	spin_lock_irqsave(ch->lock, flags);
+
 	rq = blk_queue_find_tag(&drive->queue, tag);
 	if (!rq) {
 		printk(KERN_ERR"%s: missing request for tag %d\n", __FUNCTION__, tag);
+		spin_unlock_irqrestore(ch->lock, flags);
 		return ide_stopped;
 	}
 
@@ -304,7 +312,10 @@
 	 * interrupt to indicate end of transfer, release is not allowed
 	 */
 	TCQ_PRINTK("%s: starting command %x\n", __FUNCTION__, stat);
-	return udma_tcq_start(drive, rq);
+
+	ret = udma_tcq_start(drive, rq);
+	spin_unlock_irqrestore(ch->lock, flags);
+	return ret;
 }
 
 static ide_startstop_t check_service(struct ata_device *drive, struct request *rq)
@@ -538,7 +549,7 @@
 	if (ata_start_dma(drive, rq))
 		return ide_stopped;
 
-	set_irq(drive, ide_dmaq_intr);
+	__set_irq(ch, ide_dmaq_intr);
 	udma_start(drive, rq);
 
 	return ide_started;
@@ -590,7 +601,7 @@
 	if ((feat = GET_FEAT()) & NSEC_REL) {
 		drive->immed_rel++;
 		drive->rq = NULL;
-		set_irq(drive, ide_dmaq_intr);
+		__set_irq(drive->channel, ide_dmaq_intr);
 
 		TCQ_PRINTK("REL in queued_start\n");
 

-- 
Jens Axboe

