Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSDJFQP>; Wed, 10 Apr 2002 01:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSDJFQO>; Wed, 10 Apr 2002 01:16:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312446AbSDJFQK>;
	Wed, 10 Apr 2002 01:16:10 -0400
Message-ID: <3CB3CA93.D141680B@zip.com.au>
Date: Tue, 09 Apr 2002 22:16:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] page->buffers abstraction
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

page->buffers is a bit of a layering violation.  Not all address_spaces
have pages which are backed by buffers.

The exclusive use of page->buffers for buffers means that a piece of
prime real estate in struct page is unavailable to other forms of
address_space.

This patch turns page->buffers into `unsigned long page->private' and
sets in place all the infrastructure which is needed to allow other
address_spaces to use this storage.

This change alows the multipage-bio-writeout patches to use
page->private to cache the results of an earlier get_block(), so
repeated calls into the filesystem are not needed in the case of file
overwriting.

Devlopers should think carefully before calling try_to_free_buffers()
or block_flushpage() or writeout_one_page() or waitfor_one_page()
against a page.  It's only legal to do this if you *know* that the page
is buffer-backed.  And only the address_space knows that.
Arguably, we need new a_ops for writeout_one_page() and
waitfor_one_page().  But I have more patches on the boil which
obsolete these functions in favour of ->writepage() and wait_on_page().

The new PG_private page bit is used to indicate that there
is something at page->private.  The core kernel does not
know what that object actually is, just that it's there.
The kernel must call a_ops->releasepage() to try to make
page->private go away.  And a_ops->flushpage() at truncate
time.

Patch applies to 2.5.8-pre3+ratcache+readahead


--- 2.5.8-pre2/include/linux/mm.h~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/include/linux/mm.h	Tue Apr  9 12:14:49 2002
@@ -155,7 +155,7 @@ typedef struct page {
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
-	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
+	unsigned long private;		/* fs-private opaque data */
 
 	/*
 	 * On machines where all RAM is mapped into kernel address space,
@@ -178,7 +178,7 @@ typedef struct page {
  *
  * What counts for a page usage:
  * - cache mapping   (page->mapping)
- * - disk mapping    (page->buffers)
+ * - private data    (page->private)
  * - page mapped in a task's page tables, each mapping
  *   is counted separately
  *
@@ -221,13 +221,15 @@ typedef struct page {
  * page->mapping is the pointer to the inode, and page->index is the
  * file offset of the page, in units of PAGE_CACHE_SIZE.
  *
- * A page may have buffers allocated to it. In this case,
- * page->buffers is a circular list of these buffer heads. Else,
- * page->buffers == NULL.
+ * A page contains an opaque `private' member, which belongs to the
+ * page's address_space.  Usually, this is the address of a circular
+ * list of the page's disk buffers.
  *
+ * The PG_private bitflag is set if page->private contains a valid
+ * value.
  * For pages belonging to inodes, the page->count is the number of
