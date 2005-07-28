Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVG1R2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVG1R2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVG1R01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:26:27 -0400
Received: from [151.97.230.9] ([151.97.230.9]:54182 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261757AbVG1RZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:25:14 -0400
Subject: [patch 1/1] uml: implement hostfs syncing
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 19:42:06 +0200
Message-Id: <20050728174208.A017EA3@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Actually implement the hostfs "sync" method.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/os-Linux/user_syms.c |    3 +++
 linux-2.6.git-paolo/fs/hostfs/hostfs.h           |    1 +
 linux-2.6.git-paolo/fs/hostfs/hostfs_kern.c      |    2 +-
 linux-2.6.git-paolo/fs/hostfs/hostfs_user.c      |   16 +++++++++++++++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-syncing fs/hostfs/hostfs_kern.c
--- linux-2.6.git/fs/hostfs/hostfs_kern.c~uml-hostfs-syncing	2005-07-28 18:27:31.000000000 +0200
+++ linux-2.6.git-paolo/fs/hostfs/hostfs_kern.c	2005-07-28 18:27:31.000000000 +0200
@@ -382,7 +382,7 @@ int hostfs_file_open(struct inode *ino, 
 
 int hostfs_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
-	return(0);
+	return fsync_file(HOSTFS_I(dentry->d_inode)->fd, datasync);
 }
 
 static struct file_operations hostfs_file_fops = {
diff -puN fs/hostfs/hostfs_user.c~uml-hostfs-syncing fs/hostfs/hostfs_user.c
--- linux-2.6.git/fs/hostfs/hostfs_user.c~uml-hostfs-syncing	2005-07-28 18:27:31.000000000 +0200
+++ linux-2.6.git-paolo/fs/hostfs/hostfs_user.c	2005-07-28 18:27:31.000000000 +0200
@@ -153,10 +153,24 @@ int lseek_file(int fd, long long offset,
 	int ret;
 
 	ret = lseek64(fd, offset, whence);
-	if(ret < 0) return(-errno);
+	if(ret < 0)
+		return(-errno);
 	return(0);
 }
 
+int fsync_file(int fd, int datasync)
+{
+	int ret;
+	if (datasync)
+		ret = fdatasync(fd);
+	else
+		ret = fsync(fd);
+
+	if (ret < 0)
+		return -errno;
+	return 0;
+}
+
 void close_file(void *stream)
 {
 	close(*((int *) stream));
diff -puN fs/hostfs/hostfs.h~uml-hostfs-syncing fs/hostfs/hostfs.h
--- linux-2.6.git/fs/hostfs/hostfs.h~uml-hostfs-syncing	2005-07-28 18:27:31.000000000 +0200
+++ linux-2.6.git-paolo/fs/hostfs/hostfs.h	2005-07-28 18:27:31.000000000 +0200
@@ -69,6 +69,7 @@ extern int read_file(int fd, unsigned lo
 extern int write_file(int fd, unsigned long long *offset, const char *buf,
 		      int len);
 extern int lseek_file(int fd, long long offset, int whence);
+extern int fsync_file(int fd, int datasync);
 extern int file_create(char *name, int ur, int uw, int ux, int gr,
 		       int gw, int gx, int or, int ow, int ox);
 extern int set_attr(const char *file, struct hostfs_iattr *attrs);
diff -puN arch/um/os-Linux/user_syms.c~uml-hostfs-syncing arch/um/os-Linux/user_syms.c
--- linux-2.6.git/arch/um/os-Linux/user_syms.c~uml-hostfs-syncing	2005-07-28 18:27:31.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/os-Linux/user_syms.c	2005-07-28 18:27:31.000000000 +0200
@@ -83,6 +83,9 @@ EXPORT_SYMBOL_PROTO(statfs64);
 
 EXPORT_SYMBOL_PROTO(getuid);
 
+EXPORT_SYMBOL_PROTO(fsync);
+EXPORT_SYMBOL_PROTO(fdatasync);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
_
