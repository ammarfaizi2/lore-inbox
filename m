Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316778AbSFQHUB>; Mon, 17 Jun 2002 03:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSFQGtV>; Mon, 17 Jun 2002 02:49:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18446 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316776AbSFQGri>;
	Mon, 17 Jun 2002 02:47:38 -0400
Message-ID: <3D0D86FD.E9EF1551@zip.com.au>
Date: Sun, 16 Jun 2002 23:51:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/19] grab_cache_page_nowait deadlock fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- If grab_cache_page_nowait() is to be called while holding a lock on
  a different page, it must perform memory allocations with GFP_NOFS. 
  Otherwise it could come back onto the locked page (if it's dirty) and
  deadlock.

  Also tidy this function up a bit - the checks in there were overly
  paranoid.

- In a few of places, look to see if we can avoid a buslocked cycle
  and dirtying of a cacheline.


--- 2.5.22/mm/filemap.c~grab_cache_page_nowait	Sun Jun 16 22:50:17 2002
+++ 2.5.22-akpm/mm/filemap.c	Sun Jun 16 22:50:17 2002
@@ -445,8 +445,10 @@ int fail_writepage(struct page *page)
 {
 	/* Only activate on memory-pressure, not fsync.. */
 	if (current->flags & PF_MEMALLOC) {
-		activate_page(page);
-		SetPageReferenced(page);
+		if (!PageActive(page))
+			activate_page(page);
+		if (!PageReferenced(page))
+			SetPageReferenced(page);
 	}
 
 	/* Set the page dirty again, unlock */
@@ -868,55 +870,35 @@ struct page *grab_cache_page(struct addr
  * This is intended for speculative data generators, where the data can
  * be regenerated if the page couldn't be grabbed.  This routine should
  * be safe to call while holding the lock for another page.
+ *
+ * Clear __GFP_FS when allocating the page to avoid recursion into the fs
+ * and deadlock against the caller's locked page.
  */
-struct page *grab_cache_page_nowait(struct address_space *mapping, unsigned long index)
+struct page *
+grab_cache_page_nowait(struct address_space *mapping, unsigned long index)
 {
-	struct page *page;
-
-	page = find_get_page(mapping, index);
-
-	if ( page ) {
-		if ( !TestSetPageLocked(page) ) {
-			/* Page found and locked */
-			/* This test is overly paranoid, but what the heck... */
-			if ( unlikely(page->mapping != mapping || page->index != index) ) {
-				/* Someone reallocated this page under us. */
-				unlock_page(page);
-				page_cache_release(page);
-				return NULL;
-			} else {
-				return page;
-			}
-		} else {
-			/* Page locked by someone else */
-			page_cache_release(page);
-			return NULL;
-		}
-	}
-
-	page = page_cache_alloc(mapping);
-	if (unlikely(!page))
-		return NULL;	/* Failed to allocate a page */
+	struct page *page = find_get_page(mapping, index);
 
-	if (unlikely(add_to_page_cache_unique(page, mapping, index))) {
-		/*
-		 * Someone else grabbed the page already, or
-		 * failed to allocate a radix-tree node
-		 */
+	if (page) {
+		if (!TestSetPageLocked(page))
+			return page;
 		page_cache_release(page);
 		return NULL;
 	}
-
+	page = alloc_pages(mapping->gfp_mask & ~__GFP_FS, 0);
+	if (page && add_to_page_cache_unique(page, mapping, index)) {
+		page_cache_release(page);
+		page = NULL;
+	}
 	return page;
 }
 
 /*
  * Mark a page as having seen activity.
  *
- * If it was already so marked, move it
- * to the active queue and drop the referenced
- * bit. Otherwise, just mark it for future
- * action..
+ * inactive,unreferenced	->	inactive,referenced
+ * inactive,referenced		->	active,unreferenced
+ * active,unreferenced		->	active,referenced
  */
 void mark_page_accessed(struct page *page)
 {
@@ -924,10 +906,9 @@ void mark_page_accessed(struct page *pag
 		activate_page(page);
 		ClearPageReferenced(page);
 		return;
+	} else if (!PageReferenced(page)) {
+		SetPageReferenced(page);
 	}
-
-	/* Mark the page referenced, AFTER checking for previous usage.. */
-	SetPageReferenced(page);
 }
 
 /*
@@ -2286,7 +2267,8 @@ generic_file_write(struct file *file, co
 			}
 		}
 		kunmap(page);
-		SetPageReferenced(page);
+		if (!PageReferenced(page))
+			SetPageReferenced(page);
 		unlock_page(page);
 		page_cache_release(page);
 		if (status < 0)

-
