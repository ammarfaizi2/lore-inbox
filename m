Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274931AbSITEvB>; Fri, 20 Sep 2002 00:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275017AbSITEvB>; Fri, 20 Sep 2002 00:51:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:3503 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S274931AbSITEuz>;
	Fri, 20 Sep 2002 00:50:55 -0400
Message-ID: <3D8AAA58.41BC835F@digeo.com>
Date: Thu, 19 Sep 2002 21:55:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [patch] remove page->virtual
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 04:55:52.0573 (UTC) FILETIME=[FEFAAAD0:01C26061]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hot off the presses.  Seems to work.




The patch removes page->virtual for all architectures which do not
define WANT_PAGE_VIRTUAL.  Hash for it instead.

Possibly we could define WANT_PAGE_VIRTUAL for CONFIG_HIHGMEM4G, but it
seems unlikely.

A lot of the pressure went off kmap() and page_address() as a result of
the move to kmap_atomic().  That should be the preferred way to address
CPU load in the set_page_address() and page_address() hashing and
locking.

If kmap_atomic is not usable then the next best approach is for users
to cache the result of kmap() in a local rather than calling
page_address() repeatedly.


One heavy user of kmap() and page_address() is the ext2 directory code.

On a 7G Quad PIII, running four concurrent instances of

	while true
	do
		find /usr/src/linux > /dev/null
	done

on ext2 with everything cached, profiling shows that the new hashed
set_page_address() and page_address() implementations consume 0.4% and
1.3% of CPU time respectively.   I think that's OK. (Plus the tested code
was doing an unneeded lookup in set_page_address(), for debug purposes)


c0141684 865      1.31499     page_address
c013851c 871      1.32411     kmem_cache_alloc
c015a068 1038     1.57799     dget_locked
c014ddfc 1220     1.85467     vfs_getattr
c014dd80 1320     2.00669     generic_fillattr
c0144f88 1359     2.06598     sys_chdir
c0159e60 1384     2.10398     dput
c014e334 1385     2.1055      cp_new_stat64
c01090c0 1741     2.6467      system_call
c0145b6a 1753     2.66494     .text.lock.open
c0151114 1786     2.71511     path_release
c0155d3c 2172     3.30192     filldir64
c0187580 2473     3.7595      ext2_readdir
c01eb950 2562     3.8948      atomic_dec_and_lock
c01eb690 2814     4.2779      __generic_copy_to_user
c015aba4 3194     4.85558     __d_lookup
c015207c 3567     5.42262     path_lookup
c01515dc 3775     5.73883     link_path_walk
c01eb99e 3811     5.79355     .text.lock.dec_and_lock
c01546b3 5847     8.88872     .text.lock.namei
c01884f2 6914     10.5108     .text.lock.dir



 include/linux/mm.h |   48 ++++++++----------
 init/main.c        |    1 
 kernel/ksyms.c     |    3 +
 mm/highmem.c       |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 mm/page_alloc.c    |    5 +
 5 files changed, 164 insertions(+), 34 deletions(-)

