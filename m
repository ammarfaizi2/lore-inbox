Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWBJXHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBJXHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWBJXHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:07:45 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:8926 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S932241AbWBJXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:07:45 -0500
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dvrabel@arcom.com,
       David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, nico@cam.org
In-Reply-To: <20060209181841.73e5d0b2.akpm@osdl.org>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	 <1139535480.30189.30.camel@ststephen.streetfiresound.com>
	 <20060209181841.73e5d0b2.akpm@osdl.org>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 10 Feb 2006 15:07:41 -0800
Message-Id: <1139612861.30189.126.camel@ststephen.streetfiresound.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 18:18 -0800, Andrew Morton wrote:
> Driver looks pretty clean.  It's refreshingly deviod of comments ;)
Thanks. Add more comments?  I got scared of over commenting as a result
of reading the kernel code style document.

> > +static void null_writer(struct driver_data *drv_data)
> > +{
> > +	u32 sssr = drv_data->sssr;
> > +	u32 ssdr = drv_data->ssdr;
> > +	u8 n_bytes = drv_data->cur_chip->n_bytes;
> > +
> > +	while ((SSP_REG(sssr) & SSSR_TNF)
> > +			&& (drv_data->tx < drv_data->tx_end)) {
> > +		SSP_REG(ssdr) = 0;
> > +		drv_data->tx += n_bytes;
> > +	}
> > +}
> 
> hm.
> 
> 	#define SSP_REG(x) (*((volatile unsigned long *)x))
> 
> what's this doing?  Accessing a device register?  Cannot we use readl/writel?
> 
Just following the pattern in include/asm-arm/arch-pxa/pxa_regs.h
Nicolas made a similar comment. I'm changing it now.

> > +		*(u32 *)(drv_data->null_dma_buf) = 0;
> 
> null_dma_buf gets typecast a lot.  Maybe make it a u32*?
Yes.

> > +	/* PXA255x_SSP has no timeout interrupt, wait for tailing bytes */
> > +	if ((drv_data->ssp_type == PXA25x_SSP)
> > +		&& (channel == drv_data->tx_channel)
> > +		&& (irq_status & DCSR_ENDINTR)) {
> > +
> > +		/* Wait for rx to stall */
> > +		while (SSP_REG(sssr) & SSSR_BSY)
> > +			cpu_relax();
> 
> A timeout here, perhaps?
> 
> > +		while (!(DCSR(drv_data->rx_channel) & DCSR_STOPSTATE))
> > +			cpu_relax();
> 
Ok, but if a SSP or the DMA channel never stops then the CPU is probably
toast anywise.

> > +		unmap_dma_buffers(drv_data);
> > +
> > +		/* Calculate number of trailing bytes, read them */
> > +		trailing_sssr = SSP_REG(sssr);
> > +		if ((trailing_sssr & 0xf008) != 0xf000) {
> > +			drv_data->rx = drv_data->rx_end -
> > +					(((trailing_sssr >> 12) & 0x0f) + 1);
> > +			drv_data->read(drv_data);
> > +		}
> > +		msg->actual_length += drv_data->len;
> > +
> > +		/* Release chip select if requested, transfer delays are
> > +		 * handled in pump_transfers */
> > +		if (drv_data->cs_change)
> > +			drv_data->cs_control(PXA2XX_CS_DEASSERT);
> > +
> > +		/* Move to next transfer */
> > +		msg->state = next_transfer(drv_data);
> > +
> > +		/* Schedule transfer tasklet */
> > +		tasklet_schedule(&drv_data->pump_transfers);
> > +
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	/* Never Fail */
> 
> WARN_ON(1)?
> 
> Why not return IRQ_NONE here?  That way, the IRQ system will save the
> machine if the IRQ gets stuck.
> 
In my generally confused state I decided that if the IRQ handler ran
then by definition I handled the interrupt. But thats probably not
right.  Will change.

> > +static void cleanup(const struct spi_device *spi)
> > +{
> > +	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
> 
> Remove the typecast, change spi_get_ctldata() to take a const struct
> spi_device *?  I guess that might cause warnings too - the compiler might
> want spi_get_ctldata() to return a const thing.
> 
I will talk with David about this.  Maybe the right answer is changing
the cleanup function signiture.

> > +	drv_data->null_dma_buf = drv_data + sizeof(struct driver_data);
> > +	drv_data->null_dma_buf = (void *)(((u32)(drv_data->null_dma_buf)
> > +					 & 0xfffffff8) | 8);
> 
> Consider using the ALIGN() macro here.
> 
I been looking for someway to due this for weeks and now I found it.
THANKS!

> This all looks very non-64-bit-capable.
Just the null_dma_buf issue or something more?

> > +#ifdef CONFIG_PM
> > +static int stall_queue(struct driver_data *drv_data)
> > +{
> > +	unsigned long flags;
> > +	unsigned limit = 500;
> > +
> > +	spin_lock_irqsave(&drv_data->lock, flags);
> > +
> > +	drv_data->run = QUEUE_STALLED;
> > +
> > +	while (drv_data->busy && limit--) {
> > +		spin_unlock_irqrestore(&drv_data->lock, flags);
> > +		msleep(10);
> > +		spin_lock_irqsave(&drv_data->lock, flags);
> > +	}
> 
> That looks a bit lame.  What's happening here?
Sort of dumb, I agree.  I interpreted PM_EVENT_FREEZE to mean that I
should stop processing the internal message queue but leave the queue
intact so that it can be restarted. "stall_queue" does this by setting
the run flag to QUEUE_STALLED (checked in pump_messages) and waiting for
the busy to indicate the idle state.  I considered using an wait_queue
but this seemed to much for to little.  Would you prefer a wait_queue?


> > +	spin_unlock_irqrestore(&drv_data->lock, flags);
> > +
> > +	if (!list_empty(&drv_data->queue) || drv_data->busy)
> > +		return -EBUSY;
> 
> Does the list_empty() make sense outside the lock?
Badness

Thanks for the through review!

Stephen

