Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129564AbRCGOwy>; Wed, 7 Mar 2001 09:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbRCGOwp>; Wed, 7 Mar 2001 09:52:45 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:9223 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129564AbRCGOwc>; Wed, 7 Mar 2001 09:52:32 -0500
Date: Wed, 7 Mar 2001 17:48:00 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support
Message-ID: <20010307174800.A5097@jurassic.park.msu.ru>
In-Reply-To: <20010306202025.A2805@jurassic.park.msu.ru> <200103062057.MAA03915@milano.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103062057.MAA03915@milano.cup.hp.com>; from grundler@cup.hp.com on Tue, Mar 06, 2001 at 12:57:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 12:57:00PM -0800, Grant Grundler wrote:
> My A500 console is a "regular" PCI serial device.
> 
> [ I use quotes because linux sees the device as a 16550.
> But I'm told it's fully emulated in firmware on a special card called
> the "GSP" (Guardian Service Processor). ]

Ok. Maybe this change would make a sense in general case:

-		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
+		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE ||
+				class >> 8 !=  PCI_BASE_CLASS_COMMUNICATION) {
 			pci_read_config_word(dev, PCI_COMMAND, &cmd);
...

> [ re FBB proposal ]
...
Basically I agree. I think you will need to discuss it with Martin, as it
will touch all platforms.

> [ re patch to pdev_sort_resources() ]
> 
> > I'm afraid I don't understand how that could affect hppa. PCI-to-PCI
> > bridge specification allows PCI-PCI bridge to have some device-specific
> > IO, MEM or ROM resources. If any of these are present, we must allocate
> > them properly.
> 
> Agreed. Removing the following "if/continue" statement doesn't
> affect device-specific (aka "built-in") IO/MEM/ROM resources.
> 
> 
> |	if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI &&
> |				i >= PCI_BRIDGE_RESOURCES)
> |		continue;
> 
> This code causes the outer loop to not link the &dev->resource[i] into
> the "sorted list" for the *secondary* bus.
> (ie PCI_BRIDGE_RESOURCES <= i < PCI_NUM_RESOURCES)
> 
> By including the secondary bus "window" resources in the sorted list,
> the resources for the PCI-PCI Bridge window registers are allocated
> too. Thus the change in pbus_assign_resources() to avoid clobbering
> the contents already placed in the sorted list.
> 
> I worked this out before but right now am not 100% certain some
> details haven't escaped me. But I still think I'm on the right track.
> I know it works on an A500. I've reviewed the resulting resource tree
> and am certain it was correct for the configuration I tested.

Well, it seems that I finally see what is wrong with your code, and
why it worked in your case. You assume that "window" resources of
the bridge are already known when we call pbus_assign_resources_sorted().
This is incorrect. Probably you rely on pci_read_bridge_bases() doing
something meaningful (I looked at the parisc pci code in current 2.4.x,
don't know about your CVS tree). Yes, at least some of the DEC bridges
after power-up/reset have 0s in base/limit registers. This means
that you have ranges 0000-0fff (4K) for IO and 00000000-000fffff (1M)
for MEM. Obviously it's enough to hold all resources on the
cards you've tested, but it won't work in common case. There is
a lot of reasons why; just a couple of them:
- according to PPB specification, base/limits registers of the bridge
  after reset are *undefined*, so you'll probably have troubles
  with non-DEC bridges.
- there is a number of alpha systems with a built-in PCI-PCI bridge
  and real PCI slots behind it. Obviously 4K/1M isn't enough for
  these systems, and it was the main reason of rewriting that code.
etc etc etc.
Basically, you won't know bridge "window" size for a given bus until
you'll have allocated *all* devices on *all* its child busses.
Besides, including bridge resources in the "sort lists" is meaningless,
since these resources have fixed alignment - 4K for IO and 1M for MEM,
unlike "regular" ones, which alignment == size.

> [ re arch/alpha code ]
...
> 
> Ok. If it can be removed, I'd be happier since it means I wouldn't
> need similar code in arch/parisc.

Unfortunately I haven't anything with a bridge handy at the moment
to test that patch. Besides, we'll have here a sort of holidays till
Sunday. So maybe next week...

> I don't think existing PCI code is very "dirty".

I hope so. :-)
However, some problems need to be worked out:
1. generic vs. arch code - we've already discussed some of these
2. Prefetchable Memory - do we need to deal with it? Though looking
   at modern x86 systems I tend to keep it disabled :-)
3. pdev_enable_device() - it's a bit ugly, confuses people and
   possibly is not needed at all.

> ps. Ivan - this has been a good exchange since it's forcing me to revisit
>     code I haven't looked at in a few monthes with a fresh perspective.
>     This (and my previous) reply took me about 4 hours to write.
>     I have to keep looking at code. :^)

Same with me - I've started to forget all that stuff...

thank you,

Ivan.
