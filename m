Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHFTdW>; Tue, 6 Aug 2002 15:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSHFTcl>; Tue, 6 Aug 2002 15:32:41 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:21516 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S315427AbSHFTaH>;
	Tue, 6 Aug 2002 15:30:07 -0400
Date: Tue, 6 Aug 2002 20:33:39 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [patch 5/5] demand paging documentation
Message-ID: <Pine.LNX.4.44.0208062023170.14917-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introducs a very simple paging doc to Documentation/vm/ which is just
a quick introduction to demand paging. It also expands on commentry
related to demand paging in memory.c and vmscan.c . No code is changed.
Please apply

Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel


diff --exclude=numa -u --new-file linux-2.4.19/Documentation/vm/paging linux-2.4.19-mel/Documentation/vm/paging
--- linux-2.4.19/Documentation/vm/paging	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19-mel/Documentation/vm/paging	Tue Aug  6 19:47:26 2002
@@ -0,0 +1,409 @@
+Page Replacements
+-----------------
+
+   This document describes how pages are tracked so they can be swapped out
+   and in. The principle code that deals with with this is contained
+   in vmscan.c. The algorithm used is a slightly modified, simplified
+   LRU-2Q algorithm. See the details from the paper published on
+   http://citeseer.nj.nec.com.
+
+   To summarise, all pages that can be evicted are kept on one of two lists,
+   an active_list and an inactive_list (defined in page_alloc.c). When a page
+   is referenced, it is placed in the active queue (usually) and moves down
+   the queue in a LRU fashion. When it reaches the end, it enters the
+   inactive_list until it is eventually swapped out. The basic algorithm is
+
+ if (page->lru == active_list) {
+         /* On active list so move to head */
+         del_page_from_active_list(page)
+         add_page_to_active_list(page)
+ }
+ else if (page->lru == inactive_list) {
+         /* On inactive list so move - this is done by activate_page() */
+         del_page_from_inactive_list(page)
+         add_page_to_active_list(page)
+ } else {
+         /* This is a new reference or swapping in */
+
+         if (free_page) {
+                 /* Free slot available so use it */
+                 page = free_page
+         }
+         else {
+                 /* A page has to be freed to make space */
+                 page_swap = late_page_in_inactive_list
+                 del_from_inactive_list(page_swap)
+
+                 if (page_swap->buffers) {
+                         /* Disk buffer so flush it */
+                         Flush buffer and free page_swap
+                         page = page_swap
+                 } else
+                 {
+                         /* Swap this page out */
+                         swap_out(page_swap)
+
+                         /* page_swap is now a free page slot */
+                         page = page_swap
+                         add_to_active_list(page)
+                 }
+         }
+
+         /* Figure which list to place page on */
+         if (anonymous_page) {
+                 page = alloc_page()
+                 add_page_to_active_list(page)
+         }
+         if (swap_page) {
+                 swapin(page)
+                 add_page_to_active_list(page)
+         }
+         if (empty_buffer)
+         {
+                 fill_buffer(page)
+                 add_page_to_inactive_list(page)
+         }
+
+         if (wp_page) {
+                 share page if possible or page = alloc_page()
+                 add_page_to_inactive_list(page)
+         }
+
+ }
+
+   This isn't exactly how things work. For instance, the writing out of pages
+   is done asynchronously by kswapd while placing pages on the list would
+   happen during a page fault. But from a high overview, this is
+   approximately what happens and roughly describes the life cycle of a page.
+
+Paging In
+---------
+
+   There is six places where a page can be moved onto the LRU list. The first
+   four are from page faults, be the COW pages, malloced pages or mmaped
+   files. sys_read affects the buffer cache and sys_write affects the page
+   cache.
+
+   do_no_page        Used when a new page mapping needs to be created. If the
+                     page is anonymous, do_anonymous_page handles it.
+                     Otherwise, it belongs to a vma and is backed up by a
+                     file. The appropriate vm_ops->nopage() is called and the
+                     page is added to the inactive_list() . This will
+                     eventually map onto the disk buffer and call something
+                     like block_read_full_page in buffer.c to fill
+                     page->buffers
+   do_anonymous_page This is called by do_no_page when no vm_ops is available
+                     implying it's anonymous memory. A pte is simply
+                     allocated and the page is added to the active_list.
+   do_wp_page        This happens when a page that is written to which is
+                     present and shared. If the page can be shared, because
+                     it's a buffer page for instance, then it's simply
+                     shared. If it needs to be copied, a copy is made and
+                     added to the inactive_list.
+   do_swap_page      A page is either swapped in from disk or the swap cache
+                     and added to the active_list
+   sys_read          If an application reads from a file,
+                     do_generic_file_read is called which calls the
+                     appropriate filesystem operation to read a page in from
+                     disk
+   sys_write         sys_write writes through the page cache. If this is the
+                     first time it's written to, the page is allocated and
+                     placed on the inactive_list. If the write takes place
+                     immediately, it's removed again, otherwise it's left
+                     there and gets written out as a dirty page later.
+
+   If a page is just to be added to the inactive_list, just the function
+   lru_cache_add() is called.
+
+   There is a few functions which affect pages on the LRU list
+
+ void lru_cache_add(struct page * page)
+
+   If the page is destined for the active_list, lru_cache_add is still called
+   but it's closely followed by mark_page_accessed().
+
+ void mark_page_accessed(struct page *page)
+
+   This function marks the bits on the page flag to show it has been
+   referenced. It then calls activate_page() to move it to the head of the
+   LRU list.
+
+
+ static inline void activate_page_nolock(struct page * page)
+ void activate_page(struct page * page)
+
+Entering the LRU
+----------------
+
+   do_anonymous_page() is a good example of how a page gets allocated and
+   moved into the LRU. All the other mechanisms are roughly similar except in
+   where the information comes from. For the purposes of the LRU, the data is
+   irrelevant so this is the most appropriate function to discuss.
+
+ static int do_anonymous_page(struct mm_struct * mm, struct vm_area_struct * vma, pte_t *page_table, int write_access, unsigned long addr)
+ {
+         pte_t entry;
+
+         /* Read-only mapping of ZERO_PAGE. */
+         entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+
+   This creates a new pte entry and places a zero'd page in it and marks it
+   read-only. If later, a write takes place on this page, another page fault
+   will occur and a proper page will be allocated. For the moment, this is
+   enough. In this case, the LRU is unaffected because no real page was
+   allocated.
+
+         if (write_access) {
+                 struct page *page;
+
+                /* Allocate our own private page. */
+                 spin_unlock(&mm->page_table_lock);
+
+   But if we need to be able to write to the page, a real allocation takes
+   place. This is what is more interesting. Release the page table lock as
+   the next alloc_page() could sleep.
+
+                 page = alloc_page(GFP_HIGHUSER);
+                 if (!page)
+                         goto no_mem;
+                 clear_user_highpage(page, addr);
+
+   Allocate a page from high memory and clear it of any data thats there. If
+   highmem is not available, a normal page is used.
+
+                spin_lock(&mm->page_table_lock);
+                 if (!pte_none(*page_table)) {
+                         page_cache_release(page);
+                         spin_unlock(&mm->page_table_lock);
+                         return 1;
+                 }
+
+   The page table lock is re-acquired as it's about to be examined. The first
+   is to make sure the pte that is about to be filled is actually free. If
+   it's not, page_cache_release() will free the page just allocated. The lock
+   is released and then the function exists. Success is returned because
+   there is a page in the correct place in the page
+
+                 mm->rss++;
+                 flush_page_to_ram(page);
+                 entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+
+   rss is the number of resident pages in use. flush_page_to_ram ensures that
+   any write the kernel did to this page recently will be flushed from the
+   dcache and back to main memory. See cachetlb.txt in the kernel
+   documentation tree for details. As this is a page that can be written to,
+   pte_mkwrite() is called.
+
+                 lru_cache_add(page);
+                 mark_page_accessed(page);
+         }
+
+   At this stage, a blank page is in the process address space so now it has
+   to be placed on the LRU lists as well. These two lines will place the page
+   on the active_list .
+
+         set_pte(page_table, entry);
+
+         /* No need to invalidate - it was non-present before */
+         update_mmu_cache(vma, addr, entry);
+         spin_unlock(&mm->page_table_lock);
+         return 1;       /* Minor fault */
+
+ no_mem:
+         return -1;
+ }
+
+   Set the page table entry and update the mmu cache if necessary (a no-op on
+   the x86). This MMU cache is for architectures that have external MMU
+   caches like the PPC's hashed page tables. The page table lock is then.
+   released and success returned. The no_mem line is used if alloc_page()
+   failed.
+
+   The other routines for entering the LRU lists are of a similar principle
+   to this.
+
+Paging out
+----------
+
+   This section describes how pages are moved from the active_list to
+   the inactive_list and swapped out. All the principle work involved
+   in moving pages out is started in vmscan.c:shrink_caches. The kernel
+   cache it mainly attacks is the slab cache. kmem_cache_reap is called
+   to free up empty slabs. shrink_dcache_memory, shrink_icache_memory and
+   shrink_dqcache_memory free up disk related slab caches. That is purely
+   kernel memory and not of interest to the LRU lists.
+
+Moving from active_list to inactive_list
+----------------------------------------
+
+   The first function of interest is refill_inactive is responsible for
+   moving pages from the active_list to the inactive_list. Either kswapd is
+   responsible for this or alloc_pages will do it if memory is especially
+   tight. The function is called as
+
+         ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
+         refill_inactive(ratio);
+
+   nr_pages misleadingly enough is equal to SWAP_CLUSTER_MAX which at time of
+   writing is 32. This has the effect for keeping the number of active pages
+   about twice the size of the inactive list or about two thirds the size of
+   the full cache. The function for moving the pages refill_inactive() is
+   pretty straight forward
+
+   refill_inactive() in vmscan.c is responsible for moving the pages from the
+   active list to the inactive one.
+
+Moving from inactive_list to out of memory
+------------------------------------------
+
+   The principle function concerned with moving pages out of the inactive list
+   is vmscan.c:shrink_cache. It's a heavily overloaded function because it
+   has to deal with multiple types of pages. Because of the length of time it
+   could potentially take to move these pages, a check is made to see should
+   we sleep after each page is examined. The types of pages dealt with are
+
+   Mapped Page        A mapped page is one which has no ->buffers, no
+                      ->mapping (meaning it's not backed by disk). Therefore
+                      it must be in a process address space somewhere. If too
+                      many pages are found in the inactive_list, whole
+                      process address spaces will be swapped out. These pages
+                      can not be easily swapped out because there is no easy
+                      way to find what process a page belongs to. If too many
+                      pages are mapped, whole processes have to be swapped
+                      out.
+
+   Locked Buffer Page Page has been locked for IO and is a buffer page
+                      meaning it's been written to disk and will be freed.
+                      Wait for the IO to finish and then free the page.
+
+   Dirty Mapping Page This is a page that is backed by a file on disk and had
+                      a writepage file operation available. A reference to
+                      the page is taken (page_cache_get), the spinlock
+                      released and page is flushed to disk. Once it's
+                      finished page_cache_release is called to free up the
+                      page and remove it from the LRU
+
+   Buffer Page        This is a page with buffers. Note the difference
+                      between this and a locked buffer. A locked buffer is
+                      already in the process of been written out. In this
+                      case try_to_release_page is called which attempts to
+                      remove the page from the buffer cache. If it succeeds,
+                      it's removed from the LRU
+
+  1.3   LRU Picture
+
+   This shows a basic idea how pages flow through the lists. It doesn't
+   illustrate how pages get taken out of the LRU they are in and placed at
+   the top of the active queue if they are referenced.
+
+
+ do_anonymous_page()
+     do_swap()
+    sys_read()
+        |
+        |
+        |
+        |
+        ----head> ------------------------------
+                  |                            |
+                  |         active_list        |
+                  |                            |
+                  ------------------------------ tail--->refill_inactive()
+                                                              |
+                                                              |
+              -------------------------------------------------
+              |
+     |------> ----head> -------------------
+     |                  |                 |
+     |                  |  inactive_list  |
+     |                  |                 |
+     |                  ------------------- shrink_cache() --+--> swap
+     |                                                       |
+ do_wp_page                                                  |
+ do_no_page                                           page_cache_release()
+ sys_write                                                   |
+                                                             ---> free
+
+
+kswapd
+------
+
+   kswapd is a kernel thread which begins at system startup. During
+   initialisation, vmscan.c:kswapd_init is called. It first calls
+   swap.c:swap_setup which decides the cluster size depending on the amount
+   of memory available. It then starts a thread that loops forever in the
+   vmscan.c:kswapd() function.
+
+   The kswapd first creates a wait queue called kswapd for itself. The idea
+   is that kswapd will only be woken up when zones need to be balanced rather
+   than driving up CPU usage by spinning idly.
+
+   kswapd() is the kernel thread used to free up pages periodically. It
+   sleeps most of the time and woken up when __alloc_pages() finds that it
+   would have too few pages in a zone after an allocation but that it's not
+   critical yet. kswapd will be woken when the number of free pages hit a low
+   watermark. __alloc_pages() does the work itself when the number of free
+   pages hits the min mark. This way, kswapd can do some work asynchrously
+   when things are not too urgent
+
+kswapd_can_sleep()
+------------------
+
+   kswapd can only sleep if there is no zones to be balanced. As DMA can't be
+   balanced, it only checks the NORMAL and HIGHMEM zones. Remember that there
+   will only be multiple pgdat's for NUMA arches. i386 is not a NUMA arch.
+
+ FOR ALL pgdat in pgdat_list DO
+ {
+         FOR zones 1 and 2 in pgdat->node_zones DO
+                 /* Zone 0 is not checked as it is the DMA zone and can't
+                    be balanced */
+                 IF zone->need_balance == FALSE THEN continue
+                 return 0 /* If we get here, we can't sleep
+         NEXT zone
+ }
+
+Balancing Zones
+---------------
+
+   When zones need to be balanced, kswapd_balance is called.
+
+   It basically says, call kswapd_balance_pgdat on all pgdats in the system. If
+   any of them return saying they need to be balanced more, try and balance
+   all of them again.
+
+   kswapd_balance_pgdat is straight forward. It cycles through all the
+   zones in a pgdat and tries to free pages from each of them.  It's not
+   too particular what type of pages it frees up. It just wants to bring the
+   number of free pages over the watermarks. It'll check after each zone if
+   it's used up it's quota on the processor and call schedule() if it has to.
+
+   After the attempt to free pages, check_classzone_need_balance() is called.
+   As a wise man once said, the function does exactly what it says on the
+   tin. The whole function returns indicating if it needs more balance.
+
+Zone Watermarks
+---------------
+
+   This diagram might help illustrate how the watermarks behave. These marks
+   exist for each zone.
+
+
+ --- Total number of pages
+  |
+  |
+  |
+  |
+  |
+  |--> pages_high       kswapd will work once woken until this number of pages
+  |                     are free
+  |
+  |
+  |--> pages_low        At this point, the zone is marked need_balance and
+  |                     kswapd is woken up
+  |
+  |--> pages_min        Here, the caller of __alloc_pages will call
+  |                     try_to_free_pages() itself to free pages in a
+  |                     synchronous fashion
+  |
+ --- 0 pages free
diff --exclude=numa -u --new-file linux-2.4.19/Documentation/vm/paging.bak linux-2.4.19-mel/Documentation/vm/paging.bak
--- linux-2.4.19/Documentation/vm/paging.bak	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19-mel/Documentation/vm/paging.bak	Tue Aug  6 19:19:39 2002
@@ -0,0 +1,606 @@
+Page Replacements
+-----------------
+
+   This doc describes how pages are tracked so they can be swapped out
+   and in. The principle code that deals with with this is contained
+   in vmscan.c. The algorithm used is a slightly modified, simplified
+   LRU-2Q algorithm. See the details from the paper published on
+   http://citeseer.nj.nec.com.
+
+   To summarise, all pages that can be evicted are kept on one of two lists,
+   an active_list and an inactive_list (defined in page_alloc.c). When a page
+   is referenced, it is placed in the active queue (usually) and moves down
+   the queue in a LRU fashion. When it reaches the end, it enters the
+   inactive_list until it is eventually swapped out. The basic algorithm is
+
+ if (page->lru == active_list) {
+         /* On active list so move to head */
+         del_page_from_active_list(page)
+         add_page_to_active_list(page)
+ }
+ else if (page->lru == inactive_list) {
+         /* On inactive list so move - this is done by activate_page() */
+         del_page_from_inactive_list(page)
+         add_page_to_active_list(page)
+ } else {
+         /* This is a new reference or swapping in */
+
+         if (free_page) {
+                 /* Free slot available so use it */
+                 page = free_page
+         }
+         else {
+                 /* A page has to be freed to make space */
+                 page_swap = late_page_in_inactive_list
+                 del_from_inactive_list(page_swap)
+
+                 if (page_swap->buffers) {
+                         /* Disk buffer so flush it */
+                         Flush buffer and free page_swap
+                         page = page_swap
+                 } else
+                 {
+                         /* Swap this page out */
+                         swap_out(page_swap)
+
+                         /* page_swap is now a free page slot */
+                         page = page_swap
+                         add_to_active_list(page)
+                 }
+         }
+
+         /* Figure which list to place page on */
+         if (anonymous_page) {
+                 page = alloc_page()
+                 add_page_to_active_list(page)
+         }
+         if (swap_page) {
+                 swapin(page)
+                 add_page_to_active_list(page)
+         }
+         if (empty_buffer)
+         {
+                 fill_buffer(page)
+                 add_page_to_inactive_list(page)
+         }
+
+         if (wp_page) {
+                 share page if possible or page = alloc_page()
+                 add_page_to_inactive_list(page)
+         }
+
+ }
+
+   This isn't exactly how things work. For instance, the writing out of pages
+   is done asynchronously by kswapd while placing pages on the list would
+   happen during a page fault. But from a high overview, this is
+   approximately what happens and roughly describes the life cycle of a page.
+
+  1.1   Paging In
+
+   There is six places where a page can be moved onto the LRU list. The first
+   four are from page faults, be the COW pages, malloced pages or mmaped
+   files. sys_read affects the buffer cache and sys_write affects the page
+   cache.
+
+   do_no_page        Used when a new page mapping needs to be created. If the
+                     page is anonymous, do_anonymous_page handles it.
+                     Otherwise, it belongs to a vma and is backed up by a
+                     file. The appropriate vm_ops->nopage() is called and the
+                     page is added to the inactive_list() . This will
+                     eventually map onto the disk buffer and call something
+                     like block_read_full_page in buffer.c to fill
+                     page->buffers
+   do_anonymous_page This is called by do_no_page when no vm_ops is available
+                     implying it's anonymous memory. A pte is simply
+                     allocated and the page is added to the active_list.
+   do_wp_page        This happens when a page that is written to which is
+                     present and shared. If the page can be shared, because
+                     it's a buffer page for instance, then it's simply
+                     shared. If it needs to be copied, a copy is made and
+                     added to the inactive_list.
+   do_swap_page      A page is either swapped in from disk or the swap cache
+                     and added to the active_list
+   sys_read          If an application reads from a file,
+                     do_generic_file_read is called which calls the
+                     appropriate filesystem operation to read a page in from
+                     disk
+   sys_write         sys_write writes through the page cache. If this is the
+                     first time it's written to, the page is allocated and
+                     placed on the inactive_list. If the write takes place
+                     immediately, it's removed again, otherwise it's left
+                     there and gets written out as a dirty page later.
+
+   If a page is just to be added to the inactive_list, just the function
+   lru_cache_add() is called.
+
+ void lru_cache_add(struct page * page)
+ {
+         if (!TestSetPageLRU(page)) {
+                 spin_lock(&pagemap_lru_lock);
+                 add_page_to_inactive_list(page);
+                 spin_unlock(&pagemap_lru_lock);
+         }
+ }
+
+   This is pretty self explanatory. If the page is destined for the
+   active_list, lru_cache_add is still called but it's closely followed by
+   mark_page_accessed().
+
+ void mark_page_accessed(struct page *page)
+ {
+         if (!PageActive(page) && PageReferenced(page)) {
+                 activate_page(page);
+                 ClearPageReferenced(page);
+                 return;
+         }
+
+         /* Mark the page referenced, AFTER checking for previous usage..  */
+         SetPageReferenced(page);
+ }
+
+   activate_page() is a combination of two functions. activate_page() takes
+   out a lock and calls activate_page_nolock() which just removes the page
+   from the inactive_list and places it on the active_list.
+
+ static inline void activate_page_nolock(struct page * page)
+ {
+         if (PageLRU(page) && !PageActive(page)) {
+                 del_page_from_inactive_list(page);
+                 add_page_to_active_list(page);
+         }
+ }
+
+ void activate_page(struct page * page)
+ {
+         spin_lock(&pagemap_lru_lock);
+         activate_page_nolock(page);
+         spin_unlock(&pagemap_lru_lock);
+ }
+
+   As should be clear, as long as page keeps getting referenced, it'll remain
+   in the active_list safe from been swapped out.
+
+    1.1.1   Entering the LRU
+
+   do_anonymous_page() is a good example of how a page gets allocated and
+   moved into the LRU. All the other mechanisms are roughly similar except in
+   where the information comes from. For the purposes of the LRU, the data is
+   irrelevant so this is the most appropriate function to discuss.
+
+ static int do_anonymous_page(struct mm_struct * mm, struct vm_area_struct * vma, pte_t *page_table, int write_access, unsigned long addr)
+ {
+         pte_t entry;
+
+         /* Read-only mapping of ZERO_PAGE. */
+         entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+
+   This creates a new pte entry and places a zero'd page in it and marks it
+   read-only. If later, a write takes place on this page, another page fault
+   will occur and a proper page will be allocated. For the moment, this is
+   enough. In this case, the LRU is unaffected because no real page was
+   allocated.
+
+         if (write_access) {
+                 struct page *page;
+
+                /* Allocate our own private page. */
+                 spin_unlock(&mm->page_table_lock);
+
+   But if we need to be able to write to the page, a real allocation takes
+   place. This is what is more interesting. Release the page table lock as
+   the next alloc_page() could sleep.
+
+                 page = alloc_page(GFP_HIGHUSER);
+                 if (!page)
+                         goto no_mem;
+                 clear_user_highpage(page, addr);
+
+   Allocate a page from high memory and clear it of any data thats there. If
+   highmem is not available, a normal page is used.
+
+                spin_lock(&mm->page_table_lock);
+                 if (!pte_none(*page_table)) {
+                         page_cache_release(page);
+                         spin_unlock(&mm->page_table_lock);
+                         return 1;
+                 }
+
+   The page table lock is re-acquired as it's about to be examined. The first
+   is to make sure the pte that is about to be filled is actually free. If
+   it's not, page_cache_release() will free the page just allocated. The lock
+   is released and then the function exists. Success is returned because
+   there is a page in the correct place in the page
+
+                 mm->rss++;
+                 flush_page_to_ram(page);
+                 entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+
+   rss is the number of resident pages in use. flush_page_to_ram ensures that
+   any write the kernel did to this page recently will be flushed from the
+   dcache and back to main memory. See cachetlb.txt in the kernel
+   documentation tree for details. As this is a page that can be written to,
+   pte_mkwrite() is called.
+
+                 lru_cache_add(page);
+                 mark_page_accessed(page);
+         }
+
+   At this stage, a blank page is in the process address space so now it has
+   to be placed on the LRU lists as well. These two lines will place the page
+   on the active_list .
+
+         set_pte(page_table, entry);
+
+         /* No need to invalidate - it was non-present before */
+         update_mmu_cache(vma, addr, entry);
+         spin_unlock(&mm->page_table_lock);
+         return 1;       /* Minor fault */
+
+ no_mem:
+         return -1;
+ }
+
+   Set the page table entry and update the mmu cache if necessary (a no-op on
+   the x86). This MMU cache is for architectures that have external MMU
+   caches like the PPC's hashed page tables. The page table lock is then.
+   released and success returned. The no_mem line is used if alloc_page()
+   failed.
+
+   The other routines for entering the LRU lists are of a similar principle
+   to this.
+
+  1.2   Paging out
+
+   This section describes how pages are moved from the active_list to the
+   inactive_list and swapped out. All the principle work involved in moving
+   pages out is started in vmscan.c:shrink_caches. The kernel cache it mainly
+   attacks is the slab cache. kmem_cache_reap is called to free up empty
+   slabs. shrink_dcache_memory, shrink_icache_memory and
+   shrink_dqcache_memory free up disk related slab caches. That is purely
+   kernel memory and not of interest to the LRU lists.
+
+    1.2.1   Moving from active_list to inactive_list
+
+   The first function of interest is refill_inactive is responsible for
+   moving pages from the active_list to the inactive_list. Either kswapd is
+   responsible for this or alloc_pages will do it if memory is especially
+   tight. The function is called as
+
+         ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
+         refill_inactive(ratio);
+
+   nr_pages misleadingly enough is equal to SWAP_CLUSTER_MAX which at time of
+   writing is 32. This has the effect for keeping the number of active pages
+   about twice the size of the inactive list or about two thirds the size of
+   the full cache. The function for moving the pages refill_inactive() is
+   pretty straight forward
+
+ static void refill_inactive(int nr_pages)
+ {
+         struct list_head * entry;
+
+         spin_lock(&pagemap_lru_lock);
+
+   Take out the pagemap lock as pages on page tables may be affected.
+
+         entry = active_list.prev;
+
+   entry becomes the last page on the active_list, ergo been the first to
+   move to the inactive list.
+
+         while (nr_pages && entry != &active_list) {
+                 struct page * page;
+
+                 page = list_entry(entry, struct page, lru);
+
+   Move either nr_pages number of pages or until the active_list is empty.
+   page is the struct page for this entry in the LRU.
+
+                 entry = entry->prev;
+
+   Move to the next entry on the active_list before doing anything to the
+   page.
+
+                 if (PageTestandClearReferenced(page)) {
+                         list_del(&page->lru);
+                         list_add(&page->lru, &active_list);
+                         continue;
+                 }
+
+   This tests and clears the referenced bit. If the reference bit was set, it
+   means the page was used and is "hot". The bit is cleared and moved to the
+   top of the active list to trickle down again. This makes sure that active
+   pages don't accidently get moved early.
+
+                 nr_pages--;
+
+   One page is about to be moved
+
+                 del_page_from_active_list(page);
+                 add_page_to_inactive_list(page);
+                 SetPageReferenced(page);
+         }
+
+   Pretty clear. Move from the active_list to the inactive_list and mark it
+   referenced so it'll be promoted back to the active_list quickly if it's
+   referenced again. Page is moved so loop back and examine the next page
+
+         spin_unlock(&pagemap_lru_lock);
+ }
+
+   Release the page table lock.
+
+    1.2.2   Moving from inactive_list to out of memory
+
+   The principle function concerned with moving pages out of the inactive
+   list is vmscan.c:shrink_cache. It's a heavily overloaded function because
+   it has to deal with multiple types of pages. Because of the length of time
+   it could potentially take to move these pages, a check is made to see
+   should we sleep after each page is examined. The types of pages dealt with
+   are
+
+   Mapped Page        A mapped page is one which has no ->buffers, no
+                      ->mapping (meaning it's not backed by disk). Therefore
+                      it must be in a process address space somewhere. If too
+                      many pages are found in the inactive_list, whole
+                      process address spaces will be swapped out. These pages
+                      can not be easily swapped out because there is no easy
+                      way to find what process a page belongs to. If too many
+                      pages are mapped, whole processes have to be swapped
+                      out.
+   Locked Buffer Page Page has been locked for IO and is a buffer page
+                      meaning it's been written to disk and will be freed.
+                      Wait for the IO to finish and then free the page.
+   Dirty Mapping Page This is a page that is backed by a file on disk and had
+                      a writepage file operation available. A reference to
+                      the page is taken (page_cache_get), the spinlock
+                      released and page is flushed to disk. Once it's
+                      finished page_cache_release is called to free up the
+                      page and remove it from the LRU
+   Buffer Page        This is a page with buffers. Note the difference
+                      between this and a locked buffer. A locked buffer is
+                      already in the process of been written out. In this
+                      case try_to_release_page is called which attempts to
+                      remove the page from the buffer cache. If it succeeds,
+                      it's removed from the LRU
+
+  1.3   LRU Picture
+
+   This shows a basic idea how pages flow through the lists. It doesn't
+   illustrate how pages get taken out of the LRU they are in and placed at
+   the top of the active queue if they are referenced.
+
+
+ do_anonymous_page()
+     do_swap()
+    sys_read()
+        |
+        |
+        |
+        |
+        ----head> ------------------------------
+                  |                            |
+                  |         active_list        |
+                  |                            |
+                  ------------------------------ tail--->refill_inactive()
+                                                              |
+                                                              |
+              -------------------------------------------------
+              |
+     |------> ----head> -------------------
+     |                  |                 |
+     |                  |  inactive_list  |
+     |                  |                 |
+     |                  ------------------- shrink_cache() --+--> swap
+     |                                                       |
+ do_wp_page                                                  |
+ do_no_page                                           page_cache_release()
+ sys_write                                                   |
+                                                             ---> free
+
+
+  1.4   kswapd
+
+   kswapd is a kernel thread which begins at system startup. During
+   initialisation, vmscan.c:kswapd_init is called. It first calls
+   swap.c:swap_setup which decides the cluster size depending on the amount
+   of memory available. It then starts a thread that loops forever in the
+   vmscan.c:kswapd() function.
+
+   The kswapd first creates a wait queue called kswapd for itself. The idea
+   is that kswapd will only be woken up when zones need to be balanced rather
+   than driving up CPU usage by spinning idly.
+
+  1.5   kswapd()
+
+   This function is the kernel thread used to free up pages periodically. It
+   sleeps most of the time and woken up when __alloc_pages() finds that it
+   would have too few pages in a zone after an allocation but that it's not
+   critical yet. kswapd will be woken when the number of free pages hit a low
+   watermark. __alloc_pages() does the work itself when the number of free
+   pages hits the min mark. This way, kswapd can do some work asynchrously
+   when things are not too urgent
+
+ int kswapd(void *unused)
+ {
+         struct task_struct *tsk = current;
+         DECLARE_WAITQUEUE(wait, tsk);
+
+   The queue we sleep on
+
+         daemonize();
+         strcpy(tsk->comm, "kswapd");
+         sigfillset(&tsk->blocked);
+
+   daemonize closes all files and removes all userspace related structures
+   attached to the process. init becomes the parent. sigfillset blocks all
+   signals coming to this thread.
+
+         tsk->flags |= PF_MEMALLOC;
+
+   This tells alloc_pages to give us pages if possible when we ask for them
+   no matter how tight memory would get as a result of it. The idea is that
+   kswapd will only need a small bit of memory to free up a lot more.
+
+         for (;;) {
+                 __set_current_state(TASK_INTERRUPTIBLE);
+                 add_wait_queue(&kswapd_wait, &wait);
+
+   This marks us as we are asleep at the moment and on a wait queue we can be
+   woken from. The task isn't really asleep yet, but it might be in a short
+   time depending on the next block
+
+                 mb();
+                 if (kswapd_can_sleep())
+                         schedule();
+
+   Check if we can sleep. We can sleep if all nodes and zones are above their
+   watermarks. If we can sleep, call schedule() and free the processor.
+
+                 __set_current_state(TASK_RUNNING);
+                 remove_wait_queue(&kswapd_wait, &wait);
+
+   Mark ourselves as running and remove us off the wait queue.
+
+                 kswapd_balance();
+                 run_task_queue(&tq_disk);
+         }
+ }
+
+  1.6   kswapd_can_sleep()
+
+   kswapd can only sleep if there is no zones to be balanced. As DMA can't be
+   balanced, it only checks the NORMAL and HIGHMEM zones. Remember that there
+   will only be multiple pgdat's for NUMA arches. i386 is not a NUMA arch.
+
+ FOR ALL pgdat in pgdat_list DO
+ {
+         FOR zones 1 and 2 in pgdat->node_zones DO
+                 /* Zone 0 is not checked as it is the DMA zone and can't
+                    be balanced */
+                 IF zone->need_balance == FALSE THEN continue
+                 return 0 /* If we get here, we can't sleep
+         NEXT zone
+ }
+
+  1.7   Balancing Zones
+
+   When zones need to be balanced, kswapd_balance is called.
+
+ static void kswapd_balance(void)
+ {
+         int need_more_balance;
+         pg_data_t * pgdat;
+
+         do {
+                 need_more_balance = 0;
+                 pgdat = pgdat_list;
+                 do
+                         need_more_balance |= kswapd_balance_pgdat(pgdat);
+                 while ((pgdat = pgdat->node_next));
+         } while (need_more_balance);
+ }
+
+   This basically says, call kswapd_balance_pgdat on all pgdats in the
+   system. If any of them return saying they need to be balanced more, try
+   and balance all of them again.
+
+   kswapd_balance_pgdat at this point is straight forward. It cycles through
+   all the zones in this pgdat and tries to free pages from each of them.
+   It's not too particular what type of pages it frees up. It just wants to
+   bring the number of free pages over the watermarks. It'll check after each
+   zone if it's used up it's quota on the processor and call schedule() if it
+   has to.
+
+ static int kswapd_balance_pgdat(pg_data_t * pgdat)
+ {
+         int need_more_balance = 0, i;
+         zone_t * zone;
+
+         for (i = pgdat->nr_zones-1; i >= 0; i--) {
+                 zone = pgdat->node_zones + i;
+
+
+   For all zones in this pgdat
+
+                 if (unlikely(current->need_resched))
+                         schedule();
+
+   If we've used out quota, call schedule()
+
+                 if (!zone->need_balance)
+                         continue;
+
+   If this zone if fine, slip it. This flag will be set by __alloc_pages when
+   it finds the low watermark of free pages has been reached.
+
+                 if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
+                         zone->need_balance = 0;
+                         __set_current_state(TASK_INTERRUPTIBLE);
+                         schedule_timeout(HZ);
+                         continue;
+                 }
+
+   try_to_free_pages was explained earlier. If zero was returned, a process
+   was killed to free up memory. It's unlikely the zone will need balance now
+   so mark it as balanced and then sleep to give a chance for the pages to be
+   freed.
+
+                if (check_classzone_need_balance(zone))
+                         need_more_balance = 1;
+                 else
+                         zone->need_balance = 0;
+         }
+
+         return need_more_balance;
+ }
+
+   After the attempt to free pages, check_classzone_need_balance() is called.
+   As a wise man once said, the function does exactly what it says on the
+   tin. The whole function returns indicating if it needs more balance.
+
+ static int check_classzone_need_balance(zone_t * classzone)
+ {
+         zone_t * first_classzone;
+
+         first_classzone = classzone->zone_pgdat->node_zones;
+         while (classzone >= first_classzone) {
+                 if (classzone->free_pages > classzone->pages_high)
+                         return 0;
+                 classzone--;
+         }
+         return 1;
+ }
+
+   This is the check to see if more balance is needed. Note how the check is
+   made against pages_high. kswapd is woken up when the pages hit the
+   pages_low mark but there is no point just freeing pages to reach that
+   because it'll just be woken up again a split instant later. Instead,
+   enough pages are freed to meet the pages_high mark so kswapd is unlikely
+   to be woken again soon.
+
+    1.7.1   Watermarks
+
+   This diagram might help illustrate how the watermarks behave. These marks
+   exist for each zone.
+
+
+ --- Total number of pages
+  |
+  |
+  |
+  |
+  |
+  |--> pages_high       kswapd will work once woken until this number of pages
+  |                     are free
+  |
+  |
+  |--> pages_low        At this point, the zone is marked need_balance and
+  |                     kswapd is woken up
+  |
+  |--> pages_min        Here, the caller of __alloc_pages will call
+  |                     try_to_free_pages() itself to free pages in a
+  |                     synchronous fashion
+  |
+ --- 0 pages free
--- linux-2.4.19/mm/memory.c	Sat Aug  3 01:39:46 2002
+++ linux-2.4.19-mel/mm/memory.c	Tue Aug  6 19:55:14 2002
@@ -1111,7 +1111,21 @@
 	return;
 }

-/*
+/**
+ *
+ * do_swap_page - Handle a page fault for a page that has been swapped out
+ *
+ * When a page is swapped out, it'll be identified as !pte_present && !pte_none
+ * This function will look up the swap cache first (lookup_swap_cache). If the
+ * page is not there, swapin_readahead will read the page into the swap cache
+ * and a few more pages close to it when the disk has to seek there anyway.
+ *
+ * swapin_readahead should have the page easily available so
+ * read_swap_cache_async() should just have to retrieve the page quickly
+ * from the swap cache.
+ *
+ * there, it'll swap it in from disk.
+ *
  * We hold the mm semaphore and the page_table_lock on entry and
  * should release the pagetable lock on exit..
  */
@@ -1145,6 +1159,7 @@
 		ret = 2;
 	}

+	/* Move page onto active_list */
 	mark_page_accessed(page);

 	lock_page(page);
@@ -1183,7 +1198,13 @@
 	return ret;
 }

-/*
+/**
+ * do_anonymous_page - Handle a page fault for a new mapping with no backing
+ *
+ * This will occur when a page with no backing storage mapping is faulted for
+ * the first time. This could happen after a user malloced a page but is
+ * referring to it for the first time.
+ *
  * We are called with the MM semaphore and page_table_lock
  * spinlock held to protect against concurrent faults in
  * multithreaded programs.
@@ -1209,13 +1230,18 @@

 		spin_lock(&mm->page_table_lock);
 		if (!pte_none(*page_table)) {
+			/* A page was raced in here */
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
 			return 1;
 		}
 		mm->rss++;
