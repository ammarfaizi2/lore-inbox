Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155154AbPHEAFI>; Wed, 4 Aug 1999 20:05:08 -0400
Received: by vger.rutgers.edu id <S154696AbPHEAEr>; Wed, 4 Aug 1999 20:04:47 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:28043 "EHLO neon.transmeta.com") by vger.rutgers.edu with ESMTP id <S154549AbPHEAEk>; Wed, 4 Aug 1999 20:04:40 -0400
Date: Wed, 4 Aug 1999 17:03:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Mares <mj@ucw.cz>
cc: Andi Kleen <ak@muc.de>, David Hinds <dhinds@zen.stanford.edu>, Pete Zaitcev <zaitcev@metabyte.com>, linux-kernel@vger.rutgers.edu
Subject: Re: More linker magic..
In-Reply-To: <19990804214327.A736@albireo.ucw.cz>
Message-ID: <Pine.LNX.4.10.9908041653300.1313-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



Ok,
 I was hoping that Martin would end up doing this, but as I'm forcing
myself to honour the feature freeze too, I decided I might as well forge
right ahead on the PCI resoruce issue because it will be needed for proper
PCMCIA integration.

pre-patch-2.3.13-5 does the proper resource allocation for all PCI cards;
instead of having the drivers do the resource building, the PCI layer
builds up the resource information automatically, and at least for the set
of drivers I was concerned about on my machine there wasn't even any need
to adjust the old compatibility stuff, but that will almost certainly be
needed for other sets of drivers (ie extending the resource flags with a
"BUSY" bit to mark resources as being exclusively used by some driver).

There are probably a number of broken PCI drivers, but they tend to be
fairly straightforward to fix, and often the fix cleans things up. For
example, there used to be a

	pci_device->base_address[6]

array, where "base_address" wasn't really the base_address, it was really
the value in the PCI configuration space that is a mixture of base address
and flags. With the new scheme, there is

	pci_device->resource[6]

where each resource has all the normal "start"/"end"/"flags" things, and
the fields actually do exactly what they say (so "flags" has the flags for
that region: IO vs Mem, 64-bit addressing etc, and "start" really is the
base address).

It also means that /proc/ioport and /proc/iomem actually show the full
population.

Broken non-updated drivers simply won't compile, but the fixes tend to be
rather straightforward. The less straightforward part is if some driver
tries to change the start offsets etc, which implies that he really has to
unregister the resource and re-register somewhere else. I don't know if
anybody actually does that, although I do know that there are drivers that
play some silly games with their resource list.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
