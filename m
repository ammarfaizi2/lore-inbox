Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSFZRSX>; Wed, 26 Jun 2002 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSFZRSW>; Wed, 26 Jun 2002 13:18:22 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:65037 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S316683AbSFZRSU>; Wed, 26 Jun 2002 13:18:20 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] change of cont_prepare_write() for the large file
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 27 Jun 2002 02:18:10 +0900
Message-ID: <87d6ueot65.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

I'm going to change the cont_prepare_write() for support of 4G - 1 file
on FAT32. And the following change break the adfs/affs/hfs/hpfs/qnx4.

diff -urN linux-2.5.24/fs/buffer.c fat_big-file-2.5.24/fs/buffer.c
--- linux-2.5.24/fs/buffer.c	Sun Jun 23 15:43:09 2002
+++ fat_big-file-2.5.24/fs/buffer.c	Sun Jun 23 15:31:44 2002
@@ -1930,7 +1930,7 @@
  */
 
 int cont_prepare_write(struct page *page, unsigned offset,
-		unsigned to, get_block_t *get_block, unsigned long *bytes)
+		unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;

The attached patch fixes those fs. If no problem, I'll submit
patches at this weekend.

Please review. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Disposition: attachment; filename=fat_big-file-2.5.24.diff

diff -urN linux-2.5.24/fs/buffer.c fat_big-file-2.5.24/fs/buffer.c
--- linux-2.5.24/fs/buffer.c	Sun Jun 23 15:43:09 2002
+++ fat_big-file-2.5.24/fs/buffer.c	Sun Jun 23 15:31:44 2002
@@ -1930,7 +1930,7 @@
  */
 
 int cont_prepare_write(struct page *page, unsigned offset,
-		unsigned to, get_block_t *get_block, unsigned long *bytes)
+		unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
diff -urN linux-2.5.24/fs/fat/file.c fat_big-file-2.5.24/fs/fat/file.c
--- linux-2.5.24/fs/fat/file.c	Sun Jun 23 15:43:10 2002
+++ fat_big-file-2.5.24/fs/fat/file.c	Sun Jun 23 15:31:45 2002
@@ -54,7 +54,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		BUG();
 		return -EIO;
 	}
diff -urN linux-2.5.24/fs/fat/inode.c fat_big-file-2.5.24/fs/fat/inode.c
--- linux-2.5.24/fs/fat/inode.c	Sun Jun 23 15:43:10 2002
+++ fat_big-file-2.5.24/fs/fat/inode.c	Sun Jun 23 15:31:45 2002
@@ -417,7 +417,7 @@
 	}
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -775,6 +775,8 @@
 		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
 
+		sb->s_maxbytes = 0xffffffff;
+		
 		/* MC - if info_sector is 0, don't multiply by 0 */
 		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		if (sbi->fsinfo_sector == 0)
@@ -1063,7 +1065,7 @@
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	inode->i_mtime = inode->i_atime =
 		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_ctime =
diff -urN linux-2.5.24/include/linux/buffer_head.h fat_big-file-2.5.24/include/linux/buffer_head.h
--- linux-2.5.24/include/linux/buffer_head.h	Sun Jun 23 15:43:30 2002
+++ fat_big-file-2.5.24/include/linux/buffer_head.h	Sun Jun 23 15:32:04 2002
@@ -180,7 +180,7 @@
 int block_read_full_page(struct page*, get_block_t*);
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
+				loff_t *);
 int generic_cont_expand(struct inode *inode, loff_t size) ;
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 int block_sync_page(struct page *);
diff -urN linux-2.5.24/include/linux/msdos_fs_i.h fat_big-file-2.5.24/include/linux/msdos_fs_i.h
--- linux-2.5.24/include/linux/msdos_fs_i.h	Sun Jun 23 15:43:31 2002
+++ fat_big-file-2.5.24/include/linux/msdos_fs_i.h	Sun Jun 23 15:32:06 2002
@@ -8,7 +8,7 @@
  */
 
 struct msdos_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */

--=-=-=
Content-Disposition: attachment; filename=mmu_private-fix-2.5.24.diff

diff -urN fat_big-file-2.5.24/include/linux/adfs_fs_i.h mmu_private-fix-2.5.24/include/linux/adfs_fs_i.h
--- fat_big-file-2.5.24/include/linux/adfs_fs_i.h	Sun Jun 23 15:32:04 2002
+++ mmu_private-fix-2.5.24/include/linux/adfs_fs_i.h	Sun Jun 23 15:38:29 2002
@@ -11,7 +11,7 @@
  * adfs file system inode data in memory
  */
 struct adfs_inode_info {
-	unsigned long	mmu_private;
+	loff_t		mmu_private;
 	unsigned long	parent_id;	/* object id of parent		*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
diff -urN fat_big-file-2.5.24/include/linux/affs_fs_i.h mmu_private-fix-2.5.24/include/linux/affs_fs_i.h
--- fat_big-file-2.5.24/include/linux/affs_fs_i.h	Sun Jun 23 15:32:04 2002
+++ mmu_private-fix-2.5.24/include/linux/affs_fs_i.h	Sun Jun 23 15:38:29 2002
@@ -35,7 +35,7 @@
 	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
 	u32	 i_ext_last;			/* last accessed extended block */
 	struct buffer_head *i_ext_bh;		/* bh of last extended block */
-	unsigned long mmu_private;
+	loff_t	 mmu_private;
 	u32	 i_protect;			/* unused attribute bits */
 	u32	 i_lastalloc;			/* last allocated block */
 	int	 i_pa_cnt;			/* number of preallocated blocks */
diff -urN fat_big-file-2.5.24/include/linux/hfs_fs_i.h mmu_private-fix-2.5.24/include/linux/hfs_fs_i.h
--- fat_big-file-2.5.24/include/linux/hfs_fs_i.h	Sun Jun 23 15:32:05 2002
+++ mmu_private-fix-2.5.24/include/linux/hfs_fs_i.h	Sun Jun 23 15:38:30 2002
@@ -19,7 +19,7 @@
 struct hfs_inode_info {
 	int				magic;     /* A magic number */
 
-	unsigned long			mmu_private;
+	loff_t				mmu_private;
 	struct hfs_cat_entry		*entry;
 
 	/* For a regular or header file */
diff -urN fat_big-file-2.5.24/include/linux/hpfs_fs_i.h mmu_private-fix-2.5.24/include/linux/hpfs_fs_i.h
--- fat_big-file-2.5.24/include/linux/hpfs_fs_i.h	Sun Jun 23 15:32:05 2002
+++ mmu_private-fix-2.5.24/include/linux/hpfs_fs_i.h	Sun Jun 23 15:38:30 2002
@@ -2,7 +2,7 @@
 #define _HPFS_FS_I
 
 struct hpfs_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	ino_t i_parent_dir;	/* (directories) gives fnode of parent dir */
 	unsigned i_dno;		/* (directories) root dnode */
 	unsigned i_dpos;	/* (directories) temp for readdir */
diff -urN fat_big-file-2.5.24/include/linux/qnx4_fs.h mmu_private-fix-2.5.24/include/linux/qnx4_fs.h
--- fat_big-file-2.5.24/include/linux/qnx4_fs.h	Sun Jun 23 15:32:06 2002
+++ mmu_private-fix-2.5.24/include/linux/qnx4_fs.h	Sun Jun 23 15:38:31 2002
@@ -106,7 +106,7 @@
 
 struct qnx4_inode_info {
 	struct qnx4_inode_entry raw;
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	struct inode vfs_inode;
 };
 

--=-=-=--
