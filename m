Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTEPLUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 07:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTEPLUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 07:20:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35773 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264414AbTEPLUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 07:20:15 -0400
Date: Fri, 16 May 2003 13:33:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] laptop mode, #2
Message-ID: <20030516113309.GY812@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Made a few tweaks and adjustments:

- If block_dump is set, also dump who is marking a page/buffer as dirty.
  akpm recommended this.

- Don't touch default bdflush parameters (see script)

That's about it. I've gotten several mails who really like the patch and
that it really adds a non-significant amount of extra battery time. I
consider the patch final at this point.

Patch is against 2.4.21-rc2 (ish)

-- 
Jens Axboe


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=laptop-mode

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

if [ ! -w /proc/sys/vm/laptop_mode ]; then
	echo "Kernel is not patched with laptop_mode patch"
	exit 1
fi

case "$1" in
	start)
		AGE=$((100*$MAX_AGE))
		echo -n "Starting laptop mode"
		echo "1" > /proc/sys/vm/laptop_mode
		echo "30 500 0 0 $AGE $AGE 60 20 0" > /proc/sys/vm/bdflush
		echo "."
		;;
	stop)
		U_AGE=$((100*$DEF_UPDATE))
		B_AGE=$((100*$DEF_AGE))
		echo -n "Stopping laptop mode"
		echo "0" > /proc/sys/vm/laptop_mode
		echo "30 500 0 0 $U_AGE $B_AGE 60 20 0" > /proc/sys/vm/bdflush
		echo "."
		;;
	*)
		echo "$0 {start|stop}"
		;;

esac

exit 0

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=laptop-mode-4

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1209  -> 1.1210 
#	include/linux/sysctl.h	1.23    -> 1.24   
#	drivers/block/ll_rw_blk.c	1.44    -> 1.45   
#	     kernel/sysctl.c	1.19    -> 1.20   
#	  include/linux/fs.h	1.74    -> 1.75   
#	fs/jbd/transaction.c	1.13    -> 1.14   
#	        mm/filemap.c	1.76    -> 1.77   
#	         fs/buffer.c	1.82    -> 1.83   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/16	axboe@smithers.home.kernel.dk	1.1210
# laptop mode #2
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri May 16 13:32:56 2003
+++ b/drivers/block/ll_rw_blk.c	Fri May 16 13:32:56 2003
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
@@ -1207,6 +1211,9 @@
 			kstat.pgpgin += count;
 			break;
 	}
+
+	if (block_dump)
+		printk("%s: %s block %lu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", bh->b_rsector, count, kdevname(bh->b_rdev));
 }
 
 /**
@@ -1318,6 +1325,11 @@
 extern int stram_device_init (void);
 #endif
 
+static void blk_writeback_timer(unsigned long data)
+{
+	wakeup_bdflush();
+	wakeup_kupdate();
+}
 
 /**
  * end_that_request_first - end I/O on one buffer.
@@ -1373,10 +1385,18 @@
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
@@ -1403,6 +1423,9 @@
 
 	blk_max_low_pfn = max_low_pfn - 1;
 	blk_max_pfn = max_pfn - 1;
+
+	init_timer(&writeback_timer);
+	writeback_timer.function = blk_writeback_timer;
 
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri May 16 13:32:56 2003
+++ b/fs/buffer.c	Fri May 16 13:32:56 2003
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
 
@@ -995,7 +1002,7 @@
 	dirty *= 100;
 	dirty_limit = tot * bdf_prm.b_un.nfract_stop_bdflush;
 
-	if (dirty > dirty_limit)
+	if (!laptop_mode && dirty > dirty_limit)
 		return 0;
 	return 1;
 }
@@ -1044,6 +1051,8 @@
 void mark_buffer_dirty(struct buffer_head *bh)
 {
 	if (!atomic_set_buffer_dirty(bh)) {
+		if (block_dump)
+			printk("%s: dirtied buffer\n", current->comm);
 		__mark_dirty(bh);
 		balance_dirty();
 	}
@@ -1055,6 +1064,13 @@
 }
 EXPORT_SYMBOL(set_buffer_flushtime);
 
+unsigned long get_buffer_flushtime(void)
+{
+	return bdf_prm.b_un.age_buffer;
+}
+EXPORT_SYMBOL(get_buffer_flushtime);
+
+
 /*
  * A buffer may need to be moved from one buffer list to another
  * (e.g. in case it is not shared any more). Handle this.
@@ -2815,6 +2831,12 @@
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
@@ -2835,7 +2857,9 @@
 
 		spin_lock(&lru_list_lock);
 		bh = lru_list[BUF_DIRTY];
-		if (!bh || time_before(jiffies, bh->b_flushtime))
+		if (!bh)
+			break;
+		if (time_before(jiffies, bh->b_flushtime) && !laptop_mode)
 			break;
 		if (write_some_buffers(NODEV))
 			continue;
@@ -2983,6 +3007,10 @@
 	complete((struct completion *)startup);
 
 	for (;;) {
+		DECLARE_WAITQUEUE(wait, tsk);
+
+		add_wait_queue(&kupdate_wait, &wait);
+
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
 		if (interval) {
@@ -2993,6 +3021,7 @@
 			tsk->state = TASK_STOPPED;
 			schedule(); /* wait for SIGCONT */
 		}
