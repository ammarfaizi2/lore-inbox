Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313175AbSDYOxB>; Thu, 25 Apr 2002 10:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSDYOxA>; Thu, 25 Apr 2002 10:53:00 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58352 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313175AbSDYOw5>;
	Thu, 25 Apr 2002 10:52:57 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc cleanup of fatfs (3/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 25 Apr 2002 23:50:35 +0900
Message-ID: <87znzrn878.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch misc cleanup.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_check_FAT-2.5.9/fs/fat/cache.c fat_misc_cleanup-2.5.9/fs/fat/cache.c
--- fat_check_FAT-2.5.9/fs/fat/cache.c	Thu Apr 25 01:38:44 2002
+++ fat_misc_cleanup-2.5.9/fs/fat/cache.c	Thu Apr 25 01:42:17 2002
@@ -36,19 +36,20 @@
 
 int __fat_access(struct super_block *sb, int nr, int new_value)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;
 	unsigned char *p_first, *p_last;
 	int copy, first, last, next, b;
 
-	if (MSDOS_SB(sb)->fat_bits == 32) {
+	if (sbi->fat_bits == 32) {
 		first = last = nr*4;
-	} else if (MSDOS_SB(sb)->fat_bits == 16) {
+	} else if (sbi->fat_bits == 16) {
 		first = last = nr*2;
 	} else {
 		first = nr*3/2;
 		last = first+1;
 	}
-	b = MSDOS_SB(sb)->fat_start + (first >> sb->s_blocksize_bits);
+	b = sbi->fat_start + (first >> sb->s_blocksize_bits);
 	if (!(bh = fat_bread(sb, b))) {
 		printk("FAT: bread(block %d) in fat_access failed\n", b);
 		return -EIO;
@@ -63,27 +64,29 @@
 			return -EIO;
 		}
 	}
-	if (MSDOS_SB(sb)->fat_bits == 32) {
+	if (sbi->fat_bits == 32) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
 		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 2]);
 		/* Fscking Microsoft marketing department. Their "32" is 28. */
 		next &= 0x0fffffff;
-	} else if (MSDOS_SB(sb)->fat_bits == 16) {
+	} else if (sbi->fat_bits == 16) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
 		next = CF_LE_W(((__u16 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 1]);
 	} else {
 		p_first = &((__u8 *)bh->b_data)[first & (sb->s_blocksize - 1)];
 		p_last = &((__u8 *)bh2->b_data)[(first + 1) & (sb->s_blocksize - 1)];
-		if (nr & 1) next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
-		else next = (*p_first+(*p_last << 8)) & 0xfff;
+		if (nr & 1)
+			next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
+		else
+			next = (*p_first+(*p_last << 8)) & 0xfff;
 	}
 	if (new_value != -1) {
-		if (MSDOS_SB(sb)->fat_bits == 32) {
+		if (sbi->fat_bits == 32) {
 			((__u32 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 2]
 				= CT_LE_L(new_value);
-		} else if (MSDOS_SB(sb)->fat_bits == 16) {
+		} else if (sbi->fat_bits == 16) {
 			((__u16 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 1]
 				= CT_LE_W(new_value);
 		} else {
@@ -98,9 +101,9 @@
 			fat_mark_buffer_dirty(sb, bh2);
 		}
 		fat_mark_buffer_dirty(sb, bh);
-		for (copy = 1; copy < MSDOS_SB(sb)->fats; copy++) {
-			b = MSDOS_SB(sb)->fat_start + (first >> sb->s_blocksize_bits)
-				+ MSDOS_SB(sb)->fat_length * copy;
+		for (copy = 1; copy < sbi->fats; copy++) {
+			b = sbi->fat_start + (first >> sb->s_blocksize_bits)
+				+ sbi->fat_length * copy;
 			if (!(c_bh = fat_bread(sb, b)))
 				break;
 			if (bh != bh2) {
@@ -223,7 +226,7 @@
 		    && walk->start_cluster == first
 		    && walk->file_cluster == f_clu) {
 			if (walk->disk_cluster != d_clu) {
-				printk("FAT cache corruption inode=%ld\n",
+				printk("FAT: cache corruption inode=%lu\n",
 					inode->i_ino);
 				spin_unlock(&fat_cache_lock);
 				fat_cache_inval_inode(inode);
@@ -385,13 +388,13 @@
 			nr = -EIO;
 			goto error;
 		}
-		if (MSDOS_SB(inode->i_sb)->free_clusters != -1) {
-			MSDOS_SB(inode->i_sb)->free_clusters++;
-			if (MSDOS_SB(inode->i_sb)->fat_bits == 32) {
-				fat_clusters_flush(inode->i_sb);
+		if (MSDOS_SB(sb)->free_clusters != -1) {
+			MSDOS_SB(sb)->free_clusters++;
+			if (MSDOS_SB(sb)->fat_bits == 32) {
+				fat_clusters_flush(sb);
 			}
 		}
-		inode->i_blocks -= (1 << MSDOS_SB(inode->i_sb)->cluster_bits) / 512;
+		inode->i_blocks -= (1 << MSDOS_SB(sb)->cluster_bits) >> 9 ;
 	}
 	nr = 0;
 error:
diff -urN fat_check_FAT-2.5.9/fs/fat/file.c fat_misc_cleanup-2.5.9/fs/fat/file.c
--- fat_check_FAT-2.5.9/fs/fat/file.c	Thu Apr 25 01:33:58 2002
+++ fat_misc_cleanup-2.5.9/fs/fat/file.c	Thu Apr 25 01:42:17 2002
@@ -49,7 +49,7 @@
 	if (phys < 0)
 		return phys;
 	if (phys) {
-		map_bh(bh_result, inode->i_sb, phys);
+		map_bh(bh_result, sb, phys);
 		return 0;
 	}
 	if (!create)
@@ -58,7 +58,7 @@
 		BUG();
 		return -EIO;
 	}
-	if (!(iblock % MSDOS_SB(inode->i_sb)->cluster_size)) {
+	if (!(iblock % MSDOS_SB(sb)->cluster_size)) {
 		int error;
 
 		error = fat_add_cluster(inode);
@@ -72,7 +72,7 @@
 	if (!phys)
 		BUG();
 	bh_result->b_state |= (1UL << BH_New);
-	map_bh(bh_result, inode->i_sb, phys);
+	map_bh(bh_result, sb, phys);
 	return 0;
 }
 
diff -urN fat_check_FAT-2.5.9/fs/fat/inode.c fat_misc_cleanup-2.5.9/fs/fat/inode.c
--- fat_check_FAT-2.5.9/fs/fat/inode.c	Thu Apr 25 01:38:44 2002
+++ fat_misc_cleanup-2.5.9/fs/fat/inode.c	Thu Apr 25 01:42:17 2002
@@ -383,7 +383,7 @@
 			return -EIO;
 		}
 		if (inode->i_size > FAT_MAX_DIR_SIZE) {
-			fat_fs_panic(sb, "Directory %ld: "
+			fat_fs_panic(sb, "Directory %lu: "
 				     "exceeded the maximum size of directory",
 				     inode->i_ino);
 			inode->i_size = FAT_MAX_DIR_SIZE;
@@ -984,7 +984,7 @@
 		    /* includes .., compensating for "self" */
 #ifdef DEBUG
 		if (!inode->i_nlink) {
-			printk("directory %d: i_nlink == 0\n",inode->i_ino);
+			printk("directory %lu: i_nlink == 0\n",inode->i_ino);
 			inode->i_nlink = 1;
 		}
 #endif
