Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbUCRXdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUCRXdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:33:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14184 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263274AbUCRXWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:22:45 -0500
Date: Thu, 18 Mar 2004 23:22:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH] anobjrmap 2/6 linux/rmap.h
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403182321360.16911-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 2/6 create include/linux/rmap.h

Start small: linux/rmap-locking.h has already gathered some
declarations unrelated to locking, then the rest of the rmap
declarations were over in linux/swap.h: gather them all
together in linux/rmap.h.

 fs/exec.c                    |    2 -
 include/linux/rmap-locking.h |   23 -------------------
 include/linux/rmap.h         |   51 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/swap.h         |   18 ---------------
 mm/fremap.c                  |    2 -
 mm/memory.c                  |    2 -
 mm/mremap.c                  |    2 -
 mm/rmap.c                    |    3 --
 mm/swapfile.c                |    2 -
 mm/vmscan.c                  |    2 -
 10 files changed, 58 insertions(+), 49 deletions(-)

--- anobjrmap1/fs/exec.c	2004-03-18 21:26:40.786812568 +0000
+++ anobjrmap2/fs/exec.c	2004-03-18 21:26:52.270066848 +0000
@@ -45,7 +45,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
--- anobjrmap1/include/linux/rmap-locking.h	2003-06-22 19:33:42.000000000 +0100
+++ anobjrmap2/include/linux/rmap-locking.h	1970-01-01 01:00:00.000000000 +0100
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
-#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &page->flags)
-#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &page->flags)
-
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
-
-static inline void pte_chain_free(struct pte_chain *pte_chain)
-{
-	if (pte_chain)
-		__pte_chain_free(pte_chain);
-}
--- anobjrmap1/include/linux/rmap.h	1970-01-01 01:00:00.000000000 +0100
+++ anobjrmap2/include/linux/rmap.h	2004-03-18 21:26:52.280065328 +0000
@@ -0,0 +1,51 @@
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
+#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &(page)->flags)
+#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &(page)->flags)
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
+int page_convert_anon(struct page *page);
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
--- anobjrmap1/include/linux/swap.h	2004-03-18 21:26:40.790811960 +0000
+++ anobjrmap2/include/linux/swap.h	2004-03-18 21:26:52.281065176 +0000
@@ -76,7 +76,6 @@ struct reclaim_state {
 #ifdef __KERNEL__
 
 struct address_space;
-struct pte_chain;
 struct sysinfo;
 struct writeback_control;
 struct zone;
@@ -177,28 +176,11 @@ extern int try_to_free_pages(struct zone
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
-int page_convert_anon(struct page *);
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
--- anobjrmap1/mm/fremap.c	2004-03-18 21:26:40.791811808 +0000
+++ anobjrmap2/mm/fremap.c	2004-03-18 21:26:52.282065024 +0000
@@ -12,7 +12,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/module.h>
 
 #include <asm/mmu_context.h>
--- anobjrmap1/mm/memory.c	2004-03-18 21:26:40.794811352 +0000
+++ anobjrmap2/mm/memory.c	2004-03-18 21:26:52.285064568 +0000
@@ -43,7 +43,7 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
--- anobjrmap1/mm/mremap.c	2004-02-18 03:00:07.000000000 +0000
+++ anobjrmap2/mm/mremap.c	2004-03-18 21:26:52.286064416 +0000
@@ -15,7 +15,7 @@
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
--- anobjrmap1/mm/rmap.c	2004-03-18 21:26:40.800810440 +0000
+++ anobjrmap2/mm/rmap.c	2004-03-18 21:26:52.290063808 +0000
@@ -26,7 +26,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 
@@ -551,7 +551,6 @@ out:
  *		pte_chain_lock		shrink_list()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
-static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
 static int fastcall try_to_unmap_one(struct page * page, pte_addr_t paddr)
 {
 	pte_t *ptep = rmap_ptep_map(paddr);
--- anobjrmap1/mm/swapfile.c	2004-03-18 21:26:40.802810136 +0000
+++ anobjrmap2/mm/swapfile.c	2004-03-18 21:26:52.292063504 +0000
@@ -21,7 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/security.h>
 
 #include <asm/pgtable.h>
--- anobjrmap1/mm/vmscan.c	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap2/mm/vmscan.c	2004-03-18 21:26:52.294063200 +0000
@@ -28,7 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
-#include <linux/rmap-locking.h>
+#include <linux/rmap.h>
 #include <linux/topology.h>
 
 #include <asm/pgalloc.h>