+
+		/* FIXME: flush_page_to_ram() shouldn't be used any more */
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+
+		/* Add page to active_list for the LRU */
 		lru_cache_add(page);
 		mark_page_accessed(page);
 	}
@@ -1249,10 +1275,12 @@
 	struct page * new_page;
 	pte_t entry;

+	/* If no vma_ops, this page is not backed by a file */
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table, write_access, address);
 	spin_unlock(&mm->page_table_lock);

+	/* See filemap.c:filemap_nopage to see what work this does */
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);

 	if (new_page == NULL)	/* no page was available -- SIGBUS */
--- linux-2.4.19/mm/vmscan.c	Sat Aug  3 01:39:46 2002
+++ linux-2.4.19-mel/mm/vmscan.c	Tue Aug  6 20:01:16 2002
@@ -266,11 +266,14 @@
 		++*mmcounter;
 		goto out_unlock;
 	}
+
+	/* address is now the first address to swap out */
 	vma = find_vma(mm, address);
 	if (vma) {
 		if (address < vma->vm_start)
 			address = vma->vm_start;

+		/* Try to swap out all vma's associated with this mm */
 		for (;;) {
 			count = swap_out_vma(mm, vma, address, count, classzone);
 			vma = vma->vm_next;
@@ -289,6 +292,15 @@
 	return count;
 }

+/**
+ *
+ * swap_out - Swaps out mm's belonging to processes address space
+ *
+ * This function will attempt to swap out all process address spaces until
+ * it finds one that it could not swap a page out of. Failing to swap out
+ * could mean that all processes are swapped out or that there is no swap
+ * space left.
+ */
 static int FASTCALL(swap_out(unsigned int priority, unsigned int gfp_mask, zone_t * classzone));
 static int swap_out(unsigned int priority, unsigned int gfp_mask, zone_t * classzone)
 {
@@ -304,6 +316,8 @@

 		spin_lock(&mmlist_lock);
 		mm = swap_mm;
+
+		/* A swap_address == TASK_SIZE implies process address space */
 		while (mm->swap_address == TASK_SIZE || mm == &init_mm) {
 			mm->swap_address = 0;
 			mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
@@ -311,15 +325,19 @@
 				goto empty;
 			swap_mm = mm;
 		}
+		/* At this point swap_mm points to a process address space */

 		/* Make sure the mm doesn't disappear when we drop the lock.. */
 		atomic_inc(&mm->mm_users);
 		spin_unlock(&mmlist_lock);

+		/* Swap out the processes address space */
 		nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);

+		/* Free resources associated with the mm */
 		mmput(mm);

+		/* Keep swapping processes out until no pages are freed */
 		if (!nr_pages)
 			return 1;
 	} while (--counter >= 0);
