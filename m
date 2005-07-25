Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVGYW7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVGYW7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVGYW7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:59:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62655 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261207AbVGYW7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:59:19 -0400
Message-Id: <20050725225907.007405000@localhost>
References: <20050725224417.501066000@localhost>
Date: Mon, 25 Jul 2005 15:44:18 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Avantika Mathur <mathurav@us.ibm.com>, Mike Waychison <mike@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

, miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] shared subtree
Content-Type: text/x-patch; name=shared_private_slave.patch
Content-Disposition: inline; filename=shared_private_slave.patch

This patch adds the shared/private/slave support for VFS trees.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/Makefile           |    2 
 fs/dcache.c           |    2 
 fs/namespace.c        |   93 ++++++++++
 fs/pnode.c            |  441 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    5 
 include/linux/mount.h |   44 ++++
 include/linux/pnode.h |   90 ++++++++++
 7 files changed, 673 insertions(+), 4 deletions(-)

Index: 2.6.12.work2/fs/namespace.c
===================================================================
--- 2.6.12.work2.orig/fs/namespace.c
+++ 2.6.12.work2/fs/namespace.c
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
@@ -615,6 +617,95 @@ out_unlock:
 	return err;
 }
 
+static int do_make_shared(struct vfsmount *mnt)
+{
+	int err=0;
+	struct vfspnode *old_pnode = NULL;
+	/*
+	 * if the mount is already a slave mount,
+	 * allocate a new pnode and make it
+	 * a slave pnode of the original pnode.
+	 */
+	if (IS_MNT_SLAVE(mnt)) {
+		old_pnode = mnt->mnt_pnode;
+		pnode_del_slave_mnt(mnt);
+	}
+	if(!IS_MNT_SHARED(mnt)) {
+		mnt->mnt_pnode = pnode_alloc();
+		if(!mnt->mnt_pnode) {
+			pnode_add_slave_mnt(old_pnode, mnt);
+			err = -ENOMEM;
+			goto out;
+		}
+		pnode_add_member_mnt(mnt->mnt_pnode, mnt);
+	}
+	if(old_pnode)
+		pnode_add_slave_pnode(old_pnode, mnt->mnt_pnode);
+	set_mnt_shared(mnt);
+out:
+	return err;
+}
+
+static int do_make_slave(struct vfsmount *mnt)
+{
+	int err=0;
+
+	if (IS_MNT_SLAVE(mnt))
+		goto out;
+	/*
+	 * only shared mounts can
+	 * be made slave
+	 */
+	if (!IS_MNT_SHARED(mnt)) {
+		err = -EINVAL;
+		goto out;
+	}
+	pnode_member_to_slave(mnt);
+out:
+	return err;
+}
+
+static int do_make_private(struct vfsmount *mnt)
+{
+	if(mnt->mnt_pnode)
+		pnode_disassociate_mnt(mnt);
+	set_mnt_private(mnt);
+	return 0;
+}
+
+/*
+ * recursively change the type of the mountpoint.
+ */
+static int do_change_type(struct nameidata *nd, int flag)
+{
+	struct vfsmount *m, *mnt = nd->mnt;
+	int err=0;
+
+	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
+			&& !(flag & MS_SLAVE))
+		return -EINVAL;
+
+	if (nd->dentry != nd->mnt->mnt_root)
+		return -EINVAL;
+
+	spin_lock(&vfsmount_lock);
+	for (m = mnt; m; m = next_mnt(m, mnt)) {
+		switch (flag) {
+		case MS_SHARED:
+			err = do_make_shared(m);
+			break;
+		case MS_SLAVE:
+			err = do_make_slave(m);
+			break;
+		case MS_PRIVATE:
+			err = do_make_private(m);
+			break;
+		}
+	}
+	spin_unlock(&vfsmount_lock);
+	return err;
+}
+
 /*
  * do loopback mount.
  */
