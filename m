Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSIKIMY>; Wed, 11 Sep 2002 04:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSIKIMO>; Wed, 11 Sep 2002 04:12:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:3216 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318516AbSIKILF>;
	Wed, 11 Sep 2002 04:11:05 -0400
Message-ID: <3D7EFF42.59684767@digeo.com>
Date: Wed, 11 Sep 2002 01:30:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] pdflush congestion avoidance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 08:15:46.0292 (UTC) FILETIME=[6E133340:01C2596B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Add the `nonblocking' flag to struct writeback_control, and teach
  the writeback paths to honour it.

- Add the `encountered_congestion' flag to struct writeback_control
  and teach the writeback paths to set it.


So as soon as a mapping's backing_dev_info indicates that it is getting
congested, bale out of writeback.  And don't even start writeback
against filesystems whose queues are congested.

- Convert pdflush's background_writeback() function to use
  nonblocking writeback.

This way, a single pdflush thread will circulate around all the
dirty queues, keeping them filled.

- Convert the pdlfush `kupdate' function to do the same thing.


This solves the problem of pdflush thread pool exhaustion.

It solves the problem of pdflush startup latency.

It solves the (minor) problem wherein `kupdate' writeback only writes
back a single disk at a time (it was getting blocked on each queue in
turn).

It probably means that we only ever need a single pdflush thread.




 fs/fs-writeback.c         |   40 ++++++++++++++++++++++------------------
 fs/mpage.c                |    7 +++++++
 include/linux/writeback.h |    2 ++
 mm/page-writeback.c       |   37 +++++++++++++++++++++++++++++--------
 4 files changed, 60 insertions(+), 26 deletions(-)

--- 2.5.34/fs/mpage.c~nonblocking-pdflush	Tue Sep 10 00:00:20 2002
+++ 2.5.34-akpm/fs/mpage.c	Tue Sep 10 00:00:20 2002
@@ -20,6 +20,7 @@
 #include <linux/prefetch.h>
 #include <linux/mpage.h>
 #include <linux/writeback.h>
+#include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
 /*
@@ -530,6 +531,7 @@ int
 mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block)
 {
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
 	int ret = 0;
@@ -593,6 +595,11 @@ mpage_writepages(struct address_space *m
 			}
 			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
+			if (wbc->nonblocking && bdi_write_congested(bdi)) {
+				blk_run_queues();
+				wbc->encountered_congestion = 1;
+				done = 1;
+			}
 		} else {
 			unlock_page(page);
 		}
--- 2.5.34/include/linux/writeback.h~nonblocking-pdflush	Tue Sep 10 00:00:20 2002
+++ 2.5.34-akpm/include/linux/writeback.h	Tue Sep 10 00:00:20 2002
@@ -43,6 +43,8 @@ struct writeback_control {
 					   older than this */
 	long nr_to_write;		/* Write this many pages, and decrement
 					   this for each page written */
+	int nonblocking;		/* Don't get stuck on request queues */
+	int encountered_congestion;	/* An output: a queue is full */
 };
 	
 void writeback_inodes(struct writeback_control *wbc);
--- 2.5.34/mm/page-writeback.c~nonblocking-pdflush	Tue Sep 10 00:00:20 2002
+++ 2.5.34-akpm/mm/page-writeback.c	Tue Sep 10 00:00:20 2002
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/backing-dev.h>
+#include <linux/blkdev.h>
 #include <linux/mpage.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
@@ -172,21 +173,30 @@ static void background_writeout(unsigned
 		.sync_mode	= WB_SYNC_NONE,
 		.older_than_this = NULL,
 		.nr_to_write	= 0,
+		.nonblocking	= 1,
 	};
 
 	CHECK_EMERGENCY_SYNC
 
 	background_thresh = (dirty_background_ratio * total_pages) / 100;
-
-	do {
+	for ( ; ; ) {
 		struct page_state ps;
+
 		get_page_state(&ps);
 		if (ps.nr_dirty < background_thresh && min_pages <= 0)
 			break;
+		wbc.encountered_congestion = 0;
 		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
 		writeback_inodes(&wbc);
 		min_pages -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
-	} while (wbc.nr_to_write <= 0);
+		if (wbc.nr_to_write == MAX_WRITEBACK_PAGES) {
+			/* Wrote nothing */
+			if (wbc.encountered_congestion)
+				blk_congestion_wait(WRITE, HZ/10);
+			else
+				break;
+		}
+	}
 	blk_run_queues();
 }
 
