Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbTIQHyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 03:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTIQHyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 03:54:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38858 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262702AbTIQHyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 03:54:43 -0400
Date: Wed, 17 Sep 2003 09:54:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030917075432.GG906@suse.de>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at> <20030914152755.GA27105@suse.de> <20030915093221.GE2268@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20030915093221.GE2268@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15 2003, Norbert Preining wrote:
> On Son, 14 Sep 2003, Jens Axboe wrote:
> > > Will there be a new incantation of the laptop-mode patch for 2.4.23-pre4
> > 
> > Sure, I'll done a new patch in the next few days. I don't know what aa
> > patches you mean though? Are you trying to say that it conflicts with
> 
> The ones included into kernel 2.4.23-pre4 (stuff from -aa kernels).

Here's a fresh one against current BK, could you please give it a go?

> > I'll send it to Marcelo too for 2.4.23.
> 
> Good idea!

Done.

-- 
Jens Axboe


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="laptop-mode-2.4-bk"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1135  -> 1.1136 
#	include/linux/sysctl.h	1.32    -> 1.33   
#	     kernel/sysctl.c	1.27    -> 1.28   
#	drivers/block/ll_rw_blk.c	1.50    -> 1.51   
#	    fs/jbd/journal.c	1.12    -> 1.13   
#	  include/linux/fs.h	1.89    -> 1.90   
#	        mm/filemap.c	1.88    -> 1.89   
#	         fs/buffer.c	1.95    -> 1.96   
#	               (new)	        -> 1.1     Documentation/laptop-mode.txt
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/17	axboe@smithers.home.kernel.dk	1.1136
# laptop mode
# --------------------------------------------
#
diff -Nru a/Documentation/laptop-mode.txt b/Documentation/laptop-mode.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/laptop-mode.txt	Wed Sep 17 09:13:20 2003
@@ -0,0 +1,72 @@
+Laptop mode
+===========
+
+This small doc describes the 2.4 laptop mode patch.
+
+Last updated 2003-05-25, Jens Axboe <axboe@suse.de>
+
+Introduction
+------------
+
+A few properties of the Linux vm makes it virtually impossible to attempt
+to spin down the hard drive in a laptop for a longer period of time (more
+than a handful of seconds). This means you are lucky if you can even reach
+the break even point with regards to power consumption, let alone expect any
+decrease.
+
+One problem is the age time of dirty buffers. Linux uses 30 seconds per
+default, so if you dirty any data then flusing of that data will commence
+at most 30 seconds from then. Another is the journal commit interval of
+journalled file systems such as ext3, which is 5 seconds on a stock kernel.
+Both of these are tweakable either from proc/sysctl or as mount options
+though, and thus partly solvable from user space.
+
+The kernel update daemon (kupdated) also runs at specific intervals, flushing
+old dirty data out. Default is every 5 seconds, this too can be tweaked
+from sysctl.
+
+So what does the laptop mode patch do? It attempts to fully utilize the
+hard drive once it has been spun up, flushing the old dirty data out to
+disk. Instead of flushing just the expired data, it will clean everything.
+When a read causes the disk to spin up, we kick off this flushing after
+a few seconds. This means that once the disk spins down again, everything
+is up to date. That allows longer dirty data and journal expire times.
+
+It follows that you have to set long expire times to get long spin downs.
+This means you could potentially loose 10 minutes worth of data, if you
+set a 10 minute expire count instead of just 30 seconds worth. The biggest
+risk here is undoubtedly running out of battery.
+
+Settings
+--------
+
+The main knob is /proc/sys/vm/laptop_mode. Setting that to 1 switches the
+vm (and block layer) to laptop mode. Leaving it to 0 makes the kernel work
+like before. When in laptop mode, you also want to extend the intervals
+desribed above. See the laptop-mode.sh script for how to do that.
+
+It can happen that the disk still keeps spinning up and you don't quite
+know why or what causes it. The laptop mode patch has a little helper for
+that as well, /proc/sys/vm/block_dump. When set to 1, it will dump info to
+the kernel message buffer about what process caused the io. Be very careful
+when playing with this setting, it is advisable to shut down syslog first!
+
+Result
+------
+
+Using the laptop-mode.sh script with its default settings, I get the full
+10 minutes worth of drive spin down. Provided your work load is cached,
+the disk will only spin up every 10 minutes (well actually, 9 minutes and 55
+seconds due to the 5 second delay in flushing dirty data after the last read
+completes). I can't tell you exactly how much extra battery life you will
+gain in laptop mode, it will vary greatly on the laptop and workload in
+question. The only way to know for sure is to try it out. Getting 10% extra
+battery life is not unrealistic.
+
+Notes
+-----
+
+Patch only changes journal expire time for ext3. reiserfs uses a hardwire
+value, should be trivial to adapt though (basically just make it call
+get_buffer_flushtime() and uses that). I have not looked at other
+journalling file systems, I'll happily accept patches to rectify that!
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Wed Sep 17 09:13:20 2003
+++ b/drivers/block/ll_rw_blk.c	Wed Sep 17 09:13:20 2003
@@ -121,6 +121,10 @@
 unsigned long blk_max_low_pfn, blk_max_pfn;
 int blk_nohighio = 0;
 
