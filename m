Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWF3MeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWF3MeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWF3MeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:34:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932557AbWF3MeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:34:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/2] VFS: Destroy the dentries contributed by a superblock on unmounting
Date: Fri, 30 Jun 2006 13:33:26 +0100
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, neilb@suse.de,
       raven@themaw.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       autofs@linux.kernel.org, dhowells@redhat.com
Message-Id: <20060630123326.26938.278.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch destroys all the dentries attached to a superblock in one go
by:

 (1) Destroying the tree rooted at s_root.

 (2) Destroying every entry in the anon list, one at a time.

 (3) Each entry in the anon list has its subtree consumed from the leaves
     inwards.

This reduces the amount of work generic_shutdown_super() does, and avoids
iterating through the dentry_unused list.

Note that locking is almost entirely absent in the shrink_dcache_for_umount*()
functions added by this patch.  This is because:

 (1) at the point the filesystem calls generic_shutdown_super(), it is not
     permitted to further touch the superblock's set of dentries, and nor may
     it remove aliases from inodes;

 (2) the dcache memory shrinker now skips dentries that are being unmounted;
     and

 (3) the superblock no longer has any external references through which the VFS
     can reach it.

Given these points, the only locking we need to do is when we remove dentries
from the unused list and the name hashes, which we do a directory's worth at a
time.

We also don't need to guard against reference counts going to zero unexpectedly
and removing bits of the tree we're working on as nothing else can call dput().

A cut down version of dentry_iput() has been folded into
shrink_dcache_for_umount_subtree() function.  Apart from not needing to unlock
things, it also doesn't need to check for inotify watches.

In this version of the patch, the complaint about a dentry still being in use
has been expanded from a single BUG_ON() and now gives much more information.

