Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWHKWNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWHKWNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWHKWNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:13:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964792AbWHKWNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:13:16 -0400
Message-ID: <44DD00FA.5060600@redhat.com>
Date: Fri, 11 Aug 2006 17:13:14 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ext3 mounts at 16T
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figure before we get too fired up about 48 bits and ext4 let's fix 32 bits on ext3 :)

I need to do some actual IO testing now, but this gets things mounting for a 16T ext3 filesystem.
(patched up e2fsprogs is needed too, I'll send that off the kernel list)

This patch fixes these issues in the kernel:

o sbi->s_groups_count overflows in ext3_fill_super()

	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
			       le32_to_cpu(es->s_first_data_block) +
			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
			      EXT3_BLOCKS_PER_GROUP(sb);

at 16T, s_blocks_count is already maxed out; adding EXT3_BLOCKS_PER_GROUP(sb) overflows it and 
groups_count comes out to 0.  Not really what we want, and causes a failed mount.

Feel free to check my math (actually, please do!), but changing it this way should work & 
avoid the overflow:

(A + B - 1)/B changed to: ((A - 1)/B) + 1

o ext3_check_descriptors() overflows range checks

ext3_check_descriptors() iterates over all block groups making sure that various bits are 
within the right block ranges... on the last pass through, it is checking the error case

   [item] >= block + EXT3_BLOCKS_PER_GROUP(sb)

where "block" is the first block in the last block group.  The last block in this group 
(and the last one that will fit in 32 bits) is block + EXT3_BLOCKS_PER_GROUP(sb)- 1.  
block + EXT3_BLOCKS_PER_GROUP(sb) wraps back around to 0.

so, make things clearer with "first_block" and "last_block" where those are first and last,
inclusive, and use <, > rather than <, >=.

Finally, the last block group may be smaller than the rest, so account for this on the last
pass through: last_block = sb->s_blocks_count - 1;

(a similar patch could be done for ext2; does anyone in their right mind use ext2 at 16T?
I'll send an ext2 patch doing the same thing if that's warranted)

Thanks,

-Eric

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6-xfs/fs/ext3/super.c
===================================================================
--- linux-2.6-xfs.orig/fs/ext3/super.c
+++ linux-2.6-xfs/fs/ext3/super.c
@@ -1132,7 +1132,8 @@ static int ext3_setup_super(struct super
 static int ext3_check_descriptors (struct super_block * sb)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	ext3_fsblk_t block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	ext3_fsblk_t first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	ext3_fsblk_t last_block;
 	struct ext3_group_desc * gdp = NULL;
 	int desc_block = 0;
 	int i;
@@ -1141,12 +1142,16 @@ static int ext3_check_descriptors (struc
 
 	for (i = 0; i < sbi->s_groups_count; i++)
 	{
+		if (i == sbi->s_groups_count - 1)
+			last_block = sb->s_blocks_count - 1;
+		else
+			last = first + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
+
 		if ((i % EXT3_DESC_PER_BLOCK(sb)) == 0)
 			gdp = (struct ext3_group_desc *)
 					sbi->s_group_desc[desc_block++]->b_data;
-		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_block_bitmap) >=
-				block + EXT3_BLOCKS_PER_GROUP(sb))
+		if (le32_to_cpu(gdp->bg_block_bitmap) < first_block ||
+		    le32_to_cpu(gdp->bg_block_bitmap) > last_block)
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Block bitmap for group %d"
@@ -1155,9 +1160,8 @@ static int ext3_check_descriptors (struc
 					le32_to_cpu(gdp->bg_block_bitmap));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_inode_bitmap) >=
-				block + EXT3_BLOCKS_PER_GROUP(sb))
+		if (le32_to_cpu(gdp->bg_inode_bitmap) < first_block ||
+		    le32_to_cpu(gdp->bg_inode_bitmap) > last_block)
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Inode bitmap for group %d"
@@ -1166,9 +1170,9 @@ static int ext3_check_descriptors (struc
 					le32_to_cpu(gdp->bg_inode_bitmap));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
-		    block + EXT3_BLOCKS_PER_GROUP(sb))
+		if (le32_to_cpu(gdp->bg_inode_table) < first_block ||
+		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >
+		    last_block)
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Inode table for group %d"
@@ -1177,7 +1181,7 @@ static int ext3_check_descriptors (struc
 					le32_to_cpu(gdp->bg_inode_table));
 			return 0;
 		}
-		block += EXT3_BLOCKS_PER_GROUP(sb);
+		first_block += EXT3_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
 
@@ -1580,10 +1584,9 @@ static int ext3_fill_super (struct super
 
 	if (EXT3_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext3;
-	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
-			       le32_to_cpu(es->s_first_data_block) +
-			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
-			      EXT3_BLOCKS_PER_GROUP(sb);
+	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
+			       le32_to_cpu(es->s_first_data_block) - 1)
+				       / EXT3_BLOCKS_PER_GROUP(sb)) + 1;
 	db_count = (sbi->s_groups_count + EXT3_DESC_PER_BLOCK(sb) - 1) /
 		   EXT3_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc(db_count * sizeof (struct buffer_head *),


