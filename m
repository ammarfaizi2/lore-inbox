Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUIELeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUIELeN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUIELdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:33:12 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:29957 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266366AbUIELbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:31:31 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: the inode hash from per module to per sb (4/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 05 Sep 2004 20:31:23 +0900
Message-ID: <87zn45uf3o.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fatfs_syms.c         |    2 -
 fs/fat/inode.c              |   57 +++++++++++++++++++++++---------------------
 include/linux/msdos_fs.h    |    1 
 include/linux/msdos_fs_sb.h |    7 +++++
 4 files changed, 39 insertions(+), 28 deletions(-)

diff -puN fs/fat/fatfs_syms.c~fat_per-sb-inodehash fs/fat/fatfs_syms.c
--- linux-2.6.9-rc1/fs/fat/fatfs_syms.c~fat_per-sb-inodehash	2004-09-05 18:52:34.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/fatfs_syms.c	2004-09-05 18:52:34.000000000 +0900
@@ -40,7 +40,7 @@ void __exit fat_destroy_inodecache(void)
 static int __init init_fat_fs(void)
 {
 	int ret;
-	fat_hash_init();
+
 	ret = fat_cache_init();
 	if (ret < 0)
 		return ret;
diff -puN fs/fat/inode.c~fat_per-sb-inodehash fs/fat/inode.c
--- linux-2.6.9-rc1/fs/fat/inode.c~fat_per-sb-inodehash	2004-09-05 18:52:34.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/inode.c	2004-09-05 18:54:16.000000000 +0900
@@ -55,17 +55,14 @@ static char fat_default_iocharset[] = CO
  *			and consider negative result as cache miss.
  */
 
-#define FAT_HASH_BITS	8
-#define FAT_HASH_SIZE	(1UL << FAT_HASH_BITS)
-#define FAT_HASH_MASK	(FAT_HASH_SIZE-1)
-static struct hlist_head fat_inode_hashtable[FAT_HASH_SIZE];
-static spinlock_t fat_inode_lock = SPIN_LOCK_UNLOCKED;
-
-void fat_hash_init(void)
+static void fat_hash_init(struct super_block *sb)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int i;
+
+	spin_lock_init(&sbi->inode_hash_lock);
 	for (i = 0; i < FAT_HASH_SIZE; i++)
-		INIT_HLIST_HEAD(&fat_inode_hashtable[i]);
+		INIT_HLIST_HEAD(&sbi->inode_hashtable[i]);
 }
 
 static inline unsigned long fat_hash(struct super_block *sb, loff_t i_pos)
@@ -77,39 +74,43 @@ static inline unsigned long fat_hash(str
 
 void fat_attach(struct inode *inode, loff_t i_pos)
 {
-	spin_lock(&fat_inode_lock);
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	spin_lock(&sbi->inode_hash_lock);
 	MSDOS_I(inode)->i_pos = i_pos;
 	hlist_add_head(&MSDOS_I(inode)->i_fat_hash,
-		fat_inode_hashtable + fat_hash(inode->i_sb, i_pos));
-	spin_unlock(&fat_inode_lock);
+			sbi->inode_hashtable + fat_hash(sb, i_pos));
+	spin_unlock(&sbi->inode_hash_lock);
 }
 
 void fat_detach(struct inode *inode)
 {
-	spin_lock(&fat_inode_lock);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	spin_lock(&sbi->inode_hash_lock);
 	MSDOS_I(inode)->i_pos = 0;
 	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
-	spin_unlock(&fat_inode_lock);
+	spin_unlock(&sbi->inode_hash_lock);
 }
 
 struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
-	struct hlist_head *head = fat_inode_hashtable + fat_hash(sb, i_pos);
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct hlist_head *head = sbi->inode_hashtable + fat_hash(sb, i_pos);
 	struct hlist_node *_p;
 	struct msdos_inode_info *i;
 	struct inode *inode = NULL;
 
-	spin_lock(&fat_inode_lock);
+	spin_lock(&sbi->inode_hash_lock);
 	hlist_for_each_entry(i, _p, head, i_fat_hash) {
-		if (i->vfs_inode.i_sb != sb)
-			continue;
+		BUG_ON(i->vfs_inode.i_sb != sb);
 		if (i->i_pos != i_pos)
 			continue;
 		inode = igrab(&i->vfs_inode);
 		if (inode)
 			break;
 	}
-	spin_unlock(&fat_inode_lock);
+	spin_unlock(&sbi->inode_hash_lock);
 	return inode;
 }
 