- * attaches, plus 1 if buffers are allocated to the page, plus one
- * for the page cache itself.
+ * attaches, plus 1 if `private' contains something, plus one for
+ * the page cache itself.
  *
  * All pages belonging to an inode are in these doubly linked lists:
  * mapping->clean_pages, mapping->dirty_pages and mapping->locked_pages;
@@ -291,6 +293,8 @@ typedef struct page {
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
 
+#define PG_private		16	/* Has something at ->private */
+
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
 #define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
@@ -307,6 +311,9 @@ typedef struct page {
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
 #define __SetPageReserved(page)	__set_bit(PG_reserved, &(page)->flags)
+#define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
+#define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
+#define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
 
 /*
  * The zone field is never updated after free_area_init_core()
@@ -467,7 +474,7 @@ extern struct address_space swapper_spac
 
 static inline int is_page_cache_freeable(struct page * page)
 {
-	return page_count(page) - !!page->buffers == 1;
+	return page_count(page) - !!PagePrivate(page) == 1;
 }
 
 extern int can_share_swap_page(struct page *);
--- 2.5.8-pre2/fs/buffer.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/fs/buffer.c	Tue Apr  9 12:14:49 2002
@@ -1327,21 +1327,13 @@ static void discard_buffer(struct buffer
 
 int try_to_release_page(struct page * page, int gfp_mask)
 {
+	struct address_space * const mapping = page->mapping;
+
 	if (!PageLocked(page))
 		BUG();
 	
-	if (!page->mapping)
-		goto try_to_free;
-	if (!page->mapping->a_ops->releasepage)
-		goto try_to_free;
-	if (page->mapping->a_ops->releasepage(page, gfp_mask))
-		goto try_to_free;
-	/*
-	 * We couldn't release buffer metadata; don't even bother trying
-	 * to release buffers.
-	 */
-	return 0;
-try_to_free:	
+	if (mapping && mapping->a_ops->releasepage)
+		return mapping->a_ops->releasepage(page, gfp_mask);
 	return try_to_free_buffers(page, gfp_mask);
 }
 
@@ -1359,10 +1351,10 @@ int discard_bh_page(struct page *page, u
 
 	if (!PageLocked(page))
 		BUG();
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		return 1;
 
-	head = page->buffers;
+	head = page_buffers(page);
 	bh = head;
 	do {
 		unsigned int next_off = curr_off + bh->b_size;
@@ -1401,7 +1393,7 @@ void create_empty_buffers(struct page *p
 
 	/* FIXME: create_buffers should fail if there's no enough memory */
 	head = create_buffers(page, blocksize, 1);
-	if (page->buffers)
+	if (page_has_buffers(page))
 		BUG();
 
 	bh = head;
@@ -1411,7 +1403,7 @@ void create_empty_buffers(struct page *p
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
-	page->buffers = head;
+	set_page_buffers(page, head);
 	page_cache_get(page);
 }
 EXPORT_SYMBOL(create_empty_buffers);
@@ -1467,9 +1459,9 @@ static int __block_write_full_page(struc
 	if (!PageLocked(page))
 		BUG();
 
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		create_empty_buffers(page, 1 << inode->i_blkbits);
-	head = page->buffers;
+	head = page_buffers(page);
 
 	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 
@@ -1560,9 +1552,9 @@ static int __block_prepare_write(struct 
 	char *kaddr = kmap(page);
 
 	blocksize = 1 << inode->i_blkbits;
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize);
-	head = page->buffers;
+	head = page_buffers(page);
 
 	bbits = inode->i_blkbits;
 	block = page->index << (PAGE_CACHE_SHIFT - bbits);
@@ -1653,7 +1645,7 @@ static int __block_commit_write(struct i
 
 	blocksize = 1 << inode->i_blkbits;
 
-	for(bh = head = page->buffers, block_start = 0;
+	for(bh = head = page_buffers(page), block_start = 0;
 	    bh != head || !block_start;
 	    block_start=block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
@@ -1701,9 +1693,9 @@ int block_read_full_page(struct page *pa
 	if (!PageLocked(page))
 		PAGE_BUG(page);
 	blocksize = 1 << inode->i_blkbits;
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize);
-	head = page->buffers;
+	head = page_buffers(page);
 
 	blocks = PAGE_CACHE_SIZE >> inode->i_blkbits;
 	iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
@@ -1953,11 +1945,11 @@ int block_truncate_page(struct address_s
 	if (!page)
 		goto out;
 
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize);
 
 	/* Find the buffer that contains "offset" */
-	bh = page->buffers;
+	bh = page_buffers(page);
 	pos = blocksize;
 	while (offset >= pos) {
 		bh = bh->b_this_page;
@@ -2044,7 +2036,7 @@ done:
  */
 int writeout_one_page(struct page *page)
 {
-	struct buffer_head *bh, *head = page->buffers;
+	struct buffer_head *bh, *head = page_buffers(page);
 
 	if (!PageLocked(page))
 		BUG();
@@ -2067,7 +2059,7 @@ EXPORT_SYMBOL(writeout_one_page);
 int waitfor_one_page(struct page *page)
 {
 	int error = 0;
-	struct buffer_head *bh, *head = page->buffers;
+	struct buffer_head *bh, *head = page_buffers(page);
 
 	bh = head;
 	do {
@@ -2210,9 +2202,9 @@ int brw_page(int rw, struct page *page, 
 	if (!PageLocked(page))
 		panic("brw_page: page not locked for I/O");
 
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		create_empty_buffers(page, size);
-	head = bh = page->buffers;
+	head = bh = page_buffers(page);
 
 	/* Stage 1: lock all the buffers */
 	do {
@@ -2280,7 +2272,7 @@ static inline void link_dev_buffers(stru
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
-	page->buffers = head;
+	set_page_buffers(page, head);
 	page_cache_get(page);
 }
 
@@ -2299,8 +2291,8 @@ static struct page * grow_dev_page(struc
 	if (!PageLocked(page))
 		BUG();
 
-	bh = page->buffers;
-	if (bh) {
+	if (page_has_buffers(page)) {
+		bh = page_buffers(page);
 		if (bh->b_size == size)
 			return page;
 		if (!try_to_free_buffers(page, GFP_NOFS))
@@ -2321,7 +2313,7 @@ failed:
 
 static void hash_page_buffers(struct page *page, struct block_device *bdev, int block, int size)
 {
-	struct buffer_head *head = page->buffers;
+	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh = head;
 	unsigned int uptodate;
 
@@ -2447,7 +2439,7 @@ static int sync_page_buffers(struct buff
  */
 int try_to_free_buffers(struct page * page, unsigned int gfp_mask)
 {
-	struct buffer_head * tmp, * bh = page->buffers;
+	struct buffer_head * tmp, * bh = page_buffers(page);
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!bh);
@@ -2484,7 +2476,7 @@ cleaned_buffers_try_again:
 	wake_up(&buffer_wait);
 
 	/* And free the page */
-	page->buffers = NULL;
+	clear_page_buffers(page);
 	page_cache_release(page);
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
--- 2.5.8-pre2/include/linux/fs.h~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/include/linux/fs.h	Tue Apr  9 12:14:49 2002
@@ -285,6 +285,24 @@ extern void set_bh_page(struct buffer_he
 
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)
 
+/* If we *know* page->private refers to buffer_heads */
+#define page_buffers(page)					\
+	({							\
+		if (!PagePrivate(page))				\
+			BUG();					\
+		((struct buffer_head *)(page)->private);	\
+	})
+#define page_has_buffers(page)	PagePrivate(page)
+#define set_page_buffers(page, buffers)				\
+	do {							\
+		SetPagePrivate(page);				\
+		page->private = (unsigned long)buffers;		\
+	} while (0)
+#define clear_page_buffers(page)				\
+	do {							\
+		ClearPagePrivate(page);				\
+		page->private = 0;				\
+	} while (0)
 
 #include <linux/pipe_fs_i.h>
 /* #include <linux/umsdos_fs_i.h> */
--- 2.5.8-pre2/fs/ext3/inode.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/fs/ext3/inode.c	Tue Apr  9 12:14:49 2002
@@ -1029,7 +1029,7 @@ static int ext3_prepare_write(struct fil
 		goto prepare_write_failed;
 
 	if (ext3_should_journal_data(inode)) {
-		ret = walk_page_buffers(handle, page->buffers,
+		ret = walk_page_buffers(handle, page_buffers(page),
 				from, to, NULL, do_journal_get_write_access);
 		if (ret) {
 			/*
@@ -1102,7 +1102,7 @@ static int ext3_commit_write(struct file
 		int partial = 0;
 		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 
-		ret = walk_page_buffers(handle, page->buffers,
+		ret = walk_page_buffers(handle, page_buffers(page),
 			from, to, &partial, commit_write_fn);
 		if (!partial)
 			SetPageUptodate(page);
@@ -1112,7 +1112,7 @@ static int ext3_commit_write(struct file
 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
 	} else {
 		if (ext3_should_order_data(inode)) {
-			ret = walk_page_buffers(handle, page->buffers,
+			ret = walk_page_buffers(handle, page_buffers(page),
 				from, to, NULL, journal_dirty_sync_data);
 		}
 		/* Be careful here if generic_commit_write becomes a
@@ -1252,7 +1252,7 @@ static int bget_one(handle_t *handle, st
 static int ext3_writepage(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct buffer_head *page_buffers;
+	struct buffer_head *page_bufs;
 	handle_t *handle = NULL;
 	int ret = 0, err;
 	int needed;
@@ -1285,14 +1285,14 @@ static int ext3_writepage(struct page *p
 
 	unlock_kernel();
 
-	page_buffers = NULL;	/* Purely to prevent compiler warning */
+	page_bufs = NULL;	/* Purely to prevent compiler warning */
 
 	/* bget() all the buffers */
 	if (order_data) {
-		if (!page->buffers)
+		if (!page_has_buffers(page))
 			create_empty_buffers(page, inode->i_sb->s_blocksize);
-		page_buffers = page->buffers;
-		walk_page_buffers(handle, page_buffers, 0,
+		page_bufs = page_buffers(page);
+		walk_page_buffers(handle, page_bufs, 0,
 				PAGE_CACHE_SIZE, NULL, bget_one);
 	}
 
@@ -1301,7 +1301,7 @@ static int ext3_writepage(struct page *p
 	/*
 	 * The page can become unlocked at any point now, and
 	 * truncate can then come in and change things.  So we
-	 * can't touch *page from now on.  But *page_buffers is
+	 * can't touch *page from now on.  But *page_bufs is
 	 * safe due to elevated refcount.
 	 */
 
@@ -1310,7 +1310,7 @@ static int ext3_writepage(struct page *p
 
 	/* And attach them to the current transaction */
 	if (order_data) {
-		err = walk_page_buffers(handle, page_buffers,
+		err = walk_page_buffers(handle, page_bufs,
 			0, PAGE_CACHE_SIZE, NULL, journal_dirty_async_data);
 		if (!ret)
 			ret = err;
@@ -1392,11 +1392,11 @@ static int ext3_block_truncate_page(hand
 	if (!page)
 		goto out;
 
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize);
 
 	/* Find the buffer that contains "offset" */
-	bh = page->buffers;
+	bh = page_buffers(page);
 	pos = blocksize;
 	while (offset >= pos) {
 		bh = bh->b_this_page;
--- 2.5.8-pre2/fs/jbd/transaction.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/fs/jbd/transaction.c	Tue Apr  9 12:14:49 2002
@@ -1661,10 +1661,11 @@ int journal_try_to_free_buffers(journal_
 	struct buffer_head *tmp;
 	int locked_or_dirty = 0;
 	int call_ttfb = 1;
+	int ret;
 
 	J_ASSERT(PageLocked(page));
 
-	bh = page->buffers;
+	bh = page_buffers(page);
 	tmp = bh;
 	spin_lock(&journal_datalist_lock);
 	do {
@@ -1688,7 +1689,10 @@ int journal_try_to_free_buffers(journal_
 	 */
 	call_ttfb = 1;
 out:
-	return call_ttfb;
+	ret = 0;
+	if (call_ttfb)
+		ret = try_to_free_buffers(page, gfp_mask);
+	return ret;
 }
 
 /*
@@ -1881,7 +1885,7 @@ int journal_flushpage(journal_t *journal
 		
 	if (!PageLocked(page))
 		BUG();
-	if (!page->buffers)
+	if (!page_has_buffers(page))
 		return 1;
 
 	/* We will potentially be playing with lists other than just the
@@ -1889,7 +1893,7 @@ int journal_flushpage(journal_t *journal
 	 * cautious in our locking. */
 	lock_journal(journal);
 
-	head = bh = page->buffers;
+	head = bh = page_buffers(page);
 	do {
 		unsigned int next_off = curr_off + bh->b_size;
 		next = bh->b_this_page;
@@ -1911,7 +1915,7 @@ int journal_flushpage(journal_t *journal
 	if (!offset) {
 		if (!may_free || !try_to_free_buffers(page, 0))
 			return 0;
-		J_ASSERT(page->buffers == NULL);
+		J_ASSERT(!page_has_buffers(page));
 	}
 	return 1;
 }
--- 2.5.8-pre2/fs/reiserfs/inode.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/fs/reiserfs/inode.c	Tue Apr  9 12:14:49 2002
@@ -146,8 +146,8 @@ static void add_to_flushlist(struct inod
 static inline void fix_tail_page_for_writing(struct page *page) {
     struct buffer_head *head, *next, *bh ;
 
-    if (page && page->buffers) {
-	head = page->buffers ;
+    if (page && page_has_buffers(page)) {
+	head = page_buffers(page) ;
 	bh = head ;
 	do {
 	    next = bh->b_this_page ;
@@ -1685,7 +1685,7 @@ static int grab_tail_page(struct inode *
 
     kunmap(page) ; /* mapped by block_prepare_write */
 
-    head = page->buffers ;      
+    head = page_buffers(page) ;      
     bh = head;
     do {
 	if (pos >= start) {
@@ -1930,7 +1930,7 @@ static int reiserfs_write_full_page(stru
     struct buffer_head *arr[PAGE_CACHE_SIZE/512] ;
     int nr = 0 ;
 
-    if (!page->buffers) {
+    if (!page_has_buffers(page)) {
         block_prepare_write(page, 0, 0, NULL) ;
 	kunmap(page) ;
     }
@@ -1948,7 +1948,7 @@ static int reiserfs_write_full_page(stru
 	flush_dcache_page(page) ;
 	kunmap(page) ;
     }
-    head = page->buffers ;
+    head = page_buffers(page) ;
     bh = head ;
     block = page->index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits) ;
     do {
--- 2.5.8-pre2/fs/reiserfs/tail_conversion.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/fs/reiserfs/tail_conversion.c	Tue Apr  9 12:14:49 2002
@@ -156,10 +156,10 @@ unmap_buffers(struct page *page, loff_t 
   unsigned long cur_index ;
 
   if (page) {
-    if (page->buffers) {
+    if (page_has_buffers(page)) {
       tail_index = pos & (PAGE_CACHE_SIZE - 1) ;
       cur_index = 0 ;
-      head = page->buffers ;
+      head = page_buffers(page) ;
       bh = head ;
       do {
 	next = bh->b_this_page ;
--- 2.5.8-pre2/include/asm-s390/pgtable.h~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/include/asm-s390/pgtable.h	Tue Apr  9 12:14:49 2002
@@ -429,7 +429,7 @@ extern inline pte_t mk_pte_phys(unsigned
 	                                                                  \
 	if (__page != ZERO_PAGE(__physpage)) {                            \
 		int __users = page_count(__page);                         \
-		__users -= !!__page->buffers + !!__page->mapping;         \
+		__users -= !!PagePrivate(__page) + !!__page->mapping;     \
 	                                                                  \
 		if (__users == 1)                                         \
 			pte_val(__pte) |= _PAGE_MKCLEAR;                  \
--- 2.5.8-pre2/include/asm-s390x/pgtable.h~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/include/asm-s390x/pgtable.h	Tue Apr  9 12:14:49 2002
@@ -448,7 +448,7 @@ extern inline pte_t mk_pte_phys(unsigned
 	                                                                  \
 	if (__page != ZERO_PAGE(__physpage)) {                            \
 		int __users = page_count(__page);                         \
-		__users -= !!__page->buffers + !!__page->mapping;         \
+		__users -= !!PagePrivate(page) + !!__page->mapping;       \
 	                                                                  \
 		if (__users == 1)                                         \
 			pte_val(__pte) |= _PAGE_MKCLEAR;                  \
--- 2.5.8-pre2/mm/filemap.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/mm/filemap.c	Tue Apr  9 12:14:49 2002
@@ -150,7 +150,7 @@ void invalidate_inode_pages(struct inode
 		if (TryLockPage(page))
 			continue;
 
-		if (page->buffers && !try_to_free_buffers(page, 0))
+		if (PagePrivate(page) && !try_to_release_page(page, 0))
 			goto unlock;
 
 		if (page_count(page) != 1)
@@ -182,14 +182,18 @@ static int do_flushpage(struct page *pag
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
 	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
-	if (page->buffers)
+	if (PagePrivate(page))
 		do_flushpage(page, partial);
 }
 
+/*
+ * AKPM: the PagePrivate test here seems a bit bogus.  It bypasses the
+ * mapping's ->flushpage, which may still want to be called.
+ */
 static void truncate_complete_page(struct page *page)
 {
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!page->buffers || do_flushpage(page, 0))
+	if (!PagePrivate(page) || do_flushpage(page, 0))
 		lru_cache_del(page);
 
 	/*
@@ -301,9 +305,9 @@ static inline int invalidate_this_page2(
 
 	/*
 	 * The page is locked and we hold the mapping lock as well
-	 * so both page_count(page) and page->buffers stays constant here.
+	 * so both page_count(page) and page_buffers stays constant here.
 	 */
-	if (page_count(page) == 1 + !!page->buffers) {
+	if (page_count(page) == 1 + !!page_has_buffers(page)) {
 		/* Restart after this page */
 		list_del(head);
 		list_add_tail(head, curr);
@@ -312,7 +316,7 @@ static inline int invalidate_this_page2(
 		write_unlock(&mapping->page_lock);
 		truncate_complete_page(page);
 	} else {
-		if (page->buffers) {
+		if (page_has_buffers(page)) {
 			/* Restart after this page */
 			list_del(head);
 			list_add_tail(head, curr);
@@ -409,7 +413,7 @@ static int do_buffer_fdatasync(struct ad
 	while (curr != head) {
 		page = list_entry(curr, struct page, list);
 		curr = curr->next;
-		if (!page->buffers)
+		if (!page_has_buffers(page))
 			continue;
 		if (page->index >= end)
 			continue;
@@ -421,7 +425,7 @@ static int do_buffer_fdatasync(struct ad
 		lock_page(page);
 
 		/* The buffers could have been free'd while we waited for the page lock */
-		if (page->buffers)
+		if (page_has_buffers(page))
 			retval |= fn(page);
 
 		UnlockPage(page);
--- 2.5.8-pre2/mm/page_alloc.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/mm/page_alloc.c	Tue Apr  9 12:14:49 2002
@@ -98,7 +98,7 @@ static void __free_pages_ok (struct page
 	struct page *base;
 	zone_t *zone;
 
-	if (page->buffers)
+	if (PagePrivate(page))
 		BUG();
 	if (page->mapping)
 		BUG();
@@ -291,7 +291,7 @@ static struct page * balance_classzone(z
 					set_page_count(tmp, 1);
 					page = tmp;
 
-					if (page->buffers)
+					if (PagePrivate(page))
 						BUG();
 					if (page->mapping)
 						BUG();
--- 2.5.8-pre2/mm/vmscan.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/mm/vmscan.c	Tue Apr  9 12:14:49 2002
@@ -92,7 +92,8 @@ drop_pte:
 		mm->rss--;
 		UnlockPage(page);
 		{
-			int freeable = page_count(page) - !!page->buffers <= 2;
+			int freeable = page_count(page) -
+				!!PagePrivate(page) <= 2;
 			page_cache_release(page);
 			return freeable;
 		}
@@ -121,7 +122,7 @@ drop_pte:
 	 * Anonymous buffercache pages can be left behind by
 	 * concurrent truncate and pagefault.
 	 */
-	if (page->buffers)
+	if (PagePrivate(page))
 		goto preserve;
 
 	/*
@@ -384,7 +385,7 @@ static int shrink_cache(int nr_pages, zo
 			continue;
 
 		/* Racy check to avoid trylocking when not worthwhile */
-		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
+		if (!PagePrivate(page) && (page_count(page) != 1 || !page->mapping))
 			goto page_mapped;
 
 		/*
@@ -435,7 +436,7 @@ static int shrink_cache(int nr_pages, zo
 		 * associated with this page. If we succeed we try to free
 		 * the page as well.
 		 */
-		if (page->buffers) {
+		if (PagePrivate(page)) {
 			spin_unlock(&pagemap_lru_lock);
 
 			/* avoid to free a locked page */
--- 2.5.8-pre2/mm/swapfile.c~dallocbase-40-pageprivate	Tue Apr  9 12:14:49 2002
+++ 2.5.8-pre2-akpm/mm/swapfile.c	Tue Apr  9 12:15:33 2002
@@ -240,7 +240,7 @@ static int exclusive_swap_page(struct pa
 		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
 			read_lock(&swapper_space.page_lock);
-			if (page_count(page) - !!page->buffers == 2)
+			if (page_count(page) - !!PagePrivate(page) == 2)
 				retval = 1;
 			read_unlock(&swapper_space.page_lock);
 		}
@@ -265,7 +265,7 @@ int can_share_swap_page(struct page *pag
 		BUG();
 	switch (page_count(page)) {
 	case 3:
-		if (!page->buffers)
+		if (!PagePrivate(page))
 			break;
 		/* Fallthrough */
 	case 2:
@@ -295,7 +295,7 @@ int remove_exclusive_swap_page(struct pa
 		BUG();
 	if (!PageSwapCache(page))
 		return 0;
-	if (page_count(page) - !!page->buffers != 2)	/* 2: us + cache */
+	if (page_count(page) - !!PagePrivate(page) != 2) /* 2: us + cache */
 		return 0;
 
 	entry.val = page->index;
@@ -308,7 +308,7 @@ int remove_exclusive_swap_page(struct pa
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		read_lock(&swapper_space.page_lock);
-		if (page_count(page) - !!page->buffers == 2) {
+		if (page_count(page) - !!PagePrivate(page) == 2) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
@@ -344,7 +344,7 @@ void free_swap_and_cache(swp_entry_t ent
 	if (page) {
 		page_cache_get(page);
 		/* Only cache user (+us), or swap space full? Free it! */
-		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {
+		if (page_count(page) - !!PagePrivate(page) == 2 || vm_swap_full()) {
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}

-
