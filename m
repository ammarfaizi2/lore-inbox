Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVKXQ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVKXQ00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVKXQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:26:25 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:53347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751373AbVKXQZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:25:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Wez1aCRN023ocljE7TeemBxQ6RHJsYkI0VPllo9Er9AnWNnOj5PQiT4yC8XHwjOdV6RTiTHdzD3uWLeeeRmhNf6ovJv9QfEYmCj9/B71EB9j8brEELlKv5jxKbFFAJHJ9jLpjthY7oZV99DhsO8xeozDr6BMMnqtc4DuEJo53ng=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051124162449.209CADD5@htj.dyndns.org>
In-Reply-To: <20051124162449.209CADD5@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 02/11] blk: separate out bio init part from __make_request
Message-ID: <20051124162449.87614A35@htj.dyndns.org>
Date: Fri, 25 Nov 2005 01:25:51 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_implement-init_request_from_bio.patch

	Separate out bio initialization part from __make_request.  It
        will be used by the following blk_ordered_reimpl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ll_rw_blk.c |   62 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

Index: work/block/ll_rw_blk.c
===================================================================
--- work.orig/block/ll_rw_blk.c	2005-11-25 00:52:01.000000000 +0900
+++ work/block/ll_rw_blk.c	2005-11-25 00:52:02.000000000 +0900
@@ -38,6 +38,8 @@
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
+static void init_request_from_bio(struct request *req, struct bio *bio);
+static int __make_request(request_queue_t *q, struct bio *bio);
 
 /*
  * For the allocated request tables
@@ -1651,8 +1653,6 @@ static int blk_init_free_list(request_qu
 	return 0;
 }
 
-static int __make_request(request_queue_t *, struct bio *);
-
 request_queue_t *blk_alloc_queue(gfp_t gfp_mask)
 {
 	return blk_alloc_queue_node(gfp_mask, -1);
@@ -2639,6 +2639,36 @@ void blk_attempt_remerge(request_queue_t
 
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
@@ -2734,33 +2764,7 @@ get_rq:
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

