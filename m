Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVCCGzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVCCGzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVCCGyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:54:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30868 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261179AbVCCGti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:49:38 -0500
Date: Thu, 3 Mar 2005 07:49:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH ide-dev-2.6] ide: ide_dma_intr oops fix
Message-ID: <20050303064925.GB19505@suse.de>
References: <20050303030318.GA25410@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303030318.GA25410@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03 2005, Tejun Heo wrote:
>  Hello, Bartlomiej.
> 
>  This patch fixes ide_dma_intr() oops which occurs for TASKFILE ioctl
> using DMA dataphses.  This is against the latest ide-dev-2.6 tree +
> all your recent 9 patches.
> 
>  Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Index: linux-taskfile-ng/drivers/ide/ide-dma.c
> ===================================================================
> --- linux-taskfile-ng.orig/drivers/ide/ide-dma.c	2005-03-03 11:59:16.485582413 +0900
> +++ linux-taskfile-ng/drivers/ide/ide-dma.c	2005-03-03 12:00:07.753376048 +0900
> @@ -175,10 +175,14 @@ ide_startstop_t ide_dma_intr (ide_drive_
>  	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
>  		if (!dma_stat) {
>  			struct request *rq = HWGROUP(drive)->rq;
> -			ide_driver_t *drv;
>  
> -			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
> -			drv->end_request(drive, 1, rq->nr_sectors);
> +			if (rq->rq_disk) {
> +				ide_driver_t *drv;
> +
> +				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
> +				drv->end_request(drive, 1, rq->nr_sectors);
> +			} else
> +				ide_end_request(drive, 1, rq->nr_sectors);
>  			return ide_stopped;
>  		}
>  		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 

Why not just set rq_disk for taskfile requests as well, seems a lot
cleaner than special casing the end_request handling.

-- 
Jens Axboe

