Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317711AbSGZNd6>; Fri, 26 Jul 2002 09:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSGZNd6>; Fri, 26 Jul 2002 09:33:58 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:3081
	"EHLO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id <S317711AbSGZNdy>; Fri, 26 Jul 2002 09:33:54 -0400
Date: Fri, 26 Jul 2002 15:37:10 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sard I/O accounting bug in -ac
Message-ID: <20020726153710.A5368@ds217-115-141-141.dedicated.hosteurope.de>
References: <20020726111520.G23911@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726111520.G23911@fi.muni.cz>; from kas@informatics.muni.cz on Fri, Jul 26, 2002 at 11:15:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:15:20AM +0200, Jan Kasprzak wrote:
> 	Hello,
> 
> 	There is a minor bug in the I/O accounting in 2.4.19-rc1-ac2 (and
> probably later revisions as well - at least no fix to this is mentioned
> in the changelog). The problem is that the "running" item in /proc/partitions
> can get negative. Here is a part of my /proc/partitions:
> [...]

I tracked this problem down on hosts with SCSI disks, where an
accounting function was called without the appropriate lock held. (My
previous mail including a patch for this bug on SCSI is here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.1/0323.html .)

However, since you don't have SCSI disks, this will most likely not fix
your problem. But before I was able to track down this missing lock
issue, I could fix the problem by making the ios_in_flight variable use
atomic operations. Let me guess, you have an SMP machine, where a race
condition is likely to occur?

Below is my patch to use atomic operations (against 2.4.19-pre10) that
fixed the problem for me on an SMP machine with SCSI disks. (I don't
have a non-SCSI SMP machine to check.)

In the first chunk, I also added a check for negative ios_in_flight
values to the function generating the /proc/partitions output, and
eventually set them to zero. You should remove this part to see if
values are still becoming negative.

If this patch works, there must be another place where accounting is
done without proper spinlock handling. The atomic-patch should not be
the final solution for this!

> 
> 	BTW, is there any documentation describing the meaning of the values
> in /proc/partitions? What is the difference between rio/wio and rmerge/wmerge?
> In what units is ruse/wuse measured? I thought it means milisecond of
> read/write activity, but it grows far more by than 1000 per second for some
> partitions.
rio/wio are the total number of read/write requests processed, while
rmerge/wmerge is the number of successful merges of requests.


Bye
Jochen

-- 
Jochen Suckfuell  ---  http://www.suckfuell.net/jochen/  ---



diff -ru linux/drivers/block/genhd.c
linux-2.4.19pre10/drivers/block/genhd.c
--- linux/drivers/block/genhd.c	Fri Jun 14 13:09:26 2002
+++ linux-2.4.19pre10/drivers/block/genhd.c	Fri Jun 14 11:18:26 2002
@@ -177,6 +177,15 @@
 				continue;
 
 			hd = &gp->part[n]; disk_round_stats(hd);
+
+			if((int)atomic_read(&hd->ios_in_flight) < 0)
+			{
+				/* this happens mysteriously, so here is a cheap workaround
*/
+				atomic_set(&hd->ios_in_flight, 0);
+
+				printk("get_partition_list() corrected ios_in_flight for
%s\n", disk_name(gp, n, buf));
+			}
+
 			len += sprintf(page + len,
 					"%4d  %4d %10d %s "
 					"%d %d %d %d %d %d %d %d %d %d %d\n",
@@ -189,7 +198,7 @@
 					hd->wr_ios, hd->wr_merges,
 					hd->wr_sectors,
 					MSEC(hd->wr_ticks),
-					hd->ios_in_flight,
+					atomic_read(&hd->ios_in_flight),
 					MSEC(hd->io_ticks),
 					MSEC(hd->aveq));
 #undef MSEC
diff -ru linux/drivers/block/ll_rw_blk.c
linux-2.4.19pre10/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Fri Jun 14 13:09:27 2002
+++ linux-2.4.19pre10/drivers/block/ll_rw_blk.c	Fri Jun 14 11:19:17 2002
@@ -631,10 +631,10 @@
 {
 	unsigned long now = jiffies;
 	
-	hd->aveq += (hd->ios_in_flight * (jiffies - hd->last_queue_change));
+	hd->aveq += ((int)atomic_read(&hd->ios_in_flight) * (jiffies -
hd->last_queue_change));
 	hd->last_queue_change = now;
 
-	if (hd->ios_in_flight)
+	if ((int)atomic_read(&hd->ios_in_flight))
 		hd->io_ticks += (now - hd->last_idle_time);
 	hd->last_idle_time = now;	
 }
@@ -643,13 +643,13 @@
 static inline void down_ios(struct hd_struct *hd)
 {
 	disk_round_stats(hd);	
-	--hd->ios_in_flight;
+	atomic_dec(&hd->ios_in_flight);
 }
 
 static inline void up_ios(struct hd_struct *hd)
 {
 	disk_round_stats(hd);
-	++hd->ios_in_flight;
+	atomic_inc(&hd->ios_in_flight);
 }
 
 static void account_io_start(struct hd_struct *hd, struct request *req,
diff -ru linux/include/linux/genhd.h
linux-2.4.19pre10/include/linux/genhd.h
--- linux/include/linux/genhd.h	Fri Jun 14 13:16:45 2002
+++ linux-2.4.19pre10/include/linux/genhd.h	Fri Jun 14 12:15:43 2002
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/major.h>
+#include <asm/atomic.h>
 
 enum {
 /* These three have identical behaviour; use the second one if DOS
 * fdisk gets
@@ -65,7 +66,7 @@
 	int number;                     /* stupid old code wastes space  */
 
 	/* Performance stats: */
-	unsigned int ios_in_flight;
+	atomic_t ios_in_flight;
 	unsigned int io_ticks;
 	unsigned int last_idle_time;
 	unsigned int last_queue_change;


