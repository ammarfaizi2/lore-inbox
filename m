Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVGRHTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVGRHTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVGRHHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:07:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16003 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261560AbVGRHHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:11 -0400
Message-Id: <20050718070701.248660000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:12 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 1/8] shared subtree
Content-Type: text/x-patch; name=shared_private_slave.patch
Content-Disposition: inline; filename=shared_private_slave.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the shared/private/slave support for VFS trees.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/Makefile           |    2 
 fs/dcache.c           |    2 
 fs/namespace.c        |   98 +++++++++++++++++++++++++++++++
 fs/pnode.c            |  158 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    5 +
 include/linux/mount.h |   44 ++++++++++++-
 include/linux/pnode.h |   80 +++++++++++++++++++++++++
 7 files changed, 385 insertions(+), 4 deletions(-)

Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
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
@@ -615,6 +617,100 @@ out_unlock:
 	return err;
 }
 
+static int do_make_shared(struct vfsmount *mnt)
+{
+	int err=0;
+	struct vfspnode *old_pnode = NULL;
+	/*
+	 * if the mount is already a slave mount,
+	 * allocated a new pnode and make it
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
+	struct vfspnode *old_pnode = NULL;
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
+	old_pnode = mnt->mnt_pnode;
+	pnode_del_member_mnt(mnt);
+	pnode_add_slave_mnt(old_pnode, mnt);
+	set_mnt_slave(mnt);
+
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
@@ -1049,6 +1145,8 @@ long do_mount(char * dev_name, char * di
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+	else if (flags & MS_SHARED || flags & MS_PRIVATE || flags & MS_SLAVE)
+		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
Index: 2.6.12.work1/fs/pnode.c
===================================================================
--- /dev/null
+++ 2.6.12.work1/fs/pnode.c
@@ -0,0 +1,158 @@
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
+
+void __init pnode_init(unsigned long mempages)
+{
+	pnode_cachep = kmem_cache_create("pnode_cache",
+                       sizeof(struct vfspnode), 0,
+                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+}
+
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
+void pnode_free(struct vfspnode *pnode)
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
+static void _pnode_disassociate_mnt(struct vfsmount *mnt)
+{
+	spin_lock(&vfspnode_lock);
+	list_del_init(&mnt->mnt_pnode_mntlist);
+	put_pnode_locked(mnt->mnt_pnode);
+	spin_unlock(&vfspnode_lock);
+	mnt->mnt_pnode = NULL;
+}
+
+void pnode_del_slave_mnt(struct vfsmount *mnt)
+{
+	if (!mnt)
+		return;
+ 	_pnode_disassociate_mnt(mnt);
+	CLEAR_MNT_SLAVE(mnt);
+}
+
+void pnode_del_member_mnt(struct vfsmount *mnt)
+{
+	if (!mnt)
+		return;
+ 	_pnode_disassociate_mnt(mnt);
+	CLEAR_MNT_SHARED(mnt);
+}
+
+
+void pnode_disassociate_mnt(struct vfsmount *mnt)
+{
+	if (!mnt)
+		return;
+ 	_pnode_disassociate_mnt(mnt);
+	CLEAR_MNT_SHARED(mnt);
+	CLEAR_MNT_SLAVE(mnt);
+}
Index: 2.6.12.work1/fs/dcache.c
===================================================================
--- 2.6.12.work1.orig/fs/dcache.c
+++ 2.6.12.work1/fs/dcache.c
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
Index: 2.6.12.work1/include/linux/fs.h
===================================================================
--- 2.6.12.work1.orig/include/linux/fs.h
+++ 2.6.12.work1/include/linux/fs.h
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
 
Index: 2.6.12.work1/include/linux/pnode.h
===================================================================
--- /dev/null
+++ 2.6.12.work1/include/linux/pnode.h
@@ -0,0 +1,80 @@
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
+struct vfsmount * pnode_make_mounted(struct vfspnode *, struct vfsmount *, struct dentry *);
+#endif /* _LINUX_PNODE_H */
Index: 2.6.12.work1/include/linux/mount.h
===================================================================
--- 2.6.12.work1.orig/include/linux/mount.h
+++ 2.6.12.work1/include/linux/mount.h
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
Index: 2.6.12.work1/fs/Makefile
===================================================================
--- 2.6.12.work1.orig/fs/Makefile
+++ 2.6.12.work1/fs/Makefile
@@ -8,7 +8,7 @@
 obj-y :=	open.o read_write.o file_table.o buffer.o  bio.o super.o \
 		block_dev.o char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
-		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
+		attr.o bad_inode.o file.o filesystems.o namespace.o pnode.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
