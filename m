Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUDPDf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 23:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUDPDf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 23:35:57 -0400
Received: from ozlabs.org ([203.10.76.45]:1943 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262109AbUDPDfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 23:35:51 -0400
Date: Fri, 16 Apr 2004 13:27:25 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [2/3]
Message-ID: <20040416032725.GG12735@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, 'Andrew Morton' <akpm@osdl.org>
References: <20040416023442.GF12735@zax> <200404160258.i3G2w8F13087@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404160258.i3G2w8F13087@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 07:58:07PM -0700, Chen, Kenneth W wrote:
> >>>> David Gibson wrote on Thursday, April 15, 2004 7:35 PM
> > > Yes, killing follow_hugetlb_page() is safe because follow_page() takes
> > > care of hugetlb page.  See 2nd patch posted earlier in
> > > hugetlb_demanding_generic.patch
> >
> > Yes, I looked at it already.  But what I'm asking about is applying
> > this patch *without* (or before) going to demand paging.
> >
> > Index: working-2.6/mm/memory.c
> > ===================================================================
> > +++ working-2.6/mm/memory.c	2004-04-16 11:46:31.935870496 +1000
> > @@ -766,16 +766,13 @@
> >  				|| !(flags & vma->vm_flags))
> >  			return i ? : -EFAULT;
> >
> > -		if (is_vm_hugetlb_page(vma)) {
> > -			i = follow_hugetlb_page(mm, vma, pages, vmas,
> > -						&start, &len, i);
> > -			continue;
> > -		}
> >  		spin_lock(&mm->page_table_lock);
> >  		do {
> >  			struct page *map;
> >  			int lookup_write = write;
> >  			while (!(map = follow_page(mm, start, lookup_write))) {
> > +				/* hugepages should always be prefaulted */
> > +				BUG_ON(is_vm_hugetlb_page(vma));
> >  				/*
> >  				 * Shortcut for anonymous pages. We don't want
> >  				 * to force the creation of pages tables for
> >
> > Yes, I looked at it already.  But what I'm asking about is applying
> > this patch *without* (or before) going to demand paging.

Oh, drat.  Looks like I included the old version of the patch again,
not the fixed version without the BUG_ON().  Corrected version
below for real this time.

> In that case, yes, it is not absolutely required. But we do special
> optimization for follow_hugetlb_pages() in the prefaulting implementation,
> at least for ia64 arch. It give a sizable gain on db benchmark.

Ah!  So it's just an optimiziation - it makes a bit more sense to me
now.  I had assumed that this case (hugepage get_user_pages()) would
be sufficiently rare that it would not require optimization.
Apparently not.

Do you know where the cycles are going without this optimization?  In
particular, could it be just the find_vma() in hugepage_vma() called
before follow_huge_addr()?  I note that IA64 is the only arch to have
a non-trivial hugepage_vma()/follow_huge_addr() and that its
follow_huge_addr() doesn't actually use the vma passed in.

So the only significance of the find_vma() is to determine that we're
in an allocated region and that therefore (with prefault) the hugepage
PTEs must be present.  If you actually check for the presence of the
page table entries and the return code of huge_pte_offset() in
follow_huge_addr() (as your 1/3 patch does), then the only thing that
hugepage_vma() need do on ia64 is to check that the address lies in
region 1 (and of course change names and remove the vma parameters,
since they're no longer used).

If we could get rid of follow_hugetlb_pages() it would remove an ugly
function from every arch, which would be nice.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
