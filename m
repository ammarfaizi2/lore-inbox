Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288696AbSATPWp>; Sun, 20 Jan 2002 10:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSATPWg>; Sun, 20 Jan 2002 10:22:36 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:54276 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S288696AbSATPWT>; Sun, 20 Jan 2002 10:22:19 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the infinite loop of FAT for regular file
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 21 Jan 2002 00:21:49 +0900
Message-ID: <87bsfpgi9e.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fix the infinite loop of FAT for regular file. By this
patch, I think it covered all of the infinite loop points.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.3-pre2/fs/fat/dir.c fat_loop/fs/fat/dir.c
--- linux-2.5.3-pre2/fs/fat/dir.c	Sun Jan 20 20:55:42 2002
+++ fat_loop/fs/fat/dir.c	Sun Jan 20 21:01:05 2002
@@ -744,8 +744,8 @@
 	if ((dir->i_ino == MSDOS_ROOT_INO) && (MSDOS_SB(sb)->fat_bits != 32)) 
 		return -ENOSPC;
 	new_bh = fat_extend_dir(dir);
-	if (!new_bh)
-		return -ENOSPC;
+	if (IS_ERR(new_bh))
+		return PTR_ERR(new_bh);
 	fat_brelse(sb, new_bh);
 	do {
 		fat_get_entry(dir, &curr, bh, de, ino);
@@ -761,7 +761,10 @@
 	struct msdos_dir_entry *de;
 	__u16 date, time;
 
-	if ((bh = fat_extend_dir(dir)) == NULL) return -ENOSPC;
+	bh = fat_extend_dir(dir);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
 	/* zeroed out, so... */
 	fat_date_unix2dos(dir->i_mtime,&time,&date);
 	de = (struct msdos_dir_entry*)&bh->b_data[0];
diff -urN linux-2.5.3-pre2/fs/fat/file.c fat_loop/fs/fat/file.c
--- linux-2.5.3-pre2/fs/fat/file.c	Fri Dec 28 01:17:43 2001
+++ fat_loop/fs/fat/file.c	Sun Jan 20 21:01:05 2002
@@ -65,8 +65,11 @@
 		return -EIO;
 	}
 	if (!(iblock % MSDOS_SB(inode->i_sb)->cluster_size)) {
-		if (fat_add_cluster(inode) < 0)
-			return -ENOSPC;
+		int error;
+
+		error = fat_add_cluster(inode);
+		if (error < 0)
+			return error;
 	}
 	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
 	phys = fat_bmap(inode, iblock);
diff -urN linux-2.5.3-pre2/fs/fat/misc.c fat_loop/fs/fat/misc.c
--- linux-2.5.3-pre2/fs/fat/misc.c	Sun Jan 20 20:55:42 2002
+++ fat_loop/fs/fat/misc.c	Sun Jan 20 21:01:05 2002
@@ -131,14 +131,13 @@
 {
 	struct super_block *sb = inode->i_sb;
 	int count, nr, limit, last, curr, file_cluster;
-	int cluster_size = MSDOS_SB(sb)->cluster_size;
-	int res = -ENOSPC;
+	int cluster_bits = MSDOS_SB(sb)->cluster_bits;
 	
 	lock_fat(sb);
 	
 	if (MSDOS_SB(sb)->free_clusters == 0) {
 		unlock_fat(sb);
-		return res;
+		return -ENOSPC;
 	}
 	limit = MSDOS_SB(sb)->clusters;
 	nr = limit; /* to keep GCC happy */
@@ -150,7 +149,7 @@
 	if (count >= limit) {
 		MSDOS_SB(sb)->free_clusters = 0;
 		unlock_fat(sb);
-		return res;
+		return -ENOSPC;
 	}
 	
 	MSDOS_SB(sb)->prev_free = (count + MSDOS_SB(sb)->prev_free + 1) % limit;
@@ -174,13 +173,20 @@
 	*/
 	last = file_cluster = 0;
 	if ((curr = MSDOS_I(inode)->i_start) != 0) {
+		int max_cluster = MSDOS_I(inode)->mmu_private >> cluster_bits;
+
 		fat_cache_lookup(inode, INT_MAX, &last, &curr);
 		file_cluster = last;
-		while (curr && curr != -1){
+		while (curr && curr != -1) {
 			file_cluster++;
-			if (!(curr = fat_access(sb, last = curr,-1))) {
+			if (!(curr = fat_access(sb, last = curr, -1))) {
 				fat_fs_panic(sb, "File without EOF");
-				return res;
+				return -EIO;
+			}
+			if (file_cluster > max_cluster) {
+				fat_fs_panic(sb,"inode %lu: bad cluster counts",
+					     inode->i_ino);
+				return -EIO;
 			}
 		}
 	}
@@ -192,14 +198,12 @@
 		MSDOS_I(inode)->i_logstart = nr;
 		mark_inode_dirty(inode);
 	}
-	if (file_cluster
-	    != inode->i_blocks / cluster_size / (sb->s_blocksize / 512)) {
+	if (file_cluster != (inode->i_blocks >> (cluster_bits - 9))) {
 		printk ("file_cluster badly computed!!! %d <> %ld\n",
-			file_cluster,
-			inode->i_blocks / cluster_size / (sb->s_blocksize / 512));
+			file_cluster, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
-	inode->i_blocks += (1 << MSDOS_SB(sb)->cluster_bits) / 512;
+	inode->i_blocks += (1 << cluster_bits) >> 9;
 
 	return nr;
 }
@@ -213,24 +217,23 @@
 
 	if (MSDOS_SB(sb)->fat_bits != 32) {
 		if (inode->i_ino == MSDOS_ROOT_INO)
-			return res;
+			return ERR_PTR(-ENOSPC);
 	}
 
 	nr = fat_add_cluster(inode);
 	if (nr < 0)
-		return res;
+		return ERR_PTR(nr);
 	
 	sector = MSDOS_SB(sb)->data_start + (nr - 2) * cluster_size;
 	last_sector = sector + cluster_size;
-	if (MSDOS_SB(sb)->cvf_format && MSDOS_SB(sb)->cvf_format->zero_out_cluster)
+	if (MSDOS_SB(sb)->cvf_format
+	    && MSDOS_SB(sb)->cvf_format->zero_out_cluster) {
+		res = ERR_PTR(-EIO);
 		MSDOS_SB(sb)->cvf_format->zero_out_cluster(inode, nr);
-	else {
+	} else {
 		for ( ; sector < last_sector; sector++) {
-#ifdef DEBUG
-			printk("zeroing sector %d\n", sector);
-#endif
 			if (!(bh = fat_getblk(sb, sector)))
-				printk("getblk failed\n");
+				printk("FAT: fat_getblk() failed\n");
 			else {
 				memset(bh->b_data, 0, sb->s_blocksize);
 				fat_set_uptodate(sb, bh, 1);
@@ -241,6 +244,8 @@
 					fat_brelse(sb, bh);
 			}
 		}
+		if (res == NULL)
+			res = ERR_PTR(-EIO);
 	}
 	if (inode->i_size & (sb->s_blocksize - 1)) {
 		fat_fs_panic(sb, "Odd directory size");
@@ -484,12 +489,11 @@
     **res_de)
 {
 	int count, cluster;
-	unsigned long dir_size;
+	unsigned long dir_size = 0;
 
 #ifdef DEBUG
 	printk("raw_scan_nonroot: start=%d\n",start);
 #endif
-	dir_size = 0;
 	do {
 		for (count = 0; count < MSDOS_SB(sb)->cluster_size; count++) {
 			if ((cluster = raw_scan_sector(sb,(start-2)*
