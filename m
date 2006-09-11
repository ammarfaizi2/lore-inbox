Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWIKXyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWIKXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWIKXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:54:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15046 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965180AbWIKXyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:54:15 -0400
Message-ID: <4505F722.1080207@garzik.org>
Date: Mon, 11 Sep 2006 19:54:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 15/19] dmaengine: raid5 dma client
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231854.4737.88026.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231854.4737.88026.stgit@dwillia2-linux.ch.intel.com>
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
> Adds a dmaengine client that is the hardware accelerated version of
> raid5_do_soft_block_ops.  It utilizes the raid5 workqueue implementation to
> operate on multiple stripes simultaneously.  See the iop-adma.c driver for
> an example of a driver that enables hardware accelerated raid5.
> 
> Changelog:
> * mark operations as _Dma rather than _Done until all outstanding
> operations have completed.  Once all operations have completed update the
> state and return it to the handle list
> * add a helper routine to retrieve the last used cookie
> * use dma_async_zero_sum_dma_list for checking parity which optionally
> allows parity check operations to not dirty the parity block in the cache
> (if 'disks' is less than 'MAX_ADMA_XOR_SOURCES')
> * remove dependencies on iop13xx
> * take into account the fact that dma engines have a staging buffer so we
> can perform 1 less block operation compared to software xor
> * added __arch_raid5_dma_chan_request __arch_raid5_dma_next_channel and
> __arch_raid5_dma_check_channel to make the driver architecture independent
> * added channel switching capability for architectures that implement
> different operations (i.e. copy & xor) on individual channels
> * added initial support for "non-blocking" channel switching
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/dma/Kconfig        |    9 +
>  drivers/dma/Makefile       |    1 
>  drivers/dma/raid5-dma.c    |  730 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/Kconfig         |   11 +
>  drivers/md/raid5.c         |   66 ++++
>  include/linux/dmaengine.h  |    5 
>  include/linux/raid/raid5.h |   24 +
>  7 files changed, 839 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 30d021d..fced8c3 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -22,6 +22,15 @@ config NET_DMA
>  	  Since this is the main user of the DMA engine, it should be enabled;
>  	  say Y here.
>  
> +config RAID5_DMA
> +        tristate "MD raid5: block operations offload"
> +	depends on INTEL_IOP_ADMA && MD_RAID456
> +	default y
> +	---help---
> +	  This enables the use of DMA engines in the MD-RAID5 driver to
> +	  offload stripe cache operations, freeing CPU cycles.
> +	  say Y here
> +
>  comment "DMA Devices"
>  
>  config INTEL_IOATDMA
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index bdcfdbd..4e36d6e 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
>  obj-$(CONFIG_NET_DMA) += iovlock.o
> +obj-$(CONFIG_RAID5_DMA) += raid5-dma.o
>  obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
> diff --git a/drivers/dma/raid5-dma.c b/drivers/dma/raid5-dma.c
> new file mode 100644
> index 0000000..04a1790
> --- /dev/null
> +++ b/drivers/dma/raid5-dma.c
> @@ -0,0 +1,730 @@
> +/*
> + * Offload raid5 operations to hardware RAID engines
> + * Copyright(c) 2006 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 59
> + * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + *
> + * The full GNU General Public License is included in this distribution in the
> + * file called COPYING.
> + */
> +
> +#include <linux/raid/raid5.h>
> +#include <linux/dmaengine.h>
> +
> +static struct dma_client *raid5_dma_client;
> +static atomic_t raid5_count;
> +extern void release_stripe(struct stripe_head *sh);
> +extern void __arch_raid5_dma_chan_request(struct dma_client *client);
> +extern struct dma_chan *__arch_raid5_dma_next_channel(struct dma_client *client);
> +
> +#define MAX_HW_XOR_SRCS 16
> +
> +#ifndef STRIPE_SIZE
> +#define STRIPE_SIZE PAGE_SIZE
> +#endif
> +
> +#ifndef STRIPE_SECTORS
> +#define STRIPE_SECTORS		(STRIPE_SIZE>>9)
> +#endif
> +
> +#ifndef r5_next_bio
> +#define r5_next_bio(bio, sect) ( ( (bio)->bi_sector + ((bio)->bi_size>>9) < sect + STRIPE_SECTORS) ? (bio)->bi_next : NULL)
> +#endif
> +
> +#define DMA_RAID5_DEBUG 0
> +#define PRINTK(x...) ((void)(DMA_RAID5_DEBUG && printk(x)))
> +
> +/*
> + * Copy data between a page in the stripe cache, and one or more bion
> + * The page could align with the middle of the bio, or there could be
> + * several bion, each with several bio_vecs, which cover part of the page
> + * Multiple bion are linked together on bi_next.  There may be extras
> + * at the end of this list.  We ignore them.
> + */
> +static dma_cookie_t dma_raid_copy_data(int frombio, struct bio *bio,
> +		     dma_addr_t dma, sector_t sector, struct dma_chan *chan,
> +		     dma_cookie_t cookie)
> +{
> +	struct bio_vec *bvl;
> +	struct page *bio_page;
> +	int i;
> +	int dma_offset;
> +	dma_cookie_t last_cookie = cookie;
> +
> +	if (bio->bi_sector >= sector)
> +		dma_offset = (signed)(bio->bi_sector - sector) * 512;
> +	else
> +		dma_offset = (signed)(sector - bio->bi_sector) * -512;
> +	bio_for_each_segment(bvl, bio, i) {
> +		int len = bio_iovec_idx(bio,i)->bv_len;
> +		int clen;
> +		int b_offset = 0;
> +
> +		if (dma_offset < 0) {
> +			b_offset = -dma_offset;
> +			dma_offset += b_offset;
> +			len -= b_offset;
> +		}
> +
> +		if (len > 0 && dma_offset + len > STRIPE_SIZE)
> +			clen = STRIPE_SIZE - dma_offset;
> +		else clen = len;
> +
> +		if (clen > 0) {
> +			b_offset += bio_iovec_idx(bio,i)->bv_offset;
> +			bio_page = bio_iovec_idx(bio,i)->bv_page;
> +			if (frombio)
> +				do {
> +					cookie = dma_async_memcpy_pg_to_dma(chan,
> +								dma + dma_offset,
> +								bio_page,
> +								b_offset,
> +								clen);
> +					if (cookie == -ENOMEM)
> +						dma_sync_wait(chan, last_cookie);
> +					else
> +						WARN_ON(cookie <= 0);
> +				} while (cookie == -ENOMEM);
> +			else
> +				do {
> +					cookie = dma_async_memcpy_dma_to_pg(chan,
> +								bio_page,
> +								b_offset,
> +								dma + dma_offset,
> +								clen);
> +					if (cookie == -ENOMEM)
> +						dma_sync_wait(chan, last_cookie);
> +					else
> +						WARN_ON(cookie <= 0);
> +				} while (cookie == -ENOMEM);
> +		}
> +		last_cookie = cookie;
> +		if (clen < len) /* hit end of page */
> +			break;
> +		dma_offset +=  len;
> +	}
> +
> +	return last_cookie;
> +}
> +
> +#define issue_xor() do {					          \
> +			 do {					          \
> +			 	cookie = dma_async_xor_dma_list_to_dma(   \
> +			 		sh->ops.dma_chan,	          \
> +			 		xor_destination_addr,	          \
> +			 		dma,			          \
> +			 		count,			          \
> +			 		STRIPE_SIZE);		          \
> +			 	if (cookie == -ENOMEM)		          \
> +			 		dma_sync_wait(sh->ops.dma_chan,	  \
> +			 			sh->ops.dma_cookie);      \
> +			 	else				          \
> +			 		WARN_ON(cookie <= 0);	          \
> +			 } while (cookie == -ENOMEM);		          \
> +			 sh->ops.dma_cookie = cookie;		          \
> +			 dma[0] = xor_destination_addr;			  \
> +			 count = 1;					  \
> +			} while(0)
> +#define check_xor() do {						\
> +			if (count == MAX_HW_XOR_SRCS)			\
> +				issue_xor();				\
> +		     } while (0)
> +
> +#ifdef CONFIG_RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH
> +extern struct dma_chan *__arch_raid5_dma_check_channel(struct dma_chan *chan,
> +						dma_cookie_t cookie,
> +						struct dma_client *client,
> +						unsigned long capabilities);
> +
> +#ifdef CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE
> +#define check_channel(cap, bookmark) do {			     \
> +bookmark:							     \
> +	next_chan = __arch_raid5_dma_check_channel(sh->ops.dma_chan, \
> +						sh->ops.dma_cookie,  \
> +						raid5_dma_client,    \
> +						(cap));		     \
> +	if (!next_chan) {					     \
> +		BUG_ON(sh->ops.ops_bookmark);			     \
> +		sh->ops.ops_bookmark = &&bookmark;		     \
> +		goto raid5_dma_retry;				     \
> +	} else {						     \
> +		sh->ops.dma_chan = next_chan;			     \
> +		sh->ops.dma_cookie = dma_async_get_last_cookie(	     \
> +							next_chan);  \
> +		sh->ops.ops_bookmark = NULL;			     \
> +	}							     \
> +} while (0)
> +#else
> +#define check_channel(cap, bookmark) do {			     \
> +bookmark:							     \
> +	next_chan = __arch_raid5_dma_check_channel(sh->ops.dma_chan, \
> +						sh->ops.dma_cookie,  \
> +						raid5_dma_client,    \
> +						(cap));		     \
> +	if (!next_chan) {					     \
> +		dma_sync_wait(sh->ops.dma_chan, sh->ops.dma_cookie); \
> +		goto bookmark;					     \
> +	} else {						     \
> +		sh->ops.dma_chan = next_chan;			     \
> +		sh->ops.dma_cookie = dma_async_get_last_cookie(	     \
> +							next_chan);  \
> +	}							     \
> +} while (0)
> +#endif /* CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE */
> +#else
> +#define check_channel(cap, bookmark) do { } while (0)
> +#endif /* CONFIG_RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH */

The above seems a bit questionable and overengineered.

Linux mantra:  Do What You Must, And No More.

In this case, just code and note that it's IOP-specific.  Don't bother 
to support cases that doesn't exist yet.


> + * dma_do_raid5_block_ops - perform block memory operations on stripe data
> + * outside the spin lock with dma engines
> + *
> + * A note about the need for __arch_raid5_dma_check_channel:
> + * This function is only needed to support architectures where a single raid
> + * operation spans multiple hardware channels.  For example on a reconstruct
> + * write, memory copy operations are submitted to a memcpy channel and then
> + * the routine must switch to the xor channel to complete the raid operation.
> + * __arch_raid5_dma_check_channel makes sure the previous operation has
> + * completed before returning the new channel.
> + * Some efficiency can be gained by putting the stripe back on the work
> + * queue rather than spin waiting.  This code is a work in progress and is
> + * available via the 'broken' option CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE.
> + * If 'wait via requeue' is not defined the check_channel macro live waits
> + * for the next channel.
> + */
> +static void dma_do_raid5_block_ops(void *stripe_head_ref)
> +{

Another way-too-big function that should be split up.


