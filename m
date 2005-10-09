Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVJIFzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVJIFzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 01:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVJIFzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 01:55:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42131 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932220AbVJIFzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 01:55:54 -0400
Date: Sun, 9 Oct 2005 06:55:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: [RFC] gfp flags annotations - part 6 (simple parts of fs/*)
Message-ID: <20051009055549.GK7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	- ->releasepage() annotated (s/int/gfp_t), instances updated
	- missing gfp_t in fs/* added
	- fixed misannotation from the first part caught by bitwise checks -
XFS used __nocast both for gfp_t and for flags used by XFS allocator.  The
latter left with unsigned int __nocast; we might want to add a different
type for those but for now let's leave them alone.  That, BTW, is a case
when __nocast use had been actively confusing - it had been used in the
same code for two different and similar types, with no way to catch misuses.
Switch of gfp_t to bitwise had caught that immediately...

	One tricky bit is left alone to be dealt with later - mapping->flags
is a mix of gfp_t and error indications.  Left alone for now.

	A bug had been caught in relayfs code -
        mem = vmap(buf->page_array, n_pages, GFP_KERNEL, PAGE_KERNEL);
in fs/relayfs/buffers.c is bogus (the third argument of vmap() is unrelated
to gfp flags).  s/GFP_KERNEL/VM_MAP/, presumably?  Author Cc'd, code in
question left alone for now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN net/fs/afs/file.c fs/fs/afs/file.c
--- net/fs/afs/file.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/afs/file.c	2005-10-09 01:23:29.000000000 -0400
@@ -29,7 +29,7 @@
 
 static int afs_file_readpage(struct file *file, struct page *page);
 static int afs_file_invalidatepage(struct page *page, unsigned long offset);
-static int afs_file_releasepage(struct page *page, int gfp_flags);
+static int afs_file_releasepage(struct page *page, gfp_t gfp_flags);
 
 static ssize_t afs_file_write(struct file *file, const char __user *buf,
 			      size_t size, loff_t *off);
@@ -279,7 +279,7 @@
 /*
  * release a page and cleanup its private data
  */
-static int afs_file_releasepage(struct page *page, int gfp_flags)
+static int afs_file_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	struct cachefs_page *pageio;
 
diff -urN net/fs/bio.c fs/fs/bio.c
--- net/fs/bio.c	2005-10-08 21:04:47.000000000 -0400
+++ fs/fs/bio.c	2005-10-09 01:23:29.000000000 -0400
@@ -778,7 +778,7 @@
 
 
 static struct bio *__bio_map_kern(request_queue_t *q, void *data,
-				  unsigned int len, unsigned int gfp_mask)
+				  unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -825,7 +825,7 @@
  *	device. Returns an error pointer in case of error.
  */
 struct bio *bio_map_kern(request_queue_t *q, void *data, unsigned int len,
-			 unsigned int gfp_mask)
+			 gfp_t gfp_mask)
 {
 	struct bio *bio;
 
diff -urN net/fs/buffer.c fs/fs/buffer.c
--- net/fs/buffer.c	2005-10-09 01:20:14.000000000 -0400
+++ fs/fs/buffer.c	2005-10-09 01:23:29.000000000 -0400
@@ -1571,7 +1571,7 @@
  *
  * NOTE: @gfp_mask may go away, and this function may become non-blocking.
  */
-int try_to_release_page(struct page *page, int gfp_mask)
+int try_to_release_page(struct page *page, gfp_t gfp_mask)
 {
 	struct address_space * const mapping = page->mapping;
 
diff -urN net/fs/dcache.c fs/fs/dcache.c
--- net/fs/dcache.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/dcache.c	2005-10-09 01:23:29.000000000 -0400
@@ -689,7 +689,7 @@
  *
  * In this case we return -1 to tell the caller that we baled.
  */
-static int shrink_dcache_memory(int nr, unsigned int gfp_mask)
+static int shrink_dcache_memory(int nr, gfp_t gfp_mask)
 {
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
diff -urN net/fs/dquot.c fs/fs/dquot.c
--- net/fs/dquot.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/dquot.c	2005-10-09 01:23:29.000000000 -0400
@@ -500,7 +500,7 @@
  * more memory
  */
 
-static int shrink_dqcache_memory(int nr, unsigned int gfp_mask)
+static int shrink_dqcache_memory(int nr, gfp_t gfp_mask)
 {
 	if (nr) {
 		spin_lock(&dq_list_lock);
diff -urN net/fs/ext3/inode.c fs/fs/ext3/inode.c
--- net/fs/ext3/inode.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/ext3/inode.c	2005-10-09 01:23:29.000000000 -0400
@@ -1434,7 +1434,7 @@
 	return journal_invalidatepage(journal, page, offset);
 }
 
-static int ext3_releasepage(struct page *page, int wait)
+static int ext3_releasepage(struct page *page, gfp_t wait)
 {
 	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
 
diff -urN net/fs/hfs/inode.c fs/fs/hfs/inode.c
--- net/fs/hfs/inode.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/hfs/inode.c	2005-10-09 01:23:29.000000000 -0400
@@ -46,7 +46,7 @@
 	return generic_block_bmap(mapping, block, hfs_get_block);
 }
 
-static int hfs_releasepage(struct page *page, int mask)
+static int hfs_releasepage(struct page *page, gfp_t mask)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
diff -urN net/fs/hfsplus/inode.c fs/fs/hfsplus/inode.c
--- net/fs/hfsplus/inode.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/hfsplus/inode.c	2005-10-09 01:23:29.000000000 -0400
@@ -40,7 +40,7 @@
 	return generic_block_bmap(mapping, block, hfsplus_get_block);
 }
 
-static int hfsplus_releasepage(struct page *page, int mask)
+static int hfsplus_releasepage(struct page *page, gfp_t mask)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
diff -urN net/fs/inode.c fs/fs/inode.c
--- net/fs/inode.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/inode.c	2005-10-09 01:23:29.000000000 -0400
@@ -475,7 +475,7 @@
  * This function is passed the number of inodes to scan, and it returns the
  * total number of remaining possibly-reclaimable inodes.
  */
-static int shrink_icache_memory(int nr, unsigned int gfp_mask)
+static int shrink_icache_memory(int nr, gfp_t gfp_mask)
 {
 	if (nr) {
 		/*
diff -urN net/fs/jbd/journal.c fs/fs/jbd/journal.c
--- net/fs/jbd/journal.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/jbd/journal.c	2005-10-09 01:23:29.000000000 -0400
@@ -1606,7 +1606,7 @@
  * Simple support for retrying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies. 
  */
-void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry)
+void * __jbd_kmalloc (const char *where, size_t size, gfp_t flags, int retry)
 {
 	return kmalloc(size, flags | (retry ? __GFP_NOFAIL : 0));
 }
diff -urN net/fs/jbd/transaction.c fs/fs/jbd/transaction.c
--- net/fs/jbd/transaction.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/jbd/transaction.c	2005-10-09 01:23:29.000000000 -0400
@@ -1621,7 +1621,7 @@
  * while the data is part of a transaction.  Yes?
  */
 int journal_try_to_free_buffers(journal_t *journal, 
-				struct page *page, int unused_gfp_mask)
+				struct page *page, gfp_t unused_gfp_mask)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
diff -urN net/fs/jfs/jfs_metapage.c fs/fs/jfs/jfs_metapage.c
--- net/fs/jfs/jfs_metapage.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/jfs/jfs_metapage.c	2005-10-09 01:23:29.000000000 -0400
@@ -198,7 +198,7 @@
 	}
 }
 
-static inline struct metapage *alloc_metapage(unsigned int gfp_mask)
+static inline struct metapage *alloc_metapage(gfp_t gfp_mask)
 {
 	return mempool_alloc(metapage_mempool, gfp_mask);
 }
@@ -534,7 +534,7 @@
 	return -EIO;
 }
 
