Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTECQ3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTECQ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:29:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28850 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263348AbTECQ3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:29:50 -0400
Date: Sat, 3 May 2003 18:42:03 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Reserving an ATA interface
In-Reply-To: <1051954404.4101.30.camel@gaston>
Message-ID: <Pine.SOL.4.30.0305031805170.10296-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 May 2003, Benjamin Herrenschmidt wrote:

> Hi Bart, Alan !

Hi!

> I've been fighting with a problem with both 2.4 and 2.5 for which I
> would have a workaround, but I'd like to have your point of
> view on it first as this code is rather messy.
>
> So the problem is all about deciding if an hwif slot is 'owned' by
> a driver, even after ide_unregister is called, after probe, etc...
> and problems with the way the current scheme works (and differences
> between the way PCI interfaces "pick" free slots vs. ide_register_hw
> does)

Yeah, this is tricky.

[slightly off-topic]
Yesterday I was thinking about:
- default arch hwifs, added/probed in ide_init_defult_hwifs() if no
  IDE PCI/PCI (depends on arch, should be IDE PCI?) support is compiled in
- PCI hwifs
- legacy hwifs probed in ide_setup()
- legacy hwifs probed after PCI
and about ide_register_hw() + initializing flag.

What a mess... ordering issues can make you crazy.

> So, let's first explain the various cases I have to deal with in the
> context of ide/ppc/pmac.c.
>
> 1 - Normal case: interface is non hotswap, drive is present at startup,
> things just work normally
>
> 2 - Empty interface: at boot, en empty interface (no drive) is found.
> This happens a lot since Apple's ASIC often have at least one spare
> ATA/33 interface that isn't wired to anything. This hwif is filled
> up for ide/ppc/pmac (MMIO iops, chipset = ide_pmac, etc...).
> hwif->present is cleared by the common probe code
>
> 3 - Hotswap interface: This one may or may not have devices plugged
> at boot (laptop media bay). The hwif is filled with MMIO iops etc...
> but since it may not have the CD drive plugged at boot, hwif->present
> may be cleared by the common probe code.
>
> So now, the problems:
>
>  - In both case 2 and 3, hwif->present may be cleared. That means
> that something calling ide_register_hw() (like ide-cs for example)
> will eventually pick up that hwif slot and try to use it. However
> the hwif beeing filled for ide/ppc/pmac.c (MMIO iops among other)
> it will usually not work and just crash, since ide_register_hw()
> will _not_ reinit the fields. Also, in the case of the hotswap
> interface (3), It's simply not acceptable for the slot to be re-used
> (while it is for case 2) since you don't want the CD-ROM location
> to change, and because ide-pmac will have internally setup a data
> structure for this hwif that is tied to a given index that was
> obtained at boot.
>
> So that leads to 2 actual needs: One, to deal with case 2 & re-use
> of the hwif by ide-cs (among others) is to have ide_register_hw
> actually clear the interface calling init_hwif_data() at some
> point when picking a "new" slot. The other one is to be able to
> "mark" an interface as "held" by the driver (hotswap bay that
> don't want to change numbering).
>
> The simplest solution I have in mind is to add an hwif flag,
> called "hold" (or whatever better name you find). Drivers like
> ide/ppc/pmac.c would set this flag for the "hotswap" media bay
> interface, and not for others.

This change is obviously correct and it doesn't have influence on
any existing code.

> The only change to the core code would then be for ide_register_hw
> to 'skip' those when searching for an available slot, and to call
> init_hwif_data when (!hwif->present && !hwif->hold) to handle case 2
> where the iops & other hwif fields (mmio among others) need to be
> reset to initial/legacy state.

Less safe change but also okay, as callers .
btw, Can't "ghost ides" be dealed inside ppc specific code?
     Do you know when interface is valid and when it is "ghost",
     and what other OS-es do in this case?

--
Bartlomiej

> That would allow "empty" fixed pmac interfaces to be released for
> use by ide-cs, while the hotswap media bay one stay reserved.
>
> That would give us a patch like that:
>
> ===== include/linux/ide.h 1.47 vs edited =====
> --- 1.47/include/linux/ide.h	Sun Apr 27 00:11:51 2003
> +++ edited/include/linux/ide.h	Sat May  3 11:30:34 2003
> @@ -1022,6 +1022,7 @@
>
>  	unsigned	noprobe    : 1;	/* don't probe for this interface */
>  	unsigned	present    : 1;	/* this interface exists */
> +	unsigned	hold       : 1; /* this interface is always present */
>  	unsigned	serialized : 1;	/* serialized all channel operation */
>  	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
>  	unsigned	reset      : 1;	/* reset after probe */
> ===== drivers/ide/ide.c 1.45 vs edited =====
> --- 1.45/drivers/ide/ide.c	Sun Apr 27 00:11:50 2003
> +++ edited/drivers/ide/ide.c	Sat May  3 11:32:35 2003
> @@ -920,8 +920,8 @@
>  		}
>  		for (index = 0; index < MAX_HWIFS; ++index) {
>  			hwif = &ide_hwifs[index];
> -			if ((!hwif->present && !hwif->mate && !initializing) ||
> -			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
> +			if (!hwif->hold && ((!hwif->present && !hwif->mate && !initializing) ||
> +			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing)))
>  				goto found;
>  		}
>  		for (index = 0; index < MAX_HWIFS; index++)
> @@ -931,6 +931,8 @@
>  found:
>  	if (hwif->present)
>  		ide_unregister(index);
> +	else if (!hwif->hold)
> +		init_hwif_data(index);
>  	if (hwif->present)
>  		return -1;
>  	memcpy(&hwif->hw, hw, sizeof(*hw));

