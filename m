Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVCEUDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVCEUDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCEUCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:02:36 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:20229 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261187AbVCETLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:22 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 22/29] FAT: "i_pos" cleanup
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:56:22 +0900
In-Reply-To: <873bv9q5vx.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:55:46 +0900")
Message-ID: <87y8d1orah.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "i_pos" can calculate later, so this makes the "i_pos" when it's needed.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c |   70 ++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 39 insertions(+), 31 deletions(-)

diff -puN fs/fat/dir.c~sync08-fat_tweak2 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync08-fat_tweak2	2005-03-06 02:37:15.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:37:15.000000000 +0900
@@ -22,6 +22,14 @@
 #include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
+static inline loff_t fat_make_i_pos(struct super_block *sb,
+				    struct buffer_head *bh,
+				    struct msdos_dir_entry *de)
+{
+	return ((loff_t)bh->b_blocknr << MSDOS_SB(sb)->dir_per_block_bits)
+		| (de - (struct msdos_dir_entry *)bh->b_data);
+}
+
 /* Returns the inode number of the directory entry at offset pos. If bh is
    non-NULL, it is brelse'd before. Pos is incremented. The buffer header is
    returned in bh.
@@ -33,17 +41,14 @@
    AV. we make bh NULL.
  */
 static int fat__get_entry(struct inode *dir, loff_t *pos,
-			  struct buffer_head **bh,
-			  struct msdos_dir_entry **de, loff_t *i_pos)
+			  struct buffer_head **bh, struct msdos_dir_entry **de)
 {
 	struct super_block *sb = dir->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	sector_t phys, iblock;
-	loff_t offset;
+	int offset;
 	int err;
 
 next:
-	offset = *pos;
 	if (*bh)
 		brelse(*bh);
 
@@ -62,27 +67,25 @@ next:
 		goto next;
 	}
 
-	offset &= sb->s_blocksize - 1;
+	offset = *pos & (sb->s_blocksize - 1);
 	*pos += sizeof(struct msdos_dir_entry);
 	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
-	*i_pos = ((loff_t)phys << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
 
 	return 0;
 }
 
 static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 				struct buffer_head **bh,
-				struct msdos_dir_entry **de, loff_t *i_pos)
+				struct msdos_dir_entry **de)
 {
 	/* Fast stuff first */
 	if (*bh && *de &&
 	    (*de - (struct msdos_dir_entry *)(*bh)->b_data) < MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
 		*pos += sizeof(struct msdos_dir_entry);
 		(*de)++;
-		(*i_pos)++;
 		return 0;
 	}
-	return fat__get_entry(dir, pos, bh, de, i_pos);
+	return fat__get_entry(dir, pos, bh, de);
 }
 
 /*
@@ -214,12 +217,12 @@ int fat_search_long(struct inode *inode,
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	int anycase = (MSDOS_SB(sb)->options.name_check != 's');
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
+	loff_t cpos = 0;
 	int chl, i, j, last_u, err;
-	loff_t i_pos, cpos = 0;
 
 	err = -ENOENT;
 	while(1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de, &i_pos) == -1)
+		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
 			goto EODir;
 parse_record:
 		nr_slots = 0;
@@ -270,7 +273,7 @@ parse_long:
 				if (ds->id & 0x40) {
 					unicode[offset + 13] = 0;
 				}
-				if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos)<0)
+				if (fat_get_entry(inode, &cpos, &bh, &de) < 0)
 					goto EODir;
 				if (slot == 0)
 					break;
@@ -354,11 +357,11 @@ parse_long:
 
 Found:
 	nr_slots++;	/* include the de */
-	sinfo->i_pos = i_pos;
 	sinfo->slot_off = cpos - nr_slots * sizeof(*de);
 	sinfo->nr_slots = nr_slots;
 	sinfo->de = de;
 	sinfo->bh = bh;
+	sinfo->i_pos = fat_make_i_pos(sb, sinfo->bh, sinfo->de);
 	err = 0;
 EODir:
 	if (unicode)
