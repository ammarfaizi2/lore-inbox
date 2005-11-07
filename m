Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVKGVS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVKGVS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVKGVSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:18:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10756 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965031AbVKGVSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:18:51 -0500
Date: Mon, 7 Nov 2005 22:18:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Theodore Ts'o" <tytso@mit.edu>, ext2-devel@lists.sourceforge.net,
       sct@redhat.com, akpm@osdl.org, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove CONFIG_EXT{2,3}_CHECK
Message-ID: <20051107211850.GZ3847@stusta.de>
References: <20051031001334.GP4180@stusta.de> <20051031212503.GY31368@schatzie.adilger.int> <20051101044658.GA7500@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101044658.GA7500@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:46:58PM -0500, Theodore Ts'o wrote:
> On Mon, Oct 31, 2005 at 02:25:03PM -0700, Andreas Dilger wrote:
> > On Oct 31, 2005  01:13 +0100, Adrian Bunk wrote:
> > > Can anyone tell me the history of CONFIG_EXT{2,3}_CHECK?
> > > 
> > > There is code for a "check" option for mount if these options are 
> > > enabled, but there's no way to enable them.
> > 
> > These are expensive debugging options, which walk the inode/block bitmaps
> > for getting the group inode/block usage instead of using the group
> > summary data.  Not used very often but I suspect occasionally useful for
> > developers mucking with ext[23] internals.  Since it is developer-only
> > code it needs to be enabled with #define CONFIG_EXT[23]_CHECK in a
> > header or compile option.
> 
> It's basically a stripped down version of e2fsck pass #5, though.  Is
> there any reason why this needs to be in the kernel?  If it would be
> useful I could easily make a userspace implementation of these checks.

This code was introduced with kernel 2.4, but as far as I can see there 
was never an option for enabling it.

Unless someone can give a strong reason for keeping it, I'd suggest the 
patch below.

> 						- Ted

cu
Adrian


<--  snip  -->


The CONFIG_EXT{2,3}_CHECK options where were never available, and all 
they did was to implement a subset of e2fsck in the kernel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/filesystems/ext2.txt |    2 
 fs/ext2/balloc.c                   |   73 -----------------------------
 fs/ext2/ialloc.c                   |   40 ---------------
 fs/ext2/super.c                    |   16 ------
 fs/ext3/balloc.c                   |   73 -----------------------------
 fs/ext3/ialloc.c                   |   41 ----------------
 fs/ext3/super.c                    |   17 ------
 7 files changed, 2 insertions(+), 260 deletions(-)

--- linux-2.6.14-mm1-full/Documentation/filesystems/ext2.txt.old	2005-11-07 21:22:25.000000000 +0100
+++ linux-2.6.14-mm1-full/Documentation/filesystems/ext2.txt	2005-11-07 21:22:36.000000000 +0100
@@ -17,8 +17,6 @@
 bsddf			(*)	Makes `df' act like BSD.
 minixdf				Makes `df' act like Minix.
 
-check				Check block and inode bitmaps at mount time
-				(requires CONFIG_EXT2_CHECK).
 check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
 				(check=normal and check=strict options removed)
 
--- linux-2.6.14-mm1-full/fs/ext2/balloc.c.old	2005-11-07 21:22:43.000000000 +0100
+++ linux-2.6.14-mm1-full/fs/ext2/balloc.c	2005-11-07 21:22:56.000000000 +0100
@@ -624,76 +624,3 @@
 	return EXT2_SB(sb)->s_gdb_count;
 }
 
