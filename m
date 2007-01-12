Return-Path: <linux-kernel-owner+w=401wt.eu-S1161056AbXALJzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbXALJzW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbXALJzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:55:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41343 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161053AbXALJzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:55:20 -0500
Date: Fri, 12 Jan 2007 10:06:41 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] ide: use PIO/MMIO operations directly where
 possible
Message-ID: <20070112100641.02858876@localhost.localdomain>
In-Reply-To: <20070112042807.28794.8251.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	<20070112042807.28794.8251.sendpatchset@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 05:28:07 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> [PATCH] ide: use PIO/MMIO operations directly where possible
> 
> This results in smaller/faster/simpler code and allows future optimizations.
> Also remove no longer needed ide[_mm]_{inl,outl}() and ide_hwif_t.{INL,OUTL}.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> --- a.orig/drivers/ide/ide-dma.c
> +++ a/drivers/ide/ide-dma.c
> @@ -565,7 +565,10 @@ int ide_dma_setup(ide_drive_t *drive)
>  	}
>  
>  	/* PRD table */
> -	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
> +	if (hwif->mmio == 2)
> +		writel(hwif->dmatable_dma, (void __iomem *)hwif->dma_prdtable);
> +	else
> +		outl(hwif->dmatable_dma, hwif->dma_prdtable);


This should simply be if (hwif->mmio)

mmio = 1 is still used by some amiga and other oddments and indicates
mmio in old form. I don't think this causes a bug as they don't use the
DMA layer, but its a bug waiting to happen if the mmio==1 case doesn't
get handled correctly or BUG()

Alan
