Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbTCTXMQ>; Thu, 20 Mar 2003 18:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbTCTXID>; Thu, 20 Mar 2003 18:08:03 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:1963 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263248AbTCTXDs>; Thu, 20 Mar 2003 18:03:48 -0500
Date: Thu, 20 Mar 2003 23:16:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] anobjrmap 5/6 rechained
In-Reply-To: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303202316020.2743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anonjrmap 5/6 virtual address chains for odd cases

Two exceptions remain to be handled.  The nonlinear file-backed
pages (mapped into a vma at a different location than implied by
by page->index and vm_pgoff) from Ingo's sys_remap_file_pages,
and anonymous pages sys_mremap'ed to a different location while
shared (copy-on-write) with another mm.

Bring back chains to handle these, but list user virtual addresses
not pte addresses: user virtual addresses are invariant across fork,
just bump the count, no need to allocate any memory.

And since copy_page_range won't need to allocate such buffers,
we can do a much simpler implementation than before: "rmap_get_cpu"
called just before taking page_table_lock allocates one rmap_chain
for the cpu (if not already there) in case subsequent page_add_rmap
might need it.  These chains too rare for kmem_cache, just kmalloc.

The other awkward case before was swapoff's unuse_pte.  But an
anonymous page cannot appear in two places in the same mm (until
Ingo adds sys_remap_anon_pages_in_several_places_at_once), so
only one rmap_chain needed as elsewhere - make that explicit by
returning as soon as found.  And try_to_unuse desist at last from
holding the mmlist_lock across the whole search of mms: we can't
rmap_get_cpu (may kmalloc non-atomically) while holding that lock.

There may well be some better data structure to deal with these
cases, but both are very rare - though the nonlinear presumably
will become more common.  Perhaps when we see how it gets used,
someone can propose a better structure, this will do for now.

 include/linux/mm.h         |    7 
 include/linux/page-flags.h |    5 
 include/linux/rmap.h       |    4 
 mm/fremap.c                |    4 
 mm/memory.c                |   21 ++
 mm/mremap.c                |   13 +
 mm/page_alloc.c            |    3 
 mm/rmap.c                  |  351 +++++++++++++++++++++++++++++++++++++--------
 mm/swapfile.c              |   83 ++++++----
 9 files changed, 393 insertions(+), 98 deletions(-)

--- anobjrmap4/include/linux/mm.h	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/include/linux/mm.h	Thu Mar 20 17:10:34 2003
@@ -165,7 +165,10 @@
 	unsigned long index;		/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by zone->lru_lock !! */
-	unsigned long rmap_count;	/* Count mappings in mms */
+	union {				/* Depending on PG_chained */
+		unsigned long count;	/* Count mappings in mms, or */
+		struct rmap_chain *chain;/* Scattered mappings pointer */
+	} rmap;				/* Protected by PG_rmaplock */
 	unsigned long private;		/* mapping-private opaque data */
 
 	/*
@@ -364,7 +367,7 @@
  * refers to user virtual address space into which the page is mapped.
  */
 #define page_mapping(page) (PageAnon(page)? NULL: (page)->mapping)
-#define page_mapped(page)  ((page)->rmap_count != 0)
+#define page_mapped(page)  ((page)->rmap.count != 0)
 
 /*
  * Error return values for the *_nopage functions
--- anobjrmap4/include/linux/page-flags.h	Thu Mar 20 17:10:12 2003
+++ anobjrmap5/include/linux/page-flags.h	Thu Mar 20 17:10:34 2003
@@ -70,6 +70,7 @@
 #define PG_nosave		14	/* Used for system suspend/resume */
 #define PG_rmaplock		15	/* Lock bit for reversing to ptes */
 
