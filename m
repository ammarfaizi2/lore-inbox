Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUABNDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUABNDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:03:53 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:31416 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265531AbUABNC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:02:57 -0500
Message-ID: <3FF56BC6.50201@samwel.tk>
Date: Fri, 02 Jan 2004 14:01:58 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Mackinlay <smackinlay@mail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH] laptop-mode-2.6.0, version 5
References: <20040102025509.91753.qmail@mail.com>
In-Reply-To: <20040102025509.91753.qmail@mail.com>
Content-Type: multipart/mixed;
 boundary="------------060204010605080007050401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204010605080007050401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Simon Mackinlay wrote:
>>I think what you want to do is to increase dirty_background_ratio and
>>dirty_ratio, so the system buffers _more_ dirty data before lighting up the
>>disk.  But it shouldn't be disabled altogether.
> 
> The greater component of functional gain from laptop-mode derives
> from the notion that we want to schedule writeout events with some
> controlled period (default in documentation is 10min interval, at
> next journal commit event, or at next read event, whichever arrives
> first).
> 
> Is it possible instead to put a ceiling on the amount of data we're
> willing to accept for writeout and somehow apply back-pressure
> to the task (or even, more coarsely, to the system as a whole),
> rather than arbitrarily stretching these ratios to ${MAGIC NUMBER}
> when laptop mode is active - given that the overall goal is to
> control what triggers may result in disk activity.
> 
> In other words - what happens at present if we're unable to
> accept more data into the system buffers because we're already
> out of memory (and quite possibly now awaiting completion of
> a writeout), and are we not able to just allow this condition
> (of being apparently out of memory - and presumably stalling
> writers) to persist until either of...
> 
>    * the timers controlled via laptop-mode permit a writeout event
>    * a journal commit event
>    * a read event
> 
> ... occurs?
> 
> Apologies in advance for the naivete - but this functionality
> seems too useful to ignore, particularly considering that MTBF
> figures and warranties for notebook drives tend to put a ceiling
> against the number of operational hours for which the unit will be
> supported - also considering that the periodicity of both writeout
> and journal commit are tunable (with safe defaults), and that the
> mode itself is not default (ie, notebook users, here's a gun,
> don't shoot your feet would seem to apply?).

I think Andrew has a point. The dirty writebacks (controlled by 
dirty_ratio and dirty_background_ratio) should simply be set to
possibly higher and, more importantly, *equal* values. This will 
effectively disable background writeouts (which are good for speed, but 
bad for battery power because it will spin up your disk sooner than 
necessary), but it will not make the system keep accumulating dirty 
pages ad infinitum like the current laptop_mode patch does. IMO, if a 
writer writes enough to have filled up 40% of all available memory with 
dirty pages, the disk deserves to spin up.

Find attached version 5 of the laptop-mode patch. It includes the 
following changes:

* Fix for supporting 64-bit sector_t (thanks hugang!)

* Simplified the design a bit, saved us a timer. It now only wakes up 
kupdate to write back stuff: kupdate disregards age while laptop_mode is 
active, so it writes back everything anyway.

* balance_dirty_pages does it's job again in laptop mode. However, when 
it decides to write back pages, it now also calls disk_is_spun_up(), 
which makes sure that the remainder of the dirty pages are written 
immediately as well. That means that if a writer writes an amount of 
data that is about 50% of memory, and dirty_ratio is 40%, that the disk 
will spin up after 4/5ths of the data is written, will write the full 
4/5ths of the data at once, and then the disk can spin down again 
because the remaining 10% will be not be written until the next spin-up.

* The control script now sets dirty_background_ratio to the same value 
as dirty_ratio, so that background writes are effectively disabled. This 
enables a writer to fill up up to dirty_ratio (default 40%) of the 
memory with dirty blocks before the disk is spun up.

* Includes control script (scripts/laptop_mode).

* Includes docs (Documentation/laptop-mode.txt).



-- Bart

--------------060204010605080007050401
Content-Type: text/x-patch;
 name="laptop-mode-2.6.0-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="laptop-mode-2.6.0-5.patch"

diff -Nbaur linux-2.6.0/Documentation/laptop-mode.txt linux-2.6.0-withlaptopmode/Documentation/laptop-mode.txt
--- linux-2.6.0/Documentation/laptop-mode.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-withlaptopmode/Documentation/laptop-mode.txt	2004-01-02 13:31:46.000000000 +0100
@@ -0,0 +1,69 @@
+How to conserve battery power using laptop-mode
+-----------------------------------------------
+
+Document Author: Bart Samwel (bart@samwel.tk)
+Date created: January 2, 2004
+
+Introduction
+------------
+
+Laptopmode is used to minimize the time that the hard disk needs to be spun up,
+to conserve battery power on laptops. It has been reported to cause significant
+power savings.
+
+The short story
+---------------
+
+If you just want to use it, run the laptop_mode control script as follows:
+
+# laptop_mode start
+
+and then remount all filesystems on your harddisk with a higher commit value,
+e.g.:
+
+mount /dev/hda2 / -t ext3 -o remount,defaults,noatime,commit=600
+
+Then set your harddisk spindown time to a relatively low value with hdparm:
+
+hdparm -S 4 /dev/hda
+
+The value -S 4 means 20 seconds idle time before spindown. Your harddisk will
+now only spin up when a disk cache miss occurs, or at least once every 10
+minutes to write back any pending changes.
+
+To stop laptop_mode, remount your filesystems with regular commit intervals
+(e.g., 5 seconds), and run "laptop_mode stop".
+
+CAVEAT: The downside of laptop mode is that you have a chance of losing up
+to 10 minutes of work. If you cannot afford this, don't use it!
+
+The details
+-----------
+
+Laptop-mode is controlled by the flag /proc/sys/vm/laptop_mode. When this
+flag is set, any physical disk read operation (that might have caused the
+hard disk to spin up) causes Linux to flush all dirty blocks. The result
+of this is that after a disk has spun down, it will not be spun up anymore
+to write dirty blocks, because those blocks had already been written
+immediately after the most recent read operation
+
+To increase the effectiveness of the laptop_mode strategy, the laptop_mode
+control script increases dirty_expire_centisecs and dirty_writeback_centisecs in
+/proc/sys/vm to about 10 minutes (by default), which means that pages that are
+dirtied are not forced to be written to disk as often. The control script also changes the dirty background ratio, so that background writeback of dirty pages
+is not done anymore. Combined with a higher commit value (also 10 minutes) for
+ext3 or ReiserFS filesystems, this results in concentration of disk activity in
+a small time interval which occurs only once every 10 minutes, or whenever the
+disk is forced to spin up by a cache miss. The disk can then be spun down in the periods of inactivity.
+
+If you want to find out which process caused the disk to spin up, you can
+gather information by setting the flag /proc/sys/vm/block_dump. When this flag
+is set, Linux reports all disk read and write operations that take place, and
+all block dirtyings done to files. This makes it possible to debug why a disk
+needs to spin up, and to increase battery life even more.
+
+If 10 minutes is too much or too little downtime for you, you can configure
+this downtime as follows. In the control script, set the MAX_AGE value to the
+maximum number of seconds of disk downtime that you would like. You should
+then set your filesystem's commit interval to the same value. The dirty ratio
+is also configurable from the control script.
\ No newline at end of file
diff -Nbaur linux-2.6.0/drivers/block/ll_rw_blk.c linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c
--- linux-2.6.0/drivers/block/ll_rw_blk.c	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c	2004-01-02 13:47:06.000000000 +0100
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
+		printk("%s(%d): %s block %Lu on %s\n",
+			current->comm, current->pid,
+			(rw & WRITE) ? "WRITE" : "READ",
+			(u64)bio->bi_sector, bdevname(bio->bi_bdev,b));
+	}
+
 	generic_make_request(bio);
 	return 1;
 }
