Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbSLFHKS>; Fri, 6 Dec 2002 02:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267675AbSLFHKS>; Fri, 6 Dec 2002 02:10:18 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:22691 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267674AbSLFHKQ>; Fri, 6 Dec 2002 02:10:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 23:14:16 -0800
Message-Id: <200212060714.XAA06006@adam.yggdrasil.com>
To: david@gibson.dropbear.id.au
Subject: Re: [RFC] generic device DMA implementation
Cc: James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
>On Thu, Dec 05, 2002 at 06:08:22PM -0800, Adam J. Richter wrote:
[...]
>> 	In linux-2.5.50/drivers/net/lasi_82596.c, the macros
>> CHECK_{WBACK,INV,WBACK_INV} have definitions like:
>> 
>> #define  CHECK_WBACK(addr,len) \
>> 	do { if (!dma_consistent) dma_cache_wback((unsigned long)addr,len); } while (0)
>> 
>> 	These macros are even used in IO paths like i596_rx().  The
>> "if()" statement in each of these macros is the extra branch that
>> disappears on most architectures under James's proposal.
>
>Erm... I have no problem with the macros that James's proposal would
>use to take away this branch - I would expect to use exactly the same
>ones.  It's just the notion of "try to get consistent memory, but get
>me any old memory otherwise" that I'm not so convinced by.
>
>In any case, on platforms where the dma_malloc() could really return
>either consistent or non-consistent memory, James's sync macros would
>have to have an equivalent branch within.

	Yeah, I should have said "because then you don't have to have a
branch for the case where the platform always or *never* returns
consistent memory on a give machine."

>> >What performance advantages of consistent memory?

>> [...]  For
>> example, pci_sync_single is 55 lines of C code in
>> linux-2.5.50/arch/sparc64/kernel/pci_iommu.c.
>
>Hmm... fair enough.  Ok, I can see the point of a fall back to
>non-consistent approach given that.  So I guess the idea makes sense,
>so long as dma_malloc() (without the consistent flag) is taken to be
>"give me DMAable memory, consistent or not, whichever is cheaper for
>this platform" rather than "give me DMAable memory, consistent if
>possible".  It was originally presented as the latter which misled me.

	As long as dma_sync_maybe works with the addresses returned by
dma_malloc and dma_malloc only returns the types of memory that the
callers claims to be prepared to deal with, the decision about what
kind of memory dma_malloc should return when it has a choice is up to
the platform implementation.

>I think the change to the parameters which I suggested in a reply to
>James makes this a bit clearer.

	I previously suggested some of the changes in your description:
name them dma_{malloc,free} (which James basically agrees with), have
a flags field.  However, given that it's a parameter and you're going
to pass a constant symbol like DMA_CONSISTENT or DMA_INCONSISTENT to it,
it doesn't really matter if its an enum or an int to start with, as it
could be changed later with minimal or zero driver changes.

	I like your term DMA_CONSISTENT better than
DMA_CONFORMANCE_CONSISTANT.  I think the word "conformance" in there
does not reduce the time that it takes to figure out what the symbol
means.  I don't think any other facility will want to use the terms
DMA_{,IN}CONSISTENT, so I prefer that we go with the more medium sized
symbol.

	Naming the parameter to dma_malloc "bus" would imply that it
will not look at individual device information like dma_mask, which is
wrong.  Putting the flags field in the middle of the parameter list
will make the dma_malloc and dma_free lists unnnecessarily different.
I think these two were just oversights in your posting.

	Anyhow, I think we're in full agreement at this point on the
substantive stuff at this point.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
