Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSIONsP>; Sun, 15 Sep 2002 09:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSIONsP>; Sun, 15 Sep 2002 09:48:15 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:37364 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318044AbSIONsO>;
	Sun, 15 Sep 2002 09:48:14 -0400
Date: Sun, 15 Sep 2002 09:53:05 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>, Charles.White@compaq.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix cpqarray on 2.5
Message-ID: <20020915135305.GA22713@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens & Charles,

The attached patch fixes some critical bugs in cpqarray in 2.5. One of the fixes
essentially backs out the block queue stop/start behavior that was added
recently. This code as it stands is buggy and locks up under even light SMP
workloads. Certainly we want the performance benefits of proper block queue
plugging, but the driver needs some work before it will fit nicely.

Some of these fixes do theoretically hurt performance, but when you consider
that the driver is unusable under SMP as-is, I think it is right to get
correctness first.

Specifically, this patch does the following:

* Adds locking to proc queue-walking code for debugging use. Note that the proc
registration is still broken and I've left it that way since this stuff should
probably migrate to driverfs anyway.

* Moves interrupt enabling so queue lock is initialized before interrupts are
enabled. Otherwise if we get a quick interrupt we oops the machine.

* Removes unconditional IRQ enabling in do_ida_request(). The block layer takes
the spinlock with irq_save so if we're going to play this trick then we need to
irq_restore. For now, just eliminate the unlocked region.

* Remove block queue stop/start logic since it can leave the queue stopped with
no outstanding completions to start it again. Plugging logic can come back but
it should go hand-in-hand with a cleanup of the driver's request handling
algorithm. If nobody screams about this patch I'll go ahead and start making
those improvments.

Patch is against 2.5.34 but should apply to any vaguely recent 2.5.

--Adam

--- /mnt/linux-2.5.34/drivers/block/cpqarray.c	Mon Sep  9 14:28:31 2002
+++ linux-2.5.34-mm1/drivers/block/cpqarray.c	Sat Sep 14 14:03:35 2002
@@ -202,6 +202,7 @@
 	drv_info_t *drv;
 #ifdef CPQ_PROC_PRINT_QUEUES
 	cmdlist_t *c;
+	unsigned long flags;
 #endif
 
 	ctlr = h->ctlr;
@@ -238,6 +239,7 @@
 	}
 
 #ifdef CPQ_PROC_PRINT_QUEUES
+	spin_lock_irqsave(IDA_LOCK(h->ctlr), flags); 
 	size = sprintf(buffer+len, "\nCurrent Queues:\n");
 	pos += size; len += size;
 
@@ -260,6 +262,7 @@
 	}
 
 	size = sprintf(buffer+len, "\n"); pos += size; len += size;
+	spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags); 
 #endif
 	size = sprintf(buffer+len, "nr_allocs = %d\nnr_frees = %d\n",
 			h->nr_allocs, h->nr_frees);
@@ -414,8 +417,6 @@
 		getgeometry(i);
 		start_fwbk(i); 
 
-		hba[i]->access.set_intr_mask(hba[i], FIFO_NOT_EMPTY);
-
 		ida_procinit(i);
 
 		q = BLK_DEFAULT_QUEUE(MAJOR_NR + i);
@@ -436,6 +437,9 @@
 		hba[i]->timer.function = ida_timer;
 		add_timer(&hba[i]->timer);
 
+		/* Enable IRQ now that spinlock and rate limit timer are set up */
+		hba[i]->access.set_intr_mask(hba[i], FIFO_NOT_EMPTY);
+
 		for(j=0; j<NWD; j++) {
 			struct gendisk *disk = ida_gendisk + i*NWD + j;
 			drv_info_t *drv = &hba[i]->drv[j];
@@ -832,8 +836,6 @@
 
 	blkdev_dequeue_request(creq);
 
-	spin_unlock_irq(q->queue_lock);
-
 	c->ctlr = h->ctlr;
 	c->hdr.unit = minor(creq->rq_dev) >> NWD_SHIFT;
 	c->hdr.size = sizeof(rblk_t) >> 2;
@@ -865,8 +867,6 @@
 	c->req.hdr.cmd = (rq_data_dir(creq) == READ) ? IDA_READ : IDA_WRITE;
 	c->type = CMD_RWREQ;
 
-	spin_lock_irq(q->queue_lock);
-
 	/* Put the request on the tail of the request queue */
 	addQ(&h->reqQ, c);
 	h->Qdepth++;
@@ -876,7 +876,6 @@
 	goto queue_next;
 
 startio:
-	__blk_stop_queue(q);
 	start_io(h);
 }
 
@@ -1027,8 +1026,8 @@
 	/*
 	 * See if we can queue up some more IO
 	 */
-	spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags);
-	blk_start_queue(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
+	do_ida_request(BLK_DEFAULT_QUEUE(MAJOR_NR+h->ctlr));
+	spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags); 
 }
 
 /*

