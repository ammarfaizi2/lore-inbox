Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVCETzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVCETzC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCETxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:53:52 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:22277 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261182AbVCETLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/29] FAT: Use "struct fat_slot_info" for msdos_find()
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
	<876506q653.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:50:56 +0900
In-Reply-To: <876506q653.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:50:16 +0900")
Message-ID: <871xauq63z.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The msdos_find() provide the "struct fat_slot_info". Then some cleanups.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |   88 ++++++++++++++++++++++---------------------------------
 1 files changed, 36 insertions(+), 52 deletions(-)

diff -puN fs/msdos/namei.c~sync06-fat_dir-cleanup6 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync06-fat_dir-cleanup6	2005-03-06 02:36:39.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:39.000000000 +0900
@@ -137,11 +137,9 @@ static int msdos_format_name(const unsig
 
 /***** Locates a directory entry.  Uses unformatted name. */
 static int msdos_find(struct inode *dir, const unsigned char *name, int len,
-		      struct buffer_head **bh, struct msdos_dir_entry **de,
-		      loff_t *i_pos)
+		      struct fat_slot_info *sinfo)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
-	struct fat_slot_info sinfo;
 	unsigned char msdos_name[MSDOS_NAME];
 	int err;
 
@@ -149,22 +147,17 @@ static int msdos_find(struct inode *dir,
 	if (err)
 		return -ENOENT;
 
-	err = fat_scan(dir, msdos_name, &sinfo);
+	err = fat_scan(dir, msdos_name, sinfo);
 	if (!err && sbi->options.dotsOK) {
 		if (name[0] == '.') {
-			if (!(sinfo.de->attr & ATTR_HIDDEN))
+			if (!(sinfo->de->attr & ATTR_HIDDEN))
 				err = -ENOENT;
 		} else {
-			if (sinfo.de->attr & ATTR_HIDDEN)
+			if (sinfo->de->attr & ATTR_HIDDEN)
 				err = -ENOENT;
 		}
 		if (err)
-			brelse(sinfo.bh);
-	}
-	if (!err) {
-		*i_pos = sinfo.i_pos;
-		*de = sinfo.de;
-		*bh = sinfo.bh;
+			brelse(sinfo->bh);
 	}
 	return err;
 }
@@ -228,22 +221,20 @@ static struct dentry *msdos_lookup(struc
 				   struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
+	struct fat_slot_info sinfo;
 	struct inode *inode = NULL;
-	struct msdos_dir_entry *de;
-	struct buffer_head *bh = NULL;
-	loff_t i_pos;
 	int res;
 
 	dentry->d_op = &msdos_dentry_operations;
 
 	lock_kernel();
-	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &bh,
-			 &de, &i_pos);
+	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &sinfo);
 	if (res == -ENOENT)
 		goto add;
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, de, i_pos);
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
 		res = PTR_ERR(inode);
 		goto out;
@@ -254,7 +245,6 @@ add:
 	if (dentry)
 		dentry->d_op = &msdos_dentry_operations;
 out:
-	brelse(bh);
 	unlock_kernel();
 	if (!res)
 		return dentry;
@@ -341,39 +331,35 @@ static int msdos_create(struct inode *di
 static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	loff_t i_pos;
-	int res;
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
+	struct fat_slot_info sinfo;
+	int err;
 
-	bh = NULL;
 	lock_kernel();
-	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len,
-			 &bh, &de, &i_pos);
-	if (res < 0)
-		goto rmdir_done;
 	/*
 	 * Check whether the directory is not in use, then check
 	 * whether it is empty.
 	 */
-	res = fat_dir_empty(inode);
-	if (res)
-		goto rmdir_done;
+	err = fat_dir_empty(inode);
+	if (err)
+		goto out;
+	err = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &sinfo);
+	if (err)
+		goto out;
 
-	de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(bh);
+	sinfo.de->name[0] = DELETED_FLAG;
+	mark_buffer_dirty(sinfo.bh);
+	brelse(sinfo.bh);
 	fat_detach(inode);
 	inode->i_nlink = 0;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
-	dir->i_nlink--;
 	mark_inode_dirty(inode);
-	mark_inode_dirty(dir);
-	res = 0;
 
-rmdir_done:
-	brelse(bh);
+	dir->i_nlink--;
+	mark_inode_dirty(dir);
+out:
 	unlock_kernel();
-	return res;
+
+	return err;
 }
 
 /***** Make a directory */
@@ -420,6 +406,7 @@ static int msdos_mkdir(struct inode *dir
 	if (res)
 		goto mkdir_error;
 	brelse(bh);
+
 	d_instantiate(dentry, inode);
 	res = 0;
 
@@ -445,30 +432,27 @@ mkdir_error:
 static int msdos_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	loff_t i_pos;
-	int res;
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
+	struct fat_slot_info sinfo;
+	int err;
 
-	bh = NULL;
 	lock_kernel();
-	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len,
-			 &bh, &de, &i_pos);
-	if (res < 0)
+	err = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &sinfo);
+	if (err)
 		goto unlink_done;
 
-	de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(bh);
+	sinfo.de->name[0] = DELETED_FLAG;
+	mark_buffer_dirty(sinfo.bh);
+	brelse(sinfo.bh);
 	fat_detach(inode);
-	brelse(bh);
 	inode->i_nlink = 0;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
+
 	mark_inode_dirty(dir);
-	res = 0;
 unlink_done:
 	unlock_kernel();
-	return res;
+
+	return err;
 }
 
 static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
_
