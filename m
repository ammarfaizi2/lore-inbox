Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281786AbRKVVuS>; Thu, 22 Nov 2001 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281785AbRKVVuG>; Thu, 22 Nov 2001 16:50:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:34570 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281786AbRKVVtq>;
	Thu, 22 Nov 2001 16:49:46 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15357.29418.938012.421837@cargo.ozlabs.ibm.com>
Date: Fri, 23 Nov 2001 08:49:30 +1100 (EST)
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch non-x86] PCI-PCI bridges fix
In-Reply-To: <20011122150418.A623@jurassic.park.msu.ru>
In-Reply-To: <20011122150418.A623@jurassic.park.msu.ru>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky writes:

> Bridge resources weren't added to the resource tree. This was
> harmless for most real-life configurations (especially on Alpha),
> but certainly it will be a problem with the hotplug stuff
> (thinking of ES45).
> 
> Ivan.
> 
> --- 2.4.15p9/drivers/pci/setup-bus.c	Fri Oct  5 05:47:08 2001
> +++ linux/drivers/pci/setup-bus.c	Wed Nov 21 20:16:24 2001
> @@ -201,6 +201,16 @@ pbus_assign_resources(struct pci_bus *bu
>  		b->resource[0]->end = ranges->io_end - 1;
>  		b->resource[1]->end = ranges->mem_end - 1;
>  
> +		/* Add bridge resources to the resource tree. */
> +		if (b->resource[0]->end > b->resource[0]->start &&
> +		    request_resource(bus->resource[0], b->resource[0]) < 0)
> +			printk(KERN_ERR "PCI: failed to reserve IO "
> +					"for bus %d\n",	b->number);

There is code in pci_read_bridge_bases which will decide under some
circumstances that a PCI-PCI bridge is transparent and set

	child->resource[i] = child->parent->resource[i];

for i = 0, 1 or 2.  What will happen with your request_resource in
this case is that the resource will end up being its own parent and
its own child and all allocations against it will fail. :)

I hit this just yesterday on PPC.  On our RS/6000 boxes, if you have a
PCI-PCI bridge with nothing behind it, the firmware will configure it
with all the apertures closed, i.e. with base set larger than limit.
Then pci_read_bridge_bases goes and decides that the bridge is
transparent and consequently everything stops working. :(

Does anyone really need that "assuming transparent" stuff in
pci_read_bridge_bases?  If so we need to add a check for the case
where base == limit + 0x1000 (for I/O) or base == limit + 0x100000
(for memory) and conclude that the aperture is closed in that case.

Paul.
