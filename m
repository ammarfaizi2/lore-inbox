Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVCETZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVCETZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVCETZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:25:01 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:33028 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261214AbVCESog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:44:36 -0500
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/29] let fat handle MS_SYNCHRONOUS flag
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:43:56 +0900
In-Reply-To: <878y52rl17.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:43:16 +0900")
Message-ID: <874qfqrl03.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds MS_SYNCHRONOUS flag support.

Signed-off-by: Colin Leroy <colin@colino.net>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c           |    8 ++++++++
 fs/fat/dir.c             |   26 +++++++++++++++++---------
 fs/fat/file.c            |    5 +++++
 fs/fat/inode.c           |   10 ++++++++++
 fs/fat/misc.c            |    2 ++
 fs/vfat/namei.c          |   31 ++++++++++++++++++++++++-------
 include/linux/msdos_fs.h |    1 +
 7 files changed, 67 insertions(+), 16 deletions(-)

diff -puN fs/fat/cache.c~sync03-fat_sync00 fs/fat/cache.c
--- linux-2.6.11/fs/fat/cache.c~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/cache.c	2005-03-06 02:36:08.000000000 +0900
@@ -269,8 +269,12 @@ static int __fat_access(struct super_blo
 				*p_last = (*p_last & 0xf0) | (new_value >> 8);
 			}
 			mark_buffer_dirty(bh2);
+			if (sb->s_flags & MS_SYNCHRONOUS)
+				sync_dirty_buffer(bh2);
 		}
 		mark_buffer_dirty(bh);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(bh);
 		for (copy = 1; copy < sbi->fats; copy++) {
 			b = sbi->fat_start + (first >> sb->s_blocksize_bits)
 				+ sbi->fat_length * copy;
@@ -283,10 +287,14 @@ static int __fat_access(struct super_blo
 				}
 				memcpy(c_bh2->b_data, bh2->b_data, sb->s_blocksize);
 				mark_buffer_dirty(c_bh2);
+				if (sb->s_flags & MS_SYNCHRONOUS)
+					sync_dirty_buffer(c_bh2);
 				brelse(c_bh2);
 			}
 			memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
 			mark_buffer_dirty(c_bh);
+			if (sb->s_flags & MS_SYNCHRONOUS)
+				sync_dirty_buffer(c_bh);
 			brelse(c_bh);
 		}
 	}
diff -puN fs/fat/dir.c~sync03-fat_sync00 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:08.000000000 +0900
@@ -778,6 +778,8 @@ static struct buffer_head *fat_extend_di
 			memset(bh->b_data, 0, sb->s_blocksize);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
+			if (sb->s_flags & MS_SYNCHRONOUS)
+				sync_dirty_buffer(bh);
 			if (!res)
 				res = bh;
 			else
@@ -842,6 +844,7 @@ EXPORT_SYMBOL(fat_add_entries);
 
 int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat)
 {
+	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	__le16 date, time;
@@ -851,26 +854,31 @@ int fat_new_dir(struct inode *dir, struc
 		return PTR_ERR(bh);
 
 	/* zeroed out, so... */
-	fat_date_unix2dos(dir->i_mtime.tv_sec,&time,&date);
-	de = (struct msdos_dir_entry*)&bh->b_data[0];
-	memcpy(de[0].name,MSDOS_DOT,MSDOS_NAME);
-	memcpy(de[1].name,MSDOS_DOTDOT,MSDOS_NAME);
+	fat_date_unix2dos(dir->i_mtime.tv_sec, &time, &date);
+	de = (struct msdos_dir_entry *)bh->b_data;
+	memcpy(de[0].name, MSDOS_DOT, MSDOS_NAME);
+	memcpy(de[1].name, MSDOS_DOTDOT, MSDOS_NAME);
 	de[0].attr = de[1].attr = ATTR_DIR;
 	de[0].time = de[1].time = time;
 	de[0].date = de[1].date = date;
-	if (is_vfat) {	/* extra timestamps */
+	if (is_vfat) {
+		/* extra timestamps */
 		de[0].ctime = de[1].ctime = time;
-		de[0].adate = de[0].cdate =
-			de[1].adate = de[1].cdate = date;
+		de[0].adate = de[0].cdate = de[1].adate = de[1].cdate = date;
 	}
 	de[0].start = cpu_to_le16(MSDOS_I(dir)->i_logstart);
-	de[0].starthi = cpu_to_le16(MSDOS_I(dir)->i_logstart>>16);
+	de[0].starthi = cpu_to_le16(MSDOS_I(dir)->i_logstart >> 16);
 	de[1].start = cpu_to_le16(MSDOS_I(parent)->i_logstart);
-	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart>>16);
+	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart >> 16);
 	mark_buffer_dirty(bh);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
 	brelse(bh);
+
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
+	if (IS_SYNC(dir))
+		fat_sync_inode(dir);
 
 	return 0;
 }
diff -puN fs/fat/file.c~sync03-fat_sync00 fs/fat/file.c
--- linux-2.6.11/fs/fat/file.c~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/file.c	2005-03-06 02:36:08.000000000 +0900
@@ -23,6 +23,9 @@ static ssize_t fat_file_aio_write(struct
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
+//		check the locking rules
+//		if (IS_SYNC(inode))
+//			fat_sync_inode(inode);
 	}
 	return retval;
 }
