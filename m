Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVLaKLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLaKLo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLaKLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:11:44 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:33033
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932116AbVLaKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:11:44 -0500
Date: Sat, 31 Dec 2005 02:01:24 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Chris Ross <lak1646@tebibyte.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] Don't panic on IDE DMA errors
In-Reply-To: <20051128122239.GB24608@logos.cnet>
Message-ID: <Pine.LNX.4.10.10512310158530.22711-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What was the panic base on error?
It should have aborted the request and block resends it.
However, the logic seems sane and if the request is lost on error this
would corrupt if it did not panic.

Is there a clear way to reproduce this in a controlled manner?

IE the goal would be to test data integerity on the events.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 28 Nov 2005, Marcelo Tosatti wrote:

> 
> 
> diff-tree e8f3e8dd41308fb66c026f51bb86b23205ad48c1 (from 0b85d6aa75faefe28d90362424035ef7b349974c)
> Author: Chris Ross <lak1646@tebibyte.org>
> Date:   Wed Nov 23 15:56:00 2005 +0000
> 
>     [PATCH] Don't panic on IDE DMA errors
>     
>     Kernel 2.4.32 and earlier can panic when trying to read a corrupted
>     sector from an IDE disk.
>     
>     The function ide_dma_timeout_retry can end a request early by calling
>     idedisk_error, but then goes on to use the request anyway causing a
>     kernel panic due to a null pointer exception. This patch fixes that.
> 
> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index 3f6a0aa..6fc6f77 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -899,11 +899,13 @@ static ide_startstop_t ide_dma_timeout_r
>  	rq = HWGROUP(drive)->rq;
>  	HWGROUP(drive)->rq = NULL;
>  
> -	rq->errors = 0;
> -	rq->sector = rq->bh->b_rsector;
> -	rq->current_nr_sectors = rq->bh->b_size >> 9;
> -	rq->hard_cur_sectors = rq->current_nr_sectors;
> -	rq->buffer = rq->bh->b_data;
> +	if (rq) {
> +		rq->errors = 0;
> +		rq->sector = rq->bh->b_rsector;
> +		rq->current_nr_sectors = rq->bh->b_size >> 9;
> +		rq->hard_cur_sectors = rq->current_nr_sectors;
> +		rq->buffer = rq->bh->b_data;
> +	}
>  
>  	return ret;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

