Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266500AbRGTCrq>; Thu, 19 Jul 2001 22:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266490AbRGTCrh>; Thu, 19 Jul 2001 22:47:37 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:32446 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266500AbRGTCrW>; Thu, 19 Jul 2001 22:47:22 -0400
Subject: Resend inlined text: [PATCH] Minor cleanup and export three functions
To: Linus@cus.cam.ac.uk, Torwalds@cus.cam.ac.uk, <torvalds@transmeta.com>
Date: Fri, 20 Jul 2001 03:47:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15NQK6-0005qn-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sorry for confusion. Here goes again, sent with elm, and tested for being
clear text inline and that white space is not mangled.
-------------

Linus,

Please consider attached patch. It does three things:

- Adds docbook style comments to a very few functions relating to the page
cache (mm/filemap.c) and does very minor clean up on those to keep within
80 character wide lines (only look affected).

- Minor cleanup making the offset/index parameter "const" in those
functions.

- More importantly, the patch exports the following three functions:

from mm/filemap.c (adding to include/linux/pagemap.h):
	__find_page_nolock()
	__add_to_page_cache()

from fs/buffer.c (adding to include/linux/fs.h):
	create_empty_buffers()

The static keyword is removed, they are added to the indicated header
files as extern or extern inline as appropriate, and they are also added
to kernel/ksyms.c.

These three functions are used by the new NTFS driver which is under
development and in specific in the inode metadata in page cache part. I
have looked at alternatives but they lead to much nastier complications
within the ntfs code. (E.g. due to forcing me to drop the pagecache_lock
if I were to use add_to_page_cache() function instead of
__add_to_page_cache() which would in turn lead to potential race
condition, and anyway dropping the lock to only reacquire it straight
after returning after the function seems very inefficient.)

Any objections to the patch? If not, please apply. Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
  
--- Patch follows this line ---
diff -urN linux-2.4.7-pre8-vanilla/fs/buffer.c linux-2.4.7-pre8-tng-mrproper/fs/buffer.c
--- linux-2.4.7-pre8-vanilla/fs/buffer.c	Thu Jul 19 18:53:17 2001
+++ linux-2.4.7-pre8-tng-mrproper/fs/buffer.c	Thu Jul 19 20:45:00 2001
@@ -1434,7 +1434,8 @@
 	return 1;
 }
 
-static void create_empty_buffers(struct page *page, kdev_t dev, unsigned long blocksize)
+void create_empty_buffers(struct page *page, kdev_t dev,
+		unsigned long blocksize)
 {
 	struct buffer_head *bh, *head, *tail;
 
diff -urN linux-2.4.7-pre8-vanilla/include/linux/fs.h linux-2.4.7-pre8-tng-mrproper/include/linux/fs.h
--- linux-2.4.7-pre8-vanilla/include/linux/fs.h	Thu Jul 19 18:53:19 2001
+++ linux-2.4.7-pre8-tng-mrproper/include/linux/fs.h	Thu Jul 19 23:02:10 2001
@@ -1320,6 +1320,8 @@
 
 typedef int (get_block_t)(struct inode*,long,struct buffer_head*,int);
 
+extern void create_empty_buffers(struct page *, kdev_t, unsigned long);
+
 /* Generic buffer handling for block filesystems.. */
 extern int block_flushpage(struct page *, unsigned long);
 extern int block_symlink(struct inode *, const char *, int);
diff -urN linux-2.4.7-pre8-vanilla/include/linux/pagemap.h linux-2.4.7-pre8-tng-mrproper/include/linux/pagemap.h
--- linux-2.4.7-pre8-vanilla/include/linux/pagemap.h	Tue Jul  3 23:42:57 2001
+++ linux-2.4.7-pre8-tng-mrproper/include/linux/pagemap.h	Thu Jul 19 21:08:33 2001
@@ -60,7 +60,8 @@
  * For the time being it will work for struct address_space too (most of
  * them sitting inside the inodes). We might want to change it later.
  */
-extern inline unsigned long _page_hashfn(struct address_space * mapping, unsigned long index)
+extern inline unsigned long _page_hashfn(struct address_space *mapping,
+		const unsigned long index)
 {
 #define i (((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))
 #define s(x) ((x)+((x)>>PAGE_HASH_BITS))
@@ -75,6 +76,8 @@
 				     unsigned long offset, struct page **hash);
 extern struct page * __find_lock_page (struct address_space * mapping,
 				unsigned long index, struct page **hash);
+extern inline struct page *__find_page_nolock(struct address_space *mapping,
+		const unsigned long offset, struct page *page);
 extern void lock_page(struct page *page);
 #define find_lock_page(mapping, index) \
 	__find_lock_page(mapping, index, page_hash(mapping, index))
@@ -86,8 +89,13 @@
 
 extern void __add_page_to_hash_queue(struct page * page, struct page **p);
 
-extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
-extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
+extern inline void __add_to_page_cache(struct page *page,
+		struct address_space *mapping, const unsigned long offset,
+		struct page **hash);
+extern void add_to_page_cache(struct page *page, struct address_space *mapping,
+		const unsigned long index);
+extern void add_to_page_cache_locked(struct page *page,
+		struct address_space *mapping, const unsigned long index);
 
 extern void ___wait_on_page(struct page *);
 
diff -urN linux-2.4.7-pre8-vanilla/kernel/ksyms.c linux-2.4.7-pre8-tng-mrproper/kernel/ksyms.c
--- linux-2.4.7-pre8-vanilla/kernel/ksyms.c	Thu Jul 19 18:53:20 2001
+++ linux-2.4.7-pre8-tng-mrproper/kernel/ksyms.c	Thu Jul 19 23:35:03 2001
@@ -195,6 +195,7 @@
 EXPORT_SYMBOL(unlock_buffer);
 EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(___wait_on_page);
+EXPORT_SYMBOL(create_empty_buffers);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(block_read_full_page);
 EXPORT_SYMBOL(block_prepare_write);
@@ -244,6 +245,8 @@
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(__find_lock_page);
+EXPORT_SYMBOL(__find_page_nolock);
+EXPORT_SYMBOL(__add_to_page_cache);
 EXPORT_SYMBOL(grab_cache_page);
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(vfs_readlink);
diff -urN linux-2.4.7-pre8-vanilla/mm/filemap.c linux-2.4.7-pre8-tng-mrproper/mm/filemap.c
--- linux-2.4.7-pre8-vanilla/mm/filemap.c	Thu Jul 19 18:53:20 2001
+++ linux-2.4.7-pre8-tng-mrproper/mm/filemap.c	Thu Jul 19 20:33:18 2001
@@ -321,7 +321,19 @@
 	return NULL;
 }
 
