Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318321AbSHEGwg>; Mon, 5 Aug 2002 02:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318323AbSHEGwg>; Mon, 5 Aug 2002 02:52:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35084 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318321AbSHEGwb>;
	Mon, 5 Aug 2002 02:52:31 -0400
Message-ID: <3D4E23C4.F746CF3D@zip.com.au>
Date: Mon, 05 Aug 2002 00:05:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <3D4DB9E4.E785184E@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> I'll code it tomorrow.

Tomorrow came early.

It makes basically no difference at all.  Maybe pulled back 10 of the lost
50%.  The kernel is still spending much time in the pte_chain walk in
page_remove_rmap().

Despite the fact that the number of pte_chain references in page_add/remove_rmap
now just averages two in that test.  So I'm rather stumped.  It seems that
adding any misses at all to the copy_page_range/zap_page_range path hurts.

This patch _has_ to help, even if not on my box.  Plus it's gorgeous ;)  See
how it minimises internal fragmentation and cache misses at the same time.

Let's look at `make -j6 bzImage':

2.5.30+rmap-locking+rmap-speedup:

c0133444 99       0.597213    __pagevec_lru_add       
c0134e10 99       0.597213    __alloc_pages           
c0115d60 102      0.61531     do_schedule             
c01218fc 116      0.699765    update_one_process      
c01331f4 125      0.754057    __pagevec_release       
c0121a34 133      0.802316    timer_bh                
c012afa4 134      0.808349    sys_brk                 
c012bfd4 139      0.838511    do_brk                  
c0128980 155      0.93503     pte_alloc_map           
c01350b4 158      0.953128    nr_free_pages           
c013c4a0 164      0.989323    __page_add_rmap         
c0107100 168      1.01345     system_call             
c01346d0 182      1.09791     __free_pages_ok         
c013c570 186      1.12204     page_add_rmap           
c01df770 186      1.12204     __generic_copy_to_user  
c012b88c 188      1.1341      find_vma                
c013c5d4 199      1.20046     __page_remove_rmap      
c012ae90 212      1.27888     vm_enough_memory        
c0151cd4 214      1.29095     __d_lookup              
c01351ac 227      1.36937     get_page_state          
c012ab0c 230      1.38746     handle_mm_fault         
c01126e4 247      1.49002     smp_apic_timer_interrupt 
c0148ce8 282      1.70115     link_path_walk          
c0128ed0 291      1.75544     zap_pte_range           
c0115a48 338      2.03897     scheduler_tick          
c012a7f0 349      2.10533     do_no_page              
c0107c90 368      2.21994     page_fault              
c01142b4 388      2.34059     do_page_fault           
c0129d98 389      2.34662     do_wp_page              
c010c674 515      3.10671     timer_interrupt         
c01349bc 547      3.29975     rmqueue                 
c01df7bc 711      4.28908     __generic_copy_from_user 
c012da60 1045     6.30392     file_read_actor         
c012a5fc 3343     20.1665     do_anonymous_page 

2.5.26:

c0128160 92       0.594853    pte_alloc_map           
c0106fca 96       0.620716    restore_all             
c01d98d8 104      0.672443    strnlen_user            
c0113118 105      0.678909    set_ioapic_affinity     
c012a048 108      0.698306    sys_brk                 
c01213cc 110      0.711238    update_one_process      
c012c3b8 121      0.782361    find_get_page           
c012af50 131      0.847019    do_brk                  
c01338dc 133      0.859951    nr_free_pages           
c0131d00 145      0.93754     lru_cache_add           
c0139a08 147      0.950472    do_page_cache_readahead 
c0129c8c 151      0.976335    handle_mm_fault         
c0106f88 164      1.06039     system_call             
c01d9730 169      1.09272     __generic_copy_to_user  
c01db08c 178      1.15091     radix_tree_lookup       
c0132f30 190      1.2285      __free_pages_ok         
c012a8ac 194      1.25436     find_vma                
c01284f0 226      1.46127     zap_pte_range           
c014eb84 234      1.513       __d_lookup              
c01339b4 237      1.53239     get_page_state          
c011268c 245      1.58412     smp_apic_timer_interrupt 
c011415c 246      1.59059     do_page_fault           
c0145e08 298      1.92681     link_path_walk          
c0107b58 319      2.06259     page_fault              
c01157d4 346      2.23717     scheduler_tick          
c0129a04 346      2.23717     do_no_page              
c0129124 378      2.44407     do_wp_page              
c010c7f4 529      3.42041     timer_interrupt         
c01331c0 638      4.12518     rmqueue                 
c01d977c 682      4.40967     __generic_copy_from_user 
c012c964 988      6.38821     file_read_actor         
c0129868 3179     20.5548     do_anonymous_page       

