Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKTO6s>; Wed, 20 Nov 2002 09:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSKTO6s>; Wed, 20 Nov 2002 09:58:48 -0500
Received: from ns.suse.de ([213.95.15.193]:61445 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261205AbSKTO6l>;
	Wed, 20 Nov 2002 09:58:41 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Make inode_ops->setxattr value parameter const (2.4.x + 2.5.x)
Date: Wed, 20 Nov 2002 16:05:45 +0100
User-Agent: KMail/1.4.3
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Steve Best <sbest@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_L9RVRPIEJ9G2USYG5BAW"
Message-Id: <200211201605.45786.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_L9RVRPIEJ9G2USYG5BAW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

the setxattr inode operation is defined like this in 2.4 and 2.5:

=09int (*setxattr) (struct dentry *dentry, const char *name,
=09=09=09 void *value, size_t size, int flags);

the original type of the value parameter was `const void *'; the const=20
obviously has been lost at some point. The definition should be:

=09int (*setxattr) (struct dentry *dentry, const char *name,
=09=09=09 const void *value, size_t size, int flags);

Please apply the attached patches.


Thanks,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

--------------Boundary-00=_L9RVRPIEJ9G2USYG5BAW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.48-setxattr-const-value.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.5.48-setxattr-const-value.diff"

Make inode_ops->setxattr value parameter const

Add `const' to the value parameter definition of the setxattr inode
operation and fix the resulting warnings in fs/jfs/xattr.c: File
systems are not supposed to modify the value.

Also fixes the non-const usage in jfs, ext2, and ext3.

--- linux-2.5.48.orig/fs/ext2/xattr.c	2002-11-18 05:29:48.000000000 +0100
+++ linux-2.5.48/fs/ext2/xattr.c	2002-11-18 20:15:55.000000000 +0100
@@ -230,7 +230,7 @@
  */
 int
 ext2_setxattr(struct dentry *dentry, const char *name,
-	      void *value, size_t size, int flags)
+	      const void *value, size_t size, int flags)
 {
 	struct ext2_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
--- linux-2.5.48.orig/fs/ext2/xattr.h	2002-11-18 05:29:22.000000000 +0100
+++ linux-2.5.48/fs/ext2/xattr.h	2002-11-18 20:17:07.000000000 +0100
@@ -67,7 +67,7 @@
 extern int ext2_xattr_register(int, struct ext2_xattr_handler *);
 extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
 
-extern int ext2_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern int ext2_setxattr(struct dentry *, const char *, const void *, size_t, int);
 extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
 extern int ext2_removexattr(struct dentry *, const char *);
--- linux-2.5.48.orig/fs/ext3/xattr.c	2002-11-18 05:29:47.000000000 +0100
+++ linux-2.5.48/fs/ext3/xattr.c	2002-11-18 20:18:39.000000000 +0100
@@ -223,7 +223,7 @@
  */
 int
 ext3_setxattr(struct dentry *dentry, const char *name,
-	      void *value, size_t size, int flags)
+	      const void *value, size_t size, int flags)
 {
 	struct ext3_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
--- linux-2.5.48.orig/fs/ext3/xattr.h	2002-11-18 05:29:56.000000000 +0100
+++ linux-2.5.48/fs/ext3/xattr.h	2002-11-18 20:18:12.000000000 +0100
@@ -66,7 +66,7 @@
 extern int ext3_xattr_register(int, struct ext3_xattr_handler *);
 extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
 
-extern int ext3_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern int ext3_setxattr(struct dentry *, const char *, const void *, size_t, int);
 extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
 extern int ext3_removexattr(struct dentry *, const char *);
--- linux-2.5.48.orig/fs/jfs/jfs_xattr.h	2002-11-18 05:29:53.000000000 +0100
+++ linux-2.5.48/fs/jfs/jfs_xattr.h	2002-11-18 23:40:06.000000000 +0100
@@ -52,9 +52,9 @@
 #define	END_EALIST(ealist) \
 	((struct jfs_ea *) (((char *) (ealist)) + EALIST_SIZE(ealist)))
 
-extern int __jfs_setxattr(struct inode *, const char *, void *, size_t,
-			int);
-extern int jfs_setxattr(struct dentry *, const char *, void *, size_t,
+extern int __jfs_setxattr(struct inode *, const char *, const void *, size_t,
+			  int);
+extern int jfs_setxattr(struct dentry *, const char *, const void *, size_t,
 			int);
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_getxattr(struct dentry *, const char *, void *, size_t);
--- linux-2.5.48.orig/fs/jfs/xattr.c	2002-11-18 05:29:31.000000000 +0100
+++ linux-2.5.48/fs/jfs/xattr.c	2002-11-18 20:20:16.000000000 +0100
@@ -706,7 +706,7 @@
 }
 
 static int can_set_xattr(struct inode *inode, const char *name,
-			 void *value, size_t value_len)
+			 const void *value, size_t value_len)
 {
 	if (IS_RDONLY(inode))
 		return -EROFS;
@@ -735,7 +735,7 @@
 #endif
 }
 
