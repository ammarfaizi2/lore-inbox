Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757465AbWKWVDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbWKWVDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757466AbWKWVDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:03:32 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:25610 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1757465AbWKWVDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:03:31 -0500
Date: Thu, 23 Nov 2006 21:03:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061123210322.GB25794@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <jens.axboe@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx> <20061114114120.GC22178@kernel.dk> <4559D3F1.1010400@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4559D3F1.1010400@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 03:34:25PM +0100, Pierre Ossman wrote:
> How about this patch? It is basically the same as the previous, but it
> also sets queuedata to NULL and tests for that. It does not address if
> someone still has dependencies on the queue but hasn't gotten itself a
> reference (as I haven't gotten any word on if that is a problem):
> 
> diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
> index f9027c8..5025abe 100644
> --- a/drivers/mmc/mmc_block.c
> +++ b/drivers/mmc/mmc_block.c
> @@ -83,7 +83,6 @@ static void mmc_blk_put(struct mmc_blk_d
>         md->usage--;
>         if (md->usage == 0) {
>                 put_disk(md->disk);
> -               mmc_cleanup_queue(&md->queue);
>                 kfree(md);
>         }
>         mutex_unlock(&open_lock);
> @@ -553,12 +552,11 @@ static void mmc_blk_remove(struct mmc_ca
>         if (md) {
>                 int devidx;
>  
> +               /* Stop new requests from getting into the queue */
>                 del_gendisk(md->disk);

I'm not entirely convinced that del_gendisk() will prevent any new
requests getting into the queue, which is why the comment below
says:

>  
> -               /*
> -                * I think this is needed.
> -                */
> -               md->disk->queue = NULL;

Yes, del_gendisk() removes the disk from view for new opens, but what
about existing users?

As the code currently stands, when I remove a mounted MMC card, I get:

generic_make_request: Trying to access nonexistent block-device mmcblk0p1 (26)
FAT: Directory bread(block 26) failed
generic_make_request: Trying to access nonexistent block-device mmcblk0p1 (27)
FAT: Directory bread(block 27) failed
... etc ...

and this comes from:

                q = bdev_get_queue(bio->bi_bdev);
                if (!q) {
                        printk(KERN_ERR ...

in block/ll_rw_blk.c.  bdev_get_queue merely does:

        return bdev->bd_disk->queue;

> +               /* Then flush out any already in there */
> +               mmc_cleanup_queue(&md->queue);

Now, the thing is calling mmc_cleanup_queue() will shutdown the thread
and wait for it to complete its business, free the scatterlist, and
call blk_cleanup_queue() on that queue.

Ergo, once we've shut down the thread, we should not get any further
MMC requests, so:

> diff --git a/drivers/mmc/mmc_queue.c b/drivers/mmc/mmc_queue.c
> index 4ccdd82..b6769e2 100644
> --- a/drivers/mmc/mmc_queue.c
> +++ b/drivers/mmc/mmc_queue.c
> @@ -111,6 +111,19 @@ static int mmc_queue_thread(void *d)
>  static void mmc_request(request_queue_t *q)
>  {
>         struct mmc_queue *mq = q->queuedata;
> +       struct request *req;
> +       int ret;
> +
> +       if (!mq) {
> +               printk(KERN_ERR "MMC: killing requests for dead queue\n");
> +               while ((req = elv_next_request(q)) != NULL) {
> +                       do {
> +                               ret = end_that_request_chunk(req, 0,
> +                                       req->current_nr_sectors << 9);
> +                       } while (ret);
> +               }
> +               return;
> +       }
>  
>         if (!mq->req)
>                 wake_up(&mq->thread_wq);
> @@ -179,6 +192,15 @@ EXPORT_SYMBOL(mmc_init_queue);
>  
>  void mmc_cleanup_queue(struct mmc_queue *mq)
>  {
> +       request_queue_t *q = mq->queue;
> +       unsigned long flags;
> +
> +       /* Mark that we should start throwing out stragglers */
> +       spin_lock_irqsave(q->queue_lock, flags);
> +       q->queuedata = NULL;
> +       spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +       /* Then terminate our worker thread */
>         mq->flags |= MMC_QUEUE_EXIT;
>         wake_up(&mq->thread_wq);
>         wait_for_completion(&mq->thread_complete);

These hunks do not achieve us anything.

However, what we _do_ need to do is to arrange for the MMC queue thread
to error out all pending requests before dying if MMC_QUEUE_EXIT is set.
That's already handled since the queue thread only ever exits if there
are no requests pending _and_ MMC_QUEUE_EXIT has been set.

So I think all you really need is this change:

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index f9027c8..9173067 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -83,7 +83,6 @@ static void mmc_blk_put(struct mmc_blk_d
 	md->usage--;
 	if (md->usage == 0) {
 		put_disk(md->disk);
-		mmc_cleanup_queue(&md->queue);
 		kfree(md);
 	}
 	mutex_unlock(&open_lock);
@@ -559,6 +558,7 @@ static void mmc_blk_remove(struct mmc_ca
 		 * I think this is needed.
 		 */
 		md->disk->queue = NULL;
+		mmc_cleanup_queue(&md->queue);
 
 		devidx = md->disk->first_minor >> MMC_SHIFT;
 		__clear_bit(devidx, dev_use);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
