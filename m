Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUJDSWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUJDSWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJDSWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:22:11 -0400
Received: from peabody.ximian.com ([130.57.169.10]:44246 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268090AbUJDSVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:21:01 -0400
Subject: [patch] inotify: make dnotify configurable
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096865816.3827.1.camel@vertex>
References: <1096865816.3827.1.camel@vertex>
Content-Type: multipart/mixed; boundary="=-5dIbaUh3vB09wcjwg4lg"
Date: Mon, 04 Oct 2004 14:19:27 -0400
Message-Id: <1096913967.17426.32.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5dIbaUh3vB09wcjwg4lg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

John,

Attached patch makes dnotify configurable via CONFIG_DNOTIFY.

Such an option makes inotify more attractive, as you can trade good for
evil without the memory consumption of the evil sticking around.

John: Dunno if you want to merge this into the inotify patch or not, but
here it is, diffed on top of inotify-0.12 plus my previous patch.

Best,

	Robert Love


--=-5dIbaUh3vB09wcjwg4lg
Content-Disposition: attachment; filename=inotify-0.12-rml-dnotify-configurable-1.patch
Content-Type: text/x-patch; name=inotify-0.12-rml-dnotify-configurable-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make dnotify configurable via CONFIG_DNOTIFY

Signed-Off-By: Robert Love <rml@novell.com>

 Documentation/dnotify.txt |    8 ++++++++
 fs/Kconfig                |   12 ++++++++++++
 fs/Makefile               |   13 +++++++------
 fs/dnotify.c              |    8 +-------
 include/linux/dnotify.h   |   46 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h        |    4 +++-
 kernel/sysctl.c           |    8 --------
 7 files changed, 72 insertions(+), 27 deletions(-)

diff -urN linux-inotify/Documentation/dnotify.txt linux/Documentation/dnotify.txt
--- linux-inotify/Documentation/dnotify.txt	2004-10-04 14:15:12.971565784 -0400
+++ linux/Documentation/dnotify.txt	2004-10-04 14:14:20.766502160 -0400
@@ -54,6 +54,14 @@
 Also, files that are unlinked, will still cause notifications in the
 last directory that they were linked to.
 
+Configuration
+-------------
+
+Dnotify is controlled via the CONFIG_DNOTIFY configuration option.  When
+disabled, fcntl(fd, F_NOTIFY, ...) will return -EINVAL.
+
+Dnotify is deprecated in favor of inotify (CONFIG_INOTIFY).
+
 Example
 -------
 
diff -urN linux-inotify/fs/dnotify.c linux/fs/dnotify.c
--- linux-inotify/fs/dnotify.c	2004-10-04 14:15:12.796592384 -0400
+++ linux/fs/dnotify.c	2004-10-04 14:14:20.767502008 -0400
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
diff -urN linux-inotify/fs/Kconfig linux/fs/Kconfig
--- linux-inotify/fs/Kconfig	2004-10-04 14:15:12.803591320 -0400
+++ linux/fs/Kconfig	2004-10-04 14:14:20.769501704 -0400
@@ -438,6 +438,18 @@
 	depends on XFS_QUOTA || QUOTA
 	default y
 
+config DNOTIFY
+	bool "Dnotify support"
+	default y
+	help
+	  Dnotify is a directory-based per-fd file change notification system
+	  that uses signals to communicate events to user-space.  It has
+	  been replaced by inotify (see CONFIG_INOTIFY), which solves many of
+	  the shortcomings of dnotify and adds new features, but some
+	  applications may still rely on dnotify.
+	  
+	  Because of this, if unsure, say Y.
+
 config AUTOFS_FS
 	tristate "Kernel automounter support"
 	help
diff -urN linux-inotify/fs/Makefile linux/fs/Makefile
--- linux-inotify/fs/Makefile	2004-10-04 14:15:12.804591168 -0400
+++ linux/fs/Makefile	2004-10-04 14:14:20.769501704 -0400
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
diff -urN linux-inotify/include/linux/dnotify.h linux/include/linux/dnotify.h
--- linux-inotify/include/linux/dnotify.h	2004-10-04 14:15:11.232830112 -0400
+++ linux/include/linux/dnotify.h	2004-10-04 14:14:20.770501552 -0400
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
diff -urN linux-inotify/include/linux/fs.h linux/include/linux/fs.h
--- linux-inotify/include/linux/fs.h	2004-10-04 14:15:11.249827528 -0400
+++ linux/include/linux/fs.h	2004-10-04 14:14:57.982844416 -0400
@@ -62,7 +62,7 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int leases_enable, dir_notify_enable, lease_break_time;
+extern int leases_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 #define NR_RESERVED_FILES 10 /* reserved for root */
@@ -460,8 +460,10 @@
 
 	__u32			i_generation;
 
+#ifdef CONFIG_DNOTIFY
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
+#endif
 
 #ifdef CONFIG_INOTIFY
 	struct inotify_inode_data *inotify_data;
diff -urN linux-inotify/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-inotify/kernel/sysctl.c	2004-10-04 14:15:12.978564720 -0400
+++ linux/kernel/sysctl.c	2004-10-04 14:14:20.774500944 -0400
@@ -879,14 +879,6 @@
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

--=-5dIbaUh3vB09wcjwg4lg--

