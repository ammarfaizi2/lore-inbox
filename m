Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTLYPNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 10:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTLYPNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 10:13:54 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:11913 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264315AbTLYPM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 10:12:58 -0500
Message-ID: <3FEAFE66.2020602@samwel.tk>
Date: Thu, 25 Dec 2003 16:12:38 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] laptop-mode for 2.6, version 4 + smart_spindown
References: <3FE92517.1000306@samwel.tk> <20031224111640.GL1601@suse.de> <3FE9AFFC.2080302@samwel.tk> <20031225100648.GB13382@conectiva.com.br>
In-Reply-To: <20031225100648.GB13382@conectiva.com.br>
Content-Type: multipart/mixed;
 boundary="------------050400010809010802080609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400010809010802080609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Arnaldo Carvalho de Melo wrote:
> Minor nitpicks below
[...]
>>+int laptop_mode = 0;
> 
> No need to set a global variable to 0, if you don't set it'll go to the
> .bss section and the kernel will zero it out for us, and we reclaim 
> 2 * sizeof(int) from the kernel image. This is common style in most parts
> of the kernel.

Thanks, I've fixed this. Here is the resulting patch.

I've got another problem getting this stuff to work. The problem lies 
with my HD: it just doesn't respect the spindown time, I've got it set 
to hdparm -S 4 and it just doesn't spin down, even though there's no 
activity whatsoever! hdparm -B 254 gives me:

/dev/hdb:
  setting Advanced Power Management level to 0xFE (254)
  HDIO_DRIVE_CMD failed: Input/output error

It's funny, because hdparm -I gives me:

Commands/features:
         Enabled Supported:
[...]
            *    Power Management feature set

So, it should support this. Apparently it doesn't. :( The drive is a WD 
800BB. Does anyone have any clue what could cause this?

Anyway, I've built myself a solution called "smart_spindown". This 
script monitors the read activity on a drive, and if there hasn't been 
any read activity in a while it spins down the drive. The amount of 
read-inactivity needed is subjected to an exponential backoff algorithm: 
when spun-down periods last shorter, the amount of inactivity needed for 
triggering a spindown increases. When the system is low on activity, the 
script is more aggressive w.r.t. spinning down the disk, and when you're 
using the system it usually doesn't spin down the disk. The algorithm 
can be tuned to your personal needs, so you can set it to be more 
aggressive if you want to.

Interestingly, I found out that this script removes my need for 
laptop_mode. I've added an option to the beginning called 
NO_LAPTOP_MODE, if you set that to true it will sync just before 
spinning the disk down. This even adds a bit of spun-down time, as the 
sync takes place just before spinning down the disk instead of just 
after the last read. The only downside to this is that it syncs ALL 
disks, not only the disk that it monitors. However, this is really 
getting me spun-down times of about 595 seconds, while my expires are 
set to 600 seconds. This makes me a very happy bunny indeed!

Short explanation of how the script can be used:
* Edit the script to set:
   1. the disk name (DISK=)
   2. the stats file (STATSFILE=), if your sysfs isn't mounted on /sys.
   3. the device name (DEVNAME=), if the device isn't /dev/$DISK.
* Tune the OUTLEVEL1 and OUTLEVEL2 values to set the verbosity.
* Tune other parameters as needed. See the comments in the script.
* Run it as root, or as someone who can run hdparm. :)

If you want to use the script as a replacement of laptop_mode, you must 
adjust the VM parameters yourself, like it is done in the laptop_mode 
control script; see the comments above NO_LAPTOP_MODE in the script.

Bart

--------------050400010809010802080609
Content-Type: text/plain;
 name="laptop-mode-2.6.0-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="laptop-mode-2.6.0-4.patch"

diff -baur --speed-large-files linux-2.6.0/drivers/block/ll_rw_blk.c linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c
--- linux-2.6.0/drivers/block/ll_rw_blk.c	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c	2003-12-24 15:54:37.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/writeback.h>
 
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
@@ -2307,6 +2308,15 @@
 		mod_page_state(pgpgout, count);
 	else
 		mod_page_state(pgpgin, count);
+
+	if (unlikely(block_dump)) {
+		char b[BDEVNAME_SIZE];
+		printk("%s(%d): %s block %lu on %s\n",
+			current->comm, current->pid,
+			(rw & WRITE) ? "WRITE" : (rw == READA ? "READA" : "READ"),
+			bio->bi_sector, bdevname(bio->bi_bdev,b));
+	}
+
 	generic_make_request(bio);
 	return 1;
 }
@@ -2582,6 +2592,14 @@
 
 EXPORT_SYMBOL(end_that_request_chunk);
 
