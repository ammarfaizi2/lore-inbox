Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSDXIwd>; Wed, 24 Apr 2002 04:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSDXIwc>; Wed, 24 Apr 2002 04:52:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293203AbSDXIvG>;
	Wed, 24 Apr 2002 04:51:06 -0400
Message-ID: <3CC6720F.BD1367B9@zip.com.au>
Date: Wed, 24 Apr 2002 01:51:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] page->flags cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Moves the definitions of the page->flags bits and all the PageFoo
macros into linux/page-flags.h.  That file is currently included from
mm.h, but the stage is set to remove that and include page-flags.h
direct in all .c files which require that.  (120 of them).

The patch also makes all the page flag macros and functions consistent:

For PG_foo, the following functions are defined:

	SetPageFoo
	ClearPageFoo
	TestSetPageFoo
	TestClearPageFoo
	PageFoo

and that's it.

- Page_Uptodate is renamed to PageUptodate

- LockPage is removed.  All users updated to use SetPageLocked

- UnlockPage is removed.  All callers updated to use unlock_page(). 
  it's a real function - there's no need to hide that fact.

- PageTestandClearReferenced renamed to TestClearPageReferenced

- PageSetSlab renamed to SetPageSlab

- __SetPageReserved is removed.  It's an infinitesimally small
   microoptimisation, and is inconsistent.

- TryLockPage is renamed to TestSetPageLocked

- PageSwapCache() is renamed to page_swap_cache(), so it doesn't
  pretend to be a page->flags bit test.


=====================================

--- 2.5.9/include/linux/page-flags.h~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/include/linux/page-flags.h	Wed Apr 24 01:44:56 2002
@@ -6,6 +6,72 @@
 #define PAGE_FLAGS_H
 
 /*
+ * Various page->flags bits:
+ *
+ * PG_reserved is set for special pages, which can never be swapped
+ * out. Some of them might not even exist (eg empty_bad_page)...
+ *
+ * The PG_private bitflag is set if page->private contains a valid value.
+ *
+ * During disk I/O, PG_locked_dontuse is used. This bit is set before I/O
+ * and reset when I/O completes. page_waitqueue(page) is a wait queue of all
+ * tasks waiting for the I/O on this page to complete.
+ *
+ * PG_uptodate tells whether the page's contents is valid.
+ * When a read completes, the page becomes uptodate, unless a disk I/O
+ * error happened.
+ *
+ * For choosing which pages to swap out, inode pages carry a
+ * PG_referenced bit, which is set any time the system accesses
+ * that page through the (mapping,index) hash table. This referenced
+ * bit, together with the referenced bit in the page tables, is used
+ * to manipulate page->age and move the page across the active,
+ * inactive_dirty and inactive_clean lists.
+ *
+ * Note that the referenced bit, the page->lru list_head and the
+ * active, inactive_dirty and inactive_clean lists are protected by
+ * the pagemap_lru_lock, and *NOT* by the usual PG_locked_dontuse bit!
+ *
+ * PG_skip is used on sparc/sparc64 architectures to "skip" certain
+ * parts of the address space.
+ *
+ * PG_error is set to indicate that an I/O error occurred on this page.
+ *
+ * PG_arch_1 is an architecture specific page state bit.  The generic
+ * code guarantees that this bit is cleared for a page when it first
+ * is entered into the page cache.
+ *
+ * PG_highmem pages are not permanently mapped into the kernel virtual
+ * address space, they need to be kmapped separately for doing IO on
+ * the pages. The struct page (these bits with information) are always
+ * mapped into kernel address space...
+ */
+
+/*
+ * Don't use the *_dontuse flags.  Use the macros.  Otherwise
+ * you'll break locked- and dirty-page accounting.
+ */
+#define PG_locked_dontuse	 0	/* Page is locked. Don't touch. */
+#define PG_error		 1
+#define PG_referenced		 2
+#define PG_uptodate		 3
+
+#define PG_dirty_dontuse	 4
+#define PG_unused		 5	/* err.  This is unused. */
+#define PG_lru			 6
+#define PG_active		 7
+
+#define PG_slab			 8	/* slab debug (Suparna wants this) */
+#define PG_skip			10	/* kill me now: obsolete */
+#define PG_highmem		11
+#define PG_checked		12	/* kill me in 2.5.<early>. */
+
+#define PG_arch_1		13
+#define PG_reserved		14
+#define PG_launder		15	/* written out by VM pressure.. */
+#define PG_private		16	/* Has something at ->private */
+
+/*
  * Per-CPU page acounting.  Inclusion of this file requires
  * that <linux/percpu.h> be included beforehand.
  */
@@ -35,7 +101,6 @@ extern void get_page_state(struct page_s
 /*
  * Manipulation of page state flags
  */
-#define UnlockPage(page)	unlock_page(page)
 #define PageLocked(page)	test_bit(PG_locked_dontuse, &(page)->flags)
 #define SetPageLocked(page)						\
 	do {								\
@@ -43,8 +108,7 @@ extern void get_page_state(struct page_s
 				&(page)->flags))			\
 			inc_page_state(nr_locked);			\
 	} while (0)
