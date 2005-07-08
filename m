Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVGHK1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVGHK1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVGHK0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:26:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46791 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262449AbVGHKZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:25:48 -0400
Subject: [RFC PATCH 1/8] share/private/slave a subtree
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120816229.30164.13.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost>
Content-Type: multipart/mixed; boundary="=-HuYDr/OjOzM0TY4Qa2DR"
Organization: IBM 
Message-Id: <1120817463.30164.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:25:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HuYDr/OjOzM0TY4Qa2DR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This patch adds the shared/private/slave support for VFS trees.

RP

--=-HuYDr/OjOzM0TY4Qa2DR
Content-Disposition: attachment; filename=shared_private_slave.patch
Content-Type: text/x-patch; name=shared_private_slave.patch
Content-Transfer-Encoding: 7bit

This patch adds the shared/private/slave support for VFS trees.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/Makefile            |    2 
 fs/dcache.c            |    2 
 fs/namei.c             |    4 
 fs/namespace.c         |  170 ++++++++++++++++++++++++
 fs/pnode.c             |  335 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |    2 
 include/linux/fs.h     |    5 
 include/linux/mount.h  |   48 ++++++-
 include/linux/pnode.h  |   82 +++++++++++
 9 files changed, 641 insertions(+), 9 deletions(-)

Index: 2.6.12/fs/namespace.c
===================================================================
--- 2.6.12.orig/fs/namespace.c
+++ 2.6.12/fs/namespace.c
@@ -22,6 +22,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/pnode.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
@@ -62,6 +63,7 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_fslink);
+		INIT_LIST_HEAD(&mnt->mnt_pnode_mntlist);
 		if (name) {
 			int size = strlen(name)+1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -84,7 +86,7 @@ void free_vfsmnt(struct vfsmount *mnt)
  * Now, lookup_mnt increments the ref count before returning
  * the vfsmount struct.
  */
-struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
+struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry, struct dentry *root)
 {
 	struct list_head * head = mount_hashtable + hash(mnt, dentry);
 	struct list_head * tmp = head;
@@ -97,7 +99,8 @@ struct vfsmount *lookup_mnt(struct vfsmo
 		if (tmp == head)
 			break;
 		p = list_entry(tmp, struct vfsmount, mnt_hash);
-		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
+		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry &&
+				(root == NULL || p->mnt_root == root )) {
 			found = mntget(p);
 			break;
 		}
@@ -119,6 +122,7 @@ static void detach_mnt(struct vfsmount *
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	list_del_init(&mnt->mnt_child);
 	list_del_init(&mnt->mnt_hash);
+	list_del_init(&mnt->mnt_pnode_mntlist);
 	old_nd->dentry->d_mounted--;
 }
 
@@ -161,6 +165,7 @@ clone_mnt(struct vfsmount *old, struct d
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
 		mnt->mnt_namespace = old->mnt_namespace;
+		mnt->mnt_pnode = get_pnode(old->mnt_pnode);
 
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */
@@ -176,6 +181,7 @@ void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 	dput(mnt->mnt_root);
+	put_pnode(mnt->mnt_pnode);
 	free_vfsmnt(mnt);
 	deactivate_super(sb);
 }
@@ -615,6 +621,148 @@ out_unlock:
 	return err;
 }
 
