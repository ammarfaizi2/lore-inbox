Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319543AbSH3LBR>; Fri, 30 Aug 2002 07:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319545AbSH3LBQ>; Fri, 30 Aug 2002 07:01:16 -0400
Received: from iv.ro ([194.105.28.94]:6281 "HELO iv.ro") by vger.kernel.org
	with SMTP id <S319543AbSH3LBK>; Fri, 30 Aug 2002 07:01:10 -0400
Date: Fri, 30 Aug 2002 14:10:25 +0000 (/etc/localtime)
From: Jani Monoses <jani@iv.ro>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.32 : u.ext3_sb -> generic_sbp
Message-ID: <Pine.LNX.4.21.0001010429580.1200-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This turns the remaining parts of ext3 to EXT3_SB and turns the latter
from a macro to inline function which returns the generic_sbp field of u.
linux/fs.h is not touched by this patch though.
Intermezzo's three uses of ext3_sb are also not changed.
Tested.

diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/balloc.c linux-2.5/fs/ext3/balloc.c
--- linux.orig/fs/ext3/balloc.c	Sat Jul 27 02:58:27 2002
+++ linux-2.5/fs/ext3/balloc.c	Fri Aug 30 00:00:50 2002
@@ -46,18 +46,18 @@
 	unsigned long desc;
 	struct ext3_group_desc * gdp;
 
-	if (block_group >= sb->u.ext3_sb.s_groups_count) {
+	if (block_group >= EXT3_SB(sb)->s_groups_count) {
 		ext3_error (sb, "ext3_get_group_desc",
 			    "block_group >= groups_count - "
 			    "block_group = %d, groups_count = %lu",
-			    block_group, sb->u.ext3_sb.s_groups_count);
+			    block_group, EXT3_SB(sb)->s_groups_count);
 
 		return NULL;
 	}
 	
 	group_desc = block_group / EXT3_DESC_PER_BLOCK(sb);
 	desc = block_group % EXT3_DESC_PER_BLOCK(sb);
-	if (!sb->u.ext3_sb.s_group_desc[group_desc]) {
+	if (!EXT3_SB(sb)->s_group_desc[group_desc]) {
 		ext3_error (sb, "ext3_get_group_desc",
 			    "Group descriptor not loaded - "
 			    "block_group = %d, group_desc = %lu, desc = %lu",
@@ -66,9 +66,9 @@
 	}
 	
 	gdp = (struct ext3_group_desc *) 
-	      sb->u.ext3_sb.s_group_desc[group_desc]->b_data;
+	      EXT3_SB(sb)->s_group_desc[group_desc]->b_data;
 	if (bh)
-		*bh = sb->u.ext3_sb.s_group_desc[group_desc];
+		*bh = EXT3_SB(sb)->s_group_desc[group_desc];
 	return gdp + desc;
 }
 
@@ -119,7 +119,7 @@
 		return;
 	}
 	lock_super (sb);
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) || 
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext3_error (sb, "ext3_free_blocks",
@@ -155,9 +155,9 @@
 	if (in_range (le32_to_cpu(gdp->bg_block_bitmap), block, count) ||
 	    in_range (le32_to_cpu(gdp->bg_inode_bitmap), block, count) ||
 	    in_range (block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group) ||
+		      EXT3_SB(sb)->s_itb_per_group) ||
 	    in_range (block + count - 1, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group))
+		      EXT3_SB(sb)->s_itb_per_group))
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %lu, count = %lu",
@@ -183,8 +183,8 @@
 	if (err)
 		goto error_return;
 
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get_write_access");
-	err = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
 	if (err)
 		goto error_return;
 
@@ -253,8 +253,8 @@
 	if (!err) err = ret;
 
 	/* And the superblock */
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "dirtied superblock");
-	ret = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "dirtied superblock");
+	ret = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	if (!err) err = ret;
 
 	if (overflow && !err) {
@@ -408,12 +408,12 @@
 	}
 
 	lock_super(sb);
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <=
 			le32_to_cpu(es->s_r_blocks_count) &&
-	    ((sb->u.ext3_sb.s_resuid != current->fsuid) &&
-	     (sb->u.ext3_sb.s_resgid == 0 ||
-	      !in_group_p(sb->u.ext3_sb.s_resgid)) && 
+	    ((EXT3_SB(sb)->s_resuid != current->fsuid) &&
+	     (EXT3_SB(sb)->s_resgid == 0 ||
+	      !in_group_p(EXT3_SB(sb)->s_resgid)) && 
 	     !capable(CAP_SYS_RESOURCE)))
 		goto out;
 
