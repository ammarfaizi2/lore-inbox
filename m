Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVAMKrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVAMKrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVAMKpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:45:07 -0500
Received: from mail.suse.de ([195.135.220.2]:61078 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261563AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 3/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.808497@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Race in ext[23] xattr sharing code

Andrew Tridgell and Stephen C. Tweedie have reported two different
Oopses caused by a race condition in the mbcache, which is responsible
for extended attribute sharing in ext2 and ext3.  Stephen tracked down
the bug; I did the fix.

Explanation: 
The mbcache caches the locations and content hashes of xattr blocks.
There are two access strategies: [1] xattr block disposal via
mb_cache_entry_get(), [2] xattr block reuse (sharing) via
mb_cache_entry_find_{first,next}().  There is no locking between the two
methods, so between one mb_cache_entry_find_x and the next, a
mb_cache_entry_get might come in, unhash the cache entry, and change the
journaling state of the xattr buffer.  Subsequently, two things can
happen: [a] the next mb_cache_entry_find_x may try to follow the mbcache
hash chain starting from the entry that has become unhashed, which now
is a stale pointer, [b] the block may have become deallocated, and then
we try to reuse it. 

Fix this by converting the mbcache into a readers-writer style lock, and
protect all block accesses in ext2/ext3 by the mbcache entry lock.  This
ensures that destroying blocks is an exclusive operation that may not
overlap xattr block reuse, while allowing multiple "re-users".  Write
access to the xattr block's buffer is protected by the buffer lock. 

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/mbcache.c
===================================================================
--- linux-2.6.10.orig/fs/mbcache.c
+++ linux-2.6.10/fs/mbcache.c
@@ -54,6 +54,10 @@
 		printk(KERN_ERR f); \
 		printk("\n"); \
 	} while(0)
+
+#define MB_CACHE_WRITER ((unsigned short)~0U >> 1)
+
+DECLARE_WAIT_QUEUE_HEAD(mb_cache_queue);
 		
 MODULE_AUTHOR("Andreas Gruenbacher <a.gruenbacher@computer.org>");
 MODULE_DESCRIPTION("Meta block cache (for extended attributes)");
