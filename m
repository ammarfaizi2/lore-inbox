Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUI0TxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUI0TxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUI0TxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:53:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:23207 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267184AbUI0TxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:53:12 -0400
Subject: [patch] inotify: make it configurable
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-z9UbD7TQLvvWuLssFlNb"
Date: Mon, 27 Sep 2004 15:51:52 -0400
Message-Id: <1096314712.30503.100.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z9UbD7TQLvvWuLssFlNb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

Hi, John.

Attached patch makes inotify configurable via the boolean
CONFIG_INOTIFY.  We cannot allow CONFIG_INOTIFY=m without playing with
function pointers, since the inotify (as with dnotify) code is called
from generic code.

Compile tested both on and off.

Also removed some module stuff that was unneeded, since we are not a
module.

A nice TODO would be to make dnotify a compile option, since any modern
desktop using Gamin would not need nor want dnotify.  I will look at
that later.

Rock,

	Robert Love


--=-z9UbD7TQLvvWuLssFlNb
Content-Disposition: attachment; filename=inotify-rml-modularize-1.patch
Content-Type: text/x-patch; name=inotify-rml-modularize-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

add CONFIG_INOTIFY
Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/Kconfig    |   13 ++++++++++++
 drivers/char/Makefile   |    3 +-
 drivers/char/inotify.c  |   14 -------------
 fs/attr.c               |   13 ++++++------
 fs/inode.c              |    4 ++-
 include/linux/fs.h      |    2 +
 include/linux/inotify.h |   50 ++++++++++++++++++++++++++++++++----------------
 7 files changed, 61 insertions(+), 38 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 15:00:04.217801176 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 15:50:14.501168544 -0400
@@ -1060,18 +1060,4 @@
 	return ret;
 }
 
-static void inotify_exit(void)
-{
-	kmem_cache_destroy(kevent_cache);
-	kmem_cache_destroy(watcher_cache);
-	misc_deregister(&inotify_device);
-	printk(KERN_ALERT "inotify shutdown ec=%d wc=%d ic=%d\n",
-	       event_object_count, watcher_object_count, inode_ref_count);
-}
-
-MODULE_AUTHOR("John McCutchan <ttb@tentacle.dhs.org>");
-MODULE_DESCRIPTION("Inode event driver");
-MODULE_LICENSE("GPL");
-
 module_init(inotify_init);
-module_exit(inotify_exit);
diff -urN linux-inotify/drivers/char/Kconfig linux/drivers/char/Kconfig
--- linux-inotify/drivers/char/Kconfig	2004-09-27 12:44:54.750627576 -0400
+++ linux/drivers/char/Kconfig	2004-09-27 15:41:15.704078152 -0400
@@ -62,6 +62,19 @@
 	depends on VT && !S390 && !UM
 	default y
 
+config INOTIFY
+	bool "Inotify file change notification support"
+	default y
+	---help---
+	  Say Y here to enable inotify support and the /dev/inotify character
+	  device.  Inotify is a file change notification system and a
+	  replacement for dnotify.  Inotify fixes numerous shortcomings in
+	  dnotify and introduces several new features.  It allows monitoring
+	  of both files and directories via a single open fd.  Multiple file
+	  events are supported.
+	  
+	  If unsure, say Y.
+
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	---help---
diff -urN linux-inotify/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-inotify/drivers/char/Makefile	2004-09-27 12:44:54.776623624 -0400
+++ linux/drivers/char/Makefile	2004-09-27 15:03:52.603081336 -0400
@@ -7,11 +7,12 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o inotify.o
+obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o
 
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-y				+= misc.o
+obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_VT)		+= vt_ioctl.o vc_screen.o consolemap.o \
 				   consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE)	+= vt.o defkeymap.o
diff -urN linux-inotify/fs/attr.c linux/fs/attr.c
--- linux-inotify/fs/attr.c	2004-09-27 12:44:55.371533184 -0400
+++ linux/fs/attr.c	2004-09-27 15:48:38.187810400 -0400
@@ -129,7 +129,7 @@
 	return dn_mask;
 }
 
-int setattr_mask_inotify(unsigned int ia_valid)
+static int setattr_mask_inotify(unsigned int ia_valid)
 {
 	unsigned long dn_mask = 0;
 
@@ -151,7 +151,6 @@
 	return dn_mask;
 }
 
-
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -210,12 +209,14 @@
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
 		unsigned long in_mask = setattr_mask_inotify(ia_valid);