-#define LockPage(page)		SetPageLocked(page)	/* grr.  kill me */
-#define TryLockPage(page)						\
+#define TestSetPageLocked(page)						\
 	({								\
 		int ret;						\
 		ret = test_and_set_bit(PG_locked_dontuse,		\
@@ -76,9 +140,9 @@ extern void get_page_state(struct page_s
 #define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
 #define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
-#define PageTestandClearReferenced(page)	test_and_clear_bit(PG_referenced, &(page)->flags)
+#define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
 
-#define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
+#define PageUptodate(page)	test_bit(PG_uptodate, &(page)->flags)
 #define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
 #define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
 
@@ -123,8 +187,8 @@ extern void get_page_state(struct page_s
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
-#define PageSetSlab(page)	set_bit(PG_slab, &(page)->flags)
-#define PageClearSlab(page)	clear_bit(PG_slab, &(page)->flags)
+#define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
+#define ClearPageSlab(page)	clear_bit(PG_slab, &(page)->flags)
 
 #ifdef CONFIG_HIGHMEM
 #define PageHighMem(page)	test_bit(PG_highmem, &(page)->flags)
@@ -138,7 +202,6 @@ extern void get_page_state(struct page_s
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
-#define __SetPageReserved(page)	__set_bit(PG_reserved, &(page)->flags)
 
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
--- 2.5.9/include/linux/mm.h~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/include/linux/mm.h	Wed Apr 24 01:45:02 2002
@@ -191,11 +191,6 @@ typedef struct page {
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)
 
 /*
- * Various page->flags bits:
- *
- * PG_reserved is set for special pages, which can never be swapped
- * out. Some of them might not even exist (eg empty_bad_page)...
- *
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
  * zeroes, and text pages of executables and shared libraries have
@@ -224,8 +219,6 @@ typedef struct page {
  * page's address_space.  Usually, this is the address of a circular
  * list of the page's disk buffers.
  *
- * The PG_private bitflag is set if page->private contains a valid
- * value.
  * For pages belonging to inodes, the page->count is the number of
  * attaches, plus 1 if `private' contains something, plus one for
  * the page cache itself.
@@ -244,62 +237,7 @@ typedef struct page {
  *   to be written to disk,
  * - private pages which have been modified may need to be swapped out
  *   to swap space and (later) to be read back into memory.
- * During disk I/O, PG_locked_dontuse is used. This bit is set before I/O
- * and reset when I/O completes. page_waitqueue(page) is a wait queue of all
- * tasks waiting for the I/O on this page to complete.
- * PG_uptodate tells whether the page's contents is valid.
- * When a read completes, the page becomes uptodate, unless a disk I/O
- * error happened.
- *
- * For choosing which pages to swap out, inode pages carry a
- * PG_referenced bit, which is set any time the system accesses
- * that page through the (mapping,index) hash table. This referenced
- * bit, together with the referenced bit in the page tables, is used
- * to manipulate page->age and move the page across the active,
- * inactive_dirty and inactive_clean lists.
- *
- * Note that the referenced bit, the page->lru list_head and the
- * active, inactive_dirty and inactive_clean lists are protected by
- * the pagemap_lru_lock, and *NOT* by the usual PG_locked_dontuse bit!
- *
- * PG_skip is used on sparc/sparc64 architectures to "skip" certain
- * parts of the address space.
- *
- * PG_error is set to indicate that an I/O error occurred on this page.
- *
- * PG_arch_1 is an architecture specific page state bit.  The generic
- * code guarantees that this bit is cleared for a page when it first
- * is entered into the page cache.
- *
- * PG_highmem pages are not permanently mapped into the kernel virtual
- * address space, they need to be kmapped separately for doing IO on
- * the pages. The struct page (these bits with information) are always
- * mapped into kernel address space...
- */
-
-/*
- * Don't use the *_dontuse flags.  Use the macros.  Otherwise
- * you'll break locked- and dirty-page accounting.
  */
-#define PG_locked_dontuse	 0	/* Page is locked. Don't touch. */
-#define PG_error		 1
-#define PG_referenced		 2
-#define PG_uptodate		 3
-
-#define PG_dirty_dontuse	 4
-#define PG_unused		 5	/* err.  This is unused. */
-#define PG_lru			 6
-#define PG_active		 7
-
-#define PG_slab			 8	/* slab debug (Suparna wants this) */
-#define PG_skip			10	/* kill me now: obsolete */
-#define PG_highmem		11
-#define PG_checked		12	/* kill me in 2.5.<early>. */
-
-#define PG_arch_1		13
-#define PG_reserved		14
-#define PG_launder		15	/* written out by VM pressure.. */
-#define PG_private		16	/* Has something at ->private */
 
 /*
  * FIXME: take this include out, include page-flags.h in
@@ -445,12 +383,7 @@ extern void si_meminfo(struct sysinfo * 
 extern void swapin_readahead(swp_entry_t);
 
 extern struct address_space swapper_space;
-#define PageSwapCache(page) ((page)->mapping == &swapper_space)
-
-static inline int is_page_cache_freeable(struct page * page)
-{
-	return page_count(page) - !!PagePrivate(page) == 1;
-}
+#define page_swap_cache(page) ((page)->mapping == &swapper_space)
 
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
--- 2.5.9/mm/vmscan.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/vmscan.c	Wed Apr 24 01:06:11 2002
@@ -35,6 +35,11 @@
  */
 #define DEF_PRIORITY (6)
 
+static inline int is_page_cache_freeable(struct page * page)
+{
+	return page_count(page) - !!PagePrivate(page) == 1;
+}
+
 /*
  * On the swap_out path, the radix-tree node allocations are performing
  * GFP_ATOMIC allocations under PF_MEMALLOC.  They can completely
@@ -87,7 +92,7 @@ static inline int try_to_swap_out(struct
 	if (!memclass(page_zone(page), classzone))
 		return 0;
 
-	if (TryLockPage(page))
+	if (TestSetPageLocked(page))
 		return 0;
 
 	/* From this point on, the odds are that we're going to
@@ -107,14 +112,14 @@ static inline int try_to_swap_out(struct
 	 * we can just drop our reference to it without doing
 	 * any IO - it's already up-to-date on disk.
 	 */
-	if (PageSwapCache(page)) {
+	if (page_swap_cache(page)) {
 		entry.val = page->index;
 		swap_duplicate(entry);
 set_swap_pte:
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
-		UnlockPage(page);
+		unlock_page(page);
 		{
 			int freeable = page_count(page) -
 				!!PagePrivate(page) <= 2;
@@ -181,7 +186,7 @@ drop_pte:
 	/* No swap space left */
 preserve:
 	set_pte(page_table, pte);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 }
 
@@ -416,7 +421,7 @@ static int shrink_cache(int nr_pages, zo
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
 		 */
-		if (unlikely(TryLockPage(page))) {
+		if (unlikely(TestSetPageLocked(page))) {
 			if (PageLaunder(page) && (gfp_mask & __GFP_FS)) {
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
@@ -490,7 +495,7 @@ static int shrink_cache(int nr_pages, zo
 					 * taking the lru lock
 					 */
 					spin_lock(&pagemap_lru_lock);
-					UnlockPage(page);
+					unlock_page(page);
 					__lru_cache_del(page);
 
 					/* effectively free the page here */
@@ -511,7 +516,7 @@ static int shrink_cache(int nr_pages, zo
 				}
 			} else {
 				/* failed to drop the buffers so stop here */
-				UnlockPage(page);
+				unlock_page(page);
 				page_cache_release(page);
 
 				spin_lock(&pagemap_lru_lock);
@@ -528,7 +533,7 @@ static int shrink_cache(int nr_pages, zo
 				goto page_freeable;
 			write_unlock(&mapping->page_lock);
 		}
-		UnlockPage(page);
+		unlock_page(page);
 page_mapped:
 		if (--max_mapped >= 0)
 			continue;
@@ -548,12 +553,12 @@ page_freeable:
 		 */
 		if (PageDirty(page)) {
 			write_unlock(&mapping->page_lock);
-			UnlockPage(page);
+			unlock_page(page);
 			continue;
 		}
 
 		/* point of no return */
-		if (likely(!PageSwapCache(page))) {
+		if (likely(!page_swap_cache(page))) {
 			__remove_inode_page(page);
 			write_unlock(&mapping->page_lock);
 		} else {
@@ -565,7 +570,7 @@ page_freeable:
 		}
 
 		__lru_cache_del(page);
-		UnlockPage(page);
+		unlock_page(page);
 
 		/* effectively free the page here */
 		page_cache_release(page);
@@ -597,7 +602,7 @@ static void refill_inactive(int nr_pages
 
 		page = list_entry(entry, struct page, lru);
 		entry = entry->prev;
-		if (PageTestandClearReferenced(page)) {
+		if (TestClearPageReferenced(page)) {
 			list_del(&page->lru);
 			list_add(&page->lru, &active_list);
 			continue;
--- 2.5.9/arch/alpha/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/alpha/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -127,7 +127,7 @@ show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!page_count(mem_map+i))
 			free++;
--- 2.5.9/arch/alpha/mm/numa.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/alpha/mm/numa.c	Wed Apr 24 01:44:54 2002
@@ -412,7 +412,7 @@ show_mem(void)
 			total++;
 			if (PageReserved(lmem_map+i))
 				reserved++;
-			else if (PageSwapCache(lmem_map+i))
+			else if (page_swap_cache(lmem_map+i))
 				cached++;
 			else if (!page_count(lmem_map+i))
 				free++;
--- 2.5.9/arch/arm/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/arm/mm/init.c	Wed Apr 24 01:44:56 2002
@@ -95,7 +95,7 @@ void show_mem(void)
 			total++;
 			if (PageReserved(page))
 				reserved++;
-			else if (PageSwapCache(page))
+			else if (page_swap_cache(page))
 				cached++;
 			else if (PageSlab(page))
 				slab++;
--- 2.5.9/arch/cris/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/cris/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -167,7 +167,7 @@ show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!page_count(mem_map+i))
 			free++;
--- 2.5.9/arch/i386/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/i386/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -85,7 +85,7 @@ void show_mem(void)
 			highmem++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (page_count(mem_map+i))
 			shared += page_count(mem_map+i) - 1;
--- 2.5.9/arch/ia64/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/ia64/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -188,7 +188,7 @@ show_mem(void)
 			for(i = 0; i < pgdat->node_size; i++) {
 				if (PageReserved(pgdat->node_mem_map+i))
 					reserved++;
-				else if (PageSwapCache(pgdat->node_mem_map+i))
+				else if (page_swap_cache(pgdat->node_mem_map+i))
 					cached++;
 				else if (page_count(pgdat->node_mem_map + i))
 					shared += page_count(pgdat->node_mem_map + i) - 1;
@@ -210,7 +210,7 @@ show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (page_count(mem_map + i))
 			shared += page_count(mem_map + i) - 1;
--- 2.5.9/arch/m68k/atari/stram.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/m68k/atari/stram.c	Wed Apr 24 01:06:11 2002
@@ -771,7 +771,7 @@ static int unswap_by_read(unsigned short
 			shm_unuse(entry, page);
 			/* Now get rid of the extra reference to the
 			   temporary page we've been using. */
-			if (PageSwapCache(page))
+			if (page_swap_cache(page))
 				delete_from_swap_cache(page);
 			__free_page(page);
 	#ifdef DO_PROC
--- 2.5.9/arch/m68k/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/m68k/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -96,7 +96,7 @@ void show_mem(void)
 	total++;
 	if (PageReserved(mem_map+i))
 	    reserved++;
-	else if (PageSwapCache(mem_map+i))
+	else if (page_swap_cache(mem_map+i))
 	    cached++;
 	else if (!page_count(mem_map+i))
 	    free++;
--- 2.5.9/arch/mips/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/mips/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -124,7 +124,7 @@ void show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!page_count(mem_map + i))
 			free++;
--- 2.5.9/arch/mips64/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/mips64/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -328,7 +328,7 @@ void show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!page_count(mem_map + i))
 			free++;
--- 2.5.9/arch/parisc/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/parisc/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -144,7 +144,7 @@ void show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!atomic_read(&mem_map[i].count))
 			free++;
--- 2.5.9/arch/ppc/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/ppc/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -129,7 +129,7 @@ void show_mem(void)
 			highmem++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!page_count(mem_map+i))
 			free++;
--- 2.5.9/arch/ppc64/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/ppc64/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -126,7 +126,7 @@ void show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (!atomic_read(&mem_map[i].count))
 			free++;
--- 2.5.9/arch/s390/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/s390/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -79,7 +79,7 @@ void show_mem(void)
                 total++;
                 if (PageReserved(mem_map+i))
                         reserved++;
-                else if (PageSwapCache(mem_map+i))
+                else if (page_swap_cache(mem_map+i))
                         cached++;
                 else if (page_count(mem_map+i))
                         shared += atomic_read(&mem_map[i].count) - 1;
--- 2.5.9/arch/s390x/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/s390x/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -79,7 +79,7 @@ void show_mem(void)
                 total++;
                 if (PageReserved(mem_map+i))
                         reserved++;
-                else if (PageSwapCache(mem_map+i))
+                else if (page_swap_cache(mem_map+i))
                         cached++;
                 else if (page_count(mem_map+i))
                         shared += atomic_read(&mem_map[i].count) - 1;
--- 2.5.9/arch/sh/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/sh/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -64,7 +64,7 @@ void show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (page_count(mem_map+i))
 			shared += page_count(mem_map+i) - 1;
--- 2.5.9/arch/x86_64/mm/init.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/arch/x86_64/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -60,7 +60,7 @@ void show_mem(void)
 		total++;
 		if (PageReserved(mem_map+i))
 			reserved++;
-		else if (PageSwapCache(mem_map+i))
+		else if (page_swap_cache(mem_map+i))
 			cached++;
 		else if (page_count(mem_map+i))
 			shared += page_count(mem_map+i) - 1;
--- 2.5.9/mm/page_alloc.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/page_alloc.c	Wed Apr 24 01:44:54 2002
@@ -106,7 +106,7 @@ static void __free_pages_ok (struct page
 		BUG();
 	if (!VALID_PAGE(page))
 		BUG();
-	if (PageSwapCache(page))
+	if (page_swap_cache(page))
 		BUG();
 	if (PageLocked(page))
 		BUG();
@@ -350,7 +350,7 @@ static struct page * balance_classzone(z
 						BUG();
 					if (!VALID_PAGE(page))
 						BUG();
-					if (PageSwapCache(page))
+					if (page_swap_cache(page))
 						BUG();
 					if (PageLocked(page))
 						BUG();
@@ -938,7 +938,7 @@ void __init free_area_init_core(int nid,
 			struct page *page = mem_map + offset + i;
 			set_page_zone(page, nid * MAX_NR_ZONES + j);
 			set_page_count(page, 0);
-			__SetPageReserved(page);
+			SetPageReserved(page);
 			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)
 				set_page_address(page, __va(zone_start_paddr));
--- 2.5.9/mm/page_io.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/page_io.c	Wed Apr 24 01:06:11 2002
@@ -94,12 +94,12 @@ void rw_swap_page(int rw, struct page *p
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
-	if (!PageSwapCache(page))
+	if (!page_swap_cache(page))
 		PAGE_BUG(page);
 	if (page->mapping != &swapper_space)
 		PAGE_BUG(page);
 	if (!rw_swap_page_base(rw, entry, page))
-		UnlockPage(page);
+		unlock_page(page);
 }
 
 /*
@@ -113,14 +113,14 @@ void rw_swap_page_nolock(int rw, swp_ent
 	
 	if (!PageLocked(page))
 		PAGE_BUG(page);
-	if (PageSwapCache(page))
+	if (page_swap_cache(page))
 		PAGE_BUG(page);
 	if (page->mapping)
 		PAGE_BUG(page);
 	/* needs sync_page to wait I/O completation */
 	page->mapping = &swapper_space;
 	if (!rw_swap_page_base(rw, entry, page))
-		UnlockPage(page);
+		unlock_page(page);
 	wait_on_page(page);
 	page->mapping = NULL;
 }
--- 2.5.9/mm/swap_state.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/swap_state.c	Wed Apr 24 01:06:11 2002
@@ -24,7 +24,7 @@
 static int swap_writepage(struct page *page)
 {
 	if (remove_exclusive_swap_page(page)) {
-		UnlockPage(page);
+		unlock_page(page);
 		return 0;
 	}
 	rw_swap_page(WRITE, page);
@@ -100,7 +100,7 @@ int add_to_swap_cache(struct page *page,
 	}
 	if (!PageLocked(page))
 		BUG();
-	if (!PageSwapCache(page))
+	if (!page_swap_cache(page))
 		BUG();
 	INC_CACHE_INFO(add_total);
 	return 0;
@@ -114,7 +114,7 @@ void __delete_from_swap_cache(struct pag
 {
 	if (!PageLocked(page))
 		BUG();
-	if (!PageSwapCache(page))
+	if (!page_swap_cache(page))
 		BUG();
 	ClearPageDirty(page);
 	__remove_inode_page(page);
@@ -239,14 +239,14 @@ void free_page_and_swap_cache(struct pag
 	/* 
 	 * If we are the only user, then try to free up the swap cache. 
 	 * 
-	 * Its ok to check for PageSwapCache without the page lock
+	 * Its ok to check for page_swap_cache without the page lock
 	 * here because we are going to recheck again inside 
 	 * exclusive_swap_page() _with_ the lock. 
 	 * 					- Marcelo
 	 */
-	if (PageSwapCache(page) && !TryLockPage(page)) {
+	if (page_swap_cache(page) && !TestSetPageLocked(page)) {
 		remove_exclusive_swap_page(page);
-		UnlockPage(page);
+		unlock_page(page);
 	}
 	page_cache_release(page);
 }
@@ -263,7 +263,7 @@ struct page * lookup_swap_cache(swp_entr
 
 	found = find_get_page(&swapper_space, entry.val);
 	/*
-	 * Unsafe to assert PageSwapCache and mapping on page found:
+	 * Unsafe to assert page_swap_cache and mapping on page found:
 	 * if SMP nothing prevents swapoff from deleting this page from
 	 * the swap cache at this moment.  find_lock_page would prevent
 	 * that, but no need to change: we _have_ got the right page.
--- 2.5.9/mm/swapfile.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/swapfile.c	Wed Apr 24 01:06:11 2002
@@ -269,7 +269,7 @@ int can_share_swap_page(struct page *pag
 			break;
 		/* Fallthrough */
 	case 2:
-		if (!PageSwapCache(page))
+		if (!page_swap_cache(page))
 			break;
 		retval = exclusive_swap_page(page);
 		break;
@@ -293,7 +293,7 @@ int remove_exclusive_swap_page(struct pa
 
 	if (!PageLocked(page))
 		BUG();
-	if (!PageSwapCache(page))
+	if (!page_swap_cache(page))
 		return 0;
 	if (page_count(page) - !!PagePrivate(page) != 2) /* 2: us + cache */
 		return 0;
@@ -348,7 +348,7 @@ void free_swap_and_cache(swp_entry_t ent
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 	}
 }
@@ -674,13 +674,13 @@ static int try_to_unuse(unsigned int typ
 		 * Note shmem_unuse already deleted its from swap cache.
 		 */
 		swcount = *swap_map;
-		if ((swcount > 0) != PageSwapCache(page))
+		if ((swcount > 0) != page_swap_cache(page))
 			BUG();
 		if ((swcount > 1) && PageDirty(page)) {
 			rw_swap_page(WRITE, page);
 			lock_page(page);
 		}
-		if (PageSwapCache(page))
+		if (page_swap_cache(page))
 			delete_from_swap_cache(page);
 
 		/*
@@ -689,7 +689,7 @@ static int try_to_unuse(unsigned int typ
 		 * mark page dirty so try_to_swap_out will preserve it.
 		 */
 		SetPageDirty(page);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 
 		/*
--- 2.5.9/drivers/block/rd.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/drivers/block/rd.c	Wed Apr 24 01:06:11 2002
@@ -106,19 +106,19 @@ int rd_blocksize = BLOCK_SIZE;			/* bloc
  */
 static int ramdisk_readpage(struct file *file, struct page * page)
 {
-	if (!Page_Uptodate(page)) {
+	if (!PageUptodate(page)) {
 		memset(kmap(page), 0, PAGE_CACHE_SIZE);
 		kunmap(page);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 }
 
 static int ramdisk_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
-	if (!Page_Uptodate(page)) {
+	if (!PageUptodate(page)) {
 		void *addr = page_address(page);
 		memset(addr, 0, PAGE_CACHE_SIZE);
 		flush_dcache_page(page);
@@ -173,7 +173,7 @@ static int rd_blkdev_pagecache_IO(int rw
 				goto out;
 			err = 0;
 
-			if (!Page_Uptodate(page)) {
+			if (!PageUptodate(page)) {
 				memset(kmap(page), 0, PAGE_CACHE_SIZE);
 				kunmap(page);
 				SetPageUptodate(page);
@@ -206,7 +206,7 @@ static int rd_blkdev_pagecache_IO(int rw
 			SetPageDirty(page);
 		}
 		if (unlock)
-			UnlockPage(page);
+			unlock_page(page);
 		__free_page(page);
 	} while (size);
 
--- 2.5.9/drivers/md/md.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/drivers/md/md.c	Wed Apr 24 01:06:11 2002
@@ -489,7 +489,7 @@ static int read_disk_sb(mdk_rdev_t * rde
 	if (IS_ERR(page))
 		goto out;
 	wait_on_page(page);
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto fail;
 	if (PageError(page))
 		goto fail;
@@ -948,14 +948,14 @@ static int write_disk_sb(mdk_rdev_t * rd
 						offs + MD_SB_BYTES);
 	if (error)
 		goto unlock;
-	UnlockPage(page);
+	unlock_page(page);
 	wait_on_page(page);
 	page_cache_release(page);
 	fsync_bdev(bdev);
 skip:
 	return 0;
 unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 fail:
 	printk("md: write_disk_sb failed for device %s\n", partition_name(dev));
--- 2.5.9/drivers/mtd/devices/blkmtd.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/drivers/mtd/devices/blkmtd.c	Wed Apr 24 01:06:11 2002
@@ -177,9 +177,9 @@ static int blkmtd_readpage(mtd_raw_dev_d
   DEBUG(2, "blkmtd: readpage called, dev = `%s' page = %p index = %ld\n",
 	bdevname(dev), page, page->index);
 
-  if(Page_Uptodate(page)) {
+  if(PageUptodate(page)) {
     DEBUG(2, "blkmtd: readpage page %ld is already upto date\n", page->index);
-    UnlockPage(page);
+    unlock_page(page);
     return 0;
   }
 
@@ -205,7 +205,7 @@ static int blkmtd_readpage(mtd_raw_dev_d
 	}
 	SetPageUptodate(page);
 	flush_dcache_page(page);
-	UnlockPage(page);
+	unlock_page(page);
 	spin_unlock(&mbd_writeq_lock);
 	return 0;
       }
@@ -283,7 +283,7 @@ static int blkmtd_readpage(mtd_raw_dev_d
     err = 0;
   }
   flush_dcache_page(page);
-  UnlockPage(page);
+  unlock_page(page);
   DEBUG(2, "blkmtd: readpage: finished, err = %d\n", err);
   return 0;
 }
@@ -419,7 +419,7 @@ static int write_queue_task(void *data)
       write_queue_tail %= write_queue_sz;
       if(!item->iserase) {
 	for(i = 0 ; i < item->pagecnt; i++) {
-	  UnlockPage(item->pages[i]);
+	  unlock_page(item->pages[i]);
 	  __free_pages(item->pages[i], 0);
 	}
 	kfree(item->pages);
@@ -473,7 +473,7 @@ static int queue_page_write(mtd_raw_dev_
       outpage = alloc_pages(GFP_KERNEL, 0);
       if(!outpage) {
 	while(i--) {
-	  UnlockPage(new_pages[i]);
+	  unlock_page(new_pages[i]);
 	  __free_pages(new_pages[i], 0);
 	}
 	kfree(new_pages);
@@ -610,7 +610,7 @@ static int blkmtd_erase(struct mtd_info 
     if(!err) {
       while(pagecnt--) {
 	SetPageUptodate(pages[pagecnt]);
-	UnlockPage(pages[pagecnt]);
+	unlock_page(pages[pagecnt]);
 	page_cache_release(pages[pagecnt]);
 	flush_dcache_page(pages[pagecnt]);
       }
@@ -666,7 +666,7 @@ static int blkmtd_read(struct mtd_info *
       return PTR_ERR(page);
     }
     wait_on_page(page);
-    if(!Page_Uptodate(page)) {
+    if(!PageUptodate(page)) {
       /* error reading page */
       printk("blkmtd: read: page not uptodate\n");
       page_cache_release(page);
@@ -809,7 +809,7 @@ static int blkmtd_write(struct mtd_info 
       }
       memcpy(page_address(page), buf, PAGE_SIZE);
       pages[pagecnt++] = page;
-      UnlockPage(page);
+      unlock_page(page);
       SetPageUptodate(page);
       pagenr++;
       pagesc--;
@@ -965,7 +965,7 @@ static void __exit cleanup_blkmtd(void)
     kfree(write_queue);
 
   if(erase_page) {
-    UnlockPage(erase_page);
+    unlock_page(erase_page);
     __free_pages(erase_page, 0);
   }
   printk("blkmtd: unloaded for %s\n", device);
--- 2.5.9/fs/affs/file.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/affs/file.c	Wed Apr 24 01:44:52 2002
@@ -618,7 +618,7 @@ affs_readpage_ofs(struct file *file, str
 	err = affs_do_readpage_ofs(file, page, 0, to);
 	if (!err)
 		SetPageUptodate(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 
@@ -630,7 +630,7 @@ static int affs_prepare_write_ofs(struct
 	int err = 0;
 
 	pr_debug("AFFS: prepare_write(%u, %ld, %d, %d)\n", (u32)inode->i_ino, page->index, from, to);
-	if (Page_Uptodate(page))
+	if (PageUptodate(page))
 		return 0;
 
 	size = inode->i_size;
@@ -830,7 +830,7 @@ affs_truncate(struct inode *inode)
 		res = mapping->a_ops->prepare_write(NULL, page, size, size);
 		if (!res)
 			res = mapping->a_ops->commit_write(NULL, page, size, size);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 		mark_inode_dirty(inode);
 		unlock_kernel();
--- 2.5.9/fs/buffer.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/buffer.c	Wed Apr 24 01:45:02 2002
@@ -555,7 +555,7 @@ static void end_buffer_io_async(struct b
 	 */
 	if (page_uptodate && !PageError(page))
 		SetPageUptodate(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return;
 
 still_busy:
@@ -808,7 +808,7 @@ init_page_buffers(struct page *page, str
 	unsigned int b_state;
 
 	b_state = 1 << BH_Mapped;
-	if (Page_Uptodate(page))
+	if (PageUptodate(page))
 		b_state |= 1 << BH_Uptodate;
 
 	do {
@@ -872,7 +872,7 @@ grow_dev_page(struct block_device *bdev,
 
 failed:
 	buffer_error();
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return NULL;
 }
@@ -911,7 +911,7 @@ grow_buffers(struct block_device *bdev, 
 	page = grow_dev_page(bdev, block, index, size);
 	if (!page)
 		return 0;
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return 1;
 }
@@ -1256,7 +1256,7 @@ static int __block_write_full_page(struc
 	if (!page_has_buffers(page)) {
 		if (S_ISBLK(inode->i_mode))
 			buffer_error();
-		if (!Page_Uptodate(page))
+		if (!PageUptodate(page))
 			buffer_error();
 		create_empty_buffers(page, 1 << inode->i_blkbits,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
@@ -1349,7 +1349,7 @@ done:
 		} while (bh != head);
 		if (uptodate)
 			SetPageUptodate(page);
-		UnlockPage(page);
+		unlock_page(page);
 	}
 	return err;
 recover:
@@ -1414,7 +1414,7 @@ static int __block_prepare_write(struct 
 	    block++, block_start=block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (Page_Uptodate(page))
+			if (PageUptodate(page))
 				mark_buffer_uptodate(bh, 1);
 			continue;
 		}
@@ -1426,7 +1426,7 @@ static int __block_prepare_write(struct 
 			if (buffer_new(bh)) {
 				clear_bit(BH_New, &bh->b_state);
 				unmap_underlying_metadata(bh);
-				if (Page_Uptodate(page)) {
+				if (PageUptodate(page)) {
 					if (!buffer_mapped(bh))
 						buffer_error();
 					mark_buffer_uptodate(bh, 1);
@@ -1442,7 +1442,7 @@ static int __block_prepare_write(struct 
 				continue;
 			}
 		}
-		if (Page_Uptodate(page)) {
+		if (PageUptodate(page)) {
 			mark_buffer_uptodate(bh, 1);
 			continue; 
 		}
@@ -1546,7 +1546,7 @@ int block_read_full_page(struct page *pa
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
-	if (Page_Uptodate(page))
+	if (PageUptodate(page))
 		buffer_error();
 	blocksize = 1 << inode->i_blkbits;
 	if (!page_has_buffers(page))
@@ -1593,7 +1593,7 @@ int block_read_full_page(struct page *pa
 		 */
 		if (!PageError(page))
 			SetPageUptodate(page);
-		UnlockPage(page);
+		unlock_page(page);
 		return 0;
 	}
 
@@ -1661,7 +1661,7 @@ int generic_cont_expand(struct inode *in
 	if (!err) {
 		err = mapping->a_ops->commit_write(NULL, page, offset, offset);
 	}
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	if (err > 0)
 		err = 0;
@@ -1693,7 +1693,7 @@ int cont_prepare_write(struct page *page
 			goto out;
 		/* we might sleep */
 		if (*bytes>>PAGE_CACHE_SHIFT != pgpos) {
-			UnlockPage(new_page);
+			unlock_page(new_page);
 			page_cache_release(new_page);
 			continue;
 		}
@@ -1712,7 +1712,7 @@ int cont_prepare_write(struct page *page
 		__block_commit_write(inode, new_page,
 				zerofrom, PAGE_CACHE_SIZE);
 		kunmap(new_page);
-		UnlockPage(new_page);
+		unlock_page(new_page);
 		page_cache_release(new_page);
 	}
 
@@ -1751,7 +1751,7 @@ out1:
 out_unmap:
 	ClearPageUptodate(new_page);
 	kunmap(new_page);
-	UnlockPage(new_page);
+	unlock_page(new_page);
 	page_cache_release(new_page);
 out:
 	return status;
@@ -1841,7 +1841,7 @@ int block_truncate_page(struct address_s
 	}
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (Page_Uptodate(page))
+	if (PageUptodate(page))
 		mark_buffer_uptodate(bh, 1);
 
 	if (!buffer_uptodate(bh)) {
@@ -1861,7 +1861,7 @@ int block_truncate_page(struct address_s
 	err = 0;
 
 unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 out:
 	return err;
@@ -1884,7 +1884,7 @@ int block_write_full_page(struct page *p
 	/* Is the page fully outside i_size? (truncate in progress) */
 	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
 	if (page->index >= end_index+1 || !offset) {
-		UnlockPage(page);
+		unlock_page(page);
 		return -EIO;
 	}
 
@@ -2126,7 +2126,7 @@ int block_symlink(struct inode *inode, c
 	mark_inode_dirty(inode);
 	return 0;
 fail_map:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 fail:
 	return err;
@@ -2138,7 +2138,7 @@ fail:
 static void check_ttfb_buffer(struct page *page, struct buffer_head *bh)
 {
 	if (!buffer_uptodate(bh)) {
-		if (Page_Uptodate(page) && page->mapping
+		if (PageUptodate(page) && page->mapping
 			&& buffer_mapped(bh)	/* discard_buffer */
 			&& S_ISBLK(page->mapping->host->i_mode))
 		{
@@ -2197,7 +2197,7 @@ static /*inline*/ int drop_buffers(struc
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	if (!was_uptodate && Page_Uptodate(page))
+	if (!was_uptodate && PageUptodate(page))
 		buffer_error();
 
 	do {
--- 2.5.9/fs/namei.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/namei.c	Wed Apr 24 01:06:11 2002
@@ -1957,7 +1957,7 @@ static char *page_getlink(struct dentry 
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page(page);
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto async_fail;
 	*ppage = page;
 	return kmap(page);
--- 2.5.9/fs/ext2/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/ext2/dir.c	Wed Apr 24 01:45:02 2002
@@ -166,7 +166,7 @@ static struct page * ext2_get_page(struc
 	if (!IS_ERR(page)) {
 		wait_on_page(page);
 		kmap(page);
-		if (!Page_Uptodate(page))
+		if (!PageUptodate(page))
 			goto fail;
 		if (!PageChecked(page))
 			ext2_check_page(page);
@@ -417,7 +417,7 @@ void ext2_set_link(struct inode *dir, st
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
-	UnlockPage(page);
+	unlock_page(page);
 	ext2_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
@@ -512,7 +512,7 @@ got_it:
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	ext2_put_page(page);
 out:
 	return err;
@@ -553,7 +553,7 @@ int ext2_delete_entry (struct ext2_dir_e
 		pde->rec_len = cpu_to_le16(to-from);
 	dir->inode = 0;
 	err = ext2_commit_chunk(page, from, to);
-	UnlockPage(page);
+	unlock_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 out:
@@ -597,7 +597,7 @@ int ext2_make_empty(struct inode *inode,
 
 	err = ext2_commit_chunk(page, 0, chunk_size);
 fail:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return err;
 }
--- 2.5.9/fs/ext3/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/ext3/inode.c	Wed Apr 24 01:44:52 2002
@@ -1291,7 +1291,7 @@ static int ext3_writepage(struct page *p
 	/* bget() all the buffers */
 	if (order_data) {
 		if (!page_has_buffers(page)) {
-			if (!Page_Uptodate(page))
+			if (!PageUptodate(page))
 				buffer_error();
 			create_empty_buffers(page,
 				inode->i_sb->s_blocksize,
@@ -1332,7 +1332,7 @@ out_fail:
 	
 	unlock_kernel();
 	SetPageDirty(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return ret;
 }
 
@@ -1422,7 +1422,7 @@ static int ext3_block_truncate_page(hand
 	}
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (Page_Uptodate(page))
+	if (PageUptodate(page))
 		set_bit(BH_Uptodate, &bh->b_state);
 
 	if (!buffer_uptodate(bh)) {
@@ -1457,7 +1457,7 @@ static int ext3_block_truncate_page(hand
 	}
 
 unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 out:
 	return err;
--- 2.5.9/fs/freevxfs/vxfs_subr.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/freevxfs/vxfs_subr.c	Wed Apr 24 01:06:11 2002
@@ -73,7 +73,7 @@ vxfs_get_page(struct address_space *mapp
 	if (!IS_ERR(pp)) {
 		wait_on_page(pp);
 		kmap(pp);
-		if (!Page_Uptodate(pp))
+		if (!PageUptodate(pp))
 			goto fail;
 		/** if (!PageChecked(pp)) **/
 			/** vxfs_check_page(pp); **/
--- 2.5.9/fs/jffs/inode-v23.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/jffs/inode-v23.c	Wed Apr 24 01:06:11 2002
@@ -739,7 +739,7 @@ jffs_do_readpage_nolock(struct file *fil
 		  (f->name ? f->name : ""), (long)page->index));
 
 	get_page(page);
-	/* Don't LockPage(page), should be locked already */
+	/* Don't SetPageLocked(page), should be locked already */
 	buf = page_address(page);
 	ClearPageUptodate(page);
 	ClearPageError(page);
@@ -789,7 +789,7 @@ jffs_do_readpage_nolock(struct file *fil
 static int jffs_readpage(struct file *file, struct page *page)
 {
 	int ret = jffs_do_readpage_nolock(file, page);
-	UnlockPage(page);
+	unlock_page(page);
 	return ret;
 }
 
@@ -1519,7 +1519,7 @@ jffs_prepare_write(struct file *filp, st
 	/* FIXME: we should detect some error conditions here */
 
 	/* Bugger that. We should make sure the page is uptodate */
-	if (!Page_Uptodate(page) && (from || to < PAGE_CACHE_SIZE))
+	if (!PageUptodate(page) && (from || to < PAGE_CACHE_SIZE))
 		return jffs_do_readpage_nolock(filp, page);
 
 	return 0;
--- 2.5.9/fs/jffs2/file.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/jffs2/file.c	Wed Apr 24 01:06:11 2002
@@ -281,7 +281,7 @@ int jffs2_do_readpage_nolock (struct ino
 int jffs2_do_readpage_unlock(struct inode *inode, struct page *pg)
 {
 	int ret = jffs2_do_readpage_nolock(inode, pg);
-	UnlockPage(pg);
+	unlock_page(pg);
 	return ret;
 }
 
@@ -371,7 +371,7 @@ int jffs2_prepare_write (struct file *fi
 	
 
 	/* Read in the page if it wasn't already present */
-	if (!Page_Uptodate(pg) && (start || end < PAGE_SIZE))
+	if (!PageUptodate(pg) && (start || end < PAGE_SIZE))
 		ret = jffs2_do_readpage_nolock(inode, pg);
 	D1(printk(KERN_DEBUG "end prepare_write()\n"));
 	up(&f->sem);
--- 2.5.9/fs/minix/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/minix/dir.c	Wed Apr 24 01:45:02 2002
@@ -66,7 +66,7 @@ static struct page * dir_get_page(struct
 	if (!IS_ERR(page)) {
 		wait_on_page(page);
 		kmap(page);
-		if (!Page_Uptodate(page))
+		if (!PageUptodate(page))
 			goto fail;
 	}
 	return page;
@@ -269,7 +269,7 @@ int minix_delete_entry(struct minix_dir_
 		de->inode = 0;
 		err = dir_commit_chunk(page, from, to);
 	}
-	UnlockPage(page);
+	unlock_page(page);
 	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -303,7 +303,7 @@ int minix_make_empty(struct inode *inode
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
 fail:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return err;
 }
@@ -369,7 +369,7 @@ void minix_set_link(struct minix_dir_ent
 		de->inode = inode->i_ino;
 		err = dir_commit_chunk(page, from, to);
 	}
-	UnlockPage(page);
+	unlock_page(page);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
--- 2.5.9/fs/ncpfs/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/ncpfs/dir.c	Wed Apr 24 01:06:11 2002
@@ -430,7 +430,7 @@ static int ncp_readdir(struct file *filp
 	ctl.cache = cache = kmap(page);
 	ctl.head  = cache->head;
 
-	if (!Page_Uptodate(page) || !ctl.head.eof)
+	if (!PageUptodate(page) || !ctl.head.eof)
 		goto init_cache;
 
 	if (filp->f_pos == 2) {
@@ -456,7 +456,7 @@ static int ncp_readdir(struct file *filp
 			if (!ctl.page)
 				goto invalid_cache;
 			ctl.cache = kmap(ctl.page);
-			if (!Page_Uptodate(ctl.page))
+			if (!PageUptodate(ctl.page))
 				goto invalid_cache;
 		}
 		while (ctl.idx < NCP_DIRCACHE_SIZE) {
@@ -481,7 +481,7 @@ static int ncp_readdir(struct file *filp
 		if (ctl.page) {
 			kunmap(ctl.page);
 			SetPageUptodate(ctl.page);
-			UnlockPage(ctl.page);
+			unlock_page(ctl.page);
 			page_cache_release(ctl.page);
 			ctl.page = NULL;
 		}
@@ -491,7 +491,7 @@ static int ncp_readdir(struct file *filp
 invalid_cache:
 	if (ctl.page) {
 		kunmap(ctl.page);
-		UnlockPage(ctl.page);
+		unlock_page(ctl.page);
 		page_cache_release(ctl.page);
 		ctl.page = NULL;
 	}
@@ -523,13 +523,13 @@ finished:
 		cache->head = ctl.head;
 		kunmap(page);
 		SetPageUptodate(page);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 	}
 	if (ctl.page) {
 		kunmap(ctl.page);
 		SetPageUptodate(ctl.page);
-		UnlockPage(ctl.page);
+		unlock_page(ctl.page);
 		page_cache_release(ctl.page);
 	}
 out:
@@ -597,7 +597,7 @@ ncp_fill_cache(struct file *filp, void *
 		if (ctl.page) {
 			kunmap(ctl.page);
 			SetPageUptodate(ctl.page);
-			UnlockPage(ctl.page);
+			unlock_page(ctl.page);
 			page_cache_release(ctl.page);
 		}
 		ctl.cache = NULL;
--- 2.5.9/fs/nfs/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/nfs/dir.c	Wed Apr 24 01:06:11 2002
@@ -123,12 +123,12 @@ int nfs_readdir_filler(nfs_readdir_descr
 	 */
 	if (page->index == 0)
 		invalidate_inode_pages(inode);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
  error:
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	invalidate_inode_pages(inode);
 	desc->error = error;
 	return -EIO;
@@ -202,7 +202,7 @@ int find_dirent_page(nfs_readdir_descrip
 		status = PTR_ERR(page);
 		goto out;
 	}
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto read_error;
 
 	/* NOTE: Someone else may have changed the READDIRPLUS flag */
--- 2.5.9/fs/nfs/symlink.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/nfs/symlink.c	Wed Apr 24 01:06:11 2002
@@ -44,13 +44,13 @@ static int nfs_symlink_filler(struct ino
 		goto error;
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 
 error:
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return -EIO;
 }
 
@@ -64,7 +64,7 @@ static char *nfs_getlink(struct inode *i
 				(filler_t *)nfs_symlink_filler, inode);
 	if (IS_ERR(page))
 		goto read_failed;
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto getlink_read_error;
 	*ppage = page;
 	p = kmap(page);
--- 2.5.9/fs/partitions/check.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/partitions/check.c	Wed Apr 24 01:06:11 2002
@@ -432,7 +432,7 @@ unsigned char *read_dev_sector(struct bl
 			(filler_t *)mapping->a_ops->readpage, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page(page);
-		if (!Page_Uptodate(page))
+		if (!PageUptodate(page))
 			goto fail;
 		if (PageError(page))
 			goto fail;
--- 2.5.9/fs/ramfs/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/ramfs/inode.c	Wed Apr 24 01:06:11 2002
@@ -47,20 +47,20 @@ static struct inode_operations ramfs_dir
  */
 static int ramfs_readpage(struct file *file, struct page * page)
 {
-	if (!Page_Uptodate(page)) {
+	if (!PageUptodate(page)) {
 		memset(kmap(page), 0, PAGE_CACHE_SIZE);
 		kunmap(page);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 }
 
 static int ramfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	void *addr = kmap(page);
-	if (!Page_Uptodate(page)) {
+	if (!PageUptodate(page)) {
 		memset(addr, 0, PAGE_CACHE_SIZE);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
--- 2.5.9/fs/reiserfs/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/reiserfs/inode.c	Wed Apr 24 01:44:52 2002
@@ -273,7 +273,7 @@ research:
             kunmap(bh_result->b_page) ;
 	// We do not return -ENOENT if there is a hole but page is uptodate, because it means
 	// That there is some MMAPED data associated with it that is yet to be written to disk.
-	if ((args & GET_BLOCK_NO_HOLE) && !Page_Uptodate(bh_result->b_page) ) {
+	if ((args & GET_BLOCK_NO_HOLE) && !PageUptodate(bh_result->b_page) ) {
 	    return -ENOENT ;
 	}
         return 0 ;
@@ -295,7 +295,7 @@ research:
 	} else 
 	    // We do not return -ENOENT if there is a hole but page is uptodate, because it means
 	    // That there is some MMAPED data associated with it that is yet to  be written to disk.
-	    if ((args & GET_BLOCK_NO_HOLE) && !Page_Uptodate(bh_result->b_page) ) {
+	    if ((args & GET_BLOCK_NO_HOLE) && !PageUptodate(bh_result->b_page) ) {
 	    ret = -ENOENT ;
 	    }
 
@@ -328,7 +328,7 @@ research:
 	** read old data off disk.  Set the up to date bit on the buffer instead
 	** and jump to the end
 	*/
-	    if (Page_Uptodate(bh_result->b_page)) {
+	    if (PageUptodate(bh_result->b_page)) {
 		mark_buffer_uptodate(bh_result, 1);
 		goto finished ;
     }
@@ -500,7 +500,7 @@ static int convert_tail_for_hole(struct 
 
 unlock:
     if (tail_page != hole_page) {
-        UnlockPage(tail_page) ;
+        unlock_page(tail_page) ;
 	page_cache_release(tail_page) ;
     }
 out:
@@ -1722,7 +1722,7 @@ out:
     return error ;
 
 unlock:
-    UnlockPage(page) ;
+    unlock_page(page) ;
     page_cache_release(page) ;
     return error ;
 }
@@ -1794,7 +1794,7 @@ void reiserfs_truncate_file(struct inode
 	        mark_buffer_dirty(bh) ;
 	    }
 	}
-	UnlockPage(page) ;
+	unlock_page(page) ;
 	page_cache_release(page) ;
     }
 
@@ -1996,7 +1996,7 @@ static int reiserfs_write_full_page(stru
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
     } else {
-        UnlockPage(page) ;
+        unlock_page(page) ;
     }
     if (!partial)
         SetPageUptodate(page) ;
@@ -2007,7 +2007,7 @@ fail:
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
     } else {
-        UnlockPage(page) ;
+        unlock_page(page) ;
     }
     ClearPageUptodate(page) ;
     return error ;
--- 2.5.9/fs/reiserfs/tail_conversion.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/reiserfs/tail_conversion.c	Wed Apr 24 01:44:52 2002
@@ -106,7 +106,7 @@ int direct2indirect (struct reiserfs_tra
 	** this avoids overwriting good data from writepage() with old data
 	** from the disk or buffer cache
 	*/
-	if (buffer_uptodate(unbh) || Page_Uptodate(unbh->b_page)) {
+	if (buffer_uptodate(unbh) || PageUptodate(unbh->b_page)) {
 	    up_to_date_bh = NULL ;
 	} else {
 	    up_to_date_bh = unbh ;
--- 2.5.9/fs/smbfs/cache.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/smbfs/cache.c	Wed Apr 24 01:06:11 2002
@@ -37,7 +37,7 @@ smb_invalid_dir_cache(struct inode * dir
 	if (!page)
 		goto out;
 
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto out_unlock;
 
 	cache = kmap(page);
@@ -46,7 +46,7 @@ smb_invalid_dir_cache(struct inode * dir
 	kunmap(page);
 	SetPageUptodate(page);
 out_unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 out:
 	return;
@@ -172,7 +172,7 @@ smb_fill_cache(struct file *filp, void *
 		if (ctl.page) {
 			kunmap(ctl.page);
 			SetPageUptodate(ctl.page);
-			UnlockPage(ctl.page);
+			unlock_page(ctl.page);
 			page_cache_release(ctl.page);
 		}
 		ctl.cache = NULL;
--- 2.5.9/fs/smbfs/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/smbfs/dir.c	Wed Apr 24 01:06:11 2002
@@ -102,9 +102,9 @@ smb_readdir(struct file *filp, void *dir
 	ctl.cache = cache = kmap(page);
 	ctl.head  = cache->head;
 
-	if (!Page_Uptodate(page) || !ctl.head.eof) {
+	if (!PageUptodate(page) || !ctl.head.eof) {
 		VERBOSE("%s/%s, page uptodate=%d, eof=%d\n",
-			 DENTRY_PATH(dentry), Page_Uptodate(page),ctl.head.eof);
+			 DENTRY_PATH(dentry), PageUptodate(page),ctl.head.eof);
 		goto init_cache;
 	}
 
@@ -136,7 +136,7 @@ smb_readdir(struct file *filp, void *dir
 			if (!ctl.page)
 				goto invalid_cache;
 			ctl.cache = kmap(ctl.page);
-			if (!Page_Uptodate(ctl.page))
+			if (!PageUptodate(ctl.page))
 				goto invalid_cache;
 		}
 		while (ctl.idx < SMB_DIRCACHE_SIZE) {
@@ -162,7 +162,7 @@ smb_readdir(struct file *filp, void *dir
 		if (ctl.page) {
 			kunmap(ctl.page);
 			SetPageUptodate(ctl.page);
-			UnlockPage(ctl.page);
+			unlock_page(ctl.page);
 			page_cache_release(ctl.page);
 			ctl.page = NULL;
 		}
@@ -172,7 +172,7 @@ smb_readdir(struct file *filp, void *dir
 invalid_cache:
 	if (ctl.page) {
 		kunmap(ctl.page);
-		UnlockPage(ctl.page);
+		unlock_page(ctl.page);
 		page_cache_release(ctl.page);
 		ctl.page = NULL;
 	}
@@ -197,13 +197,13 @@ finished:
 		cache->head = ctl.head;
 		kunmap(page);
 		SetPageUptodate(page);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 	}
 	if (ctl.page) {
 		kunmap(ctl.page);
 		SetPageUptodate(ctl.page);
-		UnlockPage(ctl.page);
+		unlock_page(ctl.page);
 		page_cache_release(ctl.page);
 	}
 out:
--- 2.5.9/fs/sysv/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/sysv/dir.c	Wed Apr 24 01:45:02 2002
@@ -60,7 +60,7 @@ static struct page * dir_get_page(struct
 	if (!IS_ERR(page)) {
 		wait_on_page(page);
 		kmap(page);
-		if (!Page_Uptodate(page))
+		if (!PageUptodate(page))
 			goto fail;
 	}
 	return page;
@@ -233,7 +233,7 @@ got_it:
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 out_unlock:
-	UnlockPage(page);
+	unlock_page(page);
 out_page:
 	dir_put_page(page);
 out:
@@ -255,7 +255,7 @@ int sysv_delete_entry(struct sysv_dir_en
 		BUG();
 	de->inode = 0;
 	err = dir_commit_chunk(page, from, to);
-	UnlockPage(page);
+	unlock_page(page);
 	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -288,7 +288,7 @@ int sysv_make_empty(struct inode *inode,
 
 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
 fail:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return err;
 }
@@ -352,7 +352,7 @@ void sysv_set_link(struct sysv_dir_entry
 		BUG();
 	de->inode = cpu_to_fs16(inode->i_sb, inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
-	UnlockPage(page);
+	unlock_page(page);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
--- 2.5.9/fs/udf/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/udf/inode.c	Wed Apr 24 01:44:52 2002
@@ -186,7 +186,7 @@ void udf_expand_file_adinicb(struct inod
 	page = grab_cache_page(inode->i_mapping, 0);
 	if (!PageLocked(page))
 		PAGE_BUG(page);
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 	{
 		kaddr = kmap(page);
 		memset(kaddr + UDF_I_LENALLOC(inode), 0x00,
--- 2.5.9/fs/umsdos/dir.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/umsdos/dir.c	Wed Apr 24 01:06:11 2002
@@ -693,7 +693,7 @@ struct dentry *umsdos_solve_hlink (struc
 	if (IS_ERR(page))
 		goto out;
 	wait_on_page(page);
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto async_fail;
 
 	dentry_dst = ERR_PTR(-ENOMEM);
--- 2.5.9/fs/umsdos/emd.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/umsdos/emd.c	Wed Apr 24 01:06:11 2002
@@ -140,7 +140,7 @@ int umsdos_emd_dir_readentry (struct den
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page(page);
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto async_fail;
 	p = (struct umsdos_dirent*)(kmap(page)+offs);
 
@@ -166,7 +166,7 @@ int umsdos_emd_dir_readentry (struct den
 			goto sync_fail;
 		}
 		wait_on_page(page2);
-		if (!Page_Uptodate(page2)) {
+		if (!PageUptodate(page2)) {
 			kunmap(page);
 			page_cache_release(page2);
 			goto async_fail;
@@ -276,7 +276,7 @@ int umsdos_writeentry (struct dentry *pa
 			goto out_unlock3;
 		ret = mapping->a_ops->commit_write(NULL,page,offs,
 					PAGE_CACHE_SIZE);
-		UnlockPage(page2);
+		unlock_page(page2);
 		page_cache_release(page2);
 		if (ret)
 			goto out_unlock;
@@ -292,7 +292,7 @@ int umsdos_writeentry (struct dentry *pa
 		if (ret)
 			goto out_unlock;
 	}
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 		
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -304,13 +304,13 @@ out:
 	Printk (("umsdos_writeentry /mn/: returning %d...\n", ret));
 	return ret;
 out_unlock3:
-	UnlockPage(page2);
+	unlock_page(page2);
 	page_cache_release(page2);
 out_unlock2:
 	ClearPageUptodate(page);
 	kunmap(page);
 out_unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	printk ("UMSDOS:  problem with EMD file:  can't write\n");
 	goto out_dput;
@@ -393,7 +393,7 @@ static int umsdos_find (struct dentry *d
 			if (IS_ERR(page))
 				goto sync_fail;
 			wait_on_page(page);
-			if (!Page_Uptodate(page))
+			if (!PageUptodate(page))
 				goto async_fail;
 			p = kmap(page);
 		}
@@ -442,7 +442,7 @@ static int umsdos_find (struct dentry *d
 				goto sync_fail;
 			}
 			wait_on_page(next_page);
-			if (!Page_Uptodate(next_page)) {
+			if (!PageUptodate(next_page)) {
 				page_cache_release(page);
 				page = next_page;
 				goto async_fail;
--- 2.5.9/mm/filemap.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/filemap.c	Wed Apr 24 01:45:02 2002
@@ -130,7 +130,7 @@ void invalidate_inode_pages(struct inode
 			continue;
 
 		/* ..or locked */
-		if (TryLockPage(page))
+		if (TestSetPageLocked(page))
 			continue;
 
 		if (PagePrivate(page) && !try_to_release_page(page, 0))
@@ -141,11 +141,11 @@ void invalidate_inode_pages(struct inode
 
 		__lru_cache_del(page);
 		__remove_inode_page(page);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 		continue;
 unlock:
-		UnlockPage(page);
+		unlock_page(page);
 		continue;
 	}
 
@@ -211,7 +211,7 @@ static int truncate_list_pages(struct ad
 			int failed;
 
 			page_cache_get(page);
-			failed = TryLockPage(page);
+			failed = TestSetPageLocked(page);
 
 			list_del(head);
 			if (!failed)
@@ -231,7 +231,7 @@ static int truncate_list_pages(struct ad
 				} else 
 					truncate_complete_page(page);
 
-				UnlockPage(page);
+				unlock_page(page);
 			} else
  				wait_on_page(page);
 
@@ -331,11 +331,11 @@ static int invalidate_list_pages2(struct
 	while (curr != head) {
 		page = list_entry(curr, struct page, list);
 
-		if (!TryLockPage(page)) {
+		if (!TestSetPageLocked(page)) {
 			int __unlocked;
 
 			__unlocked = invalidate_this_page2(mapping, page, curr, head);
-			UnlockPage(page);
+			unlock_page(page);
 			unlocked |= __unlocked;
 			if (!__unlocked) {
 				curr = curr->prev;
@@ -415,7 +415,7 @@ static int do_buffer_fdatasync(struct ad
 		if (page_has_buffers(page))
 			retval |= fn(page);
 
-		UnlockPage(page);
+		unlock_page(page);
 		write_lock(&mapping->page_lock);
 		curr = page->list.next;
 		page_cache_release(page);
@@ -480,7 +480,7 @@ int fail_writepage(struct page *page)
 
 	/* Set the page dirty again, unlock */
 	SetPageDirty(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 }
 
@@ -699,7 +699,7 @@ static void __lock_page(struct page *pag
 			sync_page(page);
 			schedule();
 		}
-		if (!TryLockPage(page))
+		if (!TestSetPageLocked(page))
 			break;
 	}
 	__set_task_state(tsk, TASK_RUNNING);
@@ -718,7 +718,7 @@ EXPORT_SYMBOL(wake_up_page);
  */
 void lock_page(struct page *page)
 {
-	if (TryLockPage(page))
+	if (TestSetPageLocked(page))
 		__lock_page(page);
 }
 
@@ -751,7 +751,7 @@ struct page *find_trylock_page(struct ad
 
 	read_lock(&mapping->page_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
-	if (page && TryLockPage(page))
+	if (page && TestSetPageLocked(page))
 		page = NULL;
 	read_unlock(&mapping->page_lock);
 	return page;
@@ -775,14 +775,14 @@ repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
-		if (TryLockPage(page)) {
+		if (TestSetPageLocked(page)) {
 			write_unlock(&mapping->page_lock);
 			lock_page(page);
 			write_lock(&mapping->page_lock);
 
 			/* Has the page been truncated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
-				UnlockPage(page);
+				unlock_page(page);
 				page_cache_release(page);
 				goto repeat;
 			}
@@ -891,12 +891,12 @@ struct page *grab_cache_page_nowait(stru
 	page = find_get_page(mapping, index);
 
 	if ( page ) {
-		if ( !TryLockPage(page) ) {
+		if ( !TestSetPageLocked(page) ) {
 			/* Page found and locked */
 			/* This test is overly paranoid, but what the heck... */
 			if ( unlikely(page->mapping != mapping || page->index != index) ) {
 				/* Someone reallocated this page under us. */
-				UnlockPage(page);
+				unlock_page(page);
 				page_cache_release(page);
 				return NULL;
 			} else {
@@ -1000,7 +1000,7 @@ found_page:
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
 
-		if (!Page_Uptodate(page))
+		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
 		/* If users can be writing to this page using arbitrary
@@ -1037,7 +1037,7 @@ page_ok:
 		break;
 
 page_not_up_to_date:
-		if (Page_Uptodate(page))
+		if (PageUptodate(page))
 			goto page_ok;
 
 		/* Get exclusive access to the page ... */
@@ -1045,14 +1045,14 @@ page_not_up_to_date:
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
-			UnlockPage(page);
+			unlock_page(page);
 			page_cache_release(page);
 			continue;
 		}
 
 		/* Did somebody else fill it already? */
-		if (Page_Uptodate(page)) {
-			UnlockPage(page);
+		if (PageUptodate(page)) {
+			unlock_page(page);
 			goto page_ok;
 		}
 
@@ -1061,10 +1061,10 @@ readpage:
 		error = mapping->a_ops->readpage(filp, page);
 
 		if (!error) {
-			if (Page_Uptodate(page))
+			if (PageUptodate(page))
 				goto page_ok;
 			wait_on_page(page);
-			if (Page_Uptodate(page))
+			if (PageUptodate(page))
 				goto page_ok;
 			error = -EIO;
 		}
@@ -1528,7 +1528,7 @@ retry_find:
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
 	 */
-	if (!Page_Uptodate(page))
+	if (!PageUptodate(page))
 		goto page_not_uptodate;
 
 success:
@@ -1569,20 +1569,20 @@ page_not_uptodate:
 
 	/* Did it get unhashed while we waited for it? */
 	if (!page->mapping) {
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 		goto retry_all;
 	}
 
 	/* Did somebody else get it up-to-date? */
-	if (Page_Uptodate(page)) {
-		UnlockPage(page);
+	if (PageUptodate(page)) {
+		unlock_page(page);
 		goto success;
 	}
 
 	if (!mapping->a_ops->readpage(file, page)) {
 		wait_on_page(page);
-		if (Page_Uptodate(page))
+		if (PageUptodate(page))
 			goto success;
 	}
 
@@ -1596,20 +1596,20 @@ page_not_uptodate:
 
 	/* Somebody truncated the page on us? */
 	if (!page->mapping) {
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 		goto retry_all;
 	}
 
 	/* Somebody else successfully read it in? */
-	if (Page_Uptodate(page)) {
-		UnlockPage(page);
+	if (PageUptodate(page)) {
+		unlock_page(page);
 		goto success;
 	}
 	ClearPageError(page);
 	if (!mapping->a_ops->readpage(file, page)) {
 		wait_on_page(page);
-		if (Page_Uptodate(page))
+		if (PageUptodate(page))
 			goto success;
 	}
 
@@ -2011,7 +2011,7 @@ repeat:
 
 /*
  * Read into the page cache. If a page already exists,
- * and Page_Uptodate() is not set, try to fill the page.
+ * and PageUptodate() is not set, try to fill the page.
  */
 struct page *read_cache_page(struct address_space *mapping,
 				unsigned long index,
@@ -2026,17 +2026,17 @@ retry:
 	if (IS_ERR(page))
 		goto out;
 	mark_page_accessed(page);
-	if (Page_Uptodate(page))
+	if (PageUptodate(page))
 		goto out;
 
 	lock_page(page);
 	if (!page->mapping) {
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 		goto retry;
 	}
-	if (Page_Uptodate(page)) {
-		UnlockPage(page);
+	if (PageUptodate(page)) {
+		unlock_page(page);
 		goto out;
 	}
 	err = filler(data, page);
@@ -2281,7 +2281,7 @@ unlock:
 		kunmap(page);
 		/* Mark it unlocked again and drop the page.. */
 		SetPageReferenced(page);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 
 		if (status < 0)
@@ -2317,7 +2317,7 @@ sync_failure:
 	 * few blocks outside i_size.  Trim these off again.
 	 */
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 	if (pos + bytes > inode->i_size)
 		vmtruncate(inode, inode->i_size);
--- 2.5.9/mm/mincore.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/mincore.c	Wed Apr 24 01:06:11 2002
@@ -31,7 +31,7 @@ static unsigned char mincore_page(struct
 
 	page = find_get_page(as, pgoff);
 	if (page) {
-		present = Page_Uptodate(page);
+		present = PageUptodate(page);
 		page_cache_release(page);
 	}
 
--- 2.5.9/mm/shmem.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/shmem.c	Wed Apr 24 01:06:11 2002
@@ -466,7 +466,7 @@ static int shmem_writepage(struct page *
 		spin_unlock(&info->lock);
 		SetPageUptodate(page);
 		set_page_dirty(page);
-		UnlockPage(page);
+		unlock_page(page);
 		return 0;
 	}
 
@@ -512,7 +512,7 @@ repeat:
 
 	page = find_get_page(mapping, idx);
 	if (page) {
-		if (TryLockPage(page))
+		if (TestSetPageLocked(page))
 			goto wait_retry;
 		spin_unlock (&info->lock);
 		return page;
@@ -533,7 +533,7 @@ repeat:
 				return ERR_PTR(-ENOMEM);
 			}
 			wait_on_page(page);
-			if (!Page_Uptodate(page) && entry->val == swap.val) {
+			if (!PageUptodate(page) && entry->val == swap.val) {
 				page_cache_release(page);
 				return ERR_PTR(-EIO);
 			}
@@ -545,12 +545,12 @@ repeat:
 		}
 
 		/* We have to do this with page locked to prevent races */
-		if (TryLockPage(page)) 
+		if (TestSetPageLocked(page)) 
 			goto wait_retry;
 
 		error = move_from_swap_cache(page, idx, mapping);
 		if (error < 0) {
-			UnlockPage(page);
+			unlock_page(page);
 			return ERR_PTR(error);
 		}
 
@@ -614,7 +614,7 @@ static int shmem_getpage(struct inode * 
 	if (IS_ERR (*ptr))
 		goto failed;
 
-	UnlockPage(*ptr);
+	unlock_page(*ptr);
 	up (&info->sem);
 	return 0;
 failed:
@@ -864,7 +864,7 @@ shmem_file_write(struct file *file,const
 		}
 unlock:
 		/* Mark it unlocked again and drop the page.. */
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 
 		if (status < 0)
@@ -1140,7 +1140,7 @@ static int shmem_symlink(struct inode * 
 		memcpy(kaddr, symname, len);
 		kunmap(page);
 		SetPageDirty(page);
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 		up(&info->sem);
 		inode->i_op = &shmem_symlink_inode_operations;
--- 2.5.9/drivers/char/drm/i810_dma.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/drivers/char/drm/i810_dma.c	Wed Apr 24 01:06:11 2002
@@ -287,7 +287,7 @@ static unsigned long i810_alloc_page(drm
 		return 0;
 
 	get_page(virt_to_page(address));
-	LockPage(virt_to_page(address));
+	SetPageLocked(virt_to_page(address));
 
 	return address;
 }
@@ -297,7 +297,7 @@ static void i810_free_page(drm_device_t 
 	if (page) {
 		struct page *p = virt_to_page(page);
 		put_page(p);
-		UnlockPage(p);
+		unlock_page(p);
 		free_page(page);
 	}
 }
--- 2.5.9/drivers/md/lvm-snap.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/drivers/md/lvm-snap.c	Wed Apr 24 01:06:11 2002
@@ -26,7 +26,7 @@
  *
  *    05/07/2000 - implemented persistent snapshot support
  *    23/11/2000 - used cpu_to_le64 rather than my own macro
- *    25/01/2001 - Put LockPage back in
+ *    25/01/2001 - Put SetPageLocked back in
  *    01/02/2001 - A dropped snapshot is now set as inactive
  *    12/03/2001 - lvm_pv_get_number changes:
  *                 o made it static
--- 2.5.9/mm/memory.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/memory.c	Wed Apr 24 01:06:11 2002
@@ -653,7 +653,7 @@ void unmap_kiobuf (struct kiobuf *iobuf)
 		map = iobuf->maplist[i];
 		if (map) {
 			if (iobuf->locked)
-				UnlockPage(map);
+				unlock_page(map);
 			/* FIXME: cache flush missing for rw==READ
 			 * FIXME: call the correct reference counting function
 			 */
@@ -698,11 +698,11 @@ int lock_kiovec(int nr, struct kiobuf *i
 			if (!page)
 				continue;
 			
-			if (TryLockPage(page)) {
+			if (TestSetPageLocked(page)) {
 				while (j--) {
 					struct page *tmp = *--ppage;
 					if (tmp)
-						UnlockPage(tmp);
+						unlock_page(tmp);
 				}
 				goto retry;
 			}
@@ -768,7 +768,7 @@ int unlock_kiovec(int nr, struct kiobuf 
 			page = *ppage;
 			if (!page)
 				continue;
-			UnlockPage(page);
+			unlock_page(page);
 		}
 	}
 	return 0;
@@ -982,7 +982,7 @@ static int do_wp_page(struct mm_struct *
 	if (!VALID_PAGE(old_page))
 		goto bad_wp_page;
 
-	if (!TryLockPage(old_page)) {
+	if (!TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
 		if (reuse) {
--- 2.5.9/./drivers/block/loop.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/./drivers/block/loop.c	Wed Apr 24 01:06:11 2002
@@ -220,14 +220,14 @@ static int lo_send(struct loop_device *l
 		offset = 0;
 		index++;
 		pos += size;
-		UnlockPage(page);
+		unlock_page(page);
 		page_cache_release(page);
 	}
 	up(&mapping->host->i_sem);
 	return 0;
 
 unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 fail:
 	up(&mapping->host->i_sem);
--- 2.5.9/drivers/char/agp/agpgart_be.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/drivers/char/agp/agpgart_be.c	Wed Apr 24 01:06:11 2002
@@ -785,7 +785,7 @@ static void agp_generic_destroy_page(uns
 
 	page = virt_to_page(pt);
 	put_page(page);
-	UnlockPage(page);
+	unlock_page(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
@@ -2780,7 +2780,7 @@ static void ali_destroy_page(unsigned lo
 
 	page = virt_to_page(pt);
 	put_page(page);
-	UnlockPage(page);
+	unlock_page(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
--- 2.5.9/fs/affs/symlink.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/affs/symlink.c	Wed Apr 24 01:06:11 2002
@@ -67,12 +67,12 @@ static int affs_symlink_readpage(struct 
 	unlock_kernel();
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 fail:
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 
--- 2.5.9/fs/coda/symlink.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/coda/symlink.c	Wed Apr 24 01:06:11 2002
@@ -40,13 +40,13 @@ static int coda_symlink_filler(struct fi
 		goto fail;
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 
 fail:
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return error;
 }
 
--- 2.5.9/fs/cramfs/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/cramfs/inode.c	Wed Apr 24 01:06:11 2002
@@ -425,7 +425,7 @@ static int cramfs_readpage(struct file *
 	kunmap(page);
 	flush_dcache_page(page);
 	SetPageUptodate(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 }
 
--- 2.5.9/fs/efs/symlink.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/efs/symlink.c	Wed Apr 24 01:06:11 2002
@@ -42,13 +42,13 @@ static int efs_symlink_readpage(struct f
 	unlock_kernel();
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 fail:
 	unlock_kernel();
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 
--- 2.5.9/fs/freevxfs/vxfs_immed.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/freevxfs/vxfs_immed.c	Wed Apr 24 01:06:11 2002
@@ -132,7 +132,7 @@ vxfs_immed_readpage(struct file *fp, str
 	
 	flush_dcache_page(pp);
 	SetPageUptodate(pp);
-        UnlockPage(pp);
+        unlock_page(pp);
 
 	return 0;
 }
--- 2.5.9/fs/hpfs/namei.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/hpfs/namei.c	Wed Apr 24 01:06:11 2002
@@ -448,14 +448,14 @@ int hpfs_symlink_readpage(struct file *f
 	unlock_kernel();
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 
 fail:
 	unlock_kernel();
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 	
--- 2.5.9/fs/isofs/compress.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/isofs/compress.c	Wed Apr 24 01:06:11 2002
@@ -164,7 +164,7 @@ static int zisofs_readpage(struct file *
 				flush_dcache_page(page);
 				SetPageUptodate(page);
 				kunmap(page);
-				UnlockPage(page);
+				unlock_page(page);
 				if ( fpage == xpage )
 					err = 0; /* The critical page */
 				else
@@ -282,7 +282,7 @@ static int zisofs_readpage(struct file *
 					flush_dcache_page(page);
 					SetPageUptodate(page);
 					kunmap(page);
-					UnlockPage(page);
+					unlock_page(page);
 					if ( fpage == xpage )
 						err = 0; /* The critical page */
 					else
@@ -313,7 +313,7 @@ eio:
 			if ( fpage == xpage )
 				SetPageError(page);
 			kunmap(page);
-			UnlockPage(page);
+			unlock_page(page);
 			if ( fpage != xpage )
 				page_cache_release(page);
 		}
--- 2.5.9/fs/isofs/rock.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/isofs/rock.c	Wed Apr 24 01:06:11 2002
@@ -566,7 +566,7 @@ static int rock_ridge_symlink_readpage(s
 	unlock_kernel();
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 
 	/* error exit from macro */
@@ -584,7 +584,7 @@ static int rock_ridge_symlink_readpage(s
 	unlock_kernel();
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return -EIO;
 }
 
--- 2.5.9/fs/jfs/jfs_metapage.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/jfs/jfs_metapage.c	Wed Apr 24 01:45:02 2002
@@ -494,7 +494,7 @@ static inline void sync_metapage(metapag
 		waitfor_one_page(page);
 	}
 
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 }
 
@@ -527,7 +527,7 @@ void release_metapage(metapage_t * mp)
 			mp->data = 0;
 			if (test_bit(META_dirty, &mp->flag))
 				__write_metapage(mp);
-			UnlockPage(mp->page);
+			unlock_page(mp->page);
 			if (test_bit(META_sync, &mp->flag)) {
 				sync_metapage(mp);
 				clear_bit(META_sync, &mp->flag);
@@ -536,7 +536,7 @@ void release_metapage(metapage_t * mp)
 			if (test_bit(META_discard, &mp->flag)) {
 				lock_page(mp->page);
 				block_flushpage(mp->page, 0);
-				UnlockPage(mp->page);
+				unlock_page(mp->page);
 			}
 
 			page_cache_release(mp->page);
@@ -593,7 +593,7 @@ void invalidate_metapages(struct inode *
 			page = find_lock_page(mapping, lblock>>l2BlocksPerPage);
 			if (page) {
 				block_flushpage(page, 0);
-				UnlockPage(page);
+				unlock_page(page);
 			}
 		}
 	}
@@ -610,7 +610,7 @@ void invalidate_inode_metapages(struct i
 		clear_bit(META_dirty, &mp->flag);
 		set_bit(META_discard, &mp->flag);
 		kunmap(mp->page);
-		UnlockPage(mp->page);
+		unlock_page(mp->page);
 		page_cache_release(mp->page);
 		INCREMENT(mpStat.pagefree);
 		mp->data = 0;
--- 2.5.9/fs/ncpfs/symlink.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/ncpfs/symlink.c	Wed Apr 24 01:06:11 2002
@@ -81,7 +81,7 @@ static int ncp_symlink_readpage(struct f
 		goto fail;
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 
 failEIO:
@@ -90,7 +90,7 @@ failEIO:
 fail:
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return error;
 }
 
--- 2.5.9/fs/nfs/read.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/nfs/read.c	Wed Apr 24 01:06:11 2002
@@ -145,7 +145,7 @@ nfs_readpage_sync(struct file *file, str
 
 io_error:
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return result;
 }
 
@@ -226,7 +226,7 @@ nfs_async_read_error(struct list_head *h
 		page = req->wb_page;
 		nfs_list_remove_request(req);
 		SetPageError(page);
-		UnlockPage(page);
+		unlock_page(page);
 		nfs_clear_request(req);
 		nfs_release_request(req);
 		nfs_unlock_request(req);
@@ -430,7 +430,7 @@ nfs_readpage_result(struct rpc_task *tas
 			SetPageError(page);
 		flush_dcache_page(page);
 		kunmap(page);
-		UnlockPage(page);
+		unlock_page(page);
 
 		dprintk("NFS: read (%s/%Ld %d@%Ld)\n",
                         req->wb_inode->i_sb->s_id,
@@ -483,7 +483,7 @@ out:
 	return error;
 
 out_error:
-	UnlockPage(page);
+	unlock_page(page);
 	goto out;
 }
 
--- 2.5.9/fs/nfs/write.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/nfs/write.c	Wed Apr 24 01:06:11 2002
@@ -272,7 +272,7 @@ do_it:
 	}
 	unlock_kernel();
 out:
-	UnlockPage(page);
+	unlock_page(page);
 	return err; 
 }
 
--- 2.5.9/fs/reiserfs/ioctl.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/reiserfs/ioctl.c	Wed Apr 24 01:06:11 2002
@@ -83,7 +83,7 @@ int reiserfs_unpack (struct inode * inod
     kunmap(page) ; /* mapped by prepare_write */
 
 out_unlock:
-    UnlockPage(page) ;
+    unlock_page(page) ;
     page_cache_release(page) ;
 
 out:
--- 2.5.9/fs/romfs/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/romfs/inode.c	Wed Apr 24 01:06:11 2002
@@ -432,7 +432,7 @@ romfs_readpage(struct file *file, struct
 	}
 	flush_dcache_page(page);
 
-	UnlockPage(page);
+	unlock_page(page);
 
 	kunmap(page);
 err_out:
--- 2.5.9/fs/smbfs/file.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/smbfs/file.c	Wed Apr 24 01:06:11 2002
@@ -94,7 +94,7 @@ smb_readpage_sync(struct dentry *dentry,
 
 io_error:
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return result;
 }
 
@@ -199,7 +199,7 @@ do_it:
 	get_page(page);
 	err = smb_writepage_sync(inode, page, 0, offset);
 	SetPageUptodate(page);
-	UnlockPage(page);
+	unlock_page(page);
 	put_page(page);
 	return err;
 }
--- 2.5.9/fs/udf/file.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/udf/file.c	Wed Apr 24 01:06:11 2002
@@ -71,7 +71,7 @@ static int udf_adinicb_readpage(struct f
 	SetPageUptodate(page);
 out:
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 
@@ -102,7 +102,7 @@ static int udf_adinicb_writepage(struct 
 	SetPageUptodate(page);
 out:
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 
--- 2.5.9/fs/udf/symlink.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/udf/symlink.c	Wed Apr 24 01:06:11 2002
@@ -111,13 +111,13 @@ static int udf_symlink_filler(struct fil
 	unlock_kernel();
 	SetPageUptodate(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return 0;
 out:
 	unlock_kernel();
 	SetPageError(page);
 	kunmap(page);
-	UnlockPage(page);
+	unlock_page(page);
 	return err;
 }
 
--- 2.5.9/fs/umsdos/inode.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/umsdos/inode.c	Wed Apr 24 01:06:11 2002
@@ -300,7 +300,7 @@ dentry->d_parent->d_name.name, dentry->d
 	 * EMD file. The msdos fs is not even called.
 	 */
 out_unlock:
-	UnlockPage(page);
+	unlock_page(page);
 	page_cache_release(page);
 out_dput:
 	dput(demd);
--- 2.5.9/mm/page-writeback.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/page-writeback.c	Wed Apr 24 01:45:02 2002
@@ -358,7 +358,7 @@ int generic_writeback_mapping(struct add
 					done = 1;
 			}
 		} else
-			UnlockPage(page);
+			unlock_page(page);
 
 		page_cache_release(page);
 		write_lock(&mapping->page_lock);
--- 2.5.9/mm/slab.c~cleanup-010-page_flags	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/slab.c	Wed Apr 24 01:06:11 2002
@@ -544,7 +544,7 @@ static inline void kmem_freepages (kmem_
 	 * vm_scan(). Shouldn't be a worry.
 	 */
 	while (i--) {
-		PageClearSlab(page);
+		ClearPageSlab(page);
 		page++;
 	}
 	free_pages((unsigned long)addr, cachep->gfporder);
@@ -1198,7 +1198,7 @@ static int kmem_cache_grow (kmem_cache_t
 	do {
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
-		PageSetSlab(page);
+		SetPageSlab(page);
 		page++;
 	} while (--i);