@@ -464,9 +464,9 @@
 	 * Now search the rest of the groups.  We assume that 
 	 * i and gdp correctly point to the last group visited.
 	 */
-	for (bit = 0; bit < sb->u.ext3_sb.s_groups_count; bit++) {
+	for (bit = 0; bit < EXT3_SB(sb)->s_groups_count; bit++) {
 		group_no++;
-		if (group_no >= sb->u.ext3_sb.s_groups_count)
+		if (group_no >= EXT3_SB(sb)->s_groups_count)
 			group_no = 0;
 		gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
 		if (!gdp) {
@@ -518,8 +518,8 @@
 	if (fatal)
 		goto out;
 
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get_write_access");
-	fatal = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
+	fatal = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
 	if (fatal)
 		goto out;
 
@@ -529,7 +529,7 @@
 	if (target_block == le32_to_cpu(gdp->bg_block_bitmap) ||
 	    target_block == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group))
+		      EXT3_SB(sb)->s_itb_per_group))
 		ext3_error(sb, "ext3_new_block",
 			    "Allocating block in system zone - "
 			    "block = %u", target_block);
@@ -594,9 +594,9 @@
 	if (!fatal)
 		fatal = err;
 
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh,
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh,
 			"journal_dirty_metadata for superblock");
-	err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
+	err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	if (!fatal)
 		fatal = err;
 
@@ -637,11 +637,11 @@
 	int i;
 	
 	lock_super(sb);
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext3_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
 		gdp = ext3_get_group_desc(sb, i, NULL);
 		if (!gdp)
 			continue;
@@ -662,7 +662,7 @@
 	unlock_super(sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(sb->u.ext3_sb.s_es->s_free_blocks_count);
+	return le32_to_cpu(EXT3_SB(sb)->s_es->s_free_blocks_count);
 #endif
 }
 
@@ -671,7 +671,7 @@
 				unsigned char * map)
 {
 	return ext3_test_bit ((block -
-		le32_to_cpu(sb->u.ext3_sb.s_es->s_first_data_block)) %
+		le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block)) %
 			 EXT3_BLOCKS_PER_GROUP(sb), map);
 }
 
@@ -738,11 +738,11 @@
 	struct ext3_group_desc *gdp;
 	int i;
 
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext3_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
 		gdp = ext3_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
