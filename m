Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSFIO5T>; Sun, 9 Jun 2002 10:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317626AbSFIO5S>; Sun, 9 Jun 2002 10:57:18 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:50648 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317625AbSFIO5P>; Sun, 9 Jun 2002 10:57:15 -0400
Date: Sun, 9 Jun 2002 08:57:04 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] list macros for mm (18 occ)
Message-ID: <Pine.LNX.4.44.0206090840040.26112-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the new list macros for mm

diff -Nur linus-2.5/mm/filemap.c thunder-2.5/mm/filemap.c
--- linus-2.5/mm/filemap.c	Sun Jun  9 04:17:28 2002
+++ thunder-2.5/mm/filemap.c	Sun Jun  9 07:22:20 2002
@@ -215,8 +215,7 @@
 			failed = TestSetPageLocked(page);
 			if (!failed && PageWriteback(page)) {
 				unlock_page(page);
-				list_del(head);
-				list_add_tail(head, curr);
+				list_move_tail(head, curr);
 				write_unlock(&mapping->page_lock);
 				wait_on_page_writeback(page);
 				page_cache_release(page);
@@ -325,8 +324,7 @@
 	 */
 	if (page_count(page) == 1 + !!page_has_buffers(page)) {
 		/* Restart after this page */
-		list_del(head);
-		list_add_tail(head, curr);
+		list_move_tail(head, curr);
 
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
@@ -334,8 +332,7 @@
 	} else {
 		if (page_has_buffers(page)) {
 			/* Restart after this page */
-			list_del(head);
-			list_add_tail(head, curr);
+			list_move_tail(head, curr);
 
 			page_cache_get(page);
 			write_unlock(&mapping->page_lock);
@@ -381,8 +378,7 @@
 			}
 		} else {
 			/* Restart on this page */
-			list_del(head);
-			list_add(head, curr);
+			list_move(head, curr);
 
 			page_cache_get(page);
 			write_unlock(&mapping->page_lock);
@@ -484,11 +480,10 @@
         while (!list_empty(&mapping->locked_pages)) {
 		struct page *page = list_entry(mapping->locked_pages.next, struct page, list);
 
-		list_del(&page->list);
 		if (PageDirty(page))
-			list_add(&page->list, &mapping->dirty_pages);
+			list_move(&page->list, &mapping->dirty_pages);
 		else
-			list_add(&page->list, &mapping->clean_pages);
+			list_move(&page->list, &mapping->clean_pages);
 
 		if (!PageWriteback(page))
 			continue;
diff -Nur linus-2.5/mm/page-writeback.c thunder-2.5/mm/page-writeback.c
--- linus-2.5/mm/page-writeback.c	Sun Jun  9 04:17:28 2002
+++ thunder-2.5/mm/page-writeback.c	Sun Jun  9 07:24:57 2002
@@ -366,10 +366,9 @@
 			/* FIXME: batch this up */
 			if (!PageActive(page) && PageLRU(page)) {
 				spin_lock(&pagemap_lru_lock);
-				if (!PageActive(page) && PageLRU(page)) {
-					list_del(&page->lru);
-					list_add(&page->lru, &inactive_list);
-				}
+				if (!PageActive(page) && PageLRU(page))
+					list_move(&page->lru, &inactive_list);
+
 				spin_unlock(&pagemap_lru_lock);
 			}
 			err = writepage(page);
@@ -424,9 +423,9 @@
 		wait_on_page_writeback(page);
 
 	write_lock(&mapping->page_lock);
-	list_del(&page->list);
+
 	if (TestClearPageDirty(page)) {
-		list_add(&page->list, &mapping->locked_pages);
+		list_move(&page->list, &mapping->locked_pages);
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
 		ret = mapping->a_ops->writepage(page);
@@ -437,7 +436,7 @@
 		}
 		page_cache_release(page);
 	} else {
-		list_add(&page->list, &mapping->clean_pages);
+		list_move(&page->list, &mapping->clean_pages);
 		write_unlock(&mapping->page_lock);
 		unlock_page(page);
 	}
@@ -512,8 +511,7 @@
 
 	if (!TestSetPageDirty(page)) {
 		write_lock(&mapping->page_lock);
-		list_del(&page->list);
-		list_add(&page->list, &mapping->dirty_pages);
+		list_move(&page->list, &mapping->dirty_pages);
 		write_unlock(&mapping->page_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
@@ -546,8 +544,7 @@
 
 		if (mapping) {
 			write_lock(&mapping->page_lock);
-			list_del(&page->list);
-			list_add(&page->list, &mapping->dirty_pages);
+			list_move(&page->list, &mapping->dirty_pages);
 			write_unlock(&mapping->page_lock);
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		}
diff -Nur linus-2.5/mm/slab.c thunder-2.5/mm/slab.c
--- linus-2.5/mm/slab.c	Sun Jun  9 04:17:29 2002
+++ thunder-2.5/mm/slab.c	Sun Jun  9 08:52:03 2002
@@ -1280,10 +1280,8 @@
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
 	slabp->free=slab_bufctl(slabp)[slabp->free];
 
-	if (unlikely(slabp->free == BUFCTL_END)) {
-		list_del(&slabp->list);
-		list_add(&slabp->list, &cachep->slabs_full);
-	}
+	if (unlikely(slabp->free == BUFCTL_END))
+		list_move(&slabp->list, &cachep->slabs_full);
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
 		if (kmem_check_poison_obj(cachep, objp))
@@ -1320,8 +1318,7 @@
 		entry = slabs_free->next;			\
 		if (unlikely(entry == slabs_free))		\
 			goto alloc_new_slab;			\
-		list_del(entry);				\
-		list_add(entry, slabs_partial);			\
+		list_move(entry, slabs_partial);		\
 	}							\
 								\
 	slabp = list_entry(entry, slab_t, list);		\
@@ -1347,8 +1344,7 @@
 			entry = slabs_free->next;
 			if (unlikely(entry == slabs_free))
 				break;
-			list_del(entry);
-			list_add(entry, slabs_partial);
+			list_move(entry, slabs_partial);
 		}
 
 		slabp = list_entry(entry, slab_t, list);
@@ -1487,15 +1483,12 @@
 	/* fixup slab chains */
 	{
 		int inuse = slabp->inuse;
-		if (unlikely(!--slabp->inuse)) {
+		if (unlikely(!--slabp->inuse))
 			/* Was partial or full, now empty. */
-			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_free);
-		} else if (unlikely(inuse == cachep->num)) {
+			list_move(&slabp->list, &cachep->slabs_free);
+		else if (unlikely(inuse == cachep->num))
 			/* Was full. */
-			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_partial);
-		}
+			list_move(&slabp->list, &cachep->slabs_partial);
 	}
 }
 
