Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWF0WWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWF0WWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWF0WWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:22:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45004 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030436AbWF0WOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:46 -0400
Subject: [PATCH 03/20] Add vfsmount writer count
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:38 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221438.722B9366@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows a vfsmount to keep track of how many instances
of files open for write there are at a given time.

A mount can refuse to allow writers.  This can be because
it is a read-only bind mount, or for other functionality
in the future.  A mount can also now refuse to make a
transition from r/w to r/o whenever it has currently active
writers.

Note that this version of the patch does not use an explicit
mount flag.  It is redundant along with the information in
the reference count.

The WARN_ON()s can go away before this is merged into mainline
provided it has had some time in -mm or equivalent.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c        |    1 
 lxc-dave/include/linux/mount.h |   49 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff -puN fs/namespace.c~C-add-vfsmount-writer_count fs/namespace.c
--- lxc/fs/namespace.c~C-add-vfsmount-writer_count	2006-06-27 10:40:25.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-06-27 10:40:25.000000000 -0700
@@ -66,6 +66,7 @@ struct vfsmount *alloc_vfsmnt(const char
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count, 1);
+		atomic_set(&mnt->mnt_writers, 1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
diff -puN include/linux/mount.h~C-add-vfsmount-writer_count include/linux/mount.h
--- lxc/include/linux/mount.h~C-add-vfsmount-writer_count	2006-06-27 10:40:25.000000000 -0700
+++ lxc-dave/include/linux/mount.h	2006-06-27 10:40:25.000000000 -0700
@@ -12,6 +12,8 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
+#include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -43,6 +45,10 @@ struct vfsmount {
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
+	atomic_t mnt_writers;		/* 0  - mount is r/o
+					 * >0 - mount is r/w, there are
+					 * 	mnt_writers-1 writers
+					 */
 	int mnt_flags;
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
@@ -63,6 +69,49 @@ static inline struct vfsmount *mntget(st
 	return mnt;
 }
 
+/*
+ * Must be called under write lock on mnt->mnt_sb->s_umount,
+ * this prevents concurrent decrements which could make the
+ * value -1, and test in mnt_want_write() wrongly succeed
+ */
+static inline int mnt_make_readonly(struct vfsmount *mnt)
+{
+	if (!atomic_dec_and_test(&mnt->mnt_writers)) {
+		atomic_inc(&mnt->mnt_writers);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/*
+ * This can race with itself, so it must be serialized.
+ * It must also be called with mnt->mnt_writers == 0
+ */
+static inline void __mnt_make_writable(struct vfsmount *mnt)
+{
+	WARN_ON(atomic_read(&mnt->mnt_writers));
+	atomic_inc(&mnt->mnt_writers);
+}
+
+static inline int __mnt_is_readonly(struct vfsmount *mnt)
+{
+	return (atomic_read(&mnt->mnt_writers) == 0);
+}
+
+static inline int mnt_want_write(struct vfsmount *mnt)
+{
+	int ret = 0;
+	if (!atomic_add_unless(&mnt->mnt_writers, 1, 0))
+		ret = -EROFS;
+	return ret;
+}
+
+static inline void mnt_drop_write(struct vfsmount *mnt)
+{
+	atomic_dec(&mnt->mnt_writers);
+	WARN_ON(atomic_read(&mnt->mnt_writers) < 1);
+}
+
 extern void mntput_no_expire(struct vfsmount *mnt);
 extern void mnt_pin(struct vfsmount *mnt);
 extern void mnt_unpin(struct vfsmount *mnt);
_
