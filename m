Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWFZLVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWFZLVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWFZLVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:21:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60862 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964997AbWFZLV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:21:28 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17567.31035.471039.999828@cse.unsw.edu.au> 
References: <17567.31035.471039.999828@cse.unsw.edu.au>  <17566.12727.489041.220653@cse.unsw.edu.au> <17564.52290.338084.934211@cse.unsw.edu.au> <15603.1150978967@warthog.cambridge.redhat.com> <553.1151156031@warthog.cambridge.redhat.com> <20946.1151251352@warthog.cambridge.redhat.com> 
To: Neil Brown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>, balbir@in.ibm.com, akpm@osdl.org,
       aviro@redhat.com, jblunck@suse.de, dev@openvz.org, olh@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 26 Jun 2006 12:21:00 +0100
Message-ID: <18192.1151320860@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:

> > I know they start out as root dentries, but are they required to stay so?
> 
> The 'anon' entries are linked together with d_hash

That's irrelevant.

> so if any anon entry were given a parent, it would also be given a name

That's an assumption, though it's probably valid.  I asked Al and he confirmed
that it is.

> and the d_hash would be used for something else.  So I think "yes- they are
> required to stay so".  It might not hurt to have a WARN_ON(!IS_ROOT())
> though.

That would have to be a BUG_ON().  The function does not unlink the initial
dentry from its parent if its parent is not a root.

> though the while() will do one extra (unneeded) test

Exactly.

> So the choice should be based on what makes the code clearest

You should avoid the extra test.

> Yes, I had glossed over that bit of reference counting.  I don't see a
> big problem with having an atomic_inc before the loop and an
> atomic_dec at the top, but I can see that others might not like it.

Imagine you have a directory with a few thousand file children.  With my code
as it is, you'll do one extra inc/dec for the directory.  With your
suggestion, you'll do a few thousand extra inc/decs.  Now these are (a) memory
ops, and (b) atomic ops, but it probably won't matter since you have to write
to the dentries anyway, but the fewer the better.

We don't *need* to do the extra inc/decs, so let's not.

Actually, I discussed this with Al, and he said that I can assume that the
filesystem is not permitted to rearrange its dentries once it calls
generic_shutdown_super().  This means I can reduce the locking and dispense
with the extra refcounts entirely, though I do have to fold in a cut-down copy
of dentry_iput() (no locks to drop, no inotify watches).

> > As long as the filesystem isn't trying to mangle the dentry tree whilst
> > we're trying to unmount it, nothing else will be mucking around with them
> > (now that shrink_dcache_memory() has been fixed).
> 
> That's a good reason.  I hadn't thought of that.  Thanks.

It seems I can make that assumption.  I've added comments to the header for
generic_shutdown_super() to that effect and put more header comments on
shrink_dcache_for_umount() to say why we can avoid the locking.

> If I asked really nicely, could you make consume_empty_leaf an infinite loop
> too?

It can now be a do-while loop since I've got rid of the atomic_dec().

So here's a new version.

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

 fs/dcache.c            |  120 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/super.c             |   12 ++---
 include/linux/dcache.h |    1 
 3 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 454b6af..89c7974 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -549,6 +549,126 @@ repeat:
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
+			BUG_ON(atomic_read(&dentry->d_count) != 0);
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
+				BUG_ON(!list_empty(&inode->inotify_watches));
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

