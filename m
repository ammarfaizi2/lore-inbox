Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTLaWlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbTLaWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:41:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:13448 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265269AbTLaWl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:41:26 -0500
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, janetmor@us.ibm.com,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	 <20031216180319.6d9670e4.akpm@osdl.org> <20031231091828.GA4012@in.ibm.com>
	 <20031231013521.79920efd.akpm@osdl.org> <20031231095503.GA4069@in.ibm.com>
	 <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com>
	 <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com>
	 <20031231025309.6bc8ca20.akpm@osdl.org>
	 <20031231025410.699a3317.akpm@osdl.org>
	 <20031231031736.0416808f.akpm@osdl.org>
	 <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-UYdXUQHypHwERH5KGQU3"
Organization: 
Message-Id: <1072910475.712.74.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Dec 2003 14:41:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UYdXUQHypHwERH5KGQU3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is an update of AIO fallback patch and with the bio_count race
fixed by changing bio_list_lock into bio_lock and using that for all
the bio fields.  I changed bio_count and bios_in_flight from atomics
into int.  They are now proctected by the bio_lock.  I fixed the race,
by in finished_one_bio() by leaving the bio_count at 1 until after the
dio_complete() and then do the bio_count decrement and wakeup holding
the bio_lock.

I re-diffed to 2.6.1-rc1-mm1.

I've been stressing this code for several weeks.

Daniel

--=-UYdXUQHypHwERH5KGQU3
Content-Disposition: attachment; filename=linux-2.6.1-rc1-mm1.aiodio_fallback_bio_count.patch
Content-Type: text/x-patch; name=linux-2.6.1-rc1-mm1.aiodio_fallback_bio_count.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff linux-2.6.1-rc1-mm1/fs/direct-io.c linux-2.6.1-rc1-mm1.ddm/fs/direct-io.c
--- linux-2.6.1-rc1-mm1/fs/direct-io.c	2003-12-31 10:52:45.940193469 -0800
+++ linux-2.6.1-rc1-mm1.ddm/fs/direct-io.c	2003-12-31 13:29:51.260432002 -0800
@@ -74,6 +74,7 @@ struct dio {
 					   been performed at the start of a
 					   write */
 	int pages_in_io;		/* approximate total IO pages */
+	size_t	size;			/* total request size (doesn't change)*/
 	sector_t block_in_file;		/* Current offset into the underlying
 					   file in dio_block units. */
 	unsigned blocks_available;	/* At block_in_file.  changes */
@@ -115,9 +116,9 @@ struct dio {
 	int page_errors;		/* errno from get_user_pages() */
 
 	/* BIO completion state */
-	atomic_t bio_count;		/* nr bios to be completed */
-	atomic_t bios_in_flight;	/* nr bios in flight */
-	spinlock_t bio_list_lock;	/* protects bio_list */
+	spinlock_t bio_lock;		/* protects BIO fields below */
+	int bio_count;			/* nr bios to be completed */
+	int bios_in_flight;		/* nr bios in flight */
 	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
 
@@ -221,20 +222,38 @@ static void dio_complete(struct dio *dio
  */
 static void finished_one_bio(struct dio *dio)
 {
-	if (atomic_dec_and_test(&dio->bio_count)) {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dio->bio_lock, flags);
+	if (dio->bio_count == 1) {
 		if (dio->is_async) {
+			/*
+			 * Last reference to the dio is going away.
+			 * Drop spinlock and complete the DIO.
+			 */
+			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			dio_complete(dio, dio->block_in_file << dio->blkbits,
 					dio->result);
 			/* Complete AIO later if falling back to buffered i/o */
-			if (dio->result != -ENOTBLK) {
+			if (dio->result >= dio->size || dio->rw == READ) {
 				aio_complete(dio->iocb, dio->result, 0);
 				kfree(dio);
+				return;
 			} else {
+				/*
+				 * Falling back to buffered
+				 */
+				spin_lock_irqsave(&dio->bio_lock, flags);
+				dio->bio_count--;
 				if (dio->waiter)
 					wake_up_process(dio->waiter);
+				spin_unlock_irqrestore(&dio->bio_lock, flags);
+				return;
 			}
 		}
 	}
+	dio->bio_count--;
+	spin_unlock_irqrestore(&dio->bio_lock, flags);
 }
 
 static int dio_bio_complete(struct dio *dio, struct bio *bio);
@@ -268,13 +287,13 @@ static int dio_bio_end_io(struct bio *bi
 	if (bio->bi_size)
 		return 1;
 
-	spin_lock_irqsave(&dio->bio_list_lock, flags);
+	spin_lock_irqsave(&dio->bio_lock, flags);
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
-	atomic_dec(&dio->bios_in_flight);
-	if (dio->waiter && atomic_read(&dio->bios_in_flight) == 0)
+	dio->bios_in_flight--;
+	if (dio->waiter && dio->bios_in_flight == 0)
 		wake_up_process(dio->waiter);
-	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	return 0;
 }
 
@@ -307,10 +326,13 @@ dio_bio_alloc(struct dio *dio, struct bl
 static void dio_bio_submit(struct dio *dio)
 {
 	struct bio *bio = dio->bio;
+	unsigned long flags;
 
 	bio->bi_private = dio;
-	atomic_inc(&dio->bio_count);
-	atomic_inc(&dio->bios_in_flight);
+	spin_lock_irqsave(&dio->bio_lock, flags);
+	dio->bio_count++;
+	dio->bios_in_flight++;
+	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	if (dio->is_async && dio->rw == READ)
 		bio_set_pages_dirty(bio);
 	submit_bio(dio->rw, bio);
@@ -336,22 +358,22 @@ static struct bio *dio_await_one(struct 
 	unsigned long flags;
 	struct bio *bio;
 
-	spin_lock_irqsave(&dio->bio_list_lock, flags);
+	spin_lock_irqsave(&dio->bio_lock, flags);
 	while (dio->bio_list == NULL) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (dio->bio_list == NULL) {
 			dio->waiter = current;
-			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			blk_run_queues();
 			io_schedule();
-			spin_lock_irqsave(&dio->bio_list_lock, flags);
+			spin_lock_irqsave(&dio->bio_lock, flags);
 			dio->waiter = NULL;
 		}
 		set_current_state(TASK_RUNNING);
 	}
 	bio = dio->bio_list;
 	dio->bio_list = bio->bi_private;
-	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	return bio;
 }
 
@@ -393,7 +415,12 @@ static int dio_await_completion(struct d
 	if (dio->bio)
 		dio_bio_submit(dio);
 
-	while (atomic_read(&dio->bio_count)) {
+	/*
+	 * The bio_lock is not held for the read of bio_count.
+	 * This is ok since it is the dio_bio_complete() that changes
+	 * bio_count.
+	 */
+	while (dio->bio_count) {
 		struct bio *bio = dio_await_one(dio);
 		int ret2;
 
@@ -420,10 +447,10 @@ static int dio_bio_reap(struct dio *dio)
 			unsigned long flags;
 			struct bio *bio;
 
-			spin_lock_irqsave(&dio->bio_list_lock, flags);
+			spin_lock_irqsave(&dio->bio_lock, flags);
 			bio = dio->bio_list;
 			dio->bio_list = bio->bi_private;
-			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			ret = dio_bio_complete(dio, bio);
 		}
 		dio->reap_counter = 0;
@@ -889,6 +916,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->blkbits = blkbits;
 	dio->blkfactor = inode->i_blkbits - blkbits;
 	dio->start_zero_done = 0;
+	dio->size = 0;
 	dio->block_in_file = offset >> blkbits;
 	dio->blocks_available = 0;
 	dio->cur_page = NULL;
@@ -913,9 +941,9 @@ direct_io_worker(int rw, struct kiocb *i
 	 * (or synchronous) device could take the count to zero while we're
 	 * still submitting BIOs.
 	 */
-	atomic_set(&dio->bio_count, 1);
-	atomic_set(&dio->bios_in_flight, 0);
-	spin_lock_init(&dio->bio_list_lock);
+	dio->bio_count = 1;
+	dio->bios_in_flight = 0;
+	spin_lock_init(&dio->bio_lock);
 	dio->bio_list = NULL;
 	dio->waiter = NULL;
 
@@ -925,7 +953,7 @@ direct_io_worker(int rw, struct kiocb *i
 
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
-		bytes = iov[seg].iov_len;
+		dio->size += bytes = iov[seg].iov_len;
 
 		/* Index into the first page of the first block */
 		dio->first_block_in_page = (user_addr & ~PAGE_MASK) >> blkbits;
@@ -956,6 +984,13 @@ direct_io_worker(int rw, struct kiocb *i
 		}
 	} /* end iovec loop */
 
+	if (ret == -ENOTBLK && rw == WRITE) {
+		/*
+		 * The remaining part of the request will be 
+		 * be handled by buffered I/O when we return
+		 */
+		ret = 0;
+	}
 	/*
 	 * There may be some unwritten disk at the end of a part-written
 	 * fs-block-sized block.  Go zero that now.
@@ -991,32 +1026,35 @@ direct_io_worker(int rw, struct kiocb *i
 	 * reflect the number of to-be-processed BIOs.
 	 */
 	if (dio->is_async) {
-		if (ret == 0)
-			ret = dio->result;	/* Bytes written */
-		if (ret == -ENOTBLK) {
-			/*
-			 * The request will be reissued via buffered I/O
-			 * when we return; Any I/O already issued
-			 * effectively becomes redundant.
-			 */
-			dio->result = ret;
+		int should_wait = 0;
+		
+		if (dio->result < dio->size && rw == WRITE) {
 			dio->waiter = current;
+			should_wait = 1;
 		}
+		if (ret == 0)
+			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_queues();
-		if (ret == -ENOTBLK) {
+		if (should_wait) {
+			unsigned long flags;
 			/*
 			 * Wait for already issued I/O to drain out and
 			 * release its references to user-space pages
 			 * before returning to fallback on buffered I/O
 			 */
+
+			spin_lock_irqsave(&dio->bio_lock, flags);
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			while (atomic_read(&dio->bio_count)) {
+			while (dio->bio_count) {
+				spin_unlock_irqrestore(&dio->bio_lock, flags);
 				io_schedule();
+				spin_lock_irqsave(&dio->bio_lock, flags);
 				set_current_state(TASK_UNINTERRUPTIBLE);
 			}
+			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			set_current_state(TASK_RUNNING);
-			dio->waiter = NULL;
+			kfree(dio);
 		}
 	} else {
 		finished_one_bio(dio);
@@ -1038,7 +1076,8 @@ direct_io_worker(int rw, struct kiocb *i
 		}
 		dio_complete(dio, offset, ret);
 		/* We could have also come here on an AIO file extend */
-		if (!is_sync_kiocb(iocb) && (ret != -ENOTBLK))
+		if (!is_sync_kiocb(iocb) && !(rw == WRITE && ret >= 0 && 
+			dio->result < dio->size))
 			aio_complete(iocb, ret, 0);
 		kfree(dio);
 	}
diff -rupN -X /home/daniel/dontdiff linux-2.6.1-rc1-mm1/mm/filemap.c linux-2.6.1-rc1-mm1.ddm/mm/filemap.c
--- linux-2.6.1-rc1-mm1/mm/filemap.c	2003-12-31 10:52:47.039988554 -0800
+++ linux-2.6.1-rc1-mm1.ddm/mm/filemap.c	2003-12-31 13:29:51.263431439 -0800
@@ -1908,14 +1908,16 @@ __generic_file_aio_write_nolock(struct k
 		 */
 		if (written >= 0 && file->f_flags & O_SYNC)
 			status = generic_osync_inode(inode, mapping, OSYNC_METADATA);
-		if (written >= 0 && !is_sync_kiocb(iocb))
+		if (written >= count && !is_sync_kiocb(iocb))
 			written = -EIOCBQUEUED;
-		if (written != -ENOTBLK)
+		if (written < 0 || written >= count)
 			goto out_status;
 		/*
 		 * direct-io write to a hole: fall through to buffered I/O
+		 * for completing the rest of the request.
 		 */
-		written = 0;
+		pos += written;
+		count -= written;
 	}
 
 	buf = iov->iov_base;

--=-UYdXUQHypHwERH5KGQU3--