-static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
+/**
+ * __find_page_nolock - find a page given its hash without locking it
+ * @mapping:	address space mapping of the page we are looking for
+ * @offset:	offset into the page cache of @mapping to find 
+ * @page:	the first page in the hash
+ *
+ * This finds a page given it's hash without taking any locks, thus the caller
+ * needs to hold the pagecache_lock spinlock.
+ *
+ * Return the found page or NULL, if the page is not present.
+ */
+inline struct page *__find_page_nolock(struct address_space *mapping,
+		const unsigned long offset, struct page *page)
 {
 	goto inside;
 
@@ -504,13 +516,19 @@
 	spin_unlock(&pagecache_lock);
 }
 
-/*
- * Add a page to the inode page cache.
+/**
+ * add_to_page_cache_locked - add a locked page to the page cache
+ * @page:	the page to add
+ * @mapping:	address space mapping into which to insert the @page
+ * @index:	offset into the page cache of @mapping at which to insert @page
  *
- * The caller must have locked the page and 
- * set all the page flags correctly..
+ * This adds a page to the inode page cache.
+ *
+ * The caller must have locked the page and set all the page flags correctly,
+ * but must not hold the pagecache_lock spinlock as this function acquires it.
  */
-void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index)
+void add_to_page_cache_locked(struct page *page, struct address_space *mapping,
+		const unsigned long index)
 {
 	if (!PageLocked(page))
 		BUG();
@@ -524,20 +542,30 @@
 	spin_unlock(&pagecache_lock);
 }
 
-/*
- * This adds a page to the page cache, starting out as locked,
- * owned by us, but unreferenced, not uptodate and with no errors.
+/**
+ * __add_to_page_cache - add a page to the page cache
+ * @page:	the page to add
+ * @mapping:	address space mapping into which to insert the @page
+ * @offset:	offset into the page cache of @mapping at which to insert @page
+ * @hash:	hash for the @page, obtained with page_hash(@mapping, @offset)
+ *
+ * This adds a page to the page cache, starting out as locked, owned by us,
+ * but unreferenced, not uptodate and with no errors.
+ *
+ * Caller needs to hold the pagecache_lock spinlock.
  */
-static inline void __add_to_page_cache(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+inline void __add_to_page_cache(struct page *page,
+		struct address_space *mapping, const unsigned long offset,
+		struct page **hash)
 {
 	unsigned long flags;
 
 	if (PageLocked(page))
 		BUG();
 
-	flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_dirty) | (1 << PG_referenced) | (1 << PG_arch_1) | (1 << PG_checked));
+	flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) |
+			(1 << PG_dirty) | (1 << PG_referenced) |
+			(1 << PG_arch_1) | (1 << PG_checked));
 	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
 	page->index = offset;
@@ -546,7 +574,21 @@
 	lru_cache_add(page);
 }
 
-void add_to_page_cache(struct page * page, struct address_space * mapping, unsigned long offset)
+/**
+ * add_to_page_cache - add a page to the page cache
+ * @page:	the page to add
+ * @mapping:	address space mapping into which to insert the @page
+ * @offset:	offset into the page cache of @mapping at which to insert @page
+ *
+ * This adds a page to the page cache, starting out as locked, owned by us,
+ * but unreferenced, not uptodate and with no errors.
+ *
+ * Caller must not hold the pagecache_lock spinlock as this function acquires
+ * it. If you already own the pagecache_lock, use the inlined
+ * __add_to_page_cache() function instead.
+ */
+void add_to_page_cache(struct page *page, struct address_space *mapping,
+		const unsigned long offset)
 {
 	spin_lock(&pagecache_lock);
 	__add_to_page_cache(page, mapping, offset, page_hash(mapping, offset));
