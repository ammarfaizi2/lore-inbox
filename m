Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSH1R3F>; Wed, 28 Aug 2002 13:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSH1R3E>; Wed, 28 Aug 2002 13:29:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19464 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318170AbSH1R3C>; Wed, 28 Aug 2002 13:29:02 -0400
Date: Wed, 28 Aug 2002 10:35:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
In-Reply-To: <20020828100351.8648@192.168.4.1>
Message-ID: <Pine.LNX.4.33.0208281030190.1735-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Benjamin Herrenschmidt wrote:

> >On Mon, Aug 26, 2002 at 10:12:24PM +0200, Benjamin Herrenschmidt wrote:
> >> While we are at it, I still think the loop copying parent resource
> >> pointers in the case of a transparent bridge should copy the 4
> >> resource pointers of the parent and not only 3.
> >
> >I agree that hardcoding the resource numbers is bad.
> >Instead, I suggest the following:
> >s/bus->resource[0]/bus->io/
> >s/bus->resource[1]/bus->mem/
> >s/bus->resource[2]/bus->pref_mem/
> >s/bus->resource[3]//
> >
> >There are only 3 _bus_ resources - the PCI works this way.
> >
> >Please don't propose your arch specific hacks to generic code.
> 
> I still don't agree, nothing in the _PCI_ force you to have
> only 3 resources.

I agree. There is absolutely no reason to artificially limit the "bus" 
structure to only three resoruces (and with hardcoded behaviour at that).

There are examples of bridges that are very common and that can bridge at
least four resources: every single CarsBus bridge does that _today_. Right
now Linux only uses three of the 4 resources, but that's because we've
never needed to use more. The fourth one is allocated in case some cardbus
driver were to want to use it..

In fact, even regular PCI bridges often bridge more than three resources: 
many have things like VGA pass-through etc, which would actually add up to 
at least _five_ regions that they bridge (the regular three, and the added 
VGA IO and MEM regions). Again, Linux doesn't actually care about this 
right now, but again it is absolutely _wrong_ to artificially limit Linux 
internally to some made-up (and wrong) notion of what a bridge is.

In short: if anything, we may at some point make the number of resources
_larger_, not smaller.

		Linus

