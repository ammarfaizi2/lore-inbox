Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbQL2TMr>; Fri, 29 Dec 2000 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131970AbQL2TM1>; Fri, 29 Dec 2000 14:12:27 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30994 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130061AbQL2TMY>; Fri, 29 Dec 2000 14:12:24 -0500
Date: Fri, 29 Dec 2000 14:49:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012291446560.13194-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000, Linus Torvalds wrote:

> All done. It looks something like 5-10 places, most of which are about 10
> lines of diff each, if even that.
> 
> The only real worry would be that the locking isn't rigth, but getting the
> pagemap lock should be the safe thing, and from a lock contention
> standpoint it should be ok (if we move a lot of pages back and forth, lock
> contention is going to be the least of our worries, because it implies
> that we'd be doing a LOT of IO to actually write the pages out).
> 
> If somebody (you? hint, hint) wants to do this, I'd be very happy - I can
> do it myself, but because it's my birthday I'm supposed to drag myself off
> the computer soon and be social, or Tove will be grumpy.

Ok, here it is.

I hope I got all locking and all special cases right.

Comments ?


diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Fri Dec 29 15:30:52 2000
+++ linux/fs/buffer.c	Fri Dec 29 16:21:17 2000
@@ -320,6 +320,46 @@
 	return 0;
 }
 
+/**
+ *      filemap_fdatasync - walk the list of dirty pages of the given address space
+ *     	and writepage() all of them.
+ * 
+ *      @mapping: address space structure to write
+ *
+ */
+void filemap_fdatasync(struct address_space * mapping)
+{
+	int (*writepage)(struct page *) = mapping->a_ops->writepage;
+
+	spin_lock(&pagecache_lock);
+
+        while (!list_empty(&mapping->dirty_pages)) {
+		struct page *page = list_entry(mapping->dirty_pages.next, 
+				struct page, list);
+
+		list_del(&page->list);
+		list_add(&page->list, &mapping->clean_pages);
+
+		if (!PageDirty(page))
+			continue;
+
+		page_cache_get(page);
+		spin_unlock(&pagecache_lock);
+
+		lock_page(page);
+
+		if (PageDirty(page)) {
+			ClearPageDirty(page);
+			writepage(page);
+		}
+
+		UnlockPage(page);
+		page_cache_release(page);
+		spin_lock(&pagecache_lock);
+	}
+	spin_unlock(&pagecache_lock);
+}
+
 /*
  *	filp may be NULL if called via the msync of a vma.
  */
@@ -367,6 +407,8 @@
 	if (!file->f_op || !file->f_op->fsync)
 		goto out_putf;
 
+	filemap_fdatasync(inode->i_mapping);
+
 	/* We need to protect against concurrent writers.. */
 	down(&inode->i_sem);
 	err = file->f_op->fsync(file, dentry, 0);
@@ -396,6 +438,8 @@
 	err = -EINVAL;
 	if (!file->f_op || !file->f_op->fsync)
 		goto out_putf;
+
+	filemap_fdatasync(inode->i_mapping);
 
 	down(&inode->i_sem);
 	err = file->f_op->fsync(file, dentry, 1);
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/fs/inode.c linux/fs/inode.c
--- linux.orig/fs/inode.c	Fri Dec  1 05:50:27 2000
+++ linux/fs/inode.c	Fri Dec 29 16:14:09 2000
@@ -100,7 +100,8 @@
 		memset(inode, 0, sizeof(*inode));
 		init_waitqueue_head(&inode->i_wait);
 		INIT_LIST_HEAD(&inode->i_hash);
-		INIT_LIST_HEAD(&inode->i_data.pages);
+		INIT_LIST_HEAD(&inode->i_data.clean_pages);
+		INIT_LIST_HEAD(&inode->i_data.dirty_pages);
 		INIT_LIST_HEAD(&inode->i_dentry);
 		INIT_LIST_HEAD(&inode->i_dirty_buffers);
 		sema_init(&inode->i_sem, 1);
