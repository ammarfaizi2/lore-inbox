Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992860AbWJUHQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992860AbWJUHQa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992880AbWJUHO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:57 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:27271 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992860AbWJUHOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:37 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 07 of 23] fat: change uses of f_{dentry,vfsmnt} to use f_path
Message-Id: <6e4d7789eb45b4e4f6bd.1161411452@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:32 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, hirofumi@mail.parknet.co.jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the fat filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 4 insertions(+), 4 deletions(-)
fs/fat/dir.c  |    6 +++---
fs/fat/file.c |    2 +-

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -579,7 +579,7 @@ parse_record:
 	if (!memcmp(de->name, MSDOS_DOT, MSDOS_NAME))
 		inum = inode->i_ino;
 	else if (!memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
-		inum = parent_ino(filp->f_dentry);
+		inum = parent_ino(filp->f_path.dentry);
 	} else {
 		loff_t i_pos = fat_make_i_pos(sb, bh, de);
 		struct inode *tmp = fat_iget(sb, i_pos);
@@ -643,7 +643,7 @@ out:
 
 static int fat_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	return __fat_readdir(inode, filp, dirent, filldir, 0, 0);
 }
 
@@ -782,7 +782,7 @@ static long fat_compat_dir_ioctl(struct 
 
 	set_fs(KERNEL_DS);
 	lock_kernel();
-	ret = fat_dir_ioctl(file->f_dentry->d_inode, file,
+	ret = fat_dir_ioctl(file->f_path.dentry->d_inode, file,
 			    cmd, (unsigned long) &d);
 	unlock_kernel();
 	set_fs(oldfs);
diff --git a/fs/fat/file.c b/fs/fat/file.c
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -92,7 +92,7 @@ int fat_generic_ioctl(struct inode *inod
 		}
 
 		/* This MUST be done before doing anything irreversible... */
-		err = notify_change(filp->f_dentry, &ia);
+		err = notify_change(filp->f_path.dentry, &ia);
 		if (err)
 			goto up;
 