@@ -140,7 +144,7 @@ __mb_cache_entry_forget(struct mb_cache_
 {
 	struct mb_cache *cache = ce->e_cache;
 
-	mb_assert(atomic_read(&ce->e_used) == 0);
+	mb_assert(!(ce->e_used || ce->e_queued));
 	if (cache->c_op.free && cache->c_op.free(ce, gfp_mask)) {
 		/* free failed -- put back on the lru list
 		   for freeing later. */
@@ -157,9 +161,16 @@ __mb_cache_entry_forget(struct mb_cache_
 static inline void
 __mb_cache_entry_release_unlock(struct mb_cache_entry *ce)
 {
-	if (atomic_dec_and_test(&ce->e_used)) {
+	/* Wake up all processes queuing for this cache entry. */
+	if (ce->e_queued)
+		wake_up_all(&mb_cache_queue);
+	if (ce->e_used >= MB_CACHE_WRITER)
+		ce->e_used -= MB_CACHE_WRITER;
+	ce->e_used--;
+	if (!(ce->e_used || ce->e_queued)) {
 		if (!__mb_cache_entry_is_hashed(ce))
 			goto forget;
+		mb_assert(list_empty(&ce->e_lru_list));
 		list_add_tail(&ce->e_lru_list, &mb_cache_lru_list);
 	}
 	spin_unlock(&mb_cache_spinlock);
@@ -396,7 +407,8 @@ mb_cache_entry_alloc(struct mb_cache *ca
 		INIT_LIST_HEAD(&ce->e_lru_list);
 		INIT_LIST_HEAD(&ce->e_block_list);
 		ce->e_cache = cache;
-		atomic_set(&ce->e_used, 1);
+		ce->e_used = 1 + MB_CACHE_WRITER;
+		ce->e_queued = 0;
 	}
 	return ce;
 }
@@ -488,7 +500,8 @@ mb_cache_entry_free(struct mb_cache_entr
  *
  * Get a cache entry  by device / block number. (There can only be one entry
  * in the cache per device and block.) Returns NULL if no such cache entry
- * exists.
+ * exists. The returned cache entry is locked for exclusive access ("single
+ * writer").
  */
 struct mb_cache_entry *
 mb_cache_entry_get(struct mb_cache *cache, struct block_device *bdev,
@@ -504,9 +517,27 @@ mb_cache_entry_get(struct mb_cache *cach
 	list_for_each(l, &cache->c_block_hash[bucket]) {
 		ce = list_entry(l, struct mb_cache_entry, e_block_list);
 		if (ce->e_bdev == bdev && ce->e_block == block) {
+			DEFINE_WAIT(wait);
+
 			if (!list_empty(&ce->e_lru_list))
 				list_del_init(&ce->e_lru_list);
-			atomic_inc(&ce->e_used);
+
+			while (ce->e_used > 0) {
+				ce->e_queued++;
+				prepare_to_wait(&mb_cache_queue, &wait,
+						TASK_UNINTERRUPTIBLE);
+				spin_unlock(&mb_cache_spinlock);
+				schedule();
+				spin_lock(&mb_cache_spinlock);
+				ce->e_queued--;
+			}
+			finish_wait(&mb_cache_queue, &wait);
+			ce->e_used += 1 + MB_CACHE_WRITER;
+			
+			if (!__mb_cache_entry_is_hashed(ce)) {
+				__mb_cache_entry_release_unlock(ce);
+				return NULL;
+			}
 			goto cleanup;
 		}
 	}
@@ -523,14 +554,37 @@ static struct mb_cache_entry *
 __mb_cache_entry_find(struct list_head *l, struct list_head *head,
 		      int index, struct block_device *bdev, unsigned int key)
 {
+	DEFINE_WAIT(wait);
+
 	while (l != head) {
 		struct mb_cache_entry *ce =
 			list_entry(l, struct mb_cache_entry,
 			           e_indexes[index].o_list);
 		if (ce->e_bdev == bdev && ce->e_indexes[index].o_key == key) {
+			DEFINE_WAIT(wait);
+
 			if (!list_empty(&ce->e_lru_list))
 				list_del_init(&ce->e_lru_list);
-			atomic_inc(&ce->e_used);
+
+			/* Incrementing before holding the lock gives readers
+			   priority over writers. */
+			ce->e_used++;
+			while (ce->e_used >= MB_CACHE_WRITER) {
+				ce->e_queued++;
+				prepare_to_wait(&mb_cache_queue, &wait,
+						TASK_UNINTERRUPTIBLE);
+				spin_unlock(&mb_cache_spinlock);
+				schedule();
+				spin_lock(&mb_cache_spinlock);
+				ce->e_queued--;
+			}
+			finish_wait(&mb_cache_queue, &wait);
+			
+			if (!__mb_cache_entry_is_hashed(ce)) {
+				__mb_cache_entry_release_unlock(ce);
+				spin_lock(&mb_cache_spinlock);
+				return ERR_PTR(-EAGAIN);
+			}
 			return ce;
 		}
 		l = l->next;
@@ -544,7 +598,8 @@ __mb_cache_entry_find(struct list_head *
  *
  * Find the first cache entry on a given device with a certain key in
  * an additional index. Additonal matches can be found with
- * mb_cache_entry_find_next(). Returns NULL if no match was found.
+ * mb_cache_entry_find_next(). Returns NULL if no match was found. The
+ * returned cache entry is locked for shared access ("multiple readers").
  *
  * @cache: the cache to search
  * @index: the number of the additonal index to search (0<=index<indexes_count)
Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c
+++ linux-2.6.10/fs/ext3/xattr.c
@@ -97,7 +97,6 @@ static int ext3_xattr_cache_insert(struc
 static struct buffer_head *ext3_xattr_cache_find(handle_t *, struct inode *,
 						 struct ext3_xattr_header *,
 						 int *);
-static void ext3_xattr_cache_remove(struct buffer_head *);
 static void ext3_xattr_rehash(struct ext3_xattr_header *,
 			      struct ext3_xattr_entry *);
 
@@ -500,6 +499,7 @@ bad_block:		ext3_error(sb, "ext3_xattr_s
 	/* Here we know that we can set the new attribute. */
 
 	if (header) {
+		struct mb_cache_entry *ce;
 		int credits = 0;
 
 		/* assert(header == HDR(bh)); */
@@ -511,14 +511,19 @@ bad_block:		ext3_error(sb, "ext3_xattr_s
 							      &credits);
 		if (error)
 			goto cleanup;
+		ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev,
+					bh->b_blocknr);
 		lock_buffer(bh);
 		if (header->h_refcount == cpu_to_le32(1)) {
+			if (ce)
+				mb_cache_entry_free(ce);
 			ea_bdebug(bh, "modifying in-place");
-			ext3_xattr_cache_remove(bh);
 			/* keep the buffer locked while modifying it. */
 		} else {
 			int offset;
 
+			if (ce)
+				mb_cache_entry_release(ce);
 			unlock_buffer(bh);
 			journal_release_buffer(handle, bh, credits);
 		skip_get_write_access:
@@ -725,6 +730,8 @@ getblk_failed:
 
 	error = 0;
 	if (old_bh && old_bh != new_bh) {
+		struct mb_cache_entry *ce;
+
 		/*
 		 * If there was an old block, and we are no longer using it,
 		 * release the old block.
@@ -732,9 +739,13 @@ getblk_failed:
 		error = ext3_journal_get_write_access(handle, old_bh);
 		if (error)
 			goto cleanup;
+		ce = mb_cache_entry_get(ext3_xattr_cache, old_bh->b_bdev,
+					old_bh->b_blocknr);
 		lock_buffer(old_bh);
 		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
 			/* Free the old block. */
+			if (ce)
+				mb_cache_entry_free(ce);
 			ea_bdebug(old_bh, "freeing");
 			ext3_free_blocks(handle, inode, old_bh->b_blocknr, 1);
 
@@ -747,6 +758,8 @@ getblk_failed:
 			/* Decrement the refcount only. */
 			HDR(old_bh)->h_refcount = cpu_to_le32(
 				le32_to_cpu(HDR(old_bh)->h_refcount) - 1);
+			if (ce)
+				mb_cache_entry_release(ce);
 			DQUOT_FREE_BLOCK(inode, 1);
 			ext3_journal_dirty_metadata(handle, old_bh);
 			ea_bdebug(old_bh, "refcount now=%d",
@@ -806,6 +819,7 @@ void
 ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
 {
 	struct buffer_head *bh = NULL;
+	struct mb_cache_entry *ce;
 
 	down_write(&EXT3_I(inode)->xattr_sem);
 	if (!EXT3_I(inode)->i_file_acl)
@@ -826,15 +840,19 @@ ext3_xattr_delete_inode(handle_t *handle
 	}
 	if (ext3_journal_get_write_access(handle, bh) != 0)
 		goto cleanup;
+	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev, bh->b_blocknr);
 	lock_buffer(bh);
 	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
-		ext3_xattr_cache_remove(bh);
+		if (ce)
+			mb_cache_entry_free(ce);
 		ext3_free_blocks(handle, inode, EXT3_I(inode)->i_file_acl, 1);
 		get_bh(bh);
 		ext3_forget(handle, 1, inode, bh, EXT3_I(inode)->i_file_acl);
 	} else {
 		HDR(bh)->h_refcount = cpu_to_le32(
 			le32_to_cpu(HDR(bh)->h_refcount) - 1);
+		if (ce)
+			mb_cache_entry_release(ce);
 		ext3_journal_dirty_metadata(handle, bh);
 		if (IS_SYNC(inode))
 			handle->h_sync = 1;
@@ -951,11 +969,18 @@ ext3_xattr_cache_find(handle_t *handle, 
 	if (!header->h_hash)
 		return NULL;  /* never share */
 	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
+again:
 	ce = mb_cache_entry_find_first(ext3_xattr_cache, 0,
 				       inode->i_sb->s_bdev, hash);
 	while (ce) {
-		struct buffer_head *bh = sb_bread(inode->i_sb, ce->e_block);
+		struct buffer_head *bh;
 
+		if (IS_ERR(ce)) {
+			if (PTR_ERR(ce) == -EAGAIN)
+				goto again;
+			break;
+		}
+		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext3_error(inode->i_sb, "ext3_xattr_cache_find",
 				"inode %ld: block %ld read error",
@@ -986,27 +1011,6 @@ ext3_xattr_cache_find(handle_t *handle, 
 	return NULL;
 }
 
-/*
- * ext3_xattr_cache_remove()
- *
- * Remove the cache entry of a block from the cache. Called when a
- * block becomes invalid.
- */
-static void
-ext3_xattr_cache_remove(struct buffer_head *bh)
-{
-	struct mb_cache_entry *ce;
-
-	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev,
-				bh->b_blocknr);
-	if (ce) {
-		ea_bdebug(bh, "removing (%d cache entries remaining)",
-			  atomic_read(&ext3_xattr_cache->c_entry_count)-1);
-		mb_cache_entry_free(ce);
-	} else 
-		ea_bdebug(bh, "no cache entry");
-}
-
 #define NAME_HASH_SHIFT 5
 #define VALUE_HASH_SHIFT 16
 
Index: linux-2.6.10/include/linux/mbcache.h
===================================================================
--- linux-2.6.10.orig/include/linux/mbcache.h
+++ linux-2.6.10/include/linux/mbcache.h
@@ -10,7 +10,8 @@
 struct mb_cache_entry {
 	struct list_head		e_lru_list;
 	struct mb_cache			*e_cache;
-	atomic_t			e_used;
+	unsigned short			e_used;
+	unsigned short			e_queued;
 	struct block_device		*e_bdev;
 	sector_t			e_block;
 	struct list_head		e_block_list;
Index: linux-2.6.10/fs/ext2/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext2/xattr.c
+++ linux-2.6.10/fs/ext2/xattr.c
@@ -95,7 +95,6 @@ static int ext2_xattr_set2(struct inode 
 static int ext2_xattr_cache_insert(struct buffer_head *);
 static struct buffer_head *ext2_xattr_cache_find(struct inode *,
 						 struct ext2_xattr_header *);
-static void ext2_xattr_cache_remove(struct buffer_head *);
 static void ext2_xattr_rehash(struct ext2_xattr_header *,
 			      struct ext2_xattr_entry *);
 
@@ -494,15 +493,22 @@ bad_block:		ext2_error(sb, "ext2_xattr_s
 	/* Here we know that we can set the new attribute. */
 
 	if (header) {
+		struct mb_cache_entry *ce;
+
 		/* assert(header == HDR(bh)); */
+		ce = mb_cache_entry_get(ext2_xattr_cache, bh->b_bdev,
+					bh->b_blocknr);
 		lock_buffer(bh);
 		if (header->h_refcount == cpu_to_le32(1)) {
 			ea_bdebug(bh, "modifying in-place");
-			ext2_xattr_cache_remove(bh);
+			if (ce)
+				mb_cache_entry_free(ce);
 			/* keep the buffer locked while modifying it. */
 		} else {
 			int offset;
 
+			if (ce)
+				mb_cache_entry_release(ce);
 			unlock_buffer(bh);
 			ea_bdebug(bh, "cloning");
 			header = kmalloc(bh->b_size, GFP_KERNEL);
@@ -707,13 +713,19 @@ ext2_xattr_set2(struct inode *inode, str
 
 	error = 0;
 	if (old_bh && old_bh != new_bh) {
+		struct mb_cache_entry *ce;
+
 		/*
 		 * If there was an old block and we are no longer using it,
 		 * release the old block.
 		 */
+		ce = mb_cache_entry_get(ext2_xattr_cache, old_bh->b_bdev,
+					old_bh->b_blocknr);
 		lock_buffer(old_bh);
 		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
 			/* Free the old block. */
+			if (ce)
+				mb_cache_entry_free(ce);
 			ea_bdebug(old_bh, "freeing");
 			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
 			/* We let our caller release old_bh, so we
@@ -724,6 +736,8 @@ ext2_xattr_set2(struct inode *inode, str
 			/* Decrement the refcount only. */
 			HDR(old_bh)->h_refcount = cpu_to_le32(
 				le32_to_cpu(HDR(old_bh)->h_refcount) - 1);
+			if (ce)
+				mb_cache_entry_release(ce);
 			DQUOT_FREE_BLOCK(inode, 1);
 			mark_buffer_dirty(old_bh);
 			ea_bdebug(old_bh, "refcount now=%d",
@@ -748,6 +762,7 @@ void
 ext2_xattr_delete_inode(struct inode *inode)
 {
 	struct buffer_head *bh = NULL;
+	struct mb_cache_entry *ce;
 
 	down_write(&EXT2_I(inode)->xattr_sem);
 	if (!EXT2_I(inode)->i_file_acl)
@@ -767,15 +782,19 @@ ext2_xattr_delete_inode(struct inode *in
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
+	ce = mb_cache_entry_get(ext2_xattr_cache, bh->b_bdev, bh->b_blocknr);
 	lock_buffer(bh);
 	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
-		ext2_xattr_cache_remove(bh);
+		if (ce)
+			mb_cache_entry_free(ce);
 		ext2_free_blocks(inode, EXT2_I(inode)->i_file_acl, 1);
 		get_bh(bh);
 		bforget(bh);
 	} else {
 		HDR(bh)->h_refcount = cpu_to_le32(
 			le32_to_cpu(HDR(bh)->h_refcount) - 1);
+		if (ce)
+			mb_cache_entry_release(ce);
 		mark_buffer_dirty(bh);
 		if (IS_SYNC(inode))
 			sync_dirty_buffer(bh);
@@ -892,11 +911,19 @@ ext2_xattr_cache_find(struct inode *inod
 	if (!header->h_hash)
 		return NULL;  /* never share */
 	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
+again:
 	ce = mb_cache_entry_find_first(ext2_xattr_cache, 0,
 				       inode->i_sb->s_bdev, hash);
 	while (ce) {
-		struct buffer_head *bh = sb_bread(inode->i_sb, ce->e_block);
+		struct buffer_head *bh;
+		
+		if (IS_ERR(ce)) {
+			if (PTR_ERR(ce) == -EAGAIN)
+				goto again;
+			break;
+		}
 
+		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
 				"inode %ld: block %ld read error",
@@ -923,26 +950,6 @@ ext2_xattr_cache_find(struct inode *inod
 	return NULL;
 }
 
-/*
- * ext2_xattr_cache_remove()
- *
- * Remove the cache entry of a block from the cache. Called when a
- * block becomes invalid.
- */
-static void
-ext2_xattr_cache_remove(struct buffer_head *bh)
-{
-	struct mb_cache_entry *ce;
-
-	ce = mb_cache_entry_get(ext2_xattr_cache, bh->b_bdev, bh->b_blocknr);
-	if (ce) {
-		ea_bdebug(bh, "removing (%d cache entries remaining)",
-			  atomic_read(&ext2_xattr_cache->c_entry_count)-1);
-		mb_cache_entry_free(ce);
-	} else 
-		ea_bdebug(bh, "no cache entry");
-}
-
 #define NAME_HASH_SHIFT 5
 #define VALUE_HASH_SHIFT 16
 
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

