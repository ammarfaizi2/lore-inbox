Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965532AbWJBXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965532AbWJBXVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965533AbWJBXVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:21:48 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:28375 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S965528AbWJBXVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:21:35 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Message-Id: <20061002232135.18827.28686.sendpatchset@tetsuo.zabbo.net>
In-Reply-To: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH take2 3/5] dio: formalize bio counters as a dio reference count
Date: Mon,  2 Oct 2006 16:21:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dio: formalize bio counters as a dio reference count

Previously we had two confusing counts of bio progress.  'bio_count' was
decremented as bios were processed and freed by the dio core.  It was used to
indicate final completion of the dio operation.  'bios_in_flight' reflected how
many bios were between submit_bio() and bio->end_io.  It was used by the sync
path to decide when to wake up and finish completing bios and was ignored
by the async path.

This patch collapses the two notions into one notion of a dio reference count.
bios hold a dio reference when they're between submit_bio and bio->end_io.

Since bios_in_flight was only used in the sync path it is now equivalent
to dio->refcount - 1 which accounts for direct_io_worker() holding a 
reference for the duration of the operation.

dio_bio_complete() -> finished_one_bio() was called from the sync path after
finding bios on the list that the bio->end_io function had deposited.
finished_one_bio() can not drop the dio reference on behalf of these bios now
because bio->end_io already has.  The is_async test in finished_one_bio() meant
that it never actually did anything other than drop the bio_count for sync
callers.  So we remove its refcount decrement, don't call it from
dio_bio_complete(), and hoist its call up into the async dio_bio_complete()
caller after an explicit refcount decrement.  It is renamed dio_complete_aio()
to reflect the remaining work it actually does.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/direct-io.c |  140 ++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 74 deletions(-)

