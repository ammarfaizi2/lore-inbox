Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTLaJOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTLaJOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:14:53 -0500
Received: from codepoet.org ([166.70.99.138]:11236 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263609AbTLaJOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:14:01 -0500
Date: Wed, 31 Dec 2003 02:14:00 -0700
From: Erik Andersen <andersen@codepoet.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] FAT: Support the large partition (> 128GB) for 2.4
Message-ID: <20031231091359.GA13996@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <87k74or58m.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k74or58m.fsf@devron.myhome.or.jp>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 23, 2003 at 05:02:01AM +0900, OGAWA Hirofumi wrote:
> Hello,
> 
> Some peoples reported the problem of fatfs on large partion (> 128GB),
> and fixed by the following patch.
> 
> 
> The "directory entry pointer" is position of the directory entry in
> the partition. like the following,
> 
> in fs/fat/misc.c:fat__get_entry()
> 
>     offset &= sb->s_blocksize - 1;
>     *de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
>     *ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
>     ^^^
> 
> This is used for updates (not create) of the directory entry, and
> overflowed by large partition (> 128GB).

I think this additional fat32 patch would be a good idea for
2.4.x.  Could you review these changes and perhaps fold them into
your patch for inclusion into 2.4.x.  This patch fixes support
for the full 4GB (-1 bytes) allowable fat32 file size, and should
be added onto of your previous patch for large fat32 filesystems.



diff -urN linux/fs.orig/buffer.c linux/fs/buffer.c
--- linux/fs.orig/buffer.c	2003-12-31 00:34:57.000000000 -0700
+++ linux/fs/buffer.c	2003-12-31 00:45:40.000000000 -0700
@@ -1940,7 +1940,7 @@
  * We may have to extend the file.
  */
 
-int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, unsigned long *bytes)
+int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
diff -urN linux/fs.orig/fat/dir.c linux/fs/fat/dir.c
--- linux/fs.orig/fat/dir.c	2003-12-31 00:36:59.000000000 -0700
+++ linux/fs/fat/dir.c	2003-12-31 01:22:34.000000000 -0700
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
diff -urN linux/fs.orig/fat/file.c linux/fs/fat/file.c
--- linux/fs.orig/fat/file.c	2001-08-12 11:56:56.000000000 -0600
+++ linux/fs/fat/file.c	2003-12-31 01:39:20.000000000 -0700
@@ -62,7 +62,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		BUG();
 		return -EIO;
 	}
diff -urN linux/fs.orig/fat/inode.c linux/fs/fat/inode.c
--- linux/fs.orig/fat/inode.c	2003-12-31 00:36:59.000000000 -0700
+++ linux/fs/fat/inode.c	2003-12-31 01:53:02.000000000 -0700
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
diff -urN linux/include/linux.orig/adfs_fs_i.h linux/include/linux/adfs_fs_i.h
--- linux/include/linux.orig/adfs_fs_i.h	2000-02-13 11:45:13.000000000 -0700
+++ linux/include/linux/adfs_fs_i.h	2003-12-31 00:45:40.000000000 -0700
@@ -11,7 +11,7 @@
  * adfs file system inode data in memory
  */
 struct adfs_inode_info {
-	unsigned long	mmu_private;
+	loff_t		mmu_private;
 	unsigned long	parent_id;	/* object id of parent		*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
diff -urN linux/include/linux.orig/affs_fs_i.h linux/include/linux/affs_fs_i.h
--- linux/include/linux.orig/affs_fs_i.h	2001-11-22 12:46:19.000000000 -0700
+++ linux/include/linux/affs_fs_i.h	2003-12-31 00:45:40.000000000 -0700
@@ -36,7 +36,7 @@
 	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
 	u32	 i_ext_last;			/* last accessed extended block */
 	struct buffer_head *i_ext_bh;		/* bh of last extended block */
-	unsigned long mmu_private;
+	loff_t	 mmu_private;
 	u32	 i_protect;			/* unused attribute bits */
 	u32	 i_lastalloc;			/* last allocated block */
 	int	 i_pa_cnt;			/* number of preallocated blocks */
diff -urN linux/include/linux.orig/fs.h linux/include/linux/fs.h
--- linux/include/linux.orig/fs.h	2003-12-31 00:34:59.000000000 -0700
+++ linux/include/linux/fs.h	2003-12-31 00:45:40.000000000 -0700
@@ -1505,7 +1505,7 @@
 extern int block_read_full_page(struct page*, get_block_t*);
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
+				loff_t *);
 extern int generic_cont_expand(struct inode *inode, loff_t size) ;
 extern int block_commit_write(struct page *page, unsigned from, unsigned to);
 extern int block_sync_page(struct page *);
diff -urN linux/include/linux.orig/hfs_fs_i.h linux/include/linux/hfs_fs_i.h
--- linux/include/linux.orig/hfs_fs_i.h	2001-02-13 15:13:44.000000000 -0700
+++ linux/include/linux/hfs_fs_i.h	2003-12-31 00:45:40.000000000 -0700
@@ -19,7 +19,7 @@
 struct hfs_inode_info {
 	int				magic;     /* A magic number */
 
-	unsigned long			mmu_private;
+	loff_t				mmu_private;
 	struct hfs_cat_entry		*entry;
 
 	/* For a regular or header file */
diff -urN linux/include/linux.orig/hpfs_fs_i.h linux/include/linux/hpfs_fs_i.h
--- linux/include/linux.orig/hpfs_fs_i.h	2000-02-10 13:17:00.000000000 -0700
+++ linux/include/linux/hpfs_fs_i.h	2003-12-31 00:45:40.000000000 -0700
@@ -2,7 +2,7 @@
 #define _HPFS_FS_I
 
 struct hpfs_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	ino_t i_parent_dir;	/* (directories) gives fnode of parent dir */
 	unsigned i_dno;		/* (directories) root dnode */
 	unsigned i_dpos;	/* (directories) temp for readdir */
diff -urN linux/include/linux.orig/msdos_fs_i.h linux/include/linux/msdos_fs_i.h
--- linux/include/linux.orig/msdos_fs_i.h	2003-12-31 00:36:59.000000000 -0700
+++ linux/include/linux/msdos_fs_i.h	2003-12-31 00:46:21.000000000 -0700
@@ -6,7 +6,7 @@
  */
 
 struct msdos_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
