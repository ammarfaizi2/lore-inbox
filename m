Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTENJWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbTENJWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:22:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62393 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261561AbTENJWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:22:16 -0400
Date: Wed, 14 May 2003 11:35:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4 laptop mode
Message-ID: <20030514093504.GE17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now, this isn't the prettiest patch in the world. But it does allow me
to get good spin down times on my laptop hard drive. It was somewhat
inspired by the 2.5.early version akpm did. Basically, it adds:

- a laptop_mode sysctl variable that controls:

	- write back of dirty data. when we have to do it, write back
	  all of it.

	- when a read is scheduled, write out dirty pending data right
	  after. purpose of that is to make good use of a disk that was
	  potentially spun down before.

- a block_dump sysctl variable. when this is set, it dumps info to dmesg
  about which process scheduled the read/write. this is helpful for
  determining _why_ the disk is spinning up all the time.

Patch also sets expire time of buffer and kupdated intervals to 10
minutes, this should probably just be done from a script. ext3's jbd is
changed to set the journal expire time to the same as the buffer expire
time.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.850   -> 1.853  
#	include/linux/sysctl.h	1.20    -> 1.21   
#	fs/jbd/transaction.c	1.11    -> 1.12   
#	         fs/buffer.c	1.70    -> 1.72   
#	  include/linux/fs.h	1.67    -> 1.68   
#	drivers/block/ll_rw_blk.c	1.42    -> 1.44   
#	     kernel/sysctl.c	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/14	axboe@apu.(none)	1.851
# laptop mode
# --------------------------------------------
# 03/05/14	axboe@apu.(none)	1.852
# laptop mode for jbd
# --------------------------------------------
# 03/05/14	axboe@apu.(none)	1.853
# remove some debug stuff
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Wed May 14 11:29:52 2003
+++ b/drivers/block/ll_rw_blk.c	Wed May 14 11:29:52 2003
@@ -122,6 +122,10 @@
 unsigned long blk_max_low_pfn, blk_max_pfn;
 int blk_nohighio = 0;
 
+int block_dump = 0;
+
+static struct timer_list writeback_timer;
+
 #ifdef CONFIG_BLK_AAM
 static struct proc_dir_entry *blk_aam_root;
 #endif
@@ -1223,6 +1227,9 @@
 			kstat.pgpgin += count;
 			break;
 	}
+
+	if (block_dump)
+		printk("%s: %s block %lu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", bh->b_rsector, count, kdevname(bh->b_rdev));
 }
 
 /**
@@ -1334,6 +1341,11 @@
 extern int stram_device_init (void);
 #endif
 
+static void blk_writeback_timer(unsigned long data)
+{
+	wakeup_bdflush();
+	wakeup_kupdate();
+}
 
 /**
  * end_that_request_first - end I/O on one buffer.
@@ -1389,10 +1401,18 @@
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
@@ -1419,6 +1439,9 @@
 
 	blk_max_low_pfn = max_low_pfn - 1;
 	blk_max_pfn = max_pfn - 1;
+
+	init_timer(&writeback_timer);
+	writeback_timer.function = blk_writeback_timer;
 
 #ifdef CONFIG_BLK_AAM
 	blk_aam_root = proc_mkdir("aam", 0);
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Wed May 14 11:29:52 2003
+++ b/fs/buffer.c	Wed May 14 11:29:52 2003
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
 
@@ -117,7 +124,7 @@
 		int dummy5;	/* unused */
 	} b_un;
 	unsigned int data[N_PARAM];
-} bdf_prm = {{30, 500, 0, 0, 5*HZ, 30*HZ, 60, 20, 0}};
+} bdf_prm = {{30, 500, 0, 0, 10*60*HZ, 10*60*HZ, 60, 20, 0}};
 
 /* These are the min and max parameter values that we will allow to be assigned */
 int bdflush_min[N_PARAM] = {  0,  1,    0,   0,  0,   1*HZ,   0, 0, 0};
