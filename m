Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVKHCI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVKHCI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVKHCI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:08:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27085 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965227AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 10/18] beginning of the shared-subtree proper
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ev-7N@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401947 -0500

A private mount does not forward or receive propagation.  This patch provides
user the ability to convert any mount to private.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/Makefile           |    2 +-
 fs/namespace.c        |   24 ++++++++++++++++++++++++
 fs/pnode.c            |   17 +++++++++++++++++
 fs/pnode.h            |   14 ++++++++++++++
 include/linux/fs.h    |    1 +
 include/linux/mount.h |   10 +++++-----
 6 files changed, 62 insertions(+), 6 deletions(-)
 create mode 100644 fs/pnode.c
 create mode 100644 fs/pnode.h

281805822dfdf14eb3503de6cc54906a849159d2
diff --git a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o
+		ioprio.o pnode.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -24,6 +24,7 @@
 #include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include "pnode.h"
 
 extern int __init init_rootfs(void);
 
@@ -663,6 +664,27 @@ out_unlock:
 }
 
 /*
+ * recursively change the type of the mountpoint.
+ */
+static int do_change_type(struct nameidata *nd, int flag)
+{
+	struct vfsmount *m, *mnt = nd->mnt;
+	int recurse = flag & MS_REC;
+	int type = flag & ~MS_REC;
+
+	if (nd->dentry != nd->mnt->mnt_root)
+		return -EINVAL;
+
+	down_write(&namespace_sem);
+	spin_lock(&vfsmount_lock);
+	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
+		change_mnt_propagation(m, type);
+	spin_unlock(&vfsmount_lock);
+	up_write(&namespace_sem);
+	return 0;
+}
+
+/*
  * do loopback mount.
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
@@ -1091,6 +1113,8 @@ long do_mount(char *dev_name, char *dir_
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+	else if (flags & MS_PRIVATE)
+		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff --git a/fs/pnode.c b/fs/pnode.c
new file mode 100644
--- /dev/null
+++ b/fs/pnode.c
@@ -0,0 +1,17 @@
+/*
+ *  linux/fs/pnode.c
+ *
+ * (C) Copyright IBM Corporation 2005.
+ *	Released under GPL v2.
+ *	Author : Ram Pai (linuxram@us.ibm.com)
+ *
+ */
+#include <linux/namespace.h>
+#include <linux/mount.h>
+#include <linux/fs.h>
+#include "pnode.h"
+
+void change_mnt_propagation(struct vfsmount *mnt, int type)
+{
+	mnt->mnt_flags &= ~MNT_PNODE_MASK;
+}
diff --git a/fs/pnode.h b/fs/pnode.h
new file mode 100644
--- /dev/null
+++ b/fs/pnode.h
@@ -0,0 +1,14 @@
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
+void change_mnt_propagation(struct vfsmount *, int);
+#endif /* _LINUX_PNODE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -104,6 +104,7 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
diff --git a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -17,12 +17,12 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_NOSUID	0x01
+#define MNT_NODEV	0x02
+#define MNT_NOEXEC	0x04
+#define MNT_PNODE_MASK	0x30	/* propogation flag mask */
 
-struct vfsmount
-{
+struct vfsmount {
 	struct list_head mnt_hash;
 	struct vfsmount *mnt_parent;	/* fs we are mounted on */
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */
