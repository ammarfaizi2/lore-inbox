Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQLKDrM>; Sun, 10 Dec 2000 22:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLKDrC>; Sun, 10 Dec 2000 22:47:02 -0500
Received: from cs.columbia.edu ([128.59.16.20]:51882 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129392AbQLKDqx>;
	Sun, 10 Dec 2000 22:46:53 -0500
Date: Sun, 10 Dec 2000 19:16:20 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrey Savochkin <saw@saw.sw.com.sg>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <3A341B3F.B5D962A8@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.21.0012101901030.5164-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Udo A. Steinberg wrote:

> Anton Altaparmakov wrote:
> 
> The problem here only ever happens at initialisation/first packets. Once the
> network interface has been initialised properly it never produces those
> messages anymore. Usually it helps to shut the NIC down with ifconfig and
> bringing it back up afterwards to properly initialise it.

Actually I'm beginning to suspect that you might have a different problem
after all.

Bear with me for another couple of days, until I get near my Linux boxes
and can actually look more closely at things..

Anton Altaparmakov wrote:

> > My card is an Ether Express Pro 100, lcpci says: Intel Corporation 82557
> > [Ethernet Pro 100] (rev 04) 

So it's an i82558 A-step. That's interesting, the patch shouldn't have
made any difference on an i82558, at least according to the documentation.

Also according to the documentation (which I only realized later on), the
bit I'm turning off in the advertising word is supposed to be read-only..

This shows how much one can trust the docs, I guess. :)

> > and lspci -n gives: class 0200: 10b7:9004

Umm.. I don't think so. :) This a 3Com 3c900B. You probably got the wrong
entry, in case you have multiple cards in that box.

> Mine's a rev 08.
> 
> 00:0d.0 Class 0200: 8086:1229 (rev 08)

This is an i82559 C-step. What kind of switch is it attached to?

Also, if you feel like experimenting, edit speedo_interrupt() and change
	outw(status & 0xfc00, ioaddr + SCBStatus);
to
	outw(status & 0xff00, ioaddr + SCBStatus); 

and see if the complete hangs when disconnecting the cable go away. The
docs say that the device deasserts the interrupt line only when all
interrupt sources have been acked -- so if we don't ack the FCP interrupt
but do somehow get one, we end up with an un-ending stream of interrupts.

You could also try to make the printk() right next to that line *not*
depend on the debug level, and see what you get when the card barfs. Be
aware though that it will print one log line for each interrupt received,
so at the very least make your syslogd log kernel messages asynchronously
(without sync'ing after each line). On the other hand, since your problem
occurs as soon as the device is initialized, it shouldn't be too much of a
flood -- I hope.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
