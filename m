Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVCEUlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVCEUlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCET7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:59:24 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:20741 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261188AbVCETLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:23 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/29] FAT: Use "struct fat_slot_info" for fat_scan()
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
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:50:16 +0900
In-Reply-To: <87acpiq665.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:49:38 +0900")
Message-ID: <876506q653.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use "struct fat_slot_info" for fat_scan().  But ".." entry can not provide
valid informations for inode, so add the fat_get_dotdot_entry() as
special case.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |   41 +++++++++++++++++-----
 fs/fat/inode.c           |    2 -
 fs/msdos/namei.c         |   84 ++++++++++++++++++++++++++---------------------
 fs/vfat/namei.c          |   16 +++-----
 include/linux/msdos_fs.h |    5 +-
 5 files changed, 88 insertions(+), 60 deletions(-)

diff -puN fs/fat/dir.c~sync06-fat_dir-cleanup5 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync06-fat_dir-cleanup5	2005-03-06 02:36:35.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:35.000000000 +0900
@@ -510,9 +510,9 @@ ParseLong:
 	j = last_u;
 
 	lpos = cpos - (long_slots+1)*sizeof(struct msdos_dir_entry);
-	if (!memcmp(de->name,MSDOS_DOT,11))
+	if (!memcmp(de->name, MSDOS_DOT, MSDOS_NAME))
 		inum = inode->i_ino;
-	else if (!memcmp(de->name,MSDOS_DOTDOT,11)) {
+	else if (!memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
 		inum = parent_ino(filp->f_dentry);
 	} else {
 		struct inode *tmp = fat_iget(sb, i_pos);
@@ -695,6 +695,26 @@ static int fat_get_short_entry(struct in
 	return -ENOENT;
 }
 
+/*
+ * The ".." entry can not provide the "struct fat_slot_info" informations
+ * for inode. So, this function provide the some informations only.
+ */
+int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
+			 struct msdos_dir_entry **de, loff_t *i_pos)
+{
+	loff_t offset;
+
+	offset = 0;
+	*bh = NULL;
+	while (fat_get_short_entry(dir, &offset, bh, de, i_pos) >= 0) {
+		if (!strncmp((*de)->name, MSDOS_DOTDOT, MSDOS_NAME))
+			return 0;
+	}
+	return -ENOENT;
+}
+
+EXPORT_SYMBOL(fat_get_dotdot_entry);
+
 /* See if directory is empty */
 int fat_dir_empty(struct inode *dir)
 {
@@ -744,16 +764,17 @@ int fat_subdirs(struct inode *dir)
  * Returns an error code or zero.
  */
 int fat_scan(struct inode *dir, const unsigned char *name,
-	     struct buffer_head **bh, struct msdos_dir_entry **de,
-	     loff_t *i_pos)
+	     struct fat_slot_info *sinfo)
 {
-	loff_t cpos;
-
-	*bh = NULL;
-	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, bh, de, i_pos) >= 0) {
-		if (!strncmp((*de)->name, name, MSDOS_NAME))
+	sinfo->slot_off = 0;
+	sinfo->bh = NULL;
+	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
+				   &sinfo->de, &sinfo->i_pos) >= 0) {
+		if (!strncmp(sinfo->de->name, name, MSDOS_NAME)) {
+			sinfo->slot_off -= sizeof(*sinfo->de);
+			sinfo->nr_slots = 1;
 			return 0;
+		}
 	}
 	return -ENOENT;
 }
