Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVKDUg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKDUg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVKDUg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:36:26 -0500
Received: from web36901.mail.mud.yahoo.com ([209.191.85.69]:48521 "HELO
	web36901.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750721AbVKDUg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:36:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G40Wn3qeHOIf1xmIZnrBrBn3n2eTXAJWGhAAY6FNcBt/QiQlRFzMzSK6Qwa5NUGKi1y2Vc+jcSkkCX1xvjiyOnlliX/UTH05tx+iD3CQSbdJbzblh2vNggAbhc3CG8weXuYFZJOsoFtEy9xHUHvxRrcabRM/BDEqk1Mg65F6ltY=  ;
Message-ID: <20051104203623.42911.qmail@web36901.mail.mud.yahoo.com>
Date: Fri, 4 Nov 2005 20:36:22 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
To: stephen@streetfiresound.com, Mike Lee <eemike@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131127898.426.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Stephen Street <stephen@streetfiresound.com> wrote:

> On Thu, 2005-11-03 at 17:37 +0800, Mike Lee wrote: 
> > Actually, i am now available to use your loopback driver on my SPI
> > controller driver. But only limited to PIO mode, and i get stuck on
> > DMA mode because of trigger problem of SPI module, I am now trying
> > very hard to solve that.
> 
> I had problems get the DMA buffers aligned correctly.
> 
> > 
> > In my driver, there is a little bug that i could not rmmod the driver.
> > it will stop at unregistering device. Below is a debug msg dump. it
> > seem to stop at down_write(&device_subsys.rwsem) in device_del
> > ------------------------------------------------------------
> > /mnt/tmpfs/tmp # insmod imx_spi.ko
> > bus platform: add driver imx-spi
> > CLASS: registering class device: ID = 'spi1'
> > imx-spi imx-spi.0: registered master spi1
> >  spi1.1-loopback: setup finish
> > DEV: registering device: ID = 'spi1.1-loopback'
> > bus spi: add device spi1.1-loopback
> > imx-spi imx-spi.0: registered child spi1.1-loopback
> > bound device 'imx-spi.0' to driver 'imx-spi'
> > CLASS: registering class device: ID = 'spi2'
> > imx-spi imx-spi.1: registered master spi2
> > bound device 'imx-spi.1' to driver 'imx-spi'
> > /mnt/tmpfs/tmp # rmmod imx_spi.ko
> > bus platform: remove driver imx-spi
> > DEV: Unregistering device. ID = 'spi1.1-loopback'
> > 
> > ------------------------------------------------------------
> > 
> I'm not sure what the problem is.  What kernel version are you using?
> Changes are continuing in the driver model which can affect module
> unloading.

I'm working on this problem. The first issue is that the spi_unregister_master calls
device_for_each_child which takes the devices lock and then in the __unregister routine goes on to
unregister a device which also tries to take the devices lock and hey presto your stuck :(. This
problem was easy to solve, but I now seem to be stuck in device_unregister where it gets and then
puts the reference to the device. It looks like someone is still holding the spi_master but I
haven't had time to find out where (or if problem is in my adapter driver ;).

An update on your work would be great David, I have some comments to go with your last patch but
wanted to finish my adapter driver and spi_device driver first.

Mark

> 
> > 
> > Some question on SPI subsystem:
> > I really get confused on the structure on the whole system. e.g. the
> > platform_data and controller_data in board_info.  What are thier
> > purposes?
> 
> A little confusing I agree.  Keep in mind that in a typical SPI setup
> there is one SPI master (i.MX) connected to one or more SPI slaves
> (external chips).  You will have a device_driver for the master and a
> device_driver for each SPI slave. So...
> 
> The platform_data contains configuration information for the SPI slave
> device_driver and the controller data contain configuration information
> for the SPI master device_driver which is specific to an individual SPI
> Slave.  This allows the SPI master to configure itself differently on
> the fly, for each chip connected to it.
> 
> Here is code snippet from my board init
> 
> static struct resource pxa_spi_resources[] = {
> 	[0] = {
> 		.start	= __PREG(SSCR0_P(2)),
> 		.end	= __PREG(SSCR0_P(2)) + 0x2c,
> 		.flags	= IORESOURCE_MEM,
> 	},
> 	[1] = {
> 		.start	= IRQ_NSSP,
> 		.end	= IRQ_NSSP,
> 		.flags	= IORESOURCE_IRQ,
> 	},
> };
> 
> static struct pxa2xx_spi_master pxa_nssp_master_info = {
> 	.ssp_type = PXA25x_NSSP,
> 	.clock_enable = CKEN9_NSSP,
> 	.num_chipselect = 4,
> 	.enable_dma = 1,
> };
> 
> static struct platform_device pxa_spi_ssp = {
> 	.name = "pxa2xx-spi-ssp",
> 	.id = 2,
> 	.resource = pxa_spi_resources,
> 	.num_resources = ARRAY_SIZE(pxa_spi_resources),
> 	.dev = {
> 		.platform_data = &pxa_nssp_master_info,
> 	},
> };
> 
> static struct cs8415a_platform_data cs8415a_platform_info = {
> 	.enabled = 0,
> 	.muted = 1,
> 	.channel = 0,
> 	.pll_lock_delay = 100,
> 	.irq_flags = SA_SHIRQ,
> 	.mask_interrupt = cs8415a_mask_interrupt,
> 	.unmask_interrupt = cs8415a_unmask_interrupt,
> 	.service_requested = cs8415a_service_requested,
> };
> 
> static struct pxa2xx_spi_chip cs8415a_chip_info = {
> 	.tx_threshold = 8,
> 	.rx_threshold = 8,
> 	.dma_burst_size = 8,
> 	.timeout_microsecs = 64,
> 	.cs_control = cs8415a_cs_control,
> };
> 
> static struct pxa2xx_spi_chip cs8405a_chip_info = {
> 	.tx_threshold = 12,
> 	.rx_threshold = 4,
> 	.dma_burst_size = 8,
> 	.timeout_microsecs = 64,
> };
> 
> static struct pxa2xx_spi_chip cs4341_chip_info = {
> 	.tx_threshold = 12,
> 	.rx_threshold = 4,
> 	.timeout_microsecs = 128,
> };
> 
> static struct pxa2xx_spi_chip loopback_chip_info = {
> 	.tx_threshold = 12,
> 	.rx_threshold = 4,
> 	.dma_burst_size = 8,
> 	.timeout_microsecs = 64,
> 	.enable_loopback = 1,
> };
> 
> static struct spi_board_info streetracer_spi_board_info[] __initdata = {
> 	{
> 		.modalias = "cs8415a",
> 		.max_speed_hz = 3686400,
> 		.bus_num = 2,
> 		.chip_select = 0,
> 		.platform_data = &cs8415a_platform_info,
> 		.controller_data = &cs8415a_chip_info,
> 		.irq = STREETRACER_APCI_IRQ,
> 	},
> 	{
> 		.modalias = "cs8405a",
> 		.max_speed_hz = 3686400,
> 		.bus_num = 2,
> 		.chip_select = 1,
> 		.controller_data = &cs8405a_chip_info,
> 		.irq = STREETRACER_APCI_IRQ,
> 	},
> 	{
> 		.modalias = "cs4341",
> 		.max_speed_hz = 3686400,
> 		.bus_num = 2,
> 		.chip_select = 2,
> 		.controller_data = &cs4341_chip_info,
> 	},
> 	{
> 		.modalias = "loopback",
> 		.max_speed_hz = 3686400,
> 		.bus_num = 2,
> 		.chip_select = 3,
> 		.controller_data = &loopback_chip_info,
> 	},
> };
> 
> > Also i found that spi_register_board_info is declared as __init, that
> > mean i can not register board info as a module, is it because there is
> > no 'real' probe on SPI bus? (this comsume me time to reflash my board
> > to debug)
> 
> Correct no real probe, but.... see 
> 
> extern struct spi_device *spi_new_device(struct spi_master *, struct spi_board_info *);
> 
> in spi.h for creating new spi_device on the fly or in a module.
> 
> 
> > I know that SDIO could have a SPI mode. Could SPI subsystem be used to
> > control SDIO device?
> 
> No clue, sorry.
> 
> > Sorry for my annoying questions.
> 
> No problem! Happy to help out.  What external chip are you talking to?
> 
> -Stephen
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
Does your mail provider give you FREE antivirus protection? 
Get Yahoo! Mail http://uk.mail.yahoo.com
