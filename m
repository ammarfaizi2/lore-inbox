Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSGDXua>; Thu, 4 Jul 2002 19:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSGDXsN>; Thu, 4 Jul 2002 19:48:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41997 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315202AbSGDXq2>;
	Thu, 4 Jul 2002 19:46:28 -0400
Message-ID: <3D24E04A.F4A8B170@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@suse.de>
Subject: [patch 18/27] always update page->flags atomically
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



move_from_swap_cache() and move_to_swap_cache() are playing with
page->flags nonatomically.  The page is on the LRU at the time and
another CPU could be altering page->flags concurrently.

The patch converts those functions to use atomic operations.

It also rationalises the number of bits which are cleared.  It's not
really clear to me what page flags we really want to set to a known
state in there.

It had no right to go clearing PG_arch_1.  I'm now clearing PG_arch_1
inside rmqueue() which is still a bit presumptious.

btw: shmem uses PAGE_CACHE_SIZE and swapper_space uses PAGE_SIZE.  I've
been carefully maintaining the distinction, but it looks like shmem
will break if we ever do make these values different.


Also, __add_to_page_cache() was performing a non-atomic RMW against
page->flags, under the assumption that it was a newly allocated page
which no other CPU would look at.  Not true - this function is used for
moving anon pages into swapcache.  Those anon pages are on the LRU -
other CPUs can be performing operations against page->flags while
__add_to_swap_cache is stomping on them.  This had me running around in
circles for two days.

So let's move the initialisation of the page state into rmqueue(),
where the page really is new (could do it in page_cache_alloc,
perhaps).

The SetPageLocked() in __add_to_page_cache() is also rather curious. 
Seems OK for both pagecache and swapcache so I covered that with a
comment.


2.4 has the same problem.  Basically, add_to_swap_cache() can stomp on
another CPU's manipulation of page->flags.  After a quick review of the
code there, it is barely conceivable that a concurrent refill_inactve()
could get its PG_referenced and PG_active bits scribbled on.  Rather
unlikely because swap_out() will probably see PageActive() and bale
out.

Also, mark_dirty_kiobuf() could have its PG_dirty bit accidentally
cleared (but try_to_swap_out() sets it again later).

But there may be other code paths.  Really, I think this needs fixing
in 2.4 - it's horrid.



 filemap.c    |   36 ++++++++++++++++++++++--------------
 page_alloc.c |   45 +++++++++++++++++++++------------------------
 swap_state.c |   21 +++++++++++++++------
 vmscan.c     |    2 ++
 4 files changed, 60 insertions(+), 44 deletions(-)

--- 2.5.24/mm/swap_state.c~page-flags-atomicity	Thu Jul  4 16:17:26 2002
+++ 2.5.24-akpm/mm/swap_state.c	Thu Jul  4 16:17:26 2002
@@ -153,9 +153,13 @@ int move_to_swap_cache(struct page *page
 
 		/* Add it to the swap cache */
 		*pslot = page;
-		page->flags &= ~(1 << PG_uptodate | 1 << PG_error
-				| 1 << PG_referenced | 1 << PG_arch_1
-				| 1 << PG_checked);
+		/*
+		 * This code used to clear PG_uptodate, PG_error, PG_arch1,
+		 * PG_referenced and PG_checked.  What _should_ it clear?
+		 */
+		ClearPageUptodate(page);
+		ClearPageReferenced(page);
+
 		SetPageLocked(page);
 		ClearPageDirty(page);
 		___add_to_page_cache(page, &swapper_space, entry.val);
@@ -198,9 +202,14 @@ int move_from_swap_cache(struct page *pa
 		__delete_from_swap_cache(page);
 
 		*pslot = page;
-		page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
-				 1 << PG_referenced | 1 << PG_arch_1 |
-				 1 << PG_checked);
+
+		/*
+		 * This code used to clear PG_uptodate, PG_error, PG_referenced,
+		 * PG_arch_1 and PG_checked.  It's not really clear why.
+		 */
+		ClearPageUptodate(page);
+		ClearPageReferenced(page);
+
 		/*
 		 * ___add_to_page_cache puts the page on ->clean_pages,
 		 * but it's dirty.  If it's on ->clean_pages, it will basically
--- 2.5.24/mm/filemap.c~page-flags-atomicity	Thu Jul  4 16:17:26 2002
+++ 2.5.24-akpm/mm/filemap.c	Thu Jul  4 16:22:04 2002
@@ -515,24 +515,32 @@ int filemap_fdatawait(struct address_spa
 }
 
 /*
- * This adds a page to the page cache, starting out as locked,
- * owned by us, but unreferenced, not uptodate and with no errors.
- * The caller must hold a write_lock on the mapping->page_lock.
+ * This adds a page to the page cache, starting out as locked, unreferenced,
+ * not uptodate and with no errors.
+ *
+ * The caller must hold a write_lock on mapping->page_lock.
+ *
+ * This function is used for two things: adding newly allocated pagecache
+ * pages and for moving existing anon pages into swapcache.
+ *
+ * In the case of pagecache pages, the page is new, so we can just run
+ * SetPageLocked() against it.  The other page state flags were set by
+ * rmqueue()
+ *
+ * In the case of swapcache, try_to_swap_out() has already locked the page, so
+ * SetPageLocked() is ugly-but-OK there too.  The required page state has been
+ * set up by swap_out_add_to_swap_cache().
  */
 static int __add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long offset)
 {
-	page_cache_get(page);
-	if (radix_tree_insert(&mapping->page_tree, offset, page) < 0)
-		goto nomem;
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
-			1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
-	SetPageLocked(page);
-	ClearPageDirty(page);
-	___add_to_page_cache(page, mapping, offset);
-	return 0;
- nomem:
-	page_cache_release(page);
+	if (radix_tree_insert(&mapping->page_tree, offset, page) == 0) {
+		SetPageLocked(page);
+		ClearPageDirty(page);
+		___add_to_page_cache(page, mapping, offset);
+		page_cache_get(page);
+		return 0;
+	}
 	return -ENOMEM;
 }
 