-#ifdef CONFIG_EXT2_CHECK
-/* Called at mount-time, super-block is locked */
-void ext2_check_blocks_bitmap (struct super_block * sb)
-{
-	struct buffer_head *bitmap_bh = NULL;
-	struct ext2_super_block * es;
-	unsigned long desc_count, bitmap_count, x, j;
-	unsigned long desc_blocks;
-	struct ext2_group_desc * desc;
-	int i;
-
-	es = EXT2_SB(sb)->s_es;
-	desc_count = 0;
-	bitmap_count = 0;
-	desc = NULL;
-	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		desc = ext2_get_group_desc (sb, i, NULL);
-		if (!desc)
-			continue;
-		desc_count += le16_to_cpu(desc->bg_free_blocks_count);
-		brelse(bitmap_bh);
-		bitmap_bh = read_block_bitmap(sb, i);
-		if (!bitmap_bh)
-			continue;
-
-		if (ext2_bg_has_super(sb, i) &&
-				!ext2_test_bit(0, bitmap_bh->b_data))
-			ext2_error(sb, __FUNCTION__,
-				   "Superblock in group %d is marked free", i);
-
-		desc_blocks = ext2_bg_num_gdb(sb, i);
-		for (j = 0; j < desc_blocks; j++)
-			if (!ext2_test_bit(j + 1, bitmap_bh->b_data))
-				ext2_error(sb, __FUNCTION__,
-					   "Descriptor block #%ld in group "
-					   "%d is marked free", j, i);
-
-		if (!block_in_use(le32_to_cpu(desc->bg_block_bitmap),
-					sb, bitmap_bh->b_data))
-			ext2_error(sb, "ext2_check_blocks_bitmap",
-				    "Block bitmap for group %d is marked free",
-				    i);
-
-		if (!block_in_use(le32_to_cpu(desc->bg_inode_bitmap),
-					sb, bitmap_bh->b_data))
-			ext2_error(sb, "ext2_check_blocks_bitmap",
-				    "Inode bitmap for group %d is marked free",
-				    i);
-
-		for (j = 0; j < EXT2_SB(sb)->s_itb_per_group; j++)
-			if (!block_in_use(le32_to_cpu(desc->bg_inode_table) + j,
-						sb, bitmap_bh->b_data))
-				ext2_error (sb, "ext2_check_blocks_bitmap",
-					    "Block #%ld of the inode table in "
-					    "group %d is marked free", j, i);
-
-		x = ext2_count_free(bitmap_bh, sb->s_blocksize);
-		if (le16_to_cpu(desc->bg_free_blocks_count) != x)
-			ext2_error (sb, "ext2_check_blocks_bitmap",
-				    "Wrong free blocks count for group %d, "
-				    "stored = %d, counted = %lu", i,
-				    le16_to_cpu(desc->bg_free_blocks_count), x);
-		bitmap_count += x;
-	}
-	if (le32_to_cpu(es->s_free_blocks_count) != bitmap_count)
-		ext2_error (sb, "ext2_check_blocks_bitmap",
-			"Wrong free blocks count in super block, "
-			"stored = %lu, counted = %lu",
-			(unsigned long)le32_to_cpu(es->s_free_blocks_count),
-			bitmap_count);
-	brelse(bitmap_bh);
-}
-#endif
--- linux-2.6.14-mm1-full/fs/ext2/ialloc.c.old	2005-11-07 21:23:04.000000000 +0100
+++ linux-2.6.14-mm1-full/fs/ext2/ialloc.c	2005-11-07 21:23:13.000000000 +0100
@@ -700,43 +700,3 @@
 	return count;
 }
 
-#ifdef CONFIG_EXT2_CHECK
-/* Called at mount-time, super-block is locked */
-void ext2_check_inodes_bitmap (struct super_block * sb)
-{
-	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
-	unsigned long desc_count = 0, bitmap_count = 0;
-	struct buffer_head *bitmap_bh = NULL;
-	int i;
-
-	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		struct ext2_group_desc *desc;
-		unsigned x;
-
-		desc = ext2_get_group_desc(sb, i, NULL);
-		if (!desc)
-			continue;
-		desc_count += le16_to_cpu(desc->bg_free_inodes_count);
-		brelse(bitmap_bh);
-		bitmap_bh = read_inode_bitmap(sb, i);
-		if (!bitmap_bh)
-			continue;
-		
-		x = ext2_count_free(bitmap_bh, EXT2_INODES_PER_GROUP(sb) / 8);
-		if (le16_to_cpu(desc->bg_free_inodes_count) != x)
-			ext2_error (sb, "ext2_check_inodes_bitmap",
-				    "Wrong free inodes count in group %d, "
-				    "stored = %d, counted = %lu", i,
-				    le16_to_cpu(desc->bg_free_inodes_count), x);
-		bitmap_count += x;
-	}
-	brelse(bitmap_bh);
-	if (percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter) !=
-				bitmap_count)
-		ext2_error(sb, "ext2_check_inodes_bitmap",
-			    "Wrong free inodes count in super block, "
-			    "stored = %lu, counted = %lu",
-			    (unsigned long)le32_to_cpu(es->s_free_inodes_count),
-			    bitmap_count);
-}
-#endif
--- linux-2.6.14-mm1-full/fs/ext2/super.c.old	2005-11-07 21:23:21.000000000 +0100
+++ linux-2.6.14-mm1-full/fs/ext2/super.c	2005-11-07 21:23:56.000000000 +0100
@@ -281,7 +281,7 @@
 enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic,
