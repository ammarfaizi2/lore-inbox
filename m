Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVCQJOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVCQJOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCQJOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:14:03 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:18346 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261883AbVCQJN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:13:58 -0500
In-Reply-To: <200503161406.01788.jbarnes@engr.sgi.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com> <200503161406.01788.jbarnes@engr.sgi.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com, Ian.Pratt@cl.cam.ac.uk,
       kurt@garloff.de, Christian.Limpach@cl.cam.ac.uk
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Thu, 17 Mar 2005 09:16:55 +0000
To: Jesse Barnes <jbarnes@engr.sgi.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Mar 2005, at 22:06, Jesse Barnes wrote:

>> The distinction is that physical addresses are what are used to access
>> physical memory, whereas bus addresses are what appears on some
>> external bus (usually PCI).  The GATT sits between an external (AGP)
>> bus and memory, so while the GATT is indexed using bus addresses, its
>> entries contain physical addresses.  So in fact virt_to_phys is the
>> correct thing to use to calculate values to put in GATT entries.
>
> Thanks for the explanation Paul, now the code actually makes sense.
> Converting to the DMA mapping API doesn't make sense at all in this 
> context
> then, since we're basically programming the GATT (an IOMMU type table) 
> with
> physical addresses.  Ken, are you sure you need to make these changes 
> at all?
> Does Xen break w/o them?

Yes, Xen will break w/o them, because physical addresses are an 
illusory trick that the guest OS plays on itself to give itself the 
impression of a contiguous memory map. We use _to_machine and _to_bus 
macros to get 'real' physical addresses.

For allocating the GATT itself, using dma_alloc_coherent() as done in 
my patch certainly seems sane -- the bus base address of that table is 
poked into a chipset register, right?

As for poking entries into the GATT, I guess I'm not sure what ought to 
be used. virt_to_phys() doesn't sound right to me: the GART is a bridge 
between two buses, so some sort of bus mapping would still be in order 
imo. Perhaps Linux should allow mapping requests to be tagged with a 
bridge id, like in *BSD? :-)

So: I would very much like you to take the patches I made to generic.c 
that replace __get_free_pages() calls with dma_alloc_coherent(). For 
now, the patch lines that poke into the GATT I guess stay as they are. 
We can maintain an out-of-tree patch for Xen, or perhaps if 
virt_to_phys() is not used very much we can override its definition.

  -- Keir

