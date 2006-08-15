Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWHOR2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWHOR2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWHOR2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:28:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030422AbWHOR2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:28:34 -0400
Message-ID: <44E20436.3030800@redhat.com>
Date: Tue, 15 Aug 2006 12:28:22 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ext2 mounts at 16T
References: <44DD00FA.5060600@redhat.com> <20060814155801.fa087b24.akpm@osdl.org>
In-Reply-To: <20060814155801.fa087b24.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> (I'll send an ext2 patch doing the same thing if that's warranted)
> please, when you have nothing better to do ;)

Ok, here's the ext2 version.  note however that ext2 never got the ext3_fsblk_t
treatment, so there are probably signed containers lurking in ext2 still.  I'll leave
that for another day when I have nothing better to do ;-)  But at least this part
is less divergent now.

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

--- linux.orig/fs/ext2/super.c
+++ linux/fs/ext2/super.c
@@ -505,17 +505,24 @@ static int ext2_check_descriptors (struc
 	int i;
 	int desc_block = 0;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	unsigned long block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	unsigned long first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	unsigned long last_block;
 	struct ext2_group_desc * gdp = NULL;
 
 	ext2_debug ("Checking group descriptors");
 
 	for (i = 0; i < sbi->s_groups_count; i++)
 	{
+		if (i == sbi->s_groups_count - 1)
+			last_block = sbi->s_es->s_blocks_count - 1;
+		else
+			last_block = first_block +
+				(EXT2_BLOCKS_PER_GROUP(sb) - 1);
+
 		if ((i % EXT2_DESC_PER_BLOCK(sb)) == 0)
 			gdp = (struct ext2_group_desc *) sbi->s_group_desc[desc_block++]->b_data;
-		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_block_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
+		if (le32_to_cpu(gdp->bg_block_bitmap) < first_block ||
+		    le32_to_cpu(gdp->bg_block_bitmap) > last_block)
 		{
 			ext2_error (sb, "ext2_check_descriptors",
 				    "Block bitmap for group %d"
@@ -523,8 +530,8 @@ static int ext2_check_descriptors (struc
 				    i, (unsigned long) le32_to_cpu(gdp->bg_block_bitmap));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_inode_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
+		if (le32_to_cpu(gdp->bg_inode_bitmap) < first_block ||
+		    le32_to_cpu(gdp->bg_inode_bitmap) > last_block)
 		{
 			ext2_error (sb, "ext2_check_descriptors",
 				    "Inode bitmap for group %d"
@@ -532,9 +539,9 @@ static int ext2_check_descriptors (struc
 				    i, (unsigned long) le32_to_cpu(gdp->bg_inode_bitmap));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
-		    block + EXT2_BLOCKS_PER_GROUP(sb))
+		if (le32_to_cpu(gdp->bg_inode_table) < first_block ||
+		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >
+		    last_block)
 		{
 			ext2_error (sb, "ext2_check_descriptors",
 				    "Inode table for group %d"
@@ -542,7 +549,7 @@ static int ext2_check_descriptors (struc
 				    i, (unsigned long) le32_to_cpu(gdp->bg_inode_table));
 			return 0;
 		}
-		block += EXT2_BLOCKS_PER_GROUP(sb);
+		first_block += EXT2_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
 	return 1;
@@ -822,10 +829,9 @@ static int ext2_fill_super(struct super_
 
 	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext2;
-	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
-				        le32_to_cpu(es->s_first_data_block) +
-				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
-				       EXT2_BLOCKS_PER_GROUP(sb);
+ 	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
+ 				le32_to_cpu(es->s_first_data_block) - 1)
+ 					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);



