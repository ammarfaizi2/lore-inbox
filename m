Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWBGLuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWBGLuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWBGLuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:50:18 -0500
Received: from webapps.arcom.com ([194.200.159.168]:38160 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S965044AbWBGLuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:50:17 -0500
Message-ID: <43E88970.2020107@arcom.com>
Date: Tue, 07 Feb 2006 11:50:08 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stephen@streetfiresound.com
CC: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] spi: Add PXA2xx SSP SPI Driver
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
In-Reply-To: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2006 11:55:04.0187 (UTC) FILETIME=[551564B0:01C62BDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stephen@streetfiresound.com wrote:
> From: Stephen Street <stephen@streetfiresound.com>
> 
> The driver turns a PXA2xx synchronous serial port (SSP) into a SPI master 
> controller (see Documentation/spi/spi_summary). The driver has the following
> features:

I've not tested this on my PXA27x platform yet (I'll try and get this
done this tomorrow) but a few comments.

> --- linux-2.6.16-rc2/drivers/spi/pxa2xx_spi.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-spi/drivers/spi/pxa2xx_spi.c	2006-02-06 18:39:45.339334630 -0800


> +#define CLOCK_SPEED_HZ 3686400

PXA27x has a clock speed of 13000000 Hz.

> +	chip->cr0 = SSCR0_SerClkDiv((CLOCK_SPEED_HZ / spi->max_speed_hz) + 2)

Consider spi->max_speed_hz == CLOCK_SPEED_HZ which gives a divisor of 3
(when it should be 1).

You need SSCR0_SerClkDiv(CLOCK_SPEED_HZ / (spi->max_speed_hz + 1) + 1)
for the correct divisor and for proper rounding.

> +	/* Attach to IRQ */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq == 0) {
> +		dev_err(&pdev->dev, "irq resource not defined\n");
> +		status = -ENODEV;
> +		goto out_error_master_alloc;
> +	}

Greg K-H has a patch pending that makes platform_get_irq() return -ENXIO
instead of 0 on error.  This is required for SSP3 on the PXA27x which
uses IRQ 0.

> +	/* Release IRQ */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq != 0)
> +		free_irq(irq, drv_data);

Similarly.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
