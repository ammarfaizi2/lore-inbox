Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUDPChA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 22:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDPCgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 22:36:54 -0400
Received: from ozlabs.org ([203.10.76.45]:17813 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261351AbUDPCgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 22:36:42 -0400
Date: Fri, 16 Apr 2004 11:38:18 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [0/3]
Message-ID: <20040416013818.GD12735@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, 'Andrew Morton' <akpm@osdl.org>
References: <7A4826DE8867D411BAB8009027AE9EB91DB42C83@scsmsx401.sc.intel.com> <200404151842.i3FIguF09326@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404151842.i3FIguF09326@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 11:42:55AM -0700, Chen, Kenneth W wrote:
> >>>> Chen, Kenneth W wrote on Thursday, April 15, 2004 10:08 AM
> > >>>> David Gibson wrote on Wednesday, April 14, 2004 11:43 PM
> > > >
> > > > Some caveats:  I don't have sh and sparc64 hardware to test.  But hugetlb
> > > > code in these two arch looked like a triplet twin of x86 code.  So I'm
> > > > pretty sure it will work right out of box.  I've monkeyed around with
> > > > ppc64 code and after a while I realized it should be left for the experts.
> > > > I'm sure there are plenty ppc64 developers out there that can get it done
> > > > in no time.
> > >
> > > To the extent that I understand your patches, it shouldn't be that
> > > hard to adapt for ppc64, with one caveat: on ppc64, unlike the other
> > > hugepage archs, the format of hugepage PTEs is not identical to the
> > > format of normal PTEs.  So to do this for ppc64, the generic parts of
> > > your code will need to use a hugepte_t instead of pte_t - it can be
> > > typedeffed to pte_t on archs other than ppc64.  Likewise there will
> > > need to be hugepte_none() and so forth macros.
> >
> > I think it would be cleaner if ppc64 change its format instead of changing
> > 4 other arch to accommodate ppc64.  By the way, why do you need to special
> > typedef hugepte_t? pte for huge page aren't anything special on all other
> > arches.
> 
> Again, I'm not an expert on ppc64, but this look suspicious to me:
> 
> arch/ppc64/mm/hugetlbpage.c
> /* HugePTE layout:
>  *
>  * 31 30 ... 15 14 13 12 10 9  8  7   6    5    4    3    2    1    0
>  * PFN>>12..... -  -  -  -  -  -  HASH_IX....   2ND  HASH RW   -    HG=1
>  */
> 
> #define HUGEPTE_SHIFT   15
> 
> 17 bits for pfn?  It looks to me that huge page on ppc64 will break on
> system with more than 2 Terabyte of physical memory.

Systems with >2T of physical memory are (as yet) unsupported on
ppc64.  The same limitation applies to normal pages.

Yes, that limit will need to be increased in the near future, and when
it does we will need to change this layout (as well as the overall
structure of the page tables, which is where the limit comes from for
normal pages).  We can get one extra bit trivially, since bit 1 is as
yet unused.  Beyond that we will probably have to make use of the fact
that there are 8 PMD slots for each huge page, and split the PFN
across those slots.  That still won't let us use the same format as
normal PTE entries, because we'll need the huge bit set in each PMD
entry.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