@@ -401,7 +404,7 @@ static int fat_readdirx(struct inode *in
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
 	unsigned long inum;
 	int chi, chl, i, i2, j, last, last_u, dotoffset = 0;
-	loff_t i_pos, cpos;
+	loff_t cpos;
 	int ret = 0;
 
 	lock_kernel();
@@ -429,7 +432,7 @@ static int fat_readdirx(struct inode *in
 	bh = NULL;
 GetNew:
 	long_slots = 0;
-	if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
+	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
 		goto EODir;
 	/* Check for long filename entry */
 	if (isvfat) {
@@ -486,7 +489,7 @@ ParseLong:
 			if (ds->id & 0x40) {
 				unicode[offset + 13] = 0;
 			}
-			if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
+			if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
 				goto EODir;
 			if (slot == 0)
 				break;
@@ -578,6 +581,7 @@ ParseLong:
 	else if (!memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
 		inum = parent_ino(filp->f_dentry);
 	} else {
+		loff_t i_pos = fat_make_i_pos(sb, bh, de);
 		struct inode *tmp = fat_iget(sb, i_pos);
 		if (tmp) {
 			inum = tmp->i_ino;
@@ -748,9 +752,9 @@ struct file_operations fat_dir_operation
 
 static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
-			       struct msdos_dir_entry **de, loff_t *i_pos)
+			       struct msdos_dir_entry **de)
 {
-	while (fat_get_entry(dir, pos, bh, de, i_pos) >= 0) {
+	while (fat_get_entry(dir, pos, bh, de) >= 0) {
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;
@@ -769,9 +773,11 @@ int fat_get_dotdot_entry(struct inode *d
 
 	offset = 0;
 	*bh = NULL;
-	while (fat_get_short_entry(dir, &offset, bh, de, i_pos) >= 0) {
-		if (!strncmp((*de)->name, MSDOS_DOTDOT, MSDOS_NAME))
+	while (fat_get_short_entry(dir, &offset, bh, de) >= 0) {
+		if (!strncmp((*de)->name, MSDOS_DOTDOT, MSDOS_NAME)) {
+			*i_pos = fat_make_i_pos(dir->i_sb, *bh, *de);
 			return 0;
+		}
 	}
 	return -ENOENT;
 }
@@ -783,12 +789,12 @@ int fat_dir_empty(struct inode *dir)
 {
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
-	loff_t cpos, i_pos;
+	loff_t cpos;
 	int result = 0;
 
 	bh = NULL;
 	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
+	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
 		if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
 		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
 			result = -ENOTEMPTY;
@@ -809,12 +815,12 @@ int fat_subdirs(struct inode *dir)
 {
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
-	loff_t cpos, i_pos;
+	loff_t cpos;
 	int count = 0;
 
 	bh = NULL;
 	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
+	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
 		if (de->attr & ATTR_DIR)
 			count++;
 	}
@@ -829,13 +835,16 @@ int fat_subdirs(struct inode *dir)
 int fat_scan(struct inode *dir, const unsigned char *name,
 	     struct fat_slot_info *sinfo)
 {
+	struct super_block *sb = dir->i_sb;
+
 	sinfo->slot_off = 0;
 	sinfo->bh = NULL;
 	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
-				   &sinfo->de, &sinfo->i_pos) >= 0) {
+				   &sinfo->de) >= 0) {
 		if (!strncmp(sinfo->de->name, name, MSDOS_NAME)) {
 			sinfo->slot_off -= sizeof(*sinfo->de);
 			sinfo->nr_slots = 1;
+			sinfo->i_pos = fat_make_i_pos(sb, sinfo->bh, sinfo->de);
 			return 0;
 		}
 	}
@@ -849,12 +858,11 @@ static int __fat_remove_entries(struct i
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de, *endp;
-	loff_t i_pos;
 	int err = 0, orig_slots;
 
 	while (nr_slots) {
 		bh = NULL;
-		if (fat_get_entry(dir, &pos, &bh, &de, &i_pos) < 0) {
+		if (fat_get_entry(dir, &pos, &bh, &de) < 0) {
 			err = -EIO;
 			break;
 		}
@@ -1103,7 +1111,7 @@ static int fat_add_new_entries(struct in
 	get_bh(bhs[n]);
 	*bh = bhs[n];
 	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
-	*i_pos = ((loff_t)blknr << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
+	*i_pos = fat_make_i_pos(sb, *bh, *de);
 
 	/* Second stage: clear the rest of cluster, and write outs */
 	err = fat_zeroed_cluster(dir, start_blknr, ++n, bhs, MAX_BUF_PER_PAGE);
@@ -1141,7 +1149,7 @@ int fat_add_entries(struct inode *dir, v
 	bh = prev = NULL;
 	pos = 0;
 	err = -ENOSPC;
-	while (fat_get_entry(dir, &pos, &bh, &de, &i_pos) > -1) {
+	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
 		/* check the maximum size of directory */
 		if (pos >= FAT_MAX_DIR_SIZE)
 			goto error;
@@ -1232,9 +1240,9 @@ found:
 		MSDOS_I(dir)->mmu_private += nr_cluster << sbi->cluster_bits;
 	}
 	sinfo->slot_off = pos;
-	sinfo->i_pos = i_pos;
 	sinfo->de = de;
 	sinfo->bh = bh;
+	sinfo->i_pos = fat_make_i_pos(sb, sinfo->bh, sinfo->de);
 
 	return 0;
 
_
