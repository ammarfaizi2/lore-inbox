Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUHISVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUHISVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHISU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:20:58 -0400
Received: from fmr04.intel.com ([143.183.121.6]:25045 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266830AbUHISTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:19:49 -0400
Message-Id: <200408091819.i79IJ3Y12216@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: "'Hirokazu Takahashi'" <taka@valinux.co.jp>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Mon, 9 Aug 2004 11:19:04 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcR7+XF2ZTVnVwEMSpOlhuzmrE2wFACOoLFA
In-Reply-To: <20040806210750.GT17188@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Friday, August 06, 2004 2:08 PM
> On Fri, Aug 06, 2004 at 01:55:38PM -0700, Chen, Kenneth W wrote:
> > diff -Nurp linux-2.6.7/mm/hugetlb.c linux-2.6.7.hugetlb/mm/hugetlb.c
> > --- linux-2.6.7/mm/hugetlb.c	2004-08-06 11:44:59.000000000 -0700
> > +++ linux-2.6.7.hugetlb/mm/hugetlb.c	2004-08-06 13:15:24.000000000 -0700
> > @@ -276,9 +276,10 @@ retry:
> >  	}
> >
> >  	spin_lock(&mm->page_table_lock);
> > -	if (pte_none(*pte))
> > +	if (pte_none(*pte)) {
> >  		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
> > -	else
> > +		update_mmu_cache(vma, addr, *pte);
> > +	} else
> >  		put_page(page);
> >  out:
> >  	spin_unlock(&mm->page_table_lock);
>
> update_mmu_cache() does not appear to check the size of the translation
> to be established in many architectures. e.g. on arch/ia64/ it does
> flush_icache_range(addr, addr + PAGE_SIZE) unconditionally, and only
> sets PG_arch_1 on a single struct page. Similar comments apply to
> sparc64 and ppc64; I didn't check any others.

I suppose this is fixable in update_mmu_cache() where it can check the
type of pte and do appropriate sizing and other things.  ia64 would have
to check the address instead of looking at the pte.


