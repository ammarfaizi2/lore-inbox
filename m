Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbVIPS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbVIPS1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbVIPS1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:27:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19390 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161236AbVIPS05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:26:57 -0400
Date: Fri, 16 Sep 2005 11:26:19 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 2/10] vfs: make mounts shared/slave/private 
Message-ID: <20050916182619.GA28444@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that creates mounts that sets up 
1. two-way propagation(shared) or
2. only receives propagation(slave) or
3. do not receive or forward propagation (private)

A shared mount can be bind-mount to some mountpoint. And any mount/
umount events within any of these mounts propagates to the other mount.

Eg: 	mount --make-shared /mnt
	mount --bind /mnt /tmp

	The above two steps make the /mnt and /tmp propagation peers.

	mount /dev/sda0 /mnt/1 

	is mounted on both /mnt/1 as well as /tmp/1


A slave mount, only receives mount/umount events from its master mount.
But any mount/umount in the slave mount is not propagated to the
master.

Eg: 	Lets say /mnt ant /tmp are peers(shared mounts)

	mount --make-slave /tmp

	The above step makes /tmp a slave of /mnt

	mount /dev/sda0 /mnt/1 

	is mounted on both /mnt/1 as well as /tmp/1

	but mount /dev/sda1 /tmp/1
	is mounted only on /tmp/1 and not on /mnt/1


A private mount does not receive or forward any mount/unmount event.
This is the default mount.