-int __jfs_setxattr(struct inode *inode, const char *name, void *value,
+int __jfs_setxattr(struct inode *inode, const char *name, const void *value,
 		   size_t value_len, int flags)
 {
 	struct jfs_ea_list *ealist;
@@ -874,7 +874,7 @@
 	return rc;
 }
 
-int jfs_setxattr(struct dentry *dentry, const char *name, void *value,
+int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		 size_t value_len, int flags)
 {
 	if (value == NULL) {	/* empty EA, do not remove */
--- linux-2.5.48.orig/include/linux/fs.h	2002-11-18 05:29:29.000000000 +0100
+++ linux-2.5.48/include/linux/fs.h	2002-11-18 20:13:06.000000000 +0100
@@ -782,7 +782,7 @@
 	int (*permission) (struct inode *, int);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
-	int (*setxattr) (struct dentry *, const char *, void *, size_t, int);
+	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);

--------------Boundary-00=_L9RVRPIEJ9G2USYG5BAW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.4.20-rc2-setxattr-const-value.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4.20-rc2-setxattr-const-value.diff"

Make inode_ops->setxattr value parameter const

Add `const' to the value parameter definition of the setxattr inode
operation and fix the resulting warnings in fs/jfs/xattr.c: File
systems are not supposed to modify the value.

Also fixes the non-const usage in jfs.

--- linux-2.4.20-rc2.patch/include/linux/fs.h~xattr-const	2002-11-18 23:51:35.000000000 +0100
+++ linux-2.4.20-rc2.patch-agruen/include/linux/fs.h	2002-11-18 23:51:35.000000000 +0100
@@ -866,7 +866,7 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
-	int (*setxattr) (struct dentry *, const char *, void *, size_t, int);
+	int (*setxattr) (struct dentry *, const char *, const void *, size_t, int);
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
--- linux-2.4.20-rc2.patch/fs/jfs/xattr.c~xattr-const	2002-11-18 23:51:35.000000000 +0100
+++ linux-2.4.20-rc2.patch-agruen/fs/jfs/xattr.c	2002-11-18 23:51:35.000000000 +0100
@@ -641,7 +641,7 @@
 }
 
 static int can_set_xattr(struct inode *inode, const char *name,
-			 void *value, size_t value_len)
+			 const void *value, size_t value_len)
 {
 	if (IS_RDONLY(inode))
 		return -EROFS;
@@ -660,7 +660,7 @@
 	return permission(inode, MAY_WRITE);
 }
 
-int __jfs_setxattr(struct inode *inode, const char *name, void *value,
+int __jfs_setxattr(struct inode *inode, const char *name, const void *value,
 		   size_t value_len, int flags)
 {
 	struct jfs_ea_list *ealist;
@@ -799,7 +799,7 @@
 	return rc;
 }
 
-int jfs_setxattr(struct dentry *dentry, const char *name, void *value,
+int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		 size_t value_len, int flags)
 {
 	if (value == NULL) {	/* empty EA, do not remove */
--- linux-2.4.20-rc2.patch/fs/jfs/jfs_xattr.h~xattr-const	2002-11-18 23:52:56.000000000 +0100
+++ linux-2.4.20-rc2.patch-agruen/fs/jfs/jfs_xattr.h	2002-11-18 23:40:27.000000000 +0100
@@ -52,8 +52,10 @@
 #define	END_EALIST(ealist) \
 	((struct jfs_ea *) (((char *) (ealist)) + EALIST_SIZE(ealist)))
 
-extern int __jfs_setxattr(struct inode *, const char *, void *, size_t, int);
-extern int jfs_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern int __jfs_setxattr(struct inode *, const char *, const void *, size_t,
+			  int);
+extern int jfs_setxattr(struct dentry *, const char *, const void *, size_t,
+			int);
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t jfs_listxattr(struct dentry *, char *, size_t);

_

--------------Boundary-00=_L9RVRPIEJ9G2USYG5BAW--