+#define PG_chained		16	/* Has rmap chain of scattered maps */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
@@ -239,6 +240,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageChained(page)	test_bit(PG_chained, &(page)->flags)
+#define SetPageChained(page)	set_bit(PG_chained, &(page)->flags)
+#define ClearPageChained(page)	clear_bit(PG_chained, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- anobjrmap4/include/linux/rmap.h	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/include/linux/rmap.h	Thu Mar 20 17:10:34 2003
@@ -8,9 +8,13 @@
 #include <linux/linkage.h>
 
 #ifdef CONFIG_MMU
+int rmap_get_cpu(void);
+
 void page_add_rmap(struct page *, struct vm_area_struct *,
 			unsigned long addr, int anon);
 void page_turn_rmap(struct page *, struct vm_area_struct *);
+void page_move_rmap(struct page *, struct vm_area_struct *,
+			unsigned long oaddr, unsigned long naddr);
 void FASTCALL(page_dup_rmap(struct page *));
 void FASTCALL(page_remove_rmap(struct page *));
 
--- anobjrmap4/mm/fremap.c	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/mm/fremap.c	Thu Mar 20 17:10:34 2003
@@ -58,7 +58,10 @@
 	pmd_t *pmd;
 
 	pgd = pgd_offset(mm, addr);
+	if (!rmap_get_cpu())
+		goto err;
 	spin_lock(&mm->page_table_lock);
+	put_cpu();
 
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
@@ -83,6 +86,7 @@
 	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
+err:
 	return err;
 }
 
--- anobjrmap4/mm/memory.c	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/mm/memory.c	Thu Mar 20 17:10:34 2003
@@ -1141,19 +1141,23 @@
 	mark_page_accessed(page);
 	lock_page(page);
 
+	if (!rmap_get_cpu()) {
+		ret = VM_FAULT_OOM;
+		goto outrel;
+	}
+	spin_lock(&mm->page_table_lock);
+	put_cpu();
+	page_table = pte_offset_map(pmd, address);
+
 	/*
 	 * Back out if somebody else faulted in this pte while we
 	 * released the page table lock.
 	 */
-	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
 	if (!pte_same(*page_table, orig_pte)) {
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
-		unlock_page(page);
-		page_cache_release(page);
 		ret = VM_FAULT_MINOR;
-		goto out;
+		goto outrel;
 	}
 
 	/* The page isn't present yet, go ahead with the fault. */
@@ -1179,6 +1183,10 @@
 	spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
