Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVGZPt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVGZPt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGZPrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:55 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:19477 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261860AbVGZPqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=IYeADZ9a+nQl3pfbhz6k6/IF+vkOk6NXv8gwfVB9YG/lqNYaCmZaYTN60T17c6UlOD1L9rgANhEYDPKwaguatg28IJck1czDYBINV6IBUzdeFl8+6+5oB4wX7QJNMqiy7Uny6+Cdu1JFrmx1T0y6hDIfRfCc3qUogyx9+w9wvPk=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 02/10] blk: separate out bio init part from __make_request
Message-ID: <20050726154457.D35AC817@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:01 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_implement-init_request_from_bio.patch

	Separate out bio initialization part from __make_request.  It
        will be used by the following blk_ordered_reimpl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ll_rw_blk.c |   59 ++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 32 insertions(+), 27 deletions(-)

Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-07-27 00:44:50.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-07-27 00:44:50.000000000 +0900
@@ -36,6 +36,8 @@
 
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
+static void init_request_from_bio(struct request *req, struct bio *bio);
+static int __make_request(request_queue_t *q, struct bio *bio);
 
 /*
  * For the allocated request tables
@@ -1655,8 +1657,6 @@ static int blk_init_free_list(request_qu
 	return 0;
 }
 
-static int __make_request(request_queue_t *, struct bio *);
-
 request_queue_t *blk_alloc_queue(int gfp_mask)
 {
 	request_queue_t *q = kmem_cache_alloc(requestq_cachep, gfp_mask);
@@ -2555,6 +2555,35 @@ void blk_attempt_remerge(request_queue_t
 
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
+	req->rq_disk = bio->bi_bdev->bd_disk;
+	req->start_time = jiffies;
+}
+
 /*
  * Non-locking blk_attempt_remerge variant.
  */
@@ -2678,31 +2707,7 @@ get_rq:
 		goto again;
 	}
 
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
-	if (barrier)
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
-	req->rq_disk = bio->bi_bdev->bd_disk;
-	req->start_time = jiffies;
+	init_request_from_bio(req, bio);
 
 	add_request(q, req);
 out:

