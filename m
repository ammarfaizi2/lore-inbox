Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWIKXwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWIKXwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWIKXwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:52:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4038 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965171AbWIKXwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:52:10 -0400
Message-ID: <4505F6A7.2000402@garzik.org>
Date: Mon, 11 Sep 2006 19:52:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 14/19] dmaengine: add dma_sync_wait
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231849.4737.90803.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231849.4737.90803.stgit@dwillia2-linux.ch.intel.com>
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
> dma_sync_wait is a common routine to live wait for a dma operation to
> complete.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  include/linux/dmaengine.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 9fd6cbd..0a70c9e 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -750,6 +750,18 @@ static inline void dma_async_unmap_singl
>  	chan->device->unmap_single(chan, handle, size, direction);
>  }
>  
> +static inline enum dma_status dma_sync_wait(struct dma_chan *chan,
> +						dma_cookie_t cookie)
> +{
> +	enum dma_status status;
> +	dma_async_issue_pending(chan);
> +	do {
> +		status = dma_async_operation_complete(chan, cookie, NULL, NULL);
> +	} while (status == DMA_IN_PROGRESS);
> +
> +	return status;

Where are the timeouts, etc.?  Looks like an infinite loop to me, in the 
worst case.

	Jeff



