Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSEXINA>; Fri, 24 May 2002 04:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSEXIM7>; Fri, 24 May 2002 04:12:59 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:62702 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317114AbSEXIM4>; Fri, 24 May 2002 04:12:56 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 24 May 2002 02:10:43 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: negative dentries wasting ram
Message-ID: <20020524081043.GB9485@turbolinux.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20020524071657.GI21164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2002  09:16 +0200, Andrea Arcangeli wrote:
> I actually noticed that after an unlink the dentry wasn't released (the
> inode was released the dentry wasn't). At first I thought it was a bug,
> then while reading the code I noticed this is intentional.

The benefits of negative dentries are also there, although in some cases
(such as with many thousands of use-once files are deleted) the drawbacks
probably outweigh the benefits.  The benefits are that the VFS does not
need to do _very_slow_ access to the filesystem (=disk) when resolving
executables in the PATH or dynamic libraries in ld.so.

What I did to fix this problem was to put negative dentries at the end of
the dentry_unused list and not mark them referenced until the second time
they are used.  This allows these unused negative dentries to be reaped
easily, even if we are under memory pressure from a non-GFP_FS allocator
(which would otherwise not allow the dcache to be scanned because of
deadlock problems).

Otherwise, these dentries must go through the LRU twice before they
are freed (once to clear referenced flag, again to get to the end of
the list).  The old code also didn't allow pruning any dentries under
a non-GFP_FS allocator, so you couldn't free these dentries at the time
you need to free them.

The patch I've had in my tree for a long time is below.  In my testing
at the time I wrote this patch, it didn't totally eliminate dentry
cache growth, but it did cap it at a reasonable level (i.e. when memory
pressure started up the dcache was shrunk until it held a steady size).

We might concievably want to continue scanning the dentry_unused list
even after we hit an in-use dentry, rather than bailing out as my
patch does.  It would probably just mean doing list_for_each_prev()
and skipping in-use entries (but leaving them at the end of the list)
when __GFP_FS is not set, maybe until we have skipped up to 'count'
active dentries.  Even so, the new behaviour is still better than the old
one when GFP_FS is not set, because it used to never try to drop dentries
at all in that case.

Cheers, Andreas
====================== dcache-2.4.18-negative.diff ======================
--- linux-2.4.18.orig/fs/dcache.c	Wed Feb 27 10:31:58 2002
+++ linux-2.4.18-aed/fs/dcache.c	Fri May 24 01:52:03 2002
@@ -137,7 +137,16 @@ repeat:
 	/* Unreachable? Get rid of it */
 	if (list_empty(&dentry->d_hash))
 		goto kill_it;
-	list_add(&dentry->d_lru, &dentry_unused);
+	if (dentry->d_inode) {
+		list_add(&dentry->d_lru, &dentry_unused);
+	} else {
+		/* Put an unused negative inode to the end of the list.  If it
+		 * is not referenced again before we need to free some memory,
+		 * it will be the first to be freed.
+		 */
+		dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+		list_add_tail(&dentry->d_lru, &dentry_unused);
+	}
 	dentry_stat.nr_unused++;
 	spin_unlock(&dcache_lock);
 	return;
@@ -306,8 +315,9 @@ static inline void prune_one_dentry(stru
 }
 
 /**
- * prune_dcache - shrink the dcache
+ * _prune_dcache - shrink the dcache
  * @count: number of entries to try and free
+ * @gfp_mask: context under which we are trying to free memory
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -318,7 +328,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-void prune_dcache(int count)
+void _prune_dcache(int count, unsigned int gfp_mask)
 {
 	spin_lock(&dcache_lock);
 	for (;;) {
@@ -329,15 +339,40 @@ void prune_dcache(int count)
 
 		if (tmp == &dentry_unused)
 			break;
-		list_del_init(tmp);
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
+			list_del_init(tmp);
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
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
+		 *
+		 * It is safe to call prune_one_dentry() on a negative dentry
+		 * even with GFP_FS, because dentry_iput() is a no-op in this
+		 * case, and no chance of calling into the filesystem.
+		 *
+		 * I'm not sure if the d_release check is necessary to avoid
+		 * deadlock in d_free(), but better to be safe for now.
+		 */
+		if (((dentry->d_op && dentry->d_op->d_release) ||
+		     dentry->d_inode) && !(gfp_mask & __GFP_FS))
+			break;
+
+		list_del_init(tmp);
 		dentry_stat.nr_unused--;
 
 		/* Unused dentry with a count? */
@@ -351,6 +386,11 @@ void prune_dcache(int count)
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
@@ -543,32 +583,17 @@ void shrink_dcache_parent(struct dentry 
  * too much.
  *
  * Priority:
- *   0 - very urgent: shrink everything
+ *   1 - very urgent: shrink everything
  *  ...
  *   6 - base-level: try to shrink a bit.
  */
 int shrink_dcache_memory(int priority, unsigned int gfp_mask)
 {
-	int count = 0;
-
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
-		return 0;
-
-	count = dentry_stat.nr_unused / priority;
+	int count = dentry_stat.nr_unused / priority;
 
-	prune_dcache(count);
+	_prune_dcache(count, gfp_mask);
 	kmem_cache_shrink(dentry_cache);
+
 	return 0;
 }
 
@@ -590,8 +615,15 @@ struct dentry * d_alloc(struct dentry * 
 	struct dentry *dentry;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
-	if (!dentry)
-		return NULL;
+	if (!dentry) {
+		/* Try to free some unused dentries from the cache, but do
+		 * not call into the filesystem to do so (avoid deadlock).
+		 */
+		_prune_dcache(16, GFP_NOFS);
+		dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+		if (!dentry)
+			return NULL;
+	}
 
 	if (name->len > DNAME_INLINE_LEN-1) {
 		str = kmalloc(NAME_ALLOC_LEN(name->len), GFP_KERNEL);
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

