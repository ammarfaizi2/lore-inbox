Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWFVQoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWFVQoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWFVQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:44:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750972AbWFVQoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:44:11 -0400
Date: Thu, 22 Jun 2006 18:44:09 +0200
From: Jan Blunck <jblunck@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: neilb@suse.de, balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com,
       dev@openvz.org, olh@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix dcache race during umount
Message-ID: <20060622164409.GL6824@hasse.suse.de>
References: <15603.1150978967@warthog.cambridge.redhat.com> <20060622160830.GK6824@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20060622160830.GK6824@hasse.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, Jan Blunck wrote:

> I had a similar patch. But after calling shrink_dcache_sb() in
> generic_shutdown_super() the call to shrink_dcache_parent() is not necessary
> anymore. And you should also fix d_genocide() that it is putting unused
> dentries to the LRU list.

And I even have a patch that does compile ... so please ignore the previous
one.

Jan

--O3RTKUHj+75w1tg5
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="combined.diff"

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
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
@@ -419,15 +418,26 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
-			dentry->d_flags &= ~DCACHE_REFERENCED;
- 			list_add(&dentry->d_lru, &dentry_unused);
- 			dentry_stat.nr_unused++;
- 			spin_unlock(&dentry->d_lock);
-			continue;
+		/* If the dentry was recently referenced, or dentry's
+		 * filesystem is going to be unmounted, don't free it. */
+		if (!(dentry->d_flags & DCACHE_REFERENCED) &&
+		    down_read_trylock(&dentry->d_sb->s_umount)) {
+			struct super_block *sb = dentry->d_sb;
+
+			if (dentry->d_sb->s_root) {
+				prune_one_dentry(dentry);
+				up_read(&sb->s_umount);
+				continue;
+			}
+			up_read(&sb->s_umount);
 		}
-		prune_one_dentry(dentry);
+		/* Append it at the beginning of the list, because either it
+		 * was recently reference or the dentry's filesystem is
+		 * unmounted so shrink_dcache_sb() can find it faster. */
+		dentry->d_flags &= ~DCACHE_REFERENCED;
+		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
+		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -456,32 +466,28 @@ static void prune_dcache(int count)
 
 void shrink_dcache_sb(struct super_block * sb)
 {
-	struct list_head *tmp, *next;
-	struct dentry *dentry;
+	struct dentry *dentry, *pos;
 
 	/*
 	 * Pass one ... move the dentries for the specified
 	 * superblock to the most recent end of the unused list.
 	 */
 	spin_lock(&dcache_lock);
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
+	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
 		if (dentry->d_sb != sb)
 			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
+		list_move(&dentry->d_lru, &dentry_unused);
 	}
 
 	/*
 	 * Pass two ... free the dentries for this superblock.
 	 */
 repeat:
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
+	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
 		if (dentry->d_sb != sb)
 			continue;
 		dentry_stat.nr_unused--;
-		list_del_init(tmp);
+		list_del_init(&dentry->d_lru);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count)) {
 			spin_unlock(&dentry->d_lock);
@@ -633,45 +639,6 @@ void shrink_dcache_parent(struct dentry 
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
@@ -1604,19 +1571,38 @@ repeat:
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
-		shrink_dcache_anon(&sb->s_anon);
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
-extern void shrink_dcache_anon(struct hlist_head *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */

--O3RTKUHj+75w1tg5--
