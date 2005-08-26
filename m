Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVHZRCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVHZRCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVHZRCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:13 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:32405 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965123AbVHZRCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:10 -0400
Subject: [patch 12/18] remap_file_pages protection support: optimize install_file_pte for MAP_POPULATE
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:45 +0200
Message-Id: <20050826165346.577B8254850@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add an optimization to install_file_pte: if the VMA is uniform (and thus we're
likely called by MAP_POPULATE), and the PTE was null, it will be installed
correctly if needed at fault time - we avoid thus touching the page tables,
but we must still do the walk...

The PTE could have a wrong value only if we are in a private VMA, and it was a
broken COW page, either installed or swapped. So, in subsequent patches we
even optimize away the walk.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN mm/fremap.c~rfp-linear-optim-v2 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-linear-optim-v2	2005-08-25 12:50:10.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-25 12:58:29.000000000 +0200
@@ -125,6 +125,9 @@ int install_file_pte(struct mm_struct *m
 	pud_t *pud;
 	pgd_t *pgd;
 	pte_t pte_val;
+	int uniform = !(vma->vm_flags & (VM_NONUNIFORM | VM_NONLINEAR));
+
+ 	BUG_ON(!uniform && !(vma->vm_flags & VM_SHARED));
 
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
@@ -140,6 +143,12 @@ int install_file_pte(struct mm_struct *m
 	pte = pte_alloc_map(mm, pmd, addr);
 	if (!pte)
 		goto err_unlock;
+	/*
+	 * Skip uniform non-existent ptes:
+	 */
+	err = 0;
+	if (uniform && pte_none(*pte))
+		goto err_unlock;
 
 	zap_pte(mm, vma, addr, pte);
 
_
