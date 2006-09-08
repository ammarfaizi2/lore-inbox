Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWIHQPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWIHQPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWIHQPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:15:37 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46281 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750848AbWIHQPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:15:35 -0400
Date: Fri, 8 Sep 2006 18:15:23 +0200
From: Alexandre Ratchov <alexandre.ratchov@bull.net>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, shaggy@us.ibm.com, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [patch 1/2] Re: Updated ext4 patches for 2.6.18-rc6
Message-ID: <20060908161523.GA19487@openx1.frec.bull.fr>
References: <20060908131144sho@rifu.tnes.nec.co.jp> <1157698868.8616.20.camel@localhost.localdomain> <20060908161324.GA19256@openx1.frec.bull.fr>
Mime-Version: 1.0
In-Reply-To: <20060908161324.GA19256@openx1.frec.bull.fr>
User-Agent: Mutt/1.4.1i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2006 18:21:04,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2006 18:21:07,
	Serialize complete at 08/09/2006 18:21:07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.18-rc6/include/linux/ext4_fs.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/ext4_fs.h	2006-09-08 14:37:44.000000000 +0200
+++ linux-2.6.18-rc6/include/linux/ext4_fs.h	2006-09-08 14:38:02.000000000 +0200
@@ -132,34 +132,16 @@ struct ext4_group_desc
 	__le16	bg_free_blocks_count;	/* Free blocks count */
 	__le16	bg_free_inodes_count;	/* Free inodes count */
 	__le16	bg_used_dirs_count;	/* Directories count */
-	__u16	bg_pad;
-	__le32	bg_reserved[3];
+	__u16	bg_flags;		/* reserved for fsck */
+	__le16	bg_block_bitmap_hi;	/* Blocks bitmap block MSB */
+	__le16	bg_inode_bitmap_hi;	/* Inodes bitmap block MSB */
+	__le16	bg_inode_table_hi;	/* Inodes table block MSB */
+	__u16	bg_reserved[3];
 };
 
 #ifdef __KERNEL__
 #include <linux/ext4_fs_i.h>
 #include <linux/ext4_fs_sb.h>
