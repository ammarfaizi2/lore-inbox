Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCEUJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCEUJs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVCEUIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:08:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:19205 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261173AbVCETLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/29] FAT: msdos_rename() cleanup
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
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:52:33 +0900
In-Reply-To: <87sm3aorho.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:52:03 +0900")
Message-ID: <87oedyorgu.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleans up the msdos_rename(). (use the logic similar to vfat_rename().)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |  175 +++++++++++++++++++++++++++----------------------------
 1 files changed, 89 insertions(+), 86 deletions(-)

diff -puN fs/msdos/namei.c~sync07-fat_dir3 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync07-fat_dir3	2005-03-06 02:36:47.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:47.000000000 +0900
@@ -458,146 +458,149 @@ unlink_done:
 static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 			   struct dentry *old_dentry,
 			   struct inode *new_dir, unsigned char *new_name,
-			   struct dentry *new_dentry,
-			   struct buffer_head *old_bh,
-			   struct msdos_dir_entry *old_de, loff_t old_i_pos,
-			   int is_hid)
-{
-	struct fat_slot_info sinfo;
-	struct buffer_head *new_bh = NULL, *dotdot_bh = NULL;
-	struct msdos_dir_entry *new_de, *dotdot_de;
+			   struct dentry *new_dentry, int is_hid)
+{
+	struct buffer_head *dotdot_bh;
+	struct msdos_dir_entry *dotdot_de;
+	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
-	loff_t new_i_pos, dotdot_i_pos;
-	int error;
-	int is_dir;
+	struct fat_slot_info old_sinfo, sinfo;
+	int err, is_dir;
 
+	old_sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
-	is_dir = S_ISDIR(old_inode->i_mode);
 
-	error = fat_scan(new_dir, new_name, &sinfo);
-	if (!error) {
-		new_i_pos = sinfo.i_pos;
-		new_bh = sinfo.bh;
-		new_de = sinfo.de;
-		if (!new_inode)
-			goto degenerate_case;
+	err = fat_scan(old_dir, old_name, &old_sinfo);
+	if (err) {
+		err = -EIO;
+		goto out;
 	}
+
+	is_dir = S_ISDIR(old_inode->i_mode);
 	if (is_dir) {
-		if (new_inode) {
-			error = fat_dir_empty(new_inode);
-			if (error)
-				goto out;
-		}
 		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de,
 					 &dotdot_i_pos) < 0) {
-			error = -EIO;
+			err = -EIO;
 			goto out;
 		}
 	}
