Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbTDAQVd>; Tue, 1 Apr 2003 11:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbTDAQRd>; Tue, 1 Apr 2003 11:17:33 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49131 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262639AbTDAQQt>;
	Tue, 1 Apr 2003 11:16:49 -0500
Date: Tue, 1 Apr 2003 22:03:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030401220313.C1857@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030401215957.A1800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401215957.A1800@in.ibm.com>; from suparna@in.ibm.com on Tue, Apr 01, 2003 at 09:59:57PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 09:59:57PM +0530, Suparna Bhattacharya wrote:
> 03aiobread.patch : code for async breads which can
>   be used by filesystems for providing async get block 
>   implementation

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

diff -ur linux-2.5.66/fs/buffer.c linux-2.5.66aio/fs/buffer.c
--- linux-2.5.66/fs/buffer.c	Tue Mar 25 03:30:48 2003
+++ linux-2.5.66aio/fs/buffer.c	Wed Mar 26 19:11:09 2003
@@ -118,21 +118,38 @@
  * from becoming locked again - you have to lock it yourself
  * if you want to preserve its state.
  */
-void __wait_on_buffer(struct buffer_head * bh)
+int __wait_on_buffer_async(struct buffer_head * bh)
 {
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(sync_wait);
+	wait_queue_t *wait = &sync_wait;
+	int state = TASK_UNINTERRUPTIBLE;
+
+	if (current->iocb) {
+		wait = &current->iocb->ki_wait;
+		state = TASK_RUNNING;
+	}
 
 	get_bh(bh);
 	do {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wqh, wait, state);
 		if (buffer_locked(bh)) {
 			blk_run_queues();
+			if (current->iocb) {
+				put_bh(bh); /* TBD: is this correct ? */
+				return -EIOCBQUEUED;
+			}
 			io_schedule();
 		}
 	} while (buffer_locked(bh));
 	put_bh(bh);
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, wait);
+	return 0;
+}
+
+void __wait_on_buffer(struct buffer_head * bh)
+{
+	do_sync_op(__wait_on_buffer_async(bh));
 }
 
 static void
@@ -1188,9 +1205,11 @@
 	__brelse(bh);
 }
 
-static struct buffer_head *__bread_slow(struct buffer_head *bh)
+static struct buffer_head *__bread_slow_async(struct buffer_head *bh)
 {
-	lock_buffer(bh);
+	if (-EIOCBQUEUED == lock_buffer_async(bh))
+		return ERR_PTR(-EIOCBQUEUED);
+
 	if (buffer_uptodate(bh)) {
 		unlock_buffer(bh);
 		return bh;
@@ -1200,7 +1219,8 @@
 		get_bh(bh);
 		bh->b_end_io = end_buffer_io_sync;
 		submit_bh(READ, bh);
-		wait_on_buffer(bh);
+		if (-EIOCBQUEUED == wait_on_buffer_async(bh))
+			return ERR_PTR(-EIOCBQUEUED);
 		if (buffer_uptodate(bh))
 			return bh;
 	}
@@ -1208,6 +1228,14 @@
 	return NULL;
 }
 
+static inline struct buffer_head *__bread_slow(struct buffer_head *bh)
+{
+	struct buffer_head *ret_bh;
+
+	do_sync_op(ret_bh = __bread_slow_async(bh));
+	return ret_bh;
+}
+	
 /*
  * Per-cpu buffer LRU implementation.  To reduce the cost of __find_get_block().
  * The bhs[] array is sorted - newest buffer is at bhs[0].  Buffers have their
@@ -1382,6 +1410,17 @@
 		bh = __bread_slow(bh);
 	return bh;
 }
+
+
+struct buffer_head *
+__bread_async(struct block_device *bdev, sector_t block, int size)
+{
+	struct buffer_head *bh = __getblk(bdev, block, size);
+
+	if (!buffer_uptodate(bh))
+		bh = __bread_slow_async(bh);
+	return bh;
+}
 EXPORT_SYMBOL(__bread);
 
 /*
diff -ur linux-2.5.66/include/linux/buffer_head.h linux-2.5.66aio/include/linux/buffer_head.h
--- linux-2.5.66/include/linux/buffer_head.h	Tue Mar 25 03:29:54 2003
+++ linux-2.5.66aio/include/linux/buffer_head.h	Wed Mar 26 19:26:42 2003
@@ -156,6 +156,7 @@
 void __invalidate_buffers(kdev_t dev, int);
 int sync_blockdev(struct block_device *bdev);
 void __wait_on_buffer(struct buffer_head *);
+int __wait_on_buffer_async(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
 int fsync_bdev(struct block_device *);
@@ -166,6 +167,8 @@
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 struct buffer_head *__bread(struct block_device *, sector_t block, int size);
+struct buffer_head *__bread_async(struct block_device *, sector_t block, 
+	int size);
 struct buffer_head *alloc_buffer_head(void);
 void free_buffer_head(struct buffer_head * bh);
 void FASTCALL(unlock_buffer(struct buffer_head *bh));
@@ -237,6 +240,12 @@
 	return __bread(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *sb_bread_async(struct super_block *sb, 
+	sector_t block)
+{
+	return __bread_async(sb->s_bdev, block, sb->s_blocksize);
+}
+
 static inline struct buffer_head *sb_getblk(struct super_block *sb, sector_t block)
 {
 	return __getblk(sb->s_bdev, block, sb->s_blocksize);
@@ -262,12 +271,28 @@
 		__wait_on_buffer(bh);
 }
 
+static inline int wait_on_buffer_async(struct buffer_head *bh)
+{
+	if (buffer_locked(bh))
+		return __wait_on_buffer_async(bh);
+
+	return 0;
+}
+
 static inline void lock_buffer(struct buffer_head *bh)
 {
 	while (test_set_buffer_locked(bh))
 		__wait_on_buffer(bh);
 }
 
+static inline int lock_buffer_async(struct buffer_head *bh)
+{
+	if (test_set_buffer_locked(bh))
+		return __wait_on_buffer_async(bh);
+
+	return 0;
+}
+
 /*
  * Debug
  */
