Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317511AbSFICrb>; Sat, 8 Jun 2002 22:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317516AbSFICra>; Sat, 8 Jun 2002 22:47:30 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:55812 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317511AbSFICr1>;
	Sat, 8 Jun 2002 22:47:27 -0400
Date: Sat, 8 Jun 2002 22:47:28 -0400 (EDT)
Message-Id: <200206090247.g592lR3471572@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: hirofumi@mail.parknet.co.jp, chaffee@cs.berkeley.edu
Subject: [patch] fat/msdos/vfat crud removal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This get rid of the old byte order macros.

diff -Naurd old/fs/fat/cache.c new/fs/fat/cache.c
--- old/fs/fat/cache.c	Sun Jun  2 21:44:45 2002
+++ new/fs/fat/cache.c	Sat Jun  8 17:25:48 2002
@@ -67,13 +67,13 @@
 	}
 	if (sbi->fat_bits == 32) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
-		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
+		next = le32_to_cpu(((__u32 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 2]);
 		/* Fscking Microsoft marketing department. Their "32" is 28. */
 		next &= 0x0fffffff;
 	} else if (sbi->fat_bits == 16) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
-		next = CF_LE_W(((__u16 *) bh->b_data)[(first &
+		next = le16_to_cpu(((__u16 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 1]);
 	} else {
 		p_first = &((__u8 *)bh->b_data)[first & (sb->s_blocksize - 1)];
@@ -86,10 +86,10 @@
 	if (new_value != -1) {
 		if (sbi->fat_bits == 32) {
 			((__u32 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 2]
-				= CT_LE_L(new_value);
+				= cpu_to_le32(new_value);
 		} else if (sbi->fat_bits == 16) {
 			((__u16 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 1]
-				= CT_LE_W(new_value);
+				= cpu_to_le16(new_value);
 		} else {
 			if (nr & 1) {
 				*p_first = (*p_first & 0xf) | (new_value << 4);
diff -Naurd old/fs/fat/dir.c new/fs/fat/dir.c
--- old/fs/fat/dir.c	Sun Jun  2 21:44:40 2002
+++ new/fs/fat/dir.c	Sat Jun  8 17:25:48 2002
@@ -768,17 +768,17 @@
 	memcpy(de[0].name,MSDOS_DOT,MSDOS_NAME);
 	memcpy(de[1].name,MSDOS_DOTDOT,MSDOS_NAME);
 	de[0].attr = de[1].attr = ATTR_DIR;
-	de[0].time = de[1].time = CT_LE_W(time);
-	de[0].date = de[1].date = CT_LE_W(date);
+	de[0].time = de[1].time = cpu_to_le16(time);
+	de[0].date = de[1].date = cpu_to_le16(date);
 	if (is_vfat) {	/* extra timestamps */
-		de[0].ctime = de[1].ctime = CT_LE_W(time);
+		de[0].ctime = de[1].ctime = cpu_to_le16(time);
 		de[0].adate = de[0].cdate =
-			de[1].adate = de[1].cdate = CT_LE_W(date);
+			de[1].adate = de[1].cdate = cpu_to_le16(date);
 	}
-	de[0].start = CT_LE_W(MSDOS_I(dir)->i_logstart);
-	de[0].starthi = CT_LE_W(MSDOS_I(dir)->i_logstart>>16);
-	de[1].start = CT_LE_W(MSDOS_I(parent)->i_logstart);
-	de[1].starthi = CT_LE_W(MSDOS_I(parent)->i_logstart>>16);
+	de[0].start = cpu_to_le16(MSDOS_I(dir)->i_logstart);
+	de[0].starthi = cpu_to_le16(MSDOS_I(dir)->i_logstart>>16);
+	de[1].start = cpu_to_le16(MSDOS_I(parent)->i_logstart);
+	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart>>16);
 	fat_mark_buffer_dirty(sb, bh);
 	fat_brelse(sb, bh);
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
diff -Naurd old/fs/fat/inode.c new/fs/fat/inode.c
--- old/fs/fat/inode.c	Sun Jun  2 21:44:48 2002
+++ new/fs/fat/inode.c	Sat Jun  8 17:25:48 2002
@@ -712,7 +712,7 @@
 		goto out_invalid;
 	}
 	logical_sector_size =
-		CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
+		le16_to_cpu(get_unaligned((unsigned short *) &b->sector_size));
 	if (!logical_sector_size
 	    || (logical_sector_size & (logical_sector_size - 1))
 	    || (logical_sector_size < 512)
@@ -760,8 +760,8 @@
 	sbi->cluster_bits = ffs(sb->s_blocksize * sbi->cluster_size) - 1;
 	sbi->fats = b->fats;
 	sbi->fat_bits = 0;		/* Don't know yet */
-	sbi->fat_start = CF_LE_W(b->reserved);
-	sbi->fat_length = CF_LE_W(b->fat_length);
+	sbi->fat_start = le16_to_cpu(b->reserved);
+	sbi->fat_length = le16_to_cpu(b->fat_length);
 	sbi->root_cluster = 0;
 	sbi->free_clusters = -1;	/* Don't know yet */
 	sbi->prev_free = 0;
@@ -772,11 +772,11 @@
 
 		/* Must be FAT32 */
 		sbi->fat_bits = 32;
-		sbi->fat_length = CF_LE_L(b->fat32_length);
-		sbi->root_cluster = CF_LE_L(b->root_cluster);
+		sbi->fat_length = le32_to_cpu(b->fat32_length);
+		sbi->root_cluster = le32_to_cpu(b->root_cluster);
 
 		/* MC - if info_sector is 0, don't multiply by 0 */
-		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
+		sbi->fsinfo_sector = le16_to_cpu(b->info_sector);
 		if (sbi->fsinfo_sector == 0)
 			sbi->fsinfo_sector = 1;
 
@@ -793,11 +793,11 @@
 			printk("FAT: Did not find valid FSINFO signature.\n"
 			       "     Found signature1 0x%08x signature2 0x%08x"
 			       " (sector = %lu)\n",
-			       CF_LE_L(fsinfo->signature1),
-			       CF_LE_L(fsinfo->signature2),
+			       le32_to_cpu(fsinfo->signature1),
+			       le32_to_cpu(fsinfo->signature2),
 			       sbi->fsinfo_sector);
 		} else {
-			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
+			sbi->free_clusters = le32_to_cpu(fsinfo->free_clusters);
 		}
 
 		brelse(fsinfo_bh);
@@ -808,7 +808,7 @@
 
 	sbi->dir_start = sbi->fat_start + sbi->fats * sbi->fat_length;
 	sbi->dir_entries =
-		CF_LE_W(get_unaligned((unsigned short *)&b->dir_entries));
+		le16_to_cpu(get_unaligned((unsigned short *)&b->dir_entries));
 	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
 		printk("FAT: bogus directroy-entries per block\n");
 		brelse(bh);
@@ -818,9 +818,9 @@
 	rootdir_sectors = sbi->dir_entries
 		* sizeof(struct msdos_dir_entry) / sb->s_blocksize;
 	sbi->data_start = sbi->dir_start + rootdir_sectors;
-	total_sectors = CF_LE_W(get_unaligned((unsigned short *)&b->sectors));
+	total_sectors = le16_to_cpu(get_unaligned((unsigned short *)&b->sectors));
 	if (total_sectors == 0)
-		total_sectors = CF_LE_L(b->total_sect);
+		total_sectors = le32_to_cpu(b->total_sect);
 	sbi->clusters = (total_sectors - sbi->data_start) / sbi->cluster_size;
 
 	if (sbi->fat_bits != 32)
@@ -1018,10 +1018,10 @@
 		inode->i_op = sbi->dir_ops;
 		inode->i_fop = &fat_dir_operations;
 
-		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
+		MSDOS_I(inode)->i_start = le16_to_cpu(de->start);
 		if (sbi->fat_bits == 32) {
 			MSDOS_I(inode)->i_start |=
-				(CF_LE_W(de->starthi) << 16);
+				(le16_to_cpu(de->starthi) << 16);
 		}
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
 		error = fat_calc_dir_size(inode);
@@ -1044,13 +1044,13 @@
 		       !is_exec(de->ext))
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
 		    & ~sbi->options.fs_umask) | S_IFREG;
-		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
+		MSDOS_I(inode)->i_start = le16_to_cpu(de->start);
 		if (sbi->fat_bits == 32) {
 			MSDOS_I(inode)->i_start |=
-				(CF_LE_W(de->starthi) << 16);
+				(le16_to_cpu(de->starthi) << 16);
 		}
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
-		inode->i_size = CF_LE_L(de->size);
+		inode->i_size = le32_to_cpu(de->size);
 	        inode->i_op = &fat_file_inode_operations;
 	        inode->i_fop = &fat_file_operations;
 		inode->i_mapping->a_ops = &fat_aops;
@@ -1065,10 +1065,10 @@
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
 			   & ~(inode->i_blksize - 1)) >> 9;
 	inode->i_mtime = inode->i_atime =
-		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
+		date_dos2unix(le16_to_cpu(de->time),le16_to_cpu(de->date));
 	inode->i_ctime =
 		MSDOS_SB(sb)->options.isvfat
-		? date_dos2unix(CF_LE_W(de->ctime),CF_LE_W(de->cdate))
+		? date_dos2unix(le16_to_cpu(de->ctime),le16_to_cpu(de->cdate))
 		: inode->i_mtime;
 	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
 
@@ -1110,20 +1110,20 @@
 	}
 	else {
 		raw_entry->attr = ATTR_NONE;
-		raw_entry->size = CT_LE_L(inode->i_size);
+		raw_entry->size = cpu_to_le32(inode->i_size);
 	}
 	raw_entry->attr |= MSDOS_MKATTR(inode->i_mode) |
 	    MSDOS_I(inode)->i_attrs;
-	raw_entry->start = CT_LE_W(MSDOS_I(inode)->i_logstart);
-	raw_entry->starthi = CT_LE_W(MSDOS_I(inode)->i_logstart >> 16);
+	raw_entry->start = cpu_to_le16(MSDOS_I(inode)->i_logstart);
+	raw_entry->starthi = cpu_to_le16(MSDOS_I(inode)->i_logstart >> 16);
 	fat_date_unix2dos(inode->i_mtime,&raw_entry->time,&raw_entry->date);
-	raw_entry->time = CT_LE_W(raw_entry->time);
-	raw_entry->date = CT_LE_W(raw_entry->date);
+	raw_entry->time = cpu_to_le16(raw_entry->time);
+	raw_entry->date = cpu_to_le16(raw_entry->date);
 	if (MSDOS_SB(sb)->options.isvfat) {
 		fat_date_unix2dos(inode->i_ctime,&raw_entry->ctime,&raw_entry->cdate);
 		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms;
-		raw_entry->ctime = CT_LE_W(raw_entry->ctime);
-		raw_entry->cdate = CT_LE_W(raw_entry->cdate);
+		raw_entry->ctime = cpu_to_le16(raw_entry->ctime);
+		raw_entry->cdate = cpu_to_le16(raw_entry->cdate);
 	}
 	spin_unlock(&fat_inode_lock);
 	fat_mark_buffer_dirty(sb, bh);
diff -Naurd old/fs/fat/misc.c new/fs/fat/misc.c
--- old/fs/fat/misc.c	Sun Jun  2 21:44:52 2002
+++ new/fs/fat/misc.c	Sat Jun  8 17:25:48 2002
@@ -115,10 +115,10 @@
 		printk("FAT: Did not find valid FSINFO signature.\n"
 		       "     Found signature1 0x%08x signature2 0x%08x"
 		       " (sector = %lu)\n",
-		       CF_LE_L(fsinfo->signature1), CF_LE_L(fsinfo->signature2),
+		       le32_to_cpu(fsinfo->signature1), le32_to_cpu(fsinfo->signature2),
 		       MSDOS_SB(sb)->fsinfo_sector);
 	} else {
-		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
+		fsinfo->free_clusters = le32_to_cpu(MSDOS_SB(sb)->free_clusters);
 		fat_mark_buffer_dirty(sb, bh);
 	}
 	fat_brelse(sb, bh);
@@ -405,9 +405,9 @@
     done = !IS_FREE(data[entry].name) \
       && ( \
            ( \
-             (MSDOS_SB(sb)->fat_bits != 32) ? 0 : (CF_LE_W(data[entry].starthi) << 16) \
+             (MSDOS_SB(sb)->fat_bits != 32) ? 0 : (le16_to_cpu(data[entry].starthi) << 16) \
            ) \
-           | CF_LE_W(data[entry].start) \
+           | le16_to_cpu(data[entry].start) \
          ) == *number;
 
 #define RSS_FREE /* search for free entry */ \
@@ -447,9 +447,9 @@
 		if (done) {
 			if (ino)
 				*ino = sector * MSDOS_SB(sb)->dir_per_block + entry;
-			start = CF_LE_W(data[entry].start);
+			start = le16_to_cpu(data[entry].start);
 			if (MSDOS_SB(sb)->fat_bits == 32) {
-				start |= (CF_LE_W(data[entry].starthi) << 16);
+				start |= (le16_to_cpu(data[entry].starthi) << 16);
 			}
 			if (!res_bh)
 				fat_brelse(sb, bh);
diff -Naurd old/fs/msdos/namei.c new/fs/msdos/namei.c
--- old/fs/msdos/namei.c	Sun Jun  2 21:44:49 2002
+++ new/fs/msdos/namei.c	Sat Jun  8 17:25:48 2002
@@ -514,8 +514,8 @@
 		mark_inode_dirty(new_inode);
 	}
 	if (dotdot_bh) {
-		dotdot_de->start = CT_LE_W(MSDOS_I(new_dir)->i_logstart);
-		dotdot_de->starthi = CT_LE_W((MSDOS_I(new_dir)->i_logstart) >> 16);
+		dotdot_de->start = cpu_to_le16(MSDOS_I(new_dir)->i_logstart);
+		dotdot_de->starthi = cpu_to_le16((MSDOS_I(new_dir)->i_logstart) >> 16);
 		fat_mark_buffer_dirty(sb, dotdot_bh);
 		old_dir->i_nlink--;
 		mark_inode_dirty(old_dir);
diff -Naurd old/fs/vfat/namei.c new/fs/vfat/namei.c
--- old/fs/vfat/namei.c	Sun Jun  2 21:44:51 2002
+++ new/fs/vfat/namei.c	Sat Jun  8 17:25:48 2002
@@ -1257,8 +1257,8 @@
 
 	if (is_dir) {
 		int start = MSDOS_I(new_dir)->i_logstart;
-		dotdot_de->start = CT_LE_W(start);
-		dotdot_de->starthi = CT_LE_W(start>>16);
+		dotdot_de->start = cpu_to_le16(start);
+		dotdot_de->starthi = cpu_to_le16(start>>16);
 		fat_mark_buffer_dirty(sb, dotdot_bh);
 		old_dir->i_nlink--;
 		if (new_inode) {
diff -Naurd old/include/linux/msdos_fs.h new/include/linux/msdos_fs.h
--- old/include/linux/msdos_fs.h	Sun Jun  2 21:44:52 2002
+++ new/include/linux/msdos_fs.h	Sat Jun  8 17:28:07 2002
@@ -80,8 +80,8 @@
 
 #define FAT_FSINFO_SIG1		0x41615252
 #define FAT_FSINFO_SIG2		0x61417272
-#define IS_FSINFO(x)	(CF_LE_L((x)->signature1) == FAT_FSINFO_SIG1	\
-			 && CF_LE_L((x)->signature2) == FAT_FSINFO_SIG2)
+#define IS_FSINFO(x)	(le32_to_cpu((x)->signature1) == FAT_FSINFO_SIG1	\
+			 && le32_to_cpu((x)->signature2) == FAT_FSINFO_SIG2)
 
 /*
  * ioctl commands
@@ -98,17 +98,6 @@
 #define VFAT_SFN_CREATE_WIN95	0x0100 /* emulate win95 rule for create */
 #define VFAT_SFN_CREATE_WINNT	0x0200 /* emulate winnt rule for create */
 
-/*
- * Conversion from and to little-endian byte order. (no-op on i386/i486)
- *
- * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
- * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
- */
-
-#define CF_LE_W(v) le16_to_cpu(v)
-#define CF_LE_L(v) le32_to_cpu(v)
-#define CT_LE_W(v) cpu_to_le16(v)
-#define CT_LE_L(v) cpu_to_le32(v)
 
 struct fat_boot_sector {
 	__s8	ignored[3];	/* Boot strap short or near jump */
