Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291268AbSBGUUO>; Thu, 7 Feb 2002 15:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291271AbSBGUUH>; Thu, 7 Feb 2002 15:20:07 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:1700 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291268AbSBGUTz>; Thu, 7 Feb 2002 15:19:55 -0500
Date: Thu, 7 Feb 2002 20:21:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.33L.0202071255500.17850-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0202071930320.1533-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please help, someone!

Below is the plausible-looking but fatally flawed patch I
had in mind, to help us focus.  Basically, revert to 2.4.17,
but don't treat PageLRU as a BUG in __free_pages_ok, instead
let shrink_cache free it.  Notice that page_cache_release is
not quite as in 2.4.17: it has to handle a race, and this
at least puts it in the same situation as a final put_page
when PageLRU is set.

The problem is, if SMP, imagine final put_page on one CPU
racing with shrink_cache on another: once put_page_testzero
on one CPU succeeds, shrink_cache on other may __lru_cache_del,
and both CPUs go through __free_pages_ok with PageLRU clear,
page doubly freed.  Which is even worse than the current
hang-on-SMP or corrupt-LRU-on-UP.

I think Rik's separate-list method would suffer just the same.
I was naive to imagine that working with count 0 would be easy.

I'm pretty sure Andrew's add-LRU-into-page-count would deal
with this just fine, but I'm still reluctant to implement that
at this stage.  Another idea I'd be reluctant to pursue right
now, but might be good in the longer term, is just to remove
the PageLRU and PageActive BUGs from __free_pages_ok, rmqueue
and balance_classzone, let a few rare pages remain on the LRU
while free and reused; but shrink_cache's TryLockPage not play
well with __add_to_page_cache's page->flags = flags | (1 << PG_locked).
I think we don't want _irqsaves on pagemap_lru_lock.

Maybe there's a simple answer I'm not seeing,
maybe there's an awkward combination of locking which will do it,
maybe it's mathematically provable that Andrew's is the only way.
Any suggestions?

Hugh

diff -urN 2.4.18-pre8/include/linux/pagemap.h linux/include/linux/pagemap.h
--- 2.4.18-pre8/include/linux/pagemap.h	Thu Feb  7 14:38:13 2002
+++ linux/include/linux/pagemap.h	Thu Feb  7 15:31:05 2002
@@ -29,7 +29,7 @@
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
 #define page_cache_get(x)	get_page(x)
-#define page_cache_release(x)	__free_page(x)
+extern void FASTCALL(page_cache_release(struct page *));
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
diff -urN 2.4.18-pre8/kernel/ksyms.c linux/kernel/ksyms.c
--- 2.4.18-pre8/kernel/ksyms.c	Thu Feb  7 14:38:13 2002
+++ linux/kernel/ksyms.c	Thu Feb  7 14:52:50 2002
@@ -95,6 +95,7 @@
 EXPORT_SYMBOL(alloc_pages_node);
 EXPORT_SYMBOL(__get_free_pages);
 EXPORT_SYMBOL(get_zeroed_page);
+EXPORT_SYMBOL(page_cache_release);
 EXPORT_SYMBOL(__free_pages);
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);
diff -urN 2.4.18-pre8/mm/memory.c linux/mm/memory.c
--- 2.4.18-pre8/mm/memory.c	Mon Jan  7 13:03:04 2002
+++ linux/mm/memory.c	Thu Feb  7 15:05:57 2002
@@ -487,7 +487,7 @@
 				 * depending on the type of the found page
 				 */
 				if (pages[i])
-					page_cache_get(pages[i]);
+					get_page(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -601,7 +601,7 @@
 			/* FIXME: cache flush missing for rw==READ
 			 * FIXME: call the correct reference counting function
 			 */
-			page_cache_release(map);
+			put_page(map);
 		}
 	}
 	
diff -urN 2.4.18-pre8/mm/page_alloc.c linux/mm/page_alloc.c
--- 2.4.18-pre8/mm/page_alloc.c	Thu Feb  7 14:38:13 2002
+++ linux/mm/page_alloc.c	Thu Feb  7 15:59:17 2002
@@ -70,12 +70,6 @@
 	struct page *base;
 	zone_t *zone;
 
-	/* Yes, think what happens when other parts of the kernel take 
-	 * a reference to a page in order to pin it for io. -ben
-	 */
-	if (PageLRU(page))
-		lru_cache_del(page);
-
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -86,8 +80,15 @@
 		BUG();
 	if (PageLocked(page))
 		BUG();
+	/*
+	 * Other parts of the kernel may get_page in order to pin it
+	 * for I/O, then put_page after the last page_cache_release:
+	 * perhaps at interrupt time when it would be unsafe to deLRU.
+	 * So leave page on the LRU, let shrink_cache free it later on.
+	 */
 	if (PageLRU(page))
-		BUG();
+		return;
+
 	if (PageActive(page))
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
@@ -430,6 +431,24 @@
 		return (unsigned long) address;
 	}
 	return 0;
+}
+
+void page_cache_release(struct page *page)
+{
+	/*
+	 * Yes, there is a race here, two threads might release the
+	 * same page at the same time, each see page_count as 2, and
+	 * neither delete it from LRU: okay, shrink_cache will clean
+	 * that up later.  What we must avoid is calling __free_pages_ok
+	 * on page of page_count 0 while shrink_cache is doing the same.
+	 */
+	if (PageLRU(page) && page_count(page) == 1) {
+		if (in_interrupt())
+			BUG();
+		lru_cache_del(page);
+	}
+	if (!PageReserved(page) && put_page_testzero(page))
+		__free_pages_ok(page, 0);
 }
 
 void __free_pages(struct page *page, unsigned int order)
-r--r--r--    1 hugh     hugh        18802 Feb  7 14:38 /home/hugh/1808/mm/page_alloc.c
-rw-r--r--    1 hugh     hugh        19450 Feb  7 16:48 page_alloc.c
diff -urN 2.4.18-pre8/mm/vmscan.c linux/mm/vmscan.c
--- 2.4.18-pre8/mm/vmscan.c	Thu Feb  7 14:38:13 2002
+++ linux/mm/vmscan.c	Thu Feb  7 15:43:32 2002
@@ -363,11 +363,16 @@
 		list_add(entry, &inactive_list);
 
 		/*
-		 * Zero page counts can happen because we unlink the pages
-		 * _after_ decrementing the usage count..
+		 * In exceptional cases, a page may still be on an LRU
+		 * when it arrives at __free_pages_ok, and it cannot be
+		 * removed from LRU at interrupt time: so clean up here.
 		 */
-		if (unlikely(!page_count(page)))
+		if (unlikely(!page_count(page))) {
+			page_cache_get(page);
+			__lru_cache_del(page);
+			page_cache_release(page);
 			continue;
+		}
 
 		if (!memclass(page->zone, classzone))
 			continue;

