Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUJJAla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUJJAla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUJJAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:41:30 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:56055 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S267928AbUJJAl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:41:27 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Date: Sun, 10 Oct 2004 02:42:39 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041005142001.GR2433@suse.de>
In-Reply-To: <20041005142001.GR2433@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410100242.39249.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ linux-ide MIA ]

On Tuesday 05 October 2004 16:20, Jens Axboe wrote:
> Hi,
> 
> The blacklist stuff is broken. When set_using_dma() calls into
> ide_dma_check(), it returns ide_dma_off() for a blacklisted drive. This
> of course succeeds, returning success to the caller of ide_dma_check().
> Not so good... It then uncondtionally calls ide_dma_on(), which turns on
> dma for the drive.

- s/ide_dma_check/->ide_dma_check/
- s/ide_dma_off/__ide_dma_off/

> This moves the check to ide_dma_on() so we also catch the buggy
> ->ide_dma_check() defined by various chipset drivers.

Yep, good catch.

> --- drivers/ide/ide-dma.c~	2004-10-05 16:11:49.631910586 +0200
> +++ drivers/ide/ide-dma.c	2004-10-05 16:21:58.828330845 +0200
> @@ -354,11 +355,13 @@
>  	struct hd_driveid *id = drive->id;
>  	ide_hwif_t *hwif = HWIF(drive);
>  
> -	if ((id->capability & 1) && hwif->autodma) {
> -		/* Consult the list of known "bad" drives */
> -		if (__ide_dma_bad_drive(drive))
> -			return __ide_dma_off(drive);
> +	/* Consult the list of known "bad" drives */
> +	if (__ide_dma_bad_drive(drive)) {
> +		__ide_dma_off(drive);
> +		return 1;
> +	}
>  
> +	if ((id->capability & 1) && hwif->autodma) {
>  		/*
>  		 * Enable DMA on any drive that has
>  		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled

Is __ide_dma_bad_drive() check still needed?
Doesn't __ide_dma_on() fix handle this now?

> @@ -512,6 +515,9 @@
>   
>  int __ide_dma_on (ide_drive_t *drive)
>  {
> +	if (__ide_dma_bad_drive(drive))
> +		return 1;
> +
>  	drive->using_dma = 1;
>  	ide_toggle_bounce(drive, 1);
>  
