Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVHHSvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVHHSvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVHHSvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:51:18 -0400
Received: from web30312.mail.mud.yahoo.com ([68.142.201.230]:21640 "HELO
	web30312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932194AbVHHSvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:51:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YUlTlgKAt2H8FisSdOePZOFlfj/OV7QXcwHDFhQeYmwwu1Kand5qkkJHEymFGWo7qlUKoUbTvx1+WLIyBIivJResvuDWIkIjACBNw8JkA7gcY/w0IZGVVJBaZt5xyo3JSQorcHbfOQB9m1NB6Y1+uV3D/7vcj6pRlfL10wc9+Ws=  ;
Message-ID: <20050808185111.37559.qmail@web30312.mail.mud.yahoo.com>
Date: Mon, 8 Aug 2005 19:51:11 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH] spi
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1123519315.4762.111.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- dmitry pervushin <dpervushin@gmail.com> wrote:

> 
> > Surely this should be locked with bus lock?
> Why not ? Until the transfer on device is not
> finished, the bus will be
> locked. Otherwise, the another device (on the same
> bus) might want to
> transfer something...

OK. My confusion was that we are also working on a SPI
subsystem which works in a different way.
Our SPI subsystem works much like the USB subsystem in
that drivers can queue up transfers and they will get
a callback when the transfer is complete.
Actually I think we have 4 modes of operation which
also allows transfers to be done in interrupt context,
with callback, wait for completion or high priority
(used to transfer high priority messages by bypassing
the transfer queue). I'll see if I can submit a patch
to the mailing list as I know its not only ideas but
code that counts ;-).


> > 
> > -= snip =-
> > 
> > Some other comments:
> > 1) I think you need to fix some of your comments
> > especially those describing how the interfaces
> work.
> > 2) I take it spi adaptor drivers now use
> > spi_bus_register/spi_bus_unregister?
> > 3) Different clients on one bus will want to run
> at
> > different speeds, how will you handle this?
> > 3) This subsystem can only handle small transfers
> like
> > I2C. SPI peripherals like SPI Ethernet devices
> will
> > have to do lots of large transfers and with your
> > current subsystem the device will be forced to
> wait
> > until its transfer has finished (as well as other
> > clients) when it might have other important work
> to
> > do.
> Hmm.. In the sample (it needs some polishing!), the
> bus initiates the
> DMA transfers and waits for completion on it. Do you
> want to have
> something like state machine (the function that will
> be called upon the
> end of transfer ?)

Yes, please see above.

