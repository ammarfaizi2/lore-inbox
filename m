Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWCRNCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWCRNCi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCRNCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:02:38 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:3833 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932120AbWCRNCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:02:37 -0500
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ext2/3: Changing the unit of i_blocks (e2fsprogs-1.38)
Message-Id: <20060318220229sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Sat, 18 Mar 2006 22:02:28 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modification to change the unit of i_blocks in e2fsprogs-1.38.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -uprN e2fsprogs-1.38.org/e2fsck/emptydir.c e2fsprogs-1.38-bigfile/e2fsck/emptydir.c
--- e2fsprogs-1.38.org/e2fsck/emptydir.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/emptydir.c	2006-02-27 15:55:25.000000000 +0900
@@ -169,7 +169,7 @@ static int fix_directory(ext2_filsys fs,
 	if (edi->freed_blocks) {
 		edi->inode.i_size -= edi->freed_blocks * fs->blocksize;
 		edi->inode.i_blocks -= edi->freed_blocks *
-			(fs->blocksize / 512);
+			(fs->blocksize / i_blocks_base(fs));
 		(void) ext2fs_write_inode(fs, db->ino, &edi->inode);
 	}
 	return 0;
diff -uprN e2fsprogs-1.38.org/e2fsck/pass1.c e2fsprogs-1.38-bigfile/e2fsck/pass1.c
--- e2fsprogs-1.38.org/e2fsck/pass1.c	2005-04-15 03:06:09.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/pass1.c	2006-02-27 15:55:25.000000000 +0900
@@ -177,7 +177,7 @@ int e2fsck_pass1_check_symlink(ext2_fils
 	blocks = ext2fs_inode_data_blocks(fs, inode);
 	if (blocks) {
 		if ((inode->i_size >= fs->blocksize) ||
-		    (blocks != fs->blocksize >> 9) ||
+		    (blocks != fs->blocksize / i_blocks_base(fs)) ||
 		    (inode->i_block[0] < fs->super->s_first_data_block) ||
 		    (inode->i_block[0] >= fs->super->s_blocks_count))
 			return 0;
@@ -1470,7 +1473,7 @@ static void check_blocks(e2fsck_t ctx, s
 		}
 	}
 
-	pb.num_blocks *= (fs->blocksize / 512);
+	pb.num_blocks *= (fs->blocksize / i_blocks_base(fs));
 #if 0
 	printf("inode %u, i_size = %lu, last_block = %lld, i_blocks=%lu, num_blocks = %lu\n",
 	       ino, inode->i_size, pb.last_block, inode->i_blocks,
diff -uprN e2fsprogs-1.38.org/e2fsck/pass2.c e2fsprogs-1.38-bigfile/e2fsck/pass2.c
--- e2fsprogs-1.38.org/e2fsck/pass2.c	2005-04-15 03:06:09.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/pass2.c	2006-02-27 15:55:25.000000000 +0900
@@ -1199,7 +1199,7 @@ extern int e2fsck_process_bad_inode(e2fs
 		 */
 		if (LINUX_S_ISLNK(inode.i_mode) &&
 		    (fs->flags & EXT2_FLAG_SWAP_BYTES) &&
-		    (inode.i_blocks == fs->blocksize >> 9))
+		    (inode.i_blocks == fs->blocksize / i_blocks_base(fs)))
 			inode.i_block[0] = ext2fs_swab32(inode.i_block[0]);
 #endif
 		inode_modified++;
@@ -1373,7 +1373,7 @@ static int allocate_dir_block(e2fsck_t c
 	 * Update the inode block count
 	 */
 	e2fsck_read_inode(ctx, db->ino, &inode, "allocate_dir_block");
-	inode.i_blocks += fs->blocksize / 512;
+	inode.i_blocks += fs->blocksize / i_blocks_base(fs);
 	if (inode.i_size < (db->blockcnt+1) * fs->blocksize)
 		inode.i_size = (db->blockcnt+1) * fs->blocksize;
 	e2fsck_write_inode(ctx, db->ino, &inode, "allocate_dir_block");
diff -uprN e2fsprogs-1.38.org/e2fsck/pass3.c e2fsprogs-1.38-bigfile/e2fsck/pass3.c
--- e2fsprogs-1.38.org/e2fsck/pass3.c	2005-04-15 03:06:09.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/pass3.c	2006-02-27 15:55:25.000000000 +0900
@@ -224,7 +224,7 @@ static void check_root(e2fsck_t ctx)
 	inode.i_size = fs->blocksize;
 	inode.i_atime = inode.i_ctime = inode.i_mtime = ctx->now;
 	inode.i_links_count = 2;
-	inode.i_blocks = fs->blocksize / 512;
+	inode.i_blocks = fs->blocksize / i_blocks_base(fs);
 	inode.i_block[0] = blk;
 
 	/*
@@ -472,7 +472,7 @@ ext2_ino_t e2fsck_get_lost_and_found(e2f
 	inode.i_size = fs->blocksize;
 	inode.i_atime = inode.i_ctime = inode.i_mtime = ctx->now;
 	inode.i_links_count = 2;
-	inode.i_blocks = fs->blocksize / 512;
+	inode.i_blocks = fs->blocksize / i_blocks_base(fs);
 	inode.i_block[0] = blk;
 
 	/*
@@ -795,7 +795,7 @@ errcode_t e2fsck_expand_directory(e2fsck
 		return retval;
 	
 	inode.i_size = (es.last_block + 1) * fs->blocksize;
-	inode.i_blocks += (fs->blocksize / 512) * es.newblocks;
+	inode.i_blocks += (fs->blocksize / i_blocks_base(fs)) * es.newblocks;
 
 	e2fsck_write_inode(ctx, dir, &inode, "expand_directory");
 
diff -uprN e2fsprogs-1.38.org/e2fsck/rehash.c e2fsprogs-1.38-bigfile/e2fsck/rehash.c
--- e2fsprogs-1.38.org/e2fsck/rehash.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/rehash.c	2006-02-27 15:55:25.000000000 +0900
@@ -648,7 +648,7 @@ static errcode_t write_directory(e2fsck_
 	else
 		inode.i_flags |= EXT2_INDEX_FL;
 	inode.i_size = outdir->num * fs->blocksize;
-	inode.i_blocks -= (fs->blocksize / 512) * wd.cleared;
+	inode.i_blocks -= (fs->blocksize / i_blocks_base(fs)) * wd.cleared;
 	e2fsck_write_inode(ctx, ino, &inode, "rehash_dir");
 
 	return 0;
diff -uprN e2fsprogs-1.38.org/e2fsck/super.c e2fsprogs-1.38-bigfile/e2fsck/super.c
--- e2fsprogs-1.38.org/e2fsck/super.c	2005-04-15 03:06:09.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/super.c	2006-02-27 15:55:25.000000000 +0900
@@ -209,7 +209,7 @@ static int release_inode_blocks(e2fsck_t
 
 	if (pb.truncated_blocks)
 		inode->i_blocks -= pb.truncated_blocks *
-			(fs->blocksize / 512);
+			(fs->blocksize / i_blocks_base(fs));
 
 	if (inode->i_file_acl) {
 		retval = ext2fs_adjust_ea_refcount(fs, inode->i_file_acl,
diff -uprN e2fsprogs-1.38.org/lib/e2p/feature.c e2fsprogs-1.38-bigfile/lib/e2p/feature.c
--- e2fsprogs-1.38.org/lib/e2p/feature.c	2004-12-07 07:45:50.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/e2p/feature.c	2006-02-27 15:55:25.000000000 +0900
@@ -51,6 +51,8 @@ static struct feature feature_list[] = {
 			"extents" },
 	{	E2P_FEATURE_INCOMPAT, EXT2_FEATURE_INCOMPAT_META_BG,
 			"meta_bg" },
+	{	E2P_FEATURE_INCOMPAT, EXT2_FEATURE_INCOMPAT_LARGE_BLOCK,
+			"large_block"},
 	{	0, 0, 0 },
 };
 
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/bb_inode.c e2fsprogs-1.38-bigfile/lib/ext2fs/bb_inode.c
--- e2fsprogs-1.38.org/lib/ext2fs/bb_inode.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/bb_inode.c	2006-02-27 15:55:25.000000000 +0900
@@ -127,7 +127,7 @@ errcode_t ext2fs_update_bb_inode(ext2_fi
 	inode.i_atime = inode.i_mtime = time(0);
 	if (!inode.i_ctime)
 		inode.i_ctime = time(0);
-	inode.i_blocks = rec.bad_block_count * (fs->blocksize / 512);
+	inode.i_blocks = rec.bad_block_count * (fs->blocksize / i_blocks_base(fs));
 	inode.i_size = rec.bad_block_count * fs->blocksize;
 
 	retval = ext2fs_write_inode(fs, EXT2_BAD_INO, &inode);
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/bmap.c e2fsprogs-1.38-bigfile/lib/ext2fs/bmap.c
--- e2fsprogs-1.38.org/lib/ext2fs/bmap.c	2004-12-24 03:55:34.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/bmap.c	2006-02-27 15:55:25.000000000 +0900
@@ -260,7 +260,7 @@ done:
 	if (buf)
 		ext2fs_free_mem(&buf);
 	if ((retval == 0) && (blocks_alloc || inode_dirty)) {
-		inode->i_blocks += (blocks_alloc * fs->blocksize) / 512;
+		inode->i_blocks += (blocks_alloc * fs->blocksize) / i_blocks_base(fs);
 		retval = ext2fs_write_inode(fs, ino, inode);
 	}
 	return retval;
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/expanddir.c e2fsprogs-1.38-bigfile/lib/ext2fs/expanddir.c
--- e2fsprogs-1.38.org/lib/ext2fs/expanddir.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/expanddir.c	2006-02-27 15:55:25.000000000 +0900
@@ -116,7 +116,7 @@ errcode_t ext2fs_expand_dir(ext2_filsys 
 		return retval;
 	
 	inode.i_size += fs->blocksize;
-	inode.i_blocks += (fs->blocksize / 512) * es.newblocks;
+	inode.i_blocks += (fs->blocksize / i_blocks_base(fs)) * es.newblocks;
 
 	retval = ext2fs_write_inode(fs, dir, &inode);
 	if (retval)
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/ext2_fs.h e2fsprogs-1.38-bigfile/lib/ext2fs/ext2_fs.h
--- e2fsprogs-1.38.org/lib/ext2fs/ext2_fs.h	2005-01-26 13:42:55.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/ext2_fs.h	2006-02-27 15:55:25.000000000 +0900
@@ -563,6 +563,7 @@ struct ext2_super_block {
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT3_FEATURE_INCOMPAT_EXTENTS		0x0040
+#define EXT2_FEATURE_INCOMPAT_LARGE_BLOCK	0x0080
 
 
 #define EXT2_FEATURE_COMPAT_SUPP	0
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/ext2fs.h e2fsprogs-1.38-bigfile/lib/ext2fs/ext2fs.h
--- e2fsprogs-1.38.org/lib/ext2fs/ext2fs.h	2005-06-28 00:47:15.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/ext2fs.h	2006-02-27 15:55:25.000000000 +0900
@@ -453,6 +453,7 @@ typedef struct ext2_icount *ext2_icount_
 #define EXT2_LIB_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE|\
 					 EXT3_FEATURE_INCOMPAT_JOURNAL_DEV|\
 					 EXT2_FEATURE_INCOMPAT_META_BG|\
+					 EXT2_FEATURE_INCOMPAT_LARGE_BLOCK|\
 					 EXT3_FEATURE_INCOMPAT_RECOVER)
 #endif
 #define EXT2_LIB_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER|\
@@ -1124,12 +1125,25 @@ _INLINE_ int ext2fs_group_of_ino(ext2_fi
 	return (ino - 1) / fs->super->s_inodes_per_group;
 }
 
+/*
+ * `-O large_block' option support
+ * TODO: rework this function as a variable
+ */
+_INLINE_ int i_blocks_base(ext2_filsys fs)
+{
+        if (fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
+                return fs->blocksize;
+
+        return 512;
+}
+
 _INLINE_ blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
 					struct ext2_inode *inode)
 {
        return inode->i_blocks -
-              (inode->i_file_acl ? fs->blocksize >> 9 : 0);
+              (inode->i_file_acl ? fs->blocksize / i_blocks_base(fs) : 0);
 }
+
 #undef _INLINE_
 #endif
 
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/mkdir.c e2fsprogs-1.38-bigfile/lib/ext2fs/mkdir.c
--- e2fsprogs-1.38.org/lib/ext2fs/mkdir.c	2005-03-21 12:31:41.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/mkdir.c	2006-02-27 15:55:25.000000000 +0900
@@ -82,7 +82,7 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, e
 	memset(&inode, 0, sizeof(struct ext2_inode));
 	inode.i_mode = LINUX_S_IFDIR | (0777 & ~fs->umask);
 	inode.i_uid = inode.i_gid = 0;
-	inode.i_blocks = fs->blocksize / 512;
+	inode.i_blocks = fs->blocksize / i_blocks_base(fs);
 	inode.i_block[0] = blk;
 	inode.i_links_count = 2;
 	inode.i_ctime = inode.i_atime = inode.i_mtime = time(NULL);
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/mkjournal.c e2fsprogs-1.38-bigfile/lib/ext2fs/mkjournal.c
--- e2fsprogs-1.38.org/lib/ext2fs/mkjournal.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/mkjournal.c	2006-02-27 15:55:25.000000000 +0900
@@ -228,7 +228,7 @@ static errcode_t write_journal_inode(ext
 		goto errout;
 
  	inode.i_size += fs->blocksize * size;
-	inode.i_blocks += (fs->blocksize / 512) * es.newblocks;
+	inode.i_blocks += (fs->blocksize / i_blocks_base(fs)) * es.newblocks;
 	inode.i_mtime = inode.i_ctime = time(0);
 	inode.i_links_count = 1;
 	inode.i_mode = LINUX_S_IFREG | 0600;
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/read_bb.c e2fsprogs-1.38-bigfile/lib/ext2fs/read_bb.c
--- e2fsprogs-1.38.org/lib/ext2fs/read_bb.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/read_bb.c	2006-02-27 15:55:25.000000000 +0900
@@ -76,7 +76,7 @@ errcode_t ext2fs_read_bb_inode(ext2_fils
 			return retval;
 		if (inode.i_blocks < 500)
 			numblocks = (inode.i_blocks /
-				     (fs->blocksize / 512)) + 20;
+				     (fs->blocksize / i_blocks_base(fs))) + 20;
 		else
 			numblocks = 500;
 		retval = ext2fs_badblocks_list_create(bb_list, numblocks);
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/res_gdt.c e2fsprogs-1.38-bigfile/lib/ext2fs/res_gdt.c
--- e2fsprogs-1.38.org/lib/ext2fs/res_gdt.c	2005-01-28 08:20:53.000000000 +0900
+++ e2fsprogs-1.38-bigfile/lib/ext2fs/res_gdt.c	2006-02-27 15:55:25.000000000 +0900
@@ -84,7 +84,7 @@ errcode_t ext2fs_create_resize_inode(ext
 
 	/* Maximum possible file size (we donly use the dindirect blocks) */
 	apb = EXT2_ADDR_PER_BLOCK(sb);
-	rsv_add = fs->blocksize / 512;
+	rsv_add = fs->blocksize / i_blocks_base(fs);
 	if ((dindir_blk = inode.i_block[EXT2_DIND_BLOCK])) {
 #ifdef RES_GDT_DEBUG
 		printf("reading GDT dindir %u\n", dindir_blk);
diff -uprN e2fsprogs-1.38.org/misc/mke2fs.c e2fsprogs-1.38-bigfile/misc/mke2fs.c
--- e2fsprogs-1.38.org/misc/mke2fs.c	2005-07-01 09:00:40.000000000 +0900
+++ e2fsprogs-1.38-bigfile/misc/mke2fs.c	2006-02-27 15:55:25.000000000 +0900
@@ -887,7 +887,8 @@ static __u32 ok_features[3] = {
 		EXT2_FEATURE_COMPAT_DIR_INDEX,	/* Compat */
 	EXT2_FEATURE_INCOMPAT_FILETYPE|		/* Incompat */
 		EXT3_FEATURE_INCOMPAT_JOURNAL_DEV|
-		EXT2_FEATURE_INCOMPAT_META_BG,
+		EXT2_FEATURE_INCOMPAT_META_BG |
+		EXT2_FEATURE_INCOMPAT_LARGE_BLOCK,
 	EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	/* R/O compat */
 };
 
diff -uprN e2fsprogs-1.38.org/resize/resize2fs.c e2fsprogs-1.38-bigfile/resize/resize2fs.c
--- e2fsprogs-1.38.org/resize/resize2fs.c	2005-05-10 05:22:17.000000000 +0900
+++ e2fsprogs-1.38-bigfile/resize/resize2fs.c	2006-02-27 15:55:25.000000000 +0900
@@ -1454,7 +1454,7 @@ static errcode_t fix_resize_inode(ext2_f
 	retval = ext2fs_read_inode(fs, EXT2_RESIZE_INO, &inode);
 	if (retval) goto errout;
 
-	inode.i_blocks = fs->blocksize/512;
+	inode.i_blocks = fs->blocksize / i_blocks_base(fs);
 
 	retval = ext2fs_write_inode(fs, EXT2_RESIZE_INO, &inode);
 	if (retval) goto errout;