@@ -206,6 +207,8 @@
 		inode->i_state |= I_LOCK;
 		inode->i_state &= ~I_DIRTY;
 		spin_unlock(&inode_lock);
+
+		filemap_fdatasync(inode->i_mapping);
 
 		write_inode(inode, sync);
 
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/filemap.c linux/mm/filemap.c
--- linux.orig/mm/filemap.c	Fri Dec 29 15:30:55 2000
+++ linux/mm/filemap.c	Fri Dec 29 16:18:01 2000
@@ -71,7 +71,7 @@
 
 static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
 {
-	struct list_head *head = &mapping->pages;
+	struct list_head *head = &mapping->clean_pages;
 
 	mapping->nrpages++;
 	list_add(&page->list, head);
@@ -144,7 +144,7 @@
 	struct list_head *head, *curr;
 	struct page * page;
 
-	head = &inode->i_mapping->pages;
+	head = &inode->i_mapping->clean_pages;
 
 	spin_lock(&pagecache_lock);
 	spin_lock(&pagemap_lru_lock);
@@ -204,26 +204,12 @@
 	page_cache_release(page);
 }
 
-/**
- * truncate_inode_pages - truncate *all* the pages from an offset
- * @mapping: mapping to truncate
- * @lstart: offset from with to truncate
- *
- * Truncate the page cache at a set offset, removing the pages
- * that are beyond that offset (and zeroing out partial pages).
- * If any page is locked we wait for it to become unlocked.
- */
-void truncate_inode_pages(struct address_space * mapping, loff_t lstart)
+void truncate_list_pages(struct list_head *head, unsigned long start, unsigned partial)
 {
-	struct list_head *head, *curr;
+	struct list_head *curr;
 	struct page * page;
-	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
-	unsigned long start;
-
-	start = (lstart + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 
 repeat:
-	head = &mapping->pages;
 	spin_lock(&pagecache_lock);
 	curr = head->next;
 	while (curr != head) {
@@ -267,6 +253,25 @@
 	spin_unlock(&pagecache_lock);
 }
 
+
+/**
+ * truncate_inode_pages - truncate *all* the pages from an offset
+ * @mapping: mapping to truncate
+ * @lstart: offset from with to truncate
+ *
+ * Truncate the page cache at a set offset, removing the pages
+ * that are beyond that offset (and zeroing out partial pages).
+ * If any page is locked we wait for it to become unlocked.
+ */
+void truncate_inode_pages(struct address_space * mapping, loff_t lstart) 
+{
+	unsigned long start = (lstart + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
+
+	truncate_list_pages(&mapping->clean_pages, start, partial);
+	truncate_list_pages(&mapping->dirty_pages, start, partial);
+}
+
 static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
 {
 	goto inside;
@@ -328,14 +333,12 @@
 	return error;
 }
 
-static int do_buffer_fdatasync(struct inode *inode, unsigned long start, unsigned long end, int (*fn)(struct page *))
+static int do_buffer_fdatasync(struct list_head *head, unsigned long start, unsigned long end, int (*fn)(struct page *))
 {
-	struct list_head *head, *curr;
+	struct list_head *curr;
 	struct page *page;
 	int retval = 0;
 
-	head = &inode->i_mapping->pages;
-
 	spin_lock(&pagecache_lock);
 	curr = head->next;
 	while (curr != head) {
@@ -374,8 +377,18 @@
 {
 	int retval;
 
-	retval = do_buffer_fdatasync(inode, start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(inode, start_idx, end_idx, waitfor_one_page);
+	/* writeout dirty buffers on pages from both clean and dirty lists */
+	retval = do_buffer_fdatasync(&inode->i_mapping->dirty_pages, start_idx, 
+			end_idx, writeout_one_page);
+	retval |= do_buffer_fdatasync(&inode->i_mapping->clean_pages, start_idx, 
+			end_idx, writeout_one_page);
+
+	/* now wait for locked buffers on pages from both clean and dirty lists */
+	retval |= do_buffer_fdatasync(&inode->i_mapping->dirty_pages, start_idx, 
+			end_idx, writeout_one_page);
+	retval |= do_buffer_fdatasync(&inode->i_mapping->clean_pages, start_idx, 
+			end_idx, waitfor_one_page);
+
 	return retval;
 }
 
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/memory.c linux/mm/memory.c
--- linux.orig/mm/memory.c	Mon Dec 11 19:45:42 2000
+++ linux/mm/memory.c	Fri Dec 29 16:02:23 2000
@@ -259,22 +259,22 @@
 /*
  * Return indicates whether a page was freed so caller can adjust rss
  */
-static inline int free_pte(pte_t page)
+static inline int free_pte(pte_t pte)
 {
-	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+	if (pte_present(pte)) {
+		struct page *page = pte_page(pte);
+		if ((!VALID_PAGE(page)) || PageReserved(page))
 			return 0;
 		/* 
 		 * free_page() used to be able to clear swap cache
 		 * entries.  We may now have to do it manually.  
 		 */
-		if (pte_dirty(page))
-			SetPageDirty(ptpage);
-		free_page_and_swap_cache(ptpage);
+		if (pte_dirty(pte) && page->mapping)
+			SetPageDirty(page);
+		free_page_and_swap_cache(page);
 		return 1;
 	}
-	swap_free(pte_to_swp_entry(page));
+	swap_free(pte_to_swp_entry(pte));
 	return 0;
 }
 
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Fri Dec 29 15:30:55 2000
+++ linux/mm/swap_state.c	Fri Dec 29 16:10:15 2000
@@ -29,9 +29,13 @@
 };
 
 struct address_space swapper_space = {
-	{				/* pages	*/
-		&swapper_space.pages,	/*        .next */
-		&swapper_space.pages	/*	  .prev */
+	{				/* clean_pages	*/
+		&swapper_space.clean_pages,	/*        .next */
+		&swapper_space.clean_pages	/*	  .prev */
+	},
+	{				/* dirty_pages	*/
+		&swapper_space.dirty_pages,	/*        .next */
+		&swapper_space.dirty_pages	/*	  .prev */
 	},
 	0,				/* nrpages	*/
 	&swap_aops,
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/include/linux/fs.h linux/include/linux/fs.h
--- linux.orig/include/linux/fs.h	Fri Dec 29 15:30:54 2000
+++ linux/include/linux/fs.h	Fri Dec 29 15:53:08 2000
@@ -363,8 +363,9 @@
 };
 
 struct address_space {
-	struct list_head	pages;		/* list of pages */
-	unsigned long		nrpages;	/* number of pages */
+	struct list_head	clean_pages;	/* list of clean pages */
+	struct list_head	dirty_pages;	/* list of dirty pages */
+	unsigned long		nrpages;	/* number of total pages */
 	struct address_space_operations *a_ops;	/* methods */
 	void			*host;		/* owner: inode, block_device */
 	struct vm_area_struct	*i_mmap;	/* list of private mappings */
@@ -1064,6 +1065,7 @@
 extern int fsync_inode_buffers(struct inode *);
 extern int osync_inode_buffers(struct inode *);
 extern int inode_has_buffers(struct inode *);
+extern void filemap_fdatasync(struct address_space *);
 extern void sync_supers(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Fri Dec 29 15:30:54 2000
+++ linux/include/linux/mm.h	Fri Dec 29 16:07:39 2000
@@ -181,7 +181,14 @@
 #define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
 #define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
 #define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
-#define SetPageDirty(page)	set_bit(PG_dirty, &(page)->flags)
+#define SetPageDirty(page) \
+	if (!test_and_set_bit(PG_dirty, &page->flags)) { \
+		spin_lock(&pagecache_lock); \
+		list_del(&page->list); \
+		list_add(&page->list, &page->mapping->dirty_pages); \
+		spin_unlock(&pagecache_lock); \
+	}
+
 #define ClearPageDirty(page)	clear_bit(PG_dirty, &(page)->flags)
 #define PageLocked(page)	test_bit(PG_locked, &(page)->flags)
 #define LockPage(page)		set_bit(PG_locked, &(page)->flags)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
