Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293627AbSCKXYH>; Mon, 11 Mar 2002 18:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310186AbSCKXX6>; Mon, 11 Mar 2002 18:23:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:45073 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293627AbSCKXXu>;
	Mon, 11 Mar 2002 18:23:50 -0500
Subject: [PATCH] 2.4: UFS lseek cleanup
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 11 Mar 2002 18:23:58 -0500
Message-Id: <1015889043.853.103.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The following patch continues the 2.4 lseek cleanup by removing a
redundant ufs_file_lseek implementation and having UFS use the standard
generic_file_llseek.

Al (who signed off on this for 2.5) says the implementation assumed it
needed explicit size checking, but the standard generic_file_llseek does
this just fine.  So it is redundant and a sane cleanup.  The patch is
already in -ac, but not in 2.4.19-pre3.

This is against 2.4.19-pre3, please apply.

	Robert Love

diff -urN linux-2.4.19-pre3/fs/ufs/file.c linux/fs/ufs/file.c
--- linux-2.4.19-pre3/fs/ufs/file.c	Mon Mar 11 18:08:04 2002
+++ linux/fs/ufs/file.c	Mon Mar 11 18:10:20 2002
@@ -37,43 +37,12 @@
 #include <linux/pagemap.h>
 
 /*
- * Make sure the offset never goes beyond the 32-bit mark..
- */
-static long long ufs_file_lseek(
-	struct file *file,
-	long long offset,
-	int origin )
-{
-	long long retval;
-	struct inode *inode = file->f_dentry->d_inode;
-
-	switch (origin) {
-		case 2:
-			offset += inode->i_size;
-			break;
-		case 1:
-			offset += file->f_pos;
-	}
-	retval = -EINVAL;
-	/* make sure the offset fits in 32 bits */
-	if (((unsigned long long) offset >> 32) == 0) {
-		if (offset != file->f_pos) {
-			file->f_pos = offset;
-			file->f_reada = 0;
-			file->f_version = ++event;
-		}
-		retval = offset;
-	}
-	return retval;
-}
-
-/*
  * We have mostly NULL's here: the current defaults are ok for
  * the ufs filesystem.
  */
  
 struct file_operations ufs_file_operations = {
-	llseek:		ufs_file_lseek,
+	llseek:		generic_file_llseek,
 	read:		generic_file_read,
 	write:		generic_file_write,
 	mmap:		generic_file_mmap,


