Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263171AbTCTXA1>; Thu, 20 Mar 2003 18:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbTCTXA1>; Thu, 20 Mar 2003 18:00:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2425 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263171AbTCTW76>; Thu, 20 Mar 2003 17:59:58 -0500
Date: Thu, 20 Mar 2003 23:12:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] anobjrmap 1/6 rmap.h
Message-ID: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a sequence of six patches, extending Dave McCracken's
objrmap to handle anonymous memory too, eliminating pte_chains.

Based upon 2.5.65-mm2, the aggregate has
 81 files changed, 1140 insertions(+), 1634 deletions(-)

anobjrmap 1/6 create include/linux/rmap.h
anobjrmap 2/6 free page->mapping for use by anon
anobjrmap 3/6 remove pte-pointer-based rmap
anobjrmap 4/6 add anonmm to track anonymous pages
anonjrmap 5/6 virtual address chains for odd cases
anonjrmap 6/6 updates to arches other than i386

I've not done any timings, hope others can do that better than
I would.  My guess is that Dave has already covered the worst
cases, but this should cut the rmap overhead when forking.

anobjrmap 1/6 create include/linux/rmap.h

Start small: linux/rmap-locking.h has already gathered some
declarations unrelated to locking, then the rest of the rmap
declarations were over in linux/swap.h: gather them all
together in linux/rmap.h.

Omit SWAP_ERROR (unused), page_over_rsslimit (non-existent).
Fix a couple of missed unlocks in rmap.c page_convert_anon,
before the whole function is removed in the next patch.

 fs/exec.c                    |    2 -
 include/linux/rmap-locking.h |   49 ----------------------------
 include/linux/rmap.h         |   73 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/swap.h         |   19 -----------
 mm/fremap.c                  |    2 -
 mm/memory.c                  |    2 -
 mm/mremap.c                  |    2 -
 mm/rmap.c                    |    9 +----
 mm/swapfile.c                |    2 -
 mm/vmscan.c                  |    3 -
 10 files changed, 82 insertions(+), 81 deletions(-)

--- 2.5.65-mm2/fs/exec.c	Wed Mar 19 11:05:11 2003
+++ anobjrmap1/fs/exec.c	Thu Mar 20 17:09:50 2003
@@ -45,7 +45,7 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/security.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
--- 2.5.65-mm2/include/linux/rmap-locking.h	Wed Mar 19 11:05:16 2003
+++ anobjrmap1/include/linux/rmap-locking.h	Thu Jan  1 01:00:00 1970
@@ -1,49 +0,0 @@
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
-static inline void pte_chain_lock(struct page *page)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-#ifdef CONFIG_SMP
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
-#endif
-}
-
-static inline void pte_chain_unlock(struct page *page)
-{
-#ifdef CONFIG_SMP
-	smp_mb__before_clear_bit();
-	clear_bit(PG_chainlock, &page->flags);
-#endif
-	preempt_enable();
-}
-
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
-
-static inline void pte_chain_free(struct pte_chain *pte_chain)
-{
-	if (pte_chain)
-		__pte_chain_free(pte_chain);
-}
-
-void page_convert_anon(struct page *page);
--- 2.5.65-mm2/include/linux/rmap.h	Thu Jan  1 01:00:00 1970
+++ anobjrmap1/include/linux/rmap.h	Thu Mar 20 17:09:50 2003
@@ -0,0 +1,73 @@
+#ifndef _LINUX_RMAP_H
+#define _LINUX_RMAP_H
+/*
+ * Declarations for Reverse Mapping functions in mm/rmap.c
+ * Its structures are declared within that file.
+ */
+#include <linux/config.h>
+#include <linux/linkage.h>
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
+struct pte_chain *FASTCALL(
+	page_add_rmap(struct page *, pte_t *, struct pte_chain *));
+void FASTCALL(page_remove_rmap(struct page *, pte_t *));
+void page_convert_anon(struct page *page);
+
+/*
+ * Called from mm/vmscan.c to handle paging out
+ */
+int FASTCALL(page_referenced(struct page *));
+int FASTCALL(try_to_unmap(struct page *));
+
+/*
+ * Return values of try_to_unmap
+ */
+#define SWAP_SUCCESS	0
+#define SWAP_AGAIN	1
+#define SWAP_FAIL	2
+
+#else	/* !CONFIG_MMU */
+
+#define page_referenced(page)	TestClearPageReferenced(page)
+
+#endif /* CONFIG_MMU */
+
+static inline void pte_chain_lock(struct page *page)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	preempt_disable();
+#ifdef CONFIG_SMP
+	while (test_and_set_bit(PG_chainlock, &page->flags)) {
+		while (test_bit(PG_chainlock, &page->flags))
+			cpu_relax();
+	}
+#endif
+}
+
+static inline void pte_chain_unlock(struct page *page)
+{
+#ifdef CONFIG_SMP
+	smp_mb__before_clear_bit();
+	clear_bit(PG_chainlock, &page->flags);
+#endif
+	preempt_enable();
+}
+
+#endif /* _LINUX_RMAP_H */
--- 2.5.65-mm2/include/linux/swap.h	Wed Mar  5 07:26:34 2003
+++ anobjrmap1/include/linux/swap.h	Thu Mar 20 17:09:50 2003
@@ -69,7 +69,6 @@
 #ifdef __KERNEL__
 
 struct address_space;
