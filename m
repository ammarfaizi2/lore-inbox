Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCETWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCETWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVCETWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:22:23 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:36868 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261164AbVCESp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:45:59 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/29] FAT: add debugging code to fatent.c
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:45:29 +0900
In-Reply-To: <87zmxiq6ef.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:44:40 +0900")
Message-ID: <87vf86q6d2.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fatent.c          |   20 ++++++++++++++++++++
 include/linux/msdos_fs.h |    6 ++++++
 2 files changed, 26 insertions(+)

diff -puN fs/fat/fatent.c~sync05-fat_dep-fatent-debug fs/fat/fatent.c
--- linux-2.6.11/fs/fat/fatent.c~sync05-fat_dep-fatent-debug	2005-03-06 02:36:16.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/fatent.c	2005-03-06 02:36:16.000000000 +0900
@@ -21,6 +21,7 @@ static void fat12_ent_blocknr(struct sup
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = entry + (entry >> 1);
+	WARN_ON(entry < FAT_START_ENT || sbi->max_cluster <= entry);
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
 }
@@ -30,6 +31,7 @@ static void fat_ent_blocknr(struct super
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = (entry << sbi->fatent_shift);
+	WARN_ON(entry < FAT_START_ENT || sbi->max_cluster <= entry);
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
 }
@@ -38,9 +40,11 @@ static void fat12_ent_set_ptr(struct fat
 {
 	struct buffer_head **bhs = fatent->bhs;
 	if (fatent->nr_bhs == 1) {
+		WARN_ON(offset >= (bhs[0]->b_size - 1));
 		fatent->u.ent12_p[0] = bhs[0]->b_data + offset;
 		fatent->u.ent12_p[1] = bhs[0]->b_data + (offset + 1);
 	} else {
+		WARN_ON(offset != (bhs[0]->b_size - 1));
 		fatent->u.ent12_p[0] = bhs[0]->b_data + offset;
 		fatent->u.ent12_p[1] = bhs[1]->b_data;
 	}
@@ -48,11 +52,13 @@ static void fat12_ent_set_ptr(struct fat
 
 static void fat16_ent_set_ptr(struct fat_entry *fatent, int offset)
 {
+	WARN_ON(offset & (2 - 1));
 	fatent->u.ent16_p = (__le16 *)(fatent->bhs[0]->b_data + offset);
 }
 
 static void fat32_ent_set_ptr(struct fat_entry *fatent, int offset)
 {
+	WARN_ON(offset & (4 - 1));
 	fatent->u.ent32_p = (__le32 *)(fatent->bhs[0]->b_data + offset);
 }
 
@@ -61,6 +67,7 @@ static int fat12_ent_bread(struct super_
 {
 	struct buffer_head **bhs = fatent->bhs;
 
+	WARN_ON(blocknr < MSDOS_SB(sb)->fat_start);
 	bhs[0] = sb_bread(sb, blocknr);
 	if (!bhs[0])
 		goto err;
@@ -91,6 +98,7 @@ static int fat_ent_bread(struct super_bl
 {
 	struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
 
+	WARN_ON(blocknr < MSDOS_SB(sb)->fat_start);
 	fatent->bhs[0] = sb_bread(sb, blocknr);
 	if (!fatent->bhs[0]) {
 		printk(KERN_ERR "FAT: FAT read failed (blocknr %llu)\n",
@@ -120,6 +128,7 @@ static int fat12_ent_get(struct fat_entr
 static int fat16_ent_get(struct fat_entry *fatent)
 {
 	int next = le16_to_cpu(*fatent->u.ent16_p);
+	WARN_ON((unsigned long)fatent->u.ent16_p & (2 - 1));
 	if (next >= BAD_FAT16)
 		next = FAT_ENT_EOF;
 	return next;
@@ -128,6 +137,7 @@ static int fat16_ent_get(struct fat_entr
 static int fat32_ent_get(struct fat_entry *fatent)
 {
 	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
+	WARN_ON((unsigned long)fatent->u.ent32_p & (4 - 1));
 	if (next >= BAD_FAT32)
 		next = FAT_ENT_EOF;
 	return next;
@@ -167,6 +177,7 @@ static void fat32_ent_put(struct fat_ent
 	if (new == FAT_ENT_EOF)
 		new = EOF_FAT32;
 
+	WARN_ON(new & 0xf0000000);
 	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
 	*fatent->u.ent32_p = cpu_to_le32(new);
 	mark_buffer_dirty(fatent->bhs[0]);
@@ -180,12 +191,16 @@ static int fat12_ent_next(struct fat_ent
 
 	fatent->entry++;
 	if (fatent->nr_bhs == 1) {
+		WARN_ON(ent12_p[0] > (u8 *)(bhs[0]->b_data + (bhs[0]->b_size - 2)));
+		WARN_ON(ent12_p[1] > (u8 *)(bhs[0]->b_data + (bhs[0]->b_size - 1)));
 		if (nextp < (u8 *)(bhs[0]->b_data + (bhs[0]->b_size - 1))) {
 			ent12_p[0] = nextp - 1;
 			ent12_p[1] = nextp;
 			return 1;
 		}
 	} else {
+		WARN_ON(ent12_p[0] != (u8 *)(bhs[0]->b_data + (bhs[0]->b_size - 1)));
+		WARN_ON(ent12_p[1] != (u8 *)bhs[1]->b_data);
 		ent12_p[0] = nextp - 1;
 		ent12_p[1] = nextp;
 		brelse(bhs[0]);
@@ -193,6 +208,8 @@ static int fat12_ent_next(struct fat_ent
 		fatent->nr_bhs = 1;
 		return 1;
 	}
+	ent12_p[0] = NULL;
+	ent12_p[1] = NULL;
 	return 0;
 }
 
@@ -204,6 +221,7 @@ static int fat16_ent_next(struct fat_ent
 		fatent->u.ent16_p++;
 		return 1;
 	}
+	fatent->u.ent16_p = NULL;
 	return 0;
 }
 
@@ -215,6 +233,7 @@ static int fat32_ent_next(struct fat_ent
 		fatent->u.ent32_p++;
 		return 1;
 	}
+	fatent->u.ent32_p = NULL;
 	return 0;
 }
 
@@ -323,6 +342,7 @@ int fat_ent_read(struct inode *inode, st
 	return ops->ent_get(fatent);
 }
 
+/* FIXME: We can write the blocks as more big chunk. */
 static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
 			  int nr_bhs)
 {
diff -puN include/linux/msdos_fs.h~sync05-fat_dep-fatent-debug include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync05-fat_dep-fatent-debug	2005-03-06 02:36:16.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:16.000000000 +0900
@@ -348,19 +348,25 @@ struct fat_entry {
 static inline void fatent_init(struct fat_entry *fatent)
 {
 	fatent->nr_bhs = 0;
+	fatent->entry = 0;
+	fatent->u.ent32_p = NULL;
+	fatent->bhs[0] = fatent->bhs[1] = NULL;
 }
 
 static inline void fatent_set_entry(struct fat_entry *fatent, int entry)
 {
 	fatent->entry = entry;
+	fatent->u.ent32_p = NULL;
 }
 
 static inline void fatent_brelse(struct fat_entry *fatent)
 {
 	int i;
+	fatent->u.ent32_p = NULL;
 	for (i = 0; i < fatent->nr_bhs; i++)
 		brelse(fatent->bhs[i]);
 	fatent->nr_bhs = 0;
+	fatent->bhs[0] = fatent->bhs[1] = NULL;
 }
 
 extern void fat_ent_access_init(struct super_block *sb);
_
