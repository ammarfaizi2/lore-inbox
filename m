Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWIKXuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWIKXuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWIKXuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:50:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56517 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965166AbWIKXuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:50:10 -0400
Message-ID: <4505F62D.2000006@garzik.org>
Date: Mon, 11 Sep 2006 19:50:05 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 11/19] dmaengine: add memset as an asynchronous dma operation
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231833.4737.27198.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231833.4737.27198.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Changelog:
> * make the dmaengine api EXPORT_SYMBOL_GPL
> * zero sum support should be standalone, not integrated into xor
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/dma/dmaengine.c   |   15 ++++++++++
>  drivers/dma/ioatdma.c     |    5 +++
>  include/linux/dmaengine.h |   68 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index e78ce89..fe62237 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -604,6 +604,17 @@ dma_cookie_t dma_async_do_xor_err(struct
>  	return -ENXIO;
>  }
>  
> +/**
> + * dma_async_do_memset_err - default function for dma devices that
> + *      do not support memset
> + */
> +dma_cookie_t dma_async_do_memset_err(struct dma_chan *chan,
> +                union dmaengine_addr dest, unsigned int dest_off,
> +                int val, size_t len, unsigned long flags)
> +{
> +        return -ENXIO;
> +}
> +
>  static int __init dma_bus_init(void)
>  {
>  	mutex_init(&dma_list_mutex);
> @@ -621,6 +632,9 @@ EXPORT_SYMBOL_GPL(dma_async_memcpy_pg_to
>  EXPORT_SYMBOL_GPL(dma_async_memcpy_dma_to_dma);
>  EXPORT_SYMBOL_GPL(dma_async_memcpy_pg_to_dma);
>  EXPORT_SYMBOL_GPL(dma_async_memcpy_dma_to_pg);
> +EXPORT_SYMBOL_GPL(dma_async_memset_buf);
> +EXPORT_SYMBOL_GPL(dma_async_memset_page);
> +EXPORT_SYMBOL_GPL(dma_async_memset_dma);
>  EXPORT_SYMBOL_GPL(dma_async_xor_pgs_to_pg);
>  EXPORT_SYMBOL_GPL(dma_async_xor_dma_list_to_dma);
>  EXPORT_SYMBOL_GPL(dma_async_operation_complete);
> @@ -629,6 +643,7 @@ EXPORT_SYMBOL_GPL(dma_async_device_regis
>  EXPORT_SYMBOL_GPL(dma_async_device_unregister);
>  EXPORT_SYMBOL_GPL(dma_chan_cleanup);
>  EXPORT_SYMBOL_GPL(dma_async_do_xor_err);
> +EXPORT_SYMBOL_GPL(dma_async_do_memset_err);
>  EXPORT_SYMBOL_GPL(dma_async_chan_init);
>  EXPORT_SYMBOL_GPL(dma_async_map_page);
>  EXPORT_SYMBOL_GPL(dma_async_map_single);
> diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
> index 0159d14..231247c 100644
> --- a/drivers/dma/ioatdma.c
> +++ b/drivers/dma/ioatdma.c
> @@ -637,6 +637,10 @@ extern dma_cookie_t dma_async_do_xor_err
>  	union dmaengine_addr src, unsigned int src_cnt,
>  	unsigned int src_off, size_t len, unsigned long flags);
>  
> +extern dma_cookie_t dma_async_do_memset_err(struct dma_chan *chan,
> +	union dmaengine_addr dest, unsigned int dest_off,
> +	int val, size_t size, unsigned long flags);
> +
>  static dma_addr_t ioat_map_page(struct dma_chan *chan, struct page *page,
>  					unsigned long offset, size_t size,
>  					int direction)
> @@ -748,6 +752,7 @@ #endif
>  	device->common.capabilities = DMA_MEMCPY;
>  	device->common.device_do_dma_memcpy = do_ioat_dma_memcpy;
>  	device->common.device_do_dma_xor = dma_async_do_xor_err;
> +	device->common.device_do_dma_memset = dma_async_do_memset_err;
>  	device->common.map_page = ioat_map_page;
>  	device->common.map_single = ioat_map_single;
>  	device->common.unmap_page = ioat_unmap_page;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index cb4cfcf..8d53b08 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -260,6 +260,7 @@ struct dma_chan_client_ref {
>   * @device_issue_pending: push appended descriptors to hardware
>   * @device_do_dma_memcpy: perform memcpy with a dma engine
>   * @device_do_dma_xor: perform block xor with a dma engine
> + * @device_do_dma_memset: perform block fill with a dma engine
>   */
>  struct dma_device {
>  
> @@ -284,6 +285,9 @@ struct dma_device {
>  			union dmaengine_addr src, unsigned int src_cnt,
>  			unsigned int src_off, size_t len,
>  			unsigned long flags);
> +	dma_cookie_t (*device_do_dma_memset)(struct dma_chan *chan,
> +			union dmaengine_addr dest, unsigned int dest_off,
> +			int value, size_t len, unsigned long flags);

Same comment as for XOR:  adding operations in this way just isn't scalable.

Operations need to be more compartmentalized.

Maybe a client could do:

	struct adma_transaction adma_xact;

	/* fill in hooks with XOR-specific info */
	init_XScale_xor(adma_device, &adma_xact, my_completion_func);

	/* initiate transaction */	
	adma_go(&adma_xact);

	/* callback signals completion asynchronously */

