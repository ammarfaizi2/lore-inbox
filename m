Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTELREm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTELREm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:04:42 -0400
Received: from galileo.bork.org ([66.11.174.148]:49426 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262319AbTELREj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:04:39 -0400
Date: Mon, 12 May 2003 13:17:22 -0400
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Cc: wildos@sgi.com
Subject: [PATCH] Don't add empty PTE's to mmu_gathers
Message-ID: <20030512171722.GT11947@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here's a patch to make it so empty PTEs are not added to mmu_gathers.
This is useful on machines with sparse memory.  This has been tested on
ia64 and x86.  Patch is against 2.4.21-bk.

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1209  -> 1.1210 
#	include/asm-generic/tlb.h	1.2     -> 1.3    
#	         mm/memory.c	1.54    -> 1.55   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	mort@plato.i.bork.org	1.1210
# Update the mmu_gathers code to avoid adding empty PTEs to mmu_gathers.
# --------------------------------------------
#
diff -Nru a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
--- a/include/asm-generic/tlb.h	Mon May 12 13:14:23 2003
+++ b/include/asm-generic/tlb.h	Mon May 12 13:14:23 2003
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
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Mon May 12 13:14:23 2003
+++ b/mm/memory.c	Mon May 12 13:14:23 2003
@@ -318,7 +318,7 @@
 			if (VALID_PAGE(page) && !PageReserved(page))
 				freed ++;
 			/* This will eventually call __free_pte on the pte. */
-			tlb_remove_page(tlb, ptep, address + offset);
+			tlb_remove_page(tlb, page, ptep, address + offset);
 		} else {
 			free_swap_and_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
