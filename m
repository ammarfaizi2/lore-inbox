Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVCET7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVCET7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCET5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:57:47 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:21253 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261189AbVCETLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:23 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] FAT: Update ->rename() path
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
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
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
	<87y8d1orah.fsf_-_@devron.myhome.or.jp>
	<87u0npor9o.fsf_-_@devron.myhome.or.jp>
	<87psydor8t.fsf_-_@devron.myhome.or.jp>
	<87ll91or7y.fsf_-_@devron.myhome.or.jp>
	<87hdjpor76.fsf_-_@devron.myhome.or.jp>
	<87d5udor6b.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:59:34 +0900
In-Reply-To: <87d5udor6b.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:58:52 +0900")
Message-ID: <878y51or55.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a) If old_dir == new_dir, we don't need to update the ".." entry,
   so this doesn't touch it if unneeded.

b) old algorithm is using
         1) add a new entry (doen't point the data cluster yet).
	 2) remove a old entry.
	 3) switch the data cluster to new entry.
	 4) update a ".." entry
   this order lose the data cluster when between 2) and 3).

   Instead of above, this is using
         1) add a new entry (doen't point the data cluster yet).
	 2) switch the data cluster to new entry.
	 3) update a ".." entry if needed.
	 4) remove a old entry.
   this order would not lose the data cluster, but on disk metadata is
   corrupted on some point (later, fsck would recover this corruption
   without losing the data).

c) use synchronous update.

d) Fix the corrupted directory check created by 1 of new algorithm.
   1) Fix fat_bmap(). If directory's ->i_start == 0, fat_bmap() is
      handling it as root directory, this removes that strange behavior.
   2) On mkdir() path if directory's ->i_start == 0, returns -EIO.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c   |    4 -
 fs/fat/dir.c     |    9 +++-
 fs/fat/misc.c    |    2 
 fs/msdos/namei.c |  112 ++++++++++++++++++++++++++++++++++++++++++-------------
 fs/vfat/namei.c  |  101 +++++++++++++++++++++++++++++++++++--------------
 5 files changed, 170 insertions(+), 58 deletions(-)

diff -puN fs/fat/cache.c~sync08-fat_tweak8 fs/fat/cache.c
--- linux-2.6.11/fs/fat/cache.c~sync08-fat_tweak8	2005-03-06 02:37:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/cache.c	2005-03-06 02:37:32.000000000 +0900
@@ -303,9 +303,7 @@ int fat_bmap(struct inode *inode, sector
 	int cluster, offset;
 
 	*phys = 0;
-	if ((sbi->fat_bits != 32) &&
-	    (inode->i_ino == MSDOS_ROOT_INO || (S_ISDIR(inode->i_mode) &&
-	     !MSDOS_I(inode)->i_start))) {
+	if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
 		if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits))
 			*phys = sector + sbi->dir_start;
 		return 0;
diff -puN fs/fat/dir.c~sync08-fat_tweak8 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync08-fat_tweak8	2005-03-06 02:37:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:37:32.000000000 +0900
@@ -1172,8 +1172,15 @@ int fat_add_entries(struct inode *dir, v
 			free_slots = nr_bhs = 0;
 		}
 	}
-	if ((dir->i_ino == MSDOS_ROOT_INO) && (sbi->fat_bits != 32))
+	if (dir->i_ino == MSDOS_ROOT_INO) {
+		if (sbi->fat_bits != 32)
+			goto error;
+	} else if (MSDOS_I(dir)->i_start == 0) {
+		printk(KERN_ERR "FAT: Corrupted directory (i_pos %lld)\n",
+		       MSDOS_I(dir)->i_pos);
+		err = -EIO;
 		goto error;
+	}
 
 found:
 	err = 0;
diff -puN fs/fat/misc.c~sync08-fat_tweak8 fs/fat/misc.c
--- linux-2.6.11/fs/fat/misc.c~sync08-fat_tweak8	2005-03-06 02:37:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/misc.c	2005-03-06 02:37:32.000000000 +0900
@@ -33,6 +33,8 @@ void fat_fs_panic(struct super_block *s,
 	}
 }
 
+EXPORT_SYMBOL(fat_fs_panic);
+
 /* Flushes the number of free clusters on FAT32 */
 /* XXX: Need to write one per FSINFO block.  Currently only writes 1 */
 void fat_clusters_flush(struct super_block *sb)
