Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSHFX2T>; Tue, 6 Aug 2002 19:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSHFX2T>; Tue, 6 Aug 2002 19:28:19 -0400
Received: from AMarseille-201-1-5-21.abo.wanadoo.fr ([217.128.250.21]:5744
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316574AbSHFX2Q>; Tue, 6 Aug 2002 19:28:16 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>, <ink@jurassic.park.msu.ru>
Subject: Re: PCI<->PCI bridges, transparent resource fix 
Date: Tue, 6 Aug 2002 21:20:24 +0200
Message-Id: <20020806192024.23056@192.168.4.1>
In-Reply-To: <20020806192951.7E6B44829@dsl2.external.hp.com>
References: <20020806192951.7E6B44829@dsl2.external.hp.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Benjamin Herrenschmidt wrote:
>> Closed means the resource isn't configured at all.
>
>ok.
>
>> >It's definitely true for PCI-PCI bridge.
>> >Host bridge support is expected to support this convention as well.
>> 
>> This is not possible in lots of cases
>
>Uhm...why not?
>Arch support can add as many fields as it wants to it's own data structures.
>PCI-PCI bridge support doesn't need to see those, does it?

For PCI<->PCI, sure, but not host bridges. The problem is that function
making asumptions about it's parent resource layout, while this parent may
not be a PCI<->PCI bridges. We have a bunch of cases (embedded, pmac, ...)
where the layout of the host bridge doesn't match the one of a PCI<->PCI
bridge.

Since the parent resource already contain the necessary informations that
we represent with ordering (that is the IORESOURCE_IO, IORESOURCE_MEM, ...
flags), it seems to be that it makes more sense to pick the parent resources
according to their flags rather than their position.

Also, when a host bridge has more than one MMIO ranges, which is typically
the case on pmac, if you have a transparent PCI<->PCI bridge, you really
want to show that all of these MMIO ranges are exposed to the childs, thus
you want all of these resource pointers to get down to the bridge.

What my patch does is just that: don't rely on the parent's ordering, but
rather on the parent resource flags, an when, for a given type of region
(MMIO or IO), the bridge is considered transparent, then copy down _all_
resource pointers for this type of region.

The distinction between mem and prefetchable mem is, I think, irrelevant
when dealing with transparent bridges.


>> >If the host bridge wants to support additional resources, I'm
>> >sure that's possible and does not belong in the generic support.
>> 
>> Well, I see no other place than this function making this assumption,
>> so I'd rather fix the function.
>
>Maybe you haven't looked at other arches yet?

I know archs may call other functions for actually setting up the
bridges, I actually didn't look at that closely. This is the main
reason why I post that patch for discussion and not as something
to be included ;)

>parisc is definitely assumes how resources 0,1,2 are used.
>I'm open to getting rid of that assumption but want to understand why.

Ok, so my answer to the "why" is to not make this assumption into
generic code, to let that code deal properly with the cases where
the parent of the PCI<->PCI bridge doesn't quite match this assumption.

Basically, the information that the ordering gives us (basically if
it's an IO, MEM or prefetchable MEM region) is already present in
the resource flags structure. Let's use that.

>> On OpenFirmware based machines, we
>> setup the host resources as they come in from the firmware. For All of
>> the PPC machines (a bunch of them), this convention is definitely not
>> respected.
>
>From another angle, I could call that a bug. PARISC also gets
>the IO and MMIO routing information from host firmware.

Maybe, though I don't remember seeing explicitely that there is a
requirement for host bridge resources ;)

>> Finally, on Pmacs, I had to deal with hosts exposing 2
>> separate MMIO windows.
>
>You are clearly talking about (CPU) architecture specific code.
>PCI-PCI bridges can only forward 3 ranges.

Again, I'm not arguing about what the PCI<->PCI bridge does here.
I'm concerned about the assumptions made by that code about what
the _parent_ of the PCI<->PCI bridge looks like, ie the host bridge.

>> Honestly, I don't see why we would impose such a convention. It's
>> not necessary and the code can be easily fixed.
>
>It's not necessary but it's simple and easy to understand.
>I guess I still don't understand why it needs to be fixed.

I'm having some troubles with the current code, because of the
host bridge beeing setup with a different layout for one, and
because the current code mixing transparent and non-transparent
regions when only one of the 2 MMIO regions is configured, causing
some interesting conflicts to happen when I have several neighbour
bridges and devices below them.

I'm afaid I may not have been clear here. There are 2 different
issues I'm dealing with that patch: One is that I _think_ it
doesn't make sense to have a "half transparent" bridge (that is
transparent for MMIO but not prefetch MMIO or the opposite), so
if one of the 2 regions is set, don't assume we deal with a
transparent bridge. The other one is that when the bridge is
assumed transparent, copy down all the resource pointers of the
parent matching that resource type instead of relying on the
parent ordering, so if the parent (host) exposes 2 disctint
MMIO regions, then the transparent bridge will properly expose
the fact that it's actually forwarding MMIO transactions for those
2 regions.

>> Currently, that mean we are hard-coding yet another x86 crap in
>> the core kernel code :(
>
>Wrong. It's PCI specific. PCI-PCI Bridge spec spells out how
>the resources look and what's available.

Right, I must have a been a bit nervous when writing the above
sentence, sorry about that =P

>...
>> >The two mem resources (1 & 2) are not equivalent. They are not
>exchangeable.
>> >If BIOS or Host bridge support isn't getting that right, that's a bug.
>> >We need a workaround in the Host bridge support.
>> 
>> That's not what I meant. I know they aren't. But if one of them is
>> closed, it makes no sense to configure the pci<->pci bridge as fully
>> transparent.
>
>By chance, is this comment confusing?
>	/*
>	 * Ugh. We don't know enough about this bridge. Just assume
>	 * that it's entirely transparent.
>	 */
>
>"entirely" just refers to that one range.

Ok. That's a matter of choice. If a bridge has an MMIO region well
defined (typically in the case I have to deal with, the normal one)
and the other "closed" (in my case the prefetch one), should the
bridge be considered as transparent or should we only forward the
defined MMIO region ?

If we decide it's fully transparent, we take the risk of having
the kernel assign resource for childs that won't actually be
forwarded by the bridge.

>Can you show me a messed up resource tree?
>I think I'd understand better what problem you are trying to solve.

I don't have the offending box at hand right now, I'll find something
tomorrow. I hope I've been more clear this time anyway ;)

Regards,
Ben.


