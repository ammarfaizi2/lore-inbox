Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTEGXNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTEGXLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:11:49 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:5248 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S264332AbTEGXKH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:10:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fixes for linked list bugs in block I/O code
Date: Wed, 7 May 2003 16:22:36 -0700
User-Agent: KMail/1.4.1
Cc: axboe@suse.de, davej@suse.de, dsp@llnl.gov
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305071622.36352.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a couple of small linked list bugs in __make_request() in
drivers/block/ll_rw_blk.c.  The bugs exist in both kernels
2.4.20 and 2.5.69.  Therefore I have made patches for both
kernels.  The problem is that when inserting a new buffer_head
into the linked list of buffer_head structures maintained by
"struct request", the b_reqnext field is not initialized.

-Dave Peterson
 dsp@llnl.gov


========== START OF 2.4.20 PATCH FOR drivers/block/ll_rw_blk.c ===========
--- ll_rw_blk.c.old     Wed May  7 15:54:58 2003
+++ ll_rw_blk.c.new     Wed May  7 15:58:07 2003
@@ -973,6 +973,7 @@
                                insert_here = &req->queue;
                                break;
                        }
+                       bh->b_reqnext = req->bhtail->b_reqnext;
                        req->bhtail->b_reqnext = bh;
                        req->bhtail = bh;
                        req->nr_sectors = req->hard_nr_sectors += count;
@@ -1061,6 +1062,7 @@
        req->waiting = NULL;
        req->bh = bh;
        req->bhtail = bh;
+       bh->b_reqnext = NULL;
        req->rq_dev = bh->b_rdev;
        req->start_time = jiffies;
        req_new_io(req, 0, count);
========== END OF 2.4.20 PATCH FOR drivers/block/ll_rw_blk.c =============


========== START OF 2.5.69 PATCH FOR drivers/block/ll_rw_blk.c ===========
--- ll_rw_blk.c.old     Wed May  7 15:55:18 2003
+++ ll_rw_blk.c.new     Wed May  7 16:01:56 2003
@@ -1721,6 +1721,7 @@
                                break;
                        }

+                       bio->bi_next = req->biotail->bi_next;
                        req->biotail->bi_next = bio;
                        req->biotail = bio;
                        req->nr_sectors = req->hard_nr_sectors += nr_sectors;
@@ -1811,6 +1812,7 @@
        req->buffer = bio_data(bio);    /* see ->buffer comment above */
        req->waiting = NULL;
        req->bio = req->biotail = bio;
+       bio->bi_next = NULL;
        req->rq_disk = bio->bi_bdev->bd_disk;
        req->start_time = jiffies;
        add_request(q, req, insert_here);
========== END OF 2.5.69 PATCH FOR drivers/block/ll_rw_blk.c =============
