Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJPU0J>; Wed, 16 Oct 2002 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSJPU0J>; Wed, 16 Oct 2002 16:26:09 -0400
Received: from ns.suse.de ([213.95.15.193]:35853 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261381AbSJPU0D>;
	Wed, 16 Oct 2002 16:26:03 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] linux-2.5.43-mm1: Further xattr/acl cleanups
Date: Wed, 16 Oct 2002 22:32:00 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <E181a3S-0006Nq-00@snap.thunk.org> <200210161336.27935.agruen@suse.de> <3DAD8D5E.31E177BA@digeo.com>
In-Reply-To: <3DAD8D5E.31E177BA@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C1D3XOUOTFMP2AKE0BP7"
Message-Id: <200210162232.00441.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C1D3XOUOTFMP2AKE0BP7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This is against=20
<http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.43/2.5.43-mm1/>.=20
Please look inside for comments. Seems to work pretty well; it has alread=
y=20
passed my basic test suite.

--Andreas.

--------------Boundary-00=_C1D3XOUOTFMP2AKE0BP7
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mm1-incr1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mm1-incr1.diff"

Changes:

* Minimize the calls to mark_inode_dirty() and ext3_mark_inode_dirty()
  by removing extra calls from ext[23]_init_acl()
* ext3_acl_chmod() cleanup: Don't pass in transaction handle anymore
* Remove 2.4 locking leftover in fs/ext3/inode.c:ext3_setattr()
* Remove the [gs]et_posix_acl inode operations

diff -Nur linux-2.5.43-mm1/fs/ext2/acl.c linux-2.5.43-mm1+/fs/ext2/acl.c
--- linux-2.5.43-mm1/fs/ext2/acl.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext2/acl.c	2002-10-16 20:19:09.000000000 +0200
@@ -124,13 +124,7 @@
 	return ERR_PTR(-EINVAL);
 }
 
-/*
- * Inode operation get_posix_acl().
- *
- * inode->i_sem: down
- * BKL held [before 2.5.x]
- */
-struct posix_acl *
+static struct posix_acl *
 ext2_get_acl(struct inode *inode, int type)
 {
 	int name_index;
@@ -177,13 +171,7 @@
 	return acl;
 }
 
-/*
- * Inode operation set_posix_acl().
- *
- * inode->i_sem: down
- * BKL held [before 2.5.x]
- */
-int
+static int
 ext2_set_acl(struct inode *inode, int type, struct posix_acl *acl)
 {
 	int name_index;
@@ -348,10 +336,8 @@
 			if (IS_ERR(acl))
 				return PTR_ERR(acl);
 		}
