Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVCETMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVCETMN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVCETH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:07:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42244 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261161AbVCESr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:47:59 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/29] FAT: "struct vfat_slot_info" cleanup
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:47:40 +0900
In-Reply-To: <87r7iuq6af.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:47:04 +0900")
Message-ID: <87mztiq69f.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add "struct fat_slot_info" for updating data of the directory entries.

 1) Rename "struct vfat_slot_info" to "struct fat_slot_info"
 2) Add "de" and "bh" to fat_slot_info instead of using argument.
 3) Replace the "vfat_slot_info + de + bh" by new fat_slot_info

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c          |  126 ++++++++++++++++++++---------------------------
 include/linux/msdos_fs.h |    8 +-
 2 files changed, 61 insertions(+), 73 deletions(-)

diff -puN fs/vfat/namei.c~sync06-fat_dir-cleanup fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync06-fat_dir-cleanup	2005-03-06 02:36:22.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:22.000000000 +0900
@@ -660,16 +660,15 @@ out_free:
 }
 
 static int vfat_add_entry(struct inode *dir, struct qstr *qname,
-			  int is_dir, struct vfat_slot_info *sinfo_out,
-			  struct buffer_head **bh, struct msdos_dir_entry **de)
+			  int is_dir, struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_dir_slot *dir_slots;
 	loff_t offset;
 	int res, slots, slot;
 	unsigned int len;
-	struct msdos_dir_entry *dummy_de;
-	struct buffer_head *dummy_bh;
+	struct msdos_dir_entry *de, *dummy_de;
+	struct buffer_head *bh, *dummy_bh;
 	loff_t dummy_i_pos;
 
 	len = vfat_striptail_len(qname);
