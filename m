Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUDHWw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDHWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:52:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58485 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262960AbUDHWvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:51:45 -0400
Date: Thu, 8 Apr 2004 23:51:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 1 linux/rmap.h
Message-ID: <Pine.LNX.4.44.0404082349580.1586-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a batch of three rmap patches: this initial batch of three
paving the way for a move to some form of object-based rmap (probably
Andrea's, but drawing from mine too), and making almost no functional
change by itself.  A few days will intervene before the next batch,
to give the struct page changes in the second patch some exposure
before proceeding.  Based on 2.6.5-mc2.

rmap 1 create include/linux/rmap.h

Start small: linux/rmap-locking.h has already gathered some
declarations unrelated to locking, and the rest of the rmap
declarations were over in linux/swap.h: gather them all together
in linux/rmap.h, and rename the pte_chain_lock to rmap_lock.

 fs/exec.c                    |    2 -
 include/linux/page-flags.h   |    2 -
 include/linux/rmap-locking.h |   23 -------------------
 include/linux/rmap.h         |   52 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/swap.h         |   16 -------------
 mm/fremap.c                  |    2 -
 mm/memory.c                  |    2 -
 mm/mremap.c                  |    2 -
 mm/rmap.c                    |   20 +++++++---------
 mm/swapfile.c                |    2 -
 mm/vmscan.c                  |   24 +++++++++----------
 11 files changed, 79 insertions(+), 68 deletions(-)

--- 2.6.5-mc2/fs/exec.c	2004-04-07 08:19:28.000000000 +0100
+++ rmap1/fs/exec.c	2004-04-08 20:56:29.708211552 +0100
@@ -45,7 +45,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
--- 2.6.5-mc2/include/linux/page-flags.h	2004-04-07 08:19:29.000000000 +0100
+++ rmap1/include/linux/page-flags.h	2004-04-08 20:56:29.709211400 +0100
@@ -69,7 +69,7 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
+#define PG_maplock		15	/* Lock bit for rmap to ptes */
 
 #define PG_direct		16	/* ->pte_chain points directly at pte */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
--- 2.6.5-mc2/include/linux/rmap-locking.h	2004-04-04 03:38:41.000000000 +0100
+++ rmap1/include/linux/rmap-locking.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,23 +0,0 @@
-/*
- * include/linux/rmap-locking.h
- *
- * Locking primitives for exclusive access to a page's reverse-mapping
- * pte chain.
- */
-
-#include <linux/slab.h>
-
-struct pte_chain;
-extern kmem_cache_t *pte_chain_cache;
-
-#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, (unsigned long *)&page->flags)
-#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, (unsigned long *)&page->flags)
-
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
-
-static inline void pte_chain_free(struct pte_chain *pte_chain)
-{
-	if (pte_chain)
-		__pte_chain_free(pte_chain);
-}
--- 2.6.5-mc2/include/linux/rmap.h	1970-01-01 01:00:00.000000000 +0100
+++ rmap1/include/linux/rmap.h	2004-04-08 20:56:29.718210032 +0100
@@ -0,0 +1,52 @@
+#ifndef _LINUX_RMAP_H
+#define _LINUX_RMAP_H
+/*
+ * Declarations for Reverse Mapping functions in mm/rmap.c
+ * Its structures are declared within that file.
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+#define rmap_lock(page) \
+	bit_spin_lock(PG_maplock, (unsigned long *)&(page)->flags)
+#define rmap_unlock(page) \
+	bit_spin_unlock(PG_maplock, (unsigned long *)&(page)->flags)
+
+#ifdef CONFIG_MMU
+
+struct pte_chain;
+struct pte_chain *pte_chain_alloc(int gfp_flags);
+void __pte_chain_free(struct pte_chain *pte_chain);
+
+static inline void pte_chain_free(struct pte_chain *pte_chain)
+{
+	if (pte_chain)
+		__pte_chain_free(pte_chain);
+}
+
+struct pte_chain * fastcall
+	page_add_rmap(struct page *, pte_t *, struct pte_chain *);
+void fastcall page_remove_rmap(struct page *, pte_t *);
+
+/*
+ * Called from mm/vmscan.c to handle paging out
+ */
+int fastcall page_referenced(struct page *);
+int fastcall try_to_unmap(struct page *);
+
+#else	/* !CONFIG_MMU */
+
+#define page_referenced(page)	TestClearPageReferenced(page)
+#define try_to_unmap(page)	SWAP_FAIL
+
+#endif	/* CONFIG_MMU */
+
+/*
+ * Return values of try_to_unmap
+ */
+#define SWAP_SUCCESS	0
+#define SWAP_AGAIN	1
+#define SWAP_FAIL	2
+
+#endif	/* _LINUX_RMAP_H */
--- 2.6.5-mc2/include/linux/swap.h	2004-02-04 02:45:16.000000000 +0000
+++ rmap1/include/linux/swap.h	2004-04-08 20:56:29.720209728 +0100
@@ -76,7 +76,6 @@ struct reclaim_state {
 #ifdef __KERNEL__
 
 struct address_space;
-struct pte_chain;
 struct sysinfo;
 struct writeback_control;
 struct zone;
@@ -177,26 +176,11 @@ extern int try_to_free_pages(struct zone
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
-/* linux/mm/rmap.c */
 #ifdef CONFIG_MMU
-int FASTCALL(page_referenced(struct page *));
-struct pte_chain *FASTCALL(page_add_rmap(struct page *, pte_t *,
-					struct pte_chain *));
-void FASTCALL(page_remove_rmap(struct page *, pte_t *));
-int FASTCALL(try_to_unmap(struct page *));
-
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
-#else
-#define page_referenced(page)	TestClearPageReferenced(page)
-#define try_to_unmap(page)	SWAP_FAIL
 #endif /* CONFIG_MMU */
 
-/* return values of try_to_unmap */
-#define	SWAP_SUCCESS	0
-#define	SWAP_AGAIN	1
-#define	SWAP_FAIL	2
-
 #ifdef CONFIG_SWAP
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
--- 2.6.5-mc2/mm/fremap.c	2004-03-11 01:56:06.000000000 +0000
+++ rmap1/mm/fremap.c	2004-04-08 20:56:29.720209728 +0100
@@ -12,7 +12,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/module.h>
 
 #include <asm/mmu_context.h>
--- 2.6.5-mc2/mm/memory.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap1/mm/memory.c	2004-04-08 20:56:29.722209424 +0100
@@ -43,7 +43,7 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
--- 2.6.5-mc2/mm/mremap.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap1/mm/mremap.c	2004-04-08 20:56:29.723209272 +0100
@@ -15,7 +15,7 @@
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
--- 2.6.5-mc2/mm/rmap.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap1/mm/rmap.c	2004-04-08 20:56:29.726208816 +0100
@@ -13,7 +13,7 @@
 
 /*
  * Locking:
- * - the page->pte.chain is protected by the PG_chainlock bit,
+ * - the page->pte.chain is protected by the PG_maplock bit,
  *   which nests within the the mm->page_table_lock,
  *   which nests within the page lock.
  * - because swapout locking is opposite to the locking order
@@ -26,7 +26,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 
@@ -108,7 +108,7 @@ pte_chain_encode(struct pte_chain *pte_c
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
- * Caller needs to hold the pte_chain_lock.
+ * Caller needs to hold the rmap lock.
  *
  * If the page has a single-entry pte_chain, collapse that back to a PageDirect
  * representation.  This way, it's only done under memory pressure.
@@ -175,7 +175,7 @@ page_add_rmap(struct page *page, pte_t *
 	if (PageReserved(page))
 		return pte_chain;
 
-	pte_chain_lock(page);
+	rmap_lock(page);
 
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
@@ -208,7 +208,7 @@ page_add_rmap(struct page *page, pte_t *
 	cur_pte_chain->ptes[pte_chain_idx(cur_pte_chain) - 1] = pte_paddr;
 	cur_pte_chain->next_and_idx--;
 out:
-	pte_chain_unlock(page);
+	rmap_unlock(page);
 	return pte_chain;
 }
 
@@ -230,7 +230,7 @@ void fastcall page_remove_rmap(struct pa
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
 
-	pte_chain_lock(page);
+	rmap_lock(page);
 
 	if (!page_mapped(page))
 		goto out_unlock;	/* remap_page_range() from a driver? */
@@ -276,8 +276,7 @@ out:
 	if (!page_mapped(page))
 		dec_page_state(nr_mapped);
 out_unlock:
-	pte_chain_unlock(page);
-	return;
+	rmap_unlock(page);
 }
 
 /**
@@ -290,10 +289,9 @@ out_unlock:
  * to the locking order used by the page fault path, we use trylocks.
  * Locking:
  *	    page lock			shrink_list(), trylock
- *		pte_chain_lock		shrink_list()
+ *		rmap lock		shrink_list()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
-static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
 static int fastcall try_to_unmap_one(struct page * page, pte_addr_t paddr)
 {
 	pte_t *ptep = rmap_ptep_map(paddr);
@@ -376,7 +374,7 @@ out_unlock:
  *
  * Tries to remove all the page table entries which are mapping this
  * page, used in the pageout path.  Caller must hold the page lock
- * and its pte chain lock.  Return values are:
+ * and its rmap lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a trylock, try again later
--- 2.6.5-mc2/mm/swapfile.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap1/mm/swapfile.c	2004-04-08 20:56:29.728208512 +0100
@@ -21,7 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/security.h>
 
 #include <asm/pgtable.h>
--- 2.6.5-mc2/mm/vmscan.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap1/mm/vmscan.c	2004-04-08 20:56:29.730208208 +0100
@@ -28,7 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/topology.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
@@ -173,7 +173,7 @@ static int shrink_slab(unsigned long sca
 	return 0;
 }
 
-/* Must be called with page's pte_chain_lock held. */
+/* Must be called with page's rmap lock held. */
 static inline int page_mapping_inuse(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
@@ -278,11 +278,11 @@ shrink_list(struct list_head *page_list,
 		if (PageWriteback(page))
 			goto keep_locked;
 
-		pte_chain_lock(page);
+		rmap_lock(page);
 		referenced = page_referenced(page);
 		if (referenced && page_mapping_inuse(page)) {
 			/* In active use or really unfreeable.  Activate it. */
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 			goto activate_locked;
 		}
 
@@ -296,10 +296,10 @@ shrink_list(struct list_head *page_list,
 		 * XXX: implement swap clustering ?
 		 */
 		if (page_mapped(page) && !mapping && !PagePrivate(page)) {
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 			if (!add_to_swap(page))
 				goto activate_locked;
-			pte_chain_lock(page);
+			rmap_lock(page);
 			mapping = page->mapping;
 		}
 #endif /* CONFIG_SWAP */
@@ -314,16 +314,16 @@ shrink_list(struct list_head *page_list,
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
 			case SWAP_FAIL:
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				goto activate_locked;
 			case SWAP_AGAIN:
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				goto keep_locked;
 			case SWAP_SUCCESS:
 				; /* try to free the page below */
 			}
 		}
-		pte_chain_unlock(page);
+		rmap_unlock(page);
 
 		/*
 		 * If the page is dirty, only perform writeback if that write
@@ -657,13 +657,13 @@ refill_inactive_zone(struct zone *zone, 
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			pte_chain_lock(page);
+			rmap_lock(page);
 			if (page_referenced(page)) {
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 		}
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we

