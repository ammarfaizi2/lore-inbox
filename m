Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQLGTJj>; Thu, 7 Dec 2000 14:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLGTJ3>; Thu, 7 Dec 2000 14:09:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52232 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129314AbQLGTJV>; Thu, 7 Dec 2000 14:09:21 -0500
Date: Thu, 7 Dec 2000 10:38:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        "Adam J. Richter" <adam@yggdrasil.com>, Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
In-Reply-To: <Pine.LNX.4.21.0012070023560.438-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.10.10012071031300.2496-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Martin Diehl wrote:
> 
> btw, I'm thinking I could guess the routing from the VLSI config space,
> but I don't have any doc's. Would it be worth to try to add some specific
> get/set methods for this device? What about testers (or people who have
> access to the docs)?

Please do. You might leave them commented out right now, but this is
actually how most of the pirq router entries have been created: by looking
at various pirq tables and matching them up with other (non-pirq)
documentation and testing. Th epirq "link" value is basically completely
NDA'd, and is per-chipset-specific. Nobody documents it except in their
bios writers guide, if even there.

> yenta_resume() does not exist.
> yenta_*() replaced by cardbus_*() as explained.

Yes.

> The reason for this is in drivers/pci.c where bridges are touched
> twice: once as a device on a bus and once via ->self from the bus behind.
> I'm not sure whether this is the intended behavior - but it definitely
> calls cardbus_suspend/resume() twice which breaks when forwarding to
> pcmcia_suspend/resume_socket().

Not intended behaviour. The self case should be removed.

> So I've tentatively worked around using a "once" flag added to
> pci_socket_t. This solves the problems during suspend/resume and the
> cardbus' config space appears to be restored as intended - good.
> 
> The bad news however is, the sockets are still broken after
> resume. Unfortunately there are several candidates I've spotted:
> 
> - calling yenta_init() stuff at resume - is this sufficient?
>   Probably we have to forward the pm-triggered resume from pm along
>   pci -> cardbus -> pcmcia -> yenta (last link currently missed,
>   because the pcmcia layer switches from incoming resume notification
>   to init path)
> 
> - some content of the mem/io regions might need to be preserved
> 
> - some TI1131 oddity wrt to CSC-INT's - requested IRQ's show up correctly
>   in /proc/interrupts and are properly triggered and handled at card
>   insert/eject. But after pm suspend/resume the box freezed when inserting
>   or ejecting the cards (no response to SysRq anymore).

Ok, definitely needs some more work. Thanks for testing - I have no
hardware where this is needed.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
