Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318813AbSHGS0t>; Wed, 7 Aug 2002 14:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSHGS0t>; Wed, 7 Aug 2002 14:26:49 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:52488 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S318813AbSHGS0q>; Wed, 7 Aug 2002 14:26:46 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>, ink@jurassic.park.msu.ru
Subject: Re: PCI<->PCI bridges, transparent resource fix 
In-Reply-To: Message from Benjamin Herrenschmidt <benh@kernel.crashing.org> 
   of "Tue, 06 Aug 2002 23:02:20 +0200." <20020806210220.24665@192.168.4.1> 
References: <20020807055456.61265482A@dsl2.external.hp.com>  <20020806210220.24665@192.168.4.1> 
Date: Wed, 07 Aug 2002 12:30:25 -0600
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20020807183025.BCB65482A@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Well, we are talking about transparent (substractive decoding) bridges here
> right ? Those don't care about ranges.

Of course they do. It's just the ranges are inverted.
PCI-PCI bridges do subtractive decoding for the secondary
PCI bus view of the world.

> If my host bridge expose one MMIO range at 0x90000000..0x9fffffff and one
> at 0xf2000000..0xf2ffffff, a transparent bridge below that host bridge will
> actually forward both of these ranges, right ?

It can. But then it probably is forwarding alot of other addresses as well.
I think the HW will be ok as long as two devices (behind different bridges)
don't respond to the same address. If the resource tree reflects what the
HW is doing, ranges should be replicated and we have to trust BIOS
(or other code) to know it shouldn't assign overlapping ranges
to devices.

...
> A typical setup found on mac is indeed to have the bridge forward
> 2 regions, but then, you may have a transparent bridge hanging
> on the bus. I'm not talking about changing the behaviour of a bridge
> that defines it's forwarding MMIO region, I'm talking about
> not copying parent resources blindly for _transparent_ bridges,
> but instead do it based on the flags.

I think I understand the problem now. The resource mgt for
subtractive decoding bridges *asumes* devices below can't use
anything outside the one range assigned to the parent.
But a subtractively decoded bridge could route several ranges
per range type.

...
> As you can see, for both of them, the firmware only enable
> one decoded MMIO region, and closed the IO and the prefetchable MEM
> region. 
> 
> The current code would consider the prefetchable MEM region as
> transparent, which seems plain wrong in this case.

Agreed. 

> Now, Ivan claims we shouldn't do that, but we should look for the
> bit that states if a bridge is fully transparent, use that, and if
> not, keep the window closed at this point and eventually assign new
> ones later one. That would be the best mecanism, I agree, but
> that's also, iirc, what Linus didn't want because of issues with
> non standard bridges.

Look on the x86 laptops. ISTR my Omnibook 800 having such a bridge.
And I think some bridges for dedicated graphics slots are "transparent".

Support for pmac seems to require knowing if a range is closed or
subtractively decoded. I suspect knowing that for x86 would be
better than the voodoo resource assignment that's going on now.

> (I have never seen such a bridge here though
> it may be worth digging in the list archives. I'm about to leave
> for a few days without good internet connexion though, I won't be
> able to do that research before I'm back).

np.

> Well, look what a transparent bridge does at the HW level please.
> How would it matter if the bridge is doing substractive decoding ?

Right. address routing doesn't care about prefetchable attribute.


> But as Ivan implies in his other email, I feel the whole point is
> that the bridge is either fully transparent, not transparent at all.

got it.

> The current way of picking "some" bridge resources as transparent
> when they are actually closed seems wrong. In the case of a fully
> transparent bridge, just copying down pointers to all the 4 parent
> resources would work just fine for me.

Maybe that's the right thing to do.
Send me a patch for 2.4.19 and I'll try it on the laptop.

...
> >If you write up an initial draft for linux/Documentation/pci-bios.txt,
> >I'll review and comment on it.
> 
> Heh, well, i'm afraid I may not have time for that now,

yeah...isn't that a common problem? :^/


> Then, at the end of the function, if that mask indicates all
> resources where closed, then consider the bridge transparent
> and copy all of the parent resources.

That sounds convoluted.

Ivan wrote:
| ...subtractive decoding bridge _MUST_ have bit 0 in the ProgIf set to 1.

It sounds easy to check at the top and in that case DTRT.
The "else" parts of later resource checks can go away.


> I won't get it for a transparent bridge, sorry ;)

sorry - I was still thinking conventional bridges.

> A transparent bridge does substractive decoding. It will forward
> a cycel to _any_ address that have not been claimed by another
> device on the same segment. Thus, it will forward all of the
> regions exposed by the host

That doesn't sound quite right. I suspect subtractive decoding
means one has to blindly forward everything *outside* the range.
In that case, BIOS has to make sure only one device responds to any
address regardless of how many bridges are in the system.

What you suggest implies the bridge waits for someone else to "claim"
the transaction and I'm not convinced PCI spec would allow that.
Performance would certainly suffer if that were the case.

> There are several problems mixed here, what makes it a tad difficult ;)
> 
> One of them is the host having several MMIO regions an a transparent bridge,
> one of them beeing the host not respecting the ordering of a PCI<->PCI
> bridge (thus breaking the current transparent code in some cases), and
> one of them beeing the current code considering bridges with only one of
> the MMIO regions configured as "half transparent".

Well, I've always been told to keep patches as small as possible...maybe
you want to try again with a seperate patch for each?

grant
