Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUJGS2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUJGS2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbUJGS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:27:48 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:27334 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267713AbUJGSZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:25:20 -0400
Subject: [patch 2/2] uml: fix major & minor handling in hostfs 
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 07 Oct 2004 20:22:57 +0200
Message-Id: <20041007182257.2D5B7D85E@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently hostfs passes the rdev value from stat() on the host as rdev value
to return to stat() on the guest; but we cannot pass rdev as is because glibc
and the kernel disagree about its definition. So we must decode it in a
major/minor couple with glibc macros and re-encode it in kernelspace code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/fs/hostfs/hostfs.h      |    2 +-
 linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c |   11 ++++++++---
 linux-2.6.9-current-paolo/fs/hostfs/hostfs_user.c |   10 +++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff -puN fs/hostfs/hostfs.h~uml-hostfs-fix-maj-min fs/hostfs/hostfs.h
--- linux-2.6.9-current/fs/hostfs/hostfs.h~uml-hostfs-fix-maj-min	2004-10-07 17:38:01.759274464 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs.h	2004-10-07 17:38:01.763273856 +0200
@@ -38,7 +38,7 @@ extern int stat_file(const char *path, u
 		     int *blksize_out, unsigned long long *blocks_out);
 extern int access_file(char *path, int r, int w, int x);
 extern int open_file(char *path, int r, int w, int append);
-extern int file_type(const char *path, int *rdev);
+extern int file_type(const char *path, int *maj, int *min);
 extern void *open_dir(char *path, int *err_out);
 extern char *read_dir(void *stream, unsigned long long *pos,
 		      unsigned long long *ino_out, int *len_out);
diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-fix-maj-min fs/hostfs/hostfs_kern.c
--- linux-2.6.9-current/fs/hostfs/hostfs_kern.c~uml-hostfs-fix-maj-min	2004-10-07 17:38:01.760274312 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c	2004-10-07 17:38:01.764273704 +0200
@@ -18,6 +18,7 @@
 #include <linux/buffer_head.h>
 #include <linux/root_dev.h>
 #include <linux/statfs.h>
+#include <linux/kdev_t.h>
 #include <asm/uaccess.h>
 #include "hostfs.h"
 #include "kern_util.h"
@@ -230,7 +231,7 @@ static int read_inode(struct inode *ino)
 	if(name == NULL)
 		goto out;
 
-	if(file_type(name, NULL) == OS_TYPE_SYMLINK){
+	if(file_type(name, NULL, NULL) == OS_TYPE_SYMLINK){
 		name = follow_link(name);
 		if(IS_ERR(name)){
 			err = PTR_ERR(name);
@@ -523,13 +524,17 @@ static struct address_space_operations h
 static int init_inode(struct inode *inode, struct dentry *dentry)
 {
 	char *name;
-	int type, err = -ENOMEM, rdev;
+	int type, err = -ENOMEM;
+	int maj, min;
+	dev_t rdev = 0;
 
 	if(dentry){
 		name = dentry_name(dentry, 0);
 		if(name == NULL)
 			goto out;
-		type = file_type(name, &rdev);
+		type = file_type(name, &maj, &min);
+		/*Reencode maj and min with the kernel encoding.*/
+		rdev = MKDEV(maj, min);
 		kfree(name);
 	}
 	else type = OS_TYPE_DIR;
diff -puN fs/hostfs/hostfs_user.c~uml-hostfs-fix-maj-min fs/hostfs/hostfs_user.c
--- linux-2.6.9-current/fs/hostfs/hostfs_user.c~uml-hostfs-fix-maj-min	2004-10-07 17:38:01.761274160 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs_user.c	2004-10-07 17:38:01.764273704 +0200
@@ -54,14 +54,18 @@ int stat_file(const char *path, unsigned
 	return(0);
 }
 
-int file_type(const char *path, int *rdev)
+int file_type(const char *path, int *maj, int *min)
 {
  	struct stat64 buf;
 
 	if(lstat64(path, &buf) < 0)
 		return(-errno);
-	if(rdev != NULL)
-		*rdev = buf.st_rdev;
+	/*We cannot pass rdev as is because glibc and the kernel disagree
+	 *about its definition.*/
+	if(maj != NULL)
+		*maj = major(buf.st_rdev);
+	if(min != NULL)
+		*min = minor(buf.st_rdev);
 
 	if(S_ISDIR(buf.st_mode)) return(OS_TYPE_DIR);
 	else if(S_ISLNK(buf.st_mode)) return(OS_TYPE_SYMLINK);
_
