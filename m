Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272375AbRH3R4K>; Thu, 30 Aug 2001 13:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272372AbRH3R4A>; Thu, 30 Aug 2001 13:56:00 -0400
Received: from glucose.pas.idealab.com ([64.208.8.249]:38343 "HELO idealab.com")
	by vger.kernel.org with SMTP id <S272374AbRH3Rzm>;
	Thu, 30 Aug 2001 13:55:42 -0400
Date: Thu, 30 Aug 2001 10:55:54 -0700 (PDT)
From: David Moore <david@startbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Hang in yenta socket driver in 2.4.x w/ PCI->PCMCIA adapter
Message-ID: <Pine.LNX.4.30L2.0108301029270.26919-100000@luca.pas.lab>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I'm using kernel 2.4.9, but have observed this problem with all 2.4.x
kernels I've tried.  I have a PCI card with a single PCMCIA slot in it.
It's has a TI Cardbus controller which is detected successfully and
assigned IRQs without trouble.  I have also used it successfully with the
pcmcia-cs modules and PCMCIA support not enabled in the main kernel
sources.

I get the following messages upon loading the pcmcia_core, yenta_socket,
and ds modules:

PCI: Enabling device 01:09.1 (0000 -> 0002)
PCI: Enabling device 01:09.0 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq5
Socket status: 30000010
Yenta IRQ list 0000, PCI irq5
Socket status: 30000006
cs: socket c79bb800 timed out during reset.  Try increasing setup_delay.

Then, immediately after I start the cardmgr daemon, the system hangs
solidly (cannot switch consoles or scroll up).  Upon closer inspection,
socket 0 is not attached to a physical PCMCIA slot, and is the one timing
out above.  Socket 1 is the only real slot.  As a workaround, I modified
cardmgr so that it only initializes socket 1, and avoids socket 0
completely.  When I do this, everything works perfectly and I can use
cards in the socket.  (It should be noted that the hang occurs even
without any cards in the socket).  Also, I doubt this is an IRQ problem
because irq 5 (assigned above) is not used by another device as reported
by lspci.

Since the pcmcia-cs modules work (even with kernel 2.4.x) I know that it's
theoretically possible to have socket 0 fail gracefully rather than hang
the system when it's initialized, even though it doesn't really exist.

Any ideas how to fix this?

I have attached the output when debugging is enabled in yenta_socket (this
is with cardmgr loading the modules itself):

cb_readl: c88c6740 0008 30001818
exca_readb: c88c6740 0001 4c
exca_readb: c88c6740 0003 50
^-- these three lines repeat for a while....
cb_readl: c88c6740 0008 30001818
exca_readb: c88c6740 0001 4c
exca_readb: c88c6740 0003 50
cs: socket c79a3800 timed out during reset.  Try increasing setup_delay.
cb_readl: c88c67c8 0008 30000086
exca_readb: c88c67c8 0001 00
exca_readb: c88c67c8 0003 50
exca_writeb: c88c6740 0040 a0
exca_writew: c88c6740 0010 0000
exca_writew: c88c6740 0012 8000
exca_writew: c88c6740 0014 4000
exca_writeb: c88c6740 0006 01 <------------------- hangs here

The last few lines look like they are from the mem_map function, but I'm
not sure if the hang occurs immediately at this point, or is caused by
code somewhere else.

Thanks for the help.

Best Regards,

David Moore