diff -Nur linus-2.5/mm/swap_state.c thunder-2.5/mm/swap_state.c
--- linus-2.5/mm/swap_state.c	Sun Jun  9 04:17:29 2002
+++ thunder-2.5/mm/swap_state.c	Sun Jun  9 07:25:38 2002
@@ -256,8 +256,7 @@
 		SetPageDirty(page);
 		___add_to_page_cache(page, mapping, index);
 		/* fix that up */
-		list_del(&page->list);
-		list_add(&page->list, &mapping->dirty_pages);
+		list_move(&page->list, &mapping->dirty_pages);
 		write_unlock(&mapping->page_lock);
 		write_unlock(&swapper_space.page_lock);
 
diff -Nur linus-2.5/mm/vmscan.c thunder-2.5/mm/vmscan.c
--- linus-2.5/mm/vmscan.c	Sun Jun  9 04:17:29 2002
+++ thunder-2.5/mm/vmscan.c	Sun Jun  9 08:52:47 2002
@@ -409,8 +409,7 @@
 		if (unlikely(PageActive(page)))
 			BUG();
 
-		list_del(entry);
-		list_add(entry, &inactive_list);
+		list_move(entry, &inactive_list);
 
 		/*
 		 * Zero page counts can happen because we unlink the pages
@@ -604,8 +603,7 @@
 		page = list_entry(entry, struct page, lru);
 		entry = entry->prev;
 		if (TestClearPageReferenced(page)) {
-			list_del(&page->lru);
-			list_add(&page->lru, &active_list);
+			list_move(&page->lru, &active_list);
 			continue;
 		}
 

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

