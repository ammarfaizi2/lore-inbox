Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVDLTC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVDLTC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVDLTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:01:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:60617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262222AbVDLKcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:41 -0400
Message-Id: <200504121032.j3CAWZ3N005633@shell0.pdx.osdl.net>
Subject: [patch 124/198] possible use-after-free of bio
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, axboe@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jens Axboe <axboe@suse.de>

There is a possibility that a bio will be accessed after it has been freed
on SCSI.  It happens if you submit a bio with BIO_SYNC marked and the
auto-unplugging kicks the request_fn, SCSI re-enables interrupts in-between
so if the request completes between the add_request() in __make_request()
and the bio_sync() call, we could be looking at a dead bio.  It's a slim
race, but it has been triggered in the Real World.

So assign bio_sync() to a local variable instead.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/block/ll_rw_blk.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~possible-use-after-free-of-bio drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~possible-use-after-free-of-bio	2005-04-12 03:21:33.400059320 -0700
+++ 25-akpm/drivers/block/ll_rw_blk.c	2005-04-12 03:21:33.405058560 -0700
@@ -2559,7 +2559,7 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req, *freereq = NULL;
-	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err;
+	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err, sync;
 	sector_t sector;
 
 	sector = bio->bi_sector;
@@ -2567,6 +2567,7 @@ static int __make_request(request_queue_
 	cur_nr_sectors = bio_cur_sectors(bio);
 
 	rw = bio_data_dir(bio);
+	sync = bio_sync(bio);
 
 	/*
 	 * low level driver can indicate that it wants pages above a
@@ -2698,7 +2699,7 @@ get_rq:
 out:
 	if (freereq)
 		__blk_put_request(q, freereq);
-	if (bio_sync(bio))
+	if (sync)
 		__generic_unplug_device(q);
 
 	spin_unlock_irq(q->queue_lock);
_
