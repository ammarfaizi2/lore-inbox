Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSGWAGM>; Mon, 22 Jul 2002 20:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317869AbSGWAGL>; Mon, 22 Jul 2002 20:06:11 -0400
Received: from holomorphy.com ([66.224.33.161]:32135 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317868AbSGWAGI>;
	Mon, 22 Jul 2002 20:06:08 -0400
Date: Mon, 22 Jul 2002 17:09:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@zip.com.au, ckulesa@cs.arizona.edu,
       anton@samba.org
Subject: pte_chain_slab-2.5.27-1
Message-ID: <20020723000913.GH919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
	ckulesa@cs.arizona.edu, anton@samba.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update of the pte_chain_mempool patch, which removes mempool
from it and uses the slab exclusively instead.

This patch
(1) eliminates the pte_chain_freelist_lock and all contention on it
(2) gives the VM the ability to recover unused pte_chain pages

Anton Blanchard has reported (1) from prior incarnations of this patch.
Craig Kulesa has reported (2) in combination with slab-on-LRU patches.

I've left OOM detection out of this patch entirely as upcoming patches
will do real OOM handling for pte_chains and all the code changed anyway.

This also removes more code than it adds:

$ diffstat ~/patches/pte_chain_slab-1 
 fs/proc/proc_misc.c        |    6 +--
 include/linux/page-flags.h |    3 -
 init/main.c                |    4 +-
 mm/page_alloc.c            |    3 -
 mm/rmap.c                  |   82 +++++++++------------------------------------
 5 files changed, 23 insertions(+), 75 deletions(-)

It only took a couple of minutes while my test machines were busy
booting anyway so it hasn't taken time away from highpte_chain.

Cheers,
Bill


===== fs/proc/proc_misc.c 1.31 vs edited =====
--- 1.31/fs/proc/proc_misc.c	Tue Jul 16 14:46:30 2002
+++ edited/fs/proc/proc_misc.c	Mon Jul 22 18:33:38 2002
@@ -161,8 +161,7 @@
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
 		"PageTables:   %8lu kB\n"
-		"PteChainTot:  %8lu kB\n"
-		"PteChainUsed: %8lu kB\n",
+		"ReverseMaps:  %8lu\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -179,8 +178,7 @@
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
 		K(ps.nr_page_table_pages),
-		K(ps.nr_pte_chain_pages),
-		ps.used_pte_chains_bytes >> 10
+		ps.nr_reverse_maps
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
===== include/linux/page-flags.h 1.12 vs edited =====
--- 1.12/include/linux/page-flags.h	Tue Jul 16 14:46:30 2002
+++ edited/include/linux/page-flags.h	Mon Jul 22 18:33:38 2002
@@ -79,8 +79,7 @@
 	unsigned long nr_active;	/* on active_list LRU */
 	unsigned long nr_inactive;	/* on inactive_list LRU */
 	unsigned long nr_page_table_pages;
-	unsigned long nr_pte_chain_pages;
-	unsigned long used_pte_chains_bytes;
+	unsigned long nr_reverse_maps;
 } ____cacheline_aligned_in_smp page_states[NR_CPUS];
 
 extern void get_page_state(struct page_state *ret);
===== init/main.c 1.52 vs edited =====
--- 1.52/init/main.c	Sun Jul 21 09:09:17 2002
+++ edited/init/main.c	Mon Jul 22 18:33:38 2002
@@ -70,7 +70,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern void buffer_init(void);
-
+extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 
@@ -386,7 +386,7 @@
 	mem_init();
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
-
+	pte_chain_init();
 	mempages = num_physpages;
 
 	fork_init(mempages);
===== mm/page_alloc.c 1.82 vs edited =====
--- 1.82/mm/page_alloc.c	Tue Jul 16 14:46:36 2002
+++ edited/mm/page_alloc.c	Mon Jul 22 18:33:38 2002
@@ -566,8 +566,7 @@
 		ret->nr_active += ps->nr_active;
 		ret->nr_inactive += ps->nr_inactive;
 		ret->nr_page_table_pages += ps->nr_page_table_pages;
-		ret->nr_pte_chain_pages += ps->nr_pte_chain_pages;
-		ret->used_pte_chains_bytes += ps->used_pte_chains_bytes;
+		ret->nr_reverse_maps += ps->nr_reverse_maps;
 	}
 }
 
===== mm/rmap.c 1.3 vs edited =====
--- 1.3/mm/rmap.c	Tue Jul 16 14:46:30 2002
+++ edited/mm/rmap.c	Mon Jul 22 18:36:51 2002
@@ -23,6 +23,8 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
+#include <linux/slab.h>
+#include <linux/init.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -50,10 +52,10 @@
 	pte_t * ptep;
 };
 
