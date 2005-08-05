Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVHESjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVHESjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVHEShL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:37:11 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:33309 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263009AbVHESgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:36:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=kt5mZZaQM7u8ojmtMUeGTjCfgc+02+Y+4E2fpXvxlLcZhtmoyYvMve6Z6SFUM+ishNKw+n47lCWws0t3KbiD2Lt68YR6NmxNKz1lK9adHzQ1ztY0b7nugk64wVdyuV3WGaUQZj+GRk4qErH/fTP1OoDlrz9qdx8Hsi6IpXbrUvg=
Date: Sat, 6 Aug 2005 03:36:08 +0900
From: Tejun Heo <htejun@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, James.Bottomley@steeleye.com,
       andrew.vasquez@qlogic.com
Subject: [PATCH] blk: fix tag shrinking (revive real_max_size)
Message-ID: <20050805183608.GA7249@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Andrew.

 The patch posted in the following mail (from me) incorrectly removed
blk_queue_tag->real_max_depth.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111399777404464&w=2

commit: fa72b903f75e4f0f0b2c2feed093005167da4023

 The original resize implementation was incorrect in the following
points.

 * actual allocation size of tag_index was shorter than real_max_size,
   but assumed to be of the same size, possibly causing memory access
   beyond the allocated area.
 * bits in tag_map between max_deptn and real_max_depth were
   initialized to 1's, making the tags permanently reserved.

 In an attempt to fix above two bugs, I had removed allocation
optimization in init_tag_map and real_max_size.  Tag map/index were
allocated and freed immediately during resize.  Unfortunately, I
wasn't considering that tag map/index can be resized dynamically with
tags beyond new_depth active.  This led to accessing freed area after
shrinking tags and led to the following bug reporting thread on
linux-scsi.

http://marc.theaimsgroup.com/?l=linux-scsi&m=112319898111885&w=2

 To fix the problem, I've revived real_max_depth without allocation
optimization in init_tag_map, and Andrew Vasquez confirmed that the
problem was fixed.  As Jens is not going to be available for a week,
he asked me to make sure that this patch reaches you.

http://marc.theaimsgroup.com/?l=linux-scsi&m=112325778530886&w=2

 So, here's the patch.  The patch is against today's Linus git head
(2f60f8d3573ff90fe5d75a6d11fd2add1248e7d6).  The patch also applies to
linux-2.6.13-rc4-mm1 with offset of 1.  I apologize for the bug and
hassle.  Thank you.

--------------------------------------------------------------------

 Revive blk_queue_tag->real_max_size.  Previous commit
fa72b903f75e4f0f0b2c2feed093005167da4023 incorrectly removed this
field breaking dynamic shrinking of tags.  This patch revives
real_max_size sans buggy allocation optimization the original code
had.  Also, a comment was added to make sure that real_max_size is
needed for dynamic shrinking.


Signed-off-by: Tejun Heo <htejun@gmail.com>


diff --git a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c
+++ b/drivers/block/ll_rw_blk.c
@@ -719,7 +719,7 @@ struct request *blk_queue_find_tag(reque
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
-	if (unlikely(bqt == NULL || tag >= bqt->max_depth))
+	if (unlikely(bqt == NULL || tag >= bqt->real_max_depth))
 		return NULL;
 
 	return bqt->tag_index[tag];
@@ -798,6 +798,7 @@ init_tag_map(request_queue_t *q, struct 
 
 	memset(tag_index, 0, depth * sizeof(struct request *));
 	memset(tag_map, 0, nr_ulongs * sizeof(unsigned long));
+	tags->real_max_depth = depth;
 	tags->max_depth = depth;
 	tags->tag_index = tag_index;
 	tags->tag_map = tag_map;
@@ -872,11 +873,22 @@ int blk_queue_resize_tags(request_queue_
 		return -ENXIO;
 
 	/*
+	 * if we already have large enough real_max_depth.  just
+	 * adjust max_depth.  *NOTE* as requests with tag value
+	 * between new_depth and real_max_depth can be in-flight, tag
+	 * map can not be shrunk blindly here.
+	 */
+	if (new_depth <= bqt->real_max_depth) {
+		bqt->max_depth = new_depth;
+		return 0;
+	}
+
+	/*
 	 * save the old state info, so we can copy it back
 	 */
 	tag_index = bqt->tag_index;
 	tag_map = bqt->tag_map;
-	max_depth = bqt->max_depth;
+	max_depth = bqt->real_max_depth;
 
 	if (init_tag_map(q, bqt, new_depth))
 		return -ENOMEM;
@@ -913,7 +925,7 @@ void blk_queue_end_tag(request_queue_t *
 
 	BUG_ON(tag == -1);
 
-	if (unlikely(tag >= bqt->max_depth))
+	if (unlikely(tag >= bqt->real_max_depth))
 		/*
 		 * This can happen after tag depth has been reduced.
 		 * FIXME: how about a warning or info message here?
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -301,6 +301,7 @@ struct blk_queue_tag {
 	struct list_head busy_list;	/* fifo list of busy tags */
 	int busy;			/* current depth */
 	int max_depth;			/* what we will send to device */
+	int real_max_depth;		/* what the array can hold */
 	atomic_t refcnt;		/* map can be shared */
 };
 
