Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSDYOtl>; Thu, 25 Apr 2002 10:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313075AbSDYOtk>; Thu, 25 Apr 2002 10:49:40 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:58629 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S312610AbSDYOtf>; Thu, 25 Apr 2002 10:49:35 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix handling of the wrong cluster chain (1/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 25 Apr 2002 23:49:01 +0900
Message-ID: <87adrromua.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently fatfs are disregarding the most of wrong cluster chains, and
only continues processing.

This patch change it. If the wrong cluster chain is detected, change
filesystem to the read only, and return the error code.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.9/fs/fat/cache.c fat_chain_error-2.5.9/fs/fat/cache.c
--- linux-2.5.9/fs/fat/cache.c	Thu Apr 25 01:29:48 2002
+++ fat_chain_error-2.5.9/fs/fat/cache.c	Thu Apr 25 01:33:58 2002
@@ -40,8 +40,10 @@
 	unsigned char *p_first, *p_last;
 	int copy, first, last, next, b;
 
-	if ((unsigned) (nr-2) >= MSDOS_SB(sb)->clusters)
-		return 0;
+	if (nr < 2 || MSDOS_SB(sb)->clusters + 2 <= nr) {
+		fat_fs_panic(sb, "invalid access to FAT (entry 0x%08x)", nr);
+		return -EIO;
+	}
 	if (MSDOS_SB(sb)->fat_bits == 32) {
 		first = last = nr*4;
 	} else if (MSDOS_SB(sb)->fat_bits == 16) {
@@ -52,16 +54,17 @@
 	}
 	b = MSDOS_SB(sb)->fat_start + (first >> sb->s_blocksize_bits);
 	if (!(bh = fat_bread(sb, b))) {
-		printk("bread in fat_access failed\n");
-		return 0;
+		printk("FAT: bread(block %d) in fat_access failed\n", b);
+		return -EIO;
 	}
 	if ((first >> sb->s_blocksize_bits) == (last >> sb->s_blocksize_bits)) {
 		bh2 = bh;
 	} else {
 		if (!(bh2 = fat_bread(sb, b+1))) {
 			fat_brelse(sb, bh);
-			printk("2nd bread in fat_access failed\n");
-			return 0;
+			printk("FAT: bread(block %d) in fat_access failed\n",
+			       b + 1);
+			return -EIO;
 		}
 	}
 	if (MSDOS_SB(sb)->fat_bits == 32) {
@@ -69,23 +72,26 @@
 		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 2]);
 		/* Fscking Microsoft marketing department. Their "32" is 28. */
-		next &= 0xfffffff;
-		if (next >= 0xffffff7) next = -1;
+		next &= 0x0fffffff;
+		if (next >= BAD_FAT32) next = FAT_ENT_EOF;
 		PRINTK(("fat_bread: 0x%x, nr=0x%x, first=0x%x, next=0x%x\n", b, nr, first, next));
 
 	} else if (MSDOS_SB(sb)->fat_bits == 16) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
 		next = CF_LE_W(((__u16 *) bh->b_data)[(first &
 		    (sb->s_blocksize - 1)) >> 1]);
