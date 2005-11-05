Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKEC2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKEC2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 21:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKEC2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 21:28:53 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:46036 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1750776AbVKEC2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 21:28:52 -0500
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Brownell <david-b@pacbell.net>
Cc: eemike@gmail.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200511041654.47109.david-b@pacbell.net>
References: <200511031615.22630.david-b@pacbell.net>
	 <200511041216.20301.david-b@pacbell.net>
	 <1131147483.426.78.camel@localhost.localdomain>
	 <200511041654.47109.david-b@pacbell.net>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 04 Nov 2005 18:28:48 -0800
Message-Id: <1131157728.426.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
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

On Fri, 2005-11-04 at 16:54 -0800, David Brownell wrote:
> That's not what I thought we were talking about. Stepping back, what's
> confusing is that there are three different kinds of per-device data,
> and the names are used inconsistently:
> 
>   spi_device.dev.platform_data ... from board_info.platform_data
> 	This is for the driver of the spi_device ... board-specific
> 	data that'd be the same for PXA or OMAP or PPC805 or whatever
> 
>   spi_device.platform_data ... from board_info.controller_data
> 	This is static controller-specific information, which you were
> 	using for things like chipselect functions and fifo tuning.
> 	(I had proposed to name this as "controller_data" in the
> 	spi_device too.)

Yes.

>  
>   spi_device.controller_data ... runtime state for the controller
> 	This is dynamic controller-specific information, which you
> 	were using for things like copies of register settings that
> 	set up clock speed and SPI mode for the device.
> 	(I had proposed to rename this as "controller_state".)
> 

My understanding also.  Let's at least do the renames.

> Now as for board_info.controller_data and its clone in spi_device,
> how about if I just delete that ... so that it'd be provided in the
> platform_device.dev.platform_data for the controller?  That'd also
> let you substitute a typed pointer for a void* one, usually a sign
> of goodness.
> 

This is where I am having the problem. I'm resisting removing the
board_info.controller_data (or what ever we decide to call it) because
the current code makes it easy to the have different master settings
(fifo threshold, chip select control) for each spi_device attached to
the master. If we move this to the platform_device.dev.platform_data
this then the master will have to maintain a table indexed by the
chip_select to track the per spi_device master configuration
information.

On the other hand if this is too confusing, then let make the API
simpler and the implementation more complex.  Your call.

Bigger code snippet from my board init.

static struct cs8415a_platform_data cs8415a_platform_info = {
	.enabled = 0,
	.muted = 1,
	.channel = 0,
	.pll_lock_delay = 100,
	.irq_flags = SA_SHIRQ,
	.mask_interrupt = cs8415a_mask_interrupt,
	.unmask_interrupt = cs8415a_unmask_interrupt,
	.service_requested = cs8415a_service_requested,
};

static struct pxa2xx_spi_chip cs8415a_chip_info = {
	.tx_threshold = 12,
	.rx_threshold = 4,
	.dma_burst_size = 8,
	.timeout_microsecs = 64,
	.cs_control = cs8415a_cs_control,
};

static struct pxa2xx_spi_chip cs8405a_chip_info = {
	.tx_threshold = 12,
	.rx_threshold = 4,
	.dma_burst_size = 8,
	.timeout_microsecs = 64,
	.cs_control = cs8405a_cs_control,
};

static struct pxa2xx_spi_chip cs4341_chip_info = {
	.tx_threshold = 8,
	.rx_threshold = 8,
	.timeout_microsecs = 1000,
	.cs_control = cs4341_cs_control,
};

static struct spi_board_info streetracer_spi_board_info[] __initdata = {
	{
		.modalias = "cs8415a",
		.max_speed_hz = 3686400,
		.bus_num = 2,
		.chip_select = 0,
		.platform_data = &cs8415a_platform_info,
		.controller_data = &cs8415a_chip_info,
		.irq = STREETRACER_APCI_IRQ,
	},
	{
		.modalias = "cs8405a",
		.max_speed_hz = 3686400,
		.bus_num = 2,
		.chip_select = 1,
		.controller_data = &cs8405a_chip_info,
		.irq = STREETRACER_APCI_IRQ,
	},
	{
		.modalias = "cs4341",
		.max_speed_hz = 3686400,
		.bus_num = 2,
		.chip_select = 2,
		.controller_data = &cs4341_chip_info,
	},
};

Occupying some spare cycles is the idea that what we really need is the
ability to sub-class spi_device and spi_master via structure embedding.
This would be in the spirit of the 2.6 driver model and would map to the
platform_device model better.  It would however, mean losing the
spi_board_info structure.  Feel free to take a large hammer to me, if
this is really off base.

-Stephen




