Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSHIQ6N>; Fri, 9 Aug 2002 12:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHIQ6N>; Fri, 9 Aug 2002 12:58:13 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:18957 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315120AbSHIQ6M>; Fri, 9 Aug 2002 12:58:12 -0400
Date: Fri, 9 Aug 2002 21:01:28 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Message-ID: <20020809210128.A17979@jurassic.park.msu.ru>
References: <20020808172100.C14158@jurassic.park.msu.ru> <20020809062930.32120@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020809062930.32120@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Fri, Aug 09, 2002 at 08:29:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 08:29:30AM +0200, Benjamin Herrenschmidt wrote:
> I do have 3 root busses, that's not a problem. But their resources
> are all childs of the global iomem_resources which sorta represents
> the system memory bus.

Child<->parent resource relationship between system and PCI buses
not only isn't required, but might be simply impossible in some situations.
Consider non-linear (or linear, but just not 1:1) mapping between
system and PCI bus addressing. Or even no mapping at all. ;-)
Yes, most architectures use global resources as parents of PCI resources -
just because it happens to work and is convenient. But this doesn't mean
that everybody must do the same.

> Well... at one point, I had more than that :( I added some code to
> coalesce the ranges provided by the firmware and figured out it
> mostly turned into 1 big range of 256 or 512Mb, one small in the
> 0xfx000000 region, and one IO. So that should fit. But nothing prevents
> the firmware from setting things up differently.

Exactly. One day, after firmware update, you may end up asking for
a bit more resource slots. :-)
BTW, do you really need that additional small IOMEM range?

> They should probably then, but I haven't quite looked at the cardbus
> code yet. I still think the resource management should be generic
> enough not to rely on ordering & number of resources, as the actual
> informations we want out of the parent resources are already encoded
> in the flags (that is knowing if we deal with the parent IO window,
> MEM window, or MEM+prefetch window). We have generic routines
> working only on flags for finding parents when populating the
> tree already.

This would add a lot of unneeded complexity to the code in
drivers/pci/setup-bus.c. Also, this would make impossible
configurations like this:
root bus windows	0x80000000-0x8fffffff
			0xf0000000-0xf0ffffff
pci-pci bridge window	0x80200000-0xf02fffff

which is perfectly valid in your setup unless you
place some device resources in the range 0x90000000-0xefffffff.
BTW, you can avoid that range with properly coded pcibios_align_resource() -
maybe this would be cleaner solution than allocating dummy resource.

> But that isn't an urgent issue nor difficult to work around if
> needed, so let's put that on hold until I can prove we really need
> all of those ;)

Ok. But IMO, you're trying to expose your host bridge internals to
the generic code instead of hiding it...

Ivan.
