Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWFPSow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWFPSow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFPSnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 14:43:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:37250 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751371AbWFPSnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 14:43:49 -0400
Message-Id: <20060616104322.791595000@hasse.suse.de>
References: <20060616104321.778718000@hasse.suse.de>
User-Agent: quilt/0.44-17
Date: Fri, 16 Jun 2006 12:43:26 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com, neilb@suse.de
Subject: [PATCH 5/5] vfs: per superblock dentry unused list
Content-Disposition: inline; filename=patches.jbl/vfs-per-sb-dentry_unused.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds per superblock dentry unused lists. This should speedup the
umounting/remounting of filesystems when there are a lot of dentries on the
unused lists.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/dcache.c        |  170 +++++++++++++++++++++++++----------------------------
 fs/super.c         |    2 
 include/linux/fs.h |    2 
 3 files changed, 86 insertions(+), 88 deletions(-)

Index: work-2.6/fs/dcache.c
===================================================================
--- work-2.6.orig/fs/dcache.c
+++ work-2.6/fs/dcache.c
@@ -61,7 +61,6 @@ static kmem_cache_t *dentry_cache __read
 static unsigned int d_hash_mask __read_mostly;
 static unsigned int d_hash_shift __read_mostly;
 static struct hlist_head *dentry_hashtable __read_mostly;
-static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
 struct dentry_stat global_dentry_stat = {
@@ -167,12 +166,15 @@ repeat:
 		if (dentry->d_op->d_delete(dentry))
 			goto unhash_it;
 	}
+	/* Kill dentry without superblock */
+	if (unlikely(!dentry->d_sb))
+		goto unhash_it;
 	/* Unreachable? Get rid of it */
 	if (d_unhashed(dentry))
 		goto kill_it;
 	if (list_empty(&dentry->d_lru)) {
 		dentry->d_flags |= DCACHE_REFERENCED;
-		list_add(&dentry->d_lru, &dentry_unused);
+		list_add(&dentry->d_lru, &dentry->d_sb->s_dentry_unused);
 		dentry_stat_inc(dentry->d_sb, nr_unused);
 	}
 	spin_unlock(&dentry->d_lock);
@@ -382,18 +384,20 @@ static inline void prune_one_dentry(stru
 }
 
 /**
- * prune_dcache - shrink the dcache
+ * prune_dcache_sb - prune the dcache for a superblock
+ * @sb: superblock
  * @count: number of entries to try and free
  *
- * Shrink the dcache. This is done when we need
- * more memory. When we need to unmount something
- * we call shrink_dcache_sb().
- *
- * This function may fail to free any resources if
- * all the dentries are in use.
+ * Prune the dcache for the specified super block. This walks the dentry LRU
+ * list backwards to free the @count oldest entries on it. If it finds entries
+ * which were recently referenced (the DCACHE_REFERENCED d_flag is set) they
+ * moved to the beginning of the dentry LRU list instead.
+ *
+ * You need to have a reference to the super block and should have
+ * sb->s_umount locked. This function may fail to free any resources if all
+ * the dentries are in use.
  */
-
-static void prune_dcache(int count)
+static void prune_dcache_sb(struct super_block *sb, int count)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
@@ -402,10 +406,10 @@ static void prune_dcache(int count)
 
 		cond_resched_lock(&dcache_lock);
 
-		tmp = dentry_unused.prev;
-		if (tmp == &dentry_unused)
+		tmp = sb->s_dentry_unused.prev;
+		if (tmp == &sb->s_dentry_unused)
 			break;
-		prefetch(dentry_unused.prev);
+		prefetch(sb->s_dentry_unused.prev);
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		dentry_stat_dec(dentry->d_sb, nr_unused);
 		list_del_init(&dentry->d_lru);
@@ -413,7 +417,7 @@ static void prune_dcache(int count)
 		spin_lock(&dentry->d_lock);
 		/*
 		 * We found an inuse dentry which was not removed from
-		 * dentry_unused because of laziness during lookup.  Do not free
+		 * dentry_unused because of laziness during lookup. Do not free
 		 * it - just keep it off the dentry_unused list.
 		 */
 		if (atomic_read(&dentry->d_count)) {
@@ -423,7 +427,7 @@ static void prune_dcache(int count)
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_flags & DCACHE_REFERENCED) {
 			dentry->d_flags &= ~DCACHE_REFERENCED;
-			list_add(&dentry->d_lru, &dentry_unused);
+			list_add(&dentry->d_lru, &sb->s_dentry_unused);
 			dentry_stat_inc(dentry->d_sb, nr_unused);
 			spin_unlock(&dentry->d_lock);
 			continue;
@@ -433,64 +437,68 @@ static void prune_dcache(int count)
 	spin_unlock(&dcache_lock);
 }
 
-
-/*
- * parsing d_hash list does not hlist_for_each_entry_rcu() as it
- * done under dcache_lock.
+/**
+ * prune_dcache - shrink the dcache
+ * @count: number of entries to try and free
+ *
+ * Prune the dcache. This is done when we need more memory. We are walking the
+ * list of superblocks and try to shrink their dentry LRU lists.
+ *
+ * This function may fail to free any resources if all the dentries are in use.
  */
