Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290959AbSBLKjG>; Tue, 12 Feb 2002 05:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290961AbSBLKi5>; Tue, 12 Feb 2002 05:38:57 -0500
Received: from 91dyn53.com21.casema.net ([62.234.22.53]:17104 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S290959AbSBLKil>; Tue, 12 Feb 2002 05:38:41 -0500
Message-Id: <200202121038.LAA02103@cave.bitwizard.nl>
Subject: Re: what serial driver restructure is planned?
In-Reply-To: <E16aOVf-00084P-00@the-village.bc.nu> from Alan Cox at "Feb 11,
 2002 10:01:15 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 12 Feb 2002 11:38:37 +0100 (MET)
CC: Nick Craig-Wood <ncw@axis.demon.co.uk>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Could we also have an interface to serial devices which bypass the tty
> > layer?  Ie a /dev/ttyraw* which just speaks to the serial port without
> > going through the labyrinthine tty layers?
> 
> You've got one
> 
> > 9 times out of 10 when I reach for /dev/ttyS* that is all I want and
> > the tty layer is just wasteful and gets in the way of a conceptually
> > very simple device.
> 
> The only bits of the tty layer being used in raw data passing is the same
> buffer management logic you would need anyway. In short - the perceived
> waste is simply not there

IMHO, the main waste is "in the drivers". 

A serial driver restructuring should have a simple driver just be
"pass a character to the hardware" and "get a character from the
hardware" as well as "read/write modem control" register. (And the
driver would be requested to call a "modem status changed, please
ask me what the new status is").

That way you can build a working serial driver in under 100 lines of
code.

Now most advanced serial drivers would want to also provide "pass a
bunch of characters to the hardware" routine. By default that would
just be a routine that calls the output one char function
repeatedly. But hardware with a larger buffer can really benefit from
the block-move.

All "tty-layer" things should then move out of the driver. For
instance: no calling of "hangup" if the flags allow that: The driver
should report that DCD went down, and then something generic should in
one place decide wether or not to call "hangup" (i.e. send the hangup
signal).

If someone wires "DCD" to "TXD", and then uses the port in CLOCAL, we
will call the "DCD changed" function WAY too often. But that is just
stupid. Let's not create a stupid architecture because it will be
inefficient in a stupid case.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