+static struct timer_list writeback_timer;
+
+static void blk_writeback_timer(unsigned long data)
+{
+	wakeup_bdflush(0);
+	wakeup_kupdate();
+}
+
 /*
  * queue lock must be held
  */
@@ -2598,6 +2616,11 @@
 			disk_stat_add(disk, write_ticks, duration);
 			break;
 		    case READ:
+			/*
+			 * schedule the writeout of pending dirty data when the disk is idle
+			 */
+			if (unlikely(laptop_mode))
+				mod_timer(&writeback_timer, jiffies + 5 * HZ);
 			disk_stat_inc(disk, reads);
 			disk_stat_add(disk, read_ticks, duration);
 			break;
@@ -2689,6 +2712,10 @@
 
 	for (i = 0; i < ARRAY_SIZE(congestion_wqh); i++)
 		init_waitqueue_head(&congestion_wqh[i]);
+	
+	init_timer(&writeback_timer);
+	writeback_timer.function = blk_writeback_timer;
+	
 	return 0;
 }
 
diff -baur --speed-large-files linux-2.6.0/fs/buffer.c linux-2.6.0-withlaptopmode/fs/buffer.c
--- linux-2.6.0/fs/buffer.c	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/fs/buffer.c	2003-12-24 15:46:30.000000000 +0100
@@ -855,10 +855,13 @@
 		struct buffer_head *bh = head;
 
 		do {
-			if (buffer_uptodate(bh))
+			if (buffer_uptodate(bh)) {
 				set_buffer_dirty(bh);
-			else
+				if (unlikely(block_dump))
+					printk("%s(%d): dirtied buffer\n", current->comm, current->pid);
+			} else {
 				buffer_error();
+			}
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
diff -baur --speed-large-files linux-2.6.0/include/linux/sysctl.h linux-2.6.0-withlaptopmode/include/linux/sysctl.h
--- linux-2.6.0/include/linux/sysctl.h	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/include/linux/sysctl.h	2003-12-24 03:17:36.000000000 +0100
@@ -154,6 +154,8 @@
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_LAPTOP_MODE=22,      /* vm laptop mode */
+	VM_BLOCK_DUMP=23,       /* block dump mode */
 };
 
 
diff -baur --speed-large-files linux-2.6.0/include/linux/writeback.h linux-2.6.0-withlaptopmode/include/linux/writeback.h
--- linux-2.6.0/include/linux/writeback.h	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/include/linux/writeback.h	2003-12-24 06:01:47.000000000 +0100
@@ -71,12 +71,15 @@
  * mm/page-writeback.c
  */
 int wakeup_bdflush(long nr_pages);
+int wakeup_kupdate(void);
 
-/* These 5 are exported to sysctl. */
+/* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
 extern int dirty_writeback_centisecs;
 extern int dirty_expire_centisecs;
+extern int block_dump;
+extern int laptop_mode;
 
 struct ctl_table;
 struct file;
diff -baur --speed-large-files linux-2.6.0/kernel/sysctl.c linux-2.6.0-withlaptopmode/kernel/sysctl.c
--- linux-2.6.0/kernel/sysctl.c	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/kernel/sysctl.c	2003-12-24 06:24:53.000000000 +0100
@@ -700,6 +700,26 @@
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+	{
+		.ctl_name	= VM_LAPTOP_MODE,
+		.procname	= "laptop_mode",
+		.data		= &laptop_mode,
+		.maxlen		= sizeof(laptop_mode),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= VM_BLOCK_DUMP,
+		.procname	= "block_dump",
+		.data		= &block_dump,
+		.maxlen		= sizeof(block_dump),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -baur --speed-large-files linux-2.6.0/mm/page-writeback.c linux-2.6.0-withlaptopmode/mm/page-writeback.c
--- linux-2.6.0/mm/page-writeback.c	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/mm/page-writeback.c	2003-12-25 13:36:29.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/smp.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/quotaops.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -81,6 +82,16 @@
  */
 int dirty_expire_centisecs = 30 * 100;
 
+/*
+ * Flag that makes the machine dump writes/reads and block dirtyings.
+ */
+int block_dump;
+
+/*
+ * Flag that puts the machine in "laptop mode".
+ */
+int laptop_mode;
+
 /* End of sysctl-exported parameters */
 
 
@@ -167,7 +178,7 @@
 
 		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
 		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
-		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
+		if (laptop_mode || nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 			break;
 
 		dirty_exceeded = 1;
@@ -192,10 +203,11 @@
 		blk_congestion_wait(WRITE, HZ/10);
 	}
 
-	if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
+	if (laptop_mode || nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 		dirty_exceeded = 0;
 
-	if (!writeback_in_progress(bdi) && nr_reclaimable > background_thresh)
+	if (!laptop_mode &&
+	    !writeback_in_progress(bdi) && nr_reclaimable > background_thresh)
 		pdflush_operation(background_writeout, 0);
 }
 