--- 2.5.24/mm/page_alloc.c~page-flags-atomicity	Thu Jul  4 16:17:26 2002
+++ 2.5.24-akpm/mm/page_alloc.c	Thu Jul  4 16:22:09 2002
@@ -99,7 +99,6 @@ static void __free_pages_ok (struct page
 	if (PageWriteback(page))
 		BUG();
 	ClearPageDirty(page);
-	page->flags &= ~(1<<PG_referenced);
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
@@ -188,6 +187,24 @@ static inline struct page * expand (zone
 	return page;
 }
 
+/*
+ * This page is about to be returned from the page allocator
+ */
+static inline void prep_new_page(struct page *page)
+{
+	BUG_ON(page->mapping);
+	BUG_ON(PagePrivate(page));
+	BUG_ON(PageLocked(page));
+	BUG_ON(PageLRU(page));
+	BUG_ON(PageActive(page));
+	BUG_ON(PageDirty(page));
+	BUG_ON(PageWriteback(page));
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+			1 << PG_referenced | 1 << PG_arch_1 |
+			1 << PG_checked);
+	set_page_count(page, 1);
+}
+
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
@@ -217,13 +234,9 @@ static struct page * rmqueue(zone_t *zon
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);
 
-			set_page_count(page, 1);
 			if (bad_range(zone, page))
 				BUG();
-			if (PageLRU(page))
-				BUG();
-			if (PageActive(page))
-				BUG();
+			prep_new_page(page);
 			return page;	
 		}
 		curr_order++;
@@ -296,25 +309,9 @@ static struct page * balance_classzone(z
 				tmp = list_entry(entry, struct page, list);
 				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
 					list_del(entry);
-					current->nr_local_pages--;
-					set_page_count(tmp, 1);
 					page = tmp;
-
-					if (PagePrivate(page))
-						BUG();
-					if (page->mapping)
-						BUG();
-					if (PageLocked(page))
-						BUG();
-					if (PageLRU(page))
-						BUG();
-					if (PageActive(page))
-						BUG();
-					if (PageDirty(page))
-						BUG();
-					if (PageWriteback(page))
-						BUG();
-
+					current->nr_local_pages--;
+					prep_new_page(page);
 					break;
 				}
 			} while ((entry = entry->next) != local_pages);
--- 2.5.24/mm/vmscan.c~page-flags-atomicity	Thu Jul  4 16:17:26 2002
+++ 2.5.24-akpm/mm/vmscan.c	Thu Jul  4 16:22:09 2002
@@ -64,6 +64,8 @@ swap_out_add_to_swap_cache(struct page *
 
 	current->flags &= ~PF_MEMALLOC;
 	current->flags |= PF_RADIX_TREE;
+	ClearPageUptodate(page);		/* why? */
+	ClearPageReferenced(page);		/* why? */
 	ret = add_to_swap_cache(page, entry);
 	current->flags = flags;
 	return ret;

-
