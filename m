Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133005AbRDYXK6>; Wed, 25 Apr 2001 19:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbRDYXKt>; Wed, 25 Apr 2001 19:10:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:36107 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132993AbRDYXKh>; Wed, 25 Apr 2001 19:10:37 -0400
Date: Wed, 25 Apr 2001 18:30:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
Message-ID: <Pine.LNX.4.21.0104251829490.967-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resending...

---------- Forwarded message ----------
Date: Tue, 24 Apr 2001 23:28:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
     Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
     Rik van Riel <riel@conectiva.com.br>,
     Szabolcs Szakacsits <szaka@f-secure.com>
Subject: Re: [patch] swap-speedup-2.4.3-B3



On Tue, 24 Apr 2001, Linus Torvalds wrote:

> Basically, I don't want to mix synchronous and asynchronous
> interfaces. Everything should be asynchronous by default, and waiting
> should be explicit.

The following patch changes all swap IO functions to be asynchronous by
default and changes the callers to wait when needed (except
rw_swap_page_base which will block writers if there are too many in flight
swap IOs). 

Ingo's find_get_swapcache_page() does not wait on locked pages anymore,
which is now up to the callers.

time make -j32 test with 4 CPUs machine, 128M ram and 128M swap: 

pre5
----
228.04user 28.14system 5:16.52elapsed 80%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (525113major+678617minor)pagefaults 0swaps

pre5 + attached patch 
--------------------
227.18user 25.49system 3:40.53elapsed 114%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (495387major+644924minor)pagefaults 0swaps


Comments? 


diff -Nur linux.orig/include/linux/pagemap.h linux/include/linux/pagemap.h
--- linux.orig/include/linux/pagemap.h	Wed Apr 25 00:51:36 2001
+++ linux/include/linux/pagemap.h	Wed Apr 25 00:53:04 2001
@@ -77,7 +77,12 @@
 				unsigned long index, struct page **hash);
 extern void lock_page(struct page *page);
 #define find_lock_page(mapping, index) \
-		__find_lock_page(mapping, index, page_hash(mapping, index))
+	__find_lock_page(mapping, index, page_hash(mapping, index))
+
+extern struct page * __find_get_swapcache_page (struct address_space * mapping,
+				unsigned long index, struct page **hash);
+#define find_get_swapcache_page(mapping, index) \
+	__find_get_swapcache_page(mapping, index, page_hash(mapping, index))
 
 extern void __add_page_to_hash_queue(struct page * page, struct page **p);
 
diff -Nur linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Wed Apr 25 00:51:36 2001
+++ linux/include/linux/swap.h	Wed Apr 25 00:53:04 2001
@@ -111,8 +111,8 @@
 extern int try_to_free_pages(unsigned int gfp_mask);
 
 /* linux/mm/page_io.c */
-extern void rw_swap_page(int, struct page *, int);
-extern void rw_swap_page_nolock(int, swp_entry_t, char *, int);
+extern void rw_swap_page(int, struct page *);
+extern void rw_swap_page_nolock(int, swp_entry_t, char *);
 
 /* linux/mm/page_alloc.c */
 
@@ -121,8 +121,7 @@
 extern void add_to_swap_cache(struct page *, swp_entry_t);
 extern int swap_check_entry(unsigned long);
 extern struct page * lookup_swap_cache(swp_entry_t);
-extern struct page * read_swap_cache_async(swp_entry_t, int);
-#define read_swap_cache(entry) read_swap_cache_async(entry, 1);
+extern struct page * read_swap_cache_async(swp_entry_t);
 
 /* linux/mm/oom_kill.c */
 extern int out_of_memory(void);
diff -Nur linux.orig/mm/filemap.c linux/mm/filemap.c
--- linux.orig/mm/filemap.c	Wed Apr 25 00:51:35 2001
+++ linux/mm/filemap.c	Wed Apr 25 00:53:04 2001
@@ -678,6 +678,34 @@
 }
 
 /*
+ * Find a swapcache page (and get a reference) or return NULL.
+ * The SwapCache check is protected by the pagecache lock.
+ */
+struct page * __find_get_swapcache_page(struct address_space *mapping,
+			      unsigned long offset, struct page **hash)
+{
+	struct page *page;
+
+	/*
+	 * We need the LRU lock to protect against page_launder().
+	 */
+
+	spin_lock(&pagecache_lock);
+	page = __find_page_nolock(mapping, offset, *hash);
+	if (page) {
+		spin_lock(&pagemap_lru_lock);
+		if (PageSwapCache(page)) 
+			page_cache_get(page);
+		else
+			page = NULL;
+		spin_unlock(&pagemap_lru_lock);
+	}
+	spin_unlock(&pagecache_lock);
+
+	return page;
+}
+
+/*
  * Same as the above, but lock the page too, verifying that
  * it's still valid once we own it.
  */