-		if (next >= 0xfff7) next = -1;
+		if (next >= BAD_FAT16) next = FAT_ENT_EOF;
 	} else {
 		p_first = &((__u8 *)bh->b_data)[first & (sb->s_blocksize - 1)];
 		p_last = &((__u8 *)bh2->b_data)[(first + 1) & (sb->s_blocksize - 1)];
 		if (nr & 1) next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
 		else next = (*p_first+(*p_last << 8)) & 0xfff;
-		if (next >= 0xff7) next = -1;
+		if (next >= BAD_FAT12) next = FAT_ENT_EOF;
 	}
 	if (new_value != -1) {
+		if (next == FAT_ENT_EOF)
+			next = EOF_FAT(sb);
+		
 		if (MSDOS_SB(sb)->fat_bits == 32) {
 			((__u32 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 2]
 				= CT_LE_L(new_value);
@@ -271,19 +277,30 @@
 }
 
 
-int fat_get_cluster(struct inode *inode,int cluster)
+static int fat_get_cluster(struct inode *inode, int cluster)
 {
+	struct super_block *sb = inode->i_sb;
 	int nr,count;
 
 	if (!(nr = MSDOS_I(inode)->i_start)) return 0;
 	if (!cluster) return nr;
 	count = 0;
-	for (fat_cache_lookup(inode,cluster,&count,&nr); count < cluster;
-	    count++) {
-		if ((nr = fat_access(inode->i_sb,nr,-1)) == -1) return 0;
-		if (!nr) return 0;
+	for (fat_cache_lookup(inode, cluster, &count, &nr);
+	     count < cluster;
+	     count++) {
+		nr = fat_access(sb, nr, -1);
+		if (nr == FAT_ENT_EOF) {
+			fat_fs_panic(sb, "%s: request beyond EOF (ino %lu)",
+				     __FUNCTION__, inode->i_ino);
+			return -EIO;
+		} else if (nr == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: invalid cluster chain (ino %lu)",
+				     __FUNCTION__, inode->i_ino);
+			return -EIO;
+		} else if (nr < 0)
+			return nr;
 	}
-	fat_cache_add(inode,cluster,nr);
+	fat_cache_add(inode, cluster, nr);
 	return nr;
 }
 
@@ -307,9 +324,11 @@
 
 	cluster = sector / sbi->cluster_size;
 	offset  = sector % sbi->cluster_size;
-	if (!(cluster = fat_get_cluster(inode, cluster)))
+	cluster = fat_get_cluster(inode, cluster);
+	if (cluster < 0)
+		return cluster;
+	else if (!cluster)
 		return 0;
-
 	return (cluster - 2) * sbi->cluster_size + sbi->data_start + offset;
 }
 
@@ -319,20 +338,25 @@
 
 int fat_free(struct inode *inode,int skip)
 {
+	struct super_block *sb = inode->i_sb;
 	int nr,last;
 
 	if (!(nr = MSDOS_I(inode)->i_start)) return 0;
 	last = 0;
 	while (skip--) {
 		last = nr;
-		if ((nr = fat_access(inode->i_sb,nr,-1)) == -1) return 0;
-		if (!nr) {
-			printk("fat_free: skipped EOF\n");
+		nr = fat_access(sb, nr, -1);
+		if (nr == FAT_ENT_EOF)
+			return 0;
+		else if (nr == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: invalid cluster chain (ino %lu)",
+				     __FUNCTION__, inode->i_ino);
 			return -EIO;
-		}
+		} else if (nr < 0)
+			return nr;
 	}
 	if (last) {
-		fat_access(inode->i_sb,last,EOF_FAT(inode->i_sb));
+		fat_access(sb, last, FAT_ENT_EOF);
 		fat_cache_inval_inode(inode);
 	} else {
 		fat_cache_inval_inode(inode);
@@ -340,11 +364,17 @@
 		MSDOS_I(inode)->i_logstart = 0;
 		mark_inode_dirty(inode);
 	}
-	lock_fat(inode->i_sb);
-	while (nr != -1) {
-		if (!(nr = fat_access(inode->i_sb,nr,0))) {
-			fat_fs_panic(inode->i_sb,"fat_free: deleting beyond EOF");
-			break;
+
+	lock_fat(sb);
+	while (nr != FAT_ENT_EOF) {
+		nr = fat_access(sb, nr, FAT_ENT_FREE);
+		if (nr < 0)
+			goto error;
+		else if (nr == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: deleting beyond EOF (ino %lu)",
+				     __FUNCTION__, inode->i_ino);
+			nr = -EIO;
+			goto error;
 		}
 		if (MSDOS_SB(inode->i_sb)->free_clusters != -1) {
 			MSDOS_SB(inode->i_sb)->free_clusters++;
@@ -354,6 +384,9 @@
 		}
 		inode->i_blocks -= (1 << MSDOS_SB(inode->i_sb)->cluster_bits) / 512;
 	}
-	unlock_fat(inode->i_sb);
-	return 0;
+	nr = 0;
+error:
+	unlock_fat(sb);
+
+	return nr;
 }
diff -urN linux-2.5.9/fs/fat/fatfs_syms.c fat_chain_error-2.5.9/fs/fat/fatfs_syms.c
--- linux-2.5.9/fs/fat/fatfs_syms.c	Thu Apr 25 01:29:48 2002
+++ fat_chain_error-2.5.9/fs/fat/fatfs_syms.c	Thu Apr 25 01:33:58 2002
@@ -32,7 +32,6 @@
 EXPORT_SYMBOL(fat_write_inode);
 EXPORT_SYMBOL(register_cvf_format);
 EXPORT_SYMBOL(unregister_cvf_format);
-EXPORT_SYMBOL(fat_get_cluster);
 EXPORT_SYMBOL(fat_dir_ioctl);
 EXPORT_SYMBOL(fat_add_entries);
 EXPORT_SYMBOL(fat_dir_empty);
diff -urN linux-2.5.9/fs/fat/file.c fat_chain_error-2.5.9/fs/fat/file.c
--- linux-2.5.9/fs/fat/file.c	Thu Apr 25 01:29:48 2002
+++ fat_chain_error-2.5.9/fs/fat/file.c	Thu Apr 25 01:33:58 2002
@@ -46,6 +46,8 @@
 	unsigned long phys;
 
 	phys = fat_bmap(inode, iblock);
+	if (phys < 0)
+		return phys;
 	if (phys) {
 		map_bh(bh_result, inode->i_sb, phys);
 		return 0;
@@ -65,6 +67,8 @@
 	}
 	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
 	phys = fat_bmap(inode, iblock);
+	if (phys < 0)
+		return phys;
 	if (!phys)
 		BUG();
 	bh_result->b_state |= (1UL << BH_New);
diff -urN linux-2.5.9/fs/fat/inode.c fat_chain_error-2.5.9/fs/fat/inode.c
--- linux-2.5.9/fs/fat/inode.c	Thu Apr 25 01:29:48 2002
+++ fat_chain_error-2.5.9/fs/fat/inode.c	Thu Apr 25 01:33:58 2002
@@ -121,7 +121,7 @@
 	return inode;
 }
 
