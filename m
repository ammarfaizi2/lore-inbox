Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289027AbSAMLIW>; Sun, 13 Jan 2002 06:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289029AbSAMLID>; Sun, 13 Jan 2002 06:08:03 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:48396 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S289027AbSAMLHm>; Sun, 13 Jan 2002 06:07:42 -0500
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fat_read_super() cleanup, and small bug fix
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Jan 2002 20:07:15 +0900
Message-ID: <878zb2h5lo.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a patch to FAT, and the change is the following.

    - don't support fat option. I think this option shouldn't use.
    - check the 4 fields instead of magick number. Then, if silent,
      don't output messages.
    - remove debug message. More useful message is outputted.
    - fixed bug in fat_clusters_flush().
    - output message of useing nls instead of specified nls.
    - cleanup.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.2-pre11/fs/fat/dir.c fat_read-super-cleanup/fs/fat/dir.c
--- linux-2.5.2-pre11/fs/fat/dir.c	Sat Oct 13 05:48:42 2001
+++ fat_read-super-cleanup/fs/fat/dir.c	Thu Nov 15 00:41:33 2001
@@ -538,7 +538,6 @@
 	if (!memcmp(de->name,MSDOS_DOT,11))
 		inum = inode->i_ino;
 	else if (!memcmp(de->name,MSDOS_DOTDOT,11)) {
-/*		inum = fat_parent_ino(inode,0); */
 		inum = filp->f_dentry->d_parent->d_inode->i_ino;
 	} else {
 		struct inode *tmp = fat_iget(sb, ino);
diff -urN linux-2.5.2-pre11/fs/fat/inode.c fat_read-super-cleanup/fs/fat/inode.c
--- linux-2.5.2-pre11/fs/fat/inode.c	Sun Jan 13 19:23:52 2002
+++ fat_read-super-cleanup/fs/fat/inode.c	Sun Jan 13 19:12:49 2002
@@ -208,7 +208,7 @@
 }
 
 
