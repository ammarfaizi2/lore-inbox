Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVKDXiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVKDXiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKDXiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:38:20 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:59573 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1751095AbVKDXiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:38:12 -0500
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Brownell <david-b@pacbell.net>
Cc: eemike@gmail.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200511041216.20301.david-b@pacbell.net>
References: <200511031615.22630.david-b@pacbell.net>
	 <1131130365.426.33.camel@localhost.localdomain>
	 <200511041216.20301.david-b@pacbell.net>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 04 Nov 2005 15:38:03 -0800
Message-Id: <1131147483.426.78.camel@localhost.localdomain>
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

On Fri, 2005-11-04 at 12:16 -0800, David Brownell wrote:
> I'd be confused.  They're both slave-specific ... and owned by
> the master/controller driver.

I'm using the spi_board_info.platform_data to pass configuration
information to the spi_device (slave) driver and
spi_board_info.controller_data to pass SPI bus configuration for the
specific slave device.  This allows different bus configurations for
each attached SPI device.  The following is a concrete example: 

/* CS8415A configuration information and board interface setup */
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

/* PXA2XX SPI bus setup for CS8415A */
static struct pxa2xx_spi_chip cs8415a_chip_info = {
	.tx_threshold = 12,
	.rx_threshold = 4,
	.dma_burst_size = 8,
	.timeout_microsecs = 64,
	.cs_control = cs8415a_cs_control,
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
};

IMHO the confusion is coming from the fact that struct spi_board_info is
being used to pass related, but implementation dependent, configuration
information to both the master and the slave simultaneously.  Maybe we
are asking spi_board_info to carry to much information?

> Instead, how about "controller_data" changing to match its role
> in board_info (static info, not dynamic), and "platform_data"
> becoming something like "controller_state"?  

If you mean spi_device.controller_data becomes
spi_device.controller_state, yes!

-Stephen