+struct vfsmount *do_make_mounted(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct vfsmount *child_mnt, *next;
+	struct nameidata nd;
+	struct vfsmount *newmnt = clone_mnt(mnt, dentry);
+	LIST_HEAD(move);
+
+	if (newmnt) {
+		/* put in code for mount expiry */
+		/* TOBEDONE */
+
+		/*
+		 * walk through the mount list of mnt and move
+		 * them under the new mount
+		 */
+		spin_lock(&vfsmount_lock);
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
+		attach_mnt(newmnt, &nd);
+ 		spin_unlock(&vfsmount_lock);
+ 	}
+	return newmnt;
+}
+
+int
+_do_make_mounted(struct nameidata *nd, struct vfsmount **mnt)
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
+	 * if it does not, create a vfsmount there.
+	 * which means you need to propogate it
+	 * across all vfsmounts.
+ 	 */
+	if(parent_dentry == parent_mnt->mnt_root) {
+		*mnt = parent_mnt;
+	} else {
+		*mnt = IS_MNT_SHARED(parent_mnt) ?
+			 pnode_make_mounted(parent_mnt->mnt_pnode,
+					 parent_mnt, parent_dentry) :
+			 do_make_mounted(parent_mnt, parent_dentry);
+		if (!*mnt)
+			err = -ENOMEM;
+ 	}
+	return err;
+}
+
+/*
+ * recursively change the type of the mountpoint.
+ */
+static int do_change_type(struct nameidata *nd, int flag)
+{
+	struct vfsmount *m, *mnt;
+	struct vfspnode *old_pnode = NULL;
+	int err;
+
+	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
+			&& !(flag & MS_SLAVE))
+		return -EINVAL;
+
+	if ((err = _do_make_mounted(nd, &mnt)))
+		return err;
+
+	spin_lock(&vfsmount_lock);
+	for (m = mnt; m; m = next_mnt(m, mnt)) {
+		switch (flag) {
+		case MS_SHARED:
+			/*
+			 * if the mount is already a slave mount,
+			 * allocated a new pnode and make it
+			 * a slave pnode of the original pnode.
+			 */
+			if (IS_MNT_SLAVE(m)) {
+				old_pnode = m->mnt_pnode;
+				pnode_del_slave_mnt(m);
+			}
+			if(!IS_MNT_SHARED(m)) {
+				m->mnt_pnode = pnode_alloc();
+				if(!m->mnt_pnode) {
+					pnode_add_slave_mnt(old_pnode, m);
+					err = -ENOMEM;
+					break;
+				}
+				pnode_add_member_mnt(m->mnt_pnode, m);
+			}
+			if(old_pnode) {
+				pnode_add_slave_pnode(old_pnode,
+						m->mnt_pnode);
+			}
+			SET_MNT_SHARED(m);
+			break;
+
+		case MS_SLAVE:
+			if (IS_MNT_SLAVE(m)) {
+				break;
+			}
+			/*
+			 * only shared mounts can
+			 * be made slave
+			 */
+			if (!IS_MNT_SHARED(m)) {
+				err = -EINVAL;
+				break;
+			}
+			old_pnode = m->mnt_pnode;
+			pnode_del_member_mnt(m);
+			pnode_add_slave_mnt(old_pnode, m);
+			SET_MNT_SLAVE(m);
+			break;
+
+		case MS_PRIVATE:
+			if(m->mnt_pnode)
+				pnode_disassociate_mnt(m);
+			SET_MNT_PRIVATE(m);
+			break;
+
+		}
+	}
+	spin_unlock(&vfsmount_lock);
+	return err;
+}
+
 /*
  * do loopback mount.
  */
