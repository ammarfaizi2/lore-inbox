Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314957AbSESTkI>; Sun, 19 May 2002 15:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSESTjM>; Sun, 19 May 2002 15:39:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315115AbSESTiY>;
	Sun, 19 May 2002 15:38:24 -0400
Message-ID: <3CE80008.5A9CA5DA@zip.com.au>
Date: Sun, 19 May 2002 12:42:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/15] pdflush exclusion
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use the pdflush exclusion infrastructure to ensure that only one
pdlfush thread is ever performing writeback against a particular
request_queue.

This works rather well.  It requires a lot of activity against a lot of
disks to cause more pdflush threads to start up.  Possibly the
thread-creation logic is a little weak: it starts more threads when a
pdflush thread goes back to sleep.  It may be better to start new
threads within pdlfush_operation().

All non-request_queue-backed address_spaces share the global
default_backing_dev_info structure.  So at present only a single
pdflush instance will be available for background writeback of *all*
NFS filesystems (for example).

It there is benefit in concurrent background writeback for multiple NFS
mounts then NFS would need to create per-mount backing_dev_info
structures and install those into new inode's address_spaces in some
manner.


=====================================

--- 2.5.16/fs/fs-writeback.c~pdflush-single	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/fs-writeback.c	Sun May 19 12:02:57 2002
@@ -187,6 +187,9 @@ static void __sync_single_inode(struct i
 static void
 __writeback_single_inode(struct inode *inode, int sync, int *nr_to_write)
 {
+	if (current_is_pdflush() && (inode->i_state & I_LOCK))
+		return;
+
 	while (inode->i_state & I_LOCK) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
@@ -213,6 +216,9 @@ void writeback_single_inode(struct inode
  * had their first dirtying at a time earlier than *older_than_this.
  *
  * Called under inode_lock.
+ *
+ * If we're a pdlfush thread, then implement pdlfush collision avoidance
+ * against the entire list.
  */
 static void __sync_list(struct list_head *head, int sync_mode,
 		int *nr_to_write, unsigned long *older_than_this)
@@ -223,6 +229,8 @@ static void __sync_list(struct list_head
 	while ((tmp = head->prev) != head) {
 		struct inode *inode = list_entry(tmp, struct inode, i_list);
 		struct address_space *mapping = inode->i_mapping;
+		struct backing_dev_info *bdi;
+
 		int really_sync;
 
 		/* Was this inode dirtied after __sync_list was called? */
@@ -233,10 +241,18 @@ static void __sync_list(struct list_head
 			time_after(mapping->dirtied_when, *older_than_this))
 			break;
 
+		bdi = mapping->backing_dev_info;
+		if (current_is_pdflush() && !writeback_acquire(bdi))
+			break;
+
 		really_sync = (sync_mode == WB_SYNC_ALL);
 		if ((sync_mode == WB_SYNC_LAST) && (head->prev == head))
 			really_sync = 1;
 		__writeback_single_inode(inode, really_sync, nr_to_write);
+
+		if (current_is_pdflush())
+			writeback_release(bdi);
+
 		if (nr_to_write && *nr_to_write == 0)
 			break;
 	}
@@ -255,6 +271,8 @@ static void __sync_list(struct list_head
  *
  * If `older_than_this' is non-zero then only flush inodes which have a
  * flushtime older than *older_than_this.
+ *
+ * This is a "memory cleansing" operation, not a "data integrity" operation.
  */
 void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
 				unsigned long *older_than_this)
@@ -276,29 +294,12 @@ void writeback_unlocked_inodes(int *nr_t
 		if (sb->s_writeback_gen == writeback_gen)
 			continue;
 		sb->s_writeback_gen = writeback_gen;
-
-		if (current->flags & PF_FLUSHER) {
-			if (sb->s_flags & MS_FLUSHING) {
-				/*
-				 * There's no point in two pdflush threads
-				 * flushing the same device.  But for other
-				 * callers, we want to perform the flush
-				 * because the fdatasync is how we implement
-				 * writer throttling.
-				 */
-				continue;
-			}
-			sb->s_flags |= MS_FLUSHING;
-		}
-
 		if (!list_empty(&sb->s_dirty)) {
 			spin_unlock(&sb_lock);
 			__sync_list(&sb->s_dirty, sync_mode,
 					nr_to_write, older_than_this);
 			spin_lock(&sb_lock);
 		}
-		if (current->flags & PF_FLUSHER)
-			sb->s_flags &= ~MS_FLUSHING;
 		if (nr_to_write && *nr_to_write == 0)
 			break;
 	}
@@ -307,7 +308,7 @@ void writeback_unlocked_inodes(int *nr_t
 }
 
 /*
- * Called under inode_lock
+ * Called under inode_lock.
  */
 static int __try_to_writeback_unused_list(struct list_head *head, int nr_inodes)
 {
@@ -318,7 +319,17 @@ static int __try_to_writeback_unused_lis
 		inode = list_entry(tmp, struct inode, i_list);
 
 		if (!atomic_read(&inode->i_count)) {
+			struct backing_dev_info *bdi;
+
+			bdi = inode->i_mapping->backing_dev_info;
+			if (current_is_pdflush() && !writeback_acquire(bdi))
+				goto out;
+
 			__sync_single_inode(inode, 0, NULL);
+
+			if (current_is_pdflush())
+				writeback_release(bdi);
+
 			nr_inodes--;
 
 			/* 
@@ -328,7 +339,7 @@ static int __try_to_writeback_unused_lis
 			tmp = head;
 		}
 	}
-
+out:
 	return nr_inodes;
 }
 
@@ -421,7 +432,11 @@ void sync_inodes(void)
 	}
 }
 
-void try_to_writeback_unused_inodes(unsigned long pexclusive)
+/*
+ * FIXME: the try_to_writeback_unused functions look dreadfully similar to
+ * writeback_unlocked_inodes...
+ */
+void try_to_writeback_unused_inodes(unsigned long unused)
 {
 	struct super_block * sb;
 	int nr_inodes = inodes_stat.nr_unused;
@@ -440,7 +455,6 @@ void try_to_writeback_unused_inodes(unsi
 	}
 	spin_unlock(&sb_lock);
 	spin_unlock(&inode_lock);
-	clear_bit(0, (unsigned long *)pexclusive);
 }
 
 /**
--- 2.5.16/include/linux/writeback.h~pdflush-single	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/include/linux/writeback.h	Sun May 19 12:02:57 2002
@@ -13,6 +13,15 @@ extern struct list_head inode_in_use;
 extern struct list_head inode_unused;
 
 /*
+ * Yes, writeback.h requires sched.h
+ * No, sched.h is not included from here.
+ */
+static inline int current_is_pdflush(void)
+{
+	return current->flags & PF_FLUSHER;
+}
+
+/*
  * fs/fs-writeback.c
  */
 #define WB_SYNC_NONE	0	/* Don't wait on anything */
--- 2.5.16/fs/inode.c~pdflush-single	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/inode.c	Sun May 19 12:02:57 2002
@@ -404,21 +404,14 @@ void prune_icache(int goal)
 	dispose_list(freeable);
 
 	/* 
-	 * If we didn't freed enough clean inodes schedule
-	 * a sync of the dirty inodes, we cannot do it
-	 * from here or we're either synchronously dogslow
-	 * or we deadlock with oom.
+	 * If we didn't free enough clean inodes then schedule writeback of
+	 * the dirty inodes.  We cannot do it from here or we're either
+	 * synchronously dogslow or we deadlock with oom.
 	 */
-	if (goal) {
-		static unsigned long exclusive;
-
-		if (!test_and_set_bit(0, &exclusive)) {
-			if (pdflush_operation(try_to_writeback_unused_inodes,
-						(unsigned long)&exclusive))
-				clear_bit(0, &exclusive);
-		}
-	}
+	if (goal)
+		pdflush_operation(try_to_writeback_unused_inodes, 0);
 }
+
 /*
  * This is called from kswapd when we think we need some
  * more memory, but aren't really sure how much. So we
--- 2.5.16/include/linux/fs.h~pdflush-single	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/include/linux/fs.h	Sun May 19 12:02:57 2002
@@ -112,7 +112,6 @@ extern int leases_enable, dir_notify_ena
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
-#define MS_FLUSHING	(1<<16)	/* inodes are currently under writeout */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -156,7 +155,6 @@ extern int leases_enable, dir_notify_ena
 #define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || ((inode)->i_flags & S_SYNC))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
-#define IS_FLUSHING(inode)	__IS_FLG(inode, MS_FLUSHING)
 
 #define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
--- 2.5.16/mm/page-writeback.c~pdflush-single	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/page-writeback.c	Sun May 19 12:02:57 2002
@@ -20,6 +20,7 @@
 #include <linux/writeback.h>
 #include <linux/init.h>
 #include <linux/sysrq.h>
+#include <linux/backing-dev.h>
 
 /*
  * Memory thresholds, in percentages
@@ -86,10 +87,7 @@ void balance_dirty_pages(struct address_
 		wake_pdflush = 1;
 	}
 
-	if (wake_pdflush && !IS_FLUSHING(mapping->host)) {
-		/*
-		 * There is no flush thread against this device. Start one now.
-		 */
+	if (wake_pdflush && !writeback_in_progress(mapping->backing_dev_info)) {
 		if (dirty_and_writeback > async_thresh) {
 			pdflush_flush(dirty_and_writeback - async_thresh);
 			yield();

-
