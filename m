Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWFXNeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWFXNeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWFXNeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:34:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964837AbWFXNeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:34:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17564.52290.338084.934211@cse.unsw.edu.au> 
References: <17564.52290.338084.934211@cse.unsw.edu.au>  <15603.1150978967@warthog.cambridge.redhat.com> 
To: Neil Brown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>, balbir@in.ibm.com, akpm@osdl.org,
       aviro@redhat.com, jblunck@suse.de, dev@openvz.org, olh@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Destroy the dentries contributed by a superblock on unmounting
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Sat, 24 Jun 2006 14:33:51 +0100
Message-ID: <553.1151156031@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Neil Brown <neilb@suse.de> wrote:

> Do you not have easy access to the roots of all trees in your
> super-block-sharing situation so that shrink_dcache_parent can be
> called on them all?

How about this?

David
---
From: David Howells <dhowells@redhat.com>

The attached patch destroys all the dentries attached to a superblock in one go
by:

 (1) Destroying the tree rooted at s_root.

 (2) Destroying every entry in the anon list, one at a time.

 (3) Each entry in the anon list has its subtree consumed from the leaves
     inwards.

This reduces the amount of work generic_shutdown_super() does, and avoids
iterating through the dentry_unused list.

The locking could be reduced if it can be guaranteed that the filesystem being
unmounted won't rearrange its dentry tree whilst we're trying to unmount it.
Unfortunately, I'm not sure this holds true for network filesystems,
particularly those that have callbacks, leases, oplocks or whatever to tell
them things have changed on the server.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c            |  111 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/super.c             |    8 +--
 include/linux/dcache.h |    1 
 3 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 454b6af..cb630f8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -549,6 +549,117 @@ repeat:
 }
 
 /*
+ * destroy one subtree of dentries for unmount
+ * - consumes a reference on the specified root dentry
+ * - called with the dcache_lock held, which it drops
+ *   - defend against the filesystem attempting to change the dentry tree
+ *     whilst we're trying to unmount it (it may be a network fs)
+ */
+static void shrink_dcache_for_umount_one(struct dentry *dentry)
+{
+	struct dentry *parent, *p;
+
+	/* detach this root from the system */
+	if (!list_empty(&dentry->d_lru)) {
+		dentry_stat.nr_unused--;
+		list_del_init(&dentry->d_lru);
+	}
+	__d_drop(dentry);
+
+	/* ignore anonymous dentries with parents as we'll get to those in due
+	 * course now they've been delisted */
+	if (!IS_ROOT(dentry)) {
+		spin_unlock(&dcache_lock);
+		return;
+	}
+
+	/* find the first leaf in the current subtree */
+descend_to_leaf:
+	if (!list_empty(&dentry->d_subdirs)) {
+		/* it's got children, pin it whilst we dispose of them */
+		atomic_inc(&dentry->d_count);
+
+		/* detach all children of this dentry from the system */
+		list_for_each_entry(p, &dentry->d_subdirs, d_u.d_child) {
+			if (!list_empty(&p->d_lru)) {
+				dentry_stat.nr_unused--;
+				list_del_init(&p->d_lru);
+			}
+
+			__d_drop(p);
+		}
+
+		dentry = list_entry(dentry->d_subdirs.next,
+				    struct dentry, d_u.d_child);
+		goto descend_to_leaf;
+	}
+
+	/* consume this leaf */
+consume_leaf:
+	BUG_ON(atomic_read(&dentry->d_count) != 0);
+
+	spin_lock(&dentry->d_lock);
+
+	parent = dentry->d_parent;
+	if (parent == dentry)
+		parent = NULL;
+	else
+		atomic_dec(&parent->d_count);
+
+	list_del(&dentry->d_u.d_child);
+	dentry_stat.nr_dentry--;	/* For d_free, below */
+	dentry_iput(dentry);
+	d_free(dentry);
+
+	/* done if fallen off top of tree */
+	if (!parent)
+		return;
+
+	/* ascend to parent and move to next leaf */
+	dentry = parent;
+
+	spin_lock(&dcache_lock);
+
+	if (list_empty(&dentry->d_subdirs)) {
+		atomic_dec(&dentry->d_count);
+		goto consume_leaf;
+	}
+
+	dentry = list_entry(dentry->d_subdirs.next,
+			    struct dentry, d_u.d_child);
+	goto descend_to_leaf;
+}
+
+/*
+ * destroy the dentries attached to a superblock on unmounting
+ * - shouldn't need to get dentry->d_lock as no-one else should be able to
+ *   reach this superblock and its dentries.
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
+	spin_lock(&dcache_lock);
+	atomic_dec(&dentry->d_count);
+	shrink_dcache_for_umount_one(dentry);
+
+	while (!hlist_empty(&sb->s_anon)) {
+		spin_lock(&dcache_lock);
+		if (!hlist_empty(&sb->s_anon)) {
+			dentry = hlist_entry(sb->s_anon.first, struct dentry, d_hash);
+			shrink_dcache_for_umount_one(dentry);
+		} else {
+			spin_unlock(&dcache_lock);
+		}
+	}
+}
+
+/*
  * Search for at least 1 mount point in the dentry's subdirs.
  * We descend to the next level whenever the d_subdirs
  * list is non-empty and continue searching.
diff --git a/fs/super.c b/fs/super.c
index ed653a6..50abd8e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -225,14 +225,10 @@ static int grab_super(struct super_block
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
index 28c9891..0f660ae 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -218,6 +218,7 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
+extern void shrink_dcache_for_umount(struct super_block *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