@@ -152,13 +153,15 @@ void fat_delete_inode(struct inode *inod
 
 void fat_clear_inode(struct inode *inode)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
 	if (is_bad_inode(inode))
 		return;
 	lock_kernel();
-	spin_lock(&fat_inode_lock);
+	spin_lock(&sbi->inode_hash_lock);
 	fat_cache_inval_inode(inode);
 	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
-	spin_unlock(&fat_inode_lock);
+	spin_unlock(&sbi->inode_hash_lock);
 	unlock_kernel();
 }
 
@@ -819,6 +822,7 @@ int fat_fill_super(struct super_block *s
 		goto out_fail;
 
 	/* set up enough so that it can read an inode */
+	fat_hash_init(sb);
 	init_MUTEX(&sbi->fat_lock);
 
 	error = -EIO;
@@ -1228,6 +1232,7 @@ static int fat_fill_inode(struct inode *
 void fat_write_inode(struct inode *inode, int wait)
 {
 	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
 	loff_t i_pos;
@@ -1238,22 +1243,22 @@ retry:
 		return;
 	}
 	lock_kernel();
-	if (!(bh = sb_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
+	if (!(bh = sb_bread(sb, i_pos >> sbi->dir_per_block_bits))) {
 		printk(KERN_ERR "FAT: unable to read inode block "
 		       "for updating (i_pos %lld)\n", i_pos);
 		unlock_kernel();
 		return /* -EIO */;
 	}
-	spin_lock(&fat_inode_lock);
+	spin_lock(&sbi->inode_hash_lock);
 	if (i_pos != MSDOS_I(inode)->i_pos) {
-		spin_unlock(&fat_inode_lock);
+		spin_unlock(&sbi->inode_hash_lock);
 		brelse(bh);
 		unlock_kernel();
 		goto retry;
 	}
 
 	raw_entry = &((struct msdos_dir_entry *) (bh->b_data))
-	    [i_pos & (MSDOS_SB(sb)->dir_per_block - 1)];
+	    [i_pos & (sbi->dir_per_block - 1)];
 	if (S_ISDIR(inode->i_mode)) {
 		raw_entry->attr = ATTR_DIR;
 		raw_entry->size = 0;
@@ -1267,11 +1272,11 @@ retry:
 	raw_entry->start = CT_LE_W(MSDOS_I(inode)->i_logstart);
 	raw_entry->starthi = CT_LE_W(MSDOS_I(inode)->i_logstart >> 16);
 	fat_date_unix2dos(inode->i_mtime.tv_sec, &raw_entry->time, &raw_entry->date);
-	if (MSDOS_SB(sb)->options.isvfat) {
+	if (sbi->options.isvfat) {
 		fat_date_unix2dos(inode->i_ctime.tv_sec,&raw_entry->ctime,&raw_entry->cdate);
 		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
 	}
-	spin_unlock(&fat_inode_lock);
+	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
 	brelse(bh);
 	unlock_kernel();
diff -puN include/linux/msdos_fs.h~fat_per-sb-inodehash include/linux/msdos_fs.h
--- linux-2.6.9-rc1/include/linux/msdos_fs.h~fat_per-sb-inodehash	2004-09-05 18:52:34.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs.h	2004-09-05 18:52:34.000000000 +0900
@@ -262,7 +262,6 @@ extern int fat_get_block(struct inode *i
 extern void fat_truncate(struct inode *inode);
 
 /* fat/inode.c */
-extern void fat_hash_init(void);
 extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
diff -puN include/linux/msdos_fs_sb.h~fat_per-sb-inodehash include/linux/msdos_fs_sb.h
--- linux-2.6.9-rc1/include/linux/msdos_fs_sb.h~fat_per-sb-inodehash	2004-09-05 18:52:34.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs_sb.h	2004-09-05 18:52:34.000000000 +0900
@@ -26,6 +26,10 @@ struct fat_mount_options {
 		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
 };
 
+#define FAT_HASH_BITS	8
+#define FAT_HASH_SIZE	(1UL << FAT_HASH_BITS)
+#define FAT_HASH_MASK	(FAT_HASH_SIZE-1)
+
 struct msdos_sb_info {
 	unsigned short sec_per_clus; /* sectors/cluster */
 	unsigned short cluster_bits; /* log2(cluster_size) */
@@ -48,6 +52,9 @@ struct msdos_sb_info {
 	void *dir_ops;		     /* Opaque; default directory operations */
 	int dir_per_block;	     /* dir entries per block */
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
+
+	spinlock_t inode_hash_lock;
+	struct hlist_head inode_hashtable[FAT_HASH_SIZE];
 };
 
 #endif
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
