Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTDXFEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTDXFEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:04:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64730 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264400AbTDXFEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:04:14 -0400
Date: Thu, 24 Apr 2003 10:51:19 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] Filesystem AIO rdwr - async bread
Message-ID: <20030424105119.F2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> 06bread_wq.patch	: Async bread implementation
> 

Pre-req for the filesystem specific async get block 
patches.

Regards
Suparna

06bread_wq.patch
................

 fs/buffer.c                 |   54 +++++++++++++++++++++++++++++++++++++-------
 include/linux/buffer_head.h |   30 ++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 11 deletions(-)

diff -ur -X /home/kiran/dontdiff linux-2.5.68/fs/buffer.c linux-aio-2568/fs/buffer.c
--- linux-2.5.68/fs/buffer.c	Mon Apr 21 23:30:33 2003
+++ linux-aio-2568/fs/buffer.c	Mon Apr 21 17:26:58 2003
@@ -118,23 +118,35 @@
  * from becoming locked again - you have to lock it yourself
  * if you want to preserve its state.
  */
-void __wait_on_buffer(struct buffer_head * bh)
+int __wait_on_buffer_wq(struct buffer_head * bh, wait_queue_t *wait)
 {
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(local_wait);
+
+	if (!wait)
+		wait = &local_wait;
 
 	if (atomic_read(&bh->b_count) == 0 &&
 			(!bh->b_page || !PageLocked(bh->b_page)))
 		buffer_error();
 
 	do {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wqh, wait, TASK_UNINTERRUPTIBLE);
 		if (buffer_locked(bh)) {
 			blk_run_queues();
+			if (!is_sync_wait(wait)) {
+				return -EIOCBRETRY;
+			}
 			io_schedule();
 		}
 	} while (buffer_locked(bh));
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, wait);
+	return 0;
+}
+
+void __wait_on_buffer(struct buffer_head * bh)
+{
+	__wait_on_buffer_wq(bh, NULL);
 }
 
 static void
@@ -1190,9 +1202,12 @@
 	__brelse(bh);
 }
 
-static struct buffer_head *__bread_slow(struct buffer_head *bh)
+static struct buffer_head *__bread_slow_wq(struct buffer_head *bh, 
+		wait_queue_t *wait)
 {
-	lock_buffer(bh);
+	if (-EIOCBRETRY == lock_buffer_wq(bh, wait))
+		return ERR_PTR(-EIOCBRETRY);
+
 	if (buffer_uptodate(bh)) {
 		unlock_buffer(bh);
 		return bh;
@@ -1202,7 +1217,8 @@
 		get_bh(bh);
 		bh->b_end_io = end_buffer_io_sync;
 		submit_bh(READ, bh);
-		wait_on_buffer(bh);
+		if (-EIOCBRETRY == wait_on_buffer_wq(bh, wait))
+			return ERR_PTR(-EIOCBRETRY);
 		if (buffer_uptodate(bh))
 			return bh;
 	}
@@ -1210,6 +1226,11 @@
 	return NULL;
 }
 
+static inline struct buffer_head *__bread_slow(struct buffer_head *bh)
+{
+	return __bread_slow_wq(bh, NULL);
+}
+	
 /*
  * Per-cpu buffer LRU implementation.  To reduce the cost of __find_get_block().
  * The bhs[] array is sorted - newest buffer is at bhs[0].  Buffers have their
@@ -1384,6 +1405,18 @@
 		bh = __bread_slow(bh);
 	return bh;
 }
+
+
+struct buffer_head *
+__bread_wq(struct block_device *bdev, sector_t block, int size,
+	wait_queue_t *wait)
+{
+	struct buffer_head *bh = __getblk(bdev, block, size);
+
+	if (!buffer_uptodate(bh))
+		bh = __bread_slow_wq(bh, wait);
+	return bh;
+}
 EXPORT_SYMBOL(__bread);
 
 /*
@@ -1822,8 +1855,11 @@
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
-			if (err)
+			if (err) {
+				if (-EIOCBRETRY == err)
+					pr_debug("get_block queued\n");
 				goto out;
+			}
 			if (buffer_new(bh)) {
 				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh->b_bdev,
@@ -1865,6 +1901,8 @@
 	 * If we issued read requests - let them complete.
 	 */
 	while(wait_bh > wait) {
+		if (!is_sync_wait(current->io_wait))
+			printk("block_prepare_write: wait on buffer\n");
 		wait_on_buffer(*--wait_bh);
 		if (!buffer_uptodate(*wait_bh))
 			return -EIO;
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/buffer_head.h linux-aio-2568/include/linux/buffer_head.h
--- linux-2.5.68/include/linux/buffer_head.h	Fri Apr 11 21:10:51 2003
+++ linux-aio-2568/include/linux/buffer_head.h	Wed Apr 16 16:31:12 2003
@@ -162,6 +162,7 @@
 void __invalidate_buffers(kdev_t dev, int);
 int sync_blockdev(struct block_device *bdev);
 void __wait_on_buffer(struct buffer_head *);
+int __wait_on_buffer_wq(struct buffer_head *, wait_queue_t *wait);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
 int fsync_bdev(struct block_device *);
@@ -172,6 +173,8 @@
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 struct buffer_head *__bread(struct block_device *, sector_t block, int size);
+struct buffer_head *__bread_wq(struct block_device *, sector_t block, 
+	int size, wait_queue_t *wait);
 struct buffer_head *alloc_buffer_head(void);
 void free_buffer_head(struct buffer_head * bh);
 void FASTCALL(unlock_buffer(struct buffer_head *bh));
@@ -229,13 +232,13 @@
 
 static inline void brelse(struct buffer_head *bh)
 {
-	if (bh)
+	if (bh && !IS_ERR(bh))
 		__brelse(bh);
 }
 
 static inline void bforget(struct buffer_head *bh)
 {
-	if (bh)
+	if (bh && !IS_ERR(bh))
 		__bforget(bh);
 }
 
@@ -246,7 +249,12 @@
 }
 
 static inline struct buffer_head *
-sb_getblk(struct super_block *sb, sector_t block)
+sb_bread_wq(struct super_block *sb, sector_t block, wait_queue_t *wait)
+{
+	return __bread_wq(sb->s_bdev, block, sb->s_blocksize, wait);
+}
+
+static inline struct buffer_head *sb_getblk(struct super_block *sb, sector_t block)
 {
 	return __getblk(sb->s_bdev, block, sb->s_blocksize);
 }
@@ -276,10 +284,26 @@
 		__wait_on_buffer(bh);
 }
 
+static inline int wait_on_buffer_wq(struct buffer_head *bh, wait_queue_t *wait)
+{
+	if (buffer_locked(bh))
+		return __wait_on_buffer_wq(bh, wait);
+
+	return 0;
+}
+
 static inline void lock_buffer(struct buffer_head *bh)
 {
 	while (test_set_buffer_locked(bh))
 		__wait_on_buffer(bh);
 }
 
+static inline int lock_buffer_wq(struct buffer_head *bh, wait_queue_t *wait)
+{
+	if (test_set_buffer_locked(bh))
+		return __wait_on_buffer_wq(bh, wait);
+
+	return 0;
+}
+
 #endif /* _LINUX_BUFFER_HEAD_H */

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

