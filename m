Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWARPE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWARPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWARPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:04:25 -0500
Received: from mx1.suse.de ([195.135.220.2]:26039 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030336AbWARPEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:04:24 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060117150356.7421.27313.sendpatchset@linux.site>
Subject: [patch] i386: pageattr remove __put_page
Date: Wed, 18 Jan 2006 16:04:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using __put_page and page_count in i386 pageattr.c

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.orig/arch/i386/mm/pageattr.c
+++ linux-2.6/arch/i386/mm/pageattr.c
@@ -51,6 +51,9 @@ static struct page *split_large_page(uns
 	if (!base) 
 		return NULL;
 
+	SetPagePrivate(base);
+	page_private(base) = 0;
+
 	address = __pa(address);
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
@@ -143,11 +146,12 @@ __change_page_attr(struct page *page, pg
 				return -ENOMEM;
 			set_pmd_pte(kpte,address,mk_pte(split, ref_prot));
 			kpte_page = split;
-		}	
-		get_page(kpte_page);
+		}
+		page_private(kpte_page)++;
 	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
 		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
-		__put_page(kpte_page);
+		BUG_ON(page_private(kpte_page) == 0);
+		page_private(kpte_page)--;
 	} else
 		BUG();
 
@@ -157,10 +161,8 @@ __change_page_attr(struct page *page, pg
 	 * replace it with a largepage.
 	 */
 	if (!PageReserved(kpte_page)) {
-		/* memleak and potential failed 2M page regeneration */
-		BUG_ON(!page_count(kpte_page));
-
-		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
+		if (cpu_has_pse && (page_private(kpte_page) == 0)) {
+			ClearPagePrivate(kpte_page);
 			list_add(&kpte_page->lru, &df_list);
 			revert_page(kpte_page, address);
 		}
