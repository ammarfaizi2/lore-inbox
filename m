Return-Path: <linux-kernel-owner+w=401wt.eu-S964997AbWLTLjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWLTLjL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWLTLjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:39:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:29328 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964997AbWLTLjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:39:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bcmsFrN/qFV3YMhOpMFrRN9aIZ9KWmTUpvEH3147ImThJP7vSstRPbPr0d5LyNwh5PkaMZXlNjsvFIHmhk58DNAlh8k5lUf7MXxhKxCtsOfOeqiXN/5gx66W2JiAF8YpKwArXqmcsIeS4zeW91I6pk4l4PGok6ZcPt15iJObQ7k=
Message-ID: <9a8748490612200339x4b50f0e1i3da4313bea85fbc6@mail.gmail.com>
Date: Wed, 20 Dec 2006 12:39:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>, "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Michlmayr" <tbm@cyrius.com>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <1166614001.10372.205.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1166314399.7018.6.camel@localhost>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> fix page_mkclean_one()
>
> it had several issues:
>  - it failed to flush the cache
>  - it failed to flush the tlb
>  - it failed to do s390 (s390 guys, please verify this is now correct)
>
> Also, clear in a loop to ensure SMP safeness as suggested by Arjan.
>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  mm/rmap.c |   29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> Index: linux-2.6/mm/rmap.c
> ===================================================================
> --- linux-2.6.orig/mm/rmap.c
> +++ linux-2.6/mm/rmap.c
> @@ -432,7 +432,7 @@ static int page_mkclean_one(struct page
>  {
>         struct mm_struct *mm = vma->vm_mm;
>         unsigned long address;
> -       pte_t *pte, entry;
> +       pte_t *ptep;
>         spinlock_t *ptl;
>         int ret = 0;
>
> @@ -440,22 +440,23 @@ static int page_mkclean_one(struct page
>         if (address == -EFAULT)
>                 goto out;
>
> -       pte = page_check_address(page, mm, address, &ptl);
> -       if (!pte)
> +       ptep = page_check_address(page, mm, address, &ptl);
> +       if (!ptep)
>                 goto out;
>
> -       if (!pte_dirty(*pte) && !pte_write(*pte))
> -               goto unlock;
> -
> -       entry = ptep_get_and_clear(mm, address, pte);
> -       entry = pte_mkclean(entry);
> -       entry = pte_wrprotect(entry);
> -       ptep_establish(vma, address, pte, entry);
> -       lazy_mmu_prot_update(entry);
> -       ret = 1;
> +       while (pte_dirty(*ptep) || pte_write(*ptep)) {
> +               pte_t entry = ptep_get_and_clear(mm, address, ptep);
> +               flush_cache_page(vma, address, pte_pfn(entry));
> +               flush_tlb_page(vma, address);
> +               (void)page_test_and_clear_dirty(page); /* do the s390 thing */
> +               entry = pte_wrprotect(entry);
> +               entry = pte_mkclean(entry);
> +               set_pte_at(vma, address, ptep, entry);
> +               lazy_mmu_prot_update(entry);
> +               ret = 1;
> +       }
>
Having the assignment of "ret = 1;" inside the loop seems a little
pointless. Perhaps gcc can optimize it, but still, that assignment
really only needs to happen once outside the loop.


> -unlock:
> -       pte_unmap_unlock(pte, ptl);
> +       pte_unmap_unlock(ptep, ptl);
>  out:
>         return ret;
>  }
>

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
