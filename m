Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVLOUGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVLOUGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVLOUGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:06:30 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:41809 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751005AbVLOUGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:06:30 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Date: Thu, 15 Dec 2005 12:06:25 -0800
User-Agent: KMail/1.7.1
Cc: Vitaly Wool <vwool@ru.mvista.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A1118E.9040608@ru.mvista.com>
In-Reply-To: <43A1118E.9040608@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512151206.26515.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 10:47 pm, Vitaly Wool wrote:

> One cannot allocate memory in interrupt context, so the way to go is 
> allocating it on stack, thus the buffer is not DMA-safe.

kmalloc(..., GFP_ATOMIC) is the way to allocate memory in irq context.
It's done that way throughout the kernel.


> Making it DMA-safe in thread that does the very message processing is a 
> good way of overcoming this.

The rest of Linux appears to work fine without needing such mechanisms...

I really fail to see why you think SPI needs that.  USB isn't the only
counterexample, but it's particularly relevant since both USB and SPI
use asynchronous message passing over serial links ... and USB has a
rather complete driver stack over it.   (None of the USB based WLAN
drivers need those static buffers you worry about, by the way...)


> Using preallocated buffer is not a good way, since it may well be 
> already used by another interrupt or not yet processed by the worker 
> thread (or tasklet, or whatever).

We would call those "driver bugs" and expect patches.  :)


> The way it's done in this ads7846 driver  is not quite acceptable. 
> Losing the transfer if the previous one is still processed is *not* the 
> way to go in some cases.

That's not the way it works though.  And you seem to have made up
a "losing the transfer" failure mode out of whole cloth; I have no
idea where that came from.


> One can not predict how many transfers are  
> gonna be dropped due to "previous trransfer is being processed" problem, 
> it depends on the system load. And though it's not a problem for 
> touchscreen, it *will* be a problem if it were MMC, for instance.

Huh, well I've already seen one nice "mmc/sd over SPI" driver, using
a slightly earlier version of the framework than is found in mm3.
It's being used for root filesystems.

So demonstrably there is no problem for MMC/SD, either.

- Dave

