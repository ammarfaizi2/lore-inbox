Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbUJZF2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUJZF2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbUJZFZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:25:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:64229 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262146AbUJZFRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:17:44 -0400
Subject: Re: [patch] make dnotify a configure-time option
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041025214947.63031519.akpm@osdl.org>
References: <1098765164.6034.38.camel@localhost>
	 <20041025214947.63031519.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 01:18:11 -0400
Message-Id: <1098767891.6034.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 21:49 -0700, Andrew Morton wrote:

> It's actually a sysctl and is also present in 2.4.  I doubt if it's very
> useful but it seems a bit random to be deleting it now.

Well, let's not pretend that we care about interfaces outside of
syscalls.  Removing the sysctl simply results in a return of ENOTDIR
from sysctl(2).  Nothing should break.

But, yah, it is a bit random.  OK.  How about keeping the sysctl, but
only when CONFIG_DNOTIFY=y?

Here is a version of the patch that leaves the sysctl in when dnotify is
enabled, and removes it otherwise.  Is this better?

Thanks,

	Robert Love


make dnotify configurable, via CONFIG_DNOTIFY.

 Documentation/dnotify.txt |    6 ++++++
 fs/Kconfig                |   11 +++++++++++
 fs/Makefile               |   13 +++++++------
 include/linux/dnotify.h   |   46 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h        |    8 +++++++-
 kernel/sysctl.c           |    2 ++
 6 files changed, 74 insertions(+), 12 deletions(-)

diff -urN linux-2.6.9-mm1/Documentation/dnotify.txt linux/Documentation/dnotify.txt
--- linux-2.6.9-mm1/Documentation/dnotify.txt	2004-10-18 17:54:32.000000000 -0400
+++ linux/Documentation/dnotify.txt	2004-10-26 01:03:44.120633208 -0400
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
 
diff -urN linux-2.6.9-mm1/fs/Kconfig linux/fs/Kconfig
--- linux-2.6.9-mm1/fs/Kconfig	2004-10-26 00:14:31.924435248 -0400
+++ linux/fs/Kconfig	2004-10-26 01:03:44.122632904 -0400
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
+++ linux/fs/Makefile	2004-10-26 01:03:44.123632752 -0400
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
+++ linux/include/linux/dnotify.h	2004-10-26 01:03:44.123632752 -0400
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
+++ linux/include/linux/fs.h	2004-10-26 01:04:12.726284488 -0400
@@ -61,7 +61,11 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int leases_enable, dir_notify_enable, lease_break_time;
+extern int leases_enable, lease_break_time;
+
+#ifdef CONFIG_DNOTIFY
+extern int dir_notify_enable;
+#endif
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 #define NR_RESERVED_FILES 10 /* reserved for root */
@@ -464,8 +468,10 @@
 
 	__u32			i_generation;
 
+#ifdef CONFIG_DNOTIFY
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
+#endif
 
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
diff -urN linux-2.6.9-mm1/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.6.9-mm1/kernel/sysctl.c	2004-10-26 00:14:33.274230048 -0400
+++ linux/kernel/sysctl.c	2004-10-26 01:00:28.781329296 -0400
@@ -902,6 +902,7 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_DNOTIFY
 	{
 		.ctl_name	= FS_DIR_NOTIFY,
 		.procname	= "dir-notify-enable",
@@ -910,6 +911,7 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#endif
 	{
 		.ctl_name	= FS_LEASE_TIME,
 		.procname	= "lease-break-time",


