Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVCEUul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVCEUul (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVCETtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:49:20 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:22789 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261193AbVCETLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 18/29] FAT: Allocate the cluster before adding the directory
 entry
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
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:53:48 +0900
In-Reply-To: <87k6olq60a.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:53:09 +0900")
Message-ID: <87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With this change, ->mkdir() uses the correct updating order.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |  155 +++++++++++++++++++++++++++++++++--------------
 fs/fat/fatent.c          |    3 
 fs/msdos/namei.c         |   54 +++++++---------
 fs/vfat/namei.c          |   59 ++++++++---------
 include/linux/msdos_fs.h |    2 
 5 files changed, 169 insertions(+), 104 deletions(-)

diff -puN fs/fat/dir.c~sync07-fat_dir5 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync07-fat_dir5	2005-03-06 02:36:53.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:53.000000000 +0900
@@ -869,6 +869,118 @@ int fat_remove_entries(struct inode *dir
 
 EXPORT_SYMBOL(fat_remove_entries);
 
+static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
+			      struct buffer_head **bhs, int nr_bhs)
+{
+	struct super_block *sb = dir->i_sb;
+	sector_t last_blknr = blknr + MSDOS_SB(sb)->sec_per_clus;
+	int err, i, n;
+
+	/* Zeroing the unused blocks on this cluster */
+	blknr += nr_used;
+	n = nr_used;
+	while (blknr < last_blknr) {
+		bhs[n] = sb_getblk(sb, blknr);
+		if (!bhs[n]) {
+			err = -ENOMEM;
+			goto error;
+		}
+		memset(bhs[n]->b_data, 0, sb->s_blocksize);
+		set_buffer_uptodate(bhs[n]);
+		mark_buffer_dirty(bhs[n]);
+
+		n++;
+		blknr++;
+		if (n == nr_bhs) {
+			if (IS_DIRSYNC(dir)) {
+				err = fat_sync_bhs(bhs, n);
+				if (err)
+					goto error;
+			}
+			for (i = 0; i < n; i++)
+				brelse(bhs[i]);
+			n = 0;
+		}
+	}
+	if (IS_DIRSYNC(dir)) {
+		err = fat_sync_bhs(bhs, n);
+		if (err)
+			goto error;
+	}
+	for (i = 0; i < n; i++)
+		brelse(bhs[i]);
+
+	return 0;
+
+error:
+	for (i = 0; i < n; i++)
+		bforget(bhs[i]);
+	return err;
+}
+
+int fat_alloc_new_dir(struct inode *dir, struct timespec *ts)
+{
+	struct super_block *sb = dir->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	struct msdos_dir_entry *de;
+	sector_t blknr;
+	__le16 date, time;
+	int err, cluster;
+
+	err = fat_alloc_clusters(dir, &cluster, 1);
+	if (err)
+		goto error;
+
+	blknr = fat_clus_to_blknr(sbi, cluster);
+	bhs[0] = sb_getblk(sb, blknr);
+	if (!bhs[0]) {
+		err = -ENOMEM;
+		goto error_free;
+	}
+
+	fat_date_unix2dos(ts->tv_sec, &time, &date);
+
+	de = (struct msdos_dir_entry *)bhs[0]->b_data;
+	/* filling the new directory slots ("." and ".." entries) */
+	memcpy(de[0].name, MSDOS_DOT, MSDOS_NAME);
+	memcpy(de[1].name, MSDOS_DOTDOT, MSDOS_NAME);
+	de->attr = de[1].attr = ATTR_DIR;
+	de[0].lcase = de[1].lcase = 0;
+	de[0].time = de[1].time = time;
+	de[0].date = de[1].date = date;
+	de[0].ctime_cs = de[1].ctime_cs = 0;
+	if (sbi->options.isvfat) {
+		/* extra timestamps */
+		de[0].ctime = de[1].ctime = time;
+		de[0].adate = de[0].cdate = de[1].adate = de[1].cdate = date;
+	} else {
+		de[0].ctime = de[1].ctime = 0;
+		de[0].adate = de[0].cdate = de[1].adate = de[1].cdate = 0;
+	}
+	de[0].start = cpu_to_le16(cluster);
+	de[0].starthi = cpu_to_le16(cluster >> 16);
+	de[1].start = cpu_to_le16(MSDOS_I(dir)->i_logstart);
+	de[1].starthi = cpu_to_le16(MSDOS_I(dir)->i_logstart >> 16);
+	de[0].size = de[1].size = 0;
+	memset(de + 2, 0, sb->s_blocksize - 2 * sizeof(*de));
+	set_buffer_uptodate(bhs[0]);
+	mark_buffer_dirty(bhs[0]);
+
+	err = fat_zeroed_cluster(dir, blknr, 1, bhs, MAX_BUF_PER_PAGE);
+	if (err)
+		goto error_free;
+
+	return cluster;
+
+error_free:
+	fat_free_clusters(dir, cluster);
+error:
+	return err;
+}
+
+EXPORT_SYMBOL(fat_alloc_new_dir);
+
 static struct buffer_head *fat_extend_dir(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
@@ -960,46 +1072,3 @@ int fat_add_entries(struct inode *dir,in
 }
 
 EXPORT_SYMBOL(fat_add_entries);
-
-int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat)
-{
-	struct super_block *sb = dir->i_sb;
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
-	__le16 date, time;
-
-	bh = fat_extend_dir(dir);
-	if (IS_ERR(bh))
-		return PTR_ERR(bh);
-
-	/* zeroed out, so... */
-	fat_date_unix2dos(dir->i_mtime.tv_sec, &time, &date);
-	de = (struct msdos_dir_entry *)bh->b_data;
-	memcpy(de[0].name, MSDOS_DOT, MSDOS_NAME);
-	memcpy(de[1].name, MSDOS_DOTDOT, MSDOS_NAME);
-	de[0].attr = de[1].attr = ATTR_DIR;
-	de[0].time = de[1].time = time;
-	de[0].date = de[1].date = date;
-	if (is_vfat) {
-		/* extra timestamps */
-		de[0].ctime = de[1].ctime = time;
-		de[0].adate = de[0].cdate = de[1].adate = de[1].cdate = date;
-	}
-	de[0].start = cpu_to_le16(MSDOS_I(dir)->i_logstart);
-	de[0].starthi = cpu_to_le16(MSDOS_I(dir)->i_logstart >> 16);
-	de[1].start = cpu_to_le16(MSDOS_I(parent)->i_logstart);
-	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart >> 16);
-	mark_buffer_dirty(bh);
-	if (sb->s_flags & MS_SYNCHRONOUS)
-		sync_dirty_buffer(bh);
-	brelse(bh);
-
-	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
-	mark_inode_dirty(dir);
-	if (IS_SYNC(dir))
-		fat_sync_inode(dir);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(fat_new_dir);
diff -puN fs/fat/fatent.c~sync07-fat_dir5 fs/fat/fatent.c
--- linux-2.6.11/fs/fat/fatent.c~sync07-fat_dir5	2005-03-06 02:36:53.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/fatent.c	2005-03-06 02:36:53.000000000 +0900
@@ -3,6 +3,7 @@
  * Released under GPL v2.
  */
 
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 
@@ -577,6 +578,8 @@ error:
 	return err;
 }
 
