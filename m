Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSFNRyM>; Fri, 14 Jun 2002 13:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSFNRyM>; Fri, 14 Jun 2002 13:54:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48304 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S311025AbSFNRyL>;
	Fri, 14 Jun 2002 13:54:11 -0400
Date: Fri, 14 Jun 2002 19:53:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
Message-ID: <20020614195337.A2623@ucw.cz>
In-Reply-To: <m2znxxaibg.fsf@ppro.localdomain> <Pine.LNX.4.44.0206141038020.2576-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 10:47:20AM -0700, Linus Torvalds wrote:
> 
> 
> On 14 Jun 2002, Peter Osterlund wrote:
> >
> > cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
> > Scanning bus 01
> > Found 01:00 [13d1/ab02] 000200 00
> 
> Ok, it found a regular PCI network card (000200) with a regular header
> (00), and it will have read all the resources but not _allocated_ them
> yet.
> 
> > PCI: Calling quirk c01d5650 for 01:00.0
> > Fixups for bus 01
> > PCI: Scanning for ghost devices on bus 1
> > Unknown bridge resource 0: assuming transparent
> > Unknown bridge resource 1: assuming transparent
> > Unknown bridge resource 2: assuming transparent
> > Bus scan for 01 returning with max=01
> > PCI: Device 01:00.0 not available because of resource collisions
> 
> And here it calls it unavailable, because it notices that the device has
> resources, but they haven't been allocated, so it assumes that lack of
> allocation is due to some resource conflict.
> 
> However, it _looks_ like the lack of resource allocation is simply because
> we never bothered to even try to allocate them.
> 
> Pat, your change to use "pci_do_scan_bus()" seems to have dropped the:
> 
>                 /* FIXME: Do we need to enable the expansion ROM? */
>                 for (r = 0; r < 7; r++) {
>                         struct resource *res = dev->resource + r;
>                         if (res->flags)
>                                 pci_assign_resource(dev, r);
>                 }
> 
> thing completely, which is the thing that actually _allocates_ and assigns
> the resources.

Could this be what has bitten us with new Intel IDE controllers on
latest 2.5? They also were disabled due to 'resource collisions', and
had some i/o not allocated at all - just size was nonzero. It was fixed
in the quirks code by clearing the size fields, because the i/o space
isn't needed ...

> Peter, mind adding that resource allocation loop to the "cb_alloc()"
> function, inside the "list_for_each(node,&bus->devices) {" loop? Just
> before the "Does this function have an interrupt at all?" line..
> 
> Alternatively, maybe that resource allocation might just be done in
> "pci_enable_device()". It does kind of make sense at that point, instead
> of just giving up due to unallocated resources..
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
