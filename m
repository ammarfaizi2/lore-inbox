Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRCCSG5>; Sat, 3 Mar 2001 13:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbRCCSGs>; Sat, 3 Mar 2001 13:06:48 -0500
Received: from palrel3.hp.com ([156.153.255.226]:40716 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129639AbRCCSGh>;
	Sat, 3 Mar 2001 13:06:37 -0500
Message-Id: <200103031805.KAA01024@milano.cup.hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: IO issues vs. multiple busses 
In-Reply-To: Your message of "Sat, 03 Mar 2001 03:45:22 PST."
             <19350125201706.1788@mailhost.mipsys.com> 
Date: Sat, 03 Mar 2001 10:05:17 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
...
> The reason why I'm getting this problem on the public place (again ?)
> is that we are now faced with people who want to put video cards in both
> AGP & PCI busses, those cards requiring accesses to some legacy VGA IOs
> on each of their busses.

I don't see any way of getting around virtualizing the IO port space.
(by that I mean encoding more info in the upper IO port address bits)

...
> Right. That's my opinion too. But it's difficult to make everybody agree
> on it ;) Even the simple mechanism Paul Mackerras did so that IOs to
> non-existent devices don't kill the kernel (very small overhead) caused
> some barking ;)

Well, make it a CONFIG_XXX option for your arch and the people who
insist on doing complicated things will have to live with complicated
solutions. I don't have a better idea.

> It's my understanding that you use high
> bits of the IO address to store the HBA number and then use that to call
> the proper access functions.

Correct. For some reason, I thought alpha (or sparc? hose number?) did this
as well.

> That would solve the PCI IO problem (PCI cards
> requiring IOs to BAR-mapped regions), but I don't see how it can fix the
> problem of a card accessing legacy VGA addresses, except if you hand-fixed
> the video drivers to fill those high bits before doing IOs.

That's right. That happens after the bus walk but before drivers see
the device in pci_fixup_bus().

> If I understand things correctly, that mean that each card, instead of
> accessing the legacy VGA port 0xpp, would instead access 0x00bb00pp
> (or whatever mangling you use to stuff the HBA number).

right.

> The question is then to decide is all ISA busses are on a matching PCI bus,
> in which case a simple unsigned pci_get_bus_io_base(int bus_no) -like functio
>   n
> would be enough, or if we want a scheme that supports other ISA-like busses ?

I don't know enough about your arch to answer that.

> We could eventually decide to support only PCI, and additionally declare a
> fake PCI bus for an ISA bus not matched to a PCI bus, whose config ops would
> return no device in any slot.
> Do we agree on this ? 

In theory yes. But davem already wrote:
| There is no 'fake' ISA bus number you need. There is a 'real' one, 
| the one on which the PCI-->ISA bridge lives, why not use that one 
| :-) 
 

> Well, from the driver point of view, I think it _do_ exist. Basically, the
> driver will do inb/outb & friends. Whatever those function do in reality is
> arch-dependant.

Right. I meant the underlying implementation of inb/outb.

> But we agree on the fact that in order for those functions to know on which
> bus to tap, an additional information must be "cooked" inside the IO address
> passed to them.

yes.

> Additionally, the same problem is true for ISA memory, when it exist
> obviously.

Really? I expected ISA memory to look like reguler uncacheable memory
and the drivers would simply dereference the address. But I'm not an
expert on how ISA busses work...


> With those two simple functions, we could at least

[ deleted list ]

I have to defer to someone like Alan Cox or Davem or someone who has
a clue about VGA. I don't. Like sparc, parisc doesn't support VGA.
Alan is the only person I know of who's even considered plugging a VGA
card into a parisc box.


> The only thing that's annoying me in the fact that we keep tied to PCI
> is that in various embedded system, there is one (or more) ISA-like
> bus hanging around with legacy devices and no PCI, and abstracting a

In short, where the HW doesn't route transactions down the right bus
adapter, the SW has too.

> bit the notion of IO bus would have helped. But it seem that now, more
> embedded systems are also going toward in-CPU IOs anyway, along with
> eventually a PCI bus for the most expensive ones, so it may finally
> not be an issue in the long term.

It sounds like the HW will do (some of?) the routing.

grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
