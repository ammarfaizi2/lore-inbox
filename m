Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUJZAbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUJZAbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUJYPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:01:15 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:52648 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261786AbUJYOoO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:44:14 -0400
Cc: raven@themaw.net
Subject: [PATCH 11/28] VFS: Allow for detachable subtrees
In-Reply-To: <10987154121124@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:44:02 -0400
Message-Id: <1098715442105@sun.com>
References: <10987154121124@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for having detached sub-tree of vfsmounts.  Detached
sub-trees of vfsmounts means we can now have trees that are not required to
have an associated struct namespace holding them together.  We call such a
subtree data structure a 'group'.

This is implemented by associated a new state to struct vfsmount, MNT_ISBASE.
This flag is used to determine whether or not a given vfsmount is the base of
a group.  When this flag is set, the vfsmount->mnt_group._count value stores
a an atomic count that reflects the number of all references to vfsmounts in
the tree, excluding those that used for group stitching (a child holds a
reference to a parent and vice-versa).  For any group of N vfsmounts, (N-1)*2
reference counts are used solely for holding them together.  Therefor the
invariant to this structure is: for any group with N vfsmounts, rooted at R,
R->mnt_group._count = (i->mnt_count for all i=1..N vfsmounts) - ((N - 1)*2).

In order to not have to walk up the tree each time we mntput/mntget to manage
this group count, we store a pointer to the base of the tree in
vfsmount->mnt_group._base in each vfsmount where !(vfsmount->mnt_flags &
MNT_ISBASE).  (The exercise of showing that we do not need to hold a
reference count to the base vfsmount in each node in the tree is left to the
reader).

Because we now are holding maintaining the reference counts in two different
places, they have to be synchronized in some way with actions that may
invalidate the vfsmount->mnt_group._base relationship.  The following
implementation uses a rwlock called vfsmountref_lock along with an atomic_t
group counter to do so.  The semantics of this lock are as follows:

 - To change the reference count of a vfsmount, one must take a read lock on
   vfsmountref_lock.  This keeps the mnt_group._base pointer from changing
   and ensures that the ->mnt_count values are consistent with the
   vfsmnt_base(mnt)->mnt_group._count value.
 - When a split or merge of the tree occurs, you need to take a write lock
   on vfsmountref_lock.  This keeps people from messing with the reference
   counts and ensures nobody is walking the mnt_group._base pointers.
 - To check to see if a given vfsmount is busy (->mnt_count == 1, implying
   it is a leaf), there is no need to take vfsmountref_lock.  You'd only do
   so with vfsmount_lock held, so you are sure nobody else can walk into it
   (current behaviour).

The actions of splitting off/attaching a group of vfsmounts from/to a tree
remains handled in detach_mnt and attach_mnt.  These work as before, but now
also take care of updating group counts.

When the group count for a given sub-tree hits zero, then we know that nobody
is holding a reference count to _any_ of the vfsmounts within the tree. When
this happens, we call __mntgroupput which unstitches the pieces of the tree,
and frees them.  For example, assume a user were to umount a filesystem from
his namespace.  A check would be made to see if the vfsmount in question had
->mnt_count == 2 (one for the parent->child reference and one for the calling
code's reference).  If so, the code will proceed to call detach_tree on the
vfsmount.  This call updates the base count on the namespace's group (which
would go down by one due to the reference to the unmounted filesystem leaving
it), and would mark the detached vfsmount with MNT_ISBASE with a
->mnt_group._count == 1.  When the umount syscall them drops the locks and
calls mntput on the given mountpoint, both it's mnt_count == 0 and
mnt_group._count == 0. The later invokes a call to __mntgroupput which walks
the group (which only has the one vfsmount) and calls __mntput on it to let
it release it's resource, decrement sb->count and so on.

One of the interesting side effects of this is that now when we do a lazy
umount of a tree of filesystems, we no longer need to break apart each
element of the tree.  It also allows us to implement a new interface that
allows for having sub-trees of mountpoints that aren't associated with any
namespace.  This would allow for process-specific sandboxes of filesystems
that are mounted yet not available in the process' namespace (implemented in
a later patch using mountpoint file descriptors).

