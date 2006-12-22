Return-Path: <linux-kernel-owner+w=401wt.eu-S1754837AbWLVNaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbWLVNaA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbWLVNaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:30:00 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:41995 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbWLVN37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:29:59 -0500
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
In-Reply-To: <20061222125920.GA16763@deprecation.cyrius.com>
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
Content-Type: text/plain
Date: Fri, 22 Dec 2006 14:25:52 +0100
Message-Id: <1166793952.32117.29.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 13:59 +0100, Martin Michlmayr wrote:
> * Martin Michlmayr <tbm@cyrius.com> [2006-12-22 13:32]:
> > I've completed one installation with Linus' patch plus the two from
> > Andrew successfully, but I'm currently trying again...
> 
> .... and it failed.

Since you are on ARM you might want to try with the page_mkclean_one
cleanup patch too.

Arjan agreed that the loop is not needed; we clear the pte, flush on all
CPUs and then re-establish the pte. Any race will fault and be
serialised on the pte lock.

FWIW - with todays -git and Andrews second cancel_dirty_page() patch:
  http://lkml.org/lkml/2006/12/22/49
I am unable to trigger any corruption - I could again earlier by raising
the number of seeds from 3 to 6. (am currently at 10 seeds)




From: Peter Zijlstra <a.p.zijlstra@chello.nl>

fix page_mkclean_one()

 - add flush_cache_page() for all those virtual indexed cache
   architectures.

 - handle s390.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/rmap.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -432,7 +432,7 @@ static int page_mkclean_one(struct page 
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *pte, entry;
+	pte_t *pte;
 	spinlock_t *ptl;
 	int ret = 0;
 
@@ -444,17 +444,18 @@ static int page_mkclean_one(struct page 
 	if (!pte)
 		goto out;
 
-	if (!pte_dirty(*pte) && !pte_write(*pte))
-		goto unlock;
+	if (pte_dirty(*pte) || pte_write(*pte)) {
+		pte_t entry;
 
-	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
-	entry = pte_wrprotect(entry);
-	ptep_establish(vma, address, pte, entry);
-	lazy_mmu_prot_update(entry);
-	ret = 1;
+		flush_cache_page(vma, address, pte_pfn(*pte));
+		entry = ptep_clear_flush(vma, address, pte);
+		entry = pte_wrprotect(entry);
+		entry = pte_mkclean(entry);
+		set_pte_at(vma, address, pte, entry);
+		lazy_mmu_prot_update(entry);
+		ret = 1;
+	}
 
-unlock:
 	pte_unmap_unlock(pte, ptl);
 out:
 	return ret;
@@ -489,6 +490,8 @@ int page_mkclean(struct page *page)
 		if (mapping)
 			ret = page_mkclean_file(mapping, page);
 	}
+	if (page_test_and_clear_dirty(page))
+		ret = 1;
 
 	return ret;
 }


 

