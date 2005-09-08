Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVIHPrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVIHPrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbVIHPro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:47:44 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:23341 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932666AbVIHPrl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:47:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=adVdYguoQvZZvK1i75sp6Tm3g0hb0UEOzhbXlBVIeYpJ/ruF1ZWg3ZEjA+eHrJH9rJn9ED2tWUmNVP1kyH7gxHqtiynBXPxOdoINYiW3jEmGeVC2/NOZvcmqOO39WYg+CgvKIdinyVVb6jOu8xinaE8vqDYwU1V1N+TfbDyUTK8=
Message-ID: <58cb370e05090808472f5e12e4@mail.gmail.com>
Date: Thu, 8 Sep 2005 17:47:38 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2.6.13] ide: ide-dma.c should always check hwif->cds before hwif->cds->foo
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       IDE Mailing List <linux-ide@vger.kernel.org>
In-Reply-To: <20050908151529.GL3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050908151529.GL3966@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/8/05, Tom Rini <trini@kernel.crashing.org> wrote:
> In some cases (such as the mips Toshiba TX4939 w/ onboard IDE, not PCI
> IDE), hwif->cds can be NULL, so test that prior to testing
> hwif->cds->foo

Both ide_iomio_dma() and ide_mapped_mmio_dma() are only called from
ide_dma_iobase().  ide_setup_dma() is the only user of ide_dma_iobase()
and it is supposed to be used only by IDE PCI drivers.

What is the reason for this change?

Bartlomiej

> Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Index: linux-2.6/drivers/ide/ide-dma.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-dma.c
> +++ linux-2.6/drivers/ide/ide-dma.c
> @@ -846,7 +846,7 @@ static int ide_mapped_mmio_dma(ide_hwif_
>         printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
> 
>         hwif->dma_base = base;
> -       if (hwif->cds->extra && hwif->channel == 0)
> +       if (hwif->cds && hwif->cds->extra && hwif->channel == 0)
>                 hwif->dma_extra = hwif->cds->extra;
> 
>         if(hwif->mate)
> @@ -865,7 +865,7 @@ static int ide_iomio_dma(ide_hwif_t *hwi
>                 return 1;
>         }
>         hwif->dma_base = base;
> -       if ((hwif->cds->extra) && (hwif->channel == 0)) {
> +       if (hwif->cds && hwif->cds->extra && (hwif->channel == 0)) {
>                 request_region(base+16, hwif->cds->extra, hwif->cds->name);
>                 hwif->dma_extra = hwif->cds->extra;
>         }
> 
> --
> Tom Rini
> http://gate.crashing.org/~trini/
