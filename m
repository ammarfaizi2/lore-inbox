Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVBRXTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVBRXTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBRXTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:19:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:63919 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261537AbVBRXTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:19:37 -0500
Subject: [PATCH] Add nobh_writepage() support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-seMb+w2ZTbwD5NMj6y+b"
Organization: 
Message-Id: <1108768782.20053.1779.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Feb 2005 15:19:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-seMb+w2ZTbwD5NMj6y+b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the patch to add nobh_wripage() support for the filesystems
which uses nobh_prepare_write/nobh_commit_write().

Idea here is to reduce unnecessary bufferhead creation/attachment
to the page through block_write_full_page(). nobh_wripage() tries 
to operate by directly creating bios, but it falls back to 
__block_write_full_page() if it can't make progress.

Note that this is not really generic routine and can't be used
for filesystems which uses page->Private for anything other
than buffer heads.

BTW, my next set of patches are to add ext3_writepages() support
for writeback mode and to add "nobh" support for ext3 writeback 
mode - which are based on some of this work (These are already 
discussed on ext2-devel).

And also, this needs some airtime in -mm tree before hitting mainline.

Thanks,
Badari





--=-seMb+w2ZTbwD5NMj6y+b
Content-Disposition: attachment; filename=nobh_writepage.patch2
Content-Type: text/plain; name=nobh_writepage.patch2; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
diff -Narup -X dontdiff linux-2.6.10/fs/buffer.c linux-2.6.10.nobh/fs/buffer.c
--- linux-2.6.10/fs/buffer.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10.nobh/fs/buffer.c	2005-02-18 14:52:20.707345056 -0800
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/bitops.h>
+#include <linux/mpage.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
@@ -2492,6 +2493,62 @@ int nobh_commit_write(struct file *file,
 EXPORT_SYMBOL(nobh_commit_write);
 
 /*
+ * nobh_writepage() - based on block_full_write_page() except
+ * that it tries to operate without attaching bufferheads to
+ * the page.
+ */
+int nobh_writepage(struct page *page, get_block_t *get_block,
+			struct writeback_control *wbc)
+{
+	struct inode * const inode = page->mapping->host;
+	loff_t i_size = i_size_read(inode);
+	const pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
+	unsigned offset;
+	void *kaddr;
+	int ret;
+
+	/* Is the page fully inside i_size? */
+	if (page->index < end_index) {
+		goto out;
+	}
+
+	/* Is the page fully outside i_size? (truncate in progress) */
+	offset = i_size & (PAGE_CACHE_SIZE-1);
+	if (page->index >= end_index+1 || !offset) {
+		/*
+		 * The page may have dirty, unmapped buffers.  For example,
+		 * they may have been added in ext3_writepage().  Make them
+		 * freeable here, so the page does not leak.
+		 */
+#if 0
+		/* Not really sure about this  - do we need this ? */
+		if (page->mapping->a_ops->invalidatepage)
+			page->mapping->a_ops->invalidatepage(page, offset);
+#endif
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
+out:
+	ret = mpage_writepage(page, get_block, wbc);
+	if (ret == -EAGAIN)
+		ret = __block_write_full_page(inode, page, get_block, wbc);
+	return ret;
+}
+EXPORT_SYMBOL(nobh_writepage);
+
+/*
  * This function assumes that ->prepare_write() uses nobh_prepare_write().
  */
 int nobh_truncate_page(struct address_space *mapping, loff_t from)
diff -Narup -X dontdiff linux-2.6.10/fs/ext2/inode.c linux-2.6.10.nobh/fs/ext2/inode.c
--- linux-2.6.10/fs/ext2/inode.c	2004-12-24 13:33:51.000000000 -0800
+++ linux-2.6.10.nobh/fs/ext2/inode.c	2005-02-16 16:27:32.000000000 -0800
@@ -626,6 +626,12 @@ ext2_nobh_prepare_write(struct file *fil
 	return nobh_prepare_write(page,from,to,ext2_get_block);
 }
 
+static int ext2_nobh_writepage(struct page *page, 
+			struct writeback_control *wbc)
+{
+	return nobh_writepage(page, ext2_get_block, wbc);
+}
+
 static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
@@ -675,7 +681,7 @@ struct address_space_operations ext2_aop
 struct address_space_operations ext2_nobh_aops = {
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
-	.writepage		= ext2_writepage,
+	.writepage		= ext2_nobh_writepage,
 	.sync_page		= block_sync_page,
 	.prepare_write		= ext2_nobh_prepare_write,
 	.commit_write		= nobh_commit_write,
diff -Narup -X dontdiff linux-2.6.10/fs/jfs/inode.c linux-2.6.10.nobh/fs/jfs/inode.c
--- linux-2.6.10/fs/jfs/inode.c	2004-12-24 13:33:48.000000000 -0800
+++ linux-2.6.10.nobh/fs/jfs/inode.c	2005-02-16 16:27:42.000000000 -0800
@@ -281,7 +281,7 @@ static int jfs_get_block(struct inode *i
 
 static int jfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	return block_write_full_page(page, jfs_get_block, wbc);
+	return nobh_writepage(page, jfs_get_block, wbc);
 }
 
 static int jfs_writepages(struct address_space *mapping,
diff -Narup -X dontdiff linux-2.6.10/fs/mpage.c linux-2.6.10.nobh/fs/mpage.c
--- linux-2.6.10/fs/mpage.c	2004-12-24 13:34:26.000000000 -0800
+++ linux-2.6.10.nobh/fs/mpage.c	2005-02-18 14:52:30.783813200 -0800
@@ -386,8 +386,9 @@ EXPORT_SYMBOL(mpage_readpage);
  * just allocate full-size (16-page) BIOs.
  */
 static struct bio *
-mpage_writepage(struct bio *bio, struct page *page, get_block_t get_block,
-	sector_t *last_block_in_bio, int *ret, struct writeback_control *wbc)
+__mpage_writepage(struct bio *bio, struct page *page, get_block_t get_block,
+	sector_t *last_block_in_bio, int *ret, struct writeback_control *wbc,
+	writepage_t writepage_helper)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = page->mapping->host;
@@ -580,7 +581,13 @@ alloc_new:
 confused:
 	if (bio)
 		bio = mpage_bio_submit(WRITE, bio);
-	*ret = page->mapping->a_ops->writepage(page, wbc);
+
+	if (writepage_helper)
+		*ret = writepage_helper(page, wbc);
+	else {
+		*ret = -EAGAIN;
+		goto out;
+	}
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
@@ -706,8 +713,9 @@ retry:
 							&mapping->flags);
 				}
 			} else {
-				bio = mpage_writepage(bio, page, get_block,
-						&last_block_in_bio, &ret, wbc);
+				bio = __mpage_writepage(bio, page, get_block,
+						&last_block_in_bio, &ret, wbc, 
+						page->mapping->a_ops->writepage);
 			}
 			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
@@ -734,4 +742,21 @@ retry:
 		mpage_bio_submit(WRITE, bio);
 	return ret;
 }