@@ -331,6 +349,14 @@
 	return 0;
 }

+/**
+ *
+ * shink_cache - Shrinks buffer caches in a zone
+ * @nr_pages: Helps determine if process information needs to be swapped
+ * @classzone: zone we are freeing cache from
+ * @gfp_mask: flags which determine allocator behaviour
+ * @priority: determines how many pages to scan
+ */
 static int FASTCALL(shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority));
 static int shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority)
 {
@@ -339,6 +365,7 @@
 	int max_mapped = min((nr_pages << (10 - priority)), max_scan / 10);

 	spin_lock(&pagemap_lru_lock);
+	/* Scan max_scan number of pages from the end of the inactive list */
 	while (--max_scan >= 0 && (entry = inactive_list.prev) != &inactive_list) {
 		struct page * page;

@@ -365,6 +392,8 @@
 		if (unlikely(!page_count(page)))
 			continue;

+		/* Leave pages alone that are not in the zone we are freeing
+		 * for */
 		if (!memclass(page_zone(page), classzone))
 			continue;

@@ -375,6 +404,8 @@
 		/*
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
+		 * Once finished, page_cache_release() will ultimately call
+		 * the buddy allocator
 		 */
 		if (unlikely(TryLockPage(page))) {
 			if (PageLaunder(page) && (gfp_mask & __GFP_FS)) {
@@ -434,6 +465,18 @@
 					 */
 					spin_lock(&pagemap_lru_lock);
 					UnlockPage(page);
+
+					/* QUERY: Hasn't try_to_release_page()
+					 *        already removed us from the
+					 *        LRU with page_cache_release?
+					 *
+					 *        Even if it somehow didn't,
+					 *        the page_cache_release
+					 *        below should. Seems we end
+					 *        up removing from the LRU
+					 *        three times for the one
+					 *        page
+					 */
 					__lru_cache_del(page);

 					/* effectively free the page here */
@@ -444,9 +487,11 @@
 					break;
 				} else {
 					/*
-					 * The page is still in pagecache so undo the stuff
-					 * before the try_to_release_page since we've not
-					 * finished and we can now try the next step.
+					 * The page is still in page cache
+					 * so undo the stuff before the
+					 * try_to_release_page since we've
+					 * not finished and we can now
+					 * try the next step.
 					 */
 					page_cache_release(page);

@@ -480,6 +525,7 @@
 			 */
 			spin_unlock(&pagemap_lru_lock);
 			swap_out(priority, gfp_mask, classzone);
+
 			return nr_pages;
 		}

@@ -498,6 +544,7 @@
 			__remove_inode_page(page);
 			spin_unlock(&pagecache_lock);
 		} else {
+			/* Page has been fully swapped out so frame is free */
 			swp_entry_t swap;
 			swap.val = page->index;
 			__delete_from_swap_cache(page);
@@ -553,39 +600,75 @@
 	spin_unlock(&pagemap_lru_lock);
 }

+/**
+ *
+ * shrink_caches - Shrinks different caches in a zone to free pages
+ * @classzone: zone we are freeing from
+ * @priority: passed on later to shrink_cache
+ * @gfp_mask: flags which determine allocator behaviour
+ * @nr_pages: number of pages that must be freed
+ *
+ * The caches are freed in this order until nr_pages have been freed. The order
+ * they are freed in is slab, buffer/swap, dcache, icache and qcache if it's
+ * available.
+ */
 static int FASTCALL(shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages));
 static int shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages)
 {
 	int chunk_size = nr_pages;
 	unsigned long ratio;

+	/* Remove free slabs from caches */
 	nr_pages -= kmem_cache_reap(gfp_mask);
 	if (nr_pages <= 0)
 		return 0;

-	nr_pages = chunk_size;
 	/* try to keep the active list 2/3 of the size of the cache */
+	nr_pages = chunk_size;
 	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
 	refill_inactive(ratio);

+	/* QUERY: not be nr_pages -= shrink_cache() to get cumulative count? */
 	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
 	if (nr_pages <= 0)
 		return 0;

+	/*
+	 * We don't record how many were freed at all here even though
+	 * at least shrink_dcache_memory will possible free slabs. We
+	 * could end up freeing loads of pages here and then call
+	 * out_of_memory() because we don't know enough pages were
+	 * freed
+	 *
+	 * Addressed in 2.4.19pre8aa2 by instead calling these functions when
+	 * there is too many mapped pages in memory.
+	 */
 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);
 #ifdef CONFIG_QUOTA
 	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif

+	/* Return a delta of pages free. Negative if enough were freed */
 	return nr_pages;
 }

+/**
+ *
+ * try_to_free_pages - Free pages from a particular zone
+ * @classzone: Which zone to free from
+ * @gfp_mask: flags which determine allocator behaviour
+ * @order: The order block of pages we are interested in (has no affect)
+ *
+ * This function will set up to shrink caches in the requested zone
+ *
+ */
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
 {
 	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;

+	/* Set flags which avoid IO if necessary */
 	gfp_mask = pf_gfp_mask(gfp_mask);
 	do {
 		nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);
@@ -603,6 +686,12 @@

 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);

+/*
+ * check_classzone_need_balance
+ *
+ * This will return 0 only when the number of pages freed in the zone is
+ * above the high watermark
+ */
 static int check_classzone_need_balance(zone_t * classzone)
 {
 	zone_t * first_classzone;
@@ -616,6 +705,13 @@
 	return 1;
 }

+/**
+ *
+ * kswapd_balance_pgdat - Balance all zones within a pg_data node
+ *
+ * This function calls try_to_free_pages on each zone. Periodically it'll
+ * check to make sure it doesn't need to be rescheduled.
+ */
 static int kswapd_balance_pgdat(pg_data_t * pgdat)
 {
 	int need_more_balance = 0, i;
@@ -627,21 +723,40 @@
 			schedule();
 		if (!zone->need_balance)
 			continue;
+		/*
+		 * If 0 is returned, a process was killed so sleep and wait
+		 * for the pages to be freed before continuing.
+		 */
 		if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
 			zone->need_balance = 0;
 			__set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ);
 			continue;
 		}
