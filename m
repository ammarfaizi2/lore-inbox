Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWARPDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWARPDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWARPDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:03:55 -0500
Received: from ns2.suse.de ([195.135.220.15]:53389 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030335AbWARPDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:03:52 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060117150325.7411.52002.sendpatchset@linux.site>
In-Reply-To: <20060117150307.7411.94174.sendpatchset@linux.site>
References: <20060117150307.7411.94174.sendpatchset@linux.site>
Subject: [patch 2/2] x86_64: pageattr remove __put_page
Date: Wed, 18 Jan 2006 16:03:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove page_count and __put_page from x86-64 pageattr

Signed-off-by: Nick Piggin <npiggin@suse.de>
Acked-by: Andi Kleen <ak@suse.de>

Index: linux-2.6/arch/x86_64/mm/pageattr.c
===================================================================
--- linux-2.6.orig/arch/x86_64/mm/pageattr.c
+++ linux-2.6/arch/x86_64/mm/pageattr.c
@@ -45,6 +45,9 @@ static struct page *split_large_page(uns
 	pte_t *pbase;
 	if (!base) 
 		return NULL;
+	SetPagePrivate(base);
+	page_private(base) = 0;
+
 	address = __pa(address);
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
@@ -137,23 +140,20 @@ __change_page_attr(unsigned long address
 			set_pte(kpte,mk_pte(split, ref_prot2));
 			kpte_page = split;
 		}	
-		get_page(kpte_page);
+		page_private(kpte_page)++;
 	} else if ((kpte_flags & _PAGE_PSE) == 0) { 
 		set_pte(kpte, pfn_pte(pfn, ref_prot));
-		__put_page(kpte_page);
+		BUG_ON(page_private(kpte_page) == 0);
+		page_private(kpte_page)--;
 	} else
 		BUG();
 
 	/* on x86-64 the direct mapping set at boot is not using 4k pages */
  	BUG_ON(PageReserved(kpte_page));
 
-	switch (page_count(kpte_page)) {
- 	case 1:
+	if (page_private(kpte_page) == 0) {
 		save_page(kpte_page);
 		revert_page(address, ref_prot);
-		break;
- 	case 0:
- 		BUG(); /* memleak and failed 2M page regeneration */
  	}
 	return 0;
 } 
@@ -214,6 +214,7 @@ void global_flush_tlb(void)
 
 	flush_map((dpage && !dpage->lru.next) ? (unsigned long)page_address(dpage) : 0);
 	while (dpage) {
+		ClearPagePrivate(dpage);
 		__free_page(dpage);
 		dpage = (struct page *)dpage->lru.next;
 	} 
