Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVCQJd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVCQJd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCQJd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:33:57 -0500
Received: from ozlabs.org ([203.10.76.45]:65167 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261793AbVCQJdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:33:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.20279.77584.501222@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 20:34:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com, Ian.Pratt@cl.cam.ac.uk,
       kurt@garloff.de, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
	<16952.41973.751326.592933@cargo.ozlabs.ibm.com>
	<200503161406.01788.jbarnes@engr.sgi.com>
	<29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser writes:

> Yes, Xen will break w/o them, because physical addresses are an 
> illusory trick that the guest OS plays on itself to give itself the 
> impression of a contiguous memory map. We use _to_machine and _to_bus 
> macros to get 'real' physical addresses.

This code needs real physical addresses, which are not the same things
as bus addresses.  I thought from what Rik said that virt_to_phys
should give you real physical addresses, while virt_to_pfn would give
you the contiguous "physical" page numbers - is that the case?

> For allocating the GATT itself, using dma_alloc_coherent() as done in 
> my patch certainly seems sane -- the bus base address of that table is 
> poked into a chipset register, right?

Well, a northbridge register.  The northbridge is in a privileged
position in that it controls the memory and can access all of it
directly using physical addresses, something which PCI or other
devices can't.  The address you poke into a register to define the
base of the table is a physical address.  How could it be a bus
address, when the whole point of the table is to translate bus
addresses to physical addresses?  If it was a bus address you would
have to know where the table was before you could work out where the
table was.

> As for poking entries into the GATT, I guess I'm not sure what ought to 
> be used. virt_to_phys() doesn't sound right to me: the GART is a bridge 
> between two buses, so some sort of bus mapping would still be in order 

No, the GART is a bridge between a bus and memory, and the GATT
entries are physical addresses.

> So: I would very much like you to take the patches I made to generic.c 
> that replace __get_free_pages() calls with dma_alloc_coherent(). For 

This is also wrong - the base address of the GATT is a physical
address not a bus address.  This change will break agpgart on ppc64
systems and I won't be able to play bzflag on my G5 any more. :)
dma_alloc_coherent allocates iommu entries and returns a bus address,
but the addresses coming out of the GART don't go through a further
translation through the iommu.

> now, the patch lines that poke into the GATT I guess stay as they are. 
> We can maintain an out-of-tree patch for Xen, or perhaps if 
> virt_to_phys() is not used very much we can override its definition.

It sounds like xen is trying to overload the concepts of physical and
bus addresses to represent the mapping from "logical" addresses seen
by the kernel to "absolute" addresses (the "real" physical
addresses).  IMHO that is a mistake and will only lead to trouble.

Regards,
Paul.
