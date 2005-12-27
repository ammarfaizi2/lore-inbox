Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVL0R2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVL0R2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVL0R2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:28:07 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:18261 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751129AbVL0R2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:28:03 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] SPI: add support for PNX/SPI controller
Date: Tue, 27 Dec 2005 09:25:28 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20051223171506.76aba97a.vwool@ru.mvista.com>
In-Reply-To: <20051223171506.76aba97a.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512270925.28806.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 6:15 am, Vitaly Wool wrote:
> (PNX0106 and PNX4008, namely) based on spi_bitbang library 

Good!  Does need work yet though...

> It's quite a notable thing that this buggy and in some way
> complicated SPI controller fits well in this bitbang framework! :)

So the transfer-level hooks worked for you ... I'm glad.


> This patch also contains dumb EEPROM driver for the onboard EEPROM
> behind the SPI bus. This driver was used by us for controller driver testing, mainly. 

It should still be a separate patch though.


>  # Add new SPI master controllers in alphabetical order above this line

Note how it says "above", yet you've added yours ... below!  :(


>  #
>  
> +config SPI_PNX
> +	tristate "PNX SPI bus support"
> +	depends on ARCH_PNX4008 && SPI_BITBANG

... also added the eeprom so it shows in the list of controller drivers!!


> +config SPI_EEPROM
> +	tristate "SPI EEPROM"
> +	depends on SPI
> +
>  

> +#define lock_device( dev )	/* down( &dev->sem ); */
> +#define unlock_device( dev )	/* up( &dev->sem );   */

Not clear why you'd want such stuff ... better to just remove
NOPs like that.



> +static void
> +spi_pnx_chipselect(struct spi_device *spi, int is_on)
> +{
> +	spipnx_arch_cs(spi, is_on);
> +}

I see that "arch" hook is actually just toggling a DMA line.
Did you notice how Stephen's PXA code handled that?  The
"controller_data" was a board-specific GPIO toggle function,
as provided in the board_info that implicitly defines the
relevant device.

Plus, activating the chip does more than just toggling some
arch-specific GPIO.  It has to set the right SPI mode, of
which CPOL must be set _before_ chipselect goes active.
And it has to set the transfer clock, for chips like yours
which are multiplexing devices using software.


> +static int spi_pnx_xfer(struct spi_device *spidev, struct spi_transfer *t)
> +{
...
> +	if (spidev->max_speed_hz)
> +		spi_pnx_set_clock_rate(spidev->max_speed_hz / 1000, regs);

Just do it the one time, when activating that chip's selection.


...
> +	if (t->tx_buf) {
> +		dat = (u8 *)t->tx_buf;
> +		regs->con |= SPIPNX_CON_RXTX;
> +		regs->ier |= SPIPNX_IER_EOT;
> +		regs->con &= ~SPIPNX_CON_SHIFT_OFF;
> +		regs->frm = len;
> +
> +		if (dd->dma_mode && len >= FIFO_CHUNK_SIZE) {
> +			void *dmasafe = NULL;
> +			if (t->tx_dma)

That's not actually correct, since zero might be a legal DMA address.
Unfortunately we have no DMA_ADDR_INVALID to test against, so this
will need to suffice for now.  (And I updated the spi_bitbang code
to ensure that address _is_ zeroed  when the message didn't set up
the DMA addresses already, matching the default behavior.)


> +				params.dma_buffer = t->tx_dma;
> +			else {
> +				dmasafe = kmalloc(len, SLAB_KERNEL);
> +				if (!dmasafe) {
> +					len = 0;
> +					goto out;
> +				}
> +				params.dma_buffer = dma_map_single(dev->parent, dmasafe, len, DMA_TO_DEVICE);
> +				memcpy(dmasafe, dat, len);

You do know this is incorrect don't you?  Call dma_map_single()
if you need a dma address.  The caller already guaranteed that the
input address is dma-safe.

...
> +	}
> +
> +	if (t->rx_buf) {
...
> +	}

That RX bit sure looks wrong to me ... as if, given an spi_transfer
with both TX and RX buffers, it will execute them in sequence (half
duplex) rather than concurrently (full duplex).  SPI is full duplex,
and this code should be too.  If it can't implement that, then it
should be reporting an error if both rx and tx are requested, rather
than doing the wrong thing.


> +static int spi_pnx_probe(struct device *device)

That should probably be marked __init ..

> +{
> +	struct spi_master	*master;
> +	struct spi_pnx_data	*data;
> +	struct spi_bitbang	*pnx;
> +	int rc = 0;
> +
> +	printk("spi probe called\n");
> +	master = spi_alloc_master(device, sizeof *data);
> +	if (!master) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	master->setup = &spi_pnx_setup;
> +	master->bus_num = to_platform_device(device)->id;
> +
> +	pnx = spi_master_get_devdata(master);
> +	pnx->master = master;
> +	pnx->chipselect = &spi_pnx_chipselect;
> +	pnx->txrx_bufs = &spi_pnx_xfer;
> +	rc = spi_bitbang_start(pnx);

You shouldn't start() it until it's fully set up, including
hardware being ready to go.


> +	if (rc < 0)
> +		goto out;
> +
> +	data = kzalloc(sizeof *data, GFP_KERNEL);

You don't need that kzalloc, it was already done for you by virtue of
your telling spi_alloc_master() to do so.  But then you saved that
memory into "pnx" not "data" (bug! wrong size!).  What you should be
doing is nesting your bitbang structure inside the "data" thing.


> +static int spi_pnx_remove(struct device *device)

Likewise, mark this __exit.  And I suspect you're using some kernel
older than 2.6.15-rc6 ... ;)

I notice your header file was mostly inline function declarations,
even for basic parts like clocking and DMA.  That's best as part
of the driver itself, if it's not following some framework like
the <asm/hardware/clock.h> API on ARM.

- Dave