Signed by Ram Pai (linuxram@us.ibm.com)

 fs/Makefile           |    2 
 fs/namespace.c        |   50 +++++++++++++++++++++
 fs/pnode.c            |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    3 +
 include/linux/mount.h |   29 +++++++++---
 include/linux/pnode.h |   47 ++++++++++++++++++++
 6 files changed, 239 insertions(+), 8 deletions(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -20,10 +20,11 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/pnode.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
 extern int __init init_rootfs(void);
 
@@ -60,10 +61,13 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_expire);
+		INIT_LIST_HEAD(&mnt->mnt_share);
+		INIT_LIST_HEAD(&mnt->mnt_slave_list);
+		INIT_LIST_HEAD(&mnt->mnt_slave);
 		if (name) {
 			int size = strlen(name) + 1;
 			char *newname = kmalloc(size, GFP_KERNEL);
 			if (newname) {
 				memcpy(newname, name, size);
@@ -614,10 +618,54 @@ static int graft_tree(struct vfsmount *m
 		security_sb_post_addmount(mnt, nd);
 	return err;
 }
 
 /*
+ * recursively change the type of the mountpoint.
+ */
+static int do_change_type(struct nameidata *nd, int flag)
+{
+	struct vfsmount *m, *mnt = nd->mnt;
+	int err = 0;
+	int recurse = flag & MS_REC;
+
+	if (nd->dentry != nd->mnt->mnt_root)
+		return -EINVAL;
+
+	down_write(&namespace_sem);
+	spin_lock(&vfsmount_lock);
+	switch (flag & ~MS_REC) {
+	case MS_SHARED:
+		for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
+			do_make_shared(m);
+		break;
+	case MS_SLAVE:
+		for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL)) {
+			err = do_make_slave(m);
+			if (err && m == mnt)
+				goto out;
+			else
+				err = 0;
+			/*
+			 * note: The mount tree need not have all it mounts as
+			 * shared. Hence it is expected to have some failure
+			 * while slaving mounts down the tree.
+			 */
+		}
+		break;
+	case MS_PRIVATE:
+		for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
+			do_make_private(m);
+		break;
+	}
+      out:
+	spin_unlock(&vfsmount_lock);
+	up_write(&namespace_sem);
+	return err;
+}
+
+/*
  * do loopback mount.
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
 	struct nameidata old_nd;
@@ -1051,10 +1099,12 @@ long do_mount(char *dev_name, char *dir_
 	if (flags & MS_REMOUNT)
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE))
+		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
 		retval = do_new_mount(&nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
Index: 2.6.13.sharedsubtree/fs/pnode.c
===================================================================
--- /dev/null
+++ 2.6.13.sharedsubtree/fs/pnode.c
@@ -0,0 +1,116 @@
+/*
+ *  linux/fs/pnode.c
+ *
+ * (C) Copyright IBM Corporation 2005.
+ *	Released under GPL v2.
+ *	Author : Ram Pai (linuxram@us.ibm.com)
+ *
+ */
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
+/* spinlock for pnode related operations */
+__cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
+
+/*
+ * make @mnt the slave of @master
+ */
+static void make_slave_of(struct vfsmount *mnt, struct vfsmount *master)
+{
+	list_del_init(&mnt->mnt_slave);
+	if (master)
+		list_add(&mnt->mnt_slave, &master->mnt_slave_list);
+	mnt->mnt_master = master;
+}
+
+static int __do_make_slave(struct vfsmount *mnt)
+{
+	struct vfsmount *peer_mnt, *master = mnt->mnt_master;
+	struct vfsmount *slave_mnt, *t_slave_mnt;
+
+	peer_mnt = next_shared(mnt);
+	if (peer_mnt == mnt)
+		peer_mnt = NULL;
+
+	list_del_init(&mnt->mnt_share);
+	/*
+	 * first we will attempt to move 'mnt' and its slaves
+	 * under 'peer_mnt'. if that is not possible we will
+	 * try to move them under the 'master'. And if this
+	 * is also not possible than we make them all
+	 * independent(they can no more be slaves).
+	 */
+	if (peer_mnt) {
+		if (master) {
+			/*
+			 * switch the pivot to peer_mnt
+			 */
+			BUG_ON(peer_mnt->mnt_master);
+			BUG_ON(!list_empty(&peer_mnt->mnt_slave));
+			make_slave_of(peer_mnt, master);
+		}
+		master = peer_mnt;
+	}
+
+	list_for_each_entry_safe(slave_mnt, t_slave_mnt,
+				 &mnt->mnt_slave_list, mnt_slave)
+	    make_slave_of(slave_mnt, master);
+
+	make_slave_of(mnt, master);
+	CLEAR_MNT_SHARED(mnt);
+	INIT_LIST_HEAD(&mnt->mnt_slave_list);
+	return 0;
+}
+
+int do_make_shared(struct vfsmount *mnt)
+{
+	set_mnt_shared(mnt);
+	return 0;
+}
+
+int do_make_slave(struct vfsmount *mnt)
+{
+	int err = 0;
+
+	spin_lock(&vfspnode_lock);
+	if (!IS_MNT_SHARED(mnt)) {
+		err = -EINVAL;
+		goto out;
+	}
+	__do_make_slave(mnt);
+      out:
+	spin_unlock(&vfspnode_lock);
+	return err;
+}
+
+int do_make_private(struct vfsmount *mnt)
+{
+	/*
+	 * a private mount is nothing but a
+	 * slave mount with no incoming
+	 * propagations.
+	 */
+	spin_lock(&vfspnode_lock);
+	__do_make_slave(mnt);
+	list_del_init(&mnt->mnt_slave);
+	spin_unlock(&vfspnode_lock);
+	mnt->mnt_master = NULL;
+	set_mnt_private(mnt);
+	return 0;
+}
Index: 2.6.13.sharedsubtree/include/linux/fs.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/fs.h
+++ 2.6.13.sharedsubtree/include/linux/fs.h
@@ -100,10 +100,13 @@ extern int dir_notify_enable;
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_PRIVATE	(1<<18)	/* recursively change to private */
+#define MS_SLAVE	(1<<19)	/* recursively change to slave */
+#define MS_SHARED	(1<<20)	/* recursively change to shared */
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
 /*
Index: 2.6.13.sharedsubtree/include/linux/pnode.h
===================================================================
--- /dev/null
+++ 2.6.13.sharedsubtree/include/linux/pnode.h
@@ -0,0 +1,47 @@
+/*
+ *  linux/fs/pnode.h
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
+extern spinlock_t vfspnode_lock;
+
+static inline void set_mnt_shared(struct vfsmount *mnt)
+{
+	mnt->mnt_flags &= ~MNT_PNODE_MASK;
+	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_SHARED;
+}
+
+static inline void set_mnt_private(struct vfsmount *mnt)
+{
+	mnt->mnt_flags &= ~MNT_PNODE_MASK;
+}
+
+static inline struct vfsmount *next_shared(struct vfsmount *p)
+{
+	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
+}
+
+static inline struct vfsmount *first_slave(struct vfsmount *p)
+{
+	return list_entry(p->mnt_slave_list.next, struct vfsmount, mnt_slave);
+}
+
+static inline struct vfsmount *next_slave(struct vfsmount *p)
+{
+	return list_entry(p->mnt_slave.next, struct vfsmount, mnt_slave);
+}
+
+int do_make_slave(struct vfsmount *);
+int do_make_shared(struct vfsmount *);
+int do_make_private(struct vfsmount *);
+#endif				/* _LINUX_PNODE_H */
Index: 2.6.13.sharedsubtree/include/linux/mount.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/mount.h
+++ 2.6.13.sharedsubtree/include/linux/mount.h
@@ -15,16 +15,27 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_NOSUID	0x01
+#define MNT_NODEV	0x02
+#define MNT_NOEXEC	0x04
+#define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
+#define MNT_PNODE_MASK	0x30	/* propogation flag mask */
+
+#define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
+#define IS_MNT_SLAVE(mnt) (!list_empty(&mnt->mnt_slave))
+#define IS_MNT_PRIVATE(mnt) (!IS_MNT_SLAVE(mnt) && \
+			!(mnt->mnt_flags & MNT_PNODE_MASK))
+#define IS_MNT_UNCLONABLE(mnt) (mnt->mnt_flags & MNT_UNCLONABLE)
+#define GET_MNT_TYPE(mnt) (mnt->mnt_flags & MNT_PNODE_MASK)
+#define SET_MNT_TYPE(mnt, type) (mnt->mnt_flags &= ~MNT_PNODE_MASK, \
+			mnt->mnt_flags |= (type & MNT_PNODE_MASK))
+#define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
 
