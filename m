Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271939AbTHDRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271940AbTHDRC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:02:29 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:26567 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S271939AbTHDRCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:02:19 -0400
Date: Mon, 4 Aug 2003 13:02:16 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] 2.4.22pre10+aa: XFS has it right, setxattr() takes "const void *"
Message-ID: <20030804170216.GA5804@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the XFS developers have the right idea about setxattr(),
namely that it should take a "const void *" parameter for the attributes
it will set, rather than "void *".

This patch Makes It So.  It is in some sense only cosmetic, since the
generated code is the same, but the usage of const is a Good Thing for
this kind of interface.

PS: I created the patch against 2.4.20pre10 plus many of the patches
in the 'aa' tree, so perhaps it should be taken as more of a suggested
idea rather than a literal patch.


Index: linux/fs/befs/linuxvfs.c
--- linux/fs/befs/linuxvfs.c.old	2003-06-13 10:51:37.000000000 -0400
+++ linux/fs/befs/linuxvfs.c	2003-08-04 12:34:02.000000000 -0400
@@ -59,5 +59,5 @@
 static ssize_t befs_getxattr(struct dentry *dentry, const char *name,
 			     void *buffer, size_t size);
-static int befs_setxattr(struct dentry *dentry, const char *name, void *value,
+static int befs_setxattr(struct dentry *dentry, const char *name, const void *value,
 			 size_t size, int flags);
 static int befs_removexattr(struct dentry *dentry, const char *name);
@@ -694,5 +694,5 @@
 static int
 befs_setxattr(struct dentry *dentry, const char *name,
-	      void *value, size_t size, int flags)
+	      const void *value, size_t size, int flags)
 {
 	return 0;

Index: linux/fs/jfs/jfs_xattr.h
--- linux/fs/jfs/jfs_xattr.h.old	2002-11-28 18:53:15.000000000 -0500
+++ linux/fs/jfs/jfs_xattr.h	2003-08-04 12:33:53.000000000 -0400
@@ -53,6 +53,6 @@
 	((struct jfs_ea *) (((char *) (ealist)) + EALIST_SIZE(ealist)))
 
-extern int __jfs_setxattr(struct inode *, const char *, void *, size_t, int);
-extern int jfs_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern int __jfs_setxattr(struct inode *, const char *, const void *, size_t, int);
+extern int jfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_getxattr(struct dentry *, const char *, void *, size_t);

Index: linux/fs/jfs/xattr.c
--- linux/fs/jfs/xattr.c.old	2002-11-28 18:53:15.000000000 -0500
+++ linux/fs/jfs/xattr.c	2003-08-04 12:33:44.000000000 -0400
@@ -661,5 +661,5 @@
 }
 
-int __jfs_setxattr(struct inode *inode, const char *name, void *value,
+int __jfs_setxattr(struct inode *inode, const char *name, const void *value,
 		   size_t value_len, int flags)
 {
@@ -800,5 +800,5 @@
 }
 
-int jfs_setxattr(struct dentry *dentry, const char *name, void *value,
+int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		 size_t value_len, int flags)
 {

Index: linux/fs/xattr.c
--- linux/fs/xattr.c.old	2002-11-28 18:53:15.000000000 -0500
+++ linux/fs/xattr.c	2003-08-04 12:33:15.000000000 -0400
@@ -59,5 +59,5 @@
  */
 static long
-setxattr(struct dentry *d, char *name, void *value, size_t size, int flags)
+setxattr(struct dentry *d, char *name, const void *value, size_t size, int flags)
 {
 	int error;
@@ -97,5 +97,5 @@
 
 asmlinkage long
-sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
+sys_setxattr(char *path, char *name, const void *value, size_t size, int flags)
 {
 	struct nameidata nd;
@@ -111,5 +111,5 @@
 
 asmlinkage long
-sys_lsetxattr(char *path, char *name, void *value, size_t size, int flags)
+sys_lsetxattr(char *path, char *name, const void *value, size_t size, int flags)
 {
 	struct nameidata nd;
@@ -125,5 +125,5 @@
 
 asmlinkage long
-sys_fsetxattr(int fd, char *name, void *value, size_t size, int flags)
+sys_fsetxattr(int fd, char *name, const void *value, size_t size, int flags)
 {
 	struct file *f;

Index: linux/include/linux/fs.h
--- linux/include/linux/fs.h.old	2003-08-04 12:18:32.000000000 -0400
+++ linux/include/linux/fs.h	2003-08-04 12:34:37.000000000 -0400
@@ -990,5 +990,5 @@
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
-	int (*setxattr) (struct dentry *, const char *, void *, size_t, int);
+	int (*setxattr) (struct dentry *, const char *, const void *, size_t, int);
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);



-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
