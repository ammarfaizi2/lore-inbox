Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267378AbSKPVmX>; Sat, 16 Nov 2002 16:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267380AbSKPVmX>; Sat, 16 Nov 2002 16:42:23 -0500
Received: from verein.lst.de ([212.34.181.86]:24335 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267378AbSKPVmT>;
	Sat, 16 Nov 2002 16:42:19 -0500
Date: Sat, 16 Nov 2002 22:49:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move mount.h out of fs_struct.h
Message-ID: <20021116224914.D26097@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's only need for the two monster-inlines set_fs_root and set_fs_pwd
that should better be out of line anyway.  Some additional cleanup like
named initializers as extra bonus.


--- 1.30/fs/namespace.c	Sun Nov 10 18:03:21 2002
+++ edited/fs/namespace.c	Sat Nov 16 20:44:27 2002
@@ -879,6 +879,54 @@
 out1:
 	free_page(type_page);
 	return retval;
+}
+
+/*
+ * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
+ * It can block. Requires the big lock held.
+ */
+void set_fs_root(struct fs_struct *fs, struct vfsmount *mnt,
+		 struct dentry *dentry)
+{
+	struct dentry *old_root;
+	struct vfsmount *old_rootmnt;
+	write_lock(&fs->lock);
+	spin_lock(&dcache_lock);
+	old_root = fs->root;
+	old_rootmnt = fs->rootmnt;
+	fs->rootmnt = mntget(mnt);
+	fs->root = dget(dentry);
+	spin_unlock(&dcache_lock);
+	write_unlock(&fs->lock);
+	if (old_root) {
+		dput(old_root);
+		mntput(old_rootmnt);
+	}
+}
+
+/*
+ * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
+ * It can block. Requires the big lock held.
+ */
+void set_fs_pwd(struct fs_struct *fs, struct vfsmount *mnt,
+		struct dentry *dentry)
+{
+	struct dentry *old_pwd;
+	struct vfsmount *old_pwdmnt;
+
+	write_lock(&fs->lock);
+	spin_lock(&dcache_lock);
+	old_pwd = fs->pwd;
+	old_pwdmnt = fs->pwdmnt;
+	fs->pwdmnt = mntget(mnt);
+	fs->pwd = dget(dentry);
+	spin_unlock(&dcache_lock);
+	write_unlock(&fs->lock);
+
+	if (old_pwd) {
+		dput(old_pwd);
+		mntput(old_pwdmnt);
+	}
 }
 
 static void chroot_fs_refs(struct nameidata *old_nd, struct nameidata *new_nd)
--- 1.5/include/linux/fs_struct.h	Mon Apr 29 12:03:36 2002
+++ edited/include/linux/fs_struct.h	Sat Nov 16 20:18:12 2002
@@ -1,9 +1,8 @@
 #ifndef _LINUX_FS_STRUCT_H
 #define _LINUX_FS_STRUCT_H
-#ifdef __KERNEL__
 
-#include <linux/mount.h>
-#include <linux/dcache.h>
+struct dentry;
+struct vfsmount;
 
 struct fs_struct {
 	atomic_t count;
@@ -13,68 +12,17 @@
 	struct vfsmount * rootmnt, * pwdmnt, * altrootmnt;
 };
 
-#define INIT_FS { \
-	ATOMIC_INIT(1), \
-	RW_LOCK_UNLOCKED, \
-	0022, \
-	NULL, NULL, NULL, NULL, NULL, NULL \
+#define INIT_FS {				\
+	.count		= ATOMIC_INIT(1),	\
+	.lock		= RW_LOCK_UNLOCKED,	\
+	.umask		= 0022, \
 }
 
 extern void exit_fs(struct task_struct *);
 extern void set_fs_altroot(void);
+extern void set_fs_root(struct fs_struct *, struct vfsmount *, struct dentry *);
+extern void set_fs_pwd(struct fs_struct *, struct vfsmount *, struct dentry *);
+extern struct fs_struct *copy_fs_struct(struct fs_struct *);
+extern void put_fs_struct(struct fs_struct *);
 
-/*
- * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
- * It can block. Requires the big lock held.
- */
-
-static inline void set_fs_root(struct fs_struct *fs,
-	struct vfsmount *mnt,
-	struct dentry *dentry)
-{
-	struct dentry *old_root;
-	struct vfsmount *old_rootmnt;
-	write_lock(&fs->lock);
-	spin_lock(&dcache_lock);
-	old_root = fs->root;
-	old_rootmnt = fs->rootmnt;
-	fs->rootmnt = mntget(mnt);
-	fs->root = dget(dentry);
-	spin_unlock(&dcache_lock);
-	write_unlock(&fs->lock);
-	if (old_root) {
-		dput(old_root);
-		mntput(old_rootmnt);
-	}
-}
-
-/*
- * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
- * It can block. Requires the big lock held.
- */
-
-static inline void set_fs_pwd(struct fs_struct *fs,
-	struct vfsmount *mnt,
-	struct dentry *dentry)
-{
-	struct dentry *old_pwd;
-	struct vfsmount *old_pwdmnt;
-	write_lock(&fs->lock);
-	spin_lock(&dcache_lock);
-	old_pwd = fs->pwd;
-	old_pwdmnt = fs->pwdmnt;
-	fs->pwdmnt = mntget(mnt);
-	fs->pwd = dget(dentry);
-	spin_unlock(&dcache_lock);
-	write_unlock(&fs->lock);
-	if (old_pwd) {
-		dput(old_pwd);
-		mntput(old_pwdmnt);
-	}
-}
-
-struct fs_struct *copy_fs_struct(struct fs_struct *old);
-void put_fs_struct(struct fs_struct *fs);
-
-#endif
-#endif
+#endif /* _LINUX_FS_STRUCT_H */
