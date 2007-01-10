Return-Path: <linux-kernel-owner+w=401wt.eu-S965142AbXAJWuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbXAJWuO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbXAJWuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:50:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60711 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965142AbXAJWuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:50:11 -0500
Date: Wed, 10 Jan 2007 18:07:18 -0500 (EST)
Message-Id: <20070110.180718.130242739.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Cc: dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 1/3] blk_end_request: helper interface for
 end_that_request_* callers
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the role of ->end_io() of struct request to a full I/O
completion handler.
blk_end_request() is added as a helper function to call the full
completion handler from drivers and others.

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
---
 block/ll_rw_blk.c      |   30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   10 ++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff -rupN 2.6.19.1/block/ll_rw_blk.c 1-blk-end-request-helper/block/ll_rw_blk.c
--- 2.6.19.1/block/ll_rw_blk.c	2006-12-11 14:32:53.000000000 -0500
+++ 1-blk-end-request-helper/block/ll_rw_blk.c	2007-01-10 11:02:46.000000000 -0500
@@ -3484,6 +3484,36 @@ void end_request(struct request *req, in
 
 EXPORT_SYMBOL(end_request);
 
+/*
+ * blk_end_request - Helper function for drivers to complete the request
+ * @rq:       the request being processed
+ * @uptodate: 1 for success, 0 for I/O error, < 0 for specific error
+ * @nr_bytes: number of bytes to complete
+ * @locked:   0 for taking queue lock when end_that_request_last() is called,
+ *            1 for not taking the lock
+ * @callback: function called between end_that_request_chunk() and
+ *            end_that_request_last().
+ *            If @callback returns non 0, this helper returns without
+ *            completion of @rq.
+ * @arg:      argument for @callback
+ *
+ * Description:
+ *     Ends I/O on a number of bytes attached to @rq.
+ *     If @rq has leftover, sets it up for the next range of segments.
+ *
+ * Return:
+ *     0 - we are done with this request
+ *     1 - still buffers pending for this request
+ */
+int blk_end_request(struct request *rq, int uptodate, int nr_bytes,
+		    int locked, int (callback)(void *), void *arg)
+{
+	BUG_ON(!rq->end_io);
+
+	return rq->end_io(rq, uptodate, nr_bytes, locked, callback, arg);
+}
+EXPORT_SYMBOL_GPL(blk_end_request);
+
 void blk_rq_bio_prep(request_queue_t *q, struct request *rq, struct bio *bio)
 {
 	/* first two bits are identical in rq->cmd_flags and bio->bi_rw */
diff -rupN 2.6.19.1/include/linux/blkdev.h 1-blk-end-request-helper/include/linux/blkdev.h
--- 2.6.19.1/include/linux/blkdev.h	2006-12-11 14:32:53.000000000 -0500
+++ 1-blk-end-request-helper/include/linux/blkdev.h	2007-01-10 11:05:51.000000000 -0500
@@ -126,7 +126,8 @@ void copy_io_context(struct io_context *
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
 struct request;
-typedef void (rq_end_io_fn)(struct request *, int);
+typedef int (rq_end_io_fn)(struct request *, int, int, int, int (void *),
+			   void *);
 
 struct request_list {
 	int count[2];
@@ -710,10 +711,11 @@ static inline void blk_run_address_space
  * acquired. All functions called within end_request() _must_be_ atomic.
  *
  * Several drivers define their own end_request and call
- * end_that_request_first() and end_that_request_last()
- * for parts of the original function. This prevents
- * code duplication in drivers.
+ * blk_end_request() for parts of the original function.
+ * This prevents code duplication in drivers.
  */
+extern int blk_end_request(struct request *, int, int, int, int (void *),
+			   void *);
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
 extern void end_that_request_last(struct request *, int);