Not much stands out there, except that the increase in HZ hurts
more than rmap.

2.5.26:
make -j6 bzImage  395.35s user 31.21s system 377% cpu 1:52.94 total
2.5.30:
make -j6 bzImage  395.55s user 33.00s system 375% cpu 1:54.19 total
2.5.30+everything
make -j6 bzImage  395.76s user 32.97s system 382% cpu 1:52.00 total
2.4.19
make -j6 bzImage  397.74s user 28.27s system 373% cpu 1:53.91 total
2.5.30+everything+HZ=100
make -j6 bzImage  393.60s user 28.91s system 373% cpu 1:53.06 total


Should we count PageDirect rmaps in /proc/meminfo:ReverseMaps?
I chose not to, so we can compare that number with the slabinfo
for pte_chains and see how much memory is being wasted.  Plus the
PageDirect rmaps aren't very interesting, because they don't consume
any resources.




 rmap.c |  233 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 161 insertions(+), 72 deletions(-)

--- 2.5.30/mm/rmap.c~rmap-speedup	Sun Aug  4 23:23:51 2002
+++ 2.5.30-akpm/mm/rmap.c	Sun Aug  4 23:58:27 2002
@@ -41,24 +41,39 @@
  * here, the page struct for the page table page contains the process
  * it belongs to and the offset within that process.
  *
- * A singly linked list should be fine for most, if not all, workloads.
- * On fork-after-exec the mapping we'll be removing will still be near
- * the start of the list, on mixed application systems the short-lived
- * processes will have their mappings near the start of the list and
- * in systems with long-lived applications the relative overhead of
- * exit() will be lower since the applications are long-lived.
+ * We use an array of pte pointers in this structure to minimise cache misses
+ * while traversing reverse maps.
  */
+#define NRPTE (L1_CACHE_BYTES/sizeof(void *) - 1)
+
 struct pte_chain {
 	struct pte_chain * next;
-	pte_t * ptep;
+	pte_t *ptes[NRPTE];
 };
 
 spinlock_t rmap_locks[NUM_RMAP_LOCKS];
 
 static kmem_cache_t	*pte_chain_cache;
 static inline struct pte_chain * pte_chain_alloc(void);
-static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
-		struct page *);
+static void pte_chain_free(struct pte_chain *pte_chain);
+
+/*
+ * pte_chain list management policy:
+ *
+ * - If a page has a pte_chain list then it is shared by at least two processes,
+ *   because a single sharing uses PageDirect. (Well, this isn't true yet,
+ *   coz this code doesn't collapse singletons back to PageDirect on the remove
+ *   path).
+ * - A pte_chain list has free space only in the head member - all succeeding
+ *   members are 100% full.
+ * - If the head element has free space, it occurs in its leading slots.
+ * - All free space in the pte_chain is at the start of the head member.
+ * - Insertion into the pte_chain puts a pte pointer in the last free slot of
+ *   the head member.
+ * - Removal from a pte chain moves the head pte of the head member onto the
+ *   victim pte and frees the head member if it became empty.
+ */
+
 
 /**
  * page_referenced - test if the page was referenced
@@ -82,8 +97,13 @@ int page_referenced(struct page * page)
 	} else {
 		/* Check all the page tables mapping this page. */
 		for (pc = page->pte.chain; pc; pc = pc->next) {
-			if (ptep_test_and_clear_young(pc->ptep))
-				referenced++;
+			int i;
+
+			for (i = 0; i < NRPTE; i++) {
+				pte_t *p = pc->ptes[i];
+				if (p && ptep_test_and_clear_young(p))
+					referenced++;
+			}
 		}
 	}
 	return referenced;
