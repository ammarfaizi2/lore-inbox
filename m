Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEARzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEARzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:55:02 -0400
Received: from verein.lst.de ([212.34.181.86]:41991 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261858AbTEARy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:54:59 -0400
Date: Thu, 1 May 2003 20:07:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make <linux/blk.h> obsolete
Message-ID: <20030501200719.A16182@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This file was _the_ header for block-device related stuff in earlier
Linux versions, but nowdays there's just a few prototypes left that
really belong into blkdev.h or genhd.h (and in one case elevator.h).

This patch moves them over and removes everything but including
blkdev.h from blk.h  Note that blkdev.h gets all the headers that
were included in blk.h inmplicitly too.  Now we can start removing
all references to it an maybe kill it off before 2.6.  *sniff*


--- 1.35/include/linux/blk.h	Sun Apr 20 19:22:00 2003
+++ edited/include/linux/blk.h	Thu May  1 17:20:09 2003
@@ -1,41 +1,2 @@
-#ifndef _BLK_H
-#define _BLK_H
-
+/* this file is obsolete, please use <linux/blkdev.h> instead */
 #include <linux/blkdev.h>
-#include <linux/elevator.h>
-#include <linux/config.h>
-#include <linux/spinlock.h>
-#include <linux/compiler.h>
-
-extern void set_device_ro(struct block_device *bdev, int flag);
-extern void set_disk_ro(struct gendisk *disk, int flag);
-extern void add_disk_randomness(struct gendisk *disk);
-extern void rand_initialize_disk(struct gendisk *disk);
-
-/*
- * end_request() and friends. Must be called with the request queue spinlock
- * acquired. All functions called within end_request() _must_be_ atomic.
- *
- * Several drivers define their own end_request and call
- * end_that_request_first() and end_that_request_last()
- * for parts of the original function. This prevents
- * code duplication in drivers.
- */
-
-extern int end_that_request_first(struct request *, int, int);
-extern int end_that_request_chunk(struct request *, int, int);
-extern void end_that_request_last(struct request *);
-extern void end_request(struct request *req, int uptodate);
-struct request *elv_next_request(request_queue_t *q);
-
-static inline void blkdev_dequeue_request(struct request *req)
-{
-	BUG_ON(list_empty(&req->queuelist));
-
-	list_del_init(&req->queuelist);
-
-	if (req->q)
-		elv_remove_request(req->q, req);
-}
-
-#endif /* _BLK_H */
--- 1.101/include/linux/blkdev.h	Thu Apr 24 06:23:09 2003
+++ edited/include/linux/blkdev.h	Thu May  1 17:21:03 2003
@@ -349,6 +349,30 @@
 }
 
 /*
+ * end_request() and friends. Must be called with the request queue spinlock
+ * acquired. All functions called within end_request() _must_be_ atomic.
+ *
+ * Several drivers define their own end_request and call
+ * end_that_request_first() and end_that_request_last()
+ * for parts of the original function. This prevents
+ * code duplication in drivers.
+ */
+extern int end_that_request_first(struct request *, int, int);
+extern int end_that_request_chunk(struct request *, int, int);
+extern void end_that_request_last(struct request *);
+extern void end_request(struct request *req, int uptodate);
+
+static inline void blkdev_dequeue_request(struct request *req)
+{
+	BUG_ON(list_empty(&req->queuelist));
+
+	list_del_init(&req->queuelist);
+
+	if (req->q)
+		elv_remove_request(req->q, req);
+}
+
+/*
  * get ready for proper ref counting
  */
 #define blk_put_queue(q)	do { } while (0)
--- 1.18/include/linux/elevator.h	Sun Jan 12 09:10:40 2003
+++ edited/include/linux/elevator.h	Thu May  1 17:21:24 2003
@@ -54,6 +54,7 @@
 extern void elv_merged_request(request_queue_t *, struct request *);
 extern void elv_remove_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
+extern struct request *elv_next_request(struct request_queue *q);
 extern struct request *elv_former_request(request_queue_t *, struct request *);
 extern struct request *elv_latter_request(request_queue_t *, struct request *);
 extern int elv_register_queue(struct gendisk *);
--- 1.51/include/linux/genhd.h	Fri Apr 25 18:16:28 2003
+++ edited/include/linux/genhd.h	Thu May  1 17:20:09 2003
@@ -190,6 +190,14 @@
 extern void del_gendisk(struct gendisk *gp);
 extern void unlink_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *part);
+
+extern void set_device_ro(struct block_device *bdev, int flag);
+extern void set_disk_ro(struct gendisk *disk, int flag);
+
+/* drivers/char/random.c */
+extern void add_disk_randomness(struct gendisk *disk);
+extern void rand_initialize_disk(struct gendisk *disk);
+
 static inline sector_t get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