-struct vfsmount
-{
+struct vfsmount {
 	struct list_head mnt_hash;
 	struct vfsmount *mnt_parent;	/* fs we are mounted on */
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */
 	struct dentry *mnt_root;	/* root of the mounted tree */
 	struct super_block *mnt_sb;	/* pointer to superblock */
@@ -34,11 +45,15 @@ struct vfsmount
 	int mnt_flags;
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
-	struct namespace *mnt_namespace; /* containing namespace */
+	struct list_head mnt_share;	/* circular list of shared mounts */
+	struct list_head mnt_slave_list;	/* list of slave mounts */
+	struct list_head mnt_slave;	/* slave list entry */
+	struct vfsmount *mnt_master;	/* slave is on master->mnt_slave_list */
+	struct namespace *mnt_namespace;/* containing namespace */
 };
 
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
@@ -78,6 +93,6 @@ extern void mark_mounts_for_expiry(struc
 
 extern spinlock_t vfsmount_lock;
 extern dev_t name_to_dev_t(char *name);
 
 #endif
-#endif /* _LINUX_MOUNT_H */
+#endif				/* _LINUX_MOUNT_H */
Index: 2.6.13.sharedsubtree/fs/Makefile
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/Makefile
+++ 2.6.13.sharedsubtree/fs/Makefile
@@ -8,11 +8,11 @@
 obj-y :=	open.o read_write.o file_table.o buffer.o  bio.o super.o \
 		block_dev.o char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o
+		ioprio.o pnode.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
 
