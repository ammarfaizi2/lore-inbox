Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbREWTow>; Wed, 23 May 2001 15:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263231AbREWTod>; Wed, 23 May 2001 15:44:33 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:2322 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S263228AbREWToU>; Wed, 23 May 2001 15:44:20 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] big-sector support with FAT
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 24 May 2001 04:42:59 +0900
Message-ID: <87lmnn97i4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I fixed it to dynamically change block size with logical_sector_size
of FAT. The device of bigger sector-size than 512 can be handled by
this change.

There is the following:

1) blocksize is fixed when a file system is created.
2) logical_sector_size < sector-size of the device is not supported.

But, Windows{95,2k} doesn't support 2) too.

I think the 1) and 2) a no problem.

Please apply.
Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urP linux-2.4.5-pre5/fs/fat/buffer.c linux-2.4.5-pre5-fat/fs/fat/buffer.c
--- linux-2.4.5-pre5/fs/fat/buffer.c	Sat Feb 10 04:29:44 2001
+++ linux-2.4.5-pre5-fat/fs/fat/buffer.c	Wed May 16 03:51:40 2001
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/blkdev.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 
@@ -58,22 +59,26 @@
 
 struct buffer_head *default_fat_bread(struct super_block *sb, int block)
 {
-	return bread (sb->s_dev,block,512);
+	return bread (sb->s_dev, block, sb->s_blocksize);
 }
+
 struct buffer_head *default_fat_getblk(struct super_block *sb, int block)
 {
-	return getblk (sb->s_dev,block,512);
+	return getblk (sb->s_dev, block, sb->s_blocksize);
 }
+
 void default_fat_brelse(struct super_block *sb, struct buffer_head *bh)
 {
 	brelse (bh);
 }
+
 void default_fat_mark_buffer_dirty (
 	struct super_block *sb,
 	struct buffer_head *bh)
 {
 	mark_buffer_dirty (bh);
 }
+
 void default_fat_set_uptodate (
 	struct super_block *sb,
 	struct buffer_head *bh,
@@ -81,10 +86,12 @@
 {
 	mark_buffer_uptodate(bh, val);
 }
+
 int default_fat_is_uptodate (struct super_block *sb, struct buffer_head *bh)
 {
 	return buffer_uptodate(bh);
 }
+
 void default_fat_ll_rw_block (
 	struct super_block *sb,
 	int opr,
@@ -94,109 +101,61 @@
 	ll_rw_block(opr,nbreq,bh);
 }
 
-struct buffer_head *bigblock_fat_bread (
-	struct super_block *sb,
-	int block)
+struct buffer_head *bigblock_fat_bread(struct super_block *sb, int block)
 {
-	struct buffer_head *ret = NULL;
-	struct buffer_head *real;
-	if (sb->s_blocksize == 1024){
-		real = bread (sb->s_dev,block>>1,1024);
-	} else {
-		real = bread (sb->s_dev,block>>2,2048);
-	}
-
+	unsigned int hardsect = get_hardsect_size(sb->s_dev);
+	int rblock, roffset;
+	struct buffer_head *real, *dummy;
+
+	if (hardsect <= sb->s_blocksize)
+		BUG();
+
+	dummy = NULL;
+	rblock = block / (hardsect / sb->s_blocksize);
+	roffset = (block % (hardsect / sb->s_blocksize)) * sb->s_blocksize;
+	real = bread(sb->s_dev, rblock, hardsect);
 	if (real != NULL) {
-		ret = (struct buffer_head *)
-			kmalloc (sizeof(struct buffer_head), GFP_KERNEL);
-		if (ret != NULL) {
-			/* #Specification: msdos / strategy / special device / dummy blocks
-			 * Many special device (Scsi optical disk for one) use
-			 * larger hardware sector size. This allows for higher
-			 * capacity.
-
-			 * Most of the time, the MS-DOS filesystem that sits
-			 * on this device is totally unaligned. It use logically
-			 * 512 bytes sector size, with logical sector starting
-			 * in the middle of a hardware block. The bad news is
-			 * that a hardware sector may hold data own by two
-			 * different files. This means that the hardware sector
-			 * must be read, patch and written almost all the time.
-
-			 * Needless to say that it kills write performance
-			 * on all OS.
-
-			 * Internally the linux msdos fs is using 512 bytes
-			 * logical sector. When accessing such a device, we
-			 * allocate dummy buffer cache blocks, that we stuff
-			 * with the information of a real one (1k large).
-
-			 * This strategy is used to hide this difference to
-			 * the core of the msdos fs. The slowdown is not
-			 * hidden though!
-			 */
-			/*
-			 * The memset is there only to catch errors. The msdos
-			 * fs is only using b_data
-			 */
-			memset (ret,0,sizeof(*ret));
-			ret->b_data = real->b_data;
-			if (sb->s_blocksize == 2048) {
-				if (block & 3) ret->b_data += (block & 3) << 9;
-			}else{
-				if (block & 1) ret->b_data += 512;
-			}
-			ret->b_next = real;
-		}else{
-			brelse (real);
-		}
+		dummy = kmalloc(sizeof(struct buffer_head), GFP_KERNEL);
+		if (dummy != NULL) {
+			memset(dummy, 0, sizeof(*dummy));
+			dummy->b_data = real->b_data + roffset;
+			dummy->b_next = real;
+		} else
+			brelse(real);
 	}
-	return ret;
+
+	return dummy;
 }
 
-void bigblock_fat_brelse (
-	struct super_block *sb,
-	struct buffer_head *bh)
+void bigblock_fat_brelse(struct super_block *sb, struct buffer_head *bh)
 {
-	brelse (bh->b_next);
-	/*
-	 * We can free the dummy because a new one is allocated at
-	 * each fat_getblk() and fat_bread().
-	 */
-	kfree (bh);
+	brelse(bh->b_next);
+	kfree(bh);
 }
 
-void bigblock_fat_mark_buffer_dirty (
-	struct super_block *sb,
-	struct buffer_head *bh)
+void bigblock_fat_mark_buffer_dirty(struct super_block *sb, struct buffer_head *bh)
 {
-	mark_buffer_dirty (bh->b_next);
+	mark_buffer_dirty(bh->b_next);
 }
 
-void bigblock_fat_set_uptodate (
-	struct super_block *sb,
-	struct buffer_head *bh,
-	int val)
+void bigblock_fat_set_uptodate(struct super_block *sb, struct buffer_head *bh,
+			       int val)
 {
 	mark_buffer_uptodate(bh->b_next, val);
 }
 
-int bigblock_fat_is_uptodate (
-	struct super_block *sb,
-	struct buffer_head *bh)
+int bigblock_fat_is_uptodate(struct super_block *sb, struct buffer_head *bh)
 {
 	return buffer_uptodate(bh->b_next);
 }
 
-void bigblock_fat_ll_rw_block (
-	struct super_block *sb,
-	int opr,
-	int nbreq,
-	struct buffer_head *bh[32])
+void bigblock_fat_ll_rw_block (struct super_block *sb, int opr, int nbreq,
+			       struct buffer_head *bh[32])
 {
 	struct buffer_head *tmp[32];
 	int i;
-	for (i=0; i<nbreq; i++)
+
+	for (i = 0; i < nbreq; i++)
 		tmp[i] = bh[i]->b_next;
-	ll_rw_block(opr,nbreq,tmp);
+	ll_rw_block(opr, nbreq, tmp);
 }
diff -urP linux-2.4.5-pre5/fs/fat/cache.c linux-2.4.5-pre5-fat/fs/fat/cache.c
--- linux-2.4.5-pre5/fs/fat/cache.c	Tue Jan 16 11:58:04 2001
+++ linux-2.4.5-pre5-fat/fs/fat/cache.c	Tue May 15 02:37:47 2001
@@ -41,9 +41,9 @@
 
 int default_fat_access(struct super_block *sb,int nr,int new_value)
 {
-	struct buffer_head *bh,*bh2,*c_bh,*c_bh2;
-	unsigned char *p_first,*p_last;
-	int copy,first,last,next,b;
+	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;
+	unsigned char *p_first, *p_last;
+	int copy, first, last, next, b;
 
 	if ((unsigned) (nr-2) >= MSDOS_SB(sb)->clusters)
 		return 0;
@@ -55,12 +55,12 @@
 		first = nr*3/2;
 		last = first+1;
 	}
-	b = MSDOS_SB(sb)->fat_start + (first >> SECTOR_BITS);
+	b = MSDOS_SB(sb)->fat_start + (first >> sb->s_blocksize_bits);
 	if (!(bh = fat_bread(sb, b))) {
 		printk("bread in fat_access failed\n");
 		return 0;
 	}
-	if ((first >> SECTOR_BITS) == (last >> SECTOR_BITS)) {
+	if ((first >> sb->s_blocksize_bits) == (last >> sb->s_blocksize_bits)) {
 		bh2 = bh;
 	} else {
 		if (!(bh2 = fat_bread(sb, b+1))) {
@@ -72,7 +72,7 @@
 	if (MSDOS_SB(sb)->fat_bits == 32) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
 		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
-		    (SECTOR_SIZE-1)) >> 2]);
+		    (sb->s_blocksize - 1)) >> 2]);
 		/* Fscking Microsoft marketing department. Their "32" is 28. */
 		next &= 0xfffffff;
 		if (next >= 0xffffff7) next = -1;
