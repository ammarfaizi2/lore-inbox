Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312574AbSDJLCO>; Wed, 10 Apr 2002 07:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312575AbSDJLCN>; Wed, 10 Apr 2002 07:02:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58117 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312574AbSDJLCH>;
	Wed, 10 Apr 2002 07:02:07 -0400
Message-ID: <3CB41BA7.DAC3A785@zip.com.au>
Date: Wed, 10 Apr 2002 04:01:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Rusty Russell <rusty@rustcorp.com.au>
Subject: [brokenpatch] page accounting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch implements per-CPU accounting of the global number
of locked, diry and pagecache pages.

It also busts the headers up a bit, breaking the various
SetPageFoo() macros into <linux/page-flags.h>. The page
accounting declarations are in <linux/page-accounting.h>
The intent here is that these headers be included directly
in the .c files which need them.  But at this stage they're
just pulled into mm.h.

The locked and dirty page accounting is needed for making
writeback and throttling decisions in the address_space-based
writeback code.

Problem is, I just converted it to use the new per-CPU code
and it broke.  The numbers aren't correct.  It worked fine
with open-coded per-CPU accumulators.  Rusty, can you spot
the error?


=====================================

--- 2.5.8-pre3/arch/sparc64/kernel/sys_sunos32.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/arch/sparc64/kernel/sys_sunos32.c	Wed Apr 10 03:44:59 2002
@@ -157,7 +157,7 @@ asmlinkage int sunos_brk(u32 baddr)
 	 * fool it, but this should catch most mistakes.
 	 */
 	freepages = atomic_read(&buffermem_pages) >> PAGE_SHIFT;
-	freepages += atomic_read(&page_cache_size);
+	freepages += get_page_cache_size();
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
--- 2.5.8-pre3/arch/sparc/kernel/sys_sunos.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/arch/sparc/kernel/sys_sunos.c	Wed Apr 10 03:44:59 2002
@@ -193,7 +193,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * fool it, but this should catch most mistakes.
 	 */
 	freepages = atomic_read(&buffermem_pages) >> PAGE_SHIFT;
-	freepages += atomic_read(&page_cache_size);
+	freepages += get_page_cache_size();
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
--- 2.5.8-pre3/drivers/md/lvm-snap.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/drivers/md/lvm-snap.c	Wed Apr 10 03:44:59 2002
@@ -34,6 +34,7 @@
  *                 o pv number is returned in new uint * arg
  *                 o -1 returned on error
  *                 lvm_snapshot_fill_COW_table has a return value too.
+ *    25/02/2002 - s/LockPage/SetPageLocked/ - akpm@zip.com.au
  *
  */
 
@@ -451,7 +452,7 @@ int lvm_snapshot_alloc_iobuf_pages(struc
 			goto out;
 
 		iobuf->maplist[i] = page;
-		LockPage(page);
+		SetPageLocked(page);
 		iobuf->nr_pages++;
 	}
 	iobuf->offset = 0;
