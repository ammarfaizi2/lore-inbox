Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbUJZElH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUJZElH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUJZEiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:38:25 -0400
Received: from peabody.ximian.com ([130.57.169.10]:50661 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262122AbUJZEcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:32:13 -0400
Subject: [patch] make dnotify a configure-time option
From: Robert Love <rml@novell.com>
To: akpm@osdl.org
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Oct 2004 00:32:44 -0400
Message-Id: <1098765164.6034.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch, against 2.6.9-mm1, makes dnotify a configure-time
option via CONFIG_DNOTIFY.

The motivation is in anticipation of inotify, but making dnotify
configurable makes sense regardless.  A similar patch is also in
2.6-tiny.

Everything is straightforward, except the removal of the
dir_notify_enable boot-time option.  My contention is that there is no
reason to make dnotify a boot-time option.  But even if there is, then
surely the user wants it always off, in which case the compile-time
option fulfills the need.

By the way, straightforward is really long for a single word.

Tested with both dnotify on and off.

Best,

	Robert Love


make dnotify a configure-time option, via CONFIG_DNOTIFY

 Documentation/dnotify.txt |    6 ++++++
 fs/Kconfig                |   11 +++++++++++
 fs/Makefile               |   13 +++++++------
 fs/dnotify.c              |    8 +-------
 include/linux/dnotify.h   |   46 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h        |    4 +++-
 kernel/sysctl.c           |    8 --------
 7 files changed, 69 insertions(+), 27 deletions(-)

diff -urN linux-2.6.9-mm1/Documentation/dnotify.txt linux/Documentation/dnotify.txt
--- linux-2.6.9-mm1/Documentation/dnotify.txt	2004-10-18 17:54:32.000000000 -0400
+++ linux/Documentation/dnotify.txt	2004-10-26 00:17:34.196725648 -0400
@@ -54,6 +54,12 @@
 Also, files that are unlinked, will still cause notifications in the
 last directory that they were linked to.
 
+Configuration
+-------------
+
+Dnotify is controlled via the CONFIG_DNOTIFY configuration option.  When
+disabled, fcntl(fd, F_NOTIFY, ...) will return -EINVAL.
+
 Example
 -------
 
diff -urN linux-2.6.9-mm1/fs/dnotify.c linux/fs/dnotify.c
--- linux-2.6.9-mm1/fs/dnotify.c	2004-10-18 17:53:46.000000000 -0400
+++ linux/fs/dnotify.c	2004-10-26 00:15:32.441235296 -0400
@@ -13,6 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  */
+
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -21,8 +22,6 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
-int dir_notify_enable = 1;
-
 static kmem_cache_t *dn_cache;
 
 static void redo_inode_mask(struct inode *inode)
@@ -72,8 +71,6 @@
 		dnotify_flush(filp, id);
 		return 0;
 	}
-	if (!dir_notify_enable)
-		return -EINVAL;
 	inode = filp->f_dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return -ENOTDIR;