Index: 2.6.18-rc6-dio-cleanup/fs/direct-io.c
===================================================================
--- 2.6.18-rc6-dio-cleanup.orig/fs/direct-io.c
+++ 2.6.18-rc6-dio-cleanup/fs/direct-io.c
@@ -120,9 +120,8 @@ struct dio {
 	int page_errors;		/* errno from get_user_pages() */
 
 	/* BIO completion state */
+	atomic_t refcount;		/* direct_io_worker() and bios */
 	spinlock_t bio_lock;		/* protects BIO fields below */
-	int bio_count;			/* nr bios to be completed */
-	int bios_in_flight;		/* nr bios in flight */
 	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
 
@@ -255,44 +254,27 @@ static int dio_complete(struct dio *dio,
  * Called when a BIO has been processed.  If the count goes to zero then IO is
  * complete and we can signal this to the AIO layer.
  */
-static void finished_one_bio(struct dio *dio)
+static void dio_complete_aio(struct dio *dio)
 {
 	unsigned long flags;
+	int ret;
 
-	spin_lock_irqsave(&dio->bio_lock, flags);
-	if (dio->bio_count == 1) {
-		if (dio->is_async) {
-			int ret;
-
-			/*
-			 * Last reference to the dio is going away.
-			 * Drop spinlock and complete the DIO.
-			 */
-			spin_unlock_irqrestore(&dio->bio_lock, flags);
-
-			ret = dio_complete(dio, dio->iocb->ki_pos, 0);
+	ret = dio_complete(dio, dio->iocb->ki_pos, 0);
 
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
+	/* Complete AIO later if falling back to buffered i/o */
+	if (dio->result == dio->size ||
+		((dio->rw == READ) && dio->result)) {
+		aio_complete(dio->iocb, ret, 0);
+		kfree(dio);
+	} else {
+		/*
+		 * Falling back to buffered
+		 */
+		spin_lock_irqsave(&dio->bio_lock, flags);
+		if (dio->waiter)
+			wake_up_process(dio->waiter);
+		spin_unlock_irqrestore(&dio->bio_lock, flags);
 	}
-	dio->bio_count--;
-	spin_unlock_irqrestore(&dio->bio_lock, flags);
 }
 
 static int dio_bio_complete(struct dio *dio, struct bio *bio);
@@ -308,6 +290,10 @@ static int dio_bio_end_aio(struct bio *b
 
 	/* cleanup the bio */
 	dio_bio_complete(dio, bio);
+
+	if (atomic_dec_and_test(&dio->refcount))
+		dio_complete_aio(dio);
+
 	return 0;
 }
 
@@ -329,8 +315,7 @@ static int dio_bio_end_io(struct bio *bi
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
-	dio->bios_in_flight--;
-	if (dio->waiter && dio->bios_in_flight == 0)
+	if ((atomic_sub_return(1, &dio->refcount) == 1) && dio->waiter)
 		wake_up_process(dio->waiter);
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	return 0;
@@ -361,17 +346,15 @@ dio_bio_alloc(struct dio *dio, struct bl
  * In the AIO read case we speculatively dirty the pages before starting IO.
  * During IO completion, any of these pages which happen to have been written
  * back will be redirtied by bio_check_pages_dirty().
+ *
+ * bios hold a dio reference between submit_bio and ->end_io.
  */
 static void dio_bio_submit(struct dio *dio)
 {
 	struct bio *bio = dio->bio;
-	unsigned long flags;
 
 	bio->bi_private = dio;
-	spin_lock_irqsave(&dio->bio_lock, flags);
-	dio->bio_count++;
-	dio->bios_in_flight++;
-	spin_unlock_irqrestore(&dio->bio_lock, flags);
+	atomic_inc(&dio->refcount);
 	if (dio->is_async && dio->rw == READ)
 		bio_set_pages_dirty(bio);
 	submit_bio(dio->rw, bio);
@@ -389,18 +372,28 @@ static void dio_cleanup(struct dio *dio)
 		page_cache_release(dio_get_page(dio));
 }
 
+static int wait_for_more_bios(struct dio *dio)
+{
+	assert_spin_locked(&dio->bio_lock);
+
+	return (atomic_read(&dio->refcount) > 1) && (dio->bio_list == NULL);
+}
+
 /*
- * Wait for the next BIO to complete.  Remove it and return it.
+ * Wait for the next BIO to complete.  Remove it and return it.  NULL is
+ * returned once all BIOs have been completed.  This must only be called once
+ * all bios have been issued so that dio->refcount can only decrease.  This
+ * requires that that the caller hold a reference on the dio.
  */
 static struct bio *dio_await_one(struct dio *dio)
 {
 	unsigned long flags;
-	struct bio *bio;
+	struct bio *bio = NULL;
 
 	spin_lock_irqsave(&dio->bio_lock, flags);
-	while (dio->bio_list == NULL) {
+	while (wait_for_more_bios(dio)) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (dio->bio_list == NULL) {
+		if (wait_for_more_bios(dio)) {
 			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			io_schedule();
@@ -409,8 +402,10 @@ static struct bio *dio_await_one(struct 
 		}
 		set_current_state(TASK_RUNNING);
 	}
-	bio = dio->bio_list;
-	dio->bio_list = bio->bi_private;
+	if (dio->bio_list) {
+		bio = dio->bio_list;
+		dio->bio_list = bio->bi_private;
+	}
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	return bio;
 }
@@ -439,25 +434,24 @@ static int dio_bio_complete(struct dio *
 		}
 		bio_put(bio);
 	}
-	finished_one_bio(dio);
 	return uptodate ? 0 : -EIO;
 }
 
 /*
- * Wait on and process all in-flight BIOs.
+ * Wait on and process all in-flight BIOs.  This must only be called once
+ * all bios have been issued so that the refcount can only decrease.
+ * This just waits for all bios to make it through dio_bio_complete.  IO
+ * errors are propogated through dio->io_error and should be propogated via
+ * dio_complete().
  */
 static void dio_await_completion(struct dio *dio)
 {
-	/*
-	 * The bio_lock is not held for the read of bio_count.
-	 * This is ok since it is the dio_bio_complete() that changes
-	 * bio_count.
-	 */
-	while (dio->bio_count) {
-		struct bio *bio = dio_await_one(dio);
-		/* io errors are propogated through dio->io_error */
-		dio_bio_complete(dio, bio);
-	}
+	struct bio *bio;
+	do {
+		bio = dio_await_one(dio);
+		if (bio)
+			dio_bio_complete(dio, bio);
+	} while (bio);
 }
 
 /*
@@ -987,16 +981,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->iocb = iocb;
 	dio->i_size = i_size_read(inode);
 
-	/*
-	 * BIO completion state.
-	 *
-	 * ->bio_count starts out at one, and we decrement it to zero after all
-	 * BIOs are submitted.  This to avoid the situation where a really fast
-	 * (or synchronous) device could take the count to zero while we're
-	 * still submitting BIOs.
-	 */
-	dio->bio_count = 1;
-	dio->bios_in_flight = 0;
+	atomic_set(&dio->refcount, 1);
 	spin_lock_init(&dio->bio_lock);
 	dio->bio_list = NULL;
 	dio->waiter = NULL;
@@ -1103,7 +1088,11 @@ direct_io_worker(int rw, struct kiocb *i
 		}
 		if (ret == 0)
 			ret = dio->result;
-		finished_one_bio(dio);		/* This can free the dio */
+
+		/* this can free the dio */
+		if (atomic_dec_and_test(&dio->refcount))
+			dio_complete_aio(dio);
+
 		if (should_wait) {
 			unsigned long flags;
 			/*
@@ -1114,7 +1103,7 @@ direct_io_worker(int rw, struct kiocb *i
 
 			spin_lock_irqsave(&dio->bio_lock, flags);
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			while (dio->bio_count) {
+			while (atomic_read(&dio->refcount)) {
 				spin_unlock_irqrestore(&dio->bio_lock, flags);
 				io_schedule();
 				spin_lock_irqsave(&dio->bio_lock, flags);
@@ -1125,7 +1114,6 @@ direct_io_worker(int rw, struct kiocb *i
 			kfree(dio);
 		}
 	} else {
-		finished_one_bio(dio);
 		dio_await_completion(dio);
 
 		ret = dio_complete(dio, offset, ret);
@@ -1138,7 +1126,11 @@ direct_io_worker(int rw, struct kiocb *i
 			 * i/o, we have to mark the the aio complete.
 			 */
 			aio_complete(iocb, ret, 0);
-		kfree(dio);
+
+		if (atomic_dec_and_test(&dio->refcount))
+			kfree(dio);
+		else
+			BUG();
 	}
 	return ret;
 }