+int block_dump = 0;
+
+static struct timer_list writeback_timer;
+
 static inline int get_max_sectors(kdev_t dev)
 {
 	if (!max_sectors[MAJOR(dev)])
@@ -1293,6 +1297,9 @@
 	if (waitqueue_active(&bh->b_wait))
 		wake_up(&bh->b_wait);
 
+	if (block_dump)
+		printk(KERN_DEBUG "%s: %s block %lu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", bh->b_rsector, count, kdevname(bh->b_rdev));
+
 	put_bh(bh);
 	switch (rw) {
 		case WRITE:
@@ -1413,6 +1420,11 @@
 extern int stram_device_init (void);
 #endif
 
+static void blk_writeback_timer(unsigned long data)
+{
+	wakeup_bdflush();
+	wakeup_kupdate();
+}
 
 /**
  * end_that_request_first - end I/O on one buffer.
@@ -1469,10 +1481,18 @@
 	return 0;
 }
 
+extern int laptop_mode;
+
 void end_that_request_last(struct request *req)
 {
 	struct completion *waiting = req->waiting;
 
+	/*
+	 * schedule the writeout of pending dirty data when the disk is idle
+	 */
+	if (laptop_mode && req->cmd == READ)
+		mod_timer(&writeback_timer, jiffies + 5 * HZ);
+
 	req_finished_io(req);
 	blkdev_release_request(req);
 	if (waiting)
@@ -1499,6 +1519,9 @@
 
 	blk_max_low_pfn = max_low_pfn - 1;
 	blk_max_pfn = max_pfn - 1;
+
+	init_timer(&writeback_timer);
+	writeback_timer.function = blk_writeback_timer;
 
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Wed Sep 17 09:13:20 2003
+++ b/fs/buffer.c	Wed Sep 17 09:13:20 2003
@@ -88,6 +88,13 @@
 static int osync_buffers_list(struct list_head *);
 static void __refile_buffer(struct buffer_head *);
 
+/*
+ * A global sysctl-controlled flag which puts the machine into "laptop mode"
+ */
+int laptop_mode;
+
+static DECLARE_WAIT_QUEUE_HEAD(kupdate_wait);
+
 /* This is used by some architectures to estimate available memory. */
 atomic_t buffermem_pages = ATOMIC_INIT(0);
 
@@ -1016,7 +1023,7 @@
 	dirty *= 100;
 	dirty_limit = tot * bdf_prm.b_un.nfract_stop_bdflush;
 
-	if (dirty > dirty_limit)
+	if (!laptop_mode && dirty > dirty_limit)
 		return 0;
 	return 1;
 }
@@ -1066,6 +1073,8 @@
 void mark_buffer_dirty(struct buffer_head *bh)
 {
 	if (!atomic_set_buffer_dirty(bh)) {
+		if (block_dump)
+			printk("%s: dirtied buffer\n", current->comm);
 		__mark_dirty(bh);
 		balance_dirty();
 	}
@@ -1077,6 +1086,12 @@
 }
 EXPORT_SYMBOL(set_buffer_flushtime);
 
+inline int get_buffer_flushtime(void)
+{
+	return bdf_prm.b_un.age_buffer;
+}
+EXPORT_SYMBOL(get_buffer_flushtime);
+
 /*
  * A buffer may need to be moved from one buffer list to another
  * (e.g. in case it is not shared any more). Handle this.
@@ -2860,6 +2875,12 @@
 	wake_up_interruptible(&bdflush_wait);
 }
 
+void wakeup_kupdate(void)
+{
+	if (waitqueue_active(&kupdate_wait))
+		wake_up(&kupdate_wait);
+}
+
 /* 
  * Here we attempt to write back old buffers.  We also try to flush inodes 
  * and supers as well, since this function is essentially "update", and 
@@ -2880,7 +2901,9 @@
 
 		spin_lock(&lru_list_lock);
 		bh = lru_list[BUF_DIRTY];
-		if (!bh || time_before(jiffies, bh->b_flushtime))
+		if (!bh)
+			break;
+		if (time_before(jiffies, bh->b_flushtime) && !laptop_mode)
 			break;
 		if (write_some_buffers(NODEV))
 			continue;
@@ -3028,16 +3051,20 @@
 	complete((struct completion *)startup);
 
 	for (;;) {
+		DECLARE_WAITQUEUE(wait, tsk);
+
+		add_wait_queue(&kupdate_wait, &wait);
+
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
 		if (interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(interval);
 		} else {
-		stop_kupdate:
 			tsk->state = TASK_STOPPED;
 			schedule(); /* wait for SIGCONT */
 		}
