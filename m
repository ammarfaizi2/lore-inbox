Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSEYLEA>; Sat, 25 May 2002 07:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSEYLEA>; Sat, 25 May 2002 07:04:00 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:32019 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S314458AbSEYLD7>; Sat, 25 May 2002 07:03:59 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the handling of dentry on msdos_lookup() (1/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 25 May 2002 20:03:44 +0900
Message-ID: <87bsb41obz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If d_splice_alias() doesn't find the alias dentry, it returns NULL.
Then, msdos_lookup() dereference the NULL, and Oops.
This patch fixes this.

Side of vfat_lookup() is cleanup only.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.18/fs/msdos/namei.c fat_dentry-2.5.18/fs/msdos/namei.c
--- linux-2.5.18/fs/msdos/namei.c	Sat May 25 16:52:08 2002
+++ fat_dentry-2.5.18/fs/msdos/namei.c	Sat May 25 17:09:22 2002
@@ -222,22 +222,17 @@
 	if (res)
 		goto out;
 add:
-	if (inode) {
-		dentry = d_splice_alias(inode, dentry);
-		dentry->d_op = &msdos_dentry_operations;
-	} else {
-		d_add(dentry, inode);
-		dentry = NULL;
-	}
 	res = 0;
+	dentry = d_splice_alias(inode, dentry);
+	if (dentry)
+		dentry->d_op = &msdos_dentry_operations;
 out:
 	if (bh)
 		fat_brelse(sb, bh);
 	unlock_kernel();
-	if (res)
-		return ERR_PTR(res);
-	else
+	if (!res)
 		return dentry;
+	return ERR_PTR(res);
 }
 
 /***** Creates a directory entry (name is already formatted). */
diff -urN linux-2.5.18/fs/vfat/namei.c fat_dentry-2.5.18/fs/vfat/namei.c
--- linux-2.5.18/fs/vfat/namei.c	Sat May 25 16:52:14 2002
+++ fat_dentry-2.5.18/fs/vfat/namei.c	Sat May 25 17:09:22 2002
@@ -1021,16 +1021,12 @@
 	unlock_kernel();
 	dentry->d_op = &vfat_dentry_ops[table];
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
-	if (inode) {
-		dentry = d_splice_alias(inode, dentry);
-		if (dentry) {
-			dentry->d_op = &vfat_dentry_ops[table];
-			dentry->d_time = dentry->d_parent->d_inode->i_version;
-		}
-		return dentry;
+	dentry = d_splice_alias(inode, dentry);
+	if (dentry) {
+		dentry->d_op = &vfat_dentry_ops[table];
+		dentry->d_time = dentry->d_parent->d_inode->i_version;
 	}
-	d_add(dentry,inode);
-	return NULL;
+	return dentry;
 }
 
 int vfat_create(struct inode *dir,struct dentry* dentry,int mode)
