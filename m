Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311556AbSCNISd>; Thu, 14 Mar 2002 03:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311557AbSCNISY>; Thu, 14 Mar 2002 03:18:24 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:27919 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311556AbSCNISL>; Thu, 14 Mar 2002 03:18:11 -0500
Date: Thu, 14 Mar 2002 09:18:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Daniela Engert <dani@ngrt.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <martin@dalecki.de>, Shawn Starr <spstarr@sh0n.net>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314091808.B31998@ucw.cz>
In-Reply-To: <20020314083038.A31923@ucw.cz> <20020314063843.E0E3210921@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314063843.E0E3210921@mail.medav.de>; from dani@ngrt.de on Thu, Mar 14, 2002 at 08:44:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 08:44:42AM +0100, Daniela Engert wrote:

> The PIIX3 bug is real, I have several user reports about it!

Thanks A LOT for the tables, added are some comments from me ...

>  Vendor
>  | Device
>  | | Revision			       ATA	ATAPI	     ATA66  ATA133
>  | | | south/host bridge id	     PIO  DMA  PIO  DMA  ATA33 | ATA100|   Docs
>  | | | | south/host bridge rev.     32bit  |  32bit  |	   |   |   |   |  avail
>  | | | | |			      |    |	|    |	   |   |   |   |    |
>  v v v v v			      v    v	v    v	   v   v   v   v    v
> 
>  0x8086 Intel
>    0x1230 PIIX		      x    x	x    x	   -   -   -   -    x
>      < 02			      x    -	x    -	   -   -   -   -    x

I suppose this means on PIIXes with rev 00 and 01 of the IDE controller
DMA transfers don't work reliably, right?

>        0x84C4 Orion
> 	 < 04			      x    -	x    -	   -   -   -   -    x

And this means that if there is an 84c4 PCI bridge in the system with
rev less than 04 (04 is OK), then DMA transfers are broken again.

>    0x7010 PIIX3 		      x    x	x    x	   -   -   -   -    x
>    0x7111 PIIX4 		      x    x	x    x	   x   -   -   -    x
>    0x7199 PIIX4 MX		      x    x	x    x	   x   -   -   -    x
>    0x84CA PIIX4 NX		      x    x	x    x	   x   -   -   -    x

This one confuses me, because the 0x84ca chip doesn't seem to have any
IDE capability. Is this id by any chance taken from the linux kernel?

>    0x2411 ICH			      x    x	x    x	   x   x   -   -    x
>    0x7601 ICH			      x    x	x    x	   x   x   -   -    x

This one is actually a PIIX5, not ICH.

>    0x2421 ICH0		      x    x	x    x	   x   -   -   -    x
>    0x244B ICH2		      x    x	x    x	   x   x   x   -    x
>    0x244A ICH2 mobile		      x    x	x    x	   x   x   x   -    x
>    0x248B ICH3		      x    x	x    x	   x   x   x   -    x
>    0x248A ICH3 mobile		      x    x	x    x	   x   x   x   -    x
> 
>  known bugs:
>    - PIIX3: some chips 'forget' to assert the IRQ sometimes. These chips are not
> 	    detectable in advance.

Is there any workaround for that? Or there isn't to do anything about
the bug and we just have to live with it ...

>  0x1106 VIA
>    0x1571 571			      x    x	x    x	   -   -   -   -    -

Irq unmasking during PIO transfers is known to cause problems on
these. Also, some have wrong ISA bridge vendor ID of 1107.

>    0x0571 571
>        0x0586
> 	 < 0x20  586		      x    x	x    x	   -   -   -   -    -

I have docs on this one.

> 	 >=0x20  586A/B 	      x    x	x    x	   x   -   -   -    x

00..1f 586
20..2f 586a
30..3f 586b
40..46 586b 3040 silicon
Has a bug where the preq# til ddack# bit must be cleared or can cause
spontaneous reboots.
47..4f 586b 3041 silicon

>        0x0596
> 	 < 0x10  596/A		      x    x	x    x	   x   -   -   -    x
> 	 < 0x10  596B		      x    x	x    x	   x   x   -   -    x

That probably should be >= 10

>        0x0686
> 	 < 0x10  686		      x    x	x    x	   x   -   -   -    -
> 	 < 0x40  686A		      x    x	x    x	   x   x   -   -    x
> 	 >=0x40  686B		      x    x	x    x	   x   x   x   -    -

I have docs here as well.

>        0x8231	 VT8231 	      x    x	x    x	   x   x   x   -    -
>        0x3074	 VT8233 	      x    x	x    x	   x   x   x   -    -

And for this, too.

>        0x3109	 VT8233c	      x    x	x    x	   x   x   x   -    -
>        0x3147	 VT8233a	      x    x	x    x	   x   x   x   x    -
> 
>  known bugs:
>    - all:  no host side cable type detection.

Not true, for the UDMA100 and UDMA133 capable ones, there are defined
bits in the UDMA_TIMING register. Not all BIOSes use those, though.

>    - all:  the busmaster 'active' bit doesn't match the actual busmaster state.
>    - 596B: don't touch the busmaster registers too early after interrupt
> 	   don't touch taskfile registers before stopping the busmaster!
>    - 686 rev 40/41 and VT8231 rev 10/11 have the PCI corruption bug!

Hmm, what's this one?

> --------------------------------------------------------------------------------
>  0x1022 AMD
>    0x7401 AMD 751		      x    x	x    x	   x   -   -   -    -
>    0x7409 AMD 756		      x    x	x    x	   x   x   -   -    x
>    0x7411 AMD 766  MP		      x    x	x    x	   x   x   x   -    x
>    0x7441 AMD 768  MPX	      x    x	x    x	   x   x   x   -    x
>    0x7469 AMD 8111		      x    x	x    x	   x   x   x   -    -
> 
>  known bugs:
>    - 756: no host side cable type detection.
>    - 756: SingleWord DMA doesn't work on early chip revisions.
>    - 766: read/write prefetches must be disabled to defeat infinite
> 	  PCI bus retries.

Correct.

> --------------------------------------------------------------------------------
>  0x1055 SMSC
>    0x9130 SLC90E66		      ?    x	?    ?	   x   x   -   -    x

This one is a PIIX clone, identical to PIIX4, except for slightly
different UDMA66 programming.

> --------------------------------------------------------------------------------
>  0x10DE Nvidia
>    0x01BC     nForce		      x    x	x    x	   x   x   x   -    -
> 
>  known bugs:
>    - nForce: no host side cable type detection.

Do you have any info on this one? I'd really like to have a Linux driver
for it ...

-- 
Vojtech Pavlik
SuSE Labs