@@ -1049,6 +1197,8 @@ long do_mount(char * dev_name, char * di
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+	else if (flags & MS_SHARED || flags & MS_PRIVATE || flags & MS_SLAVE)
+		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
Index: 2.6.12/fs/pnode.c
===================================================================
--- /dev/null
+++ 2.6.12/fs/pnode.c
@@ -0,0 +1,362 @@
+/*
+ *  linux/fs/pnode.c
+ *
+ * (C) Copyright IBM Corporation 2005.
+ *	Released under GPL v2.
+ *	Author : Ram Pai (linuxram@us.ibm.com)
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/syscalls.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <linux/quotaops.h>
+#include <linux/acct.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/namespace.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/mount.h>
+#include <linux/pnode.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+#include <stdarg.h>
+
+
+#define PNODE_MEMBER_VFS  0x01
+#define PNODE_SLAVE_VFS   0x02
+
+static kmem_cache_t * pnode_cachep;
+
+/* spinlock for pnode related operations */
+ __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
+
+
+static void
+pnode_init_fn(void *data, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct vfspnode *pnode = (struct vfspnode *)data;
+	INIT_LIST_HEAD(&pnode->pnode_vfs);
+	INIT_LIST_HEAD(&pnode->pnode_slavevfs);
+	INIT_LIST_HEAD(&pnode->pnode_slavepnode);
+	INIT_LIST_HEAD(&pnode->pnode_peer_slave);
+	pnode->pnode_master = NULL;
+	pnode->pnode_flags = 0;
+	atomic_set(&pnode->pnode_count,0);
+}
+
+void __init
+pnode_init(unsigned long mempages)
+{
+	pnode_cachep = kmem_cache_create("pnode_cache",
+                       sizeof(struct vfspnode), 0,
+                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, pnode_init_fn, NULL);
+}
+
+
+struct vfspnode *
+pnode_alloc(void)
+{
+	struct vfspnode *pnode =  (struct vfspnode *)kmem_cache_alloc(
+			pnode_cachep, GFP_KERNEL);
+	return pnode;
+}
+
+void
+pnode_free(struct vfspnode *pnode)
+{
+	kmem_cache_free(pnode_cachep, pnode);
+}
+
+/*
+ * __put_pnode() should be called with vfspnode_lock held
+ */
+void
+__put_pnode(struct vfspnode *pnode)
+{
+	struct vfspnode *tmp_pnode;
+	do {
+		tmp_pnode = pnode->pnode_master;
+		list_del_init(&pnode->pnode_peer_slave);
+		BUG_ON(!list_empty(&pnode->pnode_vfs));
+		BUG_ON(!list_empty(&pnode->pnode_slavevfs));
+		BUG_ON(!list_empty(&pnode->pnode_slavepnode));
+		pnode_free(pnode);
+		pnode = tmp_pnode;
+		if (!pnode || !atomic_dec_and_test(&pnode->pnode_count))
+			break;
+	} while(pnode);
+}
+
+struct inoutdata {
+	void *my_data; /* produced and consumed by me */
+	void *in_data; /* produced by master, consumed by slave */
+	void *out_data; /* produced by slave, comsume by master */
+};
+
+struct pcontext {
+	struct vfspnode *start;
+	int 	flag;
+	int 	traversal;
+	int	level;
+	struct vfspnode *master_pnode;
+	struct vfspnode *pnode;
+	struct vfspnode *slave_pnode;
+};
+
+
+#define PNODE_UP 1
+#define PNODE_DOWN 2
+#define PNODE_MID 3
+
+/*
+ * Walk the pnode tree for each pnode encountered.  A given pnode in the tree
+ * can be returned a minimum of 2 times.  First time the pnode is encountered,
+ * it is returned with the flag PNODE_DOWN. Everytime the pnode is encountered
+ * after having traversed through each of its children, it is returned with the
+ * flag PNODE_MID.  And finally when the pnode is encountered after having
+ * walked all of its children, it is returned with the flag PNODE_UP.
+ *
+ * @context: provides context on the state of the last walk in the pnode
+ * 		tree.
+ */
+static int inline
+pnode_next(struct pcontext *context)
+{
+	int traversal = context->traversal;
+	int ret=0;
+	struct vfspnode *pnode = context->pnode,
+			*slave_pnode=context->slave_pnode,
+			*master_pnode=context->master_pnode;
+	struct list_head *next;
+
+	spin_lock(&vfspnode_lock);
+	/*
+	 * the first traversal will be on the root pnode
+	 * with flag PNODE_DOWN
+	 */
+	if (!pnode) {
+		context->pnode = get_pnode(context->start);
+		context->master_pnode = NULL;
+		context->traversal = PNODE_DOWN;
+		context->slave_pnode = NULL;
+		context->level = 0;
+		ret = 1;
+		goto out;
+	}
+
+	/*
+	 * if the last traversal was PNODE_UP, than the current
+	 * traversal is PNODE_MID on the master pnode.
+	 */
+	if (traversal == PNODE_UP) {
+		if (!master_pnode) {
+			/* DONE. return */
+			put_pnode(pnode);
+			ret = 0;
+		} else {
+			context->traversal = PNODE_MID;
+			context->level--;
+			context->pnode = master_pnode;
+			put_pnode(slave_pnode);
+			context->slave_pnode = pnode;
+			context->master_pnode = (master_pnode ?
+				master_pnode->pnode_master : NULL);
+			ret = 1;
+		}
+	} else {
+		if(traversal == PNODE_MID) {
+			next = slave_pnode->pnode_peer_slave.next;
+		} else {
+			next = pnode->pnode_slavepnode.next;
+		}
+		put_pnode(slave_pnode);
+		context->slave_pnode = NULL;
+		/*
+		 * if the last traversal was PNODE_MID or PNODE_DOWN, and the
+		 * master pnode has some slaves to traverse, the current
+		 * traversal will be PNODE_DOWN on the slave pnode.
+		 */
+		if ((next != &pnode->pnode_slavepnode) &&
+			(traversal == PNODE_DOWN || traversal == PNODE_MID)) {
+			context->traversal = PNODE_DOWN;
+			context->level++;
+			context->pnode = get_pnode(list_entry(next,
+				struct vfspnode, pnode_peer_slave));
+			context->master_pnode = pnode;
+			ret = 1;
+		} else {
+			/*
+			 * since there are no more children, the current traversal
+			 * is PNODE_UP on the same pnode
+			 */
+			context->traversal = PNODE_UP;
+			ret = 1;
+		}
+	}
+out:
+	spin_unlock(&vfspnode_lock);
+	return ret;
+}
+
+
+static void inline
+pnode_add_mnt(struct vfspnode *pnode, struct vfsmount *mnt, int slave)
+{
+	if (!pnode || !mnt)
+		return;
+	spin_lock(&vfspnode_lock);
+	mnt->mnt_pnode = pnode;
+	if (slave) {
+		SET_MNT_SLAVE(mnt);
+		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_slavevfs);
+	} else {
+		SET_MNT_SHARED(mnt);
+		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_vfs);
+	}
+	get_pnode(pnode);
+	spin_unlock(&vfspnode_lock);
+}
+
+void
+pnode_add_member_mnt(struct vfspnode *pnode, struct vfsmount *mnt)
+{
+	pnode_add_mnt(pnode, mnt, 0);
+}
+
+void
+pnode_add_slave_mnt(struct vfspnode *pnode, struct vfsmount *mnt)
+{
+	pnode_add_mnt(pnode, mnt, 1);
+}
+
+
+void
+pnode_add_slave_pnode(struct vfspnode *pnode, struct vfspnode *slave_pnode)
+{
+	if (!pnode || !slave_pnode)
+		return;
+	spin_lock(&vfspnode_lock);
+	slave_pnode->pnode_master = pnode;
+	slave_pnode->pnode_flags = 0;
+	list_add(&slave_pnode->pnode_peer_slave, &pnode->pnode_slavepnode);
+	get_pnode(pnode);
+	spin_unlock(&vfspnode_lock);
+}
+
+static void
+_pnode_disassociate_mnt(struct vfsmount *mnt)
+{
+	spin_lock(&vfspnode_lock);
+	list_del_init(&mnt->mnt_pnode_mntlist);
+	spin_unlock(&vfspnode_lock);
+	put_pnode(mnt->mnt_pnode);
+	mnt->mnt_pnode = NULL;
+}
+
+void
+pnode_del_slave_mnt(struct vfsmount *mnt)
+{
+	if (!mnt)
+		return;
+ 	_pnode_disassociate_mnt(mnt);
+	mnt->mnt_flags &= ~MNT_SLAVE;
+}
+
+void
+pnode_del_member_mnt(struct vfsmount *mnt)
+{
+	if (!mnt)
+		return;
+ 	_pnode_disassociate_mnt(mnt);
+	mnt->mnt_flags &= ~MNT_SHARED;
+}
+
+
+void
+pnode_disassociate_mnt(struct vfsmount *mnt)
+{
+	if (!mnt)
+		return;
+ 	_pnode_disassociate_mnt(mnt);
+	mnt->mnt_flags &= ~MNT_SLAVE;
+	mnt->mnt_flags &= ~MNT_SHARED;
+}
+
+struct vfsmount *
+pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct vfsmount *child_mnt;
+	int ret=0,traversal,level;
+     	struct vfspnode *slave_pnode, *master_pnode, *child_pnode, *slave_child_pnode;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+	static struct inoutdata p_array[PNODE_MAX_SLAVE_LEVEL];
+
+	context.start = pnode;
+	context.pnode = NULL;
+
+	while(pnode_next(&context)) {
+		traversal = context.traversal;
+		level = context.level;
+		pnode = context.pnode;
+		slave_pnode = context.slave_pnode;
+		master_pnode = context.master_pnode;
+
+		if (traversal == PNODE_DOWN ) {
+			if (master_pnode) {
+				child_pnode = (struct vfspnode *)p_array[level-1].in_data;
+			} else {
+				child_pnode = NULL;
+			}
+			while (!(child_pnode = pnode_alloc()))
+				schedule();
+			p_array[level].my_data = (void *)child_pnode;
+			p_array[level].in_data = NULL;
+
+		} else if(traversal == PNODE_MID) {
+
+			child_pnode = (struct vfspnode *)p_array[level].my_data;
+			slave_child_pnode = p_array[level+1].out_data;
+			pnode_add_slave_pnode(child_pnode, slave_child_pnode);
+
+		} else if(traversal == PNODE_UP) {
+			child_pnode = p_array[level].my_data;
+			spin_lock(&vfspnode_lock);
+			list_for_each_entry_safe(member_mnt,
+				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+				spin_unlock(&vfspnode_lock);
+				if (!(child_mnt = do_make_mounted(mnt, dentry))) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				spin_lock(&vfspnode_lock);
+				pnode_add_member_mnt(child_pnode, child_mnt);
+			}
+			list_for_each_entry_safe(slave_mnt,
+				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+				spin_unlock(&vfspnode_lock);
+				if (!(child_mnt = do_make_mounted(mnt, dentry))) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				spin_lock(&vfspnode_lock);
+				pnode_add_slave_mnt(child_pnode, child_mnt);
+			}
+			spin_unlock(&vfspnode_lock);
+			p_array[level].out_data = child_pnode;
+		}
+	}
+
+out:
+	if (ret)
+		return NULL;
+
+	child_mnt = lookup_mnt(mnt, dentry, dentry);
+	mntput(child_mnt);
+	return child_mnt;
+}
Index: 2.6.12/fs/dcache.c
===================================================================
--- 2.6.12.orig/fs/dcache.c
+++ 2.6.12/fs/dcache.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/file.h>
+#include <linux/pnode.h>
 #include <asm/uaccess.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
