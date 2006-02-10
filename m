Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWBJXuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWBJXuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWBJXuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:50:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWBJXue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:50:34 -0500
Date: Fri, 10 Feb 2006 15:49:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: stephen@streetfiresound.com
Cc: linux-kernel@vger.kernel.org, dvrabel@arcom.com, david-b@pacbell.net,
       spi-devel-general@lists.sourceforge.net, nico@cam.org
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
Message-Id: <20060210154928.583db9e2.akpm@osdl.org>
In-Reply-To: <1139612861.30189.126.camel@ststephen.streetfiresound.com>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	<1139535480.30189.30.camel@ststephen.streetfiresound.com>
	<20060209181841.73e5d0b2.akpm@osdl.org>
	<1139612861.30189.126.camel@ststephen.streetfiresound.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Street <stephen@streetfiresound.com> wrote:
>
> ...
> > > +		unmap_dma_buffers(drv_data);
> > > +
> > > +		/* Calculate number of trailing bytes, read them */
> > > +		trailing_sssr = SSP_REG(sssr);
> > > +		if ((trailing_sssr & 0xf008) != 0xf000) {
> > > +			drv_data->rx = drv_data->rx_end -
> > > +					(((trailing_sssr >> 12) & 0x0f) + 1);
> > > +			drv_data->read(drv_data);
> > > +		}
> > > +		msg->actual_length += drv_data->len;
> > > +
> > > +		/* Release chip select if requested, transfer delays are
> > > +		 * handled in pump_transfers */
> > > +		if (drv_data->cs_change)
> > > +			drv_data->cs_control(PXA2XX_CS_DEASSERT);
> > > +
> > > +		/* Move to next transfer */
> > > +		msg->state = next_transfer(drv_data);
> > > +
> > > +		/* Schedule transfer tasklet */
> > > +		tasklet_schedule(&drv_data->pump_transfers);
> > > +
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > > +	/* Never Fail */
> > 
> > WARN_ON(1)?
> > 
> > Why not return IRQ_NONE here?  That way, the IRQ system will save the
> > machine if the IRQ gets stuck.
> > 
> In my generally confused state I decided that if the IRQ handler ran
> then by definition I handled the interrupt. But thats probably not
> right.  Will change.

Yes, IRQ_NONE means "I don't have a clue why this IRQ handler was called -
none of my device registers indicate that anything needs servicing".

The core kernel IRQ handling will see that as a signal that perhaps the
hardware is busted and ultimately it will disable the entire IRQ line so
the machine can continue to struggle along.

> > This all looks very non-64-bit-capable.
> Just the null_dma_buf issue or something more?

Well, yes, that expression.  Generally if you get all the types right and
avoid typecasting, the compiler will shout at you about 64-bit-brokenness.

> > > +#ifdef CONFIG_PM
> > > +static int stall_queue(struct driver_data *drv_data)
> > > +{
> > > +	unsigned long flags;
> > > +	unsigned limit = 500;
> > > +
> > > +	spin_lock_irqsave(&drv_data->lock, flags);
> > > +
> > > +	drv_data->run = QUEUE_STALLED;
> > > +
> > > +	while (drv_data->busy && limit--) {
> > > +		spin_unlock_irqrestore(&drv_data->lock, flags);
> > > +		msleep(10);
> > > +		spin_lock_irqsave(&drv_data->lock, flags);
> > > +	}
> > 
> > That looks a bit lame.  What's happening here?
> Sort of dumb, I agree.  I interpreted PM_EVENT_FREEZE to mean that I
> should stop processing the internal message queue but leave the queue
> intact so that it can be restarted. "stall_queue" does this by setting
> the run flag to QUEUE_STALLED (checked in pump_messages) and waiting for
> the busy to indicate the idle state.  I considered using an wait_queue
> but this seemed to much for to little.  Would you prefer a wait_queue?
> 

I guess a waitqueue would be nicer.  I don't recall seeing drivers doing
anything really fancy like this in response to a suspend request though. 

