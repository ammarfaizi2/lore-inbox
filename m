Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVBOJrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVBOJrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVBOJrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:47:11 -0500
Received: from mx1.mail.ru ([194.67.23.121]:3336 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261664AbVBOJqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:46:14 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>,
       adilger@clusterfs.com
Subject: [PATCH] ext3: Fix sparse -Wbitwise warnings.
Date: Tue, 15 Feb 2005 12:46:06 +0200
User-Agent: KMail/1.6.2
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502151246.06598.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
---

 fs/ext3/resize.c        |   20 ++++++++++----------
 fs/ext3/super.c         |    8 ++++----
 include/linux/ext3_fs.h |    2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

Index: linux-warnings/include/linux/ext3_fs.h
===================================================================
--- linux-warnings/include/linux/ext3_fs.h	(revision 14)
+++ linux-warnings/include/linux/ext3_fs.h	(revision 20)
@@ -450,7 +450,7 @@
 	 */
 	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
 	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
-	__u16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
+	__le16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
 	/*
 	 * Journaling support valid if EXT3_FEATURE_COMPAT_HAS_JOURNAL set.
 	 */
Index: linux-warnings/fs/ext3/super.c
===================================================================
--- linux-warnings/fs/ext3/super.c	(revision 14)
+++ linux-warnings/fs/ext3/super.c	(revision 20)
@@ -2105,13 +2105,13 @@
 
 			ext3_mark_recovery_complete(sb, es);
 		} else {
-			__le32 ret;
-			if ((ret = EXT3_HAS_RO_COMPAT_FEATURE(sb,
-					~EXT3_FEATURE_RO_COMPAT_SUPP))) {
+			int ret;
+			if ((ret = le32_to_cpu(EXT3_HAS_RO_COMPAT_FEATURE(sb,
+					~EXT3_FEATURE_RO_COMPAT_SUPP)))) {
 				printk(KERN_WARNING "EXT3-fs: %s: couldn't "
 				       "remount RDWR because of unsupported "
 				       "optional features (%x).\n",
-				       sb->s_id, le32_to_cpu(ret));
+				       sb->s_id, ret);
 				return -EROFS;
 			}
 			/*
Index: linux-warnings/fs/ext3/resize.c
===================================================================
--- linux-warnings/fs/ext3/resize.c	(revision 14)
+++ linux-warnings/fs/ext3/resize.c	(revision 20)
@@ -328,7 +328,7 @@
 	unsigned five = 5;
 	unsigned seven = 7;
 	unsigned grp;
-	__u32 *p = (__u32 *)primary->b_data;
+	__le32 *p = (__le32 *)primary->b_data;
 	int gdbackups = 0;
 
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
@@ -371,7 +371,7 @@
 	struct buffer_head *dind;
 	int gdbackups;
 	struct ext3_iloc iloc;
-	__u32 *data;
+	__le32 *data;
 	int err;
 
 	if (test_opt(sb, DEBUG))
@@ -408,7 +408,7 @@
 		goto exit_bh;
 	}
 
-	data = (__u32 *)dind->b_data;
+	data = (__le32 *)dind->b_data;
 	if (le32_to_cpu(data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)]) != gdblock) {
 		ext3_warning(sb, __FUNCTION__,
 			     "new group %u GDT block %lu not reserved\n",
@@ -510,7 +510,7 @@
 	struct buffer_head *dind;
 	struct ext3_iloc iloc;
 	unsigned long blk;
-	__u32 *data, *end;
+	__le32 *data, *end;
 	int gdbackups = 0;
 	int res, i;
 	int err;
@@ -527,15 +527,15 @@
 	}
 
 	blk = EXT3_SB(sb)->s_sbh->b_blocknr + 1 + EXT3_SB(sb)->s_gdb_count;
-	data = (__u32 *)dind->b_data + EXT3_SB(sb)->s_gdb_count;
-	end = (__u32 *)dind->b_data + EXT3_ADDR_PER_BLOCK(sb);
+	data = (__le32 *)dind->b_data + EXT3_SB(sb)->s_gdb_count;
+	end = (__le32 *)dind->b_data + EXT3_ADDR_PER_BLOCK(sb);
 
 	/* Get each reserved primary GDT block and verify it holds backups */
 	for (res = 0; res < reserved_gdb; res++, blk++) {
 		if (le32_to_cpu(*data) != blk) {
 			ext3_warning(sb, __FUNCTION__,
 				     "reserved block %lu not at offset %ld\n",
-				     blk, (long)(data - (__u32 *)dind->b_data));
+				     blk, (long)(data - (__le32 *)dind->b_data));
 			err = -EINVAL;
 			goto exit_bh;
 		}
@@ -550,7 +550,7 @@
 			goto exit_bh;
 		}
 		if (++data >= end)
-			data = (__u32 *)dind->b_data;
+			data = (__le32 *)dind->b_data;
 	}
 
 	for (i = 0; i < reserved_gdb; i++) {
@@ -574,7 +574,7 @@
 	blk = input->group * EXT3_BLOCKS_PER_GROUP(sb);
 	for (i = 0; i < reserved_gdb; i++) {
 		int err2;
-		data = (__u32 *)primary[i]->b_data;
+		data = (__le32 *)primary[i]->b_data;
 		/* printk("reserving backup %lu[%u] = %lu\n",
 		       primary[i]->b_blocknr, gdbackups,
 		       blk + primary[i]->b_blocknr); */
@@ -675,7 +675,7 @@
 			     "can't update backup for group %d (err %d), "
 			     "forcing fsck on next reboot\n", group, err);
 		sbi->s_mount_state &= ~EXT3_VALID_FS;
-		sbi->s_es->s_state &= ~cpu_to_le16(EXT3_VALID_FS);
+		sbi->s_es->s_state &= cpu_to_le16(~EXT3_VALID_FS);
 		mark_buffer_dirty(sbi->s_sbh);
 	}
 }
