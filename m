Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUFTAnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUFTAnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUFTAnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:43:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12435 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264815AbUFTAnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:43:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adolfo =?iso-8859-15?q?Gonz=E1lez=20Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
Date: Sun, 20 Jun 2004 02:47:32 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1087253451.4817.4.camel@localhost> <200406191846.32983.bzolnier@elka.pw.edu.pl> <1087686048.647.9.camel@localhost>
In-Reply-To: <1087686048.647.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406200247.32303.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 of June 2004 01:00, Adolfo González Blázquez wrote:
> Hi,
>
> Sorry for the delay... I tried 2.5.50 and 2.5.75, and, at least for my
> machine, everything seems to be perfect. Then i tried every 2.6 kernel.
> All of them have the same buggy behaviour.

First of all thanks for doing this.

> These are the differences between 2.5.75 and 2.6.0 pdc202xx_old.c (sorry
> if this is not the correct format, im new here :)
>
> Hope this will help.
>
> Adolfo González
>
> ###################################################################
>
> --- linux-2.5.75/drivers/ide/pci/pdc202xx_old.c	2003-07-10
> 22:15:03.000000000 +0200
> +++ linux-2.6.0/drivers/ide/pci/pdc202xx_old.c	2003-12-18
> 03:59:53.000000000 +0100
> @@ -46,7 +46,6 @@
>  #include <asm/io.h>
>  #include <asm/irq.h>
>
> -#include "ide_modes.h"
>  #include "pdc202xx_old.h"
>
>  #define PDC202_DEBUG_CABLE	0
> @@ -519,13 +518,15 @@
>  		} else {
>  			goto fast_ata_pio;
>  		}
> +		return hwif->ide_dma_on(drive);
>  	} else if ((id->capability & 8) || (id->field_valid & 2)) {
>  fast_ata_pio:
>  no_dma_set:
>  		hwif->tuneproc(drive, 5);
>  		return hwif->ide_dma_off_quietly(drive);
>  	}
> -	return hwif->ide_dma_on(drive);
> +	/* IORDY not supported */
> +	return 0;
>  }
>
>  static int pdc202xx_quirkproc (ide_drive_t *drive)
> @@ -749,9 +750,6 @@
>  	hwif->tuneproc  = &config_chipset_for_pio;
>  	hwif->quirkproc = &pdc202xx_quirkproc;
>
> -	if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
> -		hwif->addressing = (hwif->channel) ? 0 : 1;
> -
>  	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
>  		hwif->busproc   = &pdc202xx_tristate;
>  		hwif->resetproc = &pdc202xx_reset;

In 2.6.0-test5 kernel we allowed LBA48 for PDC20265
(after few people reported that it works okay now)
but the same patch is also in 2.4 kernels.

There is one important 2.4 vs 2.6 difference here
- in 2.6 if the drive is using LBA48 we allow up
to 1024KiB large requests (you can check if this is
a problem by replacing "65536" by "256" in ide-probe.c).

The other likely candidate for breakage is kernel
2.6.0-test2 which contains DMA timeout fixes.

I can make some patches later in the meantime
somebody may test 2.6.0-test[1,2,4,5].

Cheers.

> @@ -928,7 +926,7 @@
>  	return 0;
>  }
>
> -static struct pci_device_id pdc202xx_pci_tbl[] __devinitdata = {
> +static struct pci_device_id pdc202xx_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 0},
>  	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 1},
>  	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20263, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 2},
>
> ###################################################################
>
> El sáb, 19-06-2004 a las 18:46, Bartlomiej Zolnierkiewicz escribió:
> > Hi,
> >
> > Any news about this issue?
> >
> > On Tuesday 15 of June 2004 13:33, you wrote:
> > > El mar, 15-06-2004 a las 13:15, Marcelo Tosatti escribió:
> > > > On Tue, Jun 15, 2004 at 01:20:03AM +0200, Adolfo González Blázquez wrote:
> > > > > El mar, 15-06-2004 a las 01:18, Bartlomiej Zolnierkiewicz escribió:
> > > > > > On Tuesday 15 of June 2004 00:50, Adolfo González Blázquez wrote:
> > > > > > > Hi!
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > > Lot of users are reporting seriour problems with pdc202xx_old
> > > > > > > ide pci driver. Enabling DMA on any device related with this
> > > > > > > driver makes the system unusable.
> > > > > > >
> > > > > > > This seems to happen in all the 2.6.x kernel series.
> > > > > >
> > > > > > Doing binary search on 2.4->2.6 kernels would help greatly
> > > > > > (narrowing problem to a specific kernel versions).
> > > > >
> > > > > If it helps, I tried 2.6.2, 2.6.4, 2.6.5, and 2.6.7-rc3, and all
> > > > > have the bug.
> > > >
> > > > And which kernels does not exhibit the problem?
> > >
> > > The 2.4 series it's ok, I'm gonna try with different 2.5.x kernels to
> > > see if i can discover when the bug was introduced