--- 2.5.36/include/linux/mm.h~remove-page-virtual	Thu Sep 19 20:36:27 2002
+++ 2.5.36-akpm/include/linux/mm.h	Thu Sep 19 21:03:06 2002
@@ -176,7 +176,7 @@ struct page {
 	 * Architectures with slow multiplication can define
 	 * WANT_PAGE_VIRTUAL in asm/page.h
 	 */
-#if defined(CONFIG_HIGHMEM) || defined(WANT_PAGE_VIRTUAL)
+#if defined(WANT_PAGE_VIRTUAL)
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
@@ -289,38 +289,34 @@ static inline void set_page_zone(struct 
 	page->flags |= zone_num << ZONE_SHIFT;
 }
 
-/*
- * In order to avoid #ifdefs within C code itself, we define
- * set_page_address to a noop for non-highmem machines, where
- * the field isn't useful.
- * The same is true for page_address() in arch-dependent code.
- */
-#if defined(CONFIG_HIGHMEM) || defined(WANT_PAGE_VIRTUAL)
+#define lowmem_page_address(page)					\
+	__va( ( ((page) - page_zone(page)->zone_mem_map)		\
+			+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
+
+#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
+#define HASHED_PAGE_VIRTUAL
+#endif
 
+#if defined(WANT_PAGE_VIRTUAL)
+#define page_address(page) ((page)->virtual)
 #define set_page_address(page, address)			\
 	do {						\
 		(page)->virtual = (address);		\
 	} while(0)
+#define page_address_init()  do { } while(0)
+#endif
 
-#else /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
-#define set_page_address(page, address)  do { } while(0)
-#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
+#if defined(HASHED_PAGE_VIRTUAL)
+void *page_address(struct page *page);
+void set_page_address(struct page *page, void *virtual);
+void page_address_init(void);
+#endif
 
-/*
- * Permanent address of a page. Obviously must never be
- * called on a highmem page.
- */
-#if defined(CONFIG_HIGHMEM) || defined(WANT_PAGE_VIRTUAL)
-
-#define page_address(page) ((page)->virtual)
-
-#else /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
-
-#define page_address(page)						\
-	__va( ( ((page) - page_zone(page)->zone_mem_map)		\
-			+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
-
-#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
+#if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
+#define page_address(page) lowmem_page_address(page)
+#define set_page_address(page, address)  do { } while(0)
+#define page_address_init()  do { } while(0)
+#endif
 
 /*
  * Return true if this page is mapped into pagetables.  Subtle: test pte.direct
--- 2.5.36/init/main.c~remove-page-virtual	Thu Sep 19 20:36:27 2002
+++ 2.5.36-akpm/init/main.c	Thu Sep 19 20:36:27 2002
@@ -436,6 +436,7 @@ asmlinkage void __init start_kernel(void
 		initrd_start = 0;
 	}
 #endif
+	page_address_init();
 	mem_init();
 	kmem_cache_sizes_init();
 	pidhash_init();
--- 2.5.36/kernel/ksyms.c~remove-page-virtual	Thu Sep 19 20:36:27 2002
+++ 2.5.36-akpm/kernel/ksyms.c	Thu Sep 19 20:36:27 2002
@@ -133,6 +133,9 @@ EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(kmap_prot);
 EXPORT_SYMBOL(kmap_pte);
 #endif
+#ifdef HASHED_PAGE_VIRTUAL
+EXPORT_SYMBOL(page_address);
+#endif
 EXPORT_SYMBOL(get_user_pages);
 
 /* filesystem internal functions */
--- 2.5.36/mm/highmem.c~remove-page-virtual	Thu Sep 19 20:36:27 2002
+++ 2.5.36-akpm/mm/highmem.c	Thu Sep 19 20:46:18 2002
@@ -22,6 +22,7 @@
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
+#include <linux/hash.h>
 #include <asm/pgalloc.h>
 
 static mempool_t *page_pool, *isa_page_pool;
@@ -88,7 +89,7 @@ static void flush_all_zero_pkmaps(void)
 		page = pte_page(pkmap_page_table[i]);
 		pte_clear(&pkmap_page_table[i]);
 
-		page->virtual = NULL;
+		set_page_address(page, NULL);
 	}
 	flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
@@ -126,8 +127,8 @@ start:
 			spin_lock(&kmap_lock);
 
 			/* Somebody else might have mapped it while we slept */
-			if (page->virtual)
-				return (unsigned long) page->virtual;
+			if (page_address(page))
+				return (unsigned long)page_address(page);
 
 			/* Re-start */
 			goto start;
@@ -137,7 +138,7 @@ start:
 	set_pte(&(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
 
 	pkmap_count[last_pkmap_nr] = 1;
-	page->virtual = (void *) vaddr;
+	set_page_address(page, (void *)vaddr);
 
 	return vaddr;
 }
@@ -153,7 +154,7 @@ void *kmap_high(struct page *page)
 	 * We cannot call this from interrupts, as it may block
 	 */
 	spin_lock(&kmap_lock);
-	vaddr = (unsigned long) page->virtual;
+	vaddr = (unsigned long)page_address(page);
 	if (!vaddr)
 		vaddr = map_new_virtual(page);
 	pkmap_count[PKMAP_NR(vaddr)]++;
@@ -170,7 +171,7 @@ void kunmap_high(struct page *page)
 	int need_wakeup;
 
 	spin_lock(&kmap_lock);
-	vaddr = (unsigned long) page->virtual;
+	vaddr = (unsigned long)page_address(page);
 	if (!vaddr)
 		BUG();
 	nr = PKMAP_NR(vaddr);
@@ -467,7 +468,7 @@ void blk_queue_bounce(request_queue_t *q
 	*bio_orig = bio;
 }
 
-#if CONFIG_DEBUG_HIGHMEM
+#if defined(CONFIG_DEBUG_HIGHMEM) && defined(CONFIG_HIGHMEM)
 void check_highmem_ptes(void)
 {
 	int idx, type;
@@ -482,3 +483,129 @@ void check_highmem_ptes(void)
 }
 #endif
 
+#if defined(HASHED_PAGE_VIRTUAL)
+
+#define PA_HASH_ORDER	7
+
+/*
+ * Describes one page->virtual association
+ */
+static struct page_address_map {
+	struct page *page;
+	void *virtual;
+	struct list_head list;
+} page_address_maps[LAST_PKMAP];
+
+/*
+ * page_address_map freelist, allocated from page_address_maps.
+ */
+static struct list_head page_address_pool;	/* freelist */
+static spinlock_t pool_lock;			/* yech */
+
+/*
+ * Hash table bucket
+ */
+static struct page_address_slot {
+	struct list_head lh;
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp page_address_htable[1<<PA_HASH_ORDER];
+
+static struct page_address_slot *page_slot(struct page *page)
+{
+	return &page_address_htable[hash_ptr(page, PA_HASH_ORDER)];
+}
+
+void *page_address(struct page *page)
+{
+	unsigned long flags;
+	void *ret;
+	struct page_address_slot *pas;
+
+	if (!PageHighMem(page))
+		return lowmem_page_address(page);
+
+	pas = page_slot(page);
+	ret = NULL;
+	spin_lock_irqsave(&pas->lock, flags);
+	if (!list_empty(&pas->lh)) {
+		struct page_address_map *pam;
+
+		list_for_each_entry(pam, &pas->lh, list) {
+			if (pam->page == page) {
+				ret = pam->virtual;
+				goto done;
+			}
+		}
+	}
+done:
+	spin_unlock_irqrestore(&pas->lock, flags);
+	return ret;
+}
+
+void set_page_address(struct page *page, void *virtual)
+{
+	unsigned long flags;
+	struct page_address_slot *pas;
+	struct page_address_map *pam;
+
+	BUG_ON(!PageHighMem(page));
+
+	if (virtual) {
+		void *addr = page_address(page);
+		if (addr) {
+			printk("eek!\n");
+			if (addr != virtual)
+				printk("double eek!\n");
+		}
+	}
+
+	pas = page_slot(page);
+	if (virtual) {
+		BUG_ON(list_empty(&page_address_pool));
+
+		spin_lock_irqsave(&pool_lock, flags);
+		pam = list_entry(page_address_pool.next,
+				struct page_address_map, list);
+		list_del(&pam->list);
+		spin_unlock_irqrestore(&pool_lock, flags);
+
+		pam->page = page;
+		pam->virtual = virtual;
+
+		spin_lock_irqsave(&pas->lock, flags);
+		list_add_tail(&pam->list, &pas->lh);
+		spin_unlock_irqrestore(&pas->lock, flags);
+	} else {
+		spin_lock_irqsave(&pas->lock, flags);
+		list_for_each_entry(pam, &pas->lh, list) {
+			if (pam->page == page) {
+				list_del(&pam->list);
+				spin_unlock_irqrestore(&pas->lock, flags);
+				spin_lock_irqsave(&pool_lock, flags);
+				list_add_tail(&pam->list, &page_address_pool);
+				spin_unlock_irqrestore(&pool_lock, flags);
+				goto done;
+			}
+		}
+		spin_unlock_irqrestore(&pas->lock, flags);
+		printk("aargh!\n");
+	}
+done:
+	return;
+}
+
+void __init page_address_init(void)
+{
+	int i;
+
+	INIT_LIST_HEAD(&page_address_pool);
+	for (i = 0; i < ARRAY_SIZE(page_address_maps); i++)
+		list_add(&page_address_maps[i].list, &page_address_pool);
+	for (i = 0; i < ARRAY_SIZE(page_address_htable); i++) {
+		INIT_LIST_HEAD(&page_address_htable[i].lh);
+		spin_lock_init(&page_address_htable[i].lock);
+	}
+	spin_lock_init(&pool_lock);
+}
+
+#endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */
--- 2.5.36/mm/page_alloc.c~remove-page-virtual	Thu Sep 19 20:36:27 2002
+++ 2.5.36-akpm/mm/page_alloc.c	Thu Sep 19 20:36:27 2002
@@ -917,12 +917,15 @@ void __init free_area_init_core(pg_data_
 			set_page_count(page, 0);
 			SetPageReserved(page);
 			INIT_LIST_HEAD(&page->list);
+#ifdef WANT_PAGE_VIRTUAL
 			if (j != ZONE_HIGHMEM)
 				/*
 				 * The shift left won't overflow because the
 				 * ZONE_NORMAL is below 4G.
 				 */
-				set_page_address(page, __va(zone_start_pfn << PAGE_SHIFT));
+				set_page_address(page,
+					__va(zone_start_pfn << PAGE_SHIFT));
+#endif
 			zone_start_pfn++;
 		}
 

.
