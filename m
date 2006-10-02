Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWJBXXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWJBXXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965523AbWJBXV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:21:28 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:26327 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S965521AbWJBXVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:21:25 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Message-Id: <20061002232125.18827.52078.sendpatchset@tetsuo.zabbo.net>
In-Reply-To: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH take2 1/5] dio: centralize completion in dio_complete()
Date: Mon,  2 Oct 2006 16:21:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dio: centralize completion in dio_complete()

The mechanics which decide the result of a direct IO operation were duplicated
in the sync and async paths.

The async path didn't check page_errors which can manifest as silently
returning success when the final pointer in an operation faults and its
matching file region is filled with zeros.

The sync path and async path differed in whether they passed errors to the
caller's dio->end_io operation.  The async path was passing errors to it which
trips an assertion in XFS, though it is apparently harmless.

This centralizes the completion phase of dio ops in one place.  AIO will now
return EFAULT consistently and all paths fall back to the previously sync
behaviour of passing the number of bytes 'transferred' to the dio->end_io
callback, regardless of errors.

dio_await_completion() doesn't have to propogate EIO from non-uptodate
bios now that it's being propogated through dio_complete() via dio->io_error.
This lets it return void which simplifies its sole caller.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/direct-io.c |   94 +++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

Index: 2.6.18-rc6-dio-cleanup/fs/direct-io.c
===================================================================
--- 2.6.18-rc6-dio-cleanup.orig/fs/direct-io.c
+++ 2.6.18-rc6-dio-cleanup/fs/direct-io.c
@@ -209,19 +209,46 @@ static struct page *dio_get_page(struct 
 	return dio->pages[dio->head++];
 }
 
-/*
- * Called when all DIO BIO I/O has been completed - let the filesystem
- * know, if it registered an interest earlier via get_block.  Pass the
- * private field of the map buffer_head so that filesystems can use it
- * to hold additional state between get_block calls and dio_complete.
+/**
+ * dio_complete() - called when all DIO BIO I/O has been completed
+ * @offset: the byte offset in the file of the completed operation
+ *
+ * This releases locks as dictated by the locking type, lets interested parties
+ * know that a DIO operation has completed, and calculates the resulting return
+ * code for the operation.
+ *
+ * It lets the filesystem know if it registered an interest earlier via
+ * get_block.  Pass the private field of the map buffer_head so that
+ * filesystems can use it to hold additional state between get_block calls and
+ * dio_complete.
  */
-static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
+static int dio_complete(struct dio *dio, loff_t offset, int ret)
 {
+	ssize_t transferred = 0;
+
+	if (dio->result) {
+		transferred = dio->result;
+
+		/* Check for short read case */
+		if ((dio->rw == READ) && ((offset + transferred) > dio->i_size))
+			transferred = dio->i_size - offset;
+	}
+
 	if (dio->end_io && dio->result)
-		dio->end_io(dio->iocb, offset, bytes, dio->map_bh.b_private);
+		dio->end_io(dio->iocb, offset, transferred,
+			    dio->map_bh.b_private);
 	if (dio->lock_type == DIO_LOCKING)
 		/* lockdep: non-owner release */
 		up_read_non_owner(&dio->inode->i_alloc_sem);
+
+	if (ret == 0)
+		ret = dio->page_errors;
+	if (ret == 0)
+		ret = dio->io_error;
+	if (ret == 0)
+		ret = transferred;
+
+	return ret;
 }
 
 /*
@@ -235,8 +262,7 @@ static void finished_one_bio(struct dio 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	if (dio->bio_count == 1) {
 		if (dio->is_async) {
-			ssize_t transferred;
-			loff_t offset;
+			int ret;
 
 			/*
 			 * Last reference to the dio is going away.
@@ -244,24 +270,12 @@ static void finished_one_bio(struct dio 
 			 */
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
 
-			/* Check for short read case */
-			transferred = dio->result;
-			offset = dio->iocb->ki_pos;
-
-			if ((dio->rw == READ) &&
-			    ((offset + transferred) > dio->i_size))
-				transferred = dio->i_size - offset;
-
-			/* check for error in completion path */
-			if (dio->io_error)
-				transferred = dio->io_error;
-
-			dio_complete(dio, offset, transferred);
+			ret = dio_complete(dio, dio->iocb->ki_pos, 0);
 
 			/* Complete AIO later if falling back to buffered i/o */
 			if (dio->result == dio->size ||
 				((dio->rw == READ) && dio->result)) {
-				aio_complete(dio->iocb, transferred, 0);
+				aio_complete(dio->iocb, ret, 0);
 				kfree(dio);
 				return;
 			} else {
@@ -433,10 +447,8 @@ static int dio_bio_complete(struct dio *
 /*
  * Wait on and process all in-flight BIOs.
  */
-static int dio_await_completion(struct dio *dio)
+static void dio_await_completion(struct dio *dio)
 {
-	int ret = 0;
-
 	if (dio->bio)
 		dio_bio_submit(dio);
 
@@ -447,13 +459,9 @@ static int dio_await_completion(struct d
 	 */
 	while (dio->bio_count) {
 		struct bio *bio = dio_await_one(dio);
-		int ret2;
-
-		ret2 = dio_bio_complete(dio, bio);
-		if (ret == 0)
-			ret = ret2;
+		/* io errors are propogated through dio->io_error */
+		dio_bio_complete(dio, bio);
 	}
-	return ret;
 }
 
 /*
@@ -1119,28 +1127,10 @@ direct_io_worker(int rw, struct kiocb *i
 			kfree(dio);
 		}
 	} else {
-		ssize_t transferred = 0;
-
 		finished_one_bio(dio);
-		ret2 = dio_await_completion(dio);
-		if (ret == 0)
-			ret = ret2;
-		if (ret == 0)
-			ret = dio->page_errors;
-		if (dio->result) {
-			loff_t i_size = i_size_read(inode);
+		dio_await_completion(dio);
 
-			transferred = dio->result;
-			/*
-			 * Adjust the return value if the read crossed a
-			 * non-block-aligned EOF.
-			 */
-			if (rw == READ && (offset + transferred > i_size))
-				transferred = i_size - offset;
-		}
-		dio_complete(dio, offset, transferred);
-		if (ret == 0)
-			ret = transferred;
+		ret = dio_complete(dio, offset, ret);
 
 		/* We could have also come here on an AIO file extend */
 		if (!is_sync_kiocb(iocb) && (rw & WRITE) &&