Signed-Off-By: David Howells <dhowells@redhat.com>
Acked-by: NeilBrown <neilb@suse.de>
---

 fs/dcache.c            |  133 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/super.c             |   12 ++--
 include/linux/dcache.h |    1 
 3 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 48b44a7..ae041da 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -548,6 +548,139 @@ repeat:
 }
 
 /*
+ * destroy a single subtree of dentries for unmount
+ * - see the comments on shrink_dcache_for_umount() for a description of the
+ *   locking
+ */
+static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	BUG_ON(!IS_ROOT(dentry));
+
+	/* detach this root from the system */
+	spin_lock(&dcache_lock);
+	if (!list_empty(&dentry->d_lru)) {
+		dentry_stat.nr_unused--;
+		list_del_init(&dentry->d_lru);
+	}
+	__d_drop(dentry);
+	spin_unlock(&dcache_lock);
+
+	for (;;) {
+		/* descend to the first leaf in the current subtree */
+		while (!list_empty(&dentry->d_subdirs)) {
+			struct dentry *loop;
+
+			/* this is a branch with children - detach all of them
+			 * from the system in one go */
+			spin_lock(&dcache_lock);
+			list_for_each_entry(loop, &dentry->d_subdirs,
+					    d_u.d_child) {
+				if (!list_empty(&loop->d_lru)) {
+					dentry_stat.nr_unused--;
+					list_del_init(&loop->d_lru);
+				}
+
+				__d_drop(loop);
+				cond_resched_lock(&dcache_lock);
+			}
+			spin_unlock(&dcache_lock);
+
+			/* move to the first child */
+			dentry = list_entry(dentry->d_subdirs.next,
+					    struct dentry, d_u.d_child);
+		}
+
+		/* consume the dentries from this leaf up through its parents
+		 * until we find one with children or run out altogether */
+		do {
+			struct inode *inode;
+
+			if (atomic_read(&dentry->d_count) != 0) {
+				printk(KERN_ERR
+				       "BUG: Dentry %p{i=%lx,n=%s}"
+				       " still in use (%d)"
+				       " [unmount of %s %s]\n",
+				       dentry,
+				       dentry->d_inode ?
+				       dentry->d_inode->i_ino : 0UL,
+				       dentry->d_name.name,
+				       atomic_read(&dentry->d_count),
+				       dentry->d_sb->s_type->name,
+				       dentry->d_sb->s_id);
+				BUG();
+			}
+
+			parent = dentry->d_parent;
+			if (parent == dentry)
+				parent = NULL;
+			else
+				atomic_dec(&parent->d_count);
+
+			list_del(&dentry->d_u.d_child);
+			dentry_stat.nr_dentry--;	/* For d_free, below */
+
+			inode = dentry->d_inode;
+			if (inode) {
+#ifdef CONFIG_INOTIFY
+				BUG_ON(!list_empty(&inode->inotify_watches));
+#endif
+				dentry->d_inode = NULL;
+				list_del_init(&dentry->d_alias);
+				if (dentry->d_op && dentry->d_op->d_iput)
+					dentry->d_op->d_iput(dentry, inode);
+				else
+					iput(inode);
+			}
+
+			d_free(dentry);
+
+			/* finished when we fall off the top of the tree,
+			 * otherwise we ascend to the parent and move to the
+			 * next sibling if there is one */
+			if (!parent)
+				return;
+
+			dentry = parent;
+
+		} while (list_empty(&dentry->d_subdirs));
+
+		dentry = list_entry(dentry->d_subdirs.next,
+				    struct dentry, d_u.d_child);
+	}
+}
+
+/*
+ * destroy the dentries attached to a superblock on unmounting
+ * - we don't need to use dentry->d_lock, and only need dcache_lock when
+ *   removing the dentry from the system lists and hashes because:
+ *   - the superblock is detached from all mountings and open files, so the
+ *     dentry trees will not be rearranged by the VFS
+ *   - s_umount is write-locked, so the memory pressure shrinker will ignore
+ *     any dentries belonging to this superblock that it comes across
+ *   - the filesystem itself is no longer permitted to rearrange the dentries
+ *     in this superblock
+ */
+void shrink_dcache_for_umount(struct super_block *sb)
+{
+	struct dentry *dentry;
+
+	if (down_read_trylock(&sb->s_umount))
+		BUG();
+
+	dentry = sb->s_root;
+	sb->s_root = NULL;
+	atomic_dec(&dentry->d_count);
+	shrink_dcache_for_umount_subtree(dentry);
+
+	while (!hlist_empty(&sb->s_anon)) {
+		dentry = hlist_entry(sb->s_anon.first, struct dentry, d_hash);
+		shrink_dcache_for_umount_subtree(dentry);
+	}
+}
+
+/*
  * Search for at least 1 mount point in the dentry's subdirs.
  * We descend to the next level whenever the d_subdirs
  * list is non-empty and continue searching.
diff --git a/fs/super.c b/fs/super.c
index 8a669f6..bd655b1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -222,17 +222,17 @@ static int grab_super(struct super_block
  *	that need destruction out of superblock, call generic_shutdown_super()
  *	and release aforementioned objects.  Note: dentries and inodes _are_
  *	taken care of and do not need specific handling.
+ *
+ *	Upon calling this function, the filesystem may no longer alter or
+ *	rearrange the set of dentries belonging to this super_block, nor may it
+ *	change the attachments of dentries to inodes.
  */
 void generic_shutdown_super(struct super_block *sb)
 {
-	struct dentry *root = sb->s_root;
 	struct super_operations *sop = sb->s_op;
 
-	if (root) {
-		sb->s_root = NULL;
-		shrink_dcache_parent(root);
-		shrink_dcache_sb(sb);
-		dput(root);
+	if (sb->s_root) {
+		shrink_dcache_for_umount(sb);
 		fsync_super(sb);
 		lock_super(sb);
 		sb->s_flags &= ~MS_ACTIVE;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 0dd1610..fe8bcd5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,6 +217,7 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
+extern void shrink_dcache_for_umount(struct super_block *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