+EXPORT_SYMBOL(fat_free_clusters);
+
 int fat_count_free_clusters(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
diff -puN fs/msdos/namei.c~sync07-fat_dir5 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync07-fat_dir5	2005-03-06 02:36:53.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:53.000000000 +0900
@@ -253,8 +253,8 @@ out:
 
 /***** Creates a directory entry (name is already formatted). */
 static int msdos_add_entry(struct inode *dir, const unsigned char *name,
-			   int is_dir, int is_hid, struct timespec *ts,
-			   struct fat_slot_info *sinfo)
+			   int is_dir, int is_hid, int cluster,
+			   struct timespec *ts, struct fat_slot_info *sinfo)
 {
 	struct msdos_dir_entry de;
 	__le16 time, date;
@@ -269,8 +269,8 @@ static int msdos_add_entry(struct inode 
 	de.time = de.ctime = time;
 	de.date = de.cdate = de.adate = date;
 	de.ctime_cs = 0;
-	de.start = 0;
-	de.starthi = 0;
+	de.start = cpu_to_le16(cluster);
+	de.starthi = cpu_to_le16(cluster >> 16);
 	de.size = 0;
 
 	offset = fat_add_entries(dir, 1, &sinfo->bh, &sinfo->de, &sinfo->i_pos);
@@ -314,7 +314,7 @@ static int msdos_create(struct inode *di
 	}
 
 	ts = CURRENT_TIME_SEC;
-	err = msdos_add_entry(dir, msdos_name, 0, is_hid, &ts, &sinfo);
+	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &ts, &sinfo);
 	if (err)
 		goto out;
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
@@ -375,7 +375,7 @@ static int msdos_mkdir(struct inode *dir
 	struct inode *inode;
 	unsigned char msdos_name[MSDOS_NAME];
 	struct timespec ts;
-	int err, is_hid;
+	int err, is_hid, cluster;
 
 	lock_kernel();
 
@@ -392,43 +392,37 @@ static int msdos_mkdir(struct inode *dir
 	}
 
 	ts = CURRENT_TIME_SEC;
-	err = msdos_add_entry(dir, msdos_name, 1, is_hid, &ts, &sinfo);
-	if (err)
+	cluster = fat_alloc_new_dir(dir, &ts);
+	if (cluster < 0) {
+		err = cluster;
 		goto out;
+	}
+	err = msdos_add_entry(dir, msdos_name, 1, is_hid, cluster, &ts, &sinfo);
+	if (err)
+		goto out_free;
+	dir->i_nlink++;
+
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
-		brelse(sinfo.bh);
 		err = PTR_ERR(inode);
+		/* the directory was completed, just return a error */
 		goto out;
 	}
+	inode->i_nlink = 2;	/* no need to mark them dirty */
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
-	dir->i_nlink++;
-	inode->i_nlink = 2;	/* no need to mark them dirty */
+	d_instantiate(dentry, inode);
 
-	err = fat_new_dir(inode, dir, 0);
-	if (err)
-		goto mkdir_error;
-	brelse(sinfo.bh);
+	unlock_kernel();
+	return 0;
 
-	d_instantiate(dentry, inode);
+out_free:
+	fat_free_clusters(dir, cluster);
 out:
 	unlock_kernel();
 	return err;
-
-mkdir_error:
-	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = ts;
-	dir->i_nlink--;
-	mark_inode_dirty(inode);
-	mark_inode_dirty(dir);
-	sinfo.de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(sinfo.bh);
-	brelse(sinfo.bh);
-	fat_detach(inode);
-	iput(inode);
-	goto out;
 }
 
 /***** Unlink a file */
