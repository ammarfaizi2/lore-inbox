Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319684AbSH2Xtg>; Thu, 29 Aug 2002 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319686AbSH2Xtg>; Thu, 29 Aug 2002 19:49:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:17936 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319684AbSH2Xte>; Thu, 29 Aug 2002 19:49:34 -0400
Date: Fri, 30 Aug 2002 03:53:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020830035318.A3224@jurassic.park.msu.ru>
References: <20020828100351.8648@192.168.4.1> <Pine.LNX.4.33.0208281030190.1735-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0208281030190.1735-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 10:35:38AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 10:35:38AM -0700, Linus Torvalds wrote:
> I agree. There is absolutely no reason to artificially limit the "bus" 
> structure to only three resoruces (and with hardcoded behaviour at that).

I disagree. There was a very good reason for doing that - you can build
PCI bus tree (up to 256 buses) _only_ with PCI-to-PCI bridges, and I'm
absolutely sure that it will be true until PCI goes EOL.
IMHO, tying the PCI bus to the PCI-to-PCI bridge makes sense -
it's generic and can be used as abstraction.
The code in setup-bus.c is all about that - you can start embedded
system with completely uninitialized PCI and initialize it with
just pci_assign_unassigned_resources(). Don't know why i386 and ppc32
don't use this - on alpha we are using it for years. Oh, well... ;-)
Note that we don't care about "transparent" bridges at all - we
have everything properly allocated in the regular bridge windows.

> There are examples of bridges that are very common and that can bridge at
> least four resources: every single CarsBus bridge does that _today_. Right
> now Linux only uses three of the 4 resources, but that's because we've
> never needed to use more. The fourth one is allocated in case some cardbus
> driver were to want to use it..

True. But the cardbus bridge can handle only one device and the resource
allocation is up to cardbus driver. The only way to extend the bus
is to place the PCI-to-PCI bridge behind a cardbus bridge, and then
we're returning to the starting point.

> In fact, even regular PCI bridges often bridge more than three resources: 
> many have things like VGA pass-through etc, which would actually add up to 
> at least _five_ regions that they bridge (the regular three, and the added 
> VGA IO and MEM regions). Again, Linux doesn't actually care about this 
> right now, but again it is absolutely _wrong_ to artificially limit Linux 
> internally to some made-up (and wrong) notion of what a bridge is.

Hmm. Regular bridges also have ISA mode; should we have 64(!) IO resources
then it's enabled?
I think that PCIBIOS_MIN_[IO,MEM] and pcibios_align_resource handle this
legacy crap just nicely.

> In short: if anything, we may at some point make the number of resources
> _larger_, not smaller.

Well, the pci_bus itself does not have any own resources - there are 4
pointers to the real resources of the pci controller (host, pci or cardbus
bridge etc.)
So I suggest leaving only _one_ pointer, but to an array of resources
(either pci_dev or arch specific). This will work.

Not that I'm quite happy with this right now.

I can't consider Ben's request for 4th resource slot as an argument because
- he's trying to build child<->parent relationship on a resource
  level between CPU and PCI address spaces. Which is generally impossible
  (consider sparse addressing on alpha or io on parisc)
- probably I have problems counting to 4 - as Ben said in earlier threads,
  the ppc32 host bridge has 1 io and 2 memory ranges. ;-)

Ivan.
