Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWFWN2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWFWN2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWFWN2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:28:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:65225 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751527AbWFWN2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:28:14 -0400
Date: Fri, 23 Jun 2006 15:28:04 +0200
From: Jan Blunck <jblunck@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: neilb@suse.de, balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com,
       dev@openvz.org, olh@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix dcache race during umount
Message-ID: <20060623132804.GF11631@hasse.suse.de>
References: <15603.1150978967@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <15603.1150978967@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, David Howells wrote:

> I'd like to propose an alternative to your patch to fix the dcache race
> between unmounting a filesystem and the memory shrinker.
> 
> In my patch, generic_shutdown_super() is made to call shrink_dcache_sb()
> instead of shrink_dcache_anon(), and the latter function is discarded
> completely since it's no longer used.

I've updated my patches to Linus git repository from today. Additionally, I've
changed shrink_dcache_parent() to not use prune_dcache() anymore.

Comments are welcome.

Regards,
	Jan

--y0ulUmNC+osPPQO6
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="combined.diff"

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -387,101 +387,96 @@ static void prune_one_dentry(struct dent
  *         which are being unmounted.
  *
  * Shrink the dcache. This is done when we need
- * more memory, or simply when we need to unmount
- * something (at which point we need to unuse
- * all dentries).
+ * more memory. When we need to unmount something
+ * we call shrink_dcache_sb().
  *
  * This function may fail to free any resources if
  * all the dentries are in use.
  */
- 
-static void prune_dcache(int count, struct super_block *sb)
+static void prune_dcache(int count)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
-		struct rw_semaphore *s_umount;
 
 		cond_resched_lock(&dcache_lock);
 
 		tmp = dentry_unused.prev;
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
 		if (tmp == &dentry_unused)
 			break;
-		list_del_init(tmp);
-		prefetch(dentry_unused.prev);
- 		dentry_stat.nr_unused--;
+		/*
+		 * We want to prefetch the predecessor of our predecessor since
+		 * our predecessor is already accessed in list_del_init().
+		 */
+		prefetch(tmp->prev->prev);
 		dentry = list_entry(tmp, struct dentry, d_lru);
+		dentry_stat.nr_unused--;
+		list_del_init(&dentry->d_lru);
 
- 		spin_lock(&dentry->d_lock);
+		spin_lock(&dentry->d_lock);
 		/*
 		 * We found an inuse dentry which was not removed from
-		 * dentry_unused because of laziness during lookup.  Do not free
+		 * dentry_unused because of laziness during lookup. Do not free
 		 * it - just keep it off the dentry_unused list.
 		 */
- 		if (atomic_read(&dentry->d_count)) {
- 			spin_unlock(&dentry->d_lock);
-			continue;
-		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
-			dentry->d_flags &= ~DCACHE_REFERENCED;
- 			list_add(&dentry->d_lru, &dentry_unused);
- 			dentry_stat.nr_unused++;
- 			spin_unlock(&dentry->d_lock);
-			continue;
-		}
-		/*
-		 * If the dentry is not DCACHED_REFERENCED, it is time
-		 * to remove it from the dcache, provided the super block is
-		 * NULL (which means we are trying to reclaim memory)
-		 * or this dentry belongs to the same super block that
-		 * we want to shrink.
-		 */
-		/*
-		 * If this dentry is for "my" filesystem, then I can prune it
-		 * without taking the s_umount lock (I already hold it).
-		 */
-		if (sb && dentry->d_sb == sb) {
-			prune_one_dentry(dentry);
+		if (atomic_read(&dentry->d_count)) {
+			spin_unlock(&dentry->d_lock);
 			continue;
 		}
 		/*
-		 * ...otherwise we need to be sure this filesystem isn't being
-		 * unmounted, otherwise we could race with
-		 * generic_shutdown_super(), and end up holding a reference to
-		 * an inode while the filesystem is unmounted.
-		 * So we try to get s_umount, and make sure s_root isn't NULL.
-		 * (Take a local copy of s_umount to avoid a use-after-free of
-		 * `dentry').
+		 * If the dentry was recently referenced, or the dentry's
+		 * filesystem is going to be unmounted, don't free it.
 		 */
-		s_umount = &dentry->d_sb->s_umount;
-		if (down_read_trylock(s_umount)) {
-			if (dentry->d_sb->s_root != NULL) {
+		if (!(dentry->d_flags & DCACHE_REFERENCED) &&
+		    likely(down_read_trylock(&dentry->d_sb->s_umount))) {
+			struct super_block *sb = dentry->d_sb;
+
+			if (dentry->d_sb->s_root) {
 				prune_one_dentry(dentry);
-				up_read(s_umount);
+				up_read(&sb->s_umount);
 				continue;
 			}
-			up_read(s_umount);
+			up_read(&sb->s_umount);
 		}
-		spin_unlock(&dentry->d_lock);
-		/* Cannot remove the first dentry, and it isn't appropriate
-		 * to move it to the head of the list, so give up, and try
-		 * later
+		/*
+		 * Either the dentry was recently referenced or its filesystem
+		 * is going to be unmounted. Add the dentry to the beginning of
+		 * the LRU list so shrink_dcache_sb() can find it faster.
 		 */
-		break;
+		dentry->d_flags &= ~DCACHE_REFERENCED;
+		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
+		spin_unlock(&dentry->d_lock);
+	}
+	spin_unlock(&dcache_lock);
+}
+
+/*
+ * __shrink_dcache_sb - Shrink the dentries for a superblock
+ * @sb: superblock
+ * @list: list of dentries
+ *
+ * Prune a list of dentries of a superblock.
+ */
+static void __shrink_dcache_sb(struct super_block *sb, struct list_head *list)
+{
+	struct dentry *dentry, *pos;
+
+	spin_lock(&dcache_lock);
+repeat:
+	list_for_each_entry_safe(dentry, pos, list, d_lru) {
+		BUG_ON(dentry->d_sb != sb);
+		dentry_stat.nr_unused--;
+		list_del_init(&dentry->d_lru);
+		spin_lock(&dentry->d_lock);
+		if (atomic_read(&dentry->d_count)) {
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
+		prune_one_dentry(dentry);
+		cond_resched_lock(&dcache_lock);
+		goto repeat;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -505,47 +500,31 @@ static void prune_dcache(int count, stru
  *
  * Shrink the dcache for the specified super block. This
  * is used to free the dcache before unmounting a file
- * system
+ * system.
+ *
+ * This must be called with sb->s_umount locked.
  */
-
 void shrink_dcache_sb(struct super_block * sb)
 {
-	struct list_head *tmp, *next;
-	struct dentry *dentry;
+	struct dentry *dentry, *pos;
+	LIST_HEAD(list);
 
 	/*
 	 * Pass one ... move the dentries for the specified
-	 * superblock to the most recent end of the unused list.
+	 * superblock to the temporarily list.
 	 */
 	spin_lock(&dcache_lock);
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
+	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
 		if (dentry->d_sb != sb)
 			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
+		list_move(&dentry->d_lru, &list);
 	}
+	spin_unlock(&dcache_lock);
 
 	/*
 	 * Pass two ... free the dentries for this superblock.
 	 */
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
+	__shrink_dcache_sb(sb, &list);
 }
 
 /*
@@ -614,7 +593,7 @@ positive:
  * drop the lock and return early due to latency
  * constraints.
  */
-static int select_parent(struct dentry * parent)
+static int select_parent(struct dentry * parent, struct list_head *list)
 {
 	struct dentry *this_parent = parent;
 	struct list_head *next;
@@ -638,7 +617,7 @@ resume:
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add(&dentry->d_lru, dentry_unused.prev);
+			list_add(&dentry->d_lru, list);
 			dentry_stat.nr_unused++;
 			found++;
 		}
@@ -681,50 +660,11 @@ out:
  
 void shrink_dcache_parent(struct dentry * parent)
 {
+	LIST_HEAD(list);
 	int found;
 
-	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found, parent->d_sb);
-}
-
-/**
- * shrink_dcache_anon - further prune the cache
- * @head: head of d_hash list of dentries to prune
- *
- * Prune the dentries that are anonymous
- *
- * parsing d_hash list does not hlist_for_each_entry_rcu() as it
- * done under dcache_lock.
- *
- */
-void shrink_dcache_anon(struct super_block *sb)
-{
-	struct hlist_node *lp;
-	struct hlist_head *head = &sb->s_anon;
-	int found;
-	do {
-		found = 0;
-		spin_lock(&dcache_lock);
-		hlist_for_each(lp, head) {
-			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
-			if (!list_empty(&this->d_lru)) {
-				dentry_stat.nr_unused--;
-				list_del_init(&this->d_lru);
-			}
-
-			/* 
-			 * move only zero ref count dentries to the end 
-			 * of the unused list for prune_dcache
-			 */
-			if (!atomic_read(&this->d_count)) {
-				list_add_tail(&this->d_lru, &dentry_unused);
-				dentry_stat.nr_unused++;
-				found++;
-			}
-		}
-		spin_unlock(&dcache_lock);
-		prune_dcache(found, sb);
-	} while(found);
+	while ((found = select_parent(parent, &list)) != 0)
+		__shrink_dcache_sb(parent->d_sb, &list);
 }
 
 /*
@@ -744,7 +684,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr, NULL);
+		prune_dcache(nr);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }
@@ -1659,19 +1599,38 @@ repeat:
 resume:
 	while (next != &this_parent->d_subdirs) {
 		struct list_head *tmp = next;
-		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
+		struct dentry *dentry = list_entry(tmp, struct dentry,
+						   d_u.d_child);
 		next = tmp->next;
+
 		if (d_unhashed(dentry)||!dentry->d_inode)
 			continue;
+
+		if (!list_empty(&dentry->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&dentry->d_lru);
+		}
+		/*
+		 * We can lower the reference count here:
+		 * - if the refcount is zero afterwards, the dentry hasn't got
+		 *   any children
+		 * - if the recount isn't zero afterwards, we visit the
+		 *   chrildren next
+		 * - because we always hold the dcache lock, nobody else can
+		 *   kill the unused dentries yet
+		 */
+		if (atomic_dec_and_test(&dentry->d_count)) {
+			list_add_tail(&dentry->d_lru, &dentry_unused);
+			dentry_stat.nr_unused++;
+		}
+
 		if (!list_empty(&dentry->d_subdirs)) {
 			this_parent = dentry;
 			goto repeat;
 		}
-		atomic_dec(&dentry->d_count);
 	}
 	if (this_parent != root) {
 		next = this_parent->d_u.d_child.next;
-		atomic_dec(&this_parent->d_count);
 		this_parent = this_parent->d_parent;
 		goto resume;
 	}
Index: linux-2.6/fs/super.c
===================================================================
--- linux-2.6.orig/fs/super.c
+++ linux-2.6/fs/super.c
@@ -230,8 +230,7 @@ void generic_shutdown_super(struct super
 
 	if (root) {
 		sb->s_root = NULL;
-		shrink_dcache_parent(root);
-		shrink_dcache_anon(sb);
+		shrink_dcache_sb(sb);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);
Index: linux-2.6/include/linux/dcache.h
===================================================================
--- linux-2.6.orig/include/linux/dcache.h
+++ linux-2.6/include/linux/dcache.h
@@ -217,7 +217,6 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct super_block *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */

--y0ulUmNC+osPPQO6--
