Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbULMN4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbULMN4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbULMN4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:56:42 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55729 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262261AbULMN4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:56:39 -0500
Date: Mon, 13 Dec 2004 14:56:31 +0100 (MET)
Message-Id: <200412131356.iBDDuVDo028754@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc3-mm1] ioctl cleanups broke FIONREAD et al
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctl-cleanup.patch in 2.6.10-rc3-mm1 broke the file
ioctls: FIONREAD etc. These ioctls have inline code for
S_ISREG() cases, but should be redirected to ->ioctl() for
other cases. ioctl-cleanup.patch removed that redirection.

For me, both emacs and X refused to start from a console with
ENOTTY errors; at least emacs got the ENOTTY from FIONREAD.

The patch below should fix the problem.

/Mikael

--- linux-2.6.10-rc3-mm1/fs/ioctl.c.~1~	2004-12-13 13:05:09.000000000 +0100
+++ linux-2.6.10-rc3-mm1/fs/ioctl.c	2004-12-13 14:35:00.000000000 +0100
@@ -93,10 +93,8 @@ asmlinkage long sys_ioctl(unsigned int f
 			int block;
 			int res;
 
-			if (!S_ISREG(inode->i_mode)) {
-				error = -ENOTTY;
-				goto done;
-			}
+			if (!S_ISREG(inode->i_mode))
+				break;
 			/* do we support this mess? */
 			if (!mapping->a_ops->bmap) {
 				error = -EINVAL;
@@ -116,19 +114,15 @@ asmlinkage long sys_ioctl(unsigned int f
 			goto done;
 		}
 	case FIGETBSZ:
-		if (!S_ISREG(inode->i_mode)) {
-			error = -ENOTTY;
-			goto done;
-		}
+		if (!S_ISREG(inode->i_mode))
+			break;
 		error = -EBADF;
 		if (inode->i_sb)
 			error = put_user(inode->i_sb->s_blocksize, p);
 		goto done;
 	case FIONREAD:
-		if (!S_ISREG(inode->i_mode)) {
-			error = -ENOTTY;
-			goto done;
-		}
+		if (!S_ISREG(inode->i_mode))
+			break;
 		error = put_user(i_size_read(inode) - filp->f_pos, p);
 		goto done;
 	}
