Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWFVMXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWFVMXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWFVMXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:23:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15331 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750822AbWFVMXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:23:04 -0400
From: David Howells <dhowells@redhat.com>
To: neilb@suse.de, balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com
cc: jblunck@suse.de, dev@openvz.org, olh@suse.de, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Fix dcache race during umount
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 22 Jun 2006 13:22:47 +0100
Message-ID: <15603.1150978967@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Neil,

I'd like to propose an alternative to your patch to fix the dcache race
between unmounting a filesystem and the memory shrinker.

In my patch, generic_shutdown_super() is made to call shrink_dcache_sb()
instead of shrink_dcache_anon(), and the latter function is discarded
completely since it's no longer used.

This allows for the possibility of a superblock with multiple dentry trees in
it, such as exist in the patches for NFS superblock sharing that I worked out.

Otherwise, the patches are much the same, with the critical bit being
prune_dcache() ignoring any dentry for which the superblock is being unmounted
if called from shrink_dcache_memory().

I feel that prune_dcache() should probably at some point be merged into its
two callers, since shrink_dcache_parent() and select_parent() can probably
then do a better job of eating a dentry subtree from the leaves inwards, but I
haven't attempted that with this patch.

David
---
The race is that the shrink_dcache_memory() shrinker could get called while a
filesystem is being unmounted, and could try to prune a dentry belonging to
that filesystem.

If it does, then it will call in to iput() on the inode while the dentry is no
longer able to be found by the umounting process.  If iput() takes a while,
generic_shutdown_super() could get all the way though shrink_dcache_parent()
and shrink_dcache_sb() and invalidate_inodes() without ever waiting on this
particular inode.

Eventually the superblock gets freed anyway and if the iput() tried to touch it
(which some filesystems certainly do), it will lose.  The promised
"Self-destruct in 5 seconds" doesn't lead to a nice day.

The race is closed by holding s_umount while calling prune_one_dentry() on
someone else's dentry.  As a down_read_trylock() is used,
shrink_dcache_memory() will no longer try to prune the dentry of a filesystem
that is being unmounted, and unmount will not be able to start until any such
active prune_one_dentry() completes.

This requires that prune_dcache *knows* which filesystem (if any) it is doing
the prune on behalf of so that it can be careful of other filesystems.
shrink_dcache_memory() isn't called it on behalf of any filesystem, and so is
careful of everything.

generic_shutdown_super() now calls shrink_dcache_sb() rather than
shrink_dcache_anon() so that superblocks with multiple dentry trees can be
dealt with.  shrink_dcache_anon() is discarded since nothing then uses it.

If prune_dcache() finds a dentry that it cannot free, it leaves it where it is
(at the tail of the list) and exits, on the assumption that some other thread
will be removing that dentry soon.  To try to make sure that some work gets
done, a limited number of dnetries which are untouchable are skipped over while
choosing the dentry to work on.

I believe this race was first found by Kirill Korotaev.

Cc: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Olaf Hering <olh@suse.de>
Cc: Neil Brown <neilb@suse.de>
Cc: Balbir Singh <balbir@in.ibm.com>
Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 fix-dcache-race-during-umount-2.patch 
 fs/dcache.c            |  100 +++++++++++++++++++++++++++----------------------
 fs/super.c             |    2 
 include/linux/dcache.h |    1 
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 940d188..c88e426 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -382,6 +382,8 @@ static inline void prune_one_dentry(stru
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
+ * @sb: if given, ignore dentries for other superblocks
+ *         which are being unmounted.
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -392,16 +394,29 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_dcache(int count, struct super_block *sb)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
+		struct rw_semaphore *s_umount;
 
 		cond_resched_lock(&dcache_lock);
 
 		tmp = dentry_unused.prev;
+		if (unlikely(sb)) {
+			/* Try to find a dentry for this sb, but don't try
+			 * too hard, if they aren't near the tail they will
+			 * be moved down again soon
+			 */
+			int skip = count;
+			while (skip && tmp != &dentry_unused &&
+			    list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
+				skip--;
+				tmp = tmp->prev;
+			}
+		}
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
@@ -427,7 +442,45 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		prune_one_dentry(dentry);
+		/*
+		 * If the dentry is not DCACHED_REFERENCED, it is time
+		 * to remove it from the dcache, provided the super block is
+		 * NULL (which means we are trying to reclaim memory)
+		 * or this dentry belongs to the same super block that
+		 * we want to shrink.
+		 */
+		/*
+		 * If this dentry is for "my" filesystem, then I can prune it
+		 * without taking the s_umount lock (I already hold it).
+		 */
+		if (sb && dentry->d_sb == sb) {
+			prune_one_dentry(dentry);
+			continue;
+		}
+		/*
+		 * ...otherwise we need to be sure this filesystem isn't being
+		 * unmounted, otherwise we could race with
+		 * generic_shutdown_super(), and end up holding a reference to
+		 * an inode while the filesystem is unmounted.
+		 * So we try to get s_umount, and make sure s_root isn't NULL.
+		 * (Take a local copy of s_umount to avoid a use-after-free of
+		 * `dentry').
+		 */
+		s_umount = &dentry->d_sb->s_umount;
+		if (down_read_trylock(s_umount)) {
+			if (dentry->d_sb->s_root != NULL) {
+				prune_one_dentry(dentry);
+				up_read(s_umount);
+				continue;
+			}
+			up_read(s_umount);
+		}
+		spin_unlock(&dentry->d_lock);
+		/* Cannot remove the first dentry, and it isn't appropriate
+		 * to move it to the head of the list, so give up, and try
+		 * later
+		 */
+		break;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -630,46 +683,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
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
+		prune_dcache(found, parent->d_sb);
 }
 
 /*
@@ -689,7 +703,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr);
+		prune_dcache(nr, NULL);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }
diff --git a/fs/super.c b/fs/super.c
index 15f2afd..beb0c11 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -231,7 +231,7 @@ void generic_shutdown_super(struct super
 	if (root) {
 		sb->s_root = NULL;
 		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_sb(sb);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 836325e..0dd1610 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,7 +217,6 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct hlist_head *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
