Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131251AbRCHBZv>; Wed, 7 Mar 2001 20:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131252AbRCHBZc>; Wed, 7 Mar 2001 20:25:32 -0500
Received: from palrel3.hp.com ([156.153.255.226]:23556 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S131248AbRCHBZR>;
	Wed, 7 Mar 2001 20:25:17 -0500
Message-Id: <200103080128.RAA05607@milano.cup.hp.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support 
In-Reply-To: Your message of "Wed, 07 Mar 2001 17:48:00 PST."
             <20010307174800.A5097@jurassic.park.msu.ru> 
Date: Wed, 07 Mar 2001 17:27:57 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ivan Kokshaysky wrote:
...
> Well, it seems that I finally see what is wrong with your code, and
> why it worked in your case. You assume that "window" resources of
> the bridge are already known when we call pbus_assign_resources_sorted().
> This is incorrect.

Oh...do we know the "sizes" of all child resources from the bus walk?
I'll check that and see if it can be safely changed.

> Probably you rely on pci_read_bridge_bases() doing
> something meaningful (I looked at the parisc pci code in current 2.4.x,
> don't know about your CVS tree).

Nope - don't call that for A500 (machines with PDC PAT)...that might in
fact be another problem later related to some PDC (aka BIOS) changes.

> Yes, at least some of the DEC bridges
> after power-up/reset have 0s in base/limit registers. This means
> that you have ranges 0000-0fff (4K) for IO and 00000000-000fffff (1M)
> for MEM. Obviously it's enough to hold all resources on the
> cards you've tested, but it won't work in common case. There is
> a lot of reasons why; just a couple of them:
> - according to PPB specification, base/limits registers of the bridge
>   after reset are *undefined*, so you'll probably have troubles
>   with non-DEC bridges.
> - there is a number of alpha systems with a built-in PCI-PCI bridge
>   and real PCI slots behind it. Obviously 4K/1M isn't enough for
>   these systems, and it was the main reason of rewriting that code.
> etc etc etc.

Yup - I think you are right on all counts here.
I'll rework the parisc code tonight/tomorrow and see if I can get rid
of the contentious generic PCI changes. I should be able to.

> Basically, you won't know bridge "window" size for a given bus until
> you'll have allocated *all* devices on *all* its child busses.

Linux doesn't. It's possible to deal with window register size in
the initial bus walk (where BAR sizes are determined).

> Besides, including bridge resources in the "sort lists" is meaningless,
> since these resources have fixed alignment - 4K for IO and 1M for MEM,
> unlike "regular" ones, which alignment == size.

The alignment would have to be handled correctly and I thought
pcibios_align_resource() did that. I see now the arch/parisc one doesn't
and others probably don't either. Let me think about this more...


> Unfortunately I haven't anything with a bridge handy at the moment
> to test that patch. Besides, we'll have here a sort of holidays till
> Sunday. So maybe next week...

np. thanks.

> 
> > I don't think existing PCI code is very "dirty".
> 
> I hope so. :-)

:^)

> However, some problems need to be worked out:
> 1. generic vs. arch code - we've already discussed some of these
> 2. Prefetchable Memory - do we need to deal with it? Though looking
>    at modern x86 systems I tend to keep it disabled :-)

Ditto for parisc.

> 3. pdev_enable_device() - it's a bit ugly, confuses people and
>    possibly is not needed at all.

Agreed.

thanks,
grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
