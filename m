Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbULCDQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbULCDQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbULCDQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:16:13 -0500
Received: from [61.48.52.229] ([61.48.52.229]:40423 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261392AbULCDPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:15:41 -0500
Date: Thu, 2 Dec 2004 19:06:07 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412030306.iB3367V03088@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: [Fake patch 2.6.10-rc2-bk15] Hide sysfs_dirent definition
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	struct sysfs_dirent is only used internally within fs/sysfs/,
as are the legals for sysfs_dirent.s_type.  The following patch
moves these definitions from the public include/linux/sysfs.h to
the private fs/sysfs/sysfs.h, which is consistent with other
definitions for internal use within sysfs, such as struct
sysfs_symlink.

	This patch makes it clearer that there are no external
dependencies on struct sysfs_dirent, and it also eliminates the
massive recompiles that I had to do every time I would change
something in sysfs_dirent.

	Note that this is a fake patch generated against a
pristine 2.6.10-rc2-bk15 tree, because my tree has some other
changes in it that overlap.  So, please test this patch.  It
should produce exactly the same binaries as before.  If the
patch seems OK, I would appreciate it if this patch could
be forwarded for integration into the stock kernels.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


diff -ur linux-2.6.10-rc2-bk15/fs/sysfs/sysfs.h linux/fs/sysfs/sysfs.h
--- linux-2.6.10-rc2-bk15/fs/sysfs/sysfs.h	2004-11-17 18:59:13.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-12-03 11:01:25.000000000 +0800
@@ -1,3 +1,20 @@
+struct sysfs_dirent {
+	atomic_t		s_count;
+	struct list_head	s_sibling;
+	struct list_head	s_children;
+	void 			* s_element;
+	int			s_type;
+	umode_t			s_mode;
+	struct dentry		* s_dentry;
+};
+
+#define SYSFS_ROOT		0x0001
+#define SYSFS_DIR		0x0002
+#define SYSFS_KOBJ_ATTR 	0x0004
+#define SYSFS_KOBJ_BIN_ATTR	0x0008
+#define SYSFS_KOBJ_LINK 	0x0020
+#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
+
 
 extern struct vfsmount * sysfs_mount;
 
diff -ur linux-2.6.10-rc2-bk15/include/linux/sysfs.h linux/include/linux/sysfs.h
--- linux-2.6.10-rc2-bk15/include/linux/sysfs.h	2004-11-17 18:59:17.000000000 +0800
+++ linux/include/linux/sysfs.h	2004-12-03 11:01:46.000000000 +0800
@@ -59,23 +59,6 @@
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
 };
 
-struct sysfs_dirent {
-	atomic_t		s_count;
-	struct list_head	s_sibling;
-	struct list_head	s_children;
-	void 			* s_element;
-	int			s_type;
-	umode_t			s_mode;
-	struct dentry		* s_dentry;
-};
-
-#define SYSFS_ROOT		0x0001
-#define SYSFS_DIR		0x0002
-#define SYSFS_KOBJ_ATTR 	0x0004
-#define SYSFS_KOBJ_BIN_ATTR	0x0008
-#define SYSFS_KOBJ_LINK 	0x0020
-#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
-
 #ifdef CONFIG_SYSFS
 
 extern int
