Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVCEToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVCEToU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVCETmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:42:51 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:24325 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261198AbVCETLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/29] FAT: Use "struct fat_slot_info" for fat_search_long()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:48:18 +0900
In-Reply-To: <87mztiq69f.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:47:40 +0900")
Message-ID: <87is46q68d.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The fat_search_long() provide the "struct fat_slot_info" by this
change.  So, vfat_find() became to be enough simple, and it just
returns 0 or error.

And the error check of vfat_find() is also simplify.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |   26 +++++++------
 fs/vfat/namei.c          |   89 ++++++++++++++++++++---------------------------
 include/linux/msdos_fs.h |    3 -
 3 files changed, 54 insertions(+), 64 deletions(-)

diff -puN fs/fat/dir.c~sync06-fat_dir-cleanup2 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync06-fat_dir-cleanup2	2005-03-06 02:36:25.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:25.000000000 +0900
@@ -136,7 +136,7 @@ fat_shortname2uni(struct nls_table *nls,
  * value is the total amount of slots, including the shortname entry.
  */
 int fat_search_long(struct inode *inode, const unsigned char *name,
-		    int name_len, int anycase, loff_t *spos, loff_t *lpos)
+		    int name_len, struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh = NULL;
@@ -149,12 +149,14 @@ int fat_search_long(struct inode *inode,
 	unsigned char work[8], bufname[260];	/* 256 + 4 */
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
+	int anycase = (MSDOS_SB(sb)->options.name_check != 's');
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
-	int chl, i, j, last_u, res = 0;
+	int chl, i, j, last_u, err;
 	loff_t i_pos, cpos = 0;
 
+	err = -ENOENT;
 	while(1) {
-		if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
+		if (fat_get_entry(inode, &cpos, &bh, &de, &i_pos) == -1)
 			goto EODir;
 parse_record:
 		long_slots = 0;
@@ -288,15 +290,17 @@ parse_long:
 	}
 
 Found:
-	res = long_slots + 1;
-	*spos = cpos - sizeof(struct msdos_dir_entry);
-	*lpos = cpos - res*sizeof(struct msdos_dir_entry);
+	sinfo->i_pos = i_pos;
+	sinfo->slot_off = cpos - (long_slots + 1) * sizeof(*de);
+	sinfo->nr_slots = long_slots;
+	sinfo->de = de;
+	sinfo->bh = bh;
+	err = 0;
 EODir:
-	brelse(bh);
-	if (unicode) {
-		free_page((unsigned long) unicode);
-	}
-	return res;
+	if (unicode)
+		free_page((unsigned long)unicode);
+
+	return err;
 }
 
 EXPORT_SYMBOL(fat_search_long);
diff -puN fs/vfat/namei.c~sync06-fat_dir-cleanup2 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync06-fat_dir-cleanup2	2005-03-06 02:36:25.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:25.000000000 +0900
@@ -733,51 +733,35 @@ cleanup:
 static int vfat_find(struct inode *dir, struct qstr *qname,
 		     struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = dir->i_sb;
-	loff_t offset;
-	unsigned int len;
-	int res;
-
-	len = vfat_striptail_len(qname);
+	unsigned int len = vfat_striptail_len(qname);
 	if (len == 0)
 		return -ENOENT;
-
-	res = fat_search_long(dir, qname->name, len,
-			      (MSDOS_SB(sb)->options.name_check != 's'),
-			      &offset, &sinfo->slot_off);
-	if (res > 0) {
-		sinfo->nr_slots = res - 1;
-		if (fat_get_entry(dir, &offset, &sinfo->bh, &sinfo->de, &sinfo->i_pos) >= 0)
-			return 0;
-		res = -EIO;
-	}
-	return res ? res : -ENOENT;
+	return fat_search_long(dir, qname->name, len, sinfo);
 }
 
 static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
 				  struct nameidata *nd)
 {
-	int res;
+	struct super_block *sb = dir->i_sb;
 	struct fat_slot_info sinfo;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	struct dentry *alias;
-	int table;
+	int err, table;
 
 	lock_kernel();
-	table = (MSDOS_SB(dir->i_sb)->options.name_check == 's') ? 2 : 0;
+	table = (MSDOS_SB(sb)->options.name_check == 's') ? 2 : 0;
 	dentry->d_op = &vfat_dentry_ops[table];
 
-	inode = NULL;
-	res = vfat_find(dir, &dentry->d_name, &sinfo);
-	if (res < 0) {
+	err = vfat_find(dir, &dentry->d_name, &sinfo);
+	if (err) {
 		table++;
 		goto error;
 	}
-	inode = fat_build_inode(dir->i_sb, sinfo.de, sinfo.i_pos, &res);
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos, &err);
 	brelse(sinfo.bh);
-	if (res) {
+	if (err) {
 		unlock_kernel();
-		return ERR_PTR(res);
+		return ERR_PTR(err);
 	}
 	alias = d_find_alias(inode);
 	if (alias) {
@@ -870,40 +854,43 @@ static int vfat_rmdir(struct inode *dir,
 {
 	struct inode *inode = dentry->d_inode;
 	struct fat_slot_info sinfo;
-	int res;
+	int err;
 
 	lock_kernel();
-	res = fat_dir_empty(inode);
-	if (res)
-		goto out;
 
-	res = vfat_find(dir, &dentry->d_name, &sinfo);
-	if (res < 0)
+	err = fat_dir_empty(inode);
+	if (err)
+		goto out;
+	err = vfat_find(dir, &dentry->d_name, &sinfo);
+	if (err)
 		goto out;
 
-	res = 0;
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh and syncs it if necessary */
 	vfat_remove_entry(dir, &sinfo);
+
 	dir->i_nlink--;
 out:
 	unlock_kernel();
-	return res;
+
+	return err;
 }
 
 static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	struct fat_slot_info sinfo;
-	int res;
+	int err;
 
 	lock_kernel();
-	res = vfat_find(dir, &dentry->d_name, &sinfo);
-	if (res < 0)
+
+	err = vfat_find(dir, &dentry->d_name, &sinfo);
+	if (err)
 		goto out;
+
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
@@ -913,7 +900,7 @@ static int vfat_unlink(struct inode *dir
 out:
 	unlock_kernel();
 
-	return res;
+	return err;
 }
 
 static int vfat_mkdir(struct inode *dir, struct dentry *dentry, int mode)
@@ -966,44 +953,44 @@ static int vfat_rename(struct inode *old
 	struct msdos_dir_entry *dotdot_de;
 	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
-	int res, is_dir;
+	int err, is_dir;
 	struct fat_slot_info old_sinfo, sinfo;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	lock_kernel();
-	res = vfat_find(old_dir, &old_dentry->d_name, &old_sinfo);
-	if (res < 0)
+	err = vfat_find(old_dir, &old_dentry->d_name, &old_sinfo);
+	if (err)
 		goto rename_done;
 
 	is_dir = S_ISDIR(old_inode->i_mode);
 	if (is_dir) {
 		if (fat_scan(old_inode, MSDOS_DOTDOT, &dotdot_bh,
 			     &dotdot_de, &dotdot_i_pos) < 0) {
-			res = -EIO;
+			err = -EIO;
 			goto rename_done;
 		}
 	}
 
 	if (new_dentry->d_inode) {
-		res = vfat_find(new_dir, &new_dentry->d_name, &sinfo);
-		if (res < 0 || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
+		err = vfat_find(new_dir, &new_dentry->d_name, &sinfo);
+		if (err || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
 			printk(KERN_WARNING "vfat_rename: fs corrupted\n");
 			goto rename_done;
 		}
 
 		if (is_dir) {
-			res = fat_dir_empty(new_inode);
-			if (res)
+			err = fat_dir_empty(new_inode);
+			if (err)
 				goto rename_done;
 		}
 		fat_detach(new_inode);
 	} else {
-		res = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir,
+		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir,
 				     &sinfo);
-		if (res < 0)
+		if (err)
 			goto rename_done;
 	}
 
@@ -1040,13 +1027,13 @@ static int vfat_rename(struct inode *old
 			mark_inode_dirty(new_dir);
 		}
 	}
-
 rename_done:
 	brelse(dotdot_bh);
 	brelse(old_sinfo.bh);
 	brelse(sinfo.bh);
 	unlock_kernel();
-	return res;
+
+	return err;
 }
 
 static struct inode_operations vfat_dir_inode_operations = {
diff -puN include/linux/msdos_fs.h~sync06-fat_dir-cleanup2 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync06-fat_dir-cleanup2	2005-03-06 02:36:25.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:25.000000000 +0900
@@ -323,8 +323,7 @@ extern int fat_bmap(struct inode *inode,
 /* fat/dir.c */
 extern struct file_operations fat_dir_operations;
 extern int fat_search_long(struct inode *inode, const unsigned char *name,
-			   int name_len, int anycase,
-			   loff_t *spos, loff_t *lpos);
+			   int name_len, struct fat_slot_info *sinfo);
 extern int fat_add_entries(struct inode *dir, int slots,
 			   struct buffer_head **bh,
 			   struct msdos_dir_entry **de, loff_t *i_pos);
_
