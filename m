Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVCEUJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVCEUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVCEUFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:05:41 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:19717 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261183AbVCETLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:22 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] FAT: msdos_add_entry() cleanup
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
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:53:09 +0900
In-Reply-To: <87oedyorgu.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:52:33 +0900")
Message-ID: <87k6olq60a.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The msdos_add_entry() use similar interface to vfat_add_entry().
And use a same timestamp on some operations path.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |  162 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 84 insertions(+), 78 deletions(-)

diff -puN fs/msdos/namei.c~sync07-fat_dir4 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync07-fat_dir4	2005-03-06 02:36:50.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:50.000000000 +0900
@@ -253,31 +253,38 @@ out:
 
 /***** Creates a directory entry (name is already formatted). */
 static int msdos_add_entry(struct inode *dir, const unsigned char *name,
-			   struct buffer_head **bh,
-			   struct msdos_dir_entry **de,
-			   loff_t *i_pos, int is_dir, int is_hid)
+			   int is_dir, int is_hid, struct timespec *ts,
+			   struct fat_slot_info *sinfo)
 {
-	int res;
+	struct msdos_dir_entry de;
+	__le16 time, date;
+	int offset;
 
-	res = fat_add_entries(dir, 1, bh, de, i_pos);
-	if (res < 0)
-		return res;
+	memcpy(de.name, name, MSDOS_NAME);
+	de.attr = is_dir ? ATTR_DIR : ATTR_ARCH;
+	if (is_hid)
+		de.attr |= ATTR_HIDDEN;
+	de.lcase = 0;
+	fat_date_unix2dos(ts->tv_sec, &time, &date);
+	de.time = de.ctime = time;
+	de.date = de.cdate = de.adate = date;
+	de.ctime_cs = 0;
+	de.start = 0;
+	de.starthi = 0;
+	de.size = 0;
+
+	offset = fat_add_entries(dir, 1, &sinfo->bh, &sinfo->de, &sinfo->i_pos);
+	if (offset < 0)
+		return offset;
+	sinfo->slot_off = offset;
+	sinfo->nr_slots = 1;
 
-	/*
-	 * XXX all times should be set by caller upon successful completion.
-	 */
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
+	memcpy(sinfo->de, &de, sizeof(de));
+	mark_buffer_dirty(sinfo->bh);
+
+	dir->i_ctime = dir->i_mtime = *ts;
 	mark_inode_dirty(dir);
 
-	memcpy((*de)->name, name, MSDOS_NAME);
-	(*de)->attr = is_dir ? ATTR_DIR : ATTR_ARCH;
-	if (is_hid)
-		(*de)->attr |= ATTR_HIDDEN;
-	(*de)->start = 0;
-	(*de)->starthi = 0;
-	fat_date_unix2dos(dir->i_mtime.tv_sec, &(*de)->time, &(*de)->date);
-	(*de)->size = 0;
-	mark_buffer_dirty(*bh);
 	return 0;
 }
 
@@ -286,45 +293,43 @@ static int msdos_create(struct inode *di
 			struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
-	struct fat_slot_info sinfo;
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
 	struct inode *inode;
-	loff_t i_pos;
-	int res, is_hid;
+	struct fat_slot_info sinfo;
+	struct timespec ts;
 	unsigned char msdos_name[MSDOS_NAME];
+	int err, is_hid;
 
 	lock_kernel();
-	res = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
+
+	err = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
 				msdos_name, &MSDOS_SB(sb)->options);
-	if (res < 0) {
-		unlock_kernel();
-		return res;
-	}
+	if (err)
+		goto out;
 	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
 	/* Have to do it due to foo vs. .foo conflicts */
 	if (!fat_scan(dir, msdos_name, &sinfo)) {
 		brelse(sinfo.bh);
-		unlock_kernel();
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
-	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 0, is_hid);
-	if (res) {
-		unlock_kernel();
-		return res;
-	}
-	inode = fat_build_inode(sb, de, i_pos);
-	brelse(bh);
+	ts = CURRENT_TIME_SEC;
+	err = msdos_add_entry(dir, msdos_name, 0, is_hid, &ts, &sinfo);
+	if (err)
+		goto out;
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
-		unlock_kernel();
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	mark_inode_dirty(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
+
 	d_instantiate(dentry, inode);
+out:
 	unlock_kernel();
-	return 0;
+	return err;
 }
 
 /***** Remove a directory */
