Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVHZREm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVHZREm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVHZRCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:38 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:35733 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965124AbVHZRCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:25 -0400
Subject: [patch 16/18] remap_file_pages protection support: avoid truncating COW PTEs
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:54:00 +0200
Message-Id: <20050826165400.AB10A254854@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

This patch may or may not be wanted. I took this from the original Ingo's
patch and improved it, but probably we want to keep this bug. However, I'm not
sure of what Ingo wanted to do.

If on a private writable mapping we call remap_file_pages() without
altering the file offset or the protections, after writing on the page to
create a COW mapping, with this patch we refuse reinstalling the old page, as
we should.

However, I'm not sure there's a point for an app to do this.

It is possible that we return an error even if the present page is already the
same one; however, that shouldn't be a big problem. In fact, the main purpose
of supporting private VMAs in remap_file_pages is allowing mmap(MAP_PRIVATE |
MAP_POPULATE) to work, and for that case existing mappings have already been
cleared and this patch is unneeded.

Note that this patch *needs* testing on each existing arch - I already got
subtle failures on i386 and not on UML on this patch (I had forgot to test
pte_present(), and pte_file() returned true, because _PAGE_DIRTY and
_PAGE_FILE share the same slot).

Setting CONFIG_DEBUG_PRIVATE in the test-program provides a mean to test this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)

diff -puN mm/fremap.c~rfp-notrunc-priv-mappings mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-notrunc-priv-mappings	2005-08-24 20:57:34.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-24 20:57:34.000000000 +0200
@@ -94,6 +94,16 @@ int install_page(struct mm_struct *mm, s
 	if (!page->mapping || page->index >= size)
 		goto err_unlock;
 
+	/*
+	 * On private (and thus uniform) mapping, we don't want to truncate COW
+	 * page, so we can only override pte_none or pte_file PTEs, not swap or
+	 * present ones.
+	 */
+	err = -EEXIST;
+	if (unlikely(!(vma->vm_flags & VM_SHARED)) && (pte_present(*pte) ||
+				(!pte_none(*pte) && !pte_file(*pte))))
+		goto err_unlock;
+
 	zap_pte(mm, vma, addr, pte);
 
 	inc_mm_counter(mm,rss);
@@ -155,6 +165,15 @@ int install_file_pte(struct mm_struct *m
 	err = 0;
 	if (uniform && pte_none(*pte))
 		goto err_unlock;
+	/*
+	 * On private (and thus uniform) mapping, we don't want to truncate COW
+	 * page, so we can only override pte_none or pte_file PTEs, not swap or
+	 * present ones.
+	 */
+	err = -EEXIST;
+	if (unlikely(!(vma->vm_flags & VM_SHARED)) && (pte_present(*pte) ||
+				(!pte_none(*pte) && !pte_file(*pte))))
+		goto err_unlock;
 
 	err = 0;
 	zap_pte(mm, vma, addr, pte);
_
