Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWDZBuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWDZBuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 21:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDZBuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 21:50:51 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:12531 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932337AbWDZBuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 21:50:50 -0400
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][16/21]e2fsprogs enlarge file size and filesystem size
Message-Id: <20060426105041sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 26 Apr 2006 10:50:41 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [16/21] enlarge file size and filesystem size
          - Add new option "-O large_block" in mke2fs.

          - With this option, the maximum size of a file is (blocksize)
            * (2^32-1) bytes, and of a filesystem is (pagesize) *
           (2^32-1).

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr e2fsprogs-1.39/debugfs/debugfs.8.in e2fsprogs-1.39.tmp/debugfs/debugfs.8.in
--- e2fsprogs-1.39/debugfs/debugfs.8.in	2006-03-19 09:53:51.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/debugfs.8.in	2006-04-21 14:41:04.000000000 +0900
@@ -319,6 +319,8 @@ flag will list deleted entries in the di
 .I modify_inode filespec
 Modify the contents of the inode structure in the inode
 .IR filespec .
+On filesystems with large_block feature, the field 'Block count' should be input
+in filesystem block units.
 .TP
 .I mkdir filespec
 Make a directory.
@@ -402,6 +404,8 @@ has value 
 The list of valid inode fields which can be set via this command 
 can be displayed by using the command:
 .B set_inode_field -l
+On filesystems with large_block feature, the field 'blocks' should be input in
+filesystem block units.
 .TP
 .I set_super_value field value
 Set the superblock field