+
+int
+mpage_writepage(struct page *page, get_block_t get_block,
+	struct writeback_control *wbc)
+{
+	int ret = 0;
+	struct bio *bio = NULL;
+	sector_t last_block_in_bio = 0;
+
+	bio = __mpage_writepage(bio, page, get_block,
+			&last_block_in_bio, &ret, wbc, NULL);
+	if (bio)
+		mpage_bio_submit(WRITE, bio);
+
+	return ret;
+}
+
 EXPORT_SYMBOL(mpage_writepages);
diff -Narup -X dontdiff linux-2.6.10/include/linux/buffer_head.h linux-2.6.10.nobh/include/linux/buffer_head.h
--- linux-2.6.10/include/linux/buffer_head.h	2004-12-24 13:33:49.000000000 -0800
+++ linux-2.6.10.nobh/include/linux/buffer_head.h	2005-02-16 16:22:51.000000000 -0800
@@ -203,6 +203,9 @@ int file_fsync(struct file *, struct den
 int nobh_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 int nobh_commit_write(struct file *, struct page *, unsigned, unsigned);
 int nobh_truncate_page(struct address_space *, loff_t);
+int nobh_writepage(struct page *page, get_block_t *get_block,
+                        struct writeback_control *wbc);
+
 
 /*
  * inline definitions
diff -Narup -X dontdiff linux-2.6.10/include/linux/mpage.h linux-2.6.10.nobh/include/linux/mpage.h
--- linux-2.6.10/include/linux/mpage.h	2004-12-24 13:34:32.000000000 -0800
+++ linux-2.6.10.nobh/include/linux/mpage.h	2005-02-17 17:34:24.913837456 -0800
@@ -11,12 +11,15 @@
  */
 
 struct writeback_control;
+typedef int (writepage_t)(struct page *page, struct writeback_control *wbc);
 
 int mpage_readpages(struct address_space *mapping, struct list_head *pages,
 				unsigned nr_pages, get_block_t get_block);
 int mpage_readpage(struct page *page, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block);
+int mpage_writepage(struct page *page, get_block_t *get_block,
+		struct writeback_control *wbc);
 
 static inline int
 generic_writepages(struct address_space *mapping, struct writeback_control *wbc)

--=-seMb+w2ZTbwD5NMj6y+b--