-	if (!new_bh) {
-		error = msdos_add_entry(new_dir, new_name, &new_bh, &new_de,
-					&new_i_pos, is_dir, is_hid);
-		if (error)
+
+	err = fat_scan(new_dir, new_name, &sinfo);
+	if (!err) {
+		brelse(sinfo.bh);
+		if (!new_inode) {
+			/* "foo" -> ".foo" case. just change the ATTR_HIDDEN */
+			if (sinfo.de != old_sinfo.de) {
+				err = -EINVAL;
+				goto out;
+			}
+			if (is_hid)
+				MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
+			else
+				MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
+			mark_inode_dirty(old_inode);
+
+			old_dir->i_version++;
+			old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
+			mark_inode_dirty(old_dir);
 			goto out;
+		}
 	}
-	new_dir->i_version++;
-
-	/* There we go */
+	if (new_inode) {
+		if (err)
+			goto out;
+		if (MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
+			/* WTF??? Cry and fail. */
+			printk(KERN_WARNING "msdos_rename: fs corrupted\n");
+			goto out;
+		}
 
-	if (new_inode)
+		if (is_dir) {
+			err = fat_dir_empty(new_inode);
+			if (err)
+				goto out;
+		}
 		fat_detach(new_inode);
-	old_de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(old_bh);
+	} else {
+		err = msdos_add_entry(new_dir, new_name, &sinfo.bh, &sinfo.de,
+				      &sinfo.i_pos, is_dir, is_hid);
+		if (err)
+			goto out;
+		brelse(sinfo.bh);
+	}
+	new_dir->i_version++;
+
+	old_sinfo.de->name[0] = DELETED_FLAG;
+	mark_buffer_dirty(old_sinfo.bh);
+	brelse(old_sinfo.bh);
+	old_sinfo.bh = NULL;
+	if (is_dir)
+		old_dir->i_nlink--;
 	fat_detach(old_inode);
-	fat_attach(old_inode, new_i_pos);
+	fat_attach(old_inode, sinfo.i_pos);
 	if (is_hid)
 		MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
 	else
 		MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
 	mark_inode_dirty(old_inode);
+
 	old_dir->i_version++;
 	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(old_dir);
+
 	if (new_inode) {
 		new_inode->i_nlink--;
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(new_inode);
 	}
-	if (dotdot_bh) {
-		dotdot_de->start = cpu_to_le16(MSDOS_I(new_dir)->i_logstart);
-		dotdot_de->starthi =
-			cpu_to_le16((MSDOS_I(new_dir)->i_logstart) >> 16);
+	if (is_dir) {
+		int start = MSDOS_I(new_dir)->i_logstart;
+		dotdot_de->start = cpu_to_le16(start);
+		dotdot_de->starthi = cpu_to_le16(start >> 16);
 		mark_buffer_dirty(dotdot_bh);
-		old_dir->i_nlink--;
-		mark_inode_dirty(old_dir);
+
 		if (new_inode) {
 			new_inode->i_nlink--;
-			mark_inode_dirty(new_inode);
 		} else {
 			new_dir->i_nlink++;
 			mark_inode_dirty(new_dir);
 		}
 	}
-	error = 0;
 out:
-	brelse(new_bh);
 	brelse(dotdot_bh);
-	return error;
-
-degenerate_case:
-	error = -EINVAL;
-	if (new_de != old_de)
-		goto out;
-	brelse(new_bh);
-	if (is_hid)
-		MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
-	else
-		MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
-	mark_inode_dirty(old_inode);
-	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
-	mark_inode_dirty(old_dir);
-	return 0;
+	brelse(old_sinfo.bh);
+	return err;
 }
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
 static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct fat_slot_info sinfo;
-	int error, is_hid, old_hid; /* if new file and old file are hidden */
 	unsigned char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
+	int err, is_hid;
 
 	lock_kernel();
-	error = msdos_format_name(old_dentry->d_name.name,
-				  old_dentry->d_name.len, old_msdos_name,
-				  &MSDOS_SB(old_dir->i_sb)->options);
-	if (error < 0)
-		goto rename_done;
-	error = msdos_format_name(new_dentry->d_name.name,
-				  new_dentry->d_name.len, new_msdos_name,
-				  &MSDOS_SB(new_dir->i_sb)->options);
-	if (error < 0)
-		goto rename_done;
+
+	err = msdos_format_name(old_dentry->d_name.name,
+				old_dentry->d_name.len, old_msdos_name,
+				&MSDOS_SB(old_dir->i_sb)->options);
+	if (err)
+		goto out;
+	err = msdos_format_name(new_dentry->d_name.name,
+				new_dentry->d_name.len, new_msdos_name,
+				&MSDOS_SB(new_dir->i_sb)->options);
+	if (err)
+		goto out;
 
 	is_hid =
 	     (new_dentry->d_name.name[0] == '.') && (new_msdos_name[0] != '.');
-	old_hid =
-	     (old_dentry->d_name.name[0] == '.') && (old_msdos_name[0] != '.');
 
-	error = fat_scan(old_dir, old_msdos_name, &sinfo);
-	if (error < 0)
-		goto rename_done;
-
-	error = do_msdos_rename(old_dir, old_msdos_name, old_dentry,
-				new_dir, new_msdos_name, new_dentry,
-				sinfo.bh, sinfo.de, sinfo.i_pos, is_hid);
-	brelse(sinfo.bh);
-
-rename_done:
+	err = do_msdos_rename(old_dir, old_msdos_name, old_dentry,
+			      new_dir, new_msdos_name, new_dentry, is_hid);
+out:
 	unlock_kernel();
-	return error;
+	return err;
 }
 
 static struct inode_operations msdos_dir_inode_operations = {
_