One of the downsides to this implementation is that we grab a read on a
rwlock on _every_ mntget/mntput.  I looked into using a brlock, but
apparently those have been removed from the kernel a while ago.  I've thought
about how to do the same kind of synchronization using RCU, but haven't yet
figured out how to apply it to this kind of data-structure.  This patch
hasn't been tested for scalability in any sense.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c        |  276 +++++++++++++++++++++++++++++++++++++++-----------
 fs/super.c            |    1 
 include/linux/mount.h |   46 +++++++-
 3 files changed, 263 insertions(+), 60 deletions(-)

Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:38.338635784 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:38.881553248 -0400
@@ -38,6 +38,15 @@ static inline int sysfs_init(void)
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
+/*
+ * spinlock for mnt_group entries.  A write lock indicates that a sub-tree is
+ * being attached/detached and all reference count changes must wait until this
+ * is done.  As such, any vfsmount reference count changes must hold a read
+ * lock on vfsmountref_lock.
+ */
+rwlock_t vfsmountref_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+EXPORT_SYMBOL(vfsmountref_lock);
+
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
@@ -62,7 +71,9 @@ struct vfsmount *alloc_vfsmnt(const char
 	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
+		mnt->mnt_flags = MNT_ISBASE;
 		atomic_set(&mnt->mnt_count,1);
+		atomic_set(&mnt->mnt_group.count, 1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
@@ -137,24 +148,141 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
+/*
+ * detach_mnt breaks apart mnt from its parent.  Caller is expected to call this
+ * with a reference held on mnt, as well as an empty nameidata struct.  Once mnt
+ * is detached, the caller is responsible for dropping the references in
+ * nameidata as well as a reference to mnt, on top of the caller-owned
+ * reference to mnt.
+ *
+ * Called with namespace->sem held and vfsmount_lock held (if appropriate)
+ */
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
+	struct vfsmount *p;
+	long nmounts = 0, nrefs = 0;
+	long basecount;
+
+
+	/* save copy old mountpoint for delayed release */
+	old_nd->mnt    = mnt->mnt_parent;
 	old_nd->dentry = mnt->mnt_mountpoint;
-	old_nd->mnt = mnt->mnt_parent;
-	mnt->mnt_parent = mnt;
-	mnt->mnt_mountpoint = mnt->mnt_root;
+
+	/* undo mountpoint stitching */
 	list_del_init(&mnt->mnt_child);
 	list_del_init(&mnt->mnt_hash);
-	old_nd->dentry->d_mounted--;
+	mnt->mnt_parent = mnt;
+	mnt->mnt_mountpoint->d_mounted--;
+
+	/* messing with mount groups requires a write lock */
+	write_lock(&vfsmountref_lock);
+
+	/* mnt is now the root of it's own sub-tree */
+	mnt->mnt_flags |= MNT_ISBASE;
+
+	/* dissassociate sub-tree with parent namespace */
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		list_del_init(&p->mnt_list);
+		p->mnt_namespace = NULL;
+
+		/* point to mnt as the base of their sub-tree */
+		p->mnt_group.base = mnt;
+
+		/* count the number of mounts in the detached sub-tree */
+		nmounts++;
+
+		/* count the total number of refcounts in the sub-tree */
+		nrefs += atomic_read(&p->mnt_count);
+	}
+
+	/*
+	 * calculate the number of group-refs in the base sub-tree.
+	 *
+	 * Lemma: within a tree, 2 references are used for stitching
+	 * parent->child and child->parent for each child.
+	 * Therefore, the total count of references used for stitching in a tree
+	 * is the number of children times 2.  nmounts here represents the total
+	 * count of mountpoints, so nmounts - 1 is number of children within the
+	 * tree.
+	 * We subtract this value from nrefs to get the total number of refs not
+	 * used for stitching.
+	 */
+	basecount = nrefs - ((nmounts - 1) * 2);
+
+	/* set the new base counts in the child tree */
+	memset(&mnt->mnt_group.count, 0, sizeof(mnt->mnt_group.count));
+	atomic_set(&mnt->mnt_group.count, basecount);
+
+	/*
+	 * - the parent tree gets +1 because old_nd->mnt is the callers
+	 *   responsiblity to free.
+	 * - the parent tree gets another +1 because mnt is the callers
+	 *   responsibility to free as well.
+	 * These stem from the fact that we can't mntput the references
+	 * previously used for stitching because we are under spinlocks.
+	 */
+	atomic_sub(basecount - 2 , &vfsmnt_base(old_nd->mnt)->mnt_group.count);
+
+	write_unlock(&vfsmountref_lock);
 }
 
