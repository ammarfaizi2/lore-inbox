Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313075AbSDYOuC>; Thu, 25 Apr 2002 10:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313078AbSDYOuB>; Thu, 25 Apr 2002 10:50:01 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:60165 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S313075AbSDYOt6>; Thu, 25 Apr 2002 10:49:58 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add validity check the first entry of FAT (2/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 25 Apr 2002 23:49:50 +0900
Message-ID: <87662fomsx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes detection of a FAT filesystem more exact than current
one by checking the first entry of FAT.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_chain_error-2.5.9/fs/fat/cache.c fat_check_FAT-2.5.9/fs/fat/cache.c
--- fat_chain_error-2.5.9/fs/fat/cache.c	Thu Apr 25 01:33:58 2002
+++ fat_check_FAT-2.5.9/fs/fat/cache.c	Thu Apr 25 01:38:44 2002
@@ -34,16 +34,12 @@
 	return MSDOS_SB(inode->i_sb)->cvf_format->cvf_bmap(inode,sector);
 }
 
-int default_fat_access(struct super_block *sb,int nr,int new_value)
+int __fat_access(struct super_block *sb, int nr, int new_value)
 {
 	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;
 	unsigned char *p_first, *p_last;
 	int copy, first, last, next, b;
 
-	if (nr < 2 || MSDOS_SB(sb)->clusters + 2 <= nr) {
-		fat_fs_panic(sb, "invalid access to FAT (entry 0x%08x)", nr);
-		return -EIO;
-	}
 	if (MSDOS_SB(sb)->fat_bits == 32) {
 		first = last = nr*4;
 	} else if (MSDOS_SB(sb)->fat_bits == 16) {
@@ -73,25 +69,17 @@
 		    (sb->s_blocksize - 1)) >> 2]);
 		/* Fscking Microsoft marketing department. Their "32" is 28. */
 		next &= 0x0fffffff;
-		if (next >= BAD_FAT32) next = FAT_ENT_EOF;
-		PRINTK(("fat_bread: 0x%x, nr=0x%x, first=0x%x, next=0x%x\n", b, nr, first, next));
-
 	} else if (MSDOS_SB(sb)->fat_bits == 16) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
 		next = CF_LE_W(((__u16 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 1]);
-		if (next >= BAD_FAT16) next = FAT_ENT_EOF;
 	} else {
 		p_first = &((__u8 *)bh->b_data)[first & (sb->s_blocksize - 1)];
 		p_last = &((__u8 *)bh2->b_data)[(first + 1) & (sb->s_blocksize - 1)];
 		if (nr & 1) next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
 		else next = (*p_first+(*p_last << 8)) & 0xfff;
-		if (next >= BAD_FAT12) next = FAT_ENT_EOF;
 	}
 	if (new_value != -1) {
-		if (next == FAT_ENT_EOF)
-			next = EOF_FAT(sb);
-		
 		if (MSDOS_SB(sb)->fat_bits == 32) {
 			((__u32 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 2]
 				= CT_LE_L(new_value);
@@ -132,6 +120,27 @@
 	fat_brelse(sb, bh);
 	if (bh != bh2)
 		fat_brelse(sb, bh2);
+	return next;
+}
+
+int default_fat_access(struct super_block *sb, int nr, int new_value)
+{
+	int next;
+
+	next = -EIO;
+	if (nr < 2 || MSDOS_SB(sb)->clusters + 2 <= nr) {
+		fat_fs_panic(sb, "invalid access to FAT (entry 0x%08x)", nr);
+		goto out;
+	}
+	if (new_value == FAT_ENT_EOF)
+		new_value = EOF_FAT(sb);
+
+	next = __fat_access(sb, nr, new_value);
+	if (next < 0)
+		goto out;
+	if (next >= BAD_FAT(sb))
+		next = FAT_ENT_EOF;
+out:
 	return next;
 }
 
diff -urN fat_chain_error-2.5.9/fs/fat/inode.c fat_check_FAT-2.5.9/fs/fat/inode.c
--- fat_chain_error-2.5.9/fs/fat/inode.c	Thu Apr 25 01:33:58 2002
+++ fat_check_FAT-2.5.9/fs/fat/inode.c	Thu Apr 25 01:38:44 2002
@@ -591,8 +591,9 @@
 	struct buffer_head *bh;
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi;
-	int logical_sector_size, fat_clusters, debug, cp;
+	int logical_sector_size, fat_clusters, debug, cp, first;
 	unsigned int total_sectors, rootdir_sectors;
+	unsigned char media;
 	long error = -EIO;
 	char buf[50];
 	int i;
@@ -655,6 +656,13 @@
 		brelse(bh);
 		goto out_invalid;
 	}
+	media = b->media;
+	if (!FAT_VALID_MEDIA(media)) {
+		if (!silent)
+			printk("FAT: invalid media value (0x%02x)\n", media);
+		brelse(bh);
+		goto out_invalid;
+	}
 	logical_sector_size =
 		CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
 	if (!logical_sector_size
@@ -776,6 +784,21 @@
 		sbi->clusters = fat_clusters - 2;
 
 	brelse(bh);
+
+	/* validity check of FAT */
+	first = __fat_access(sb, 0, -1);
+	if (first < 0) {
+		error = first;
+		goto out_fail;
+	}
+	if (FAT_FIRST_ENT(sb, media) != first) {
+		if (!silent) {
+			printk("FAT: invalid first entry of FAT "
+			       "(0x%x != 0x%x)\n",
+			       FAT_FIRST_ENT(sb, media), first);
+		}
+		goto out_invalid;
+	}
 
 	if (!strcmp(cvf_format, "none"))
 		i = -1;
diff -urN fat_chain_error-2.5.9/include/linux/msdos_fs.h fat_check_FAT-2.5.9/include/linux/msdos_fs.h
--- fat_chain_error-2.5.9/include/linux/msdos_fs.h	Thu Apr 25 01:33:58 2002
+++ fat_check_FAT-2.5.9/include/linux/msdos_fs.h	Thu Apr 25 01:38:44 2002
@@ -54,6 +54,11 @@
 
 #define MSDOS_FAT12 4084 /* maximum number of clusters in a 12 bit FAT */
 
+/* media of boot sector */
+#define FAT_VALID_MEDIA(x)	((0xF8 <= (x) && (x) <= 0xFF) || (x) == 0xF0)
+#define FAT_FIRST_ENT(s, x)	((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
+	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
+
 /* bad cluster mark */
 #define BAD_FAT12 0xFF7
 #define BAD_FAT16 0xFFF7
@@ -114,7 +119,7 @@
 	__u8	fats;		/* number of FATs */
 	__u8	dir_entries[2];	/* root directory entries */
 	__u8	sectors[2];	/* number of sectors */
-	__u8	media;		/* media code (unused) */
+	__u8	media;		/* media code */
 	__u16	fat_length;	/* sectors/FAT */
 	__u16	secs_track;	/* sectors per track */
 	__u16	heads;		/* number of heads */
@@ -242,6 +247,7 @@
 
 /* fat/cache.c */
 extern int fat_access(struct super_block *sb, int nr, int new_value);
+extern int __fat_access(struct super_block *sb, int nr, int new_value);
 extern int fat_bmap(struct inode *inode, int sector);
 extern void fat_cache_init(void);
 extern void fat_cache_lookup(struct inode *inode, int cluster, int *f_clu,