@@ -288,6 +291,8 @@ void fat_truncate(struct inode *inode)
 	unlock_kernel();
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
+	if (IS_SYNC(inode))
+		fat_sync_inode(inode);
 }
 
 struct inode_operations fat_file_inode_operations = {
diff -puN fs/fat/inode.c~sync03-fat_sync00 fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:36:08.000000000 +0900
@@ -501,11 +501,21 @@ retry:
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
+	if (wait)
+		sync_dirty_buffer(bh);
 	brelse(bh);
 	unlock_kernel();
+
 	return 0;
 }
 
+int fat_sync_inode(struct inode *inode)
+{
+	return fat_write_inode(inode, 1);
+}
+
+EXPORT_SYMBOL(fat_sync_inode);
+
 static int fat_show_options(struct seq_file *m, struct vfsmount *mnt);
 static struct super_operations fat_sops = {
 	.alloc_inode	= fat_alloc_inode,
diff -puN fs/fat/misc.c~sync03-fat_sync00 fs/fat/misc.c
--- linux-2.6.11/fs/fat/misc.c~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/misc.c	2005-03-06 02:36:08.000000000 +0900
@@ -75,6 +75,8 @@ void fat_clusters_flush(struct super_blo
 		if (sbi->prev_free != -1)
 			fsinfo->next_cluster = cpu_to_le32(sbi->prev_free);
 		mark_buffer_dirty(bh);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(bh);
 	}
 	brelse(bh);
 }
diff -puN fs/vfat/namei.c~sync03-fat_sync00 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:08.000000000 +0900
@@ -663,6 +663,7 @@ static int vfat_add_entry(struct inode *
 			  int is_dir, struct vfat_slot_info *sinfo_out,
 			  struct buffer_head **bh, struct msdos_dir_entry **de)
 {
+	struct super_block *sb = dir->i_sb;
 	struct msdos_dir_slot *dir_slots;
 	loff_t offset;
 	int res, slots, slot;
@@ -702,6 +703,8 @@ static int vfat_add_entry(struct inode *
 		}
 		memcpy(*de, dir_slots + slot, sizeof(struct msdos_dir_slot));
 		mark_buffer_dirty(*bh);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(*bh);
 	}
 
 	res = 0;
@@ -713,8 +716,9 @@ static int vfat_add_entry(struct inode *
 	dir->i_mtime.tv_nsec = 0;
 	(*de)->ctime = (*de)->time;
 	(*de)->adate = (*de)->cdate = (*de)->date;
-
 	mark_buffer_dirty(*bh);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(*bh);
 
 	/* slots can't be less than 1 */
 	sinfo_out->long_slots = slots - 1;
@@ -820,9 +824,12 @@ static int vfat_create(struct inode *dir
 	if (!inode)
 		goto out;
 	res = 0;
+	inode->i_version++;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
-	inode->i_version++;
+	if (IS_SYNC(inode))
+		fat_sync_inode(inode);
+
 	dir->i_version++;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry, inode);
@@ -835,15 +842,20 @@ static void vfat_remove_entry(struct ino
 			      struct buffer_head *bh,
 			      struct msdos_dir_entry *de)
 {
+	struct super_block *sb = dir->i_sb;
 	loff_t offset, i_pos;
 	int i;
 
-	/* remove the shortname */
 	dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
 	dir->i_version++;
 	mark_inode_dirty(dir);
+
+	/* remove the shortname */
 	de->name[0] = DELETED_FLAG;
 	mark_buffer_dirty(bh);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+
 	/* remove the longname */
 	offset = sinfo->longname_offset;
 	de = NULL;
@@ -853,6 +865,8 @@ static void vfat_remove_entry(struct ino
 		de->name[0] = DELETED_FLAG;
 		de->attr = ATTR_NONE;
 		mark_buffer_dirty(bh);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(bh);
 	}
 	brelse(bh);
 }
@@ -879,7 +893,7 @@ static int vfat_rmdir(struct inode *dir,
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh */
+	/* releases bh and syncs it if necessary */
 	vfat_remove_entry(dir, &sinfo, bh, de);
 	dir->i_nlink--;
 out:
@@ -903,7 +917,7 @@ static int vfat_unlink(struct inode *dir
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh */
+	/* releases bh and syncs it if necessary */
 	vfat_remove_entry(dir, &sinfo, bh, de);
 out:
 	unlock_kernel();
@@ -949,7 +963,7 @@ mkdir_failed:
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh */
+	/* releases bh ands syncs if necessary */
 	vfat_remove_entry(dir, &sinfo, bh, de);
 	iput(inode);
 	dir->i_nlink--;
@@ -1027,8 +1041,11 @@ static int vfat_rename(struct inode *old
 	if (is_dir) {
 		int start = MSDOS_I(new_dir)->i_logstart;
 		dotdot_de->start = cpu_to_le16(start);
-		dotdot_de->starthi = cpu_to_le16(start>>16);
+		dotdot_de->starthi = cpu_to_le16(start >> 16);
 		mark_buffer_dirty(dotdot_bh);
+		if (new_dir->i_sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(dotdot_bh);
+
 		old_dir->i_nlink--;
 		if (new_inode) {
 			new_inode->i_nlink--;
diff -puN include/linux/msdos_fs.h~sync03-fat_sync00 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync03-fat_sync00	2005-03-06 02:36:08.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:08.000000000 +0900
@@ -349,6 +349,7 @@ extern void fat_detach(struct inode *ino
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
 			struct msdos_dir_entry *de, loff_t i_pos, int *res);
+extern int fat_sync_inode(struct inode *inode);
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
 
_
