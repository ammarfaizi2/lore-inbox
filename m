Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbVJMPth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbVJMPth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 11:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbVJMPth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 11:49:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26243 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751583AbVJMPth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 11:49:37 -0400
Subject: Re: [PATCH 2/3] hugetlb: Demand fault handler
From: Adam Litke <agl@us.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ak@suse.de, hugh@veritas.com
In-Reply-To: <20051012060934.GA14943@localhost.localdomain>
References: <1129055057.22182.8.camel@localhost.localdomain>
	 <1129055559.22182.12.camel@localhost.localdomain>
	 <20051012060934.GA14943@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Thu, 13 Oct 2005 10:49:28 -0500
Message-Id: <1129218568.8797.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review and comments...

On Wed, 2005-10-12 at 16:09 +1000, David Gibson wrote:
> On Tue, Oct 11, 2005 at 01:32:38PM -0500, Adam Litke wrote:
> > Version 5 (Tue, 11 Oct 2005)
> > 	Deal with hugetlbfs file truncation in find_get_huge_page()
> > Version 4 (Mon, 03 Oct 2005)
> > 	Make find_get_huge_page bale properly when add_to_page_cache fails
> > 	  due to OOM conditions
> > Version 3 (Thu, 08 Sep 2005)
> >         Organized logic in hugetlb_pte_fault() by breaking out
> >           find_get_page/alloc_huge_page logic into separate function
> >         Removed a few more paranoid checks  ( Thanks       )
> >         Fixed tlb flushing in a race case   ( Yanmin Zhang )
> > 
> > Version 2 (Wed, 17 Aug 2005)
> >         Removed spurious WARN_ON()
> >     Patches added earlier in the series (now in mainline):
> >         Check for p?d_none() in arch/i386/mm/hugetlbpage.c:huge_pte_offset()
> >         Move i386 stale pte check into huge_pte_alloc()
> 
> I'm not sure this does fully deal with truncation, I'm afraid - it
> will deal with a truncation well before the fault, but not a
> concurrent truncate().  We'll need the truncate_count/retry logic from
> do_no_page, I think.  Andi/Hugh, can you confirm that's correct?

Ok.  I can see why we need that.

> > Initial Post (Fri, 05 Aug 2005)
> > 
> > Below is a patch to implement demand faulting for huge pages.  The main
> > motivation for changing from prefaulting to demand faulting is so that
> > huge page memory areas can be allocated according to NUMA policy.
> > 
> > Thanks to consolidated hugetlb code, switching the behavior requires changing
> > only one fault handler.  The bulk of the patch just moves the logic from 
> > hugelb_prefault() to hugetlb_pte_fault() and find_get_huge_page().
> 
> While we're at it - it's a minor nit, but I find the distinction
> between hugetlb_pte_fault() and hugetlb_fault() confusing.  A better
> name for the former would be hugetlb_no_page(), in which case we
> should probably also move the border between it and
> hugetlb_find_get_page() to match the boundary between do_no_page() and
> mapping->nopage.
> 
> How about this, for example:

Yeah, I suppose that division makes more sense when comparing to the
normal fault handler code.

> @@ -338,57 +337,128 @@
>  	spin_unlock(&mm->page_table_lock);
>  }
>  
> -int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
> +static struct page *hugetlbfs_nopage(struct vm_area_struct *vma,

<snip>

> +	/* Check to make sure the mapping hasn't been truncated */
> +	size = i_size_read(inode) >> HPAGE_SHIFT;
> +	if (pgoff >= size)
> +		return NULL;
> +
> + retry:
> +	page = find_get_page(mapping, pgoff);
> +	if (page)
> +		/* Another thread won the race */
> +		return page;

Both of those returns could be changed to goto out so that the function
has only one exit path.  Isn't that what we want?

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

