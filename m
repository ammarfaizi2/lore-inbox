Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270172AbTGUPnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270173AbTGUPnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:43:07 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:7433 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270172AbTGUPib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:38:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat_access cleanup (4/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:53:28 +0900
Message-ID: <87brvnx4ef.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes dirty raw_scan_*(), and rewrites fat_scan() and
fat_subdirs() by useing fat_get_entry() instead.


 fs/fat/inode.c |    1 
 fs/fat/misc.c  |  247 +++++++++------------------------------------------------
 2 files changed, 40 insertions(+), 208 deletions(-)

diff -puN fs/fat/inode.c~fat_access-cleanup1 fs/fat/inode.c
--- linux-2.6.0-test1/fs/fat/inode.c~fat_access-cleanup1	2003-07-21 02:48:16.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/inode.c	2003-07-21 02:48:16.000000000 +0900
@@ -501,6 +501,7 @@ static int fat_read_root(struct inode *i
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int error;
 
+	MSDOS_I(inode)->file_cluster = MSDOS_I(inode)->disk_cluster = 0;
 	MSDOS_I(inode)->i_pos = 0;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
diff -puN fs/fat/misc.c~fat_access-cleanup1 fs/fat/misc.c
--- linux-2.6.0-test1/fs/fat/misc.c~fat_access-cleanup1	2003-07-21 02:48:16.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/misc.c	2003-07-21 02:48:16.000000000 +0900
@@ -326,230 +326,61 @@ next:
 	return 0;
 }
 
-
-/*
- * Now an ugly part: this set of directory scan routines works on clusters
- * rather than on inodes and sectors. They are necessary to locate the '..'
- * directory "inode". raw_scan_sector operates in four modes:
- *
- * name     number   ino      action
- * -------- -------- -------- -------------------------------------------------
- * non-NULL -        X        Find an entry with that name
- * NULL     non-NULL non-NULL Find an entry whose data starts at *number
- * NULL     non-NULL NULL     Count subdirectories in *number. (*)
- * NULL     NULL     non-NULL Find an empty entry
- *
- * (*) The return code should be ignored. It DOES NOT indicate success or
- *     failure. *number has to be initialized to zero.
- *
- * - = not used, X = a value is returned unless NULL
- *
- * If res_bh is non-NULL, the buffer is not deallocated but returned to the
- * caller on success. res_de is set accordingly.
- *
- * If cont is non-zero, raw_found continues with the entry after the one
- * res_bh/res_de point to.
- */
-
-
-#define RSS_NAME /* search for name */ \
-    done = !strncmp(data[entry].name,name,MSDOS_NAME) && \
-     !(data[entry].attr & ATTR_VOLUME);
-
-#define RSS_START /* search for start cluster */ \
-    done = !IS_FREE(data[entry].name) \
-      && ( \
-           ( \
-             (sbi->fat_bits != 32) ? 0 : (CF_LE_W(data[entry].starthi) << 16) \
-           ) \
-           | CF_LE_W(data[entry].start) \
-         ) == *number;
-
-#define RSS_FREE /* search for free entry */ \
-    { \
-	done = IS_FREE(data[entry].name); \
-    }
-
-#define RSS_COUNT /* count subdirectories */ \
-    { \
-	done = 0; \
-	if (!IS_FREE(data[entry].name) && (data[entry].attr & ATTR_DIR)) \
-	    (*number)++; \
-    }
-
-static int raw_scan_sector(struct super_block *sb, sector_t sector,
-			   const char *name, int *number, loff_t *i_pos,
-			   struct buffer_head **res_bh,
-			   struct msdos_dir_entry **res_de)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *bh;
-	struct msdos_dir_entry *data;
-	int entry,start,done;
-
-	if (!(bh = sb_bread(sb, sector)))
-		return -EIO;
-	data = (struct msdos_dir_entry *) bh->b_data;
-	for (entry = 0; entry < sbi->dir_per_block; entry++) {
-/* RSS_COUNT:  if (data[entry].name == name) done=true else done=false. */
-		if (name) {
-			RSS_NAME
-		} else {
-			if (!i_pos) RSS_COUNT
-			else {
-				if (number) RSS_START
-				else RSS_FREE
-			}
-		}
-		if (done) {
-			if (i_pos) {
-				*i_pos = ((loff_t)sector << sbi->dir_per_block_bits) + entry;
-			}
-			start = CF_LE_W(data[entry].start);
-			if (sbi->fat_bits == 32)
-				start |= (CF_LE_W(data[entry].starthi) << 16);
-
-			if (!res_bh)
-				brelse(bh);
-			else {
-				*res_bh = bh;
-				*res_de = &data[entry];
-			}
-			return start;
-		}
-	}
-	brelse(bh);
-	return -ENOENT;
-}
-
-
-/*
- * raw_scan_root performs raw_scan_sector on the root directory until the
- * requested entry is found or the end of the directory is reached.
- */
-
-static int raw_scan_root(struct super_block *sb, const char *name,
-			 int *number, loff_t *i_pos,
-			 struct buffer_head **res_bh,
-			 struct msdos_dir_entry **res_de)
-{
-	int count,cluster;
-
-	for (count = 0;
-	     count < MSDOS_SB(sb)->dir_entries / MSDOS_SB(sb)->dir_per_block;
-	     count++) {
-		cluster = raw_scan_sector(sb, MSDOS_SB(sb)->dir_start + count,
-					  name, number, i_pos, res_bh, res_de);
-		if (cluster >= 0)
-			return cluster;
-	}
-	return -ENOENT;
-}
-
-
-/*
- * raw_scan_nonroot performs raw_scan_sector on a non-root directory until the
- * requested entry is found or the end of the directory is reached.
- */
-
-static int raw_scan_nonroot(struct super_block *sb, int start, const char *name,
-			    int *number, loff_t *i_pos,
-			    struct buffer_head **res_bh,
-			    struct msdos_dir_entry **res_de)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int count, cluster;
-	unsigned long dir_size = 0;
-	sector_t sector;
-
-#ifdef DEBUG
-	printk("raw_scan_nonroot: start=%d\n",start);
-#endif
-	do {
-		for (count = 0; count < sbi->cluster_size; count++) {
-			sector = ((sector_t)start - 2) * sbi->cluster_size
-				+ count + sbi->data_start;
-			cluster = raw_scan_sector(sb, sector, name, number,
-						  i_pos, res_bh, res_de);
-			if (cluster >= 0)
-				return cluster;
-		}
-		dir_size += 1 << sbi->cluster_bits;
-		if (dir_size > FAT_MAX_DIR_SIZE) {
-			fat_fs_panic(sb, "Directory %d: "
+static int fat_get_short_entry(struct inode *dir, loff_t *pos,
+			       struct buffer_head **bh,
+			       struct msdos_dir_entry **de, loff_t *i_pos)
+{
+	struct super_block *sb = dir->i_sb;
+
+	while (fat_get_entry(dir, pos, bh, de, i_pos) >= 0) {
+		if (*pos >= FAT_MAX_DIR_SIZE) {
+			fat_fs_panic(sb, "Directory %llu: "
 				     "exceeded the maximum size of directory",
-				     start);
-			break;
+				     MSDOS_I(dir)->i_pos);
+			return -EIO;
 		}
-		start = fat_access(sb, start, -1);
-		if (start < 0)
-			return start;
-		else if (start == FAT_ENT_FREE) {
-			fat_fs_panic(sb, "%s: invalid cluster chain",
-				     __FUNCTION__);
-			break;
-		}
-#ifdef DEBUG
-	printk("next start: %d\n",start);
-#endif
-	} while (start != FAT_ENT_EOF);
-
+		/* free entry or long name entry or volume label */
+		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
+			return 0;
+	}
 	return -ENOENT;
 }
 
-
-/*
- * raw_scan performs raw_scan_sector on any sector.
- *
- * NOTE: raw_scan must not be used on a directory that is is the process of
- *       being created.
- */
-
-static int raw_scan(struct super_block *sb, int start, const char *name,
-		    loff_t *i_pos, struct buffer_head **res_bh,
-		    struct msdos_dir_entry **res_de)
-{
-	if (start)
-		return raw_scan_nonroot(sb,start,name,NULL,i_pos,res_bh,res_de);
-	else
-		return raw_scan_root(sb,name,NULL,i_pos,res_bh,res_de);
-}
-
 /*
  * fat_subdirs counts the number of sub-directories of dir. It can be run
  * on directories being created.
  */
 int fat_subdirs(struct inode *dir)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
-	int number;
-
-	number = 0;
-	if ((dir->i_ino == MSDOS_ROOT_INO) && (sbi->fat_bits != 32))
-		raw_scan_root(dir->i_sb, NULL, &number, NULL, NULL, NULL);
-	else {
-		if ((dir->i_ino != MSDOS_ROOT_INO) && !MSDOS_I(dir)->i_start)
-			return 0; /* in mkdir */
-		else {
-			raw_scan_nonroot(dir->i_sb, MSDOS_I(dir)->i_start,
-					 NULL, &number, NULL, NULL, NULL);
-		}
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	loff_t cpos, i_pos;
+	int count = 0;
+
+	bh = NULL;
+	cpos = 0;
+	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
+		if (de->attr & ATTR_DIR)
+			count++;
 	}
-	return number;
+	brelse(bh);
+	return count;
 }
 
-
 /*
- * Scans a directory for a given file (name points to its formatted name) or
- * for an empty directory slot (name is NULL). Returns an error code or zero.
+ * Scans a directory for a given file (name points to its formatted name).
+ * Returns an error code or zero.
  */
-
-int fat_scan(struct inode *dir, const char *name, struct buffer_head **res_bh,
-	     struct msdos_dir_entry **res_de, loff_t *i_pos)
+int fat_scan(struct inode *dir, const char *name, struct buffer_head **bh,
+	     struct msdos_dir_entry **de, loff_t *i_pos)
 {
-	int res;
+	loff_t cpos;
 
-	res = raw_scan(dir->i_sb, MSDOS_I(dir)->i_start, name, i_pos,
-		       res_bh, res_de);
-	return (res < 0) ? res : 0;
+	*bh = NULL;
+	cpos = 0;
+	while (fat_get_short_entry(dir, &cpos, bh, de, i_pos) >= 0) {
+		if (!strncmp((*de)->name, name, MSDOS_NAME))
+			return 0;
+	}
+	return -ENOENT;
 }

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
