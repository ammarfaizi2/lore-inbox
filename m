Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264824AbSJOVBm>; Tue, 15 Oct 2002 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbSJOVBJ>; Tue, 15 Oct 2002 17:01:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22446 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S264824AbSJOU7X>; Tue, 15 Oct 2002 16:59:23 -0400
Date: Tue, 15 Oct 2002 22:06:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap deadlock
Message-ID: <Pine.LNX.4.44.0210152203300.1521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_pte_range's page_remove_rmap spins for pte_chain_lock while holding
pte_page_lock; while kswapd's try_to_unmap_one spins for pte_page_lock
while holding pte_chain_lock.  This is well documented, and was handled
before by a trylock in try_to_unmap_one: add pte_chain_trylock and use
its alias pte_page_trylock here; and update those comments.

--- 2.5.42-mm3/include/linux/rmap-locking.h	Tue Oct 15 06:43:41 2002
+++ linux/include/linux/rmap-locking.h	Tue Oct 15 13:14:35 2002
@@ -23,6 +23,18 @@
 #endif
 }
 
+static inline int pte_chain_trylock(struct page *page)
+{
+	preempt_disable();
+#ifdef CONFIG_SMP
+	if (test_and_set_bit(PG_chainlock, &page->flags)) {
+		preempt_enable();
+		return 0;
+	}
+#endif
+	return 1;
+}
+
 static inline void pte_chain_unlock(struct page *page)
 {
 #ifdef CONFIG_SMP
@@ -32,5 +44,6 @@
 	preempt_enable();
 }
 
-#define	pte_page_lock	pte_chain_lock
-#define	pte_page_unlock	pte_chain_unlock
+#define pte_page_lock		pte_chain_lock
+#define pte_page_trylock	pte_chain_trylock
+#define pte_page_unlock		pte_chain_unlock
--- 2.5.42-mm3/mm/rmap.c	Tue Oct 15 06:43:41 2002
+++ linux/mm/rmap.c	Tue Oct 15 13:14:35 2002
@@ -14,11 +14,11 @@
 /*
  * Locking:
  * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the zone->lru_lock, then the
- *   mm->page_table_lock, and then the page lock.
+ *   which nests within the zone->lru_lock, then the pte_page_lock,
+ *   and then the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
- *   on the mm->page_table_lock
+ *   on the pte_page_lock.
  */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -280,7 +280,7 @@
  * @ptep: the page table entry mapping this page
  *
  * Add a new pte reverse mapping to a page.
- * The caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the pte_page_lock.
  */
 void page_add_rmap(struct page * page, pte_t * ptep)
 {
@@ -377,7 +377,7 @@
  * Removes the reverse mapping from the pte_chain of the page,
  * after that the caller can clear the page table entry and free
  * the page.
- * Caller needs to hold the mm->page_table_lock.
+ * Caller needs to hold the pte_page_lock.
  */
 void page_remove_rmap(struct page * page, pte_t * ptep)
 {
@@ -560,7 +560,7 @@
  *	zone->lru_lock			page_launder()
  *	    page lock			page_launder(), trylock
  *		pte_chain_lock		page_launder()
- *		    mm->page_table_lock	try_to_unmap_one(), trylock
+ *		    pte_page_lock	try_to_unmap_one(), trylock
  */
 static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
 static int try_to_unmap_one(struct page * page, pte_addr_t paddr)
@@ -571,7 +571,10 @@
 	unsigned long address = ptep_to_address(ptep);
 	int ret;
 
-	pte_page_lock(ptepage);
+	if (!pte_page_trylock(ptepage)) {
+		rmap_ptep_unmap(ptep);
+		return SWAP_AGAIN;
+	}
 
 	ret = pgtable_check_mlocked(ptepage, address);
 	if (ret != SWAP_SUCCESS)

