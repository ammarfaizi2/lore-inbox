Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSHWFyQ>; Fri, 23 Aug 2002 01:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHWFyQ>; Fri, 23 Aug 2002 01:54:16 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:10750 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318263AbSHWFyI>; Fri, 23 Aug 2002 01:54:08 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52979.3384.484954@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:58:11 +1000
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Large Block Device patch 7 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


THis patch changes the type of the bmap() function to allow block
numbers within a file to be greater than 2^31 (e.g., for a filesystem
using 1k blocks when PAGECACHE_SIZE is 4k), and allows bmap() to
return a value greater than 2^32 (where the filesystem is on a large partition).

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.514   -> 1.515  
#	      fs/jfs/inode.c	1.12    -> 1.13   
#	     fs/ext2/inode.c	1.41    -> 1.42   
#	       fs/bfs/file.c	1.10    -> 1.11   
#	      fs/ufs/inode.c	1.13    -> 1.14   
#	include/linux/blkdev.h	1.61    -> 1.62   
#	fs/jfs/jfs_metapage.c	1.15    -> 1.16   
#	  include/linux/fs.h	1.157   -> 1.158  
#	       fs/fat/file.c	1.16    -> 1.17   
#	     fs/sysv/itree.c	1.13    -> 1.14   
#	fs/freevxfs/vxfs_subr.c	1.9     -> 1.10   
#	     fs/adfs/inode.c	1.14    -> 1.15   
#	     fs/qnx4/inode.c	1.21    -> 1.22   
#	 fs/reiserfs/inode.c	1.63    -> 1.64   
#	fs/partitions/check.c	1.45    -> 1.46   
#	      fs/efs/inode.c	1.5     -> 1.6    
#	      fs/hpfs/file.c	1.10    -> 1.11   
#	      fs/fat/inode.c	1.42    -> 1.43   
#	    fs/minix/inode.c	1.26    -> 1.27   
#	         fs/buffer.c	1.138   -> 1.139  
#	include/linux/iso_fs.h	1.8     -> 1.9    
#	     fs/ext3/inode.c	1.32    -> 1.33   
#	    fs/isofs/inode.c	1.24    -> 1.25   
#	          fs/inode.c	1.67    -> 1.68   
#	      fs/hfs/inode.c	1.8     -> 1.9    
#	      fs/udf/inode.c	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.515
# Change type of bmap() to allow more than 2^31 blocks in an address space, and to allow
# mode than 2^31 blocks on a file system.
# 
# Also fix read_dev_sector() to allow access outside the first 2^31 sectors.
# --------------------------------------------
#
diff -Nru a/fs/adfs/inode.c b/fs/adfs/inode.c
--- a/fs/adfs/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/adfs/inode.c	Fri Aug 23 15:27:33 2002
@@ -67,7 +67,7 @@
 		&ADFS_I(page->mapping->host)->mmu_private);
 }
 
-static int _adfs_bmap(struct address_space *mapping, long block)
+static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, adfs_get_block);
 }
diff -Nru a/fs/bfs/file.c b/fs/bfs/file.c
--- a/fs/bfs/file.c	Fri Aug 23 15:27:33 2002
+++ b/fs/bfs/file.c	Fri Aug 23 15:27:33 2002
@@ -145,7 +145,7 @@
 	return block_prepare_write(page, from, to, bfs_get_block);
 }
 
