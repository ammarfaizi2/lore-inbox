Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUEBNJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUEBNJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUEBNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:09:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:18956 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263040AbUEBNJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:09:36 -0400
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: simple error handling cleanup (2/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 May 2004 22:09:31 +0900
Message-ID: <871xm3t1pw.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    From: René Scharfe <l.s.r@web.de>

the following patch converts the error handling paths in VFAT fs to use
goto, making it more consistent with other filesystem code. Shrinks the
resulting binary by 144 bytes in my build.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>




 fs/vfat/namei.c |   53 +++++++++++++++++++++++------------------------------
 1 files changed, 23 insertions(+), 30 deletions(-)

diff -puN fs/vfat/namei.c~vfat_cleanup1 fs/vfat/namei.c
--- linux-2.6.6-rc3/fs/vfat/namei.c~vfat_cleanup1	2004-05-02 19:15:38.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/vfat/namei.c	2004-05-02 19:15:39.000000000 +0900
@@ -866,24 +866,22 @@ int vfat_create(struct inode *dir,struct
 
 	lock_kernel();
 	res = vfat_add_entry(dir, &dentry->d_name, 0, &sinfo, &bh, &de);
-	if (res < 0) {
-		unlock_kernel();
-		return res;
-	}
+	if (res < 0)
+		goto out;
 	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
 	brelse(bh);
-	if (!inode) {
-		unlock_kernel();
-		return res;
-	}
+	if (!inode)
+		goto out;
+	res = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 	inode->i_version++;
 	dir->i_version++;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry,inode);
+out:
 	unlock_kernel();
-	return 0;
+	return res;
 }
 
 static void vfat_remove_entry(struct inode *dir,struct vfat_slot_info *sinfo,
@@ -919,16 +917,13 @@ int vfat_rmdir(struct inode *dir,struct 
 
 	lock_kernel();
 	res = fat_dir_empty(dentry->d_inode);
-	if (res) {
-		unlock_kernel();
-		return res;
-	}
+	if (res)
+		goto out;
 
 	res = vfat_find(dir,&dentry->d_name,&sinfo, &bh, &de);
-	if (res<0) {
-		unlock_kernel();
-		return res;
-	}
+	if (res < 0)
+		goto out;
+	res = 0;
 	dentry->d_inode->i_nlink = 0;
 	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
 	fat_detach(dentry->d_inode);
@@ -936,8 +931,9 @@ int vfat_rmdir(struct inode *dir,struct 
 	/* releases bh */
 	vfat_remove_entry(dir,&sinfo,bh,de);
 	dir->i_nlink--;
+out:
 	unlock_kernel();
-	return 0;
+	return res;
 }
 
 int vfat_unlink(struct inode *dir, struct dentry* dentry)
@@ -949,16 +945,15 @@ int vfat_unlink(struct inode *dir, struc
 
 	lock_kernel();
 	res = vfat_find(dir,&dentry->d_name,&sinfo,&bh,&de);
-	if (res < 0) {
-		unlock_kernel();
-		return res;
-	}
+	if (res < 0)
+		goto out;
 	dentry->d_inode->i_nlink = 0;
 	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
 	/* releases bh */
 	vfat_remove_entry(dir,&sinfo,bh,de);
+out:
 	unlock_kernel();
 
 	return res;
@@ -976,13 +971,11 @@ int vfat_mkdir(struct inode *dir,struct 
 
 	lock_kernel();
 	res = vfat_add_entry(dir, &dentry->d_name, 1, &sinfo, &bh, &de);
-	if (res < 0) {
-		unlock_kernel();
-		return res;
-	}
+	if (res < 0)
+		goto out;
 	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
 	if (!inode)
-		goto out;
+		goto out_brelse;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 	inode->i_version++;
@@ -994,8 +987,9 @@ int vfat_mkdir(struct inode *dir,struct 
 		goto mkdir_failed;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry,inode);
-out:
+out_brelse:
 	brelse(bh);
+out:
 	unlock_kernel();
 	return res;
 
@@ -1008,8 +1002,7 @@ mkdir_failed:
 	vfat_remove_entry(dir,&sinfo,bh,de);
 	iput(inode);
 	dir->i_nlink--;
-	unlock_kernel();
-	return res;
+	goto out;
 }
  
 int vfat_rename(struct inode *old_dir,struct dentry *old_dentry,

_