+static kmem_cache_t	*pte_chain_cache;
 static inline struct pte_chain * pte_chain_alloc(void);
 static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
 		struct page *);
-static void alloc_new_pte_chains(void);
 
 /**
  * page_referenced - test if the page was referenced
@@ -148,6 +151,7 @@
 	}
 
 	pte_chain_unlock(page);
+	inc_page_state(nr_reverse_maps);
 }
 
 /**
@@ -208,9 +212,9 @@
 #endif
 
 out:
+	dec_page_state(nr_reverse_maps);
 	pte_chain_unlock(page);
 	return;
-			
 }
 
 /**
@@ -355,27 +359,6 @@
  ** functions.
  **/
 
-struct pte_chain * pte_chain_freelist;
-spinlock_t pte_chain_freelist_lock = SPIN_LOCK_UNLOCKED;
-
-/* Maybe we should have standard ops for singly linked lists ... - Rik */
-static inline void pte_chain_push(struct pte_chain * pte_chain)
-{
-	pte_chain->ptep = NULL;
-	pte_chain->next = pte_chain_freelist;
-	pte_chain_freelist = pte_chain;
-}
-
-static inline struct pte_chain * pte_chain_pop(void)
-{
-	struct pte_chain *pte_chain;
-
-	pte_chain = pte_chain_freelist;
-	pte_chain_freelist = pte_chain->next;
-	pte_chain->next = NULL;
-
-	return pte_chain;
-}
 
 /**
  * pte_chain_free - free pte_chain structure
@@ -391,15 +374,12 @@
 static inline void pte_chain_free(struct pte_chain * pte_chain,
 		struct pte_chain * prev_pte_chain, struct page * page)
 {
-	mod_page_state(used_pte_chains_bytes, -sizeof(struct pte_chain));
 	if (prev_pte_chain)
 		prev_pte_chain->next = pte_chain->next;
 	else if (page)
 		page->pte.chain = pte_chain->next;
 
-	spin_lock(&pte_chain_freelist_lock);
-	pte_chain_push(pte_chain);
-	spin_unlock(&pte_chain_freelist_lock);
+	kmem_cache_free(pte_chain_cache, pte_chain);
 }
 
 /**
@@ -409,47 +389,20 @@
  * pte_chain structures as required.
  * Caller needs to hold the page's pte_chain_lock.
  */
-static inline struct pte_chain * pte_chain_alloc()
+static inline struct pte_chain *pte_chain_alloc(void)
 {
-	struct pte_chain * pte_chain;
-
-	spin_lock(&pte_chain_freelist_lock);
-
-	/* Allocate new pte_chain structs as needed. */
-	if (!pte_chain_freelist)
-		alloc_new_pte_chains();
-
-	/* Grab the first pte_chain from the freelist. */
-	pte_chain = pte_chain_pop();
-
-	spin_unlock(&pte_chain_freelist_lock);
-
-	mod_page_state(used_pte_chains_bytes, sizeof(struct pte_chain));
-	return pte_chain;
+	return kmem_cache_alloc(pte_chain_cache, GFP_ATOMIC);
 }
 
-/**
- * alloc_new_pte_chains - convert a free page to pte_chain structures
- *
- * Grabs a free page and converts it to pte_chain structures. We really
- * should pre-allocate these earlier in the pagefault path or come up
- * with some other trick.
- *
- * Note that we cannot use the slab cache because the pte_chain structure
- * is way smaller than the minimum size of a slab cache allocation.
- * Caller needs to hold the pte_chain_freelist_lock
- */
-static void alloc_new_pte_chains()
+void __init pte_chain_init(void)
 {
-	struct pte_chain * pte_chain = (void *) get_zeroed_page(GFP_ATOMIC);
-	int i = PAGE_SIZE / sizeof(struct pte_chain);
+	pte_chain_cache = kmem_cache_create(	"pte_chain",
+						sizeof(struct pte_chain),
+						0,
+						0,
+						NULL,
+						NULL);
 
-	if (pte_chain) {
-		inc_page_state(nr_pte_chain_pages);
-		for (; i-- > 0; pte_chain++)
-			pte_chain_push(pte_chain);
-	} else {
-		/* Yeah yeah, I'll fix the pte_chain allocation ... */
-		panic("Fix pte_chain allocation, you lazy bastard!\n");
-	}
+	if (!pte_chain_cache)
+		panic("failed to create pte_chain cache!\n");
 }
