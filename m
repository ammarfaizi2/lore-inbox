Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQLJIw5>; Sun, 10 Dec 2000 03:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQLJIws>; Sun, 10 Dec 2000 03:52:48 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:51603 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129819AbQLJIwg>;
	Sun, 10 Dec 2000 03:52:36 -0500
Date: Sun, 10 Dec 2000 03:22:06 -0500
Message-Id: <200012100822.DAA17932@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
In-Reply-To: Jeff Garzik's message of Sat, 09 Dec 2000 11:13:59 -0500,
	<3A325A47.29DE00D8@mandrakesoft.com>
Subject: Re: Serial cardbus code.... for testing, please.....
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 09 Dec 2000 11:13:59 -0500
   From: Jeff Garzik <jgarzik@mandrakesoft.com>

   > Note how the "rs_interrupt()" routine _tries_ to avoid this by having a
   > pass counter value, but that logic never triggers because we will loop
   > forever in receive_chars(), so the rs_interrupt() counter never even gets
   > to increment.

   Other places in serial.c check for 0xff, which implies we can and should
   do the same in the interrupt handler...

No, other places in the serial driver check for 0xff *after* setting
various registers and clearing various flags.  Those various
initializations are critical before you can simply do a "bail if LSR ==
0xff" check.

It's possible (not very likely, but possible) for LSR to go into
christmas tree mode where all of the flags are set in normal operation.
So for the interrupt driver, we're going to have to do some kind of loop
based thing --- if interrupt driver receives 0xff more than some number
of times, bail.

   I'm starting to think this Ositech Jack of Spades is unusual in some
   way, since your (Linus) BestData card and other serial CardBus cards
   sound like they work.

Well, I'm able to make the Jack of Spades work if everything is compiled
in --- although the networking side of the card seems to deadlock the
kernel if I eject and re-insert the card --- this problem doesn't show
up if I compile the epic100 driver as a module, only when it is compiled
into the kernel.  However, if the 2.4 pcmcia/cardbus drivers are
compiled as modules, *all* serial cards which I've tried, CardBus and
PCMCIA, fail in mostly the same way.

If I disable the kernel PCMCIA drivers, and use the pcmcia-cs drivers
with the 2.4 kernel, they all work fine.  If I use the pcmcia-cs drivers
with the 2.2 kernel, it also works fine.  So starting to look like it's
a very specific set of circumstances where it doesn't work.  It just
happened to be the one which I tried first, since I do like kernel
modules since it's a lot easier to debug things that way....  

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