@@ -1049,6 +1140,8 @@ long do_mount(char * dev_name, char * di
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+	else if (flags & MS_SHARED || flags & MS_PRIVATE || flags & MS_SLAVE)
+		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
Index: 2.6.12.work2/fs/pnode.c
===================================================================
--- /dev/null
+++ 2.6.12.work2/fs/pnode.c
@@ -0,0 +1,441 @@
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
+static kmem_cache_t * pnode_cachep;
+
+/* spinlock for pnode related operations */
+ __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
+
+enum pnode_vfs_type {
+	PNODE_MEMBER_VFS = 0x01,
+	PNODE_SLAVE_VFS = 0x02
+};
+
+void __init pnode_init(unsigned long mempages)
+{
+	pnode_cachep = kmem_cache_create("pnode_cache",
+                       sizeof(struct vfspnode), 0,
+                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+}
+
+struct vfspnode * pnode_alloc(void)
+{
+	struct vfspnode *pnode =  kmem_cache_alloc(pnode_cachep, GFP_KERNEL);
+	INIT_LIST_HEAD(&pnode->pnode_vfs);
+	INIT_LIST_HEAD(&pnode->pnode_slavevfs);
+	INIT_LIST_HEAD(&pnode->pnode_slavepnode);
+	INIT_LIST_HEAD(&pnode->pnode_peer_slave);
+	pnode->pnode_master = NULL;
+	pnode->pnode_flags = 0;
+	atomic_set(&pnode->pnode_count,0);
+	return pnode;
+}
+
+void inline pnode_free(struct vfspnode *pnode)
+{
+	kmem_cache_free(pnode_cachep, pnode);
+}
+
+/*
+ * __put_pnode() should be called with vfspnode_lock held
+ */
+void __put_pnode(struct vfspnode *pnode)
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
+static void inline pnode_add_mnt(struct vfspnode *pnode,
+		struct vfsmount *mnt, int slave)
+{
+	if (!pnode || !mnt)
+		return;
+	spin_lock(&vfspnode_lock);
+	mnt->mnt_pnode = pnode;
+	if (slave) {
+		set_mnt_slave(mnt);
+		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_slavevfs);
+	} else {
+		set_mnt_shared(mnt);
+		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_vfs);
+	}
+	get_pnode(pnode);
+	spin_unlock(&vfspnode_lock);
+}
+
+void pnode_add_member_mnt(struct vfspnode *pnode,
+		struct vfsmount *mnt)
+{
+	pnode_add_mnt(pnode, mnt, 0);
+}
+
+void pnode_add_slave_mnt(struct vfspnode *pnode,
+		struct vfsmount *mnt)
+{
+	pnode_add_mnt(pnode, mnt, 1);
+}
+
+
+void pnode_add_slave_pnode(struct vfspnode *pnode,
+		struct vfspnode *slave_pnode)
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
+/*
+ * merge 'pnode' into 'peer_pnode' and get rid of pnode
+ * @pnode: pnode the contents of which have to be merged
+ * @peer_pnode: pnode into which the contents are merged
+ */
+int pnode_merge_pnode(struct vfspnode *pnode, struct vfspnode *peer_pnode)
+{
+	struct vfspnode *slave_pnode, *pnext;
+	struct vfsmount *mnt, *slave_mnt, *next;
+
+	list_for_each_entry_safe(slave_pnode,  pnext,
+			&pnode->pnode_slavepnode, pnode_peer_slave) {
+		slave_pnode->pnode_master = peer_pnode;
+		list_move(&slave_pnode->pnode_peer_slave,
+				&peer_pnode->pnode_slavepnode);
+		put_pnode_locked(pnode);
+		get_pnode(peer_pnode);
+	}
+
+	list_for_each_entry_safe(slave_mnt,  next,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+		slave_mnt->mnt_pnode = peer_pnode;
+		list_move(&slave_mnt->mnt_pnode_mntlist,
+				&peer_pnode->pnode_slavevfs);
+		put_pnode_locked(pnode);
+		get_pnode(peer_pnode);
+	}
+
+	list_for_each_entry_safe(mnt, next,
+			&pnode->pnode_vfs, mnt_pnode_mntlist) {
+		mnt->mnt_pnode = peer_pnode;
+		list_move(&mnt->mnt_pnode_mntlist,
+				&peer_pnode->pnode_vfs);
+		put_pnode_locked(pnode);
+		get_pnode(peer_pnode);
+	}
+	return 0;
+}
+
+/*
+ * called when pnode has no member mounts.  Merge all the slave mounts/pnodes
+ * of this pnode with that of its master pnode. If master pnode does not exit,
+ * convert all the slave mounts to private mounts.
+ */
+static void empty_pnode(struct vfspnode *pnode) { struct vfsmount *slave_mnt,
+	*next; struct vfspnode *master_pnode, *slave_pnode, *pnext;
+
+	if ((master_pnode = pnode->pnode_master)) {
+		pnode->pnode_master = NULL;
+		list_del_init(&pnode->pnode_peer_slave);
+		pnode_merge_pnode(pnode, master_pnode);
+		put_pnode_locked(master_pnode);
+	} else {
+		list_for_each_entry_safe(slave_mnt, next,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+			list_del_init(&slave_mnt->mnt_pnode_mntlist);
+			set_mnt_private(slave_mnt);
+			put_pnode_locked(pnode);
+		}
+		list_for_each_entry_safe(slave_pnode,  pnext,
+			&pnode->pnode_slavepnode, pnode_peer_slave) {
+			slave_pnode->pnode_master = NULL;
+			list_del_init(&slave_pnode->pnode_peer_slave);
+			put_pnode_locked(pnode);
+		}
+	}
+}
+
+static void __pnode_disassociate_mnt(struct vfsmount *mnt)
+{
+	struct vfspnode *pnode = mnt->mnt_pnode;
+
+	spin_lock(&vfspnode_lock);
+	list_del_init(&mnt->mnt_pnode_mntlist);
+
+	if (list_empty(&pnode->pnode_vfs))
+		empty_pnode(pnode);
+
+	put_pnode_locked(pnode);
+
+	spin_unlock(&vfspnode_lock);
+	mnt->mnt_pnode = NULL;
+}
+
+void pnode_del_slave_mnt(struct vfsmount *mnt)
+{
+	if (!mnt || !mnt->mnt_pnode)
+		return;
+ 	__pnode_disassociate_mnt(mnt);
+	CLEAR_MNT_SLAVE(mnt);
+}
+
+void pnode_del_member_mnt(struct vfsmount *mnt)
+{
+	if (!mnt || !mnt->mnt_pnode)
+		return;
+ 	__pnode_disassociate_mnt(mnt);
+	CLEAR_MNT_SHARED(mnt);
+}
+
+void pnode_member_to_slave(struct vfsmount *mnt)
+{
+	struct vfspnode *pnode = mnt->mnt_pnode;
+	if (!mnt || !pnode)
+		return;
+
+	spin_lock(&vfspnode_lock);
+
+	list_del_init(&mnt->mnt_pnode_mntlist);
+	list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_slavevfs);
+	set_mnt_slave(mnt);
+
+	if (list_empty(&pnode->pnode_vfs))
+		empty_pnode(pnode);
+
+	spin_unlock(&vfspnode_lock);
+	return;
+}
+
+void pnode_disassociate_mnt(struct vfsmount *mnt)
+{
+	if (!mnt || !mnt->mnt_pnode)
+		return;
+ 	__pnode_disassociate_mnt(mnt);
+	CLEAR_MNT_SHARED(mnt);
+	CLEAR_MNT_SLAVE(mnt);
+}
+
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
+/*
+ * skip the rest of the tree, cleaning up
+ * reference to pnodes held in pnode_next().
+ */
+static void pnode_end(struct pcontext *context)
+{
+	struct vfspnode *p = context->pnode;
+	struct vfspnode *start = context->start;
+
+	do {
+		put_pnode(p);
+	} while (p != start && (p = p->pnode_master));
+	return;
+}
+
+/*
+ * traverse the pnode tree and at each pnode encountered, execute the
+ * pnode_fnc(). For each vfsmount encountered call the vfs_fnc().
+ *
+ * @pnode: pnode tree to be traversed
+ * @in_data: input data
+ * @out_data: output data
+ * @pnode_func: function to be called when a new pnode is encountered.
+ * @vfs_func: function to be called on each slave and member vfs belonging
+ * 		to the pnode.
+ */
+static int pnode_traverse(struct vfspnode *pnode,
+		void *in_data,
+		void **out_data,
+		int (*pnode_pre_func)(struct vfspnode *,
+			void *, void **, va_list),
+		int (*pnode_post_func)(struct vfspnode *,
+			void *, va_list),
+		int (*vfs_func)(struct vfsmount *,
+			enum pnode_vfs_type, void *,  va_list),
+		...)
+{
+	va_list args;
+	int ret = 0, level;
+	void *my_data, *data_from_master;
+     	struct vfspnode *master_pnode;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+	static void *p_array[PNODE_MAX_SLAVE_LEVEL];
+
+	context.start = pnode;
+	context.pnode = NULL;
+	/*
+	 * determine whether to process vfs first or the
+	 * slave pnode first
+	 */
+	while (pnode_next(&context)) {
+		level = context.level;
+
+		if (level >= PNODE_MAX_SLAVE_LEVEL)
+			goto error;
+
+		pnode = context.pnode;
+		master_pnode = context.master_pnode;
+
+		if (master_pnode) {
+			data_from_master = p_array[level-1];
+			my_data = NULL;
+		} else {
+			data_from_master = NULL;
+			my_data = in_data;
+		}
+
+		if (pnode_pre_func) {
+			va_start(args, vfs_func);
+			if((ret = pnode_pre_func(pnode,
+				data_from_master, &my_data, args)))
+				goto error;
+			va_end(args);
+		}
+
+		// traverse member vfsmounts
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+
+			spin_unlock(&vfspnode_lock);
+			va_start(args, vfs_func);
+			if ((ret = vfs_func(member_mnt,
+				PNODE_MEMBER_VFS, my_data, args)))
+				goto error;
+			va_end(args);
+			spin_lock(&vfspnode_lock);
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+
+			spin_unlock(&vfspnode_lock);
+			va_start(args, vfs_func);
+			if ((ret = vfs_func(slave_mnt, PNODE_SLAVE_VFS,
+				my_data, args)))
+				goto error;
+			va_end(args);
+			spin_lock(&vfspnode_lock);
+		}
+		spin_unlock(&vfspnode_lock);
+
+		if (pnode_post_func) {
+			va_start(args, vfs_func);
+			if((ret = pnode_post_func(pnode,
+				my_data, args)))
+				goto error;
+			va_end(args);
+		}
+
+		p_array[level] = my_data;
+	}
+out:
+	if (out_data)
+		*out_data = p_array[0];
+	return ret;
+error:
+	va_end(args);
+	pnode_end(&context);
+	goto out;
+}
Index: 2.6.12.work2/fs/dcache.c
===================================================================
--- 2.6.12.work2.orig/fs/dcache.c
+++ 2.6.12.work2/fs/dcache.c
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
Index: 2.6.12.work2/include/linux/fs.h
===================================================================
--- 2.6.12.work2.orig/include/linux/fs.h
+++ 2.6.12.work2/include/linux/fs.h
@@ -102,6 +102,9 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_PRIVATE	(1<<18) /* recursively change to private */
+#define MS_SLAVE	(1<<19) /* recursively change to slave */
+#define MS_SHARED	(1<<20) /* recursively change to shared */
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
 
