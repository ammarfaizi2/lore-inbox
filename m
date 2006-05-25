Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWEYM5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWEYM5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWEYM5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:57:21 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:23510 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965157AbWEYM5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:57:20 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][20/24]ext2resize fix resize_inode format
Message-Id: <20060525215712sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:57:12 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [20/24] fix the bug related to the option "resize_inode"
          - A format of resize-inode in ext2prepare is different from
            the one in mke2fs, so ext2prepare fails.  Then I adapt
            ext2prepare's to mke2fs's.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -Nurp old/ext2resize-1.1.19/src/ext2.c ext2resize-1.1.19/src/ext2.c
--- old/ext2resize-1.1.19/src/ext2.c	2004-09-30 22:01:40.000000000 +0800
+++ ext2resize-1.1.19/src/ext2.c	2006-03-20 21:45:13.000000000 +0800
@@ -286,6 +286,7 @@ void ext2_set_inode_state(struct ext2_fs
 	}
 }
 
+/* Remind: prototype returns int, but it may return blk_t */
 int ext2_block_iterate(struct ext2_fs *fs, struct ext2_inode *inode,
 		       blk_t block, int action)
 {
@@ -295,6 +296,9 @@ int ext2_block_iterate(struct ext2_fs *f
 	int			 count = 0;
 	int			 i;
 	int			 i512perblock = 1 << (fs->logsize - 9);
+	unsigned long long 	apb;
+
+	apb = fs->u32perblock;
 
 	if (block == 0 || inode->i_mode == 0)
 		return -1;
@@ -313,114 +317,66 @@ int ext2_block_iterate(struct ext2_fs *f
 		}
 	}
 
-	/* Direct blocks for first 12 blocks */
-	for (i = 0, curblock = 0; i < EXT2_NDIR_BLOCKS; i++, curblock++) {
-		if (action == EXT2_ACTION_ADD && !inode->i_block[i]) {
-			size_t new_size = (curblock + 1) * fs->blocksize;
-
-			if (fs->flags & FL_DEBUG)
-				printf("add %d as direct block\n", curblock);
-			inode->i_block[i] = block;
-			/* i_blocks is in 512 byte blocks */
-			inode->i_blocks += i512perblock;
-			if (new_size > inode->i_size)
-				inode->i_size = new_size;
-
-			inode->i_mtime = time(NULL);
-			ext2_set_block_state(fs, block, 1,
-					     !(fs->flags & FL_ONLINE));
-			return curblock;
-		}
-		if (inode->i_block[i] == block) {
-			if (action == EXT2_ACTION_DELETE) {
-				if (fs->flags & FL_DEBUG)
-					printf("del %d as direct block\n",
-					      curblock);
-				inode->i_block[i] = 0;
-				inode->i_blocks -= i512perblock;
-				inode->i_mtime = time(NULL);
-				if (!(fs->flags & FL_ONLINE))
-					ext2_set_block_state(fs, block, 0, 1);
-			}
-			return i;
-		}
-		if (inode->i_block[i])
-			count += i512perblock;
-	}
-
-	count += inode->i_block[EXT2_IND_BLOCK] ? i512perblock : 0;
-	count += inode->i_block[EXT2_DIND_BLOCK] ? i512perblock : 0;
-	count += inode->i_block[EXT2_TIND_BLOCK] ? i512perblock : 0;
-
-	if (!inode->i_block[EXT2_IND_BLOCK] ||
-	    (count >= inode->i_blocks && action != EXT2_ACTION_ADD))
+	if(!inode->i_block[EXT2_DIND_BLOCK] && action != EXT2_ACTION_ADD)
 		return -1;
 
-	bh = ext2_bread(fs, inode->i_block[EXT2_IND_BLOCK]);
-	udata = (__u32 *)bh->data;
+	if (!inode->i_block[EXT2_DIND_BLOCK]) {
+		unsigned long long	inode_size;
+		blk_t	dindblk;
 
-	/* Indirect blocks for next 256/512/1024 blocks (for 1k/2k/4k blocks) */
-	for (i = 0; i < fs->u32perblock; i++, curblock++) {
-		if (action == EXT2_ACTION_ADD && !udata[i]) {
-			size_t new_size = (curblock + 1) * fs->blocksize;
-
-			if (fs->flags & FL_DEBUG)
-				printf("add %d to ind block %d\n", curblock,
-				       inode->i_block[EXT2_IND_BLOCK]);
-			bh->dirty = 1;
-			udata[i] = block;
-			inode->i_blocks += i512perblock;
-			if (new_size > inode->i_size)
-				inode->i_size = new_size;
-			inode->i_mtime = time(NULL);
-			ext2_set_block_state(fs, block, 1,
-					     !(fs->flags & FL_ONLINE));
-			ext2_brelse(bh, 0);
-			return curblock;
-		}
-		if (udata[i] == block) {
-			if (action == EXT2_ACTION_DELETE) {
-				if (fs->flags & FL_DEBUG)
-					printf("del %d from ind block %d\n",
-					      curblock,
-					      inode->i_block[EXT2_IND_BLOCK]);
-				bh->dirty = 1;
-				udata[i] = 0;
-				inode->i_blocks -= i512perblock;
-				inode->i_mtime = time(NULL);
-				if (!(fs->flags & FL_ONLINE))
-					ext2_set_block_state(fs, block, 0, 1);
-			}
-			ext2_brelse(bh, 0);
-			return curblock;
-		}
-		if (udata[i]) {
-			count += i512perblock;
-			if (count >= inode->i_blocks &&
-			    action != EXT2_ACTION_ADD)
-				return -1;
-		}
+		dindblk = ext2_find_free_block(fs);
+		if(!dindblk)
+			return -1;
+		ext2_set_block_state(fs, dindblk, 1, 1);
+		inode_size = apb*apb + apb + EXT2_NDIR_BLOCKS;
+		inode_size *= fs->blocksize;
+		inode->i_size = inode_size & 0xFFFFFFFF;
+		inode->i_size_high = (inode_size >> 32) & 0xFFFFFFFF;
+		if(inode->i_size_high) {
+			fs->sb.s_feature_ro_compat |=
+				EXT2_FEATURE_RO_COMPAT_LARGE_FILE;
+		}
+		inode->i_mtime = time(NULL);
+
+		inode->i_block[EXT2_DIND_BLOCK] = dindblk;
+		bh = ext2_bread(fs, inode->i_block[EXT2_DIND_BLOCK]);
+		memset(bh->data, 0, fs->blocksize);
+		inode->i_blocks += i512perblock;
 	}
+	else
+		bh = ext2_bread(fs, inode->i_block[EXT2_DIND_BLOCK]);
 
-	ext2_brelse(bh, 0);
-
-	if (!inode->i_block[EXT2_DIND_BLOCK] ||
-	    (count >= inode->i_blocks && action != EXT2_ACTION_ADD))
-		return -1;
-	bh = ext2_bread(fs, inode->i_block[EXT2_DIND_BLOCK]);
 	udata = (__u32 *)bh->data;
+	curblock = apb*apb + apb + EXT2_NDIR_BLOCKS;
 
 	/* Double indirect blocks for next 2^16/2^18/2^20 1k/2k/4k blocks */
 	for (i = 0; i < fs->u32perblock; i++) {
 		struct ext2_buffer_head	*bh2;
 		__u32			*udata2;
 		int			 j;
+		int grp, gdb_offset;
 
-		if (!udata[i]) {
+		gdb_offset = fs->sb.s_first_data_block + 1;
+		grp = block/fs->sb.s_blocks_per_group;
+		if(grp == 0 && action == EXT2_ACTION_ADD) {
+			udata[(block - gdb_offset)%fs->u32perblock] = block;
+			ext2_zero_blocks(fs, block, 1);
+			ext2_set_block_state(fs, block, 1, 1);
+			bh->dirty = 1;
+			inode->i_blocks += i512perblock;
+			inode->i_mtime = time(NULL);
 			ext2_brelse(bh, 0);
-			ext2_brelse(bh2, 0);
-			return -1;
+			return 1;
+		}
+		if (!udata[i])
+			continue;
+		if(udata[i] == block){
+			ext2_brelse(bh, 0);
+			return 1;
 		}
+		if(((block - gdb_offset)%fs->u32perblock) != i)
+			continue;
+
 		bh2 = ext2_bread(fs, udata[i]);
 		udata2 = (__u32 *)bh2->data;
 		count += i512perblock;
@@ -1044,3 +1000,51 @@ error_free_fs:
 error:
 	return NULL;
 }
+
+/* Update resize_inode's blocks */
+void ext2_fix_resize_inode(struct ext2_fs *fs) {
+	if (fs->sb.s_feature_compat & EXT2_FEATURE_COMPAT_RESIZE_INODE) {
+		int i;
+		blk_t block;
+		struct ext2_inode * inode;
+
+		ext2_read_inode(fs, EXT2_RESIZE_INO, &fs->resize);
+		inode = &fs->resize;
+		inode->i_mtime = 0;
+
+		if (inode->i_block[EXT2_DIND_BLOCK]) {
+			ext2_zero_blocks(fs, inode->i_block[EXT2_DIND_BLOCK], 1);
+			inode->i_blocks = 1 << (fs->logsize - 9);
+		}
+
+		for (i = 0, block = fs->sb.s_first_data_block + fs->newgdblocks + 1;
+		     i < fs->newgroups; i++, block += fs->sb.s_blocks_per_group) {
+			int j;
+
+			if (!ext2_bg_has_super(fs, i))
+				continue;
+			for (j = 0; j < fs->resgdblocks; j++) {
+				if(i == 0)
+					ext2_zero_blocks(fs, block + j, 1);
+
+				if (j < fs->blocksize / 4){
+					if (ext2_get_block_state(fs, block + j))
+						ext2_set_block_state(fs, block + j, 0, 1);
+					ext2_block_iterate(fs, inode, block + j, EXT2_ACTION_ADD);
+				}
+				else{
+					if (ext2_get_block_state(fs, block + j))
+						ext2_set_block_state(fs, block + j, 0, 1);
+				}
+			}
+		}
+
+		fs->sb.s_reserved_gdt_blocks = fs->resgdblocks;
+		if (fs->resgdblocks > fs->blocksize / 4)
+			fs->sb.s_reserved_gdt_blocks = fs->blocksize / 4;
+		fs->metadirty |= EXT2_META_SB;
+		
+		if (inode->i_mtime)
+			ext2_write_inode(fs, EXT2_RESIZE_INO, inode);
+	}
+}
diff -Nurp old/ext2resize-1.1.19/src/ext2.h ext2resize-1.1.19/src/ext2.h
--- old/ext2resize-1.1.19/src/ext2.h	2002-12-11 08:05:12.000000000 +0800
+++ ext2resize-1.1.19/src/ext2.h	2006-03-20 21:45:13.000000000 +0800
@@ -242,6 +242,8 @@ loff_t ext2_llseek(unsigned int fd, loff
 struct ext2_dev_handle *ext2_make_dev_handle_from_file(char *dev, char *dir,
 						       char *prog);
 
+void ext2_fix_resize_inode(struct ext2_fs *fs);
+
 #define set_bit(buf, offset)	buf[(offset)>>3] |= _bitmap[(offset)&7]
 #define clear_bit(buf, offset)	buf[(offset)>>3] &= ~_bitmap[(offset)&7]
 #define check_bit(buf, offset)	(buf[(offset)>>3] & _bitmap[(offset)&7])
diff -Nurp old/ext2resize-1.1.19/src/ext2online.c ext2resize-1.1.19/src/ext2online.c
--- old/ext2resize-1.1.19/src/ext2online.c	2004-09-30 22:12:01.000000000 +0800
+++ ext2resize-1.1.19/src/ext2online.c	2006-03-20 21:45:13.000000000 +0800
@@ -551,24 +551,7 @@ static blk_t ext2_online_primary(struct 
  */
 static void ext2_online_finish(struct ext2_fs *fs)
 {
-	int			 group;
-	blk_t			 block;
-	blk_t			 gdb;
-
-	/* Remove blocks as required from Bond inode */
-	for (group = 0, gdb = fs->sb.s_first_data_block + 1;
-	     group < fs->numgroups;
-	     group++, gdb += fs->sb.s_blocks_per_group)
-		if (ext2_bg_has_super(fs, group))
-			for (block = fs->gdblocks;
-			     block < fs->newgdblocks;
-			     block++) {
-				if (fs->flags & FL_DEBUG)
-					printf("Checking for group block %d "
-					       "in Bond\n", gdb);
-				ext2_block_iterate(fs, &fs->resize, gdb + block,
-						   EXT2_ACTION_DELETE);
-			}
+	ext2_fix_resize_inode(fs);
 
 	/* Save the new number of reserved GDT blocks in the resize inode */
 	fs->resize.i_generation = fs->resgdblocks + fs->gdblocks -
diff -Nurp old/ext2resize-1.1.19/src/ext2prepare.c ext2resize-1.1.19/src/ext2prepare.c
--- old/ext2resize-1.1.19/src/ext2prepare.c	2004-09-30 22:04:05.000000000 +0800
+++ ext2resize-1.1.19/src/ext2prepare.c	2006-03-20 21:45:13.000000000 +0800
@@ -155,6 +155,7 @@ int create_resize_inode(struct ext2_fs *
 	fs->sb.s_feature_compat |= EXT2_FEATURE_COMPAT_RESIZE_INODE;
 
 	diff = fs->newgdblocks - fs->gdblocks;
+	fs->resgdblocks = fs->sb.s_reserved_gdt_blocks = diff;
 	/* we store the number of reserved blocks in the inode version field */
 	inode->i_generation = diff;
 
diff -Nurp old/ext2resize-1.1.19/src/ext2_resize.c ext2resize-1.1.19/src/ext2_resize.c
--- old/ext2resize-1.1.19/src/ext2_resize.c	2004-09-30 22:01:41.000000000 +0800
+++ ext2resize-1.1.19/src/ext2_resize.c	2006-03-20 21:45:13.000000000 +0800
@@ -78,7 +78,8 @@ static int ext2_add_group(struct ext2_fs
 					ext2_block_iterate(fs, inode,
 							   start+fs->gdblocks+1,
 							   EXT2_ACTION_DELETE);
-				ext2_set_block_state(fs, start +fs->gdblocks +1,
+				if(group!=0 || !ext2_get_block_state(fs, start + fs->gdblocks + 1))
+					ext2_set_block_state(fs, start + fs->gdblocks + 1,
 						     1, 1);
 			}
 		}
@@ -480,6 +481,9 @@ int ext2_resize_fs(struct ext2_fs *fs)
 	else
 		status = ext2_grow_fs(fs);
 
+	if (status)
+		ext2_fix_resize_inode(fs);
+
 	free(fs->relocator_pool);
 	fs->relocator_pool = NULL;
 	fs->relocator_pool_end = NULL;

 


