Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbQLIGMS>; Sat, 9 Dec 2000 01:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbQLIGMI>; Sat, 9 Dec 2000 01:12:08 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:42899 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129901AbQLIGMA>;
	Sat, 9 Dec 2000 01:12:00 -0500
Date: Sat, 9 Dec 2000 00:41:24 -0500
Message-Id: <200012090541.AAA17863@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Linus Torvalds <torvalds@transmeta.com>
CC: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: Linus Torvalds's message of Fri, 8 Dec 2000 13:27:51 -0800 (PST),
	<Pine.LNX.4.10.10012081319010.11626-100000@penguin.transmeta.com>
Subject: Re: Serial cardbus code.... for testing, please.....
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 8 Dec 2000 13:27:51 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

   I didn't have time to do more than just quickly apply the patch and leave
   in a hurry, but my Vaio certainly recognized the serial port on the combo
   cardbus card I have with this patch. Everything looked fine - I got a
   message saying it found a 16450 on ttyS4 when I plugged the card in.

When you have a chance, can you check and make sure that you actually
can talk to the modem?  That will make me feel much better.....

There was is usual with these sorts of things, multiple problems I was
dealing with.  The first was that I was trying to use cardmgr, and my
pcmcia config file was still trying to load epic_cb.  Oops.  David, you
might want to mention of this caveat in the README-2.4 file in the
pcmcia-cs package.

Once I fixed the /etc/pcmcia/config file, was able to start up the
epic100 driver with cardmgr.  I was also able to (with cardmgr not
running) load the epic100 module, and lo and behold it worked.  OK, one
problem down.  I also demonstrated to my self that I could manually load
the serial and epic module, and yenta/ds code would call the appropriate
device driver's registration routine.  So far, so good.  

But then I ran into the second problem, which seems to afflict all
PCMCIA/CARDBUS serial devices which I've tried.  That problem is the one
which I alluded to in an eariler messages; it looks like some or all of
the I/O port window for the serial device isn't getting set up properly.
Reads and writes to the UART registers (or at least where the UART
registers allegedly should be, according to the pcmcia/cardbus
subsystem) are returning garbage.

For example, with the Jack of Spades Ositech Cardbus card, a write to
the Interrupt Enable Register of 0x0f is returning 0x08, when it should
return the value that was originally written, 0x0f.  This causes the
card to fail the serial UART detection code.

In the case of the MegaHertz modem PCMCIA card and the Linksys combo
PCMCIA card, card registers manage to survive the serial driver's UART
test (although as a 8250 or 16450, instead of the 16550A that's really
in those cards, meaning it failed the more advanced loopback and FIFO
tests).  However, when you try to actually *use* the Line Status
Register always returns 0, while the IIR register returns 0 --- which
should never happen; if LSR returns 0, then there can't be any
interrupts pending, so IIR should be 0x1.  Other times both LSR and IIR
when queried return 0x80, where 0x80 is an a always-zero bit on the LSR
register.  In both cases it causes the interrupt service routine to
loop, although fortunately a safety I had coded into the driver to
prevent infinite loops breaks it out after 50 loops.

This makes me suspicious that the I/O windows for the serial drivers
aren't getting set correctly.  And whatever the problem, it's affecting
both PCMCIA devices (which still use serial_cs), as well as cardbus
drivers, which is just using serial.o.  And this is why I asked you
whether or not you can actually talk to the modem --- I've seen cases
where the PCMCIA code finds the modem, and the UART even passes some of
the preliminary tests, but if you try send "AT" to the modem, you'll see
that it hangs because it doesn't get any transmit interrupts, and even
when the watchdog timer forces an entry to the serial interrupt driver,
the UART registers yield nonsense values.

If I turn off CONFIG_PCMCIA and recompile the kernel and the pcmcia
driver, then the serial driver works fine and fines the ports without
any problems.  And even with CONFIG_PCMCIA enabled, the serial driver
has no problem talking to the built-in modem in my Vaio 505TX (that's
one advantage of having an old Vaio -- a real modem, not a winmode
requiring the use of a GPL-violating driver.  :-)

Anyway, if anyone has any suggestions on how to debug this, let me
know.  I'll be happy to run whatever debugging tests are necessary to
get to the bottom of this.  

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
