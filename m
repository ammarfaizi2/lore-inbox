Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273853AbRIRFYp>; Tue, 18 Sep 2001 01:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRIRFYg>; Tue, 18 Sep 2001 01:24:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29452 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273853AbRIRFYU>; Tue, 18 Sep 2001 01:24:20 -0400
Date: Tue, 18 Sep 2001 01:00:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, Christoph Rohland <cr@sap.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.10pre VM changes: Potential race
In-Reply-To: <Pine.LNX.4.21.0109151236270.1155-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109180057480.7152-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Sep 2001, Hugh Dickins wrote:

> Marcelo,
> 
> I've done little testing of patch below (just SMP build on UP machine),
> and uncertain whether I'll be able to do more over the weekend.  Better
> for me to think backwards and forwards over it instead.  Please check
> it out and give it a try, or take pieces for a patch of your own.
> I won't be online, but will fetch mail from time to time.
> 
> It's an all-in-one patch of various things, which I'd want to
> divide up into separate parts if I were submitting to Linus.
> There's something in Documentation should be updated too.

Hugh, 

Here is my patch (mostly reaped your code) to fix the
add_to_swap_cache/try_to_swap_out() race. I've tested it for quite some
time on an SMP box. 

Christoph, can you please check if the shmem patch is OK? 

Note: this is against 2.4.10pre10, its not going to apply against pre11.

Just need to fix some hunks, though. 

diff -Nur --exclude-from=exclude linux.orig/mm/shmem.c linux/mm/shmem.c
--- linux.orig/mm/shmem.c	Mon Sep 17 17:01:19 2001
+++ linux/mm/shmem.c	Mon Sep 17 21:49:10 2001
@@ -241,14 +241,17 @@
 	
 	inode = page->mapping->host;
 	info = &inode->u.shmem_i;
+
+	spin_lock(&info->lock);
+	swap_list_lock();
 	swap = __get_swap_page(2);
 	error = -ENOMEM;
 	if (!swap.val) {
+		swap_list_unlock();
 		activate_page(page);
 		goto out;
 	}
 
-	spin_lock(&info->lock);
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
@@ -268,8 +271,10 @@
 	page_cache_release(page);
 	info->swapped++;
 
-	spin_unlock(&info->lock);
+	swap_list_unlock();
+
 out:
+	spin_unlock(&info->lock);
 	set_page_dirty(page);
 	UnlockPage(page);
 	return error;
diff -Nur --exclude-from=exclude linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Mon Sep 17 17:01:19 2001
+++ linux/mm/swap_state.c	Mon Sep 17 22:29:32 2001
@@ -94,7 +94,6 @@
 void __delete_from_swap_cache(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
-	swp_entry_t entry;
 
 #ifdef SWAP_CACHE_INFO
 	swap_cache_del_total++;
@@ -104,11 +103,9 @@
 	if (!PageSwapCache(page) || !PageLocked(page))
 		BUG();
 
-	entry.val = page->index;
 	PageClearSwapCache(page);
 	ClearPageDirty(page);
 	__remove_inode_page(page);
-	swap_free(entry);
 }
 
 /*
@@ -117,15 +114,20 @@
  */
 void delete_from_swap_cache_nolock(struct page *page)
 {
+	swp_entry_t entry;
+
 	if (!PageLocked(page))
 		BUG();
 
 	if (block_flushpage(page, 0))
 		lru_cache_del(page);
 
+	entry.val = page->index;
+
 	spin_lock(&pagecache_lock);
 	__delete_from_swap_cache(page);
 	spin_unlock(&pagecache_lock);
+	swap_free(entry);
 	page_cache_release(page);
 }
 
@@ -215,11 +217,17 @@
 	if (!new_page)
 		goto out;		/* Out of memory */
 
+	if (TryLockPage(new_page))
+		BUG();
+
 	/*
 	 * Check the swap cache again, in case we stalled above.
-	 * The BKL is guarding against races between this check
+	 * swap_list_lock is guarding against races between this check
 	 * and where the new page is added to the swap cache below.
+	 * It is also guarding against race where try_to_swap_out
+	 * allocates entry with get_swap_page then adds to cache.
 	 */
