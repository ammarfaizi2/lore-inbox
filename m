Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbQLFSUy>; Wed, 6 Dec 2000 13:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLFSUo>; Wed, 6 Dec 2000 13:20:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129824AbQLFSUg>; Wed, 6 Dec 2000 13:20:36 -0500
Date: Wed, 6 Dec 2000 09:49:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        "Adam J. Richter" <adam@yggdrasil.com>, Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
In-Reply-To: <Pine.LNX.4.21.0012060226120.563-300000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.10.10012060939240.1611-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Martin Diehl wrote:
> 
> problems with recent 2.4.0-test1* on my HP OmniBook 800 are probably
> combined PCMCIA(CB) / PCI / APM issues. The point is my 16bit cards
> (modem+ne2k) are working perfectly fine with yenta sockets until the first
> suspend/resume. Afterwards the PCI config space of the Cardbus
> bridge(s) is completely messed up forcing me to reboot.

Ok. I actually knew of this issue, and it should be trivial to fix: we
should save and restore the 256-byte config space over suspends. CardBus
isn't the only controller that would need it.

Can you remind me in a day or two if I haven't gotten back to you? I don't
have any machines that need this, but I've seen ones that do, and if
you're willing to test..

> result: issue remains unchanged but nothing seems to be broken so far.
> The only difference I've noticed is the following two lines appearing when
> modprobing the pcmcia_core/yenta stuff:
> 
> IRQ for 00:04.0(0) via 00:04.0 -> PIRQ 01, mask 8eb8, \
>     excl 0000 -> newirq=9 ... failed
> IRQ for 00:04.1(1) via 00:04.1 -> PIRQ 04, mask 8eb8, \
>     excl 0000 -> newirq=7 ... failed

Yes, this is expected for routers that we don't know about: we will still
use the irq that the device claims it has, but we will obviously fail to
try to route it (but it still works if the BIOS had already routed it -
which is how the old code always worked anyway).

Anyway, for the suspend-resume thing, if you want to go ahead on your own
without a real patch from me, the fix is along the lines of

 - add a "u32 config_state[64]" array to pci_socket_t

 - add two functions:

	static void yenta_save_config(pci_socket_t *socket)
	{
		struct pci_dev *dev = socket->dev;
		int i;

		for (i = 0; i < 64; i++)
			pci_read_config_dword(dev, i*4, socket->config_state+i);
	}

	static void yenta_restore_config(pci_socket_t *socket)
	{
		struct pci_dev *dev = socket->dev;
		int i;

		for (i = 0; i < 64; i++)
			pci_write_config_dword(dev, i*4, socket->config_state[i]);
	}

 - do a "yenta_save_config()" in "yenta_suspend()" and a
   "yenta_restore_config()" at the top of "yenta_resume()"

 - test. Also test with the "pci_set_power_state(3)" in suspend enabled,
   because it may/should actually work with that enabled too.

Any change in suspend/resume from the above?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