diff -puN fs/msdos/namei.c~sync08-fat_tweak8 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync08-fat_tweak8	2005-03-06 02:37:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:37:32.000000000 +0900
@@ -456,9 +456,9 @@ static int do_msdos_rename(struct inode 
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec ts;
-	int err, is_dir;
+	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
 
-	old_sinfo.bh = dotdot_bh = NULL;
+	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 
@@ -469,7 +469,8 @@ static int do_msdos_rename(struct inode 
 	}
 
 	is_dir = S_ISDIR(old_inode->i_mode);
-	if (is_dir) {
+	update_dotdot = (is_dir && old_dir != new_dir);
+	if (update_dotdot) {
 		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de,
 					 &dotdot_i_pos) < 0) {
 			err = -EIO;
@@ -477,9 +478,9 @@ static int do_msdos_rename(struct inode 
 		}
 	}
 
+	old_attrs = MSDOS_I(old_inode)->i_attrs;
 	err = fat_scan(new_dir, new_name, &sinfo);
 	if (!err) {
-		brelse(sinfo.bh);
 		if (!new_inode) {
 			/* "foo" -> ".foo" case. just change the ATTR_HIDDEN */
 			if (sinfo.de != old_sinfo.de) {
@@ -490,11 +491,21 @@ static int do_msdos_rename(struct inode 
 				MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
 			else
 				MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
-			mark_inode_dirty(old_inode);
+			if (IS_DIRSYNC(old_dir)) {
+				err = fat_sync_inode(old_inode);
+				if (err) {
+					MSDOS_I(old_inode)->i_attrs = old_attrs;
+					goto out;
+				}
+			} else
+				mark_inode_dirty(old_inode);
 
 			old_dir->i_version++;
 			old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
-			mark_inode_dirty(old_dir);
+			if (IS_DIRSYNC(old_dir))
+				(void)fat_sync_inode(old_dir);
+			else
+				mark_inode_dirty(old_dir);
 			goto out;
 		}
 	}
@@ -520,47 +531,96 @@ static int do_msdos_rename(struct inode 
 				      &ts, &sinfo);
 		if (err)
 			goto out;
-		brelse(sinfo.bh);
 	}
 	new_dir->i_version++;
 
-	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
-	old_sinfo.bh = NULL;
-	if (err)
-		goto out;
-	if (is_dir)
-		old_dir->i_nlink--;
 	fat_detach(old_inode);
 	fat_attach(old_inode, sinfo.i_pos);
 	if (is_hid)
 		MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
 	else
 		MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
-	mark_inode_dirty(old_inode);
-
-	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = ts;
-	mark_inode_dirty(old_dir);
+	if (IS_DIRSYNC(new_dir)) {
+		err = fat_sync_inode(old_inode);
+		if (err)
+			goto error_inode;
+	} else
+		mark_inode_dirty(old_inode);
 
-	if (new_inode) {
-		new_inode->i_nlink--;
-		new_inode->i_ctime = ts;
-	}
-	if (is_dir) {
+	if (update_dotdot) {
 		int start = MSDOS_I(new_dir)->i_logstart;
 		dotdot_de->start = cpu_to_le16(start);
 		dotdot_de->starthi = cpu_to_le16(start >> 16);
 		mark_buffer_dirty(dotdot_bh);
+		if (IS_DIRSYNC(new_dir)) {
+			err = sync_dirty_buffer(dotdot_bh);
+			if (err)
+				goto error_dotdot;
+		}
+		old_dir->i_nlink--;
+		if (!new_inode)
+			new_dir->i_nlink++;
+	}
 
-		if (new_inode)
-			new_inode->i_nlink--;
+	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
+	old_sinfo.bh = NULL;
+	if (err)
+		goto error_dotdot;
+	old_dir->i_version++;
+	old_dir->i_ctime = old_dir->i_mtime = ts;
+	if (IS_DIRSYNC(old_dir))
+		(void)fat_sync_inode(old_dir);
+	else
+		mark_inode_dirty(old_dir);
+
+	if (new_inode) {
+		if (is_dir)
+			new_inode->i_nlink -= 2;
 		else
-			new_dir->i_nlink++;
+			new_inode->i_nlink--;
+		new_inode->i_ctime = ts;
 	}
 out:
+	brelse(sinfo.bh);
 	brelse(dotdot_bh);
 	brelse(old_sinfo.bh);
 	return err;
+
+error_dotdot:
+	/* data cluster is shared, serious corruption */
+	corrupt = 1;
+
+	if (update_dotdot) {
+		int start = MSDOS_I(old_dir)->i_logstart;
+		dotdot_de->start = cpu_to_le16(start);
+		dotdot_de->starthi = cpu_to_le16(start >> 16);
+		mark_buffer_dirty(dotdot_bh);
+		corrupt |= sync_dirty_buffer(dotdot_bh);
+	}
+error_inode:
+	fat_detach(old_inode);
+	fat_attach(old_inode, old_sinfo.i_pos);
+	MSDOS_I(old_inode)->i_attrs = old_attrs;
+	if (new_inode) {
+		fat_attach(new_inode, sinfo.i_pos);
+		if (corrupt)
+			corrupt |= fat_sync_inode(new_inode);
+	} else {
+		/*
+		 * If new entry was not sharing the data cluster, it
+		 * shouldn't be serious corruption.
+		 */
+		int err2 = fat_remove_entries(new_dir, &sinfo);
+		if (corrupt)
+			corrupt |= err2;
+		sinfo.bh = NULL;
+	}
+	if (corrupt < 0) {
+		fat_fs_panic(new_dir->i_sb,
+			     "%s: Filesystem corrupted (i_pos %lld)",
+			     __FUNCTION__, sinfo.i_pos);
+	}
+	goto out;
 }
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
diff -puN fs/vfat/namei.c~sync08-fat_tweak8 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync08-fat_tweak8	2005-03-06 02:37:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:37:32.000000000 +0900
@@ -890,11 +890,11 @@ static int vfat_rename(struct inode *old
 	struct msdos_dir_entry *dotdot_de;
 	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
-	int err, is_dir;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec ts;
+	int err, is_dir, update_dotdot, corrupt = 0;
 
-	old_sinfo.bh = dotdot_bh = NULL;
+	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	lock_kernel();
@@ -903,7 +903,8 @@ static int vfat_rename(struct inode *old
 		goto out;
 
 	is_dir = S_ISDIR(old_inode->i_mode);
-	if (is_dir) {
+	update_dotdot = (is_dir && old_dir != new_dir);
+	if (update_dotdot) {
 		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de,
 					 &dotdot_i_pos) < 0) {
 			err = -EIO;
@@ -912,11 +913,10 @@ static int vfat_rename(struct inode *old
 	}
 
 	ts = CURRENT_TIME_SEC;
-	if (new_dentry->d_inode) {
+	if (new_inode) {
 		err = vfat_find(new_dir, &new_dentry->d_name, &sinfo);
 		if (err)
 			goto out;
-		brelse(sinfo.bh);
 		if (MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
 			printk(KERN_WARNING "vfat_rename: fs corrupted\n");
@@ -934,48 +934,93 @@ static int vfat_rename(struct inode *old
 				     &ts, &sinfo);
 		if (err)
 			goto out;
-		brelse(sinfo.bh);
 	}
 	new_dir->i_version++;
 
-	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
-	old_sinfo.bh = NULL;
-	if (err)
-		goto out;
-	if (is_dir)
-		old_dir->i_nlink--;
 	fat_detach(old_inode);
 	fat_attach(old_inode, sinfo.i_pos);
-	mark_inode_dirty(old_inode);
-
-	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = ts;
-	mark_inode_dirty(old_dir);
-
-	if (new_inode) {
-		new_inode->i_nlink--;
-		new_inode->i_ctime = ts;
-	}
+	if (IS_DIRSYNC(new_dir)) {
+		err = fat_sync_inode(old_inode);
+		if (err)
+			goto error_inode;
+	} else
+		mark_inode_dirty(old_inode);
 
-	if (is_dir) {
+	if (update_dotdot) {
 		int start = MSDOS_I(new_dir)->i_logstart;
 		dotdot_de->start = cpu_to_le16(start);
 		dotdot_de->starthi = cpu_to_le16(start >> 16);
 		mark_buffer_dirty(dotdot_bh);
-		if (new_dir->i_sb->s_flags & MS_SYNCHRONOUS)
-			sync_dirty_buffer(dotdot_bh);
+		if (IS_DIRSYNC(new_dir)) {
+			err = sync_dirty_buffer(dotdot_bh);
+			if (err)
+				goto error_dotdot;
+		}
+		old_dir->i_nlink--;
+		if (!new_inode)
+ 			new_dir->i_nlink++;
+	}
 
-		if (new_inode)
-			new_inode->i_nlink--;
+	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
+	old_sinfo.bh = NULL;
+	if (err)
+		goto error_dotdot;
+	old_dir->i_version++;
+	old_dir->i_ctime = old_dir->i_mtime = ts;
+	if (IS_DIRSYNC(old_dir))
+		(void)fat_sync_inode(old_dir);
+	else
+		mark_inode_dirty(old_dir);
+
+	if (new_inode) {
+		if (is_dir)
+			new_inode->i_nlink -= 2;
 		else
-			new_dir->i_nlink++;
+			new_inode->i_nlink--;
+		new_inode->i_ctime = ts;
 	}
 out:
+	brelse(sinfo.bh);
 	brelse(dotdot_bh);
 	brelse(old_sinfo.bh);
 	unlock_kernel();
 
 	return err;
+
+error_dotdot:
+	/* data cluster is shared, serious corruption */
+	corrupt = 1;
+
+	if (update_dotdot) {
+		int start = MSDOS_I(old_dir)->i_logstart;
+		dotdot_de->start = cpu_to_le16(start);
+		dotdot_de->starthi = cpu_to_le16(start >> 16);
+		mark_buffer_dirty(dotdot_bh);
+		corrupt |= sync_dirty_buffer(dotdot_bh);
+	}
+error_inode:
+	fat_detach(old_inode);
+	fat_attach(old_inode, old_sinfo.i_pos);
+	if (new_inode) {
+		fat_attach(new_inode, sinfo.i_pos);
+		if (corrupt)
+			corrupt |= fat_sync_inode(new_inode);
+	} else {
+		/*
+		 * If new entry was not sharing the data cluster, it
+		 * shouldn't be serious corruption.
+		 */
+		int err2 = fat_remove_entries(new_dir, &sinfo);
+		if (corrupt)
+			corrupt |= err2;
+		sinfo.bh = NULL;
+	}
+	if (corrupt < 0) {
+		fat_fs_panic(new_dir->i_sb,
+			     "%s: Filesystem corrupted (i_pos %lld)",
+			     __FUNCTION__, sinfo.i_pos);
+	}
+	goto out;
 }
 
 static struct inode_operations vfat_dir_inode_operations = {
_