@@ -100,6 +120,7 @@ int page_referenced(struct page * page)
 void __page_add_rmap(struct page *page, pte_t *ptep)
 {
 	struct pte_chain * pte_chain;
+	int i;
 
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
@@ -121,32 +142,58 @@ void __page_add_rmap(struct page *page, 
 				BUG();
 		} else {
 			for (pc = page->pte.chain; pc; pc = pc->next) {
-				if (pc->ptep == ptep)
-					BUG();
+				for (i = 0; i < NRPTE; i++) {
+					pte_t *p = pc->ptes[i];
+
+					if (p && p == ptep)
+						BUG();
+				}
 			}
 		}
 	}
 #endif
 
+	if (page->pte.chain == NULL) {
+		page->pte.direct = ptep;
+		SetPageDirect(page);
+		goto out;
+	}
+	
 	if (PageDirect(page)) {
 		/* Convert a direct pointer into a pte_chain */
-		pte_chain = pte_chain_alloc();
-		pte_chain->ptep = page->pte.direct;
-		pte_chain->next = NULL;
-		page->pte.chain = pte_chain;
 		ClearPageDirect(page);
-	}
-	if (page->pte.chain) {
-		/* Hook up the pte_chain to the page. */
 		pte_chain = pte_chain_alloc();
-		pte_chain->ptep = ptep;
-		pte_chain->next = page->pte.chain;
+		pte_chain->ptes[NRPTE-1] = page->pte.direct;
+		pte_chain->ptes[NRPTE-2] = ptep;
+		mod_page_state(nr_reverse_maps, 2);
 		page->pte.chain = pte_chain;
-	} else {
-		page->pte.direct = ptep;
-		SetPageDirect(page);
+		goto out;
+	}
+
+	pte_chain = page->pte.chain;
+	if (pte_chain->ptes[0]) {	/* It's full */
+		struct pte_chain *new;
+
+		new = pte_chain_alloc();
+		new->next = pte_chain;
+		page->pte.chain = new;
+		new->ptes[NRPTE-1] = ptep;
+		inc_page_state(nr_reverse_maps);
+		goto out;
 	}
-	inc_page_state(nr_reverse_maps);
+
+	BUG_ON(pte_chain->ptes[NRPTE-1] == NULL);
+
+	for (i = NRPTE-2; i >= 0; i--) {
+		if (pte_chain->ptes[i] == NULL) {
+			pte_chain->ptes[i] = ptep;
+			inc_page_state(nr_reverse_maps);
+			goto out;
+		}
+	}
+	BUG();
+
+out:
 }
 
 void page_add_rmap(struct page *page, pte_t *ptep)