-static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
+/*
+ * attach_mnt attaches mountpoint mnt at the location given by nd.
+ * This should be called with a reference to mnt, as well as a reference to
+ * nd->mnt/dentry.  The reference to mnt is consumed by this call, however the
+ * references in nd are _not_ consumed.
+ *
+ * called with namespace->sem and vfsmount_lock held if appropriate
+ */
+static void attach_mnt (struct vfsmount *mnt, struct nameidata *nd)
 {
-	mnt->mnt_parent = mntget(nd->mnt);
+	struct vfsmount *p;
+	struct vfsmount *base;
+	struct namespace *namespace = nd->mnt->mnt_namespace;
+	long basecount;
+
+	/* do the stitching */
+	nd->dentry->d_mounted++;
+	mnt->mnt_parent     = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
-	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
-	nd->dentry->d_mounted++;
+	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
+
+	/* messing with mount groups requires a write lock */
+	write_lock(&vfsmountref_lock);
+
+	/* get a reference to the base of the subtree */
+	/* (protected by vfsmountref_lock) */
+	base = vfsmnt_base(nd->mnt);
+
+	/* mnt is no longer the base of its own subtree */
+	mnt->mnt_flags &= ~MNT_ISBASE;
+
+	/*
+	 * calculate the new base count.
+	 *
+	 * -1 because mnt is consumed by stitching
+	 * -1 because nd->mnt is consumed by stitching
+	 */
+	basecount = atomic_read(&base->mnt_group.count)
+	          + atomic_read(&mnt->mnt_group.count)
+		  - 2;
+
+
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+
+		/* update the base pointers */
+		p->mnt_group.base = base;
+
+		/* chain in the namespace of the parenting subtree */
+		p->mnt_namespace = namespace;
+		if (namespace)
+			list_add_tail(&p->mnt_list, &namespace->list);
+	}
+
+	atomic_set(&base->mnt_group.count, basecount);
+
+	write_unlock(&vfsmountref_lock);
 }
 
 /* this expects the caller to hold vfsmount_lock */
@@ -194,12 +322,13 @@ clone_mnt(struct vfsmount *old, struct d
 		} else {
 			mnt->mnt_flags = old->mnt_flags & ~MNT_CHILDEXPIRE;
 		}
+		mnt->mnt_flags |= MNT_ISBASE;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
-		mnt->mnt_namespace = old->mnt_namespace;
+		mnt->mnt_namespace = NULL;
 	}
 	return mnt;
 }
@@ -212,7 +341,49 @@ void __mntput(struct vfsmount *mnt)
 	deactivate_super(sb);
 }
 
-EXPORT_SYMBOL(__mntput);
+void __mntgroupput(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	LIST_HEAD(kill);
+
+
+	/*
+	 * We don't need to grab vfsmount_lock here because we are assured
+	 * that no-one holds a reference to us.
+	 * The kill list ordering depends on next_mnt doing a pre-order
+	 * traversal.
+	 */
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		p->mnt_namespace = NULL;
+		list_del(&p->mnt_list);
+		list_add(&p->mnt_list, &kill);
+	}
+
+	while (!list_empty(&kill)) {
+		struct nameidata old_nd;
+
+
+		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
+		WARN_ON(!list_empty(&mnt->mnt_mounts));
+
+		if (mnt == mnt->mnt_parent) {
+			WARN_ON(atomic_read(&mnt->mnt_count) != 0);
+			list_del_init(&mnt->mnt_list);
+			__mntput(mnt);
+		} else {
+			/* detach_mnt will clear mnt's mnt_list, however, we are
+			 * working on a depth_first pass, so this is okay */
+			detach_mnt(mnt, &old_nd);
+			/* we don't mntput because that would cause recursion */
+			atomic_dec(&old_nd.mnt->mnt_count);
+			dput(old_nd.dentry);
+			atomic_dec(&mnt->mnt_count);
+			WARN_ON(atomic_read(&mnt->mnt_count) != 0);
+			__mntput(mnt);
+		}
+	}
+}
+EXPORT_SYMBOL(__mntgroupput);
 
 /* iterator */
 static void *m_start(struct seq_file *m, loff_t *pos)
