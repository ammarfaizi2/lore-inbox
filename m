Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWIYJbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWIYJbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWIYJbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:31:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25058 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750724AbWIYJbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:31:14 -0400
Message-ID: <4517A1D9.2090505@sgi.com>
Date: Mon, 25 Sep 2006 11:31:05 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] do_no_pfn()
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>	<yq0u033c84a.fsf@jaguar.mkp.net> <20060922124940.5ca5ee87.akpm@osdl.org>
In-Reply-To: <20060922124940.5ca5ee87.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> How does this followup look?
> 
> We don't want the rarely-used do_no_pfn() to get inlined in the oft-used
> handle_pte_fault(), using up icache.  Mark it noinline and unlikely.


I'd say it looks good - will give a microscopic slowdown for do_no_pfn
but compared to the overall benefit I think thats more than acceptable.

Acked-by: Jes Sorensen <jes@sgi.com>

Cheers,
Jes

> --- a/mm/memory.c~do_no_pfn-tweaks
> +++ a/mm/memory.c
> @@ -2276,8 +2276,10 @@ oom:
>   *
>   * It is expected that the ->nopfn handler always returns the same pfn
>   * for a given virtual mapping.
> + *
> + * Mark this `noinline' to prevent it from bloating the main pagefault code.
>   */
> -static int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
> +static noinline int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
>  		     unsigned long address, pte_t *page_table, pmd_t *pmd,
>  		     int write_access)
>  {
> @@ -2376,7 +2378,7 @@ static inline int handle_pte_fault(struc
>  					return do_no_page(mm, vma, address,
>  							  pte, pmd,
>  							  write_access);
> -				if (vma->vm_ops->nopfn)
> +				if (unlikely(vma->vm_ops->nopfn))
>  					return do_no_pfn(mm, vma, address, pte,
>  							 pmd, write_access);
>  			}
> _

