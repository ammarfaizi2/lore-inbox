Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSECBoa>; Thu, 2 May 2002 21:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315532AbSECBo3>; Thu, 2 May 2002 21:44:29 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:11793 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315529AbSECBo2>; Thu, 2 May 2002 21:44:28 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu, torvalds@transmeta.edu
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Replace exec_permission_lite() with inlined vfs_permission()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 May 2002 18:44:13 -0700
Message-Id: <E173S7J-0004EH-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since exec_permission_lite() is now basically an inlined and
constant-propagated duplicate of vfs_permission(), this patch drops
exec_permission_lite() and makes vfs_permission() inlined (but not
static) and calls it from link_path_walk() if the inode doesn't have an
i_op->permission() method.

diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/fs/namei.c linux-2.5.13-permission/fs/namei.c
--- linux-2.5.13/fs/namei.c	Thu May  2 17:22:48 2002
+++ linux-2.5.13-permission/fs/namei.c	Thu May  2 17:48:11 2002
@@ -153,7 +153,7 @@
  * for filesystem access without changing the "normal" uids which
  * are used for other things..
  */
-int vfs_permission(struct inode * inode, int mask)
+inline int vfs_permission(struct inode * inode, int mask)
 {
 	umode_t			mode = inode->i_mode;
 
@@ -300,40 +300,6 @@
 }
 
 /*
- * Short-cut version of permission(), for calling by
- * path_walk(), when dcache lock is held.  Combines parts
- * of permission() and vfs_permission(), and tests ONLY for
- * MAY_EXEC permission.
- *
- * If appropriate, check DAC only.  If not appropriate, or
- * short-cut DAC fails, then call permission() to do more
- * complete permission check.
- */
-static inline int exec_permission_lite(struct inode *inode)
-{
-	umode_t	mode = inode->i_mode;
-
-	if ((inode->i_op && inode->i_op->permission))
-		return -EAGAIN;
-
-	if (current->fsuid == inode->i_uid)
-		mode >>= 6;
-	else if (in_group_p(inode->i_gid))
-		mode >>= 3;
-
-	if (mode & MAY_EXEC)
-		return 0;
-
-	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
-		return 0;
-
-	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
-		return 0;
-
-	return -EACCES;
-}
-
-/*
  * This is called when everything else fails, and we actually have
  * to go to the low-level filesystem to find out what we should do..
  *
@@ -578,11 +544,12 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = exec_permission_lite(inode);
-		if (err == -EAGAIN) {
+		if(inode->i_op && inode->i_op->permission) {
 			unlock_nd(nd);
 			err = permission(inode, MAY_EXEC);
 			lock_nd(nd);
+		} else {
+			err = vfs_permission(inode, MAY_EXEC);
 		}
  		if (err)
 			break;


