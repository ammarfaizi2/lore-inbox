Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVKDSLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVKDSLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKDSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:11:43 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:3297 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1750766AbVKDSLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:11:42 -0500
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Mike Lee <eemike@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1ffb4b070511030137o345049d2o5ed5e020c96e022d@mail.gmail.com>
References: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
	 <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
	 <1130431260.22836.19.camel@localhost.localdomain>
	 <1ffb4b070510291125j1fad2362xe40843f7719c611d@mail.gmail.com>
	 <1130870131.10324.51.camel@localhost.localdomain>
	 <1ffb4b070511030137o345049d2o5ed5e020c96e022d@mail.gmail.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 04 Nov 2005 10:11:38 -0800
Message-Id: <1131127898.426.8.camel@localhost.localdomain>
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

On Thu, 2005-11-03 at 17:37 +0800, Mike Lee wrote: 
> Actually, i am now available to use your loopback driver on my SPI
> controller driver. But only limited to PIO mode, and i get stuck on
> DMA mode because of trigger problem of SPI module, I am now trying
> very hard to solve that.

I had problems get the DMA buffers aligned correctly.

> 
> In my driver, there is a little bug that i could not rmmod the driver.
> it will stop at unregistering device. Below is a debug msg dump. it
> seem to stop at down_write(&device_subsys.rwsem) in device_del
> ------------------------------------------------------------
> /mnt/tmpfs/tmp # insmod imx_spi.ko
> bus platform: add driver imx-spi
> CLASS: registering class device: ID = 'spi1'
> imx-spi imx-spi.0: registered master spi1
>  spi1.1-loopback: setup finish
> DEV: registering device: ID = 'spi1.1-loopback'
> bus spi: add device spi1.1-loopback
> imx-spi imx-spi.0: registered child spi1.1-loopback
> bound device 'imx-spi.0' to driver 'imx-spi'
> CLASS: registering class device: ID = 'spi2'
> imx-spi imx-spi.1: registered master spi2
> bound device 'imx-spi.1' to driver 'imx-spi'
> /mnt/tmpfs/tmp # rmmod imx_spi.ko
> bus platform: remove driver imx-spi
> DEV: Unregistering device. ID = 'spi1.1-loopback'
> 
> ------------------------------------------------------------
> 
I'm not sure what the problem is.  What kernel version are you using?
Changes are continuing in the driver model which can affect module
unloading.

> 
> Some question on SPI subsystem:
> I really get confused on the structure on the whole system. e.g. the
> platform_data and controller_data in board_info.  What are thier
> purposes?

A little confusing I agree.  Keep in mind that in a typical SPI setup
there is one SPI master (i.MX) connected to one or more SPI slaves
(external chips).  You will have a device_driver for the master and a
device_driver for each SPI slave. So...

The platform_data contains configuration information for the SPI slave
device_driver and the controller data contain configuration information
for the SPI master device_driver which is specific to an individual SPI
Slave.  This allows the SPI master to configure itself differently on
the fly, for each chip connected to it.

Here is code snippet from my board init

static struct resource pxa_spi_resources[] = {
	[0] = {
		.start	= __PREG(SSCR0_P(2)),
		.end	= __PREG(SSCR0_P(2)) + 0x2c,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= IRQ_NSSP,
		.end	= IRQ_NSSP,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct pxa2xx_spi_master pxa_nssp_master_info = {
	.ssp_type = PXA25x_NSSP,
	.clock_enable = CKEN9_NSSP,
	.num_chipselect = 4,
	.enable_dma = 1,
};

static struct platform_device pxa_spi_ssp = {
	.name = "pxa2xx-spi-ssp",
	.id = 2,
	.resource = pxa_spi_resources,
	.num_resources = ARRAY_SIZE(pxa_spi_resources),
	.dev = {
		.platform_data = &pxa_nssp_master_info,
	},
};

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
	.tx_threshold = 8,
	.rx_threshold = 8,
	.dma_burst_size = 8,
	.timeout_microsecs = 64,
	.cs_control = cs8415a_cs_control,
};

static struct pxa2xx_spi_chip cs8405a_chip_info = {
	.tx_threshold = 12,
	.rx_threshold = 4,
	.dma_burst_size = 8,
	.timeout_microsecs = 64,
};

static struct pxa2xx_spi_chip cs4341_chip_info = {
	.tx_threshold = 12,
	.rx_threshold = 4,
	.timeout_microsecs = 128,
};

static struct pxa2xx_spi_chip loopback_chip_info = {
	.tx_threshold = 12,
	.rx_threshold = 4,
	.dma_burst_size = 8,
	.timeout_microsecs = 64,
	.enable_loopback = 1,
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
	{
		.modalias = "loopback",
		.max_speed_hz = 3686400,
		.bus_num = 2,
		.chip_select = 3,
		.controller_data = &loopback_chip_info,
	},
};

> Also i found that spi_register_board_info is declared as __init, that
> mean i can not register board info as a module, is it because there is
> no 'real' probe on SPI bus? (this comsume me time to reflash my board
> to debug)

Correct no real probe, but.... see 

extern struct spi_device *spi_new_device(struct spi_master *, struct spi_board_info *);

in spi.h for creating new spi_device on the fly or in a module.


> I know that SDIO could have a SPI mode. Could SPI subsystem be used to
> control SDIO device?

No clue, sorry.

> Sorry for my annoying questions.

No problem! Happy to help out.  What external chip are you talking to?

-Stephen