-		if (!acl) {
+		if (!acl)
 			inode->i_mode &= ~current->fs->umask;
-			mark_inode_dirty(inode);
-		}
 	}
 	if (test_opt(inode->i_sb, POSIX_ACL) && acl) {
                struct posix_acl *clone;
@@ -370,7 +356,6 @@
 		error = posix_acl_create_masq(clone, &mode);
 		if (error >= 0) {
 			inode->i_mode = mode;
-			mark_inode_dirty(inode);
 			if (error > 0) {
 				/* This is an extended ACL */
 				error = ext2_set_acl(inode,
diff -Nur linux-2.5.43-mm1/fs/ext2/acl.h linux-2.5.43-mm1+/fs/ext2/acl.h
--- linux-2.5.43-mm1/fs/ext2/acl.h	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext2/acl.h	2002-10-16 20:25:05.000000000 +0200
@@ -62,8 +62,6 @@
 /* acl.c */
 extern int ext2_permission (struct inode *, int);
 extern int ext2_permission_locked (struct inode *, int);
-extern struct posix_acl *ext2_get_acl (struct inode *, int);
-extern int ext2_set_acl (struct inode *, int, struct posix_acl *);
 extern int ext2_acl_chmod (struct inode *);
 extern int ext2_init_acl (struct inode *, struct inode *);
 
@@ -73,8 +71,6 @@
 #else
 #include <linux/sched.h>
 #define ext2_permission NULL
-#define ext2_get_acl	NULL
-#define ext2_set_acl	NULL
 
 static inline int
 ext2_acl_chmod (struct inode *inode)
diff -Nur linux-2.5.43-mm1/fs/ext2/file.c linux-2.5.43-mm1+/fs/ext2/file.c
--- linux-2.5.43-mm1/fs/ext2/file.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext2/file.c	2002-10-16 20:20:05.000000000 +0200
@@ -63,6 +63,4 @@
 	.removexattr	= ext2_removexattr,
 	.setattr	= ext2_setattr,
 	.permission	= ext2_permission,
-	.get_posix_acl	= ext2_get_acl,
-	.set_posix_acl	= ext2_set_acl,
 };
diff -Nur linux-2.5.43-mm1/fs/ext2/namei.c linux-2.5.43-mm1+/fs/ext2/namei.c
--- linux-2.5.43-mm1/fs/ext2/namei.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext2/namei.c	2002-10-16 20:20:00.000000000 +0200
@@ -379,8 +379,6 @@
 	.removexattr	= ext2_removexattr,
 	.setattr	= ext2_setattr,
 	.permission	= ext2_permission,
-	.get_posix_acl	= ext2_get_acl,
-	.set_posix_acl	= ext2_set_acl,
 };
 
 struct inode_operations ext2_special_inode_operations = {
@@ -390,6 +388,4 @@
 	.removexattr	= ext2_removexattr,
 	.setattr	= ext2_setattr,
 	.permission	= ext2_permission,
-	.get_posix_acl	= ext2_get_acl,
-	.set_posix_acl	= ext2_set_acl,
 };
diff -Nur linux-2.5.43-mm1/fs/ext3/acl.c linux-2.5.43-mm1+/fs/ext3/acl.c
--- linux-2.5.43-mm1/fs/ext3/acl.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext3/acl.c	2002-10-16 20:40:32.000000000 +0200
@@ -125,12 +125,7 @@
 	return ERR_PTR(-EINVAL);
 }
 
-/*
- * Inode operation get_posix_acl().
- *
- * inode->i_sem: down
- */
-struct posix_acl *
+static struct posix_acl *
 ext3_get_acl(struct inode *inode, int type)
 {
 	int name_index;
@@ -183,7 +178,7 @@
  * inode->i_sem: down unless called from ext3_new_inode
  */
 static int
-ext3_do_set_acl(handle_t *handle, struct inode *inode, int type,
+ext3_set_acl(handle_t *handle, struct inode *inode, int type,
 		struct posix_acl *acl)
 {
 	int name_index;
@@ -243,30 +238,6 @@
 	return error;
 }
 
-/*
- * Inode operation set_posix_acl().
- *
- * inode->i_sem: down
- */
-
-int
-ext3_set_acl(struct inode *inode, int type, struct posix_acl *acl)
-{
-	handle_t *handle;
-	int error;
-	
-	if (!test_opt(inode->i_sb, POSIX_ACL))
-		return 0;
-
-	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
-	error = ext3_do_set_acl(handle, inode, type, acl);
-	ext3_journal_stop(handle, inode);
-
-	return error;
-}
-
 static int
 __ext3_permission(struct inode *inode, int mask, int lock)
 {
@@ -368,18 +339,16 @@
 			if (IS_ERR(acl))
 				return PTR_ERR(acl);
 		}
-		if (!acl) {
+		if (!acl)
 			inode->i_mode &= ~current->fs->umask;
-			ext3_mark_inode_dirty(handle, inode);
-		}
 	}
 	if (test_opt(inode->i_sb, POSIX_ACL) && acl) {
 		struct posix_acl *clone;
 		mode_t mode;
 
 		if (S_ISDIR(inode->i_mode)) {
-			error = ext3_do_set_acl(handle, inode,
-						ACL_TYPE_DEFAULT, acl);
+			error = ext3_set_acl(handle, inode,
+					     ACL_TYPE_DEFAULT, acl);
 			if (error)
 				goto cleanup;
 		}
@@ -392,11 +361,10 @@
 		error = posix_acl_create_masq(clone, &mode);
 		if (error >= 0) {
 			inode->i_mode = mode;
-			ext3_mark_inode_dirty(handle, inode);
 			if (error > 0) {
 				/* This is an extended ACL */
-				error = ext3_do_set_acl(handle, inode,
-							ACL_TYPE_ACCESS, clone);
+				error = ext3_set_acl(handle, inode,
+						     ACL_TYPE_ACCESS, clone);
 			}
 		}
 		posix_acl_release(clone);
@@ -421,7 +389,7 @@
  * inode->i_sem: down
  */
 int
-ext3_acl_chmod(handle_t *handle, struct inode *inode)
+ext3_acl_chmod(struct inode *inode)
 {
 	struct posix_acl *acl, *clone;
         int error;
@@ -438,8 +406,17 @@
 	if (!clone)
 		return -ENOMEM;
 	error = posix_acl_chmod_masq(clone, inode->i_mode);
-	if (!error)
-		error = ext3_do_set_acl(handle, inode, ACL_TYPE_ACCESS, clone);
+	if (!error) {
+		handle_t *handle;
+		
+		handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
+		if (IS_ERR(handle)) {
+			ext3_std_error(inode->i_sb, error);
+			return PTR_ERR(handle);
+		}
+		error = ext3_set_acl(handle, inode, ACL_TYPE_ACCESS, clone);
+		ext3_journal_stop(handle, inode);
+	}
 	posix_acl_release(clone);
 	return error;
 }
@@ -538,7 +515,7 @@
 	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	error = ext3_do_set_acl(handle, inode, type, acl);
+	error = ext3_set_acl(handle, inode, type, acl);
 	ext3_journal_stop(handle, inode);
 
 release_and_out:
diff -Nur linux-2.5.43-mm1/fs/ext3/acl.h linux-2.5.43-mm1+/fs/ext3/acl.h
--- linux-2.5.43-mm1/fs/ext3/acl.h	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext3/acl.h	2002-10-16 20:24:43.000000000 +0200
@@ -62,12 +62,8 @@
 /* acl.c */
 extern int ext3_permission (struct inode *, int);
 extern int ext3_permission_locked (struct inode *, int);
-extern struct posix_acl *ext3_get_acl (struct inode *, int);
-extern int ext3_set_acl (struct inode *, int, struct posix_acl *);
-extern int ext3_acl_chmod (handle_t *, struct inode *);
+extern int ext3_acl_chmod (struct inode *);
 extern int ext3_init_acl (handle_t *, struct inode *, struct inode *);
-extern int ext3_get_acl_xattr (struct inode *, int, void *, size_t);
-extern int ext3_set_acl_xattr (struct inode *, int, void *, size_t);
 
 extern int init_ext3_acl(void);
 extern void exit_ext3_acl(void);
@@ -75,11 +71,9 @@
 #else  /* CONFIG_EXT3_FS_POSIX_ACL */
 #include <linux/sched.h>
 #define ext3_permission NULL
-#define ext3_get_acl	NULL
-#define ext3_set_acl	NULL
 
 static inline int
-ext3_acl_chmod(handle_t *handle, struct inode *inode)
+ext3_acl_chmod(struct inode *inode)
 {
 	return 0;
 }
diff -Nur linux-2.5.43-mm1/fs/ext3/file.c linux-2.5.43-mm1+/fs/ext3/file.c
--- linux-2.5.43-mm1/fs/ext3/file.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext3/file.c	2002-10-16 20:20:47.000000000 +0200
@@ -104,7 +104,5 @@
 	.listxattr	= ext3_listxattr,
 	.removexattr	= ext3_removexattr,
 	.permission	= ext3_permission,
-	.get_posix_acl	= ext3_get_acl,
-	.set_posix_acl	= ext3_set_acl,
 };
 
diff -Nur linux-2.5.43-mm1/fs/ext3/inode.c linux-2.5.43-mm1+/fs/ext3/inode.c
--- linux-2.5.43-mm1/fs/ext3/inode.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext3/inode.c	2002-10-16 20:06:13.000000000 +0200
@@ -2559,23 +2559,8 @@
 	if (S_ISREG(inode->i_mode) && inode->i_nlink)
 		ext3_orphan_del(NULL, inode);
 
-#ifdef CONFIG_EXT3_FS_POSIX_ACL
-	if (!rc && test_opt(inode->i_sb, POSIX_ACL) && (ia_valid & ATTR_MODE)) {
-		handle_t *handle;
-
-		handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
-		if (IS_ERR(handle)) {
-			error = PTR_ERR(handle);
-			goto err_out;
-		}
-		if (!(ia_valid & ATTR_SIZE))
-			down(&inode->i_sem);
-		rc = ext3_acl_chmod(handle, inode);
-		if (!(ia_valid & ATTR_SIZE))
-			up(&inode->i_sem);
-		ext3_journal_stop(handle, inode);
-	}
-#endif
+	if (!rc && (ia_valid & ATTR_MODE))
+		rc = ext3_acl_chmod(inode);
 
 err_out:
 	ext3_std_error(inode->i_sb, error);
diff -Nur linux-2.5.43-mm1/fs/ext3/namei.c linux-2.5.43-mm1+/fs/ext3/namei.c
--- linux-2.5.43-mm1/fs/ext3/namei.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/ext3/namei.c	2002-10-16 20:20:42.000000000 +0200
@@ -2290,8 +2290,6 @@
 	.listxattr	= ext3_listxattr,	
 	.removexattr	= ext3_removexattr,
 	.permission	= ext3_permission,
-	.get_posix_acl	= ext3_get_acl,
-	.set_posix_acl	= ext3_set_acl,
 };
 
 struct inode_operations ext3_special_inode_operations = {
@@ -2301,8 +2299,6 @@
 	.listxattr	= ext3_listxattr,
 	.removexattr	= ext3_removexattr,
 	.permission	= ext3_permission,
-	.get_posix_acl	= ext3_get_acl,
-	.set_posix_acl	= ext3_set_acl,
 };
 
  
diff -Nur linux-2.5.43-mm1/fs/posix_acl.c linux-2.5.43-mm1+/fs/posix_acl.c
--- linux-2.5.43-mm1/fs/posix_acl.c	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/fs/posix_acl.c	2002-10-16 20:38:47.000000000 +0200
@@ -410,37 +410,3 @@
 
 	return 0;
 }