-static void fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
+static int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
 
 struct inode *fat_build_inode(struct super_block *sb,
 				struct msdos_dir_entry *de, int ino, int *res)
@@ -135,10 +135,14 @@
 	*res = -ENOMEM;
 	if (!inode)
 		goto out;
-	*res = 0;
 	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
 	inode->i_version = 0;
-	fat_fill_inode(inode, de);
+	*res = fat_fill_inode(inode, de);
+	if (*res < 0) {
+		iput(inode);
+		inode = NULL;
+		goto out;
+	}
 	fat_attach(inode, ino);
 	insert_inode_hash(inode);
 out:
@@ -358,22 +362,25 @@
 	return ret;
 }
 
-static void fat_calc_dir_size(struct inode *inode)
+static int fat_calc_dir_size(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	int nr;
 
 	inode->i_size = 0;
 	if (MSDOS_I(inode)->i_start == 0)
-		return;
+		return 0;
 
 	nr = MSDOS_I(inode)->i_start;
 	do {
 		inode->i_size += 1 << MSDOS_SB(sb)->cluster_bits;
-		if (!(nr = fat_access(sb, nr, -1))) {
-			printk("FAT: Directory %ld: bad FAT\n",
-			       inode->i_ino);
-			break;
+		nr = fat_access(sb, nr, -1);
+		if (nr < 0)
+			return nr;
+		else if (nr == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "Directory %lu: invalid cluster chain",
+				     inode->i_ino);
+			return -EIO;
 		}
 		if (inode->i_size > FAT_MAX_DIR_SIZE) {
 			fat_fs_panic(sb, "Directory %ld: "
@@ -382,13 +389,16 @@
 			inode->i_size = FAT_MAX_DIR_SIZE;
 			break;
 		}
-	} while (nr != -1);
+	} while (nr != FAT_ENT_EOF);
+
+	return 0;
 }
 