-	Opt_err_ro, Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug,
+	Opt_err_ro, Opt_nouid32, Opt_nocheck, Opt_debug,
 	Opt_oldalloc, Opt_orlov, Opt_nobh, Opt_user_xattr, Opt_nouser_xattr,
 	Opt_acl, Opt_noacl, Opt_xip, Opt_ignore, Opt_err, Opt_quota,
 	Opt_usrquota, Opt_grpquota
@@ -303,7 +303,6 @@
 	{Opt_nouid32, "nouid32"},
 	{Opt_nocheck, "check=none"},
 	{Opt_nocheck, "nocheck"},
-	{Opt_check, "check"},
 	{Opt_debug, "debug"},
 	{Opt_oldalloc, "oldalloc"},
 	{Opt_orlov, "orlov"},
@@ -376,13 +375,6 @@
 		case Opt_nouid32:
 			set_opt (sbi->s_mount_opt, NO_UID32);
 			break;
-		case Opt_check:
-#ifdef CONFIG_EXT2_CHECK
-			set_opt (sbi->s_mount_opt, CHECK);
-#else
-			printk("EXT2 Check option not supported\n");
-#endif
-			break;
 		case Opt_nocheck:
 			clear_opt (sbi->s_mount_opt, CHECK);
 			break;
@@ -503,12 +495,6 @@
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
 			sbi->s_mount_opt);
-#ifdef CONFIG_EXT2_CHECK
-	if (test_opt (sb, CHECK)) {
-		ext2_check_blocks_bitmap (sb);
-		ext2_check_inodes_bitmap (sb);
-	}
-#endif
 	return res;
 }
 
--- linux-2.6.14-mm1-full/fs/ext3/balloc.c.old	2005-11-07 21:24:04.000000000 +0100
+++ linux-2.6.14-mm1-full/fs/ext3/balloc.c	2005-11-07 21:26:53.000000000 +0100
@@ -1517,76 +1517,3 @@
 	return EXT3_SB(sb)->s_gdb_count;
 }
 
-#ifdef CONFIG_EXT3_CHECK
-/* Called at mount-time, super-block is locked */
-void ext3_check_blocks_bitmap (struct super_block * sb)
-{
-	struct ext3_super_block *es;
-	unsigned long desc_count, bitmap_count, x, j;
-	unsigned long desc_blocks;
-	struct buffer_head *bitmap_bh = NULL;
-	struct ext3_group_desc *gdp;
-	int i;
-
-	es = EXT3_SB(sb)->s_es;
-	desc_count = 0;
-	bitmap_count = 0;
-	gdp = NULL;
-	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
-		gdp = ext3_get_group_desc (sb, i, NULL);
-		if (!gdp)
-			continue;
-		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
-		brelse(bitmap_bh);
-		bitmap_bh = read_block_bitmap(sb, i);
-		if (bitmap_bh == NULL)
-			continue;
-
-		if (ext3_bg_has_super(sb, i) &&
-				!ext3_test_bit(0, bitmap_bh->b_data))
-			ext3_error(sb, __FUNCTION__,
-				   "Superblock in group %d is marked free", i);
-
-		desc_blocks = ext3_bg_num_gdb(sb, i);
-		for (j = 0; j < desc_blocks; j++)
-			if (!ext3_test_bit(j + 1, bitmap_bh->b_data))
-				ext3_error(sb, __FUNCTION__,
-					   "Descriptor block #%ld in group "
-					   "%d is marked free", j, i);
-
-		if (!block_in_use (le32_to_cpu(gdp->bg_block_bitmap),
-						sb, bitmap_bh->b_data))
-			ext3_error (sb, "ext3_check_blocks_bitmap",
-				    "Block bitmap for group %d is marked free",
-				    i);
-
-		if (!block_in_use (le32_to_cpu(gdp->bg_inode_bitmap),
-						sb, bitmap_bh->b_data))
-			ext3_error (sb, "ext3_check_blocks_bitmap",
-				    "Inode bitmap for group %d is marked free",
-				    i);
-
-		for (j = 0; j < EXT3_SB(sb)->s_itb_per_group; j++)
-			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j,
-							sb, bitmap_bh->b_data))
-				ext3_error (sb, "ext3_check_blocks_bitmap",
-					    "Block #%d of the inode table in "
-					    "group %d is marked free", j, i);
-
-		x = ext3_count_free(bitmap_bh, sb->s_blocksize);
-		if (le16_to_cpu(gdp->bg_free_blocks_count) != x)
-			ext3_error (sb, "ext3_check_blocks_bitmap",
-				    "Wrong free blocks count for group %d, "
-				    "stored = %d, counted = %lu", i,
-				    le16_to_cpu(gdp->bg_free_blocks_count), x);
-		bitmap_count += x;
-	}
-	brelse(bitmap_bh);
-	if (le32_to_cpu(es->s_free_blocks_count) != bitmap_count)
-		ext3_error (sb, "ext3_check_blocks_bitmap",
-			"Wrong free blocks count in super block, "
-			"stored = %lu, counted = %lu",
-			(unsigned long)le32_to_cpu(es->s_free_blocks_count),
-			bitmap_count);
-}
-#endif
--- linux-2.6.14-mm1-full/fs/ext3/ialloc.c.old	2005-11-07 21:27:02.000000000 +0100
+++ linux-2.6.14-mm1-full/fs/ext3/ialloc.c	2005-11-07 21:27:09.000000000 +0100
@@ -756,44 +756,3 @@
 	return count;
 }
 
