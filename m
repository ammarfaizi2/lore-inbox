Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSLFCpk>; Thu, 5 Dec 2002 21:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSLFCpk>; Thu, 5 Dec 2002 21:45:40 -0500
Received: from dp.samba.org ([66.70.73.150]:40592 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261398AbSLFCpj>;
	Thu, 5 Dec 2002 21:45:39 -0500
Date: Fri, 6 Dec 2002 13:53:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206025303.GC17829@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, davem@redhat.com,
	James.Bottomley@steeleye.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212060208.SAA05756@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212060208.SAA05756@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 06:08:22PM -0800, Adam J. Richter wrote:
> David Gibson wrote:
> >On Thu, Dec 05, 2002 at 03:57:53AM -0800, Adam J. Richter wrote:
> >> David Gibson wrote:
> >> >Since, with James's approach you'd need a dma sync function (which
> >> >might compile to NOP) in pretty much the same places you'd need
> >> >map/sync calls, I don't see that it does make the source noticeably
> >> >simpler.
> >> 
> >>         Because then you don't have to have a branch for
> >> case where the platform *does* support consistent memory.
> 
> >Sorry, you're going to have to explain where this extra branch is, I
> >don't see it.
> 
> 	In linux-2.5.50/drivers/net/lasi_82596.c, the macros
> CHECK_{WBACK,INV,WBACK_INV} have definitions like:
> 
> #define  CHECK_WBACK(addr,len) \
> 	do { if (!dma_consistent) dma_cache_wback((unsigned long)addr,len); } while (0)
> 
> 	These macros are even used in IO paths like i596_rx().  The
> "if()" statement in each of these macros is the extra branch that
> disappears on most architectures under James's proposal.

Erm... I have no problem with the macros that James's proposal would
use to take away this branch - I would expect to use exactly the same
ones.  It's just the notion of "try to get consistent memory, but get
me any old memory otherwise" that I'm not so convinced by.

In any case, on platforms where the dma_malloc() could really return
either consistent or non-consistent memory, James's sync macros would
have to have an equivalent branch within.

> [...]
> >What performance advantages of consistent memory?  Can you name any
> >non-fully-consistent platform where consistent memory is preferable
> >when it is not strictly required?  For, all the non-consistent
> >platforms I'm aware of getting consistent memory means disabling the
> >cache and therefore is to be avoided wherever it can be.
> 
> 	I believe that the cache synchronization operations for
> nonconsistent memory are often expensive enough so that consistent
> memory is faster on many platforms for small reads and writes, such as
> dealing with control and status fields and hardware DMA lists.  For
> example, pci_sync_single is 55 lines of C code in
> linux-2.5.50/arch/sparc64/kernel/pci_iommu.c.

Hmm... fair enough.  Ok, I can see the point of a fall back to
non-consistent approach given that.  So I guess the idea makes sense,
so long as dma_malloc() (without the consistent flag) is taken to be
"give me DMAable memory, consistent or not, whichever is cheaper for
this platform" rather than "give me DMAable memory, consistent if
possible".  It was originally presented as the latter which misled me.

I think the change to the parameters which I suggested in a reply to
James makes this a bit clearer.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
