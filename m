Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129514AbQLGTB5>; Thu, 7 Dec 2000 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLGTBn>; Thu, 7 Dec 2000 14:01:43 -0500
Received: from r1608.muc.dial.surf-callino.de ([213.21.7.84]:6660 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129345AbQLGTBW>; Thu, 7 Dec 2000 14:01:22 -0500
Date: Thu, 7 Dec 2000 19:30:40 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        "Adam J. Richter" <adam@yggdrasil.com>, Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
In-Reply-To: <Pine.LNX.4.10.10012060939240.1611-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012070023560.438-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Dec 2000, Linus Torvalds wrote:

> On Wed, 6 Dec 2000, Martin Diehl wrote:
> > 
> [Cardbus config space lost after APM suspend/resume]
> 
> Can you remind me in a day or two if I haven't gotten back to you? I don't
> have any machines that need this, but I've seen ones that do, and if
> you're willing to test..

sure, will to do testing (and reminding ;-)

> Yes, this is expected for routers that we don't know about: we will still
> use the irq that the device claims it has, but we will obviously fail to
> try to route it (but it still works if the BIOS had already routed it -
> which is how the old code always worked anyway).

btw, I'm thinking I could guess the routing from the VLSI config space,
but I don't have any doc's. Would it be worth to try to add some specific
get/set methods for this device? What about testers (or people who have
access to the docs)?

> Anyway, for the suspend-resume thing, if you want to go ahead on your own
> without a real patch from me, the fix is along the lines of

well, took me some time to follow all the paths thru cardbus/pcmcia stuff
wrt suspend/resume from pm - but ended up at:

>  - add two functions:
> 
> 	static void yenta_save_config(pci_socket_t *socket)
> 	static void yenta_restore_config(pci_socket_t *socket)

That's the crucial point, imho. The PCI layer forwards the PM events to
the cardbus-driver's suspend/resume methods, which are calling 
pcmcia_suspend/resume_socket(). The latter in turn will call back the
appropriate yenta_operations which are registered to it. So much for sure.

However, there is no pcmcia_resume path forwarded to yenta since the
traditional pccard_operations did not provide such a method and pcmcia
simply re-initialized it's sockets. My assumption is, you haven't meant
to add a do-nothing resume to all the pcmcia-stuff (including i82365,
tcic) just to allow yenta to register for a resume operation which would
be there for cardbus only.
So my suggestion is to have cardbus_save/restore_config() exactly doing
what you've said for yenta_*.

>  - do a "yenta_save_config()" in "yenta_suspend()" and a
>    "yenta_restore_config()" at the top of "yenta_resume()"

yenta_resume() does not exist.
yenta_*() replaced by cardbus_*() as explained.

>  - test. Also test with the "pci_set_power_state(3)" in suspend enabled,
>    because it may/should actually work with that enabled too.

same point: pci_set_power_state(3) should go to cardbus_suspend(), not
yenta.

A first try of this ended oopsing at pm suspend somewhere below
pci_pm_*(). It turned out the reason was the cardbus_suspend() (and resume
too) method which was *invoked several times* in a row!

The reason for this is in drivers/pci.c where bridges are touched
twice: once as a device on a bus and once via ->self from the bus behind.
I'm not sure whether this is the intended behavior - but it definitely
calls cardbus_suspend/resume() twice which breaks when forwarding to
pcmcia_suspend/resume_socket().

So I've tentatively worked around using a "once" flag added to
pci_socket_t. This solves the problems during suspend/resume and the
cardbus' config space appears to be restored as intended - good.

The bad news however is, the sockets are still broken after
resume. Unfortunately there are several candidates I've spotted:

- calling yenta_init() stuff at resume - is this sufficient?
  Probably we have to forward the pm-triggered resume from pm along
  pci -> cardbus -> pcmcia -> yenta (last link currently missed,
  because the pcmcia layer switches from incoming resume notification
  to init path)

- some content of the mem/io regions might need to be preserved

- some TI1131 oddity wrt to CSC-INT's - requested IRQ's show up correctly
  in /proc/interrupts and are properly triggered and handled at card
  insert/eject. But after pm suspend/resume the box freezed when inserting
  or ejecting the cards (no response to SysRq anymore).

I'll try to continue on this.

Regards
Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
