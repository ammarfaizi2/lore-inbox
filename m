Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTEFTmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbTEFTmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:42:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21402 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261220AbTEFTmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:42:13 -0400
Date: Tue, 6 May 2003 21:54:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Nicolas Pitre <nico@cam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506195435.GP905@suse.de>
References: <20030506184914.GL905@suse.de> <Pine.LNX.4.44.0305061509090.11648-100000@xanadu.home> <20030506192056.GM905@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506192056.GM905@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Jens Axboe wrote:
> On Tue, May 06 2003, Nicolas Pitre wrote:
> > On Tue, 6 May 2003, Jens Axboe wrote:
> > 
> > > On Tue, May 06 2003, Nicolas Pitre wrote:
> > > > On Tue, 6 May 2003, Jens Axboe wrote:
> > > > 
> > > > > On Tue, May 06 2003, Alan Cox wrote:
> > > > > > On Maw, 2003-05-06 at 18:23, Nicolas Pitre wrote:
> > > > > > > According to Alan it's nearly possible to configure the block layer out 
> > > > > > > entirely, which would be a good thing to associate with a CONFIG_DISK option 
> > > > > > > too.
> > > > > > 
> > > > > > David Woodhouse I believe..
> > > > > 
> > > > > Are we talking about everything below submit_bh/bio? Shouldn't be too
> > > > > hard to write a small no-block.c for that...
> > > > 
> > > > The idea is to configure out everything not needed when only NFS and/or JFFS 
> > > > (which doesn't rely on the block layer to work) are used.  Pretty useful for 
> > > > networked or embedded machines.
> > > 
> > > I see, that would indeed be a bigger job :). Just the block layer would
> > > not be hard, especially if you make the restriction that the block
> > > drivers usable would be ones that used a make_request strategy for
> > > handling requests. That would allow you to kill ll_rw_blk.c,
> > > deadline-iosched.c, and elevator.c. That's some 21k of text and 2k of
> > > data on this box.
> > 
> > That's certainly a good start.
> 
> How easy it is depends on which drivers need to work - which? mtdblock
> comes to mind, a quick glance reveals that should be a breeze to make
> work. It would even simplify it a bit, as the 'push request handling to
> thread context' could be killed as well.

Something like this, I think the diffstat speaks for itself... Whether
this one works at all or not I dunno, it was done quickly and I don't
have any hardware to test it on. Should be trivial to make it work, if
it doesn't already.

axboe@smithers:/home/axboe $ diffstat mtdblock-1
 mtdblock.c |  124 +++++++++++++++++--------------------------------------------
 1 files changed, 36 insertions(+), 88 deletions(-)

===== drivers/mtd/mtdblock.c 1.43 vs edited =====
--- 1.43/drivers/mtd/mtdblock.c	Mon Apr 21 01:21:18 2003
+++ edited/drivers/mtd/mtdblock.c	Tue May  6 21:52:10 2003
@@ -381,105 +381,56 @@
  * to dequeue requests before we are done.
  */
 static struct request_queue mtd_queue;
-static void handle_mtdblock_request(void)
+static volatile int leaving = 0;
+static DECLARE_MUTEX_LOCKED(thread_sem);
+static DECLARE_WAIT_QUEUE_HEAD(thr_wq);
+
+static int mtdblock_make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req;
-	struct mtdblk_dev *mtdblk;
-	unsigned int res;
+	struct mtdblk_dev **p = bio->bi_bdev->bd_disk->private_data;
+	struct mtdblk_dev *mtdblk = *p;
+	struct bio_vec *bv;
+	sector_t sector;
+	int i, err = 0;
 
