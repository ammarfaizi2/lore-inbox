Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSDRJSN>; Thu, 18 Apr 2002 05:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSDRJSM>; Thu, 18 Apr 2002 05:18:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63242 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314277AbSDRJSK>;
	Thu, 18 Apr 2002 05:18:10 -0400
Message-ID: <3CBE8F34.6B449626@zip.com.au>
Date: Thu, 18 Apr 2002 02:17:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] pagecache locking bugfix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug which Anton found.  On the
find_or_create_page->__find_lock_page path we're performing
a read_unlock of an rwlock which is held for writing.

The patch converts that to using a write_lock throughout.

Which penalises find_lock_page() a bit.  If it shows up
on profiles then we can clone __find_lock_page() and
use read_lock()s, but for now I'd opt for saving the
cache footprint.


--- 2.5.8/mm/filemap.c~pagecache-screwup	Thu Apr 18 00:49:02 2002
+++ 2.5.8-akpm/mm/filemap.c	Thu Apr 18 01:02:20 2002
@@ -797,9 +797,9 @@ struct page *find_trylock_page(struct ad
 }
 
 /*
- * Must be called with the pagecache lock held,
- * will return with it held (but it may be dropped
- * during blocking operations..
+ * Must be called with the mapping lock held for writing.
+ * Will return with it held for writing, but it may be dropped
+ * while locking the page.
  */
 static struct page *__find_lock_page(struct address_space *mapping,
 					unsigned long offset)
@@ -815,11 +815,11 @@ repeat:
 	if (page) {
 		page_cache_get(page);
 		if (TryLockPage(page)) {
-			read_unlock(&mapping->page_lock);
+			write_unlock(&mapping->page_lock);
 			lock_page(page);
-			read_lock(&mapping->page_lock);
+			write_lock(&mapping->page_lock);
 
-			/* Has the page been re-allocated while we slept? */
+			/* Has the page been truncated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
 				UnlockPage(page);
 				page_cache_release(page);
@@ -830,25 +830,53 @@ repeat:
 	return page;
 }
 
+/**
+ * find_lock_page - locate, pin and lock a pagecache page
+ *
+ * @mapping - the address_space to search
+ * @offset - the page index
+ *
+ * Locates the desired pagecache page, locks it, increments its reference
+ * count and returns its address.
+ *
+ * Returns zero if the page was not present. find_lock_page() may sleep.
+ */
+
 /*
- * Same as the above, but lock the page too, verifying that
- * it's still valid once we own it.
+ * The write_lock is unfortunate, but __find_lock_page() requires that on
+ * behalf of find_or_create_page().  We could just clone __find_lock_page() -
+ * one for find_lock_page(), one for find_or_create_page()...
  */
-struct page * find_lock_page(struct address_space *mapping, unsigned long offset)
+struct page *find_lock_page(struct address_space *mapping,
+				unsigned long offset)
 {
 	struct page *page;
 
-	read_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	page = __find_lock_page(mapping, offset);
-	read_unlock(&mapping->page_lock);
-
+	write_unlock(&mapping->page_lock);
 	return page;
 }
 
-/*
- * Same as above, but create the page if required..
+/**
+ * find_or_create_page - locate or add a pagecache page
+ *
+ * @mapping - the page's address_space
+ * @index - the page's index into the mapping
+ * @gfp_mask - page allocation mode
+ *
+ * Locates a page in the pagecache.  If the page is not present, a new page
+ * is allocated using @gfp_mask and is added to the pagecache and to the VM's
+ * LRU list.  The returned page is locked and has its reference count
+ * incremented.
+ *
+ * find_or_create_page() may sleep, even if @gfp_flags specifies an atomic
+ * allocation!
+ *
+ * find_or_create_page() returns the desired page's address, or zero on
+ * memory exhaustion.
  */
-struct page * find_or_create_page(struct address_space *mapping,
+struct page *find_or_create_page(struct address_space *mapping,
 		unsigned long index, unsigned int gfp_mask)
 {
 	struct page *page;


-