@@ -417,31 +588,18 @@ static void clear_expire(struct vfsmount
 	}
 }
 
+/* called with vfsmount_lock held */
 static void umount_tree(struct vfsmount *mnt)
 {
-	struct vfsmount *p;
-	LIST_HEAD(kill);
-
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		list_del(&p->mnt_list);
-		list_add(&p->mnt_list, &kill);
-	}
-
-	while (!list_empty(&kill)) {
-		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
-		list_del_init(&mnt->mnt_list);
-		list_del_init(&mnt->mnt_expire);
-		if (mnt->mnt_parent == mnt) {
-			spin_unlock(&vfsmount_lock);
-		} else {
-			struct nameidata old_nd;
-			detach_mnt(mnt, &old_nd);
-			spin_unlock(&vfsmount_lock);
-			path_release_on_umount(&old_nd);
-		}
-		_mntput(mnt);
-		spin_lock(&vfsmount_lock);
-	}
+	struct nameidata old_nd;
+	
+	list_del_init(&mnt->mnt_expire);
+	clear_childexpire(mnt);
+	detach_mnt(mnt, &old_nd);
+	spin_unlock(&vfsmount_lock);
+	path_release(&old_nd);	
+	mntput(mnt);
+	spin_lock(&vfsmount_lock);
 }
 
 static int do_umount(struct vfsmount *mnt, int flags)
@@ -506,14 +664,16 @@ static int do_umount(struct vfsmount *mn
 		security_sb_umount_close(mnt);
 		spin_lock(&vfsmount_lock);
 	}
+	retval = -EEXIST;
+	if (flags & MNT_DETACH && mnt->mnt_parent == mnt)
+		goto out;
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
-		if (!list_empty(&mnt->mnt_list)) {
-			clear_expire(mnt);
-			umount_tree(mnt);
-		}
+		clear_expire(mnt);
+		umount_tree(mnt);
 		retval = 0;
 	}
+out:
 	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
@@ -662,14 +822,23 @@ static int graft_tree(struct vfsmount *m
 	if (err)
 		goto out_unlock;
 
-	err = -ENOENT;
 	spin_lock(&vfsmount_lock);
+	err = -EEXIST;
+	if (mnt->mnt_parent != mnt) {
+		spin_unlock(&vfsmount_lock);
+		goto out_unlock;
+	}
+	read_lock(&vfsmountref_lock);
+	err = -ELOOP;
+	if (vfsmnt_base(nd->mnt) == mnt) {
+		read_unlock(&vfsmountref_lock);
+		spin_unlock(&vfsmount_lock);
+		goto out_unlock;
+	}
+	read_unlock(&vfsmountref_lock);
+	err = -ENOENT;
 	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
-		struct list_head head;
-
 		attach_mnt(mnt, nd);
-		list_add_tail(&head, &mnt->mnt_list);
-		list_splice(&head, current->namespace->list.prev);
 		mntget(mnt);
 		err = 0;
 	}
