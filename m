Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317137AbSFBFbf>; Sun, 2 Jun 2002 01:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317138AbSFBFbe>; Sun, 2 Jun 2002 01:31:34 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10247
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317137AbSFBFb1>; Sun, 2 Jun 2002 01:31:27 -0400
Date: Sat, 1 Jun 2002 22:30:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: FUD or FACTS ?? but a new FLAME!
In-Reply-To: <Pine.SOL.4.30.0206020318090.29792-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10206012109170.5846-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Jun 2002, Bartlomiej Zolnierkiewicz wrote:

> Only in piix driver (Intel & Efar) and user have to explicitly compile
> support for it, it have nothing to do with kernel version and everything
> with driver version.

And you forgot about the removal of the bad drive lists.

> > The effect is the following.  "LINUS are you listening?"
> 				 ^^^^^^^^^^^^^^^^^^^^^^^^
> Andre, you forgot to cc Linus ;)

I don't bother, he will not listen.

> > Maybe now people will understand why 2.5 is falling apart and it is not
> > Martin's fault.  He is just getting bad information and bad patches.
> 
> Poor Marcin, he is so misinformed by bad people trying to spoil ATA stuff.

Well yes, I have waited to see who could solve the double timer and double
handler issue since I never got to include the correct solution before it
was ripped out of my hands.  The was a nice big private flamewar where
much of the lot in 2.5 made claims they could read and code to state
diagrams.  OOPS where is the code?  The error still exists, but not in 2.4.

At this point I have two solutions and trying to determine which is the
best.  The current one works, but have observed random extra interrupt on
traces.  Now the second model is not tested but in practice would not need
the check for possible handler race which causes the fore mentioned.

I guess I should now resubmit another patch, since the 2.5.7 was DOA, to
fix the transport layer problem.  However unless there is an in-process
flag for walking BIO's it will only make the communication correct.  It
will still violate the nature of the state diagrams proper.  It is a
development kernel, and who cares if it blows your data on an error.
This happens because at the time, there was not a usable means to protect
the BIOS walked during the operations of the hardware atomic segment.

So any BIOS/BH's traversed are at risk of there is a media error or any
other error event.

> > He actual has nearly the same model I was working on to use fucntion
> 
> It is really funny... but some people read code and know facts...

And some of us do not publish all there work because it needs to be a
complete solution as not to damage peoples data.

> > pointers in the style of "MiniPort (tm)".  I will explain why this is
> > desired later.
> 
> in Q4 I guess

Nah, in Q3 with Serial ATA which requires a much more dynamic driver.

> What a nice FUD.
> What is this major design flaw? Experimental (on demand) code in piix

This is typical style from the PIO5 issue in the past to expanding the VIA
variable clockbase cruft to hardware which can only operate in 33 or 66
reference baseclock.  Any other chipsets which do specific things with
timing ... ie HPT366/37X, CMD/SiI680, PDC20262 and above with PLL timers
to setup and properly phase.

So now you have multiple cases where the hardware does things total different
then the cruft added to them, and the "working toser code of mine" deleted.

So now pick up the pieces.

        switch (amd_clock) {
                case 33000: amd_clock = 33333; break;
                case 37000: amd_clock = 37500; break;
                case 41000: amd_clock = 41666; break;
        }

Please somebody tell me where in the AMD hardware spec it allow the base
clock to be anything but 33MHz ?  So instead of preventing people from
forcing the driver into bogus modes in the past, it now promotes
stupidity.

        switch (piix_clock) {
                case 33000: piix_clock = 33333; break;
                case 37000: piix_clock = 37500; break;
                case 41000: piix_clock = 41666; break;
        }

Also repeat for INTEL ...
Oh and exclude the point about clock as 66 or 100 cause the option is not
here even.  Since the registers referred to are for internal silicon
triggers which have a base origin of 33 .... sheesh why to I bother!

Look it still exists even after explaining many times of trying to make
the point!

/*
 * $Id: ata-timing.c,v 2.0 2002/03/12 15:48:43 vojtech Exp $
 *
 *  Copyright (c) 1999-2001 Vojtech Pavlik
 *
 * This program is free software; you can redistribute it and/or modify it

        { XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
        { XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },

        { XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 },
        { XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },

NICE

        /* EIDE PIO modes */
        if ((map & XFER_EPIO) && (id->field_valid & 2)) {
                if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
                            (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
                            (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0))
                        return best;
        }


For some reason I can not find XFER_PIO_5 any where in the standard.
So where did the value come from?
Do I have a test for (drive->id->eide_pio_modes & 4), yes.
The difference is I know to never permit XFER_PIO_5 ever being set.

BETTER

        /* Lenghten active & recovery time so that cycle time is correct.
         */

        if (t->act8b + t->rec8b < t->cyc8b) {
                t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
                t->rec8b = t->cyc8b - t->act8b;
        }

        if (t->active + t->recover < t->cycle) {
                t->active += (t->cycle - (t->active + t->recover)) / 2;
                t->recover = t->cycle - t->active;
        }

Instead of using the fixed and bounded PIO timing values as set forward by
the OEM Chip makers, who know best how their product works.  2.5 now has
this charming piece of crap which admits to dorking up the command block
transfer timing execution.  OUCH.

Now recall me being called a LIAR by PINHEAD.

If the drivers baseclock gets fubar'd, thus the PIO taskfile or ata
command block execution (how to talk to the hardware), the driver will
begin to corrupt events.

PINHEAD, look it happened and you were not even watching.
Your blind hatered of me being correct again has come back to visit.

BEST!

/*
 * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).  These were taken
 * from ATA/ATAPI-6 standard, rev 0a, except for PIO 5, which is a nonstandard
 * extension and UDMA6, which is currently supported only by Maxtor drives.
 */

I wish somebody would inform Maxtor so it can be made public.
On monday I will call one of my contacts there who writes the
diskware/firmware, I am sure he will need a good laugh at the beginning of
the week.

> driver? Or you no longer being ATA maintainer?

No check the file.

> Ok, I really wanted to be quiet, but this time it is too much...
> sorry for bad words/irony but that is how things look like...

I wish you had because, you will soon find out how right I am at the
hardware transport layer.

> Some people (me included) are putting much effort in cleaning/improving
> all this mess, and you keep spreading FUD and discrediting them.

Well I have admitted in the past and will again, my coding style sucks.
Now given the choice between ugly code which is technically correct, or
elegantly written to be technically wrong.

The latter will not provide usable reports to fix it, while the former
will allow one to make it elegant.

Sincerely,

Andre Hedrick
LAD Storage Consulting Group

PS "PINHEAD" is the endearing term generally used to refer to Torvalds, by
may of the mainsteam developers.