-static void fat_read_root(struct inode *inode)
+static int fat_read_root(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int error;
 
 	MSDOS_I(inode)->i_location = 0;
 	inode->i_uid = sbi->options.fs_uid;
@@ -400,7 +410,9 @@
 	inode->i_fop = &fat_dir_operations;
 	if (sbi->fat_bits == 32) {
 		MSDOS_I(inode)->i_start = sbi->root_cluster;
-		fat_calc_dir_size(inode);
+		error = fat_calc_dir_size(inode);
+		if (error < 0)
+			return error;
 	} else {
 		MSDOS_I(inode)->i_start = 0;
 		inode->i_size = sbi->dir_entries * sizeof(struct msdos_dir_entry);
@@ -415,6 +427,8 @@
 	inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
 	MSDOS_I(inode)->i_ctime_ms = 0;
 	inode->i_nlink = fat_subdirs(inode)+2;
+
+	return 0;
 }
 
 /*
@@ -573,7 +587,7 @@
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat)
 {
-	struct inode *root_inode;
+	struct inode *root_inode = NULL;
 	struct buffer_head *bh;
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi;
@@ -802,18 +816,20 @@
 			       sbi->nls_io->charset);
 	}
 
+	error = -ENOMEM;
 	root_inode = new_inode(sb);
 	if (!root_inode)
 		goto out_fail;
-
 	root_inode->i_ino = MSDOS_ROOT_INO;
 	root_inode->i_version = 0;
-	fat_read_root(root_inode);
+	error = fat_read_root(root_inode);
+	if (error < 0)
+		goto out_fail;
+	error = -ENOMEM;
 	insert_inode_hash(root_inode);
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root) {
 		printk("FAT: get root inode failed\n");
-		iput(root_inode);
 		goto out_fail;
 	}
 	if(i >= 0) {
@@ -826,6 +842,8 @@
 	error = -EINVAL;
 
 out_fail:
+	if (root_inode)
+		iput(root_inode);
 	if (sbi->nls_io)
 		unload_nls(sbi->nls_io);
 	if (sbi->nls_disk)
@@ -855,17 +873,20 @@
 		free = MSDOS_SB(sb)->free_clusters;
 	else {
 		free = 0;
-		for (nr = 2; nr < MSDOS_SB(sb)->clusters+2; nr++)
-			if (!fat_access(sb,nr,-1)) free++;
+		for (nr = 2; nr < MSDOS_SB(sb)->clusters + 2; nr++)
+			if (fat_access(sb, nr, -1) == FAT_ENT_FREE)
+				free++;
 		MSDOS_SB(sb)->free_clusters = free;
 	}
 	unlock_fat(sb);
+
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = 1 << MSDOS_SB(sb)->cluster_bits;
 	buf->f_blocks = MSDOS_SB(sb)->clusters;
 	buf->f_bfree = free;
 	buf->f_bavail = free;
 	buf->f_namelen = MSDOS_SB(sb)->options.isvfat ? 260 : 12;
+
 	return 0;
 }
 
@@ -906,10 +927,11 @@
 };
 
 /* doesn't deal with root inode */
-static void fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
+static int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int error;
 
 	MSDOS_I(inode)->i_location = 0;
 	inode->i_uid = sbi->options.fs_uid;
@@ -930,6 +952,11 @@
 				(CF_LE_W(de->starthi) << 16);
 		}
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
+		error = fat_calc_dir_size(inode);
+		if (error < 0)
+			return error;
+		MSDOS_I(inode)->mmu_private = inode->i_size;
+
 		inode->i_nlink = fat_subdirs(inode);
 		    /* includes .., compensating for "self" */
 #ifdef DEBUG
@@ -938,8 +965,6 @@
 			inode->i_nlink = 1;
 		}
 #endif
-		fat_calc_dir_size(inode);
-		MSDOS_I(inode)->mmu_private = inode->i_size;
 	} else { /* not a directory */
 		inode->i_generation |= 1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,
@@ -974,6 +999,8 @@
 		? date_dos2unix(CF_LE_W(de->ctime),CF_LE_W(de->cdate))
 		: inode->i_mtime;
 	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
+
+	return 0;
 }
 
 void fat_write_inode(struct inode *inode, int wait)
diff -urN linux-2.5.9/fs/fat/misc.c fat_chain_error-2.5.9/fs/fat/misc.c
--- linux-2.5.9/fs/fat/misc.c	Thu Apr 25 01:29:48 2002
+++ fat_chain_error-2.5.9/fs/fat/misc.c	Thu Apr 25 01:33:58 2002
@@ -128,6 +128,41 @@
 	int count, nr, limit, last, curr, file_cluster;
 	int cluster_bits = MSDOS_SB(sb)->cluster_bits;
 	