-
-/*
- * Get the POSIX ACL of an inode.
- */
-struct posix_acl *
-get_posix_acl(struct inode *inode, int type)
-{
-	struct posix_acl *acl;
-
-	if (!inode->i_op->get_posix_acl)
-		return ERR_PTR(-EOPNOTSUPP);
-	down(&inode->i_sem);
-	acl = inode->i_op->get_posix_acl(inode, type);
-	up(&inode->i_sem);
-
-	return acl;
-}
-
-/*
- * Set the POSIX ACL of an inode.
- */
-int
-set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
-{
-	int error;
-
-	if (!inode->i_op->set_posix_acl)
-		return -EOPNOTSUPP;
-	down(&inode->i_sem);
-	error = inode->i_op->set_posix_acl(inode, type, acl);
-	up(&inode->i_sem);
-
-	return error;
-}
diff -Nur linux-2.5.43-mm1/include/linux/fs.h linux-2.5.43-mm1+/include/linux/fs.h
--- linux-2.5.43-mm1/include/linux/fs.h	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/include/linux/fs.h	2002-10-16 20:20:27.000000000 +0200
@@ -792,8 +792,6 @@
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
-	struct posix_acl *(*get_posix_acl) (struct inode *, int);
-	int (*set_posix_acl) (struct inode *, int, struct posix_acl *);
 };
 
 struct seq_file;
diff -Nur linux-2.5.43-mm1/include/linux/posix_acl.h linux-2.5.43-mm1+/include/linux/posix_acl.h
--- linux-2.5.43-mm1/include/linux/posix_acl.h	2002-10-16 19:15:56.000000000 +0200
+++ linux-2.5.43-mm1+/include/linux/posix_acl.h	2002-10-16 20:38:38.000000000 +0200
@@ -81,7 +81,4 @@
 extern int posix_acl_chmod_masq(struct posix_acl *, mode_t);
 extern int posix_acl_masq_nfs_mode(struct posix_acl *, mode_t *);
 
-extern struct posix_acl *get_posix_acl(struct inode *, int);
-extern int set_posix_acl(struct inode *, int, struct posix_acl *);
-
 #endif  /* __LINUX_POSIX_ACL_H */

--------------Boundary-00=_C1D3XOUOTFMP2AKE0BP7--