@@ -2598,6 +2608,11 @@
 			disk_stat_add(disk, write_ticks, duration);
 			break;
 		    case READ:
+			/*
+			 * schedule the writeout of pending dirty data when the disk is idle
+			 */
+			if (unlikely(laptop_mode))
+				disk_is_spun_up();
 			disk_stat_inc(disk, reads);
 			disk_stat_add(disk, read_ticks, duration);
 			break;
diff -Nbaur linux-2.6.0/fs/buffer.c linux-2.6.0-withlaptopmode/fs/buffer.c
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
diff -Nbaur linux-2.6.0/include/linux/sysctl.h linux-2.6.0-withlaptopmode/include/linux/sysctl.h
--- linux-2.6.0/include/linux/sysctl.h	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/include/linux/sysctl.h	2003-12-24 03:17:36.000000000 +0100
@@ -154,6 +154,8 @@
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_LAPTOP_MODE=22,      /* vm laptop mode */
+	VM_BLOCK_DUMP=23,       /* block dump mode */
 };
 
 
diff -Nbaur linux-2.6.0/include/linux/writeback.h linux-2.6.0-withlaptopmode/include/linux/writeback.h
--- linux-2.6.0/include/linux/writeback.h	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/include/linux/writeback.h	2004-01-02 13:07:50.000000000 +0100
@@ -71,12 +71,15 @@
  * mm/page-writeback.c
  */
 int wakeup_bdflush(long nr_pages);
