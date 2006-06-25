Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWFYQCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWFYQCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWFYQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751120AbWFYQCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:02:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17566.12727.489041.220653@cse.unsw.edu.au> 
References: <17566.12727.489041.220653@cse.unsw.edu.au>  <17564.52290.338084.934211@cse.unsw.edu.au> <15603.1150978967@warthog.cambridge.redhat.com> <553.1151156031@warthog.cambridge.redhat.com> 
To: Neil Brown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>, balbir@in.ibm.com, akpm@osdl.org,
       aviro@redhat.com, jblunck@suse.de, dev@openvz.org, olh@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Sun, 25 Jun 2006 17:02:32 +0100
Message-ID: <20946.1151251352@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:

>  - The test for IS_ROOT surprises me.  I thought anonymous dentries
>    were all IS_ROOT.   Maybe this changes with your shared-superblock
>    changes? 

I know they start out as root dentries, but are they required to stay so?

My NFS changes don't cause this to happen.

>  - You have two nested loops implemented with gotos.  Dijykstra would
>    be shocked!

It'll be good for him.

> The logic looks like it should be:

Two points:

 (1) The second while loop really wants to be a do-while loop.  We have to go
     around it at least once, since the first loop brings it to that
     condition.

 (2) We need to drop a reference on a dentry node for which we've drained all
     the children, but we need to do it after the test to see whether it has
     any children.  This means you'd need to put the atomic_dec() in the
     condition of the do-while statement.

     To have a while-loop instead, you'd have to get a reference on every node
     you considered, even if you're just going to immediately drop that
     reference again.

>     Which I think makes it a lot more readable (obviously I have left
>     out lots of the details in the above.

But not necessarily right.  Basically, the goto to consume_leaf when we've
drained the parent is a sort of shortcut.

>   - The section that I have called 'stuff-1' above seems excessive.
>     Everytime you visit a dentry with children, you remove them from
>     the unused list (if present) and d_drop them from the hash.  After
>     the first time, these should all be no-ops.

"After the first time"?  I don't see what you're getting at.  It is executed
once per directory.

>     If there some particular reason for this that I'm not seeing (which case
>     I'd like a comment) or can you just unuse/drop the dentry just before
>     freeing it

Well, I'd like to avoid holding the dcache_lock as much as possible, and,
theoretically, around that while loop is the only place in which dcache_lock
needs to be held.  As long as the filesystem isn't trying to mangle the dentry
tree whilst we're trying to unmount it, nothing else will be mucking around
with them (now that shrink_dcache_memory() has been fixed).

>   - Think the reference counting deserves a comment.

There is a comment:

+		/* it's got children, pin it whilst we dispose of them */

>     I think that this routine holds a reference count on 'dentry' and every
>     parent up to the IS_ROOT.  Is that right?

No.  We only get a reference on a dentry that has children.  Any dentry that
doesn't have children we just clobber.

I want to defend against a netfs attempting to evict dentries during unmount
in response to network events.

> In summary, it looks right, though I feel I would want to go through
> and double check the refcounting again, but I would rather do that
> with it restructured into while loops.
> Is that fair?

No... you should be able to handle gotos:-)

I've restructured it a little (see attached).

I've made the descend_to_leaf loop into an infinite for-loop.

I've moved the __d_drop and LRU-removal to just before we clobber an entry,
since for the moment the lock is being held anyway - that shortens the descent
loop.

The consume-leaf loop is tricky to turn into a while-loop, a for-loop or a
do-loop since as I said above: I need to call atomic_dec() on the second+
times round the loop, but after the condition has been evaluated to true.

David
---
[PATCH] Destroy the dentries contributed by a superblock on unmounting

From: David Howells <dhowells@redhat.com>

The attached patch destroys all the dentries attached to a superblock in one go
by:

 (1) Destroying the tree rooted at s_root.

 (2) Destroying every entry in the anon list, one at a time.

 (3) Each entry in the anon list has its subtree consumed from the leaves
     inwards.

This reduces the amount of work generic_shutdown_super() does, and avoids
iterating through the dentry_unused list.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c            |  109 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/super.c             |    8 +---
 include/linux/dcache.h |    1 
 3 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 454b6af..31f2d8a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -549,6 +549,115 @@ repeat:
 }
 
 /*
+ * destroy a subtree of dentries for unmount
+ * - consumes a reference on the specified root dentry
+ * - called with the dcache_lock held, which it drops
+ *   - defend against the filesystem attempting to change the dentry tree
+ *     whilst we're trying to unmount it (it may be a network fs)
+ */
+static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
+{
+	struct dentry *parent;
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
+	for (;;) {
+		/* descend to the first leaf in the current subtree */
+		while (!list_empty(&dentry->d_subdirs)) {
+			/* this dentry has children - pin it whilst we dispose
+			 * of them */
+			atomic_inc(&dentry->d_count);
+			dentry = list_entry(dentry->d_subdirs.next,
+					    struct dentry, d_u.d_child);
+		}
+
+	consume_empty_leaf:
+		/* consume this leaf */
+		BUG_ON(atomic_read(&dentry->d_count) != 0);
+
+		spin_lock(&dentry->d_lock);
+
+		if (!list_empty(&dentry->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&dentry->d_lru);
+		}
+		__d_drop(dentry);
+
+		parent = dentry->d_parent;
+		if (parent == dentry)
+			parent = NULL;
+		else
+			atomic_dec(&parent->d_count);
+
+		list_del(&dentry->d_u.d_child);
+		dentry_stat.nr_dentry--;	/* For d_free, below */
+		dentry_iput(dentry);
+		d_free(dentry);
+
+		/* finished if fallen off top of tree */
+		if (!parent)
+			return;
+
+		/* ascend to parent and move to next leaf */
+		dentry = parent;
+
+		spin_lock(&dcache_lock);
+
+		if (list_empty(&dentry->d_subdirs)) {
+			/* the parent is now empty and can be itself
+			 * consumed */
+			atomic_dec(&dentry->d_count);
+			goto consume_empty_leaf;
+		}
+
+		dentry = list_entry(dentry->d_subdirs.next,
+				    struct dentry, d_u.d_child);
+	}
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
+	shrink_dcache_for_umount_subtree(dentry);
+
+	while (!hlist_empty(&sb->s_anon)) {
+		spin_lock(&dcache_lock);
+		if (!hlist_empty(&sb->s_anon)) {
+			dentry = hlist_entry(sb->s_anon.first,
+					     struct dentry, d_hash);
+			shrink_dcache_for_umount_subtree(dentry);
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
index 8a669f6..dc0f3c1 100644
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
