Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSHGHb5>; Wed, 7 Aug 2002 03:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHGHb5>; Wed, 7 Aug 2002 03:31:57 -0400
Received: from AMarseille-201-1-5-21.abo.wanadoo.fr ([217.128.250.21]:7536
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314938AbSHGHbz>; Wed, 7 Aug 2002 03:31:55 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Date: Tue, 6 Aug 2002 22:31:34 +0200
Message-Id: <20020806203134.15708@192.168.4.1>
In-Reply-To: <20020807042402.A4840@jurassic.park.msu.ru>
References: <20020807042402.A4840@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Not true. Closed means closed by firmware - in the terms of the
>PCI-PCI bridge, this means that window base > limit. There are _only_
>two reasons for "closed" state:
>1. There is no io or memory behind the bridge, which is perfectly valid.
>   This bridge (and its respective bus) resource must be ignored (flags = 0).
>2. BIOS bug. There _are_ io/mem resources behind the bridge, but any access
>   to these resources will cause machine checks, lockups etc., depends on
>   platform.
>In either case "assuming transparent" is totally wrong if the bridge
>is normal (positive) decoder.
>
>Not configured (i.e. after reset) state for vast majority of bridges
>is base == limit == 0, which means minimal io (4K) or mem (1M)
>window enabled at address 0. Obviously, this is not acceptable for
>most architectures.

Ok, right, I was indeed talking about ranges that have been disabled
by the firmware.

>I'm a bit puzzled. How do these windows look from a) CPU b) PCI bus
>point of view?  And what was a reason for having more than one
>MMIO window per PCI controller?

Well, it's definitely not that specific since I know several host
bridges that have several programmable windows to PCI, and those
aren't PPC specifc. In the case of pmacs, the UniNorth bridge
forwards up to 7 regions of 256Mb (0x80000000..0x8fffffff,
0x90000000..0x9fffffff, etc... up to 0xe0000000..0xefffffff),
each of them beeing selected by a bit setup by the firmware.
It then have additional 16 regions of type 0xfx000000 than can
also be individually selected, some of them beeing reserved for
IO and config space, but one of them beeing typically an additional
memory window to the PCI bus.
>> 
>> You are clearly talking about (CPU) architecture specific code.
>> PCI-PCI bridges can only forward 3 ranges.
>
>Surely.
>
>> > Currently, that mean we are hard-coding yet another x86 crap in
>> > the core kernel code :(
>
>PPC seems to be the only arch with such a weird host bridge
>design, so I'd talk about PPC rather than x86 crap ;-)

Yes, well ... ;) 
>
>> By chance, is this comment confusing?
>> 	/*
>> 	 * Ugh. We don't know enough about this bridge. Just assume
>> 	 * that it's entirely transparent.
>> 	 */
>> 
>> "entirely" just refers to that one range.
>
>The comment is _extremely_ confusing. P2P bridge specs are quite clear:
>the bridge can support the subtractive decoding (i.e. "transparent")
>mode, and the way how to place it in this mode is indeed not
>standardized. But, the subtractive decoding bridge _MUST_ have bit 0
>in the ProgIf set to 1. For some reasons, I don't believe that there are
>any exceptions. And even if they are, we can easily handle them with
>"quirks".

Ok, here we need Linus answert. We did have a patch in the PPC tree
that was consideing closed resources as really closed instead of
transparent, and we were told by Linus that there were non standard
bridges and various issues in the x86 world with that, and that those
would remain transparent. I don't have pointers at hand, but I think
this was dicusssed on lkml several monthes ago.

I would _love_ beeing able to simplify even more my code by assuming
that the resources are closed (what I really need in most of my
cases), or the bridge fully transparent, according to such a bit.

>> Earlier Benjamin wrote:
>> | - The current code for setting up a transparent resource is broken in
>> | a couple of ways. It makes assumptions about the layout of the parent
>> | resources (0 beeing IO, 1 memory, 2 prefetchable memory), while this
>> | is just not true, especially if your parent is the host bridge.
>
>Your parent is not a bridge - it's a pci_bus, and this resource layout
>is pci_bus specific. Note that it's _pointers_ to resources, either to
>standard PCI-PCI bridge resources, or arch specific resources in the case
>of the root bus.
>The "transparency" code is broken by no means though.
>I'm keen to fix that, but at this moment I've ~100K of pending
>alpha patches which are of higher priority for me... :-\

Well, I do have a case of conflict here where a device below a bridge
can't get it's resources allocated because it's considered as conflicting
with the bridge itself. The problem disappear if I set the bridge
as closed (thoough I get another problem where the IO region is not
enabled by the firmware, but that's another matter, I can quirk here).

In most cases, I have to trust the firmware setup as a critical ASIC
(the "mac-io" ASIC) tend to be behind a PCI<->PCI bridge and I cannot
afford to have access to it disabled nor moved at any time.

This is btw a problem with the current kernel code as the PCI probe
code will disable IO/MEM forwarding during probe on the bridge. That
means there is a small window of time during which, if I take an
interrupt for example, I'll be dead because my interrupt controller
(which is part of that "mac-io" ASIC) will be unreachable. But this
is a different issue.

>Basically, I suggest something like this for people trusting their
>firmware setup and therefore using pci_read_bridge_bases():
>1. Check bit 0 of the P2P bridge classcode/progif; if set, assume
>   transparent - set all 3 resource pointers to those of the parent
>   bus; ignore windows settings.

I'd set all 4 then, thus the bridge would really be seen as forwarding
all the regions of the host bridge, whatever they are.

Since pci_read_bridge_bases() is called by the arch code, I can implement
a version doing what you suggest in the arch code and use that. I'll
try and let you know.

>2. If cleared, check base/limit settings of windows 0,1,2. If they seem ok,
>   i.e base != 0 && base < limit, allocate these resources properly in
>   the resource tree.
>3. At the end of arch specific PCI setup, call either
>   pci_assign_unassigned_resources, or more fine-grained helpers from
>   pci/setup_bus.c. These routines will take care of 
>   a) unallocated P2P bridge resources;
>   b) regular resources, unassigned due to resource conflicts and other
>      BIOS bugs.

That makes sense. This would also allow to spot that there is no device
below a PCI<->PCI bridge when doing that assignement of unassigned
resources, and thus to spot that the firmware may have indeed been
right to close them and not to bother.

>The above was one of the purposes of the new 2.5 PCI allocation code,
>although some (relatively small) changes are still needed...

Ok, I'll look into implementing that in the PPC arch code for now

Thanks for your comments,
Ben.


