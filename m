Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSHaHgZ>; Sat, 31 Aug 2002 03:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSHaHgZ>; Sat, 31 Aug 2002 03:36:25 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:21764 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316437AbSHaHgX>; Sat, 31 Aug 2002 03:36:23 -0400
Date: Sat, 31 Aug 2002 01:57:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020831015716.B926@jurassic.park.msu.ru>
References: <20020830035318.A3224@jurassic.park.msu.ru> <20020830092825.16543@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020830092825.16543@192.168.4.1>; from benh@kernel.crashing.org on Fri, Aug 30, 2002 at 11:28:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 11:28:25AM +0200, Benjamin Herrenschmidt wrote:
> THen why did the embedded folks at montavista redid their own
> pci_auto version (it Marcelo tree since latest merge) ? Not that
> I agree with them here, I haven't digged into that code yet and
> I'm pretty sure it could ultimately be replaced by setup-bus, but
> in it's current incarnation, setup-bus is definitely not suitable
> for PPC32. I must also make sure on ppc32's like pmac and CHRP that
> some critical devices do _NOT_ get moved around by the PCI code.

Indeed, 2.4 isn't usable for that. My fault - I have yet to back port
2.5 setup-bus stuff...

> I don't see why you insist on picking the P2P bridge as the basis
> of the definition of a pci_bus structure. It's a limiting definition,
> and again, the code wouldn't be much more complex, more bloated or
> whatever by beeing slightly more generic...

And less functional, unless I'm missing something fundamental.

Consider the following simplified cofiguration (not quite real life,
but very close).
Host bridge (similar to pmac, I think :-) with 2 memory regions:
256M at 0x80000000 and 16M at 0xf0000000. There is also PCI or, even better,
AGP bridge, non-transparent; two graphic cards, one PCI and other AGP, with
2 memory resources each: 128M framebuffer and 4K of MMIO registers.
The memory window of the AGP bridge must be at least 129M (128M + 4K rounded
up to 1M).
Obviously, this window + 128M range of the PCI card won't fit in the
256M region of the host bridge. So, the only way to get all this working
is to set AGP bridge window such that it overlaps both regions
of the host bridge. Like this:
0x80000000-0x87ffffff           - PCI card, fb
0x88000000-0xf00fffff           - AGP bridge, memory window
        0x88000000-0x8fffffff   - AGP card, fb
        0x90000000-0xefffffff   - empty
        0xf0000000-0xf0000fff   - AGP card, MMIO
0xf0100000-0xf0100fff           - PCI card, MMIO

I don't see how you can cope with it using 2 separate bus resources -
the memory resource of the AGP bridge wouldn't have a valid parent.
OTOH, if you expose a _single_ memory resource of the host bridge
(0x80000000-0xf0ffffff) and write your pcibios_align_resource()
such that it won't allow allocation of non-bridge resources in the
0x90000000-0xefffffff range, everything is fine.

Please prove me that I'm wrong. :-)

Ivan.