diff -upNr e2fsprogs-1.39/debugfs/debugfs.c e2fsprogs-1.39.tmp/debugfs/debugfs.c
--- e2fsprogs-1.39/debugfs/debugfs.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/debugfs.c	2006-04-21 14:41:04.000000000 +0900
@@ -846,7 +846,10 @@ void do_modify_inode(int argc, char *arg
 	modify_u32(argv[0], "Access time", decimal_format, &inode.i_atime);
 	modify_u32(argv[0], "Deletion time", decimal_format, &inode.i_dtime);
 	modify_u16(argv[0], "Link count", decimal_format, &inode.i_links_count);
-	modify_u32(argv[0], "Block count", unsignedlong_format, &inode.i_blocks);
+	if (current_fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
+		modify_u32(argv[0], "Block count (fsblocks)", unsignedlong_format, &inode.i_blocks);
+	else
+		modify_u32(argv[0], "Block count", unsignedlong_format, &inode.i_blocks);
 	modify_u32(argv[0], "File flags", hex_format, &inode.i_flags);
 	modify_u32(argv[0], "Generation", hex_format, &inode.i_generation);
 #if 0
diff -upNr e2fsprogs-1.39/debugfs/set_fields.c e2fsprogs-1.39.tmp/debugfs/set_fields.c
--- e2fsprogs-1.39/debugfs/set_fields.c	2006-03-20 10:31:06.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/set_fields.c	2006-04-21 14:41:04.000000000 +0900
@@ -384,6 +384,9 @@ static void print_possible_fields(struct
 		else if (ss->func == parse_bmap)
 			type = "set physical->logical block map";
 		strcpy(name, ss->name);
+		if ((current_fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK) &&
+		    (fields == inode_fields) && (!strcmp(name, "blocks")))
+			strcat(name, " (fsblocks)");
 		if (ss->flags & FLAG_ARRAY) {
 			if (ss->max_idx > 0) 
 				sprintf(idx, "[%d]", ss->max_idx);
diff -upNr e2fsprogs-1.39/e2fsck/emptydir.c e2fsprogs-1.39.tmp/e2fsck/emptydir.c
--- e2fsprogs-1.39/e2fsck/emptydir.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/emptydir.c	2006-04-21 14:41:04.000000000 +0900
@@ -169,7 +169,7 @@ static int fix_directory(ext2_filsys fs,
 	if (edi->freed_blocks) {
 		edi->inode.i_size -= edi->freed_blocks * fs->blocksize;
 		edi->inode.i_blocks -= edi->freed_blocks *
-			(fs->blocksize / 512);
+			(fs->blocksize / i_blocks_base(fs));
 		(void) ext2fs_write_inode(fs, db->ino, &edi->inode);
 	}
 	return 0;
diff -upNr e2fsprogs-1.39/e2fsck/pass1.c e2fsprogs-1.39.tmp/e2fsck/pass1.c
--- e2fsprogs-1.39/e2fsck/pass1.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass1.c	2006-04-21 14:41:04.000000000 +0900
@@ -177,7 +177,7 @@ int e2fsck_pass1_check_symlink(ext2_fils
 	blocks = ext2fs_inode_data_blocks(fs, inode);
 	if (blocks) {
 		if ((inode->i_size >= fs->blocksize) ||
-		    (blocks != fs->blocksize >> 9) ||
+		    (blocks != fs->blocksize / i_blocks_base(fs)) ||		   
 		    (inode->i_block[0] < fs->super->s_first_data_block) ||
 		    (inode->i_block[0] >= fs->super->s_blocks_count))
 			return 0;
@@ -1470,7 +1470,7 @@ static void check_blocks(e2fsck_t ctx, s
 		}
 	}
 
-	pb.num_blocks *= (fs->blocksize / 512);
+	pb.num_blocks *= (fs->blocksize / i_blocks_base(fs));
 #if 0
 	printf("inode %u, i_size = %lu, last_block = %lld, i_blocks=%lu, num_blocks = %lu\n",
 	       ino, inode->i_size, pb.last_block, inode->i_blocks,
@@ -1658,8 +1658,9 @@ static int process_block(ext2_filsys fs,
 
 	if (p->is_dir && blockcnt > (1 << (21 - fs->super->s_log_block_size)))
 		problem = PR_1_TOOBIG_DIR;
-	if (p->is_reg && p->num_blocks+1 >= p->max_blocks)
-		problem = PR_1_TOOBIG_REG;
+	if (!(fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK))
+		if (p->is_reg && p->num_blocks+1 >= p->max_blocks)
+			problem = PR_1_TOOBIG_REG;
 	if (!p->is_dir && !p->is_reg && blockcnt > 0)
 		problem = PR_1_TOOBIG_SYMLINK;
 	    
diff -upNr e2fsprogs-1.39/e2fsck/pass2.c e2fsprogs-1.39.tmp/e2fsck/pass2.c
--- e2fsprogs-1.39/e2fsck/pass2.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass2.c	2006-04-21 14:41:04.000000000 +0900
@@ -1200,7 +1200,7 @@ extern int e2fsck_process_bad_inode(e2fs
 			 */
 			if (LINUX_S_ISLNK(inode.i_mode) &&
 			    (fs->flags & EXT2_FLAG_SWAP_BYTES) &&
-			    (inode.i_blocks == fs->blocksize >> 9))
+			    (inode.i_blocks == fs->blocksize / i_blocks_base(fs)))
 				inode.i_block[0] = ext2fs_swab32(inode.i_block[0]);
 #endif
 			inode_modified++;
@@ -1375,7 +1375,7 @@ static int allocate_dir_block(e2fsck_t c
 	 * Update the inode block count
 	 */
 	e2fsck_read_inode(ctx, db->ino, &inode, "allocate_dir_block");
-	inode.i_blocks += fs->blocksize / 512;
+	inode.i_blocks += fs->blocksize / i_blocks_base(fs);
 	if (inode.i_size < (db->blockcnt+1) * fs->blocksize)
 		inode.i_size = (db->blockcnt+1) * fs->blocksize;
 	e2fsck_write_inode(ctx, db->ino, &inode, "allocate_dir_block");
diff -upNr e2fsprogs-1.39/e2fsck/pass3.c e2fsprogs-1.39.tmp/e2fsck/pass3.c
--- e2fsprogs-1.39/e2fsck/pass3.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass3.c	2006-04-21 14:41:04.000000000 +0900
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
 
diff -upNr e2fsprogs-1.39/e2fsck/rehash.c e2fsprogs-1.39.tmp/e2fsck/rehash.c
--- e2fsprogs-1.39/e2fsck/rehash.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/rehash.c	2006-04-21 14:41:04.000000000 +0900
@@ -648,7 +648,7 @@ static errcode_t write_directory(e2fsck_
 	else
 		inode.i_flags |= EXT2_INDEX_FL;
 	inode.i_size = outdir->num * fs->blocksize;
-	inode.i_blocks -= (fs->blocksize / 512) * wd.cleared;
+	inode.i_blocks -= (fs->blocksize / i_blocks_base(fs)) * wd.cleared;
 	e2fsck_write_inode(ctx, ino, &inode, "rehash_dir");
 
 	return 0;
diff -upNr e2fsprogs-1.39/e2fsck/super.c e2fsprogs-1.39.tmp/e2fsck/super.c
--- e2fsprogs-1.39/e2fsck/super.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/super.c	2006-04-21 14:41:04.000000000 +0900
@@ -209,7 +209,7 @@ static int release_inode_blocks(e2fsck_t
 
 	if (pb.truncated_blocks)
 		inode->i_blocks -= pb.truncated_blocks *
-			(fs->blocksize / 512);
+			(fs->blocksize / i_blocks_base(fs));
 
 	if (inode->i_file_acl) {
 		retval = ext2fs_adjust_ea_refcount(fs, inode->i_file_acl,
diff -upNr e2fsprogs-1.39/lib/e2p/feature.c e2fsprogs-1.39.tmp/lib/e2p/feature.c
--- e2fsprogs-1.39/lib/e2p/feature.c	2006-03-24 01:01:41.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/e2p/feature.c	2006-04-21 14:41:04.000000000 +0900
@@ -51,6 +51,8 @@ static struct feature feature_list[] = {
 			"extents" },
 	{	E2P_FEATURE_INCOMPAT, EXT2_FEATURE_INCOMPAT_META_BG,
 			"meta_bg" },
+	{	E2P_FEATURE_INCOMPAT, EXT2_FEATURE_INCOMPAT_LARGE_BLOCK,
+			"large_block"},
 	{	0, 0, 0 },
 };
 
diff -upNr e2fsprogs-1.39/lib/ext2fs/bb_inode.c e2fsprogs-1.39.tmp/lib/ext2fs/bb_inode.c
--- e2fsprogs-1.39/lib/ext2fs/bb_inode.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bb_inode.c	2006-04-21 14:41:04.000000000 +0900
@@ -127,7 +127,7 @@ errcode_t ext2fs_update_bb_inode(ext2_fi
 	inode.i_atime = inode.i_mtime = fs->now ? fs->now : time(0);
 	if (!inode.i_ctime)
 		inode.i_ctime = fs->now ? fs->now : time(0);
-	inode.i_blocks = rec.bad_block_count * (fs->blocksize / 512);
+	inode.i_blocks = rec.bad_block_count * (fs->blocksize / i_blocks_base(fs));
 	inode.i_size = rec.bad_block_count * fs->blocksize;
 
 	retval = ext2fs_write_inode(fs, EXT2_BAD_INO, &inode);
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitops.h e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h
--- e2fsprogs-1.39/lib/ext2fs/bitops.h	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h	2006-04-21 14:41:04.000000000 +0900
@@ -145,6 +145,7 @@ extern int ext2fs_unmark_generic_bitmap_
  * functions at all; they will be included as normal functions in
  * inline.c
  */
+
 #ifdef NO_INLINE_FUNCS
 #if (defined(__GNUC__) && (defined(__i386__) || defined(__i486__) || \
 			   defined(__i586__) || defined(__mc68000__)))
@@ -165,6 +166,8 @@ extern int ext2fs_unmark_generic_bitmap_
 #endif
 #endif
 
+
+
 /*
  * Fast bit set/clear functions that doesn't need to return the
  * previous bit value.
diff -upNr e2fsprogs-1.39/lib/ext2fs/bmap.c e2fsprogs-1.39.tmp/lib/ext2fs/bmap.c
--- e2fsprogs-1.39/lib/ext2fs/bmap.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bmap.c	2006-04-21 14:41:04.000000000 +0900
@@ -260,7 +260,7 @@ done:
 	if (buf)
 		ext2fs_free_mem(&buf);
 	if ((retval == 0) && (blocks_alloc || inode_dirty)) {
-		inode->i_blocks += (blocks_alloc * fs->blocksize) / 512;
+		inode->i_blocks += (blocks_alloc * fs->blocksize) / i_blocks_base(fs);
 		retval = ext2fs_write_inode(fs, ino, inode);
 	}
 	return retval;
diff -upNr e2fsprogs-1.39/lib/ext2fs/expanddir.c e2fsprogs-1.39.tmp/lib/ext2fs/expanddir.c
--- e2fsprogs-1.39/lib/ext2fs/expanddir.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/expanddir.c	2006-04-21 14:41:04.000000000 +0900
@@ -116,7 +116,7 @@ errcode_t ext2fs_expand_dir(ext2_filsys 
 		return retval;
 	
 	inode.i_size += fs->blocksize;
-	inode.i_blocks += (fs->blocksize / 512) * es.newblocks;
+	inode.i_blocks += (fs->blocksize / i_blocks_base(fs)) * es.newblocks;
 
 	retval = ext2fs_write_inode(fs, dir, &inode);
 	if (retval)
diff -upNr e2fsprogs-1.39/lib/ext2fs/ext2_fs.h e2fsprogs-1.39.tmp/lib/ext2fs/ext2_fs.h
--- e2fsprogs-1.39/lib/ext2fs/ext2_fs.h	2006-03-20 10:31:06.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/ext2_fs.h	2006-04-21 14:41:04.000000000 +0900
@@ -579,7 +579,7 @@ struct ext2_super_block {
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT3_FEATURE_INCOMPAT_EXTENTS		0x0040
-
+#define EXT2_FEATURE_INCOMPAT_LARGE_BLOCK	0x0080
 
 #define EXT2_FEATURE_COMPAT_SUPP	0
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE)
diff -upNr e2fsprogs-1.39/lib/ext2fs/ext2fs.h e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h
--- e2fsprogs-1.39/lib/ext2fs/ext2fs.h	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h	2006-04-21 14:41:04.000000000 +0900
@@ -457,6 +457,7 @@ typedef struct ext2_icount *ext2_icount_
 #define EXT2_LIB_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE|\
 					 EXT3_FEATURE_INCOMPAT_JOURNAL_DEV|\
 					 EXT2_FEATURE_INCOMPAT_META_BG|\
+					 EXT2_FEATURE_INCOMPAT_LARGE_BLOCK|\
 					 EXT3_FEATURE_INCOMPAT_RECOVER)
 #endif
 #define EXT2_LIB_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER|\
@@ -1141,11 +1142,23 @@ _INLINE_ int ext2fs_group_of_ino(ext2_fi
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
+	      (inode->i_file_acl ? fs->blocksize / i_blocks_base(fs) : 0);
 }
 #undef _INLINE_
 #endif
diff -upNr e2fsprogs-1.39/lib/ext2fs/mkdir.c e2fsprogs-1.39.tmp/lib/ext2fs/mkdir.c
--- e2fsprogs-1.39/lib/ext2fs/mkdir.c	2005-09-25 09:06:42.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/mkdir.c	2006-04-21 14:41:04.000000000 +0900
@@ -82,7 +82,7 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, e
 	memset(&inode, 0, sizeof(struct ext2_inode));
 	inode.i_mode = LINUX_S_IFDIR | (0777 & ~fs->umask);
 	inode.i_uid = inode.i_gid = 0;
-	inode.i_blocks = fs->blocksize / 512;
+	inode.i_blocks = fs->blocksize / i_blocks_base(fs);
 	inode.i_block[0] = blk;
 	inode.i_links_count = 2;
 	inode.i_ctime = inode.i_atime = inode.i_mtime = fs->now ? fs->now : time(NULL);
diff -upNr e2fsprogs-1.39/lib/ext2fs/mkjournal.c e2fsprogs-1.39.tmp/lib/ext2fs/mkjournal.c
--- e2fsprogs-1.39/lib/ext2fs/mkjournal.c	2006-04-05 08:12:30.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/mkjournal.c	2006-04-21 14:41:04.000000000 +0900
@@ -228,7 +228,7 @@ static errcode_t write_journal_inode(ext
 		goto errout;
 
  	inode.i_size += fs->blocksize * size;
-	inode.i_blocks += (fs->blocksize / 512) * es.newblocks;
+	inode.i_blocks += (fs->blocksize / i_blocks_base(fs)) * es.newblocks;
 	inode.i_mtime = inode.i_ctime = fs->now ? fs->now : time(0);
 	inode.i_links_count = 1;
 	inode.i_mode = LINUX_S_IFREG | 0600;
diff -upNr e2fsprogs-1.39/lib/ext2fs/read_bb.c e2fsprogs-1.39.tmp/lib/ext2fs/read_bb.c
--- e2fsprogs-1.39/lib/ext2fs/read_bb.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/read_bb.c	2006-04-21 14:41:04.000000000 +0900
@@ -76,7 +76,7 @@ errcode_t ext2fs_read_bb_inode(ext2_fils
 			return retval;
 		if (inode.i_blocks < 500)
 			numblocks = (inode.i_blocks /
-				     (fs->blocksize / 512)) + 20;
+				     (fs->blocksize / i_blocks_base(fs))) + 20;
 		else
 			numblocks = 500;
 		retval = ext2fs_badblocks_list_create(bb_list, numblocks);
diff -upNr e2fsprogs-1.39/lib/ext2fs/res_gdt.c e2fsprogs-1.39.tmp/lib/ext2fs/res_gdt.c
--- e2fsprogs-1.39/lib/ext2fs/res_gdt.c	2005-12-11 01:44:25.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/res_gdt.c	2006-04-21 14:41:04.000000000 +0900
@@ -84,7 +84,7 @@ errcode_t ext2fs_create_resize_inode(ext
 
 	/* Maximum possible file size (we donly use the dindirect blocks) */
 	apb = EXT2_ADDR_PER_BLOCK(sb);
-	rsv_add = fs->blocksize / 512;
+	rsv_add = fs->blocksize / i_blocks_base(fs);
 	if ((dindir_blk = inode.i_block[EXT2_DIND_BLOCK])) {
 #ifdef RES_GDT_DEBUG
 		printf("reading GDT dindir %u\n", dindir_blk);
diff -upNr e2fsprogs-1.39/misc/mke2fs.8.in e2fsprogs-1.39.tmp/misc/mke2fs.8.in
--- e2fsprogs-1.39/misc/mke2fs.8.in	2006-03-27 15:16:49.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/mke2fs.8.in	2006-04-21 14:41:04.000000000 +0900
@@ -406,6 +406,12 @@ extended option.
 .B sparse_super
 Create a filesystem with fewer superblock backup copies
 (saves space on large filesystems).
+.TP
+.B large_block
+The maximum size of a file can be (blocksize)x(232-1) bytes and the maximum
+size of a filesystem is (pagesize)x(232-1).  Specifically on 32 bit platforms,
+a file size cannot exceed 4TB.  With this feature enabled, users cannot make
+blocksize smaller than 4KB.
 .RE
 .TP
 .B \-q
diff -upNr e2fsprogs-1.39/misc/mke2fs.c e2fsprogs-1.39.tmp/misc/mke2fs.c
--- e2fsprogs-1.39/misc/mke2fs.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/mke2fs.c	2006-04-21 14:41:04.000000000 +0900
@@ -817,7 +817,8 @@ static __u32 ok_features[3] = {
 		EXT2_FEATURE_COMPAT_DIR_INDEX,	/* Compat */
 	EXT2_FEATURE_INCOMPAT_FILETYPE|		/* Incompat */
 		EXT3_FEATURE_INCOMPAT_JOURNAL_DEV|
-		EXT2_FEATURE_INCOMPAT_META_BG,
+		EXT2_FEATURE_INCOMPAT_META_BG |
+		EXT2_FEATURE_INCOMPAT_LARGE_BLOCK,
 	EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	/* R/O compat */
 };
 
@@ -1336,6 +1337,16 @@ static void PRS(int argc, char *argv[])
 		int_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
 
 	blocksize = EXT2_BLOCK_SIZE(&fs_param);
+
+	/* We should have checked it earlier if we cared about the blocksize
+	 * set by -b option. */
+	if ((fs_param.s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK) &&
+	    (blocksize < 4096)) {
+		com_err(program_name, 0,
+			_("Too small blocksize! You should specify more than "
+			"or equal to 4KB blocksize with the '-O large_block' option."));
+		exit(1);
+	}
 	
 	if (extended_opts)
 		parse_extended_opts(&fs_param, extended_opts);
@@ -1360,7 +1371,8 @@ static void PRS(int argc, char *argv[])
 		}
 	}
 
-	if (!force && fs_param.s_blocks_count >= (1 << 31)) {
+	if (!(fs_param.s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK) &&
+		!force && fs_param.s_blocks_count >= (1 << 31)) {
 		com_err(program_name, 0,
 			_("Filesystem too large.  No more than 2**31-1 blocks\n"
 			  "\t (8TB using a blocksize of 4k) are currently supported."));
diff -upNr e2fsprogs-1.39/resize/resize2fs.c e2fsprogs-1.39.tmp/resize/resize2fs.c
--- e2fsprogs-1.39/resize/resize2fs.c	2006-04-21 14:40:37.000000000 +0900
+++ e2fsprogs-1.39.tmp/resize/resize2fs.c	2006-04-21 14:41:04.000000000 +0900
@@ -1520,7 +1520,7 @@ static errcode_t fix_resize_inode(ext2_f
 	retval = ext2fs_read_inode(fs, EXT2_RESIZE_INO, &inode);
 	if (retval) goto errout;
 
-	inode.i_blocks = fs->blocksize/512;
+	inode.i_blocks = fs->blocksize/i_blocks_base(fs);
 
 	retval = ext2fs_write_inode(fs, EXT2_RESIZE_INO, &inode);
 	if (retval) goto errout;
