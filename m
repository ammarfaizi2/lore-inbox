Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbSJEArl>; Fri, 4 Oct 2002 20:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbSJEArl>; Fri, 4 Oct 2002 20:47:41 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:31398 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261840AbSJEArk>; Fri, 4 Oct 2002 20:47:40 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA5926@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'Oleg Nesterov'" <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, "Seth, Rohit" <rohit.seth@intel.com>
Subject: RE: [patch] futex-2.5.40-B5
Date: Fri, 4 Oct 2002 17:53:07 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg, your solution is not generic for mm/memory.c  If any code wants to get
the page_struct mapping the hugetlb page then that code should branch out to
arch specific hugetlb code to get the correct page_struct pointer.  More on
the following lines in arch/..../mm/hugetlbpage.c file:


follow_lightweight_hugetlb_page(mm, start)
                ptep = huge_pte_offset(mm, start);
                pte = *ptep; 
                page = pte_page(pte);
                
                page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
                return page;

> -----Original Message-----
> From: Oleg Nesterov [mailto:oleg@tv-sign.ru] 
> Sent: Friday, October 04, 2002 5:00 PM
> To: linux-kernel@vger.kernel.org
> Cc: Ingo Molnar; Rohit Seth
> Subject: Re: [patch] futex-2.5.40-B5
> 
> 
> Hello.
> 
> Ingo Molnar wrote:
> >   the new lookup code first does a lightweight 
> follow_page(), then if no
> >   page is present we do the get_user_pages() thing.
> 
> What if futex placed in VM_HUGETLB area?
> Then follow_page() return garbage.
> 
> I beleive in i386 case it can be fixed something like this:
> 
> --- mm/memory.c.orig	Sat Oct  5 01:08:54 2002
> +++ mm/memory.c		Sat Oct  5 03:31:28 2002
> @@ -480,6 +480,17 @@ follow_page(struct mm_struct *mm, unsign
>  	if (pmd_none(*pmd) || pmd_bad(*pmd))
>  		goto out;
>  
> +#ifdef	CONFIG_HUGETLB_PAGE
> +	if (pmd_large(pmd)) {
> +		ptep = (pte_t *) pmd;
> +
> +		if (write && !pte_write(*ptep))
> +			return NULL;
> +
> +		return pte_page(*ptep) + ((address & 
> ~HPAGE_MASK) >> PAGE_SHIFT);
> +	}
> +#endif
> +
>  	ptep = pte_offset_map(pmd, address);
>  	if (!ptep)
>  		goto out;
> 
> 
> Then follow_hugetlb_page() hook can be killed.
> 
> Oleg.
> 
