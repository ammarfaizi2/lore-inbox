Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKPB2n>; Wed, 15 Nov 2000 20:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbQKPB2d>; Wed, 15 Nov 2000 20:28:33 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:12786 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129094AbQKPB2Y>;
	Wed, 15 Nov 2000 20:28:24 -0500
Date: Thu, 16 Nov 2000 01:58:22 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011160058.BAA20802@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 truncate() change broke `dd'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test10 broke `dd' for block devices, due to the following
change to do_sys_truncate & do_sys_ftruncate:

diff -u --recursive --new-file v2.4.0-test9/linux/fs/open.c linux/fs/open.c
--- v2.4.0-test9/linux/fs/open.c	Sun Oct  8 10:50:33 2000
+++ linux/fs/open.c	Thu Oct 26 08:11:21 2000
@@ -103,7 +103,7 @@
 	inode = nd.dentry->d_inode;
 
 	error = -EACCES;
-	if (S_ISDIR(inode->i_mode))
+	if (!S_ISREG(inode->i_mode))
 		goto dput_and_out;
 
 	error = permission(inode,MAY_WRITE);
@@ -164,7 +164,7 @@
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
 	error = -EACCES;
-	if (S_ISDIR(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
+	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
 		goto out_putf;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))

I noticed because I needed to build a boot floppy with an
initial ram disk under 2.4.0-test11pre5. The standard recipe
(Documentation/ramdisk.txt) basically goes:
- dd if=bzImage of=/dev/fd0 bs=1k
  notice how many blocks dd reported (NNN)
- dd if=ram_image of=/dev/fd0 bs=1k seek=NNN
dd implements the seek=NNN option by calling ftruncate() before
starting the write. This is where 2.4.0-test10 breaks, since
ftruncate on a block device now provokes an EACCES error.

Maybe `dd' is buggy and should use lseek() instead, but this has
apparently worked for a long time.

Does anyone know the reason for the S_ISDIR -> !S_ISREG change in test10?

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
