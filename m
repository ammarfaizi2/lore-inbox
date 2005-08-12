Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVHLSyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVHLSyB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVHLSxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:53:51 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:48572 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750937AbVHLSsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:51 -0400
Subject: [patch 39/39] remap_file_pages protection support: wrong "historical" code for review - 2
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:40 +0200
Message-Id: <20050812183641.0ED1124E7F7@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This "fast-path" was contained in the original
remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch from Ingo Molnar; I think this
code is wrong, but I'm sending it for review anyway, because I'm unsure (and
in fact, in the end I found the reason for this).

I guess this code is intended for when we're called by sys_remap_file_page,
without altering pgoffset or protections (otherwise we'd refuse operation on a
private mapping). This cannot happen with mmap(MAP_POPULATE) because we clear
old mappings. And the code makes sense only if we COW'ed a page, because
otherwise the old mapping is already correct. I'm not sure whether we should
fail here - maybe skipping the PTE would be more appropriate. Or we could
anyway turn the nonblock param into a bitmask and pass O_TRUNC there.

However, this is wrong because both routines can be called from within
do_file_page, which is called when !pte_present(pte) && !pte_none(pte) &&
pte_file(pte). I.e.  the pte is not zeroed, so it has been used, but the page
has been swapped out, or the page hasn't been loaded in first place (for
instance for MAP_NONBLOCK).

More accurately, in that situation ->populate is called with nonblock == 0, so
only install_page can be called there. If ->populate fails, the faulting
process will get an inappropriate SIGBUS.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN mm/fremap.c~rfp-wrong mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-wrong	2005-08-12 18:42:23.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-12 18:42:23.000000000 +0200
@@ -90,6 +90,14 @@ int install_page(struct mm_struct *mm, s
 	if (!page->mapping || page->index >= size)
 		goto err_unlock;
 
+	/*
+	 * Only install a new page for a non-shared mapping if it's
+	 * not existent yet:
+	 */
+	err = -EEXIST;
+	if (!pte_none(*pte) && !(vma->vm_flags & VM_SHARED))
+		goto err_unlock;
+
 	zap_pte(mm, vma, addr, pte);
 
 	inc_mm_counter(mm,rss);
@@ -145,6 +153,13 @@ int install_file_pte(struct mm_struct *m
 	pte = pte_alloc_map(mm, pmd, addr);
 	if (!pte)
 		goto err_unlock;
+	/*
+	 * Only install a new page for a non-shared mapping if it's
+	 * not existent yet:
+	 */
+	err = -EEXIST;
+	if (!pte_none(*pte) && !(vma->vm_flags & VM_SHARED))
+		goto err_unlock;
 
 	zap_pte(mm, vma, addr, pte);
 
_