+	/* 
+	 * We must locate the last cluster of the file to add this new
+	 * one (nr) to the end of the link list (the FAT).
+	 *
+	 * In order to confirm that the cluster chain is valid, we
+	 * find out EOF first.
+	 */
+	nr = -EIO;
+	last = file_cluster = 0;
+	if ((curr = MSDOS_I(inode)->i_start) != 0) {
+		int max_cluster = MSDOS_I(inode)->mmu_private >> cluster_bits;
+
+		fat_cache_lookup(inode, INT_MAX, &last, &curr);
+		file_cluster = last;
+		while (curr && curr != FAT_ENT_EOF) {
+			file_cluster++;
+			curr = fat_access(sb, last = curr, -1);
+			if (curr < 0)
+				return curr;
+			else if (curr == FAT_ENT_FREE) {
+				fat_fs_panic(sb, "%s: invalid cluster chain"
+					     " (ino %lu)",
+					     __FUNCTION__, inode->i_ino);
+				goto out;
+			}
+			if (file_cluster > max_cluster) {
+				fat_fs_panic(sb, "%s: bad cluster counts"
+					     " (ino %lu)",
+					     __FUNCTION__, inode->i_ino);
+				goto out;
+			}
+		}
+	}
+
+	/* find free FAT entry */
 	lock_fat(sb);
 	
 	if (MSDOS_SB(sb)->free_clusters == 0) {
@@ -135,10 +170,9 @@
 		return -ENOSPC;
 	}
 	limit = MSDOS_SB(sb)->clusters;
-	nr = limit; /* to keep GCC happy */
 	for (count = 0; count < limit; count++) {
 		nr = ((count + MSDOS_SB(sb)->prev_free) % limit) + 2;
-		if (fat_access(sb, nr, -1) == 0)
+		if (fat_access(sb, nr, -1) == FAT_ENT_FREE)
 			break;
 	}
 	if (count >= limit) {
@@ -148,43 +182,15 @@
 	}
 	
 	MSDOS_SB(sb)->prev_free = (count + MSDOS_SB(sb)->prev_free + 1) % limit;
-	fat_access(sb, nr, EOF_FAT(sb));
+	fat_access(sb, nr, FAT_ENT_EOF);
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		MSDOS_SB(sb)->free_clusters--;
 	if (MSDOS_SB(sb)->fat_bits == 32)
 		fat_clusters_flush(sb);
 	
 	unlock_fat(sb);
-	
-	/* We must locate the last cluster of the file to add this
-	   new one (nr) to the end of the link list (the FAT).
-	   
-	   Here file_cluster will be the number of the last cluster of the
-	   file (before we add nr).
-	   
-	   last is the corresponding cluster number on the disk. We will
-	   use last to plug the nr cluster. We will use file_cluster to
-	   update the cache.
-	*/
-	last = file_cluster = 0;
-	if ((curr = MSDOS_I(inode)->i_start) != 0) {
-		int max_cluster = MSDOS_I(inode)->mmu_private >> cluster_bits;
 
-		fat_cache_lookup(inode, INT_MAX, &last, &curr);
-		file_cluster = last;
-		while (curr && curr != -1) {
-			file_cluster++;
-			if (!(curr = fat_access(sb, last = curr, -1))) {
-				fat_fs_panic(sb, "File without EOF");
-				return -EIO;
-			}
-			if (file_cluster > max_cluster) {
-				fat_fs_panic(sb,"inode %lu: bad cluster counts",
-					     inode->i_ino);
-				return -EIO;
-			}
-		}
-	}
+	/* add new one to the last of the cluster chain */
 	if (last) {
 		fat_access(sb, last, nr);
 		fat_cache_add(inode, file_cluster, nr);
@@ -200,6 +206,7 @@
 	}
 	inode->i_blocks += (1 << cluster_bits) >> 9;
 
+out:
 	return nr;
 }
 
@@ -330,33 +337,33 @@
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int sector, offset;
+	int sector, offset, iblock;
 
