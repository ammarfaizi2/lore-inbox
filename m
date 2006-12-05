Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967131AbWLEXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967131AbWLEXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967745AbWLEXXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:23:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:14632 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966119AbWLEXXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:23:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jTv/2ihSK+jhwh7KwMr2u8WxeTS233DCYeb6q5HZVB7PhE1LSPDB+8N7wmwUoxKe8U87QiInJKxVGv+TUsUskUz9tPaIjoLAJgaUVXsMDIi/PtaNw1ARkQL4j73vLOJM52mww36QgM0WksQnwrSsAICZS9ONrV1fTLu0/IC1C/8=
Message-ID: <58cb370e0612051523t2feba049rae830c9fa593b1c1@mail.gmail.com>
Date: Wed, 6 Dec 2006 00:23:03 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org,
       "Jeff Garzik" <jgarzik@pobox.com>, "Tejun Heo" <htejun@gmail.com>
In-Reply-To: <20061204163057.2f27a12a@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061204163057.2f27a12a@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ added Jeff and Tejun to cc: ]

On 12/4/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> The ESB2 appears to emit spurious DMA interrupts when configured for
> native mode and handling ATAPI devices. Stratus were able to pin this bug
> down and produce a patch. This is a rework which applies the fixup only
> to the ESB2 (for now). We can apply it to other chips later if the same
> problem is found.

Looks good but aren't this trying to fix the same ICH
issue that is fixed in libata by ap->ops->irq_clear(ap)?

[ please see Tejun's mail: http://lkml.org/lkml/2006/11/15/94 ]

If so shouldn't we apply this fix for all ICH5/6/7/8 chipsets?

> This code has been tested and confirmed to fix the problem on the tested
> systems.

Also shouldn't the fix be in IRQ handler?  Currently the fix is limited
to ide-cd driver which seems to be the wrong place as the problem
is supposed to happen also when using other IDE device drivers
or/and other ATA/ATAPI devices?

> Signed-off-by: Alan Cox <alan@redhat.com>
> (Most of the hard work done by Stratus however)
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ide/ide-cd.c linux-2.6.19-rc6-mm1/drivers/ide/ide-cd.c
> --- linux.vanilla-2.6.19-rc6-mm1/drivers/ide/ide-cd.c   2006-11-24 13:58:06.000000000 +0000
> +++ linux-2.6.19-rc6-mm1/drivers/ide/ide-cd.c   2006-12-01 19:24:58.000000000 +0000
> @@ -687,8 +687,15 @@
>  static int cdrom_decode_status(ide_drive_t *drive, int good_stat, int *stat_ret)
>  {
>         struct request *rq = HWGROUP(drive)->rq;
> +       ide_hwif_t *hwif = HWIF(drive);
>         int stat, err, sense_key;
>
> +       /* We may have bogus DMA interrupts in PIO state here */
> +       if (HWIF(drive)->dma_status && hwif->atapi_irq_bogon) {
> +               stat = hwif->INB(hwif->dma_status);
> +               /* Should we force the bit as well ? */
> +               hwif->OUTB(stat, hwif->dma_status);
> +       }
>         /* Check for errors. */
>         stat = HWIF(drive)->INB(IDE_STATUS_REG);
>         if (stat_ret)
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.19-rc6-mm1/drivers/ide/pci/piix.c
> --- linux.vanilla-2.6.19-rc6-mm1/drivers/ide/pci/piix.c 2006-11-24 13:58:29.000000000 +0000
> +++ linux-2.6.19-rc6-mm1/drivers/ide/pci/piix.c 2006-12-01 19:20:46.000000000 +0000
> @@ -473,6 +473,10 @@
>                 /* This is a painful system best to let it self tune for now */
>                 return;
>         }
> +       /* ESB2 appears to generate spurious DMA interrupts in PIO mode
> +          when in native mode */
> +       if (hwif->pci_dev->device == PCI_DEVICE_ID_INTEL_ESB2_18)
> +               hwif->atapi_irq_bogon = 1;
>
>         hwif->autodma = 0;
>         hwif->tuneproc = &piix_tune_drive;
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/include/linux/ide.h linux-2.6.19-rc6-mm1/include/linux/ide.h
> --- linux.vanilla-2.6.19-rc6-mm1/include/linux/ide.h    2006-11-24 13:58:12.000000000 +0000
> +++ linux-2.6.19-rc6-mm1/include/linux/ide.h    2006-12-01 19:16:27.000000000 +0000
> @@ -796,6 +796,7 @@
>         unsigned        sg_mapped  : 1; /* sg_table and sg_nents are ready */
>         unsigned        no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
>         unsigned        err_stops_fifo : 1; /* 1=data FIFO is cleared by an error */
> +       unsigned        atapi_irq_bogon : 1; /* Generates spurious DMA interrupts in PIO mode */
>
>         struct device   gendev;
>         struct completion gendev_rel_comp; /* To deal with device release() */
