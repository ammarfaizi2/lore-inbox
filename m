Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSHIVL0>; Fri, 9 Aug 2002 17:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSHIVL0>; Fri, 9 Aug 2002 17:11:26 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:32655 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316106AbSHIVLW>; Fri, 9 Aug 2002 17:11:22 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Date: Fri, 9 Aug 2002 23:14:45 +0200
Message-Id: <20020809211445.11929@smtp.wanadoo.fr>
In-Reply-To: <20020809210128.A17979@jurassic.park.msu.ru>
References: <20020809210128.A17979@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Child<->parent resource relationship between system and PCI buses
>not only isn't required, but might be simply impossible in some situations.
>Consider non-linear (or linear, but just not 1:1) mapping between
>system and PCI bus addressing. Or even no mapping at all. ;-)
>Yes, most architectures use global resources as parents of PCI resources -
>just because it happens to work and is convenient. But this doesn't mean
>that everybody must do the same.

Right. Though it's convenient that way on ppc32 ;)

>> Well... at one point, I had more than that :( I added some code to
>> coalesce the ranges provided by the firmware and figured out it
>> mostly turned into 1 big range of 256 or 512Mb, one small in the
>> 0xfx000000 region, and one IO. So that should fit. But nothing prevents
>> the firmware from setting things up differently.
>
>Exactly. One day, after firmware update, you may end up asking for
>a bit more resource slots. :-)

Yup, especially since Apple does the firmware :)

>BTW, do you really need that additional small IOMEM range?

Yup. It's really used by some devices on some machines, and it's nasty
to let the kernel relocate PCI devices when it turns to be Apple's
ASICs. Especially when things get out of sync with the Open Firmware
device tree. So we need to keep the PCI setup as close as possible
as what is set by the firmware, while still having some freedom
for things like bus renumbering or reallocations of some PCI
devices.

>> They should probably then, but I haven't quite looked at the cardbus
>> code yet. I still think the resource management should be generic
>> enough not to rely on ordering & number of resources, as the actual
>> informations we want out of the parent resources are already encoded
>> in the flags (that is knowing if we deal with the parent IO window,
>> MEM window, or MEM+prefetch window). We have generic routines
>> working only on flags for finding parents when populating the
>> tree already.
>
>This would add a lot of unneeded complexity to the code in
>drivers/pci/setup-bus.c. Also, this would make impossible
>configurations like this:
>root bus windows	0x80000000-0x8fffffff
>			0xf0000000-0xf0ffffff
>pci-pci bridge window	0x80200000-0xf02fffff

A bit of complexity on a rarely usesed code path (typically at boot
only most of the time) for more flexibility may be worth the trade ;)

>which is perfectly valid in your setup unless you
>place some device resources in the range 0x90000000-0xefffffff.
>BTW, you can avoid that range with properly coded pcibios_align_resource() -
>maybe this would be cleaner solution than allocating dummy resource.

Yup, nasty case, but does the current code handle it cleanly anyway ?

>> But that isn't an urgent issue nor difficult to work around if
>> needed, so let's put that on hold until I can prove we really need
>> all of those ;)
>
>Ok. But IMO, you're trying to expose your host bridge internals to
>the generic code instead of hiding it...

Maybe. I have a quite non-PCI centric view of it (maybe after dealing
a bit with embedded stuff). I want to represent my physical bus layout
with those, having a coherent tree, crossing a PCI segment or not.
It makes sense to me to expose the resources of the host as they are
really implemented.

Ben.


