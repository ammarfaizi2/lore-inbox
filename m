Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbVCQLva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbVCQLva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVCQLvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:51:01 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:3760 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S263058AbVCQK5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:57:02 -0500
To: Paul Mackerras <paulus@samba.org>
cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com, Ian.Pratt@cl.cam.ac.uk,
       kurt@garloff.de, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: Your message of "Thu, 17 Mar 2005 20:34:47 +1100."
             <16953.20279.77584.501222@cargo.ozlabs.ibm.com> 
Date: Thu, 17 Mar 2005 10:56:45 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DBsgI-0001Cg-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So: I would very much like you to take the patches I made to generic.c 
> > that replace __get_free_pages() calls with dma_alloc_coherent(). For 
> 
> This is also wrong - the base address of the GATT is a physical
> address not a bus address.  This change will break agpgart on ppc64
> systems and I won't be able to play bzflag on my G5 any more. :)
> dma_alloc_coherent allocates iommu entries and returns a bus address,
> but the addresses coming out of the GART don't go through a further
> translation through the iommu.

Okay, thank you for clearing up my confusion over how the GART
actually works. :-) I see you are right: my current patch is indeed
bogus, sorry about that. Unfortunately this means that some other
solution needs to be found for Xen....

> > now, the patch lines that poke into the GATT I guess stay as they are. 
> > We can maintain an out-of-tree patch for Xen, or perhaps if 
> > virt_to_phys() is not used very much we can override its definition.
> 
> It sounds like xen is trying to overload the concepts of physical and
> bus addresses to represent the mapping from "logical" addresses seen
> by the kernel to "absolute" addresses (the "real" physical
> addresses).  IMHO that is a mistake and will only lead to trouble.

Well, actually it has worked well for us so far. Our model of memory
allocation amongst Xen guests is fine-grained (page granularity). The
fact a guest can get random sparse physical pages does not fit well
with Linux's expectation (even with discontig-mem builds) of at least
getting fairly large contiguous physical chunks of RAM.

For this reason, we do rather abuse the notion of 'phys'
addresses. But we get away with it because it really doesn't matter to
the VM system that these addresses bear no relation to reality. In
most cases that it does matter it is because we are programming an I/O
device, in which case we have convenient hook points (bus-address
macros and the DMA-mapping interface). Another slightly tricky one was
block-I/O buffer merging but, again, we found a fairly clean way of
hooking that in an appropriate manner.

Even generic IOMMUs we will be able to handle -- we have control of
the DMA-mapping interface in arch/xen -- so it seems to be the case
that AGPGART is the one significant spanner in the works for us,
because it is an IOMMU in the form of a generic (arch-agnostic)
driver.

So: how about the following solution. It's a bit more distasteful
than I'd like, but I see no alternative apart from us maintaining an
out-of-tree patch to be applied only when building Linux for Xen.
What we need are four hook functions to be defined and used in place
of virt_to_phys, phys_to_virt, __get_free_pages, and
free_pages. Possible names might be:
  To go into asm/io.h:
     virt_to_fsb, fsb_to_virt, alloc_fsb_pages, free_fsb_pages
  Or, to go into asm/agp.h:
     agp_virt_to_phys, agp_phys_to_virt, agp_alloc/free_pages
The former names are an attempt to make the hooks a bit more 'generic'
by defining something applicable wherever you want an address that is
usable directly on the front-side bus. The latter are a bit hackier,
but then, maybe that is appropriate. :-)

I'd be happy to cook up a patch to do this if it isn't too offensive
for anyone.

 -- Keir
