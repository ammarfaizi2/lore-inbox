Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285136AbRL2Rhi>; Sat, 29 Dec 2001 12:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285114AbRL2Rha>; Sat, 29 Dec 2001 12:37:30 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:63776 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285136AbRL2RhO> convert rfc822-to-8bit; Sat, 29 Dec 2001 12:37:14 -0500
Date: Sat, 29 Dec 2001 19:39:19 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sym53c8xx tape corruption squashed! (was: Re: SCSI Tape corruption
 - update)
In-Reply-To: <Pine.GSO.4.21.0112291421030.277-100000@vervain.sonytel.be>
Message-ID: <20011229184019.V1580-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Dec 2001, Geert Uytterhoeven wrote:

> On Sat, 29 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> > On Fri, 28 Dec 2001, Geert Uytterhoeven wrote:
> > > The sym-2 driver has a define for modifying the PCI latency timer
> > > (SYM_SETUP_PCI_FIX_UP), but it is never used, so I see no corruption.
> >
> > By default sym-2 use value 3 for the pci_fix_up (cache line size + memory
> > write and invalidate). The latency timer fix-up has been removed, since it
> > is rather up to the generic PCI driver to tune latency timers.
> >
> > > Is this a hardware bug in my SCSI host adapter (53c875 rev 04) or my host
> > > bridge (VLSI VAS96011/12 Golden Gate II for PPC), or a software bug in the
> > > driver (wrong burst_max)?
> >
> > Great bug hunting!
> >
> > It is about certainly not a software bug in the driver. Any latency timer
> > value should not give any trouble if hardware was flawless. Just the PCI
> > performances could be affected.
>
> I played a bit with sym-2 and setpci. Everything goes fine as long as the PCI
> latency timer value is smaller than 0x16 (yes, at first I thought it was
> decimal, but setpci parameters are in hex).

Interesting result, even if it doesn't trigger any of my guessing
capabilities, for now. :-)

Just it means that the 875 must release the PCI BUS if its GNT# signal is
deasserted by PCI arbiter and current transaction lasted 22 PCI cycles or
more since the assertion of FRAME#.

If I remember correctly, the problem occurred when data is written to the
device. Is it ok?

If so, the MWI problem I pointed out in my previous posting is unlikely to
apply. But, for user data DMA write, the 875 may execute Memory Read Line
or Memory Read Multiple Lines transactions. It would be interesting to
know if it makes difference disabling those capabilities.

Setting to zero the PCI cache line register in the PCI configuration space
does force the chip not to use any of the cache line based PCI
transactions. It is brute force but should work.

In order to disable separately those features, some IO register bits must
be set to zero. The faster way is to hack the driver (sym_hipd.c) at some
place, for example (entered by hand just for you):

	/*
	 *  Select all supported special features.
	 *  If we are using on-board RAM for scripts, prefetch (PFEN)
	 *  does not help, but burst op fetch (BOF) does.
	 *  Disabling PFEN makes sure BOF will be used.
	 */
	if (np->features & FE_ERL)
		np->rv_dmode	|= ERL;		/* Enable Read Line */
	if (np->features & FE_BOF)
		np->rv_dmode	|= BOF;		/* Burst Opcode Fetch */
	if (np->features & FE_ERMP)
		np->rv_dmode	|= ERMP;	/* Enable Read Multiple */
#if 1
	if ((np->features & FE_PFEN) && !np->ram_ba)
#else
	if (np->features & FE_PFEN)
#endif
		np->rv_dcntl	|= PFEN;	/* Prefetch Enable */
	if (np->features & FE_CLSE)
		np->rv_dcntl	|= CLSE;	/* Cache Line Size Enable */
	if (np->features & FE_WRIE)
		np->rv_ctest3	|= WRIE;	/* Write and Invalidate */
	if (np->features & FE_DFS)
		np->rv_ctest5	|= DFS;		/* Dma Fifo Size */

+ #if 0 /* Disable all cache line based features */
+ 	np->rv_dcntl	&= ~CLSE;
+ #endif
+ #if 1 /* Disable Read Line */
+ 	np->rv_dmode	&= ~ERL;
+ #endif
+ #if 1 /* Disable Read Multiple */
+ 	np->rv_dmode	&= ~ERMP;
+ #endif
+ #if 0 /* Disable Write and Invalidate */
+ 	np->rv_ctest3	&= ~WRIE;
+ #endif

This example disables Read Line and Memory Read Multiple. I just added
provisions (#if'ed zero) for other bits that also apply to cache line
based transactions.

Gérard.