@@ -81,23 +81,22 @@
 	} else if (MSDOS_SB(sb)->fat_bits == 16) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
 		next = CF_LE_W(((__u16 *) bh->b_data)[(first &
-		    (SECTOR_SIZE-1)) >> 1]);
+		    (sb->s_blocksize - 1)) >> 1]);
 		if (next >= 0xfff7) next = -1;
 	} else {
-		p_first = &((__u8 *) bh->b_data)[first & (SECTOR_SIZE-1)];
-		p_last = &((__u8 *) bh2->b_data)[(first+1) &
-		    (SECTOR_SIZE-1)];
+		p_first = &((__u8 *)bh->b_data)[first & (sb->s_blocksize - 1)];
+		p_last = &((__u8 *)bh2->b_data)[(first + 1) & (sb->s_blocksize - 1)];
 		if (nr & 1) next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
 		else next = (*p_first+(*p_last << 8)) & 0xfff;
 		if (next >= 0xff7) next = -1;
 	}
 	if (new_value != -1) {
 		if (MSDOS_SB(sb)->fat_bits == 32) {
-			((__u32 *) bh->b_data)[(first & (SECTOR_SIZE-1)) >>
-			    2] = CT_LE_L(new_value);
+			((__u32 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 2]
+				= CT_LE_L(new_value);
 		} else if (MSDOS_SB(sb)->fat_bits == 16) {
-			((__u16 *) bh->b_data)[(first & (SECTOR_SIZE-1)) >>
-			    1] = CT_LE_W(new_value);
+			((__u16 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 1]
+				= CT_LE_W(new_value);
 		} else {
 			if (nr & 1) {
 				*p_first = (*p_first & 0xf) | (new_value << 4);
@@ -111,20 +110,21 @@
 		}
 		fat_mark_buffer_dirty(sb, bh);
 		for (copy = 1; copy < MSDOS_SB(sb)->fats; copy++) {
-			b = MSDOS_SB(sb)->fat_start + (first >> SECTOR_BITS) +
-				MSDOS_SB(sb)->fat_length * copy;
+			b = MSDOS_SB(sb)->fat_start + (first >> sb->s_blocksize_bits)
+				+ MSDOS_SB(sb)->fat_length * copy;
 			if (!(c_bh = fat_bread(sb, b)))
 				break;
-			memcpy(c_bh->b_data,bh->b_data,SECTOR_SIZE);
-			fat_mark_buffer_dirty(sb, c_bh);
 			if (bh != bh2) {
 				if (!(c_bh2 = fat_bread(sb, b+1))) {
 					fat_brelse(sb, c_bh);
 					break;
 				}
-				memcpy(c_bh2->b_data,bh2->b_data,SECTOR_SIZE);
+				memcpy(c_bh2->b_data, bh2->b_data, sb->s_blocksize);
+				fat_mark_buffer_dirty(sb, c_bh2);
 				fat_brelse(sb, c_bh2);
 			}
+			memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
+			fat_mark_buffer_dirty(sb, c_bh);
 			fat_brelse(sb, c_bh);
 		}
 	}
@@ -143,7 +143,7 @@
 	if (initialized) {
 		spin_unlock(&fat_cache_lock);
 		return;
-		}
+	}
 	fat_cache = &cache[0];
 	for (count = 0; count < FAT_CACHE; count++) {
 		cache[count].device = 0;
@@ -294,22 +294,28 @@
 
 int default_fat_bmap(struct inode *inode,int sector)
 {
-	struct msdos_sb_info *sb=MSDOS_SB(inode->i_sb);
-	int cluster,offset;
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int cluster, offset, last_block;
 
-	if ((sb->fat_bits != 32) &&
+	if ((sbi->fat_bits != 32) &&
 	    (inode->i_ino == MSDOS_ROOT_INO || (S_ISDIR(inode->i_mode) &&
 	     !MSDOS_I(inode)->i_start))) {
-		if (sector >= sb->dir_entries >> MSDOS_DPS_BITS)
+		if (sector >= sbi->dir_entries >> sbi->dir_per_block_bits)
 			return 0;
-		return sector+sb->dir_start;
+		return sector + sbi->dir_start;
 	}
-	if (sector >= (MSDOS_I(inode)->mmu_private+511)>>9)
+	last_block = (MSDOS_I(inode)->mmu_private + (sb->s_blocksize - 1))
+		>> sb->s_blocksize_bits;
+	if (sector >= last_block)
 		return 0;
-	cluster = sector/sb->cluster_size;
-	offset = sector % sb->cluster_size;
-	if (!(cluster = fat_get_cluster(inode,cluster))) return 0;
-	return (cluster-2)*sb->cluster_size+sb->data_start+offset;
+
+	cluster = sector / sbi->cluster_size;
+	offset  = sector % sbi->cluster_size;
+	if (!(cluster = fat_get_cluster(inode, cluster)))
+		return 0;
+
+	return (cluster - 2) * sbi->cluster_size + sbi->data_start + offset;
 }
 
 
@@ -351,7 +357,7 @@
 				fat_clusters_flush(inode->i_sb);
 			}
 		}
-		inode->i_blocks -= MSDOS_SB(inode->i_sb)->cluster_size;
+		inode->i_blocks -= (1 << MSDOS_SB(inode->i_sb)->cluster_bits) / 512;
 	}
 	unlock_fat(inode->i_sb);
 	return 0;
diff -urP linux-2.4.5-pre5/fs/fat/file.c linux-2.4.5-pre5-fat/fs/fat/file.c
--- linux-2.4.5-pre5/fs/fat/file.c	Thu Apr 13 01:47:29 2000
+++ linux-2.4.5-pre5-fat/fs/fat/file.c	Tue May 15 02:37:47 2001
@@ -54,8 +54,11 @@
 }
 
 