@@ -172,7 +219,7 @@ void page_add_rmap(struct page *page, pt
  */
 void __page_remove_rmap(struct page *page, pte_t *ptep)
 {
-	struct pte_chain * pc, * prev_pc = NULL;
+	struct pte_chain *pc;
 
 	if (!page || !ptep)
 		BUG();
@@ -186,15 +233,32 @@ void __page_remove_rmap(struct page *pag
 			goto out;
 		}
 	} else {
-		for (pc = page->pte.chain; pc; prev_pc = pc, pc = pc->next) {
-			if (pc->ptep == ptep) {
-				pte_chain_free(pc, prev_pc, page);
-				/* Check whether we can convert to direct */
-				pc = page->pte.chain;
-				if (!pc->next) {
-					page->pte.direct = pc->ptep;
-					SetPageDirect(page);
-					pte_chain_free(pc, NULL, NULL);
+		struct pte_chain *start = page->pte.chain;
+		int victim_i = -1;
+
+		for (pc = start; pc; pc = pc->next) {
+			int i;
+
+			if (pc->next)
+				prefetch(pc->next);
+			for (i = 0; i < NRPTE; i++) {
+				pte_t *p = pc->ptes[i];
+
+				if (!p)
+					continue;
+				if (victim_i == -1)
+					victim_i = i;
+				if (p != ptep)
+					continue;
+				pc->ptes[i] = start->ptes[victim_i];
+				start->ptes[victim_i] = NULL;
+				dec_page_state(nr_reverse_maps);
+				if (victim_i == NRPTE-1) {
+					/* Emptied a pte_chain */
+					page->pte.chain = start->next;
+					pte_chain_free(start);
+				} else {
+					/* Do singleton->PageDirect here */
 				}
 				goto out;
 			}
@@ -213,9 +277,9 @@ void __page_remove_rmap(struct page *pag
 	printk("\n");
 	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
 #endif
+	return;
 
 out:
-	dec_page_state(nr_reverse_maps);
 	return;
 }
 
@@ -317,8 +381,9 @@ out_unlock:
  */
 int try_to_unmap(struct page * page)
 {
-	struct pte_chain * pc, * next_pc, * prev_pc = NULL;
+	struct pte_chain *pc, *next_pc, *start;
 	int ret = SWAP_SUCCESS;
+	int victim_i = -1;
 
 	/* This page should not be on the pageout lists. */
 	if (PageReserved(page))
@@ -335,35 +400,57 @@ int try_to_unmap(struct page * page)
 			page->pte.direct = NULL;
 			ClearPageDirect(page);
 		}
-	} else {		
-		for (pc = page->pte.chain; pc; pc = next_pc) {
-			next_pc = pc->next;
-			switch (try_to_unmap_one(page, pc->ptep)) {
-				case SWAP_SUCCESS:
-					/* Free the pte_chain struct. */
-					pte_chain_free(pc, prev_pc, page);
-					break;
-				case SWAP_AGAIN:
-					/* Skip this pte, remembering status. */
-					prev_pc = pc;
-					ret = SWAP_AGAIN;
-					continue;
-				case SWAP_FAIL:
-					ret = SWAP_FAIL;
-					break;
-				case SWAP_ERROR:
-					ret = SWAP_ERROR;
-					break;
+		goto out;
+	}		
+
+	start = page->pte.chain;
+	for (pc = start; pc; pc = next_pc) {
+		int i;
+
+		next_pc = pc->next;
+		if (next_pc)
+			prefetch(next_pc);
+		for (i = 0; i < NRPTE; i++) {
+			pte_t *p = pc->ptes[i];
+
+			if (!p)
+				continue;
+			if (victim_i == -1) 
+				victim_i = i;
+
+			switch (try_to_unmap_one(page, p)) {
+			case SWAP_SUCCESS:
+				/*
+				 * Release a slot.  If we're releasing the
+				 * first pte in the first pte_chain then
+				 * pc->ptes[i] and start->ptes[victim_i] both
+				 * refer to the same thing.  It works out.
+				 */
+				pc->ptes[i] = start->ptes[victim_i];
+				start->ptes[victim_i] = NULL;
+				dec_page_state(nr_reverse_maps);
+				victim_i++;
+				if (victim_i == NRPTE) {
+					page->pte.chain = start->next;
+					pte_chain_free(start);
+					start = page->pte.chain;
+					victim_i = 0;
+				}
+				break;
+			case SWAP_AGAIN:
+				/* Skip this pte, remembering status. */
+				ret = SWAP_AGAIN;
+				continue;
+			case SWAP_FAIL:
+				ret = SWAP_FAIL;
+				goto out;
+			case SWAP_ERROR:
+				ret = SWAP_ERROR;
+				goto out;
 			}
 		}
-		/* Check whether we can convert to direct pte pointer */
-		pc = page->pte.chain;
-		if (pc && !pc->next) {
-			page->pte.direct = pc->ptep;
-			SetPageDirect(page);
-			pte_chain_free(pc, NULL, NULL);
-		}
 	}
+out:
 	return ret;
 }
 
@@ -384,14 +471,9 @@ int try_to_unmap(struct page * page)
  * called for new pte_chain structures which aren't on any list yet.
  * Caller needs to hold the rmap_lock if the page is non-NULL.
  */
-static inline void pte_chain_free(struct pte_chain * pte_chain,
-		struct pte_chain * prev_pte_chain, struct page * page)
+static void pte_chain_free(struct pte_chain *pte_chain)
 {
-	if (prev_pte_chain)
-		prev_pte_chain->next = pte_chain->next;
-	else if (page)
-		page->pte.chain = pte_chain->next;
-
+	pte_chain->next = NULL;
 	kmem_cache_free(pte_chain_cache, pte_chain);
 }
 
@@ -406,6 +488,13 @@ static inline struct pte_chain *pte_chai
 	return kmem_cache_alloc(pte_chain_cache, GFP_ATOMIC);
 }
 
+static void pte_chain_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct pte_chain *pc = p;
+
+	memset(pc, 0, sizeof(*pc));
+}
+
 void __init pte_chain_init(void)
 {
 	int i;
@@ -417,7 +506,7 @@ void __init pte_chain_init(void)
 						sizeof(struct pte_chain),
 						0,
 						0,
-						NULL,
+						pte_chain_ctor,
 						NULL);
 
 	if (!pte_chain_cache)

.