@@ -776,7 +776,7 @@
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
-		for (j = 0; j < sb->u.ext3_sb.s_itb_per_group; j++)
+		for (j = 0; j < EXT3_SB(sb)->s_itb_per_group; j++)
 			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j,
 							sb, bitmap_bh->b_data))
 				ext3_error (sb, "ext3_check_blocks_bitmap",
diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/dir.c linux-2.5/fs/ext3/dir.c
--- linux.orig/fs/ext3/dir.c	Mon Aug 19 14:15:39 2002
+++ linux-2.5/fs/ext3/dir.c	Fri Aug 30 01:13:42 2002
@@ -54,7 +54,7 @@
 	else if (((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize)
 		error_msg = "directory entry across blocks";
 	else if (le32_to_cpu(de->inode) >
-			le32_to_cpu(dir->i_sb->u.ext3_sb.s_es->s_inodes_count))
+			le32_to_cpu(EXT3_SB(dir->i_sb)->s_es->s_inodes_count))
 		error_msg = "inode out of bounds";
 
 	if (error_msg != NULL)
diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/ialloc.c linux-2.5/fs/ext3/ialloc.c
--- linux.orig/fs/ext3/ialloc.c	Sat Jul 27 02:58:38 2002
+++ linux-2.5/fs/ext3/ialloc.c	Fri Aug 30 00:03:25 2002
@@ -127,7 +127,7 @@
 	clear_inode (inode);
 
 	lock_super (sb);
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	if (ino < EXT3_FIRST_INO(sb) || ino > le32_to_cpu(es->s_inodes_count)) {
 		ext3_error (sb, "ext3_free_inode",
 			    "reserved or nonexistent inode %lu", ino);
@@ -155,8 +155,8 @@
 		fatal = ext3_journal_get_write_access(handle, bh2);
 		if (fatal) goto error_return;
 
-		BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get write access");
-		fatal = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
+		BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get write access");
+		fatal = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
 		if (fatal) goto error_return;
 
 		if (gdp) {
@@ -171,9 +171,9 @@
 		if (!fatal) fatal = err;
 		es->s_free_inodes_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		BUFFER_TRACE(sb->u.ext3_sb.s_sbh,
+		BUFFER_TRACE(EXT3_SB(sb)->s_sbh,
 					"call ext3_journal_dirty_metadata");
-		err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
+		err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 		if (!fatal) fatal = err;
 	}
 	BUFFER_TRACE(bitmap_bh, "call ext3_journal_dirty_metadata");
@@ -222,16 +222,16 @@
 	ei = EXT3_I(inode);
 
 	lock_super (sb);
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 repeat:
 	gdp = NULL;
 	i = 0;
 
 	if (S_ISDIR(mode)) {
 		avefreei = le32_to_cpu(es->s_free_inodes_count) /
-			sb->u.ext3_sb.s_groups_count;
+			EXT3_SB(sb)->s_groups_count;
 		if (!gdp) {
-			for (j = 0; j < sb->u.ext3_sb.s_groups_count; j++) {
+			for (j = 0; j < EXT3_SB(sb)->s_groups_count; j++) {
 				struct buffer_head *temp_buffer;
 				tmp = ext3_get_group_desc (sb, j, &temp_buffer);
 				if (tmp &&
@@ -261,10 +261,10 @@
 			 * Use a quadratic hash to find a group with a
 			 * free inode
 			 */
-			for (j = 1; j < sb->u.ext3_sb.s_groups_count; j <<= 1) {
+			for (j = 1; j < EXT3_SB(sb)->s_groups_count; j <<= 1) {
 				i += j;
-				if (i >= sb->u.ext3_sb.s_groups_count)
-					i -= sb->u.ext3_sb.s_groups_count;
+				if (i >= EXT3_SB(sb)->s_groups_count)
+					i -= EXT3_SB(sb)->s_groups_count;
 				tmp = ext3_get_group_desc (sb, i, &bh2);
 				if (tmp &&
 				    le16_to_cpu(tmp->bg_free_inodes_count)) {
@@ -278,8 +278,8 @@
 			 * That failed: try linear search for a free inode
 			 */
 			i = EXT3_I(dir)->i_block_group + 1;
-			for (j = 2; j < sb->u.ext3_sb.s_groups_count; j++) {
-				if (++i >= sb->u.ext3_sb.s_groups_count)
+			for (j = 2; j < EXT3_SB(sb)->s_groups_count; j++) {
+				if (++i >= EXT3_SB(sb)->s_groups_count)
 					i = 0;
 				tmp = ext3_get_group_desc (sb, i, &bh2);
 				if (tmp &&
@@ -357,13 +357,13 @@
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
 	
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get_write_access");
-	err = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
 	if (err) goto fail;
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "call ext3_journal_dirty_metadata");
-	err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "call ext3_journal_dirty_metadata");
+	err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	if (err) goto fail;
 
@@ -417,7 +417,7 @@
 	if (IS_DIRSYNC(inode))
 		handle->h_sync = 1;
 	insert_inode_hash(inode);
-	inode->i_generation = sb->u.ext3_sb.s_next_generation++;
+	inode->i_generation = EXT3_SB(sb)->s_next_generation++;
 
 	ei->i_state = EXT3_STATE_NEW;
 	err = ext3_mark_inode_dirty(handle, inode);
@@ -512,11 +512,11 @@
 	int i;
 
 	lock_super (sb);
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext3_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
 		gdp = ext3_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
@@ -537,7 +537,7 @@
 	unlock_super(sb);
 	return desc_count;
 #else
-	return le32_to_cpu(sb->u.ext3_sb.s_es->s_free_inodes_count);
+	return le32_to_cpu(EXT3_SB(sb)->s_es->s_free_inodes_count);
 #endif
 }
 
@@ -551,11 +551,11 @@
 	struct ext3_group_desc * gdp;
 	int i;
 
-	es = sb->u.ext3_sb.s_es;
+	es = EXT3_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext3_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
 		gdp = ext3_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/inode.c linux-2.5/fs/ext3/inode.c
--- linux.orig/fs/ext3/inode.c	Mon Aug 19 14:15:39 2002
+++ linux-2.5/fs/ext3/inode.c	Fri Aug 30 01:13:20 2002
@@ -471,7 +471,7 @@
 	 * the same cylinder group then.
 	 */
 	return (ei->i_block_group * EXT3_BLOCKS_PER_GROUP(inode->i_sb)) +
-	       le32_to_cpu(inode->i_sb->u.ext3_sb.s_es->s_first_data_block);
+	       le32_to_cpu(EXT3_SB(inode->i_sb)->s_es->s_first_data_block);
 }
 
 /**
@@ -2055,20 +2055,20 @@
 		inode->i_ino != EXT3_JOURNAL_INO &&
 		inode->i_ino < EXT3_FIRST_INO(inode->i_sb)) ||
 		inode->i_ino > le32_to_cpu(
-			inode->i_sb->u.ext3_sb.s_es->s_inodes_count)) {
+			EXT3_SB(inode->i_sb)->s_es->s_inodes_count)) {
 		ext3_error (inode->i_sb, "ext3_get_inode_loc",
 			    "bad inode number: %lu", inode->i_ino);
 		goto bad_inode;
 	}
 	block_group = (inode->i_ino - 1) / EXT3_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext3_sb.s_groups_count) {
+	if (block_group >= EXT3_SB(inode->i_sb)->s_groups_count) {
 		ext3_error (inode->i_sb, "ext3_get_inode_loc",
 			    "group >= groups count");
 		goto bad_inode;
 	}
 	group_desc = block_group >> EXT3_DESC_PER_BLOCK_BITS(inode->i_sb);
 	desc = block_group & (EXT3_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext3_sb.s_group_desc[group_desc];
+	bh = EXT3_SB(inode->i_sb)->s_group_desc[group_desc];
 	if (!bh) {
 		ext3_error (inode->i_sb, "ext3_get_inode_loc",
 			    "Descriptor not loaded");
@@ -2138,7 +2138,7 @@
 	 */
 	if (inode->i_nlink == 0) {
 		if (inode->i_mode == 0 ||
-		    !(inode->i_sb->u.ext3_sb.s_mount_state & EXT3_ORPHAN_FS)) {
+		    !(EXT3_SB(inode->i_sb)->s_mount_state & EXT3_ORPHAN_FS)) {
 			/* this inode is deleted */
 			brelse (bh);
 			goto bad_inode;
@@ -2308,7 +2308,7 @@
 				* created, add a flag to the superblock.
 				*/
 				err = ext3_journal_get_write_access(handle,
-						sb->u.ext3_sb.s_sbh);
+						EXT3_SB(sb)->s_sbh);
 				if (err)
 					goto out_brelse;
 				ext3_update_dynamic_rev(sb);
@@ -2317,7 +2317,7 @@
 				sb->s_dirt = 1;
 				handle->h_sync = 1;
 				err = ext3_journal_dirty_metadata(handle,
-						sb->u.ext3_sb.s_sbh);
+						EXT3_SB(sb)->s_sbh);
 			}
 		}
 	}
diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/ioctl.c linux-2.5/fs/ext3/ioctl.c
--- linux.orig/fs/ext3/ioctl.c	Sat Jul 27 02:58:36 2002
+++ linux-2.5/fs/ext3/ioctl.c	Fri Aug 30 00:08:16 2002
@@ -159,12 +159,12 @@
 			int ret = 0;
 
 			set_current_state(TASK_INTERRUPTIBLE);
-			add_wait_queue(&sb->u.ext3_sb.ro_wait_queue, &wait);
-			if (timer_pending(&sb->u.ext3_sb.turn_ro_timer)) {
+			add_wait_queue(&EXT3_SB(sb)->ro_wait_queue, &wait);
+			if (timer_pending(&EXT3_SB(sb)->turn_ro_timer)) {
 				schedule();
 				ret = 1;
 			}
-			remove_wait_queue(&sb->u.ext3_sb.ro_wait_queue, &wait);
+			remove_wait_queue(&EXT3_SB(sb)->ro_wait_queue, &wait);
 			return ret;
 		}
 #endif
diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/namei.c linux-2.5/fs/ext3/namei.c
--- linux.orig/fs/ext3/namei.c	Mon Aug 19 14:15:39 2002
+++ linux-2.5/fs/ext3/namei.c	Fri Aug 30 00:09:51 2002
@@ -729,8 +729,8 @@
 	J_ASSERT ((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get_write_access");
-	err = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
 	if (err)
 		goto out_unlock;
 	
@@ -741,7 +741,7 @@
 	/* Insert this inode at the head of the on-disk orphan list... */
 	NEXT_ORPHAN(inode) = le32_to_cpu(EXT3_SB(sb)->s_es->s_last_orphan);
 	EXT3_SB(sb)->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
-	err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
+	err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	rc = ext3_mark_iloc_dirty(handle, inode, &iloc);
 	if (!err)
 		err = rc;
diff -X /home/jani/dontdiff -ur linux.orig/fs/ext3/super.c linux-2.5/fs/ext3/super.c
--- linux.orig/fs/ext3/super.c	Mon Aug 19 14:15:53 2002
+++ linux-2.5/fs/ext3/super.c	Fri Aug 30 10:39:37 2002
@@ -120,7 +120,7 @@
 	/* If no overrides were specified on the mount, then fall back
 	 * to the default behaviour set in the filesystem's superblock
 	 * on disk. */
-	switch (le16_to_cpu(sb->u.ext3_sb.s_es->s_errors)) {
+	switch (le16_to_cpu(EXT3_SB(sb)->s_es->s_errors)) {
 	case EXT3_ERRORS_PANIC:
 		return EXT3_ERRORS_PANIC;
 	case EXT3_ERRORS_RO:
@@ -268,9 +268,9 @@
 		return;
 	
 	printk (KERN_CRIT "Remounting filesystem read-only\n");
-	sb->u.ext3_sb.s_mount_state |= EXT3_ERROR_FS;
+	EXT3_SB(sb)->s_mount_state |= EXT3_ERROR_FS;
 	sb->s_flags |= MS_RDONLY;
-	sb->u.ext3_sb.s_mount_opt |= EXT3_MOUNT_ABORT;
+	EXT3_SB(sb)->s_mount_opt |= EXT3_MOUNT_ABORT;
 	journal_abort(EXT3_SB(sb)->s_journal, -EIO);
 }
 
@@ -439,7 +439,8 @@
 		ext3_blkdev_remove(sbi);
 	}
 	clear_ro_after(sb);
-
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 	return;
 }
 
@@ -873,7 +874,7 @@
 		sb->s_flags &= ~MS_RDONLY;
 	}
 
-	if (sb->u.ext3_sb.s_mount_state & EXT3_ERROR_FS) {
+	if (EXT3_SB(sb)->s_mount_state & EXT3_ERROR_FS) {
 		if (es->s_last_orphan)
 			jbd_debug(1, "Errors on filesystem, "
 				  "clearing orphan list.\n");
@@ -945,7 +946,7 @@
 {
 	struct buffer_head * bh;
 	struct ext3_super_block *es = 0;
-	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	struct ext3_sb_info *sbi;
 	unsigned long sb_block = 1;
 	unsigned long logic_sb_block = 1;
 	unsigned long offset = 0;
@@ -966,7 +967,11 @@
 	 * This is important for devices that have a hardware
 	 * sectorsize that is larger than the default.
 	 */
-
+	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(*sbi));
 	sbi->s_mount_opt = 0;
 	sbi->s_resuid = EXT3_DEF_RESUID;
 	sbi->s_resgid = EXT3_DEF_RESGID;
@@ -1262,6 +1267,8 @@
 	ext3_blkdev_remove(sbi);
 	brelse(bh);
 out_fail:
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 	return -EINVAL;
 }
 
@@ -1516,11 +1523,11 @@
 			       int sync)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "marking dirty");
-	mark_buffer_dirty(sb->u.ext3_sb.s_sbh);
+	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "marking dirty");
+	mark_buffer_dirty(EXT3_SB(sb)->s_sbh);
 	if (sync) {
-		ll_rw_block(WRITE, 1, &sb->u.ext3_sb.s_sbh);
-		wait_on_buffer(sb->u.ext3_sb.s_sbh);
+		ll_rw_block(WRITE, 1, &EXT3_SB(sb)->s_sbh);
+		wait_on_buffer(EXT3_SB(sb)->s_sbh);
 	}
 }
 
@@ -1571,7 +1578,7 @@
 		ext3_warning(sb, __FUNCTION__, "Marking fs in need of "
 			     "filesystem check.");
 		
-		sb->u.ext3_sb.s_mount_state |= EXT3_ERROR_FS;
+		EXT3_SB(sb)->s_mount_state |= EXT3_ERROR_FS;
 		es->s_state |= cpu_to_le16(EXT3_ERROR_FS);
 		ext3_commit_super (sb, es, 1);
 
diff -X /home/jani/dontdiff -ur linux.orig/include/linux/ext3_fs.h linux-2.5/include/linux/ext3_fs.h
--- linux.orig/include/linux/ext3_fs.h	Sat Jul 27 02:58:26 2002
+++ linux-2.5/include/linux/ext3_fs.h	Fri Aug 30 10:21:58 2002
@@ -97,9 +97,9 @@
 # define EXT3_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
 #ifdef __KERNEL__
-#define	EXT3_ADDR_PER_BLOCK_BITS(s)	((s)->u.ext3_sb.s_addr_per_block_bits)
-#define EXT3_INODE_SIZE(s)		((s)->u.ext3_sb.s_inode_size)
-#define EXT3_FIRST_INO(s)		((s)->u.ext3_sb.s_first_ino)
+#define	EXT3_ADDR_PER_BLOCK_BITS(s)	(EXT3_SB(s)->s_addr_per_block_bits)
+#define EXT3_INODE_SIZE(s)		(EXT3_SB(s)->s_inode_size)
+#define EXT3_FIRST_INO(s)		(EXT3_SB(s)->s_first_ino)
 #else
 #define EXT3_INODE_SIZE(s)	(((s)->s_rev_level == EXT3_GOOD_OLD_REV) ? \
 				 EXT3_GOOD_OLD_INODE_SIZE : \
@@ -116,8 +116,8 @@
 #define	EXT3_MAX_FRAG_SIZE		4096
 #define EXT3_MIN_FRAG_LOG_SIZE		  10
 #ifdef __KERNEL__
-# define EXT3_FRAG_SIZE(s)		((s)->u.ext3_sb.s_frag_size)
-# define EXT3_FRAGS_PER_BLOCK(s)	((s)->u.ext3_sb.s_frags_per_block)
+# define EXT3_FRAG_SIZE(s)		(EXT3_SB(s)->s_frag_size)
+# define EXT3_FRAGS_PER_BLOCK(s)	(EXT3_SB(s)->s_frags_per_block)
 #else
 # define EXT3_FRAG_SIZE(s)		(EXT3_MIN_FRAG_SIZE << (s)->s_log_frag_size)
 # define EXT3_FRAGS_PER_BLOCK(s)	(EXT3_BLOCK_SIZE(s) / EXT3_FRAG_SIZE(s))
@@ -164,10 +164,10 @@
  * Macro-instructions used to manage group descriptors
  */
 #ifdef __KERNEL__
-# define EXT3_BLOCKS_PER_GROUP(s)	((s)->u.ext3_sb.s_blocks_per_group)
-# define EXT3_DESC_PER_BLOCK(s)		((s)->u.ext3_sb.s_desc_per_block)
-# define EXT3_INODES_PER_GROUP(s)	((s)->u.ext3_sb.s_inodes_per_group)
-# define EXT3_DESC_PER_BLOCK_BITS(s)	((s)->u.ext3_sb.s_desc_per_block_bits)
+# define EXT3_BLOCKS_PER_GROUP(s)	(EXT3_SB(s)->s_blocks_per_group)
+# define EXT3_DESC_PER_BLOCK(s)		(EXT3_SB(s)->s_desc_per_block)
+# define EXT3_INODES_PER_GROUP(s)	(EXT3_SB(s)->s_inodes_per_group)
+# define EXT3_DESC_PER_BLOCK_BITS(s)	(EXT3_SB(s)->s_desc_per_block_bits)
 #else
 # define EXT3_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
 # define EXT3_DESC_PER_BLOCK(s)		(EXT3_BLOCK_SIZE(s) / sizeof (struct ext3_group_desc))
@@ -346,7 +346,7 @@
 #ifndef _LINUX_EXT2_FS_H
 #define clear_opt(o, opt)		o &= ~EXT3_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT3_MOUNT_##opt
-#define test_opt(sb, opt)		((sb)->u.ext3_sb.s_mount_opt & \
+#define test_opt(sb, opt)		(EXT3_SB(sb)->s_mount_opt & \
 					 EXT3_MOUNT_##opt)
 #else
 #define EXT2_MOUNT_NOLOAD		EXT3_MOUNT_NOLOAD
@@ -444,7 +444,10 @@
 };
 
 #ifdef __KERNEL__
-#define EXT3_SB(sb)	(&((sb)->u.ext3_sb))
+static inline struct ext3_sb_info * EXT3_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 static inline struct ext3_inode_info *EXT3_I(struct inode *inode)
 {
 	return container_of(inode, struct ext3_inode_info, vfs_inode);

