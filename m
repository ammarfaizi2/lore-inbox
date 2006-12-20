Return-Path: <linux-kernel-owner+w=401wt.eu-S965117AbWLTO4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWLTO4A (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWLTO4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:56:00 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:50257 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964855AbWLTOz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:55:59 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <1166614001.10372.205.camel@twins>
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
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 20 Dec 2006 15:55:40 +0100
Message-Id: <1166626540.4221.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 12:26 +0100, Peter Zijlstra wrote:
> fix page_mkclean_one()
> 
> it had several issues:
>  - it failed to flush the cache
>  - it failed to flush the tlb
>  - it failed to do s390 (s390 guys, please verify this is now correct)

Sorry, page_mkclean is broken for s390. But it has already been broken
before your change. It is only more broken now.

> @@ -440,22 +440,23 @@ static int page_mkclean_one(struct page
>  	if (address == -EFAULT)
>  		goto out;
> 
> -	pte = page_check_address(page, mm, address, &ptl);
> -	if (!pte)
> +	ptep = page_check_address(page, mm, address, &ptl);
> +	if (!ptep)
>  		goto out;
> 
> -	if (!pte_dirty(*pte) && !pte_write(*pte))
> -		goto unlock;
> -
> -	entry = ptep_get_and_clear(mm, address, pte);
> -	entry = pte_mkclean(entry);
> -	entry = pte_wrprotect(entry);
> -	ptep_establish(vma, address, pte, entry);
> -	lazy_mmu_prot_update(entry);
> -	ret = 1;
> +	while (pte_dirty(*ptep) || pte_write(*ptep)) {
> +		pte_t entry = ptep_get_and_clear(mm, address, ptep);
> +		flush_cache_page(vma, address, pte_pfn(entry));
> +		flush_tlb_page(vma, address);
> +		(void)page_test_and_clear_dirty(page); /* do the s390 thing */
> +		entry = pte_wrprotect(entry);
> +		entry = pte_mkclean(entry);
> +		set_pte_at(vma, address, ptep, entry);
> +		lazy_mmu_prot_update(entry);
> +		ret = 1;
> +	}
> 
> -unlock:
> -	pte_unmap_unlock(pte, ptl);
> +	pte_unmap_unlock(ptep, ptl);
>  out:
>  	return ret;
>  }

1) pte_dirty() is always false. The reason is that s390 keeps the dirty
bit information in the storage key and not the pte. If pte_write is
false as well nothing is done. There really should be a 
	if (page_test_and_clear_dirty(page))
		ret = 1;
at the end of page_mkclean.

2) Please use ptep_clear_flush instead of ptep_get_and_clear +
flush_tlb_page. The former uses an optimization on s390 that flushes
just one TLB, the later flushes every TLB of the current mm.

My try to fix this up is attached. It moves the flush_cache_page after
the flush_tlb_page (see asm-generic/pgtable.h for the generic definition
of ptep_clear_flush that is used for i386). I hope this doesn't break
anything else.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

---
 mm/rmap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/mm/rmap.c linux-2.6-mkclean/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-12-20 15:49:01.000000000 +0100
+++ linux-2.6-mkclean/mm/rmap.c	2006-12-20 15:51:14.000000000 +0100
@@ -445,10 +445,8 @@ static int page_mkclean_one(struct page 
 		goto out;
 
 	while (pte_dirty(*ptep) || pte_write(*ptep)) {
-		pte_t entry = ptep_get_and_clear(mm, address, ptep);
+		pte_t entry = ptep_clear_flush(vma, address, ptep);
 		flush_cache_page(vma, address, pte_pfn(entry));
-		flush_tlb_page(vma, address);
-		(void)page_test_and_clear_dirty(page); /* do the s390 thing */
 		entry = pte_wrprotect(entry);
 		entry = pte_mkclean(entry);
 		set_pte_at(vma, address, ptep, entry);
@@ -490,6 +488,8 @@ int page_mkclean(struct page *page)
 		if (mapping)
 			ret = page_mkclean_file(mapping, page);
 	}
+	if (page_test_and_clear_dirty(page))
+		ret = 1;
 
 	return ret;
 }


