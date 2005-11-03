Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVKCOM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVKCOM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVKCOM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:12:57 -0500
Received: from silver.veritas.com ([143.127.12.111]:22360 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751024AbVKCOM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:12:57 -0500
Date: Thu, 3 Nov 2005 14:11:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gleb Natapov <gleb@minantech.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051103081213.GC22185@minantech.com>
Message-ID: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
 <4368139A.30701@vc.cvut.cz> <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
 <1130965454.20136.50.camel@gaston> <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
 <1130967936.20136.65.camel@gaston> <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
 <20051103081213.GC22185@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Nov 2005 14:12:52.0387 (UTC) FILETIME=[ADA89730:01C5E080]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Gleb Natapov wrote:
> On Wed, Nov 02, 2005 at 10:02:49PM +0000, Hugh Dickins wrote:
> > On Thu, 3 Nov 2005, Benjamin Herrenschmidt wrote:
> > > On Wed, 2005-11-02 at 21:41 +0000, Hugh Dickins wrote:
> > > 
> > > > The only extant problem here is if the pages are private, and you
> > > > fork while this is going on, and the parent user process writes to the
> > > > area before completion: then COW leaves the child with the page being
> > > > DMAed into, giving the parent a copied page which may be incomplete.
> > > 
> > > Won't happen, and if it does, it's a user error to rely on that working,
> > > so it doesn't matter.
> > 
> > I wish everyone else would see it that way!  (But some people do
> > have valid scenarios where it can't just be ruled out completely.)
> > 
> I am one of those people :)
> 
> Last discussion about this issue ended without resolution, but I remember
> you mentioned the possibility to leave ptes writable in parent during fork 
> for private pages mapped for DMA. Is this approach acceptable?

I was toying with that idea back then, but it leaves the pages in a
peculiar limbo between being shared and private, such that it's hard
to think through the consequences.  We do already have a case rather
like that (ptrace writing to a write-protected area), but some of us
are a bit worried by that one, so I'd be foolish now to recommend
another such subversion of the rules.

In the time since we discussed before, I've rather come full circle
round to my original position: abandoning such ideas of trying to
handle it from get_user_pages itself, appreciating the simplicity
of the original PROT_DONTCOPY idea from you guys; but sticking to my
initial reaction that this is better done by madvise(MADV_DONTCOPY),
not by the mmap/mprotect route in Michael's patch.  (I never bought
the "racy" argument advanced in favour of the mmap flag.)

One of the factors which has swayed me to the DONTCOPY approach, is
Nick's 2.6.14 optimization in fork's copy_page_range, where areas
which can be safely faulted later are not copied pte by pte.  But
that doesn't apply to all areas, and in particular cannot apply to
VM_NONLINEAR shared areas.  It should be of benefit to apps which
use large such areas, and also do a lot of forking children who don't
need those areas, to be able to mark them VM_DONTCOPY.  Or any other
vmas the children won't need.  (But there's one big distinction between
the optimization and VM_DONTCOPY: the optimization copies vma but
doesn't fill in its ptes, VM_DONTCOPY doesn't even copy the vma.)

Two warnings if someone would like to post a MADV_DONTCOPY patch.
It should include a matching MADV_DOCOPY to clear the condition, but
that must not be allowed to clear VM_DONTCOPY set originally by driver:
perhaps you'll end up with a VM_UDONTCOPY or something like that.

And Badari has a MADV_REMOVE patch in the works, taking the next
slot (just after MADV_DONTNEED in most of the arches): probably
best for you to base yours on top of his (though yours is simpler
and might jump ahead).

Hugh
