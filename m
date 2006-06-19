Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWFSBVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWFSBVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWFSBVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:21:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55718 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750910AbWFSBVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:21:14 -0400
From: Neil Brown <neilb@suse.de>
To: David Chinner <dgc@sgi.com>
Date: Mon, 19 Jun 2006 11:21:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17557.64512.496195.714144@cse.unsw.edu.au>
Cc: Jan Blunck <jblunck@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
In-Reply-To: message from David Chinner on Monday June 19
References: <20060601095125.773684000@hasse.suse.de>
	<17539.35118.103025.716435@cse.unsw.edu.au>
	<20060616155120.GA6824@hasse.suse.de>
	<17555.12234.347353.670918@cse.unsw.edu.au>
	<20060618235654.GB2114946@melbourne.sgi.com>
	<17557.61307.364404.640539@cse.unsw.edu.au>
	<20060619010013.GC2114946@melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 19, dgc@sgi.com wrote:
> 
> Ok. Send me the patch and I'll try to get some tests done on it...
> 

Below, thanks.
NeilBrown


-------------------------------------
Reduce contention in dentry_unused when unmounting.

When we unmount a filesystem we need to release all dentries.
We currently
  - move a collection of dentries to the end of the dentry_unused list
  - call prune_dcache to prune that number of dentries.

If lots of other dentries are added to the end of the list while
the prune_dcache proceeds (e.g. another filesystem is unmounted),
this can involve a lot of wasted time wandering through the
list looking for dentries that we had previously found.

This patch allows the dentry_unused list to temporarily be multiple
lists.
When unmounting, dentries that are found to require pruning are moved
to a temporary list, but accounted as though they were on dentry_unused.
Then this list is passed to prune_dcache for freeing.  Any entries
that are not pruned for whatever reason are added to the end of
dentry_unused.

Also change shrink_dcache_sb to simply call shrink_dcache_parent and
shrink_dcache_anon.  This avoids a long walk of the LRU.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c |  111 ++++++++++++++++++----------------------------------------
 1 file changed, 35 insertions(+), 76 deletions(-)