@@ -327,6 +339,8 @@
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+	if (laptop_mode)
+		wbc.older_than_this = NULL;
 	nr_to_write = ps.nr_dirty + ps.nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
 	while (nr_to_write > 0) {
@@ -343,6 +357,11 @@
 	}
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
+	if (laptop_mode) {
+		sync_inodes(0);
+		sync_filesystems(0);
+		DQUOT_SYNC(NULL);
+	}
 	if (dirty_writeback_centisecs)
 		mod_timer(&wb_timer, next_jif);
 }
@@ -363,6 +382,15 @@
 	return 0;
 }
 
+/*
+ * Set the kupdate timer to run it as soon as possible.
+ */
+int wakeup_kupdate(void)
+{
+	mod_timer(&wb_timer, jiffies);
+	return 0;
+}
+
 static void wb_timer_fn(unsigned long unused)
 {
 	if (pdflush_operation(wb_kupdate, 0) < 0)
@@ -525,6 +553,8 @@
 				__mark_inode_dirty(mapping->host,
 							I_DIRTY_PAGES);
 		}
+		if (unlikely(block_dump))
+			printk("%s(%d): dirtied page\n", current->comm, current->pid);
 	}
 	return ret;
 }

--------------050400010809010802080609
Content-Type: text/plain;
 name="smart_spindown"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smart_spindown"

#! /bin/bash
#
# smart_spindown rev. 1
#
# Copyright (C) 2003 by Bart Samwel
#
# You may do with this file (and parts thereof) whatever you want, as long
# as my copyright notice is retained.
#
#
# How it works: This program monitors the read activity on a disk. If there
# is no read activity for a while, the disk is spun down. The time without
# read activity that is required is dynamic, using a backoff factor. When
# the recent spun-down periods are relatively short, this means that the
# machine might be busy with something, so the script tries to wait for
# longer periods without activity before spinning down again. When spun-down
# periods are long, the backoff factor is decreased, and the disk is spun
# down after shorter periods without read activity.
#
# This script REQUIRES that laptop_mode is enabled on your kernel. This is
# because it assumes that after a couple of seconds without read activity,
# all dirty blocks will be flushed. If this is not done, the disc will
# spin up at random times
#
# Configuration
#

# Output levels. Level 2 is verbose, level 1 is normal output.
# Enable all levels you would like to see.
OUTLEVEL1=true
OUTLEVEL2=false

# Disk to monitor.
DISK=hdb

# Device name for the disk.
DEVNAME=/dev/$DISK

# Stats file: the file used to monitor the disk's read activity.
# The first entry in this stats file must represent the read activity.
STATSFILE=/sys/block/$DISK/stat

# Multiplication factor for the backoff after a spinup, in percentages.
# Default is 300 = factor 3.
BACKOFF_INCREASE_PCT=300

# Multiplication factor for the backoff at every poll that shows that
# the disk is spun down. This determines how fast the backoff value
# decreases.
BACKOFF_DECREASE_PCT=96

# The base "no reads" wait time (in seconds). This is multiplied by
# the backoff factor to determine the real "no reads" wait time.
WAITTIME=20

# The maximum "no reads" wait time (in seconds).
# This also limits the backoff factor: the backoff factor cannot increase
# above a value that makes the "no reads" wait time larger than MAXWAIT.
# Default is 120 seconds.
MAXWAIT=120

# Time (in seconds) between polls to see if the disk is active again.
# Default is 10 seconds.
POLLTIME=10

# Enable this if you don't use laptop_mode. This will make the script
# sync before spinning down the disc. To make this work, you must
# ensure that:
# 1. /proc/sys/vm/dirty_expire_centisecs is set to a high value. You can
#    use 60000 for 10 minutes.
# 2. /proc/sys/vm/dirty_writeback_centisecs is set to the same value.
# 3. Your ext3 filesystems are mounted with "commit=n", where n is the
#    number of seconds between commit. Use 600 for 10 minutes.
NO_LAPTOP_MODE=false


#
# Let's go!
#

# Number of poll times that the disc was found to be spun down.
POLLSSPUNDOWN=0

# Number of spindowns performed
SPINDOWNS=0

# Number of times (*100) the WAITTIME of no-reads required before spindown
BACKOFF_FACTOR=100

# Stats: Total time the disk has been up.
UPTIME=0

# Total duration of last spun-down period.
LASTDOWNTIME=0

# Total duration of the last spun-up period.
LASTUPTIME=0

# Duration of the last poll. Always equal to POLLTIME except the first
# time around.
LASTPOLLTIME=0

