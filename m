Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286851AbRLWJp5>; Sun, 23 Dec 2001 04:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286852AbRLWJps>; Sun, 23 Dec 2001 04:45:48 -0500
Received: from bs1.dnx.de ([213.252.143.130]:425 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S286851AbRLWJpd>;
	Sun, 23 Dec 2001 04:45:33 -0500
Date: Sun, 23 Dec 2001 10:45:21 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: <rkaiser@sysgo.de>, <linux-embedded@waste.org>
Subject: Re: AMD SC410 boot problems with recent kernels
In-Reply-To: <a03cuj$661$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112231009500.10528-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Dec 2001, H. Peter Anvin wrote:
> I mean %dx -- you'd built a 32-bit counter into %dx:%cx.

Ok - didn't know this. Sorry for confusion - it's the first time I'm
digging deeper into x86 assembler stuff. My conclusion is that %dx:%cx is
0000:0001 after the old wait routine.

> It's part of the counter.  This seems to be *your* code, since there
> is nothing even closely similar in any previous kernel, so I don't
> know what you're trying to do here...

See above - the code after a20_wait_old just outputs stuff to an 8 bit
dioport with LEDs attached.

> Doesn't change the fact that the board is still broken, and they
> didn't provide the BIOS routine to compensate.

Hmm, I still don't understand this. Ok, the BIOS does not have the
routine, but this is rather common on embedded boards which do not have a
full featured BIOS. I mean - the procedure used by your code is to use
BIOS, then KBC and then 'fast' method one after the other until everything
fails. So it should be ok if KBC method worked, shouldn't it? I mean - not
taking into accout that due to some strange reasons the KBC method does
_not_ work correctly at the moment, but that's another question.

> At that point, the fact that the old code worked by accident is
> unfortunately irrelevant; especially since you obviously have a
> workaround that you can use.

Could you elaborate why you think that the old code worked only by
accident? [please be patient - I'm no native speaker and it may be that I
do sometimes not understand everything correctly. I'm trying hard.] As I
said above: before I do not understand _why_ the new code breaks it's
rather difficult to draw conclusions.

If the board is really _broken_ I have no problem with the fact that in
the future the manufacturer has either to supply a correct BIOS or a
workaround patch has to be used. If it's only uggly that there's no BIOS
routine it would IMHO be better to find a way to make it work again. There
are fixes for other uggly architectures in the code as well, see the
Toshiba Laptop reference. If the board may be PC compatible, Linux should
IMHO boot without further changes.

Are there other x86 boards where the BIOS doesn't provide the routine and
where the KBC method actually _works_? Would be interesting; I'm not sure
that much people have tested this yet, as most "normal" motherboards today
have full featured BIOSes. So any comments from embedded people using the
mechanimsm on other boards (SC410 or something different) would be
helpful.

> No, but the sequence in verbatim either before or after the call
> delay.

Now, I've tried these variants in the section after a20_test_wait:

----------8<----------
        call    delay           # Serialize and make delay constant

        pushw   %dx
        smsw    %dx
        lmsw    %dx
        popw    %dx
---------->8----------
        pushw   %dx
        smsw    %dx
        lmsw    %dx
        popw    %dx

        call    delay           # Serialize and make delay constant
----------8<----------

Still no change -> reboots.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+