+	swap_list_lock();
 	found_page = __find_get_page(&swapper_space, entry.val, hash);
 	if (found_page)
 		goto out_free_page;
@@ -235,13 +243,14 @@
 	/* 
 	 * Add it to the swap cache and read its contents.
 	 */
-	if (TryLockPage(new_page))
-		BUG();
 	add_to_swap_cache(new_page, entry);
+	swap_list_unlock();
 	rw_swap_page(READ, new_page);
 	return new_page;
 
 out_free_page:
+	swap_list_unlock();
+	UnlockPage(new_page);
 	page_cache_release(new_page);
 out:
 	return found_page;
diff -Nur --exclude-from=exclude linux.orig/mm/swapfile.c linux/mm/swapfile.c
--- linux.orig/mm/swapfile.c	Mon Sep 17 17:01:19 2001
+++ linux/mm/swapfile.c	Mon Sep 17 18:39:40 2001
@@ -108,6 +108,9 @@
 	return 0;
 }
 
+/*
+ * Caller needs swap_list_lock() held.
+ */
 swp_entry_t __get_swap_page(unsigned short count)
 {
 	struct swap_info_struct * p;
@@ -118,7 +121,6 @@
 	entry.val = 0;	/* Out of memory */
 	if (count >= SWAP_MAP_MAX)
 		goto bad_count;
-	swap_list_lock();
 	type = swap_list.next;
 	if (type < 0)
 		goto out;
@@ -154,7 +156,6 @@
 				goto out;	/* out of swap space */
 	}
 out:
-	swap_list_unlock();
 	return entry;
 
 bad_count:
diff -Nur --exclude-from=exclude linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Mon Sep 17 17:01:19 2001
+++ linux/mm/vmscan.c	Mon Sep 17 22:18:40 2001
@@ -166,16 +166,16 @@
 	 * we have the swap cache set up to associate the
 	 * page with that swap entry.
 	 */
+	swap_list_lock();
 	entry = get_swap_page();
-	if (!entry.val)
-		goto out_unlock_restore; /* No swap space left */
-
-	/* Add it to the swap cache and mark it dirty */
-	add_to_swap_cache(page, entry);
-	set_page_dirty(page);
-	goto set_swap_pte;
-
-out_unlock_restore:
+	if (entry.val) {
+		/* Add it to the swap cache and mark it dirty */
+		add_to_swap_cache(page, entry);
+		swap_list_unlock();
+		set_page_dirty(page);
+		goto set_swap_pte;
+	}
+	swap_list_unlock();
 	set_pte(page_table, pte);
 	UnlockPage(page);
 	return;
@@ -384,6 +384,7 @@
 {
 	struct page * page = NULL;
 	struct list_head * page_lru;
+	swp_entry_t entry = {0};
 	int maxscan;
 
 	/*
@@ -429,6 +430,7 @@
 
 		/* OK, remove the page from the caches. */
 		if (PageSwapCache(page)) {
+			entry.val = page->index;
 			__delete_from_swap_cache(page);
 			goto found_page;
 		}
@@ -444,21 +446,26 @@
 		zone->inactive_clean_pages--;
 		UnlockPage(page);
 	}
-	/* Reset page pointer, maybe we encountered an unfreeable page. */
-	page = NULL;
-	goto out;
+
+	spin_unlock(&pagemap_lru_lock);
+	spin_unlock(&pagecache_lock);
+	return NULL;
 
 found_page:
 	memory_pressure++;
 	del_page_from_inactive_clean_list(page);
+	spin_unlock(&pagemap_lru_lock);
+	spin_unlock(&pagecache_lock);
+	if (entry.val)
+		swap_free(entry);
 	UnlockPage(page);
 	page->age = PAGE_AGE_START;
 	if (page_count(page) != 1)
 		printk("VM: reclaim_page, found page with count %d!\n",
 				page_count(page));
+
+	
 out:
-	spin_unlock(&pagemap_lru_lock);
-	spin_unlock(&pagecache_lock);
 	return page;
 }
 