-	while ((req = elv_next_request(&mtd_queue)) != NULL) {
-		struct mtdblk_dev **p = req->rq_disk->private_data;
-		spin_unlock_irq(mtd_queue.queue_lock);
-		mtdblk = *p;
-		res = 0;
-
-		if (! (req->flags & REQ_CMD))
-			goto end_req;
-
-		if ((req->sector + req->current_nr_sectors) > (mtdblk->mtd->size >> 9))
-			goto end_req;
-
-		// Handle the request
-		switch (rq_data_dir(req))
-		{
-			int err;
-
-			case READ:
-			down(&mtdblk->cache_sem);
-			err = do_cached_read (mtdblk, req->sector << 9, 
-					req->current_nr_sectors << 9,
-					req->buffer);
-			up(&mtdblk->cache_sem);
-			if (!err)
-				res = 1;
-			break;
+	down(&mtdblk->cache_sem);
 
-			case WRITE:
-			// Read only device
-			if ( !(mtdblk->mtd->flags & MTD_WRITEABLE) ) 
-				break;
-
-			// Do the write
-			down(&mtdblk->cache_sem);
-			err = do_cached_write (mtdblk, req->sector << 9,
-					req->current_nr_sectors << 9, 
-					req->buffer);
-			up(&mtdblk->cache_sem);
-			if (!err)
-				res = 1;
+	if (bio_data_dir(bio) == WRITE && !(mtdblk->mtd->flags & MTD_WRITEABLE))
+		goto end_io;
+
+	sector = bio->bi_sector;
+
+	bio_for_each_segment(bv, bio, i) {
+		unsigned long flags;
+		char *dst;
+
+		if (sector + (bv->bv_len >> 9) > (mtdblk->mtd->size >> 9)) {
+			err = -EIO;
 			break;
 		}
 
-end_req:
-		spin_lock_irq(mtd_queue.queue_lock);
-		if (!end_that_request_first(req, res, req->hard_cur_sectors)) {
-			blkdev_dequeue_request(req);
-			end_that_request_last(req);
-		}
+		dst = bvec_kmap_irq(bv, &flags);
 
-	}
-}
+		if (bio_data_dir(bio) == READ)
+			err = do_cached_read(mtdblk, sector << 9, bv->bv_len, dst);
+		else
+			err = do_cached_write(mtdblk, sector << 9, bv->bv_len, dst);
 
-static volatile int leaving = 0;
-static DECLARE_MUTEX_LOCKED(thread_sem);
-static DECLARE_WAIT_QUEUE_HEAD(thr_wq);
+		bvec_kunmap_irq(dst, &flags);
 
-int mtdblock_thread(void *dummy)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+		if (err)
+			break;
 
-	/* we might get involved when memory gets low, so use PF_MEMALLOC */
-	tsk->flags |= PF_MEMALLOC;
-	daemonize("mtdblockd");
-
-	while (!leaving) {
-		add_wait_queue(&thr_wq, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock_irq(mtd_queue.queue_lock);
-		if (!elv_next_request(&mtd_queue) || blk_queue_plugged(&mtd_queue)) {
-			spin_unlock_irq(mtd_queue.queue_lock);
-			schedule();
-			remove_wait_queue(&thr_wq, &wait); 
-		} else {
-			remove_wait_queue(&thr_wq, &wait); 
-			set_current_state(TASK_RUNNING);
-			handle_mtdblock_request();
-			spin_unlock_irq(mtd_queue.queue_lock);
-		}
+		sector += bv->bv_len >> 9;
+		bio_endio(bio, bv->bv_len, 0);
 	}
 
-	up(&thread_sem);
+end_io:
+	up(&mtdblk->cache_sem);
+	bio_endio(bio, bio->bi_size, err);
 	return 0;
 }
 
-static void mtdblock_request(struct request_queue *q)
-{
-	/* Don't do anything, except wake the thread if necessary */
-	wake_up(&thr_wq);
-}
-
-
 static int mtdblock_ioctl(struct inode * inode, struct file * file,
 		      unsigned int cmd, unsigned long arg)
 {
@@ -557,8 +508,6 @@
         }
 }
 
-static spinlock_t mtddev_lock = SPIN_LOCK_UNLOCKED;
-
 int __init init_mtdblock(void)
 {
 	spin_lock_init(&mtdblks_lock);
@@ -572,8 +521,7 @@
 	register_mtd_user(&notifier);
 	
 	init_waitqueue_head(&thr_wq);
-	blk_init_queue(&mtd_queue, &mtdblock_request, &mtddev_lock);
-	kernel_thread (mtdblock_thread, NULL, CLONE_FS|CLONE_FILES|CLONE_SIGHAND);
+	blk_queue_make_request(&mtd_queue, mtdblock_make_request);
 	return 0;
 }
 

-- 
Jens Axboe

