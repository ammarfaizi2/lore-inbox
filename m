Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277595AbRJREuw>; Thu, 18 Oct 2001 00:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJREun>; Thu, 18 Oct 2001 00:50:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:53009 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277595AbRJREuX>;
	Thu, 18 Oct 2001 00:50:23 -0400
Date: Thu, 18 Oct 2001 02:50:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] free more swap space on exit()
Message-ID: <Pine.LNX.4.33L.0110180247460.6440-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At the moment, the kernel frees the following things at
exit() / exec() time:
1) memory in the process page tables + swapcache belonging
   to these pages
2) swap space used by the process (refcount decrement)

However, it does NOT free:
3) swap cache and space belonging to the process, where the
   page is in RAM (and the swap cache) but NOT in the process'
   page tables

The attached patch fixes the problem by simply looking up the
address in the swap cache and freeing the page if it's there.

Comments ?

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/



--- linux-2.4.12-ac3/mm/memory.c.freemore	Thu Oct 18 01:20:48 2001
+++ linux-2.4.12-ac3/mm/memory.c	Thu Oct 18 01:37:32 2001
@@ -302,7 +302,7 @@
 			/* This will eventually call __free_pte on the pte. */
 			tlb_remove_page(tlb, ptep, address + offset);
 		} else {
-			swap_free(pte_to_swp_entry(pte));
+			free_swap_and_swap_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
 		}
 	}
--- linux-2.4.12-ac3/mm/swap_state.c.freemore	Thu Oct 18 01:20:59 2001
+++ linux-2.4.12-ac3/mm/swap_state.c	Thu Oct 18 02:32:47 2001
@@ -147,6 +147,29 @@
 }

 /*
+ * Like the above, but used to clean up the non-resident pages of
+ * a process. If the page exists but we couldn't get the trylock,
+ * the pageout code will remove the page later.
+ */
+void free_swap_and_swap_cache(swp_entry_t entry)
+{
+	struct page * page;
+
+	/* Free our own reference to the swap space */
+	swap_free(entry);
+
+	/* If the swapcache is the only remaining user, free that too. */
+	page = find_trylock_page(&swapper_space, entry.val);
+	if (page) {
+		if (exclusive_swap_page(page)) {
+			delete_from_swap_cache(page);
+		}
+		UnlockPage(page);
+		page_cache_release(page);
+	}
+}
+
+/*
  * Lookup a swap entry in the swap cache. A found page will be returned
  * unlocked and with its refcount incremented - we rely on the kernel
  * lock getting page table operations atomic even if we drop the page
--- linux-2.4.12-ac3/mm/filemap.c.freemore	Thu Oct 18 01:21:04 2001
+++ linux-2.4.12-ac3/mm/filemap.c	Thu Oct 18 02:03:03 2001
@@ -740,12 +740,8 @@
 	 * the hash-list needs a held write-lock.
 	 */
 repeat:
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	page = __find_get_page(mapping, offset, hash);
 	if (page) {
-		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
-
 		lock_page(page);

 		/* Is the page still hashed? Ok, good.. */
@@ -757,7 +753,36 @@
 		page_cache_release(page);
 		goto repeat;
 	}
-	spin_unlock(&pagecache_lock);
+	return NULL;
+}
+
+/*
+ * Find a page in the page cache and return it to us locked and
+ * with the page count incremented, but only if nobody else has
+ * it locked already.  Used by the VM to opportunistically grab
+ * a page in places where we don't want to sleep.
+ */
+struct page * find_trylock_page (struct address_space *mapping,
+		unsigned long offset)
+{
+	struct page *page;
+
+	page = __find_get_page(mapping, offset, page_hash(mapping, offset));
+	if (page) {
+		/* If we cannot get the page, drop it and return NULL. */
+		if (TryLockPage(page)) {
+			page_cache_release(page);
+			return NULL;
+		}
+
+		/* The page didn't get removed/remapped behind our backs ? */
+		if (page->mapping == mapping && page->index == offset)
+			return page;
+
+		/* Hrrrm, it did; release the page and return NULL. */
+		UnlockPage(page);
+		page_cache_release(page);
+	}
 	return NULL;
 }

--- linux-2.4.12-ac3/include/linux/swap.h.freemore	Thu Oct 18 01:31:15 2001
+++ linux-2.4.12-ac3/include/linux/swap.h	Thu Oct 18 01:34:57 2001
@@ -141,6 +141,7 @@
 extern void __delete_from_swap_cache(struct page *page);
 extern void delete_from_swap_cache(struct page *page);
 extern void free_page_and_swap_cache(struct page *page);
+extern void free_swap_and_swap_cache(swp_entry_t);
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t);

--- linux-2.4.12-ac3/include/linux/pagemap.h.freemore	Thu Oct 18 01:31:35 2001
+++ linux-2.4.12-ac3/include/linux/pagemap.h	Thu Oct 18 01:45:35 2001
@@ -77,6 +77,7 @@
 	__find_get_page(mapping, index, page_hash(mapping, index))
 extern struct page * __find_lock_page (struct address_space * mapping,
 				unsigned long index, struct page **hash);
+extern struct page * find_trylock_page (struct address_space *, unsigned long);
 extern void lock_page(struct page *page);
 #define find_lock_page(mapping, index) \
 	__find_lock_page(mapping, index, page_hash(mapping, index))

