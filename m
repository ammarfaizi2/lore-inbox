Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbVLFUWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVLFUWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVLFUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:22:51 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:62638 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932628AbVLFUWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:22:50 -0500
Subject: [PATCH] ext2: return FSID for statvfs
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Date: Tue, 06 Dec 2005 22:22:48 +0200
Message-Id: <1133900569.3279.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes ext2_statfs() to return a FSID based on least significant
64-bits of the 128-bit filesystem UUID. This patch is a partial fix for
Bugzilla Bug <http://bugzilla.kernel.org/show_bug.cgi?id=136>.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 super.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: 2.6/fs/ext2/super.c
===================================================================
--- 2.6.orig/fs/ext2/super.c
+++ 2.6/fs/ext2/super.c
@@ -1038,6 +1038,7 @@ restore_opts:
 static int ext2_statfs (struct super_block * sb, struct kstatfs * buf)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_super_block *es = sbi->s_es;
 	unsigned long overhead;
 	int i;
 
@@ -1052,7 +1053,7 @@ static int ext2_statfs (struct super_blo
 		 * All of the blocks before first_data_block are
 		 * overhead
 		 */
-		overhead = le32_to_cpu(sbi->s_es->s_first_data_block);
+		overhead = le32_to_cpu(es->s_first_data_block);
 
 		/*
 		 * Add the overhead attributed to the superblock and
@@ -1073,14 +1074,16 @@ static int ext2_statfs (struct super_blo
 
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(sbi->s_es->s_blocks_count) - overhead;
+	buf->f_blocks = le32_to_cpu(es->s_blocks_count) - overhead;
 	buf->f_bfree = ext2_count_free_blocks(sb);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(sbi->s_es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(sbi->s_es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - le32_to_cpu(es->s_r_blocks_count);
+	if (buf->f_bfree < le32_to_cpu(es->s_r_blocks_count))
 		buf->f_bavail = 0;
-	buf->f_files = le32_to_cpu(sbi->s_es->s_inodes_count);
+	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
+	buf->f_fsid.val[0] = le32_to_cpup((void *)es->s_uuid);
+	buf->f_fsid.val[1] = le32_to_cpup((void *)es->s_uuid + sizeof(u32));
 	return 0;
 }
 