+outrel:
+	unlock_page(page);
+	page_cache_release(page);
+	goto out;
 }
 
 /*
@@ -1291,7 +1299,10 @@
 		anon = 1;
 	}
 
+	if (!rmap_get_cpu())
+		goto oom;
 	spin_lock(&mm->page_table_lock);
+	put_cpu();
 	page_table = pte_offset_map(pmd, address);
 
 	/*
--- anobjrmap4/mm/mremap.c	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/mm/mremap.c	Thu Mar 20 17:10:34 2003
@@ -96,11 +96,8 @@
 			page = pte_page(*src);
 		pte = ptep_get_and_clear(src);
 		set_pte(dst, pte);
-		if (page) {
-			int anon = PageAnon(page);
-			page_remove_rmap(page);
-			page_add_rmap(page, vma, new_addr, anon);
-		}
+		if (page)
+			page_move_rmap(page, vma, old_addr, new_addr);
 	}
 	return 0;
 }
@@ -113,7 +110,12 @@
 	int error = 0;
 	pte_t *src, *dst;
 
+	if (!rmap_get_cpu()) {
+		error = -ENOMEM;
+		goto out;
+	}
 	spin_lock(&mm->page_table_lock);
+	put_cpu();
 	src = get_one_pte_map_nested(mm, old_addr);
 	if (src) {
 		/*
@@ -134,6 +136,7 @@
 	}
 	flush_tlb_page(vma, old_addr);
 	spin_unlock(&mm->page_table_lock);
+out:
 	return error;
 }
 
--- anobjrmap4/mm/page_alloc.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap5/mm/page_alloc.c	Thu Mar 20 17:10:34 2003
@@ -81,6 +81,7 @@
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_rmaplock  |
+			1 << PG_chained   |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback);
@@ -220,6 +221,7 @@
 			1 << PG_active	|
 			1 << PG_reclaim	|
 			1 << PG_rmaplock  |
+			1 << PG_chained   |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
@@ -327,6 +329,7 @@
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_rmaplock  |
+			1 << PG_chained   |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
--- anobjrmap4/mm/rmap.c	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/mm/rmap.c	Thu Mar 20 17:10:34 2003
@@ -27,11 +27,35 @@
 #include <linux/percpu.h>
 #include <asm/tlbflush.h>
 
-#define page_mapcount(page)	((page)->rmap_count)
+/*
+ * struct rmap_chain: extension of struct page, to track scattered
+ * mappings originating from sys_mremap of anonymous cow pages, or
+ * sys_remap_file_pages.  Each cpu caches one to grab while locked.
+ */
+struct rmap_chain {
+#define NRSLOT	7			/* first contains count, then */
+	unsigned long slot[NRSLOT];	/* user virtual addresses */
+	struct rmap_chain *next;
+};
+static DEFINE_PER_CPU(struct rmap_chain *, rmap_chain) = 0;
+
+#define page_mapcount(page) (unlikely(PageChained(page))? \
+	(page)->rmap.chain->slot[0]: (page)->rmap.count)
 
 #define NOADDR	(~0UL)		/* impossible user virtual address */
 
 /*
+ * struct addresser: for next_rmap_address to dole out user
+ * addresses one by one to page_referenced or to try_to_unmap.
+ */
+struct addresser {
+	unsigned long address;
+	unsigned long count;
+	struct rmap_chain *chain;
+	int index;
+};
+
+/*
  * struct anonmm: to track a bundle of anonymous memory mappings.
  *
  * Could be embedded in mm_struct, but mm_struct is rather heavyweight,
@@ -64,6 +88,147 @@
 }
 
 /**
+ ** Functions for manipulating struct rmap_chain.
+ **/
+
+/*
+ * Boolean rmap_get_cpu ensures that the cpu has an rmap_chain
+ * cached in case it is needed later while lock is held; it is never
+ * needed when page_add_rmap is adding a freshly allocated anon page.
+ * Caller does put_cpu() once page_table_lock prevents preemption.
+ */
+int
+rmap_get_cpu(void)
+{
+	struct rmap_chain **cache;
+
+	might_sleep();
+	cache = &per_cpu(rmap_chain, get_cpu());
+	if (unlikely(!*cache)) {
+		struct rmap_chain *chain;
+
+		put_cpu();
+		chain = kmalloc(sizeof(*chain), GFP_KERNEL);
+		cache = &per_cpu(rmap_chain, get_cpu());
+		if (*cache)
+			kfree(chain);
+		else if (chain)
+			*cache = chain;
+		else {
+			put_cpu();
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static struct rmap_chain *
+get_rmap_chain(void)
+{
+	struct rmap_chain **cache;
+	struct rmap_chain *chain;
+	int i;
+
+	/*
+	 * page_table_lock and rmap_lock are held, no need to get_cpu
+	 */
+	cache = &per_cpu(rmap_chain, smp_processor_id());
+	chain = *cache;
+	*cache = NULL;
+	BUG_ON(!chain);
+	for (i = 0; i < NRSLOT; i++)
+		chain->slot[i] = NOADDR;
+	chain->next = NULL;
+	return chain;
+}
+
+static void
+add_rmap_address(struct page *page, unsigned long address)
+{
+	struct rmap_chain *chain;
+	int i = 1;
+
+	if (PageChained(page)) {
+		/*
+		 * Check lest duplicate, and find free slot at end
+		 */
+		for (chain = page->rmap.chain; ; chain = chain->next, i = 0) {
+			for (; i < NRSLOT; i++) {
+				if (chain->slot[i] == NOADDR)
+					goto set;
+				if (chain->slot[i] == address)
+					return;
+			}
+			if (!chain->next)
+				chain->next = get_rmap_chain();
+		}
+	} else {
+		SetPageChained(page);
+		chain = get_rmap_chain();
+		chain->slot[0] = page->rmap.count;
+		page->rmap.chain = chain;
+	}
+set:
+	chain->slot[i] = address;
+}
+
+static int
+next_rmap_address(struct page *page,
+	struct vm_area_struct *vma, struct addresser *addresser)
+{
+	if (addresser->index == 0) {
+		/* set chain and index for next call */
+		addresser->chain =
+			PageChained(page)? page->rmap.chain: NULL;
+		addresser->index = 1;
+		if (vma) {
+			addresser->address = vma_address(page, vma);
+			if (addresser->address != NOADDR)
+				return 1;
+		} else {
+			addresser->address = page->index;
+			return 1;
+		}
+	}
+	while (addresser->chain) {
+		if (addresser->index >= NRSLOT)
+			addresser->index = 0;
+		addresser->address =
+			addresser->chain->slot[addresser->index];
+		if (addresser->address == NOADDR)
+			break;
+		addresser->index++;
+		if (addresser->index >= NRSLOT)
+			addresser->chain = addresser->chain->next;
+		if (!vma || addresser->address != vma_address(page, vma))
+			return 1;
+	}
+	return 0;
+}
+
+static void
+clear_page_chained(struct page *page)
+{
+	struct rmap_chain *chain = page->rmap.chain;
+
+	/*
+	 * At present this is only called when mapcount goes to 0, which
+	 * leaves open the possibility that a page might accumulate a
+	 * large chain of stale addresses, slowing page_referenced and
+	 * wasting memory on the chain; but normally try_to_unmap_one
+	 * will bring the count down to 0 and free them all here.
+	 */
+
+	page->rmap.count = chain->slot[0];
+	ClearPageChained(page);
+	do {
+		struct rmap_chain *next = chain->next;
+		kfree(chain);
+		chain = next;
+	} while (chain);
+}
+
+/**
  ** Functions for creating and destroying struct anonmm.
  **/
 
@@ -181,8 +346,9 @@
 
 static int
 page_referenced_one(struct page *page, struct mm_struct *mm,
-	unsigned long address, unsigned long *mapcount)
+		    struct addresser *addresser)
 {
+	unsigned long address = addresser->address;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -211,7 +377,7 @@
 	if (ptep_test_and_clear_young(pte))
 		referenced++;
 
-	(*mapcount)--;
+	addresser->count--;
 
 out_unmap:
 	pte_unmap(pte);
@@ -224,7 +390,7 @@
 }
 
 static inline int
-page_referenced_anon(struct page *page, unsigned long *mapcount)
+page_referenced_anon(struct page *page, struct addresser *addresser)
 {
 	struct anonmm *anonmm = (struct anonmm *) page->mapping;
 	struct anonmm *anonhd = anonmm->head;
@@ -233,19 +399,25 @@
 
 	spin_lock(&anonhd->lock);
 	if (anonmm->mm && anonmm->mm->rss) {
-		referenced += page_referenced_one(
-			page, anonmm->mm, page->index, mapcount);
-		if (!*mapcount)
-			goto out;
+		addresser->index = 0;
+		while (next_rmap_address(page, NULL, addresser)) {
+			referenced += page_referenced_one(
+				page, anonmm->mm, addresser);
+			if (!addresser->count)
+				goto out;
+		}
 	}
 	seek_head = &anonmm->list;
 	list_for_each_entry(anonmm, seek_head, list) {
 		if (!anonmm->mm || !anonmm->mm->rss)
 			continue;
-		referenced += page_referenced_one(
-			page, anonmm->mm, page->index, mapcount);
-		if (!*mapcount)
-			goto out;
+		addresser->index = 0;
+		while (next_rmap_address(page, NULL, addresser)) {
+			referenced += page_referenced_one(
+				page, anonmm->mm, addresser);
+			if (!addresser->count)
+				goto out;
+		}
 	}
 out:
 	spin_unlock(&anonhd->lock);
@@ -253,11 +425,10 @@
 }
 
 static inline int
-page_referenced_obj(struct page *page, unsigned long *mapcount)
+page_referenced_obj(struct page *page, struct addresser *addresser)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
-	unsigned long address;
 	int referenced = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
@@ -266,11 +437,11 @@
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
 		if (!vma->vm_mm->rss)
 			continue;
-		address = vma_address(page, vma);
-		if (address != NOADDR) {
+		addresser->index = 0;
+		while (next_rmap_address(page, vma, addresser)) {
 			referenced += page_referenced_one(
-				page, vma->vm_mm, address, mapcount);
-			if (!*mapcount)
+				page, vma->vm_mm, addresser);
+			if (!addresser->count)
 				goto out;
 		}
 	}
@@ -278,11 +449,11 @@
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 		if (!vma->vm_mm->rss)
 			continue;
-		address = vma_address(page, vma);
-		if (address != NOADDR) {
+		addresser->index = 0;
+		while (next_rmap_address(page, vma, addresser)) {
 			referenced += page_referenced_one(
-				page, vma->vm_mm, address, mapcount);
-			if (!*mapcount)
+				page, vma->vm_mm, addresser);
+			if (!addresser->count)
 				goto out;
 		}
 	}
