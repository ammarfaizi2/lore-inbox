Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965875AbWKNOeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965875AbWKNOeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 09:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965885AbWKNOeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 09:34:17 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:6294 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S965875AbWKNOeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 09:34:16 -0500
Message-ID: <4559D3F1.1010400@drzeus.cx>
Date: Tue, 14 Nov 2006 15:34:25 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx> <20061114114120.GC22178@kernel.dk>
In-Reply-To: <20061114114120.GC22178@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about this patch? It is basically the same as the previous, but it
also sets queuedata to NULL and tests for that. It does not address if
someone still has dependencies on the queue but hasn't gotten itself a
reference (as I haven't gotten any word on if that is a problem):

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index f9027c8..5025abe 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -83,7 +83,6 @@ static void mmc_blk_put(struct mmc_blk_d
        md->usage--;
        if (md->usage == 0) {
                put_disk(md->disk);
-               mmc_cleanup_queue(&md->queue);
                kfree(md);
        }
        mutex_unlock(&open_lock);
@@ -553,12 +552,11 @@ static void mmc_blk_remove(struct mmc_ca
        if (md) {
                int devidx;
 
+               /* Stop new requests from getting into the queue */
                del_gendisk(md->disk);
 
-               /*
-                * I think this is needed.
-                */
-               md->disk->queue = NULL;
+               /* Then flush out any already in there */
+               mmc_cleanup_queue(&md->queue);
 
                devidx = md->disk->first_minor >> MMC_SHIFT;
                __clear_bit(devidx, dev_use);
diff --git a/drivers/mmc/mmc_queue.c b/drivers/mmc/mmc_queue.c
index 4ccdd82..b6769e2 100644
--- a/drivers/mmc/mmc_queue.c
+++ b/drivers/mmc/mmc_queue.c
@@ -111,6 +111,19 @@ static int mmc_queue_thread(void *d)
 static void mmc_request(request_queue_t *q)
 {
        struct mmc_queue *mq = q->queuedata;
+       struct request *req;
+       int ret;
+
+       if (!mq) {
+               printk(KERN_ERR "MMC: killing requests for dead queue\n");
+               while ((req = elv_next_request(q)) != NULL) {
+                       do {
+                               ret = end_that_request_chunk(req, 0,
+                                       req->current_nr_sectors << 9);
+                       } while (ret);
+               }
+               return;
+       }
 
        if (!mq->req)
                wake_up(&mq->thread_wq);
@@ -179,6 +192,15 @@ EXPORT_SYMBOL(mmc_init_queue);
 
 void mmc_cleanup_queue(struct mmc_queue *mq)
 {
+       request_queue_t *q = mq->queue;
+       unsigned long flags;
+
+       /* Mark that we should start throwing out stragglers */
+       spin_lock_irqsave(q->queue_lock, flags);
+       q->queuedata = NULL;
+       spin_unlock_irqrestore(q->queue_lock, flags);
+
+       /* Then terminate our worker thread */
        mq->flags |= MMC_QUEUE_EXIT;
        wake_up(&mq->thread_wq);
        wait_for_completion(&mq->thread_complete);

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

