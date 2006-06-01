Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWFAKDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWFAKDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWFAKCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:02:51 -0400
Received: from mail.suse.de ([195.135.220.2]:53391 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964907AbWFAKCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:47 -0400
Message-Id: <20060601100135.071321000@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de>
User-Agent: quilt/0.44-16
Date: Thu, 01 Jun 2006 11:51:28 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com
Subject: [patch 3/5] vfs: remove shrink_dcache_anon()
Content-Disposition: inline; filename=patches.jbl/vfs-remove-shrink_dcache_anon.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After shrink_dcache_anon() is unexported there is only one caller
(generic_shutdown_super()). Instead of calling shrink_dcache_anon() and
shrink_dcache_parent() it is better to call shrink_dcache_sb(). Therefore
shrink_dcache_sb() is extended by also reordering the anonymous dentries in
the unused list. This way we get rid of all unused dentries when we touch them
the first time instead of checking for DCACHE_REFERENCED and adding them back
to the list again.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/dcache.c            |  100 ++++++++++++++++++++++++-------------------------
 fs/super.c             |    3 -
 include/linux/dcache.h |    1 
 3 files changed, 51 insertions(+), 53 deletions(-)

Index: work-2.6/fs/dcache.c
===================================================================
--- work-2.6.orig/fs/dcache.c
+++ work-2.6/fs/dcache.c
@@ -384,9 +384,8 @@ static inline void prune_one_dentry(stru
  * @count: number of entries to try and free
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
@@ -432,6 +431,51 @@ static void prune_dcache(int count)
 	spin_unlock(&dcache_lock);
 }
 
+
+/*
+ * parsing d_hash list does not hlist_for_each_entry_rcu() as it
+ * done under dcache_lock.
+ */
+static void select_anon(struct super_block *sb)
+{
+	struct dentry *dentry;
+	struct hlist_node *lp;
+
+	spin_lock(&dcache_lock);
+	hlist_for_each_entry(dentry, lp, &sb->s_anon, d_hash) {
+		if (!list_empty(&dentry->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&dentry->d_lru);
+		}
+
+		/*
+		 * move only zero ref count dentries to the beginning
+		 * (the most recent end) of the unused list
+		 */
+		spin_lock(&dentry->d_lock);
+		if (!atomic_read(&dentry->d_count)) {
+			list_add(&dentry->d_lru, &dentry_unused);
+			dentry_stat.nr_unused++;
+		}
+		spin_unlock(&dentry->d_lock);
+	}
+	spin_unlock(&dcache_lock);
+}
+
+static void select_sb(struct super_block *sb)
+{
+	struct dentry *dentry, *pos;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
+		if (dentry->d_sb != sb)
+			continue;
+		list_del(&dentry->d_lru);
+		list_add(&dentry->d_lru, &dentry_unused);
+	}
+	spin_unlock(&dcache_lock);
+}
+
 /*
  * Shrink the dcache for the specified super block.
  * This allows us to unmount a device without disturbing
@@ -463,18 +507,13 @@ void shrink_dcache_sb(struct super_block
 	 * Pass one ... move the dentries for the specified
 	 * superblock to the most recent end of the unused list.
 	 */
-	spin_lock(&dcache_lock);
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
-	}
+	select_anon(sb);
+	select_sb(sb);
 
 	/*
 	 * Pass two ... free the dentries for this superblock.
 	 */
+	spin_lock(&dcache_lock);
 repeat:
 	list_for_each_safe(tmp, next, &dentry_unused) {
 		dentry = list_entry(tmp, struct dentry, d_lru);
@@ -633,45 +672,6 @@ void shrink_dcache_parent(struct dentry 
 		prune_dcache(found);
 }
 
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
-void shrink_dcache_anon(struct hlist_head *head)
-{
-	struct hlist_node *lp;
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
-		prune_dcache(found);
-	} while(found);
-}
-
 /*
  * Scan `nr' dentries and return the number which remain.
  *
Index: work-2.6/fs/super.c
===================================================================
--- work-2.6.orig/fs/super.c
+++ work-2.6/fs/super.c
@@ -230,8 +230,7 @@ void generic_shutdown_super(struct super
 
 	if (root) {
 		sb->s_root = NULL;
-		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_sb(sb);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);
Index: work-2.6/include/linux/dcache.h
===================================================================
--- work-2.6.orig/include/linux/dcache.h
+++ work-2.6/include/linux/dcache.h
@@ -217,7 +217,6 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct hlist_head *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */

