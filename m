Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUDPM2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUDPM2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:28:11 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:35022 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262953AbUDPM1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:27:25 -0400
Date: Fri, 16 Apr 2004 14:26:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH COW] remove struct file from readpage() and friends
Message-ID: <20040416122652.GA24859@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

this could be a good idea, it could also be utterly insane.  If anyone
knows for sure, please tell me.

The point is that copyfile(), one of the ingredients to cowlinks,
currently has to open() the source, because sendfile() requires a
struct file* as one of the arguments.  Following the path down shows
that this struct file* is almost never used, but ultimately required
by readpage() and readpages().

Those two, again, almost never use the struct file*, except for five
cases.  One was trivial to fix, nfs, smbfs, cifs and blkmtd remain:

o nfs and smbfs appear to need the dentry as the de-facto inode in
  order to retrieve the correct file from the server.  Afs and coda
  work without it, so it appears to be unnecessary, just not trivial
  to change.

o blkmtd uses it to pass the underlying block device.  Not sure if the
  usual page->mapping->host trick would work here.

o cifs needs a possibility to pass some private data along.  It should
  be sufficient to do this per-inode instead of per-file, but I'm not
  completely sure.

Would this patch make sense sometime during 2.7 or should I hide under
a table and remove all traces of it?

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown


Remove the struct file* from readpage and readpages.  In most cases, that
field is completely unnecessary.  Current exceptions, which are thus broken
by this patch:

smbfs:		access dentry
nfs:		unknown
cifs:		uses file->private_data
blkmtd:		unknown

This patch helps copyfile(), as it removed the need to open() and close()
before and after doing a sendfile().  copyfile() in turn is a prerequisite
for decent cowlinks.

 fs/adfs/inode.c          |    2 +-
 fs/affs/file.c           |   12 ++++++------
 fs/affs/symlink.c        |    2 +-
 fs/afs/dir.c             |    3 +--
 fs/afs/file.c            |    4 ++--
 fs/afs/mntpt.c           |    5 ++---
 fs/befs/linuxvfs.c       |    4 ++--
 fs/bfs/file.c            |    2 +-
 fs/block_dev.c           |    2 +-
 fs/cramfs/inode.c        |    5 ++---
 fs/efs/inode.c           |    2 +-
 fs/efs/symlink.c         |    2 +-
 fs/ext2/dir.c            |    2 +-
 fs/ext2/inode.c          |    4 ++--
 fs/ext3/inode.c          |    4 ++--
 fs/fat/inode.c           |    2 +-
 fs/freevxfs/vxfs_immed.c |    4 ++--
 fs/freevxfs/vxfs_subr.c  |    6 +++---
 fs/hfs/bnode.c           |    2 +-
 fs/hfs/btree.c           |    2 +-
 fs/hfs/inode.c           |    2 +-
 fs/hfsplus/bitmap.c      |   10 +++++-----
 fs/hfsplus/bnode.c       |    2 +-
 fs/hfsplus/btree.c       |    2 +-
 fs/hfsplus/inode.c       |    2 +-
 fs/hpfs/file.c           |    2 +-
 fs/hpfs/namei.c          |    2 +-
 fs/hugetlbfs/inode.c     |    2 +-
 fs/isofs/compress.c      |    4 ++--
 fs/isofs/inode.c         |    2 +-
 fs/isofs/rock.c          |    2 +-
 fs/jffs/inode-v23.c      |    8 ++++----
 fs/jffs2/file.c          |   13 +++++++------
 fs/jffs2/gc.c            |    4 ++--
 fs/jffs2/os-linux.h      |    2 +-
 fs/jfs/inode.c           |    4 ++--
 fs/jfs/jfs_metapage.c    |    2 +-
 fs/libfs.c               |    2 +-
 fs/minix/dir.c           |    2 +-
 fs/minix/inode.c         |    2 +-
 fs/namei.c               |    3 +--
 fs/ncpfs/symlink.c       |    2 +-
 fs/ntfs/aops.c           |    2 +-
 fs/ntfs/mft.c            |    2 +-
 fs/ntfs/ntfs.h           |    2 +-
 fs/ntfs/super.c          |    6 ++----
 fs/partitions/check.c    |    2 +-
 fs/qnx4/inode.c          |    2 +-
 fs/reiserfs/inode.c      |    4 ++--
 fs/romfs/inode.c         |    2 +-
 fs/sysv/dir.c            |    2 +-
 fs/sysv/itree.c          |    2 +-
 fs/udf/file.c            |    2 +-
 fs/udf/inode.c           |    2 +-
 fs/ufs/inode.c           |    2 +-
 fs/umsdos/dir.c          |    2 +-
 fs/umsdos/emd.c          |    8 ++++----
 include/linux/fs.h       |    6 +++---
 include/linux/pagemap.h  |    7 +++----
 mm/filemap.c             |   12 +++++-------
 mm/readahead.c           |    4 ++--
 mm/swapfile.c            |    3 +--
 62 files changed, 106 insertions(+), 115 deletions(-)


--- linux-2.6.5cow/fs/adfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/adfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -55,7 +55,7 @@
 	return block_write_full_page(page, adfs_get_block, wbc);
 }
 
-static int adfs_readpage(struct file *file, struct page *page)
+static int adfs_readpage(struct page *page)
 {
 	return block_read_full_page(page, adfs_get_block);
 }
--- linux-2.6.5cow/fs/affs/file.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/affs/file.c	2004-04-15 22:44:08.000000000 +0200
@@ -411,7 +411,7 @@
 {
 	return block_write_full_page(page, affs_get_block, wbc);
 }