> 
> 
>  Kconfig             |   12 +
>  Makefile            |    7
>  pnxalloc.c          |   70 ++++++
>  pnxalloc.h          |    9
>  spi-pnx010x_atmel.c |   91 ++++++++
>  spipnx-resources.h  |  138 ++++++++++++
>  spipnx.c            |  581
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
>  spipnx.h            |  309
> +++++++++++++++++++++++++++
>  8 files changed, 1455 insertions(+)
> 
> Index: linux-2.6.10/drivers/spi/spipnx-resources.h
>
===================================================================
> --- /dev/null
> +++ linux-2.6.10/drivers/spi/spipnx-resources.h
> @@ -0,0 +1,138 @@
> +#ifdef CONFIG_MACH_PNX0106_GH450
> +struct resource spipnx_010x_resources_0[] = 
> +{
> +	{ 
> +	  .start = BLAS_SPI0_BASE, 
> +	  .end = BLAS_SPI0_BASE + SZ_4K, 
> +	  .flags = IORESOURCE_MEM,
> +	}, { 
> +	  .start = SPI0_FIFO_DMA_SLAVE_NR, 
> +	  .flags = IORESOURCE_DMA,
> +	},
> +	/*
> +	 * Note that the clocks are shutdown in this order
> and resumed
> +	 * in the opposite order.
> +	 */
> +       	{ 
> +	  .start = CGU_SWITCHBOX_BLAS_SPI0_PCLK_ID, 
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	  .start = CGU_SWITCHBOX_BLAS_SPI0_PCLK_GAT_ID,
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	  .start = CGU_SWITCHBOX_BLAS_SPI0_FIFO_PCLK_ID,
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, { 
> +	   .start =
> CGU_SWITCHBOX_BLAS_SPI0_DUMMY_VPBCLK_ID, 
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	  .start = VH_INTC_INT_NUM_BLAS_SPI0_INT, 
> +	  .flags =  IORESOURCE_IRQ,
> +	}, {
> +	   .flags = 0,
> +	}
> +};
> +
> +struct resource spipnx_010x_resources_1[] = 
> +{
> +	{ 
> +	  .start = BLAS_SPI1_BASE, 
> +	  .end = BLAS_SPI1_BASE + SZ_4K, 
> +	  .flags = IORESOURCE_MEM,
> +	}, { 
> +	  .start = SPI1_FIFO_DMA_SLAVE_NR, 
> +	  .flags = IORESOURCE_DMA,
> +	}, 
> +	/*
> +	 * Note that the clocks are shutdown in this order
> and resumed
> +	 * in the opposite order.
> +	 */
> +	{ 
> +	  .start = CGU_SWITCHBOX_BLAS_SPI1_PCLK_ID, 
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, { 
> +	   .start = CGU_SWITCHBOX_BLAS_SPI1_PCLK_GAT_ID,
> +	   .flags = IORESOURCE_CLOCK_ID,
> +	}, { 
> +	  .start = CGU_SWITCHBOX_BLAS_SPI1_FIFO_PCLK_ID,
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	   .start =
> CGU_SWITCHBOX_BLAS_SPI1_DUMMY_VPBCLK_ID, 
> +	  .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	  .start = VH_INTC_INT_NUM_BLAS_SPI1_INT, 
> +	  .flags =  IORESOURCE_IRQ,
> +	}, {
> +	   .flags = 0,
> +	}
> +};
> +#endif
> +
> +#ifdef CONFIG_MACH_PNX0105_GH448
> +struct resource spipnx_010x_resources[] = 
> +{
> +	{ 
> +	  .start = BLAS_SPI_BASE, 
> +	  .end = BLAS_SPI_BASE + SZ_4K, 
> +	  .flags = IORESOURCE_MEM,
> +	}, { 
> +	  .start = BLAS_SPI_DMA_SLAVE_NR, 
> +	  .flags = IORESOURCE_DMA,
> +	}, 
> +	/*
> +	 * Note that the clocks are shutdown in this order
> and resumed
> +	 * in the opposite order.
> +	 */
> +	{
> +	   .start =  CGU_SWITCHBOX_BLAS_SPI_PCLK_ID,
> +	   .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	   .start = CGU_SWITCHBOX_BLAS_SPI_PCLK_GAT_ID,
> +	   .flags = IORESOURCE_CLOCK_ID,
> +	}, {
> +	   .start = CGU_SWITCHBOX_BLAS_SPI_FIFO_PCLK_ID,
> +	   .flags = IORESOURCE_CLOCK_ID,
> +	}, { 
> +	  .start = VH_INTC_INT_NUM_BLAS_SPI_INT, 
> +	  .flags =  IORESOURCE_IRQ,
> +	}, {
> +	   .flags = 0,
> +	}
> +};
> +#endif
> +
> +#ifdef CONFIG_ARCH_PNX4008
> +struct resource spipnx_4008_resources_0[] = 
> +{
> +	{ 	      
> +	  .start = PNX4008_SPI1_BASE, 
> +	  .end = PNX4008_SPI1_BASE + SZ_4K, 
> +	  .flags = IORESOURCE_MEM,
> +	}, { 
> +	  .start = 11 /* SPI1_DMA_PERIPHERAL_ID */, 
> +	  .flags = IORESOURCE_DMA,
> +	}, { 
> +	  .start = SPI1_INT, 
> +	  .flags =  IORESOURCE_IRQ,
> +	}, {
> +	   .flags = 0,
> +	}
> +};
> +
> +struct resource spipnx_4008_resources_1[] = 
> +{
> +	{ 	      
> +	  .start = PNX4008_SPI2_BASE, 
> +	  .end = PNX4008_SPI2_BASE + SZ_4K, 
> +	  .flags = IORESOURCE_MEM,
> +	}, { 
> +	  .start = 12 /* SPI2_DMA_PERIPHERAL_ID */, 
> +	  .flags = IORESOURCE_DMA,
> +	}, { 
> +	  .start = SPI2_INT, 
> +	  .flags =  IORESOURCE_IRQ,
> +	}, {
> +	   .flags = 0,
> +	}
> +};
> +#endif
> Index: linux-2.6.10/drivers/spi/spipnx.c
> 
=== message truncated ===



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
