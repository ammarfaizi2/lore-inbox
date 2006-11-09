Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423589AbWKIBQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423589AbWKIBQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161757AbWKIBQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:16:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:11876 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161780AbWKIBQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:16:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=oA4apeXDwMdTjOyTOQFU7vZ+J1nfxvzRyxaRTZYNsU5gMsCWBvY1gF2JU4j3IVuL/a97OWbh6aJpvCjtS6VZSc6dLDu9NyVhG7np1slezkJzBGX9e6mc3epXUKoNHQ+KNzVzE807r0slqdemfcFwcaNslpjOl4OSzV08d/8oNOg=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] direct-io: factor out dio_determine_result()
In-Reply-To: <11630349713427-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Thu, 9 Nov 2006 10:16:11 +0900
Message-Id: <11630349714058-git-send-email-htejun@gmail.com>
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

Code to determine dio result value is shared between async and sync
completion paths.  Factor it out.

This is in preparation of unifying sync and async completion paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/direct-io.c |   68 +++++++++++++++++++++++++------------------------------
 1 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index c85aee3..98d8c2e 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -210,15 +210,38 @@ static struct page *dio_get_page(struct
 }
 
 /*
+ * Determine the final result value for @dio.  If no error occurred,
+ * it's the number of transferred bytes.  Otherwise, -errno.  Error
+ * which occurred earlier has precedence.  If a read request straddles
+ * unaligned EOF, read data may go beyond it.  In such cases,
+ * tranferred nbytes is capped at EOF.
+ */
+static ssize_t dio_determine_result(struct dio *dio, int issue_err)
+{
+	loff_t offset = dio->iocb->ki_pos;
+	ssize_t transferred = dio->result;
+
+	if (issue_err)
+		return issue_err;
+	if (dio->io_error)
+		return dio->io_error;
+
+	if ((dio->rw == READ) && ((offset + transferred) > dio->i_size))
+		transferred = dio->i_size - offset;
+	return transferred;
+}
+
+/*
  * Called when all DIO BIO I/O has been completed - let the filesystem
  * know, if it registered an interest earlier via get_block.  Pass the
  * private field of the map buffer_head so that filesystems can use it
  * to hold additional state between get_block calls and dio_complete.
  */
-static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
+static void dio_complete(struct dio *dio, ssize_t bytes)
 {
 	if (dio->end_io && dio->result)
-		dio->end_io(dio->iocb, offset, bytes, dio->map_bh.b_private);
+		dio->end_io(dio->iocb, dio->iocb->ki_pos, bytes,
+			    dio->map_bh.b_private);
 	if (dio->lock_type == DIO_LOCKING)
 		/* lockdep: non-owner release */
 		up_read_non_owner(&dio->inode->i_alloc_sem);
@@ -235,33 +258,19 @@ static void finished_one_bio(struct dio
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	if (dio->bio_count == 1) {
 		if (dio->is_async) {
-			ssize_t transferred;
-			loff_t offset;
-
+			ssize_t ret = dio_determine_result(dio, 0);
 			/*
 			 * Last reference to the dio is going away.
 			 * Drop spinlock and complete the DIO.
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
+			dio_complete(dio, ret);
 
 			/* Complete AIO later if falling back to buffered i/o */
 			if (dio->result == dio->size ||
 				((dio->rw == READ) && dio->result)) {
-				aio_complete(dio->iocb, transferred, 0);
+				aio_complete(dio->iocb, ret, 0);
 				kfree(dio);
 				return;
 			} else {
@@ -1121,27 +1130,12 @@ direct_io_worker(int rw, struct kiocb *i
 			kfree(dio);
 		}
 	} else {
-		ssize_t transferred = 0;
-
 		finished_one_bio(dio);
-		ret2 = dio_await_completion(dio);
-		if (ret == 0)
-			ret = ret2;
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
-		if (ret == 0)
-			ret = transferred;
+		ret = dio_determine_result(dio, ret);
 
-		dio_complete(dio, offset, ret);
+		dio_complete(dio, ret);
 
 		/* We could have also come here on an AIO file extend */
 		if (!is_sync_kiocb(iocb) && (rw & WRITE) &&
-- 
1.4.3.3