@@ -529,7 +523,7 @@ static int do_msdos_rename(struct inode 
 		}
 		fat_detach(new_inode);
 	} else {
-		err = msdos_add_entry(new_dir, new_name, is_dir, is_hid,
+		err = msdos_add_entry(new_dir, new_name, is_dir, is_hid, 0,
 				      &ts, &sinfo);
 		if (err)
 			goto out;
diff -puN fs/vfat/namei.c~sync07-fat_dir5 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync07-fat_dir5	2005-03-06 02:36:53.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:53.000000000 +0900
@@ -658,7 +658,7 @@ out_free:
 }
 
 static int vfat_add_entry(struct inode *dir, struct qstr *qname, int is_dir,
-			  struct timespec *ts,
+			  int cluster, struct timespec *ts,
 			  struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
@@ -678,7 +678,7 @@ static int vfat_add_entry(struct inode *
 	if (slots == NULL)
 		return -ENOMEM;
 
-	err = vfat_build_slots(dir, qname->name, len, is_dir, 0, ts,
+	err = vfat_build_slots(dir, qname->name, len, is_dir, cluster, ts,
 			       slots, &nr_slots);
 	if (err)
 		goto cleanup;
@@ -787,9 +787,11 @@ static int vfat_create(struct inode *dir
 	lock_kernel();
 
 	ts = CURRENT_TIME_SEC;
-	err = vfat_add_entry(dir, &dentry->d_name, 0, &ts, &sinfo);
+	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
 	if (err)
 		goto out;
+	dir->i_version++;
+
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
@@ -800,7 +802,6 @@ static int vfat_create(struct inode *dir
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
-	dir->i_version++;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry, inode);
 out:
@@ -866,50 +867,48 @@ out:
 static int vfat_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct super_block *sb = dir->i_sb;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct fat_slot_info sinfo;
 	struct timespec ts;
-	int err;
+	int err, cluster;
 
 	lock_kernel();
 
 	ts = CURRENT_TIME_SEC;
-	err = vfat_add_entry(dir, &dentry->d_name, 1, &ts, &sinfo);
-	if (err)
+	cluster = fat_alloc_new_dir(dir, &ts);
+	if (cluster < 0) {
+		err = cluster;
 		goto out;
+	}
+	err = vfat_add_entry(dir, &dentry->d_name, 1, cluster, &ts, &sinfo);
+	if (err)
+		goto out_free;
+	dir->i_version++;
+	dir->i_nlink++;
+
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		goto out_brelse;
+		/* the directory was completed, just return a error */
+		goto out;
 	}
 	inode->i_version++;
+	inode->i_nlink = 2;	/* no need to mark them dirty */
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
-	dir->i_version++;
-	dir->i_nlink++;
-	inode->i_nlink = 2;	/* no need to mark them dirty */
-	err = fat_new_dir(inode, dir, 1);
-	if (err)
-		goto mkdir_failed;
-
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry, inode);
-out_brelse:
-	brelse(sinfo.bh);
+
+	unlock_kernel();
+	return 0;
+
+out_free:
+	fat_free_clusters(dir, cluster);
 out:
 	unlock_kernel();
 	return err;
-
-mkdir_failed:
-	inode->i_nlink = 0;
-	inode->i_mtime = inode->i_atime = ts;
-	fat_detach(inode);
-	mark_inode_dirty(inode);
-	fat_remove_entries(dir, &sinfo);	/* and releases bh */
-	iput(inode);
-	dir->i_nlink--;
-	goto out;
 }
 
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -959,8 +958,8 @@ static int vfat_rename(struct inode *old
 		}
 		fat_detach(new_inode);
 	} else {
-		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir, &ts,
-				     &sinfo);
+		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir, 0,
+				     &ts, &sinfo);
 		if (err)
 			goto out;
 		brelse(sinfo.bh);
diff -puN include/linux/msdos_fs.h~sync07-fat_dir5 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync07-fat_dir5	2005-03-06 02:36:53.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:53.000000000 +0900
@@ -327,13 +327,13 @@ extern int fat_search_long(struct inode 
 extern int fat_add_entries(struct inode *dir, int slots,
 			   struct buffer_head **bh,
 			   struct msdos_dir_entry **de, loff_t *i_pos);
-extern int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat);
 extern int fat_dir_empty(struct inode *dir);
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const unsigned char *name,
 		    struct fat_slot_info *sinfo);
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 				struct msdos_dir_entry **de, loff_t *i_pos);
+extern int fat_alloc_new_dir(struct inode *dir, struct timespec *ts);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
 
 /* fat/fatent.c */
_
