Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTJUMGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbTJUMGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:06:01 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10897 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263071AbTJUMFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:05:43 -0400
Date: Tue, 21 Oct 2003 17:41:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pbadari@us.ibm.com
Subject: Patch for Retry based AIO-DIO (Was AIO and DIO testing on 2.6.0-test7-mm1)
Message-ID: <20031021121113.GA4282@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net> <20031020142727.GA4068@in.ibm.com> <1066693673.22983.10.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066693673.22983.10.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 04:47:53PM -0700, Daniel McNeil wrote:
> On Mon, 2003-10-20 at 07:27, Suparna Bhattacharya wrote:
> > On Fri, Oct 17, 2003 at 04:12:58PM -0700, Daniel McNeil wrote:
> > > 
> > > I still had apply suparna's direct-io.c patch to prevent oopses.
> > > Suparna, you said the patch was not the complete patch, do you have
> > > the complete patch?
> > 
> > Not yet.
> > A complete patch would need to address one more case that's rather
> > tricky to solve -- the case where a single dio request covers an 
> > allocated region followed by a hole.
> > 
> > Besides that there is a pending bug to address -- i.e to avoid
> > dropping i_sem during the actual i/o in the case where we are
> > extending the file (an intervening buffered write could extend
> > i_size, exposing uninitialized blocks). For AIO-DIO this means 
> > forcing the i/o to be synchronous for this case (as also for 
> > the case where we are overwriting an allocated region followed 
> > by a hole). Until we can use i/o barriers.
> > 
> > I was playing with a retry-based implementation for AIO-DIO,
> > where the first (tricky) case above becomes simple to handle ...
> > But didn't get a chance to work much on this during the last 
> > few days. I actually do have a patch, but there are occasional 
> > hangs with a lot of AIO-DIO writes to an ext3 filesystem in 
> > particular, that I can't explain as yet.
> > 

OK, here is the patch I was talking about, in case you get a 
chance to experiment with it. (you'll need to reverse the 
earlier incomplete fix for overwriting holes if you apply
this).

It converts AIO-DIO to be based on the retry model, and addresses
the following known remaining loopholes in the current DIO
code:

1) For DIO file extends, we can't drop i_sem during the actual
   i/o  -- intermediate writes could extend i_size exposing
   unwritten blocks
2) For AIO-DIO extends, we are updating i_size before i/o 
   completes --- could expose unwritten blocks to intermediate
   reads
3) For AIO-DIO writes to holes, finished_one_bio causes 
   aio_complete() (and dio end_io) to be called before 
   falling back to buffered i/o. 
4) For AIO-DIO writes to allocated blocks followed by a hole,
   we've submitted BIOs for some of the i/o before we come
   across the hole and then we fallback to buffered i/o
   without waiting for that i/o to complete.

This patch avoids dropping i_sem in between during synchronous 
writes altogether. I had initially skipped dropping i_sem in the
case of file extends only, but observed some hangs with ext3
... couldn't be sure if it was really OK to drop i_sem before
completing the ext3_stop_journal. In the AIO case i_sem is
released during the i/o when the request overwrites existing
blocks only.

The second thing it does is to wait for i/o to complete even
for AIO, if any part of the request involves overwriting a hole 
or extending the file (takes care of 1, 2 and 4). Using the
retry model makes it possible to switch from async to sync
wait if appropriate _after_ the i/o is issued.


Regards
Suparna

diffstat aio-dio-retry.patch

 fs/aio.c            |    9 ++
 fs/direct-io.c      |  177 ++++++++++++++++++++++++++--------------------------
 include/linux/aio.h |    2 
 mm/filemap.c        |    4 -
 4 files changed, 100 insertions(+), 92 deletions(-)