-
-#define EXT4_BLOCK_BITMAP(bg, group_base)	\
-		ext4_relative_decode(group_base, le32_to_cpu((bg)->bg_block_bitmap))
-#define EXT4_INODE_BITMAP(bg, group_base)	\
-		ext4_relative_decode(group_base, le32_to_cpu((bg)->bg_inode_bitmap))
-#define EXT4_INODE_TABLE(bg, group_base)	\
-		ext4_relative_decode(group_base, le32_to_cpu((bg)->bg_inode_table))
-
-#define EXT4_BLOCK_BITMAP_SET(bg, group_base, value)	\
-	do {(bg)->bg_block_bitmap = ext4_relative_encode(group_base, value);} while(0)
-#define EXT4_INODE_BITMAP_SET(bg, group_base, value)	\
-	do {(bg)->bg_inode_bitmap = ext4_relative_encode(group_base, value);} while(0)
-#define EXT4_INODE_TABLE_SET(bg, group_base, value)	\
-	do {(bg)->bg_inode_table = ext4_relative_encode(group_base, value);} while(0)
-
-#define EXT4_IS_USED_BLOCK_BITMAP(bg)	\
-	((bg)->bg_block_bitmap != 0)
-#define EXT4_IS_USED_INODE_BITMAP(bg)	\
-	((bg)->bg_inode_bitmap != 0)
-#define EXT4_IS_USED_INODE_TABLE(bg)	\
-	((bg)->bg_inode_table != 0)
 #endif
 /*
  * Macro-instructions used to manage group descriptors
@@ -223,9 +205,9 @@ struct ext4_group_desc
 /* Used to pass group descriptor data when online resize is done */
 struct ext4_new_group_input {
 	__u32 group;            /* Group number for this data */
-	__u32 block_bitmap;     /* Absolute block number of block bitmap */
-	__u32 inode_bitmap;     /* Absolute block number of inode bitmap */
-	__u32 inode_table;      /* Absolute block number of inode table start */
+	__u64 block_bitmap;     /* Absolute block number of block bitmap */
+	__u64 inode_bitmap;     /* Absolute block number of inode bitmap */
+	__u64 inode_table;      /* Absolute block number of inode table start */
 	__u32 blocks_count;     /* Total number of blocks in this group */
 	__u16 reserved_blocks;  /* Number of reserved blocks in this group */
 	__u16 unused;
@@ -234,9 +216,9 @@ struct ext4_new_group_input {
 /* The struct ext4_new_group_input in kernel space, with free_blocks_count */
 struct ext4_new_group_data {
 	__u32 group;
-	__u32 block_bitmap;
-	__u32 inode_bitmap;
-	__u32 inode_table;
+	__u64 block_bitmap;
+	__u64 inode_bitmap;
+	__u64 inode_table;
 	__u32 blocks_count;
 	__u16 reserved_blocks;
 	__u16 unused;
@@ -911,8 +893,12 @@ extern void ext4_warning (struct super_b
 extern void ext4_update_dynamic_rev (struct super_block *sb);
 extern ext4_fsblk_t ext4_blocks_count(struct ext4_super_block *es);
 extern ext4_fsblk_t ext4_r_blocks_count(struct ext4_super_block *es);
-extern u32 ext4_relative_encode(ext4_fsblk_t group_base, ext4_fsblk_t fs_block);
-extern ext4_fsblk_t ext4_relative_decode(ext4_fsblk_t group_base, u32 gdp_block);
+extern ext4_fsblk_t ext4_block_bitmap(struct ext4_group_desc *bg);
+extern ext4_fsblk_t ext4_inode_bitmap(struct ext4_group_desc *bg);
+extern ext4_fsblk_t ext4_inode_table(struct ext4_group_desc *bg);
+extern void ext4_block_bitmap_set(struct ext4_group_desc *bg, ext4_fsblk_t blk);
+extern void ext4_inode_bitmap_set(struct ext4_group_desc *bg, ext4_fsblk_t blk);
+extern void ext4_inode_table_set(struct ext4_group_desc *bg, ext4_fsblk_t blk);
 
 #define ext4_std_error(sb, errno)				\
 do {								\
Index: linux-2.6.18-rc6/fs/ext4/balloc.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/balloc.c	2006-09-08 14:37:48.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/balloc.c	2006-09-08 14:42:54.000000000 +0200
@@ -87,16 +87,13 @@ read_block_bitmap(struct super_block *sb
 	desc = ext4_get_group_desc (sb, block_group, NULL);
 	if (!desc)
 		goto error_out;
-	bh = sb_bread(sb,
-		      EXT4_BLOCK_BITMAP(desc,
-			      ext4_group_first_block_no(sb, block_group)));
+	bh = sb_bread(sb, ext4_block_bitmap(desc));
 	if (!bh)
 		ext4_error (sb, "read_block_bitmap",
 			    "Cannot read block bitmap - "
 			    "block_group = %d, block_bitmap = %llu",
 			    block_group,
-			    EXT4_BLOCK_BITMAP(desc,
-			      ext4_group_first_block_no(sb, block_group)));
+			    ext4_block_bitmap(desc));
 error_out:
 	return bh;
 }
@@ -338,7 +335,7 @@ void ext4_free_blocks_sb(handle_t *handl
 		goto error_return;
 	}
 
-	ext4_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
+	ext4_debug ("freeing block(s) %llu-%llu\n", block, block + count - 1);
 
 do_more:
 	overflow = 0;
@@ -359,20 +356,10 @@ do_more:
 	if (!desc)
 		goto error_return;
 
-	if (in_range (EXT4_BLOCK_BITMAP(desc,
-				ext4_group_first_block_no(sb, block_group)),
-		      block, count) ||
-	    in_range (EXT4_INODE_BITMAP(desc,
-			    	ext4_group_first_block_no(sb, block_group)),
-		      block, count) ||
-	    in_range (block,
-		      EXT4_INODE_TABLE(desc,
-			      	ext4_group_first_block_no(sb, block_group)),
-		      sbi->s_itb_per_group) ||
-	    in_range (block + count - 1,
-		      EXT4_INODE_TABLE(desc,
-			      	ext4_group_first_block_no(sb, block_group)),
-		      sbi->s_itb_per_group))
+	if (in_range(ext4_block_bitmap(desc), block, count) ||
+	    in_range(ext4_inode_bitmap(desc), block, count) ||
+	    in_range(block, ext4_inode_table(desc), sbi->s_itb_per_group) ||
+	    in_range(block + count - 1, ext4_inode_table(desc), sbi->s_itb_per_group))
 		ext4_error (sb, "ext4_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %llu, count = %lu",
@@ -1372,16 +1359,12 @@ allocated:
 
 	ret_block = grp_alloc_blk + ext4_group_first_block_no(sb, group_no);
 
-	if (in_range(EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, group_no)),
-				ret_block, num) ||
-	    in_range(EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, group_no)),
-		    		ret_block, num) ||
-	    in_range(ret_block, EXT4_INODE_TABLE(gdp,
-			    	ext4_group_first_block_no(sb, group_no)),
-		      EXT4_SB(sb)->s_itb_per_group) ||
-	    in_range(ret_block + num - 1, EXT4_INODE_TABLE(gdp,
-			    ext4_group_first_block_no(sb, group_no)),
-		      EXT4_SB(sb)->s_itb_per_group))
+	if (in_range(ext4_block_bitmap(gdp), ret_block, num) ||
+	    in_range(ext4_block_bitmap(gdp), ret_block, num) ||
+	    in_range(ret_block, ext4_inode_table(gdp),
+			EXT4_SB(sb)->s_itb_per_group) ||
+	    in_range(ret_block + num - 1, ext4_inode_table(gdp),
+			EXT4_SB(sb)->s_itb_per_group))
 		ext4_error(sb, "ext4_new_block",
 			    "Allocating block in system zone - "
 			    "blocks from %llu, length %lu",
Index: linux-2.6.18-rc6/fs/ext4/resize.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/resize.c	2006-09-08 14:37:48.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/resize.c	2006-09-08 14:38:02.000000000 +0200
@@ -829,12 +829,9 @@ int ext4_group_add(struct super_block *s
 	/* Update group descriptor block for new group */
 	gdp = (struct ext4_group_desc *)primary->b_data + gdb_off;
 
-	EXT4_BLOCK_BITMAP_SET(gdp, ext4_group_first_block_no(sb, gdb_num),
-				   input->block_bitmap); /* LV FIXME */
-	EXT4_INODE_BITMAP_SET(gdp, ext4_group_first_block_no(sb, gdb_num),
-			           input->inode_bitmap); /* LV FIXME */
-	EXT4_INODE_TABLE_SET(gdp, ext4_group_first_block_no(sb, gdb_num),
-			          input->inode_table); /* LV FIXME */
+	ext4_block_bitmap_set(gdp, input->block_bitmap); /* LV FIXME */
+	ext4_inode_bitmap_set(gdp, input->inode_bitmap); /* LV FIXME */
+	ext4_inode_table_set(gdp, input->inode_table); /* LV FIXME */
 	gdp->bg_free_blocks_count = cpu_to_le16(input->free_blocks_count);
 	gdp->bg_free_inodes_count = cpu_to_le16(EXT4_INODES_PER_GROUP(sb));
 
Index: linux-2.6.18-rc6/fs/ext4/ialloc.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/ialloc.c	2006-09-08 14:37:44.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/ialloc.c	2006-09-08 14:38:02.000000000 +0200
@@ -60,14 +60,12 @@ read_inode_bitmap(struct super_block * s
 	if (!desc)
 		goto error_out;
 
-	bh = sb_bread(sb, EXT4_INODE_BITMAP(desc,
-			      ext4_group_first_block_no(sb, block_group)));
+	bh = sb_bread(sb, ext4_inode_bitmap(desc));
 	if (!bh)
 		ext4_error(sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
 			    "block_group = %lu, inode_bitmap = %llu",
-			    block_group, EXT4_INODE_BITMAP(desc,
-			      ext4_group_first_block_no(sb, block_group)));
+			    block_group, ext4_inode_bitmap(desc));
 error_out:
 	return bh;
 }
Index: linux-2.6.18-rc6/fs/ext4/inode.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/inode.c	2006-09-08 14:37:54.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/inode.c	2006-09-08 14:38:02.000000000 +0200
@@ -2434,8 +2434,7 @@ static ext4_fsblk_t ext4_get_inode_block
 	 */
 	offset = ((ino - 1) % EXT4_INODES_PER_GROUP(sb)) *
 		EXT4_INODE_SIZE(sb);
-	block = EXT4_INODE_TABLE((gdp+desc),
-			ext4_group_first_block_no(sb, block_group)) +
+	block = ext4_inode_table(gdp + desc) +
 			(offset >> EXT4_BLOCK_SIZE_BITS(sb));
 
 	iloc->block_group = block_group;
@@ -2502,10 +2501,8 @@ static int __ext4_get_inode_loc(struct i
 			if (!desc)
 				goto make_io;
 
-			bitmap_bh = sb_getblk(inode->i_sb,
-				EXT4_INODE_BITMAP(desc,
-				     ext4_group_first_block_no(inode->i_sb,
-						     block_group)));
+			bitmap_bh = sb_getblk(inode->i_sb, 
+				ext4_inode_bitmap(desc));
 			if (!bitmap_bh)
 				goto make_io;
 
Index: linux-2.6.18-rc6/fs/ext4/super.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/super.c	2006-09-08 14:37:44.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/super.c	2006-09-08 14:56:00.000000000 +0200
@@ -74,31 +74,41 @@ ext4_fsblk_t ext4_r_blocks_count(struct 
 				(__u64)le32_to_cpu(es->s_r_blocks_count));
 }
 
-u32 ext4_relative_encode(ext4_fsblk_t group_base, ext4_fsblk_t fs_block)
-{
-	s32 gdp_block;
-
-	if (fs_block < (1ULL<<32) && group_base < (1ULL<<32))
-		return fs_block;
-
-	gdp_block = (fs_block - group_base);
-	BUG_ON ((group_base + gdp_block) != fs_block);
-
-	return gdp_block;
-}
-
-ext4_fsblk_t ext4_relative_decode(ext4_fsblk_t group_base, u32 gdp_block)
-{
-	if (group_base >= (1ULL<<32))
-		return group_base + (s32) gdp_block;
-
-	if ((s32) gdp_block >= 0 && gdp_block < group_base &&
-	   	  group_base + gdp_block >= (1ULL<<32))
-		return group_base + gdp_block;
-
-	return gdp_block;
-}
-
+ext4_fsblk_t ext4_block_bitmap(struct ext4_group_desc *bg)
+{	
+	return le32_to_cpu(bg->bg_block_bitmap) | 
+		((ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi) << 32);
+}	
+
+ext4_fsblk_t ext4_inode_bitmap(struct ext4_group_desc *bg)
+{	
+	return le32_to_cpu(bg->bg_inode_bitmap) | 
+		((ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi) << 32);
+}	
+
+ext4_fsblk_t ext4_inode_table(struct ext4_group_desc *bg)
+{	
+	return le32_to_cpu(bg->bg_inode_table) | 
+		((ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi) << 32);
+}	
+
+void ext4_block_bitmap_set(struct ext4_group_desc *bg, ext4_fsblk_t blk)
+{	
+	bg->bg_block_bitmap    = cpu_to_le32((u32)blk);
+	bg->bg_block_bitmap_hi = cpu_to_le32(blk >> 32);
+}	
+
+void ext4_inode_bitmap_set(struct ext4_group_desc *bg, ext4_fsblk_t blk)
+{	
+	bg->bg_inode_bitmap    = cpu_to_le32((u32)blk);
+	bg->bg_inode_bitmap_hi = cpu_to_le32(blk >> 32);
+}	
+
+void ext4_inode_table_set(struct ext4_group_desc *bg, ext4_fsblk_t blk)
+{	
+	bg->bg_inode_table    = cpu_to_le32((u32)blk);
+	bg->bg_inode_table_hi = cpu_to_le32(blk >> 32);
+}	
 
 static void ext4_free_blocks_count_set(struct ext4_super_block *es, __u32 v)
 {
@@ -1194,41 +1204,32 @@ static int ext4_check_descriptors (struc
 		if ((i % EXT4_DESC_PER_BLOCK(sb)) == 0)
 			gdp = (struct ext4_group_desc *)
 					sbi->s_group_desc[desc_block++]->b_data;
-		if (EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, i)) <
-				block ||
-		    	EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, i)) >=
-				block + EXT4_BLOCKS_PER_GROUP(sb))
+		if (ext4_block_bitmap(gdp) < block ||
+		    ext4_block_bitmap(gdp) >= block + EXT4_BLOCKS_PER_GROUP(sb))
 		{
 			ext4_error (sb, "ext4_check_descriptors",
 				    "Block bitmap for group %d"
-				    " not in group (block %lu)!",
-				    i, (unsigned long)
-					EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, i)));
+				    " not in group (block %llu)!",
+				    i, ext4_block_bitmap(gdp));
 			return 0;
 		}
