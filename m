Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVHLStO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVHLStO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVHLStN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:13 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:48572 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1751187AbVHLStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:09 -0400
Subject: [patch 23/39] remap_file_pages protection support: fix try_to_unmap_one for VM_NONUNIFORM vma's
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:35:54 +0200
Message-Id: <20050812183554.D8CBD24E0B7@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When unmapping linear but non uniform VMA's in try_to_unmap_one, we must
encode the prots in the PTE.

However, we shouldn't use the generic set_nonlinear_pte() function as it
allows for nonlinear offsets, on which we should instead BUG() in this code
path.

Additionally, add a missing TLB flush in both locations. However, there'is
some excess of flushes in these functions.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/rmap.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN mm/rmap.c~rfp-fix-unmap-linear mm/rmap.c
--- linux-2.6.git/mm/rmap.c~rfp-fix-unmap-linear	2005-08-11 23:07:12.000000000 +0200
+++ linux-2.6.git-paolo/mm/rmap.c	2005-08-11 23:07:12.000000000 +0200
@@ -543,6 +543,10 @@ static int try_to_unmap_one(struct page 
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
 
+	/* If nonlinear, store the file page offset in the pte. */
+	set_nonlinear_pte(pteval, pte, vma, mm, page, address);
+	flush_tlb_page(vma, address);
+
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
@@ -661,6 +665,7 @@ static void try_to_unmap_cluster(unsigne
 
 		/* If nonlinear, store the file page offset in the pte. */
 		set_nonlinear_pte(pteval, pte, vma, mm, page, address);
+		flush_tlb_page(vma, address);
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
_
