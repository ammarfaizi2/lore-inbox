Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTDQQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTDQQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:46:28 -0400
Received: from galileo.bork.org ([66.11.174.148]:14355 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261705AbTDQQqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:46:25 -0400
Date: Thu, 17 Apr 2003 12:58:19 -0400
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Cc: wildos@sgi.com
Subject: [PATCH] Empty PTEs and fewer TLB flushes
Message-ID: <20030417165819.GD543@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here's a patch to make it so empty PTEs are not added to mmu_gathers
(except the first one). It also reduces the number of unnecessary TLB
flushes.

This is useful on machines with sparse memory.

Tested on ia64 (Bjorn's latest 2.4.21-pre5) and i386 (2.4.21-pre7).  
The patch applies cleanly against both 2.4.21 pre5 and pre7.

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com


diff -X /home/mort/diffex -uNr linux-2.4.21-pre5.pristine/include/asm-generic/tlb.h linux-2.4.21-pre5/include/asm-generic/tlb.h
--- linux-2.4.21-pre5.pristine/include/asm-generic/tlb.h	Fri Aug  2 18:39:45 2002
+++ linux-2.4.21-pre5/include/asm-generic/tlb.h	Wed Apr 16 17:27:31 2003
@@ -43,16 +43,16 @@
 
 	tlb->mm = mm;
 	/* Use fast mode if there is only one user of this mm (this process) */
-	tlb->nr = (atomic_read(&(mm)->mm_users) == 1) ? ~0UL : 0UL;
+	tlb->nr = (atomic_read(&(mm)->mm_users) <= 1) ? ~0UL : 0UL;
 	return tlb;
 }
 
-/* void tlb_remove_page(mmu_gather_t *tlb, pte_t *ptep, unsigned long addr)
+/* void tlb_remove_page(mmu_gather_t *tlb, struct page *page, pte_t *ptep, unsigned long addr)
  *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
  *	handling the additional races in SMP caused by other CPUs caching valid
  *	mappings in their TLBs.
  */
-#define tlb_remove_page(ctxp, pte, addr) do {\
+#define tlb_remove_page(ctxp, page, pte, addr) do {\
 		/* Handle the common case fast, first. */\
 		if ((ctxp)->nr == ~0UL) {\
 			pte_t __pte = *(pte);\
@@ -62,15 +62,19 @@
 		}\
 		if (!(ctxp)->nr) \
 			(ctxp)->start_addr = (addr);\
-		(ctxp)->ptes[(ctxp)->nr++] = ptep_get_and_clear(pte);\
 		(ctxp)->end_addr = (addr) + PAGE_SIZE;\
+		(ctxp)->ptes[(ctxp)->nr] = ptep_get_and_clear(pte);\
+		if ((ctxp)->nr == 0 || (VALID_PAGE(page) && !PageReserved(page))) \
+			(ctxp)->nr++; \
 		if ((ctxp)->nr >= FREE_PTE_NR)\
 			tlb_finish_mmu((ctxp), 0, 0);\
 	} while (0)
 
 /* tlb_finish_mmu
  *	Called at the end of the shootdown operation to free up any resources
- *	that were required.  The page talbe lock is still held at this point.
+ *	that were required.  The page table lock is still held at this point.
+ *	Note that no TLB flushes are needed if there are no users of the mm
+ *	context.
  */
 static inline void tlb_finish_mmu(struct free_pte_ctx *ctx, unsigned long start, unsigned long end)
 {
@@ -78,7 +82,8 @@
 
 	/* Handle the fast case first. */
 	if (ctx->nr == ~0UL) {
-		flush_tlb_range(ctx->mm, start, end);
+		if (ctx->mm->mmap)
+			flush_tlb_range(ctx->mm, start, end);
 		return;
 	}
 	nr = ctx->nr;
@@ -101,7 +106,7 @@
 
 #define tlb_gather_mmu(mm)	(mm)
 #define tlb_finish_mmu(tlb, start, end)	flush_tlb_range(tlb, start, end)
-#define tlb_remove_page(tlb, ptep, addr)	do {\
+#define tlb_remove_page(tlb, page, ptep, addr)	do {\
 		pte_t __pte = *(ptep);\
 		pte_clear(ptep);\
 		__free_pte(__pte);\
diff -X /home/mort/diffex -uNr linux-2.4.21-pre5.pristine/mm/memory.c linux-2.4.21-pre5/mm/memory.c
--- linux-2.4.21-pre5.pristine/mm/memory.c	Sun Mar 30 17:31:31 2003
+++ linux-2.4.21-pre5/mm/memory.c	Wed Apr 16 18:11:18 2003
@@ -318,7 +318,7 @@
 			if (VALID_PAGE(page) && !PageReserved(page))
 				freed ++;
 			/* This will eventually call __free_pte on the pte. */
-			tlb_remove_page(tlb, ptep, address + offset);
+			tlb_remove_page(tlb, page, ptep, address + offset);
 		} else {
 			free_swap_and_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