-	while (1) {
-		offset = *pos;
-		PRINTK (("get_entry offset %d\n",offset));
-		if (*bh)
-			fat_brelse(sb, *bh);
-		*bh = NULL;
-		if ((sector = fat_bmap(dir,offset >> sb->s_blocksize_bits)) == -1)
-			return -1;
-		PRINTK (("get_entry sector %d %p\n",sector,*bh));
-		PRINTK (("get_entry sector apres brelse\n"));
-		if (!sector)
-			return -1; /* beyond EOF */
-		*pos += sizeof(struct msdos_dir_entry);
-		if (!(*bh = fat_bread(sb, sector))) {
-			printk("Directory sread (sector 0x%x) failed\n",sector);
-			continue;
-		}
-		PRINTK (("get_entry apres sread\n"));
+next:
+	offset = *pos;
+	if (*bh)
+		fat_brelse(sb, *bh);
+
+	*bh = NULL;
+	iblock = *pos >> sb->s_blocksize_bits;
+	sector = fat_bmap(dir, iblock);
+	if (sector <= 0)
+		return -1;	/* beyond EOF or error */
+
+	*bh = fat_bread(sb, sector);
+	if (*bh == NULL) {
+		printk("FAT: Directory bread(block %d) failed\n", sector);
+		/* skip this block */
+		*pos = (iblock + 1) << sb->s_blocksize_bits;
+		goto next;
+	}
+
+	offset &= sb->s_blocksize - 1;
+	*pos += sizeof(struct msdos_dir_entry);
+	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
+	*ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
 
-		offset &= sb->s_blocksize - 1;
-		*de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
-		*ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
-
-		return 0;
-	}
+	return 0;
 }
 
 
@@ -503,14 +510,18 @@
 				     start);
 			break;
 		}
-		if (!(start = fat_access(sb,start,-1))) {
-			fat_fs_panic(sb,"FAT error");
+		start = fat_access(sb, start, -1);
+		if (start < 0)
+			return start;
+		else if (start == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: invalid cluster chain",
+				     __FUNCTION__);
 			break;
 		}
 #ifdef DEBUG
 	printk("next start: %d\n",start);
 #endif
-	} while (start != -1);
+	} while (start != FAT_ENT_EOF);
 
 	return -ENOENT;
 }
diff -urN linux-2.5.9/include/linux/msdos_fs.h fat_chain_error-2.5.9/include/linux/msdos_fs.h
--- linux-2.5.9/include/linux/msdos_fs.h	Thu Apr 25 01:30:16 2002
+++ fat_chain_error-2.5.9/include/linux/msdos_fs.h	Thu Apr 25 01:33:58 2002
@@ -54,12 +54,24 @@
 
 #define MSDOS_FAT12 4084 /* maximum number of clusters in a 12 bit FAT */
 
-#define EOF_FAT12 0xFF8		/* standard EOF */
+/* bad cluster mark */
+#define BAD_FAT12 0xFF7
+#define BAD_FAT16 0xFFF7
+#define BAD_FAT32 0xFFFFFF7
+#define BAD_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? BAD_FAT32 : \
+	MSDOS_SB(s)->fat_bits == 16 ? BAD_FAT16 : BAD_FAT12)
+
+/* standard EOF */
+#define EOF_FAT12 0xFF8
 #define EOF_FAT16 0xFFF8
 #define EOF_FAT32 0xFFFFFF8
 #define EOF_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? EOF_FAT32 : \
 	MSDOS_SB(s)->fat_bits == 16 ? EOF_FAT16 : EOF_FAT12)
 
+#define FAT_ENT_FREE	(0)
+#define FAT_ENT_BAD	(BAD_FAT32)
+#define FAT_ENT_EOF	(EOF_FAT32)
+
 #define FAT_FSINFO_SIG1		0x41615252
 #define FAT_FSINFO_SIG2		0x61417272
 #define IS_FSINFO(x)	(CF_LE_L((x)->signature1) == FAT_FSINFO_SIG1	\
@@ -237,7 +249,6 @@
 extern void fat_cache_add(struct inode *inode, int f_clu, int d_clu);
 extern void fat_cache_inval_inode(struct inode *inode);
 extern void fat_cache_inval_dev(struct super_block *sb);
-extern int fat_get_cluster(struct inode *inode, int cluster);
 extern int fat_free(struct inode *inode, int skip);
 
 /* fat/dir.c */
