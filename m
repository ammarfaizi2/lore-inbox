Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbTIBKr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTIBKr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:47:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9900 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263701AbTIBKrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:47:23 -0400
Date: Tue, 2 Sep 2003 16:24:11 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] Remove percpufication of in_flight counter in diskstats
Message-ID: <20030902105409.GC1272@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
The routine disk_round_stats showed up considerably under oprofile 
for high disk io load (four processes doing dd to the same disk 
(different partitions) on a 4 way).  This is because the counter 
in_flight which is per-cpu right now gets read every time disk_round_stats 
gets called.  Per cpu counters like disk statistics improve write speed, 
but reads are slow (since all cpus' local counter values have to be 
read and summed up).
Considering the fact that in_flight counter is modified post disk_round_stats
(which reads the in_flight counter) it is better not to per-cpu this counter.

Following patch does just that.  Below is the profile comparison before
and after the change.  This was on a 4 way PIII Xeon, 1G ram, 2.6.0-test4-mm2.
Please apply.

Thanks,
Kiran


Before:
c010aa60 2910109  92.2249     poll_idle
c0275340 23208    0.73549     __copy_to_user_ll
c02753b0 11191    0.354657    __copy_from_user_ll
c0114aa0 7168     0.227163    mark_offset_tsc
c011ad10 6767     0.214455    schedule
c011a2b0 6741     0.213631    load_balance
c0138890 6710     0.212648    __generic_file_aio_write_nolock
c011d302 4683     0.14841     .text.lock.sched
c02e4b50 4533     0.143656    ahc_linux_isr
c029cec0 3582     0.113518    disk_round_stats
c0119b40 3509     0.111205    try_to_wake_up
c029d320 3306     0.104771    __make_request
c01567d0 3300     0.104581    __block_write_full_page
c0156c00 3299     0.104549    __block_prepare_write

After:
c010aa60 2777940  92.1302     poll_idle
c0275340 23479    0.778679    __copy_to_user_ll
c02753b0 10943    0.362924    __copy_from_user_ll
c0114aa0 7022     0.232884    mark_offset_tsc
c0138890 6988     0.231757    __generic_file_aio_write_nolock
c011ad10 6607     0.219121    schedule
c011d302 5771     0.191395    .text.lock.sched
c02e4a60 4458     0.147849    ahc_linux_isr
c011a2b0 3921     0.13004     load_balance
c01567d0 3569     0.118366    __block_write_full_page
c029d2a0 3540     0.117404    __make_request
...
c029ceb0 311      0.0103143   disk_round_stats
c011d5b0 299      0.00991631  remove_wait_queue


diff -ruN -X dontdiff linux-2.6.0-test4/drivers/block/genhd.c diskstat-mod-2.6.0-test4/drivers/block/genhd.c
--- linux-2.6.0-test4/drivers/block/genhd.c	2003-08-23 05:25:38.000000000 +0530
+++ diskstat-mod-2.6.0-test4/drivers/block/genhd.c	2003-09-01 21:36:43.000000000 +0530
@@ -372,7 +372,7 @@
 		disk_stat_read(disk, write_merges),
 		(unsigned long long)disk_stat_read(disk, write_sectors),
 		jiffies_to_msec(disk_stat_read(disk, write_ticks)),
-		disk_stat_read(disk, in_flight), 
+		disk->in_flight, 
 		jiffies_to_msec(disk_stat_read(disk, io_ticks)),
 		jiffies_to_msec(disk_stat_read(disk, time_in_queue)));
 }
@@ -492,7 +492,7 @@
 		disk_stat_read(gp, writes), disk_stat_read(gp, write_merges),
 		(unsigned long long)disk_stat_read(gp, write_sectors),
 		jiffies_to_msec(disk_stat_read(gp, write_ticks)),
-		disk_stat_read(gp, in_flight),
+		gp->in_flight,
 		jiffies_to_msec(disk_stat_read(gp, io_ticks)),
 		jiffies_to_msec(disk_stat_read(gp, time_in_queue)));
 
diff -ruN -X dontdiff linux-2.6.0-test4/drivers/block/ll_rw_blk.c diskstat-mod-2.6.0-test4/drivers/block/ll_rw_blk.c
--- linux-2.6.0-test4/drivers/block/ll_rw_blk.c	2003-08-23 05:22:13.000000000 +0530
+++ diskstat-mod-2.6.0-test4/drivers/block/ll_rw_blk.c	2003-09-01 21:51:30.000000000 +0530
@@ -1652,7 +1652,7 @@
 	}
 	if (new_io) {
 		disk_round_stats(rq->rq_disk);
-		disk_stat_inc(rq->rq_disk, in_flight);
+		rq->rq_disk->in_flight++;
 	}
 }
 
@@ -1693,10 +1693,10 @@
 	unsigned long now = jiffies;
 
 	disk_stat_add(disk, time_in_queue, 
-			disk_stat_read(disk, in_flight) * (now - disk->stamp));
+			disk->in_flight * (now - disk->stamp));
 	disk->stamp = now;
 
-	if (disk_stat_read(disk, in_flight))
+	if (disk->in_flight)
 		disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
 	disk->stamp_idle = now;
 }
@@ -1808,7 +1808,7 @@
 
 	if (req->rq_disk) {
 		disk_round_stats(req->rq_disk);
-		disk_stat_dec(req->rq_disk, in_flight);
+		req->rq_disk->in_flight--;
 	}
 
 	__blk_put_request(q, next);
@@ -2470,7 +2470,7 @@
 			break;
 		}
 		disk_round_stats(disk);
-		disk_stat_dec(disk, in_flight);
+		disk->in_flight--;
 	}
 	__blk_put_request(req->q, req);
 	/* Do this LAST! The structure may be freed immediately afterwards */
diff -ruN -X dontdiff linux-2.6.0-test4/include/linux/genhd.h diskstat-mod-2.6.0-test4/include/linux/genhd.h
--- linux-2.6.0-test4/include/linux/genhd.h	2003-08-23 05:22:28.000000000 +0530
+++ diskstat-mod-2.6.0-test4/include/linux/genhd.h	2003-09-01 14:45:50.000000000 +0530
@@ -75,7 +75,6 @@
 	unsigned read_merges, write_merges;
 	unsigned read_ticks, write_ticks;
 	unsigned io_ticks;
-	int in_flight;
 	unsigned time_in_queue;
 };
 	
@@ -101,6 +100,7 @@
 
 	unsigned sync_io;		/* RAID */
 	unsigned long stamp, stamp_idle;
+	int in_flight;
 #ifdef	CONFIG_SMP
 	struct disk_stats *dkstats;
 #else
