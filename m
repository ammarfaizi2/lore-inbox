Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317318AbSFGSqh>; Fri, 7 Jun 2002 14:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317321AbSFGSqg>; Fri, 7 Jun 2002 14:46:36 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:44559 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317318AbSFGSqf>; Fri, 7 Jun 2002 14:46:35 -0400
To: F ker <f_ker@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] vfat doesn't support files > 2GB under Linux, under Windoze it does
In-Reply-To: <20020606224935.87914.qmail@web14604.mail.yahoo.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 08 Jun 2002 03:46:26 +0900
Message-ID: <87ptz3orjx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

F ker <f_ker@yahoo.co.uk> writes:

> Could someone direct me towards a patch?  Many thanks.

This patch is for 2.5.19, but, the back porting to 2.5.18 should
be not difficult.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Disposition: attachment; filename=fat-big_file-2.5.19.diff

diff -urN linux-2.5.19/fs/buffer.c fat-big_file-2.5.19/fs/buffer.c
--- linux-2.5.19/fs/buffer.c	Sat Jun  8 03:33:39 2002
+++ fat-big_file-2.5.19/fs/buffer.c	Sat Jun  8 01:29:20 2002
@@ -1931,7 +1931,7 @@
  */
 
 int cont_prepare_write(struct page *page, unsigned offset,
-		unsigned to, get_block_t *get_block, unsigned long *bytes)
+		unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
diff -urN linux-2.5.19/fs/fat/file.c fat-big_file-2.5.19/fs/fat/file.c
--- linux-2.5.19/fs/fat/file.c	Sat Jun  8 03:33:40 2002
+++ fat-big_file-2.5.19/fs/fat/file.c	Sat Jun  8 01:56:24 2002
@@ -54,7 +54,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		BUG();
 		return -EIO;
 	}
diff -urN linux-2.5.19/fs/fat/inode.c fat-big_file-2.5.19/fs/fat/inode.c
--- linux-2.5.19/fs/fat/inode.c	Sat Jun  8 03:33:40 2002
+++ fat-big_file-2.5.19/fs/fat/inode.c	Sat Jun  8 01:31:41 2002
@@ -775,6 +775,8 @@
 		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
 
+		sb->s_maxbytes = 0xffffffff;
+		
 		/* MC - if info_sector is 0, don't multiply by 0 */
 		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		if (sbi->fsinfo_sector == 0)
diff -urN linux-2.5.19/include/linux/buffer_head.h fat-big_file-2.5.19/include/linux/buffer_head.h
--- linux-2.5.19/include/linux/buffer_head.h	Sat Jun  8 03:33:58 2002
+++ fat-big_file-2.5.19/include/linux/buffer_head.h	Sat Jun  8 01:31:01 2002
@@ -197,7 +197,7 @@
 int block_read_full_page(struct page*, get_block_t*);
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
+				loff_t *);
 int generic_cont_expand(struct inode *inode, loff_t size) ;
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 int block_sync_page(struct page *);
diff -urN linux-2.5.19/include/linux/msdos_fs_i.h fat-big_file-2.5.19/include/linux/msdos_fs_i.h
--- linux-2.5.19/include/linux/msdos_fs_i.h	Sat Jun  8 03:33:59 2002
+++ fat-big_file-2.5.19/include/linux/msdos_fs_i.h	Sat Jun  8 01:43:41 2002
@@ -8,7 +8,7 @@
  */
 
 struct msdos_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */

--=-=-=--
