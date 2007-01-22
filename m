Return-Path: <linux-kernel-owner+w=401wt.eu-S1750971AbXAVF3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbXAVF3p (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 00:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXAVF3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 00:29:45 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:49679 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbXAVF3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 00:29:44 -0500
Date: Mon, 22 Jan 2007 07:29:39 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
       Daniel.E.Messinger@seagate.com, Liran Schour <LIRANS@il.ibm.com>,
       Benny Halevy <bhalevy@panasas.com>
Subject: Re: [RFC 1/6] bidi support: request dma_data_direction
Message-ID: <20070122052938.GJ3531@rhun.ibm.com>
References: <45B3F578.7090109@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B3F578.7090109@panasas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2007 at 01:21:28AM +0200, Boaz Harrosh wrote:

> - Introduce a new enum dma_data_direction data_dir member in struct request.
>   and remove the RW bit from request->cmd_flag

Some architecture use 'enum dma_data_direction' and some 'int
dma_data_direction'. The consensus was to move to int over
time. Please use 'int dma_data_direction'.

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index ff203c4..abbca7b 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -13,6 +13,28 @@ enum dma_data_direction {
>  	DMA_NONE = 3,
>  };
> 
> +static inline int dma_write_dir(enum dma_data_direction dir)
> +{
> +	return (dir == DMA_TO_DEVICE) || (dir == DMA_BIDIRECTIONAL);
> +}

"write" can mean "write to device" or "write to memory", depending on
context. Not exactly something which should be a generic
helper. Rename to 'dma_to_device(int dir)'?

> +static inline int dma_uni_dir(enum dma_data_direction dir)
> +{
> +	return (dir == DMA_TO_DEVICE) || (dir == DMA_FROM_DEVICE) ||
> +	       (dir == DMA_NONE);
> +}

While this doesn't look very useful. Why is "DMA_NONE" a uni-dir? I
suggest replacing this with an open coded (dir != DMA_BIDIRECTIONAL).

Cheers,
Muli
