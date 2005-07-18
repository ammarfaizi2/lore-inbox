Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVGRHTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGRHTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGRHHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:07:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:4070 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261568AbVGRHHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:11 -0400
Message-Id: <20050718070701.542095000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:14 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 3/8] shared subtree
Content-Type: text/x-patch; name=rbind.patch
Content-Disposition: inline; filename=rbind.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the ability to bind/rbind a shared/private/slave subtree and set up
propogation wherever needed.

RP

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c            |  559 ++++++++++++++++++++++++++++++++++++++++------
 fs/pnode.c                |  416 +++++++++++++++++++++++++++++++++-
 include/linux/dcache.h    |    2 
 include/linux/fs.h        |    4 
 include/linux/namespace.h |    1 
 include/linux/pnode.h     |    5 
 6 files changed, 906 insertions(+), 81 deletions(-)

Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
@@ -42,7 +42,8 @@ static inline int sysfs_init(void)
 
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
-static kmem_cache_t *mnt_cache; 
+static kmem_cache_t *mnt_cache;
+static struct rw_semaphore namespace_sem;
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -54,7 +55,7 @@ static inline unsigned long hash(struct 
 
 struct vfsmount *alloc_vfsmnt(const char *name)
 {
-	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
+	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count,1);
@@ -86,7 +87,8 @@ void free_vfsmnt(struct vfsmount *mnt)
  * Now, lookup_mnt increments the ref count before returning
  * the vfsmount struct.
  */
-struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
+struct vfsmount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry,
+		struct dentry *root)
 {
 	struct list_head * head = mount_hashtable + hash(mnt, dentry);
 	struct list_head * tmp = head;
@@ -99,7 +101,8 @@ struct vfsmount *lookup_mnt(struct vfsmo
 		if (tmp == head)
 			break;
 		p = list_entry(tmp, struct vfsmount, mnt_hash);
-		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
+		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry &&
+				(root == NULL || p->mnt_root == root)) {
 			found = mntget(p);
 			break;
 		}
@@ -108,6 +111,37 @@ struct vfsmount *lookup_mnt(struct vfsmo
 	return found;
 }
 
+struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
+{
+	return __lookup_mnt(mnt, dentry, NULL);
+}
+
+static struct vfsmount *
+clone_mnt(struct vfsmount *old, struct dentry *root)
+{
+	struct super_block *sb = old->mnt_sb;
+	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
+
+	if (mnt) {
+		mnt->mnt_flags = old->mnt_flags;
+		atomic_inc(&sb->s_active);
+		mnt->mnt_sb = sb;
+		mnt->mnt_root = dget(root);
+		mnt->mnt_mountpoint = mnt->mnt_root;
+		mnt->mnt_parent = mnt;
+		mnt->mnt_namespace = old->mnt_namespace;
+		mnt->mnt_pnode = get_pnode(old->mnt_pnode);
+
+		/* stick the duplicate mount on the same expiry list
+		 * as the original if that was on one */
+		spin_lock(&vfsmount_lock);
+		if (!list_empty(&old->mnt_fslink))
+			list_add(&mnt->mnt_fslink, &old->mnt_fslink);
+		spin_unlock(&vfsmount_lock);
+	}
+	return mnt;
+}
+
 static inline int check_mnt(struct vfsmount *mnt)
 {
 	return mnt->mnt_namespace == current->namespace;
@@ -128,11 +162,70 @@ static void attach_mnt(struct vfsmount *
 {
 	mnt->mnt_parent = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
+	mnt->mnt_namespace = nd->mnt->mnt_namespace;
 	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
 }
 
+static struct vfsmount *do_attach_mnt(struct vfsmount *mnt,
+		struct dentry *dentry,
+		struct vfsmount *child_mnt)
+{
+	struct nameidata nd;
+	LIST_HEAD(head);
+
+	nd.mnt = mnt;
+	nd.dentry = dentry;
+	attach_mnt(child_mnt, &nd);
+	list_add_tail(&head, &child_mnt->mnt_list);
+	list_splice(&head, child_mnt->mnt_namespace->list.prev);
+	return child_mnt;
+}
+
+static void attach_prepare_mnt(struct vfsmount *mnt, struct nameidata *nd)
+{
+	mnt->mnt_parent = mntget(nd->mnt);
+	mnt->mnt_mountpoint = dget(nd->dentry);
+	nd->dentry->d_mounted++;
+}
+
+void do_attach_real_mnt(struct vfsmount *mnt)
+{
+	struct vfsmount *parent = mnt->mnt_parent;
+	BUG_ON(parent==mnt);
+	if(list_empty(&mnt->mnt_hash))
+		list_add(&mnt->mnt_hash,
+			mount_hashtable+hash(parent, mnt->mnt_mountpoint));
+	if(list_empty(&mnt->mnt_child))
+		list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
+	mnt->mnt_namespace = parent->mnt_namespace;
+	list_add_tail(&mnt->mnt_list, &mnt->mnt_namespace->list);
+}
+
+struct vfsmount *do_attach_prepare_mnt(struct vfsmount *mnt,
+		struct dentry *dentry,
+		struct vfsmount *template_mnt,
+		int clone_flag)
+{
+	struct vfsmount *child_mnt;
+	struct nameidata nd;
+
+	if (clone_flag) {
+		if(!(child_mnt = clone_mnt(template_mnt,
+				template_mnt->mnt_root)))
+			return NULL;
+	} else
+		child_mnt = template_mnt;
+
+	nd.mnt = mnt;
+	nd.dentry = dentry;
+
+	attach_prepare_mnt(child_mnt, &nd);
+
+	return child_mnt;
+}
+
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
 {
 	struct list_head *next = p->mnt_mounts.next;
@@ -149,29 +242,14 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+static struct vfsmount *skip_mnt_tree(struct vfsmount *p)
 {
-	struct super_block *sb = old->mnt_sb;
-	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
-
-	if (mnt) {
-		mnt->mnt_flags = old->mnt_flags;
-		atomic_inc(&sb->s_active);
-		mnt->mnt_sb = sb;
-		mnt->mnt_root = dget(root);
-		mnt->mnt_mountpoint = mnt->mnt_root;
-		mnt->mnt_parent = mnt;
-		mnt->mnt_namespace = old->mnt_namespace;
-
-		/* stick the duplicate mount on the same expiry list
-		 * as the original if that was on one */
-		spin_lock(&vfsmount_lock);
-		if (!list_empty(&old->mnt_fslink))
-			list_add(&mnt->mnt_fslink, &old->mnt_fslink);
-		spin_unlock(&vfsmount_lock);
+	struct list_head *prev = p->mnt_mounts.prev;
+	while (prev != &p->mnt_mounts) {
+		p = list_entry(prev, struct vfsmount, mnt_child);
+		prev = p->mnt_mounts.prev;
 	}
-	return mnt;
+	return p;
 }
 
 void __mntput(struct vfsmount *mnt)
@@ -191,7 +269,7 @@ static void *m_start(struct seq_file *m,
 	struct list_head *p;
 	loff_t l = *pos;
 
-	down_read(&n->sem);
+	down_read(&namespace_sem);
 	list_for_each(p, &n->list)
 		if (!l--)
 			return list_entry(p, struct vfsmount, mnt_list);
@@ -208,8 +286,7 @@ static void *m_next(struct seq_file *m, 
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct namespace *n = m->private;
-	up_read(&n->sem);
+	up_read(&namespace_sem);
 }
 
 static inline void mangle(struct seq_file *m, const char *s)
@@ -433,7 +510,7 @@ static int do_umount(struct vfsmount *mn
 		return retval;
 	}
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 
 	if (atomic_read(&sb->s_active) == 1) {
@@ -455,7 +532,7 @@ static int do_umount(struct vfsmount *mn
 	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	return retval;
 }
 
@@ -495,9 +572,9 @@ out:
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
- *	The 2.0 compatible umount. No flags. 
+ *	The 2.0 compatible umount. No flags.
  */
- 
+
 asmlinkage long sys_oldumount(char __user * name)
 {
 	return sys_umount(name,0);
@@ -541,6 +618,9 @@ static struct vfsmount *copy_tree(struct
 	struct list_head *h;
 	struct nameidata nd;
 
+	if (IS_MNT_UNCLONE(mnt))
+		return NULL;
+
 	res = q = clone_mnt(mnt, dentry);
 	if (!q)
 		goto Enomem;
@@ -549,10 +629,15 @@ static struct vfsmount *copy_tree(struct
 	p = mnt;
 	for (h = mnt->mnt_mounts.next; h != &mnt->mnt_mounts; h = h->next) {
 		r = list_entry(h, struct vfsmount, mnt_child);
+
 		if (!lives_below_in_same_fs(r->mnt_mountpoint, dentry))
 			continue;
 
 		for (s = r; s; s = next_mnt(s, r)) {
+			if (IS_MNT_UNCLONE(s)) {
+				s = skip_mnt_tree(s);
+				continue;
+			}
 			while (p != s->mnt_parent) {
 				p = p->mnt_parent;
 				q = q->mnt_parent;
@@ -579,9 +664,179 @@ static struct vfsmount *copy_tree(struct
 	return NULL;
 }
 
+ /*
+ *  @source_mnt : mount tree to be attached
+ *  @nd		: place the mount tree @source_mnt is attached
+ *
+ *  NOTE: in the table below explains the semantics when a source vfsmount
+ *  of a given type is attached to a destination vfsmount of a give type.
+ *  ---------------------------------------------------------------------
+ *  |				BIND MOUNT OPERATION			|
+ *  |*******************************************************************|
+ *  |  dest --> | shared	|	private	 |  slave   |unclonable	|
+ *  | source	|		|       	 |   	    |    	|
+ *  |   |   	|		|       	 |   	    |    	|
+ *  |   v 	|		|       	 |   	    |    	|
+ *  |*******************************************************************|
+ *  |	     	|		|       	 |   	    |    	|
+ *  |  shared	| shared (++) 	|      shared (+)|shared (+)| shared (+)|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *  | private	| shared (+)	|      private	 | private  | private  	|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *  | slave	| shared (+)	|      private   | private  | private  	|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *  | unclonable|    -		|       -	 |   -	    |   - 	|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *   ********************************************************************
+ *
+ * (++)  the mount will be propogated to all the vfsmounts in the pnode tree
+ *    	  of the destination vfsmount, and all the non-slave new mounts in
+ *    	  destination vfsmount will be added the source vfsmount's pnode.
+ * (+)  the mount will be propogated to the destination vfsmount
+ *    	  and the new mount will be added to the source vfsmount's pnode.
+ *
+ * if the source mount is a tree, the operations explained above is
+ * applied to each
+ * vfsmount in the tree.
+ *
+ * Should be called without spinlocks held, because this function can sleep
+ * in allocations.
+ *
+  */
+static int attach_recursive_mnt(struct vfsmount *source_mnt,
+		struct nameidata *nd)
+{
+	struct vfsmount *mntpt_mnt, *m, *p;
+	struct vfspnode *src_pnode, *t_p, *dest_pnode, *tmp_pnode;
+	struct dentry *mntpt_dentry;
+	int ret;
+	LIST_HEAD(pnodehead);
+
+	mntpt_mnt = nd->mnt;
+	dest_pnode = IS_MNT_SHARED(mntpt_mnt) ? mntpt_mnt->mnt_pnode : NULL;
+	src_pnode = IS_MNT_SHARED(source_mnt) ? source_mnt->mnt_pnode : NULL;
+
+	if (!dest_pnode && !src_pnode) {
+		LIST_HEAD(head);
+		spin_lock(&vfsmount_lock);
+		do_attach_mnt(nd->mnt, nd->dentry, source_mnt);
+		spin_unlock(&vfsmount_lock);
+		goto out;
+	}
+
+	/*
+	 * Ok, the source or the destination pnode exists.
+	 * Get ready for pnode operations.
+	 * Create a temporary pnode which shall hold all the
+	 * new mounts. Merge or delete or slave that pnode
+	 * later in a separate operation, depending on
+	 * the type of source and destination mounts.
+	 */
+	p = NULL;
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		int unclone = IS_MNT_UNCLONE(m);
+
+		list_del_init(&m->mnt_list);
+
+		while (p && p != m->mnt_parent)
+			p = p->mnt_parent;
+
+		if (!p) {
+			mntpt_dentry = nd->dentry;
+			mntpt_mnt = nd->mnt;
+		} else {
+			mntpt_dentry = m->mnt_mountpoint;
+			mntpt_mnt    = p;
+		}
+
+		p=m;
+		dest_pnode = IS_MNT_SHARED(mntpt_mnt) ?
+			mntpt_mnt->mnt_pnode : NULL;
+		src_pnode = (IS_MNT_SHARED(m))?
+				m->mnt_pnode : NULL;
+
+		m->mnt_pnode = NULL;
+		/*
+		 * get a temporary pnode into which add the new vfs, and keep
+		 * track of these pnodes and their real pnode.
+		 */
+		if (!(tmp_pnode = pnode_alloc()))
+			return -ENOMEM;
+
+
+		if (dest_pnode && !unclone) {
+			if ((ret = pnode_prepare_mount(dest_pnode, tmp_pnode,
+					mntpt_dentry, m, mntpt_mnt)))
+				return ret;
+		} else {
+			if (m == m->mnt_parent)
+				do_attach_prepare_mnt(mntpt_mnt,
+					mntpt_dentry, m, 0);
+			pnode_add_member_mnt(tmp_pnode, m);
+			if (unclone) {
+				set_mnt_unclone(m);
+				m->mnt_pnode = tmp_pnode;
+				SET_PNODE_DELETE(tmp_pnode);
+			} else if (!src_pnode) {
+				set_mnt_private(m);
+				m->mnt_pnode = tmp_pnode;
+				SET_PNODE_DELETE(tmp_pnode);
+			}
+			/*
+			 * NOTE: set_mnt_private() or
+			 * set_mnt_unclone() resets the
+			 * m->mnt_pnode information.
+			 * reinitialize it.  This is needed to
+			 * decrement the refcount on the
+			 * pnode when * the mount 'm' is
+			 * unlinked in * pnode_real_mount().
+			 */
+		}
+
+		tmp_pnode->pnode_master = src_pnode;
+		/*
+		 * temporarily track the pnode with which the tmp_pnode
+		 * has to merge with; in the pnode_master field.
+		 */
+		list_add_tail(&tmp_pnode->pnode_peer_slave, &pnodehead);
+	}
+
+	/*
+	 * new mounts. Merge or delete or slave the temporary pnode
+	 */
+	spin_lock(&vfsmount_lock);
+	list_for_each_entry_safe(tmp_pnode, t_p, &pnodehead, pnode_peer_slave) {
+		int del_flag = IS_PNODE_DELETE(tmp_pnode);
+		struct vfspnode *master_pnode = tmp_pnode->pnode_master;
+		list_del_init(&tmp_pnode->pnode_peer_slave);
+		pnode_real_mount(tmp_pnode, del_flag);
+		if (!del_flag && master_pnode) {
+			tmp_pnode->pnode_master = NULL;
+			pnode_merge_pnode(tmp_pnode, master_pnode);
+			/*
+			 * we don't need the extra reference to
+			 * the master_pnode, that was created either
+			 * (a) pnode_add_slave_pnode: when the mnt was made as
+			 * 		a slave mnt.
+			 * (b) pnode_merge_pnode: during clone_mnt().
+			 */
+			put_pnode(master_pnode);
+		}
+	}
+	spin_unlock(&vfsmount_lock);
+out:
+	mntget(source_mnt);
+	return 0;
+}
+
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
-	int err;
+	int err, ret;
+
 	if (mnt->mnt_sb->s_flags & MS_NOUSER)
 		return -EINVAL;
 
@@ -599,17 +854,12 @@ static int graft_tree(struct vfsmount *m
 		goto out_unlock;
 
 	err = -ENOENT;
-	spin_lock(&vfsmount_lock);
-	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
-		struct list_head head;
 
-		attach_mnt(mnt, nd);
-		list_add_tail(&head, &mnt->mnt_list);
-		list_splice(&head, current->namespace->list.prev);
-		mntget(mnt);
-		err = 0;
-	}
+	spin_lock(&vfsmount_lock);
+	ret = (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry));
 	spin_unlock(&vfsmount_lock);
+	if (ret)
+		err = attach_recursive_mnt(mnt, nd);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
@@ -686,6 +936,146 @@ static int do_make_unclone(struct vfsmou
 	return 0;
 }
 
+ /*
+ * This operation is equivalent of mount --bind dir dir
+ * create a new mount at the dentry, and unmount all child mounts
+ * mounted on top of dentries below 'dentry', and mount them
+ * under the new mount.
+  */
+struct vfsmount *do_make_mounted(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct vfsmount *child_mnt, *next;
+	struct nameidata nd;
+	struct vfsmount *newmnt = clone_mnt(mnt, dentry);
+	LIST_HEAD(move);
+
+	/*
+	 * note clone_mnt() gets a reference to the pnode.
+	 * we won't use that pnode anyway. So just let it
+	 * go
+	 */
+	put_pnode(newmnt->mnt_pnode);
+	newmnt->mnt_pnode = NULL;
+
+	if (newmnt) {
+		/*
+		 * walk through the mount list of mnt and move
+		 * them under the new mount
+		 */
+		spin_lock(&vfsmount_lock);
+		list_del_init(&newmnt->mnt_fslink);
+
+		list_for_each_entry_safe(child_mnt, next,
+				&mnt->mnt_mounts, mnt_child) {
+
+			if(child_mnt->mnt_mountpoint == dentry)
+				continue;
+
+			if(!is_subdir(child_mnt->mnt_mountpoint, dentry))
+				continue;
+
+			detach_mnt(child_mnt, &nd);
+			nd.mnt = newmnt;
+			attach_mnt(child_mnt, &nd);
+		}
+
+		nd.mnt = mnt;
+		nd.dentry = dentry;
+		do_attach_mnt(nd.mnt, nd.dentry, newmnt);
+ 		spin_unlock(&vfsmount_lock);
+ 	}
+	return newmnt;
+}
+
+ /*
+ * Inverse operation of do_make_mounted()
+  */
+int do_make_unmounted(struct vfsmount *mnt)
+{
+	struct vfsmount *parent_mnt, *child_mnt, *next;
+	struct nameidata nd;
+
+	/* validate if mount has a different parent */
+	parent_mnt = mnt->mnt_parent;
+	if (mnt == parent_mnt)
+		return 0;
+	/*
+	 * cannot unmount a mount that is not created
+	 * as a overlay mount.
+	 */
+	if (mnt->mnt_mountpoint != mnt->mnt_root)
+		return -EINVAL;
+
+	/* for each submounts in the parent, put the mounts back */
+	spin_lock(&vfsmount_lock);
+	list_for_each_entry_safe(child_mnt, next, &mnt->mnt_mounts, mnt_child) {
+		detach_mnt(child_mnt, &nd);
+		nd.mnt = parent_mnt;
+		attach_mnt(child_mnt, &nd);
+ 	}
+	detach_mnt(mnt, &nd);
+ 	spin_unlock(&vfsmount_lock);
+	return 0;
+}
+
+/*
+ * @nd: contains the vfsmount and the dentry where the new mount
+ * 	is the be created
+ * @mnt: returns the newly created mount.
+ * Create a new mount at the location specified by 'nd' and
+ * propogate the mount to all other mounts if the mountpoint
+ * is under a shared mount.
+ */
+int make_mounted(struct nameidata *nd, struct vfsmount **mnt)
+{
+	struct vfsmount *parent_mnt;
+	struct dentry *parent_dentry;
+	int err = mount_is_safe(nd);
+	if (err)
+		return err;
+	parent_dentry = nd->dentry;
+	parent_mnt = nd->mnt;
+ 	/*
+	 * check if dentry already has a vfsmount
+	 * if it does not, create and attach
+	 * a new vfsmount at that dentry.
+	 * Also propogate the mount if parent_mnt
+	 * is shared.
+ 	 */
+	if(parent_dentry != parent_mnt->mnt_root) {
+		*mnt = IS_MNT_SHARED(parent_mnt) ?
+			 pnode_make_mounted(parent_mnt->mnt_pnode,
+					 parent_mnt, parent_dentry) :
+			 do_make_mounted(parent_mnt, parent_dentry);
+		if (!*mnt)
+			err = -ENOMEM;
+ 	} else
+		*mnt = parent_mnt;
+	return err;
+}
+
+ /*
+ * Inverse operation of make_mounted()
+  */
+int make_unmounted(struct vfsmount *mnt)
+{
+	if (mnt == mnt->mnt_parent)
+		return 0;
+	/*
+	 * cannot unmount a mount that is not created
+	 * as a overlay mount.
+	 */
+	if (mnt->mnt_mountpoint != mnt->mnt_root)
+		return -EINVAL;
+
+	if (IS_MNT_SHARED(mnt))
+		pnode_make_unmounted(mnt->mnt_pnode);
+ 	else
+		do_make_unmounted(mnt);
+
+	return 0;
+}
+
 /*
  * recursively change the type of the mountpoint.
  */
@@ -729,7 +1119,7 @@ static int do_change_type(struct nameida
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
 	struct nameidata old_nd;
-	struct vfsmount *mnt = NULL;
+	struct vfsmount *mnt = NULL, *overlay_mnt=NULL;
 	int err = mount_is_safe(nd);
 	if (err)
 		return err;
@@ -739,14 +1129,31 @@ static int do_loopback(struct nameidata 
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	if (IS_MNT_UNCLONE(old_nd.mnt)) {
+		err = -EINVAL;
+		goto path_release;
+	}
+
+	down_write(&namespace_sem);
 	err = -EINVAL;
 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
+
+		/*
+		 * If the dentry is not the root dentry, and if a bind
+		 * from a shared subtree is attempted, create a mount
+		 * at the dentry, and use the new mount as the starting
+		 * point for the bind/rbind operation.
+		 */
+		overlay_mnt = old_nd.mnt;
+		if(IS_MNT_SHARED(old_nd.mnt) &&
+			(err = make_mounted(&old_nd, &overlay_mnt)))
+			goto out;
+
 		err = -ENOMEM;
 		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+			mnt = copy_tree(overlay_mnt, old_nd.dentry);
 		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+			mnt = clone_mnt(overlay_mnt, old_nd.dentry);
 	}
 
 	if (mnt) {
@@ -757,15 +1164,25 @@ static int do_loopback(struct nameidata 
 
 		err = graft_tree(mnt, nd);
 		if (err) {
-			spin_lock(&vfsmount_lock);
-			umount_tree(mnt);
-			spin_unlock(&vfsmount_lock);
-		} else
-			mntput(mnt);
-	}
+ 			spin_lock(&vfsmount_lock);
+ 			umount_tree(mnt);
+ 			spin_unlock(&vfsmount_lock);
+			/*
+			 * ok we failed! so undo any overlay
+			 * mount that we did earlier.
+			 */
+			if (old_nd.mnt !=  overlay_mnt)
+				make_unmounted(overlay_mnt);
+ 		} else
+ 			mntput(mnt);
+ 	}
+
+ out:
+	up_write(&namespace_sem);
+
+ path_release:
+ 	path_release(&old_nd);
 
-	up_write(&current->namespace->sem);
-	path_release(&old_nd);
 	return err;
 }
 
@@ -813,7 +1230,7 @@ static int do_move_mount(struct nameidat
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 	err = -EINVAL;
@@ -857,7 +1274,7 @@ out2:
 out1:
 	up(&nd->dentry->d_inode->i_sem);
 out:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	if (!err)
 		path_release(&parent_nd);
 	path_release(&old_nd);
@@ -896,7 +1313,7 @@ int do_add_mount(struct vfsmount *newmnt
 {
 	int err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
@@ -925,7 +1342,7 @@ int do_add_mount(struct vfsmount *newmnt
 	}
 
 unlock:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	mntput(newmnt);
 	return err;
 }
@@ -981,7 +1398,7 @@ void mark_mounts_for_expiry(struct list_
 		get_namespace(namespace);
 
 		spin_unlock(&vfsmount_lock);
-		down_write(&namespace->sem);
+		down_write(&namespace_sem);
 		spin_lock(&vfsmount_lock);
 
 		/* check that it is still dead: the count should now be 2 - as
@@ -1025,7 +1442,7 @@ void mark_mounts_for_expiry(struct list_
 			spin_unlock(&vfsmount_lock);
 		}
 
-		up_write(&namespace->sem);
+		up_write(&namespace_sem);
 
 		mntput(mnt);
 		put_namespace(namespace);
@@ -1071,7 +1488,7 @@ int copy_mount_options(const void __user
 	int i;
 	unsigned long page;
 	unsigned long size;
-	
+
 	*where = 0;
 	if (!data)
 		return 0;
@@ -1090,7 +1507,7 @@ int copy_mount_options(const void __user
 
 	i = size - exact_copy_from_user((void *)page, data, size);
 	if (!i) {
-		free_page(page); 
+		free_page(page);
 		return -EFAULT;
 	}
 	if (i != PAGE_SIZE)
@@ -1196,14 +1613,13 @@ int copy_namespace(int flags, struct tas
 		goto out;
 
 	atomic_set(&new_ns->count, 1);
-	init_rwsem(&new_ns->sem);
 	INIT_LIST_HEAD(&new_ns->list);
 
-	down_write(&tsk->namespace->sem);
+	down_write(&namespace_sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
 	if (!new_ns->root) {
-		up_write(&tsk->namespace->sem);
+		up_write(&namespace_sem);
 		kfree(new_ns);
 		goto out;
 	}
@@ -1237,7 +1653,7 @@ int copy_namespace(int flags, struct tas
 		p = next_mnt(p, namespace->root);
 		q = next_mnt(q, new_ns->root);
 	}
-	up_write(&tsk->namespace->sem);
+	up_write(&namespace_sem);
 
 	tsk->namespace = new_ns;
 
@@ -1419,7 +1835,7 @@ asmlinkage long sys_pivot_root(const cha
 	user_nd.mnt = mntget(current->fs->rootmnt);
 	user_nd.dentry = dget(current->fs->root);
 	read_unlock(&current->fs->lock);
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	down(&old_nd.dentry->d_inode->i_sem);
 	error = -EINVAL;
 	if (!check_mnt(user_nd.mnt))
@@ -1465,7 +1881,7 @@ asmlinkage long sys_pivot_root(const cha
 	path_release(&parent_nd);
 out2:
 	up(&old_nd.dentry->d_inode->i_sem);
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	path_release(&user_nd);
 	path_release(&old_nd);
 out1:
@@ -1492,7 +1908,6 @@ static void __init init_mount_tree(void)
 		panic("Can't allocate initial namespace");
 	atomic_set(&namespace->count, 1);
 	INIT_LIST_HEAD(&namespace->list);
-	init_rwsem(&namespace->sem);
 	list_add(&mnt->mnt_list, &namespace->list);
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
@@ -1515,6 +1930,8 @@ void __init mnt_init(unsigned long mempa
 	unsigned int nr_hash;
 	int i;
 
+	init_rwsem(&namespace_sem);
+
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
@@ -1562,7 +1979,7 @@ void __put_namespace(struct namespace *n
 {
 	struct vfsmount *mnt;
 
-	down_write(&namespace->sem);
+	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 
 	list_for_each_entry(mnt, &namespace->list, mnt_list) {
@@ -1571,6 +1988,6 @@ void __put_namespace(struct namespace *n
 
 	umount_tree(namespace->root);
 	spin_unlock(&vfsmount_lock);
-	up_write(&namespace->sem);
+	up_write(&namespace_sem);
 	kfree(namespace);
 }
Index: 2.6.12.work1/fs/pnode.c
===================================================================
--- 2.6.12.work1.orig/fs/pnode.c
+++ 2.6.12.work1/fs/pnode.c
@@ -26,6 +26,10 @@
 #include <asm/unistd.h>
 #include <stdarg.h>
 
+enum pnode_vfs_type {
+	PNODE_MEMBER_VFS = 0x01,
+	PNODE_SLAVE_VFS = 0x02
+};
 
 static kmem_cache_t * pnode_cachep;
 
@@ -78,6 +82,72 @@ void __put_pnode(struct vfspnode *pnode)
 	} while(pnode);
 }
 
+struct pcontext {
+	struct vfspnode *start;
+	int	level;
+	struct vfspnode *master_pnode;
+	struct vfspnode *pnode;
+};
+
+/*
+ * Walk the pnode tree for each pnode encountered.
+ * @context: provides context on the state of the last walk in the pnode
+ * 		tree.
+ */
+static int pnode_next(struct pcontext *context)
+{
+	struct vfspnode *pnode = context->pnode;
+	struct vfspnode	*master_pnode=context->master_pnode;
+	struct list_head *next;
+
+	if (!pnode) {
+		BUG_ON(!context->start);
+		get_pnode(context->start);
+		context->pnode = context->start;
+		context->master_pnode = NULL;
+		context->level = 0;
+		return 1;
+	}
+
+	spin_lock(&vfspnode_lock);
+	next = pnode->pnode_slavepnode.next;
+	if (next == &pnode->pnode_slavepnode) {
+		while (1) {
+			int flag;
+
+			if (pnode == context->start) {
+				put_pnode_locked(pnode);
+				spin_unlock(&vfspnode_lock);
+				BUG_ON(context->level != 0);
+				return 0;
+			}
+
+			next = pnode->pnode_peer_slave.next;
+			flag = (next != &pnode->pnode_master->pnode_slavepnode);
+			put_pnode_locked(pnode);
+
+			if (flag)
+				break;
+
+			pnode = master_pnode;
+			master_pnode = pnode->pnode_master;
+			context->level--;
+		}
+	} else {
+		master_pnode = pnode;
+		context->level++;
+	}
+
+	pnode = list_entry(next, struct vfspnode, pnode_peer_slave);
+	get_pnode(pnode);
+
+	context->pnode = pnode;
+	context->master_pnode = master_pnode;
+	spin_unlock(&vfspnode_lock);
+	return 1;
+}
+
+
 static void inline pnode_add_mnt(struct vfspnode *pnode,
 		struct vfsmount *mnt, int slave)
 {
@@ -87,10 +157,12 @@ static void inline pnode_add_mnt(struct 
 	mnt->mnt_pnode = pnode;
 	if (slave) {
 		set_mnt_slave(mnt);
-		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_slavevfs);
+		list_add(&mnt->mnt_pnode_mntlist,
+				&pnode->pnode_slavevfs);
 	} else {
 		set_mnt_shared(mnt);
-		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_vfs);
+		list_add(&mnt->mnt_pnode_mntlist,
+				&pnode->pnode_vfs);
 	}
 	get_pnode(pnode);
 	spin_unlock(&vfspnode_lock);
@@ -108,7 +180,6 @@ void pnode_add_slave_mnt(struct vfspnode
 	pnode_add_mnt(pnode, mnt, 1);
 }
 
-
 void pnode_add_slave_pnode(struct vfspnode *pnode,
 		struct vfspnode *slave_pnode)
 {
@@ -117,12 +188,13 @@ void pnode_add_slave_pnode(struct vfspno
 	spin_lock(&vfspnode_lock);
 	slave_pnode->pnode_master = pnode;
 	slave_pnode->pnode_flags = 0;
-	list_add(&slave_pnode->pnode_peer_slave, &pnode->pnode_slavepnode);
+	list_add(&slave_pnode->pnode_peer_slave,
+			&pnode->pnode_slavepnode);
 	get_pnode(pnode);
 	spin_unlock(&vfspnode_lock);
 }
 
-static void _pnode_disassociate_mnt(struct vfsmount *mnt)
+static inline void __pnode_disassociate_mnt(struct vfsmount *mnt)
 {
 	spin_lock(&vfspnode_lock);
 	list_del_init(&mnt->mnt_pnode_mntlist);
@@ -135,7 +207,7 @@ void pnode_del_slave_mnt(struct vfsmount
 {
 	if (!mnt)
 		return;
- 	_pnode_disassociate_mnt(mnt);
+ 	__pnode_disassociate_mnt(mnt);
 	CLEAR_MNT_SLAVE(mnt);
 }
 
@@ -143,16 +215,342 @@ void pnode_del_member_mnt(struct vfsmoun
 {
 	if (!mnt)
 		return;
- 	_pnode_disassociate_mnt(mnt);
+ 	__pnode_disassociate_mnt(mnt);
 	CLEAR_MNT_SHARED(mnt);
 }
 
-
 void pnode_disassociate_mnt(struct vfsmount *mnt)
 {
 	if (!mnt)
 		return;
- 	_pnode_disassociate_mnt(mnt);
+ 	__pnode_disassociate_mnt(mnt);
 	CLEAR_MNT_SHARED(mnt);
 	CLEAR_MNT_SLAVE(mnt);
 }
+
+// merge pnode into peer_pnode and get rid of pnode
+int pnode_merge_pnode(struct vfspnode *pnode, struct vfspnode *peer_pnode)
+{
+	struct vfspnode *slave_pnode, *pnext;
+	struct vfsmount *mnt, *slave_mnt, *next;
+	int i,count;
+
+	spin_lock(&vfspnode_lock);
+	list_for_each_entry_safe(slave_pnode,  pnext,
+			&pnode->pnode_slavepnode, pnode_peer_slave) {
+		slave_pnode->pnode_master = peer_pnode;
+		list_move(&slave_pnode->pnode_peer_slave,
+				&peer_pnode->pnode_slavepnode);
+	}
+
+	list_for_each_entry_safe(slave_mnt,  next,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+		slave_mnt->mnt_pnode = peer_pnode;
+		list_move(&slave_mnt->mnt_pnode_mntlist,
+				&peer_pnode->pnode_slavevfs);
+	}
+
+	list_for_each_entry_safe(mnt, next,
+			&pnode->pnode_vfs, mnt_pnode_mntlist) {
+		mnt->mnt_pnode = peer_pnode;
+		list_move(&mnt->mnt_pnode_mntlist,
+				&peer_pnode->pnode_vfs);
+	}
+
+	count = atomic_read(&pnode->pnode_count);
+	atomic_add(count, &peer_pnode->pnode_count);
+
+	/*
+	 * delete all references to 'pnode'.
+	 * A better implementation can simply
+	 * call free_pnode(pnode). But this is
+	 * a cleaner way of doing it. Offcourse
+	 * with some cost.
+	 */
+	for (i=0 ; i <count; i++)
+		put_pnode_unlocked(pnode);
+	spin_unlock(&vfspnode_lock);
+	return 0;
+}
+
+/*
+ * @pnode: pnode that contains the vfsmounts, on which the
+ *  		new mount is created at dentry 'dentry'
+ * @dentry: the dentry on which the new mount is created
+ * @mnt:   return the mount created on this vfsmount
+ * walk through all the vfsmounts belonging to this pnode
+ * as well as its slave pnodes and for each vfsmount create
+ * a new vfsmount at 'dentry'.  Return the vfsmount created
+ * at 'dentry' of vfsmount 'mnt'.
+ */
+struct vfsmount *pnode_make_mounted(struct vfspnode *pnode,
+		struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct vfsmount *child_mnt;
+	int ret=0, level;
+   	struct vfspnode *master_pnode;
+	struct vfspnode *child_pnode, *master_child_pnode;
+    	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+	static struct vfspnode *p_array[PNODE_MAX_SLAVE_LEVEL];
+
+	context.start = pnode;
+	context.pnode = NULL;
+
+	while (pnode_next(&context)) {
+		level = context.level;
+		pnode = context.pnode;
+		master_pnode = context.master_pnode;
+
+		if (master_pnode)
+			master_child_pnode = p_array[level-1];
+		else
+			master_child_pnode = NULL;
+
+		if (!(child_pnode = pnode_alloc())) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (child_pnode && master_child_pnode)
+			pnode_add_slave_pnode(master_child_pnode,
+					child_pnode);
+
+		p_array[level] = child_pnode;
+
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if (!(child_mnt = do_make_mounted(member_mnt,
+					dentry))) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			spin_lock(&vfspnode_lock);
+			pnode_add_member_mnt(child_pnode, child_mnt);
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if (!(child_mnt = do_make_mounted(slave_mnt,
+					dentry))) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			spin_lock(&vfspnode_lock);
+			pnode_add_slave_mnt(child_pnode, child_mnt);
+		}
+		spin_unlock(&vfspnode_lock);
+	}
+out:
+	if (ret)
+		return NULL;
+
+	child_mnt = __lookup_mnt(mnt, dentry, dentry);
+	mntput(child_mnt);
+	return child_mnt;
+}
+
+int vfs_make_unmounted(struct vfsmount *mnt)
+{
+	struct vfspnode *pnode;
+	int ret=0;
+
+	if (do_make_unmounted(mnt)) {
+		ret = 1;
+		goto out;
+	}
+	pnode = mnt->mnt_pnode;
+	list_del_init(&mnt->mnt_pnode_mntlist);
+	put_pnode(pnode);
+out:
+	return ret;
+}
+
+int pnode_make_unmounted(struct vfspnode *pnode)
+{
+	int ret=0;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+
+	context.start = pnode;
+	context.pnode = NULL;
+	while (pnode_next(&context)) {
+		pnode = context.pnode;
+		// traverse member vfsmounts
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_make_unmounted(member_mnt)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_make_unmounted(slave_mnt)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		spin_unlock(&vfspnode_lock);
+	}
+out:
+	return ret;
+}
+
+int vfs_prepare_mount_func(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		struct vfspnode *pnode,
+		struct vfsmount *source_mnt,
+		struct dentry *mountpoint_dentry,
+		struct vfsmount *p_mnt)
+
+{
+	struct vfsmount *child_mnt;
+
+	if ((p_mnt != mnt) || (source_mnt == source_mnt->mnt_parent)) {
+		child_mnt = do_attach_prepare_mnt(mnt, mountpoint_dentry,
+				source_mnt, (p_mnt != mnt));
+
+		if (!child_mnt)
+			return -ENOMEM;
+
+		if (child_mnt != source_mnt)
+			put_pnode(source_mnt->mnt_pnode);
+	} else
+		child_mnt = source_mnt;
+
+	switch (flag) {
+	case PNODE_SLAVE_VFS :
+		pnode_add_slave_mnt(pnode, child_mnt);
+		break;
+	case PNODE_MEMBER_VFS :
+		pnode_add_member_mnt(pnode, child_mnt);
+		break;
+	}
+
+	return 0;
+}
+
+int pnode_prepare_mount(struct vfspnode *pnode,
+		struct vfspnode *my_pnode,
+		struct dentry *mountpoint_dentry,
+		struct vfsmount *source_mnt,
+		struct vfsmount *mnt)
+{
+	int ret=0, level;
+     	struct vfspnode *master_pnode, *child_pnode, *master_child_pnode;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+	static struct vfspnode *p_array[PNODE_MAX_SLAVE_LEVEL];
+
+	context.start = pnode;
+	context.pnode = NULL;
+	while (pnode_next(&context)) {
+		level = context.level;
+		pnode = context.pnode;
+		master_pnode = context.master_pnode;
+
+		if (master_pnode) {
+			master_child_pnode = p_array[level];
+			child_pnode = NULL;
+		} else {
+			master_child_pnode = NULL;
+			child_pnode = my_pnode;
+		}
+
+		if (!(child_pnode = pnode_alloc()))
+			return -ENOMEM;
+
+		if (master_child_pnode && child_pnode)
+			pnode_add_slave_pnode(master_child_pnode,
+					child_pnode);
+		p_array[level] = child_pnode;
+
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if((ret=vfs_prepare_mount_func(member_mnt,
+				PNODE_MEMBER_VFS, child_pnode,
+				source_mnt, mountpoint_dentry, mnt)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		list_for_each_entry_safe(slave_mnt,
+			t_m, &pnode->pnode_slavevfs,
+			mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if((ret = vfs_prepare_mount_func(slave_mnt,
+				PNODE_SLAVE_VFS, child_pnode,
+				source_mnt, mountpoint_dentry, mnt)))
+					goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		spin_unlock(&vfspnode_lock);
+	}
+out:
+	return ret;
+}
+
+int vfs_real_mount_func(struct vfsmount *mnt, int delflag)
+{
+	BUG_ON(mnt == mnt->mnt_parent);
+	do_attach_real_mnt(mnt);
+	if (delflag) {
+		spin_lock(&vfspnode_lock);
+		list_del_init(&mnt->mnt_pnode_mntlist);
+		put_pnode_locked(mnt->mnt_pnode);
+		spin_unlock(&vfspnode_lock);
+		mnt->mnt_pnode = NULL;
+	}
+	return 0;
+}
+
+/*
+ * @pnode: walk the propogation tree and complete the
+ * 	attachments of the child mounts to the parents
+ * 	correspondingly.
+ * @flag: if set destroy the propogation tree
+ */
+int pnode_real_mount(struct vfspnode *pnode, int flag)
+{
+	int ret=0;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+
+	context.start = pnode;
+	context.pnode = NULL;
+	while (pnode_next(&context)) {
+		pnode = context.pnode;
+		// traverse member vfsmounts
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_real_mount_func(member_mnt,
+							flag)))
+				goto out;
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_real_mount_func(slave_mnt,
+							flag)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+
+		if (flag) {
+			BUG_ON(!list_empty(&pnode->pnode_vfs));
+			BUG_ON(!list_empty(&pnode->pnode_slavevfs));
+			BUG_ON(!list_empty(&pnode->pnode_slavepnode));
+			list_del_init(&pnode->pnode_peer_slave);
+			put_pnode_locked(pnode);
+		}
+		spin_unlock(&vfspnode_lock);
+	}
+out:
+	return ret;
+}
Index: 2.6.12.work1/include/linux/fs.h
===================================================================
--- 2.6.12.work1.orig/include/linux/fs.h
+++ 2.6.12.work1/include/linux/fs.h
@@ -1216,7 +1216,11 @@ extern struct vfsmount *kern_mount(struc
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
+extern struct vfsmount *do_attach_prepare_mnt(struct vfsmount *,
+		struct dentry *, struct vfsmount *, int );
+extern void do_attach_real_mnt(struct vfsmount *);
 extern struct vfsmount *do_make_mounted(struct vfsmount *, struct dentry *);
+extern int do_make_unmounted(struct vfsmount *);
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
Index: 2.6.12.work1/include/linux/pnode.h
===================================================================
--- 2.6.12.work1.orig/include/linux/pnode.h
+++ 2.6.12.work1/include/linux/pnode.h
@@ -76,5 +76,10 @@ void pnode_del_slave_mnt(struct vfsmount
 void pnode_del_member_mnt(struct vfsmount *);
 void pnode_disassociate_mnt(struct vfsmount *);
 void pnode_add_slave_pnode(struct vfspnode *, struct vfspnode *);
+int pnode_merge_pnode(struct vfspnode *, struct vfspnode *);
 struct vfsmount * pnode_make_mounted(struct vfspnode *, struct vfsmount *, struct dentry *);
+int  pnode_make_unmounted(struct vfspnode *);
+int pnode_prepare_mount(struct vfspnode *, struct vfspnode *, struct dentry *,
+		struct vfsmount *, struct vfsmount *);
+int pnode_real_mount(struct vfspnode *, int);
 #endif /* _LINUX_PNODE_H */
Index: 2.6.12.work1/include/linux/namespace.h
===================================================================
--- 2.6.12.work1.orig/include/linux/namespace.h
+++ 2.6.12.work1/include/linux/namespace.h
@@ -9,7 +9,6 @@ struct namespace {
 	atomic_t		count;
 	struct vfsmount *	root;
 	struct list_head	list;
-	struct rw_semaphore	sem;
 };
 
 extern void umount_tree(struct vfsmount *);
Index: 2.6.12.work1/include/linux/dcache.h
===================================================================
--- 2.6.12.work1.orig/include/linux/dcache.h
+++ 2.6.12.work1/include/linux/dcache.h
@@ -329,6 +329,8 @@ static inline int d_mountpoint(struct de
 }
 
 extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
+extern struct vfsmount *__lookup_mnt(struct vfsmount *,
+		struct dentry *, struct dentry *);
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 
 extern int sysctl_vfs_cache_pressure;