@@ -753,7 +922,7 @@ static int do_remount(struct nameidata *
 	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
 		nd->mnt->mnt_flags = mnt_flags | 
-		    (nd->mnt->mnt_flags & MNT_CHILDEXPIRE);
+		    (nd->mnt->mnt_flags & (MNT_CHILDEXPIRE | MNT_ISBASE));
 	up_write(&sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
@@ -843,7 +1012,7 @@ static int do_add_mount(struct nameidata
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	mnt->mnt_flags = mnt_flags;
+	mnt->mnt_flags = mnt_flags | MNT_ISBASE;
 	return do_graft_mount(mnt, nd);
 }
 
@@ -874,8 +1043,6 @@ int do_graft_mount(struct vfsmount *newm
 		goto unlock;
 
 	err = graft_tree(newmnt, nd);
-
-
 unlock:
 	up_write(&current->namespace->sem);
 	mntput(newmnt);
@@ -1213,9 +1380,9 @@ int copy_namespace(int flags, struct tas
 		kfree(new_ns);
 		goto out;
 	}
-	spin_lock(&vfsmount_lock);
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
-	spin_unlock(&vfsmount_lock);
+	list_for_each_entry(p, &new_ns->list, mnt_list)
+		p->mnt_namespace = new_ns;
 
 	/*
 	 * Second pass: switch the tsk->fs->* elements and mark new vfsmounts
@@ -1454,6 +1621,8 @@ asmlinkage long sys_pivot_root(const cha
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
+	mntget(user_nd.mnt);
+	mntget(new_nd.mnt);
 	detach_mnt(new_nd.mnt, &parent_nd);
 	detach_mnt(user_nd.mnt, &root_parent);
 	attach_mnt(user_nd.mnt, &old_nd);
@@ -1564,21 +1733,16 @@ void __init mnt_init(unsigned long mempa
 
 void __put_namespace(struct namespace *namespace)
 {
-	struct vfsmount *mnt;
-
 	down(&expiry_sem);
 	down_write(&namespace->sem);
 	spin_lock(&vfsmount_lock);
 
-	list_for_each_entry(mnt, &namespace->list, mnt_list) {
-		mnt->mnt_namespace = NULL;
-		mnt->mnt_flags &= ~MNT_CHILDEXPIRE;
-		list_del_init(&mnt->mnt_expire);
-	}
+	clear_expire(namespace->root);
 
-	umount_tree(namespace->root);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace->sem);
 	up(&expiry_sem);
+
+	mntput(namespace->root);
 	kfree(namespace);
 }
Index: linux-2.6.9-quilt/include/linux/mount.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/mount.h	2004-10-22 17:17:35.927002408 -0400
+++ linux-2.6.9-quilt/include/linux/mount.h	2004-10-22 17:17:38.881553248 -0400
@@ -18,6 +18,7 @@
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
 #define MNT_CHILDEXPIRE 8
+#define MNT_ISBASE	16
 
 struct vfsmount
 {
@@ -29,6 +30,10 @@ struct vfsmount
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
+	union {
+		struct vfsmount *base;	/* pointer to root of vfsmount tree */
+		atomic_t count;		/* user ref count on this tree */
+	} mnt_group;
 	int mnt_flags;
 	int mnt_active;			/* flag set on mntput() */
 	int mnt_expiry_countdown;	/* countdown of ticks until expiry */
@@ -39,10 +44,39 @@ struct vfsmount
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
+extern rwlock_t vfsmountref_lock;
+
+static inline struct vfsmount *vfsmnt_base(struct vfsmount *mnt) {
+	if (mnt->mnt_flags & MNT_ISBASE) {
+		return mnt;
+	}
+	return mnt->mnt_group.base;
+}
+
+static inline void mntgroupget(struct vfsmount *mnt)
+{
+	atomic_inc(&vfsmnt_base(mnt)->mnt_group.count);
+}
+
+extern void __mntgroupput(struct vfsmount *mnt);
+static inline struct vfsmount *mntgroupput(struct vfsmount *mnt)
+{
+	struct vfsmount *base;
+
+	base = vfsmnt_base(mnt);
+	if (atomic_dec_and_test(&base->mnt_group.count))
+		return base;
+	return NULL;
+}
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
-	if (mnt)
+	if (mnt) {
+		read_lock(&vfsmountref_lock);
 		atomic_inc(&mnt->mnt_count);
+		mntgroupget(mnt);
+		read_unlock(&vfsmountref_lock);
+	}
 	return mnt;
 }
 
@@ -50,9 +84,15 @@ extern void __mntput(struct vfsmount *mn
 
 static inline void _mntput(struct vfsmount *mnt)
 {
+	struct vfsmount *cleanup;
+	might_sleep();
 	if (mnt) {
-		if (atomic_dec_and_test(&mnt->mnt_count))
-			__mntput(mnt);
+		read_lock(&vfsmountref_lock);
+		cleanup = mntgroupput(mnt);
+		atomic_dec(&mnt->mnt_count);
+		read_unlock(&vfsmountref_lock);
+		if (cleanup)
+			__mntgroupput(cleanup);
 	}
 }
 
Index: linux-2.6.9-quilt/fs/super.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/super.c	2004-08-14 01:36:57.000000000 -0400
+++ linux-2.6.9-quilt/fs/super.c	2004-10-22 17:17:38.882553096 -0400
@@ -793,7 +793,6 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
-	mnt->mnt_namespace = current->namespace;
 	up_write(&sb->s_umount);
 	put_filesystem(type);
 	return mnt;