+void disk_is_spun_up(void);
 
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
diff -Nbaur linux-2.6.0/kernel/sysctl.c linux-2.6.0-withlaptopmode/kernel/sysctl.c
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
 
diff -Nbaur linux-2.6.0/mm/page-writeback.c linux-2.6.0-withlaptopmode/mm/page-writeback.c
--- linux-2.6.0/mm/page-writeback.c	2003-12-24 05:19:46.000000000 +0100
+++ linux-2.6.0-withlaptopmode/mm/page-writeback.c	2004-01-02 13:51:40.000000000 +0100
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
 
 
@@ -180,6 +191,8 @@
 		 */
 		if (nr_reclaimable) {
 			writeback_inodes(&wbc);
+			if (unlikely(laptop_mode))
+				disk_is_spun_up(); /* Schedule full writeout. */
 			get_dirty_limits(&ps, &background_thresh,
 					&dirty_thresh);
 			nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
@@ -327,6 +340,8 @@
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+	if (laptop_mode)
+		wbc.older_than_this = NULL;
 	nr_to_write = ps.nr_dirty + ps.nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
 	while (nr_to_write > 0) {
@@ -343,6 +358,11 @@
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
@@ -363,6 +383,15 @@
 	return 0;
 }
 
+/*
+ * We've spun up the disk and we're in laptop mode: schedule writeback
+ * of all dirty data in 5 seconds.
+ */
+void disk_is_spun_up(void)
+{
+	mod_timer(&wb_timer, jiffies + 5 * HZ);
+}
+
 static void wb_timer_fn(unsigned long unused)
 {
 	if (pdflush_operation(wb_kupdate, 0) < 0)
@@ -525,6 +554,8 @@
 				__mark_inode_dirty(mapping->host,
 							I_DIRTY_PAGES);
 		}
+		if (unlikely(block_dump))
+			printk("%s(%d): dirtied page\n", current->comm, current->pid);
 	}
 	return ret;
 }
diff -Nbaur linux-2.6.0/scripts/laptop_mode linux-2.6.0-withlaptopmode/scripts/laptop_mode
--- linux-2.6.0/scripts/laptop_mode	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-withlaptopmode/scripts/laptop_mode	2004-01-02 13:10:55.000000000 +0100
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# start of stop laptop mode, best run by a power management daemon when
+# ac gets connected/disconnected from a laptop
+
+# age time, in seconds. should be put into a sysconfig file
+MAX_AGE=600
+
+# Allowed dirty ratio, in pct. should be put into a sysconfig file as well.
+DIRTY_RATIO=40
+
+# kernel default dirty buffer age
+DEF_AGE=30
+DEF_UPDATE=5
+DEF_DIRTY_BACKGROUND_RATIO=10
+DEF_DIRTY_RATIO=40
+
+
+if [ ! -e /proc/sys/vm/laptop_mode ]; then
+	echo "Kernel is not patched with laptop_mode patch."
+	exit 1
+fi
+
+if [ ! -w /proc/sys/vm/laptop_mode ]; then
+	echo "You do not have enough privileges to enable laptop mode."
+	exit 1
+fi
+
+case "$1" in
+	start)
+		AGE=$((100*$MAX_AGE))
+		echo -n "Starting laptop mode"
+		echo "1" > /proc/sys/vm/laptop_mode
+		echo "$AGE" > /proc/sys/vm/dirty_expire_centisecs
+		echo "$AGE" > /proc/sys/vm/dirty_writeback_centisecs
+		echo "$DIRTY_RATIO" > /proc/sys/vm/dirty_ratio
+		echo "$DIRTY_RATIO" > /proc/sys/vm/dirty_background_ratio
+		echo "."
+		;;
+	stop)
+		U_AGE=$((100*$DEF_UPDATE))
+		B_AGE=$((100*$DEF_AGE))
+		echo -n "Stopping laptop mode"
+		echo "0" > /proc/sys/vm/laptop_mode
+		echo "$B_AGE" > /proc/sys/vm/dirty_writeback_centisecs
+		echo "$U_AGE" > /proc/sys/vm/dirty_expire_centisecs
+		echo "$DEF_DIRTY_RATIO" > /proc/sys/vm/dirty_ratio
+		echo "$DEF_DIRTY_BACKGROUND_RATIO" > /proc/sys/vm/dirty_background_ratio
+		echo "."
+		;;
+	*)
+		echo "$0 {start|stop}"
+		;;
+
+esac
+
+exit 0

--------------060204010605080007050401--