-int fat_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create) {
+int fat_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+{
+	struct super_block *sb = inode->i_sb;
 	unsigned long phys;
+
 	phys = fat_bmap(inode, iblock);
 	if (phys) {
 		bh_result->b_dev = inode->i_dev;
@@ -65,7 +68,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock<<9 != MSDOS_I(inode)->mmu_private) {
+	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
 		BUG();
 		return -EIO;
 	}
@@ -73,8 +76,8 @@
 		if (fat_add_cluster(inode))
 			return -ENOSPC;
 	}
-	MSDOS_I(inode)->mmu_private += 512;
-	phys=fat_bmap(inode, iblock);
+	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
+	phys = fat_bmap(inode, iblock);
 	if (!phys)
 		BUG();
 	bh_result->b_dev = inode->i_dev;
@@ -124,7 +127,7 @@
 		return /* -EPERM */;
 	if (IS_IMMUTABLE(inode))
 		return /* -EPERM */;
-	cluster = SECTOR_SIZE*sbi->cluster_size;
+	cluster = 1 << sbi->cluster_bits;
 	/* 
 	 * This protects against truncating a file bigger than it was then
 	 * trying to write into the hole.
@@ -132,7 +135,7 @@
 	if (MSDOS_I(inode)->mmu_private > inode->i_size)
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
-	fat_free(inode,(inode->i_size+(cluster-1))>>sbi->cluster_bits);
+	fat_free(inode, (inode->i_size + (cluster - 1)) >> sbi->cluster_bits);
 	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
diff -urP linux-2.4.5-pre5/fs/fat/inode.c linux-2.4.5-pre5-fat/fs/fat/inode.c
--- linux-2.4.5-pre5/fs/fat/inode.c	Thu Apr 19 03:49:12 2001
+++ linux-2.4.5-pre5-fat/fs/fat/inode.c	Wed May 23 03:13:07 2001
@@ -201,7 +201,7 @@
 }
 
 
-static int parse_options(char *options,int *fat, int *blksize, int *debug,
+static int parse_options(char *options,int *fat, int *debug,
 			 struct fat_mount_options *opts,
 			 char *cvf_format, char *cvf_options)
 {
@@ -310,13 +310,8 @@
 			else opts->quiet = 1;
 		}
 		else if (!strcmp(this_char,"blocksize")) {
-			if (!value || !*value) ret = 0;
-			else {
-				*blksize = simple_strtoul(value,&value,0);
-				if (*value || (*blksize != 512 &&
-					*blksize != 1024 && *blksize != 2048))
-					ret = 0;
-			}
+			printk("FAT: blocksize option is obsolete, "
+			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"sys_immutable")) {
 			if (value) ret = 0;
@@ -383,8 +378,8 @@
 		MSDOS_I(inode)->i_start = sbi->root_cluster;
 		if ((nr = MSDOS_I(inode)->i_start) != 0) {
 			while (nr != -1) {
-				inode->i_size += SECTOR_SIZE*sbi->cluster_size;
-				if (!(nr = fat_access(sb,nr,-1))) {
+				inode->i_size += 1 << sbi->cluster_bits;
+				if (!(nr = fat_access(sb, nr, -1))) {
 					printk("Directory %ld: bad FAT\n",
 					       inode->i_ino);
 					break;
@@ -393,13 +388,11 @@
 		}
 	} else {
 		MSDOS_I(inode)->i_start = 0;
-		inode->i_size = sbi->dir_entries*
-			sizeof(struct msdos_dir_entry);
+		inode->i_size = sbi->dir_entries * sizeof(struct msdos_dir_entry);
 	}
-	inode->i_blksize = sbi->cluster_size* SECTOR_SIZE;
-	inode->i_blocks =
-		((inode->i_size+inode->i_blksize-1)>>sbi->cluster_bits) *
-		    sbi->cluster_size;
+	inode->i_blksize = 1 << sbi->cluster_bits;
+	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
+			   & ~(inode->i_blksize - 1)) / 512;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -432,10 +425,9 @@
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	char *p;
-	int data_sectors,logical_sector_size,sector_mult,fat_clusters=0;
-	int debug,error,fat,cp;
-	int blksize;
-	int fat32;
+	int logical_sector_size, hard_blksize, fat_clusters = 0;
+	unsigned int total_sectors, rootdir_sectors;
+	int fat32, debug, error, fat, cp;
 	struct fat_mount_options opts;
 	char buf[50];
 	int i;
@@ -451,35 +443,26 @@
 
 	sb->s_maxbytes = MAX_NON_LFS;
 	sb->s_op = &fat_sops;
-	blksize = get_hardsect_size(sb->s_dev);
-	if (!blksize)
-		blksize = 512;
-	if (blksize != 512)
-		printk ("MSDOS: Hardware sector size is %d\n",blksize);
+
+	hard_blksize = get_hardsect_size(sb->s_dev);
+	if (!hard_blksize)
+		hard_blksize = 512;
+	if (hard_blksize != 512)
+		printk("MSDOS: Hardware sector size is %d\n", hard_blksize);
 
 	opts.isvfat = sbi->options.isvfat;
-	if (!parse_options((char *) data, &fat, &blksize, &debug, &opts, 
-			   cvf_format, cvf_options)
-	    || (blksize != 512 && blksize != 1024 && blksize != 2048))
+	if (!parse_options((char *) data, &fat, &debug, &opts,
+			   cvf_format, cvf_options))
 		goto out_fail;
 	/* N.B. we should parse directly into the sb structure */
 	memcpy(&(sbi->options), &opts, sizeof(struct fat_mount_options));
 
 	fat_cache_init();
-	if( blksize > 1024 )
-	  {
-	    /* Force the superblock to a larger size here. */
-	    sb->s_blocksize = blksize;
-	    set_blocksize(sb->s_dev, blksize);
-	  }
-	else
-	  {
-	    /* The first read is always 1024 bytes */
-	    sb->s_blocksize = 1024;
-	    set_blocksize(sb->s_dev, 1024);
-	  }
+
+	sb->s_blocksize = hard_blksize;
+	set_blocksize(sb->s_dev, hard_blksize);
 	bh = bread(sb->s_dev, 0, sb->s_blocksize);
-	if (bh == NULL || !buffer_uptodate(bh)) {
+	if (bh == NULL) {
 		brelse (bh);
 		goto out_no_bread;
 	}
@@ -499,110 +482,122 @@
  * (by Drew Eckhardt)
  */
 
-#define ROUND_TO_MULTIPLE(n,m) ((n) && (m) ? (n)+(m)-1-((n)-1)%(m) : 0)
-    /* don't divide by zero */
 
 	b = (struct fat_boot_sector *) bh->b_data;
 	logical_sector_size =
 		CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
-	sector_mult = logical_sector_size >> SECTOR_BITS;
-	sbi->cluster_size = b->cluster_size*sector_mult;
-	if (!sbi->cluster_size || (sbi->cluster_size & (sbi->cluster_size-1))) {
-		printk("fatfs: bogus cluster size\n");
+	if (!logical_sector_size
+	    || (logical_sector_size & (logical_sector_size - 1))) {
+		printk("fatfs: bogus logical sector size %d\n",
+		       logical_sector_size);
+		brelse(bh);
+		goto out_invalid;
+	}
+
+	sbi->cluster_size = b->cluster_size;
+	if (!sbi->cluster_size || (sbi->cluster_size & (sbi->cluster_size - 1))) {
+		printk("fatfs: bogus cluster size %d\n", sbi->cluster_size);
 		brelse(bh);
 		goto out_invalid;
 	}
-	for (sbi->cluster_bits=0;
-	     1<<sbi->cluster_bits<sbi->cluster_size;
-	     sbi->cluster_bits++)
-		;
-	sbi->cluster_bits += SECTOR_BITS;
+
+	sbi->cluster_bits = ffs(logical_sector_size * sbi->cluster_size) - 1;
 	sbi->fats = b->fats;
-	sbi->fat_start = CF_LE_W(b->reserved)*sector_mult;
+	sbi->fat_start = CF_LE_W(b->reserved);
 	if (!b->fat_length && b->fat32_length) {
 		struct fat_boot_fsinfo *fsinfo;
+		struct buffer_head *fsinfo_bh;
+		int fsinfo_block, fsinfo_offset;
 
 		/* Must be FAT32 */
 		fat32 = 1;
-		sbi->fat_length= CF_LE_L(b->fat32_length)*sector_mult;
+		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
 
+		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		/* MC - if info_sector is 0, don't multiply by 0 */
-		if(CF_LE_W(b->info_sector) == 0) {
-			sbi->fsinfo_offset =
-	 			logical_sector_size + 0x1e0;
-		} else {
-			sbi->fsinfo_offset =
-				(CF_LE_W(b->info_sector) * logical_sector_size)
-				+ 0x1e0;
-		}
-		if (sbi->fsinfo_offset + sizeof(struct fat_boot_fsinfo) > sb->s_blocksize) {
-			printk("fat_read_super: Bad fsinfo_offset\n");
-			brelse(bh);
-			goto out_invalid;
-		}
-		fsinfo = (struct fat_boot_fsinfo *)
-			&bh->b_data[sbi->fsinfo_offset];
-		if (CF_LE_L(fsinfo->signature) != 0x61417272) {
-			printk("fat_read_super: Did not find valid FSINFO "
-				"signature. Found 0x%x\n",
-				CF_LE_L(fsinfo->signature));
+		if (sbi->fsinfo_sector == 0)
+			sbi->fsinfo_sector = 1;
+
+		fsinfo_block =
+			(sbi->fsinfo_sector * logical_sector_size) / hard_blksize;
+		fsinfo_offset =
+			(sbi->fsinfo_sector * logical_sector_size) % hard_blksize;
+		fsinfo_bh = bh;
+		if (bh->b_blocknr != fsinfo_block) {
+			fsinfo_bh = bread(sb->s_dev, fsinfo_block, hard_blksize);
+			if (fsinfo_bh == NULL) {
+				printk("FAT: bread failed, fsinfo block %d\n",
+				       fsinfo_block);
+				brelse(bh);
+				goto out_invalid;
+			}
+		}
+		fsinfo = (struct fat_boot_fsinfo *)&fsinfo_bh->b_data[fsinfo_offset];
+		if (!IS_FSINFO(fsinfo)) {
+			printk("FAT: Did not find valid FSINFO signature.\n"
+			       "Found signature1 0x%x signature2 0x%x sector=%ld.\n",
+			       CF_LE_L(fsinfo->signature1),
+			       CF_LE_L(fsinfo->signature2),
+			       sbi->fsinfo_sector);
 		} else {
 			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
 		}
+
+		if (bh->b_blocknr != fsinfo_block)
+			brelse(fsinfo_bh);
 	} else {
 		fat32 = 0;
-		sbi->fat_length = CF_LE_W(b->fat_length)*sector_mult;
+		sbi->fat_length = CF_LE_W(b->fat_length);
 		sbi->root_cluster = 0;
 		sbi->free_clusters = -1; /* Don't know yet */
 	}
-	sbi->dir_start= CF_LE_W(b->reserved)*sector_mult+
-	    b->fats*sbi->fat_length;
+
+	sbi->dir_per_block = logical_sector_size / sizeof(struct msdos_dir_entry);
+	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
+
+	sbi->dir_start = sbi->fat_start + sbi->fats * sbi->fat_length;
 	sbi->dir_entries =
-		CF_LE_W(get_unaligned((unsigned short *) &b->dir_entries));
-	sbi->data_start = sbi->dir_start+ROUND_TO_MULTIPLE((
-	    sbi->dir_entries << MSDOS_DIR_BITS) >> SECTOR_BITS,
-	    sector_mult);
-	data_sectors = CF_LE_W(get_unaligned((unsigned short *) &b->sectors));
-	if (!data_sectors) {
-		data_sectors = CF_LE_L(b->total_sect);
-	}
-	data_sectors = data_sectors * sector_mult - sbi->data_start;
-	error = !b->cluster_size || !sector_mult;
+		CF_LE_W(get_unaligned((unsigned short *)&b->dir_entries));
+	rootdir_sectors = sbi->dir_entries
+		* sizeof(struct msdos_dir_entry) / logical_sector_size;
+	sbi->data_start = sbi->dir_start + rootdir_sectors;
+	total_sectors = CF_LE_W(get_unaligned((unsigned short *)&b->sectors));
+	if (total_sectors == 0)
+		total_sectors = CF_LE_L(b->total_sect);
+	sbi->clusters = (total_sectors - sbi->data_start) / sbi->cluster_size;
+
+	error = 0;
 	if (!error) {
-		sbi->clusters = b->cluster_size ? data_sectors/
-		    b->cluster_size/sector_mult : 0;
 		sbi->fat_bits = fat32 ? 32 :
 			(fat ? fat :
 			 (sbi->clusters > MSDOS_FAT12 ? 16 : 12));
-		fat_clusters = sbi->fat_length*SECTOR_SIZE*8/
-		    sbi->fat_bits;
-		error = !sbi->fats || (sbi->dir_entries &
-		    (MSDOS_DPS-1)) || sbi->clusters+2 > fat_clusters+
-		    MSDOS_MAX_EXTRA || (logical_sector_size & (SECTOR_SIZE-1))
-		    || !b->secs_track || !b->heads;
+		fat_clusters =
+			sbi->fat_length * logical_sector_size * 8 / sbi->fat_bits;
+		error = !sbi->fats || (sbi->dir_entries & (sbi->dir_per_block - 1))
+			|| sbi->clusters + 2 > fat_clusters + MSDOS_MAX_EXTRA
+			|| logical_sector_size < 512
+			|| PAGE_CACHE_SIZE < logical_sector_size
+			|| !b->secs_track || !b->heads;
 	}
 	brelse(bh);
-	set_blocksize(sb->s_dev, blksize);
-	/*
-		This must be done after the brelse because the bh is a dummy
-		allocated by fat_bread (see buffer.c)
-	*/
-	sb->s_blocksize = blksize;    /* Using this small block size solves */
-				/* the misfit with buffer cache and cluster */
-				/* because clusters (DOS) are often aligned */
-				/* on odd sectors. */
-	sb->s_blocksize_bits = blksize == 512 ? 9 : (blksize == 1024 ? 10 : 11);
+
+	sb->s_blocksize = logical_sector_size;
+	sb->s_blocksize_bits = ffs(logical_sector_size) - 1;
+	if (sb->s_blocksize >= hard_blksize) {
+		set_blocksize(sb->s_dev, sb->s_blocksize);
+		sbi->cvf_format = &default_cvf;
+	} else {
+		set_blocksize(sb->s_dev, hard_blksize);
+		sbi->cvf_format = &bigblock_cvf;
+	}
+
 	if (!strcmp(cvf_format,"none"))
 		i = -1;
 	else
 		i = detect_cvf(sb,cvf_format);
 	if (i >= 0)
 		error = cvf_formats[i]->mount_cvf(sb,cvf_options);
-	else if (sb->s_blocksize == 512)
-		sbi->cvf_format = &default_cvf;
-	else
-		sbi->cvf_format = &bigblock_cvf;
 	if (error || debug) {
 		/* The MSDOS_CAN_BMAP is obsolete, but left just to remember */
 		printk("[MS-DOS FS Rel. 12,FAT %d,check=%c,conv=%c,"
@@ -612,18 +607,19 @@
 		       MSDOS_CAN_BMAP(sbi) ? ",bmap" : "");
 		printk("[me=0x%x,cs=%d,#f=%d,fs=%d,fl=%ld,ds=%ld,de=%d,data=%ld,"
 		       "se=%d,ts=%ld,ls=%d,rc=%ld,fc=%u]\n",
-			b->media,sbi->cluster_size,
-			sbi->fats,sbi->fat_start,
-			sbi->fat_length,
+		       b->media,sbi->cluster_size,
+		       sbi->fats,sbi->fat_start,
+		       sbi->fat_length,
 		       sbi->dir_start,sbi->dir_entries,
 		       sbi->data_start,
 		       CF_LE_W(*(unsigned short *) &b->sectors),
 		       (unsigned long)b->total_sect,logical_sector_size,
 		       sbi->root_cluster,sbi->free_clusters);
-		printk ("Transaction block size = %d\n",blksize);
+		printk ("Transaction block size = %d\n", hard_blksize);
 	}
-	if (i<0) if (sbi->clusters+2 > fat_clusters)
-		sbi->clusters = fat_clusters-2;
+	if (i < 0)
+		if (sbi->clusters + 2 > fat_clusters)
+			sbi->clusters = fat_clusters - 2;
 	if (error)
 		goto out_invalid;
 
@@ -692,7 +688,7 @@
 	}
 	if(sbi->private_data)
 		kfree(sbi->private_data);
-	sbi->private_data=NULL;
+	sbi->private_data = NULL;
  
 	return NULL;
 }
@@ -717,7 +713,7 @@
 	}
 	unlock_fat(sb);
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = MSDOS_SB(sb)->cluster_size*SECTOR_SIZE;
+	buf->f_bsize = 1 << MSDOS_SB(sb)->cluster_bits;
 	buf->f_blocks = MSDOS_SB(sb)->clusters;
 	buf->f_bfree = free;
 	buf->f_bavail = free;
@@ -796,8 +792,8 @@
 #endif
 		if ((nr = MSDOS_I(inode)->i_start) != 0)
 			while (nr != -1) {
-				inode->i_size += SECTOR_SIZE*sbi->cluster_size;
-				if (!(nr = fat_access(sb,nr,-1))) {
+				inode->i_size += 1 << sbi->cluster_bits;
+				if (!(nr = fat_access(sb, nr, -1))) {
 					printk("Directory %ld: bad FAT\n",
 					    inode->i_ino);
 					break;
@@ -828,12 +824,11 @@
 			inode->i_flags |= S_IMMUTABLE;
 	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
 	/* this is as close to the truth as we can get ... */
-	inode->i_blksize = sbi->cluster_size*SECTOR_SIZE;
-	inode->i_blocks =
-		((inode->i_size+inode->i_blksize-1)>>sbi->cluster_bits) *
-		sbi->cluster_size;
+	inode->i_blksize = 1 << sbi->cluster_bits;
+	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
+			   & ~(inode->i_blksize - 1)) / 512;
 	inode->i_mtime = inode->i_atime =
-	    date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
+		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_ctime =
 		MSDOS_SB(sb)->options.isvfat
 		? date_dos2unix(CF_LE_W(de->ctime),CF_LE_W(de->cdate))
@@ -854,7 +849,7 @@
 		return;
 	}
 	lock_kernel();
-	if (!(bh = fat_bread(sb, i_pos >> MSDOS_DPB_BITS))) {
+	if (!(bh = fat_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
 		printk("dev = %s, ino = %d\n", kdevname(inode->i_dev), i_pos);
 		fat_fs_panic(sb, "msdos_write_inode: unable to read i-node block");
 		unlock_kernel();
@@ -869,7 +864,7 @@
 	}
 
 	raw_entry = &((struct msdos_dir_entry *) (bh->b_data))
-	    [i_pos & (MSDOS_DPB-1)];
+	    [i_pos & (MSDOS_SB(sb)->dir_per_block - 1)];
 	if (S_ISDIR(inode->i_mode)) {
 		raw_entry->attr = ATTR_DIR;
 		raw_entry->size = 0;
diff -urP linux-2.4.5-pre5/fs/fat/misc.c linux-2.4.5-pre5-fat/fs/fat/misc.c
--- linux-2.4.5-pre5/fs/fat/misc.c	Wed Sep  6 06:07:29 2000
+++ linux-2.4.5-pre5-fat/fs/fat/misc.c	Wed May 16 02:52:48 2001
@@ -108,24 +108,22 @@
 /* XXX: Need to write one per FSINFO block.  Currently only writes 1 */
 void fat_clusters_flush(struct super_block *sb)
 {
-	int offset;
 	struct buffer_head *bh;
 	struct fat_boot_fsinfo *fsinfo;
 
-	/* The fat32 boot fs info is at offset 0x3e0 by observation */
-	offset = MSDOS_SB(sb)->fsinfo_offset;
-	bh = fat_bread(sb, (offset >> SECTOR_BITS));
+	bh = fat_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
 	if (bh == NULL) {
 		printk("FAT bread failed in fat_clusters_flush\n");
 		return;
 	}
-	fsinfo = (struct fat_boot_fsinfo *)
-		&bh->b_data[offset & (SECTOR_SIZE-1)];
 
+	fsinfo = (struct fat_boot_fsinfo *)bh->b_data;
 	/* Sanity check */
-	if (CF_LE_L(fsinfo->signature) != 0x61417272) {
-		printk("fat_clusters_flush: Did not find valid FSINFO signature. Found 0x%x.  offset=0x%x\n", CF_LE_L(fsinfo->signature), offset);
-		fat_brelse(sb, bh);
+	if (!IS_FSINFO(fsinfo)) {
+		printk("FAT: Did not find valid FSINFO signature.\n"
+		       "Found signature1 0x%x signature2 0x%x sector=%ld.\n",
+		       CF_LE_L(fsinfo->signature1), CF_LE_L(fsinfo->signature2),
+		       MSDOS_SB(sb)->fsinfo_sector);
 		return;
 	}
 	fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
@@ -145,7 +143,6 @@
 	struct super_block *sb = inode->i_sb;
 	int count,nr,limit,last,curr,file_cluster;
 	int res = -ENOSPC;
-	int cluster_size = MSDOS_SB(sb)->cluster_size;
 
 	if (!MSDOS_SB(sb)->free_clusters) return res;
 	lock_fat(sb);
@@ -167,7 +164,7 @@
 	if (MSDOS_SB(sb)->fat_bits == 32)
 		fat_clusters_flush(sb);
 	unlock_fat(sb);
-	last = 0;
+
 	/* We must locate the last cluster of the file to add this
 	   new one (nr) to the end of the link list (the FAT).
 	   
@@ -178,7 +175,7 @@
 	   use last to plug the nr cluster. We will use file_cluster to
 	   update the cache.
 	*/
-	file_cluster = 0;
+	last = file_cluster = 0;
 	if ((curr = MSDOS_I(inode)->i_start) != 0) {
 		fat_cache_lookup(inode,INT_MAX,&last,&curr);
 		file_cluster = last;
@@ -190,14 +187,15 @@
 			}
 		}
 	}
-	if (last) fat_access(sb,last,nr);
-	else {
+	if (last) {
+		fat_access(sb, last, nr);
+		fat_cache_add(inode, file_cluster, nr);
+	} else {
 		MSDOS_I(inode)->i_start = nr;
 		MSDOS_I(inode)->i_logstart = nr;
 		mark_inode_dirty(inode);
 	}
-	fat_cache_add(inode,file_cluster,nr);
-	inode->i_blocks += cluster_size;
+	inode->i_blocks += (1 << MSDOS_SB(sb)->cluster_bits) / 512;
 	return 0;
 }
 
@@ -209,36 +207,44 @@
 	int cluster_size = MSDOS_SB(sb)->cluster_size;
 
 	if (MSDOS_SB(sb)->fat_bits != 32) {
-		if (inode->i_ino == MSDOS_ROOT_INO) return res;
+		if (inode->i_ino == MSDOS_ROOT_INO)
+			return res;
 	}
-	if (!MSDOS_SB(sb)->free_clusters) return res;
+	if (!MSDOS_SB(sb)->free_clusters)
+		return res;
+
 	lock_fat(sb);
+
 	limit = MSDOS_SB(sb)->clusters;
 	nr = limit; /* to keep GCC happy */
 	for (count = 0; count < limit; count++) {
-		nr = ((count+MSDOS_SB(sb)->prev_free) % limit)+2;
-		if (fat_access(sb,nr,-1) == 0) break;
+		nr = ((count + MSDOS_SB(sb)->prev_free) % limit) + 2;
+		if (fat_access(sb, nr, -1) == 0)
+			break;
 	}
-	PRINTK (("cnt = %d --",count));
+	PRINTK (("cnt = %d --", count));
 #ifdef DEBUG
-printk("free cluster: %d\n",nr);
+	printk("free cluster: %d\n", nr);
 #endif
-	MSDOS_SB(sb)->prev_free = (count+MSDOS_SB(sb)->prev_free+1) % limit;
 	if (count >= limit) {
 		MSDOS_SB(sb)->free_clusters = 0;
 		unlock_fat(sb);
 		return res;
 	}
-	fat_access(sb,nr,EOF_FAT(sb));
+
+	MSDOS_SB(sb)->prev_free = (count + MSDOS_SB(sb)->prev_free + 1) % limit;
+	fat_access(sb, nr, EOF_FAT(sb));
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		MSDOS_SB(sb)->free_clusters--;
 	if (MSDOS_SB(sb)->fat_bits == 32)
 		fat_clusters_flush(sb);
+
 	unlock_fat(sb);
+
 #ifdef DEBUG
-printk("set to %x\n",fat_access(sb,nr,-1));
+	printk("set to %x\n", fat_access(sb, nr, -1));
 #endif
-	last = 0;
+
 	/* We must locate the last cluster of the file to add this
 	   new one (nr) to the end of the link list (the FAT).
 	   
@@ -249,15 +255,14 @@
 	   use last to plug the nr cluster. We will use file_cluster to
 	   update the cache.
 	*/
-	file_cluster = 0;
+	last = file_cluster = 0;
 	if ((curr = MSDOS_I(inode)->i_start) != 0) {
-		fat_cache_lookup(inode,INT_MAX,&last,&curr);
+		fat_cache_lookup(inode, INT_MAX, &last, &curr);
 		file_cluster = last;
 		while (curr && curr != -1){
 			PRINTK (("."));
 			file_cluster++;
-			if (!(curr = fat_access(sb,
-			    last = curr,-1))) {
+			if (!(curr = fat_access(sb, last = curr, -1))) {
 				fat_fs_panic(sb,"File without EOF");
 				return res;
 			}
@@ -265,53 +270,57 @@
 		PRINTK ((" --  "));
 	}
 #ifdef DEBUG
-printk("last = %d\n",last);
+	printk("last = %d\n", last);
 #endif
-	if (last) fat_access(sb,last,nr);
+	if (last)
+		fat_access(sb, last, nr);
 	else {
 		MSDOS_I(inode)->i_start = nr;
 		MSDOS_I(inode)->i_logstart = nr;
 		mark_inode_dirty(inode);
 	}
 #ifdef DEBUG
-if (last) printk("next set to %d\n",fat_access(sb,last,-1));
+	if (last)
+		printk("next set to %d\n",fat_access(sb, last, -1));
 #endif
-	sector = MSDOS_SB(sb)->data_start+(nr-2)*cluster_size;
+	sector = MSDOS_SB(sb)->data_start + (nr - 2) * cluster_size;
 	last_sector = sector + cluster_size;
-	if (MSDOS_SB(sb)->cvf_format &&
-	    MSDOS_SB(sb)->cvf_format->zero_out_cluster)
-		MSDOS_SB(sb)->cvf_format->zero_out_cluster(inode,nr);
-	else
-	for ( ; sector < last_sector; sector++) {
-		#ifdef DEBUG
-			printk("zeroing sector %d\n",sector);
-		#endif
-		if (!(bh = fat_getblk(sb, sector)))
-			printk("getblk failed\n");
-		else {
-			memset(bh->b_data,0,SECTOR_SIZE);
-			fat_set_uptodate(sb, bh, 1);
-			fat_mark_buffer_dirty(sb, bh);
-			if (!res)
-				res=bh;
-			else
-				fat_brelse(sb, bh);
+	if (MSDOS_SB(sb)->cvf_format && MSDOS_SB(sb)->cvf_format->zero_out_cluster)
+		MSDOS_SB(sb)->cvf_format->zero_out_cluster(inode, nr);
+	else {
+		for ( ; sector < last_sector; sector++) {
+#ifdef DEBUG
+			printk("zeroing sector %d\n", sector);
+#endif
+			if (!(bh = fat_getblk(sb, sector)))
+				printk("getblk failed\n");
+			else {
+				memset(bh->b_data, 0, sb->s_blocksize);
+				fat_set_uptodate(sb, bh, 1);
+				fat_mark_buffer_dirty(sb, bh);
+				if (!res)
+					res = bh;
+				else
+					fat_brelse(sb, bh);
+			}
 		}
 	}
-	if (file_cluster != inode->i_blocks/cluster_size){
-		printk ("file_cluster badly computed!!! %d <> %ld\n"
-			,file_cluster,inode->i_blocks/cluster_size);
+	if (file_cluster
+	    != inode->i_blocks / cluster_size / (sb->s_blocksize / 512)) {
+		printk ("file_cluster badly computed!!! %d <> %ld\n",
+			file_cluster,
+			inode->i_blocks / cluster_size / (sb->s_blocksize / 512));
 	}else{
-		fat_cache_add(inode,file_cluster,nr);
+		fat_cache_add(inode, file_cluster, nr);
 	}
-	inode->i_blocks += cluster_size;
-	if (inode->i_size & (SECTOR_SIZE-1)) {
-		fat_fs_panic(sb,"Odd directory size");
-		inode->i_size = (inode->i_size+SECTOR_SIZE) &
-		    ~(SECTOR_SIZE-1);
+	inode->i_blocks += (1 << MSDOS_SB(sb)->cluster_bits) / 512;
+	if (inode->i_size & (sb->s_blocksize - 1)) {
+		fat_fs_panic(sb, "Odd directory size");
+		inode->i_size = (inode->i_size + sb->s_blocksize) &
+			~(sb->s_blocksize - 1);
 	}
-	inode->i_size += SECTOR_SIZE*cluster_size;
-	MSDOS_I(inode)->mmu_private += SECTOR_SIZE*cluster_size;
+	inode->i_size += 1 << MSDOS_SB(sb)->cluster_bits;
+	MSDOS_I(inode)->mmu_private += 1 << MSDOS_SB(sb)->cluster_bits;
 	mark_inode_dirty(inode);
 	return res;
 }
@@ -386,6 +395,7 @@
     struct msdos_dir_entry **de, int *ino)
 {
 	struct super_block *sb = dir->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int sector, offset;
 
 	while (1) {
@@ -394,7 +404,7 @@
 		if (*bh)
 			fat_brelse(sb, *bh);
 		*bh = NULL;
-		if ((sector = fat_bmap(dir,offset >> SECTOR_BITS)) == -1)
+		if ((sector = fat_bmap(dir,offset >> sb->s_blocksize_bits)) == -1)
 			return -1;
 		PRINTK (("get_entry sector %d %p\n",sector,*bh));
 		PRINTK (("get_entry sector apres brelse\n"));
@@ -406,10 +416,11 @@
 			continue;
 		}
 		PRINTK (("get_entry apres sread\n"));
-		*de = (struct msdos_dir_entry *) ((*bh)->b_data+(offset &
-		    (SECTOR_SIZE-1)));
-		*ino = (sector << MSDOS_DPS_BITS)+((offset & (SECTOR_SIZE-1)) >>
-		    MSDOS_DIR_BITS);
+
+		offset &= sb->s_blocksize - 1;
+		*de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
+		*ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
+
 		return 0;
 	}
 }
@@ -476,7 +487,7 @@
 	if (!(bh = fat_bread(sb,sector)))
 		return -EIO;
 	data = (struct msdos_dir_entry *) bh->b_data;
-	for (entry = 0; entry < MSDOS_DPS; entry++) {
+	for (entry = 0; entry < MSDOS_SB(sb)->dir_per_block; entry++) {
 /* RSS_COUNT:  if (data[entry].name == name) done=true else done=false. */
 		if (name) {
 			RSS_NAME
@@ -488,7 +499,8 @@
 			}
 		}
 		if (done) {
-			if (ino) *ino = sector*MSDOS_DPS+entry;
+			if (ino)
+				*ino = sector * MSDOS_SB(sb)->dir_per_block + entry;
 			start = CF_LE_W(data[entry].start);
 			if (MSDOS_SB(sb)->fat_bits == 32) {
 				start |= (CF_LE_W(data[entry].starthi) << 16);
@@ -517,9 +529,12 @@
 {
 	int count,cluster;
 
-	for (count = 0; count < MSDOS_SB(sb)->dir_entries/MSDOS_DPS; count++) {
+	for (count = 0;
+	     count < MSDOS_SB(sb)->dir_entries / MSDOS_SB(sb)->dir_per_block;
+	     count++) {
 		if ((cluster = raw_scan_sector(sb,MSDOS_SB(sb)->dir_start+count,
-		    name,number,ino,res_bh,res_de)) >= 0) return cluster;
+					       name,number,ino,res_bh,res_de)) >= 0)
+			return cluster;
 	}
 	return -ENOENT;
 }
@@ -570,13 +585,12 @@
     int *number, int *ino, struct buffer_head **res_bh,
     struct msdos_dir_entry **res_de)
 {
-	if (start) return raw_scan_nonroot
-		(sb,start,name,number,ino,res_bh,res_de);
-	else return raw_scan_root
-		(sb,name,number,ino,res_bh,res_de);
+	if (start)
+		return raw_scan_nonroot(sb,start,name,number,ino,res_bh,res_de);
+	else
+		return raw_scan_root(sb,name,number,ino,res_bh,res_de);
 }
 
-
 /*
  * fat_parent_ino returns the inode number of the parent directory of dir.
  * File creation has to be deferred while fat_parent_ino is running to
@@ -627,7 +641,6 @@
 	if (!locked) fat_unlock_creation();
 	return nr;
 }
-
 
 /*
  * fat_subdirs counts the number of sub-directories of dir. It can be run
diff -urP linux-2.4.5-pre5/include/linux/msdos_fs.h linux-2.4.5-pre5-fat/include/linux/msdos_fs.h
--- linux-2.4.5-pre5/include/linux/msdos_fs.h	Thu May 24 03:35:25 2001
+++ linux-2.4.5-pre5-fat/include/linux/msdos_fs.h	Mon May 21 00:27:46 2001
@@ -76,6 +76,11 @@
 #define EOF_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? EOF_FAT32 : \
 	MSDOS_SB(s)->fat_bits == 16 ? EOF_FAT16 : EOF_FAT12)
 
+#define FAT_FSINFO_SIG1		0x41615252
+#define FAT_FSINFO_SIG2		0x61417272
+#define IS_FSINFO(x)		(CF_LE_L((x)->signature1) == FAT_FSINFO_SIG1	 \
+				 && CF_LE_L((x)->signature2) == FAT_FSINFO_SIG2)
+
 /*
  * Inode flags
  */
@@ -127,8 +132,9 @@
 };
 
 struct fat_boot_fsinfo {
-	__u32   reserved1;	/* Nothing as far as I can tell */
-	__u32   signature;	/* 0x61417272L */
+	__u32   signature1;	/* 0x61417272L */
+	__u32   reserved1[120];	/* Nothing as far as I can tell */
+	__u32   signature2;	/* 0x61417272L */
 	__u32   free_clusters;	/* Free cluster count.  -1 if unknown */
 	__u32   next_cluster;	/* Most recently allocated cluster.
 				 * Unused under Linux. */
@@ -208,7 +214,7 @@
 {
 	/* Fast stuff first */
 	if (*bh && *de &&
-	    	(*de - (struct msdos_dir_entry *)(*bh)->b_data) < MSDOS_DPB-1) {
+	    (*de - (struct msdos_dir_entry *)(*bh)->b_data) < MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
 		*pos += sizeof(struct msdos_dir_entry);
 		(*de)++;
 		(*ino)++;
diff -urP linux-2.4.5-pre5/include/linux/msdos_fs_sb.h linux-2.4.5-pre5-fat/include/linux/msdos_fs_sb.h
--- linux-2.4.5-pre5/include/linux/msdos_fs_sb.h	Wed Sep  6 06:53:04 2000
+++ linux-2.4.5-pre5-fat/include/linux/msdos_fs_sb.h	Tue May 15 02:37:47 2001
@@ -44,7 +44,7 @@
 	unsigned long data_start;    /* first data sector */
 	unsigned long clusters;      /* number of clusters */
 	unsigned long root_cluster;  /* first cluster of the root directory */
-	unsigned long fsinfo_offset; /* FAT32 fsinfo offset from start of disk */
+	unsigned long fsinfo_sector; /* FAT32 fsinfo offset from start of disk */
 	wait_queue_head_t fat_wait;
 	struct semaphore fat_lock;
 	int prev_free;               /* previously returned free cluster number */
@@ -54,7 +54,9 @@
 	struct nls_table *nls_io;    /* Charset used for input and display */
 	struct cvf_format* cvf_format;
 	void *dir_ops;		     /* Opaque; default directory operations */
-	void *private_data;	
+	void *private_data;
+	int dir_per_block;	     /* dir entries per block */
+	int dir_per_block_bits;	     /* log2(dir_per_block) */
 };
 
 #endif