@@ -367,65 +372,63 @@ static int msdos_mkdir(struct inode *dir
 {
 	struct super_block *sb = dir->i_sb;
 	struct fat_slot_info sinfo;
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
 	struct inode *inode;
-	int res, is_hid;
 	unsigned char msdos_name[MSDOS_NAME];
-	loff_t i_pos;
+	struct timespec ts;
+	int err, is_hid;
 
 	lock_kernel();
-	res = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
+
+	err = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
 				msdos_name, &MSDOS_SB(sb)->options);
-	if (res < 0) {
-		unlock_kernel();
-		return res;
-	}
+	if (err)
+		goto out;
 	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
 	/* foo vs .foo situation */
 	if (!fat_scan(dir, msdos_name, &sinfo)) {
 		brelse(sinfo.bh);
-		res = -EINVAL;
-		goto out_unlock;
+		err = -EINVAL;
+		goto out;
 	}
 
-	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 1, is_hid);
-	if (res)
-		goto out_unlock;
-	inode = fat_build_inode(dir->i_sb, de, i_pos);
+	ts = CURRENT_TIME_SEC;
+	err = msdos_add_entry(dir, msdos_name, 1, is_hid, &ts, &sinfo);
+	if (err)
+		goto out;
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	if (IS_ERR(inode)) {
-		brelse(bh);
-		res = PTR_ERR(inode);
-		goto out_unlock;
+		brelse(sinfo.bh);
+		err = PTR_ERR(inode);
+		goto out;
 	}
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	dir->i_nlink++;
 	inode->i_nlink = 2;	/* no need to mark them dirty */
 
-	res = fat_new_dir(inode, dir, 0);
-	if (res)
+	err = fat_new_dir(inode, dir, 0);
+	if (err)
 		goto mkdir_error;
-	brelse(bh);
+	brelse(sinfo.bh);
 
 	d_instantiate(dentry, inode);
-	res = 0;
-
-out_unlock:
+out:
 	unlock_kernel();
-	return res;
+	return err;
 
 mkdir_error:
 	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = ts;
 	dir->i_nlink--;
 	mark_inode_dirty(inode);
 	mark_inode_dirty(dir);
-	de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(bh);
-	brelse(bh);
+	sinfo.de->name[0] = DELETED_FLAG;
+	mark_buffer_dirty(sinfo.bh);
+	brelse(sinfo.bh);
 	fat_detach(inode);
 	iput(inode);
-	goto out_unlock;
+	goto out;
 }
 
 /***** Unlink a file */
@@ -465,6 +468,7 @@ static int do_msdos_rename(struct inode 
 	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
+	struct timespec ts;
 	int err, is_dir;
 
 	old_sinfo.bh = dotdot_bh = NULL;
@@ -507,6 +511,8 @@ static int do_msdos_rename(struct inode 
 			goto out;
 		}
 	}
+
+	ts = CURRENT_TIME_SEC;
 	if (new_inode) {
 		if (err)
 			goto out;
@@ -523,8 +529,8 @@ static int do_msdos_rename(struct inode 
 		}
 		fat_detach(new_inode);
 	} else {
-		err = msdos_add_entry(new_dir, new_name, &sinfo.bh, &sinfo.de,
-				      &sinfo.i_pos, is_dir, is_hid);
+		err = msdos_add_entry(new_dir, new_name, is_dir, is_hid,
+				      &ts, &sinfo);
 		if (err)
 			goto out;
 		brelse(sinfo.bh);
@@ -546,12 +552,12 @@ static int do_msdos_rename(struct inode 
 	mark_inode_dirty(old_inode);
 
 	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
+	old_dir->i_ctime = old_dir->i_mtime = ts;
 	mark_inode_dirty(old_dir);
 
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME_SEC;
+		new_inode->i_ctime = ts;
 		mark_inode_dirty(new_inode);
 	}
 	if (is_dir) {
_