-static int affs_readpage(struct file *file, struct page *page)
+static int affs_readpage(struct page *page)
 {
 	return block_read_full_page(page, affs_get_block);
 }
@@ -506,7 +506,7 @@
 }
 
 static int
-affs_do_readpage_ofs(struct file *file, struct page *page, unsigned from, unsigned to)
+affs_do_readpage_ofs(struct page *page, unsigned from, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
@@ -614,7 +614,7 @@
 }
 
 static int
-affs_readpage_ofs(struct file *file, struct page *page)
+affs_readpage_ofs(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	u32 to;
@@ -627,7 +627,7 @@
 		memset(page_address(page) + to, 0, PAGE_CACHE_SIZE - to);
 	}
 
-	err = affs_do_readpage_ofs(file, page, 0, to);
+	err = affs_do_readpage_ofs(page, 0, to);
 	if (!err)
 		SetPageUptodate(page);
 	unlock_page(page);
@@ -654,7 +654,7 @@
 		return 0;
 
 	if (from) {
-		err = affs_do_readpage_ofs(file, page, 0, from);
+		err = affs_do_readpage_ofs(page, 0, from);
 		if (err)
 			return err;
 	}
@@ -669,7 +669,7 @@
 				tmp = size & ~PAGE_CACHE_MASK;
 			else
 				tmp = PAGE_CACHE_SIZE;
-			err = affs_do_readpage_ofs(file, page, to, tmp);
+			err = affs_do_readpage_ofs(page, to, tmp);
 		}
 	}
 	return err;
--- linux-2.6.5cow/fs/affs/symlink.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/affs/symlink.c	2004-04-15 22:44:08.000000000 +0200
@@ -17,7 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
-static int affs_symlink_readpage(struct file *file, struct page *page)
+static int affs_symlink_readpage(struct page *page)
 {
 	struct buffer_head *bh;
 	struct inode *inode = page->mapping->host;
--- linux-2.6.5cow/fs/afs/dir.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/afs/dir.c	2004-04-15 22:44:08.000000000 +0200
@@ -186,8 +186,7 @@
 	_enter("{%lu},%lu", dir->i_ino, index);
 
 	page = read_cache_page(dir->i_mapping,index,
-			       (filler_t *) dir->i_mapping->a_ops->readpage,
-			       NULL);
+			       (filler_t *) dir->i_mapping->a_ops->readpage);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
--- linux-2.6.5cow/fs/afs/file.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/afs/file.c	2004-04-15 22:44:08.000000000 +0200
@@ -27,7 +27,7 @@
 static int afs_file_release(struct inode *inode, struct file *file);
 #endif
 
-static int afs_file_readpage(struct file *file, struct page *page);
+static int afs_file_readpage(struct page *page);
 static int afs_file_invalidatepage(struct page *page, unsigned long offset);
 static int afs_file_releasepage(struct page *page, int gfp_flags);
 
@@ -115,7 +115,7 @@
 /*
  * AFS read page from file (or symlink)
  */
-static int afs_file_readpage(struct file *file, struct page *page)
+static int afs_file_readpage(struct page *page)
 {
 	struct afs_rxfs_fetch_descriptor desc;
 #ifdef AFS_CACHING_SUPPORT
--- linux-2.6.5cow/fs/afs/mntpt.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/afs/mntpt.c	2004-04-15 22:44:08.000000000 +0200
@@ -80,8 +80,7 @@
 	/* read the contents of the symlink into the pagecache */
 	filler = (filler_t *) AFS_VNODE_TO_I(vnode)->i_mapping->a_ops->readpage;
 
-	page = read_cache_page(AFS_VNODE_TO_I(vnode)->i_mapping, 0,
-			       filler, NULL);
+	page = read_cache_page(AFS_VNODE_TO_I(vnode)->i_mapping, 0, filler);
 	if (IS_ERR(page)) {
 		ret = PTR_ERR(page);
 		goto out;
@@ -191,7 +190,7 @@
 	/* read the contents of the AFS special symlink */
 	filler_t *filler = mntpt->d_inode->i_mapping->a_ops->readpage;
 
-	page = read_cache_page(mntpt->d_inode->i_mapping, 0, filler, NULL);
+	page = read_cache_page(mntpt->d_inode->i_mapping, 0, filler);
 	if (IS_ERR(page)) {
 		ret = PTR_ERR(page);
 		goto error;
--- linux-2.6.5cow/fs/befs/linuxvfs.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/befs/linuxvfs.c	2004-04-15 22:44:08.000000000 +0200
@@ -32,7 +32,7 @@
 
 static int befs_readdir(struct file *, void *, filldir_t);
 static int befs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-static int befs_readpage(struct file *file, struct page *page);
+static int befs_readpage(struct page *page);
 static sector_t befs_bmap(struct address_space *mapping, sector_t block);
 static struct dentry *befs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static void befs_read_inode(struct inode *ino);
@@ -97,7 +97,7 @@
  * positions to disk blocks.
  */
 static int
-befs_readpage(struct file *file, struct page *page)
+befs_readpage(struct page *page)
 {
 	return block_read_full_page(page, befs_get_block);
 }
--- linux-2.6.5cow/fs/bfs/file.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/bfs/file.c	2004-04-15 22:44:08.000000000 +0200
@@ -135,7 +135,7 @@
 	return block_write_full_page(page, bfs_get_block, wbc);
 }
 
-static int bfs_readpage(struct file *file, struct page *page)
+static int bfs_readpage(struct page *page)
 {
 	return block_read_full_page(page, bfs_get_block);
 }
--- linux-2.6.5cow/fs/block_dev.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/block_dev.c	2004-04-15 22:44:08.000000000 +0200
@@ -164,7 +164,7 @@
 	return block_write_full_page(page, blkdev_get_block, wbc);
 }
 
-static int blkdev_readpage(struct file * file, struct page * page)
+static int blkdev_readpage(struct page * page)
 {
 	return block_read_full_page(page, blkdev_get_block);
 }
--- linux-2.6.5cow/fs/cramfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/cramfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -147,8 +147,7 @@
 
 		if (blocknr + i < devsize) {
 			page = read_cache_page(mapping, blocknr + i,
-				(filler_t *)mapping->a_ops->readpage,
-				NULL);
+				(filler_t *)mapping->a_ops->readpage);
 			/* synchronous error? */
 			if (IS_ERR(page))
 				page = NULL;
@@ -420,7 +419,7 @@
 	return NULL;
 }
 