@@ -695,16 +694,16 @@ static int vfat_add_entry(struct inode *
 	brelse(dummy_bh);
 
 	/* Now create the new entry */
-	*bh = NULL;
+	bh = NULL;
 	for (slot = 0; slot < slots; slot++) {
-		if (fat_get_entry(dir, &offset, bh, de, &sinfo_out->i_pos) < 0) {
+		if (fat_get_entry(dir, &offset, &bh, &de, &sinfo->i_pos) < 0) {
 			res = -EIO;
 			goto cleanup;
 		}
-		memcpy(*de, dir_slots + slot, sizeof(struct msdos_dir_slot));
-		mark_buffer_dirty(*bh);
+		memcpy(de, dir_slots + slot, sizeof(struct msdos_dir_slot));
+		mark_buffer_dirty(bh);
 		if (sb->s_flags & MS_SYNCHRONOUS)
-			sync_dirty_buffer(*bh);
+			sync_dirty_buffer(bh);
 	}
 
 	res = 0;
@@ -712,18 +711,19 @@ static int vfat_add_entry(struct inode *
 	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 
-	fat_date_unix2dos(dir->i_mtime.tv_sec, &(*de)->time, &(*de)->date);
+	fat_date_unix2dos(dir->i_mtime.tv_sec, &de->time, &de->date);
 	dir->i_mtime.tv_nsec = 0;
-	(*de)->ctime = (*de)->time;
-	(*de)->adate = (*de)->cdate = (*de)->date;
-	mark_buffer_dirty(*bh);
+	de->ctime = de->time;
+	de->adate = de->cdate = de->date;
+	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
-		sync_dirty_buffer(*bh);
+		sync_dirty_buffer(bh);
 
 	/* slots can't be less than 1 */
-	sinfo_out->long_slots = slots - 1;
-	sinfo_out->longname_offset =
-		offset - sizeof(struct msdos_dir_slot) * slots;
+	sinfo->slot_off = offset - sizeof(struct msdos_dir_slot) * slots;
+	sinfo->nr_slots = slots - 1;
+	sinfo->de = de;
+	sinfo->bh = bh;
 
 cleanup:
 	kfree(dir_slots);
@@ -731,8 +731,7 @@ cleanup:
 }
 
 static int vfat_find(struct inode *dir, struct qstr *qname,
-		     struct vfat_slot_info *sinfo, struct buffer_head **last_bh,
-		     struct msdos_dir_entry **last_de)
+		     struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset;
@@ -745,10 +744,10 @@ static int vfat_find(struct inode *dir, 
 
 	res = fat_search_long(dir, qname->name, len,
 			      (MSDOS_SB(sb)->options.name_check != 's'),
-			      &offset, &sinfo->longname_offset);
+			      &offset, &sinfo->slot_off);
 	if (res > 0) {
-		sinfo->long_slots = res - 1;
-		if (fat_get_entry(dir, &offset, last_bh, last_de, &sinfo->i_pos) >= 0)
+		sinfo->nr_slots = res - 1;
+		if (fat_get_entry(dir, &offset, &sinfo->bh, &sinfo->de, &sinfo->i_pos) >= 0)
 			return 0;
 		res = -EIO;
 	}
@@ -759,11 +758,9 @@ static struct dentry *vfat_lookup(struct
 				  struct nameidata *nd)
 {
 	int res;
-	struct vfat_slot_info sinfo;
+	struct fat_slot_info sinfo;
 	struct inode *inode;
 	struct dentry *alias;
-	struct buffer_head *bh = NULL;
-	struct msdos_dir_entry *de;
 	int table;
 
 	lock_kernel();
@@ -771,13 +768,13 @@ static struct dentry *vfat_lookup(struct
 	dentry->d_op = &vfat_dentry_ops[table];
 
 	inode = NULL;
-	res = vfat_find(dir, &dentry->d_name, &sinfo, &bh, &de);
+	res = vfat_find(dir, &dentry->d_name, &sinfo);
 	if (res < 0) {
 		table++;
 		goto error;
 	}
-	inode = fat_build_inode(dir->i_sb, de, sinfo.i_pos, &res);
-	brelse(bh);
+	inode = fat_build_inode(dir->i_sb, sinfo.de, sinfo.i_pos, &res);
+	brelse(sinfo.bh);
 	if (res) {
 		unlock_kernel();
 		return ERR_PTR(res);
@@ -810,17 +807,15 @@ static int vfat_create(struct inode *dir
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
-	struct buffer_head *bh = NULL;
-	struct msdos_dir_entry *de;
-	struct vfat_slot_info sinfo;
+	struct fat_slot_info sinfo;
 	int res;
 
 	lock_kernel();
-	res = vfat_add_entry(dir, &dentry->d_name, 0, &sinfo, &bh, &de);
+	res = vfat_add_entry(dir, &dentry->d_name, 0, &sinfo);
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
-	brelse(bh);
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos, &res);
+	brelse(sinfo.bh);
 	if (!inode)
 		goto out;
 	res = 0;
@@ -838,11 +833,11 @@ out:
 	return res;
 }
 
-static void vfat_remove_entry(struct inode *dir, struct vfat_slot_info *sinfo,
-			      struct buffer_head *bh,
-			      struct msdos_dir_entry *de)
+static void vfat_remove_entry(struct inode *dir, struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
+	struct msdos_dir_entry *de = sinfo->de;
+	struct buffer_head *bh = sinfo->bh;
 	loff_t offset, i_pos;
 	int i;
 
@@ -857,9 +852,9 @@ static void vfat_remove_entry(struct ino
 		sync_dirty_buffer(bh);
 
 	/* remove the longname */
-	offset = sinfo->longname_offset;
+	offset = sinfo->slot_off;
 	de = NULL;
-	for (i = sinfo->long_slots; i > 0; --i) {
+	for (i = sinfo->nr_slots; i > 0; --i) {
 		if (fat_get_entry(dir, &offset, &bh, &de, &i_pos) < 0)
 			continue;
 		de->name[0] = DELETED_FLAG;
@@ -874,9 +869,7 @@ static void vfat_remove_entry(struct ino
 static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	struct vfat_slot_info sinfo;
-	struct buffer_head *bh = NULL;
-	struct msdos_dir_entry *de;
+	struct fat_slot_info sinfo;
 	int res;
 
 	lock_kernel();
@@ -884,7 +877,7 @@ static int vfat_rmdir(struct inode *dir,
 	if (res)
 		goto out;
 
-	res = vfat_find(dir, &dentry->d_name, &sinfo, &bh, &de);
+	res = vfat_find(dir, &dentry->d_name, &sinfo);
 	if (res < 0)
 		goto out;
 
@@ -894,7 +887,7 @@ static int vfat_rmdir(struct inode *dir,
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh and syncs it if necessary */
-	vfat_remove_entry(dir, &sinfo, bh, de);
+	vfat_remove_entry(dir, &sinfo);
 	dir->i_nlink--;
 out:
 	unlock_kernel();
@@ -904,13 +897,11 @@ out:
 static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	struct vfat_slot_info sinfo;
-	struct buffer_head *bh = NULL;
-	struct msdos_dir_entry *de;
+	struct fat_slot_info sinfo;
 	int res;
 
 	lock_kernel();
-	res = vfat_find(dir, &dentry->d_name, &sinfo, &bh, &de);
+	res = vfat_find(dir, &dentry->d_name, &sinfo);
 	if (res < 0)
 		goto out;
 	inode->i_nlink = 0;
@@ -918,7 +909,7 @@ static int vfat_unlink(struct inode *dir
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh and syncs it if necessary */
-	vfat_remove_entry(dir, &sinfo, bh, de);
+	vfat_remove_entry(dir, &sinfo);
 out:
 	unlock_kernel();
 
@@ -929,16 +920,14 @@ static int vfat_mkdir(struct inode *dir,
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
-	struct vfat_slot_info sinfo;
-	struct buffer_head *bh = NULL;
-	struct msdos_dir_entry *de;
+	struct fat_slot_info sinfo;
 	int res;
 
 	lock_kernel();
-	res = vfat_add_entry(dir, &dentry->d_name, 1, &sinfo, &bh, &de);
+	res = vfat_add_entry(dir, &dentry->d_name, 1, &sinfo);
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos, &res);
 	if (!inode)
 		goto out_brelse;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
@@ -953,7 +942,7 @@ static int vfat_mkdir(struct inode *dir,
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry, inode);
 out_brelse:
-	brelse(bh);
+	brelse(sinfo.bh);
 out:
 	unlock_kernel();
 	return res;
@@ -964,7 +953,7 @@ mkdir_failed:
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh ands syncs if necessary */
-	vfat_remove_entry(dir, &sinfo, bh, de);
+	vfat_remove_entry(dir, &sinfo);
 	iput(inode);
 	dir->i_nlink--;
 	goto out;
@@ -973,24 +962,22 @@ mkdir_failed:
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct buffer_head *old_bh, *new_bh, *dotdot_bh;
-	struct msdos_dir_entry *old_de, *new_de, *dotdot_de;
+	struct buffer_head *dotdot_bh;
+	struct msdos_dir_entry *dotdot_de;
 	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
 	int res, is_dir;
-	struct vfat_slot_info old_sinfo, sinfo;
+	struct fat_slot_info old_sinfo, sinfo;
 
-	old_bh = new_bh = dotdot_bh = NULL;
+	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	lock_kernel();
-	res = vfat_find(old_dir, &old_dentry->d_name, &old_sinfo, &old_bh,
-			&old_de);
+	res = vfat_find(old_dir, &old_dentry->d_name, &old_sinfo);
 	if (res < 0)
 		goto rename_done;
 
 	is_dir = S_ISDIR(old_inode->i_mode);
-
 	if (is_dir) {
 		if (fat_scan(old_inode, MSDOS_DOTDOT, &dotdot_bh,
 			     &dotdot_de, &dotdot_i_pos) < 0) {
@@ -1000,8 +987,7 @@ static int vfat_rename(struct inode *old
 	}
 
 	if (new_dentry->d_inode) {
-		res = vfat_find(new_dir, &new_dentry->d_name, &sinfo, &new_bh,
-				&new_de);
+		res = vfat_find(new_dir, &new_dentry->d_name, &sinfo);
 		if (res < 0 || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
 			printk(KERN_WARNING "vfat_rename: fs corrupted\n");
@@ -1016,7 +1002,7 @@ static int vfat_rename(struct inode *old
 		fat_detach(new_inode);
 	} else {
 		res = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir,
-				     &sinfo, &new_bh, &new_de);
+				     &sinfo);
 		if (res < 0)
 			goto rename_done;
 	}
@@ -1024,8 +1010,8 @@ static int vfat_rename(struct inode *old
 	new_dir->i_version++;
 
 	/* releases old_bh */
-	vfat_remove_entry(old_dir, &old_sinfo, old_bh, old_de);
-	old_bh = NULL;
+	vfat_remove_entry(old_dir, &old_sinfo);
+	old_sinfo.bh = NULL;
 	fat_detach(old_inode);
 	fat_attach(old_inode, sinfo.i_pos);
 	mark_inode_dirty(old_inode);
@@ -1057,8 +1043,8 @@ static int vfat_rename(struct inode *old
 
 rename_done:
 	brelse(dotdot_bh);
-	brelse(old_bh);
-	brelse(new_bh);
+	brelse(old_sinfo.bh);
+	brelse(sinfo.bh);
 	unlock_kernel();
 	return res;
 }
diff -puN include/linux/msdos_fs.h~sync06-fat_dir-cleanup include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync06-fat_dir-cleanup	2005-03-06 02:36:22.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:22.000000000 +0900
@@ -170,10 +170,12 @@ struct msdos_dir_slot {
 	__u8    name11_12[4];	/* last 2 characters in name */
 };
 
-struct vfat_slot_info {
-	int long_slots;		/* number of long slots in filename */
-	loff_t longname_offset;	/* dir offset for longname start */
+struct fat_slot_info {
 	loff_t i_pos;		/* on-disk position of directory entry */
+	loff_t slot_off;	/* offset for slot or de start */
+	int nr_slots;		/* number of slots + 1(de) in filename */
+	struct msdos_dir_entry *de;
+	struct buffer_head *bh;
 };
 
 #ifdef __KERNEL__
_
