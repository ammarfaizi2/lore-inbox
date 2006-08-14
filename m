Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWHNTyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWHNTyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWHNTyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:54:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11676 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751719AbWHNTyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:54:45 -0400
Message-ID: <44E0D4F8.9020104@sandeen.net>
Date: Mon, 14 Aug 2006 14:54:32 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ext2-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [UPDATED PATCH] fix ext3 mounts at 16T
References: <44DD00FA.5060600@redhat.com>
In-Reply-To: <44DD00FA.5060600@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:

> I figure before we get too fired up about 48 bits and ext4 let's fix 32 bits on ext3 :)
>   
Urk... must remember to "quilt refresh..." - this version actually compiles :/  sorry!

(1st part of 2nd hunk was wrong before)

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.17/fs/ext3/super.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/super.c
+++ linux-2.6.17/fs/ext3/super.c
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
@@ -1141,12 +1142,17 @@ static int ext3_check_descriptors (struc
 
 	for (i = 0; i < sbi->s_groups_count; i++)
 	{
+		if (i == sbi->s_groups_count - 1)
+			last_block = sbi->s_es->s_blocks_count - 1;
+		else
+			last_block = first_block +
+				(EXT3_BLOCKS_PER_GROUP(sb) - 1);
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
@@ -1155,9 +1161,8 @@ static int ext3_check_descriptors (struc
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
@@ -1166,9 +1171,9 @@ static int ext3_check_descriptors (struc
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
@@ -1177,7 +1182,7 @@ static int ext3_check_descriptors (struc
 					le32_to_cpu(gdp->bg_inode_table));
 			return 0;
 		}
-		block += EXT3_BLOCKS_PER_GROUP(sb);
+		first_block += EXT3_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
 
@@ -1580,10 +1585,9 @@ static int ext3_fill_super (struct super
 
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

