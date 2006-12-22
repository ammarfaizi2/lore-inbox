Return-Path: <linux-kernel-owner+w=401wt.eu-S1754840AbWLVNb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbWLVNb5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbWLVNb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:31:57 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:65462 "EHLO
	amsfep19-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbWLVNb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:31:56 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1166793952.32117.29.camel@twins>
References: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	 <20061222100004.GC10273@deprecation.cyrius.com>
	 <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>
	 <20061222123249.GG13727@deprecation.cyrius.com>
	 <20061222125920.GA16763@deprecation.cyrius.com>
	 <1166793952.32117.29.camel@twins>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 14:29:54 +0100
Message-Id: <1166794194.32117.34.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A cleanup of try_to_unmap. I have not identified any races that this
would solve, but for consistencies sake.

Also includes a small s390 optimization by moving
page_test_and_clear_dirty() out of the vma iteration.


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

We clear the page in the following sequence:
  ClearPageDirty - lock ptl, clear pte, unlock ptl

hence we should dirty in the opposite order:
  lock ptl, clear pte, unlock ptl - SetPageDirty

try_to_unmap_one violates this by doing the SetPageDirty under the ptl.

Also move page_test_and_clear_dirty() to try_to_unmap().

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/rmap.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -590,8 +590,6 @@ void page_remove_rmap(struct page *page)
 		 * Leaving it set also helps swapoff to reinstate ptes
 		 * faster for those pages still in swapcache.
 		 */
-		if (page_test_and_clear_dirty(page))
-			set_page_dirty(page);
 		__dec_zone_page_state(page,
 				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
 	}
@@ -610,6 +608,7 @@ static int try_to_unmap_one(struct page 
 	pte_t pteval;
 	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
+	struct page *dirty_page = NULL;
 
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -636,7 +635,7 @@ static int try_to_unmap_one(struct page 
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
-		set_page_dirty(page);
+		dirty_page = page;
 
 	/* Update high watermark before we lower rss */
 	update_hiwater_rss(mm);
@@ -687,6 +686,8 @@ static int try_to_unmap_one(struct page 
 
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
+	if (dirty_page)
+		set_page_dirty(dirty_page);
 out:
 	return ret;
 }
@@ -918,6 +919,9 @@ int try_to_unmap(struct page *page, int 
 	else
 		ret = try_to_unmap_file(page, migration);
 
+	if (page_test_and_clear_dirty(page))
+		set_page_dirty(page);
+
 	if (!page_mapped(page))
 		ret = SWAP_SUCCESS;
 	return ret;


