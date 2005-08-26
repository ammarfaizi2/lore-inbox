Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVHZRCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVHZRCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVHZRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:37 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:36501 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965111AbVHZRCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:30 -0400
Subject: [patch 13/18] remap_file_pages protection support: optimize install_file_pte and avoid redundant pte_file PTE's
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:49 +0200
Message-Id: <20050826165349.A817F254625@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

For linear uniform shared VMA's, there is no need to install pte_file PTEs to
remember the offset. For private ones, the same holds for absent and pte_file
PTEs, while existing ones must be left there.

I've also added some warnings on the path which used to cope with such PTE's.
I expect to remove that path soon, and I've never seen that warning triggering
during testing.

If we're going to refuse remap_file_pages() and MAP_POPULATE on private VMA,
this patch may be further simplified.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   14 ++++++++++++--
 linux-2.6.git-paolo/mm/memory.c |    5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff -puN mm/fremap.c~rfp-linear-optim-v4 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-linear-optim-v4	2005-08-25 12:59:23.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-25 12:59:23.000000000 +0200
@@ -129,6 +129,12 @@ int install_file_pte(struct mm_struct *m
 
  	BUG_ON(!uniform && !(vma->vm_flags & VM_SHARED));
 
+	/* We're being called by mmap(MAP_NONBLOCK|MAP_POPULATE) on an uniform
+	 * shared VMA. So don't need to take the lock, and to install a PTE for
+	 * the page we'd fault in anyway. */
+	if (uniform && (vma->vm_flags & VM_SHARED))
+		return 0;
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 	
@@ -150,14 +156,18 @@ int install_file_pte(struct mm_struct *m
 	if (uniform && pte_none(*pte))
 		goto err_unlock;
 
+	err = 0;
 	zap_pte(mm, vma, addr, pte);
 
+	/* I don't want at all to install useless pte_file pte's for private
+	 * mappings. */
+	if (unlikely(uniform))
+		goto err_unlock;
+
 	set_pte_at(mm, addr, pte, pgoff_prot_to_pte(pgoff, pgprot));
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
-	spin_unlock(&mm->page_table_lock);
-	return 0;
 
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
diff -puN mm/memory.c~rfp-linear-optim-v4 mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-linear-optim-v4	2005-08-25 12:59:23.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-25 12:59:23.000000000 +0200
@@ -1983,10 +1983,15 @@ static int do_file_page(struct mm_struct
 	/*
 	 * Fall back to the linear mapping if the fs does not support
 	 * ->populate; in this case do the protection checks.
+	 * Could have been installed by install_file_pte, for a MAP_NONBLOCK
+	 * pagetable population.
 	 */
 	if (!vma->vm_ops->populate ||
 			((access_mask & (VM_WRITE|VM_MAYWRITE)) &&
 			 !(vma->vm_flags & VM_SHARED))) {
+		/* remap_file_pages should disallow this, now that
+		 * install_file_pte skips linear ones. */
+		WARN_ON(1);
 		/* We're behaving as if pte_file was cleared, so check
 		 * protections like in handle_pte_fault. */
 		if (check_perms(vma, access_mask))
_