@@ -157,9 +154,6 @@
 {
 	struct dentry *parent;
 
-	if (!dir_notify_enable)
-		return;
-
 	spin_lock(&dentry->d_lock);
 	parent = dentry->d_parent;
 	if (parent->d_inode->i_dnotify_mask & event) {
diff -urN linux-2.6.9-mm1/fs/Kconfig linux/fs/Kconfig
--- linux-2.6.9-mm1/fs/Kconfig	2004-10-26 00:14:31.924435248 -0400
+++ linux/fs/Kconfig	2004-10-26 00:18:51.729938808 -0400
@@ -440,6 +440,17 @@
 	depends on XFS_QUOTA || QUOTA
 	default y
 
+config DNOTIFY
+	bool "Dnotify support"
+	default y
+	help
+	  Dnotify is a directory-based per-fd file change notification system
+	  that uses signals to communicate events to user-space.  There exist
+	  superior alternatives, but some applications may still rely on
+	  dnotify.
+	  
+	  Because of this, if unsure, say Y.
+
 config AUTOFS_FS
 	tristate "Kernel automounter support"
 	help
diff -urN linux-2.6.9-mm1/fs/Makefile linux/fs/Makefile
--- linux-2.6.9-mm1/fs/Makefile	2004-10-26 00:14:31.933433880 -0400
+++ linux/fs/Makefile	2004-10-26 00:15:32.444234840 -0400
@@ -5,12 +5,11 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
-obj-y :=	open.o read_write.o file_table.o buffer.o \
-		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
-		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
-		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
-		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+obj-y :=	open.o read_write.o file_table.o buffer.o  bio.o super.o \
+		block_dev.o char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
+		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
+		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
+		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
@@ -37,6 +36,8 @@
 obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
 obj-$(CONFIG_QUOTACTL)		+= quota.o
 
+obj-$(CONFIG_DNOTIFY)		+= dnotify.o
+
 obj-$(CONFIG_PROC_FS)		+= proc/
 obj-y				+= partitions/
 obj-$(CONFIG_SYSFS)		+= sysfs/
diff -urN linux-2.6.9-mm1/include/linux/dnotify.h linux/include/linux/dnotify.h
--- linux-2.6.9-mm1/include/linux/dnotify.h	2004-10-18 17:53:06.000000000 -0400
+++ linux/include/linux/dnotify.h	2004-10-26 00:15:32.444234840 -0400
@@ -1,3 +1,5 @@
+#ifndef _LINUX_DNOTIFY_H
+#define _LINUX_DNOTIFY_H
 /*
  * Directory notification for Linux
  *
@@ -8,20 +10,54 @@
 
 struct dnotify_struct {
 	struct dnotify_struct *	dn_next;
-	unsigned long		dn_mask;	/* Events to be notified
-						   see linux/fcntl.h */
+	unsigned long		dn_mask;
 	int			dn_fd;
 	struct file *		dn_filp;
 	fl_owner_t		dn_owner;
 };
 
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+
+#ifdef CONFIG_DNOTIFY
+
 extern void __inode_dir_notify(struct inode *, unsigned long);
-extern void dnotify_flush(struct file *filp, fl_owner_t id);
+extern void dnotify_flush(struct file *, fl_owner_t);
 extern int fcntl_dirnotify(int, struct file *, unsigned long);
-void dnotify_parent(struct dentry *dentry, unsigned long event);
+extern void dnotify_parent(struct dentry *, unsigned long);
 
 static inline void inode_dir_notify(struct inode *inode, unsigned long event)
 {
-	if ((inode)->i_dnotify_mask & (event))
+	if (inode->i_dnotify_mask & (event))
 		__inode_dir_notify(inode, event);
 }
+
+#else
+
+static inline void __inode_dir_notify(struct inode *inode, unsigned long event)
+{
+}
+
+static inline void dnotify_flush(struct file *filp, fl_owner_t id)
+{
+}
+
+static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+static inline void dnotify_parent(struct dentry *dentry, unsigned long event)
+{
+}
+
+static inline void inode_dir_notify(struct inode *inode, unsigned long event)
+{
+}
+
+#endif /* CONFIG_DNOTIFY */
+
+#endif /* __KERNEL __ */
+
+#endif /* _LINUX_DNOTIFY_H */
diff -urN linux-2.6.9-mm1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.6.9-mm1/include/linux/fs.h	2004-10-26 00:14:32.890288416 -0400
+++ linux/include/linux/fs.h	2004-10-26 00:16:24.707289648 -0400
@@ -61,7 +61,7 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int leases_enable, dir_notify_enable, lease_break_time;
+extern int leases_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 #define NR_RESERVED_FILES 10 /* reserved for root */
@@ -464,8 +464,10 @@
 
 	__u32			i_generation;
 
+#ifdef CONFIG_DNOTIFY
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
+#endif
 
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
diff -urN linux-2.6.9-mm1/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.6.9-mm1/kernel/sysctl.c	2004-10-26 00:14:33.274230048 -0400
+++ linux/kernel/sysctl.c	2004-10-26 00:15:32.448234232 -0400
@@ -903,14 +903,6 @@
 		.proc_handler	= &proc_dointvec,
 	},
 	{
-		.ctl_name	= FS_DIR_NOTIFY,
-		.procname	= "dir-notify-enable",
-		.data		= &dir_notify_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
 		.ctl_name	= FS_LEASE_TIME,
 		.procname	= "lease-break-time",
 		.data		= &lease_break_time,


