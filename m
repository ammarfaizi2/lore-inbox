Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289370AbSAJKGS>; Thu, 10 Jan 2002 05:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289371AbSAJKGA>; Thu, 10 Jan 2002 05:06:00 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:62192 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289370AbSAJKFp>;
	Thu, 10 Jan 2002 05:05:45 -0500
Date: Thu, 10 Jan 2002 03:05:38 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Cc: Bruce Guenter <bruceg@em.ca>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Where's all my memory going?
Message-ID: <20020110030537.C771@lynx.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Bruce Guenter <bruceg@em.ca>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020110024520.A29045@em.ca>; from bruceg@em.ca on Thu, Jan 10, 2002 at 02:45:20AM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10, 2002  02:45 -0600, Bruce Guenter wrote:
> On Wed, Jan 09, 2002 at 08:36:13PM -0200, Rik van Riel wrote:
> > Matt's system seems to go from 900 MB free to about
> > 300 MB (free + cache).
> > 
> > I doubt qmail would eat 600 MB of RAM (it might, I
> > just doubt it) so I'm curious where the RAM is going.
> 
> I am seeing the same symptoms, with similar use -- ext3 filesystems
> running qmail.

Hmm, does qmail put each piece of email is in a separate file?  That
might explain a lot about what is going on here.

> Adding up the RSS of all the processes in use gives
> about 75MB, while free shows:
> 
>              total       used       free     shared    buffers     cached
> Mem:        901068     894088       6980          0     157568     113856
> -/+ buffers/cache:     622664     278404
> Swap:      1028152      10468    1017684
> 
> This are fairly consistent numbers.  buffers hovers around 150MB and
> cached around 110MB all day.  The server is heavy on write traffic.
> 
> > Matt, do you see any suspiciously high numbers in
> > /proc/slabinfo ?
> 
> What would be suspiciously high?  The four biggest numbers I see are:
> 
> inode_cache       139772 204760    480 25589 25595    1
> dentry_cache      184024 326550    128 10885 10885    1
> buffer_head       166620 220480     96 4487 5512    1
> size-64           102388 174876     64 2964 2964    1

Well, these numbers _are_ high, but with 1GB of RAM you have to use it all
_somewhere_.  It looks like you don't have much memory pressure, because
there is lots of free space in these slabs that could probably be freed
easily.

I'm thinking that if you get _lots_ of dentry and inode items (especially
under the "postal" benchmark) you may not be able to free the negative
dentries for all of the created/deleted files in the mailspool (all of
which will have unique names).  There is a deadlock path in the VM that
has to be avoided, and as a result it makes it harder to free dentries
under certain uncommon loads.

I had a "use once" patch for negative dentries that allowed the VM to
free negative dentries easily if they are never referenced again.  It
is a bit old, but it should be pretty close to applying.  I have been
using it for months without problems (although I don't really stress
it very much in this regard).

The other question would of course be whether we are calling into
shrink_dcache_memory() enough, but that is an issue for Matt to
see by testing "postal" with and without the patch, and keeping an
eye on the slab caches.

Cheers, Andreas
======================= dcache-2.4.13-neg.diff ============================
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
+		/* Put an unused negative inode to the end of the list.
+		 * If it is not referenced again before we need to free some
+		 * memory, it will be the first to be freed.
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
 
@@ -590,8 +607,15 @@
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
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

