Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWH2QuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWH2QuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWH2QuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:50:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965159AbWH2QuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:50:18 -0400
Message-ID: <44F4703E.5060300@redhat.com>
Date: Tue, 29 Aug 2006 11:50:06 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
CC: "Stephen C. Tweedie" <sct@redhat.com>
Subject: [PATCH] endianness fixes for 16T ext patches
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops... thanks for pointing this out, Stephen...

Fix some endian errors in the 16T ext[23] patches I sent in the past couple weeks.

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.17/fs/ext2/super.c
===================================================================
--- linux-2.6.17.orig/fs/ext2/super.c
+++ linux-2.6.17/fs/ext2/super.c
@@ -514,7 +514,7 @@ static int ext2_check_descriptors (struc
 	for (i = 0; i < sbi->s_groups_count; i++)
 	{
 		if (i == sbi->s_groups_count - 1)
-			last_block = sbi->s_es->s_blocks_count - 1;
+			last_block = le32_to_cpu(sbi->s_es->s_blocks_count) - 1;
 		else
 			last_block = first_block +
 				(EXT2_BLOCKS_PER_GROUP(sb) - 1);
Index: linux-2.6.17/fs/ext3/resize.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/resize.c
+++ linux-2.6.17/fs/ext3/resize.c
@@ -730,12 +730,14 @@ int ext3_group_add(struct super_block *s
 		return -EPERM;
 	}
 
-	if (es->s_blocks_count + input->blocks_count < es->s_blocks_count) {
+	if (le32_to_cpu(es->s_blocks_count) + input->blocks_count < 
+	    le32_to_cpu(es->s_blocks_count)) {
 		ext3_warning(sb, __FUNCTION__, "blocks_count overflow\n");
 		return -EINVAL;
 	}
 
-	if (es->s_inodes_count+EXT3_INODES_PER_GROUP(sb) < es->s_inodes_count) {
+	if (le32_to_cpu(es->s_inodes_count) + EXT3_INODES_PER_GROUP(sb) <
+	    le32_to_cpu(es->s_inodes_count)) {
 		ext3_warning(sb, __FUNCTION__, "inodes_count overflow\n");
 		return -EINVAL;
 	}
Index: linux-2.6.17/fs/ext3/super.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/super.c
+++ linux-2.6.17/fs/ext3/super.c
@@ -1143,7 +1143,7 @@ static int ext3_check_descriptors (struc
 	for (i = 0; i < sbi->s_groups_count; i++)
 	{
 		if (i == sbi->s_groups_count - 1)
-			last_block = sbi->s_es->s_blocks_count - 1;
+			last_block = le32_to_cpu(sbi->s_es->s_blocks_count) - 1;
 		else
 			last_block = first_block +
 				(EXT3_BLOCKS_PER_GROUP(sb) - 1);


