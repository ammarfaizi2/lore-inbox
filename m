Return-Path: <linux-kernel-owner+w=401wt.eu-S1161007AbWLTXFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWLTXFB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWLTXFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:05:01 -0500
Received: from amsfep17-int.chello.nl ([62.179.120.12]:27126 "EHLO
	amsfep17-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161007AbWLTXFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:05:00 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <1166652901.30008.1.camel@twins>
	 <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 00:03:25 +0100
Message-Id: <1166655805.30008.18.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 14:49 -0800, Linus Torvalds wrote:
> 
> On Wed, 20 Dec 2006, Peter Zijlstra wrote:
> >
> > I think this is also needed:
> 
> Yeah, that looks about right. Although I think it should go above the 
> "try_to_release_page()", because right now we do that "ttrp()" with the 
> dirty bit set, and we should let the low-level filesystem just know that 
> it's simply not interesting any more (and, indeed, "try_to_free_buffers()" 
> too, for that matter).

That makes NFS unhappy, see nfs_release_page().

> Anyway, I think that's a detail. I'd rather know whether this all actually 
> makes any difference what-so-ever to the corruption behaviour of Andrei 
> &co. 

Yeah, I have to tinker with my test setup to make it fail again. Maybe I
have to add more seeds, that seemed to make a difference, it was
impossible to trigger with a single seed.

FWIW I also added some scribble past i_size checks in nobh_writepage()
and block_write_full_page().

FWIW2 I straced rtorrent for a bit and it does an aweful lot of mmap
calls and relatively few msync(MS_ASYNC);munmap(), and no truncate apart
from creating sparse files at the beginning.

> Maybe the UP ARM case is some strange dcache alias issue with PIO IDE, and 
> the only reason that started showing up at the same time is the different 
> IO loads. Who knows.
> 
> [ Although I think you may have been on the right track with that dcache 
>   flushing stuff in "page_mkclean()".. It might not have been quite 
>   all there, but I think we should go back and look very closely at 
>   page_mkclean() regardless of any other issues! ]

current version

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/rmap.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

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
+	while (pte_dirty(*pte) || pte_write(*pte)) {
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
+		ptep_establish(vma, address, pte, entry);
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


> So far, my whole "cancel_dirty_page/clean_page_dirty_for_io" patch has 
> really been just a "try to make the code _look_ sane. I don't think we 
> have a single report that the patch actually makes any difference yet.

I failed to compile a kernel with that patch (100% iowait and a bunch of
processes stuck in D state), but sysrq-t was borked (only numbers no
symbols) have yet to retry - I noticed you kicked the unwinder?.

