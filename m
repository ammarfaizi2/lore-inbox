Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbUCOXWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbUCOXWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:22:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262844AbUCOXVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:21:50 -0500
Date: Mon, 15 Mar 2004 18:21:21 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@ucw.cz>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: [PATCH] RSS limit enforcement for 2.6
Message-ID: <Pine.LNX.4.44.0403151816350.12895-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hugh Dickins found a bug in the 2.4-rmap RSS limit enforcing
code that may well explain why the previous port of the code
to 2.6 resulted in bad performance.  The split active lists
in 2.4-rmap probably masked the largest damages, but in 2.6
it was very much visible.

The patch below should work.  Pavel, Nick, still interested
in testing the performance ? ;)

===== fs/exec.c 1.105 vs edited =====
--- 1.105/fs/exec.c	Wed Feb 25 05:34:47 2004
+++ edited/fs/exec.c	Mon Mar 15 17:27:06 2004
@@ -1119,6 +1119,11 @@
 	if (retval < 0)
 		goto out_mm;
 
+	if (likely(current->mm))
+		bprm.mm->rlimit_rss = current->mm->rlimit_rss;
+	else 
+		bprm.mm->rlimit_rss = init_mm.rlimit_rss;
+
 	bprm.argc = count(argv, bprm.p / sizeof(void *));
 	if ((retval = bprm.argc) < 0)
 		goto out_mm;
===== include/linux/init_task.h 1.29 vs edited =====
--- 1.29/include/linux/init_task.h	Wed Feb 18 22:42:38 2004
+++ edited/include/linux/init_task.h	Mon Mar 15 17:27:57 2004
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
+#include <asm/resource.h>
 
 #define INIT_FILES \
 { 							\
@@ -42,6 +43,7 @@
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
+	.rlimit_rss	= RLIM_INFINITY,			\
 }
 
 #define INIT_SIGNALS(sig) {	\
===== include/linux/sched.h 1.185 vs edited =====
--- 1.185/include/linux/sched.h	Sun Mar  7 02:05:01 2004
+++ edited/include/linux/sched.h	Mon Mar 15 17:28:38 2004
@@ -205,6 +205,7 @@
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
+	unsigned long rlimit_rss;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
===== include/linux/swap.h 1.80 vs edited =====
--- 1.80/include/linux/swap.h	Mon Jan 19 01:28:35 2004
+++ edited/include/linux/swap.h	Mon Mar 15 17:29:00 2004
@@ -179,7 +179,7 @@
 
 /* linux/mm/rmap.c */
 #ifdef CONFIG_MMU
-int FASTCALL(page_referenced(struct page *));
+int FASTCALL(page_referenced(struct page *, int *));
 struct pte_chain *FASTCALL(page_add_rmap(struct page *, pte_t *,
 					struct pte_chain *));
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
@@ -188,7 +188,7 @@
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
 #else
-#define page_referenced(page)	TestClearPageReferenced(page)
+#define page_referenced(page, _x)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 #endif /* CONFIG_MMU */
 
===== kernel/sys.c 1.73 vs edited =====
--- 1.73/kernel/sys.c	Mon Feb 23 14:46:54 2004
+++ edited/kernel/sys.c	Mon Mar 15 17:30:13 2004
@@ -1489,6 +1489,14 @@
 	if (retval)
 		return retval;
 
+	/* The rlimit is specified in bytes, convert to pages for mm. */
+	if (resource == RLIMIT_RSS && current->mm) {
+		unsigned long pages = RLIM_INFINITY;
+		if (new_rlim.rlim_cur != RLIM_INFINITY)
+			pages = new_rlim.rlim_cur >> PAGE_SHIFT;
+		current->mm->rlimit_rss = pages;
+	}
+
 	*old_rlim = new_rlim;
 	return 0;
 }
===== mm/rmap.c 1.36 vs edited =====
--- 1.36/mm/rmap.c	Sun Mar  7 02:04:57 2004
+++ edited/mm/rmap.c	Mon Mar 15 17:30:45 2004
@@ -104,6 +104,7 @@
 /**
  * page_referenced - test if the page was referenced
  * @page: the page to test
+ * @rsslimit: set if the process(es) using the page is(are) over RSS limit
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
@@ -112,10 +113,11 @@
  * If the page has a single-entry pte_chain, collapse that back to a PageDirect
  * representation.  This way, it's only done under memory pressure.
  */
-int fastcall page_referenced(struct page * page)
+int fastcall page_referenced(struct page * page, int * rsslimit)
 {
 	struct pte_chain *pc;
-	int referenced = 0;
+	int referenced = 0, over_rsslimit = 0;
+	struct mm_struct * mm;
 
 	if (page_test_and_clear_young(page))
 		mark_page_accessed(page);
@@ -125,11 +127,15 @@
 
 	if (PageDirect(page)) {
 		pte_t *pte = rmap_ptep_map(page->pte.direct);
+		mm = ptep_to_mm(pte);
 		if (ptep_test_and_clear_young(pte))
 			referenced++;
+		if (mm->rss > mm->rlimit_rss)
+			over_rsslimit = 1;
 		rmap_ptep_unmap(pte);
-	} else {
+	} else if (page->pte.chain) {
 		int nr_chains = 0;
+		int over_rsslimit = 1;
 
 		/* Check all the page tables mapping this page. */
 		for (pc = page->pte.chain; pc; pc = pte_chain_next(pc)) {
@@ -142,6 +148,9 @@
 				p = rmap_ptep_map(pte_paddr);
 				if (ptep_test_and_clear_young(p))
 					referenced++;
+				mm = ptep_to_mm(p);
+				if (mm->rss <= mm->rlimit_rss)
+					over_rsslimit = 0;
 				rmap_ptep_unmap(p);
 				nr_chains++;
 			}
@@ -154,6 +163,8 @@
 			__pte_chain_free(pc);
 		}
 	}
+	*rsslimit = over_rsslimit;
+
 	return referenced;
 }
 
===== mm/vmscan.c 1.198 vs edited =====
--- 1.198/mm/vmscan.c	Fri Mar 12 04:33:10 2004
+++ edited/mm/vmscan.c	Mon Mar 15 18:07:32 2004
@@ -250,6 +250,7 @@
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
+	int over_rsslimit;
 	int ret = 0;
 
 	cond_resched();
@@ -276,8 +277,8 @@
 			goto keep_locked;
 
 		pte_chain_lock(page);
-		referenced = page_referenced(page);
-		if (referenced && page_mapping_inuse(page)) {
+		referenced = page_referenced(page, &over_rsslimit);
+		if (referenced && page_mapping_inuse(page) && !over_rsslimit) {
 			/* In active use or really unfreeable.  Activate it. */
 			pte_chain_unlock(page);
 			goto activate_locked;
@@ -593,6 +594,7 @@
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+	int over_rsslimit;
 
 	lru_add_drain();
 	pgmoved = 0;
@@ -657,7 +659,7 @@
 				continue;
 			}
 			pte_chain_lock(page);
-			if (page_referenced(page)) {
+			if (page_referenced(page, &over_rsslimit) && !over_rsslimit) {
 				pte_chain_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;