-static int bfs_bmap(struct address_space *mapping, long block)
+static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, bfs_get_block);
 }
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri Aug 23 15:27:33 2002
+++ b/fs/buffer.c	Fri Aug 23 15:27:33 2002
@@ -1818,7 +1818,7 @@
 		unsigned from, unsigned to, get_block_t *get_block)
 {
 	unsigned block_start, block_end;
-	unsigned long block;
+	sector_t block;
 	int err = 0;
 	unsigned blocksize, bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
@@ -1835,7 +1835,7 @@
 	head = page_buffers(page);
 
 	bbits = inode->i_blkbits;
-	block = page->index << (PAGE_CACHE_SHIFT - bbits);
+	block = (sector_t)page->index << (PAGE_CACHE_SHIFT - bbits);
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
@@ -1966,7 +1966,7 @@
 int block_read_full_page(struct page *page, get_block_t *get_block)
 {
 	struct inode *inode = page->mapping->host;
-	unsigned long iblock, lblock;
+	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, blocks;
 	int nr, i;
@@ -1981,7 +1981,7 @@
 	head = page_buffers(page);
 
 	blocks = PAGE_CACHE_SIZE >> inode->i_blkbits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	iblock = (sector_t)page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 	lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;
 	bh = head;
 	nr = 0;
diff -Nru a/fs/efs/inode.c b/fs/efs/inode.c
--- a/fs/efs/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/efs/inode.c	Fri Aug 23 15:27:33 2002
@@ -19,7 +19,7 @@
 {
 	return block_read_full_page(page,efs_get_block);
 }
-static int _efs_bmap(struct address_space *mapping, long block)
+static sector_t _efs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,efs_get_block);
 }
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/ext2/inode.c	Fri Aug 23 15:27:33 2002
@@ -601,7 +601,7 @@
 	return block_prepare_write(page,from,to,ext2_get_block);
 }
 
-static int ext2_bmap(struct address_space *mapping, long block)
+static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Fri Aug 23 15:27:34 2002
+++ b/fs/ext3/inode.c	Fri Aug 23 15:27:34 2002
@@ -1167,7 +1167,7 @@
  * So, if we see any bmap calls here on a modified, data-journaled file,
  * take extra steps to flush any blocks which might be in the cache. 
  */
-static int ext3_bmap(struct address_space *mapping, long block)
+static sector_t ext3_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	journal_t *journal;
diff -Nru a/fs/fat/file.c b/fs/fat/file.c
--- a/fs/fat/file.c	Fri Aug 23 15:27:33 2002
+++ b/fs/fat/file.c	Fri Aug 23 15:27:33 2002
@@ -59,7 +59,7 @@
 		BUG();
 		return -EIO;
 	}
-	if (!(iblock % MSDOS_SB(sb)->cluster_size)) {
+	if (!((unsigned long)iblock % MSDOS_SB(sb)->cluster_size)) {
 		int error;
 
 		error = fat_add_cluster(inode);
diff -Nru a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/fat/inode.c	Fri Aug 23 15:27:33 2002
@@ -987,7 +987,7 @@
 	return cont_prepare_write(page,from,to,fat_get_block,
 		&MSDOS_I(page->mapping->host)->mmu_private);
 }
-static int _fat_bmap(struct address_space *mapping, long block)
+static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,fat_get_block);
 }
diff -Nru a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
--- a/fs/freevxfs/vxfs_subr.c	Fri Aug 23 15:27:33 2002
+++ b/fs/freevxfs/vxfs_subr.c	Fri Aug 23 15:27:33 2002
@@ -43,7 +43,7 @@
 
 
 static int		vxfs_readpage(struct file *, struct page *);
-static int		vxfs_bmap(struct address_space *, long);
+static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 struct address_space_operations vxfs_aops = {
 	.readpage =		vxfs_readpage,
@@ -186,8 +186,8 @@
  * Locking status:
  *   We are under the bkl.
  */
-static int
-vxfs_bmap(struct address_space *mapping, long block)
+static sector_t
+vxfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, vxfs_getblk);
 }
diff -Nru a/fs/hfs/inode.c b/fs/hfs/inode.c
--- a/fs/hfs/inode.c	Fri Aug 23 15:27:34 2002
+++ b/fs/hfs/inode.c	Fri Aug 23 15:27:34 2002
@@ -242,7 +242,7 @@
 	return cont_prepare_write(page,from,to,hfs_get_block,
 		&HFS_I(page->mapping->host)->mmu_private);
 }
-static int hfs_bmap(struct address_space *mapping, long block)
+static sector_t hfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,hfs_get_block);
 }
