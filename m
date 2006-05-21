Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWEUMQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWEUMQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWEUMQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:16:15 -0400
Received: from [194.90.237.34] ([194.90.237.34]:44239 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751535AbWEUMQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:16:15 -0400
Date: Sun, 21 May 2006 15:17:26 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Brice Goglin <brice@myri.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060521121726.GQ30211@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447047F2.2070607@myri.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 21 May 2006 12:20:12.0281 (UTC) FILETIME=[E8868690:01C67CD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Brice Goglin <brice@myri.com>:
> Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
> 
> Michael S. Tsirkin wrote:
> > Quoting r. Greg KH <gregkh@suse.de>:
> >> Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
> >>
> >> On Mon, May 15, 2006 at 11:11:33PM +0200, Brice Goglin wrote:
> >>> Hi Greg,
> >>>
> >>> While looking at the MSI detection, I noticed that the AMD 8131 quirk
> >>> (quirk_amd_8131_ioapic) is defined as FINAL and thus executed after the
> >>> PCI hierarchy is scanned. So it looks like the bus_flags won't be
> >>> inherited at all. If there's a bridge behind the 8131, then the devices
> >>> behind this bridge won't see the bus flags and thus might try to enable
> >>> MSI anyway.
> >>> I tried to change the AMD 8131 quirk to HEADER so that it is executed
> >>> during PCI scanning. But, I don't get its message in dmesg anymore. Any
> >>> idea?
> >> Michael is the one who added that change, perhaps he can explain how he
> >> tested it?
> >
> > Well, I just re-tested with 2.6.17-rc4 and it does not seem to work.  No idea
> > what did I do wrong when testing this patch before posting it :(. Oops.
> > I'm sorry.
> >
> > Given that its late in -rc series, that its a clear regression from 2.6.16, that
> > disabling MSI is always safe, and that the patch was intended to enable MSI on
> > Tyan motherboard which Roland used to have but doesn't anymore and which no one
> > else seems to be bothered to test on either - it seems the best thing is to just
> > revert the patch, and go back to using a global flag for now.
> 
> I would say that it works for devices that are directly behind the
> amd8131. But it won't disable MSI for devices that are behind another
> bridge behind the 8131. It is great for us since we have lots of Tyan
> motherboards without any device behind the 8131 :)

MSI is an optional feature so things are supposed to work even without MSI - are
you getting that great a benefit from MSI?

> I don't know how many
> machines have a bridge behind a 8131, this bug might not hit a lot of
> people.

All mellanox PCI-X devices have a bridge inside them, so ...

> At least, with 2.6.17-rc, we can get MSI on devices that have nothing to
> do with the 8131. I consider this a very good progress. Yes, we try to
> enable MSI on devices behing a bridge behind the 8131. But, if few
> people have such a PCI hierarchy, I am not sure this regression is
> important. What happens if you actually enable MSI there ? It fails ? Or
> it crashes ?

It fails to generate interrupts.

> Is it worth than having no MSI at all on any devices on the
> machine ?

I think it is.

> Anyway, we are working on merging our MSI detection code based on HT
> capabilities. And we think we might have to add a couple other quirks
> where it will be very important there that the bus flags are inherited.
> So I tried to dig more in what we could do to inherit flags properly and
> here's what I found:
> 
> The amd8131 MSI quirk cannot be EARLY or HEADER because it would be
> called before dev->subordinate has been set. So PCI_BUS_FLAGS_NO_MSI
> could not be set in the bus flags at this time.
> So we need a quirk that is called while the PCI hierarchy is scanned
> (ie, before FINAL or ENABLE) and after the pci child bus of the bridge
> is created (ie, after EARLY and HEADER).
> 
> The attached patch adds a new type of fixup that is called right after
> the child bus is created (ie, when dev->subordinate exists). And the
> patch moves the amd8131 MSI quirk to use this new quirk type.
> I chose the name "bridge header" but I guess somebody will come with a
> better name (I am not really familiar with all the PCI terminology).
> 
> Signed-off-by: Brice Goglin <brice@myri.com>
> 
> Brice

Doesn't seem to work for me:

ib_mthca: Initializing 0000:04:00.0
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 29 (level, low) -> IRQ 185
ib_mthca 0000:04:00.0: NOP command failed to generate interrupt (IRQ 217),
aborting.
ib_mthca 0000:04:00.0: Try again with MSI/MSI-X disabled.
ACPI: PCI interrupt for device 0000:04:00.0 disabled
ib_mthca: probe of 0000:04:00.0 failed with error -16

-- 
MST
