Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268685AbRGZUPh>; Thu, 26 Jul 2001 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267771AbRGZUP2>; Thu, 26 Jul 2001 16:15:28 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63506 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268685AbRGZUPL>; Thu, 26 Jul 2001 16:15:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Optimization for use-once pages (updated to 2.4.7)
Date: Thu, 26 Jul 2001 22:19:56 +0200
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Message-Id: <01072622195600.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Here is the use-once patch, updated to 2.4.7.

For my test load, I noticed that the stock 2.4.7 is a little faster
and 2.4.7+use.once is a little bit slower than 2.4.5+use.once.  But
the patch still turns in a performance improvement of about 6% over
the stock kernel.

I investigated this a little bit and what I saw was some very erratic
behavior of the inactive lists.  In particular, both free counts and
inactive_dirty length would gyrate wildly while inactive_dirty stayed
unchanged for long periods.  This is for both stock and patched
kernels.  Quite different from the 2.4.5 behaviour, and not very nice
looking.

I think what this means is, we need to take a good hard look at the
way the queues are balanced.  Hmmm, I mean *yet another* good hard
look.

To apply:

  cd /usr/src/your-2.4.7-tree
  patch <this.patch -p0

--- ../2.4.7.clean/mm/filemap.c	Wed Jul 11 23:52:58 2001
+++ ./mm/filemap.c	Thu Jul 26 16:40:53 2001
@@ -778,51 +778,6 @@
 #endif
 
 /*
- * We combine this with read-ahead to deactivate pages when we
- * think there's sequential IO going on. Note that this is
- * harmless since we don't actually evict the pages from memory
- * but just move them to the inactive list.
- *
- * TODO:
- * - make the readahead code smarter
- * - move readahead to the VMA level so we can do the same
- *   trick with mmap()
- *
- * Rik van Riel, 2000
- */
-static void drop_behind(struct file * file, unsigned long index)
-{
-	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
-	unsigned long start;
-
-	/* Nothing to drop-behind if we're on the first page. */
-	if (!index)
-		return;
-
-	if (index > file->f_rawin)
-		start = index - file->f_rawin;
-	else
-		start = 0;
-
-	/*
-	 * Go backwards from index-1 and drop all pages in the
-	 * readahead window. Since the readahead window may have
-	 * been increased since the last time we were called, we
-	 * stop when the page isn't there.
-	 */
-	spin_lock(&pagecache_lock);
-	while (--index >= start) {
-		page = __find_page_simple(mapping, index);
-		if (!page)
-			break;
-		deactivate_page(page);
-	}
-	spin_unlock(&pagecache_lock);
-}
-
-/*
  * Read-ahead profiling information
  * --------------------------------
  * Every PROFILE_MAXREADCOUNT, the following information is written 
@@ -1041,12 +996,6 @@
 		if (filp->f_ramax > max_readahead)
 			filp->f_ramax = max_readahead;
 
-		/*
-		 * Move the pages that have already been passed
-		 * to the inactive list.
-		 */
-		drop_behind(filp, index);
-
 #ifdef PROFILE_READAHEAD
 		profile_readahead((reada_ok == 2), filp);
 #endif
@@ -1055,6 +1004,21 @@
 	return;
 }
 
+/*
+ * Optimization for use-once file pages: queue immediately for eviction,
+ * but check later for additional uses before actually evicting.
+ *
+ * Daniel Phillips, 7/2001
+ */
+
+static inline void check_used_once (struct page *page)
+{
+	if (!page->age)
+	{
+		page->age = PAGE_AGE_START;
+		ClearPageReferenced(page);
+	}
+}
 
 /*
  * This is a generic file read routine, and uses the
@@ -1171,7 +1135,8 @@
 		offset += ret;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
-	
+
+		check_used_once (page);
 		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
@@ -2608,7 +2573,6 @@
 	while (count) {
 		unsigned long index, offset;
 		char *kaddr;
-		int deactivate = 1;
 
 		/*
 		 * Try to find the page in the cache. If it isn't there,
@@ -2617,10 +2581,8 @@
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count) {
+		if (bytes > count)
 			bytes = count;
-			deactivate = 0;
-		}
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2664,8 +2626,7 @@
 unlock:
 		/* Mark it unlocked again and drop the page.. */
 		UnlockPage(page);
-		if (deactivate)
-			deactivate_page(page);
+		check_used_once(page);
 		page_cache_release(page);
 
 		if (status < 0)
--- ../2.4.7.clean/mm/swap.c	Mon Jan 22 22:30:21 2001
+++ ./mm/swap.c	Thu Jul 26 15:59:30 2001
@@ -231,11 +231,8 @@
 	spin_lock(&pagemap_lru_lock);
 	if (!PageLocked(page))
 		BUG();
-	DEBUG_ADD_PAGE
-	add_page_to_active_list(page);
-	/* This should be relatively rare */
-	if (!page->age)
-		deactivate_page_nolock(page);
+	add_page_to_inactive_dirty_list(page);
+	page->age = 0;
 	spin_unlock(&pagemap_lru_lock);
 }
 
--- ../2.4.7.clean/mm/vmscan.c	Mon Jul  9 19:18:50 2001
+++ ./mm/vmscan.c	Thu Jul 26 15:59:30 2001
@@ -355,10 +355,10 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1)) {
+		if (PageReferenced(page) || (!page->buffers && page_count(page) > 1)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_active_list(page);
+			page->age = PAGE_AGE_START;
 			continue;
 		}
 
@@ -453,11 +453,11 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1) ||
+		if (PageReferenced(page) || (!page->buffers && page_count(page) > 1) ||
 				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			page->age = PAGE_AGE_START;
 			continue;
 		}
 
