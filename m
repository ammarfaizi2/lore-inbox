Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317453AbSFIEc5>; Sun, 9 Jun 2002 00:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSFIEc4>; Sun, 9 Jun 2002 00:32:56 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:1803 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317453AbSFIEcz>; Sun, 9 Jun 2002 00:32:55 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090247.g592lR3471572@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 13:32:43 +0900
Message-ID: <87hekddqc4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, my previous miss email.

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> This get rid of the old byte order macros.
> 
> diff -Naurd old/fs/fat/cache.c new/fs/fat/cache.c
> --- old/fs/fat/cache.c	Sun Jun  2 21:44:45 2002
> +++ new/fs/fat/cache.c	Sat Jun  8 17:25:48 2002
> @@ -67,13 +67,13 @@
>  	}
>  	if (sbi->fat_bits == 32) {
>  		p_first = p_last = NULL; /* GCC needs that stuff */
> -		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
> +		next = le32_to_cpu(((__u32 *) bh->b_data)[(first &
>  		    (sb->s_blocksize - 1)) >> 2]);

[...]

> -/*
> - * Conversion from and to little-endian byte order. (no-op on i386/i486)
> - *
> - * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
> - * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
> - */
> -
> -#define CF_LE_W(v) le16_to_cpu(v)
> -#define CF_LE_L(v) le32_to_cpu(v)
> -#define CT_LE_W(v) cpu_to_le16(v)
> -#define CT_LE_L(v) cpu_to_le32(v)

Personally I think this patch makes code readable. But please don't
remove Cx_LE_x macros. Cx_LE_x is used from dosfsck.

The following incrementale patch fixes above problem, and does trivial
cleanup.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.20/fs/fat/inode.c fat-byte_order/fs/fat/inode.c
--- linux-2.5.20/fs/fat/inode.c	Sun Jun  9 13:05:33 2002
+++ fat-byte_order/fs/fat/inode.c	Sun Jun  9 13:19:16 2002
@@ -711,8 +711,7 @@
 		brelse(bh);
 		goto out_invalid;
 	}
-	logical_sector_size =
-		le16_to_cpu(get_unaligned((unsigned short *) &b->sector_size));
+	logical_sector_size = le16_to_cpu(get_unaligned((u16*)&b->sector_size));
 	if (!logical_sector_size
 	    || (logical_sector_size & (logical_sector_size - 1))
 	    || (logical_sector_size < 512)
@@ -807,8 +806,7 @@
 	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
 
 	sbi->dir_start = sbi->fat_start + sbi->fats * sbi->fat_length;
-	sbi->dir_entries =
-		le16_to_cpu(get_unaligned((unsigned short *)&b->dir_entries));
+	sbi->dir_entries = le16_to_cpu(get_unaligned((u16 *)&b->dir_entries));
 	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
 		printk("FAT: bogus directroy-entries per block\n");
 		brelse(bh);
@@ -818,7 +816,7 @@
 	rootdir_sectors = sbi->dir_entries
 		* sizeof(struct msdos_dir_entry) / sb->s_blocksize;
 	sbi->data_start = sbi->dir_start + rootdir_sectors;
-	total_sectors = le16_to_cpu(get_unaligned((unsigned short *)&b->sectors));
+	total_sectors = le16_to_cpu(get_unaligned((u16 *)&b->sectors));
 	if (total_sectors == 0)
 		total_sectors = le32_to_cpu(b->total_sect);
 	sbi->clusters = (total_sectors - sbi->data_start) / sbi->cluster_size;
diff -urN linux-2.5.20/include/linux/msdos_fs.h fat-byte_order/include/linux/msdos_fs.h
--- linux-2.5.20/include/linux/msdos_fs.h	Sun Jun  9 13:05:34 2002
+++ fat-byte_order/include/linux/msdos_fs.h	Sun Jun  9 13:02:13 2002
@@ -13,6 +13,11 @@
 #define MSDOS_DPB_BITS	4		/* log2(MSDOS_DPB) */
 #define MSDOS_DPS	(SECTOR_SIZE / sizeof(struct msdos_dir_entry))
 #define MSDOS_DPS_BITS	4		/* log2(MSDOS_DPS) */
+#define CF_LE_W(v) le16_to_cpu(v)
+#define CF_LE_L(v) le32_to_cpu(v)
+#define CT_LE_W(v) cpu_to_le16(v)
+#define CT_LE_L(v) cpu_to_le32(v)
+
 
 #define MSDOS_ROOT_INO	1	/* == MINIX_ROOT_INO */
 #define MSDOS_DIR_BITS	5	/* log2(sizeof(struct msdos_dir_entry)) */
@@ -80,7 +85,7 @@
 
 #define FAT_FSINFO_SIG1		0x41615252
 #define FAT_FSINFO_SIG2		0x61417272
-#define IS_FSINFO(x)	(le32_to_cpu((x)->signature1) == FAT_FSINFO_SIG1	\
+#define IS_FSINFO(x)	(le32_to_cpu((x)->signature1) == FAT_FSINFO_SIG1 \
 			 && le32_to_cpu((x)->signature2) == FAT_FSINFO_SIG2)
 
 /*
