Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268907AbRHBXbG>; Thu, 2 Aug 2001 19:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268874AbRHBXar>; Thu, 2 Aug 2001 19:30:47 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36604 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268907AbRHBXaj>; Thu, 2 Aug 2001 19:30:39 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108022330.f72NU4OE028731@webber.adilger.int>
Subject: [PATCH][RFC] free unused negative dentries early
To: Linux kernel development list <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com
Date: Thu, 2 Aug 2001 17:30:03 -0600 (MDT)
CC: Brian Ristuccia <bristuccia@starentnetworks.com>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to free unused negative dentries early by putting them
at the tail of the dentry_unused list in an unreferenced state, rather
than at the head in a referenced state.  If they are later referenced
before prune_dcache() tries to reap them, they are moved to the head
of the list, so they will stay around for a longer time, otherwise
they are reaped quite quickly.

I tested with trying creating a sequence of unique files in a directory
I don't have write permission to.  The net result is about 25% fewer
cached negative dentries (300k vs. 400k) at steady state (after 1M+
file creation attempts).  I wasn't trying very hard to use up memory,
just testing that nothing terrible happened.

This still isn't _great_, because it still means that we have too much
memory tied up in the dentry cache, but that is an issue of trying to
free unused dentries more often, and is orthogonal to the problem of
used-once negative dentries polluting the cache.  The current code
also isn't ideal in that the negative unused dentries are not on the
list in LRU order, but since we don't prune the list very often there
is a good chance they will be referenced if actually needed.

I had looked at implementing two lists as Linus suggested, but then
there is the issue of moving dentries from one list to another (if a
file is later created), and also freeing items from both lists when
pruning directories, etc.

This patch also changes two other minor areas:
1) it allows non __GFP_IO requests to prune the dentry cache as long
   as they are negative dentries only (no calls into fs to deadlock)
2) instead of returning NULL if kmem_cache_alloc() fails to allocate
   a dentry for us, we try to prune the dcache first

Comments?

Cheers, Andreas
======================  dcache-2.4.7-negative.diff  ========================
--- linux.orig/fs/dcache.c	Tue Jul 31 15:00:37 2001
+++ linux/fs/dcache.c	Thu Aug  2 17:12:52 2001
@@ -137,7 +137,16 @@
 	/* Unreachable? Get rid of it */
 	if (list_empty(&dentry->d_hash))
 		goto kill_it;
-	list_add(&dentry->d_lru, &dentry_unused);
+	if (dentry->d_inode) {
+		list_add(&dentry->d_lru, &dentry_unused);
+	} else {
+		/* Put an unused negative inode to the end of the list.  If it
+		 * is not referenced again before we need to free some memory,
+		 * it will be the first to be freed (2Q algorithm, I believe).
+		 */
+		dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+		list_add_tail(&dentry->d_lru, &dentry_unused);
+	}
 	dentry_stat.nr_unused++;
 	spin_unlock(&dcache_lock);
 	return;
@@ -306,8 +315,9 @@
 }
 
 /**
- * prune_dcache - shrink the dcache
+ * _prune_dcache - shrink the dcache
  * @count: number of entries to try and free
+ * @gfp_mask: context under which we are trying to free memory
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -318,7 +328,7 @@
  * all the dentries are in use.
  */
  
-void prune_dcache(int count)
+void _prune_dcache(int count, unsigned int gfp_mask)
 {
 	spin_lock(&dcache_lock);
 	for (;;) {
@@ -329,15 +339,32 @@
 
 		if (tmp == &dentry_unused)
 			break;
-		list_del_init(tmp);
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+			list_del_init(tmp);
 			list_add(&dentry->d_lru, &dentry_unused);
 			continue;
 		}
+
+		/*
+		 * Nasty deadlock avoidance.
+		 *
+		 * ext2_new_block->getblk->GFP->shrink_dcache_memory->
+		 * prune_dcache->prune_one_dentry->dput->dentry_iput->iput->
+		 * inode->i_sb->s_op->put_inode->ext2_discard_prealloc->
+		 * ext2_free_blocks->lock_super->DEADLOCK.
+		 *
+		 * We should make sure we don't hold the superblock lock over
+		 * block allocations, but for now we will only free unused
+		 * negative dentries (which are added at the end of the list).
+		 */
+		if (dentry->d_inode && !(gfp_mask & __GFP_FS))
+			break;
+
+		list_del_init(tmp);
 		dentry_stat.nr_unused--;
 
 		/* Unused dentry with a count? */
@@ -351,6 +378,11 @@
 	spin_unlock(&dcache_lock);
 }
 
+void prune_dcache(int count)
+{
+	_prune_dcache(count, __GFP_FS);
+}
+
 /*
  * Shrink the dcache for the specified super block.
  * This allows us to unmount a device without disturbing
@@ -551,24 +583,10 @@
 {
 	int count = 0;
 
-	/*
-	 * Nasty deadlock avoidance.
-	 *
-	 * ext2_new_block->getblk->GFP->shrink_dcache_memory->prune_dcache->
-	 * prune_one_dentry->dput->dentry_iput->iput->inode->i_sb->s_op->
-	 * put_inode->ext2_discard_prealloc->ext2_free_blocks->lock_super->
-	 * DEADLOCK.
-	 *
-	 * We should make sure we don't hold the superblock lock over
-	 * block allocations, but for now:
-	 */
-	if (!(gfp_mask & __GFP_FS))
-		return;
-
 	if (priority)
 		count = dentry_stat.nr_unused / priority;
 
-	prune_dcache(count);
+	_prune_dcache(count, gfp_mask);
 	kmem_cache_shrink(dentry_cache);
 }
 
@@ -590,8 +608,15 @@
 	struct dentry *dentry;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
-	if (!dentry)
-		return NULL;
+	if (!dentry) {
+		/* Try to free some unused dentries from the cache, but do
+		 * not call into the filesystem to do so (avoid deadlock).
+		 */
+		_prune_dcache(16, 0);
+		dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+		if (!dentry)
+			return NULL;
+	}
 
 	if (name->len > DNAME_INLINE_LEN-1) {
 		str = kmalloc(NAME_ALLOC_LEN(name->len), GFP_KERNEL);
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