# Make sure the stuff we use is in the cache. I've seen it happen
# that the script spun the disk down, and then "sleep" wasn't in
# the cache and the disk spun right up again. :)
true
false
sleep 1

$OUTLEVEL1 && echo Monitoring spindown opportunities for disk $DISK.
if ($OUTLEVEL1) ; then
	hdparm -C $DEVNAME |grep active >/dev/null
	if [ "$?" == "0" ] ; then
		echo Drive is currently spun up. ;
	else
		echo Drive is currently spun down. ;
	fi ;
fi
while [[ /sbin/true ]]; do
	hdparm -C $DEVNAME |grep active >/dev/null
	if [ "$?" == "0" ] ; then
		THISWAIT=$(($WAITTIME*$BACKOFF_FACTOR/100)) ;
		if [[ $THISWAIT -gt $MAXWAIT ]] ; then
			THISWAIT=$MAXWAIT ;
		fi ;
		# Increase the backoff irrespective of whether we failed
		# or not. The backoff should drop again by the lack of
		# spinups afterwards.
		BACKOFF_FACTOR=$(($BACKOFF_FACTOR*$BACKOFF_INCREASE_PCT/100)) ;
		if [[ $(($BACKOFF_FACTOR*$WAITTIME/100)) -gt $MAXWAIT ]] ; then
			BACKOFF_FACTOR=$(($MAXWAIT*100/$WAITTIME)) ;
		fi ;
		UPTIME=$(($UPTIME+$LASTPOLLTIME)) ;
		LASTUPTIME=$(($LASTUPTIME+$LASTPOLLTIME)) ;
		if [ "$LASTDOWNTIME" != "0" ] ; then
			$OUTLEVEL1 && echo Drive spun up after $LASTDOWNTIME seconds. ;
		fi
		PREVIOUS_READS=-1 ;
		NUM_EQUALS=0 ;
		$OUTLEVEL2 && echo Waiting for $THISWAIT seconds of read inactivity... ;
		PREVIOUS_READS=`cat $STATSFILE |awk '{ print $1; }'` ;
		while [[ $(($NUM_EQUALS*5)) -lt $THISWAIT ]]; do
			sleep 5 ;
			UPTIME=$(($UPTIME+5)) ;
			LASTUPTIME=$(($LASTUPTIME+5)) ;
			NEXT_READS=`cat $STATSFILE |awk '{ print $1; }'` ;
			if [[ $PREVIOUS_READS -ne $NEXT_READS ]] ; then
				NUM_EQUALS=0 ;
				PREVIOUS_READS=$NEXT_READS
				$OUTLEVEL2 && echo Restarting... ;
			else
				NUM_EQUALS=$(($NUM_EQUALS+1)) ;
				$OUTLEVEL2 && echo Seconds of quiet: $(($NUM_EQUALS*5)) ;
			fi
		done
		# We've just had $THISWAIT seconds of read inactivity. Writes can be
		# cached, reads always spin up the disk; the inactivity indicates
		# that we're ready to go to sleep. Laptop mode will have synced all
		# writes for us after the last read, so we don't have to explicitly
		# sync.
		if ( $NO_LAPTOP_MODE ) ; then
			sync ;
		fi ;
		hdparm -q -y $DEVNAME ;
		SPINDOWNS=$(($SPINDOWNS+1)) ;
		$OUTLEVEL1 && echo Drive spun down after $LASTUPTIME seconds \(with $THISWAIT seconds of inactivity\). ;
		LASTUPTIME=0 ;
		LASTDOWNTIME=0 ;
	else
		POLLSSPUNDOWN=$(($POLLSSPUNDOWN+1)) ;
		if [[ $SPINDOWNS -eq 0 ]] ; then
			SPINDOWNS=1 ;
		fi
		LASTDOWNTIME=$(($LASTDOWNTIME+$LASTPOLLTIME)) ;
		BACKOFF_FACTOR=$(($BACKOFF_FACTOR*$BACKOFF_DECREASE_PCT/100)) ;
		if [ $BACKOFF_FACTOR -lt 100 ] ; then
			BACKOFF_FACTOR=100 ;
		fi
	fi ;
	if ( $OUTLEVEL2 ) ; then
		echo -n spindowns: $SPINDOWNS, time up/down: $UPTIME/$(($POLLSSPUNDOWN*$POLLTIME)), backoff $BACKOFF_FACTOR, down for $LASTDOWNTIME \(avg $(($POLLSSPUNDOWN*$POLLTIME/$SPINDOWNS))\). ;
	fi ;
	sleep $POLLTIME ;
	LASTPOLLTIME=$POLLTIME ;
done


--------------050400010809010802080609--