diff -Nur linux.orig/mm/memory.c linux/mm/memory.c
--- linux.orig/mm/memory.c	Wed Apr 25 00:51:35 2001
+++ linux/mm/memory.c	Wed Apr 25 00:53:04 2001
@@ -1040,7 +1040,7 @@
 			break;
 		}
 		/* Ok, do the async read-ahead now */
-		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset), 0);
+		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset));
 		if (new_page != NULL)
 			page_cache_release(new_page);
 		swap_free(SWP_ENTRY(SWP_TYPE(entry), offset));
@@ -1063,13 +1063,13 @@
 	if (!page) {
 		lock_kernel();
 		swapin_readahead(entry);
-		page = read_swap_cache(entry);
+		page = read_swap_cache_async(entry);
 		unlock_kernel();
 		if (!page) {
 			spin_lock(&mm->page_table_lock);
 			return -1;
 		}
-
+		wait_on_page(page);
 		flush_page_to_ram(page);
 		flush_icache_page(vma, page);
 	}
diff -Nur linux.orig/mm/page_io.c linux/mm/page_io.c
--- linux.orig/mm/page_io.c	Wed Apr 25 00:51:35 2001
+++ linux/mm/page_io.c	Wed Apr 25 00:53:04 2001
@@ -33,7 +33,7 @@
  * that shared pages stay shared while being swapped.
  */
 
