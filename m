Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVCETkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVCETkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCETeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:34:13 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:26885 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261205AbVCETL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:29 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 21/29] FAT: make the fat_get_entry()/fat__get_entry() the
 static
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
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:55:46 +0900
In-Reply-To: <877jklq5x7.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:55:00 +0900")
Message-ID: <873bv9q5vx.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |   63 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/misc.c            |   50 -------------------------------------
 include/linux/msdos_fs.h |   17 ------------
 3 files changed, 63 insertions(+), 67 deletions(-)

diff -puN fs/fat/dir.c~sync08-fat_tweak1 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync08-fat_tweak1	2005-03-06 02:37:02.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:37:03.000000000 +0900
@@ -22,6 +22,69 @@
 #include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
+/* Returns the inode number of the directory entry at offset pos. If bh is
+   non-NULL, it is brelse'd before. Pos is incremented. The buffer header is
+   returned in bh.
+   AV. Most often we do it item-by-item. Makes sense to optimize.
+   AV. OK, there we go: if both bh and de are non-NULL we assume that we just
+   AV. want the next entry (took one explicit de=NULL in vfat/namei.c).
+   AV. It's done in fat_get_entry() (inlined), here the slow case lives.
+   AV. Additionally, when we return -1 (i.e. reached the end of directory)
+   AV. we make bh NULL.
+ */
+static int fat__get_entry(struct inode *dir, loff_t *pos,
+			  struct buffer_head **bh,
+			  struct msdos_dir_entry **de, loff_t *i_pos)
+{
+	struct super_block *sb = dir->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	sector_t phys, iblock;
+	loff_t offset;
+	int err;
+
+next:
+	offset = *pos;
+	if (*bh)
+		brelse(*bh);
+
+	*bh = NULL;
+	iblock = *pos >> sb->s_blocksize_bits;
+	err = fat_bmap(dir, iblock, &phys);
+	if (err || !phys)
+		return -1;	/* beyond EOF or error */
+
+	*bh = sb_bread(sb, phys);
+	if (*bh == NULL) {
+		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
+		       (unsigned long long)phys);
+		/* skip this block */
+		*pos = (iblock + 1) << sb->s_blocksize_bits;
+		goto next;
+	}
+
+	offset &= sb->s_blocksize - 1;
+	*pos += sizeof(struct msdos_dir_entry);
+	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
+	*i_pos = ((loff_t)phys << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
+
+	return 0;
+}
+
+static inline int fat_get_entry(struct inode *dir, loff_t *pos,
+				struct buffer_head **bh,
+				struct msdos_dir_entry **de, loff_t *i_pos)
+{
+	/* Fast stuff first */
+	if (*bh && *de &&
+	    (*de - (struct msdos_dir_entry *)(*bh)->b_data) < MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
+		*pos += sizeof(struct msdos_dir_entry);
+		(*de)++;
+		(*i_pos)++;
+		return 0;
+	}
+	return fat__get_entry(dir, pos, bh, de, i_pos);
+}
+
 /*
  * Convert Unicode 16 to UTF8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
diff -puN fs/fat/misc.c~sync08-fat_tweak1 fs/fat/misc.c
--- linux-2.6.11/fs/fat/misc.c~sync08-fat_tweak1	2005-03-06 02:37:02.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/misc.c	2005-03-06 02:37:03.000000000 +0900
@@ -194,56 +194,6 @@ void fat_date_unix2dos(int unix_date, __
 
 EXPORT_SYMBOL(fat_date_unix2dos);
 
-/* Returns the inode number of the directory entry at offset pos. If bh is
-   non-NULL, it is brelse'd before. Pos is incremented. The buffer header is
-   returned in bh.
-   AV. Most often we do it item-by-item. Makes sense to optimize.
-   AV. OK, there we go: if both bh and de are non-NULL we assume that we just
-   AV. want the next entry (took one explicit de=NULL in vfat/namei.c).
-   AV. It's done in fat_get_entry() (inlined), here the slow case lives.
-   AV. Additionally, when we return -1 (i.e. reached the end of directory)
-   AV. we make bh NULL.
- */
-
-int fat__get_entry(struct inode *dir, loff_t *pos, struct buffer_head **bh,
-		   struct msdos_dir_entry **de, loff_t *i_pos)
-{
-	struct super_block *sb = dir->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	sector_t phys, iblock;
-	loff_t offset;
-	int err;
-
-next:
-	offset = *pos;
-	if (*bh)
-		brelse(*bh);
-
-	*bh = NULL;
-	iblock = *pos >> sb->s_blocksize_bits;
-	err = fat_bmap(dir, iblock, &phys);
-	if (err || !phys)
-		return -1;	/* beyond EOF or error */
-
-	*bh = sb_bread(sb, phys);
-	if (*bh == NULL) {
-		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
-		       (unsigned long long)phys);
-		/* skip this block */
-		*pos = (iblock + 1) << sb->s_blocksize_bits;
-		goto next;
-	}
-
-	offset &= sb->s_blocksize - 1;
-	*pos += sizeof(struct msdos_dir_entry);
-	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
-	*i_pos = ((loff_t)phys << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(fat__get_entry);
-
 int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 {
 	int i, e, err = 0;
diff -puN include/linux/msdos_fs.h~sync08-fat_tweak1 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync08-fat_tweak1	2005-03-06 02:37:02.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:37:03.000000000 +0900
@@ -405,23 +405,6 @@ extern void fat_clusters_flush(struct su
 extern int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster);
 extern int date_dos2unix(unsigned short time, unsigned short date);
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
-extern int fat__get_entry(struct inode *dir, loff_t *pos,
-			  struct buffer_head **bh,
-			  struct msdos_dir_entry **de, loff_t *i_pos);
-static __inline__ int fat_get_entry(struct inode *dir, loff_t *pos,
-				    struct buffer_head **bh,
-				    struct msdos_dir_entry **de, loff_t *i_pos)
-{
-	/* Fast stuff first */
-	if (*bh && *de &&
-	    (*de - (struct msdos_dir_entry *)(*bh)->b_data) < MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
-		*pos += sizeof(struct msdos_dir_entry);
-		(*de)++;
-		(*i_pos)++;
-		return 0;
-	}
-	return fat__get_entry(dir, pos, bh, de, i_pos);
-}
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 
 #endif /* __KERNEL__ */
_
