Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423990AbWKIBQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423990AbWKIBQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423981AbWKIBQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:16:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:3501 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161757AbWKIBQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:16:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=iRM5dwC8vy1IFAyy5BZkgS5wxuVwZzb50UbGzLLw5JkOWvqp2854ih4zyH5LeLWpauFuKdfApOzsR0yJMIg/ocsvMDS1rS5015+izJ50dW4FruzDOQHhVj9lk+9qn53QxEeajL89ZPHAdzSNK5lI6FDLlsBk2QB2OV0ejCExnRw=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] direct-io: unify sync and async completion paths
In-Reply-To: <11630349713427-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Thu, 9 Nov 2006 10:16:11 +0900
Message-Id: <11630349713462-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: zach.brown@oracle.com, pbadari@us.ibm.com, suparna@in.ibm.com,
       jmoyer@redhat.com, akpm@osdl.org, cwyang@aratech.co.kr,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

direct-io used separate paths for sync and async request completion.
For sync requests, completion callback queues completed bios and the
issuing thread dequeues and completes them.  For async requests,
completion callback handles all the completion.

Two separate completion paths add considerable complexity.
Furthermore, some of async write requests (file-extending write and
write to hole) should be handled synchronously.  File-extending write
is treated as sync request w/ special completion handling while
write-to-hole has another separate wait logic inside async completion
path.

Unfortunately, the above doesn't cover all.  The current code can't
handle requests which are partially valid.  If an async request has
invalid pages after valid pages, the valid part is issued as async IO
but __blockdev_direct_IO() returns error code.  This causes double
completion and thus oops.  Fixing this bug requires adding yet another
waiting logic to already fragile async completion path.

To relieve the situation, this patch unifies sync and async completion
paths.  Whether to wait for completion or not is determined soley
inside direct_io_worker() proper and both sync and async waits are
handled by the same code.

