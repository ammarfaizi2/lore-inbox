Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTLWPZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTLWPZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:25:16 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:43896 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S261492AbTLWPYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:24:16 -0500
Message-ID: <3FE85E11.5020602@samwel.tk>
Date: Tue, 23 Dec 2003 16:24:01 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: Attempt at laptop-mode for 2.6.0
Content-Type: multipart/mixed;
 boundary="------------030204070107060400090700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204070107060400090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys,

Even though I don't own a laptop, I find it very irritating that my hard
drive is active so much. Wanting to fix this, I found the Jens Axboe's
"laptop-mode" patch. Unfortunately it hadn't been ported to Linux
2.6.0 yet, and I'm using that as my primary kernel now. I gave porting 
it a shot, and here is the result. I'm running it right now, and my hard 
drive has been spun down for the complete time I have been writing this 
message. Still, I'm not sure whether it really works as advertised. :) 
The reason is that my PC is also a mail server for my personal e-mail, 
and I receive e-mails more than once every 10 minutes (fscking spam!). 
Still, the tests that I've done seem to indicate that it works.

I've done some things differently than in Jens's patch (my port is based
on v4 of the patch BTW):

* The block dirtying reporting is not there. As an alternative,
you can write a number N higher than 1 into /proc/sys/vm/laptop_mode,
which will give you reports on N-1 actual read/write operations,
including the pid+command that caused them. This gives you a way
to put a reasonable bound on the number of messages you're going to get.
You're only interested in the first one (the one that spins up your
disk) anyway. The messages look like this:

ll_rw_block: (107 reports left) READ requested by imapd (pid 1137)

* When laptop mode is on, wb_kupdate() also performs all of the other
actions mentioned in do_sync(). I don't know whether this is really
necessary because I don't know the full implications of all those
actions, but at least it REALLY makes sure that everything is synced.

* The script writes to different values in /proc/sys/vm, because the 
Linux 2.6 VM has different controls.

* The patch does not modify the ext3 journal commit timeout; you have to 
mount your filesystem with commit=600 (or whatever your preferred value 
is) to get the correct effect. The 2.4 patch modified the expiration of 
an ext3 transaction, I've removed this as I don't see the use if you're 
going to have to mount the fs with "commit=" anyway. The default 
expiration time of an ext3 transaction is equal to the commit interval, 
which is very reasonable. Usually you'd set your commit interval to the 
same as the dirty_writeback_centisecs value (in seconds, then), so it 
would boil down to the same thing.

Disclaimer: I'm not a very experienced kernel developer, and I may have 
made mistakes. Don't kill me if it doesn't work. :) I'd appreciate some 
feedback, so if it works or doesn't work for you, please let me know!


Bart Samwel

--------------030204070107060400090700
Content-Type: text/plain;
 name="laptop-mode-2.6.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="laptop-mode-2.6.0.patch"

diff -baur --speed-large-files linux-2.6.0/drivers/block/ll_rw_blk.c linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c
--- linux-2.6.0/drivers/block/ll_rw_blk.c	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c	2003-12-23 15:21:29.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/writeback.h>
 
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
@@ -2582,6 +2583,16 @@
 
 EXPORT_SYMBOL(end_that_request_chunk);
 
+static struct timer_list writeback_timer;
+
+static void blk_writeback_timer(unsigned long data)
+{
+	wakeup_bdflush(0);
+	wakeup_kupdate();
+}
+
+extern int laptop_mode;
+
 /*
  * queue lock must be held
  */
@@ -2598,6 +2609,11 @@
 			disk_stat_add(disk, write_ticks, duration);
 			break;
 		    case READ:
+			/*
+			 * schedule the writeout of pending dirty data when the disk is idle
+			 */
+			if (laptop_mode)
+				mod_timer(&writeback_timer, jiffies + 5 * HZ);
 			disk_stat_inc(disk, reads);
 			disk_stat_add(disk, read_ticks, duration);
 			break;
@@ -2689,6 +2705,10 @@
 
 	for (i = 0; i < ARRAY_SIZE(congestion_wqh); i++)
 		init_waitqueue_head(&congestion_wqh[i]);
+	
+	init_timer(&writeback_timer);
+	writeback_timer.function = blk_writeback_timer;
+	
 	return 0;
 }
 
diff -baur --speed-large-files linux-2.6.0/fs/buffer.c linux-2.6.0-withlaptopmode/fs/buffer.c
--- linux-2.6.0/fs/buffer.c	2003-12-18 03:58:57.000000000 +0100
+++ linux-2.6.0-withlaptopmode/fs/buffer.c	2003-12-23 15:14:08.000000000 +0100
@@ -44,6 +44,11 @@
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
 /*
+ * A global sysctl-controlled flag which puts the machine into "laptop mode"
+ */
+int laptop_mode;
+
+/*
  * Hashed waitqueue_head's for wait_on_buffer()
  */
 #define BH_WAIT_TABLE_ORDER	7
