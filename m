Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKAGQG>; Thu, 1 Nov 2001 01:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278050AbRKAGP5>; Thu, 1 Nov 2001 01:15:57 -0500
Received: from [63.231.122.81] ([63.231.122.81]:2633 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278042AbRKAGPm>;
	Thu, 1 Nov 2001 01:15:42 -0500
Date: Wed, 31 Oct 2001 23:15:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Vijay Gadad <vgadad@zantaz.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Slab Allocator Leak?
Message-ID: <20011031231523.Y16554@lynx.no>
Mail-Followup-To: Vijay Gadad <vgadad@zantaz.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <12C7D768CC8ED4118A9200508BEEC6FB018C2B00@zanexch.zantaz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <12C7D768CC8ED4118A9200508BEEC6FB018C2B00@zanexch.zantaz.com>; from vgadad@zantaz.com on Wed, Oct 31, 2001 at 05:42:45PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  17:42 -0800, Vijay Gadad wrote:
> I have a script (below) which creates a file, deletes it, and loops.  In
> /proc/slabinfo, I see many dentry_cache slabs being created - to the point
> where nearly all free memory is consumed.  The system is still usable, as
> the slab allocator responds to memory pressure and releases some of these
> dentry_cache slabs.

I had created a patch a few months ago to address this problem.  It put
new negative dentries at the head of the dentry list, so if there was
memory pressure they would be freed first.

This meant that in a situation as you describe, the VM can free a large
number of negative dentries quickly, because the head of the list was
likely to contain a large number of unreferenced negative dentries, which
I changed it to allow in the __GFP_FS context (currently it can't do this
because of a potential deadlock).

The question is, is this really needed?  Maybe.  Being able to free
negative dentries from the dcache within a __GFP_FS context may be
useful under memory pressure, and can't really hurt.  Putting negative
dentries at the head of the dentry list as unreferenced _should_ be OK,
as under normal circumstances (e.g. PATH searches) you would likely
reference the negative dentry relatively quickly again, which would
put it at the end of the list when the next prune_dcache call came.

The below patch is extracted from my current kernel - I have been running
with it since I created the original patch in 2.4.7, so it is pretty safe.

Cheers, Andreas
=========================================================================
--- linux.orig/fs/dcache.c	Thu Oct 25 01:50:30 2001
+++ linux/fs/dcache.c	Thu Oct 25 00:02:58 2001
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
+		 * It is safe to call prune_one_dentry() on a negative dentry
+		 * even with GFP_FS, because dentry_iput() is a no-op in this
+		 * case, and no chance of calling into the filesystem.
+		 *
+		 * I'm not sure if the d_release check is necessary to avoid
+		 * deadlock in d_free(), but better to be safe for now.
+		 */
+		 if (((dentry->d_op && dentry->d_op->d_release) ||
+		      dentry->d_inode) && !(gfp_mask & __GFP_FS))
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
@@ -549,26 +581,11 @@
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
+	int count = dentry_stat.nr_unused / (priority + 1);
 
-	prune_dcache(count);
+	_prune_dcache(count, gfp_mask);
 	kmem_cache_shrink(dentry_cache);
+
 	return 0;
 }
 
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

