Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCETkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCETkD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVCEThj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:37:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:26373 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261202AbVCETL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:27 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/29] FAT: Use a same timestamp on some operations path
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
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:52:03 +0900
In-Reply-To: <87wtsmorii.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:51:33 +0900")
Message-ID: <87sm3aorho.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |   63 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 28 deletions(-)

diff -puN fs/vfat/namei.c~sync07-fat_dir2 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync07-fat_dir2	2005-03-06 02:36:44.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:44.000000000 +0900
@@ -658,11 +658,11 @@ out_free:
 }
 
 static int vfat_add_entry(struct inode *dir, struct qstr *qname, int is_dir,
+			  struct timespec *ts,
 			  struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_dir_slot *slots;
-	struct timespec ts;
 	unsigned int len;
 	int err, i, nr_slots;
 	loff_t offset;
@@ -678,8 +678,7 @@ static int vfat_add_entry(struct inode *
 	if (slots == NULL)
 		return -ENOMEM;
 
-	ts = CURRENT_TIME_SEC;
-	err = vfat_build_slots(dir, qname->name, len, is_dir, 0, &ts,
+	err = vfat_build_slots(dir, qname->name, len, is_dir, 0, ts,
 			       slots, &nr_slots);
 	if (err)
 		goto cleanup;
@@ -707,7 +706,7 @@ static int vfat_add_entry(struct inode *
 	}
 
 	/* update timestamp */
-	dir->i_ctime = dir->i_mtime = dir->i_atime = ts;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = *ts;
 	mark_inode_dirty(dir);
 
 	/* slots can't be less than 1 */
@@ -780,33 +779,33 @@ static int vfat_create(struct inode *dir
 		       struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct fat_slot_info sinfo;
-	int res;
+	struct timespec ts;
+	int err;
 
 	lock_kernel();
-	res = vfat_add_entry(dir, &dentry->d_name, 0, &sinfo);
-	if (res < 0)
+
+	ts = CURRENT_TIME_SEC;
+	err = vfat_add_entry(dir, &dentry->d_name, 0, &ts, &sinfo);
+	if (err)
 		goto out;
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
-		res = PTR_ERR(inode);
+		err = PTR_ERR(inode);
 		goto out;
 	}
-	res = 0;
 	inode->i_version++;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	mark_inode_dirty(inode);
-	if (IS_SYNC(inode))
-		fat_sync_inode(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	dir->i_version++;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry, inode);
 out:
 	unlock_kernel();
-	return res;
+	return err;
 }
 
 static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
@@ -869,37 +868,42 @@ static int vfat_mkdir(struct inode *dir,
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
 	struct fat_slot_info sinfo;
-	int res;
+	struct timespec ts;
+	int err;
 
 	lock_kernel();
-	res = vfat_add_entry(dir, &dentry->d_name, 1, &sinfo);
-	if (res < 0)
+
+	ts = CURRENT_TIME_SEC;
+	err = vfat_add_entry(dir, &dentry->d_name, 1, &ts, &sinfo);
+	if (err)
 		goto out;
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	if (IS_ERR(inode)) {
-		res = PTR_ERR(inode);
+		err = PTR_ERR(inode);
 		goto out_brelse;
 	}
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	mark_inode_dirty(inode);
 	inode->i_version++;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
+
 	dir->i_version++;
 	dir->i_nlink++;
 	inode->i_nlink = 2;	/* no need to mark them dirty */
-	res = fat_new_dir(inode, dir, 1);
-	if (res < 0)
+	err = fat_new_dir(inode, dir, 1);
+	if (err)
 		goto mkdir_failed;
+
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry, inode);
 out_brelse:
 	brelse(sinfo.bh);
 out:
 	unlock_kernel();
-	return res;
+	return err;
 
 mkdir_failed:
 	inode->i_nlink = 0;
-	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
+	inode->i_mtime = inode->i_atime = ts;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	fat_remove_entries(dir, &sinfo);	/* and releases bh */
@@ -917,6 +921,7 @@ static int vfat_rename(struct inode *old
 	struct inode *old_inode, *new_inode;
 	int err, is_dir;
 	struct fat_slot_info old_sinfo, sinfo;
+	struct timespec ts;
 
 	old_sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
@@ -935,6 +940,7 @@ static int vfat_rename(struct inode *old
 		}
 	}
 
+	ts = CURRENT_TIME_SEC;
 	if (new_dentry->d_inode) {
 		err = vfat_find(new_dir, &new_dentry->d_name, &sinfo);
 		if (err)
@@ -953,7 +959,7 @@ static int vfat_rename(struct inode *old
 		}
 		fat_detach(new_inode);
 	} else {
-		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir,
+		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir, &ts,
 				     &sinfo);
 		if (err)
 			goto out;
@@ -972,11 +978,12 @@ static int vfat_rename(struct inode *old
 	mark_inode_dirty(old_inode);
 
 	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
+	old_dir->i_ctime = old_dir->i_mtime = ts;
 	mark_inode_dirty(old_dir);
+
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME_SEC;
+		new_inode->i_ctime = ts;
 	}
 
 	if (is_dir) {
_
