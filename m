Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUA0RwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA0RwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:52:19 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:43904 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261368AbUA0RwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:52:08 -0500
Date: Tue, 27 Jan 2004 12:51:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       <linux-mm@kvack.org>, <linux-kernel@redhat.com>
Subject: [PATCH] RSS limit enforcement for 2.6
Message-ID: <Pine.LNX.4.44.0401271248580.23718-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Linus,

the patch below (softly) enforces RLIMIT_RSS in the 2.6 kernel,
it has been tested by Pavel and seems to work ok for his workload.
Please place it in -mm for more extensive testing.

thanks,

Rik
===== include/linux/init_task.h 1.27 vs edited =====
--- 1.27/include/linux/init_task.h	Mon Aug 18 22:46:23 2003
+++ edited/include/linux/init_task.h	Tue Jan 20 17:34:40 2004
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
+#include <asm/resource.h>
 
 #define INIT_FILES \
 { 							\
@@ -41,6 +42,7 @@
 	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
+	.rlimit_rss	= RLIM_INFINITY			\
 }
 
 #define INIT_SIGNALS(sig) {	\
===== include/linux/sched.h 1.178 vs edited =====
--- 1.178/include/linux/sched.h	Mon Jan 19 18:38:15 2004
+++ edited/include/linux/sched.h	Tue Jan 20 17:32:56 2004
@@ -204,6 +204,7 @@
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
+	unsigned long rlimit_rss;
 	cpumask_t cpu_vm_mask;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
===== include/linux/swap.h 1.80 vs edited =====
--- 1.80/include/linux/swap.h	Mon Jan 19 01:28:35 2004
+++ edited/include/linux/swap.h	Tue Jan 20 18:16:28 2004
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
 
===== kernel/sys.c 1.69 vs edited =====
--- 1.69/kernel/sys.c	Mon Jan 19 18:38:13 2004
+++ edited/kernel/sys.c	Tue Jan 20 18:02:19 2004
@@ -1308,6 +1308,14 @@
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
===== mm/rmap.c 1.34 vs edited =====
--- 1.34/mm/rmap.c	Mon Jan 19 01:36:00 2004
+++ edited/mm/rmap.c	Tue Jan 20 18:26:03 2004
@@ -104,6 +104,7 @@
 /**
  * page_referenced - test if the page was referenced
  * @page: the page to test
+ * rsslimit: set if the process(es) using the page is(are) over RSS limit
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
@@ -112,8 +113,9 @@
  * If the page has a single-entry pte_chain, collapse that back to a PageDirect
  * representation.  This way, it's only done under memory pressure.
  */
-int page_referenced(struct page * page)
+int page_referenced(struct page * page, int * rsslimit)
 {
+	struct mm_struct * mm;
 	struct pte_chain *pc;
 	int referenced = 0;
 
@@ -127,10 +129,17 @@
 		pte_t *pte = rmap_ptep_map(page->pte.direct);
 		if (ptep_test_and_clear_young(pte))
 			referenced++;
+
+		mm = ptep_to_mm(pte);
+		if (mm->rss > mm->rlimit_rss)
+			*rsslimit = 1;
 		rmap_ptep_unmap(pte);
 	} else {
 		int nr_chains = 0;
 
+		/* We clear it if any task using the page is under its limit. */
+		*rsslimit = 1;
+
 		/* Check all the page tables mapping this page. */
 		for (pc = page->pte.chain; pc; pc = pte_chain_next(pc)) {
 			int i;
@@ -142,6 +151,10 @@
 				p = rmap_ptep_map(pte_paddr);
 				if (ptep_test_and_clear_young(p))
 					referenced++;
+
+				mm = ptep_to_mm(p);
+				if (mm->rss < mm->rlimit_rss)
+					*rsslimit = 0;
 				rmap_ptep_unmap(p);
 				nr_chains++;
 			}
===== mm/vmscan.c 1.177 vs edited =====
--- 1.177/mm/vmscan.c	Mon Jan 19 18:38:07 2004
+++ edited/mm/vmscan.c	Fri Jan 23 14:00:48 2004
@@ -250,6 +250,7 @@
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
+	int over_rsslimit;
 	int ret = 0;
 
 	cond_resched();
@@ -278,8 +279,8 @@
 			goto keep_locked;
 
 		pte_chain_lock(page);
-		referenced = page_referenced(page);
-		if (referenced && page_mapping_inuse(page)) {
+		referenced = page_referenced(page, &over_rsslimit);
+		if (referenced && page_mapping_inuse(page) && !over_rsslimit) {
 			/* In active use or really unfreeable.  Activate it. */
 			pte_chain_unlock(page);
 			goto activate_locked;
@@ -597,6 +598,7 @@
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+	int over_rsslimit;
 
 	lru_add_drain();
 	pgmoved = 0;
@@ -657,7 +659,7 @@
 		list_del(&page->lru);
 		if (page_mapped(page)) {
 			pte_chain_lock(page);
-			if (page_mapped(page) && page_referenced(page)) {
+			if (page_mapped(page) && page_referenced(page, &over_rsslimit) && !over_rsslimit) {
 				pte_chain_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;