@@ -223,25 +233,36 @@ static void wb_kupdate(unsigned long arg
 	unsigned long oldest_jif;
 	unsigned long start_jif;
 	unsigned long next_jif;
+	long nr_to_write;
 	struct page_state ps;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= WB_SYNC_NONE,
 		.older_than_this = &oldest_jif,
 		.nr_to_write	= 0,
+		.nonblocking	= 1,
 	};
 
 	sync_supers();
-	get_page_state(&ps);
 
+	get_page_state(&ps);
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
-	wbc.nr_to_write = ps.nr_dirty;
-	writeback_inodes(&wbc);
+	nr_to_write = ps.nr_dirty;
+	while (nr_to_write > 0) {
+		wbc.encountered_congestion = 0;
+		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
+		writeback_inodes(&wbc);
+		if (wbc.nr_to_write == MAX_WRITEBACK_PAGES) {
+			if (wbc.encountered_congestion)
+				blk_congestion_wait(WRITE, HZ);
+			else
+				break;	/* All the old data is written */
+		}
+		nr_to_write -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
+	}
 	blk_run_queues();
-	yield();
-
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
 	mod_timer(&wb_timer, next_jif);
--- 2.5.34/fs/fs-writeback.c~nonblocking-pdflush	Tue Sep 10 00:00:20 2002
+++ 2.5.34-akpm/fs/fs-writeback.c	Tue Sep 10 00:00:20 2002
@@ -220,44 +220,52 @@ __writeback_single_inode(struct inode *i
  *
  * FIXME: this linear search could get expensive with many fileystems.  But
  * how to fix?  We need to go from an address_space to all inodes which share
- * a queue with that address_space.
+ * a queue with that address_space.  (Easy: have a global "dirty superblocks"
+ * list).
  *
  * The inodes to be written are parked on sb->s_io.  They are moved back onto
  * sb->s_dirty as they are selected for writing.  This way, none can be missed
  * on the writer throttling path, and we get decent balancing between many
- * thrlttled threads: we don't want them all piling up on __wait_on_inode.
+ * throlttled threads: we don't want them all piling up on __wait_on_inode.
  */
 static void
 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
 {
-	struct list_head *tmp;
-	struct list_head *head;
 	const unsigned long start = jiffies;	/* livelock avoidance */
 
 	list_splice_init(&sb->s_dirty, &sb->s_io);
-	head = &sb->s_io;
-	while ((tmp = head->prev) != head) {
-		struct inode *inode = list_entry(tmp, struct inode, i_list);
+	while (!list_empty(&sb->s_io)) {
+		struct inode *inode = list_entry(sb->s_io.prev,
+						struct inode, i_list);
 		struct address_space *mapping = inode->i_mapping;
-		struct backing_dev_info *bdi;
+		struct backing_dev_info *bdi = mapping->backing_dev_info;
 		int really_sync;
 
-		if (wbc->bdi && mapping->backing_dev_info != wbc->bdi) {
+		if (wbc->nonblocking && bdi_write_congested(bdi)) {
+			wbc->encountered_congestion = 1;
 			if (sb != blockdev_superblock)
-				break;		/* inappropriate superblock */
+				break;		/* Skip a congested fs */
 			list_move(&inode->i_list, &sb->s_dirty);
-			continue;		/* not this blockdev */
+			continue;		/* Skip a congested blockdev */
+		}
+
+		if (wbc->bdi && bdi != wbc->bdi) {
+			if (sb != blockdev_superblock)
+				break;		/* fs has the wrong queue */
+			list_move(&inode->i_list, &sb->s_dirty);
+			continue;		/* blockdev has wrong queue */
 		}
 
 		/* Was this inode dirtied after sync_sb_inodes was called? */
 		if (time_after(mapping->dirtied_when, start))
 			break;
 
+		/* Was this inode dirtied too recently? */
 		if (wbc->older_than_this && time_after(mapping->dirtied_when,
 						*wbc->older_than_this))
-			goto out;
+			break;
 
-		bdi = mapping->backing_dev_info;
+		/* Is another pdflush already flushing this queue? */
 		if (current_is_pdflush() && !writeback_acquire(bdi))
 			break;
 
@@ -278,11 +286,7 @@ sync_sb_inodes(struct super_block *sb, s
 		if (wbc->nr_to_write <= 0)
 			break;
 	}
-out:
-	/*
-	 * Leave any unwritten inodes on s_io.
-	 */
-	return;
+	return;		/* Leave any unwritten inodes on s_io */
 }
 
 /*

.
