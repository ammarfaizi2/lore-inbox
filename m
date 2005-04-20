Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVDTLls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDTLls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDTLlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:41:47 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:57668 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261279AbVDTLll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:41:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=IcjjeUU9TgqX6PCoNde2+ac089pC1jbGu1VE4sMuLtdBqh8eBPRnzPltbfC4umzIcR4cPYF4s5pn5uCTlQmrstGLj9qWhbennfP+rWg9Nb80jPpda3ZrDQl1Dc+ys1pg7hStlmz2ILNsHTpuwmIEZYBGqCeW5T33IjNITefczXY=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050420114041.F2FA00DB@htj.dyndns.org>
In-Reply-To: <20050420114041.F2FA00DB@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc2 01/04] blk: use find_first_zero_bit() in blk_queue_start_tag()
Message-ID: <20050420114041.7F96D980@htj.dyndns.org>
Date: Wed, 20 Apr 2005 20:41:37 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_blk_tag_map_use_find_first_zero_bit.patch

	blk_queue_start_tag() hand-coded searching for the first zero
	bit in the tag map.  Replace it with find_first_zero_bit().
	With this patch, blk_queue_star_tag() doesn't need to fill
	remains of tag map with 1, thus allowing it to work properly
	with the next remove_real_max_depth patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ll_rw_blk.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-04-20 20:36:35.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-04-20 20:36:36.000000000 +0900
@@ -967,8 +967,7 @@ EXPORT_SYMBOL(blk_queue_end_tag);
 int blk_queue_start_tag(request_queue_t *q, struct request *rq)
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
-	unsigned long *map = bqt->tag_map;
-	int tag = 0;
+	int tag;
 
 	if (unlikely((rq->flags & REQ_QUEUED))) {
 		printk(KERN_ERR 
@@ -977,14 +976,10 @@ int blk_queue_start_tag(request_queue_t 
 		BUG();
 	}
 
-	for (map = bqt->tag_map; *map == -1UL; map++) {
-		tag += BLK_TAGS_PER_LONG;
-
-		if (tag >= bqt->max_depth)
-			return 1;
-	}
+	tag = find_first_zero_bit(bqt->tag_map, bqt->max_depth);
+	if (tag >= bqt->max_depth)
+		return 1;
 
-	tag += ffz(*map);
 	__set_bit(tag, bqt->tag_map);
 
 	rq->flags |= REQ_QUEUED;

