Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTEGHKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTEGHKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:10:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46022 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262942AbTEGHK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:10:28 -0400
Date: Wed, 7 May 2003 09:22:37 +0200
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nicolas Pitre <nico@cam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030507072237.GW905@suse.de>
References: <20030506183010.GK905@suse.de> <Pine.LNX.4.44.0305061436510.11648-100000@xanadu.home> <20030506184914.GL905@suse.de> <1052254888.7532.58.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052254888.7532.58.camel@imladris.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, David Woodhouse wrote:
> On Tue, 2003-05-06 at 19:49, Jens Axboe wrote:
> > I see, that would indeed be a bigger job :). Just the block layer would
> > not be hard, especially if you make the restriction that the block
> > drivers usable would be ones that used a make_request strategy for
> > handling requests. That would allow you to kill ll_rw_blk.c,
> > deadline-iosched.c, and elevator.c. That's some 21k of text and 2k of
> > data on this box.
> 
> That's a little short of what I was intending. Ideally we stick 'struct
> request', 'struct buffer_head' and 'struct bio' inside #ifdef
> CONFIG_BLK_DEV, then kill all the dead code which uses them.

struct request can be a goner with my patch, the others not really.
request is really a block private property, so it's easy to kill off.
You are going for the really minimal approach, basically ruling out lots
of filesystems and requiring major surgery all around. While I can see
that make sense for an embedded kernel, I'm having a hard time
envisioning this as something mergable :-)

> mtdblock.c cleanup noted with interest -- I'll play with that shortly;
> thanks. Note that you don't actually need flash hardware, you can load
> the 'mtdram' device which fakes it with vmalloc-backed storage instead.
> Not too useful for powerfail-testing but for mounting something like
> ext2 on mtdblock on mtdram it's fine.

I'm attaching an updated version, I don't think it's safe to use atomic
kmaps across the do_cached_read/write.

Also, I want bio_endio() to increment the sector position of the bio as
well. Makes for a nicer api, and the sector var in mtdblock would then
be killable.

===== drivers/mtd/mtdblock.c 1.43 vs edited =====
--- 1.43/drivers/mtd/mtdblock.c	Mon Apr 21 01:21:18 2003
+++ edited/drivers/mtd/mtdblock.c	Wed May  7 09:18:30 2003
@@ -381,105 +381,55 @@
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
+		dst = kmap(bv->bv_page) + bv->bv_offset;
 
-	}
-}
+		if (bio_data_dir(bio) == READ)
+			err = do_cached_read(mtdblk, sector << 9, bv->bv_len, dst);
+		else
+			err = do_cached_write(mtdblk, sector << 9, bv->bv_len, dst);
 
-static volatile int leaving = 0;
-static DECLARE_MUTEX_LOCKED(thread_sem);
-static DECLARE_WAIT_QUEUE_HEAD(thr_wq);
+		kunmap(bv->bv_page);
 
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
@@ -557,8 +507,6 @@
         }
 }
 
-static spinlock_t mtddev_lock = SPIN_LOCK_UNLOCKED;
-
 int __init init_mtdblock(void)
 {
 	spin_lock_init(&mtdblks_lock);
@@ -572,8 +520,7 @@
 	register_mtd_user(&notifier);
 	
 	init_waitqueue_head(&thr_wq);
-	blk_init_queue(&mtd_queue, &mtdblock_request, &mtddev_lock);
-	kernel_thread (mtdblock_thread, NULL, CLONE_FS|CLONE_FILES|CLONE_SIGHAND);
+	blk_queue_make_request(&mtd_queue, mtdblock_make_request);
 	return 0;
 }
 

-- 
Jens Axboe