@@ -302,15 +473,15 @@
 int
 page_referenced(struct page *page)
 {
-	unsigned long mapcount;
+	struct addresser addresser;
 	int referenced;
 
 	referenced = !!TestClearPageReferenced(page);
-	mapcount = page_mapcount(page);
-	if (mapcount && page->mapping) {
+	addresser.count = page_mapcount(page);
+	if (addresser.count && page->mapping) {
 		referenced += PageAnon(page)?
-			page_referenced_anon(page, &mapcount):
-			page_referenced_obj(page, &mapcount);
+			page_referenced_anon(page, &addresser):
+			page_referenced_obj(page, &addresser);
 	}
 	return referenced;
 }
@@ -343,8 +514,12 @@
 	if (page->mapping) {
 		if (anon) {
 			BUG_ON(!PageAnon(page));
+			if (unlikely(address != page->index))
+				add_rmap_address(page, address);
 		} else {
 			BUG_ON(PageAnon(page));
+			if (unlikely(address != vma_address(page, vma)))
+				add_rmap_address(page, address);
 		}
 	} else {
 		if (anon) {
@@ -410,6 +585,50 @@
 }
 
 /**
+ * page_move_rmap - move address in reverse mapping entry.
+ * @page:	the page originally mapped into some vma
+ * @vma:	that old vma into which this page is mapped
+ * @old_address: old virtual address at which page was mapped
+ * @new_address: new virtual address at which page will be mapped
+ *
+ * For sys_remap's copy_one_pte: move address in reverse mapping.
+ * Cannot use page_remove_rmap followed by page_add_rmap since
+ * the new vma into which to add has not yet been set up.
+ */
+void
+page_move_rmap(struct page *page, struct vm_area_struct *vma,
+	unsigned long old_address, unsigned long new_address)
+{
+	if (!page_mapped(page) || !page->mapping)
+		return;
+
+	rmap_lock(page);
+
+	if (PageAnon(page)) {
+		/*
+		 * We don't check page_mapcount(page) == 1 here
+		 * because the mapcount could be 1 yet the page
+		 * still have a chain, and our new_address be in
+		 * that chain: if the same address goes in twice,
+		 * try_to_unmap would give up too early.
+		 */
+		if (page->rmap.count == 1)
+			page->index = new_address;
+		else if (new_address != page->index)
+			add_rmap_address(page, new_address);
+	} else {
+		/*
+		 * We must chain the new address if the old
+		 * address was nonlinear in its original vma.
+		 */
+		if (old_address != vma_address(page, vma))
+			add_rmap_address(page, new_address);
+	}
+
+	rmap_unlock(page);
+}
+
+/**
  * page_remove_rmap - take down reverse mapping to a page
  * @page: page to remove mapping from
  *
@@ -420,13 +639,22 @@
 void
 page_remove_rmap(struct page *page)
 {
+#if 0	/* All its callers have already checked these conditions */
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
+#endif
 
 	rmap_lock(page);
 
-	BUG_ON(!page_mapcount(page));
-	page_mapcount(page)--;
+	if (unlikely(PageChained(page))) {
+		BUG_ON(!page->rmap.chain->slot[0]);
+		page->rmap.chain->slot[0]--;
+		if (!page->rmap.chain->slot[0])
+			clear_page_chained(page);
+	} else {
+		BUG_ON(!page->rmap.count);
+		page->rmap.count--;
+	}
 
 	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
@@ -444,9 +672,9 @@
 
 static int
 try_to_unmap_one(struct page *page, struct mm_struct *mm,
-	unsigned long address, unsigned long *mapcount,
-	struct vm_area_struct *vma)
+	struct addresser *addresser, struct vm_area_struct *vma)
 {
+	unsigned long address = addresser->address;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -475,7 +703,7 @@
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	(*mapcount)--;
+	addresser->count--;
 
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
@@ -505,7 +733,6 @@
 		BUG_ON(pte_file(*pte));
 	} else {
 		/*
-		 * This only comes into play with the next patch...
 		 * If a nonlinear mapping then store
 		 * the file page offset in the pte.
 		 */
@@ -520,7 +747,12 @@
 		set_page_dirty(page);
 
 	BUG_ON(!page_mapcount(page));
-	page_mapcount(page)--;
+	if (unlikely(PageChained(page))) {
+		page->rmap.chain->slot[0]--;
+		if (!page->rmap.chain->slot[0])
+			clear_page_chained(page);
+	} else
+		page->rmap.count--;
 	page_cache_release(page);
 	mm->rss--;
 
@@ -535,7 +767,7 @@
 }
 
 static inline int
-try_to_unmap_anon(struct page *page, unsigned long *mapcount)
+try_to_unmap_anon(struct page *page, struct addresser *addresser)
 {
 	struct anonmm *anonmm = (struct anonmm *) page->mapping;
 	struct anonmm *anonhd = anonmm->head;
@@ -544,19 +776,25 @@
 
 	spin_lock(&anonhd->lock);
 	if (anonmm->mm && anonmm->mm->rss) {
-		ret = try_to_unmap_one(
-			page, anonmm->mm, page->index, mapcount, NULL);
-		if (ret == SWAP_FAIL || !*mapcount)
-			goto out;
+		addresser->index = 0;
+		while (next_rmap_address(page, NULL, addresser)) {
+			ret = try_to_unmap_one(
+				page, anonmm->mm, addresser, NULL);
+			if (ret == SWAP_FAIL || !addresser->count)
+				goto out;
+		}
 	}
 	seek_head = &anonmm->list;
 	list_for_each_entry(anonmm, seek_head, list) {
 		if (!anonmm->mm || !anonmm->mm->rss)
 			continue;
-		ret = try_to_unmap_one(
-			page, anonmm->mm, page->index, mapcount, NULL);
-		if (ret == SWAP_FAIL || !*mapcount)
-			goto out;
+		addresser->index = 0;
+		while (next_rmap_address(page, NULL, addresser)) {
+			ret = try_to_unmap_one(
+				page, anonmm->mm, addresser, NULL);
+			if (ret == SWAP_FAIL || !addresser->count)
+				goto out;
+		}
 	}
 out:
 	spin_unlock(&anonhd->lock);
@@ -564,11 +802,10 @@
 }
 
 static inline int
-try_to_unmap_obj(struct page *page, unsigned long *mapcount)
+try_to_unmap_obj(struct page *page, struct addresser *addresser)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
-	unsigned long address;
 	int ret = SWAP_AGAIN;
 
 	if (down_trylock(&mapping->i_shared_sem))
@@ -577,11 +814,11 @@
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
 		if (!vma->vm_mm->rss)
 			continue;
-		address = vma_address(page, vma);
-		if (address != NOADDR) {
+		addresser->index = 0;
+		while (next_rmap_address(page, vma, addresser)) {
 			ret = try_to_unmap_one(
-				page, vma->vm_mm, address, mapcount, vma);
-			if (ret == SWAP_FAIL || !*mapcount)
+				page, vma->vm_mm, addresser, vma);
+			if (ret == SWAP_FAIL || !addresser->count)
 				goto out;
 		}
 	}
