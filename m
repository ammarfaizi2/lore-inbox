Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCETkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCETkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCETdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:33:17 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27909 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261204AbVCETL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:29 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/29] FAT: Add fat_remove_entries()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:49:05 +0900
In-Reply-To: <87is46q68d.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:48:18 +0900")
Message-ID: <87ekeuq672.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changes the fat_slot_info->nr_slot, now it's total counts which
include a shortname entry.  And this adds a fat_remove_entries()
which use the ->nr_slots.

In order not to write out the same block repeatedly,
fat_remove_entries() was rewritten from vfat_remove_entries().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |  103 +++++++++++++++++++++++++++++++++++++++++++----
 fs/vfat/namei.c          |   81 ++++++++++++------------------------
 include/linux/msdos_fs.h |    1 
 3 files changed, 124 insertions(+), 61 deletions(-)

diff -puN fs/fat/dir.c~sync06-fat_dir-cleanup3 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync06-fat_dir-cleanup3	2005-03-06 02:36:28.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:29.000000000 +0900
@@ -144,7 +144,7 @@ int fat_search_long(struct inode *inode,
 	struct nls_table *nls_io = MSDOS_SB(sb)->nls_io;
 	struct nls_table *nls_disk = MSDOS_SB(sb)->nls_disk;
 	wchar_t bufuname[14];
-	unsigned char xlate_len, long_slots;
+	unsigned char xlate_len, nr_slots;
 	wchar_t *unicode = NULL;
 	unsigned char work[8], bufname[260];	/* 256 + 4 */
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
@@ -159,7 +159,7 @@ int fat_search_long(struct inode *inode,
 		if (fat_get_entry(inode, &cpos, &bh, &de, &i_pos) == -1)
 			goto EODir;
 parse_record:
-		long_slots = 0;
+		nr_slots = 0;
 		if (de->name[0] == DELETED_FLAG)
 			continue;
 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
@@ -191,7 +191,7 @@ parse_long:
 			slots = id & ~0x40;
 			if (slots > 20 || !slots)	/* ceil(256 * 2 / 26) */
 				continue;
-			long_slots = slots;
+			nr_slots = slots;
 			alias_checksum = ds->alias_checksum;
 
 			slot = slots;
@@ -228,7 +228,7 @@ parse_long:
 			for (sum = 0, i = 0; i < 11; i++)
 				sum = (((sum&1)<<7)|((sum&0xfe)>>1)) + de->name[i];
 			if (sum != alias_checksum)
-				long_slots = 0;
+				nr_slots = 0;
 		}
 
 		memcpy(work, de->name, sizeof(de->name));
@@ -276,7 +276,7 @@ parse_long:
 								xlate_len)))
 				goto Found;
 