-static void select_anon(struct super_block *sb)
+static void prune_dcache(int count)
 {
-	struct dentry *dentry;
-	struct hlist_node *lp;
+	struct super_block *sb;
+	int unused = global_dentry_stat.nr_unused;
 
-	spin_lock(&dcache_lock);
-	hlist_for_each_entry(dentry, lp, &sb->s_anon, d_hash) {
-		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat_dec(sb, nr_unused);
-			list_del_init(&dentry->d_lru);
-		}
+	if (count <= 0)
+		return;
 
-		/*
-		 * move only zero ref count dentries to the beginning
-		 * (the most recent end) of the unused list
-		 */
-		spin_lock(&dentry->d_lock);
-		if (!atomic_read(&dentry->d_count)) {
-			list_add(&dentry->d_lru, &dentry_unused);
-			dentry_stat_inc(sb, nr_unused);
+	spin_lock(&sb_lock);
+ restart:
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		if (down_read_trylock(&sb->s_umount)) {
+			if (sb->s_root) {
+				int tmp;
+
+				/*
+				 * We try to be fair and distribute the amount
+				 * of dentries to be pruned by the easy rule:
+				 *
+				 *   sb_count/sb_unused ~ count/global_unused
+				 *
+				 * This is not enough if the superblock has
+				 * <= 128 unused dentries (this is always
+				 * called via shrink_slab() with a count of
+				 * 128) therefore we use the s_scan_count to
+				 * artifically increase the dentry unused count
+				 * if we haven't pruned any dentries lately (in
+				 * the last runs of prune_dcache().
+				 */
+				tmp = sb->s_dentry_stat.nr_unused /
+					((unused /
+					  ((atomic_read(&sb->s_scan_count)+1) *
+					   count))+1);
+				if (tmp) {
+					atomic_add_unless(
+						&sb->s_scan_count, -1, 0);
+					prune_dcache_sb(sb, tmp);
+				} else
+					atomic_inc(&sb->s_scan_count, 0);
+				if (!sb->s_dentry_stat.nr_unused)
+					atomic_set(&sb->s_scan_count, 0);
+			}
+			up_read(&sb->s_umount);
 		}
-		spin_unlock(&dentry->d_lock);
-	}
-	spin_unlock(&dcache_lock);
-}
-
-static void select_sb(struct super_block *sb)
-{
-	struct dentry *dentry, *pos;
-
-	spin_lock(&dcache_lock);
-	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
-		if (dentry->d_sb != sb)
-			continue;
-		list_del(&dentry->d_lru);
-		list_add(&dentry->d_lru, &dentry_unused);
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb))
+			goto restart;
 	}
-	spin_unlock(&dcache_lock);
+	spin_unlock(&sb_lock);
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
@@ -499,30 +507,16 @@ static void select_sb(struct super_block
  * is used to free the dcache before unmounting a file
  * system
  */
-
 void shrink_dcache_sb(struct super_block * sb)
 {
-	struct list_head *tmp, *next;
-	struct dentry *dentry;
-
-	/*
-	 * Pass one ... move the dentries for the specified
-	 * superblock to the most recent end of the unused list.
-	 */
-	select_anon(sb);
-	select_sb(sb);
+	struct dentry *dentry, *pos;
 
-	/*
-	 * Pass two ... free the dentries for this superblock.
-	 */
 	spin_lock(&dcache_lock);
 repeat:
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
+	list_for_each_entry_safe(dentry, pos, &sb->s_dentry_unused, d_lru) {
+		BUG_ON(dentry->d_sb != sb);
 		dentry_stat_dec(sb, nr_unused);
-		list_del_init(tmp);
+		list_del_init(&dentry->d_lru);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count)) {
 			spin_unlock(&dentry->d_lock);
@@ -625,7 +619,7 @@ resume:
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add(&dentry->d_lru, dentry_unused.prev);
+			list_add_tail(&dentry->d_lru, &dentry->d_sb->s_dentry_unused);
 			dentry_stat_inc(dentry->d_sb, nr_unused);
 			found++;
 		}
@@ -671,7 +665,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_dcache_sb(parent->d_sb, found);
 }
 
 /*
@@ -1622,7 +1616,7 @@ resume:
 			list_del_init(&dentry->d_lru);
 		}
 		if (atomic_dec_and_test(&dentry->d_count)) {
-			list_add(&dentry->d_lru, dentry_unused.prev);
+			list_add(&dentry->d_lru, &dentry->d_sb->s_dentry_unused);
 			dentry_stat_inc(dentry->d_sb, nr_unused);
 		}
 	}
@@ -1633,7 +1627,7 @@ resume:
 			list_del_init(&this_parent->d_lru);
 		}
 		if (atomic_dec_and_test(&this_parent->d_count)) {
-			list_add(&this_parent->d_lru, dentry_unused.prev);
+			list_add(&this_parent->d_lru, &this_parent->d_sb->s_dentry_unused);
 			dentry_stat_inc(this_parent->d_sb, nr_unused);
 		}
 		this_parent = this_parent->d_parent;
Index: work-2.6/fs/super.c
===================================================================
--- work-2.6.orig/fs/super.c
+++ work-2.6/fs/super.c
@@ -71,7 +71,9 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
+		INIT_LIST_HEAD(&s->s_dentry_unused);
 		s->s_dentry_stat.age_limit = 45;
+		atomic_set(&s->s_scan_count, 0);
 		init_rwsem(&s->s_umount);
 		mutex_init(&s->s_lock);
 		down_write(&s->s_umount);
Index: work-2.6/include/linux/fs.h
===================================================================
--- work-2.6.orig/include/linux/fs.h
+++ work-2.6/include/linux/fs.h
@@ -847,7 +847,9 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	struct list_head	s_dentry_unused;
 	struct dentry_stat	s_dentry_stat;
+	atomic_t		s_scan_count;
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;

