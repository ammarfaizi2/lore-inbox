Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJAPZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJAPZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJAPXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:23:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39113 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261375AbUJAPWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:22:44 -0400
Subject: Re: [patch] make dnotify compile-time configurable
From: Robert Love <rml@novell.com>
To: Matt Mackall <mpm@selenic.com>
Cc: ttb@tentacle.dhs.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org
In-Reply-To: <20041001151124.GQ31237@waste.org>
References: <1096611874.4803.18.camel@localhost>
	 <20041001151124.GQ31237@waste.org>
Content-Type: multipart/mixed; boundary="=-B02BKrePi2lUfXfJdLDj"
Date: Fri, 01 Oct 2004 11:21:16 -0400
Message-Id: <1096644076.7676.6.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B02BKrePi2lUfXfJdLDj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-10-01 at 10:11 -0500, Matt Mackall wrote:

> Indeed, it's been useful for months. Unfortunately my development
> boxes are still mothballed so progress upstream is stalled.

Oh, great...

/me finds your broken out patches ...

Ah, you ifdef'ed out the dnotify variables in the inode structure.  That
was the original reason I did this--doh.

In mine, I remove the sysctl entirely, which you don't.  I also add some
documentation to dnotify.txt.  Not a big difference.

> > Disabling CONFIG_DNOTIFY saves a couple hundred bytes off of vmlinux.
> 
> Hmm, thought I saved at least 1 or 2k.

I thought my number sounded suspect.  Dunno.

Here is a respun patch ifdef'ing out the dnotify member variables in
struct inode.  This one is diff'ed against my inode tree since the
struct inode changes break one path or the other and, well, I like to
mix things up.

John, want to merge this into the inotify patch?

Thanks, Matt.

	Robert Love


--=-B02BKrePi2lUfXfJdLDj
Content-Disposition: attachment; filename=dnotify-configurable-rml-2.patch
Content-Type: text/x-patch; name=dnotify-configurable-rml-2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

make dnotify configurable via CONFIG_DNOTIFY

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
--- linux-inotify/Documentation/dnotify.txt	2004-09-30 12:09:42.919493656 -0400
+++ linux/Documentation/dnotify.txt	2004-10-01 11:15:38.727889256 -0400
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
--- linux-inotify/fs/dnotify.c	2004-09-30 12:09:42.488559168 -0400
+++ linux/fs/dnotify.c	2004-10-01 11:15:38.728889104 -0400
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
--- linux-inotify/fs/Kconfig	2004-09-30 12:09:42.754518736 -0400
+++ linux/fs/Kconfig	2004-10-01 11:15:38.739887432 -0400
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
--- linux-inotify/fs/Makefile	2004-09-30 12:09:42.755518584 -0400
+++ linux/fs/Makefile	2004-10-01 11:15:38.739887432 -0400
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
--- linux-inotify/include/linux/dnotify.h	2004-09-30 12:09:40.019934456 -0400
+++ linux/include/linux/dnotify.h	2004-10-01 11:15:38.739887432 -0400
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
--- linux-inotify/include/linux/fs.h	2004-09-30 12:09:40.036931872 -0400
+++ linux/include/linux/fs.h	2004-10-01 11:16:19.980617888 -0400
@@ -61,7 +61,7 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int leases_enable, dir_notify_enable, lease_break_time;
+extern int leases_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 #define NR_RESERVED_FILES 10 /* reserved for root */
@@ -459,8 +459,10 @@
 
 	__u32			i_generation;
 
+#ifdef CONFIG_DNOTIFY
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
+#endif
 
 #ifdef CONFIG_INOTIFY
 	struct list_head	watchers;
diff -urN linux-inotify/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-inotify/kernel/sysctl.c	2004-09-30 12:09:42.926492592 -0400
+++ linux/kernel/sysctl.c	2004-10-01 11:15:38.750885760 -0400
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

--=-B02BKrePi2lUfXfJdLDj--

