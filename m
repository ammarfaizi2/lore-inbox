Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUDPDgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 23:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUDPDgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 23:36:07 -0400
Received: from ozlabs.org ([203.10.76.45]:2967 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262119AbUDPDfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 23:35:51 -0400
Date: Fri, 16 Apr 2004 13:32:51 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [0/3]
Message-ID: <20040416033251.GH12735@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
References: <20040416013033.GC12735@zax> <200404160301.i3G31tF13237@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404160301.i3G31tF13237@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 08:01:55PM -0700, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, April 15, 2004 6:31 PM
> > On Thu, Apr 15, 2004 at 10:08:22AM -0700, Chen, Kenneth W wrote:
> > > >>>> David Gibson wrote on Wednesday, April 14, 2004 11:43 PM
> > > > >
> > > > > Some caveats:  I don't have sh and sparc64 hardware to test.  But hugetlb
> > > > > code in these two arch looked like a triplet twin of x86 code.  So I'm
> > > > > pretty sure it will work right out of box.  I've monkeyed around with
> > > > > ppc64 code and after a while I realized it should be left for the experts.
> > > > > I'm sure there are plenty ppc64 developers out there that can get it done
> > > > > in no time.
> > > >
> > > > To the extent that I understand your patches, it shouldn't be that
> > > > hard to adapt for ppc64, with one caveat: on ppc64, unlike the other
> > > > hugepage archs, the format of hugepage PTEs is not identical to the
> > > > format of normal PTEs.  So to do this for ppc64, the generic parts of
> > > > your code will need to use a hugepte_t instead of pte_t - it can be
> > > > typedeffed to pte_t on archs other than ppc64.  Likewise there will
> > > > need to be hugepte_none() and so forth macros.
> > >
> > > I think it would be cleaner if ppc64 change its format instead of changing
> > > 4 other arch to accommodate ppc64.  By the way, why do you need to special
> > > typedef hugepte_t? pte for huge page aren't anything special on all other
> > > arches.
> >
> > The hugepte entries go in the same slots as pmd entries, which means
> > they must be compatible with the layout of pmd entries.  That's not
> > compatible with making them identical to normal PTE entries.  For one
> > thing, normal PTE entries are 64 bits wide, whereas PMD entries are
> > only 32 bits wide.
> 
> It smells like handle_hugetlb_mm_fault() need to be replicated in each arch
> (or at least replicated in ppc64).

No, that shouldn't be necessary.  With a per-arch huge_pte_offset()
(returning a hugepte_t *) and similar arch functions for establishing
and tearing down huge ptes handle_hugetlb_mm_fault() should be able to
be generic.  More significantly, it should still be possible to make
it generic when adding copy-on-write, which makes it less trivial.

To unify even the non-ppc64 archs we already have to allow for the
hugepage pagetables to have different structure across archs - on i386
and ppc64 the hugePTEs lie in PMD slots, on sparc64 and sh they lie in
(normal) PTE slots and on IA64 they lie in the PTE slots of a special
set of pagetables.  Given that, it seems conceptually logical to me
that we also not assume the hugepage PTEs have the same layout as
normal PTEs.  It makes the handle_mm_fault function not the least more
complicated.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