@@ -239,9 +246,9 @@
  */
 static void write_unlocked_buffers(kdev_t dev)
 {
-	do
+	do {
 		spin_lock(&lru_list_lock);
-	while (write_some_buffers(dev));
+	} while (write_some_buffers(dev));
 }
 
 /*
@@ -995,7 +1002,7 @@
 	dirty *= 100;
 	dirty_limit = tot * bdf_prm.b_un.nfract_stop_bdflush;
 
-	if (dirty > dirty_limit)
+	if (!laptop_mode && dirty > dirty_limit)
 		return 0;
 	return 1;
 }
@@ -1055,6 +1062,13 @@
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
@@ -2815,6 +2829,12 @@
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
@@ -2835,7 +2855,9 @@
 
 		spin_lock(&lru_list_lock);
 		bh = lru_list[BUF_DIRTY];
-		if (!bh || time_before(jiffies, bh->b_flushtime))
+		if (!bh)
+			break;
+		if (time_before(jiffies, bh->b_flushtime) && !laptop_mode)
 			break;
 		if (write_some_buffers(NODEV))
 			continue;
@@ -2983,6 +3005,10 @@
 	complete((struct completion *)startup);
 
 	for (;;) {
+		DECLARE_WAITQUEUE(wait, tsk);
+
+		add_wait_queue(&kupdate_wait, &wait);
+
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
 		if (interval) {
@@ -2993,6 +3019,7 @@
 			tsk->state = TASK_STOPPED;
 			schedule(); /* wait for SIGCONT */
 		}
+		remove_wait_queue(&kupdate_wait, &wait);
 		/* check for sigstop */
 		if (signal_pending(tsk)) {
 			int stopped = 0;
@@ -3010,6 +3037,8 @@
 		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
 		sync_old_buffers();
+		if (laptop_mode)
+			fsync_dev(NODEV);
 		run_task_queue(&tq_disk);
 	}
 }
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	Wed May 14 11:29:52 2003
+++ b/fs/jbd/transaction.c	Wed May 14 11:29:52 2003
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
--- a/include/linux/fs.h	Wed May 14 11:29:52 2003
+++ b/include/linux/fs.h	Wed May 14 11:29:52 2003
@@ -1242,6 +1242,7 @@
 }
 
 extern void set_buffer_flushtime(struct buffer_head *);
+extern unsigned long get_buffer_flushtime(void);
 extern void balance_dirty(void);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
@@ -1431,6 +1432,7 @@
 	return get_hash_table(sb->s_dev, block, sb->s_blocksize);
 }
 extern void wakeup_bdflush(void);
+extern void wakeup_kupdate(void);
 extern void put_unused_buffer_head(struct buffer_head * bh);
 extern struct buffer_head * get_unused_buffer_head(int async);
 
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Wed May 14 11:29:52 2003
+++ b/include/linux/sysctl.h	Wed May 14 11:29:52 2003
@@ -145,6 +145,8 @@
 	VM_MIN_READAHEAD=12,    /* Min file readahead */
 	VM_MAX_READAHEAD=13,    /* Max file readahead */
 	VM_HEAP_STACK_GAP=14,	/* int: page gap between heap and stack */
+	VM_LAPTOP_MODE=15,
+	VM_BLOCK_DUMP=16,
 };
 
 
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed May 14 11:29:52 2003
+++ b/kernel/sysctl.c	Wed May 14 11:29:52 2003
@@ -51,6 +51,8 @@
 extern int core_uses_pid;
 extern char core_pattern[];
 extern int cad_pid;
+extern int laptop_mode;
+extern int block_dump;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -282,6 +284,10 @@
 	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAX_MAP_COUNT, "max_map_count",
 	 &max_map_count, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_LAPTOP_MODE, "laptop_mode",
+	 &laptop_mode, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_BLOCK_DUMP, "block_dump",
+	 &block_dump, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 

-- 
Jens Axboe

