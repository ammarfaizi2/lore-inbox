Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVCVVvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVCVVvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCVVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:51:05 -0500
Received: from inmail.compaq.com ([161.114.64.101]:21518 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262047AbVCVVuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:50:16 -0500
Message-ID: <42409313.1010308@hp.com>
Date: Tue, 22 Mar 2005 16:50:11 -0500
From: Mark Seger <Mark.Seger@hp.com>
Organization: Consulting and Architecture
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Patch for inconsistent recording of block device statistics
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read/write statistics for both sectors and merges are calculated at 
the time requests first enter the request queue but the remainder of the 
statistics, such as the number of read/writes are calculated at the time 
the I/O completes.  As a result, one cannot accurately determine the 
data rates read or written at the actual time the I/O is performed.  
This behavior is masked with smaller queue sizes but is very real and 
was very noticeable with earlier 2.6 kenels using the cfq scheduler 
which had a default queue size of 8192 where the time difference between 
these sets of counters could exceed 10 seconds for large file writes and 
small monitoring intervals such as 1 second.  In that environment, one 
would see extremely high bursts of I/O, sometimes exceeding 500 or even 
1000 MB/sec for the first second or two and then drop to 0 for a long 
time while the 'number of operations' counters accurately reflect what 
is really happening.

The attached patch fixes this problem by simply accumulating the 
read/write sector/merge data in temporary variables stored in the 
request queue entry, and when the I/O completes copies those values to 
the disk statistics block.

-mark

diff -uprN -X dontdiff ../linux-2.6.11.4/drivers/block/ll_rw_blk.c 
../linux-2.6.11.4-mjs/drivers/block/ll_rw_blk.c
--- ../linux-2.6.11.4/drivers/block/ll_rw_blk.c    2005-03-15 
19:09:00.000000000 -0500
+++ ../linux-2.6.11.4-mjs/drivers/block/ll_rw_blk.c    2005-03-22 
15:43:07.000000000 -0500
@@ -2107,13 +2107,13 @@ void drive_stat_acct(struct request *rq,
         return;
 
     if (rw == READ) {
-        __disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
+                rq->read_sectors_accum += nr_sectors;
         if (!new_io)
-            __disk_stat_inc(rq->rq_disk, read_merges);
+                        rq->read_merges_accum += 1;
     } else if (rw == WRITE) {
-        __disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
+                rq->write_sectors_accum += nr_sectors;
         if (!new_io)
-            __disk_stat_inc(rq->rq_disk, write_merges);
+                        rq->write_merges_accum += 1;
     }
     if (new_io) {
         disk_round_stats(rq->rq_disk);
@@ -2487,6 +2487,11 @@ get_rq:
     req->rq_disk = bio->bi_bdev->bd_disk;
     req->start_time = jiffies;
 
+        req->write_sectors_accum=0;
+    req->write_merges_accum=0;
+        req->read_sectors_accum=0;
+    req->read_merges_accum=0;
+
     add_request(q, req);
 out:
     if (freereq)
@@ -2989,10 +2994,14 @@ void end_that_request_last(struct reques
             case WRITE:
             __disk_stat_inc(disk, writes);
             __disk_stat_add(disk, write_ticks, duration);
+                        __disk_stat_add(disk, write_sectors, 
req->write_sectors_accum);
+                        __disk_stat_add(disk, write_merges,  
req->write_merges_accum);
             break;
             case READ:
             __disk_stat_inc(disk, reads);
             __disk_stat_add(disk, read_ticks, duration);
+                        __disk_stat_add(disk, read_sectors, 
req->read_sectors_accum);
+                        __disk_stat_add(disk, read_merges,  
req->read_merges_accum);
             break;
         }
         disk_round_stats(disk);
diff -uprN -X dontdiff ../linux-2.6.11.4/include/linux/blkdev.h 
../linux-2.6.11.4-mjs/include/linux/blkdev.h
--- ../linux-2.6.11.4/include/linux/blkdev.h    2005-03-15 
19:09:02.000000000 -0500
+++ ../linux-2.6.11.4-mjs/include/linux/blkdev.h    2005-03-22 
15:42:47.000000000 -0500
@@ -176,6 +176,12 @@ struct request {
      * For Power Management requests
      */
     struct request_pm_state *pm;
+
+    /*
+     * accumulate intermediate stats
+     */
+        unsigned long read_sectors_accum, write_sectors_accum;
+        unsigned long read_merges_accum, write_merges_accum;
 };
 
 /*