-static int cramfs_readpage(struct file *file, struct page * page)
+static int cramfs_readpage(struct page * page)
 {
 	struct inode *inode = page->mapping->host;
 	u32 maxblock, bytes_filled;
--- linux-2.6.5cow/fs/efs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/efs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -15,7 +15,7 @@
 
 
 extern int efs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-static int efs_readpage(struct file *file, struct page *page)
+static int efs_readpage(struct page *page)
 {
 	return block_read_full_page(page,efs_get_block);
 }
--- linux-2.6.5cow/fs/efs/symlink.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/efs/symlink.c	2004-04-15 22:44:08.000000000 +0200
@@ -12,7 +12,7 @@
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
-static int efs_symlink_readpage(struct file *file, struct page *page)
+static int efs_symlink_readpage(struct page *page)
 {
 	char *link = kmap(page);
 	struct buffer_head * bh;
--- linux-2.6.5cow/fs/ext2/dir.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/dir.c	2004-04-15 22:44:08.000000000 +0200
@@ -160,7 +160,7 @@
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_cache_page(mapping, n,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+				(filler_t*)mapping->a_ops->readpage);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
--- linux-2.6.5cow/fs/ext2/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -611,13 +611,13 @@
 	return block_write_full_page(page, ext2_get_block, wbc);
 }
 
-static int ext2_readpage(struct file *file, struct page *page)
+static int ext2_readpage(struct page *page)
 {
 	return mpage_readpage(page, ext2_get_block);
 }
 
 static int
-ext2_readpages(struct file *file, struct address_space *mapping,
+ext2_readpages(struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
 	return mpage_readpages(mapping, pages, nr_pages, ext2_get_block);
--- linux-2.6.5cow/fs/ext3/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ext3/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -1486,13 +1486,13 @@
 	goto out;
 }
 
-static int ext3_readpage(struct file *file, struct page *page)
+static int ext3_readpage(struct page *page)
 {
 	return mpage_readpage(page, ext3_get_block);
 }
 
 static int
-ext3_readpages(struct file *file, struct address_space *mapping,
+ext3_readpages(struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
 	return mpage_readpages(mapping, pages, nr_pages, ext3_get_block);
--- linux-2.6.5cow/fs/fat/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/fat/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -1107,7 +1107,7 @@
 {
 	return block_write_full_page(page,fat_get_block, wbc);
 }
-static int fat_readpage(struct file *file, struct page *page)
+static int fat_readpage(struct page *page)
 {
 	return block_read_full_page(page,fat_get_block);
 }
--- linux-2.6.5cow/fs/freevxfs/vxfs_immed.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/freevxfs/vxfs_immed.c	2004-04-15 22:44:08.000000000 +0200
@@ -40,7 +40,7 @@
 static int	vxfs_immed_readlink(struct dentry *, char __user *, int);
 static int	vxfs_immed_follow_link(struct dentry *, struct nameidata *);
 
-static int	vxfs_immed_readpage(struct file *, struct page *);
+static int	vxfs_immed_readpage(struct page *);
 
 /*
  * Inode operations for immed symlinks.
@@ -118,7 +118,7 @@
  *   @page is locked and will be unlocked.
  */
 static int
-vxfs_immed_readpage(struct file *fp, struct page *pp)
+vxfs_immed_readpage(struct page *pp)
 {
 	struct vxfs_inode_info	*vip = VXFS_INO(pp->mapping->host);
 	u_int64_t		offset = pp->index << PAGE_CACHE_SHIFT;
--- linux-2.6.5cow/fs/freevxfs/vxfs_subr.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/freevxfs/vxfs_subr.c	2004-04-15 22:44:08.000000000 +0200
@@ -40,7 +40,7 @@
 #include "vxfs_extern.h"
 
 
-static int		vxfs_readpage(struct file *, struct page *);
+static int		vxfs_readpage(struct page *);
 static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 struct address_space_operations vxfs_aops = {
@@ -73,7 +73,7 @@
 	struct page *			pp;
 
 	pp = read_cache_page(mapping, n,
-			(filler_t*)mapping->a_ops->readpage, NULL);
+			(filler_t*)mapping->a_ops->readpage);
 
 	if (!IS_ERR(pp)) {
 		wait_on_page_locked(pp);
@@ -163,7 +163,7 @@
  *   @page is locked and will be unlocked.
  */
 static int
-vxfs_readpage(struct file *file, struct page *page)
+vxfs_readpage(struct page *page)
 {
 	return block_read_full_page(page, vxfs_getblk);
 }
--- linux-2.6.5cow/fs/hfs/bnode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfs/bnode.c	2004-04-15 22:44:08.000000000 +0200
@@ -282,7 +282,7 @@
 	block = off >> PAGE_CACHE_SHIFT;
 	node->page_offset = off & ~PAGE_CACHE_MASK;
 	for (i = 0; i < tree->pages_per_bnode; i++) {
-		page = read_cache_page(mapping, block++, (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_cache_page(mapping, block++, (filler_t *)mapping->a_ops->readpage);
 		if (IS_ERR(page))
 			goto fail;
 #if !REF_PAGES
--- linux-2.6.5cow/fs/hfs/btree.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfs/btree.c	2004-04-15 22:44:08.000000000 +0200
@@ -60,7 +60,7 @@
 	unlock_new_inode(tree->inode);
 
 	mapping = tree->inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_cache_page(mapping, 0, (filler_t*)mapping->a_ops->readpage);
 	if (IS_ERR(page))
 		goto free_tree;
 
--- linux-2.6.5cow/fs/hfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -27,7 +27,7 @@
 	return block_write_full_page(page, hfs_get_block, wbc);
 }
 
-static int hfs_readpage(struct file *file, struct page *page)
+static int hfs_readpage(struct page *page)
 {
 	return block_read_full_page(page, hfs_get_block);
 }
--- linux-2.6.5cow/fs/hfsplus/bitmap.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/bitmap.c	2004-04-15 22:44:08.000000000 +0200
@@ -31,7 +31,7 @@
 	down(&HFSPLUS_SB(sb).alloc_file->i_sem);
 	mapping = HFSPLUS_SB(sb).alloc_file->i_mapping;
 	page = read_cache_page(mapping, offset / PAGE_CACHE_BITS,
-			       (filler_t *)mapping->a_ops->readpage, NULL);
+			       (filler_t *)mapping->a_ops->readpage);
 	pptr = kmap(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	i = offset % 32;
@@ -72,7 +72,7 @@
 		if (offset >= size)
 			break;
 		page = read_cache_page(mapping, offset / PAGE_CACHE_BITS,
-				       (filler_t *)mapping->a_ops->readpage, NULL);
+				       (filler_t *)mapping->a_ops->readpage);
 		curr = pptr = kmap(page);
 		if ((size ^ offset) / PAGE_CACHE_BITS)
 			end = pptr + PAGE_CACHE_BITS / 32;
@@ -119,7 +119,7 @@
 		kunmap(page);
 		offset += PAGE_CACHE_BITS;
 		page = read_cache_page(mapping, offset / PAGE_CACHE_BITS,
-				       (filler_t *)mapping->a_ops->readpage, NULL);
+				       (filler_t *)mapping->a_ops->readpage)
 		pptr = kmap(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
@@ -166,7 +166,7 @@
 	down(&HFSPLUS_SB(sb).alloc_file->i_sem);
 	mapping = HFSPLUS_SB(sb).alloc_file->i_mapping;
 	pnr = offset / PAGE_CACHE_BITS;
-	page = read_cache_page(mapping, pnr, (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_cache_page(mapping, pnr, (filler_t *)mapping->a_ops->readpage);
 	pptr = kmap(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	end = pptr + PAGE_CACHE_BITS / 32;
@@ -198,7 +198,7 @@
 			break;
 		set_page_dirty(page);
 		kunmap(page);
-		page = read_cache_page(mapping, ++pnr, (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_cache_page(mapping, ++pnr, (filler_t *)mapping->a_ops->readpage);
 		pptr = kmap(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
--- linux-2.6.5cow/fs/hfsplus/bnode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/bnode.c	2004-04-15 22:44:08.000000000 +0200
@@ -443,7 +443,7 @@
 	block = off >> PAGE_CACHE_SHIFT;
 	node->page_offset = off & ~PAGE_CACHE_MASK;
 	for (i = 0; i < tree->pages_per_bnode; block++, i++) {
-		page = read_cache_page(mapping, block, (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_cache_page(mapping, block, (filler_t *)mapping->a_ops->readpage);
 		if (IS_ERR(page))
 			goto fail;
 #if !REF_PAGES
--- linux-2.6.5cow/fs/hfsplus/btree.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/btree.c	2004-04-15 22:44:08.000000000 +0200
@@ -47,7 +47,7 @@
 		goto free_tree;
 
 	mapping = tree->inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_cache_page(mapping, 0, (filler_t*)mapping->a_ops->readpage);
 	if (IS_ERR(page))
 		goto free_tree;
 
--- linux-2.6.5cow/fs/hfsplus/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -17,7 +17,7 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
-static int hfsplus_readpage(struct file *file, struct page *page)
+static int hfsplus_readpage(struct page *page)
 {
 	//printk("readpage: %lu\n", page->index);
 	return block_read_full_page(page, hfsplus_get_block);
--- linux-2.6.5cow/fs/hpfs/file.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hpfs/file.c	2004-04-15 22:44:08.000000000 +0200
@@ -86,7 +86,7 @@
 {
 	return block_write_full_page(page,hpfs_get_block, wbc);
 }
-static int hpfs_readpage(struct file *file, struct page *page)
+static int hpfs_readpage(struct page *page)
 {
 	return block_read_full_page(page,hpfs_get_block);
 }
--- linux-2.6.5cow/fs/hpfs/namei.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hpfs/namei.c	2004-04-15 22:44:08.000000000 +0200
@@ -508,7 +508,7 @@
 	return err;
 }
 
-static int hpfs_symlink_readpage(struct file *file, struct page *page)
+static int hpfs_symlink_readpage(struct page *page)
 {
 	char *link = kmap(page);
 	struct inode *i = page->mapping->host;
--- linux-2.6.5cow/fs/hugetlbfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/hugetlbfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -119,7 +119,7 @@
  * Read a page. Again trivial. If it didn't already exist
  * in the page cache, it is zero-filled.
  */
-static int hugetlbfs_readpage(struct file *file, struct page * page)
+static int hugetlbfs_readpage(struct page * page)
 {
 	unlock_page(page);
 	return -EINVAL;
--- linux-2.6.5cow/fs/isofs/compress.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/isofs/compress.c	2004-04-15 22:44:08.000000000 +0200
@@ -59,9 +59,9 @@
  * per reference.  We inject the additional pages into the page
  * cache as a form of readahead.
  */
-static int zisofs_readpage(struct file *file, struct page *page)
+static int zisofs_readpage(struct page *page)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = page->mapping->host;
 	struct address_space *mapping = inode->i_mapping;
 	unsigned int maxpage, xpage, fpage, blockindex;
 	unsigned long offset;
--- linux-2.6.5cow/fs/isofs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/isofs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -1057,7 +1057,7 @@
 	return sb_bread(inode->i_sb, blknr);
 }
 
-static int isofs_readpage(struct file *file, struct page *page)
+static int isofs_readpage(struct page *page)
 {
 	return block_read_full_page(page,isofs_get_block);
 }
--- linux-2.6.5cow/fs/isofs/rock.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/isofs/rock.c	2004-04-15 22:44:08.000000000 +0200
@@ -428,7 +428,7 @@
 /* readpage() for symlinks: reads symlink contents into the page and either
    makes it uptodate and returns 0 or returns error (-EIO) */
 
-static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
+static int rock_ridge_symlink_readpage(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	char *link = kmap(page);
--- linux-2.6.5cow/fs/jffs/inode-v23.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/jffs/inode-v23.c	2004-04-15 22:44:08.000000000 +0200
@@ -733,7 +733,7 @@
 
 /* Try to read a page of data from a file.  */
 static int
-jffs_do_readpage_nolock(struct file *file, struct page *page)
+jffs_do_readpage_nolock(struct page *page)
 {
 	void *buf;
 	unsigned long read_len;
@@ -797,9 +797,9 @@
 	return result;
 } /* jffs_do_readpage_nolock()  */
 
-static int jffs_readpage(struct file *file, struct page *page)
+static int jffs_readpage(struct page *page)
 {
-	int ret = jffs_do_readpage_nolock(file, page);
+	int ret = jffs_do_readpage_nolock(page);
 	unlock_page(page);
 	return ret;
 }
@@ -1534,7 +1534,7 @@
 
 	/* Bugger that. We should make sure the page is uptodate */
 	if (!PageUptodate(page) && (from || to < PAGE_CACHE_SIZE))
-		return jffs_do_readpage_nolock(filp, page);
+		return jffs_do_readpage_nolock(page);
 
 	return 0;
 } /* jffs_prepare_write() */
--- linux-2.6.5cow/fs/jffs2/file.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/jffs2/file.c	2004-04-15 22:44:08.000000000 +0200
@@ -65,8 +65,9 @@
 	.commit_write =	jffs2_commit_write
 };
 
-int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
+int jffs2_do_readpage_nolock (struct page *pg)
 {
+	struct inode *inode = pg->mapping->host;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	unsigned char *pg_buf;
@@ -97,21 +98,21 @@
 	return 0;
 }
 
-int jffs2_do_readpage_unlock(struct inode *inode, struct page *pg)
+int jffs2_do_readpage_unlock(struct page *pg)
 {
-	int ret = jffs2_do_readpage_nolock(inode, pg);
+	int ret = jffs2_do_readpage_nolock(pg);
 	unlock_page(pg);
 	return ret;
 }
 
 
-int jffs2_readpage (struct file *filp, struct page *pg)
+int jffs2_readpage (struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
 	int ret;
 	
 	down(&f->sem);
-	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
+	ret = jffs2_do_readpage_unlock(pg);
 	up(&f->sem);
 	return ret;
 }
@@ -191,7 +192,7 @@
 	/* Read in the page if it wasn't already present, unless it's a whole page */
 	if (!PageUptodate(pg) && (start || end < PAGE_CACHE_SIZE)) {
 		down(&f->sem);
-		ret = jffs2_do_readpage_nolock(inode, pg);
+		ret = jffs2_do_readpage_nolock(pg);
 		up(&f->sem);
 	}
 	D1(printk(KERN_DEBUG "end prepare_write(). pg->flags %lx\n", pg->flags));
--- linux-2.6.5cow/fs/jffs2/gc.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/jffs2/gc.c	2004-04-15 22:44:08.000000000 +0200
@@ -1185,9 +1185,9 @@
 	 *    suboptimal, but at least we're correct.
 	 */
 #ifdef __ECOS
-	pg = read_cache_page(start >> PAGE_CACHE_SHIFT, (void *)jffs2_do_readpage_unlock, inode);
+	pg = read_cache_page(start >> PAGE_CACHE_SHIFT, (filler_t *)jffs2_do_readpage_unlock);
 #else
-	pg = read_cache_page(inode->i_mapping, start >> PAGE_CACHE_SHIFT, (void *)jffs2_do_readpage_unlock, inode);
+	pg = read_cache_page(inode->i_mapping, start >> PAGE_CACHE_SHIFT, (filler_t *)jffs2_do_readpage_unlock);
 #endif
 	if (IS_ERR(pg)) {
 		printk(KERN_WARNING "read_cache_page() returned error: %ld\n", PTR_ERR(pg));
--- linux-2.6.5cow/fs/jffs2/os-linux.h~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/jffs2/os-linux.h	2004-04-15 22:44:08.000000000 +0200
@@ -162,7 +162,7 @@
 int jffs2_fsync(struct file *, struct dentry *, int);
 int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg);
 int jffs2_do_readpage_unlock (struct inode *inode, struct page *pg);
-int jffs2_readpage (struct file *, struct page *);
+int jffs2_readpage (struct page *);
 int jffs2_prepare_write (struct file *, struct page *, unsigned, unsigned);
 int jffs2_commit_write (struct file *, struct page *, unsigned, unsigned);
 
--- linux-2.6.5cow/fs/jfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/jfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -280,12 +280,12 @@
 	return mpage_writepages(mapping, wbc, jfs_get_block);
 }
 
-static int jfs_readpage(struct file *file, struct page *page)
+static int jfs_readpage(struct page *page)
 {
 	return mpage_readpage(page, jfs_get_block);
 }
 
-static int jfs_readpages(struct file *file, struct address_space *mapping,
+static int jfs_readpages(struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
 	return mpage_readpages(mapping, pages, nr_pages, jfs_get_block);
--- linux-2.6.5cow/fs/jfs/jfs_metapage.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/jfs/jfs_metapage.c	2004-04-15 22:44:08.000000000 +0200
@@ -332,7 +332,7 @@
 		} else {
 			jfs_info("__get_metapage: Calling read_cache_page");
 			mp->page = read_cache_page(mapping, lblock,
-				    (filler_t *)mapping->a_ops->readpage, NULL);
+				    (filler_t *)mapping->a_ops->readpage);
 			if (IS_ERR(mp->page)) {
 				jfs_err("read_cache_page failed!");
 				goto freeit;
--- linux-2.6.5cow/fs/libfs.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/libfs.c	2004-04-15 22:44:08.000000000 +0200
@@ -299,7 +299,7 @@
 	return 0;
 }
 
-int simple_readpage(struct file *file, struct page *page)
+int simple_readpage(struct page *page)
 {
 	void *kaddr;
 
--- linux-2.6.5cow/fs/minix/dir.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/minix/dir.c	2004-04-15 22:44:08.000000000 +0200
@@ -61,7 +61,7 @@
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_cache_page(mapping, n,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+				(filler_t*)mapping->a_ops->readpage);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
--- linux-2.6.5cow/fs/minix/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/minix/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -321,7 +321,7 @@
 {
 	return block_write_full_page(page, minix_get_block, wbc);
 }
-static int minix_readpage(struct file *file, struct page *page)
+static int minix_readpage(struct page *page)
 {
 	return block_read_full_page(page,minix_get_block);
 }
--- linux-2.6.5cow/fs/namei.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/namei.c	2004-04-15 22:44:08.000000000 +0200
@@ -2352,8 +2352,7 @@
 {
 	struct page * page;
 	struct address_space *mapping = dentry->d_inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
-				NULL);
+	page = read_cache_page(mapping, 0, (filler_t*)mapping->a_ops->readpage);
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page_locked(page);
--- linux-2.6.5cow/fs/ncpfs/symlink.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ncpfs/symlink.c	2004-04-15 22:44:08.000000000 +0200
@@ -41,7 +41,7 @@
 
 /* ----- read a symbolic link ------------------------------------------ */
 
-static int ncp_symlink_readpage(struct file *file, struct page *page)
+static int ncp_symlink_readpage(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	int error, length, len;
--- linux-2.6.5cow/fs/ntfs/aops.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ntfs/aops.c	2004-04-15 22:44:08.000000000 +0200
@@ -338,7 +338,7 @@
  *
  * WARNING: Do not make this function static! It is used by mft.c!
  */
-int ntfs_readpage(struct file *file, struct page *page)
+int ntfs_readpage(struct page *page)
 {
 	s64 attr_pos;
 	ntfs_inode *ni, *base_ni;
--- linux-2.6.5cow/fs/ntfs/mft.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ntfs/mft.c	2004-04-15 22:44:08.000000000 +0200
@@ -100,7 +100,7 @@
 /**
  * ntfs_readpage - external declaration, function is in fs/ntfs/aops.c
  */
-extern int ntfs_readpage(struct file *, struct page *);
+extern int ntfs_readpage(struct page *);
 
 /**
  * ntfs_mft_aops - address space operations for access to $MFT
--- linux-2.6.5cow/fs/ntfs/ntfs.h~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ntfs/ntfs.h	2004-04-15 22:44:08.000000000 +0200
@@ -140,7 +140,7 @@
 		unsigned long index)
 {
 	struct page *page = read_cache_page(mapping, index,
-			(filler_t*)mapping->a_ops->readpage, NULL);
+			(filler_t*)mapping->a_ops->readpage);
 
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
--- linux-2.6.5cow/fs/ntfs/super.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ntfs/super.c	2004-04-15 22:44:08.000000000 +0200
@@ -1104,8 +1104,7 @@
 		 * Read the page from page cache, getting it from backing store
 		 * if necessary, and increment the use count.
 		 */
-		page = read_cache_page(mapping, index, (filler_t*)readpage,
-				NULL);
+		page = read_cache_page(mapping, index, (filler_t*)readpage);
 		/* Ignore pages which errored synchronously. */
 		if (IS_ERR(page)) {
 			ntfs_debug("Sync read_cache_page() error. Skipping "
@@ -1193,8 +1192,7 @@
 		 * Read the page from page cache, getting it from backing store
 		 * if necessary, and increment the use count.
 		 */
-		page = read_cache_page(mapping, index, (filler_t*)readpage,
-				NULL);
+		page = read_cache_page(mapping, index, (filler_t*)readpage);
 		/* Ignore pages which errored synchronously. */
 		if (IS_ERR(page)) {
 			ntfs_debug("Sync read_cache_page() error. Skipping "
--- linux-2.6.5cow/fs/partitions/check.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/partitions/check.c	2004-04-15 22:44:08.000000000 +0200
@@ -426,7 +426,7 @@
 	struct page *page;
 
 	page = read_cache_page(mapping, (pgoff_t)(n >> (PAGE_CACHE_SHIFT-9)),
-			(filler_t *)mapping->a_ops->readpage, NULL);
+			(filler_t *)mapping->a_ops->readpage);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
--- linux-2.6.5cow/fs/qnx4/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/qnx4/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -427,7 +427,7 @@
 {
 	return block_write_full_page(page,qnx4_get_block, wbc);
 }
-static int qnx4_readpage(struct file *file, struct page *page)
+static int qnx4_readpage(struct page *page)
 {
 	return block_read_full_page(page,qnx4_get_block);
 }
--- linux-2.6.5cow/fs/reiserfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/reiserfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -936,7 +936,7 @@
 }
 
 static int
-reiserfs_readpages(struct file *file, struct address_space *mapping,
+reiserfs_readpages(struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
     return mpage_readpages(mapping, pages, nr_pages, reiserfs_get_block);
@@ -2217,7 +2217,7 @@
 }
 
 
-static int reiserfs_readpage (struct file *f, struct page * page)
+static int reiserfs_readpage (struct page * page)
 {
     return block_read_full_page (page, reiserfs_get_block);
 }
--- linux-2.6.5cow/fs/romfs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/romfs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -415,7 +415,7 @@
  */
 
 static int
-romfs_readpage(struct file *file, struct page * page)
+romfs_readpage(struct page * page)
 {
 	struct inode *inode = page->mapping->host;
 	unsigned long offset, avail, readlen;
--- linux-2.6.5cow/fs/sysv/dir.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/sysv/dir.c	2004-04-15 22:44:08.000000000 +0200
@@ -54,7 +54,7 @@
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_cache_page(mapping, n,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+				(filler_t*)mapping->a_ops->readpage);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
--- linux-2.6.5cow/fs/sysv/itree.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/sysv/itree.c	2004-04-15 22:44:08.000000000 +0200
@@ -451,7 +451,7 @@
 {
 	return block_write_full_page(page,get_block,wbc);
 }
-static int sysv_readpage(struct file *file, struct page *page)
+static int sysv_readpage(struct page *page)
 {
 	return block_read_full_page(page,get_block);
 }
--- linux-2.6.5cow/fs/udf/file.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/udf/file.c	2004-04-15 22:44:08.000000000 +0200
@@ -44,7 +44,7 @@
 #include "udf_i.h"
 #include "udf_sb.h"
 
-static int udf_adinicb_readpage(struct file *file, struct page * page)
+static int udf_adinicb_readpage(struct page * page)
 {
 	struct inode *inode = page->mapping->host;
 	char *kaddr;
--- linux-2.6.5cow/fs/udf/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/udf/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -135,7 +135,7 @@
 	return block_write_full_page(page, udf_get_block, wbc);
 }
 
-static int udf_readpage(struct file *file, struct page *page)
+static int udf_readpage(struct page *page)
 {
 	return block_read_full_page(page, udf_get_block);
 }
--- linux-2.6.5cow/fs/ufs/inode.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/ufs/inode.c	2004-04-15 22:44:08.000000000 +0200
@@ -510,7 +510,7 @@
 {
 	return block_write_full_page(page,ufs_getfrag_block,wbc);
 }
-static int ufs_readpage(struct file *file, struct page *page)
+static int ufs_readpage(struct page *page)
 {
 	return block_read_full_page(page,ufs_getfrag_block);
 }
--- linux-2.6.5cow/fs/umsdos/dir.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/umsdos/dir.c	2004-04-15 22:44:08.000000000 +0200
@@ -692,7 +692,7 @@
 	struct address_space *mapping = hlink->d_inode->i_mapping;
 	struct page *page;
 
-	page=read_cache_page(mapping,0,(filler_t *)mapping->a_ops->readpage,NULL);
+	page = read_cache_page(mapping, 0, (filler_t*)mapping->a_ops->readpage);
 	dentry_dst=(struct dentry *)page;
 	if (IS_ERR(page))
 		goto out;
--- linux-2.6.5cow/fs/umsdos/emd.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/fs/umsdos/emd.c	2004-04-15 22:44:08.000000000 +0200
@@ -136,7 +136,7 @@
 	int ret = 0;
 
 	page = read_cache_page(mapping, *pos>>PAGE_CACHE_SHIFT,
-			(filler_t*)mapping->a_ops->readpage, NULL);
+			(filler_t*)mapping->a_ops->readpage);
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page_locked(page);
@@ -158,7 +158,7 @@
 		struct page *page2;
 		int part = (char *)(page_address(page) + PAGE_CACHE_SIZE) - p->spare;
 		page2 = read_cache_page(mapping, 1+(*pos>>PAGE_CACHE_SHIFT),
-				(filler_t*)mapping->a_ops->readpage, NULL);
+				(filler_t*)mapping->a_ops->readpage);
 		if (IS_ERR(page2)) {
 			kunmap(page);
 			page_cache_release(page);
@@ -389,7 +389,7 @@
 			if (++index == (emd_dir->i_size>>PAGE_CACHE_SHIFT))
 				max_offs = emd_dir->i_size & ~PAGE_CACHE_MASK;
 			offs -= PAGE_CACHE_SIZE;
-			page = read_cache_page(mapping,index,readpage,NULL);
+			page = read_cache_page(mapping, index, readpage);
 			if (IS_ERR(page))
 				goto sync_fail;
 			wait_on_page_locked(page);
@@ -435,7 +435,7 @@
 			int len = (p+PAGE_CACHE_SIZE)-rentry->name;
 			struct page *next_page;
 			char *q;
-			next_page = read_cache_page(mapping,index+1,readpage,NULL);
+			next_page = read_cache_page(mapping, index+1, readpage);
 			if (IS_ERR(next_page)) {
 				page_cache_release(page);
 				page = next_page;
--- linux-2.6.5cow/include/linux/fs.h~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/include/linux/fs.h	2004-04-15 22:44:08.000000000 +0200
@@ -297,7 +297,7 @@
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
+	int (*readpage)(struct page *);
 	int (*sync_page)(struct page *);
 
 	/* Write back some dirty pages from this mapping. */
@@ -306,7 +306,7 @@
 	/* Set a page dirty */
 	int (*set_page_dirty)(struct page *page);
 
-	int (*readpages)(struct file *filp, struct address_space *mapping,
+	int (*readpages)(struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
 
 	/*
@@ -1418,7 +1418,7 @@
 extern int simple_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
 extern int simple_sync_file(struct file *, struct dentry *, int);
 extern int simple_empty(struct dentry *);
-extern int simple_readpage(struct file *file, struct page *page);
+extern int simple_readpage(struct page *page);
 extern int simple_prepare_write(struct file *file, struct page *page,
 			unsigned offset, unsigned to);
 extern int simple_commit_write(struct file *file, struct page *page,
--- linux-2.6.5cow/include/linux/pagemap.h~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/include/linux/pagemap.h	2004-04-15 22:44:08.000000000 +0200
@@ -59,7 +59,7 @@
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
 }
 
-typedef int filler_t(void *, struct page *);
+typedef int filler_t(struct page *);
 
 extern struct page * find_get_page(struct address_space *mapping,
 				unsigned long index);
@@ -84,10 +84,9 @@
 extern struct page * grab_cache_page_nowait(struct address_space *mapping,
 				unsigned long index);
 extern struct page * read_cache_page(struct address_space *mapping,
-				unsigned long index, filler_t *filler,
-				void *data);
+				unsigned long index, filler_t *filler);
 extern int read_cache_pages(struct address_space *mapping,
-		struct list_head *pages, filler_t *filler, void *data);
+		struct list_head *pages, filler_t *filler);
 
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 				unsigned long index, int gfp_mask);
--- linux-2.6.5cow/mm/filemap.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/mm/filemap.c	2004-04-15 22:44:08.000000000 +0200
@@ -1411,8 +1411,7 @@
 
 static inline struct page *__read_cache_page(struct address_space *mapping,
 				unsigned long index,
-				int (*filler)(void *,struct page*),
-				void *data)
+				int (*filler)(struct page*))
 {
 	struct page *page, *cached_page = NULL;
 	int err;
@@ -1435,7 +1434,7 @@
 		}
 		page = cached_page;
 		cached_page = NULL;
-		err = filler(data, page);
+		err = filler(page);
 		if (err < 0) {
 			page_cache_release(page);
 			page = ERR_PTR(err);
@@ -1452,14 +1451,13 @@
  */
 struct page *read_cache_page(struct address_space *mapping,
 				unsigned long index,
-				int (*filler)(void *,struct page*),
-				void *data)
+				int (*filler)(struct page*))
 {
 	struct page *page;
 	int err;
 
 retry:
-	page = __read_cache_page(mapping, index, filler, data);
+	page = __read_cache_page(mapping, index, filler);
 	if (IS_ERR(page))
 		goto out;
 	mark_page_accessed(page);
@@ -1476,7 +1474,7 @@
 		unlock_page(page);
 		goto out;
 	}
-	err = filler(data, page);
+	err = filler(page);
 	if (err < 0) {
 		page_cache_release(page);
 		page = ERR_PTR(err);
--- linux-2.6.5cow/mm/readahead.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/mm/readahead.c	2004-04-15 22:44:08.000000000 +0200
@@ -62,7 +62,7 @@
  * Hides the details of the LRU cache etc from the filesystems.
  */
 int read_cache_pages(struct address_space *mapping, struct list_head *pages,
-		 int (*filler)(void *, struct page *), void *data)
+		 int (*filler)(struct page *))
 {
 	struct page *page;
 	struct pagevec lru_pvec;
@@ -77,7 +77,7 @@
 			page_cache_release(page);
 			continue;
 		}
-		ret = filler(data, page);
+		ret = filler(page);
 		if (!pagevec_add(&lru_pvec, page))
 			__pagevec_lru_add(&lru_pvec);
 		if (ret) {
--- linux-2.6.5cow/mm/swapfile.c~readpage_prune	2004-04-15 22:44:06.000000000 +0200
+++ linux-2.6.5cow/mm/swapfile.c	2004-04-15 22:44:08.000000000 +0200
@@ -1336,8 +1336,7 @@
 		error = -EINVAL;
 		goto bad_swap;
 	}
-	page = read_cache_page(mapping, 0,
-			(filler_t *)mapping->a_ops->readpage, swap_file);
+	page = read_cache_page(mapping, 0, (filler_t*)mapping->a_ops->readpage);
 	if (IS_ERR(page)) {
 		error = PTR_ERR(page);
 		goto bad_swap;
