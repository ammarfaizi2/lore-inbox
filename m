Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTLXP0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTLXP0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:26:03 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:51068 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S263692AbTLXPZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:25:53 -0500
Message-ID: <3FE9AFFC.2080302@samwel.tk>
Date: Wed, 24 Dec 2003 16:25:48 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] laptop-mode for 2.6, version 3
References: <3FE92517.1000306@samwel.tk> <20031224111640.GL1601@suse.de>
In-Reply-To: <20031224111640.GL1601@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070107070603030903070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107070603030903070601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
 > It looks better, getting there!

Thx!

[block_dump code in set_buffer_dirty()]
 > Probably want to move this to the actual set_page_dirty() function(s).

Done. Works better, seeing a bit more output as well.

[block_dump code in submit_bh()]
 > You don't want this in submit_bh(), that hardly matters at all anymore.
 > It wants to be in submit_bio(). And you should follow the brace
 > placement style. And just dump device+offset, b_count is not
 > interesting.

Done. This gives some extra output as well, which is good.

 > The rest looks ok, apart from style.

I've changed it to use the correct bracing style. Is it OK now?

Thanks for the feedback. Do you see any more problems with the current 
patch, or is it OK like this?

Bart

--------------070107070603030903070601
Content-Type: text/plain;
 name="laptop-mode-2.6.0-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="laptop-mode-2.6.0-3.patch"

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
+++ linux-2.6.0-withlaptopmode/mm/page-writeback.c	2003-12-24 15:49:55.000000000 +0100
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
+int block_dump = 0;
+
+/*
+ * Flag that puts the machine in "laptop mode".
+ */
+int laptop_mode = 0;
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

--------------070107070603030903070601--