@@ -589,11 +826,11 @@
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 		if (!vma->vm_mm->rss)
 			continue;
-		address = vma_address(page, vma);
-		if (address != NOADDR) {
+		addresser->index = 0;
+		while (next_rmap_address(page, vma, addresser)) {
 			ret = try_to_unmap_one(
-				page, vma->vm_mm, address, mapcount, vma);
-			if (ret == SWAP_FAIL || !*mapcount)
+				page, vma->vm_mm, addresser, vma);
+			if (ret == SWAP_FAIL || !addresser->count)
 				goto out;
 		}
 	}
@@ -618,17 +855,17 @@
 int
 try_to_unmap(struct page *page)
 {
-	unsigned long mapcount;
+	struct addresser addresser;
 	int ret;
 
 	BUG_ON(PageReserved(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!page_mapped(page));
 
-	mapcount = page_mapcount(page);
+	addresser.count = page_mapcount(page);
 	ret = PageAnon(page)?
-		try_to_unmap_anon(page, &mapcount):
-		try_to_unmap_obj(page, &mapcount);
+		try_to_unmap_anon(page, &addresser):
+		try_to_unmap_obj(page, &addresser);
 
 	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
--- anobjrmap4/mm/swapfile.c	Thu Mar 20 17:10:23 2003
+++ anobjrmap5/mm/swapfile.c	Thu Mar 20 17:10:34 2003
@@ -383,28 +383,29 @@
  * share this swap entry, so be cautious and let do_wp_page work out
  * what to do if a write is requested later.
  */
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void
+/* vma->vm_mm->page_table_lock is held */
+static int
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page)
 {
 	pte_t pte = *dir;
 
 	if (pte_file(pte))
-		return;
+		return 0;
 	if (likely(pte_to_swp_entry(pte).val != entry.val))
-		return;
+		return 0;
 	if (unlikely(pte_none(pte) || pte_present(pte)))
-		return;
+		return 0;
 	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_rmap(page, vma, address, 1);
 	swap_free(entry);
+	return 1;
 }
 
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
+/* vma->vm_mm->page_table_lock is held */
+static int unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page* page)
 {
@@ -412,11 +413,11 @@
 	unsigned long end;
 
 	if (pmd_none(*dir))
-		return;
+		return 0;
 	if (pmd_bad(*dir)) {
 		pmd_ERROR(*dir);
 		pmd_clear(dir);
-		return;
+		return 0;
 	}
 	pte = pte_offset_map(dir, address);
 	offset += address & PMD_MASK;
@@ -425,15 +426,19 @@
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
-		unuse_pte(vma, offset + address, pte, entry, page);
+		if (unuse_pte(vma, offset + address, pte, entry, page)) {
+			pte_unmap(pte);
+			return 1;
+		}
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
 	pte_unmap(pte - 1);
+	return 0;
 }
 
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
+/* vma->vm_mm->page_table_lock is held */
+static int unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
 	swp_entry_t entry, struct page* page)
 {
@@ -441,11 +446,11 @@
 	unsigned long offset, end;
 
 	if (pgd_none(*dir))
-		return;
+		return 0;
 	if (pgd_bad(*dir)) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
-		return;
+		return 0;
 	}
 	pmd = pmd_offset(dir, address);
 	offset = address & PGDIR_MASK;