-		if (dn_mask) {
+
+		if (dn_mask)
 			dnotify_parent(dentry, dn_mask);
-		}
 		if (in_mask) {
-			inotify_inode_queue_event (dentry->d_inode, in_mask, NULL);
-			inotify_dentry_parent_queue_event (dentry, in_mask, dentry->d_name.name);
+			inotify_inode_queue_event(dentry->d_inode, in_mask,
+						  NULL);
+			inotify_dentry_parent_queue_event(dentry, in_mask,
+							  dentry->d_name.name);
 		}
 	}
 	return error;
diff -urN linux-inotify/fs/inode.c linux/fs/inode.c
--- linux-inotify/fs/inode.c	2004-09-27 12:44:55.389530448 -0400
+++ linux/fs/inode.c	2004-09-27 15:48:38.187810400 -0400
@@ -114,7 +114,9 @@
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
 
-		INIT_LIST_HEAD (&inode->watchers);
+#ifdef CONFIG_INOTIFY
+		INIT_LIST_HEAD(&inode->watchers);
+#endif
 		inode->i_sb = sb;
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
diff -urN linux-inotify/include/linux/fs.h linux/include/linux/fs.h
--- linux-inotify/include/linux/fs.h	2004-09-27 12:44:53.844765288 -0400
+++ linux/include/linux/fs.h	2004-09-27 15:44:00.964954680 -0400
@@ -462,9 +462,11 @@
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
+#ifdef CONFIG_INOTIFY
 	struct list_head	watchers;
 	unsigned long		watchers_mask;
 	int			watcher_count;
+#endif
 
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
diff -urN linux-inotify/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-inotify/include/linux/inotify.h	2004-09-27 12:44:53.886758904 -0400
+++ linux/include/linux/inotify.h	2004-09-27 15:35:38.792296528 -0400
@@ -2,8 +2,6 @@
  * Inode based directory notification for Linux
  *
  * Copyright (C) 2004 John McCutchan
- *
- * Signed-off-by: John McCutchan ttb@tentacle.dhs.org
  */
 
 #ifndef _LINUX_INOTIFY_H
@@ -43,12 +41,12 @@
 #define IN_CREATE_SUBDIR	0x00000200	/* Subdir was created */
 #define IN_CREATE_FILE		0x00000400	/* Subfile was created */
 #define IN_DELETE_SELF		0x00000800	/* Self was deleted */
-#define IN_UNMOUNT		0x00001000	/* Backing filesystem was unmounted */
-#define IN_Q_OVERFLOW		0x00002000	/* The event queued overflowed */
+#define IN_UNMOUNT		0x00001000	/* Backing fs was unmounted */
+#define IN_Q_OVERFLOW		0x00002000	/* Event queued overflowed */
 #define IN_IGNORED		0x00004000	/* File was ignored */
 
 /* special flags */
-#define IN_ALL_EVENTS	0xffffffff	/* All the events */
+#define IN_ALL_EVENTS		0xffffffff	/* All the events */
 
 /*
  * struct inotify_watch_request - represents a watch request
@@ -80,20 +78,40 @@
 
 #include <linux/dcache.h>
 #include <linux/fs.h>
+#include <linux/config.h>
 
-/* Adds event to all watchers on inode that are interested in mask */
-void inotify_inode_queue_event (struct inode *inode, unsigned long mask,
-		const char *filename);
-
-/* Same as above but uses dentry's inode */
-void inotify_dentry_parent_queue_event (struct dentry *dentry,
-		unsigned long mask, const char *filename);
+#ifdef CONFIG_INOTIFY
 
-/* This will remove all watchers from all inodes on the superblock */
-void inotify_super_block_umount (struct super_block *sb);
+extern void inotify_inode_queue_event(struct inode *, unsigned long,
+		const char *);
+extern void inotify_dentry_parent_queue_event(struct dentry *, unsigned long,
+		const char *);
+extern void inotify_super_block_umount(struct super_block *);
+extern void inotify_inode_is_dead(struct inode *);
+
+#else
+
+static inline void inotify_inode_queue_event(struct inode *inode,
+					     unsigned long mask,
+					     const char *filename)
+{
+}
+
+static inline void inotify_dentry_parent_queue_event(struct dentry *dentry,
+						     unsigned long mask,
+						     const char *filename)
+{
+}
+
+static inline void inotify_super_block_umount(struct super_block *sb)
+{
+}
+
+static inline void inotify_inode_is_dead(struct inode *inode)
+{
+}
 
-/* Call this when an inode is dead, and inotify should ignore it */
-void inotify_inode_is_dead (struct inode *inode);
+#endif	/* CONFIG_INOTIFY */
 
 #endif	/* __KERNEL __ */
 

--=-z9UbD7TQLvvWuLssFlNb--

