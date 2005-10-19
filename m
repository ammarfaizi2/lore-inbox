Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVJSMsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVJSMsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVJSMsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:48:23 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:18986 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750914AbVJSMr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:47:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=s3Yz+XjIAR4pZO/MNK6gJo4VHJQMmpe2fMr4DFFnlCy8eemMmJbHraPh/jMHKfE2rdnVLEARpv1J7l8fqNkjbteaqewXjVmV04Qt3irgDXEiLCmlJRYAFDZ50zEnLEKj8i4NGqxjs53LKUs5/kTTkND8A2bZirLd2ABVFm5kAnQ=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019124716.EF1F6546@htj.dyndns.org>
In-Reply-To: <20051019124716.EF1F6546@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 02/10] blk: separate out bio init part from __make_request
Message-ID: <20051019124716.48E8FBF7@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:47:51 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_implement-init_request_from_bio.patch

	Separate out bio initialization part from __make_request.  It
        will be used by the following blk_ordered_reimpl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ll_rw_blk.c |   62 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-10-19 21:47:12.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-10-19 21:47:13.000000000 +0900
@@ -38,6 +38,8 @@
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
+static void init_request_from_bio(struct request *req, struct bio *bio);
+static int __make_request(request_queue_t *q, struct bio *bio);
 
 /*
  * For the allocated request tables
@@ -1652,8 +1654,6 @@ static int blk_init_free_list(request_qu
 	return 0;
 }
 
-static int __make_request(request_queue_t *, struct bio *);
-
 request_queue_t *blk_alloc_queue(int gfp_mask)
 {
 	return blk_alloc_queue_node(gfp_mask, -1);
@@ -2641,6 +2641,36 @@ void blk_attempt_remerge(request_queue_t
 
 EXPORT_SYMBOL(blk_attempt_remerge);
 
+static void init_request_from_bio(struct request *req, struct bio *bio)
+{
+	req->flags |= REQ_CMD;
+
+	/*
+	 * inherit FAILFAST from bio (for read-ahead, and explicit FAILFAST)
+	 */
+	if (bio_rw_ahead(bio) || bio_failfast(bio))
+		req->flags |= REQ_FAILFAST;
+
+	/*
+	 * REQ_BARRIER implies no merging, but lets make it explicit
+	 */
+	if (unlikely(bio_barrier(bio)))
+		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
+
+	req->errors = 0;
+	req->hard_sector = req->sector = bio->bi_sector;
+	req->hard_nr_sectors = req->nr_sectors = bio_sectors(bio);
+	req->current_nr_sectors = req->hard_cur_sectors = bio_cur_sectors(bio);
+	req->nr_phys_segments = bio_phys_segments(req->q, bio);
+	req->nr_hw_segments = bio_hw_segments(req->q, bio);
+	req->buffer = bio_data(bio);	/* see ->buffer comment above */
+	req->waiting = NULL;
+	req->bio = req->biotail = bio;
+	req->ioprio = bio_prio(bio);
+	req->rq_disk = bio->bi_bdev->bd_disk;
+	req->start_time = jiffies;
+}
+
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req;
@@ -2736,33 +2766,7 @@ get_rq:
 	 * We don't worry about that case for efficiency. It won't happen
 	 * often, and the elevators are able to handle it.
 	 */
-
-	req->flags |= REQ_CMD;
-
-	/*
-	 * inherit FAILFAST from bio (for read-ahead, and explicit FAILFAST)
-	 */
-	if (bio_rw_ahead(bio) || bio_failfast(bio))
-		req->flags |= REQ_FAILFAST;
-
-	/*
-	 * REQ_BARRIER implies no merging, but lets make it explicit
-	 */
-	if (unlikely(barrier))
-		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
-
-	req->errors = 0;
-	req->hard_sector = req->sector = sector;
-	req->hard_nr_sectors = req->nr_sectors = nr_sectors;
-	req->current_nr_sectors = req->hard_cur_sectors = cur_nr_sectors;
-	req->nr_phys_segments = bio_phys_segments(q, bio);
-	req->nr_hw_segments = bio_hw_segments(q, bio);
-	req->buffer = bio_data(bio);	/* see ->buffer comment above */
-	req->waiting = NULL;
-	req->bio = req->biotail = bio;
-	req->ioprio = prio;
-	req->rq_disk = bio->bi_bdev->bd_disk;
-	req->start_time = jiffies;
+	init_request_from_bio(req, bio);
 
 	spin_lock_irq(q->queue_lock);
 	if (elv_queue_empty(q))

