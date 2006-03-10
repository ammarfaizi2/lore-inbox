Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWCJASB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWCJASB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWCJASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:18:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751362AbWCJASA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:18:00 -0500
Subject: [PATCH: 2.6.15-rc5] block layer: increase size of disk stat
	counters
From: Ben Woodard <woodard@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 09 Mar 2006 16:17:50 -0800
Message-Id: <1141949870.7334.1.camel@quince.llnl.gov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel's representation of the disk statistics uses the type 
unsigned which is 32b on both 32b and 64b platforms. Unfortunately, most 
system tools that work with these numbers that are exported in 
/proc/diskstats including iostat read these numbers into unsigned longs. 
This works fine on 32b platforms and when the number of IO transactions 
are small on 64b platforms. However, when the numbers wrap on 64b 
platforms & you read the numbers into unsigned longs, and compare the 
numbers to previous readings, then you get an unsigned representation of 
a negative number. This looks like a very large 64b number & gives 
you bizarre readouts in iostat:

ilc4: Device:    rrqm/s wrqm/s r/s    w/s  rsec/s  wsec/s    rkB/s wkB/s avgrq-sz avgqu-sz   await  svctm  %util
ilc4: sda        5.50   0.00   143.96 0.00 307496983987862656.00 0.00 153748491993931328.00     0.00 2136028725038430.00     7.94   55.12    5.59  80.42

Though fixing iostat in user space is possible, and a quick survey 
indicates that several other similar tools also use unsigned longs when 
processing /proc/diskstats. Therefore, it seems like a better approach 
would be to extend the length of the disk_stats structure on 64b 
architectures to 64b. The following patch does that. It should not 
affect the operation on 32b platforms.

Signed-off-by: Ben Woodard <woodard@redhat.com>

diff -rup linux-2.6.15-rc5.orig/block/genhd.c linux-2.6.15-rc5/block/genhd.c
--- linux-2.6.15-rc5.orig/block/genhd.c 2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/block/genhd.c      2006-03-09 14:55:30.000000000 -0800
@@ -387,8 +387,8 @@ static ssize_t disk_stats_read(struct ge
        disk_round_stats(disk);
        preempt_enable();
        return sprintf(page,
-               "%8u %8u %8llu %8u "
-               "%8u %8u %8llu %8u "
+               "%8lu %8lu %8llu %8u "
+               "%8lu %8lu %8llu %8u "
                "%8u %8u %8u"
                "\n",
                disk_stat_read(disk, ios[READ]),
@@ -582,7 +582,7 @@ static int diskstats_show(struct seq_fil
        preempt_disable();
        disk_round_stats(gp);
        preempt_enable();
-       seq_printf(s, "%4d %4d %s %u %u %llu %u %u %u %llu %u %u %u %u\n",
+       seq_printf(s, "%4d %4d %s %lu %lu %llu %u %lu %lu %llu %u %u %u %u\n",
                gp->major, n + gp->first_minor, disk_name(gp, n, buf),
                disk_stat_read(gp, ios[0]), disk_stat_read(gp, merges[0]),
                (unsigned long long)disk_stat_read(gp, sectors[0]),
diff -rup linux-2.6.15-rc5.orig/include/linux/genhd.h linux-2.6.15-rc5/include/linux/genhd.h
--- linux-2.6.15-rc5.orig/include/linux/genhd.h 2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/genhd.h      2006-03-09 14:58:42.000000000 -0800
@@ -89,12 +89,12 @@ struct hd_struct {
 #define GENHD_FL_SUPPRESS_PARTITION_INFO       32
 
 struct disk_stats {
-       unsigned sectors[2];            /* READs and WRITEs */
-       unsigned ios[2];
-       unsigned merges[2];
-       unsigned ticks[2];
-       unsigned io_ticks;
-       unsigned time_in_queue;
+       unsigned long sectors[2];               /* READs and WRITEs */
+       unsigned long ios[2];
+       unsigned long merges[2];
+       unsigned long ticks[2];
+       unsigned long io_ticks;
+       unsigned long time_in_queue;
 };
        
 struct gendisk {

-- 

