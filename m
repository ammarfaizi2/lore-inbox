Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSGEAVf>; Thu, 4 Jul 2002 20:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSGDXuT>; Thu, 4 Jul 2002 19:50:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314829AbSGDXp0>;
	Thu, 4 Jul 2002 19:45:26 -0400
Message-ID: <3D24E00D.C986DB7D@zip.com.au>
Date: Thu, 04 Jul 2002 16:53:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch 3/27] per-cpu buffer_head cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ext2 and ext3 implement a custom LRU cache of buffer_heads - the eight
most-recently-used inode bitmap buffers and the eight MRU block bitmap
buffers.

I don't like them, for a number of reasons:

- The code is duplicated between filesystems

- The functionality is unavailable to other filesystems

- The LRU only applies to bitmap buffers.  And not, say, indirects.

- The LRUs are subtly dependent upon lock_super() for protection:
  without lock_super protection a bitmap could be evicted and freed
  while in use.

  And removing this dependence on lock_super() gets us one step on
  the way toward getting that semaphore out of the ext2 block allocator -
  it causes significant contention under some loads and should be a
  spinlock.

- The LRUs pin 64 kbytes per mounted filesystem.

Now, we could just delete those LRUs and rely on the VM to manage the
memory.  But that would introduce significant lock contention in
__find_get_block - the blockdev mapping's private_lock and page_lock
are heavily used.

