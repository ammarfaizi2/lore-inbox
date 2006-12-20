Return-Path: <linux-kernel-owner+w=401wt.eu-S965028AbWLTN5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWLTN5p (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWLTN5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:57:45 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:14768 "EHLO
	amsfep14-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965028AbWLTN5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:57:44 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 14:56:18 +0100
Message-Id: <1166622979.10372.224.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 13:00 +0000, Hugh Dickins wrote:
> On Wed, 20 Dec 2006, Peter Zijlstra wrote:
> > 
> > fix page_mkclean_one()
> 
> Congratulations on getting to the bottom of it, Peter (if you have:
> I haven't digested enough of the thread to tell).

Well, I thought I understood, you just shattered that.

>   I'm mostly offline at
> present, no time for dialogue, I'll throw out a few remarks and run...

I wondered where you were ;-) Enjoy your time away from the computer.

> > 
> > it had several issues:
> >  - it failed to flush the cache
> 
> It's unclear to me why it should need to flush the cache, but I don't
> know much about that, and mprotect does flush the cache in advance -
> I think others will tell you that if it does need to be flushed,

I was still thinking about why exactly, but indeed since mprotect does I
thought it prudent to also do it.

> it must
> be flushed while there's still a valid pte (on some arches at least).

Ah, good point, makes sense I guess.

> >  - it failed to flush the tlb
> 
> Eh?  It flushed the TLB inside ptep_establish, didn't it?
> I guess you mean you've found a race before it flushed the TLB.

Hmm, quite right indeed. I missed that. So moving the flush inside the
pte cleared section closed a race. It seems I must have a long hard look
at these architecture manuals...

> >  - it failed to do s390 (s390 guys, please verify this is now correct)
> 
> Hmm, I thought we cleared it with them back at the time.

/me queries mail folder...
can't seem to find it.

> > 
> > Also, clear in a loop to ensure SMP safeness as suggested by Arjan.
> 
> Yikes.  Well, please compare with mprotect's change_pte_range.  I think
> I took that as the relevant standard when checking your implementation,
> and back then satisfied myself that what you were doing was equivalent.
> If page_mkclean_one is now agreed to be significantly defective, then
> I suspect change_pte_range is also; perhaps others too.

Arjan argued that mprotect and msync would mostly race with themselves
in userspace. 

> (But I haven't found time to do more than skim through the thread,
> I've not thought through the issues at all: I am surprised that it's
> now found defective, we looked at it long and hard back then.)

---

page_mkclean_one() fix

it had several issues:
 - it failed to flush the cache
 - a race wrt tlb flushing
 - it failed to do s390 (s390 guys, please verify this is now correct)

Also, clear in a loop to ensure SMP safeness as suggested by Arjan.

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
 
@@ -444,17 +444,20 @@ static int page_mkclean_one(struct page 
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
+		entry = ptep_get_and_clear(mm, address, pte);
+		flush_tlb_page(vma, address);
+		(void)page_test_and_clear_dirty(page); /* do the s390 thing */
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


