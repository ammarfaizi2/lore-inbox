Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316388AbSEZVAT>; Sun, 26 May 2002 17:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316383AbSEZVAQ>; Sun, 26 May 2002 17:00:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50704 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316384AbSEZUls>;
	Sun, 26 May 2002 16:41:48 -0400
Message-ID: <3CF14946.5E2EE7D1@zip.com.au>
Date: Sun, 26 May 2002 13:44:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/18] rename writeback_mapping to writepages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Spot the difference:

aops.readpage
aops.readpages
aops.writepage
aops.writeback_mapping

The patch renames `writeback_mapping' to `writepages'



=====================================

--- 2.5.18/fs/block_dev.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/fs/block_dev.c	Sun May 26 02:39:45 2002
@@ -748,7 +748,7 @@ struct address_space_operations def_blk_
 	sync_page: block_sync_page,
 	prepare_write: blkdev_prepare_write,
 	commit_write: blkdev_commit_write,
-	writeback_mapping: generic_writeback_mapping,
+	writepages: generic_writepages,
 	vm_writeback: generic_vm_writeback,
 	direct_IO: blkdev_direct_IO,
 };
--- 2.5.18/fs/buffer.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/fs/buffer.c	Sun May 26 02:39:45 2002
@@ -780,11 +780,11 @@ EXPORT_SYMBOL(sync_mapping_buffers);
  *
  * The private_list buffers generally contain filesystem indirect blocks.
  * The idea is that the filesystem can start I/O against the indirects at
- * the same time as running generic_writeback_mapping(), so the indirect's
+ * the same time as running generic_writepages(), so the indirect's
  * I/O will be merged with the data.
  *
  * We sneakliy write the buffers in probable tail-to-head order.  This is
- * because generic_writeback_mapping writes in probable head-to-tail
+ * because generic_writepages() writes in probable head-to-tail
  * order.  If the file is so huge that the data or the indirects overflow
  * the request queue we will at least get some merging this way.
  *
