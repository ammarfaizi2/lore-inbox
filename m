Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266862AbRGFV1w>; Fri, 6 Jul 2001 17:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266860AbRGFV1c>; Fri, 6 Jul 2001 17:27:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44807 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266855AbRGFV1b>; Fri, 6 Jul 2001 17:27:31 -0400
Date: Fri, 6 Jul 2001 18:27:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] OOM kill trigger fix
Message-ID: <Pine.LNX.4.33L.0107061817300.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below fixes a bug in the OOM killer where the killer
could kick in if the system is out of swap (or has no swap), is
not out of memory yet but simply has a hard time with the cache.

The solution is to test against page_cache.min_percent +
buffer_cache.min_percent, this way we:

1) don't oom_kill() anything if we still have enough memory
   left
2) will run oom_kill() BEFORE the system really starts
   thrashing so badly that it'll never reach oom_kill()
   because of the thrashing

Of course, to implement this we have to count the number of
swapcache pages, but that's a 2-liner ;)

Please apply for the next (pre) kernel.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


--- linux-2.4.6/mm/oom_kill.c.orig	Fri Jul  6 17:32:58 2001
+++ linux-2.4.6/mm/oom_kill.c	Fri Jul  6 18:15:59 2001
@@ -191,11 +191,28 @@
  */
 int out_of_memory(void)
 {
+	long cache_mem, limit;
+
 	/* Enough free memory?  Not OOM. */
 	if (nr_free_pages() > freepages.min)
 		return 0;

 	if (nr_free_pages() + nr_inactive_clean_pages() > freepages.low)
+		return 0;
+
+	/*
+	 * If the buffer and page cache (excluding swap cache) are over
+	 * their (/proc tunable) minimum, we're still not OOM.  We test
+	 * this to make sure we don't return OOM when the system simply
+	 * has a hard time with the cache.
+	 */
+	cache_mem = atomic_read(&page_cache_size);
+	cache_mem += atomic_read(&buffermem_pages);
+	cache_mem -= atomic_read(&nr_swapcache_pages);
+	limit = (page_cache.min_percent + buffer_mem.min_percent);
+	limit *= num_physpages / 100;
+
+	if (cache_mem > limit)
 		return 0;

 	/* Enough swap space left?  Not OOM. */
--- linux-2.4.6/mm/swap_state.c.orig	Fri Jul  6 17:32:58 2001
+++ linux-2.4.6/mm/swap_state.c	Fri Jul  6 17:34:59 2001
@@ -51,6 +51,8 @@
 	&swap_aops,
 };

+atomic_t nr_swapcache_pages = ATOMIC_INIT(0);
+
 #ifdef SWAP_CACHE_INFO
 unsigned long swap_cache_add_total;
 unsigned long swap_cache_del_total;
@@ -82,6 +84,7 @@
 	flags = page->flags & ~((1 << PG_error) | (1 << PG_arch_1));
 	page->flags = flags | (1 << PG_uptodate);
 	add_to_page_cache_locked(page, &swapper_space, entry.val);
+	atomic_inc(&nr_swapcache_pages);
 }

 static inline void remove_from_swap_cache(struct page *page)
@@ -96,6 +99,7 @@
 	PageClearSwapCache(page);
 	ClearPageDirty(page);
 	__remove_inode_page(page);
+	atomic_dec(&nr_swapcache_pages);
 }

 /*
--- linux-2.4.6/include/linux/swap.h.orig	Fri Jul  6 17:33:07 2001
+++ linux-2.4.6/include/linux/swap.h	Fri Jul  6 17:33:34 2001
@@ -70,6 +70,7 @@
 extern int nr_active_pages;
 extern int nr_inactive_dirty_pages;
 extern atomic_t nr_async_pages;
+extern atomic_t nr_swapcache_pages;
 extern struct address_space swapper_space;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;

