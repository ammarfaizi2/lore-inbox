Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269256AbUI3N2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbUI3N2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUI3N1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:27:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269256AbUI3NYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:24:40 -0400
Date: Thu, 30 Sep 2004 14:24:00 +0100
Message-Id: <200409301324.i8UDO0Qw004809@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 9/10]: ext3 online resize: remove on-stack special resize inode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resize is currently using a dummy inode in order to return blocks to
the free list via ext3_free_blocks().

Refactor the core free-blocks code to use ext3_free_blocks_sb(), which
takes a super_block rather than an inode.  The resize code can now use
that to avoid the need for a dummy inode.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/balloc.c.=K0008=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/balloc.c
@@ -274,8 +274,9 @@ void ext3_discard_reservation(struct ino
 }
 
 /* Free given blocks, update quota and i_blocks field */
-void ext3_free_blocks(handle_t *handle, struct inode *inode,
-			unsigned long block, unsigned long count)
+void ext3_free_blocks_sb(handle_t *handle, struct super_block *sb,
+			 unsigned long block, unsigned long count,
+			 int *pdquot_freed_blocks)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gd_bh;
@@ -283,18 +284,12 @@ void ext3_free_blocks(handle_t *handle, 
 	unsigned long bit;
 	unsigned long i;
 	unsigned long overflow;
-	struct super_block * sb;
 	struct ext3_group_desc * gdp;
 	struct ext3_super_block * es;
 	struct ext3_sb_info *sbi;
 	int err = 0, ret;
-	int dquot_freed_blocks = 0;
 
-	sb = inode->i_sb;
-	if (!sb) {
-		printk ("ext3_free_blocks: nonexistent device");
-		return;
-	}
+	*pdquot_freed_blocks = 0;
 	sbi = EXT3_SB(sb);
 	es = EXT3_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
@@ -426,7 +421,7 @@ do_more:
 			jbd_lock_bh_state(bitmap_bh);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
-			dquot_freed_blocks++;
+			(*pdquot_freed_blocks)++;
 		}
 	}
 	jbd_unlock_bh_state(bitmap_bh);
@@ -434,7 +429,7 @@ do_more:
 	spin_lock(sb_bgl_lock(sbi, block_group));
 	gdp->bg_free_blocks_count =
 		cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) +
-			dquot_freed_blocks);
+			*pdquot_freed_blocks);
 	spin_unlock(sb_bgl_lock(sbi, block_group));
 	percpu_counter_mod(&sbi->s_freeblocks_counter, count);
 
@@ -456,7 +451,23 @@ do_more:
 error_return:
 	brelse(bitmap_bh);
 	ext3_std_error(sb, err);
-	if (dquot_freed_blocks && !(EXT3_I(inode)->i_state & EXT3_STATE_RESIZE))
+	return;
+}
+
+/* Free given blocks, update quota and i_blocks field */
+void ext3_free_blocks(handle_t *handle, struct inode *inode,
+			unsigned long block, unsigned long count)
+{
+	struct super_block * sb;
+	int dquot_freed_blocks;
+	
+	sb = inode->i_sb;
+	if (!sb) {
+		printk ("ext3_free_blocks: nonexistent device");
+		return;
+	}
+	ext3_free_blocks_sb(handle, sb, block, count, &dquot_freed_blocks);
+	if (dquot_freed_blocks)
 		DQUOT_FREE_BLOCK(inode, dquot_freed_blocks);
 	return;
 }
--- linux-2.6.9-rc2-mm4/fs/ext3/resize.c.=K0008=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/resize.c
@@ -902,10 +902,9 @@ int ext3_group_extend(struct super_block
 	unsigned long o_groups_count;
 	unsigned long last;
 	int add;
-	struct inode *inode;
 	struct buffer_head * bh;
 	handle_t *handle;
-	int err;
+	int err, freed_blocks;
 
 	/* We don't need to worry about locking wrt other resizers just
 	 * yet: we're going to revalidate es->s_blocks_count after
@@ -955,20 +954,10 @@ int ext3_group_extend(struct super_block
 	}
 	brelse(bh);
 
-	/* Get a bogus inode to "free" the new blocks in this group. */
-	if (!(inode = new_inode(sb))) {
-		ext3_warning(sb, __FUNCTION__,
-			     "error getting dummy resize inode");
-		return -ENOMEM;
-	}
-	inode->i_ino = 0;
-
-	EXT3_I(inode)->i_state = EXT3_STATE_RESIZE;
-
 	/* We will update the superblock, one block bitmap, and
 	 * one group descriptor via ext3_free_blocks().
 	 */
-	handle = ext3_journal_start(inode, 3);
+	handle = ext3_journal_start_sb(sb, 3);
 	if (IS_ERR(handle)) {
 		err = PTR_ERR(handle);
 		ext3_warning(sb, __FUNCTION__, "error %d on journal start",err);
@@ -997,7 +986,7 @@ int ext3_group_extend(struct super_block
 	unlock_super(sb);
 	ext3_debug("freeing blocks %ld through %ld\n", o_blocks_count,
 		   o_blocks_count + add);
-	ext3_free_blocks(handle, inode, o_blocks_count, add);
+	ext3_free_blocks_sb(handle, sb, o_blocks_count, add, &freed_blocks);
 	ext3_debug("freed blocks %ld through %ld\n", o_blocks_count,
 		   o_blocks_count + add);
 	if ((err = ext3_journal_stop(handle)))
@@ -1008,7 +997,5 @@ int ext3_group_extend(struct super_block
 	update_backups(sb, EXT3_SB(sb)->s_sbh->b_blocknr, (char *)es,
 		       sizeof(struct ext3_super_block));
 exit_put:
-	iput(inode);
-
 	return err;
 } /* ext3_group_extend */
--- linux-2.6.9-rc2-mm4/include/linux/ext3_fs.h.=K0008=.orig
+++ linux-2.6.9-rc2-mm4/include/linux/ext3_fs.h
@@ -195,7 +195,6 @@ struct ext3_group_desc
  */
 #define EXT3_STATE_JDATA		0x00000001 /* journaled data exists */
 #define EXT3_STATE_NEW			0x00000002 /* inode is newly created */
-#define EXT3_STATE_RESIZE		0x00000004 /* fake inode for resizing */
 
 
 /* Used to pass group descriptor data when online resize is done */
@@ -715,6 +714,8 @@ extern unsigned long ext3_bg_num_gdb(str
 extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
+extern void ext3_free_blocks_sb (handle_t *, struct super_block *,
+				 unsigned long, unsigned long, int *);
 extern unsigned long ext3_count_free_blocks (struct super_block *);
 extern void ext3_check_blocks_bitmap (struct super_block *);
 extern struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
