Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132207AbQL1B2p>; Wed, 27 Dec 2000 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132219AbQL1B2f>; Wed, 27 Dec 2000 20:28:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45584 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132207AbQL1B2W>; Wed, 27 Dec 2000 20:28:22 -0500
Date: Wed, 27 Dec 2000 21:05:35 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap write clustering for 2.4 (4th time) 
Message-ID: <Pine.LNX.4.21.0012272104520.11471-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The following patch changes swap_writepage() to try to do write clustering
of phisically contiguous pages which are dirty and in the swapcache.

The patch is pretty clean and small. 

Do you want to include it in 2.4?


diff -Nur --exclude-from=exclude linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Thu Dec 21 04:34:19 2000
+++ linux/include/linux/mm.h	Thu Dec 21 03:56:30 2000
@@ -451,6 +451,8 @@
 extern int filemap_swapout(struct page *, struct file *);
 extern int filemap_sync(struct vm_area_struct *, unsigned long,	size_t, unsigned int);
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
+extern inline struct page * ___find_page_nolock(struct address_space *, unsigned long, struct page *);
+
 
 /*
  * GFP bitmasks..
diff -Nur --exclude-from=exclude linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Thu Dec 21 04:34:19 2000
+++ linux/include/linux/swap.h	Thu Dec 21 04:16:42 2000
@@ -166,6 +166,8 @@
 extern unsigned long swap_cache_find_total;
 extern unsigned long swap_cache_find_success;
 #endif
+ 
+extern struct swap_info_struct swap_info[MAX_SWAPFILES];
 
 /*
  * Work out if there are any other processes sharing this page, ignoring
diff -Nur --exclude-from=exclude linux.orig/mm/filemap.c linux/mm/filemap.c
--- linux.orig/mm/filemap.c	Thu Dec 21 04:34:20 2000
+++ linux/mm/filemap.c	Thu Dec 21 03:53:41 2000
@@ -242,7 +242,7 @@
 	spin_unlock(&pagecache_lock);
 }
 
-static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
+inline struct page * ___find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
 {
 	goto inside;
 
@@ -250,12 +250,22 @@
 		page = page->next_hash;
 inside:
 		if (!page)
-			goto not_found;
+			return NULL;
 		if (page->mapping != mapping)
 			continue;
 		if (page->index == offset)
 			break;
 	}
+	return page;
+}
+
+static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
+{
+	page = ___find_page_nolock(mapping, offset, page);
+
+	if(!page)
+		return NULL;
+
 	/*
 	 * Touching the page may move it to the active list.
 	 * If we end up with too few inactive pages, we wake
@@ -264,7 +274,7 @@
 	age_page_up(page);
 	if (inactive_shortage() > inactive_target / 2 && free_shortage())
 			wakeup_kswapd(0);
-not_found:
+
 	return page;
 }
 
diff -Nur --exclude-from=exclude linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Mon Dec  4 19:22:02 2000
+++ linux/mm/swap_state.c	Thu Dec 21 04:23:47 2000
@@ -5,6 +5,8 @@
  *  Swap reorganised 29.12.95, Stephen Tweedie
  *
  *  Rewritten to use page cache, (C) 1998 Stephen Tweedie
+ *
+ *  21/12/2000 Added swap write clustering. Marcelo Tosatti
  */
 
 #include <linux/mm.h>
@@ -17,9 +19,95 @@
 
 #include <asm/pgtable.h>
 
+static inline struct page * swap_page_dirty(unsigned long, unsigned long, struct swap_info_struct *);
+
+#define SWAP_WRITE_CLUSTER (1 << page_cluster)
+
 static int swap_writepage(struct page *page)
 {
-	rw_swap_page(WRITE, page, 0);
+	unsigned long page_offset, curr, offset, i, type;
+	struct swap_info_struct *swap;
+	swp_entry_t entry;
+	struct page *cpages[SWAP_WRITE_CLUSTER*2];
+	int count, first;
+
+	entry.val = page->index;
+
+	type = SWP_TYPE(entry);
+
+	swap = &swap_info[type];
+
+	/* If swap area is not a real device, do not try to write cluster. */
+	if(!swap->swap_device) {
+		rw_swap_page(WRITE, page, 0);
+		return 0;
+	}
+
+	page_offset = offset = SWP_OFFSET(entry);
+	cpages[SWAP_WRITE_CLUSTER] = page;
+	count = 1;
+	first = SWAP_WRITE_CLUSTER;
+	curr = 1;
+
+	spin_lock(&pagecache_lock);
+	swap_device_lock(swap);
+
+	/*
+	 * Search for clusterable dirty swap pages.
+	 */
+	 
+	while (count < SWAP_WRITE_CLUSTER) { 
+		struct page *p = NULL;
+
+		if(offset <= 0) 
+			break;
+
+		offset = page_offset - curr;
+		p = swap_page_dirty(offset, type, swap);
+
+		if(!p)
+			break;
+
+		cpages[--first] = p;
+
+		ClearPageDirty(p);
+		curr++;
+		count++;
+	}
+
+	curr = 1;
+
+	while (count < SWAP_WRITE_CLUSTER) {
+		struct page *p = NULL;
+		offset = page_offset + curr;
+
+		if(offset >= swap->max)
+			break;
+
+		p = swap_page_dirty(offset, type, swap);
+		if(!p) 
+			break;
+
+		cpages[first + count] = p;
+		ClearPageDirty(p);
+		curr++;
+		count++;
+	}
+
+	swap_device_unlock(swap);
+	spin_unlock(&pagecache_lock);
+
+	/* Now write out everything we were able to cluster */
+
+	for(i=0; i<count; i++) {
+		int pos = first + i;
+		rw_swap_page(WRITE, cpages[pos], 0);
+
+	/* If the page is a clustered one, decrement its counter */
+		if(pos != SWAP_WRITE_CLUSTER)
+			page_cache_release(cpages[pos]);
+	}
+
 	return 0;
 }
 
@@ -36,6 +124,43 @@
 	0,				/* nrpages	*/
 	&swap_aops,
 };
+
+static inline struct page * swap_page_dirty(unsigned long offset, unsigned long type,
+		struct swap_info_struct *swapdev) 
+{ 
+	struct page *page, **hash;
+	swp_entry_t entry;
+	unsigned long index;
+
+	entry = SWP_ENTRY(type, offset);
+
+	index = entry.val;
+
+	if(!swapdev->swap_map[offset])
+		return NULL;
+
+	if(swapdev->swap_map[offset] == SWAP_MAP_BAD)
+		return NULL;
+	
+	hash = page_hash(&swapper_space, index);
+
+	page = ___find_page_nolock(&swapper_space, index, *hash);
+
+	if(!page)
+		return NULL;
+
+	if(TryLockPage(page)) 
+		return NULL;
+
+	page_cache_get(page);
+
+	if(PageDirty(page) && PageSwapCache(page))
+		return page;
+
+	UnlockPage(page);
+	page_cache_release(page);
+	return NULL;
+}
 
 #ifdef SWAP_CACHE_INFO
 unsigned long swap_cache_add_total;




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
