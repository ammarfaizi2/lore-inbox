Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVK1RvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVK1RvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVK1RvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:51:04 -0500
Received: from hera.kernel.org ([140.211.167.34]:21993 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932138AbVK1RvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:51:03 -0500
Date: Mon, 28 Nov 2005 10:06:02 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Ross <lak1646@tebibyte.org>
Cc: Andre Hedrick <andre@linux-ide.org>, Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] 2.4.32 Don't panic on IDE DMA errors
Message-ID: <20051128120602.GA24532@logos.cnet>
References: <43849110.2070806@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43849110.2070806@tebibyte.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks Chris.

On Wed, Nov 23, 2005 at 03:56:00PM +0000, Chris Ross wrote:
> Kernel 2.4.32 and earlier can panic when trying to read a corrupted 
> sector from an IDE disk.
> 
> The function ide_dma_timeout_retry can end a request early by calling 
> idedisk_error, but then goes on to use the request anyway causing a 
> kernel panic due to a null pointer exception. This patch fixes that.
> 
> Regards,
> Chris R.
> 
> 
> diff -urN -X dontdiff linux-2.4.32/drivers/ide/ide-io.c 
> patched-linux-2.4.32/drivers/ide/ide-io.c
> --- linux-2.4.32/drivers/ide/ide-io.c	2003-11-28 18:26:20.000000000 +0000
> +++ patched-linux-2.4.32/drivers/ide/ide-io.c	2005-11-23 
> 12:33:37.000000000 +0000
> @@ -899,11 +899,13 @@
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