Index: 2.6.12.work2/include/linux/pnode.h
===================================================================
--- /dev/null
+++ 2.6.12.work2/include/linux/pnode.h
@@ -0,0 +1,90 @@
+/*
+ *  linux/fs/pnode.c
+ *
+ * (C) Copyright IBM Corporation 2005.
+ *	Released under GPL v2.
+ *
+ */
+#ifndef _LINUX_PNODE_H
+#define _LINUX_PNODE_H
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
+#define PNODE_MAX_SLAVE_LEVEL 32  /* MAXIMUM DEPTH OF THE PNODE TREE */
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
+/*
+ * must be called holding the vfspnode_lock
+ */
+static inline void
+put_pnode_locked(struct vfspnode *pnode)
+{
+	if (!pnode)
+		return;
+	if (atomic_dec_and_test(&pnode->pnode_count)) {
+		__put_pnode(pnode);
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
+struct vfsmount * pnode_make_mounted(struct vfspnode *, struct vfsmount *,
+		struct dentry *);
+void pnode_member_to_slave(struct vfsmount *);
+int pnode_merge_pnode(struct vfspnode *, struct vfspnode *);
+struct vfsmount * pnode_make_mounted(struct vfspnode *, struct vfsmount *,
+		struct dentry *);
+int  pnode_make_unmounted(struct vfspnode *);
+int pnode_prepare_mount(struct vfspnode *, struct vfspnode *, struct dentry *,
+		struct vfsmount *, struct vfsmount *);
+int pnode_commit_mount(struct vfspnode *, int);
+int pnode_abort_mount(struct vfspnode *, struct vfsmount *);
+#endif /* _LINUX_PNODE_H */
Index: 2.6.12.work2/include/linux/mount.h
===================================================================
--- 2.6.12.work2.orig/include/linux/mount.h
+++ 2.6.12.work2/include/linux/mount.h
@@ -16,9 +16,21 @@
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
+#define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
+#define IS_MNT_SLAVE(mnt) (mnt->mnt_flags & MNT_SLAVE)
+#define IS_MNT_PRIVATE(mnt) (mnt->mnt_flags & MNT_PRIVATE)
+
+#define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
+#define CLEAR_MNT_PRIVATE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_PRIVATE))
+#define CLEAR_MNT_SLAVE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SLAVE))
 
 struct vfsmount
 {
@@ -29,6 +41,10 @@ struct vfsmount
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
@@ -38,6 +54,28 @@ struct vfsmount
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
+static inline void set_mnt_shared(struct vfsmount *mnt)
+{
+	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_SHARED;
+	CLEAR_MNT_PRIVATE(mnt);
+	CLEAR_MNT_SLAVE(mnt);
+}
+
+static inline void set_mnt_private(struct vfsmount *mnt)
+{
+	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_PRIVATE;
+	CLEAR_MNT_SLAVE(mnt);
+	CLEAR_MNT_SHARED(mnt);
+	mnt->mnt_pnode = NULL;
+}
+
+static inline void set_mnt_slave(struct vfsmount *mnt)
+{
+	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_SLAVE;
+	CLEAR_MNT_PRIVATE(mnt);
+	CLEAR_MNT_SHARED(mnt);
+}
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
Index: 2.6.12.work2/fs/Makefile
===================================================================
--- 2.6.12.work2.orig/fs/Makefile
+++ 2.6.12.work2/fs/Makefile
@@ -8,7 +8,7 @@
 obj-y :=	open.o read_write.o file_table.o buffer.o  bio.o super.o \
 		block_dev.o char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
-		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
+		attr.o bad_inode.o file.o filesystems.o namespace.o pnode.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
