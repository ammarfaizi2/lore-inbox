Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTFXHwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 03:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTFXHwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 03:52:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263997AbTFXHwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 03:52:41 -0400
Date: Tue, 24 Jun 2003 10:06:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030624080641.GP7383@suse.de>
References: <20030623194514.GW6353@lug-owl.de> <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23 2003, Bartlomiej Zolnierkiewicz wrote:
> [ide] TCQ initialization fixes
> 
> - do not enable TCQ in ide_init_drive(), its too early
> - enable TCQ in __ide_dma_on() only if CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
> 
>  drivers/ide/ide-dma.c   |    8 ++++----
>  drivers/ide/ide-probe.c |    5 -----
>  include/linux/ide.h     |    1 -
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff -puN drivers/ide/ide-probe.c~ide-tcq-init-fixes drivers/ide/ide-probe.c
> --- linux-2.5.73/drivers/ide/ide-probe.c~ide-tcq-init-fixes	Mon Jun 23 23:10:11 2003
> +++ linux-2.5.73-root/drivers/ide/ide-probe.c	Mon Jun 23 23:10:11 2003
> @@ -983,7 +983,6 @@ static void ide_init_queue(ide_drive_t *
>  	 
>  	blk_init_queue(q, do_ide_request, &ide_lock);
>  	q->queuedata = HWGROUP(drive);
> -	drive->queue_setup = 1;
>  	blk_queue_segment_boundary(q, 0xffff);
>  
>  	if (!hwif->rqsize)
> @@ -1005,10 +1004,6 @@ static void ide_init_queue(ide_drive_t *
>  static void ide_init_drive(ide_drive_t *drive)
>  {
>  	ide_toggle_bounce(drive, 1);
> -
> -#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> -	HWIF(drive)->ide_dma_queued_on(drive);
> -#endif
>  }
>  
>  /*
> diff -puN drivers/ide/ide-dma.c~ide-tcq-init-fixes drivers/ide/ide-dma.c
> --- linux-2.5.73/drivers/ide/ide-dma.c~ide-tcq-init-fixes	Mon Jun 23 23:10:11 2003
> +++ linux-2.5.73-root/drivers/ide/ide-dma.c	Mon Jun 23 23:10:11 2003
> @@ -523,8 +523,7 @@ int __ide_dma_off_quietly (ide_drive_t *
>  	if (HWIF(drive)->ide_dma_host_off(drive))
>  		return 1;
>  
> -	if (drive->queue_setup)
> -		HWIF(drive)->ide_dma_queued_off(drive);
> +	HWIF(drive)->ide_dma_queued_off(drive);
>  
>  	return 0;
>  }
> @@ -585,8 +584,9 @@ int __ide_dma_on (ide_drive_t *drive)
>  	if (HWIF(drive)->ide_dma_host_on(drive))
>  		return 1;
>  
> -	if (drive->queue_setup)
> -		HWIF(drive)->ide_dma_queued_on(drive);
> +#ifdef BLK_DEV_IDE_TCQ_DEFAULT
> +	HWIF(drive)->ide_dma_queued_on(drive);
> +#endif
>  
>  	return 0;
>  }
> diff -puN include/linux/ide.h~ide-tcq-init-fixes include/linux/ide.h
> --- linux-2.5.73/include/linux/ide.h~ide-tcq-init-fixes	Mon Jun 23 23:10:11 2003
> +++ linux-2.5.73-root/include/linux/ide.h	Mon Jun 23 23:10:11 2003
> @@ -726,7 +726,6 @@ typedef struct ide_drive_s {
>  	unsigned ata_flash	: 1;	/* 1=present, 0=default */
>  	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
>  	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
> -	unsigned queue_setup	: 1;
>  	unsigned addressing;		/*      : 3;
>  					 *  0=28-bit
>  					 *  1=48-bit
> 
> _

Patch is nice and kills the ->queue_setup abomination, great.

-- 
Jens Axboe

