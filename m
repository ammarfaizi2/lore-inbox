Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVCWJUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVCWJUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVCWJT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:19:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14018 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262897AbVCWJTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:19:40 -0500
Date: Wed, 23 Mar 2005 10:19:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for inconsistent recording of block device statistics
Message-ID: <20050323091916.GO24105@suse.de>
References: <42409313.1010308@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42409313.1010308@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22 2005, Mark Seger wrote:
> The read/write statistics for both sectors and merges are calculated at 
> the time requests first enter the request queue but the remainder of the 
> statistics, such as the number of read/writes are calculated at the time 
> the I/O completes.  As a result, one cannot accurately determine the 
> data rates read or written at the actual time the I/O is performed.  
> This behavior is masked with smaller queue sizes but is very real and 
> was very noticeable with earlier 2.6 kenels using the cfq scheduler 
> which had a default queue size of 8192 where the time difference between 
> these sets of counters could exceed 10 seconds for large file writes and 
> small monitoring intervals such as 1 second.  In that environment, one 
> would see extremely high bursts of I/O, sometimes exceeding 500 or even 
> 1000 MB/sec for the first second or two and then drop to 0 for a long 
> time while the 'number of operations' counters accurately reflect what 
> is really happening.
> 
> The attached patch fixes this problem by simply accumulating the 
> read/write sector/merge data in temporary variables stored in the 
> request queue entry, and when the I/O completes copies those values to 
> the disk statistics block.

I don't like this patch, it adds 4 * sizeof(unsigned long) to struct
request when it can be solved without adding anything. The idea is
sound, though, the current way the stats are done isn't very
interesting.

How about accounting merges the way we currently do it, since that piece
of the stats _is_ interesting at queueing time. And then account
completion in __end_that_request_first(). Untested patch attached.

===== drivers/block/ll_rw_blk.c 1.287 vs edited =====
--- 1.287/drivers/block/ll_rw_blk.c	2005-03-11 21:32:27 +01:00
+++ edited/drivers/block/ll_rw_blk.c	2005-03-23 10:10:39 +01:00
@@ -2294,16 +2293,12 @@
 	if (!blk_fs_request(rq) || !rq->rq_disk)
 		return;
 
-	if (rw == READ) {
-		__disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
-		if (!new_io)
+	if (!new_io) {
+		if (rw == READ)
 			__disk_stat_inc(rq->rq_disk, read_merges);
-	} else if (rw == WRITE) {
-		__disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
-		if (!new_io)
+		else
 			__disk_stat_inc(rq->rq_disk, write_merges);
-	}
-	if (new_io) {
+	} else {
 		disk_round_stats(rq->rq_disk);
 		rq->rq_disk->in_flight++;
 	}
@@ -3063,6 +3069,13 @@
 				(unsigned long long)req->sector);
 	}
 
+	if (blk_fs_request(req)) {
+		if (rq_data_dir(req) == READ)
+			__disk_stat_add(req->rq_disk, read_sectors, nr_bytes >> 9);
+		else
+			__disk_stat_add(req->rq_disk, write_sectors, nr_bytes >> 9);
+	}
+
 	total_bytes = bio_nbytes = 0;
 	while ((bio = req->bio) != NULL) {
 		int nbytes;

-- 
Jens Axboe

