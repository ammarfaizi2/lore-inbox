Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSFKCqw>; Mon, 10 Jun 2002 22:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSFKCqv>; Mon, 10 Jun 2002 22:46:51 -0400
Received: from host194.steeleye.com ([216.33.1.194]:26639 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316659AbSFKCqu>; Mon, 10 Jun 2002 22:46:50 -0400
Message-Id: <200206110246.g5B2kia06902@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: axboe@suse.de, linux-scsi@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Proposed changes to generic blk tag for use in SCSI (1/3)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1741911420"
Date: Mon, 10 Jun 2002 22:46:44 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1741911420
Content-Type: text/plain; charset=us-ascii

The attached is what I needed in the generic block layer to get the SCSI 
subsystem using it for Tag Command Queueing.

The changes are basically

1) I need a function to find the tagged request given the queue and the tag, 
which I've added as a function in the block layer

2) The SCSI queue will stall if it gets an untagged request in the stream, so 
once tagged queueing is enabled, all commands (including SPECIALS) must be 
tagged.  I altered the check in blk_queue_start_tag to permit this.

This is part of a set of three patches which provide a sample implementation 
of a SCSI driver using the generic TCQ code.

There are several shortcomings of the prototype, most notably it doesn't have 
tag starvation detection and processing.  However, I think I can re-introduce 
this as part of the error handler functions.

James Bottomley


--==_Exmh_1741911420
Content-Type: text/plain ; name="blk-tag-2.5.21.diff"; charset=us-ascii
Content-Description: blk-tag-2.5.21.diff
Content-Disposition: attachment; filename="blk-tag-2.5.21.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.585   -> 1.586  
#	drivers/block/ll_rw_blk.c	1.67    -> 1.68   
#	include/linux/blkdev.h	1.44    -> 1.45   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/10	jejb@mulgrave.(none)	1.586
# [BLK LAYER]
# 
# add find tag function, adjust criteria for tagging commands.
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Jun 10 22:29:38 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Jun 10 22:29:38 2002
@@ -304,6 +304,27 @@
 }
 
 /**
+ * blk_queue_find_tag - find a request by its tag and queue
+ *
+ * @q:	 The request queue for the device
+ * @tag: The tag of the request
+ *
+ * Notes:
+ *    Should be used when a device returns a tag and you want to match
+ *    it with a request.
+ *
+ *    no locks need be held.
+ **/
+struct request *blk_queue_find_tag(request_queue_t *q, int tag)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+
+	if(unlikely(bqt == NULL || bqt->max_depth < tag))
+		return NULL;
+
+	return bqt->tag_index[tag];
+}
+/**
  * blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
  *
@@ -448,7 +469,7 @@
 	unsigned long *map = bqt->tag_map;
 	int tag = 0;
 
-	if (unlikely(!(rq->flags & REQ_CMD)))
+	if (unlikely((rq->flags & REQ_QUEUED)))
 		return 1;
 
 	for (map = bqt->tag_map; *map == -1UL; map++) {
@@ -1945,6 +1966,7 @@
 EXPORT_SYMBOL(ll_10byte_cmd_build);
 EXPORT_SYMBOL(blk_queue_prep_rq);
 
+EXPORT_SYMBOL(blk_queue_find_tag);
 EXPORT_SYMBOL(blk_queue_init_tags);
 EXPORT_SYMBOL(blk_queue_free_tags);
 EXPORT_SYMBOL(blk_queue_start_tag);
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Mon Jun 10 22:29:38 2002
+++ b/include/linux/blkdev.h	Mon Jun 10 22:29:38 2002
@@ -339,6 +339,7 @@
 #define blk_queue_tag_queue(q)		((q)->queue_tags->busy < (q)->queue_tags->max_depth)
 #define blk_rq_tagged(rq)		((rq)->flags & REQ_QUEUED)
 extern int blk_queue_start_tag(request_queue_t *, struct request *);
+extern struct request *blk_queue_find_tag(request_queue_t *, int);
 extern void blk_queue_end_tag(request_queue_t *, struct request *);
 extern int blk_queue_init_tags(request_queue_t *, int);
 extern void blk_queue_free_tags(request_queue_t *);

--==_Exmh_1741911420--