So this patch introduces a transparent per-CPU bh lru which is hidden
inside __find_get_block(), __getblk() and __bread().  It is designed to
shorten code paths and to reduce lock contention.  It uses a seven-slot
LRU.  It achieves a 99% hit rate in `dbench 64'.  It provides benefit
to all filesystems.

The next patches remove the open-coded LRUs from ext2 and ext3.

Taken together, these patches are a code cleanup (300-400 lines gone),
and they reduce lock contention.  Anton tested these patches on the
32-way and demonstrated a throughput improvement of up to 15% on
RAM-only dbench runs.  See http://samba.org/~anton/linux/2.5.24/dbench/

Most of this benefit is from avoiding find_get_page() on the blockdev
mapping.  Because the generic LRU copes with indirect blocks as well as
bitmaps.



 fs/buffer.c                 |  172 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/buffer_head.h |   49 +++---------
 kernel/ksyms.c              |    3 
 3 files changed, 184 insertions(+), 40 deletions(-)

--- 2.5.24/fs/buffer.c~bh-lrus	Thu Jul  4 16:17:07 2002
+++ 2.5.24-akpm/fs/buffer.c	Thu Jul  4 16:22:13 2002
@@ -36,6 +36,8 @@
 #include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
+static void invalidate_bh_lrus(void);
+
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
 /*
@@ -389,7 +391,7 @@ out:
  * private_lock is contended then so is mapping->page_lock).
  */
 struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, int unused)
+__find_get_block_slow(struct block_device *bdev, sector_t block, int unused)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -459,6 +461,7 @@ out:
    pass does the actual I/O. */
 void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers)
 {
+	invalidate_bh_lrus();
 	/*
 	 * FIXME: what about destroy_dirty_buffers?
 	 * We really want to use invalidate_inode_pages2() for
@@ -1159,7 +1162,7 @@ grow_buffers(struct block_device *bdev, 
  * attempt is failing.  FIXME, perhaps?
  */
 struct buffer_head *
-__getblk(struct block_device *bdev, sector_t block, int size)
+__getblk_slow(struct block_device *bdev, sector_t block, int size)
 {
 	for (;;) {
 		struct buffer_head * bh;
@@ -1259,7 +1262,8 @@ void __bforget(struct buffer_head *bh)
  *  Reads a specified block, and returns buffer head that contains it.
  *  It returns NULL if the block was unreadable.
  */
-struct buffer_head * __bread(struct block_device *bdev, int block, int size)
+struct buffer_head *
+__bread_slow(struct block_device *bdev, sector_t block, int size)
 {
 	struct buffer_head *bh = __getblk(bdev, block, size);
 
@@ -1283,6 +1287,165 @@ struct buffer_head * __bread(struct bloc
 	return NULL;
 }
 
+/*
+ * Per-cpu buffer LRU implementation.  To reduce the cost of __find_get_block().
+ * The bhs[] array is sorted - newest buffer is at bhs[0].  Buffers have their
+ * refcount elevated by one when they're in an LRU.  A buffer can only appear
+ * once in a particular CPU's LRU.  A single buffer can be present in multiple
+ * CPU's LRUs at the same time.
+ *
+ * This is a transparent caching front-end to sb_bread(), sb_getblk() and
+ * sb_find_get_block().
+ */
+
+#define BH_LRU_SIZE	7
+
+static struct bh_lru {
+	spinlock_t lock;
+	struct buffer_head *bhs[BH_LRU_SIZE];
+} ____cacheline_aligned_in_smp bh_lrus[NR_CPUS];
+
+/*
+ * The LRU management algorithm is dopey-but-simple.  Sorry.
+ */
+static void bh_lru_install(struct buffer_head *bh)
+{
+	struct buffer_head *evictee = NULL;
+	struct bh_lru *lru;
+
+	if (bh == NULL)
+		return;
+
+	lru = &bh_lrus[get_cpu()];
+	spin_lock(&lru->lock);
+	if (lru->bhs[0] != bh) {
+		struct buffer_head *bhs[BH_LRU_SIZE];
+		int in;
+		int out = 0;
+
+		get_bh(bh);
+		bhs[out++] = bh;
+		for (in = 0; in < BH_LRU_SIZE; in++) {
+			struct buffer_head *bh2 = lru->bhs[in];
+
+			if (bh2 == bh) {
+				__brelse(bh2);
+			} else {
+				if (out >= BH_LRU_SIZE) {
+					BUG_ON(evictee != NULL);
+					evictee = bh2;
+				} else {
+					bhs[out++] = bh2;
+				}
+			}
+		}
+		while (out < BH_LRU_SIZE)
+			bhs[out++] = NULL;
+		memcpy(lru->bhs, bhs, sizeof(bhs));
+	}
+	spin_unlock(&lru->lock);
+	put_cpu();
+
+	if (evictee) {
+		touch_buffer(evictee);
+		__brelse(evictee);
+	}
+}
+
+static inline struct buffer_head *
+lookup_bh(struct block_device *bdev, sector_t block, int size)
+{
+	struct buffer_head *ret = NULL;
+	struct bh_lru *lru;
+	int i;
+
+	lru = &bh_lrus[get_cpu()];
+	spin_lock(&lru->lock);
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		struct buffer_head *bh = lru->bhs[i];
+
+		if (bh && bh->b_bdev == bdev &&
+				bh->b_blocknr == block && bh->b_size == size) {
+			if (i) {
+				while (i) {
+					lru->bhs[i] = lru->bhs[i - 1];
+					i--;
+				}
+				lru->bhs[0] = bh;
+			}
+			get_bh(bh);
+			ret = bh;
+			break;
+		}
+	}
+	spin_unlock(&lru->lock);
+	put_cpu();
+	return ret;
+}
+
+struct buffer_head *
+__find_get_block(struct block_device *bdev, sector_t block, int size)
+{
+	struct buffer_head *bh = lookup_bh(bdev, block, size);
+
+	if (bh == NULL) {
+		bh = __find_get_block_slow(bdev, block, size);
+		bh_lru_install(bh);
+	}
+	return bh;
+}
+EXPORT_SYMBOL(__find_get_block);
+
+struct buffer_head *
+__getblk(struct block_device *bdev, sector_t block, int size)
+{
+	struct buffer_head *bh = __find_get_block(bdev, block, size);
+
+	if (bh == NULL) {
+		bh = __getblk_slow(bdev, block, size);
+		bh_lru_install(bh);
+	}
+	return bh;
+}
+EXPORT_SYMBOL(__getblk);
+
+struct buffer_head *
+__bread(struct block_device *bdev, sector_t block, int size)
+{
+	struct buffer_head *bh = __getblk(bdev, block, size);
+
+	if (bh) {
+		if (buffer_uptodate(bh))
+			return bh;
+		__brelse(bh);
+	}
+	bh = __bread_slow(bdev, block, size);
+	bh_lru_install(bh);
+	return bh;
+}
+EXPORT_SYMBOL(__bread);
+
+/*
+ * This is called rarely - at unmount.
+ */
+static void invalidate_bh_lrus(void)
+{
+	int cpu_idx;
+
+	for (cpu_idx = 0; cpu_idx < NR_CPUS; cpu_idx++)
+		spin_lock(&bh_lrus[cpu_idx].lock);
+	for (cpu_idx = 0; cpu_idx < NR_CPUS; cpu_idx++) {
+		int i;
+
+		for (i = 0; i < BH_LRU_SIZE; i++) {
+			brelse(bh_lrus[cpu_idx].bhs[i]);
+			bh_lrus[cpu_idx].bhs[i] = NULL;
+		}
+	}
+	for (cpu_idx = 0; cpu_idx < NR_CPUS; cpu_idx++)
+		spin_unlock(&bh_lrus[cpu_idx].lock);
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
@@ -2435,6 +2598,9 @@ void __init buffer_init(void)
 {
 	int i;
 
+	for (i = 0; i < NR_CPUS; i++)
+		spin_lock_init(&bh_lrus[i].lock);
+
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
 			SLAB_HWCACHE_ALIGN, init_buffer_head, NULL);
--- 2.5.24/include/linux/buffer_head.h~bh-lrus	Thu Jul  4 16:17:07 2002
+++ 2.5.24-akpm/include/linux/buffer_head.h	Thu Jul  4 16:17:07 2002
@@ -164,7 +164,7 @@ struct buffer_head *__find_get_block(str
 struct buffer_head * __getblk(struct block_device *, sector_t, int);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
-struct buffer_head * __bread(struct block_device *, int, int);
+struct buffer_head *__bread(struct block_device *, sector_t block, int size);
 void wakeup_bdflush(void);
 struct buffer_head *alloc_buffer_head(void);
 void free_buffer_head(struct buffer_head * bh);
@@ -201,9 +201,9 @@ int generic_osync_inode(struct inode *, 
  * inline definitions
  */
 
-static inline void get_bh(struct buffer_head * bh)
+static inline void get_bh(struct buffer_head *bh)
 {
-        atomic_inc(&(bh)->b_count);
+        atomic_inc(&bh->b_count);
 }
 
 static inline void put_bh(struct buffer_head *bh)
@@ -212,68 +212,49 @@ static inline void put_bh(struct buffer_
         atomic_dec(&bh->b_count);
 }
 
-/*
- * If an error happens during the make_request, this function
- * has to be recalled. It marks the buffer as clean and not
- * uptodate, and it notifys the upper layer about the end
- * of the I/O.
- */
-static inline void buffer_IO_error(struct buffer_head * bh)
-{
-	clear_buffer_dirty(bh);
-
-	/*
-	 * b_end_io has to clear the BH_Uptodate bitflag in the read error
-	 * case, however buffer contents are not necessarily bad if a
-	 * write fails
-	 */
-	bh->b_end_io(bh, buffer_uptodate(bh));
-}
-
-
-static inline void brelse(struct buffer_head *buf)
+static inline void brelse(struct buffer_head *bh)
 {
-	if (buf)
-		__brelse(buf);
+	if (bh)
+		__brelse(bh);
 }
 
-static inline void bforget(struct buffer_head *buf)
+static inline void bforget(struct buffer_head *bh)
 {
-	if (buf)
-		__bforget(buf);
+	if (bh)
+		__bforget(bh);
 }
 
-static inline struct buffer_head * sb_bread(struct super_block *sb, int block)
+static inline struct buffer_head *sb_bread(struct super_block *sb, sector_t block)
 {
 	return __bread(sb->s_bdev, block, sb->s_blocksize);
 }
 
-static inline struct buffer_head * sb_getblk(struct super_block *sb, int block)
+static inline struct buffer_head *sb_getblk(struct super_block *sb, sector_t block)
 {
 	return __getblk(sb->s_bdev, block, sb->s_blocksize);
 }
 
 static inline struct buffer_head *
-sb_find_get_block(struct super_block *sb, int block)
+sb_find_get_block(struct super_block *sb, sector_t block)
 {
 	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
 }
 
 static inline void
-map_bh(struct buffer_head *bh, struct super_block *sb, int block)
+map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
 	set_buffer_mapped(bh);
 	bh->b_bdev = sb->s_bdev;
 	bh->b_blocknr = block;
 }
 
-static inline void wait_on_buffer(struct buffer_head * bh)
+static inline void wait_on_buffer(struct buffer_head *bh)
 {
 	if (buffer_locked(bh))
 		__wait_on_buffer(bh);
 }
 
-static inline void lock_buffer(struct buffer_head * bh)
+static inline void lock_buffer(struct buffer_head *bh)
 {
 	while (test_set_buffer_locked(bh))
 		__wait_on_buffer(bh);
--- 2.5.24/kernel/ksyms.c~bh-lrus	Thu Jul  4 16:17:07 2002
+++ 2.5.24-akpm/kernel/ksyms.c	Thu Jul  4 16:22:11 2002
@@ -196,14 +196,12 @@ EXPORT_SYMBOL(notify_change);
 EXPORT_SYMBOL(set_blocksize);
 EXPORT_SYMBOL(sb_set_blocksize);
 EXPORT_SYMBOL(sb_min_blocksize);
-EXPORT_SYMBOL(__getblk);
 EXPORT_SYMBOL(cdget);
 EXPORT_SYMBOL(cdput);
 EXPORT_SYMBOL(bdget);
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bd_claim);
 EXPORT_SYMBOL(bd_release);
-EXPORT_SYMBOL(__bread);
 EXPORT_SYMBOL(__brelse);
 EXPORT_SYMBOL(__bforget);
 EXPORT_SYMBOL(ll_rw_block);
@@ -549,7 +547,6 @@ EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(fsync_buffers_list);
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(__find_get_block);
 EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(__insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);

-
