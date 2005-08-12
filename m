Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVHLSQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVHLSQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVHLSQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:16:43 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:6606 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750845AbVHLSQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:16:33 -0400
Subject: [patch 20/39] remap_file_pages protection support: optimize install_file_pte for MAP_POPULATE
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:23:27 +0200
Message-Id: <20050812182327.05E9B24E0A6@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add an optimization to install_file_pte: if the VMA is uniform, and the PTE
was null, it will be installed correctly if needed at fault time - we avoid
thus touching the page tables, but we must still do the walk...

I'd like to avoid doing the walk altogether, when detecting that the VMA is
uniform.

I'm wondering why should the PTE have a wrong value? It could be a pte_file
PTE installed by a previous MAP_POPULATE or remap_file_pages call with
MAP_NONBLOCK, but that would either have been zapped (if we're handling
MAP_POPULATE) or it would be correct (if called by remap_file_pages, which is
unlikely since we're in a uniform VMA).

The protections must be correct, or we'd detect it by seeing VM_NONUNIFORM,
and the offset too, otherwise we'd see VM_NONLINEAR.

Thus it's just used for MAP_POPULATE|MAP_NONBLOCK.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN mm/fremap.c~rfp-linear-optim-v2 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-linear-optim-v2	2005-08-11 22:46:58.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 22:57:49.000000000 +0200
@@ -121,6 +121,9 @@ int install_file_pte(struct mm_struct *m
 	pud_t *pud;
 	pgd_t *pgd;
 	pte_t pte_val;
+	int uniform = !(vma->vm_flags & (VM_NONUNIFORM | VM_NONLINEAR));
+
+ 	BUG_ON(!uniform && !(vma->vm_flags & VM_SHARED));
 
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
@@ -136,6 +139,12 @@ int install_file_pte(struct mm_struct *m
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