-static int parse_options(char *options,int *fat, int *debug,
+static int parse_options(char *options, int *debug,
 			 struct fat_mount_options *opts,
 			 char *cvf_format, char *cvf_options)
 {
@@ -227,7 +227,7 @@
 	opts->shortname = 0;
 	opts->utf8 = 0;
 	opts->iocharset = NULL;
-	*debug = *fat = 0;
+	*debug = 0;
 
 	if (!options)
 		goto out;
@@ -305,13 +305,8 @@
 			else *debug = 1;
 		}
 		else if (!strcmp(this_char,"fat")) {
-			if (!value || !*value) ret = 0;
-			else {
-				*fat = simple_strtoul(value,&value,0);
-				if (*value || (*fat != 12 && *fat != 16 &&
-					       *fat != 32)) 
-					ret = 0;
-			}
+			printk("FAT: fat option is obsolete, "
+			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"quiet")) {
 			if (value) ret = 0;
@@ -328,8 +323,6 @@
 		else if (!strcmp(this_char,"codepage") && value) {
 			opts->codepage = simple_strtoul(value,&value,0);
 			if (*value) ret = 0;
-			else printk ("MSDOS FS: Using codepage %d\n",
-					opts->codepage);
 		}
 		else if (!strcmp(this_char,"iocharset") && value) {
 			p = value;
@@ -348,7 +341,6 @@
 					opts->iocharset = buffer;
 					memcpy(buffer, p, len);
 					buffer[len] = 0;
-					printk("MSDOS FS: IO charset %s\n", buffer);
 				} else
 					ret = 0;
 			}
@@ -550,11 +542,9 @@
 	struct buffer_head *bh;
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	char *p;
-	int logical_sector_size, hard_blksize, fat_clusters = 0;
+	int logical_sector_size, fat_clusters;
 	unsigned int total_sectors, rootdir_sectors;
-	int fat32, debug, error, fat, cp;
-	struct fat_mount_options opts;
+	int debug, cp;
 	char buf[50];
 	int i;
 	char cvf_format[21];
@@ -562,22 +552,20 @@
 
 	cvf_format[0] = '\0';
 	cvf_options[0] = '\0';
-	sbi->cvf_format = NULL;
 	sbi->private_data = NULL;
 
-	sbi->dir_ops = fs_dir_inode_ops;
-
-	sb->s_maxbytes = MAX_NON_LFS;
+	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
+	sbi->dir_ops = fs_dir_inode_ops;
+	sbi->cvf_format = &default_cvf;
 
-	opts.isvfat = sbi->options.isvfat;
-	if (!parse_options((char *) data, &fat, &debug, &opts,
+	if (!parse_options((char *)data, &debug, &sbi->options,
 			   cvf_format, cvf_options))
 		goto out_fail;
-	/* N.B. we should parse directly into the sb structure */
-	memcpy(&(sbi->options), &opts, sizeof(struct fat_mount_options));
 
 	fat_cache_init();
+	/* set up enough so that it can read an inode */
+	init_MUTEX(&sbi->fat_lock);
 
 	sb_min_blocksize(sb, 512);
 	bh = sb_bread(sb, 0);
@@ -586,37 +574,37 @@
 		goto out_fail;
 	}
 
-/*
- * The DOS3 partition size limit is *not* 32M as many people think.  
- * Instead, it is 64K sectors (with the usual sector size being
- * 512 bytes, leading to a 32M limit).
- * 
- * DOS 3 partition managers got around this problem by faking a 
- * larger sector size, ie treating multiple physical sectors as 
- * a single logical sector.
- * 
- * We can accommodate this scheme by adjusting our cluster size,
- * fat_start, and data_start by an appropriate value.
- *
- * (by Drew Eckhardt)
- */
-
-
 	b = (struct fat_boot_sector *) bh->b_data;
+	if (!b->secs_track) {
+		if (!silent)
+			printk("FAT: bogus sectors-per-track value\n");
+		brelse(bh);
+		goto out_invalid;
+	}
+	if (!b->heads) {
+		if (!silent)
+			printk("FAT: bogus number-of-heads value\n");
+		brelse(bh);
+		goto out_invalid;
+	}
 	logical_sector_size =
 		CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
 	if (!logical_sector_size
-	    || (logical_sector_size & (logical_sector_size - 1))) {
-		printk("FAT: bogus logical sector size %d\n",
-		       logical_sector_size);
+	    || (logical_sector_size & (logical_sector_size - 1))
+	    || (logical_sector_size < 512)
+	    || (PAGE_CACHE_SIZE < logical_sector_size)) {
+		if (!silent)
+			printk("FAT: bogus logical sector size %d\n",
+			       logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
 	}
-
 	sbi->cluster_size = b->cluster_size;
 	if (!sbi->cluster_size
 	    || (sbi->cluster_size & (sbi->cluster_size - 1))) {
-		printk("FAT: bogus cluster size %d\n", sbi->cluster_size);
+		if (!silent)
+			printk("FAT: bogus cluster size %d\n",
+			       sbi->cluster_size);
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -625,47 +613,62 @@
 		printk("FAT: logical sector size too small for device"
 		       " (logical sector size = %d)\n", logical_sector_size);
 		brelse(bh);
-		goto out_invalid;
+		goto out_fail;
 	}
+	if (logical_sector_size > sb->s_blocksize) {
+		brelse(bh);
 
-	hard_blksize = sb->s_blocksize;
+		if (!sb_set_blocksize(sb, logical_sector_size)) {
+			printk("FAT: unable to set blocksize %d\n",
+			       logical_sector_size);
+			goto out_fail;
+		}
+		bh = sb_bread(sb, 0);
+		if (bh == NULL) {
+			printk("FAT: unable to read boot sector"
+			       " (logical sector size = %lu)\n",
+			       sb->s_blocksize);
+			goto out_fail;
+		}
+		b = (struct fat_boot_sector *) bh->b_data;
+	}
 
-	sbi->cluster_bits = ffs(logical_sector_size * sbi->cluster_size) - 1;
+	sbi->cluster_bits = ffs(sb->s_blocksize * sbi->cluster_size) - 1;
 	sbi->fats = b->fats;
+	sbi->fat_bits = 0;		/* Don't know yet */
 	sbi->fat_start = CF_LE_W(b->reserved);
-	if (!b->fat_length && b->fat32_length) {
+	sbi->fat_length = CF_LE_W(b->fat_length);
+	sbi->root_cluster = 0;
+	sbi->free_clusters = -1;	/* Don't know yet */
+	sbi->prev_free = 0;
+
+	if (!sbi->fat_length && b->fat32_length) {
 		struct fat_boot_fsinfo *fsinfo;
 		struct buffer_head *fsinfo_bh;
-		int fsinfo_block, fsinfo_offset;
 
 		/* Must be FAT32 */
-		fat32 = 1;
+		sbi->fat_bits = 32;
 		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
 
-		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		/* MC - if info_sector is 0, don't multiply by 0 */
+		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		if (sbi->fsinfo_sector == 0)
 			sbi->fsinfo_sector = 1;
 
-		fsinfo_block =
-			(sbi->fsinfo_sector * logical_sector_size) / hard_blksize;
-		fsinfo_offset =
-			(sbi->fsinfo_sector * logical_sector_size) % hard_blksize;
-		fsinfo_bh = bh;
-		if (fsinfo_block != 0) {
-			fsinfo_bh = sb_bread(sb, fsinfo_block);
-			if (fsinfo_bh == NULL) {
-				printk("FAT: bread failed, FSINFO block"
-				       " (blocknr = %d)\n", fsinfo_block);
-				brelse(bh);
-				goto out_invalid;
-			}
+		fsinfo_bh = sb_bread(sb, sbi->fsinfo_sector);
+		if (fsinfo_bh == NULL) {
+			printk("FAT: bread failed, FSINFO block"
+			       " (sector = %lu)\n", sbi->fsinfo_sector);
+			brelse(bh);
+			goto out_fail;
 		}
-		fsinfo = (struct fat_boot_fsinfo *)&fsinfo_bh->b_data[fsinfo_offset];
+
+		fsinfo = (struct fat_boot_fsinfo *)fsinfo_bh->b_data;
 		if (!IS_FSINFO(fsinfo)) {
 			printk("FAT: Did not find valid FSINFO signature.\n"
-			       "Found signature1 0x%x signature2 0x%x sector=%ld.\n",
+			       "     Found signature1 0x%08x signature2 0x%08x"
+			       " (sector = %lu)\n",
 			       CF_LE_L(fsinfo->signature1),
 			       CF_LE_L(fsinfo->signature2),
 			       sbi->fsinfo_sector);
@@ -673,140 +676,110 @@
 			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
 		}
 
-		if (fsinfo_block != 0)
-			brelse(fsinfo_bh);
-	} else {
-		fat32 = 0;
-		sbi->fat_length = CF_LE_W(b->fat_length);
-		sbi->root_cluster = 0;
-		sbi->free_clusters = -1; /* Don't know yet */
+		brelse(fsinfo_bh);
 	}
 
-	sbi->dir_per_block = logical_sector_size / sizeof(struct msdos_dir_entry);
+	sbi->dir_per_block = sb->s_blocksize / sizeof(struct msdos_dir_entry);
 	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
 
 	sbi->dir_start = sbi->fat_start + sbi->fats * sbi->fat_length;
 	sbi->dir_entries =
 		CF_LE_W(get_unaligned((unsigned short *)&b->dir_entries));
+	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
+		printk("FAT: bogus directroy-entries per block\n");
+		brelse(bh);
+		goto out_invalid;
+	}
+
 	rootdir_sectors = sbi->dir_entries
-		* sizeof(struct msdos_dir_entry) / logical_sector_size;
+		* sizeof(struct msdos_dir_entry) / sb->s_blocksize;
 	sbi->data_start = sbi->dir_start + rootdir_sectors;
 	total_sectors = CF_LE_W(get_unaligned((unsigned short *)&b->sectors));
 	if (total_sectors == 0)
 		total_sectors = CF_LE_L(b->total_sect);
 	sbi->clusters = (total_sectors - sbi->data_start) / sbi->cluster_size;
 
-	error = 0;
-	if (!error) {
-		sbi->fat_bits = fat32 ? 32 :
-			(fat ? fat :
-			 (sbi->clusters > MSDOS_FAT12 ? 16 : 12));
-		fat_clusters =
-			sbi->fat_length * logical_sector_size * 8 / sbi->fat_bits;
-		error = !sbi->fats || (sbi->dir_entries & (sbi->dir_per_block - 1))
-			|| sbi->clusters + 2 > fat_clusters + MSDOS_MAX_EXTRA
-			|| logical_sector_size < 512
-			|| PAGE_CACHE_SIZE < logical_sector_size
-			|| !b->secs_track || !b->heads;
-	}
-	brelse(bh);
+	if (sbi->fat_bits != 32)
+		sbi->fat_bits = (sbi->clusters > MSDOS_FAT12) ? 16 : 12;
 
-	if (error)
-		goto out_invalid;
+	/* check that FAT table does not overflow */
+	fat_clusters = sbi->fat_length * sb->s_blocksize * 8 / sbi->fat_bits;
+	if (sbi->clusters > fat_clusters - 2)
+		sbi->clusters = fat_clusters - 2;
+
+	brelse(bh);
 
-	sb_set_blocksize(sb, logical_sector_size);
-	sbi->cvf_format = &default_cvf;
 	if (!strcmp(cvf_format, "none"))
 		i = -1;
 	else
-		i = detect_cvf(sb,cvf_format);
-	if (i >= 0)
-		error = cvf_formats[i]->mount_cvf(sb, cvf_options);
-	if (error || debug) {
-		/* The MSDOS_CAN_BMAP is obsolete, but left just to remember */
-		printk("[MS-DOS FS Rel. 12,FAT %d,check=%c,conv=%c,"
-		       "uid=%d,gid=%d,umask=%03o%s]\n",
-		       sbi->fat_bits,opts.name_check,
-		       opts.conversion,opts.fs_uid,opts.fs_gid,opts.fs_umask,
-		       MSDOS_CAN_BMAP(sbi) ? ",bmap" : "");
-		printk("[me=0x%x,cs=%d,#f=%d,fs=%d,fl=%ld,ds=%ld,de=%d,data=%ld,"
-		       "se=%u,ts=%u,ls=%d,rc=%ld,fc=%u]\n",
-		       b->media, sbi->cluster_size, sbi->fats,
-		       sbi->fat_start, sbi->fat_length, sbi->dir_start,
-		       sbi->dir_entries, sbi->data_start,
-		       CF_LE_W(get_unaligned((unsigned short *)&b->sectors)),
-		       CF_LE_L(b->total_sect), logical_sector_size,
-		       sbi->root_cluster, sbi->free_clusters);
-		printk ("hard sector size = %d\n", hard_blksize);
-	}
-	if (i < 0)
-		if (sbi->clusters + 2 > fat_clusters)
-			sbi->clusters = fat_clusters - 2;
-	if (error)
-		goto out_invalid;
-
-	sb->s_magic = MSDOS_SUPER_MAGIC;
-	/* set up enough so that it can read an inode */
-	init_MUTEX(&sbi->fat_lock);
-	sbi->prev_free = 0;
+		i = detect_cvf(sb, cvf_format);
+	if (i >= 0) {
+		if (cvf_formats[i]->mount_cvf(sb, cvf_options))
+			goto out_invalid;
+	}
 
-	cp = opts.codepage ? opts.codepage : 437;
+	cp = sbi->options.codepage ? sbi->options.codepage : 437;
 	sprintf(buf, "cp%d", cp);
 	sbi->nls_disk = load_nls(buf);
 	if (! sbi->nls_disk) {
 		/* Fail only if explicit charset specified */
-		if (opts.codepage != 0)
+		if (sbi->options.codepage != 0) {
+			printk("FAT: codepage %s not found\n", buf);
 			goto out_fail;
+		}
 		sbi->options.codepage = 0; /* already 0?? */
 		sbi->nls_disk = load_nls_default();
 	}
+	if (!silent)
+		printk("FAT: Using codepage %s\n", sbi->nls_disk->charset);
 
-	sbi->nls_io = NULL;
-	if (sbi->options.isvfat && !opts.utf8) {
-		p = opts.iocharset ? opts.iocharset : CONFIG_NLS_DEFAULT;
-		sbi->nls_io = load_nls(p);
-		if (! sbi->nls_io)
-			/* Fail only if explicit charset specified */
-			if (opts.iocharset)
-				goto out_unload_nls;
+	if (sbi->options.isvfat && !sbi->options.utf8) {
+		if (sbi->options.iocharset != NULL) {
+			sbi->nls_io = load_nls(sbi->options.iocharset);
+			if (!sbi->nls_io) {
+				printk("FAT: IO charset %s not found\n",
+				       sbi->options.iocharset);
+				goto out_fail;
+			}
+		} else
+			sbi->nls_io = load_nls_default();
+		if (!silent)
+			printk("FAT: Using IO charset %s\n",
+			       sbi->nls_io->charset);
 	}
-	if (! sbi->nls_io)
-		sbi->nls_io = load_nls_default();
 
 	root_inode = new_inode(sb);
 	if (!root_inode)
-		goto out_unload_nls;
+		goto out_fail;
+
 	root_inode->i_ino = MSDOS_ROOT_INO;
 	root_inode->i_version = 0;
 	fat_read_root(root_inode);
 	insert_inode_hash(root_inode);
 	sb->s_root = d_alloc_root(root_inode);
-	if (!sb->s_root)
-		goto out_no_root;
+	if (!sb->s_root) {
+		printk("FAT: get root inode failed\n");
+		iput(root_inode);
+		goto out_fail;
+	}
 	if(i >= 0) {
 		sbi->cvf_format = cvf_formats[i];
 		++cvf_format_use_count[i];
 	}
 	return sb;
 
-out_no_root:
-	printk("FAT: get root inode failed\n");
-	iput(root_inode);
-	unload_nls(sbi->nls_io);
-out_unload_nls:
-	unload_nls(sbi->nls_disk);
-	goto out_fail;
 out_invalid:
-	if (!silent) {
+	if (!silent)
 		printk("VFS: Can't find a valid FAT filesystem on dev %s.\n",
 			sb->s_id);
-	}
 out_fail:
-	if (opts.iocharset) {
-		printk("FAT: freeing iocharset=%s\n", opts.iocharset);
-		kfree(opts.iocharset);
-	}
-	if(sbi->private_data)
+	if (sbi->nls_io)
+		unload_nls(sbi->nls_io);
+	if (sbi->nls_disk)
+		unload_nls(sbi->nls_disk);
+	if (sbi->options.iocharset)
+		kfree(sbi->options.iocharset);
+	if (sbi->private_data)
 		kfree(sbi->private_data);
 	sbi->private_data = NULL;
  
diff -urN linux-2.5.2-pre11/fs/fat/misc.c fat_read-super-cleanup/fs/fat/misc.c
--- linux-2.5.2-pre11/fs/fat/misc.c	Sun Jan 13 19:23:52 2002
+++ fat_read-super-cleanup/fs/fat/misc.c	Sun Jan 13 03:00:09 2002
@@ -102,13 +102,14 @@
 	/* Sanity check */
 	if (!IS_FSINFO(fsinfo)) {
 		printk("FAT: Did not find valid FSINFO signature.\n"
-		       "Found signature1 0x%x signature2 0x%x sector=%ld.\n",
+		       "     Found signature1 0x%08x signature2 0x%08x"
+		       " (sector = %lu)\n",
 		       CF_LE_L(fsinfo->signature1), CF_LE_L(fsinfo->signature2),
 		       MSDOS_SB(sb)->fsinfo_sector);
-		return;
+	} else {
+		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
+		fat_mark_buffer_dirty(sb, bh);
 	}
-	fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
-	fat_mark_buffer_dirty(sb, bh);
 	fat_brelse(sb, bh);
 }
 
diff -urN linux-2.5.2-pre11/fs/vfat/namei.c fat_read-super-cleanup/fs/vfat/namei.c
--- linux-2.5.2-pre11/fs/vfat/namei.c	Sun Jan 13 19:23:55 2002
+++ fat_read-super-cleanup/fs/vfat/namei.c	Sun Jan 13 03:01:06 2002
@@ -446,7 +446,7 @@
 	(x)->lower = 1;				\
 	(x)->upper = 1;				\
 	(x)->valid = 1;				\
-} while (0);
+} while (0)
 
 static inline unsigned char
 shortname_info_to_lcase(struct shortname_info *base,
diff -urN linux-2.5.2-pre11/include/linux/msdos_fs.h fat_read-super-cleanup/include/linux/msdos_fs.h
--- linux-2.5.2-pre11/include/linux/msdos_fs.h	Sun Jan 13 19:23:58 2002
+++ fat_read-super-cleanup/include/linux/msdos_fs.h	Sun Jan 13 03:02:01 2002
@@ -23,9 +23,6 @@
 
 #define FAT_CACHE    8 /* FAT cache size */
 
-#define MSDOS_MAX_EXTRA	3 /* tolerate up to that number of clusters which are
-			     inaccessible because the FAT is too short */
-
 #define ATTR_RO      1  /* read-only */
 #define ATTR_HIDDEN  2  /* hidden */
 #define ATTR_SYS     4  /* system */
@@ -48,11 +45,6 @@
 #define CASE_LOWER_BASE 8	/* base is lower case */
 #define CASE_LOWER_EXT  16	/* extension is lower case */
 
-#define SCAN_ANY     0  /* either hidden or not */
-#define SCAN_HID     1  /* only hidden */
-#define SCAN_NOTHID  2  /* only not hidden */
-#define SCAN_NOTANY  3  /* test name, then use SCAN_HID or SCAN_NOTHID */
-
 #define DELETED_FLAG 0xe5 /* marks file as deleted when in name[0] */
 #define IS_FREE(n) (!*(n) || *(const unsigned char *) (n) == DELETED_FLAG)
 
@@ -78,8 +70,8 @@
 
 #define FAT_FSINFO_SIG1		0x41615252
 #define FAT_FSINFO_SIG2		0x61417272
-#define IS_FSINFO(x)		(CF_LE_L((x)->signature1) == FAT_FSINFO_SIG1	 \
-				 && CF_LE_L((x)->signature2) == FAT_FSINFO_SIG2)
+#define IS_FSINFO(x)	(CF_LE_L((x)->signature1) == FAT_FSINFO_SIG1	\
+			 && CF_LE_L((x)->signature2) == FAT_FSINFO_SIG2)
 
 /*
  * Inode flags
@@ -183,10 +175,6 @@
 	loff_t shortname_offset;       /* dir offset for shortname start */
 	int ino;		       /* ino for the file */
 };
-
-/* Determine whether this FS has kB-aligned data. */
-#define MSDOS_CAN_BMAP(mib) (!(((mib)->cluster_size & 1) || \
-    ((mib)->data_start & 1)))
 
 /* Convert attribute bits and a mask to the UNIX mode. */
 #define MSDOS_MKMODE(a,m) (m & (a & ATTR_RO ? S_IRUGO|S_IXUGO : S_IRWXUGO))
