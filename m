Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVKJBvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVKJBvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVKJBvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:51:22 -0500
Received: from gold.veritas.com ([143.127.12.110]:62003 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751396AbVKJBvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:51:21 -0500
Date: Thu, 10 Nov 2005 01:50:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] mm: remove ppc highpte
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100148410.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:51:21.0307 (UTC) FILETIME=[3FCCCAB0:01C5E599]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc's HIGHPTE config option was removed in 2.5.28, and nobody seems to
have wanted it enough to restore it: so remove its traces from pgtable.h
and pte_alloc_one.  Or supply an alternative patch to config it back?

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/ppc/mm/pgtable.c     |   13 +------------
 include/asm-ppc/pgtable.h |   10 ++++------
 2 files changed, 5 insertions(+), 18 deletions(-)

--- mm05/arch/ppc/mm/pgtable.c	2005-11-07 07:39:08.000000000 +0000
+++ mm06/arch/ppc/mm/pgtable.c	2005-11-09 14:39:02.000000000 +0000
@@ -111,18 +111,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 
 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *ptepage;
-
-#ifdef CONFIG_HIGHPTE
-	gfp_t flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT;
-#else
-	gfp_t flags = GFP_KERNEL | __GFP_REPEAT;
-#endif
-
-	ptepage = alloc_pages(flags, 0);
-	if (ptepage)
-		clear_highpage(ptepage);
-	return ptepage;
+	return alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 }
 
 void pte_free_kernel(pte_t *pte)
--- mm05/include/asm-ppc/pgtable.h	2005-11-07 07:39:55.000000000 +0000
+++ mm06/include/asm-ppc/pgtable.h	2005-11-09 14:39:02.000000000 +0000
@@ -750,13 +750,11 @@ static inline pmd_t * pmd_offset(pgd_t *
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, addr)	\
 	((pte_t *) pmd_page_kernel(*(dir)) + pte_index(addr))
-#define pte_offset_map(dir, addr)		\
-	((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))
-#define pte_offset_map_nested(dir, addr)	\
-	((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE1) + pte_index(addr))
 
-#define pte_unmap(pte)		kunmap_atomic(pte, KM_PTE0)
-#define pte_unmap_nested(pte)	kunmap_atomic(pte, KM_PTE1)
+#define pte_offset_map(dir,addr)	pte_offset_kernel(dir,addr)
+#define pte_offset_map_nested(dir,addr)	pte_offset_kernel(dir,addr)
+#define pte_unmap(pte)			do { } while(0)
+#define pte_unmap_nested(pte)		do { } while(0)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