+		remove_wait_queue(&kupdate_wait, &wait);
 		/* check for sigstop */
 		if (signal_pending(tsk)) {
 			int stopped = 0;
@@ -3010,6 +3039,8 @@
 		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
 		sync_old_buffers();
+		if (laptop_mode)
+			fsync_dev(NODEV);
 		run_task_queue(&tq_disk);
 	}
 }
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	Fri May 16 13:32:56 2003
+++ b/fs/jbd/transaction.c	Fri May 16 13:32:56 2003
@@ -56,7 +56,11 @@
 	transaction->t_journal = journal;
 	transaction->t_state = T_RUNNING;
 	transaction->t_tid = journal->j_transaction_sequence++;
-	transaction->t_expires = jiffies + journal->j_commit_interval;
+	/*
+	 * have to do it here, otherwise changed age_buffers since boot
+	 * wont have any effect
+	 */
+	transaction->t_expires = jiffies + get_buffer_flushtime();
 	INIT_LIST_HEAD(&transaction->t_jcb);
 
 	/* Set up the commit timer for the new transaction. */
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri May 16 13:32:56 2003
+++ b/include/linux/fs.h	Fri May 16 13:32:56 2003
@@ -1238,6 +1238,7 @@
 }
 
 extern void set_buffer_flushtime(struct buffer_head *);
+extern unsigned long get_buffer_flushtime(void);
 extern void balance_dirty(void);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
@@ -1427,8 +1428,10 @@
 	return get_hash_table(sb->s_dev, block, sb->s_blocksize);
 }
 extern void wakeup_bdflush(void);
+extern void wakeup_kupdate(void);
 extern void put_unused_buffer_head(struct buffer_head * bh);
 extern struct buffer_head * get_unused_buffer_head(int async);
+extern int block_dump;
 
 extern int brw_page(int, struct page *, kdev_t, int [], int);
 
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Fri May 16 13:32:56 2003
+++ b/include/linux/sysctl.h	Fri May 16 13:32:56 2003
@@ -144,6 +144,8 @@
 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
 	VM_MIN_READAHEAD=12,    /* Min file readahead */
 	VM_MAX_READAHEAD=13,    /* Max file readahead */
+	VM_LAPTOP_MODE=14,	/* vm laptop mode */
+	VM_BLOCK_DUMP=15,	/* dump data read/write and dirtying */
 };
 
 
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Fri May 16 13:32:56 2003
+++ b/kernel/sysctl.c	Fri May 16 13:32:56 2003
@@ -51,6 +51,8 @@
 extern int core_uses_pid;
 extern char core_pattern[];
 extern int cad_pid;
+extern int laptop_mode;
+extern int block_dump;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -280,6 +282,10 @@
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
--- a/mm/filemap.c	Fri May 16 13:32:56 2003
+++ b/mm/filemap.c	Fri May 16 13:32:56 2003
@@ -166,6 +166,8 @@
 
 			if (mapping && mapping->host)
 				mark_inode_dirty_pages(mapping->host);
+			if (block_dump)
+				printk("%s: dirtied page\n", current->comm);
 		}
 	}
 }

--gKMricLos+KVdGMg--
