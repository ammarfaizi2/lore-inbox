Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbQLIQpL>; Sat, 9 Dec 2000 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbQLIQpB>; Sat, 9 Dec 2000 11:45:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9989 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S131781AbQLIQoz>;
	Sat, 9 Dec 2000 11:44:55 -0500
Message-ID: <3A325A47.29DE00D8@mandrakesoft.com>
Date: Sat, 09 Dec 2000 11:13:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <Pine.LNX.4.10.10012082328260.2121-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 9 Dec 2000, Theodore Y. Ts'o wrote:
> >    I didn't have time to do more than just quickly apply the patch and leave
> >    in a hurry, but my Vaio certainly recognized the serial port on the combo
> >    cardbus card I have with this patch. Everything looked fine - I got a
> >    message saying it found a 16450 on ttyS4 when I plugged the card in.
> >
> > When you have a chance, can you check and make sure that you actually
> > can talk to the modem?  That will make me feel much better.....
> 
> Done.
> 
> It works perfectly fine for me, with the following caveat:
> 
> It crashes hard if I remove the card while the modem is in use, though (ie
> insert card, point minicom at it, sit at the minicom window while removing
> the card).
> 
> This is a problem that many drivers have: when the card is removed, the
> driver sees an interrupt (which happens to be the CardBus card removal
> interrupt, but the serial driver doesn't know that, and the way cardbus
> interrupts work it's always shared with the driver).
> 
> So the serial driver reads the modem status byte, which is all ones, and
> decides that there is a ton of work to do. It then loops forever, because
> the status byte bits will obviously continue to be all ones.
> 
> Note how the "rs_interrupt()" routine _tries_ to avoid this by having a
> pass counter value, but that logic never triggers because we will loop
> forever in receive_chars(), so the rs_interrupt() counter never even gets
> to increment.

Other places in serial.c check for 0xff, which implies we can and should
do the same in the interrupt handler...

>        /*
>         *      If we read 0xff from the LSR, there is no UART here.
>         */
>        if (serial_in(info, UART_LSR) == 0xff)
>               return -1;

I'm starting to think this Ositech Jack of Spades is unusual in some
way, since your (Linus) BestData card and other serial CardBus cards
sound like they work.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
