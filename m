Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbRA2Xoi>; Mon, 29 Jan 2001 18:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130929AbRA2Xo3>; Mon, 29 Jan 2001 18:44:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129999AbRA2XoV>; Mon, 29 Jan 2001 18:44:21 -0500
Date: Mon, 29 Jan 2001 15:44:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12: SiS pirq handling..
In-Reply-To: <00b601c08a49$b6257e10$0300a8c0@methusela>
Message-ID: <Pine.LNX.4.10.10101291523470.9984-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Aaron Tiensivu wrote:
> 
> Problem still exists, diffed to last kernel:

Yes. But everything works for you, no? Including USB?

The problem is that you have this routing table entry:

	00:01 slot=00 0:62/1eb8 1:00/0000 2:00/0000 3:00/0000

which is really for the USB chip (PCI id 00:01.2), and which the PCI code
_does_ find for the USB chip. So it should set up the routing happily, and
everything should be ok.

The trouble is that the routing table entry _also_ gets a false match to
the IDE chip (PCI id 00:01.1), which doesn't get routed through the above
AT ALL. So every time it sees either the USB or the IDE device, it will
notice that there is a bogus routing table entry associated with the IDE
device.

As a result, 2.4.1-pre12 will now complain (twice - once when it tries to
find the IDE irq route, the other time when it tries to find the USB irq
route) that there seems to be a routing table conflict for device 00:01.1.

In reality, the IDE device is routed with a fixed routing by the BIOS, and
the BIOS has also set the device "irqline" config space entry to point to
the proper table. So the IDE controller should work fine - and in fact it
is this second piece of information from the PCI config space that makes
Linux notice the conflict in the first place.

So it does appear that everything is fine. Linux should be doing exactly
the right thing on your board now, and USB _should_ work for you. The
complaints are real, and more importantly I now think we understand _why_
they happen.

It probably all used to work for you before, but we didn't really know
_why_. Which is almost as nasty a situation as not working at all.

Basically, the way your chipset is laid out PCI-wise, they are
subfunctions of the same device (subfunction 1 is IDE, subfunction 2 is
USB. Because of this they share an irq routing entry, and if they were to
NOT clash they should have been given separate "irq pin" numbers in their
config space. So a _good_ routing entry might have looked like

	00:01 slot=00 0:fe/4000 1:62/1eb8 2:00/0000 3:00/0000

where the IDE device has "irqpin=1" and the USB device has "irqpin=2", and
USB points to link 62, while IDE points to link fe (ie "hardcode to 14").

But the BIOS didn't do this properly, and as a result we get these pirq
clashes. Which are real, but should be harmless.

Now, will the two people in the world who know the pirq black magic now
stand up and confirm or deride my interpretation?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