-#ifdef CONFIG_EXT3_CHECK
-/* Called at mount-time, super-block is locked */
-void ext3_check_inodes_bitmap (struct super_block * sb)
-{
-	struct ext3_super_block * es;
-	unsigned long desc_count, bitmap_count, x;
-	struct buffer_head *bitmap_bh = NULL;
-	struct ext3_group_desc * gdp;
-	int i;
-
-	es = EXT3_SB(sb)->s_es;
-	desc_count = 0;
-	bitmap_count = 0;
-	gdp = NULL;
-	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
-		gdp = ext3_get_group_desc (sb, i, NULL);
-		if (!gdp)
-			continue;
-		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
-		brelse(bitmap_bh);
-		bitmap_bh = read_inode_bitmap(sb, i);
-		if (!bitmap_bh)
-			continue;
-
-		x = ext3_count_free(bitmap_bh, EXT3_INODES_PER_GROUP(sb) / 8);
-		if (le16_to_cpu(gdp->bg_free_inodes_count) != x)
-			ext3_error (sb, "ext3_check_inodes_bitmap",
-				    "Wrong free inodes count in group %d, "
-				    "stored = %d, counted = %lu", i,
-				    le16_to_cpu(gdp->bg_free_inodes_count), x);
-		bitmap_count += x;
-	}
-	brelse(bitmap_bh);
-	if (le32_to_cpu(es->s_free_inodes_count) != bitmap_count)
-		ext3_error (sb, "ext3_check_inodes_bitmap",
-			    "Wrong free inodes count in super block, "
-			    "stored = %lu, counted = %lu",
-			    (unsigned long)le32_to_cpu(es->s_free_inodes_count),
-			    bitmap_count);
-}
-#endif
--- linux-2.6.14-mm1-full/fs/ext3/super.c.old	2005-11-07 21:27:17.000000000 +0100
+++ linux-2.6.14-mm1-full/fs/ext3/super.c	2005-11-07 21:27:48.000000000 +0100
@@ -625,7 +625,7 @@
 enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
-	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
+	Opt_nouid32, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
 	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
@@ -652,7 +652,6 @@
 	{Opt_nouid32, "nouid32"},
 	{Opt_nocheck, "nocheck"},
 	{Opt_nocheck, "check=none"},
-	{Opt_check, "check"},
 	{Opt_debug, "debug"},
 	{Opt_oldalloc, "oldalloc"},
 	{Opt_orlov, "orlov"},
@@ -773,14 +772,6 @@
 		case Opt_nouid32:
 			set_opt (sbi->s_mount_opt, NO_UID32);
 			break;
-		case Opt_check:
-#ifdef CONFIG_EXT3_CHECK
-			set_opt (sbi->s_mount_opt, CHECK);
-#else
-			printk(KERN_ERR
-			       "EXT3 Check option not supported\n");
-#endif
-			break;
 		case Opt_nocheck:
 			clear_opt (sbi->s_mount_opt, CHECK);
 			break;
@@ -1115,12 +1106,6 @@
 	} else {
 		printk("internal journal\n");
 	}
-#ifdef CONFIG_EXT3_CHECK
-	if (test_opt (sb, CHECK)) {
-		ext3_check_blocks_bitmap (sb);
-		ext3_check_inodes_bitmap (sb);
-	}
-#endif
 	return res;
 }
 

