Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVDTLrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDTLrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDTLog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:44:36 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:57675 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261431AbVDTLl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:41:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ShH0KyYibFUdHKsdIrET7kGf3o4NmUeyifVMpEUiVAB9z8lTRmpU2TX7ctF459+/wyNfo6n3EHU+BT5jc3PqdBrpOqNZiy/OG2U2yEj13RxSOPIBYmUtsGGaDQ2nPVIJfMXf+MwXUU7S1lSJU4y5zZDXORkzjlmUKaaEhz1+AgM=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050420114041.F2FA00DB@htj.dyndns.org>
In-Reply-To: <20050420114041.F2FA00DB@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc2 04/04] blk: cleanup generic tag support error messages
Message-ID: <20050420114041.3394A7A1@htj.dyndns.org>
Date: Wed, 20 Apr 2005 20:41:53 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_blk_tag_map_error_handling_cleanup.patch

	Add KERN_ERR and __FUNCTION__ to generic tag error messages,
	and add a comment in blk_queue_end_tag() which explains the
	silent failure path.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ll_rw_blk.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-04-20 20:36:38.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-04-20 20:36:40.000000000 +0900
@@ -911,10 +911,15 @@ void blk_queue_end_tag(request_queue_t *
 	BUG_ON(tag == -1);
 
 	if (unlikely(tag >= bqt->max_depth))
+		/*
+		 * This can happen after tag depth has been reduced.
+		 * FIXME: how about a warning or info message here?
+		 */
 		return;
 
 	if (unlikely(!__test_and_clear_bit(tag, bqt->tag_map))) {
-		printk("attempt to clear non-busy tag (%d)\n", tag);
+		printk(KERN_ERR "%s: attempt to clear non-busy tag (%d)\n",
+		       __FUNCTION__, tag);
 		return;
 	}
 
@@ -923,7 +928,8 @@ void blk_queue_end_tag(request_queue_t *
 	rq->tag = -1;
 
 	if (unlikely(bqt->tag_index[tag] == NULL))
-		printk("tag %d is missing\n", tag);
+		printk(KERN_ERR "%s: tag %d is missing\n",
+		       __FUNCTION__, tag);
 
 	bqt->tag_index[tag] = NULL;
 	bqt->busy--;
@@ -956,8 +962,9 @@ int blk_queue_start_tag(request_queue_t 
 
 	if (unlikely((rq->flags & REQ_QUEUED))) {
 		printk(KERN_ERR 
-		       "request %p for device [%s] already tagged %d",
-		       rq, rq->rq_disk ? rq->rq_disk->disk_name : "?", rq->tag);
+		       "%s: request %p for device [%s] already tagged %d",
+		       __FUNCTION__, rq,
+		       rq->rq_disk ? rq->rq_disk->disk_name : "?", rq->tag);
 		BUG();
 	}
 
@@ -1000,7 +1007,8 @@ void blk_queue_invalidate_tags(request_q
 		rq = list_entry_rq(tmp);
 
 		if (rq->tag == -1) {
-			printk("bad tag found on list\n");
+			printk(KERN_ERR
+			       "%s: bad tag found on list\n", __FUNCTION__);
 			list_del_init(&rq->queuelist);
 			rq->flags &= ~REQ_QUEUED;
 		} else

