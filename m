Return-Path: <linux-kernel-owner+w=401wt.eu-S1752748AbWLVVKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbWLVVKW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbWLVVKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:10:22 -0500
Received: from ppp85-141-207-24.pppoe.mtu-net.ru ([85.141.207.24]:35609 "EHLO
	gw.home.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752748AbWLVVJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:09:55 -0500
X-Greylist: delayed 2746 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 16:09:46 EST
From: Alex Tomas <alex@clusterfs.com>
To: linux-ext4@vger.kernel.org
Subject: [RFC] ext4-delayed-allocation.patch
Organization: CFS
References: <m37iwjwumf.fsf@bzzz.home.net>
CC: <linux-kernel@vger.kernel.org>, alex@clusterfs.com
Date: Fri, 22 Dec 2006 23:28:32 +0300
In-Reply-To: <m37iwjwumf.fsf@bzzz.home.net> (Alex Tomas's message of "Fri\, 22
	Dec 2006 23\:20\:08 +0300")
Message-ID: <m3tzznvfnz.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Index: linux-2.6.20-rc1/include/linux/ext4_fs_i.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/ext4_fs_i.h	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/ext4_fs_i.h	2006-12-22 22:56:04.000000000 +0300
@@ -153,6 +153,11 @@ struct ext4_inode_info {
 
 	unsigned long i_ext_generation;
 	struct ext4_ext_cache i_cached_extent;
+
+	__u32 i_blocks_reserved;
+	__u32 i_md_reserved;
+	spinlock_t i_wb_reserved_lock;	/* to protect i_md_reserved */
+	atomic_t i_wb_writers;
 };
 
 #endif	/* _LINUX_EXT4_FS_I */
Index: linux-2.6.20-rc1/include/linux/ext4_fs.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/ext4_fs.h	2006-12-22 22:56:03.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/ext4_fs.h	2006-12-22 22:56:04.000000000 +0300
@@ -401,6 +401,7 @@ struct ext4_inode {
 #define EXT4_MOUNT_USRQUOTA		0x100000 /* "old" user quota */
 #define EXT4_MOUNT_GRPQUOTA		0x200000 /* "old" group quota */
 #define EXT4_MOUNT_EXTENTS		0x400000 /* Extents support */
+#define EXT4_MOUNT_DELAYED_ALLOC	0x1000000/* Delayed allocation support */
 
 /* Compatibility, for having both ext2_fs.h and ext4_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
@@ -994,6 +995,18 @@ ext4_get_blocks_wrap(handle_t *handle, s
 }
 
 
+/* writeback.c */
+extern int ext4_wb_writepages(struct address_space *, struct writeback_control *);
+extern int ext4_wb_prepare_write(struct file *file, struct page *page,
+			      unsigned from, unsigned to);
+extern int ext4_wb_commit_write(struct file *, struct page *, unsigned, unsigned);
+extern int ext4_wb_writepage(struct page *, struct writeback_control *);
+extern void ext4_wb_invalidatepage(struct page *, unsigned long);
+extern int ext4_wb_releasepage(struct page *, gfp_t);
+extern int ext4_wb_block_truncate_page(handle_t *, struct page *, struct address_space *, loff_t);
+extern void ext4_wb_init(struct super_block *);
+extern void ext4_wb_release(struct super_block *);
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_EXT4_FS_H */
Index: linux-2.6.20-rc1/include/linux/ext4_fs_sb.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/ext4_fs_sb.h	2006-12-22 22:56:03.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/ext4_fs_sb.h	2006-12-22 22:56:04.000000000 +0300
@@ -94,6 +94,17 @@ struct ext4_sb_info {
 	unsigned long s_ext_blocks;
 	unsigned long s_ext_extents;
 #endif
+
+	atomic_t s_wb_congested;
+	atomic_t s_wb_single_pages;
+	atomic_t s_wb_collisions_sp;
+	atomic_t s_wb_allocated;
+	atomic_t s_wb_reqs;
+	atomic_t s_wb_nr_to_write;
+	atomic_t s_wb_collisions;
+	atomic_t s_wb_blocks;
+	atomic_t s_wb_extents;
+	atomic_t s_wb_dropped;
 };
 
 #endif	/* _LINUX_EXT4_FS_SB */
Index: linux-2.6.20-rc1/include/linux/ext4_fs_extents.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/ext4_fs_extents.h	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/ext4_fs_extents.h	2006-12-22 22:56:04.000000000 +0300
@@ -193,6 +193,7 @@ extern int ext4_ext_calc_credits_for_ins
 extern int ext4_ext_insert_extent(handle_t *, struct inode *, struct ext4_ext_path *, struct ext4_extent *);
 extern int ext4_ext_walk_space(struct inode *, unsigned long, unsigned long, ext_prepare_callback, void *);
 extern struct ext4_ext_path * ext4_ext_find_extent(struct inode *, int, struct ext4_ext_path *);
+int ext4_ext_calc_metadata_amount(struct inode *inode, int blocks);
 
 #endif /* _LINUX_EXT4_EXTENTS */
 
Index: linux-2.6.20-rc1/fs/ext4/super.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/super.c	2006-12-22 22:56:03.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/super.c	2006-12-22 22:56:04.000000000 +0300
@@ -439,6 +439,7 @@ static void ext4_put_super (struct super
 	struct ext4_super_block *es = sbi->s_es;
 	int i;
 
+	ext4_wb_release(sb);
 	ext4_reserve_release(sb);
 	ext4_ext_release(sb);
 	ext4_xattr_put_super(sb);
@@ -506,6 +507,13 @@ static struct inode *ext4_alloc_inode(st
 	ei->i_block_alloc_info = NULL;
 	ei->vfs_inode.i_version = 1;
 	memset(&ei->i_cached_extent, 0, sizeof(struct ext4_ext_cache));
+
+	/* FIXME: these wb-related fields could be initialized once */
+ 	ei->i_blocks_reserved = 0;
+ 	ei->i_md_reserved = 0;
+ 	atomic_set(&ei->i_wb_writers, 0);
+	spin_lock_init(&ei->i_wb_reserved_lock);
+
 	return &ei->vfs_inode;
 }
 
@@ -729,7 +737,7 @@ enum {
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_quota, Opt_noquota,
 	Opt_ignore, Opt_barrier, Opt_err, Opt_resize, Opt_usrquota,
-	Opt_grpquota, Opt_extents,
+	Opt_grpquota, Opt_extents, Opt_delayed_alloc,
 };
 
 static match_table_t tokens = {
@@ -780,6 +788,7 @@ static match_table_t tokens = {
 	{Opt_usrquota, "usrquota"},
 	{Opt_barrier, "barrier=%u"},
 	{Opt_extents, "extents"},
+	{Opt_delayed_alloc, "delalloc"},
 	{Opt_err, NULL},
 	{Opt_resize, "resize"},
 };
@@ -1094,6 +1103,9 @@ clear_qf_name:
 			else
 				clear_opt(sbi->s_mount_opt, BARRIER);
 			break;
+		case Opt_delayed_alloc:
+			set_opt(sbi->s_mount_opt, DELAYED_ALLOC);
+			break;
 		case Opt_ignore:
 			break;
 		case Opt_resize:
@@ -1869,6 +1881,7 @@ static int ext4_fill_super (struct super
 
 	ext4_ext_init(sb);
 	ext4_reserve_init(sb);
+	ext4_wb_init(sb);
 
 	lock_kernel();
 	return 0;
Index: linux-2.6.20-rc1/fs/ext4/extents.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/extents.c	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/extents.c	2006-12-22 22:56:04.000000000 +0300
@@ -2159,6 +2159,36 @@ int ext4_ext_writepage_trans_blocks(stru
 	return needed;
 }
 
+int ext4_ext_calc_metadata_amount(struct inode *inode, int blocks)
+{
+	int lcap, icap, rcap, leafs, idxs, num;
+
+	rcap = ext4_ext_space_root(inode);
+	if (blocks <= rcap) {
+		/* all extents fit to the root */
+		return 0;
+	}
+
+	rcap = ext4_ext_space_root_idx(inode);
+	lcap = ext4_ext_space_block(inode);
+	icap = ext4_ext_space_block_idx(inode);
+
+	num = leafs = (blocks + lcap - 1) / lcap;
+	if (leafs <= rcap) {
+		/* all pointers to leafs fit to the root */
+		return leafs;
+	}
+
+	/* ok. we need separate index block(s) to link all leaf blocks */
+	idxs = (leafs + icap - 1) / icap;
+	do {
+		num += idxs;
+		idxs = (idxs + icap - 1) / icap;
+	} while (idxs > rcap);
+
+	return num;
+}
+
 EXPORT_SYMBOL(ext4_mark_inode_dirty);
 EXPORT_SYMBOL(ext4_ext_invalidate_cache);
 EXPORT_SYMBOL(ext4_ext_insert_extent);
Index: linux-2.6.20-rc1/fs/ext4/Makefile
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/Makefile	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/Makefile	2006-12-22 22:56:04.000000000 +0300
@@ -6,7 +6,7 @@ obj-$(CONFIG_EXT4DEV_FS) += ext4dev.o
 
 ext4dev-y	:= balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 		   ioctl.o namei.o super.o symlink.o hash.o resize.o extents.o \
-		   ext4_jbd2.o
+		   ext4_jbd2.o writeback.o
 
 ext4dev-$(CONFIG_EXT4DEV_FS_XATTR)	+= xattr.o xattr_user.o xattr_trusted.o
 ext4dev-$(CONFIG_EXT4DEV_FS_POSIX_ACL)	+= acl.o
Index: linux-2.6.20-rc1/fs/ext4/writeback.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/writeback.c	2006-11-30 15:32:10.563465031 +0300
+++ linux-2.6.20-rc1/fs/ext4/writeback.c	2006-12-22 22:59:33.000000000 +0300
@@ -0,0 +1,1167 @@
+/*
+ * Copyright (c) 2003-2006, Cluster File Systems, Inc, info@clusterfs.com
+ * Written by Alex Tomas <alex@clusterfs.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public Licens
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
+ */
+
+/*
+ * TODO:
+ *   MUST:
+ *     - flush dirty pages in -ENOSPC case in order to free reserved blocks
+ *     - direct I/O support
+ *     - blocksize != PAGE_CACHE_SIZE support
+ *     - store last unwritten page in ext4_wb_writepages() and
+ *       continue from it in a next run
+ *   WISH:
+ *     - should ext4_wb_writepage() try to flush neighbours?
+ *     - ext4_wb_block_truncate_page() must flush partial truncated pages
+ *     - reservation can be done per write-request in ext4_file_write()
+ *       rather than per-page in ext4_wb_commit_write() -- it's quite
+ *       expensive to recalculate amount of required metadata for evey page
+ *     - re-allocation to improve layout
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/time.h>
+#include <linux/ext4_jbd2.h>
+#include <linux/jbd.h>
+#include <linux/ext4_fs_extents.h>
+#include <linux/smp_lock.h>
+#include <linux/highuid.h>
+#include <linux/pagemap.h>
+#include <linux/quotaops.h>
+#include <linux/string.h>
+#include <linux/buffer_head.h>
+#include <linux/writeback.h>
+#include <linux/mpage.h>
+#include <linux/pagevec.h>
+#include <linux/backing-dev.h>
+#include <linux/spinlock.h>
+
+/*
+ * If EXT4_WB_STATS is defined, then some stats are collected.
+ * It will be showed upont umount time.
+ */
+#define EXT4_WB_STATS
+
+
+/*
+ * With EXT4_WB_SKIP_SMALL defined the patch will try to avoid
+ * small I/Os ignoring ->writepages() if mapping hasn't enough
+ * contig. dirty pages
+ */
+#define EXT4_WB_SKIP_SMALL__
+
+#define WB_ASSERT(__x__) if (!(__x__)) BUG();
+
+#define WB_DEBUG__
+#ifdef WB_DEBUG
+#define wb_debug(fmt,a...)	printk(fmt, ##a);
+#else
+#define wb_debug(fmt,a...)
+#endif
+
+#define WB_MAX_PAGES_PER_EXTENT	32768
+
+#define WB_PAGES_PER_ARRAY	60
+
+struct ext4_wb_pages {
+	struct list_head list;
+	struct page *pages[WB_PAGES_PER_ARRAY];
+	unsigned short num, start;
+};
+
+struct ext4_wb_control {
+	pgoff_t	start;
+	int len, extents;
+	int blocks_to_release;
+	struct ext4_wb_pages *pages;
+	struct list_head list;
+	struct address_space *mapping;
+};
+
+
+void ext4_wb_invalidatepage(struct page *, unsigned long);
+int ext4_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
+
+
+static struct page * ext4_wb_pull_page(struct ext4_wb_control *wc)
+{
+	struct ext4_wb_pages *wp = wc->pages;
+
+	BUG_ON(wp == NULL);
+	BUG_ON(list_empty(&wc->list));
+	BUG_ON(list_empty(&wp->list));
+	if (wp->start == wp->num) {
+		list_del(&wp->list);
+		kfree(wp);
+		if (list_empty(&wc->list))
+			return NULL;
+		wp = list_entry(wc->list.next, struct ext4_wb_pages, list);
+		wc->pages = wp;
+	}
+	BUG_ON(list_empty(&wp->list));
+	return wp->pages[wp->start++];
+}
+
+static struct bio * ext4_wb_bio_alloc(struct inode *inode,
+					sector_t first_block, int nr_vecs)
+{
+	int gfp_flags = GFP_NOFS | __GFP_HIGH;
+	struct bio *bio;
+	int maxreq;
+
+	maxreq = bio_get_nr_vecs(inode->i_sb->s_bdev);
+	if (maxreq < nr_vecs)
+		nr_vecs = maxreq;
+
+	bio = bio_alloc(gfp_flags, nr_vecs);
+
+	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
+		while (!bio && (nr_vecs /= 2))
+			bio = bio_alloc(gfp_flags, nr_vecs);
+	}
+
+	if (bio) {
+		bio->bi_bdev = inode->i_sb->s_bdev;
+		bio->bi_sector = first_block << (inode->i_blkbits - 9);
+	}
+	return bio;
+}
+
+static int ext4_wb_end_io(struct bio *bio, unsigned int bytes, int err)
+{
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+
+	if (bio->bi_size)
+		return 1;
+
+	do {
+		struct page *page = bvec->bv_page;
+
+		if (--bvec >= bio->bi_io_vec)
+			prefetchw(&bvec->bv_page->flags);
+
+		if (!uptodate)
+			SetPageError(page);
+		end_page_writeback(page);
+	} while (bvec >= bio->bi_io_vec);
+	bio_put(bio);
+	return 0;
+}
+
+static struct bio *ext4_wb_bio_submit(struct bio *bio, handle_t *handle)
+{
+	bio->bi_end_io = ext4_wb_end_io;
+	submit_bio(WRITE, bio);
+	return NULL;
+}
+
+int inline ext4_wb_reserve_space_page(struct page *page, int blocks)
+{
+	struct inode *inode = page->mapping->host;
+	int total, mdb, err;
+
+	wb_debug("reserve %d blocks for page %lu from inode %lu\n",
+			blocks, page->index, inode->i_ino);
+
+	/* user wants us to reserve blocks for his file. reserving space
+	 * for his (data) blocks isn't enough because adding block may
+	 * involve allocation index/leaf blocks for tree/blockmap. 
+	 * so, we need to calculate numbers of needed metadata for worst
+	 * case: block per extent */
+
+	spin_lock(&EXT4_I(inode)->i_wb_reserved_lock);
+	total = EXT4_I(inode)->i_blocks_reserved + blocks;
+	mdb = ext4_ext_calc_metadata_amount(inode, total);
+
+	/* if blockmap needs more metadata, we have to reserve difference */
+	BUG_ON(mdb < EXT4_I(inode)->i_md_reserved);
+	mdb = mdb - EXT4_I(inode)->i_md_reserved;
+	
+	err = ext4_reserve_blocks(inode->i_sb, mdb + blocks);
+	if (err) {
+		/* blocks are exhausted? */
+		spin_unlock(&EXT4_I(inode)->i_wb_reserved_lock);
+		return err;
+	}
+
+	/* blocks have been reserved, account this. I believe
+	 * inode's fields are protected by inode->i_sem */
+	EXT4_I(inode)->i_blocks_reserved += blocks;
+	EXT4_I(inode)->i_md_reserved += mdb;
+	spin_unlock(&EXT4_I(inode)->i_wb_reserved_lock);
+
+	/* we have reserved space on a disk for the page */
+	SetPageBooked(page);
+	return 0;
+}
+
+/*
+ * release space reserved for @blocks of data
+ * @used signals that @blocks got really allocated and we just
+ * need to release corresponded over-reserved metadata
+ */
+int inline ext4_wb_release_space(struct inode *inode, int blocks, int used)
+{
+	int total, mdb, release;
+
+	spin_lock(&EXT4_I(inode)->i_wb_reserved_lock);
+
+	total = EXT4_I(inode)->i_blocks_reserved - blocks;
+	mdb = ext4_ext_calc_metadata_amount(inode, total);
+
+	/* if blockmap needs lesser metadata, we may release difference */
+	BUG_ON(mdb > EXT4_I(inode)->i_md_reserved);
+	mdb = EXT4_I(inode)->i_md_reserved - mdb;
+
+	release = mdb;
+	/* drop reservation only for non-used blocks */
+	if (!used)
+		release += blocks;
+	wb_debug("%u %s: release %d/%d blocks from %u/%u reserved for inode %lu\n",
+			blocks, used ? "allocated" : "dropped", used ? 0 : blocks,
+			mdb, EXT4_I(inode)->i_blocks_reserved,
+			EXT4_I(inode)->i_md_reserved, inode->i_ino);
+	if (release)
+		ext4_release_blocks(inode->i_sb, release);
+
+	/* update per-inode reservations */
+	BUG_ON(blocks > EXT4_I(inode)->i_blocks_reserved);
+	EXT4_I(inode)->i_blocks_reserved -= blocks;
+	BUG_ON(mdb > EXT4_I(inode)->i_md_reserved);
+	EXT4_I(inode)->i_md_reserved -= mdb;
+
+	spin_unlock(&EXT4_I(inode)->i_wb_reserved_lock);
+
+	return 0;
+}
+
+static inline int ext4_wb_drop_page_reservation(struct page *page)
+{
+	/* we just allocated blocks for this page. those blocks (and
+	 * probably metadata for them) were reserved before. now we
+	 * should drop reservation mark from the page. if we didn't
+	 * do that then ->invalidatepage() may think page still holds
+	 * reserved blocks. we could release reserved blocks right
+	 * now, but I'd prefer to make this once per several blocks */
+	wb_debug("drop reservation from page %lu from inode %lu\n",
+			page->index, page->mapping->host->i_ino);
+	BUG_ON(!PageBooked(page));
+	ClearPageBooked(page);
+	return 0;
+}
+
+static int ext4_wb_submit_extent(struct ext4_wb_control *wc, handle_t *handle,
+					struct ext4_extent *ex, int new)
+{
+	struct inode *inode = wc->mapping->host;
+	int blkbits = inode->i_blkbits;
+	struct page *page;
+	unsigned long blk, off, len, remain;
+	unsigned long pstart, plen, prev;
+	struct bio *bio = NULL;
+	int nr_pages;
+
+	/*
+	 * we have list of pages in wc and block numbers in ex
+	 * let's cook bios from them and start real I/O
+	 */
+
+	BUG_ON(PAGE_CACHE_SHIFT < blkbits);
+	BUG_ON(list_empty(&wc->list));
+
+	wb_debug("cook and submit bios for %u/%u/%u for %lu/%u\n",
+		ex->ee_block, ex->ee_len, ex->ee_start, wc->start, wc->len);
+
+	blk = ex->ee_block;
+	remain = ex->ee_len;
+	wc->extents++;
+
+	while (remain) {
+		page = ext4_wb_pull_page(wc);
+		if (page == NULL)
+			break;
+
+		pstart = page->index << (PAGE_CACHE_SHIFT - blkbits);
+		plen = PAGE_SIZE >> blkbits;
+		if (pstart > blk) {
+			/* probably extent covers long space and page
+			 * to be written in the middle of it */
+			BUG_ON(pstart - blk >= remain);
+			remain -= pstart - blk;
+			blk = pstart;
+		}
+		BUG_ON(blk < pstart || blk >= pstart + plen);
+
+		BUG_ON(!PageUptodate(page));
+		/* page can get here via mmap(2) 
+		 * BUG_ON(!PagePrivate(page));*/
+		BUG_ON(new && PageMappedToDisk(page));
+		BUG_ON(!new && !PageMappedToDisk(page));
+		SetPageMappedToDisk(page);
+		if (new && PagePrivate(page)) {
+			/* space is just allocated and it was reserved in
+			 * ->commit_write(). time to release reservation.
+			 * space may not be reserved if page gets dirty
+			 * via mmap. should we reserve it in ->mmap() ? */
+			prev = min(plen, remain);
+			ext4_wb_drop_page_reservation(page);
+			wc->blocks_to_release += prev;
+		}
+
+alloc_new_bio:
+		if (bio == NULL) {
+			/* +2 because head/tail may belong to different pages */
+			nr_pages = (ex->ee_len - (blk - ex->ee_block));
+			nr_pages = (nr_pages >> (PAGE_CACHE_SHIFT - blkbits));
+			off = ex->ee_start + (blk - ex->ee_block);
+			bio = ext4_wb_bio_alloc(inode, off, nr_pages + 2);
+			if (bio == NULL)
+				return -ENOMEM;
+		}
+
+		off = (blk - pstart) << blkbits;
+		prev = min(plen, remain);
+		len = prev << blkbits;
+		if (bio_add_page(bio, page, len, off) < len) {
+			bio = ext4_wb_bio_submit(bio, handle);
+			goto alloc_new_bio;
+		}
+		remain -= prev;
+		blk += prev;
+		if (blk < pstart + plen) {
+			/* extent covers part of the page only.
+			 * it's possible that next extent covers
+			 * the tail. so, we leave page */
+			printk("blk %lu pstart %lu plen %lu remain %lu prev %lu\n",
+				blk, pstart, plen, remain, prev);
+			wc->pages->start--;
+			BUG_ON(remain != 0);
+		}
+	}
+	if (bio)
+		ext4_wb_bio_submit(bio, handle);
+	BUG_ON(new && remain != 0);
+	return 0;
+}
+
+static ext4_fsblk_t
+ext4_wb_find_goal(struct inode *inode, struct ext4_ext_path *path,
+			ext4_fsblk_t block)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	ext4_fsblk_t bg_start;
+	unsigned long colour;
+	int depth;
+	
+	if (path) {
+		struct ext4_extent *ex;
+		depth = path->p_depth;
+		
+		/* try to predict block placement */
+		if ((ex = path[depth].p_ext))
+			return ex->ee_start + (block - ex->ee_block);
+
+		/* it looks index is empty
+		 * try to find starting from index itself */
+		if (path[depth].p_bh)
+			return path[depth].p_bh->b_blocknr;
+	}
+
+	/* OK. use inode's group */
+	bg_start = (ei->i_block_group * EXT4_BLOCKS_PER_GROUP(inode->i_sb)) +
+		le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_first_data_block);
+	colour = (current->pid % 16) *
+			(EXT4_BLOCKS_PER_GROUP(inode->i_sb) / 16);
+	return bg_start + colour + block;
+}
+
+static int ext4_wb_handle_extent(struct inode *inode,
+					struct ext4_ext_path *path,
+					struct ext4_ext_cache *ec,
+					void *cbdata)
+{
+	struct ext4_wb_control *wc = cbdata;
+	struct super_block *sb = inode->i_sb;
+	ext4_fsblk_t goal, pblock;
+	unsigned long tgen, count;
+	struct ext4_extent nex;
+	loff_t new_i_size;
+	handle_t *handle;
+	int i, err;
+
+	if (ec->ec_type == EXT4_EXT_CACHE_EXTENT) {
+		/* 
+		 * The extent is already allocated. The only thing
+		 * we have to do is to flush correspondend pages.
+		 */
+		wb_debug("extent %u/%u/%u exist\n",
+				(unsigned) ec->ec_block,
+				(unsigned) ec->ec_len,
+				(unsigned) ec->ec_start);
+		nex.ee_start = ec->ec_start;
+		nex.ee_block = ec->ec_block;
+		nex.ee_len = ec->ec_len;
+		err = ext4_wb_submit_extent(wc, NULL, &nex, 0);
+
+		/* correct on-disk size, if we grow within
+		 * already allocated block */
+		new_i_size = (loff_t) nex.ee_block + nex.ee_len;
+		new_i_size = new_i_size << inode->i_blkbits;
+		if (new_i_size > i_size_read(inode))
+			new_i_size = i_size_read(inode);
+		if (new_i_size > EXT4_I(inode)->i_disksize) {
+			EXT4_I(inode)->i_disksize = new_i_size;
+			ext4_dirty_inode(inode);
+		}
+		return err;
+	}
+
+	wb_debug("extent %u/%u DOES NOT exist\n", ec->ec_block, ec->ec_len);
+
+	/* space for some pages we want to flush hasn't allocated
+	 * yet. so, it's time to allocate space */
+	tgen = EXT4_I(inode)->i_ext_generation;
+	count = ext4_ext_calc_credits_for_insert(inode, path);
+	mutex_unlock(&EXT4_I(inode)->truncate_mutex);
+
+	handle = ext4_journal_start(inode, count + EXT4_DATA_TRANS_BLOCKS(sb) + 1);
+	if (IS_ERR(handle)) {
+		mutex_lock(&EXT4_I(inode)->truncate_mutex);
+		return PTR_ERR(handle);
+	}
+
+	/* FIXME: we could analyze current path and advice allocator
+	 * to find additional blocks if goal can't be allocated
+	 * this is for better interaction between extents and mballoc
+	 * plus this should improve overall performance */
+
+	mutex_lock(&EXT4_I(inode)->truncate_mutex);
+	if (tgen != EXT4_I(inode)->i_ext_generation) {
+		/* the tree has changed. so path can be invalid at moment */
+		ext4_journal_stop(handle);
+		return EXT_REPEAT;
+	}
+
+	goal = ext4_wb_find_goal(inode, path, ec->ec_block);
+	count = ec->ec_len;
+
+	/* if this is a tail of closed file, ask allocator don't preallocate */
+	new_i_size = i_size_read(inode) + sb->s_blocksize - 1;
+	new_i_size = new_i_size >> inode->i_blkbits;
+	if (ec->ec_block + count == new_i_size &&
+			!atomic_read(&inode->i_writecount)) {
+		/* XXX: disable preallocation for tail */
+	}
+
+	/* this is a hack to tell the allocator that blocks
+	 * we are going to allocated are already reserved */
+	EXT4_I(inode)->i_state |= EXT4_STATE_BLOCKS_RESERVED;
+	pblock = ext4_new_blocks(handle, inode, goal, &count, &err);
+	EXT4_I(inode)->i_state &= ~EXT4_STATE_BLOCKS_RESERVED;
+
+	if (!pblock)
+		goto out;
+
+	BUG_ON(count > ec->ec_len);
+	BUG_ON(count == 0);
+	wb_debug("allocated %llu/%lu for %lu (asked %u)\n",
+			pblock, count, inode->i_ino, ec->ec_len);
+
+	/* insert new extent */
+	nex.ee_start = pblock;
+	nex.ee_start_hi = 0;
+	nex.ee_len = count;
+	nex.ee_block = ec->ec_block;
+	err = ext4_ext_insert_extent(handle, inode, path, &nex);
+	if (err)
+		goto out;
+
+	/*
+	 * Putting len of the actual extent we just inserted,
+	 * we are asking ext4_ext_walk_space() to continue 
+	 * scaning after that block
+	 */
+	ec->ec_len = nex.ee_len;
+	BUG_ON(nex.ee_len == 0);
+
+#ifdef EXT4_WB_STATS
+	atomic_add(nex.ee_len, &EXT4_SB(inode->i_sb)->s_wb_allocated);
+#endif
+
+	wb_debug("inserted %lu/%lu/%lu for %lu (asked %u)\n",
+		(unsigned long) nex.ee_block, (unsigned long) nex.ee_len, 
+		(unsigned long) nex.ee_start, inode->i_ino, ec->ec_len);
+
+	/*
+	 * Important! The nex can change after insert. So do not
+	 * use ec for following
+	 */
+
+	/* block have been allocated for data, so time to drop dirty
+	 * in correspondend buffer_heads to prevent corruptions */
+	for (i = 0; i < nex.ee_len; i++)
+		unmap_underlying_metadata(sb->s_bdev, nex.ee_start + i);
+
+	/* correct on-disk inode size */
+	if (nex.ee_len > 0) {
+		new_i_size = (loff_t) nex.ee_block + nex.ee_len;
+		new_i_size = new_i_size << inode->i_blkbits;
+		if (new_i_size > i_size_read(inode))
+			new_i_size = i_size_read(inode);
+		if (new_i_size > EXT4_I(inode)->i_disksize) {
+			EXT4_I(inode)->i_disksize = new_i_size;
+			err = ext4_mark_inode_dirty(handle, inode);
+		}
+	}
+
+	if (ext4_should_order_data(inode))
+		err = ext4_wb_submit_extent(wc, handle, &nex, 1);
+	else
+		err = ext4_wb_submit_extent(wc, NULL, &nex, 1);
+
+	/* we don't want to recalculate needed reservation for
+	 * each page. we may do this for each new extent */
+	ext4_wb_release_space(inode, wc->blocks_to_release, 1);
+	wc->blocks_to_release = 0;
+
+out:
+	ext4_journal_stop(handle);
+	if (err)
+		printk("EXT4-fs: writeback error = %d\n", err);
+	return err;
+}
+
+static int ext4_wb_flush(struct ext4_wb_control *wc)
+{
+	struct list_head *cur, *tmp;
+	struct inode *inode;
+	int err, num = 0;
+
+	if (wc->len == 0)
+		return 0;
+
+	inode = wc->mapping->host;
+	wb_debug("start flushing %lu/%u from inode %lu\n",
+			wc->start, wc->len, inode->i_ino);
+
+	wc->pages = list_entry(wc->list.next, struct ext4_wb_pages, list);
+	wc->extents = 0;
+
+	mutex_lock(&EXT4_I(inode)->truncate_mutex);
+	/* FIXME: last page may be partial */
+	err = ext4_ext_walk_space(inode, wc->start, wc->len,
+					ext4_wb_handle_extent, wc);
+	mutex_unlock(&EXT4_I(inode)->truncate_mutex);
+
+	list_for_each_safe(cur, tmp, &wc->list) {
+		struct ext4_wb_pages *wp;
+		wp = list_entry(cur, struct ext4_wb_pages, list);
+		if (err) {
+			while (wp->start < wp->num) {
+				struct page *page = wp->pages[wp->start];
+				BUG_ON(!PageWriteback(page));
+				end_page_writeback(page);
+				__set_page_dirty_nobuffers(page);
+				wp->start++;
+			}
+		} else {
+			BUG_ON(num != 0);
+			BUG_ON(wp->start != wp->num - 1 &&
+					wp->start != wp->num);
+		}
+		list_del(&wp->list);
+		kfree(wp);
+		num++;
+	}
+	wc->pages = NULL;
+	wc->len = 0;
+	wc->extents = 0;
+	
+	return err;
+}
+
+static int ext4_wb_add_page(struct ext4_wb_control *wc, struct page *page)
+{
+	struct ext4_wb_pages * wp = wc->pages;
+
+	if (wp == NULL || wp->num == WB_PAGES_PER_ARRAY) {
+		wp = kmalloc(sizeof(struct ext4_wb_pages), GFP_NOFS);
+		if (wp == NULL) {
+			printk("no mem for ext4_wb_pages!\n");
+			return -ENOMEM;
+		}
+		wp->num = 0;
+		wp->start = 0;
+		list_add_tail(&wp->list, &wc->list);
+		wc->pages = wp;
+	}
+
+	wp->pages[wp->num] = page;
+	wp->num++;
+
+	return 0;
+}
+
+static inline void
+ext4_wb_init_control(struct ext4_wb_control *wc, struct address_space *mapping)
+{
+	wc->mapping = mapping;
+	wc->len = 0;
+	wc->blocks_to_release = 0;
+	INIT_LIST_HEAD(&wc->list);
+	wc->pages = NULL;
+}
+
+static inline int
+ext4_wb_can_merge(struct ext4_wb_control *wc, unsigned long next)
+{
+	if (wc->start + wc->len == next &&
+			wc->len <= WB_MAX_PAGES_PER_EXTENT)
+		return 1;
+	return 0;
+}
+
+int ext4_wb_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	struct inode *inode = mapping->host;
+	int nr_pages, i, err = 0, done = 0;
+	struct ext4_wb_control wc;
+	struct pagevec pvec;
+	pgoff_t index = 0;
+	int written = 0;
+	int extents = 0;
+	pgoff_t pindex = 0;
+	
+	wb_debug("->writepages on inode %lu (%u reserved)\n",
+		inode->i_ino, EXT4_I(inode)->i_blocks_reserved);
+#ifdef EXT4_WB_SKIP_SMALL
+	if (wbc->nr_to_write <= 64 && wbc->sync_mode == WB_SYNC_NONE)
+		return 0;
+#endif
+	atomic_inc(&EXT4_I(inode)->i_wb_writers);
+#ifdef EXT4_WB_STATS
+	atomic_inc(&EXT4_SB(inode->i_sb)->s_wb_reqs);
+	atomic_add(wbc->nr_to_write, &EXT4_SB(inode->i_sb)->s_wb_nr_to_write);
+	if (atomic_read(&EXT4_I(inode)->i_wb_writers) != 1)
+		atomic_inc(&EXT4_SB(inode->i_sb)->s_wb_collisions);
+#endif
+
+	/* skip opened-for-write small files
+	 * XXX: what do we do if most of files hit the condition? */
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+			atomic_read(&inode->i_writecount) &&
+			i_size_read(inode) <= 64*1024) {
+		return 0;
+	}
+
+	ext4_wb_init_control(&wc, mapping);
+
+	pagevec_init(&pvec, 0);
+	while (!done && (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+					PAGECACHE_TAG_DIRTY, PAGEVEC_SIZE))) {
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+		
+			lock_page(page);
+
+			if (wbc->sync_mode != WB_SYNC_NONE)
+				wait_on_page_writeback(page);
+
+			if (page->mapping != mapping) {
+				unlock_page(page);
+				continue;
+			}
+			if (PageWriteback(page)) {
+				unlock_page(page);
+				continue;
+			}
+
+			if (wc.len && ext4_wb_can_merge(&wc, page->index) &&
+					wbc->nr_to_write <= 0) {
+				/*
+				 * If we already exhausted blocks we got
+				 * to write and new extent starts, stop
+				 * writeback
+				 */
+				unlock_page(page);
+				done = 1;
+				break;
+
+			}
+
+			if (!clear_page_dirty_for_io(page)) {
+				unlock_page(page);
+				continue;
+			}
+
+			set_page_writeback(page);
+			unlock_page(page);
+
+			if (wc.len == 0) {
+				wc.start = page->index;
+				wc.len = 1;
+				extents++;
+			} else if (ext4_wb_can_merge(&wc, page->index)) {
+				wc.len++;
+			} else {
+				/* end of current extent: flush it ... */
+#if 0
+				if (wc.len < 64 && wc.len > 0) {
+					printk("#%u: wow! short extent %d for flush on #%lu\n",
+						(unsigned) current->pid, wc.len, inode->i_ino);
+					printk("#%u: done = %d, nr_to_write %ld, sync = %d\n",
+						(unsigned) current->pid, done, wbc->nr_to_write,
+						wbc->sync_mode);
+					printk("#%u: written %d, extents %d\n",
+						(unsigned) current->pid, written, extents);
+					printk("#%u: cur %lu, prev %lu\n",
+						(unsigned) current->pid,
+						(unsigned long) page->index,
+						(unsigned long) pindex);
+				}
+#endif
+				err = ext4_wb_flush(&wc);
+				if (err) {
+					done = 1;
+					end_page_writeback(page);
+					break;
+				}
+
+				/* ... and start new one */
+				BUG_ON(!PageWriteback(page));
+				wc.start = page->index;
+				wc.len = 1;
+				extents++;
+			}
+
+			pindex = page->index;
+			err = ext4_wb_add_page(&wc, page);
+			if (err) {
+				done = 1;
+				end_page_writeback(page);
+				break;
+			}
+			written++;
+
+			wbc->nr_to_write--;
+#if 0
+			if ((--(wbc->nr_to_write) <= 0))
+				done = 1;
+#endif
+			if (wbc->nonblocking && bdi_write_congested(bdi)) {
+#ifdef EXT4_WB_STATS
+				atomic_inc(&EXT4_SB(inode->i_sb)->s_wb_congested);
+#endif
+				wbc->encountered_congestion = 1;
+				done = 1;
+			}
+		}
+		pagevec_release(&pvec);
+	}
+	if (!err) {
+#ifdef EXT4_WB_SKIP_SMALL
+		if (wc.len > 0 && wc.len < 64 && wbc->sync_mode == WB_SYNC_NONE) {
+			struct list_head *cur, *tmp;
+			list_for_each_safe(cur, tmp, &wc.list) {
+				struct ext4_wb_pages *wp;
+				wp = list_entry(cur, struct ext4_wb_pages, list);
+				for (i = wp->start; i < wp->num; i++) {
+					struct page *page = wp->pages[i];
+					BUG_ON(!PageWriteback(page));
+					end_page_writeback(page);
+					__set_page_dirty_nobuffers(page);
+				}
+				wbc->nr_to_write += i;
+				list_del(&wp->list);
+				kfree(wp);
+			}
+		} else
+#endif
+			ext4_wb_flush(&wc);
+	}
+
+	atomic_dec(&EXT4_I(inode)->i_wb_writers);
+
+#ifdef EXT4_WB_STATS
+	atomic_add(written, &EXT4_SB(inode->i_sb)->s_wb_blocks);
+	atomic_add(extents, &EXT4_SB(inode->i_sb)->s_wb_extents);
+#endif
+	return 0;
+}
+
+static void ext4_wb_clear_page(struct page *page, int from, int to)
+{
+	void *kaddr;
+
+	if (to < PAGE_CACHE_SIZE || from > 0) {
+		kaddr = kmap_atomic(page, KM_USER0);
+		if (PAGE_CACHE_SIZE > to)
+			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
+		if (0 < from)
+			memset(kaddr, 0, from);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+	}
+}
+
+int ext4_wb_prepare_write(struct file *file, struct page *page,
+			      unsigned from, unsigned to)
+{
+	struct inode *inode = page->mapping->host;
+	struct buffer_head bh, *bhw = &bh;
+	int err = 0;
+
+	wb_debug("prepare page %lu (%u-%u) for inode %lu\n",
+			page->index, from, to, page->mapping->host->i_ino);
+
+	/* if page is uptodate this means that ->prepare_write() has
+	 * been called on page before and page is mapped to disk or
+	 * we did reservation. page is protected and nobody can
+	 * access it. hence, it safe to use page->private to pass
+	 * flag that ->commit_write() has to reserve blocks. because
+	 * an error may occur after ->prepare_write() we should not
+	 * reserve block here. it's better to do in ->commit_write()
+	 * when we're sure page is to be written */
+	page->private = 0;
+	if (!PageUptodate(page)) {
+		/* first write to this page */
+		bh.b_state = 0;
+		err = ext4_get_block(inode, page->index, bhw, 0);
+		if (err)
+			return err;
+		if (!buffer_mapped(bhw)) {
+			/* this block isn't allocated yet, reserve space */
+			wb_debug("reserve space for new block\n");
+			page->private = 1;
+			ext4_wb_clear_page(page, from, to);
+			ClearPageMappedToDisk(page);
+		} else { 
+			/* block is already mapped, so no need to reserve */
+			BUG_ON(PagePrivate(page));
+			if (to - from < PAGE_CACHE_SIZE) {
+				wb_debug("read block %u\n",
+						(unsigned) bhw->b_blocknr);
+				set_bh_page(bhw, page, 0);
+				bhw->b_this_page = 0;
+				bhw->b_size = 1 << inode->i_blkbits;
+				atomic_set(&bhw->b_count, 1);
+				ll_rw_block(READ, 1, &bhw);
+				wait_on_buffer(bhw);
+				if (!buffer_uptodate(bhw))
+					return -EIO;
+			}
+			SetPageMappedToDisk(page);
+		}
+	} else if (!PageMappedToDisk(page) && !PagePrivate(page)) {
+		/* this page was a hole at time of mmap() calling 
+		 * now someone wants to modify it by sys_write() */
+		wb_debug("reserve block for hole\n");
+		page->private = 1;
+	}
+
+	return 0;
+}
+
+int ext4_wb_commit_write(struct file *file, struct page *page,
+			     unsigned from, unsigned to)
+{
+	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+	struct inode *inode = page->mapping->host;
+	int err = 0;
+
+	wb_debug("commit page %lu (%u-%u) for inode %lu\n",
+			page->index, from, to, inode->i_ino);
+
+	/* mark page private so that we get
+	 * called to invalidate/release page */
+	SetPagePrivate(page);
+
+	if (!PageBooked(page) && !PageMappedToDisk(page)) {
+		/* ->prepare_write() observed that block for this
+		 * page hasn't been allocated yet. there fore it
+		 * asked to reserve block for later allocation */
+		BUG_ON(page->private == 0);
+		page->private = 0;
+		err = ext4_wb_reserve_space_page(page, 1);
+		if (err)
+			return err;
+	}
+
+	/* ok. block for this page is allocated already or it has
+	 * been reserved succesfully. so, user may use it */
+	__set_page_dirty_nobuffers(page);
+
+	SetPageUptodate(page);
+
+	/* correct in-core size,  on-disk size will
+	 * be corrected upon allocation */
+	if (pos > inode->i_size) {
+		i_size_write(inode, pos);
+		mark_inode_dirty(inode);
+	}
+
+	return err;
+}
+
+int ext4_wb_write_single_page(struct page *page,
+					struct writeback_control *wbc)
+{
+	struct inode *inode = page->mapping->host;
+	struct ext4_wb_control wc;
+	int err;
+
+	atomic_inc(&EXT4_I(inode)->i_wb_writers);
+
+#ifdef EXT4_WB_STATS
+	atomic_inc(&EXT4_SB(inode->i_sb)->s_wb_single_pages);
+	if (atomic_read(&EXT4_I(inode)->i_wb_writers) != 1)
+		atomic_inc(&EXT4_SB(inode->i_sb)->s_wb_collisions_sp);
+#endif
+
+	ext4_wb_init_control(&wc, page->mapping);
+
+	BUG_ON(PageWriteback(page));
+	set_page_writeback(page);
+	unlock_page(page);
+
+	wc.start = page->index;
+	wc.len = 1;
+
+	err = ext4_wb_add_page(&wc, page);
+	if (err) {
+		printk(KERN_ERR "EXT4-fs: cant add page at %s:%d - %d\n",
+				__FILE__, __LINE__, err);
+		end_page_writeback(page);
+		return err;
+	}
+	err = ext4_wb_flush(&wc);
+	atomic_dec(&EXT4_I(inode)->i_wb_writers);
+
+	return err;
+}
+
+int ext4_wb_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct inode *inode = page->mapping->host;
+	loff_t i_size = i_size_read(inode);
+	pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
+	unsigned offset;
+	void *kaddr;
+
+	wb_debug("writepage %lu from inode %lu\n", page->index, inode->i_ino);
+
+	/* 
+	 * FIXME: just to play ...
+	 * If another thread is writing inode's data and the page
+	 * hasn't space on a disk yet, leave it for that thread
+	 */
+#if 1
+	if (atomic_read(&EXT4_I(page->mapping->host)->i_wb_writers)
+			&& !PageMappedToDisk(page)) {
+		__set_page_dirty_nobuffers(page);
+		unlock_page(page);
+		return 0;
+	}
+#endif
+
+	/* we give up here if we're reentered, because
+	 * it might be for a different filesystem  */
+	if (ext4_journal_current_handle()) {
+		__set_page_dirty_nobuffers(page);
+		unlock_page(page);
+		return 0;
+	}
+
+	/* Is the page fully inside i_size? */
+	if (page->index < end_index)
+		return ext4_wb_write_single_page(page, wbc);
+
+	/* Is the page fully outside i_size? (truncate in progress) */
+	offset = i_size & (PAGE_CACHE_SIZE-1);
+	if (page->index >= end_index + 1 || !offset) {
+		/*
+		 * The page may have dirty, unmapped buffers.  For example,
+		 * they may have been added in ext4_writepage().  Make them
+		 * freeable here, so the page does not leak.
+		 */
+		ext4_wb_invalidatepage(page, 0);
+		unlock_page(page);
+		return 0; /* don't care */
+	}
+
+	/*
+	 * The page straddles i_size.  It must be zeroed out on each and every
+	 * writepage invocation because it may be mmapped.  "A file is mapped
+	 * in multiples of the page size.  For a file that is not a multiple of
+	 * the  page size, the remaining memory is zeroed when mapped, and
+	 * writes to that region are not written out to the file."
+	 */
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
+	flush_dcache_page(page);
+	kunmap_atomic(kaddr, KM_USER0);
+	return ext4_wb_write_single_page(page, wbc);
+}
+
+int ext4_wb_releasepage(struct page *page, gfp_t wait)
+{
+	wb_debug("release %sM%sR page %lu from inode %lu (wait %d)\n",
+			PageMappedToDisk(page) ? "" : "!",
+			PageBooked(page) ? "" : "!", 
+			page->index, page->mapping->host->i_ino, wait);
+
+	if (PageWriteback(page))
+		return 0;
+
+	if (PagePrivate(page))
+		ClearPagePrivate(page);
+	return 0;
+}
+
+void ext4_wb_invalidatepage(struct page *page, unsigned long offset)
+{
+	struct inode *inode = page->mapping->host;
+	int ret = 0;
+
+	/* ->invalidatepage() is called when page is marked Private.
+	 * for our page being Private mean that space has been 
+	 * reserved for this page and it is being truncated. so,
+	 * it's time to drop reservation */
+	wb_debug("invalidate %sM%sR page %lu from inode %lu (offset %lu)\n",
+			PageMappedToDisk(page) ? "" : "!",
+			PageBooked(page) ? "" : "!",
+			page->index, inode->i_ino, offset);
+
+	if (offset == 0) {
+		if (PageBooked(page)) {
+			atomic_inc(&EXT4_SB(inode->i_sb)->s_wb_dropped);
+			ext4_wb_release_space(inode, 1, 0);
+			ext4_wb_drop_page_reservation(page);
+		}
+		ret = try_to_release_page(page, 0);
+	}
+	return;
+}
+
+int ext4_wb_block_truncate_page(handle_t *handle, struct page *page,
+				struct address_space *mapping, loff_t from)
+{
+	unsigned offset = from & (PAGE_CACHE_SIZE-1);
+	struct inode *inode = mapping->host;
+	struct buffer_head bh, *bhw = &bh;
+	unsigned blocksize, length;
+	void *kaddr;
+	int err = 0;
+
+	wb_debug("partial truncate from %lu on page %lu from inode %lu\n",
+			(unsigned long) from, page->index, inode->i_ino);
+
+	blocksize = inode->i_sb->s_blocksize;
+	length = blocksize - (offset & (blocksize - 1));
+
+	/* if page isn't uptodate we have to check has it assigned block
+	 * if it has then that block is to be read before memset() */
+	if (!PageUptodate(page)) {
+		BUG_ON(PageMappedToDisk(page));
+		bh.b_state = 0;
+		err = ext4_get_block(inode, page->index, bhw, 0);
+		if (err)
+			goto err_out;
+		BUG_ON(buffer_new(bhw));
+		if (buffer_mapped(bhw)) {
+			/* time to retrieve data from a disk */
+			wb_debug("read block %u for part.trunc on %lu\n",
+					(unsigned) bhw->b_blocknr, page->index);
+			set_bh_page(bhw, page, 0);
+			bhw->b_this_page = 0;
+			bhw->b_size = 1 << inode->i_blkbits;
+			atomic_set(&bhw->b_count, 1);
+			ll_rw_block(READ, 1, &bhw);
+			wait_on_buffer(bhw);
+			err = -EIO;
+			if (!buffer_uptodate(bhw))
+				goto err_out;
+			SetPageMappedToDisk(page);
+		} else {
+			wb_debug("zero page %lu (part.trunc)\n", page->index);
+			offset = 0;
+			length = blocksize;
+		}
+	}
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + offset, 0, length);
+	flush_dcache_page(page);
+	kunmap_atomic(kaddr, KM_USER0);
+	SetPageUptodate(page);
+	__set_page_dirty_nobuffers(page);
+
+err_out:
+	unlock_page(page);
+	page_cache_release(page);
+	return err;
+}
+
+void ext4_wb_init(struct super_block *sb)
+{
+	if (!test_opt(sb, DELAYED_ALLOC))
+		return;
+
+	if (PAGE_CACHE_SHIFT != sb->s_blocksize_bits) {
+		printk(KERN_ERR "EXT4-fs: delayed allocation isn't"
+			"supported for PAGE_CACHE_SIZE != blocksize yet\n");
+		clear_opt (EXT4_SB(sb)->s_mount_opt, DELAYED_ALLOC);
+		return;
+	}
+	printk("EXT4-fs: delayed allocation enabled\n");
+}
+
+void ext4_wb_release(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (!test_opt(sb, DELAYED_ALLOC))
+		return;
+
+#ifdef EXT4_WB_STATS
+	if (atomic_read(&sbi->s_wb_reqs) == 0)
+		return;
+
+	printk("EXT4-fs: writeback: %d blocks %d extents in %d reqs (%d ave)\n",
+		atomic_read(&sbi->s_wb_blocks),
+		atomic_read(&sbi->s_wb_extents),
+		atomic_read(&sbi->s_wb_reqs),
+		atomic_read(&sbi->s_wb_blocks) / atomic_read(&sbi->s_wb_reqs));
+	printk("EXT4-fs: writeback: %d nr_to_write, %d congestions, %d singles\n",
+		atomic_read(&sbi->s_wb_nr_to_write),
+		atomic_read(&sbi->s_wb_congested),
+		atomic_read(&sbi->s_wb_single_pages));
+	printk("EXT4-fs: writeback: %d collisions, %d single-page collisions\n",
+		atomic_read(&sbi->s_wb_collisions),
+		atomic_read(&sbi->s_wb_collisions_sp));
+	printk("EXT4-fs: writeback: %d allocated, %d dropped\n",
+		atomic_read(&sbi->s_wb_allocated),
+		atomic_read(&sbi->s_wb_dropped));
+#endif
+}
+
Index: linux-2.6.20-rc1/fs/ext4/file.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/file.c	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/file.c	2006-12-22 22:56:04.000000000 +0300
@@ -35,8 +35,8 @@ static int ext4_release_file (struct ino
 {
 	/* if we are the last writer on the inode, drop the block reservation */
 	if ((filp->f_mode & FMODE_WRITE) &&
-			(atomic_read(&inode->i_writecount) == 1))
-	{
+			(atomic_read(&inode->i_writecount) == 1) &&
+			EXT4_I(inode)->i_blocks_reserved == 0) {
 		mutex_lock(&EXT4_I(inode)->truncate_mutex);
 		ext4_discard_reservation(inode);
 		mutex_unlock(&EXT4_I(inode)->truncate_mutex);
Index: linux-2.6.20-rc1/fs/ext4/inode.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/inode.c	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/inode.c	2006-12-22 22:56:04.000000000 +0300
@@ -943,7 +943,7 @@ out:
 
 #define DIO_CREDITS (EXT4_RESERVE_TRANS_BLOCKS + 32)
 
-static int ext4_get_block(struct inode *inode, sector_t iblock,
+int ext4_get_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	handle_t *handle = journal_current_handle();
@@ -1807,9 +1807,34 @@ static const struct address_space_operat
 	.releasepage	= ext4_releasepage,
 };
 
+static int ext4_wb_set_page_dirty(struct page *page)
+{
+	return __set_page_dirty_nobuffers(page);
+}
+
+static struct address_space_operations ext4_writeback_da_aops = {
+	.readpage	= ext4_readpage,
+	.readpages	= ext4_readpages,
+	.writepage	= ext4_wb_writepage,
+	.writepages	= ext4_wb_writepages,
+	.sync_page	= block_sync_page,
+	.prepare_write	= ext4_wb_prepare_write,
+	.commit_write	= ext4_wb_commit_write,
+	.bmap		= ext4_bmap,
+	.invalidatepage	= ext4_wb_invalidatepage,
+	.releasepage	= ext4_wb_releasepage,
+	.set_page_dirty	= ext4_wb_set_page_dirty,
+	.direct_IO	= ext4_direct_IO,
+};
+
 void ext4_set_aops(struct inode *inode)
 {
-	if (ext4_should_order_data(inode))
+	if (S_ISREG(inode->i_mode) && 
+			(EXT4_I(inode)->i_flags & EXT4_EXTENTS_FL) &&
+			test_opt(inode->i_sb, EXTENTS) &&
+			test_opt(inode->i_sb, DELAYED_ALLOC))
+		inode->i_mapping->a_ops = &ext4_writeback_da_aops;
+	else if (ext4_should_order_data(inode))
 		inode->i_mapping->a_ops = &ext4_ordered_aops;
 	else if (ext4_should_writeback_data(inode))
 		inode->i_mapping->a_ops = &ext4_writeback_aops;
@@ -1834,6 +1859,11 @@ int ext4_block_truncate_page(handle_t *h
 	int err = 0;
 	void *kaddr;
 
+	if ((EXT4_I(inode)->i_flags & EXT4_EXTENTS_FL) &&
+			test_opt(inode->i_sb, EXTENTS) &&
+			test_opt(inode->i_sb, DELAYED_ALLOC))
+		return ext4_wb_block_truncate_page(handle, page, mapping, from);
+
 	blocksize = inode->i_sb->s_blocksize;
 	length = blocksize - (offset & (blocksize - 1));
 	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