@@ -1737,6 +1738,7 @@ void __init vfs_caches_init(unsigned lon
 	inode_init(mempages);
 	files_init(mempages);
 	mnt_init(mempages);
+	pnode_init(mempages);
 	bdev_cache_init();
 	chrdev_init();
 }
Index: 2.6.12/fs/namei.c
===================================================================
--- 2.6.12.orig/fs/namei.c
+++ 2.6.12/fs/namei.c
@@ -583,7 +583,7 @@ static int __follow_mount(struct path *p
 {
 	int res = 0;
 	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path->mnt, path->dentry);
+		struct vfsmount *mounted = lookup_mnt(path->mnt, path->dentry, NULL);
 		if (!mounted)
 			break;
 		dput(path->dentry);
@@ -599,7 +599,7 @@ static int __follow_mount(struct path *p
 static void follow_mount(struct vfsmount **mnt, struct dentry **dentry)
 {
 	while (d_mountpoint(*dentry)) {
-		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry);
+		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry, NULL);
 		if (!mounted)
 			break;
 		dput(*dentry);
@@ -616,7 +616,7 @@ int follow_down(struct vfsmount **mnt, s
 {
 	struct vfsmount *mounted;
 
-	mounted = lookup_mnt(*mnt, *dentry);
+	mounted = lookup_mnt(*mnt, *dentry, NULL);
 	if (mounted) {
 		dput(*dentry);
 		mntput(*mnt);
Index: 2.6.12/include/linux/fs.h
===================================================================
--- 2.6.12.orig/include/linux/fs.h
+++ 2.6.12/include/linux/fs.h
@@ -102,6 +102,9 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_PRIVATE	262144
+#define MS_SLAVE	524288
+#define MS_SHARED	1048576
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
@@ -232,6 +235,7 @@ extern void update_atime (struct inode *
 extern void __init inode_init(unsigned long);
 extern void __init inode_init_early(void);
 extern void __init mnt_init(unsigned long);
+extern void __init pnode_init(unsigned long);
 extern void __init files_init(unsigned long);
 
 struct buffer_head;
@@ -1211,6 +1215,7 @@ extern struct vfsmount *kern_mount(struc
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
+extern struct vfsmount *do_make_mounted(struct vfsmount *, struct dentry *);
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
Index: 2.6.12/include/linux/dcache.h
===================================================================
--- 2.6.12.orig/include/linux/dcache.h
+++ 2.6.12/include/linux/dcache.h
@@ -328,7 +328,7 @@ static inline int d_mountpoint(struct de
 	return dentry->d_mounted;
 }
 
-extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
+extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *, struct dentry *);
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 
 extern int sysctl_vfs_cache_pressure;
Index: 2.6.12/include/linux/pnode.h
===================================================================
--- /dev/null
+++ 2.6.12/include/linux/pnode.h
@@ -0,0 +1,78 @@
+/*
+ *  linux/fs/pnode.c
+ *
+ * (C) Copyright IBM Corporation 2005.
+ *	Released under GPL v2.
+ *
+ */
+#ifndef _LINUX_PNODE_H
+#define _LINUX_PNODE_H
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/mount.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+
+struct vfspnode {
+	struct list_head pnode_vfs; 	 /* list of vfsmounts anchored here */
+	struct list_head pnode_slavevfs; /* list of slave vfsmounts */
+	struct list_head pnode_slavepnode;/* list of slave pnode */
+	struct list_head pnode_peer_slave;/* going through master's slave pnode
+					    list*/
+	struct vfspnode	 *pnode_master;	  /* master pnode */
+	int 		 pnode_flags;
+	atomic_t 	 pnode_count;
+};
+#define PNODE_MAX_SLAVE_LEVEL 10
+#define PNODE_DELETE  0x01
+#define PNODE_SLAVE   0x02
+
+#define IS_PNODE_DELETE(pn)  ((pn->pnode_flags&PNODE_DELETE)==PNODE_DELETE)
+#define IS_PNODE_SLAVE(pn)  ((pn->pnode_flags&PNODE_SLAVE)==PNODE_SLAVE)
+#define SET_PNODE_DELETE(pn)  pn->pnode_flags |= PNODE_DELETE
+#define SET_PNODE_SLAVE(pn)  pn->pnode_flags |= PNODE_SLAVE
+
+extern spinlock_t vfspnode_lock;
+extern void __put_pnode(struct vfspnode *);
+
+static inline struct vfspnode *
+get_pnode(struct vfspnode *pnode)
+{
+	if (!pnode)
+		return NULL;
+	atomic_inc(&pnode->pnode_count);
+	return pnode;
+}
+
+static inline struct vfspnode *
+get_pnode_n(struct vfspnode *pnode, size_t n)
+{
+	if (!pnode)
+		return NULL;
+	atomic_add(n, &pnode->pnode_count);
+	return pnode;
+}
+
+static inline void
+put_pnode(struct vfspnode *pnode)
+{
+	if (!pnode)
+		return;
+	if (atomic_dec_and_lock(&pnode->pnode_count, &vfspnode_lock)) {
+		__put_pnode(pnode);
+		spin_unlock(&vfspnode_lock);
+	}
+}
+
+void __init pnode_init(unsigned long );
+struct vfspnode * pnode_alloc(void);
+void pnode_add_slave_mnt(struct vfspnode *, struct vfsmount *);
+void pnode_add_member_mnt(struct vfspnode *, struct vfsmount *);
+void pnode_del_slave_mnt(struct vfsmount *);
+void pnode_del_member_mnt(struct vfsmount *);
+void pnode_disassociate_mnt(struct vfsmount *);
+void pnode_add_slave_pnode(struct vfspnode *, struct vfspnode *);
+struct vfsmount * pnode_make_mounted(struct vfspnode *, struct vfsmount *, struct dentry *);
+#endif /* KERNEL */
+#endif /* _LINUX_PNODE_H */
Index: 2.6.12/include/linux/mount.h
===================================================================
--- 2.6.12.orig/include/linux/mount.h
+++ 2.6.12/include/linux/mount.h
@@ -16,9 +16,33 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_NOSUID	0x01
+#define MNT_NODEV	0x02
+#define MNT_NOEXEC	0x04
+#define MNT_PRIVATE	0x10  /* if the vfsmount is private, by default it is private*/
+#define MNT_SLAVE	0x20  /* if the vfsmount is a slave mount of its pnode */
+#define MNT_SHARED	0x40  /* if the vfsmount is a slave mount of its pnode */
+#define MNT_PNODE_MASK	0xf0  /* propogation flag mask */
+
+#define IS_MNT_SHARED(mnt) (mnt->mnt_flags&MNT_SHARED)
+#define IS_MNT_SLAVE(mnt) (mnt->mnt_flags&MNT_SLAVE)
+#define IS_MNT_PRIVATE(mnt) (mnt->mnt_flags&MNT_PRIVATE)
+
+#define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
+#define CLEAR_MNT_PRIVATE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_PRIVATE))
+#define CLEAR_MNT_SLAVE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SLAVE))
+
+//TOBEDONE WRITE BETTER MACROS. ..
+#define SET_MNT_SHARED(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_SHARED),\
+				CLEAR_MNT_PRIVATE(mnt), \
+				CLEAR_MNT_SLAVE(mnt))
+#define SET_MNT_PRIVATE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_PRIVATE), \
+				CLEAR_MNT_SLAVE(mnt), \
+				CLEAR_MNT_SHARED(mnt), \
+				mnt->mnt_pnode = NULL)
+#define SET_MNT_SLAVE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_SLAVE), \
+				CLEAR_MNT_PRIVATE(mnt), \
+				CLEAR_MNT_SHARED(mnt))
 
 struct vfsmount
 {
@@ -29,6 +53,10 @@ struct vfsmount
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
+	struct list_head mnt_pnode_mntlist;/* and going through their
+					   pnode's vfsmount */
+	struct vfspnode *mnt_pnode;	/* and going through their
+					   pnode's vfsmount */
 	atomic_t mnt_count;
 	int mnt_flags;
 	int mnt_expiry_mark;		/* true if marked for expiry */
@@ -38,6 +66,7 @@ struct vfsmount
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
Index: 2.6.12/fs/Makefile
===================================================================
--- 2.6.12.orig/fs/Makefile
+++ 2.6.12/fs/Makefile
@@ -8,7 +8,7 @@
 obj-y :=	open.o read_write.o file_table.o buffer.o  bio.o super.o \
 		block_dev.o char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
-		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
+		attr.o bad_inode.o file.o filesystems.o namespace.o pnode.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o

--=-HuYDr/OjOzM0TY4Qa2DR--

