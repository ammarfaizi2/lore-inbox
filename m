Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSHIG0N>; Fri, 9 Aug 2002 02:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSHIG0N>; Fri, 9 Aug 2002 02:26:13 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:36335 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318162AbSHIG0M>; Fri, 9 Aug 2002 02:26:12 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Date: Fri, 9 Aug 2002 08:29:30 +0200
Message-Id: <20020809062930.32120@smtp.wanadoo.fr>
In-Reply-To: <20020808172100.C14158@jurassic.park.msu.ru>
References: <20020808172100.C14158@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 08, 2002 at 10:20:15AM +0200, Benjamin Herrenschmidt wrote:
>> Unfortunately that wouldn't work as I actually have 3 host bridges
>> on these models, and the windows can be "mixed". One host can have
>> 0x80000000 to 0x9ffffffff (and one region at 0xfx000000), The next
>> one can have 0xa0000000 to 0xaffffffff and another region at
>> 0xfx000000, etc...
>
>Please elaborate. I always thought that 3 host bridges (controllers,
>hoses and so on) mean 3 physically separated PCI buses. In this
>case the approach with only one root bus structure is plain wrong -
>resource allocation won't work correctly.
>You should have 3 root buses, and apply suggested workaround to all 3.
>Or am I missing something?

I do have 3 root busses, that's not a problem. But their resources
are all childs of the global iomem_resources which sorta represents
the system memory bus. (I do eventually declare additional resources
as child of this one, not behind any pci host bridge, like some
memory controller registers).

>> >There are only 3, as Grant pointed out. :-)
>> 
>> Well, I as pointed out, I may actually need all 4 regions of the host ;)
>
>I still hope you won't :-)

Well... at one point, I had more than that :( I added some code to
coalesce the ranges provided by the firmware and figured out it
mostly turned into 1 big range of 256 or 512Mb, one small in the
0xfx000000 region, and one IO. So that should fit. But nothing prevents
the firmware from setting things up differently.
But yes, at least on pmac, I think we now don't have more than 3 in
real life, though I can't speak for IBM high end stations.

We have a routine that takes whatever ranges are provided by openfirmware
and then populates the host bridge resources. This routine can fill up
to 4 slots and doesn't force any ordering on the way those are filled.
This may have to be changed, though currently, I think the case of
pci_read_bridge_bases() with a transparent bridge was the only common
routine we used that relied on this parent resource ordering assumption,
and this will be going away with your proposed patch.

>> Anyway, since we agree on copying down the parent regions, and the pci_bus
>> stucture holds 4 resource slots, then let's copy them all down.
>
>I think 4th slot makes no sense in terms of the PCI bus and
>should be killed. I guess that initially it was intended for cardbus
>drivers (for 2nd IO window), but it seems that they don't use
>pci_bus->resource pointers at all.

They should probably then, but I haven't quite looked at the cardbus
code yet. I still think the resource management should be generic
enough not to rely on ordering & number of resources, as the actual
informations we want out of the parent resources are already encoded
in the flags (that is knowing if we deal with the parent IO window,
MEM window, or MEM+prefetch window). We have generic routines
working only on flags for finding parents when populating the
tree already.

But that isn't an urgent issue nor difficult to work around if
needed, so let's put that on hold until I can prove we really need
all of those ;)

>> I'll write some code about that when I'm back from vacation and we'll
>> see what's up. I may end up adding a quirk call inside the
>> pci_read_bridge_bases
>> functions so that it's behaviour can be easily overriden if we ever meet
>> a non-strandard enough bridge to be transparent without having ProgIf
code 1
>
>This can be easily done with generic quirks:
>
>	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_XXX, PCI_DEVICE_ID_BAD_BRIDGE,
>	  quirk_transparent_bridge }
>...
>static void __init
>quirk_transparent_bridge(struct pci_dev *dev)
>{
>	dev->class |= 1;
>}

Yah, that would make it.

Thanks for your enlightenment
Ben.