--- 2.5.18/fs/fs-writeback.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/fs/fs-writeback.c	Sun May 26 02:39:45 2002
@@ -114,13 +114,13 @@ static void write_inode(struct inode *in
  * from *nr_to_write.
  *
  * Normally it is not legal for a single process to lock more than one
- * page at a time, due to ab/ba deadlock problems.  But writeback_mapping()
+ * page at a time, due to ab/ba deadlock problems.  But writepages()
  * does want to lock a large number of pages, without immediately submitting
  * I/O against them (starting I/O is a "deferred unlock_page").
  *
  * However it *is* legal to lock multiple pages, if this is only ever performed
  * by a single process.  We provide that exclusion via locking in the
- * filesystem's ->writeback_mapping a_op. This ensures that only a single
+ * filesystem's ->writepages a_op. This ensures that only a single
  * process is locking multiple pages against this inode.  And as I/O is
  * submitted against all those locked pages, there is no deadlock.
  *
@@ -146,7 +146,7 @@ static void __sync_single_inode(struct i
 	mapping->dirtied_when = 0;	/* assume it's whole-file writeback */
 	spin_unlock(&inode_lock);
 
-	writeback_mapping(mapping, nr_to_write);
+	do_writepages(mapping, nr_to_write);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
--- 2.5.18/fs/ext2/inode.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/fs/ext2/inode.c	Sun May 26 02:39:45 2002
@@ -616,13 +616,13 @@ ext2_direct_IO(int rw, struct inode *ino
 }
 
 static int
-ext2_writeback_mapping(struct address_space *mapping, int *nr_to_write)
+ext2_writepages(struct address_space *mapping, int *nr_to_write)
 {
 	int ret;
 	int err;
 
 	ret = write_mapping_buffers(mapping);
-	err = mpage_writeback_mapping(mapping, nr_to_write, ext2_get_block);
+	err = mpage_writepages(mapping, nr_to_write, ext2_get_block);
 	if (!ret)
 		ret = err;
 	return ret;
@@ -637,7 +637,7 @@ struct address_space_operations ext2_aop
 	commit_write:		generic_commit_write,
 	bmap:			ext2_bmap,
 	direct_IO:		ext2_direct_IO,
-	writeback_mapping:	ext2_writeback_mapping,
+	writepages:		ext2_writepages,
 	vm_writeback:		generic_vm_writeback,
 };
 
--- 2.5.18/fs/mpage.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/fs/mpage.c	Sun May 26 02:39:45 2002
@@ -470,11 +470,11 @@ out:
 }
 
 /*
- * This is a cut-n-paste of generic_writeback_mapping().  We _could_
+ * This is a cut-n-paste of generic_writepages().  We _could_
  * generalise that function.  It'd get a bit messy.  We'll see.
  */
 int
-mpage_writeback_mapping(struct address_space *mapping,
+mpage_writepages(struct address_space *mapping,
 			int *nr_to_write, get_block_t get_block)
 {
 	struct bio *bio = NULL;
@@ -544,4 +544,4 @@ mpage_writeback_mapping(struct address_s
 		mpage_bio_submit(WRITE, bio);
 	return ret;
 }
-EXPORT_SYMBOL(mpage_writeback_mapping);
+EXPORT_SYMBOL(mpage_writepages);
--- 2.5.18/include/linux/fs.h~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/include/linux/fs.h	Sun May 26 02:39:45 2002
@@ -282,7 +282,7 @@ struct address_space_operations {
 	int (*sync_page)(struct page *);
 
 	/* Write back some dirty pages from this mapping. */
-	int (*writeback_mapping)(struct address_space *, int *nr_to_write);
+	int (*writepages)(struct address_space *, int *nr_to_write);
 
 	/* Perform a writeback as a memory-freeing operation. */
 	int (*vm_writeback)(struct page *, int *nr_to_write);
--- 2.5.18/include/linux/mm.h~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/include/linux/mm.h	Sun May 26 02:39:45 2002
@@ -443,7 +443,7 @@ extern int filemap_sync(struct vm_area_s
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
 
 /* mm/page-writeback.c */
-int generic_writeback_mapping(struct address_space *mapping, int *nr_to_write);
+int generic_writepages(struct address_space *mapping, int *nr_to_write);
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
--- 2.5.18/include/linux/writeback.h~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/include/linux/writeback.h	Sun May 26 02:39:45 2002
@@ -47,6 +47,6 @@ static inline void wait_on_inode(struct 
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
-int writeback_mapping(struct address_space *mapping, int *nr_to_write);
+int do_writepages(struct address_space *mapping, int *nr_to_write);
 
 #endif		/* WRITEBACK_H */
--- 2.5.18/include/linux/mpage.h~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/include/linux/mpage.h	Sun May 26 02:39:45 2002
@@ -13,6 +13,6 @@
 int mpage_readpages(struct address_space *mapping, struct list_head *pages,
 				unsigned nr_pages, get_block_t get_block);
 int mpage_readpage(struct page *page, get_block_t get_block);
-int mpage_writeback_mapping(struct address_space *mapping,
+int mpage_writepages(struct address_space *mapping,
 		int *nr_to_write, get_block_t get_block);
 
--- 2.5.18/mm/filemap.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/mm/filemap.c	Sun May 26 02:39:45 2002
@@ -463,7 +463,7 @@ EXPORT_SYMBOL(fail_writepage);
  */
 int filemap_fdatawrite(struct address_space *mapping)
 {
-	return writeback_mapping(mapping, NULL);
+	return do_writepages(mapping, NULL);
 }
 
 /**
--- 2.5.18/mm/swap_state.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/mm/swap_state.c	Sun May 26 02:39:45 2002
@@ -44,7 +44,7 @@ static int swap_vm_writeback(struct page
 	struct address_space *mapping = page->mapping;
 
 	unlock_page(page);
-	return generic_writeback_mapping(mapping, nr_to_write);
+	return generic_writepages(mapping, nr_to_write);
 }
 
 static struct address_space_operations swap_aops = {
--- 2.5.18/mm/page-writeback.c~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/mm/page-writeback.c	Sun May 26 02:39:45 2002
@@ -267,7 +267,7 @@ int generic_vm_writeback(struct page *pa
 	unlock_page(page);
 
 	if (inode) {
-		writeback_mapping(inode->i_mapping, nr_to_write);
+		do_writepages(inode->i_mapping, nr_to_write);
 
 		/*
 		 * This iput() will internally call ext2_discard_prealloc(),
@@ -292,13 +292,13 @@ int generic_vm_writeback(struct page *pa
 EXPORT_SYMBOL(generic_vm_writeback);
 
 /**
- * generic_writeback_mapping - walk the list of dirty pages of the given
+ * generic_writepages - walk the list of dirty pages of the given
  * address space and writepage() all of them.
  * 
  * @mapping: address space structure to write
  * @nr_to_write: subtract the number of written pages from *@nr_to_write
  *
- * This is a library function, which implements the writeback_mapping()
+ * This is a library function, which implements the writepages()
  * address_space_operation.
  *
  * (The next two paragraphs refer to code which isn't here yet, but they
@@ -307,7 +307,7 @@ EXPORT_SYMBOL(generic_vm_writeback);
  * Pages can be moved from clean_pages or locked_pages onto dirty_pages
  * at any time - it's not possible to lock against that.  So pages which
  * have already been added to a BIO may magically reappear on the dirty_pages
- * list.  And generic_writeback_mapping() will again try to lock those pages.
+ * list.  And generic_writepages() will again try to lock those pages.
  * But I/O has not yet been started against the page.  Thus deadlock.
  *
  * To avoid this, the entire contents of the dirty_pages list are moved
@@ -317,7 +317,7 @@ EXPORT_SYMBOL(generic_vm_writeback);
  * This has the added benefit of preventing a livelock which would otherwise
  * occur if pages are being dirtied faster than we can write them out.
  *
- * If a page is already under I/O, generic_writeback_mapping() skips it, even
+ * If a page is already under I/O, generic_writepages() skips it, even
  * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
  * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
  * and msync() need to guarentee that all the data which was dirty at the time
@@ -327,7 +327,7 @@ EXPORT_SYMBOL(generic_vm_writeback);
  * It's fairly rare for PageWriteback pages to be on ->dirty_pages.  It
  * means that someone redirtied the page while it was under I/O.
  */
-int generic_writeback_mapping(struct address_space *mapping, int *nr_to_write)
+int generic_writepages(struct address_space *mapping, int *nr_to_write)
 {
 	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 	int ret = 0;
@@ -394,13 +394,13 @@ int generic_writeback_mapping(struct add
 	write_unlock(&mapping->page_lock);
 	return ret;
 }
-EXPORT_SYMBOL(generic_writeback_mapping);
+EXPORT_SYMBOL(generic_writepages);
 
-int writeback_mapping(struct address_space *mapping, int *nr_to_write)
+int do_writepages(struct address_space *mapping, int *nr_to_write)
 {
-	if (mapping->a_ops->writeback_mapping)
-		return mapping->a_ops->writeback_mapping(mapping, nr_to_write);
-	return generic_writeback_mapping(mapping, nr_to_write);
+	if (mapping->a_ops->writepages)
+		return mapping->a_ops->writepages(mapping, nr_to_write);
+	return generic_writepages(mapping, nr_to_write);
 }
 
 /**
--- 2.5.18/Documentation/filesystems/Locking~rename-writeback_mapping	Sun May 26 02:39:45 2002
+++ 2.5.18-akpm/Documentation/filesystems/Locking	Sun May 26 02:39:45 2002
@@ -132,7 +132,7 @@ prototypes:
 	int (*writepage)(struct page *);
 	int (*readpage)(struct file *, struct page *);
 	int (*sync_page)(struct page *);
-	int (*writeback_mapping)(struct address_space *, int *nr_to_write);
+	int (*writepages)(struct address_space *, int *nr_to_write);
 	int (*vm_writeback)(struct page *, int *nr_to_write);
 	int (*set_page_dirty)(struct page *page);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
@@ -150,7 +150,7 @@ writepage:		no	yes, unlocks
 readpage:		no	yes, unlocks
 readpages:		no
 sync_page:		no	maybe
-writeback_mapping:	no
+writepages:		no
 vm_writeback:		no	yes
 set_page_dirty		no	no
 prepare_write:		no	yes
@@ -181,13 +181,12 @@ with lock on page, but that is not guara
 existing instances of this method ->sync_page() itself doesn't look
 well-defined...
 
-	->writeback_mapping() is used for periodic writeback and for
-systemcall-initiated sync operations.  The address_space should start
-I/O against at least *nr_to_write pages.  *nr_to_write must be
-decremented for each page which is written.  The address_space
-implementation may write more (or less) pages than *nr_to_write asks
-for, but it should try to be reasonably close.  If nr_to_write is NULL,
-all dirty pages must be written.
+	->writepages() is used for periodic writeback and for syscall-initiated
+sync operations.  The address_space should start I/O against at least
+*nr_to_write pages.  *nr_to_write must be decremented for each page which is
+written.  The address_space implementation may write more (or less) pages
+than *nr_to_write asks for, but it should try to be reasonably close.  If
+nr_to_write is NULL, all dirty pages must be written.
 
 	->vm_writeback() is called from the VM.  The address_space should
 start I/O against at least *nr_to_write pages, including the passed page. As


-
