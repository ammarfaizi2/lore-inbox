Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129844AbQLJHif>; Sun, 10 Dec 2000 02:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbQLJHiY>; Sun, 10 Dec 2000 02:38:24 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:45715 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129844AbQLJHiP>;
	Sun, 10 Dec 2000 02:38:15 -0500
Date: Sun, 10 Dec 2000 02:07:41 -0500
Message-Id: <200012100707.CAA17906@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
In-Reply-To: Linus Torvalds's message of Fri, 8 Dec 2000 23:41:54 -0800 (PST),
	<Pine.LNX.4.10.10012082328260.2121-100000@penguin.transmeta.com>
Subject: Re: Serial cardbus code.... for testing, please.....
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 8 Dec 2000 23:41:54 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

   This is a problem that many drivers have: when the card is removed, the
   driver sees an interrupt (which happens to be the CardBus card removal
   interrupt, but the serial driver doesn't know that, and the way cardbus
   interrupts work it's always shared with the driver).

   So the serial driver reads the modem status byte, which is all ones, and
   decides that there is a ton of work to do. It then loops forever, because
   the status byte bits will obviously continue to be all ones. 

Ok, thanks.  I'll work up a patch to fix this problem.

   You should also just test having it compiled in - I know some people love
   modules, but there is nothing quite as liberating as just having a kernel
   that finds the devices it needs and doesn't need anything else.

Interesting.  Yup, the serial driver works with it compiled in.
However, the epic driver fails after I eject and remove the card, and
then re-insert it (it hangs on the re-insertion).  It looks like a
deadlock; after it hangs, "ifconfig" also hangs, presumably waiting on
the same lock (ps alx reports it's waiting on "down").

   > But then I ran into the second problem, which seems to afflict all
   > PCMCIA/CARDBUS serial devices which I've tried.  That problem is the one
   > which I alluded to in an eariler messages; it looks like some or all of
   > the I/O port window for the serial device isn't getting set up properly.

   I'm sitting here with a minicom session, talking to the modem. Maybe you
   have a device that is not a standard UART?

Nope, it fails in this way for three separate PC Cards, but they work
just fine  under Linux 2.2 w/ pcmcia-cs, and Linux 2.4 w/ pcmcia-cs, and
I know they are standard UART's.

However, they all fail in the same way if I use the built-in pcmcia
drivers in Linux 2.4 if things are compiled as modules.  The cardbus
(Jack of Spades Ositech) works if the serial module is compiled into the
kernel (but the network half fails upon reinsertion).  I haven't had a
chance to check the PCMCIA cards with the drivers built-in (PCMCIA
requires cardmgr, right?  Will cardmgr work if the relevant drivers are
compiled in, as opposed to compiled as module?).

Curious.....  well, I'm about to go on the road again for a week (IETF
meeting in San Diego), so I won't have as much chance to work on this (I
need to have my laptop working reliably, which means I'll have to back
it out to Linux 2.2.18pre24 for the most part).  

In any case, I think I know how to fix the serial driver to not loop in
receive_chars().  If I get this working, do you want to take a serial
driver update now or post 2.4.0?  I have a number of fixes queued up
that I didn't consider critical, so I haven't fed them to you.  One of
them is from an SGI engineer who's been harassing me about getting one
of the changes in, since he's apparently on deadline and he needs a
change for one of his SGI MIPS boxes.  I don't understand why he can't
just use a kernel with a patch, but whatever...

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