diff -urp linux-2.6.0-test6-mm4/fs/aio.c 260t6mm4/fs/aio.c
--- linux-2.6.0-test6-mm4/fs/aio.c	Tue Oct 21 19:20:50 2003
+++ 260t6mm4/fs/aio.c	Tue Oct 21 19:09:26 2003
@@ -408,6 +408,7 @@ static struct kiocb *__aio_get_req(struc
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_user_obj = NULL;
+	req->ki_private = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
@@ -700,8 +701,12 @@ static ssize_t aio_run_iocb(struct kiocb
 	iocb->ki_retry = NULL;
 	spin_unlock_irq(&ctx->ctx_lock);
 
-	/* Quit retrying if the i/o has been cancelled */
-	if (kiocbIsCancelled(iocb)) {
+	/* 
+	 * Quit retrying if the i/o has been cancelled unless
+	 * there is some private iocb state that is still being 
+	 * referenced
+	 */
+	if (kiocbIsCancelled(iocb) && !iocb->ki_private) {
 		ret = -EINTR;
 		aio_complete(iocb, ret, 0);
 		/* must not access the iocb after this */
diff -urp linux-2.6.0-test6-mm4/fs/direct-io.c 260t6mm4/fs/direct-io.c
--- linux-2.6.0-test6-mm4/fs/direct-io.c	Tue Oct 21 18:58:52 2003
+++ 260t6mm4/fs/direct-io.c	Tue Oct 21 19:14:55 2003
@@ -118,11 +118,10 @@ struct dio {
 	atomic_t bios_in_flight;	/* nr bios in flight */
 	spinlock_t bio_list_lock;	/* protects bio_list */
 	struct bio *bio_list;		/* singly linked via bi_private */
-	struct task_struct *waiter;	/* waiting task (NULL if none) */
+	wait_queue_head_t wqh;		/* to wait on in-flight bios */
 
 	/* AIO related stuff */
 	struct kiocb *iocb;		/* kiocb */
-	int is_async;			/* is IO async ? */
 	int result;			/* IO result */
 };
 
@@ -218,33 +217,12 @@ static void dio_complete(struct dio *dio
  * Called when a BIO has been processed.  If the count goes to zero then IO is
  * complete and we can signal this to the AIO layer.
  */
-static void finished_one_bio(struct dio *dio)
+static inline void finished_one_bio(struct dio *dio)
 {
-	if (atomic_dec_and_test(&dio->bio_count)) {
-		if (dio->is_async) {
-			dio_complete(dio, dio->block_in_file << dio->blkbits,
-					dio->result);
-			aio_complete(dio->iocb, dio->result, 0);
-			kfree(dio);
-		}
-	}
+	atomic_dec(&dio->bio_count);
 }
 
 static int dio_bio_complete(struct dio *dio, struct bio *bio);
-/*
- * Asynchronous IO callback. 
- */
-static int dio_bio_end_aio(struct bio *bio, unsigned int bytes_done, int error)
-{
-	struct dio *dio = bio->bi_private;
-
-	if (bio->bi_size)
-		return 1;
-
-	/* cleanup the bio */
-	dio_bio_complete(dio, bio);
-	return 0;
-}
 
 /*
  * The BIO completion handler simply queues the BIO up for the process-context
@@ -265,8 +243,8 @@ static int dio_bio_end_io(struct bio *bi
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
 	atomic_dec(&dio->bios_in_flight);
-	if (dio->waiter && atomic_read(&dio->bios_in_flight) == 0)
-		wake_up_process(dio->waiter);
+	if (atomic_read(&dio->bios_in_flight) == 0)
+		wake_up(&dio->wqh);
 	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
 	return 0;
 }
@@ -283,10 +261,7 @@ dio_bio_alloc(struct dio *dio, struct bl
 
 	bio->bi_bdev = bdev;
 	bio->bi_sector = first_sector;
-	if (dio->is_async)
-		bio->bi_end_io = dio_bio_end_aio;
-	else
-		bio->bi_end_io = dio_bio_end_io;
+	bio->bi_end_io = dio_bio_end_io;
 
 	dio->bio = bio;
 	return 0;
@@ -304,8 +279,6 @@ static void dio_bio_submit(struct dio *d
 	bio->bi_private = dio;
 	atomic_inc(&dio->bio_count);
 	atomic_inc(&dio->bios_in_flight);
-	if (dio->is_async && dio->rw == READ)
-		bio_set_pages_dirty(bio);
 	submit_bio(dio->rw, bio);
 
 	dio->bio = NULL;
@@ -324,23 +297,29 @@ static void dio_cleanup(struct dio *dio)
 /*
  * Wait for the next BIO to complete.  Remove it and return it.
  */
-static struct bio *dio_await_one(struct dio *dio)
+static struct bio *dio_await_one(struct dio *dio, wait_queue_t *wait)
 {
 	unsigned long flags;
 	struct bio *bio;
 
 	spin_lock_irqsave(&dio->bio_list_lock, flags);
-	while (dio->bio_list == NULL) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (dio->bio_list == NULL) {
-			dio->waiter = current;
+	if (dio->bio_list == NULL) {
+		DEFINE_WAIT(local_wait);
+
+		if (!wait)
+			wait = &local_wait;
+		do {	
+			prepare_to_wait(&dio->wqh, wait, TASK_UNINTERRUPTIBLE);
+			if (dio->bio_list != NULL)
+				break;
 			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
 			blk_run_queues();
+			if (!is_sync_wait(wait))
+				return ERR_PTR(-EIOCBRETRY);
 			io_schedule();
 			spin_lock_irqsave(&dio->bio_list_lock, flags);
-			dio->waiter = NULL;
-		}
-		set_current_state(TASK_RUNNING);
+		} while (dio->bio_list == NULL);
+		finish_wait(&dio->wqh, wait);
 	}
 	bio = dio->bio_list;
 	dio->bio_list = bio->bi_private;
@@ -360,26 +339,25 @@ static int dio_bio_complete(struct dio *
 	if (!uptodate)
 		dio->result = -EIO;
 
-	if (dio->is_async && dio->rw == READ) {
-		bio_check_pages_dirty(bio);	/* transfers ownership */
-	} else {
-		for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
-			struct page *page = bvec[page_no].bv_page;
+	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
+		struct page *page = bvec[page_no].bv_page;
 
-			if (dio->rw == READ)
-				set_page_dirty_lock(page);
-			page_cache_release(page);
-		}
-		bio_put(bio);
+		if (dio->rw == READ)
+			set_page_dirty_lock(page);
+		page_cache_release(page);
 	}
+	bio_put(bio);
+
 	finished_one_bio(dio);
 	return uptodate ? 0 : -EIO;
 }
 
 /*
  * Wait on and process all in-flight BIOs.
+ * Complete and free the dio once all are done.
  */
-static int dio_await_completion(struct dio *dio)
+static int dio_await_completion(struct dio *dio, loff_t offset, 
+	wait_queue_t *wait)
 {
 	int ret = 0;
 
@@ -387,13 +365,25 @@ static int dio_await_completion(struct d
 		dio_bio_submit(dio);
 
 	while (atomic_read(&dio->bio_count)) {
-		struct bio *bio = dio_await_one(dio);
+		struct bio *bio = dio_await_one(dio, wait);
 		int ret2;
 
+		if (IS_ERR(bio)) {
+			ret = PTR_ERR(bio);
+			return ret;
+		}
 		ret2 = dio_bio_complete(dio, bio);
 		if (ret == 0)
 			ret = ret2;
 	}
+	if (ret == 0)
+		ret = dio->page_errors;
+	if ((ret == 0) && dio->result)
+		ret = dio->result;
+	dio_complete(dio, offset, ret);
+	dio->iocb->ki_private = NULL;
+	kfree(dio);
+
 	return ret;
 }
 
@@ -875,8 +865,12 @@ direct_io_worker(int rw, struct kiocb *i
 	int ret = 0;
 	int ret2;
 	size_t bytes;
+	loff_t end = offset;
+	struct dio *old_dio = iocb->ki_private;
+	wait_queue_t *io_wait = current->io_wait;
 
-	dio->is_async = !is_sync_kiocb(iocb);
+	if (dio == old_dio) /* i/o has already been issued for this dio */
+		goto do_wait;
 
 	dio->bio = NULL;
 	dio->inode = inode;
@@ -899,6 +893,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->page_errors = 0;
 	dio->result = 0;
 	dio->iocb = iocb;
+	iocb->ki_private = dio;
 
 	/*
 	 * BIO completion state.
@@ -912,7 +907,7 @@ direct_io_worker(int rw, struct kiocb *i
 	atomic_set(&dio->bios_in_flight, 0);
 	spin_lock_init(&dio->bio_list_lock);
 	dio->bio_list = NULL;
-	dio->waiter = NULL;
+	init_waitqueue_head(&dio->wqh);
 
 	dio->pages_in_io = 0;
 	for (seg = 0; seg < nr_segs; seg++) 
@@ -920,7 +915,7 @@ direct_io_worker(int rw, struct kiocb *i
 
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
-		bytes = iov[seg].iov_len;
+		end += bytes = iov[seg].iov_len;
 
 		/* Index into the first page of the first block */
 		dio->first_block_in_page = (user_addr & ~PAGE_MASK) >> blkbits;
@@ -968,41 +963,50 @@ direct_io_worker(int rw, struct kiocb *i
 		dio_bio_submit(dio);
 
 	/*
-	 * All new block allocations have been performed.  We can let i_sem
-	 * go now.
+	 * If this is a file extend we have to hold i_sem throughout 
+	 * till the data hits the disk and i_size is updated, to avoid 
+	 * exposing uninitialized blocks. 
+	 *
+	 * For AIO file extends we just take the easy way out and wait 
+	 * synchronously in this situation; typically databases
+	 * would have pre-allocated the file before issuing AIO.
+	 * We may have to change this if there are real world 
+	 * users of file extending AIO who are affected.
+	 *
+	 * Secondly if we ran into a hole after submitting i/o for 
+	 * some of the blocks, we wait for issued i/o to complete 
+	 * before falling back to buffered i/o.
 	 */
-	if (dio->needs_locking)
+	if ((end > i_size_read(dio->inode)) || ret) {
+		/* switch to synchronous wait even if we are in AIO */
+		io_wait = NULL;
+	}
+	/*
+	 * All block lookups have been performed.  We can let i_sem
+	 * go now if this is a read request.
+	 */
+	if ((rw == READ) && dio->needs_locking)
 		up(&dio->inode->i_sem);
 
 	/*
 	 * OK, all BIOs are submitted, so we can decrement bio_count to truly
 	 * reflect the number of to-be-processed BIOs.
 	 */
-	if (dio->is_async) {
-		if (ret == 0)
-			ret = dio->result;	/* Bytes written */
-		finished_one_bio(dio);		/* This can free the dio */
-		blk_run_queues();
-	} else {
-		finished_one_bio(dio);
-		ret2 = dio_await_completion(dio);
-		if (ret == 0)
-			ret = ret2;
-		if (ret == 0)
-			ret = dio->page_errors;
-		if (ret == 0 && dio->result) {
-			loff_t i_size = i_size_read(inode);
+	finished_one_bio(dio);
 
-			ret = dio->result;
-			/*
-			 * Adjust the return value if the read crossed a
-			 * non-block-aligned EOF.
-			 */
-			if (rw == READ && (offset + ret > i_size))
-				ret = i_size - offset;
-		}
-		dio_complete(dio, offset, ret);
-		kfree(dio);
+do_wait:
+	ret2 = dio_await_completion(dio, offset, io_wait);
+	if (ret == 0)
+		ret = ret2;
+	if (ret == 0) {
+		loff_t i_size = i_size_read(inode);
+
+		/*
+		 * Adjust the return value if the read crossed a
+		 * non-block-aligned EOF.
+		 */
+		if (rw == READ && (offset + ret > i_size))
+			ret = i_size - offset;
 	}
 	return ret;
 }
@@ -1028,7 +1032,7 @@
 	unsigned bdev_blkbits = 0;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
 	ssize_t retval = -EINVAL;
-	struct dio *dio;
+	struct dio *dio = iocb->ki_private;
 	int needs_locking;
 
 	if (bdev)
@@ -1055,6 +1061,8 @@ __blockdev_direct_IO(int rw, struct kioc
 		}
 	}
 
+	if (dio)
+		goto have_dio;	
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	retval = -ENOMEM;
 	if (!dio)
@@ -1081,10 +1089,9 @@ __blockdev_direct_IO(int rw, struct kioc
 	}
 	dio->needs_locking = needs_locking;
 
+have_dio:
 	retval = direct_io_worker(rw, iocb, inode, iov, offset,
 				nr_segs, blkbits, get_blocks, end_io, dio);
-	if (needs_locking && rw == WRITE)
-		down(&inode->i_sem);
 out:
 	return retval;
 }
diff -urp linux-2.6.0-test6-mm4/include/linux/aio.h 260t6mm4/include/linux/aio.h
--- linux-2.6.0-test6-mm4/include/linux/aio.h	Tue Oct 21 18:58:55 2003
+++ 260t6mm4/include/linux/aio.h	Tue Oct 14 21:36:43 2003
@@ -74,6 +74,7 @@ struct kiocb {
 	char 			*ki_buf;	/* remaining iocb->aio_buf */
 	size_t			ki_left; 	/* remaining bytes */
 	wait_queue_t		ki_wait;
+	void			*ki_private;
 	long			ki_retried; 	/* just for testing */
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
@@ -94,6 +95,7 @@ struct kiocb {
 		(x)->ki_user_obj = tsk;			\
 		(x)->ki_user_data = 0;			\
 		init_wait((&(x)->ki_wait));		\
+		(x)->ki_private = NULL;			\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
diff -urp linux-2.6.0-test6-mm4/mm/filemap.c 260t6mm4/mm/filemap.c
--- linux-2.6.0-test6-mm4/mm/filemap.c	Tue Oct 21 18:58:56 2003
+++ 260t6mm4/mm/filemap.c	Tue Oct 21 19:16:20 2003
@@ -926,8 +926,6 @@ __generic_file_aio_read(struct kiocb *io
 		if (pos < size) {
 			retval = generic_file_direct_IO(READ, iocb,
 						iov, pos, nr_segs);
-			if (retval >= 0 && !is_sync_kiocb(iocb))
-				retval = -EIOCBQUEUED;
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
@@ -1892,8 +1890,6 @@ __generic_file_aio_write_nolock(struct k
 		 */
 		if (written >= 0 && file->f_flags & O_SYNC)
 			status = generic_osync_inode(inode, mapping, OSYNC_METADATA);
-		if (written >= 0 && !is_sync_kiocb(iocb))
-			written = -EIOCBQUEUED;
 		if (written != -ENOTBLK)
 			goto out_status;
 		/*
