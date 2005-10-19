Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVJSHyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVJSHyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 03:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVJSHyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 03:54:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20516
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1750816AbVJSHyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 03:54:01 -0400
Date: Wed, 19 Oct 2005 09:52:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Olof Johansson <olof@austin.ibm.com>
Subject: [PATCH] .text page fault SMP scalability optimization
Message-ID: <20051019075255.GB30541@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a problem on ppc64 where with more than 4 threads a large system
wouldn't scale well while faulting in the .text (most of the time was
spent in the kernel despite it was an userland compute intensive app).
The reason is the useless overwrite of the same pte from all cpu.

I fixed it this way (verified on an older kernel but the forward port is
almost identical). This will benefit all archs not just ppc64.

Thanks.

From: Andrea Arcangeli <andrea@suse.de>
Subject: make the .text parallel fault from multiple threads scale in smp

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

 memory.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

Index: linux-2.6/mm/memory.c
--- linux-2.6/mm/memory.c.~1~	2005-09-21 17:38:48.000000000 +0200
+++ linux-2.6/mm/memory.c	2005-10-18 14:20:25.000000000 +0200
@@ -2000,7 +2000,7 @@ static inline int handle_pte_fault(struc
 	struct vm_area_struct * vma, unsigned long address,
 	int write_access, pte_t *pte, pmd_t *pmd)
 {
-	pte_t entry;
+	pte_t entry, young_entry;
 
 	entry = *pte;
 	if (!pte_present(entry)) {
@@ -2021,10 +2021,12 @@ static inline int handle_pte_fault(struc
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
 		entry = pte_mkdirty(entry);
 	}
-	entry = pte_mkyoung(entry);
-	ptep_set_access_flags(vma, address, pte, entry, write_access);
-	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
+	young_entry = pte_mkyoung(entry);
+	if (!pte_same(young_entry, entry)) {
+		ptep_set_access_flags(vma, address, pte, young_entry, write_access);
+		update_mmu_cache(vma, address, young_entry);
+		lazy_mmu_prot_update(young_entry);
+	}
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