diff -puN fs/fat/inode.c~sync06-fat_dir-cleanup5 fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~sync06-fat_dir-cleanup5	2005-03-06 02:36:35.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:36:35.000000000 +0900
@@ -654,7 +654,7 @@ static struct dentry *fat_get_parent(str
 
 	lock_kernel();
 
-	err = fat_scan(child->d_inode, MSDOS_DOTDOT, &bh, &de, &i_pos);
+	err = fat_get_dotdot_entry(child->d_inode, &bh, &de, &i_pos);
 	if (err) {
 		parent = ERR_PTR(err);
 		goto out;
diff -puN fs/msdos/namei.c~sync06-fat_dir-cleanup5 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync06-fat_dir-cleanup5	2005-03-06 02:36:35.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:35.000000000 +0900
@@ -140,26 +140,33 @@ static int msdos_find(struct inode *dir,
 		      struct buffer_head **bh, struct msdos_dir_entry **de,
 		      loff_t *i_pos)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	struct fat_slot_info sinfo;
 	unsigned char msdos_name[MSDOS_NAME];
-	char dotsOK;
-	int res;
+	int err;
 
-	dotsOK = MSDOS_SB(dir->i_sb)->options.dotsOK;
-	res = msdos_format_name(name, len, msdos_name,
-				&MSDOS_SB(dir->i_sb)->options);
-	if (res < 0)
+	err = msdos_format_name(name, len, msdos_name, &sbi->options);
+	if (err)
 		return -ENOENT;
-	res = fat_scan(dir, msdos_name, bh, de, i_pos);
-	if (!res && dotsOK) {
+
+	err = fat_scan(dir, msdos_name, &sinfo);
+	if (!err && sbi->options.dotsOK) {
 		if (name[0] == '.') {
-			if (!((*de)->attr & ATTR_HIDDEN))
-				res = -ENOENT;
+			if (!(sinfo.de->attr & ATTR_HIDDEN))
+				err = -ENOENT;
 		} else {
-			if ((*de)->attr & ATTR_HIDDEN)
-				res = -ENOENT;
+			if (sinfo.de->attr & ATTR_HIDDEN)
+				err = -ENOENT;
 		}
+		if (err)
+			brelse(sinfo.bh);
 	}
-	return res;
+	if (!err) {
+		*i_pos = sinfo.i_pos;
+		*de = sinfo.de;
+		*bh = sinfo.bh;
+	}
+	return err;
 }
 
 /*
@@ -289,6 +296,7 @@ static int msdos_create(struct inode *di
 			struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
+	struct fat_slot_info sinfo;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	struct inode *inode;
@@ -305,18 +313,18 @@ static int msdos_create(struct inode *di
 	}
 	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
 	/* Have to do it due to foo vs. .foo conflicts */
-	if (fat_scan(dir, msdos_name, &bh, &de, &i_pos) >= 0) {
-		brelse(bh);
+	if (!fat_scan(dir, msdos_name, &sinfo)) {
+		brelse(sinfo.bh);
 		unlock_kernel();
 		return -EINVAL;
 	}
-	inode = NULL;
+
 	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 0, is_hid);
 	if (res) {
 		unlock_kernel();
 		return res;
 	}
-	inode = fat_build_inode(dir->i_sb, de, i_pos);
+	inode = fat_build_inode(sb, de, i_pos);
 	brelse(bh);
 	if (IS_ERR(inode)) {
 		unlock_kernel();
@@ -372,6 +380,7 @@ rmdir_done:
 static int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct super_block *sb = dir->i_sb;
+	struct fat_slot_info sinfo;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	struct inode *inode;
@@ -388,8 +397,11 @@ static int msdos_mkdir(struct inode *dir
 	}
 	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
 	/* foo vs .foo situation */
-	if (fat_scan(dir, msdos_name, &bh, &de, &i_pos) >= 0)
-		goto out_exist;
+	if (!fat_scan(dir, msdos_name, &sinfo)) {
+		brelse(sinfo.bh);
+		res = -EINVAL;
+		goto out_unlock;
+	}
 
 	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 1, is_hid);
 	if (res)
@@ -400,7 +412,6 @@ static int msdos_mkdir(struct inode *dir
 		res = PTR_ERR(inode);
 		goto out_unlock;
 	}
-	res = 0;
 
 	dir->i_nlink++;
 	inode->i_nlink = 2;	/* no need to mark them dirty */
@@ -408,7 +419,6 @@ static int msdos_mkdir(struct inode *dir
 	res = fat_new_dir(inode, dir, 0);
 	if (res)
 		goto mkdir_error;
-
 	brelse(bh);
 	d_instantiate(dentry, inode);
 	res = 0;
@@ -429,11 +439,6 @@ mkdir_error:
 	fat_detach(inode);
 	iput(inode);
 	goto out_unlock;
-
-out_exist:
-	brelse(bh);
-	res = -EINVAL;
-	goto out_unlock;
 }
 
 /***** Unlink a file */
@@ -474,6 +479,7 @@ static int do_msdos_rename(struct inode 
 			   struct msdos_dir_entry *old_de, loff_t old_i_pos,
 			   int is_hid)
 {
+	struct fat_slot_info sinfo;
 	struct buffer_head *new_bh = NULL, *dotdot_bh = NULL;
 	struct msdos_dir_entry *new_de, *dotdot_de;
 	struct inode *old_inode, *new_inode;
@@ -485,17 +491,22 @@ static int do_msdos_rename(struct inode 
 	new_inode = new_dentry->d_inode;
 	is_dir = S_ISDIR(old_inode->i_mode);
 
-	if (fat_scan(new_dir, new_name, &new_bh, &new_de, &new_i_pos) >= 0 &&
-	    !new_inode)
-		goto degenerate_case;
+	error = fat_scan(new_dir, new_name, &sinfo);
+	if (!error) {
+		new_i_pos = sinfo.i_pos;
+		new_bh = sinfo.bh;
+		new_de = sinfo.de;
+		if (!new_inode)
+			goto degenerate_case;
+	}
 	if (is_dir) {
 		if (new_inode) {
 			error = fat_dir_empty(new_inode);
 			if (error)
 				goto out;
 		}
-		if (fat_scan(old_inode, MSDOS_DOTDOT, &dotdot_bh,
-			     &dotdot_de, &dotdot_i_pos) < 0) {
+		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de,
+					 &dotdot_i_pos) < 0) {
 			error = -EIO;
 			goto out;
 		}
@@ -554,6 +565,7 @@ degenerate_case:
 	error = -EINVAL;
 	if (new_de != old_de)
 		goto out;
+	brelse(new_bh);
 	if (is_hid)
 		MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
 	else
@@ -569,9 +581,7 @@ degenerate_case:
 static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct buffer_head *old_bh;
-	struct msdos_dir_entry *old_de;
-	loff_t old_i_pos;
+	struct fat_slot_info sinfo;
 	int error, is_hid, old_hid; /* if new file and old file are hidden */
 	unsigned char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
 
@@ -592,14 +602,14 @@ static int msdos_rename(struct inode *ol
 	old_hid =
 	     (old_dentry->d_name.name[0] == '.') && (old_msdos_name[0] != '.');
 
-	error = fat_scan(old_dir, old_msdos_name, &old_bh, &old_de, &old_i_pos);
+	error = fat_scan(old_dir, old_msdos_name, &sinfo);
 	if (error < 0)
 		goto rename_done;
 
 	error = do_msdos_rename(old_dir, old_msdos_name, old_dentry,
 				new_dir, new_msdos_name, new_dentry,
-				old_bh, old_de, old_i_pos, is_hid);
-	brelse(old_bh);
+				sinfo.bh, sinfo.de, sinfo.i_pos, is_hid);
+	brelse(sinfo.bh);
 
 rename_done:
 	unlock_kernel();
diff -puN fs/vfat/namei.c~sync06-fat_dir-cleanup5 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync06-fat_dir-cleanup5	2005-03-06 02:36:35.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:35.000000000 +0900
@@ -208,15 +208,11 @@ static int vfat_valid_longname(const uns
 
 static int vfat_find_form(struct inode *dir, unsigned char *name)
 {
-	struct msdos_dir_entry *de;
-	struct buffer_head *bh = NULL;
-	loff_t i_pos;
-	int res;
-
-	res = fat_scan(dir, name, &bh, &de, &i_pos);
-	brelse(bh);
-	if (res < 0)
+	struct fat_slot_info sinfo;
+	int err = fat_scan(dir, name, &sinfo);
+	if (err)
 		return -ENOENT;
+	brelse(sinfo.bh);
 	return 0;
 }
 
@@ -938,8 +934,8 @@ static int vfat_rename(struct inode *old
 
 	is_dir = S_ISDIR(old_inode->i_mode);
 	if (is_dir) {
-		if (fat_scan(old_inode, MSDOS_DOTDOT, &dotdot_bh,
-			     &dotdot_de, &dotdot_i_pos) < 0) {
+		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de,
+					 &dotdot_i_pos) < 0) {
 			err = -EIO;
 			goto out;
 		}
diff -puN include/linux/msdos_fs.h~sync06-fat_dir-cleanup5 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync06-fat_dir-cleanup5	2005-03-06 02:36:35.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:35.000000000 +0900
@@ -331,8 +331,9 @@ extern int fat_new_dir(struct inode *dir
 extern int fat_dir_empty(struct inode *dir);
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const unsigned char *name,
-		    struct buffer_head **res_bh,
-		    struct msdos_dir_entry **res_de, loff_t *i_pos);
+		    struct fat_slot_info *sinfo);
+extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
+				struct msdos_dir_entry **de, loff_t *i_pos);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
 
 /* fat/fatent.c */
_
