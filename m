Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCETxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCETxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCETvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:51:41 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:23301 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261196AbVCETLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] FAT: fat_build_inode() cleanup
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:49:38 +0900
In-Reply-To: <87ekeuq672.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:49:05 +0900")
Message-ID: <87acpiq665.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just use ERR_PTR() instead of getting the error code by additional
argument.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c           |   62 ++++++++++++++++++++++-------------------------
 fs/msdos/namei.c         |   17 +++++++-----
 fs/vfat/namei.c          |   19 ++++++++------
 include/linux/msdos_fs.h |    2 -
 4 files changed, 52 insertions(+), 48 deletions(-)

diff -puN fs/fat/inode.c~sync06-fat_dir-cleanup4 fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~sync06-fat_dir-cleanup4	2005-03-06 02:36:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:36:32.000000000 +0900
@@ -304,23 +304,25 @@ static int fat_fill_inode(struct inode *
 }
 
 struct inode *fat_build_inode(struct super_block *sb,
-			struct msdos_dir_entry *de, loff_t i_pos, int *res)
+			struct msdos_dir_entry *de, loff_t i_pos)
 {
 	struct inode *inode;
-	*res = 0;
+	int err;
+
 	inode = fat_iget(sb, i_pos);
 	if (inode)
 		goto out;
 	inode = new_inode(sb);
-	*res = -ENOMEM;
-	if (!inode)
+	if (!inode) {
+		inode = ERR_PTR(-ENOMEM);
 		goto out;
+	}
 	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
 	inode->i_version = 1;
-	*res = fat_fill_inode(inode, de);
-	if (*res < 0) {
+	err = fat_fill_inode(inode, de);
+	if (err) {
 		iput(inode);
-		inode = NULL;
+		inode = ERR_PTR(err);
 		goto out;
 	}
 	fat_attach(inode, i_pos);
@@ -643,39 +645,35 @@ fat_encode_fh(struct dentry *de, __u32 *
 
 static struct dentry *fat_get_parent(struct dentry *child)
 {
-	struct buffer_head *bh=NULL;
-	struct msdos_dir_entry *de = NULL;
-	struct dentry *parent = NULL;
-	int res;
-	loff_t i_pos = 0;
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	loff_t i_pos;
+	struct dentry *parent;
 	struct inode *inode;
+	int err;
 
 	lock_kernel();
-	res = fat_scan(child->d_inode, MSDOS_DOTDOT, &bh, &de, &i_pos);
 
-	if (res < 0)
+	err = fat_scan(child->d_inode, MSDOS_DOTDOT, &bh, &de, &i_pos);
+	if (err) {
+		parent = ERR_PTR(err);
 		goto out;
-	inode = fat_build_inode(child->d_sb, de, i_pos, &res);
-	if (res)
+	}
+	inode = fat_build_inode(child->d_sb, de, i_pos);
+	brelse(bh);
+	if (IS_ERR(inode)) {
+		parent = ERR_PTR(PTR_ERR(inode));
 		goto out;
-	if (!inode)
-		res = -EACCES;
-	else {
-		parent = d_alloc_anon(inode);
-		if (!parent) {
-			iput(inode);
-			res = -ENOMEM;
-		}
 	}
-
- out:
-	if(bh)
-		brelse(bh);
+	parent = d_alloc_anon(inode);
+	if (!parent) {
+		iput(inode);
+		parent = ERR_PTR(-ENOMEM);
+	}
+out:
 	unlock_kernel();
-	if (res)
-		return ERR_PTR(res);
-	else
-		return parent;
+
+	return parent;
 }
 
 static struct export_operations fat_export_ops = {
diff -puN fs/msdos/namei.c~sync06-fat_dir-cleanup4 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync06-fat_dir-cleanup4	2005-03-06 02:36:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:32.000000000 +0900
@@ -236,9 +236,11 @@ static struct dentry *msdos_lookup(struc
 		goto add;
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, de, i_pos, &res);
-	if (res)
+	inode = fat_build_inode(sb, de, i_pos);
+	if (IS_ERR(inode)) {
+		res = PTR_ERR(inode);
 		goto out;
+	}
 add:
 	res = 0;
 	dentry = d_splice_alias(inode, dentry);
@@ -314,11 +316,11 @@ static int msdos_create(struct inode *di
 		unlock_kernel();
 		return res;
 	}
-	inode = fat_build_inode(dir->i_sb, de, i_pos, &res);
+	inode = fat_build_inode(dir->i_sb, de, i_pos);
 	brelse(bh);
-	if (!inode) {
+	if (IS_ERR(inode)) {
 		unlock_kernel();
-		return res;
+		return PTR_ERR(inode);
 	}
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
@@ -392,9 +394,10 @@ static int msdos_mkdir(struct inode *dir
 	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 1, is_hid);
 	if (res)
 		goto out_unlock;
-	inode = fat_build_inode(dir->i_sb, de, i_pos, &res);
-	if (!inode) {
+	inode = fat_build_inode(dir->i_sb, de, i_pos);
+	if (IS_ERR(inode)) {
 		brelse(bh);
+		res = PTR_ERR(inode);
 		goto out_unlock;
 	}
 	res = 0;
diff -puN fs/vfat/namei.c~sync06-fat_dir-cleanup4 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync06-fat_dir-cleanup4	2005-03-06 02:36:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:32.000000000 +0900
@@ -757,11 +757,11 @@ static struct dentry *vfat_lookup(struct
 		table++;
 		goto error;
 	}
-	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos, &err);
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	brelse(sinfo.bh);
-	if (err) {
+	if (IS_ERR(inode)) {
 		unlock_kernel();
-		return ERR_PTR(err);
+		return ERR_PTR(PTR_ERR(inode));
 	}
 	alias = d_find_alias(inode);
 	if (alias) {
@@ -798,10 +798,12 @@ static int vfat_create(struct inode *dir
 	res = vfat_add_entry(dir, &dentry->d_name, 0, &sinfo);
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos, &res);
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	brelse(sinfo.bh);
-	if (!inode)
+	if (IS_ERR(inode)) {
+		res = PTR_ERR(inode);
 		goto out;
+	}
 	res = 0;
 	inode->i_version++;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
@@ -883,9 +885,11 @@ static int vfat_mkdir(struct inode *dir,
 	res = vfat_add_entry(dir, &dentry->d_name, 1, &sinfo);
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos, &res);
-	if (!inode)
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	if (IS_ERR(inode)) {
+		res = PTR_ERR(inode);
 		goto out_brelse;
+	}
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	inode->i_version++;
@@ -967,7 +971,6 @@ static int vfat_rename(struct inode *old
 	}
 	new_dir->i_version++;
 
-	/* releases old_bh */
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
 	if (err)
diff -puN include/linux/msdos_fs.h~sync06-fat_dir-cleanup4 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync06-fat_dir-cleanup4	2005-03-06 02:36:32.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:32.000000000 +0900
@@ -394,7 +394,7 @@ extern void fat_attach(struct inode *ino
 extern void fat_detach(struct inode *inode);
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
-			struct msdos_dir_entry *de, loff_t i_pos, int *res);
+			struct msdos_dir_entry *de, loff_t i_pos);
 extern int fat_sync_inode(struct inode *inode);
 extern int fat_fill_super(struct super_block *sb, void *data, int silent,
 			struct inode_operations *fs_dir_inode_ops, int isvfat);
_