The only behavior change this patch makes is how pages are made dirty
after sync reads.  As read sync requests are handled by the same async
path, they are also pre-dirtied before issuing and re-dirtied using
bio_check_pages_dirty() on completion.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/direct-io.c |  314 ++++++++++++++------------------------------------------
 1 files changed, 77 insertions(+), 237 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 98d8c2e..c558aa6 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -85,7 +85,6 @@ struct dio {
 	sector_t final_block_in_request;/* doesn't change */
 	unsigned first_block_in_page;	/* doesn't change, Used only once */
 	int boundary;			/* prev block is at a boundary */
-	int reap_counter;		/* rate limit reaping */
 	get_block_t *get_block;		/* block mapping function */
 	dio_iodone_t *end_io;		/* IO completion function */
 	sector_t final_block_in_bio;	/* current final block in bio + 1 */
@@ -122,13 +121,10 @@ struct dio {
 	/* BIO completion state */
 	spinlock_t bio_lock;		/* protects BIO fields below */
 	int bio_count;			/* nr bios to be completed */
-	int bios_in_flight;		/* nr bios in flight */
-	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
 
 	/* AIO related stuff */
 	struct kiocb *iocb;		/* kiocb */
-	int is_async;			/* is IO async ? */
 	int io_error;			/* IO error in completion path */
 	ssize_t result;                 /* IO result */
 };
@@ -256,78 +252,59 @@ static void finished_one_bio(struct dio
 	unsigned long flags;
 
 	spin_lock_irqsave(&dio->bio_lock, flags);
-	if (dio->bio_count == 1) {
-		if (dio->is_async) {
-			ssize_t ret = dio_determine_result(dio, 0);
-			/*
-			 * Last reference to the dio is going away.
-			 * Drop spinlock and complete the DIO.
-			 */
-			spin_unlock_irqrestore(&dio->bio_lock, flags);
+	if (dio->bio_count == 2) {
+		/*
+		 * If we're doing synchronous completion, the waiter
+		 * is holding an extra bio_count making us the last
+		 * bio.  Wake waiter up.
+		 */
+		if (dio->waiter)
+			wake_up_process(dio->waiter);
+	} else if (dio->bio_count == 1) {
+		ssize_t ret = dio_determine_result(dio, 0);
 
-			dio_complete(dio, ret);
+		/*
+		 * Last reference to the dio is going away.
+		 * Drop spinlock and complete the DIO.
+		 */
+		spin_unlock_irqrestore(&dio->bio_lock, flags);
 
-			/* Complete AIO later if falling back to buffered i/o */
-			if (dio->result == dio->size ||
-				((dio->rw == READ) && dio->result)) {
-				aio_complete(dio->iocb, ret, 0);
-				kfree(dio);
-				return;
-			} else {
-				/*
-				 * Falling back to buffered
-				 */
-				spin_lock_irqsave(&dio->bio_lock, flags);
-				dio->bio_count--;
-				if (dio->waiter)
-					wake_up_process(dio->waiter);
-				spin_unlock_irqrestore(&dio->bio_lock, flags);
-				return;
-			}
-		}
+		dio_complete(dio, ret);
+
+		/* Complete AIO */
+		BUG_ON(!(dio->result == dio->size ||
+			 ((dio->rw == READ) && dio->result)));
+		aio_complete(dio->iocb, ret, 0);
+		kfree(dio);
+		return;
 	}
 	dio->bio_count--;
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 }
 
-static int dio_bio_complete(struct dio *dio, struct bio *bio);
-/*
- * Asynchronous IO callback. 
- */
-static int dio_bio_end_aio(struct bio *bio, unsigned int bytes_done, int error)
+static int dio_bio_end_io(struct bio *bio, unsigned int bytes_done, int error)
 {
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 	struct dio *dio = bio->bi_private;
+	struct bio_vec *bvec = bio->bi_io_vec;
+	int page_no;
 
 	if (bio->bi_size)
 		return 1;
 
-	/* cleanup the bio */
-	dio_bio_complete(dio, bio);
-	return 0;
-}
+	if (!uptodate)
+		dio->io_error = -EIO;
 
-/*
- * The BIO completion handler simply queues the BIO up for the process-context
- * handler.
- *
- * During I/O bi_private points at the dio.  After I/O, bi_private is used to
- * implement a singly-linked list of completed BIOs, at dio->bio_list.
- */
-static int dio_bio_end_io(struct bio *bio, unsigned int bytes_done, int error)
-{
-	struct dio *dio = bio->bi_private;
-	unsigned long flags;
+	if (dio->rw == READ)
+		bio_check_pages_dirty(bio);	/* transfers ownership */
+	else {
+		for (page_no = 0; page_no < bio->bi_vcnt; page_no++)
+			page_cache_release(bvec[page_no].bv_page);
+		bio_put(bio);
+	}
 
-	if (bio->bi_size)
-		return 1;
+	finished_one_bio(dio);
 
-	spin_lock_irqsave(&dio->bio_lock, flags);
-	bio->bi_private = dio->bio_list;
-	dio->bio_list = bio;
-	dio->bios_in_flight--;
-	if (dio->waiter && dio->bios_in_flight == 0)
-		wake_up_process(dio->waiter);
-	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	return 0;
 }
 
@@ -343,10 +320,7 @@ dio_bio_alloc(struct dio *dio, struct bl
 
 	bio->bi_bdev = bdev;
 	bio->bi_sector = first_sector;
-	if (dio->is_async)
-		bio->bi_end_io = dio_bio_end_aio;
-	else
-		bio->bi_end_io = dio_bio_end_io;
+	bio->bi_end_io = dio_bio_end_io;
 
 	dio->bio = bio;
 	return 0;
@@ -365,9 +339,8 @@ static void dio_bio_submit(struct dio *d
 	bio->bi_private = dio;
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	dio->bio_count++;
-	dio->bios_in_flight++;
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
-	if (dio->is_async && dio->rw == READ)
+	if (dio->rw == READ)
 		bio_set_pages_dirty(bio);
 	submit_bio(dio->rw, bio);
 
@@ -385,117 +358,6 @@ static void dio_cleanup(struct dio *dio)
 }
 
 /*
- * Wait for the next BIO to complete.  Remove it and return it.
- */
-static struct bio *dio_await_one(struct dio *dio)
-{
-	unsigned long flags;
-	struct bio *bio;
-
-	spin_lock_irqsave(&dio->bio_lock, flags);
-	while (dio->bio_list == NULL) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (dio->bio_list == NULL) {
-			dio->waiter = current;
-			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			blk_run_address_space(dio->inode->i_mapping);
-			io_schedule();
-			spin_lock_irqsave(&dio->bio_lock, flags);
-			dio->waiter = NULL;
-		}
-		set_current_state(TASK_RUNNING);
-	}
-	bio = dio->bio_list;
-	dio->bio_list = bio->bi_private;
-	spin_unlock_irqrestore(&dio->bio_lock, flags);
-	return bio;
-}
-
-/*
- * Process one completed BIO.  No locks are held.
- */
-static int dio_bio_complete(struct dio *dio, struct bio *bio)
-{
-	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
-	struct bio_vec *bvec = bio->bi_io_vec;
-	int page_no;
-
-	if (!uptodate)
-		dio->io_error = -EIO;
-
-	if (dio->is_async && dio->rw == READ) {
-		bio_check_pages_dirty(bio);	/* transfers ownership */
-	} else {
-		for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
-			struct page *page = bvec[page_no].bv_page;
-
-			if (dio->rw == READ && !PageCompound(page))
-				set_page_dirty_lock(page);
-			page_cache_release(page);
-		}
-		bio_put(bio);
-	}
-	finished_one_bio(dio);
-	return uptodate ? 0 : -EIO;
-}
-
-/*
- * Wait on and process all in-flight BIOs.
- */
-static int dio_await_completion(struct dio *dio)
-{
-	int ret = 0;
-
-	if (dio->bio)
-		dio_bio_submit(dio);
-
-	/*
-	 * The bio_lock is not held for the read of bio_count.
-	 * This is ok since it is the dio_bio_complete() that changes
-	 * bio_count.
-	 */
-	while (dio->bio_count) {
-		struct bio *bio = dio_await_one(dio);
-		int ret2;
-
-		ret2 = dio_bio_complete(dio, bio);
-		if (ret == 0)
-			ret = ret2;
-	}
-	return ret;
-}
-
-/*
- * A really large O_DIRECT read or write can generate a lot of BIOs.  So
- * to keep the memory consumption sane we periodically reap any completed BIOs
- * during the BIO generation phase.
- *
- * This also helps to limit the peak amount of pinned userspace memory.
- */
-static int dio_bio_reap(struct dio *dio)
-{
-	int ret = 0;
-
-	if (dio->reap_counter++ >= 64) {
-		while (dio->bio_list) {
-			unsigned long flags;
-			struct bio *bio;
-			int ret2;
-
-			spin_lock_irqsave(&dio->bio_lock, flags);
-			bio = dio->bio_list;
-			dio->bio_list = bio->bi_private;
-			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			ret2 = dio_bio_complete(dio, bio);
-			if (ret == 0)
-				ret = ret2;
-		}
-		dio->reap_counter = 0;
-	}
-	return ret;
-}
-
-/*
  * Call into the fs to map some more disk blocks.  We record the current number
  * of available blocks at dio->blocks_available.  These are in units of the
  * fs blocksize, (1 << inode->i_blkbits).
@@ -574,15 +436,11 @@ static int dio_new_bio(struct dio *dio,
 	sector_t sector;
 	int ret, nr_pages;
 
-	ret = dio_bio_reap(dio);
-	if (ret)
-		goto out;
 	sector = start_sector << (dio->blkbits - 9);
 	nr_pages = min(dio->pages_in_io, bio_get_nr_vecs(dio->map_bh.b_bdev));
 	BUG_ON(nr_pages <= 0);
 	ret = dio_bio_alloc(dio, dio->map_bh.b_bdev, sector, nr_pages);
 	dio->boundary = 0;
-out:
 	return ret;
 }
 
@@ -968,6 +826,7 @@ direct_io_worker(int rw, struct kiocb *i
 	ssize_t ret = 0;
 	ssize_t ret2;
 	size_t bytes;
+	unsigned long flags;
 
 	dio->bio = NULL;
 	dio->inode = inode;
@@ -981,7 +840,6 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->cur_page = NULL;
 
 	dio->boundary = 0;
-	dio->reap_counter = 0;
 	dio->get_block = get_block;
 	dio->end_io = end_io;
 	dio->map_bh.b_private = NULL;
@@ -1003,9 +861,7 @@ direct_io_worker(int rw, struct kiocb *i
 	 * still submitting BIOs.
 	 */
 	dio->bio_count = 1;
-	dio->bios_in_flight = 0;
 	spin_lock_init(&dio->bio_lock);
-	dio->bio_list = NULL;
 	dio->waiter = NULL;
 
 	/*
@@ -1094,59 +950,52 @@ direct_io_worker(int rw, struct kiocb *i
 	if ((rw == READ) && (dio->lock_type == DIO_LOCKING))
 		mutex_unlock(&dio->inode->i_mutex);
 
+	blk_run_address_space(inode->i_mapping);
+
 	/*
-	 * OK, all BIOs are submitted, so we can decrement bio_count to truly
-	 * reflect the number of to-be-processed BIOs.
+	 * If this request can be completed asynchronously, drop the
+	 * extra reference and return.
 	 */
-	if (dio->is_async) {
-		int should_wait = 0;
-
-		if (dio->result < dio->size && (rw & WRITE)) {
-			dio->waiter = current;
-			should_wait = 1;
-		}
+	if (!is_sync_kiocb(iocb) &&
+	    ((rw == READ) || (dio->result == dio->size &&
+			      offset + dio->size <= dio->i_size))) {
 		if (ret == 0)
 			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
-		blk_run_address_space(inode->i_mapping);
-		if (should_wait) {
-			unsigned long flags;
-			/*
-			 * Wait for already issued I/O to drain out and
-			 * release its references to user-space pages
-			 * before returning to fallback on buffered I/O
-			 */
+		return ret;
+	}
 
-			spin_lock_irqsave(&dio->bio_lock, flags);
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			while (dio->bio_count) {
-				spin_unlock_irqrestore(&dio->bio_lock, flags);
-				io_schedule();
-				spin_lock_irqsave(&dio->bio_lock, flags);
-				set_current_state(TASK_UNINTERRUPTIBLE);
-			}
-			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			set_current_state(TASK_RUNNING);
-			kfree(dio);
-		}
-	} else {
-		finished_one_bio(dio);
-		dio_await_completion(dio);
+	/*
+	 * We need to wait for the request to complete if the request
+	 * is synchronous or an async write which writes to hole or
+	 * extends the file.
+	 *
+	 * For file extending writes updating i_size before data
+	 * writeouts complete can expose uninitialized blocks. So even
+	 * for AIO, we need to wait for i/o to complete before
+	 * returning in this case.
+	 */
+	spin_lock_irqsave(&dio->bio_lock, flags);
+	dio->waiter = current;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	while (dio->bio_count > 1) {
+		spin_unlock_irqrestore(&dio->bio_lock, flags);
+		io_schedule();
+		spin_lock_irqsave(&dio->bio_lock, flags);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+	}
+	spin_unlock_irqrestore(&dio->bio_lock, flags);
+	set_current_state(TASK_RUNNING);
 
-		ret = dio_determine_result(dio, ret);
+	ret = dio_determine_result(dio, ret);
 
-		dio_complete(dio, ret);
+	dio_complete(dio, ret);
 
-		/* We could have also come here on an AIO file extend */
-		if (!is_sync_kiocb(iocb) && (rw & WRITE) &&
-		    ret >= 0 && dio->result == dio->size)
-			/*
-			 * For AIO writes where we have completed the
-			 * i/o, we have to mark the the aio complete.
-			 */
-			aio_complete(iocb, ret, 0);
-		kfree(dio);
-	}
+	/* complete file-extending async write */
+	if (!is_sync_kiocb(iocb) && ret == dio->size)
+		aio_complete(dio->iocb, ret, 0);
+
+	kfree(dio);
 	return ret;
 }
 
@@ -1261,15 +1110,6 @@ __blockdev_direct_IO(int rw, struct kioc
 			down_read_non_owner(&inode->i_alloc_sem);
 	}
 
-	/*
-	 * For file extending writes updating i_size before data
-	 * writeouts complete can expose uninitialized blocks. So
-	 * even for AIO, we need to wait for i/o to complete before
-	 * returning in this case.
-	 */
-	dio->is_async = !is_sync_kiocb(iocb) && !((rw & WRITE) &&
-		(end > i_size_read(inode)));
-
 	retval = direct_io_worker(rw, iocb, inode, iov, offset,
 				nr_segs, blkbits, get_block, end_io, dio);
 
-- 
1.4.3.3


