Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUL1UsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUL1UsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUL1UsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 15:48:20 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:29542 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261239AbUL1UsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 15:48:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BShfHkccRAkMyLTAqZSP0Ld/kqVNmeNmaLT7P2MfgEbyjo3bV0fEr2dyfH6sNQ7iJY2tjzO6kvApbVURNaEoe+Bc5vqi3V31Mta3CRG5kDbCfnRvgFkUzw7nEEJqBw5zN88I6dQrx3z/fcc+hsa1EYzBtV3ichsB8fnkJdDXHm0=
Message-ID: <58cb370e041228124878cb6e2a@mail.gmail.com>
Date: Tue, 28 Dec 2004 21:48:13 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10 - Still mishandles volumes without geometry data
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104155840.20898.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104155840.20898.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 13:57:20 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> An IDE device can choose not to report geometry. In this situation the
> base 2.6 kernel tries to verify the LBA data despite having nothing to
> validate it against and prints it out (although now only as pr_debug).
> 
> This patch fixes these problems and has in various forms been in
> 2.6.9-ac and Fedora Core for a considerable time now
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/ide/ide-disk.c linux-2.6.10/drivers/ide/ide-disk.c
> --- linux.vanilla-2.6.10/drivers/ide/ide-disk.c 2004-12-25 21:15:34.000000000 +0000
> +++ linux-2.6.10/drivers/ide/ide-disk.c 2004-12-26 21:55:43.084714368 +0000
> @@ -84,6 +84,10 @@
>  {
>         unsigned long lba_sects, chs_sects, head, tail;
> 
> +       /* No non-LBA info .. so valid! */
> +       if (id->cyls == 0)
> +               return 1;
> +
>         /*
>          * The ATA spec tells large drives to return
>          * C/H/S = 16383/16/63 independent of their size.
> @@ -201,7 +205,8 @@
>                 head  = track % drive->head;
>                 cyl   = track / drive->head;
> 
> -               pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
> +               if(drive->bios_cyl)
> +                       pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
> 
>                 hwif->OUTB(0x00, IDE_FEATURE_REG);
>                 hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);

Shouldn't this check be around printk in idedisk_setup() instead?
