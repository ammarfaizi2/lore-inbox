Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSHHNRl>; Thu, 8 Aug 2002 09:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSHHNRl>; Thu, 8 Aug 2002 09:17:41 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1547 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317567AbSHHNRk>; Thu, 8 Aug 2002 09:17:40 -0400
Date: Thu, 8 Aug 2002 17:21:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Message-ID: <20020808172100.C14158@jurassic.park.msu.ru>
References: <20020807200311.A5566@jurassic.park.msu.ru> <20020808082015.20733@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020808082015.20733@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Thu, Aug 08, 2002 at 10:20:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 10:20:15AM +0200, Benjamin Herrenschmidt wrote:
> Unfortunately that wouldn't work as I actually have 3 host bridges
> on these models, and the windows can be "mixed". One host can have
> 0x80000000 to 0x9ffffffff (and one region at 0xfx000000), The next
> one can have 0xa0000000 to 0xaffffffff and another region at
> 0xfx000000, etc...

Please elaborate. I always thought that 3 host bridges (controllers,
hoses and so on) mean 3 physically separated PCI buses. In this
case the approach with only one root bus structure is plain wrong -
resource allocation won't work correctly.
You should have 3 root buses, and apply suggested workaround to all 3.
Or am I missing something?

> >There are only 3, as Grant pointed out. :-)
> 
> Well, I as pointed out, I may actually need all 4 regions of the host ;)

I still hope you won't :-)

> Anyway, since we agree on copying down the parent regions, and the pci_bus
> stucture holds 4 resource slots, then let's copy them all down.

I think 4th slot makes no sense in terms of the PCI bus and
should be killed. I guess that initially it was intended for cardbus
drivers (for 2nd IO window), but it seems that they don't use
pci_bus->resource pointers at all.

> I'll write some code about that when I'm back from vacation and we'll
> see what's up. I may end up adding a quirk call inside the
> pci_read_bridge_bases
> functions so that it's behaviour can be easily overriden if we ever meet
> a non-strandard enough bridge to be transparent without having ProgIf code 1

This can be easily done with generic quirks:

	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_XXX, PCI_DEVICE_ID_BAD_BRIDGE,
	  quirk_transparent_bridge }
...
static void __init
quirk_transparent_bridge(struct pci_dev *dev)
{
	dev->class |= 1;
}


Ivan.