-static int metapage_releasepage(struct page *page, int gfp_mask)
+static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct metapage *mp;
 	int busy = 0;
diff -urN net/fs/mbcache.c fs/fs/mbcache.c
--- net/fs/mbcache.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/mbcache.c	2005-10-09 01:23:29.000000000 -0400
@@ -116,7 +116,7 @@
  * What the mbcache registers as to get shrunk dynamically.
  */
 
-static int mb_cache_shrink_fn(int nr_to_scan, unsigned int gfp_mask);
+static int mb_cache_shrink_fn(int nr_to_scan, gfp_t gfp_mask);
 
 
 static inline int
@@ -140,7 +140,7 @@
 
 
 static inline void
-__mb_cache_entry_forget(struct mb_cache_entry *ce, int gfp_mask)
+__mb_cache_entry_forget(struct mb_cache_entry *ce, gfp_t gfp_mask)
 {
 	struct mb_cache *cache = ce->e_cache;
 
@@ -193,7 +193,7 @@
  * Returns the number of objects which are present in the cache.
  */
 static int
-mb_cache_shrink_fn(int nr_to_scan, unsigned int gfp_mask)
+mb_cache_shrink_fn(int nr_to_scan, gfp_t gfp_mask)
 {
 	LIST_HEAD(free_list);
 	struct list_head *l, *ltmp;
diff -urN net/fs/reiserfs/fix_node.c fs/fs/reiserfs/fix_node.c
--- net/fs/reiserfs/fix_node.c	2005-09-22 14:50:51.000000000 -0400
+++ fs/fs/reiserfs/fix_node.c	2005-10-09 01:23:29.000000000 -0400
@@ -2022,7 +2022,7 @@
 }
 
 #ifdef CONFIG_REISERFS_CHECK
-void *reiserfs_kmalloc(size_t size, int flags, struct super_block *s)
+void *reiserfs_kmalloc(size_t size, gfp_t flags, struct super_block *s)
 {
 	void *vp;
 	static size_t malloced;
diff -urN net/fs/reiserfs/inode.c fs/fs/reiserfs/inode.c
--- net/fs/reiserfs/inode.c	2005-09-22 14:50:52.000000000 -0400
+++ fs/fs/reiserfs/inode.c	2005-10-09 01:23:29.000000000 -0400
@@ -2842,7 +2842,7 @@
  * even in -o notail mode, we can't be sure an old mount without -o notail
  * didn't create files with tails.
  */
-static int reiserfs_releasepage(struct page *page, int unused_gfp_flags)
+static int reiserfs_releasepage(struct page *page, gfp_t unused_gfp_flags)
 {
 	struct inode *inode = page->mapping->host;
 	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
diff -urN net/fs/xfs/linux-2.6/kmem.c fs/fs/xfs/linux-2.6/kmem.c
--- net/fs/xfs/linux-2.6/kmem.c	2005-10-08 21:04:47.000000000 -0400
+++ fs/fs/xfs/linux-2.6/kmem.c	2005-10-09 01:23:29.000000000 -0400
@@ -45,11 +45,11 @@
 
 
 void *
-kmem_alloc(size_t size, gfp_t flags)
+kmem_alloc(size_t size, unsigned int __nocast flags)
 {
-	int		retries = 0;
-	unsigned int	lflags = kmem_flags_convert(flags);
-	void		*ptr;
+	int	retries = 0;
+	gfp_t	lflags = kmem_flags_convert(flags);
+	void	*ptr;
 
 	do {
 		if (size < MAX_SLAB_SIZE || retries > MAX_VMALLOCS)
@@ -67,7 +67,7 @@
 }
 
 void *
-kmem_zalloc(size_t size, gfp_t flags)
+kmem_zalloc(size_t size, unsigned int __nocast flags)
 {
 	void	*ptr;
 
@@ -90,7 +90,7 @@
 
 void *
 kmem_realloc(void *ptr, size_t newsize, size_t oldsize,
-	     gfp_t flags)
+	     unsigned int __nocast flags)
 {
 	void	*new;
 
@@ -105,11 +105,11 @@
 }
 
 void *
-kmem_zone_alloc(kmem_zone_t *zone, gfp_t flags)
+kmem_zone_alloc(kmem_zone_t *zone, unsigned int __nocast flags)
 {
-	int		retries = 0;
-	unsigned int	lflags = kmem_flags_convert(flags);
-	void		*ptr;
+	int	retries = 0;
+	gfp_t	lflags = kmem_flags_convert(flags);
+	void	*ptr;
 
 	do {
 		ptr = kmem_cache_alloc(zone, lflags);
@@ -124,7 +124,7 @@
 }
 
 void *
-kmem_zone_zalloc(kmem_zone_t *zone, gfp_t flags)
+kmem_zone_zalloc(kmem_zone_t *zone, unsigned int __nocast flags)
 {
 	void	*ptr;
 
diff -urN net/fs/xfs/linux-2.6/kmem.h fs/fs/xfs/linux-2.6/kmem.h
--- net/fs/xfs/linux-2.6/kmem.h	2005-10-08 21:04:47.000000000 -0400
+++ fs/fs/xfs/linux-2.6/kmem.h	2005-10-09 01:23:29.000000000 -0400
@@ -81,9 +81,9 @@
 	*(NSTATEP) = *(OSTATEP);	\
 } while (0)
 
-static __inline unsigned int kmem_flags_convert(gfp_t flags)
+static __inline gfp_t kmem_flags_convert(unsigned int __nocast flags)
 {
-	unsigned int	lflags = __GFP_NOWARN;	/* we'll report problems, if need be */
+	gfp_t lflags = __GFP_NOWARN;	/* we'll report problems, if need be */
 
 #ifdef DEBUG
 	if (unlikely(flags & ~(KM_SLEEP|KM_NOSLEEP|KM_NOFS|KM_MAYFAIL))) {
@@ -125,16 +125,16 @@
 		BUG();
 }
 
-extern void	    *kmem_zone_zalloc(kmem_zone_t *, gfp_t);
-extern void	    *kmem_zone_alloc(kmem_zone_t *, gfp_t);
+extern void	    *kmem_zone_zalloc(kmem_zone_t *, unsigned int __nocast);
+extern void	    *kmem_zone_alloc(kmem_zone_t *, unsigned int __nocast);
 
-extern void	    *kmem_alloc(size_t, gfp_t);
-extern void	    *kmem_realloc(void *, size_t, size_t, gfp_t);
-extern void	    *kmem_zalloc(size_t, gfp_t);
+extern void	    *kmem_alloc(size_t, unsigned int __nocast);
+extern void	    *kmem_realloc(void *, size_t, size_t, unsigned int __nocast);
+extern void	    *kmem_zalloc(size_t, unsigned int __nocast);
 extern void         kmem_free(void *, size_t);
 
 typedef struct shrinker *kmem_shaker_t;
-typedef int (*kmem_shake_func_t)(int, unsigned int);
+typedef int (*kmem_shake_func_t)(int, gfp_t);
 
 static __inline kmem_shaker_t
 kmem_shake_register(kmem_shake_func_t sfunc)
@@ -149,7 +149,7 @@
 }
 
 static __inline int
-kmem_shake_allow(unsigned int gfp_mask)
+kmem_shake_allow(gfp_t gfp_mask)
 {
 	return (gfp_mask & __GFP_WAIT);
 }
diff -urN net/fs/xfs/linux-2.6/xfs_aops.c fs/fs/xfs/linux-2.6/xfs_aops.c
--- net/fs/xfs/linux-2.6/xfs_aops.c	2005-09-22 14:50:52.000000000 -0400
+++ fs/fs/xfs/linux-2.6/xfs_aops.c	2005-10-09 01:23:29.000000000 -0400
@@ -1296,7 +1296,7 @@
 STATIC int
 linvfs_release_page(
 	struct page		*page,
-	int			gfp_mask)
+	gfp_t			gfp_mask)
 {
 	struct inode		*inode = page->mapping->host;
 	int			dirty, delalloc, unmapped, unwritten;
diff -urN net/fs/xfs/linux-2.6/xfs_buf.c fs/fs/xfs/linux-2.6/xfs_buf.c
--- net/fs/xfs/linux-2.6/xfs_buf.c	2005-09-22 14:50:52.000000000 -0400
+++ fs/fs/xfs/linux-2.6/xfs_buf.c	2005-10-09 01:23:29.000000000 -0400
@@ -64,7 +64,7 @@
 
 STATIC kmem_cache_t *pagebuf_zone;
 STATIC kmem_shaker_t pagebuf_shake;
-STATIC int xfsbufd_wakeup(int, unsigned int);
+STATIC int xfsbufd_wakeup(int, gfp_t);
 STATIC void pagebuf_delwri_queue(xfs_buf_t *, int);
 
 STATIC struct workqueue_struct *xfslogd_workqueue;
@@ -383,7 +383,7 @@
 	size_t			blocksize = bp->pb_target->pbr_bsize;
 	size_t			size = bp->pb_count_desired;
 	size_t			nbytes, offset;
-	int			gfp_mask = pb_to_gfp(flags);
+	gfp_t			gfp_mask = pb_to_gfp(flags);
 	unsigned short		page_count, i;
 	pgoff_t			first;
 	loff_t			end;
@@ -1749,8 +1749,8 @@
 
 STATIC int
 xfsbufd_wakeup(
-	int			priority,
-	unsigned int		mask)
+	int		priority,
+	gfp_t		mask)
 {
 	if (xfsbufd_force_sleep)
 		return 0;
diff -urN net/include/linux/bio.h fs/include/linux/bio.h
--- net/include/linux/bio.h	2005-10-08 21:04:47.000000000 -0400
+++ fs/include/linux/bio.h	2005-10-09 01:23:29.000000000 -0400
@@ -301,7 +301,7 @@
 				    struct sg_iovec *, int, int);
 extern void bio_unmap_user(struct bio *);
 extern struct bio *bio_map_kern(struct request_queue *, void *, unsigned int,
-				unsigned int);
+				gfp_t);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 extern struct bio *bio_copy_user(struct request_queue *, unsigned long, unsigned int, int);
diff -urN net/include/linux/buffer_head.h fs/include/linux/buffer_head.h
--- net/include/linux/buffer_head.h	2005-10-08 21:04:47.000000000 -0400
+++ fs/include/linux/buffer_head.h	2005-10-09 01:23:29.000000000 -0400
@@ -188,7 +188,7 @@
  * Generic address_space_operations implementations for buffer_head-backed
  * address_spaces.
  */
-int try_to_release_page(struct page * page, int gfp_mask);
+int try_to_release_page(struct page * page, gfp_t gfp_mask);
 int block_invalidatepage(struct page *page, unsigned long offset);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
diff -urN net/include/linux/fs.h fs/include/linux/fs.h
--- net/include/linux/fs.h	2005-09-22 14:50:53.000000000 -0400
+++ fs/include/linux/fs.h	2005-10-09 01:23:29.000000000 -0400
@@ -320,7 +320,7 @@
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
-	int (*releasepage) (struct page *, int);
+	int (*releasepage) (struct page *, gfp_t);
 	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
diff -urN net/include/linux/jbd.h fs/include/linux/jbd.h
--- net/include/linux/jbd.h	2005-10-08 21:04:47.000000000 -0400
+++ fs/include/linux/jbd.h	2005-10-09 01:23:29.000000000 -0400
@@ -69,7 +69,7 @@
 #define jbd_debug(f, a...)	/**/
 #endif
 
-extern void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry);
+extern void * __jbd_kmalloc (const char *where, size_t size, gfp_t flags, int retry);
 #define jbd_kmalloc(size, flags) \
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), journal_oom_retry)
 #define jbd_rep_kmalloc(size, flags) \
