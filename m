Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSGQFWt>; Wed, 17 Jul 2002 01:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318218AbSGQFVa>; Wed, 17 Jul 2002 01:21:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17676 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318222AbSGQFTY>;
	Wed, 17 Jul 2002 01:19:24 -0400
Message-ID: <3D3500E2.9CB994A7@zip.com.au>
Date: Tue, 16 Jul 2002 22:30:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/13] remove add_to_page_cache_unique()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A tasty patch from Hugh Dickens.  radix_tree_insert() fails if something
was already present at the target index, so that error can be
propagated back through add_to_page_cache().  Hence
add_to_page_cache_unique() is obsolete.

Hugh's patch removes add_to_page_cache_unique() and cleans up a bunch of
stuff.



 fs/mpage.c              |    2 
 include/linux/pagemap.h |    2 
 mm/filemap.c            |  182 +++++++++++++-----------------------------------
 mm/readahead.c          |    2 
 mm/swap_state.c         |    3 
 5 files changed, 53 insertions(+), 138 deletions(-)

--- 2.5.26/fs/mpage.c~hugh-add_to_page_cache	Tue Jul 16 21:47:15 2002
+++ 2.5.26-akpm/fs/mpage.c	Tue Jul 16 21:47:15 2002
@@ -268,7 +268,7 @@ mpage_readpages(struct address_space *ma
 
 		prefetchw(&page->flags);
 		list_del(&page->list);
-		if (!add_to_page_cache_unique(page, mapping, page->index))
+		if (!add_to_page_cache(page, mapping, page->index))
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
 					&last_block_in_bio, get_block);
--- 2.5.26/include/linux/pagemap.h~hugh-add_to_page_cache	Tue Jul 16 21:47:15 2002
+++ 2.5.26-akpm/include/linux/pagemap.h	Tue Jul 16 21:47:15 2002
@@ -52,8 +52,6 @@ extern struct page * read_cache_page(str
 
 extern int add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index);
-extern int add_to_page_cache_unique(struct page *page,
-		struct address_space *mapping, unsigned long index);
 
 static inline void ___add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index)