diff .prev/fs/dcache.c ./fs/dcache.c
--- .prev/fs/dcache.c	2006-06-19 11:14:02.000000000 +1000
+++ ./fs/dcache.c	2006-06-19 11:19:29.000000000 +1000
@@ -383,8 +383,8 @@ static void prune_one_dentry(struct dent
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
- * @sb: if given, ignore dentries for other superblocks
- *         which are being unmounted.
+ * @list: If given, remove from this list instead of
+ *        from dentry_unused.
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -393,11 +393,23 @@ static void prune_one_dentry(struct dent
  *
  * This function may fail to free any resources if
  * all the dentries are in use.
+ *
+ * Any dentries that were not removed due to the @count
+ * limit will be splice on to the end of dentry_unused,
+ * so they should already be founded in dentry_stat.nr_unused.
  */
  
-static void prune_dcache(int count, struct super_block *sb)
+static void prune_dcache(int count, struct list_head *list)
 {
+	int have_list = list != NULL;
+	struct list_head alt_head;
 	spin_lock(&dcache_lock);
+	if (list == NULL) {
+		/* use the dentry_unused list */
+		list_add(&alt_head, &dentry_unused);
+		list_del_init(&dentry_unused);
+		list = &alt_head;
+	}
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
@@ -405,23 +417,11 @@ static void prune_dcache(int count, stru
 
 		cond_resched_lock(&dcache_lock);
 
-		tmp = dentry_unused.prev;
-		if (unlikely(sb)) {
-			/* Try to find a dentry for this sb, but don't try
-			 * too hard, if they aren't near the tail they will
-			 * be moved down again soon
-			 */
-			int skip = count;
-			while (skip && tmp != &dentry_unused &&
-			    list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
-				skip--;
-				tmp = tmp->prev;
-			}
-		}
-		if (tmp == &dentry_unused)
+		tmp = list->prev;
+		if (tmp == list)
 			break;
 		list_del_init(tmp);
-		prefetch(dentry_unused.prev);
+		prefetch(list->prev);
  		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
@@ -454,7 +454,7 @@ static void prune_dcache(int count, stru
 		 * If this dentry is for "my" filesystem, then I can prune it
 		 * without taking the s_umount lock (I already hold it).
 		 */
-		if (sb && dentry->d_sb == sb) {
+		if (have_list) {
 			prune_one_dentry(dentry);
 			continue;
 		}
@@ -489,68 +489,25 @@ static void prune_dcache(int count, stru
 		 */
 		break;
 	}
+	/* split any remaining entries back onto dentry_unused */
+	list_splice(list, dentry_unused.prev);
 	spin_unlock(&dcache_lock);
 }
 
-/*
- * Shrink the dcache for the specified super block.
- * This allows us to unmount a device without disturbing
- * the dcache for the other devices.
- *
- * This implementation makes just two traversals of the
- * unused list.  On the first pass we move the selected
- * dentries to the most recent end, and on the second
- * pass we free them.  The second pass must restart after
- * each dput(), but since the target dentries are all at
- * the end, it's really just a single traversal.
- */
-
 /**
  * shrink_dcache_sb - shrink dcache for a superblock
  * @sb: superblock
  *
  * Shrink the dcache for the specified super block. This
- * is used to free the dcache before unmounting a file
- * system
+ * is used to reduce the dcache presence of a file system
+ * before re-mounting, and when invalidating the device
+ * holding a file system.
  */
 
 void shrink_dcache_sb(struct super_block * sb)
 {
-	struct list_head *tmp, *next;
-	struct dentry *dentry;
-
-	/*
-	 * Pass one ... move the dentries for the specified
-	 * superblock to the most recent end of the unused list.
-	 */
-	spin_lock(&dcache_lock);
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
-		list_move(tmp, &dentry_unused);
-	}
-
-	/*
-	 * Pass two ... free the dentries for this superblock.
-	 */
-repeat:
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
-		dentry_stat.nr_unused--;
-		list_del_init(tmp);
-		spin_lock(&dentry->d_lock);
-		if (atomic_read(&dentry->d_count)) {
-			spin_unlock(&dentry->d_lock);
-			continue;
-		}
-		prune_one_dentry(dentry);
-		cond_resched_lock(&dcache_lock);
-		goto repeat;
-	}
-	spin_unlock(&dcache_lock);
+	shrink_dcache_parent(sb->s_root);
+	shrink_dcache_anon(sb);
 }
 
 /*
@@ -607,7 +564,7 @@ positive:
 
 /*
  * Search the dentry child list for the specified parent,
- * and move any unused dentries to the end of the unused
+ * and move any unused dentries to the end of a new unused
  * list for prune_dcache(). We descend to the next level
  * whenever the d_subdirs list is non-empty and continue
  * searching.
@@ -619,7 +576,7 @@ positive:
  * drop the lock and return early due to latency
  * constraints.
  */
-static int select_parent(struct dentry * parent)
+static int select_parent(struct dentry * parent, struct list_head *new)
 {
 	struct dentry *this_parent = parent;
 	struct list_head *next;
@@ -643,7 +600,7 @@ resume:
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add_tail(&dentry->d_lru, &dentry_unused);
+			list_add_tail(&dentry->d_lru, new);
 			dentry_stat.nr_unused++;
 			found++;
 		}
@@ -687,9 +644,10 @@ out:
 void shrink_dcache_parent(struct dentry * parent)
 {
 	int found;
+	LIST_HEAD(list);
 
-	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found, parent->d_sb);
+	while ((found = select_parent(parent, &list)) != 0)
+		prune_dcache(found, &list);
 }
 
 /**
@@ -708,6 +666,7 @@ void shrink_dcache_anon(struct super_blo
 	struct hlist_head *head = &sb->s_anon;
 	int found;
 	do {
+		LIST_HEAD(list);
 		found = 0;
 		spin_lock(&dcache_lock);
 		hlist_for_each(lp, head) {
@@ -722,13 +681,13 @@ void shrink_dcache_anon(struct super_blo
 			 * of the unused list for prune_dcache
 			 */
 			if (!atomic_read(&this->d_count)) {
-				list_add_tail(&this->d_lru, &dentry_unused);
+				list_add_tail(&this->d_lru, &list);
 				dentry_stat.nr_unused++;
 				found++;
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found, sb);
+		prune_dcache(found, &list);
 	} while(found);
 }
 
