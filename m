Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSLGKwB>; Sat, 7 Dec 2002 05:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbSLGKuw>; Sat, 7 Dec 2002 05:50:52 -0500
Received: from dp.samba.org ([66.70.73.150]:35977 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262425AbSLGKuo>;
	Sat, 7 Dec 2002 05:50:44 -0500
Date: Sat, 7 Dec 2002 20:45:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021207094530.GB22230@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212060714.XAA06006@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212060714.XAA06006@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:14:16PM -0800, Adam J. Richter wrote:
> David Gibson wrote:
> >On Thu, Dec 05, 2002 at 06:08:22PM -0800, Adam J. Richter wrote:
> [...]
> >> 	In linux-2.5.50/drivers/net/lasi_82596.c, the macros
> >> CHECK_{WBACK,INV,WBACK_INV} have definitions like:
> >> 
> >> #define  CHECK_WBACK(addr,len) \
> >> 	do { if (!dma_consistent) dma_cache_wback((unsigned long)addr,len); } while (0)
> >> 
> >> 	These macros are even used in IO paths like i596_rx().  The
> >> "if()" statement in each of these macros is the extra branch that
> >> disappears on most architectures under James's proposal.
> >
> >Erm... I have no problem with the macros that James's proposal would
> >use to take away this branch - I would expect to use exactly the same
> >ones.  It's just the notion of "try to get consistent memory, but get
> >me any old memory otherwise" that I'm not so convinced by.
> >
> >In any case, on platforms where the dma_malloc() could really return
> >either consistent or non-consistent memory, James's sync macros would
> >have to have an equivalent branch within.
> 
> 	Yeah, I should have said "because then you don't have to have a
> branch for the case where the platform always or *never* returns
> consistent memory on a give machine."

Actually, no, since my idea was to remove the "consistent_alloc()"
path from the driver entirely - leaving only the map/sync approach.
That gives a result which is correct everywhere (afaict) but (as
you've since pointed out) will perform poorly on platforms where the
map/sync operations are expensive.

> >> >What performance advantages of consistent memory?
> 
> >> [...]  For
> >> example, pci_sync_single is 55 lines of C code in
> >> linux-2.5.50/arch/sparc64/kernel/pci_iommu.c.
> >
> >Hmm... fair enough.  Ok, I can see the point of a fall back to
> >non-consistent approach given that.  So I guess the idea makes sense,
> >so long as dma_malloc() (without the consistent flag) is taken to be
> >"give me DMAable memory, consistent or not, whichever is cheaper for
> >this platform" rather than "give me DMAable memory, consistent if
> >possible".  It was originally presented as the latter which misled me.
> 
> 	As long as dma_sync_maybe works with the addresses returned by
> dma_malloc and dma_malloc only returns the types of memory that the
> callers claims to be prepared to deal with, the decision about what
> kind of memory dma_malloc should return when it has a choice is up to
> the platform implementation.
> 
> >I think the change to the parameters which I suggested in a reply to
> >James makes this a bit clearer.
> 
> 	I previously suggested some of the changes in your description:
> name them dma_{malloc,free} (which James basically agrees with), have
> a flags field.  However, given that it's a parameter and you're going
> to pass a constant symbol like DMA_CONSISTENT or DMA_INCONSISTENT to it,
> it doesn't really matter if its an enum or an int to start with, as it
> could be changed later with minimal or zero driver changes.
> 
> 	I like your term DMA_CONSISTENT better than
> DMA_CONFORMANCE_CONSISTANT.  I think the word "conformance" in there
> does not reduce the time that it takes to figure out what the symbol
> means.  I don't think any other facility will want to use the terms
> DMA_{,IN}CONSISTENT, so I prefer that we go with the more medium sized
> symbol.

Actually I think the "conformance" is actively misleading, since (to
me) it implies that the function is always "trying" to get consistent
memory, which it really isn't.

> 	Naming the parameter to dma_malloc "bus" would imply that it
> will not look at individual device information like dma_mask, which is
> wrong.  Putting the flags field in the middle of the parameter list
> will make the dma_malloc and dma_free lists unnnecessarily different.
> I think these two were just oversights in your posting.

Yes indeed.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