+
 		if (check_classzone_need_balance(zone))
 			need_more_balance = 1;
 		else
+			/*
+			 * QUERY: Dead code? If the zone->need_balance was 0,
+			 * 	  we would have exited at the
+			 * 	  !zone->need_balance check earlier
+		 	 */
 			zone->need_balance = 0;
 	}

+	/* return a bool that will determine if all pgdat's are re-examined */
 	return need_more_balance;
 }

+/**
+ *
+ * kswapd_balance - Balances all pgdat
+ *
+ * This function cycles through all pg_data_t's and calls kswapd_balance_pgdat
+ * on each one. If one pgdat reports it needs more balance, all pgdat's
+ * are scanned again until all are balanced and kswapd can sleep
+ */
 static void kswapd_balance(void)
 {
 	int need_more_balance;
@@ -656,6 +771,11 @@
 	} while (need_more_balance);
 }

+/*
+ * Checks if this pg_data_t can sleep. It can sleep if none of it's zones
+ * require balancing. A zone is said to need balancing if the number of
+ * pages free drop below the pages_low watermark.
+ */
 static int kswapd_can_sleep_pgdat(pg_data_t * pgdat)
 {
 	zone_t * zone;
@@ -671,6 +791,7 @@
 	return 1;
 }

+/* Checks if all nodes can sleep */
 static int kswapd_can_sleep(void)
 {
 	pg_data_t * pgdat;
@@ -685,9 +806,11 @@
 	return 1;
 }

-/*
- * The background pageout daemon, started as a kernel thread
- * from the init process.
+/**
+ *
+ * kswapd - The background pageot daemon
+ *
+ * Started as a kernel thread from the init process.
  *
  * This basically trickles out pages so that we have _some_
  * free memory available even if there is no other activity
@@ -754,3 +877,4 @@
 }

 module_init(kswapd_init)
+