-		if (long_slots) {
+		if (nr_slots) {
 			xlate_len = utf8
 				?utf8_wcstombs(bufname, unicode, sizeof(bufname))
 				:uni16_to_x8(bufname, unicode, uni_xlate, nls_io);
@@ -290,9 +290,10 @@ parse_long:
 	}
 
 Found:
+	nr_slots++;	/* include the de */
 	sinfo->i_pos = i_pos;
-	sinfo->slot_off = cpos - (long_slots + 1) * sizeof(*de);
-	sinfo->nr_slots = long_slots;
+	sinfo->slot_off = cpos - nr_slots * sizeof(*de);
+	sinfo->nr_slots = nr_slots;
 	sinfo->de = de;
 	sinfo->bh = bh;
 	err = 0;
@@ -759,6 +760,94 @@ int fat_scan(struct inode *dir, const un
 
 EXPORT_SYMBOL(fat_scan);
 
+static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
+{
+	struct super_block *sb = dir->i_sb;
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de, *endp;
+	loff_t i_pos;
+	int err = 0, orig_slots;
+
+	while (nr_slots) {
+		bh = NULL;
+		if (fat_get_entry(dir, &pos, &bh, &de, &i_pos) < 0) {
+			err = -EIO;
+			break;
+		}
+
+		orig_slots = nr_slots;
+		endp = (struct msdos_dir_entry *)(bh->b_data + sb->s_blocksize);
+		while (nr_slots && de < endp) {
+			de->name[0] = DELETED_FLAG;
+			de++;
+			nr_slots--;
+		}
+		mark_buffer_dirty(bh);
+		if (IS_DIRSYNC(dir))
+			err = sync_dirty_buffer(bh);
+		brelse(bh);
+		if (err)
+			break;
+
+		/* pos is *next* de's position, so this does `- sizeof(de)' */
+		pos += ((orig_slots - nr_slots) * sizeof(*de)) - sizeof(*de);
+	}
+
+	return err;
+}
+
+int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
+{
+	struct msdos_dir_entry *de;
+	struct buffer_head *bh;
+	int err = 0, nr_slots;
+
+	/*
+	 * First stage: Remove the shortname. By this, the directory
+	 * entry is removed.
+	 */
+	nr_slots = sinfo->nr_slots;
+	de = sinfo->de;
+	sinfo->de = NULL;
+	bh = sinfo->bh;
+	sinfo->bh = NULL;
+	while (nr_slots && de >= (struct msdos_dir_entry *)bh->b_data) {
+		de->name[0] = DELETED_FLAG;
+		de--;
+		nr_slots--;
+	}
+	mark_buffer_dirty(bh);
+	if (IS_DIRSYNC(dir))
+		err = sync_dirty_buffer(bh);
+	brelse(bh);
+	if (err)
+		return err;
+	dir->i_version++;
+
+	if (nr_slots) {
+		/*
+		 * Second stage: remove the remaining longname slots.
+		 * (This directory entry is already removed, and so return
+		 * the success)
+		 */
+		err = __fat_remove_entries(dir, sinfo->slot_off, nr_slots);
+		if (err) {
+			printk(KERN_WARNING
+			       "FAT: Couldn't remove the long name slots\n");
+		}
+	}
+
+	dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(fat_remove_entries);
+
 static struct buffer_head *fat_extend_dir(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
diff -puN fs/vfat/namei.c~sync06-fat_dir-cleanup3 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync06-fat_dir-cleanup3	2005-03-06 02:36:28.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:29.000000000 +0900
@@ -721,7 +721,7 @@ static int vfat_add_entry(struct inode *
 
 	/* slots can't be less than 1 */
 	sinfo->slot_off = offset - sizeof(struct msdos_dir_slot) * slots;
-	sinfo->nr_slots = slots - 1;
+	sinfo->nr_slots = slots;
 	sinfo->de = de;
 	sinfo->bh = bh;
 
@@ -817,39 +817,6 @@ out:
 	return res;
 }
 
-static void vfat_remove_entry(struct inode *dir, struct fat_slot_info *sinfo)
-{
-	struct super_block *sb = dir->i_sb;
-	struct msdos_dir_entry *de = sinfo->de;
-	struct buffer_head *bh = sinfo->bh;
-	loff_t offset, i_pos;
-	int i;
-
-	dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
-	dir->i_version++;
-	mark_inode_dirty(dir);
-
-	/* remove the shortname */
-	de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(bh);
-	if (sb->s_flags & MS_SYNCHRONOUS)
-		sync_dirty_buffer(bh);
-
-	/* remove the longname */
-	offset = sinfo->slot_off;
-	de = NULL;
-	for (i = sinfo->nr_slots; i > 0; --i) {
-		if (fat_get_entry(dir, &offset, &bh, &de, &i_pos) < 0)
-			continue;
-		de->name[0] = DELETED_FLAG;
-		de->attr = ATTR_NONE;
-		mark_buffer_dirty(bh);
-		if (sb->s_flags & MS_SYNCHRONOUS)
-			sync_dirty_buffer(bh);
-	}
-	brelse(bh);
-}
-
 static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -865,14 +832,15 @@ static int vfat_rmdir(struct inode *dir,
 	if (err)
 		goto out;
 
+	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
+	if (err)
+		goto out;
+	dir->i_nlink--;
+
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh and syncs it if necessary */
-	vfat_remove_entry(dir, &sinfo);
-
-	dir->i_nlink--;
 out:
 	unlock_kernel();
 
@@ -891,12 +859,13 @@ static int vfat_unlink(struct inode *dir
 	if (err)
 		goto out;
 
+	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
+	if (err)
+		goto out;
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh and syncs it if necessary */
-	vfat_remove_entry(dir, &sinfo);
 out:
 	unlock_kernel();
 
@@ -939,8 +908,7 @@ mkdir_failed:
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh ands syncs if necessary */
-	vfat_remove_entry(dir, &sinfo);
+	fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	iput(inode);
 	dir->i_nlink--;
 	goto out;
@@ -956,49 +924,56 @@ static int vfat_rename(struct inode *old
 	int err, is_dir;
 	struct fat_slot_info old_sinfo, sinfo;
 
-	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
+	old_sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	lock_kernel();
 	err = vfat_find(old_dir, &old_dentry->d_name, &old_sinfo);
 	if (err)
-		goto rename_done;
+		goto out;
 
 	is_dir = S_ISDIR(old_inode->i_mode);
 	if (is_dir) {
 		if (fat_scan(old_inode, MSDOS_DOTDOT, &dotdot_bh,
 			     &dotdot_de, &dotdot_i_pos) < 0) {
 			err = -EIO;
-			goto rename_done;
+			goto out;
 		}
 	}
 
 	if (new_dentry->d_inode) {
 		err = vfat_find(new_dir, &new_dentry->d_name, &sinfo);
-		if (err || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
+		if (err)
+			goto out;
+		brelse(sinfo.bh);
+		if (MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
 			printk(KERN_WARNING "vfat_rename: fs corrupted\n");
-			goto rename_done;
+			goto out;
 		}
 
 		if (is_dir) {
 			err = fat_dir_empty(new_inode);
 			if (err)
-				goto rename_done;
+				goto out;
 		}
 		fat_detach(new_inode);
 	} else {
 		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir,
 				     &sinfo);
 		if (err)
-			goto rename_done;
+			goto out;
+		brelse(sinfo.bh);
 	}
-
 	new_dir->i_version++;
 
 	/* releases old_bh */
-	vfat_remove_entry(old_dir, &old_sinfo);
+	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
+	if (err)
+		goto out;
+	if (is_dir)
+		old_dir->i_nlink--;
 	fat_detach(old_inode);
 	fat_attach(old_inode, sinfo.i_pos);
 	mark_inode_dirty(old_inode);
@@ -1019,7 +994,6 @@ static int vfat_rename(struct inode *old
 		if (new_dir->i_sb->s_flags & MS_SYNCHRONOUS)
 			sync_dirty_buffer(dotdot_bh);
 
-		old_dir->i_nlink--;
 		if (new_inode) {
 			new_inode->i_nlink--;
 		} else {
@@ -1027,10 +1001,9 @@ static int vfat_rename(struct inode *old
 			mark_inode_dirty(new_dir);
 		}
 	}
-rename_done:
+out:
 	brelse(dotdot_bh);
 	brelse(old_sinfo.bh);
-	brelse(sinfo.bh);
 	unlock_kernel();
 
 	return err;
diff -puN include/linux/msdos_fs.h~sync06-fat_dir-cleanup3 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync06-fat_dir-cleanup3	2005-03-06 02:36:28.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:29.000000000 +0900
@@ -333,6 +333,7 @@ extern int fat_subdirs(struct inode *dir
 extern int fat_scan(struct inode *dir, const unsigned char *name,
 		    struct buffer_head **res_bh,
 		    struct msdos_dir_entry **res_de, loff_t *i_pos);
+extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
 
 /* fat/fatent.c */
 struct fat_entry {
_
