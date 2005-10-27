Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbVJ0AVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbVJ0AVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbVJ0AVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:21:09 -0400
Received: from ozlabs.org ([203.10.76.45]:23970 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751524AbVJ0AVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:21:06 -0400
Date: Thu, 27 Oct 2005 10:20:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       William Irwin <wli@holomorphy.com>
Subject: Re: RFC: Cleanup / small fixes to hugetlb fault handling
Message-ID: <20051027002051.GB16013@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	William Irwin <wli@holomorphy.com>
References: <20051026020055.GA17191@localhost.localdomain> <20051026024831.GB17191@localhost.localdomain> <1130363177.2689.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130363177.2689.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 04:46:16PM -0500, Adam Litke wrote:
> On Wed, 2005-10-26 at 12:48 +1000, David Gibson wrote:
> > On Wed, Oct 26, 2005 at 12:00:55PM +1000, David Gibson wrote:
> > > Hi, Adam, Bill, Hugh,
> > > 
> > > Does this look like a reasonable patch to send to akpm for -mm.
> > 
> > Ahem.  Or rather this version, which actually compiles.
> > 
> > This patch makes some slight tweaks / cleanups to the fault handling
> > path for huge pages in -mm.  My main motivation is to make it simpler
> > to fit COW in, but along the way it addresses a few minor problems
> > with the existing code:
> > 
> > - The check against i_size was duplicated: once in
> >   find_lock_huge_page() and again in hugetlb_fault() after taking the
> >   page_table_lock.  We only really need the locked one, so remove the
> >   other.
> 
> Fair enough.
> 
> > - find_lock_huge_page() didn't, in fact, lock the page if it newly
> >   allocated one, rather than finding it in the page cache already.  As
> >   far as I can tell this is a bug, so the patch corrects it.
> 
> Thanks.  I was about to post a fix for this too.  It is reproducible in
> the case where two threads race in the fault handler and both do
> alloc_huge_page().  In that case, the loser will fail to insert his page
> into the page cache and will call put_page() which has a
> BUG_ON(page_count(page) == 0).

Hrm.. I don't think this is due to that.  As Ken points out,
add_to_page_cache() does indeed lock the page if it suceeds in
inserting.  And alloc_huge_page() sets the count to 1, not 0, so the
put_page() should not cause a problem on the failure path.

Hrm.. wonder what's going on here.

> > - find_lock_huge_page() isn't a great name, since it does extra things
> >   not analagous to find_lock_page().  Rename it
> >   find_or_alloc_huge_page() which is closer to the mark.
> 
> I'll agree with the above.  I am not all that committed to the current
> layout and what you have here is a little closer to the thinking in my
> original patch ;)
> 
> <snip>
> 
> > +int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> > +		  unsigned long address, int write_access)
> > +{
> > +	pte_t *ptep;
> > +	pte_t entry;
> > +
> > +	ptep = huge_pte_alloc(mm, address);
> > +	if (! ptep)
> > +		/* OOM */
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	entry = *ptep;
> > +
> > +	if (pte_none(entry))
> > +		return hugetlb_no_page(mm, vma, address, ptep);
> > +
> > +	/* we could get here if another thread instantiated the pte
> > +	 * before the test above */
> > +
> > +	return VM_FAULT_SIGBUS;
> >  }
> 
> I'll agree with Ken that the last return should probably still be
> VM_FAULT_MINOR.
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