-struct pte_chain;
 struct sysinfo;
 struct writeback_control;
 struct zone;
@@ -167,27 +166,9 @@
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
-/* linux/mm/rmap.c */
 #ifdef CONFIG_MMU
-int FASTCALL(page_referenced(struct page *));
-struct pte_chain *FASTCALL(page_add_rmap(struct page *, pte_t *,
-					struct pte_chain *));
-void FASTCALL(page_remove_rmap(struct page *, pte_t *));
-int FASTCALL(try_to_unmap(struct page *));
-int FASTCALL(page_over_rsslimit(struct page *));
-
-/* return values of try_to_unmap */
-#define	SWAP_SUCCESS	0
-#define	SWAP_AGAIN	1
-#define	SWAP_FAIL	2
-#define	SWAP_ERROR	3
-
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
-
-#else
-#define page_referenced(page) \
-	TestClearPageReferenced(page)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_SWAP
--- 2.5.65-mm2/mm/fremap.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap1/mm/fremap.c	Thu Mar 20 17:09:50 2003
@@ -11,7 +11,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
--- 2.5.65-mm2/mm/memory.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap1/mm/memory.c	Thu Mar 20 17:09:50 2003
@@ -44,7 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/vcache.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
--- 2.5.65-mm2/mm/mremap.c	Tue Mar 18 07:38:45 2003
+++ anobjrmap1/mm/mremap.c	Thu Mar 20 17:09:50 2003
@@ -15,7 +15,7 @@
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
--- 2.5.65-mm2/mm/rmap.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap1/mm/rmap.c	Thu Mar 20 17:09:50 2003
@@ -25,7 +25,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 
@@ -677,7 +677,6 @@
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a trylock, try again later
  * SWAP_FAIL	- the page is unswappable
- * SWAP_ERROR	- an error occurred
  */
 int try_to_unmap(struct page * page)
 {
@@ -754,9 +753,6 @@
 			case SWAP_FAIL:
 				ret = SWAP_FAIL;
 				goto out;
-			case SWAP_ERROR:
-				ret = SWAP_ERROR;
-				goto out;
 			}
 		}
 	}
@@ -812,6 +808,7 @@
 	 */
 	if (mapcount < page->pte.mapcount) {
 		pte_chain_unlock(page);
+		up(&mapping->i_shared_sem);
 		goto retry;
 	} else if ((mapcount > page->pte.mapcount) && (mapcount > 1)) {
 		mapcount = page->pte.mapcount;
@@ -827,7 +824,7 @@
 	SetPageAnon(page);
 
 	if (mapcount == 0)
-		goto out;
+		goto out_unlock;
 	else if (mapcount == 1) {
 		SetPageDirect(page);
 		page->pte.direct = 0;
--- 2.5.65-mm2/mm/swapfile.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap1/mm/swapfile.c	Thu Mar 20 17:09:50 2003
@@ -20,7 +20,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/pgtable.h>
 #include <linux/swapops.h>
--- 2.5.65-mm2/mm/vmscan.c	Tue Feb 18 02:14:32 2003
+++ anobjrmap1/mm/vmscan.c	Thu Mar 20 17:09:50 2003
@@ -26,7 +26,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -284,7 +284,6 @@
 		 */
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
-			case SWAP_ERROR:
 			case SWAP_FAIL:
 				pte_chain_unlock(page);
 				goto activate_locked;

