Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSHaIH2>; Sat, 31 Aug 2002 04:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHaIH2>; Sat, 31 Aug 2002 04:07:28 -0400
Received: from AMarseille-201-1-5-96.abo.wanadoo.fr ([217.128.250.96]:4464
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316512AbSHaIH0>; Sat, 31 Aug 2002 04:07:26 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Date: Sat, 31 Aug 2002 10:09:53 +0200
Message-Id: <20020831080954.10900@192.168.4.1>
In-Reply-To: <20020831015716.B926@jurassic.park.msu.ru>
References: <20020831015716.B926@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Obviously, this window + 128M range of the PCI card won't fit in the
>256M region of the host bridge. So, the only way to get all this working
>is to set AGP bridge window such that it overlaps both regions
>of the host bridge. Like this:
>0x80000000-0x87ffffff           - PCI card, fb
>0x88000000-0xf00fffff           - AGP bridge, memory window
>        0x88000000-0x8fffffff   - AGP card, fb
>        0x90000000-0xefffffff   - empty
>        0xf0000000-0xf0000fff   - AGP card, MMIO
>0xf0100000-0xf0100fff           - PCI card, MMIO
>
>I don't see how you can cope with it using 2 separate bus resources -
>the memory resource of the AGP bridge wouldn't have a valid parent.
>OTOH, if you expose a _single_ memory resource of the host bridge
>(0x80000000-0xf0ffffff) and write your pcibios_align_resource()
>such that it won't allow allocation of non-bridge resources in the
>0x90000000-0xefffffff range, everything is fine.
>
>Please prove me that I'm wrong. :-)

First, a simple problem: You are showing a possible problem caused
by a given PCI host & bridge setup. That's not my point. My point
is that I _do_ have setups with N MMIO regions and want the kernel
to be able to deal with that. I'm not introducing any limitation to
the code, I want the code to be generic enough to cope with a setup
that exist (as the host is configured by my firmware).

Also, in your example, if I expose a single memory resource, then I
lie since the host bridge in this example would not forward addresses
"between" the 2 ranges, thus the kernel would potentially allocate
space for unassigned devices in that non-decoded range.

I want my host pci_bus structure to expose what it is really forwarding.
That's as simple as that. If your host is configured in a more "sane",
way, then good. I'm not forcing anybody to have 2 MMIO regions ;)
I just want that dawn code to deal with cases where I do have them
(or more). Again, that code isn't about setting up the bus, it's
about coping with an existing setup when building the resource tree.

Regarding your above example, it just don't happen in real life.
First, we have AGP as a separate PCI host domain on pmac ;) Then,
the firmware can configures host bridges with large enough regions
to deal with what is needed by the card.

Ben.



