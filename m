Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLIINJ>; Sat, 9 Dec 2000 03:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQLIIM7>; Sat, 9 Dec 2000 03:12:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40966 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129604AbQLIIMt>; Sat, 9 Dec 2000 03:12:49 -0500
Date: Fri, 8 Dec 2000 23:41:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <200012090541.AAA17863@tsx-prime.MIT.EDU>
Message-ID: <Pine.LNX.4.10.10012082328260.2121-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Theodore Y. Ts'o wrote:
> 
>    I didn't have time to do more than just quickly apply the patch and leave
>    in a hurry, but my Vaio certainly recognized the serial port on the combo
>    cardbus card I have with this patch. Everything looked fine - I got a
>    message saying it found a 16450 on ttyS4 when I plugged the card in.
> 
> When you have a chance, can you check and make sure that you actually
> can talk to the modem?  That will make me feel much better.....

Done.

It works perfectly fine for me, with the following caveat:

It crashes hard if I remove the card while the modem is in use, though (ie
insert card, point minicom at it, sit at the minicom window while removing
the card).

This is a problem that many drivers have: when the card is removed, the
driver sees an interrupt (which happens to be the CardBus card removal
interrupt, but the serial driver doesn't know that, and the way cardbus
interrupts work it's always shared with the driver).

So the serial driver reads the modem status byte, which is all ones, and
decides that there is a ton of work to do. It then loops forever, because
the status byte bits will obviously continue to be all ones. 

Note how the "rs_interrupt()" routine _tries_ to avoid this by having a
pass counter value, but that logic never triggers because we will loop
forever in receive_chars(), so the rs_interrupt() counter never even gets
to increment.

> Once I fixed the /etc/pcmcia/config file, was able to start up the
> epic100 driver with cardmgr.  I was also able to (with cardmgr not
> running) load the epic100 module, and lo and behold it worked.

You should also just test having it compiled in - I know some people love
modules, but there is nothing quite as liberating as just having a kernel
that finds the devices it needs and doesn't need anything else.

> But then I ran into the second problem, which seems to afflict all
> PCMCIA/CARDBUS serial devices which I've tried.  That problem is the one
> which I alluded to in an eariler messages; it looks like some or all of
> the I/O port window for the serial device isn't getting set up properly.

I'm sitting here with a minicom session, talking to the modem. Maybe you
have a device that is not a standard UART?

> This makes me suspicious that the I/O windows for the serial drivers
> aren't getting set correctly.  And whatever the problem, it's affecting
> both PCMCIA devices (which still use serial_cs), as well as cardbus
> drivers, which is just using serial.o.  And this is why I asked you
> whether or not you can actually talk to the modem.

I have the serial.c driver compiled into the kernel, and apart from the
glitch I can _definitely_ talk to the modem just fine.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