--- 2.5.8-pre3/fs/proc/proc_misc.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/fs/proc/proc_misc.c	Wed Apr 10 03:44:59 2002
@@ -129,14 +129,16 @@ static int meminfo_read_proc(char *page,
 	struct sysinfo i;
 	int len;
 	int pg_size ;
+	struct page_state ps;
 
+	get_page_state(&ps);
 /*
  * display in kilobytes.
  */
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
+	pg_size = get_page_cache_size() - i.bufferram ;
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -155,7 +157,9 @@ static int meminfo_read_proc(char *page,
 		"LowTotal:     %8lu kB\n"
 		"LowFree:      %8lu kB\n"
 		"SwapTotal:    %8lu kB\n"
-		"SwapFree:     %8lu kB\n",
+		"SwapFree:     %8lu kB\n"
+		"Dirty:        %8lu kB\n"
+		"Locked:       %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -169,7 +173,10 @@ static int meminfo_read_proc(char *page,
 		K(i.totalram-i.totalhigh),
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
-		K(i.freeswap));
+		K(i.freeswap),
+		K(ps.nr_dirty),
+		K(ps.nr_locked)
+		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
--- 2.5.8-pre3/include/linux/mm.h~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/include/linux/mm.h	Wed Apr 10 03:44:59 2002
@@ -244,7 +244,7 @@ typedef struct page {
  *   to be written to disk,
  * - private pages which have been modified may need to be swapped out
  *   to swap space and (later) to be read back into memory.
- * During disk I/O, PG_locked is used. This bit is set before I/O
+ * During disk I/O, PG_locked_dontuse is used. This bit is set before I/O
  * and reset when I/O completes. page_waitqueue(page) is a wait queue of all
  * tasks waiting for the I/O on this page to complete.
  * PG_uptodate tells whether the page's contents is valid.
@@ -260,7 +260,7 @@ typedef struct page {
  *
  * Note that the referenced bit, the page->lru list_head and the
  * active, inactive_dirty and inactive_clean lists are protected by
- * the pagemap_lru_lock, and *NOT* by the usual PG_locked bit!
+ * the pagemap_lru_lock, and *NOT* by the usual PG_locked_dontuse bit!
  *
  * PG_skip is used on sparc/sparc64 architectures to "skip" certain
  * parts of the address space.
@@ -276,43 +276,35 @@ typedef struct page {
  * the pages. The struct page (these bits with information) are always
  * mapped into kernel address space...
  */
-#define PG_locked		 0	/* Page is locked. Don't touch. */
+
+/*
+ * Don't use the *_dontuse flags.  Use the macros.  Otherwise
+ * you'll break locked- and dirty-page accounting.
+ */
+#define PG_locked_dontuse	 0	/* Page is locked. Don't touch. */
 #define PG_error		 1
 #define PG_referenced		 2
 #define PG_uptodate		 3
-#define PG_dirty		 4
+#define PG_dirty_dontuse	 4
 #define PG_unused		 5
 #define PG_lru			 6
 #define PG_active		 7
-#define PG_slab			 8
-#define PG_skip			10
+#define PG_slab			 8	/* kill me if needed: slab debug */
+#define PG_skip			10	/* kill me now: obsolete */
 #define PG_highmem		11
 #define PG_checked		12	/* kill me in 2.5.<early>. */
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
-
 #define PG_private		16	/* Has something at ->private */
 
-/* Make it prettier to test the above... */
-#define UnlockPage(page)	unlock_page(page)
-#define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
-#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
-#define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
-#define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
-#define SetPageDirty(page)	set_bit(PG_dirty, &(page)->flags)
-#define ClearPageDirty(page)	clear_bit(PG_dirty, &(page)->flags)
-#define PageLocked(page)	test_bit(PG_locked, &(page)->flags)
-#define LockPage(page)		set_bit(PG_locked, &(page)->flags)
-#define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
-#define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
-#define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
-#define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
-#define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
-#define __SetPageReserved(page)	__set_bit(PG_reserved, &(page)->flags)
-#define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
-#define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
-#define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+/*
+ * FIXME: take this include out, include page-flags.h in
+ * files which need it (119 of them)
+ */
+#include <linux/percpu.h>
+#include <linux/page-accounting.h>
+#include <linux/page-flags.h>
 
 /*
  * The zone field is never updated after free_area_init_core()
@@ -371,41 +363,6 @@ static inline void set_page_zone(struct 
 extern void FASTCALL(set_page_dirty(struct page *));
 
 /*
- * The first mb is necessary to safely close the critical section opened by the
- * TryLockPage(), the second mb is necessary to enforce ordering between
- * the clear_bit and the read of the waitqueue (to avoid SMP races with a
- * parallel wait_on_page).
- */
-#define PageError(page)		test_bit(PG_error, &(page)->flags)
-#define SetPageError(page)	set_bit(PG_error, &(page)->flags)
-#define ClearPageError(page)	clear_bit(PG_error, &(page)->flags)
-#define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
-#define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
-#define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
-#define PageTestandClearReferenced(page)	test_and_clear_bit(PG_referenced, &(page)->flags)
-#define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
-#define PageSetSlab(page)	set_bit(PG_slab, &(page)->flags)
-#define PageClearSlab(page)	clear_bit(PG_slab, &(page)->flags)
-#define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
-
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-
-#define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
-#define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
-#define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
-
-#ifdef CONFIG_HIGHMEM
-#define PageHighMem(page)		test_bit(PG_highmem, &(page)->flags)
-#else
-#define PageHighMem(page)		0 /* needed to optimize away at compile time */
-#endif
-
-#define SetPageReserved(page)		set_bit(PG_reserved, &(page)->flags)
-#define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
-
-/*
  * Error return values for the *_nopage functions
  */
 #define NOPAGE_SIGBUS	(NULL)
@@ -593,6 +550,7 @@ extern int pdflush_operation(void (*fn)(
 extern int pdflush_flush(unsigned long nr_pages);
 
 extern struct page * vmalloc_to_page(void *addr);
+extern unsigned long get_page_cache_size(void);
 
 #endif /* __KERNEL__ */
 
--- 2.5.8-pre3/include/linux/pagemap.h~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/include/linux/pagemap.h	Wed Apr 10 03:45:57 2002
@@ -41,8 +41,6 @@ static inline struct page *page_cache_al
  */
 #define page_cache_entry(x)	virt_to_page(x)
 
-extern atomic_t page_cache_size; /* # of pages currently in the page cache */
-
 extern struct page * find_get_page(struct address_space *mapping,
 				unsigned long index);
 extern struct page * find_lock_page(struct address_space *mapping,
@@ -61,6 +59,7 @@ extern int add_to_page_cache(struct page
 		struct address_space *mapping, unsigned long index);
 extern int add_to_page_cache_unique(struct page *page,
 		struct address_space *mapping, unsigned long index);
+
 static inline void ___add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index)
 {
@@ -69,7 +68,7 @@ static inline void ___add_to_page_cache(
 	page->index = index;
 
 	mapping->nrpages++;
-	atomic_inc(&page_cache_size);
+	inc_page_state(nr_pagecache);
 }
 
 extern void FASTCALL(lock_page(struct page *page));
--- 2.5.8-pre3/include/linux/swap.h~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/include/linux/swap.h	Wed Apr 10 03:44:59 2002
@@ -100,7 +100,6 @@ extern unsigned int nr_free_buffer_pages
 extern int nr_active_pages;
 extern int nr_inactive_pages;
 extern atomic_t nr_async_pages;
-extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
 extern spinlock_t pagecache_lock;
 extern void __remove_inode_page(struct page *);
--- 2.5.8-pre3/mm/filemap.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/mm/filemap.c	Wed Apr 10 03:44:59 2002
@@ -46,7 +46,6 @@
  * SMP-threaded pagemap-LRU 1999, Andrea Arcangeli <andrea@suse.de>
  */
 
-atomic_t page_cache_size = ATOMIC_INIT(0);
 
 /*
  * Lock ordering:
@@ -74,7 +73,7 @@ void __remove_inode_page(struct page *pa
 	page->mapping = NULL;
 
 	mapping->nrpages--;
-	atomic_dec(&page_cache_size);
+	dec_page_state(nr_pagecache);
 }
 
 void remove_inode_page(struct page *page)
@@ -103,7 +102,7 @@ static inline int sync_page(struct page 
  */
 void set_page_dirty(struct page *page)
 {
-	if (!test_and_set_bit(PG_dirty, &page->flags)) {
+	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page->mapping;
 
 		if (mapping) {
@@ -583,13 +582,13 @@ int filemap_fdatawait(struct address_spa
 static int __add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long offset)
 {
-	unsigned long flags;
-
 	page_cache_get(page);
 	if (radix_tree_insert(&mapping->page_tree, offset, page) < 0)
 		goto nomem;
-	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
-	page->flags = flags | (1 << PG_locked);
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+			1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
+	SetPageLocked(page);
+	ClearPageDirty(page);
 	___add_to_page_cache(page, mapping, offset);
 	return 0;
  nomem:
@@ -714,7 +713,7 @@ void unlock_page(struct page *page)
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	clear_bit(PG_launder, &(page)->flags);
 	smp_mb__before_clear_bit();
-	if (!test_and_clear_bit(PG_locked, &(page)->flags))
+	if (!TestClearPageLocked(page))
 		BUG();
 	smp_mb__after_clear_bit(); 
 	if (waitqueue_active(waitqueue))
--- 2.5.8-pre3/mm/mmap.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/mm/mmap.c	Wed Apr 10 03:44:59 2002
@@ -69,7 +69,7 @@ int vm_enough_memory(long pages)
 	    return 1;
 
 	/* The page cache contains buffer pages these days.. */
-	free = atomic_read(&page_cache_size);
+	free = get_page_cache_size();
 	free += nr_free_pages();
 	free += nr_swap_pages;
 
--- 2.5.8-pre3/mm/page_alloc.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/mm/page_alloc.c	Wed Apr 10 03:44:59 2002
@@ -111,7 +111,8 @@ static void __free_pages_ok (struct page
 		BUG();
 	if (PageActive(page))
 		BUG();
-	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
+	ClearPageDirty(page);
+	page->flags &= ~(1<<PG_referenced);
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
@@ -533,6 +534,40 @@ unsigned int nr_free_highpages (void)
 }
 #endif
 
+/*
+ * Accumulate the page_state information across all CPUs.
+ * The result is unavoidably approximate - it can change
+ * during and after execution of this function.
+ */
+struct page_state page_states __per_cpu_data;
+EXPORT_SYMBOL(page_states);
+
+void get_page_state(struct page_state *ret)
+{
+	int pcpu;
+
+	ret->nr_dirty = 0;
+	ret->nr_locked = 0;
+	ret->nr_pagecache = 0;
+
+	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
+		struct page_state *ps;
+
+		ps = &per_cpu(page_states, cpu_logical_map(pcpu));
+		ret->nr_dirty += ps->nr_dirty;
+		ret->nr_locked += ps->nr_locked;
+		ret->nr_pagecache += ps->nr_pagecache;
+	}
+}
+
+unsigned long get_page_cache_size(void)
+{
+	struct page_state ps;
+
+	get_page_state(&ps);
+	return ps.nr_pagecache;
+}
+
 #define K(x) ((x) << (PAGE_SHIFT-10))
 
 /*
--- 2.5.8-pre3/mm/vmscan.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/mm/vmscan.c	Wed Apr 10 03:44:59 2002
@@ -409,7 +409,7 @@ static int shrink_cache(int nr_pages, zo
 			/*
 			 * It is not critical here to write it only if
 			 * the page is unmapped beause any direct writer
-			 * like O_DIRECT would set the PG_dirty bitflag
+			 * like O_DIRECT would set the page's dirty bitflag
 			 * on the phisical page after having successfully
 			 * pinned it and after the I/O to the page is finished,
 			 * so the direct writes to the page cannot get lost.
--- 2.5.8-pre3/drivers/char/agp/agpgart_be.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/drivers/char/agp/agpgart_be.c	Wed Apr 10 03:44:59 2002
@@ -770,7 +770,7 @@ static unsigned long agp_generic_alloc_p
 		return 0;
 
 	get_page(page);
-	LockPage(page);
+	SetPageLocked(page);
 	atomic_inc(&agp_bridge.current_memory_agp);
 	return (unsigned long)page_address(page);
 }
@@ -2744,7 +2744,7 @@ static unsigned long ali_alloc_page(void
 		return 0;
 
 	get_page(page);
-	LockPage(page);
+	SetPageLocked(page);
 	atomic_inc(&agp_bridge.current_memory_agp);
 
 	global_cache_flush();
--- 2.5.8-pre3/mm/swap_state.c~dallocbase-35-page_accounting	Wed Apr 10 03:44:59 2002
+++ 2.5.8-pre3-akpm/mm/swap_state.c	Wed Apr 10 03:44:59 2002
@@ -159,10 +159,11 @@ int move_to_swap_cache(struct page *page
 
 		/* Add it to the swap cache */
 		*pslot = page;
-		page->flags = ((page->flags & ~(1 << PG_uptodate | 1 << PG_error
-						| 1 << PG_dirty  | 1 << PG_referenced
-						| 1 << PG_arch_1 | 1 << PG_checked))
-			       | (1 << PG_locked));
+		page->flags &= ~(1 << PG_uptodate | 1 << PG_error
+				| 1 << PG_referenced | 1 << PG_arch_1
+				| 1 << PG_checked);
+		SetPageLocked(page);
+		ClearPageDirty(page);
 		___add_to_page_cache(page, &swapper_space, entry.val);
 	}
 
@@ -207,7 +208,7 @@ int move_from_swap_cache(struct page *pa
 		page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 				 1 << PG_referenced | 1 << PG_arch_1 |
 				 1 << PG_checked);
-		page->flags |= (1 << PG_dirty);
+		SetPageDirty(page);
 		___add_to_page_cache(page, mapping, index);
 	}
 
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.8-pre3-akpm/include/linux/page-flags.h	Wed Apr 10 03:44:59 2002
@@ -0,0 +1,120 @@
+/*
+ * Macros for manipulating and testing page->flags
+ */
+
+#ifndef PAGE_FLAGS_H
+#define PAGE_FLAGS_H
+
+#define UnlockPage(page)	unlock_page(page)
+#define PageLocked(page)	test_bit(PG_locked_dontuse, &(page)->flags)
+#define SetPageLocked(page)						\
+	do {								\
+		if (!test_and_set_bit(PG_locked_dontuse,		\
+				&(page)->flags))			\
+			inc_page_state(nr_locked);			\
+	} while (0)
+#define LockPage(page)		SetPageLocked(page)	/* grr.  kill me */
+#define TryLockPage(page)						\
+	({								\
+		int ret;						\
+		ret = test_and_set_bit(PG_locked_dontuse,		\
+					&(page)->flags);		\
+		if (!ret)						\
+			inc_page_state(nr_locked);			\
+		ret;							\
+	})
+#define ClearPageLocked(page)						\
+	do {								\
+		if (test_and_clear_bit(PG_locked_dontuse,		\
+				&(page)->flags))			\
+			dec_page_state(nr_locked);			\
+	} while (0)
+#define TestClearPageLocked(page)					\
+	({								\
+		int ret;						\
+		ret = test_and_clear_bit(PG_locked_dontuse,		\
+				&(page)->flags);			\
+		if (ret)						\
+			dec_page_state(nr_locked);			\
+		ret;							\
+	})
+
+#define PageError(page)		test_bit(PG_error, &(page)->flags)
+#define SetPageError(page)	set_bit(PG_error, &(page)->flags)
+#define ClearPageError(page)	clear_bit(PG_error, &(page)->flags)
+
+#define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
+#define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
+#define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
+#define PageTestandClearReferenced(page)	test_and_clear_bit(PG_referenced, &(page)->flags)
+
+#define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
+#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
+#define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
+
+#define PageDirty(page)		test_bit(PG_dirty_dontuse, &(page)->flags)
+#define SetPageDirty(page)						\
+	do {								\
+		if (!test_and_set_bit(PG_dirty_dontuse,			\
+					&(page)->flags))		\
+			inc_page_state(nr_dirty);			\
+	} while (0)
+#define TestSetPageDirty(page)						\
+	({								\
+		int ret;						\
+		ret = test_and_set_bit(PG_dirty_dontuse,		\
+				&(page)->flags);			\
+		if (!ret)						\
+			inc_page_state(nr_dirty);			\
+		ret;							\
+	})
+#define ClearPageDirty(page)						\
+	do {								\
+		if (test_and_clear_bit(PG_dirty_dontuse,		\
+				&(page)->flags))			\
+			dec_page_state(nr_dirty);			\
+	} while (0)
+#define TestClearPageDirty(page)					\
+	({								\
+		int ret;						\
+		ret = test_and_clear_bit(PG_dirty_dontuse,		\
+				&(page)->flags);			\
+		if (ret)						\
+			dec_page_state(nr_dirty);			\
+		ret;							\
+	})
+
+#define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
+#define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
+#define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
+
+#define PageActive(page)	test_bit(PG_active, &(page)->flags)
+#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
+#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
+
+#define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
+#define PageSetSlab(page)	set_bit(PG_slab, &(page)->flags)
+#define PageClearSlab(page)	clear_bit(PG_slab, &(page)->flags)
+#define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
+
+#ifdef CONFIG_HIGHMEM
+#define PageHighMem(page)	test_bit(PG_highmem, &(page)->flags)
+#else
+#define PageHighMem(page)	0 /* needed to optimize away at compile time */
+#endif
+
+#define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
+#define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+
+#define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
+#define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
+#define __SetPageReserved(page)	__set_bit(PG_reserved, &(page)->flags)
+
+#define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
+#define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
+
+#define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
+#define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
+#define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+
+#endif	/* PAGE_FLAGS_H */
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.8-pre3-akpm/include/linux/page-accounting.h	Wed Apr 10 03:55:31 2002
@@ -0,0 +1,33 @@
+/*
+ * Per-CPU page accounting.  Inclusion of this file requires
+ * that <linux/percpu.h> be included beforehand.
+ */
+
+#ifndef PAGE_ACCOUNTING_H
+#define PAGE_ACCOUNTING_H
+
+/*
+ * Dirty- and locked-page accounting.  One instance per CPU.
+ */
+struct page_state {
+	unsigned long nr_dirty;
+	unsigned long nr_locked;
+	unsigned long nr_pagecache;
+};
+
+extern struct page_state page_states;
+
+extern void get_page_state(struct page_state *ret);
+
+#define mod_page_state(member, delta)					\
+	do {								\
+		preempt_disable();					\
+		this_cpu(page_states).member += delta;			\
+		preempt_enable();					\
+	} while (0)
+
+#define inc_page_state(member)	mod_page_state(member, 1UL)
+#define dec_page_state(member)	mod_page_state(member, 0UL - 1)
+
+#endif		/* PAGE_ACCOUNTING_H */
+


-