@@ -456,15 +461,17 @@
 	if (address >= end)
 		BUG();
 	do {
-		unuse_pmd(vma, pmd, address, end - address, offset, entry,
-			  page);
+		if (unuse_pmd(vma, pmd, address, end - address,
+				offset, entry, page))
+			return 1;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
+	return 0;
 }
 
-/* mmlist_lock and vma->vm_mm->page_table_lock are held */
-static void unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
+/* vma->vm_mm->page_table_lock is held */
+static int unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
 			swp_entry_t entry, struct page* page)
 {
 	unsigned long start = vma->vm_start, end = vma->vm_end;
@@ -472,13 +479,15 @@
 	if (start >= end)
 		BUG();
 	do {
-		unuse_pgd(vma, pgdir, start, end - start, entry, page);
+		if (unuse_pgd(vma, pgdir, start, end - start, entry, page))
+			return 1;
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		pgdir++;
 	} while (start && (start < end));
+	return 0;
 }
 
-static void unuse_process(struct mm_struct * mm,
+static int unuse_process(struct mm_struct * mm,
 			swp_entry_t entry, struct page* page)
 {
 	struct vm_area_struct* vma;
@@ -486,13 +495,17 @@
 	/*
 	 * Go through process' page directory.
 	 */
+	if (!rmap_get_cpu())
+		return -ENOMEM;
 	spin_lock(&mm->page_table_lock);
+	put_cpu();
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-		unuse_vma(vma, pgd, entry, page);
+		if (unuse_vma(vma, pgd, entry, page))
+			break;
 	}
 	spin_unlock(&mm->page_table_lock);
-	return;
+	return 0;
 }
 
 /*
@@ -635,34 +648,46 @@
 			flush_page_to_ram(page);
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
-			else
-				unuse_process(start_mm, entry, page);
+			else {
+				retval = unuse_process(start_mm, entry, page);
+				if (retval)
+					break;
+			}
 		}
 		if (*swap_map > 1) {
 			int set_start_mm = (*swap_map >= swcount);
 			struct list_head *p = &start_mm->mmlist;
 			struct mm_struct *new_start_mm = start_mm;
+			struct mm_struct *prev_mm = start_mm;
 			struct mm_struct *mm;
 
+			atomic_inc(&new_start_mm->mm_users);
+			atomic_inc(&prev_mm->mm_users);
 			spin_lock(&mmlist_lock);
-			while (*swap_map > 1 &&
+			while (*swap_map > 1 && !retval &&
 					(p = p->next) != &start_mm->mmlist) {
 				mm = list_entry(p, struct mm_struct, mmlist);
+				atomic_inc(&mm->mm_users);
+				spin_unlock(&mmlist_lock);
+				mmput(prev_mm);
+				prev_mm = mm;
+
 				swcount = *swap_map;
 				if (mm == &init_mm) {
 					set_start_mm = 1;
-					spin_unlock(&mmlist_lock);
 					shmem = shmem_unuse(entry, page);
-					spin_lock(&mmlist_lock);
 				} else
-					unuse_process(mm, entry, page);
+					retval = unuse_process(mm, entry, page);
 				if (set_start_mm && *swap_map < swcount) {
+					mmput(new_start_mm);
+					atomic_inc(&mm->mm_users);
 					new_start_mm = mm;
 					set_start_mm = 0;
 				}
+				spin_lock(&mmlist_lock);
 			}
-			atomic_inc(&new_start_mm->mm_users);
 			spin_unlock(&mmlist_lock);
+			mmput(prev_mm);
 			mmput(start_mm);
 			start_mm = new_start_mm;
 		}

