Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCJGjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 01:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUCJGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 01:39:49 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:58375 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262272AbUCJGjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:39:46 -0500
Message-ID: <404EB824.1030806@cs.wisc.edu>
Date: Tue, 09 Mar 2004 22:39:32 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] set request fastfail bit
Content-Type: multipart/mixed;
 boundary="------------010400060006060505030807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010400060006060505030807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The first three bio and request flags are no longer identical.
The bio barrier and rw flags are getting set in __make_request
and get_request respectively, and failfast is getting
left out. The attached patch (built against 2.6.4-rc3)
sets the request's failfast flag in __make_request when the bio's
flag is set.

Mike Chrisite

--------------010400060006060505030807
Content-Type: text/plain;
 name="failfast.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="failfast.patch"

--- linux-2.6.4-rc3-orig/drivers/block/ll_rw_blk.c	2004-03-09 22:21:26.819208694 -0800
+++ linux-2.6.4-rc3-ff/drivers/block/ll_rw_blk.c	2004-03-09 22:37:02.395169904 -0800
@@ -2121,11 +2121,14 @@ get_rq:
 		goto again;
 	}
 
+	req->flags |= REQ_CMD;
+
 	/*
-	 * first three bits are identical in rq->flags and bio->bi_rw,
-	 * see bio.h and blkdev.h
+	 * inherit FAILFAST from bio and don't stack up
+	 * retries for read ahead
 	 */
-	req->flags = (bio->bi_rw & 7) | REQ_CMD;
+	if (ra || test_bit(BIO_RW_FAILFAST, &bio->bi_rw))	
+		req->flags |= REQ_FAILFAST;
 
 	/*
 	 * REQ_BARRIER implies no merging, but lets make it explicit
@@ -2133,12 +2136,6 @@ get_rq:
 	if (barrier)
 		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
 
-	/*
-	 * don't stack up retries for read ahead
-	 */
-	if (ra)
-		req->flags |= REQ_FAILFAST;
-
 	req->errors = 0;
 	req->hard_sector = req->sector = sector;
 	req->hard_nr_sectors = req->nr_sectors = nr_sectors;

--------------010400060006060505030807--