--- 2.5.26/mm/filemap.c~hugh-add_to_page_cache	Tue Jul 16 21:47:15 2002
+++ 2.5.26-akpm/mm/filemap.c	Tue Jul 16 21:59:35 2002
@@ -520,8 +520,6 @@ int filemap_fdatawait(struct address_spa
  * This adds a page to the page cache, starting out as locked, unreferenced,
  * not uptodate and with no errors.
  *
- * The caller must hold a write_lock on mapping->page_lock.
- *
  * This function is used for two things: adding newly allocated pagecache
  * pages and for moving existing anon pages into swapcache.
  *
@@ -533,44 +531,20 @@ int filemap_fdatawait(struct address_spa
  * SetPageLocked() is ugly-but-OK there too.  The required page state has been
  * set up by swap_out_add_to_swap_cache().
  */
-static int __add_to_page_cache(struct page *page,
+int add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long offset)
 {
-	if (radix_tree_insert(&mapping->page_tree, offset, page) == 0) {
+	int error;
+
+	write_lock(&mapping->page_lock);
+	error = radix_tree_insert(&mapping->page_tree, offset, page);
+	if (!error) {
 		SetPageLocked(page);
 		ClearPageDirty(page);
 		___add_to_page_cache(page, mapping, offset);
 		page_cache_get(page);
-		return 0;
 	}
-	return -ENOMEM;
-}
-
-int add_to_page_cache(struct page *page,
-		struct address_space *mapping, unsigned long offset)
-{
-	write_lock(&mapping->page_lock);
-	if (__add_to_page_cache(page, mapping, offset) < 0)
-		goto nomem;
 	write_unlock(&mapping->page_lock);
-	lru_cache_add(page);
-	return 0;
-nomem:
-	write_unlock(&mapping->page_lock);
-	return -ENOMEM;
-}
-
-int add_to_page_cache_unique(struct page *page,
-		struct address_space *mapping, unsigned long offset)
-{
-	struct page *alias;
-	int error = -EEXIST;
-
-	write_lock(&mapping->page_lock);
-	if (!(alias = radix_tree_lookup(&mapping->page_tree, offset)))
-		error = __add_to_page_cache(page, mapping, offset);
-	write_unlock(&mapping->page_lock);
-
 	if (!error)
 		lru_cache_add(page);
 	return error;
@@ -587,17 +561,11 @@ static int page_cache_read(struct file *
 	struct page *page; 
 	int error;
 
-	read_lock(&mapping->page_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
-	read_unlock(&mapping->page_lock);
-	if (page)
-		return 0;
-
 	page = page_cache_alloc(mapping);
 	if (!page)
 		return -ENOMEM;
 
-	error = add_to_page_cache_unique(page, mapping, offset);
+	error = add_to_page_cache(page, mapping, offset);
 	if (!error) {
 		error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
@@ -759,28 +727,31 @@ struct page *find_trylock_page(struct ad
 	return page;
 }
 
-/*
- * Must be called with the mapping lock held for writing.
- * Will return with it held for writing, but it may be dropped
- * while locking the page.
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
  */
-static struct page *__find_lock_page(struct address_space *mapping,
-					unsigned long offset)
+struct page *find_lock_page(struct address_space *mapping,
+				unsigned long offset)
 {
 	struct page *page;
 
-	/*
-	 * We scan the hash list read-only. Addition to and removal from
-	 * the hash-list needs a held write-lock.
-	 */
+	read_lock(&mapping->page_lock);
 repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
-			write_unlock(&mapping->page_lock);
+			read_unlock(&mapping->page_lock);
 			lock_page(page);
-			write_lock(&mapping->page_lock);
+			read_lock(&mapping->page_lock);
 
 			/* Has the page been truncated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
@@ -790,34 +761,7 @@ repeat:
 			}
 		}
 	}
-	return page;
-}
-
-/**
- * find_lock_page - locate, pin and lock a pagecache page
- *
- * @mapping - the address_space to search
- * @offset - the page index
- *
- * Locates the desired pagecache page, locks it, increments its reference
- * count and returns its address.
- *
- * Returns zero if the page was not present. find_lock_page() may sleep.
- */
-
-/*
- * The write_lock is unfortunate, but __find_lock_page() requires that on
- * behalf of find_or_create_page().  We could just clone __find_lock_page() -
- * one for find_lock_page(), one for find_or_create_page()...
- */
-struct page *find_lock_page(struct address_space *mapping,
-				unsigned long offset)
-{
-	struct page *page;
-
-	write_lock(&mapping->page_lock);
-	page = __find_lock_page(mapping, offset);
-	write_unlock(&mapping->page_lock);
+	read_unlock(&mapping->page_lock);
 	return page;
 }
 
@@ -842,32 +786,25 @@ struct page *find_lock_page(struct addre
 struct page *find_or_create_page(struct address_space *mapping,
 		unsigned long index, unsigned int gfp_mask)
 {
-	struct page *page;
-
+	struct page *page, *cached_page = NULL;
+	int err;
+repeat:
 	page = find_lock_page(mapping, index);
 	if (!page) {
-		struct page *newpage = alloc_page(gfp_mask);
-		if (newpage) {
-			write_lock(&mapping->page_lock);
-			page = __find_lock_page(mapping, index);
-			if (likely(!page)) {
-				page = newpage;
-				if (__add_to_page_cache(page, mapping, index)) {
-					write_unlock(&mapping->page_lock);
-					page_cache_release(page);
-					page = NULL;
-					goto out;
-				}
-				newpage = NULL;
-			}
-			write_unlock(&mapping->page_lock);
-			if (newpage == NULL)
-				lru_cache_add(page);
-			else 
-				page_cache_release(newpage);
+		if (!cached_page) {
+			cached_page = alloc_page(gfp_mask);
+			if (!cached_page)
+				return NULL;
 		}
+		err = add_to_page_cache(cached_page, mapping, index);
+		if (!err) {
+			page = cached_page;
+			cached_page = NULL;
+		} else if (err == -EEXIST)
+			goto repeat;
 	}
-out:
+	if (cached_page)
+		page_cache_release(cached_page);
 	return page;
 }
 
@@ -901,7 +838,7 @@ grab_cache_page_nowait(struct address_sp
 		return NULL;
 	}
 	page = alloc_pages(mapping->gfp_mask & ~__GFP_FS, 0);
-	if (page && add_to_page_cache_unique(page, mapping, index)) {
+	if (page && add_to_page_cache(page, mapping, index)) {
 		page_cache_release(page);
 		page = NULL;
 	}
@@ -968,18 +905,16 @@ void do_generic_file_read(struct file * 
 		/*
 		 * Try to find the data in the page cache..
 		 */
-
-		write_lock(&mapping->page_lock);
+find_page:
+		read_lock(&mapping->page_lock);
 		page = radix_tree_lookup(&mapping->page_tree, index);
 		if (!page) {
-			write_unlock(&mapping->page_lock);
+			read_unlock(&mapping->page_lock);
 			handle_ra_thrashing(filp);
-			write_lock(&mapping->page_lock);
 			goto no_cached_page;
 		}
-found_page:
 		page_cache_get(page);
-		write_unlock(&mapping->page_lock);
+		read_unlock(&mapping->page_lock);
 
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
@@ -1059,40 +994,23 @@ no_cached_page:
 		/*
 		 * Ok, it wasn't cached, so we need to create a new
 		 * page..
-		 *
-		 * We get here with the page cache lock held.
 		 */
 		if (!cached_page) {
-			write_unlock(&mapping->page_lock);
 			cached_page = page_cache_alloc(mapping);
 			if (!cached_page) {
 				desc->error = -ENOMEM;
 				break;
 			}
-
-			/*
-			 * Somebody may have added the page while we
-			 * dropped the page cache lock. Check for that.
-			 */
-			write_lock(&mapping->page_lock);
-			page = radix_tree_lookup(&mapping->page_tree, index);
-			if (page)
-				goto found_page;
 		}
-
-		/*
-		 * Ok, add the new page to the hash-queues...
-		 */
-		if (__add_to_page_cache(cached_page, mapping, index) < 0) {
-			write_unlock(&mapping->page_lock);
-			desc->error = -ENOMEM;
+		error = add_to_page_cache(cached_page, mapping, index);
+		if (error) {
+			if (error == -EEXIST)
+				goto find_page;
+			desc->error = error;
 			break;
 		}
 		page = cached_page;
-		write_unlock(&mapping->page_lock);
-		lru_cache_add(page);		
 		cached_page = NULL;
-
 		goto readpage;
 	}
 
@@ -1875,7 +1793,7 @@ repeat:
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
-		err = add_to_page_cache_unique(cached_page, mapping, index);
+		err = add_to_page_cache(cached_page, mapping, index);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err < 0) {
@@ -1948,7 +1866,7 @@ repeat:
 			if (!*cached_page)
 				return NULL;
 		}
-		err = add_to_page_cache_unique(*cached_page, mapping, index);
+		err = add_to_page_cache(*cached_page, mapping, index);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err == 0) {
--- 2.5.26/mm/readahead.c~hugh-add_to_page_cache	Tue Jul 16 21:47:15 2002
+++ 2.5.26-akpm/mm/readahead.c	Tue Jul 16 21:59:35 2002
@@ -43,7 +43,7 @@ read_pages(struct file *file, struct add
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, list);
 		list_del(&page->list);
-		if (!add_to_page_cache_unique(page, mapping, page->index))
+		if (!add_to_page_cache(page, mapping, page->index))
 			mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
 	}
--- 2.5.26/mm/swap_state.c~hugh-add_to_page_cache	Tue Jul 16 21:47:15 2002
+++ 2.5.26-akpm/mm/swap_state.c	Tue Jul 16 21:47:15 2002
@@ -75,8 +75,7 @@ int add_to_swap_cache(struct page *page,
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-
-	error = add_to_page_cache_unique(page, &swapper_space, entry.val);
+	error = add_to_page_cache(page, &swapper_space, entry.val);
 	if (error != 0) {
 		swap_free(entry);
 		if (error == -EEXIST)

.
