Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUA0PKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUA0PKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:10:35 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58847 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263796AbUA0PKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:10:33 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Glenn Wurster <gwurster@scs.carleton.ca>
Subject: Re: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Date: Tue, 27 Jan 2004 16:14:40 +0100
User-Agent: KMail/1.5.3
Cc: Alan Cox <alan@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
References: <20040123183245.GB853@desktop> <200401240045.56966.bzolnier@elka.pw.edu.pl> <20040127055206.GA690@electric.ath.cx>
In-Reply-To: <20040127055206.GA690@electric.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401271614.40542.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 of January 2004 06:52, Glenn Wurster wrote:
> > Glenn, your patch hides potential problems - these functions shouldn't be
> > called if host doesn't support DMA.  However there is one place when
> > ->ide_dma_host_off() shouldn't be called unconditionally, here is a
> > patch. It is not pretty but at least consistent - we check
> > hwif->ide_dma_check to see if DMA is supported in other places too.  Does
> > it fix the problem?
>
> Not quite.  If we go forward with a patch like that, then it must be
> updated to include at least two other places that I know of

Doh.  I overlooked one place.
IMO this check needs to be added only to two places.

> immediately.  The updated patch would be something similar to the one
> at the bottom of this e-mail.

Did you test this patch?

> On a further note, how should hdparm -d behave on my controller, the
> relivant lines from dmesg are:
>
> SIS5513: IDE controller at PCI slot 00:01.1
> SIS5513: chipset revision 8
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS551x ATA 16 controller
>     ide0: BM-DMA at 0xf870-0xf877, BIOS settings: hda:pio, hdb:pio
> SIS5513: simplex device: DMA disabled
> ide1: SIS5513 Bus-Master DMA disabled (BIOS)
> hda: WDC AC21000H, ATA DISK drive
> hdc: Maxtor 6Y080L0, ATA DISK drive
>
> "hdparm -d 1 /dev/hdc" returns an operation not permitted, but "hdparm
> -d 1 /dev/hda" is successful and results in future calls to "hdparm -d
> 1 /dev/hdc" seemingly locking the computer.

I suspect that this is caused by unfinished handling of simplex devices
in setup-pci.c (simplex host - one DMA engine but two channels).

> @@ -980,10 +981,13 @@
>  	drive->id->dma_1word &= ~0x0F00;
>
>  #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
> -	if (speed >= XFER_SW_DMA_0)
> -		hwif->ide_dma_host_on(drive);
> -	else
> -		hwif->ide_dma_off_quietly(drive);
> +	if (speed >= XFER_SW_DMA_0) {
> +		if (hwif->ide_dma_check) /* Check if host supports DMA */
> +			hwif->ide_dma_host_on(drive);

I've seen this and decided that it is not needed.

If we try to program drives to DMA on non-DMA host
something is going wrong and it is better to just OOPS.

> +	} else {
> +		if (hwif->ide_dma_check) /* Check if host supports DMA */
> +			hwif->ide_dma_off_quietly(drive);
> +	}

Yep, I've missed this one.

Thanks,
--bart

