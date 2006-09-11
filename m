Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWIKXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWIKXoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWIKXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:44:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965141AbWIKXoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:44:20 -0400
Message-ID: <4505F4D0.7010901@garzik.org>
Date: Mon, 11 Sep 2006 19:44:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 08/19] dmaengine: enable multiple clients and operations
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> @@ -759,8 +755,10 @@ #endif
>  	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
>  	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
>  	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
> -	device->common.device_memcpy_complete = ioat_dma_is_complete;
> -	device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
> +	device->common.device_operation_complete = ioat_dma_is_complete;
> +	device->common.device_xor_pgs_to_pg = dma_async_xor_pgs_to_pg_err;
> +	device->common.device_issue_pending = ioat_dma_memcpy_issue_pending;
> +	device->common.capabilities = DMA_MEMCPY;


Are we really going to add a set of hooks for each DMA engine whizbang 
feature?

That will get ugly when DMA engines support memcpy, xor, crc32, sha1, 
aes, and a dozen other transforms.


> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c94d8f1..3599472 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -20,7 +20,7 @@
>   */
>  #ifndef DMAENGINE_H
>  #define DMAENGINE_H
> -
> +#include <linux/config.h>
>  #ifdef CONFIG_DMA_ENGINE
>  
>  #include <linux/device.h>
> @@ -65,6 +65,27 @@ enum dma_status {
>  };
>  
>  /**
> + * enum dma_capabilities - DMA operational capabilities
> + * @DMA_MEMCPY: src to dest copy
> + * @DMA_XOR: src*n to dest xor
> + * @DMA_DUAL_XOR: src*n to dest_diag and dest_horiz xor
> + * @DMA_PQ_XOR: src*n to dest_q and dest_p gf/xor
> + * @DMA_MEMCPY_CRC32C: src to dest copy and crc-32c sum
> + * @DMA_SHARE: multiple clients can use this channel
> + */
> +enum dma_capabilities {
> +	DMA_MEMCPY		= 0x1,
> +	DMA_XOR			= 0x2,
> +	DMA_PQ_XOR		= 0x4,
> +	DMA_DUAL_XOR		= 0x8,
> +	DMA_PQ_UPDATE		= 0x10,
> +	DMA_ZERO_SUM		= 0x20,
> +	DMA_PQ_ZERO_SUM		= 0x40,
> +	DMA_MEMSET		= 0x80,
> +	DMA_MEMCPY_CRC32C	= 0x100,

Please use the more readable style that explicitly lists bits:

	DMA_MEMCPY		= (1 << 0),
	DMA_XOR			= (1 << 1),
	...


> +/**
>   * struct dma_chan_percpu - the per-CPU part of struct dma_chan
>   * @refcount: local_t used for open-coded "bigref" counting
>   * @memcpy_count: transaction counter
> @@ -75,27 +96,32 @@ struct dma_chan_percpu {
>  	local_t refcount;
>  	/* stats */
>  	unsigned long memcpy_count;
> +	unsigned long xor_count;
>  	unsigned long bytes_transferred;
> +	unsigned long bytes_xor;

Clearly, each operation needs to be more compartmentalized.

This just isn't scalable, when you consider all the possible transforms.

	Jeff


