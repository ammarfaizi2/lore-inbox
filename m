Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286334AbRL2V2j>; Sat, 29 Dec 2001 16:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286233AbRL2V2a>; Sat, 29 Dec 2001 16:28:30 -0500
Received: from mail.sonytel.be ([193.74.243.200]:15548 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S285568AbRL2V2S>;
	Sat, 29 Dec 2001 16:28:18 -0500
Date: Sat, 29 Dec 2001 22:28:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sym53c8xx tape corruption squashed! (was: Re: SCSI Tape corruption
 - update)
In-Reply-To: <20011229184019.V1580-100000@gerard>
Message-ID: <Pine.GSO.4.21.0112292224220.277-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> On Sat, 29 Dec 2001, Geert Uytterhoeven wrote:
> > On Sat, 29 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> > > On Fri, 28 Dec 2001, Geert Uytterhoeven wrote:
> > > > The sym-2 driver has a define for modifying the PCI latency timer
> > > > (SYM_SETUP_PCI_FIX_UP), but it is never used, so I see no corruption.
> > >
> > > By default sym-2 use value 3 for the pci_fix_up (cache line size + memory
> > > write and invalidate). The latency timer fix-up has been removed, since it
> > > is rather up to the generic PCI driver to tune latency timers.
> > >
> > > > Is this a hardware bug in my SCSI host adapter (53c875 rev 04) or my host
> > > > bridge (VLSI VAS96011/12 Golden Gate II for PPC), or a software bug in the
> > > > driver (wrong burst_max)?
> > >
> > > Great bug hunting!
> > >
> > > It is about certainly not a software bug in the driver. Any latency timer
> > > value should not give any trouble if hardware was flawless. Just the PCI
> > > performances could be affected.
> >
> > I played a bit with sym-2 and setpci. Everything goes fine as long as the PCI
> > latency timer value is smaller than 0x16 (yes, at first I thought it was
> > decimal, but setpci parameters are in hex).
> 
> Interesting result, even if it doesn't trigger any of my guessing
> capabilities, for now. :-)
> 
> Just it means that the 875 must release the PCI BUS if its GNT# signal is
> deasserted by PCI arbiter and current transaction lasted 22 PCI cycles or
> more since the assertion of FRAME#.

Exactly my thoughts.

> If I remember correctly, the problem occurred when data is written to the
> device. Is it ok?

Yes.

> If so, the MWI problem I pointed out in my previous posting is unlikely to
> apply. But, for user data DMA write, the 875 may execute Memory Read Line
> or Memory Read Multiple Lines transactions. It would be interesting to
> know if it makes difference disabling those capabilities.
> 
> Setting to zero the PCI cache line register in the PCI configuration space
> does force the chip not to use any of the cache line based PCI
> transactions. It is brute force but should work.

Note that on my system the PCI cache line register in the PCI configuration
space of the '875 is already set to zero.

> In order to disable separately those features, some IO register bits must
> be set to zero. The faster way is to hack the driver (sym_hipd.c) at some
> place, for example (entered by hand just for you):

So I don't think it would help to test this, since PCI_CACHE_LINE_SIZE is set
to 0?

Anyway, thanks for your time and suggestions!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

