Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTJFQzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTJFQzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:55:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:59662 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262241AbTJFQzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:55:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VFAT: ->i_[cam]time cleanups (1/6)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Oct 2003 01:55:09 +0900
Message-ID: <87isn2paqa.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From René Scharfe <l.s.r@web.de>

there's one call to strncpy() in vfat that really should be a memcpy().
The source, msdos_name, is a space-filled char array, not a
NUL-terminated string.

The rest of the patch eliminates duplicate occurencies of the
CURRENT_TIME macro inside functions. This shrinks vfat.o by a few
bytes.

Please apply.

 linux-2.6.0-test6-hirofumi/fs/vfat/namei.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -puN fs/vfat/namei.c~fat_i_camtime-cleanup fs/vfat/namei.c
--- linux-2.6.0-test6/fs/vfat/namei.c~fat_i_camtime-cleanup	2003-10-06 04:01:13.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/vfat/namei.c	2003-10-07 01:51:20.000000000 +0900
@@ -714,7 +714,7 @@ shortname:
 	PRINTK3(("vfat_fill_slots 9\n"));
 	/* build the entry of 8.3 alias name */
 	(*slots)++;
-	strncpy(de->name, msdos_name, MSDOS_NAME);
+	memcpy(de->name, msdos_name, MSDOS_NAME);
 	de->attr = is_dir ? ATTR_DIR : ATTR_ARCH;
 	de->lcase = lcase;
 	de->adate = de->cdate = de->date = 0;
@@ -901,8 +901,7 @@ static void vfat_remove_entry(struct ino
 	int i;
 
 	/* remove the shortname */
-	dir->i_mtime = CURRENT_TIME;
-	dir->i_atime = CURRENT_TIME;
+	dir->i_mtime = dir->i_atime = CURRENT_TIME;
 	dir->i_version++;
 	mark_inode_dirty(dir);
 	de->name[0] = DELETED_FLAG;
@@ -939,8 +938,7 @@ int vfat_rmdir(struct inode *dir,struct 
 		return res;
 	}
 	dentry->d_inode->i_nlink = 0;
-	dentry->d_inode->i_mtime = CURRENT_TIME;
-	dentry->d_inode->i_atime = CURRENT_TIME;
+	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
 	/* releases bh */
@@ -965,8 +963,7 @@ int vfat_unlink(struct inode *dir, struc
 		return res;
 	}
 	dentry->d_inode->i_nlink = 0;
-	dentry->d_inode->i_mtime = CURRENT_TIME;
-	dentry->d_inode->i_atime = CURRENT_TIME;
+	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
 	/* releases bh */
@@ -1013,8 +1010,7 @@ out:
 
 mkdir_failed:
 	inode->i_nlink = 0;
-	inode->i_mtime = CURRENT_TIME;
-	inode->i_atime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = CURRENT_TIME;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh */

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
