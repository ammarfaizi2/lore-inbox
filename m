Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbRFPSLq>; Sat, 16 Jun 2001 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264640AbRFPSLf>; Sat, 16 Jun 2001 14:11:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12557 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264639AbRFPSLV>; Sat, 16 Jun 2001 14:11:21 -0400
Date: Sat, 16 Jun 2001 11:10:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Eric Smith <eric@brouhaha.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com, mj@ucw.cz
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <3B2A9975.D648D55B@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0106161055040.9713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Jun 2001, Jeff Garzik wrote:
> 
> I believe Alan had mentioned something on IRC about seeing a case where
> the CardBus bridge's secondary and subordinate bridge numbers were 1 on
> bootup, but 0 after the yenta driver got ahold of it.  So, there is the
> potential that the yenta driver is not setting things up quite
> correctly.

Cardbus shouldn't be touching the bus stuff at all, BUT there may be
strange hardware that doesn't like the following:

        config_writeb(socket, PCI_SEC_LATENCY_TIMER, 176); 
	config_writeb(socket, PCI_PRIMARY_BUS, dev->bus->number);
        config_writeb(socket, PCI_SECONDARY_BUS, dev->subordinate->number);
        config_writeb(socket, PCI_SUBORDINATE_BUS, dev->subordinate->number);

I have heard rumors of PCI devices that want all these set with a single
double-word write.

That's how drivers/pci/pci.c does it, and it kind of makes sense (setting
all bus details in one atomic go, so that there can be no question of how
the config space accesses get forwarded or what the bus routing is).

So it is probable that yenta _should_ do

	unsigned int buses =
		(latency << 24) |
		(subordinate << 16) |
		(secondary << 8) |
		primary;
	config_writel(socket, PCI_PRIMARY_BUS, buses);

although I believe that any device that gets this wrong is really broken,
as it just re-programs the old values (needed in case of a suspend event).

> To answer your question, I wouldn't mind at all having a kernel command
> line setting that turned the above into a variable...

Agreed. That would make sense regardless.

> I would love to just define it unconditionally for x86, but I believe
> Martin said that causes problems with some hardware, and the way the
> BIOS has set up that hardware.  (details anyone?)

One of the main problems we used to have was (and will still probably be)
bridges that we don't recognize as such or that are invisible for some
other reason. The BIOS has set them up correctly, and if we reprogram
other stuff, we may have serious problems.

In particular, a lot of PCI bridges - notably the host bridges - have
"extra" bridging information in the extended part of the PCI config space.
Just see the problems we had with serverworks and compaq host bridges and
the "last bus" information.

Generic code generally cannot get that right, and without full knowledge
of all bridges (which we'll never have even in theory - just think of
trying to boot a kernel on a chipset that is newer than the kernel) we're
much better off using the BIOS setup at least as a very strong HINT.

That said, we already have heuristics for stuff that we notice is broken
and we fix it up in that case. We could just try to add a new heuristic,
namely "if we notice that two PCI bridges have the same bus number, we'd
better allocate a new one somewhere".

		Linus