@@ -2720,6 +2725,16 @@
 {
 	int i;
 
+	if (laptop_mode > 1)
+	{
+		/* Set laptop_mode to any value higher than one
+		 * to report on just about that many reads/writes.
+		 * Watch out: this is not really threadsafe.
+		 */
+		printk("ll_rw_block: (%d reports left) %s requested by %s (pid %d)\n",
+		       laptop_mode - 1, rw == READ ? "READ" : "WRITE", current->comm, current->pid);
+		--laptop_mode;
+	}
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
 
diff -baur --speed-large-files linux-2.6.0/fs/jbd/transaction.c linux-2.6.0-withlaptopmode/fs/jbd/transaction.c
--- linux-2.6.0/fs/jbd/transaction.c	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.0-withlaptopmode/fs/jbd/transaction.c	2003-12-23 15:45:19.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/smp_lock.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/writeback.h>
 
 /*
  * get_transaction: obtain a new transaction_t object.
diff -baur --speed-large-files linux-2.6.0/include/linux/sysctl.h linux-2.6.0-withlaptopmode/include/linux/sysctl.h
--- linux-2.6.0/include/linux/sysctl.h	2003-12-18 03:58:56.000000000 +0100
+++ linux-2.6.0-withlaptopmode/include/linux/sysctl.h	2003-12-21 17:05:40.000000000 +0100
@@ -154,6 +154,7 @@
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_LAPTOP_MODE=22,      /* vm laptop mode */
 };
 
 
diff -baur --speed-large-files linux-2.6.0/include/linux/writeback.h linux-2.6.0-withlaptopmode/include/linux/writeback.h
--- linux-2.6.0/include/linux/writeback.h	2003-12-18 03:58:15.000000000 +0100
+++ linux-2.6.0-withlaptopmode/include/linux/writeback.h	2003-12-21 17:17:14.000000000 +0100
@@ -71,6 +71,7 @@
  * mm/page-writeback.c
  */
 int wakeup_bdflush(long nr_pages);
+int wakeup_kupdate(void);
 
 /* These 5 are exported to sysctl. */
 extern int dirty_background_ratio;
diff -baur --speed-large-files linux-2.6.0/kernel/sysctl.c linux-2.6.0-withlaptopmode/kernel/sysctl.c
--- linux-2.6.0/kernel/sysctl.c	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.0-withlaptopmode/kernel/sysctl.c	2003-12-21 17:07:42.000000000 +0100
@@ -60,6 +60,7 @@
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
+extern int laptop_mode;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -700,6 +701,16 @@
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
 	{ .ctl_name = 0 }
 };
 
diff -baur --speed-large-files linux-2.6.0/mm/page-writeback.c linux-2.6.0-withlaptopmode/mm/page-writeback.c
--- linux-2.6.0/mm/page-writeback.c	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.0-withlaptopmode/mm/page-writeback.c	2003-12-23 13:35:30.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/smp.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/quotaops.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -139,6 +140,8 @@
 	*pdirty = dirty;
 }
 
+extern int laptop_mode;
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -167,7 +170,7 @@
 
 		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
 		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
-		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
+		if (laptop_mode || nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 			break;
 
 		dirty_exceeded = 1;
@@ -192,10 +195,11 @@
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
 
@@ -290,6 +294,8 @@
 
 static struct timer_list wb_timer;
 
+extern int laptop_mode;
+
 /*
  * Periodic writeback of "old" data.
  *
@@ -327,6 +333,8 @@
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+	if (laptop_mode)
+		wbc.older_than_this = NULL;
 	nr_to_write = ps.nr_dirty + ps.nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
 	while (nr_to_write > 0) {
@@ -343,6 +351,12 @@
 	}
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
+	if (laptop_mode)
+	{
+		sync_inodes(0);
+		sync_filesystems(0);
+		DQUOT_SYNC(NULL);
+	}
 	if (dirty_writeback_centisecs)
 		mod_timer(&wb_timer, next_jif);
 }
@@ -363,6 +377,15 @@
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


--------------030204070107060400090700
Content-Type: text/plain;
 name="laptop_mode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="laptop_mode"

#!/bin/sh
#
# start of stop laptop mode, best run by a power management daemon when
# ac gets connected/disconnected from a laptop
#
# FIXME: assumes HZ == 100

# age time, in seconds. should be put into a sysconfig file
MAX_AGE=600

# kernel default dirty buffer age
DEF_AGE=30
DEF_UPDATE=5

if [ ! -e /proc/sys/vm/laptop_mode ]; then
	echo "Kernel is not patched with laptop_mode patch."
	exit 1
fi

if [ ! -w /proc/sys/vm/laptop_mode ]; then
	echo "You do not have enough privileges to enable laptop mode."
	exit 1
fi

case "$1" in
	start)
		AGE=$((100*$MAX_AGE))
		echo -n "Starting laptop mode"
		echo "2" > /proc/sys/vm/laptop_mode
		echo "$AGE" > /proc/sys/vm/dirty_expire_centisecs
		echo "$AGE" > /proc/sys/vm/dirty_writeback_centisecs
		echo "."
		;;
	stop)
		U_AGE=$((100*$DEF_UPDATE))
		B_AGE=$((100*$DEF_AGE))
		echo -n "Stopping laptop mode"
		echo "0" > /proc/sys/vm/laptop_mode
		echo "$B_AGE" > /proc/sys/vm/dirty_writeback_centisecs
		echo "$U_AGE" > /proc/sys/vm/dirty_expire_centisecs
		echo "."
		;;
	*)
		echo "$0 {start|stop}"
		;;

esac

exit 0


--------------030204070107060400090700--