-static int rw_swap_page_base(int rw, swp_entry_t entry, struct page *page, int wait)
+static int rw_swap_page_base(int rw, swp_entry_t entry, struct page *page)
 {
 	unsigned long offset;
 	int zones[PAGE_SIZE/512];
@@ -41,6 +41,7 @@
 	kdev_t dev = 0;
 	int block_size;
 	struct inode *swapf = 0;
+	int wait = 0;
 
 	/* Don't allow too many pending pages in flight.. */
 	if ((rw == WRITE) && atomic_read(&nr_async_pages) >
@@ -104,7 +105,7 @@
  *  - it's marked as being swap-cache
  *  - it's associated with the swap inode
  */
-void rw_swap_page(int rw, struct page *page, int wait)
+void rw_swap_page(int rw, struct page *page)
 {
 	swp_entry_t entry;
 
@@ -116,7 +117,7 @@
 		PAGE_BUG(page);
 	if (page->mapping != &swapper_space)
 		PAGE_BUG(page);
-	if (!rw_swap_page_base(rw, entry, page, wait))
+	if (!rw_swap_page_base(rw, entry, page))
 		UnlockPage(page);
 }
 
@@ -125,7 +126,7 @@
  * Therefore we can't use it.  Later when we can remove the need for the
  * lock map and we can reduce the number of functions exported.
  */
-void rw_swap_page_nolock(int rw, swp_entry_t entry, char *buf, int wait)
+void rw_swap_page_nolock(int rw, swp_entry_t entry, char *buf)
 {
 	struct page *page = virt_to_page(buf);
 	
@@ -137,7 +138,8 @@
 		PAGE_BUG(page);
 	/* needs sync_page to wait I/O completation */
 	page->mapping = &swapper_space;
-	if (!rw_swap_page_base(rw, entry, page, wait))
+	if (!rw_swap_page_base(rw, entry, page))
 		UnlockPage(page);
+	wait_on_page(page);
 	page->mapping = NULL;
 }
diff -Nur linux.orig/mm/shmem.c linux/mm/shmem.c
--- linux.orig/mm/shmem.c	Wed Apr 25 00:51:35 2001
+++ linux/mm/shmem.c	Wed Apr 25 00:53:04 2001
@@ -124,6 +124,7 @@
 		*ptr = (swp_entry_t){0};
 		freed++;
 		if ((page = lookup_swap_cache(entry)) != NULL) {
+			wait_on_page(page);
 			delete_from_swap_cache(page);
 			page_cache_release(page);	
 		}
@@ -329,10 +330,11 @@
 			spin_unlock (&info->lock);
 			lock_kernel();
 			swapin_readahead(*entry);
-			page = read_swap_cache(*entry);
+			page = read_swap_cache_async(*entry);
 			unlock_kernel();
 			if (!page) 
 				return ERR_PTR(-ENOMEM);
+			wait_on_page(page);
 			if (!Page_Uptodate(page)) {
 				page_cache_release(page);
 				return ERR_PTR(-EIO);
diff -Nur linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Wed Apr 25 00:51:35 2001
+++ linux/mm/swap_state.c	Wed Apr 25 00:53:04 2001
@@ -34,7 +34,7 @@
 	return 0;
 
 in_use:
-	rw_swap_page(WRITE, page, 0);
+	rw_swap_page(WRITE, page);
 	return 0;
 }
 
@@ -163,37 +163,18 @@
 		/*
 		 * Right now the pagecache is 32-bit only.  But it's a 32 bit index. =)
 		 */
-repeat:
-		found = find_lock_page(&swapper_space, entry.val);
+		found = find_get_swapcache_page(&swapper_space, entry.val);
 		if (!found)
 			return 0;
-		/*
-		 * Though the "found" page was in the swap cache an instant
-		 * earlier, it might have been removed by refill_inactive etc.
-		 * Re search ... Since find_lock_page grabs a reference on
-		 * the page, it can not be reused for anything else, namely
-		 * it can not be associated with another swaphandle, so it
-		 * is enough to check whether the page is still in the scache.
-		 */
-		if (!PageSwapCache(found)) {
-			UnlockPage(found);
-			page_cache_release(found);
-			goto repeat;
-		}
+		if (!PageSwapCache(found))
+			BUG();
 		if (found->mapping != &swapper_space)
-			goto out_bad;
+			BUG();
 #ifdef SWAP_CACHE_INFO
 		swap_cache_find_success++;
 #endif
-		UnlockPage(found);
 		return found;
 	}
-
-out_bad:
-	printk (KERN_ERR "VM: Found a non-swapper swap page!\n");
-	UnlockPage(found);
-	page_cache_release(found);
-	return 0;
 }
 
 /* 
@@ -205,7 +186,7 @@
  * the swap entry is no longer in use.
  */
 
-struct page * read_swap_cache_async(swp_entry_t entry, int wait)
+struct page * read_swap_cache_async(swp_entry_t entry)
 {
 	struct page *found_page = 0, *new_page;
 	unsigned long new_page_addr;
@@ -238,7 +219,7 @@
 	 */
 	lock_page(new_page);
 	add_to_swap_cache(new_page, entry);
-	rw_swap_page(READ, new_page, wait);
+	rw_swap_page(READ, new_page);
 	return new_page;
 
 out_free_page:
diff -Nur linux.orig/mm/swapfile.c linux/mm/swapfile.c
--- linux.orig/mm/swapfile.c	Wed Apr 25 00:51:35 2001
+++ linux/mm/swapfile.c	Wed Apr 25 00:53:24 2001
@@ -369,13 +369,15 @@
 		/* Get a page for the entry, using the existing swap
                    cache page if there is one.  Otherwise, get a clean
                    page and read the swap into it. */
-		page = read_swap_cache(entry);
+		page = read_swap_cache_async(entry);
 		if (!page) {
 			swap_free(entry);
   			return -ENOMEM;
 		}
+		lock_page(page);
 		if (PageSwapCache(page))
-			delete_from_swap_cache(page);
+			delete_from_swap_cache_nolock(page);
+		UnlockPage(page);
 		read_lock(&tasklist_lock);
 		for_each_task(p)
 			unuse_process(p->mm, entry, page);
@@ -650,7 +652,7 @@
 	}
 
 	lock_page(virt_to_page(swap_header));
-	rw_swap_page_nolock(READ, SWP_ENTRY(type,0), (char *) swap_header, 1);
+	rw_swap_page_nolock(READ, SWP_ENTRY(type,0), (char *) swap_header);
 
 	if (!memcmp("SWAP-SPACE",swap_header->magic.magic,10))
 		swap_header_version = 1;