-		if (EXT4_INODE_BITMAP(gdp, ext4_group_first_block_no(sb, i)) <
-				block ||
-		    EXT4_INODE_BITMAP(gdp, ext4_group_first_block_no(sb, i)) >=
-				block + EXT4_BLOCKS_PER_GROUP(sb))
+		if (ext4_inode_bitmap(gdp) < block ||
+		    ext4_inode_bitmap(gdp) >= block + EXT4_BLOCKS_PER_GROUP(sb))
 		{
 			ext4_error (sb, "ext4_check_descriptors",
 				    "Inode bitmap for group %d"
-				    " not in group (block %lu)!",
-				    i, (unsigned long)
-					EXT4_INODE_BITMAP(gdp, ext4_group_first_block_no(sb, i)));
+				    " not in group (block %llu)!",
+				    i, ext4_inode_bitmap(gdp));
 			return 0;
 		}
-		if (EXT4_INODE_TABLE(gdp, ext4_group_first_block_no(sb, i)) <
-			block ||
-		    EXT4_INODE_TABLE(gdp, ext4_group_first_block_no(sb, i)) +
-							sbi->s_itb_per_group >=
+		if (ext4_inode_table(gdp) < block ||
+		    ext4_inode_table(gdp) + sbi->s_itb_per_group >=
 			block + EXT4_BLOCKS_PER_GROUP(sb))
 		{
 			ext4_error (sb, "ext4_check_descriptors",
 				    "Inode table for group %d"
-				    " not in group (block %lu)!",
-				    i, (unsigned long)
-					EXT4_INODE_TABLE(gdp, ext4_group_first_block_no(sb, i)));
+				    " not in group (block %llu)!",
+				    i, ext4_inode_table(gdp));
 			return 0;
 		}
 		block += EXT4_BLOCKS_PER_GROUP(sb);
