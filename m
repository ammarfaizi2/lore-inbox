Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbUATTjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUATTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:39:23 -0500
Received: from codepoet.org ([166.70.99.138]:44467 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S265757AbUATTiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:38:54 -0500
Date: Tue, 20 Jan 2004 12:38:54 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Support 4 GB files with fat32
Message-ID: <20040120193854.GA12264@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I see you have now applied the patch from OGAWA Hirofumi.  I
submitted a follow on patch later that day which I think you 
may also want to consider.

Windows can create files up to 4GB (-1 byte) on fat32, while
Linux can currently only read/write files up to 2GB.  This patch
fixes up the 2.4.x fat32 support so it can properly support the
full fat32 file range of file sizes.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- orig/fs/buffer.c	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/fs/buffer.c	2004-01-14 19:14:29.000000000 -0700
@@ -1902,7 +1902,7 @@
  * We may have to extend the file.
  */
 
-int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, unsigned long *bytes)
+int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
--- orig/fs/fat/dir.c	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/fs/fat/dir.c	2004-01-14 19:14:29.000000000 -0700
@@ -362,15 +362,14 @@
 	unsigned char long_slots;
 	wchar_t *unicode = NULL;
 	char c, work[8], bufname[56], *ptname = bufname;
-	unsigned long lpos, dummy, *furrfu = &lpos;
+	loff_t lpos, dummy, *furrfu = &lpos;
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int isvfat = MSDOS_SB(sb)->options.isvfat;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	int nocase = MSDOS_SB(sb)->options.nocase;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
-	unsigned long inum;
 	int chi, chl, i, i2, j, last, last_u, dotoffset = 0;
-	loff_t i_pos, cpos;
+	loff_t i_pos, inum, cpos;
 
 	cpos = filp->f_pos;
 /* Fake . and .. for the root directory. */
--- orig/fs/fat/file.c	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/fs/fat/file.c	2004-01-14 19:14:29.000000000 -0700
@@ -62,7 +62,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		BUG();
 		return -EIO;
 	}
--- orig/fs/fat/inode.c	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/fs/fat/inode.c	2004-01-14 19:14:29.000000000 -0700
@@ -406,7 +406,7 @@
 	}
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -556,8 +556,8 @@
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	char *p;
-	int logical_sector_size, hard_blksize, fat_clusters = 0;
-	unsigned int total_sectors, rootdir_sectors;
+	int logical_sector_size, hard_blksize;
+	unsigned long total_sectors, rootdir_sectors, fat_clusters = 0;
 	int fat32, debug, error, fat, cp;
 	struct fat_mount_options opts;
 	char buf[50];
@@ -651,6 +651,7 @@
 		fat32 = 1;
 		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
+		sb->s_maxbytes = 0xffffffff;
 
 		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		/* MC - if info_sector is 0, don't multiply by 0 */
@@ -957,7 +958,7 @@
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	inode->i_mtime = inode->i_atime =
 		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_ctime =
--- orig/include/linux/adfs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/include/linux/adfs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
@@ -11,7 +11,7 @@
  * adfs file system inode data in memory
  */
 struct adfs_inode_info {
-	unsigned long	mmu_private;
+	loff_t		mmu_private;
 	unsigned long	parent_id;	/* object id of parent		*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
--- orig/include/linux/affs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/include/linux/affs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
@@ -36,7 +36,7 @@
 	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
 	u32	 i_ext_last;			/* last accessed extended block */
 	struct buffer_head *i_ext_bh;		/* bh of last extended block */
-	unsigned long mmu_private;
+	loff_t	 mmu_private;
 	u32	 i_protect;			/* unused attribute bits */
 	u32	 i_lastalloc;			/* last allocated block */
 	int	 i_pa_cnt;			/* number of preallocated blocks */
--- orig/include/linux/fs.h	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/include/linux/fs.h	2004-01-14 19:14:29.000000000 -0700
@@ -1508,7 +1508,7 @@
 extern int block_read_full_page(struct page*, get_block_t*);
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
+				loff_t *);
 extern int generic_cont_expand(struct inode *inode, loff_t size) ;
 extern int block_commit_write(struct page *page, unsigned from, unsigned to);
 extern int block_sync_page(struct page *);
--- orig/include/linux/hfs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/include/linux/hfs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
@@ -19,7 +19,7 @@
 struct hfs_inode_info {
 	int				magic;     /* A magic number */
 
-	unsigned long			mmu_private;
+	loff_t				mmu_private;
 	struct hfs_cat_entry		*entry;
 
 	/* For a regular or header file */
--- orig/include/linux/hpfs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/include/linux/hpfs_fs_i.h	2004-01-14 19:14:29.000000000 -0700
@@ -2,7 +2,7 @@
 #define _HPFS_FS_I
 
 struct hpfs_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	ino_t i_parent_dir;	/* (directories) gives fnode of parent dir */
 	unsigned i_dno;		/* (directories) root dnode */
 	unsigned i_dpos;	/* (directories) temp for readdir */
--- orig/include/linux/msdos_fs_i.h	2004-01-14 19:14:29.000000000 -0700
+++ linux-2.4.24/include/linux/msdos_fs_i.h	2004-01-14 19:14:29.000000000 -0700
@@ -6,7 +6,7 @@
  */
 
 struct msdos_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */
--- linux/include/linux/qnx4_fs_i.h.orig	2004-01-20 12:34:08.000000000 -0700
+++ linux/include/linux/qnx4_fs_i.h	2004-01-20 12:35:02.000000000 -0700
@@ -33,7 +33,7 @@
 	__u8		i_zero[4];	/*  4 */
 	qnx4_ftype_t	i_type;		/*  1 */
 	__u8		i_status;	/*  1 */
-	unsigned long	mmu_private;
+	loff_t		mmu_private;
 };
 
 #endif
