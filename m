Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSHGFvX>; Wed, 7 Aug 2002 01:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHGFvX>; Wed, 7 Aug 2002 01:51:23 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:10757 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S317300AbSHGFvV>; Wed, 7 Aug 2002 01:51:21 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>, ink@jurassic.park.msu.ru
Subject: Re: PCI<->PCI bridges, transparent resource fix 
In-Reply-To: Message from Benjamin Herrenschmidt <benh@kernel.crashing.org> 
   of "Tue, 06 Aug 2002 21:20:24 +0200." <20020806192024.23056@192.168.4.1> 
References: <20020806192951.7E6B44829@dsl2.external.hp.com>  <20020806192024.23056@192.168.4.1> 
Date: Tue, 06 Aug 2002 23:54:56 -0600
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20020807055456.61265482A@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
...
> Since the parent resource already contain the necessary informations that
> we represent with ordering (that is the IORESOURCE_IO, IORESOURCE_MEM, ...
> flags), it seems to be that it makes more sense to pick the parent resources
> according to their flags rather than their position.

It does not make more sense.
The three fields are specified by PCI-PCI Bridge Specification.

> Also, when a host bridge has more than one MMIO ranges, which is typically
> the case on pmac, if you have a transparent PCI<->PCI bridge, you really
> want to show that all of these MMIO ranges are exposed to the childs, thus
> you want all of these resource pointers to get down to the bridge.

This is wrong. PCI-PCI bridges can only forward one IO range, one MMIO
range, and one MMIO-Prefetchable range. ("range" == address window).
Any ranges in addition to that means it's not a PCI-PCI bridge.

By explicitly setting resource[1] of the parent to the MMIO range,
arch specific code *knows* which MMIO range the PCI-PCI bridge
will forward.

Are you trying to address the following kind of problem?
	o Host Bridge 00 forwards MMIO 0xf1000000-0xf1100000 and
		MMIO 0xf1800000-0xf1900000.
	o PCI-PCI Bridge 00:01.0 forwards MMIO 0xf1000000-0xf1100000
	o PCI-PCI Bridge 00:02.0 forwards MMIO 0xf1800000-0xf1900000

I'm hoping you'll have real data tomorrow for the problem machine.
But a yes/no/"don't know" answer would be sufficient.

...
> The distinction between mem and prefetchable mem is, I think, irrelevant
> when dealing with transparent bridges.

Sorry - my gut feeling is it matters.  I need something better
than "I think" before I can agree with that statement.
For IO, cacheable vs un-cacheable addresses are worlds apart.

> >Maybe you haven't looked at other arches yet?
> 
> I know archs may call other functions for actually setting up the
> bridges, I actually didn't look at that closely. This is the main
> reason why I post that patch for discussion and not as something
> to be included ;)

ok. When implementing parisc PCI support, I looked alot at alpha,
sparc64, and x86 code to understand how the peices fit together.
parisc introduced some new issues neither of the above had to solve.
Ivan's PCI code changes from 2.5.x took those problems into consideration
and I helped test. Sounds like we need to iterate once the real
problem is clear. You might consider looking at 2.5.30 before
getting too hung up in a fix for 2.4.

...
> Basically, the information that the ordering gives us (basically if
> it's an IO, MEM or prefetchable MEM region) is already present in
> the resource flags structure. Let's use that.

I'm sorry; I've still not understood the problem you are trying to fix
by removing this assumption.

> >From another angle, I could call that a bug. PARISC also gets
> >the IO and MMIO routing information from host firmware.
> 
> Maybe, though I don't remember seeing explicitely that there is a
> requirement for host bridge resources ;)

Lots of things required of the arch support aren't explicitly specified.
Only a handful (or two) people on this planet ever muck with arch PCI
support and no one has felt it was worth writing a HOW-TO.

If you write up an initial draft for linux/Documentation/pci-bios.txt,
I'll review and comment on it.

...
> >It's not necessary but it's simple and easy to understand.
> >I guess I still don't understand why it needs to be fixed.
> 
> I'm having some troubles with the current code, because of the
> host bridge beeing setup with a different layout for one,

This sounds like something you can fix in the arch specific code.

> and
> because the current code mixing transparent and non-transparent
> regions

regions aren't "transparent" - it's the bridge that's transparent.

> when only one of the 2 MMIO regions is configured, causing
> some interesting conflicts to happen when I have several neighbour
> bridges and devices below them.

If different MMIO regions route to different sibling PCI-PCI bridges
(both P-P bridges are children of the same parent), that is a problem
we can't solve in the generic code.
I suspect you'll have to add some cruft to your pcibios_fixup_bus()
to handle this properly.

> I'm afaid I may not have been clear here. There are 2 different
> issues I'm dealing with that patch: One is that I _think_ it
> doesn't make sense to have a "half transparent" bridge (that is
> transparent for MMIO but not prefetch MMIO or the opposite), so
> if one of the 2 regions is set, don't assume we deal with a
> transparent bridge.

pci_read_bridge_bases() handles each resource seperately.
I prefer Ivan's suggestions on dealing with tranparent bridges.


> The other one is that when the bridge is
> assumed transparent, copy down all the resource pointers of the
> parent matching that resource type instead of relying on the
> parent ordering, so if the parent (host) exposes 2 disctint
> MMIO regions, then the transparent bridge will properly expose
> the fact that it's actually forwarding MMIO transactions for those
> 2 regions.

The host can forward as many MMIO regions as it is capable of.
The PCI-PCI bridge can only forward one (of each type).
I'll keep telling you that until you get it.

...
> If a bridge has an MMIO region well
> defined (typically in the case I have to deal with, the normal one)
> and the other "closed" (in my case the prefetch one), should the
> bridge be considered as transparent or should we only forward the
> defined MMIO region ?

Look at setup-bus.c again in 2.4.18. Each type of range is
handled seperately. It should only forward the MMIO region.
If the prefetchable base and limit are not set correctly to indicate
the range is "closed", it's a BIOS/Firmware bug which your arch support
needs to work around.

> If we decide it's fully transparent, we take the risk of having
> the kernel assign resource for childs that won't actually be
> forwarded by the bridge.

yup.

...
> I don't have the offending box at hand right now, I'll find something
> tomorrow. I hope I've been more clear this time anyway ;)

Please do. Getting closer to the core problem at least. ;^)

thanks,
grant