diff -Nru a/fs/hpfs/file.c b/fs/hpfs/file.c
--- a/fs/hpfs/file.c	Fri Aug 23 15:27:33 2002
+++ b/fs/hpfs/file.c	Fri Aug 23 15:27:33 2002
@@ -111,7 +111,7 @@
 	return cont_prepare_write(page,from,to,hpfs_get_block,
 		&hpfs_i(page->mapping->host)->mmu_private);
 }
-static int _hpfs_bmap(struct address_space *mapping, long block)
+static sector_t _hpfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,hpfs_get_block);
 }
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Aug 23 15:27:34 2002
+++ b/fs/inode.c	Fri Aug 23 15:27:34 2002
@@ -917,9 +917,9 @@
  *	file.
  */
  
-int bmap(struct inode * inode, int block)
+sector_t bmap(struct inode * inode, sector_t block)
 {
-	int res = 0;
+	sector_t res = 0;
 	if (inode->i_mapping->a_ops->bmap)
 		res = inode->i_mapping->a_ops->bmap(inode->i_mapping, block);
 	return res;
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Fri Aug 23 15:27:34 2002
+++ b/fs/isofs/inode.c	Fri Aug 23 15:27:34 2002
@@ -1044,9 +1044,9 @@
 	return 0;
 }
 
-struct buffer_head *isofs_bread(struct inode *inode, unsigned int block)
+struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 {
-	unsigned int blknr = isofs_bmap(inode, block);
+	sector_t blknr = isofs_bmap(inode, block);
 	if (!blknr)
 		return NULL;
 	return sb_bread(inode->i_sb, blknr);
@@ -1057,7 +1057,7 @@
 	return block_read_full_page(page,isofs_get_block);
 }
 
-static int _isofs_bmap(struct address_space *mapping, long block)
+static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,isofs_get_block);
 }
diff -Nru a/fs/jfs/inode.c b/fs/jfs/inode.c
--- a/fs/jfs/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/jfs/inode.c	Fri Aug 23 15:27:33 2002
@@ -282,7 +282,7 @@
 	return block_prepare_write(page, from, to, jfs_get_block);
 }
 
-static int jfs_bmap(struct address_space *mapping, long block)
+static sector_t jfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
diff -Nru a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
--- a/fs/jfs/jfs_metapage.c	Fri Aug 23 15:27:33 2002
+++ b/fs/jfs/jfs_metapage.c	Fri Aug 23 15:27:33 2002
@@ -256,7 +256,7 @@
 	return block_prepare_write(page, from, to, direct_get_block);
 }
 
-static int direct_bmap(struct address_space *mapping, long block)
+static sector_t direct_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, direct_get_block);
 }
diff -Nru a/fs/minix/inode.c b/fs/minix/inode.c
--- a/fs/minix/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/minix/inode.c	Fri Aug 23 15:27:33 2002
@@ -328,7 +328,7 @@
 {
 	return block_prepare_write(page,from,to,minix_get_block);
 }
-static int minix_bmap(struct address_space *mapping, long block)
+static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,minix_get_block);
 }
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Fri Aug 23 15:27:33 2002
+++ b/fs/partitions/check.c	Fri Aug 23 15:27:33 2002
@@ -449,13 +449,12 @@
 	blkdev_put(bdev, BDEV_RAW);
 }
 
-unsigned char *read_dev_sector(struct block_device *bdev, unsigned long n, Sector *p)
+unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
-	int sect = PAGE_CACHE_SIZE / 512;
 	struct page *page;
 
-	page = read_cache_page(mapping, n/sect,
+	page = read_cache_page(mapping, (pgoff_t)(n >> (PAGE_CACHE_SHIFT-9)),
 			(filler_t *)mapping->a_ops->readpage, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
@@ -464,7 +463,8 @@
 		if (PageError(page))
 			goto fail;
 		p->v = page;
-		return (unsigned char *)page_address(page) + 512 * (n % sect);
+		return (unsigned char *)page_address(page) + ((n & (1 << (PAGE_CACHE_SHIFT - 9) - 1)) << 9);
+
 fail:
 		page_cache_release(page);
 	}
diff -Nru a/fs/qnx4/inode.c b/fs/qnx4/inode.c
--- a/fs/qnx4/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/qnx4/inode.c	Fri Aug 23 15:27:33 2002
@@ -444,7 +444,7 @@
 	return cont_prepare_write(page, from, to, qnx4_get_block,
 				  &qnx4_inode->mmu_private);
 }
