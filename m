Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbTCYWBn>; Tue, 25 Mar 2003 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbTCYWBS>; Tue, 25 Mar 2003 17:01:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38529 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261570AbTCYWAz>; Tue, 25 Mar 2003 17:00:55 -0500
Date: Tue, 25 Mar 2003 22:13:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 04/13 page_convert_anon -ENOMEM
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252213140.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

objrmap page_convert_anon tries to allocate pte_chains, so must allow
for failure (even GFP_KERNEL can fail when OOM-killed); and move its
prototype to join the rest of the rmap.c prototypes in swap.h.

--- swap03/include/linux/rmap-locking.h	Sun Mar 23 10:30:14 2003
+++ swap04/include/linux/rmap-locking.h	Tue Mar 25 20:43:29 2003
@@ -45,5 +45,3 @@
 	if (pte_chain)
 		__pte_chain_free(pte_chain);
 }
-
-void page_convert_anon(struct page *page);
--- swap03/include/linux/swap.h	Tue Mar 25 20:43:18 2003
+++ swap04/include/linux/swap.h	Tue Mar 25 20:43:29 2003
@@ -175,6 +175,8 @@
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
 int FASTCALL(try_to_unmap(struct page *));
 
+int page_convert_anon(struct page *);
+
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
 #else
--- swap03/mm/fremap.c	Sun Mar 23 10:30:15 2003
+++ swap04/mm/fremap.c	Tue Mar 25 20:43:29 2003
@@ -69,8 +69,10 @@
 	pgidx = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgidx += vma->vm_pgoff;
 	pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-	if (!PageAnon(page) && (page->index != pgidx))
-		page_convert_anon(page);
+	if (!PageAnon(page) && (page->index != pgidx)) {
+		if (page_convert_anon(page) < 0)
+			goto err_free;
+	}
 
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
@@ -95,12 +97,10 @@
 	if (flush)
 		flush_tlb_page(vma, addr);
 
-	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-	return 0;
-
+	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
+err_free:
 	pte_chain_free(pte_chain);
 err:
 	return err;
--- swap03/mm/rmap.c	Tue Mar 25 20:42:56 2003
+++ swap04/mm/rmap.c	Tue Mar 25 20:43:29 2003
@@ -774,7 +774,7 @@
  * of pte_chain structures to ensure that it can complete without releasing
  * the lock.
  */
-void page_convert_anon(struct page *page)
+int page_convert_anon(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
@@ -783,6 +783,7 @@
 	pte_addr_t pte_paddr;
 	int mapcount;
 	int index = 0;
+	int err = 0;
 
 	if (PageAnon(page))
 		goto out;
@@ -795,6 +796,15 @@
 	if (mapcount > 1) {
 		for (; index < mapcount; index += NRPTE) {
 			ptec = pte_chain_alloc(GFP_KERNEL);
+			if (!ptec) {
+				while (pte_chain) {
+					ptec = pte_chain->next;
+					pte_chain_free(pte_chain);
+					pte_chain = ptec;
+				}
+				err = -ENOMEM;
+				goto out;
+			}
 			ptec->next = pte_chain;
 			pte_chain = ptec;
 		}
@@ -867,7 +877,7 @@
 	pte_chain_unlock(page);
 	up(&mapping->i_shared_sem);
 out:
-	return;
+	return err;
 }
 
 /**