+		remove_wait_queue(&kupdate_wait, &wait);
 		/* check for sigstop */
 		if (signal_pending(tsk)) {
 			int stopped = 0;
@@ -3048,13 +3075,17 @@
 			}
 			recalc_sigpending(tsk);
 			spin_unlock_irq(&tsk->sigmask_lock);
-			if (stopped)
-				goto stop_kupdate;
+			if (stopped) {
+				tsk->state = TASK_STOPPED;
+				schedule(); /* wait for SIGCONT */
+			}
 		}
 #ifdef DEBUG
 		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
 		sync_old_buffers();
+		if (laptop_mode)
+			fsync_dev(NODEV);
 		run_task_queue(&tq_disk);
 	}
 }
diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Wed Sep 17 09:13:20 2003
+++ b/fs/jbd/journal.c	Wed Sep 17 09:13:20 2003
@@ -705,7 +705,7 @@
 	init_MUTEX(&journal->j_checkpoint_sem);
 	init_MUTEX(&journal->j_sem);
 
-	journal->j_commit_interval = (HZ * 5);
+	journal->j_commit_interval = get_buffer_flushtime();
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JFS_ABORT;
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Sep 17 09:13:20 2003
+++ b/include/linux/fs.h	Wed Sep 17 09:13:20 2003
@@ -1255,6 +1255,7 @@
 }
 
 extern void set_buffer_flushtime(struct buffer_head *);
+extern inline int get_buffer_flushtime(void);
 extern void balance_dirty(void);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
@@ -1445,8 +1446,10 @@
 	return get_hash_table(sb->s_dev, block, sb->s_blocksize);
 }
 extern void wakeup_bdflush(void);
+extern void wakeup_kupdate(void);
 extern void put_unused_buffer_head(struct buffer_head * bh);
 extern struct buffer_head * get_unused_buffer_head(int async);
+extern int block_dump;
 
 extern int brw_page(int, struct page *, kdev_t, int [], int);
 
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Wed Sep 17 09:13:20 2003
+++ b/include/linux/sysctl.h	Wed Sep 17 09:13:20 2003
@@ -154,6 +154,8 @@
 	VM_GFP_DEBUG=18,        /* debug GFP failures */
 	VM_CACHE_SCAN_RATIO=19, /* part of the inactive cache list to scan */
 	VM_MAPPED_RATIO=20,     /* amount of unfreeable pages that triggers swapout */
+	VM_LAPTOP_MODE=21,	/* kernel in laptop flush mode */
+	VM_BLOCK_DUMP=22,	/* dump fs activity to log */
 };
 
 
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed Sep 17 09:13:20 2003
+++ b/kernel/sysctl.c	Wed Sep 17 09:13:20 2003
@@ -53,6 +53,8 @@
 extern int core_setuid_ok;
 extern char core_pattern[];
 extern int cad_pid;
+extern int laptop_mode;
+extern int block_dump;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -306,6 +308,10 @@
 	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAX_MAP_COUNT, "max_map_count",
 	 &max_map_count, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_LAPTOP_MODE, "laptop_mode",
+	 &laptop_mode, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_BLOCK_DUMP, "block_dump",
+	 &block_dump, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Wed Sep 17 09:13:20 2003
+++ b/mm/filemap.c	Wed Sep 17 09:13:20 2003
@@ -165,6 +165,8 @@
 
 			if (mapping && mapping->host)
 				mark_inode_dirty_pages(mapping->host);
+			if (block_dump)
+				printk(KERN_DEBUG "%s: dirtied page\n", current->comm);
 		}
 	}
 }

--ZmUaFz6apKcXQszQ--