@@ -890,7 +890,7 @@
 extern void	 journal_sync_buffer (struct buffer_head *);
 extern int	 journal_invalidatepage(journal_t *,
 				struct page *, unsigned long);
-extern int	 journal_try_to_free_buffers(journal_t *, struct page *, int);
+extern int	 journal_try_to_free_buffers(journal_t *, struct page *, gfp_t);
 extern int	 journal_stop(handle_t *);
 extern int	 journal_flush (journal_t *);
 extern void	 journal_lock_updates (journal_t *);
diff -urN net/include/linux/mbcache.h fs/include/linux/mbcache.h
--- net/include/linux/mbcache.h	2005-09-22 14:50:53.000000000 -0400
+++ fs/include/linux/mbcache.h	2005-10-09 01:23:29.000000000 -0400
@@ -22,7 +22,7 @@
 };
 
 struct mb_cache_op {
-	int (*free)(struct mb_cache_entry *, int);
+	int (*free)(struct mb_cache_entry *, gfp_t);
 };
 
 /* Functions on caches */
diff -urN net/include/linux/reiserfs_fs.h fs/include/linux/reiserfs_fs.h
--- net/include/linux/reiserfs_fs.h	2005-09-22 14:50:53.000000000 -0400
+++ fs/include/linux/reiserfs_fs.h	2005-10-09 01:23:29.000000000 -0400
@@ -1972,7 +1972,7 @@
 
 /* fix_nodes.c */
 #ifdef CONFIG_REISERFS_CHECK
-void *reiserfs_kmalloc(size_t size, int flags, struct super_block *s);
+void *reiserfs_kmalloc(size_t size, gfp_t flags, struct super_block *s);
 void reiserfs_kfree(const void *vp, size_t size, struct super_block *s);
 #else
 static inline void *reiserfs_kmalloc(size_t size, int flags,
