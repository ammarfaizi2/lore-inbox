Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSG1HWE>; Sun, 28 Jul 2002 03:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSG1HWC>; Sun, 28 Jul 2002 03:22:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52229 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318918AbSG1HUv>;
	Sun, 28 Jul 2002 03:20:51 -0400
Message-ID: <3D439E15.9827B189@zip.com.au>
Date: Sun, 28 Jul 2002 00:32:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/13] use a slab cache for pte_chains
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from Bill Irwin.

It removes the custom pte_chain allocator in mm/rmap.c and replaces it
with a slab cache.

"This patch
 (1) eliminates the pte_chain_freelist_lock and all contention on it
 (2) gives the VM the ability to recover unused pte_chain pages

 Anton Blanchard has reported (1) from prior incarnations of this patch.
 Craig Kulesa has reported (2) in combination with slab-on-LRU patches.

 I've left OOM detection out of this patch entirely as upcoming patches
 will do real OOM handling for pte_chains and all the code changed anyway."





 fs/proc/proc_misc.c        |    6 +--
 include/linux/page-flags.h |    3 -
 init/main.c                |    4 +-
 mm/page_alloc.c            |    3 -
 mm/rmap.c                  |   82 +++++++++------------------------------------
 5 files changed, 23 insertions(+), 75 deletions(-)

--- 2.5.29/fs/proc/proc_misc.c~pte_chain_slab	Sat Jul 27 23:39:01 2002
+++ 2.5.29-akpm/fs/proc/proc_misc.c	Sat Jul 27 23:49:00 2002
@@ -161,8 +161,7 @@ static int meminfo_read_proc(char *page,
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
 		"PageTables:   %8lu kB\n"
-		"PteChainTot:  %8lu kB\n"
-		"PteChainUsed: %8lu kB\n",
+		"ReverseMaps:  %8lu\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -179,8 +178,7 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
 		K(ps.nr_page_table_pages),
-		K(ps.nr_pte_chain_pages),
-		ps.used_pte_chains_bytes >> 10
+		ps.nr_reverse_maps
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
--- 2.5.29/include/linux/page-flags.h~pte_chain_slab	Sat Jul 27 23:39:01 2002
+++ 2.5.29-akpm/include/linux/page-flags.h	Sat Jul 27 23:49:02 2002
@@ -79,8 +79,7 @@ extern struct page_state {
 	unsigned long nr_active;	/* on active_list LRU */
 	unsigned long nr_inactive;	/* on inactive_list LRU */
 	unsigned long nr_page_table_pages;
-	unsigned long nr_pte_chain_pages;
-	unsigned long used_pte_chains_bytes;
+	unsigned long nr_reverse_maps;
 } ____cacheline_aligned_in_smp page_states[NR_CPUS];
 
 extern void get_page_state(struct page_state *ret);
--- 2.5.29/init/main.c~pte_chain_slab	Sat Jul 27 23:39:01 2002
+++ 2.5.29-akpm/init/main.c	Sat Jul 27 23:39:01 2002
@@ -70,7 +70,7 @@ extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern void buffer_init(void);
-
+extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 
@@ -432,7 +432,7 @@ asmlinkage void __init start_kernel(void
 	mem_init();
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
-
+	pte_chain_init();
 	mempages = num_physpages;
 
 	fork_init(mempages);
--- 2.5.29/mm/page_alloc.c~pte_chain_slab	Sat Jul 27 23:39:01 2002
+++ 2.5.29-akpm/mm/page_alloc.c	Sat Jul 27 23:49:03 2002
@@ -567,8 +567,7 @@ void get_page_state(struct page_state *r
 		ret->nr_active += ps->nr_active;
 		ret->nr_inactive += ps->nr_inactive;
 		ret->nr_page_table_pages += ps->nr_page_table_pages;
-		ret->nr_pte_chain_pages += ps->nr_pte_chain_pages;
-		ret->used_pte_chains_bytes += ps->used_pte_chains_bytes;
+		ret->nr_reverse_maps += ps->nr_reverse_maps;
 	}
 }
 
--- 2.5.29/mm/rmap.c~pte_chain_slab	Sat Jul 27 23:39:01 2002
+++ 2.5.29-akpm/mm/rmap.c	Sat Jul 27 23:39:01 2002
@@ -23,6 +23,8 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
+#include <linux/slab.h>
+#include <linux/init.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -50,10 +52,10 @@ struct pte_chain {
 	pte_t * ptep;
 };
 
+static kmem_cache_t	*pte_chain_cache;
 static inline struct pte_chain * pte_chain_alloc(void);
 static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
 		struct page *);
-static void alloc_new_pte_chains(void);
 
 /**
  * page_referenced - test if the page was referenced
@@ -148,6 +150,7 @@ void page_add_rmap(struct page * page, p
 	}
 
 	pte_chain_unlock(page);
+	inc_page_state(nr_reverse_maps);
 }
 
 /**
@@ -210,9 +213,9 @@ void page_remove_rmap(struct page * page
 #endif
 
 out:
+	dec_page_state(nr_reverse_maps);
 	pte_chain_unlock(page);
 	return;
-			
 }
 
 /**
@@ -357,27 +360,6 @@ int try_to_unmap(struct page * page)
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
@@ -393,15 +375,12 @@ static inline struct pte_chain * pte_cha
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
@@ -411,47 +390,20 @@ static inline void pte_chain_free(struct
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

.
