Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWBGVRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWBGVRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWBGVRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:17:39 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:24005 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S965162AbWBGVRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:17:38 -0500
Subject: Re: [PATCH] spi: Add PXA2xx SSP SPI Driver
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Vrabel <dvrabel@arcom.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
In-Reply-To: <43E88970.2020107@arcom.com>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	 <43E88970.2020107@arcom.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Tue, 07 Feb 2006 13:17:34 -0800
Message-Id: <1139347054.4549.437.camel@localhost.localdomain>
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

On Tue, 2006-02-07 at 11:50 +0000, David Vrabel wrote:
> PXA27x has a clock speed of 13000000 Hz.
> 
Yea... And this affects the divisor calculation depending on type of CPU
and when the CPU is a PXA260 or PXA25x which SSP port.  And worse, the
SSP controller (as opposed to the NSSP/ASSP) on the PXA25x and PXA260
use a different divisor calculation:

Serial Bit Rate = SSP Port Clock / 2 / (SCR + 1)

The pxa_regs.h file is misleading and potentially inaccurate in this
respect.

> Consider spi->max_speed_hz == CLOCK_SPEED_HZ which gives a divisor of 3
> (when it should be 1).
> 
> You need SSCR0_SerClkDiv(CLOCK_SPEED_HZ / (spi->max_speed_hz + 1) + 1)
> for the correct divisor and for proper rounding.
Yes, but see qualification above.  I will fix this as you suggest, with
some modifications. FYI The CPU differences also exposed a similar
problem with the DMA setup.  Thanks!

> 
> > +	/* Attach to IRQ */
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq == 0) {
> > +		dev_err(&pdev->dev, "irq resource not defined\n");
> > +		status = -ENODEV;
> > +		goto out_error_master_alloc;
> > +	}
> 
> Greg K-H has a patch pending that makes platform_get_irq() return -ENXIO
> instead of 0 on error.  This is required for SSP3 on the PXA27x which
> uses IRQ 0.
> 
> > +	/* Release IRQ */
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq != 0)
> > +		free_irq(irq, drv_data);
> 
> Similarly.

Will do.

I will re-post the patch again to today.  Thanks for the help.

-Stephen