-static int qnx4_bmap(struct address_space *mapping, long block)
+static sector_t qnx4_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/reiserfs/inode.c	Fri Aug 23 15:27:33 2002
@@ -2045,7 +2045,7 @@
 }
 
 
-static int reiserfs_aop_bmap(struct address_space *as, long block) {
+static sector_t reiserfs_aop_bmap(struct address_space *as, sector_t block) {
   return generic_block_bmap(as, block, reiserfs_bmap) ;
 }
 
diff -Nru a/fs/sysv/itree.c b/fs/sysv/itree.c
--- a/fs/sysv/itree.c	Fri Aug 23 15:27:33 2002
+++ b/fs/sysv/itree.c	Fri Aug 23 15:27:33 2002
@@ -459,7 +459,7 @@
 {
 	return block_prepare_write(page,from,to,get_block);
 }
-static int sysv_bmap(struct address_space *mapping, long block)
+static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,get_block);
 }
diff -Nru a/fs/udf/inode.c b/fs/udf/inode.c
--- a/fs/udf/inode.c	Fri Aug 23 15:27:34 2002
+++ b/fs/udf/inode.c	Fri Aug 23 15:27:34 2002
@@ -146,7 +146,7 @@
 	return block_prepare_write(page, from, to, udf_get_block);
 }
 
-static int udf_bmap(struct address_space *mapping, long block)
+static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,udf_get_block);
 }
diff -Nru a/fs/ufs/inode.c b/fs/ufs/inode.c
--- a/fs/ufs/inode.c	Fri Aug 23 15:27:33 2002
+++ b/fs/ufs/inode.c	Fri Aug 23 15:27:33 2002
@@ -457,7 +457,7 @@
 {
 	return block_prepare_write(page,from,to,ufs_getfrag_block);
 }
-static int ufs_bmap(struct address_space *mapping, long block)
+static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ufs_getfrag_block);
 }
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Fri Aug 23 15:27:33 2002
+++ b/include/linux/blkdev.h	Fri Aug 23 15:27:33 2002
@@ -344,7 +344,7 @@
 extern void blk_queue_free_tags(request_queue_t *);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 
-extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
+extern sector_t *blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
 
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
@@ -397,7 +397,7 @@
 
 typedef struct {struct page *v;} Sector;
 
-unsigned char *read_dev_sector(struct block_device *, unsigned long, Sector *);
+unsigned char *read_dev_sector(struct block_device *, sector_t, Sector *);
 
 static inline void put_dev_sector(Sector p)
 {
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Aug 23 15:27:33 2002
+++ b/include/linux/fs.h	Fri Aug 23 15:27:33 2002
@@ -304,7 +304,7 @@
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
-	int (*bmap)(struct address_space *, long);
+	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 	int (*direct_IO)(int, struct inode *, char *buf,
@@ -1138,7 +1138,7 @@
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
-extern int bmap(struct inode *, int);
+extern sector_t bmap(struct inode *, sector_t);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
 extern int vfs_permission(struct inode *, int);
diff -Nru a/include/linux/iso_fs.h b/include/linux/iso_fs.h
--- a/include/linux/iso_fs.h	Fri Aug 23 15:27:33 2002
+++ b/include/linux/iso_fs.h	Fri Aug 23 15:27:33 2002
@@ -230,7 +230,7 @@
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
 extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
-extern struct buffer_head *isofs_bread(struct inode *, unsigned int);
+extern struct buffer_head *isofs_bread(struct inode *, sector_t);
 extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);
 
 extern struct inode_operations isofs_dir_inode_operations;
