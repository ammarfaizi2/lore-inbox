Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWJBSAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWJBSAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWJBSAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:00:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965199AbWJBR76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:59:58 -0400
Date: Mon, 2 Oct 2006 10:59:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: "Andrea Paterniani" <a.paterniani@swapp-eng.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Message-Id: <20061002105951.e892ccda.akpm@osdl.org>
In-Reply-To: <200610020816.58985.david-b@pacbell.net>
References: <200610020816.58985.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 08:16:58 -0700
David Brownell <david-b@pacbell.net> wrote:

> Subject: SPI controller driver for Freescale iMX
> From: Andrea Paterniani <a.paterniani@swapp-eng.it>
> 
> This patch adds a SPI controller driver for the Freescale i.MX(S/L/1).
> The code is inspired by pxa2xx_spi driver.  Main features summary:
>  -  Per chip setup via board specific code and/or protocol driver.
>  -  Per transfer setup.
>  -  PIO transfers.
>  -  DMA transfers.
>  -  Managing of NULL tx / rx buffer for rd only / wr only transfers.
> 
> ...
>
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/ioport.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/spi/spi.h>
> +#include <linux/workqueue.h>
> +#include <linux/errno.h>

we already did that include.

> +
> +#define DEFINE_SPI_REG_RD(reg, off)			\
> +	static inline u32 rd_##reg(void __iomem *p)	\
> +	{						\
> +		return readl(p + (off));		\
> +	}
> +
> +#define DEFINE_SPI_REG_WR(reg, off)				\
> +	static inline void wr_##reg(u32 v, void __iomem *p)	\
> +	{							\
> +		writel(v, p + (off));				\
> +	}
> +
> +DEFINE_SPI_REG_RD(DATA, 0x00)
> +DEFINE_SPI_REG_WR(DATA, 0x04)
> +DEFINE_SPI_REG_RD(CONTROL, 0x08)
> +DEFINE_SPI_REG_WR(CONTROL, 0x08)
> +DEFINE_SPI_REG_RD(INT_STATUS, 0x0C)
> +DEFINE_SPI_REG_WR(INT_STATUS, 0x0C)
> +DEFINE_SPI_REG_RD(TEST, 0x10)
> +DEFINE_SPI_REG_WR(TEST, 0x10)
> +DEFINE_SPI_REG_RD(PERIOD, 0x14)
> +DEFINE_SPI_REG_WR(PERIOD, 0x14)
> +DEFINE_SPI_REG_RD(DMA, 0x18)
> +DEFINE_SPI_REG_WR(DMA, 0x18)
> +DEFINE_SPI_REG_WR(RESET, 0x1C)

ug.  Why not simply open-code

	readl(addr + DATA);

?

> +
> +#define PRINT_DMA_GLOBAL_REGS(dev)	\
> +	dev_dbg(dev,			\
> +		"DMA_GLOBAL\n"		\
> +		"    DCR    = 0x%08X\n"	\
> +		"    DISR   = 0x%08X\n"	\
> +		"    DIMR   = 0x%08X\n"	\
> +		"    DBTOSR = 0x%08X\n"	\
> +		"    DRTOSR = 0x%08X\n"	\
> +		"    DSESR  = 0x%08X\n"	\
> +		"    DBOSR  = 0x%08X\n"	\
> +		"    DBTOCR = 0x%08X\n",\
> +		DCR,			\
> +		DISR,			\
> +		DIMR,			\
> +		DBTOSR,			\
> +		DRTOSR,			\
> +		DSESR,			\
> +		DBOSR,			\
> +		DBTOCR)

Unless the callsites have been cunningly hidden inside even more macros,
this thankfully has no users and can be removed.

> +#define PRINT_DMA_CH_REGS(dev, channel)	\
> +	dev_dbg(dev,			\
> +		"DMA(%d)\n"		\
> +		"    SAR    = 0x%08X\n"	\
> +		"    DAR    = 0x%08X\n"	\
> +		"    CNTR   = 0x%08X\n"	\
> +		"    CCR    = 0x%08X\n"	\
> +		"    RSSR   = 0x%08X\n"	\
> +		"    BLR    = 0x%08X\n"	\
> +		"    RTOR   = 0x%08X\n"	\
> +		"    BUCR   = 0x%08X\n",\
> +		channel,		\
> +		SAR(channel),		\
> +		DAR(channel),		\
> +		CNTR(channel),		\
> +		CCR(channel),		\
> +		RSSR(channel),		\
> +		BLR(channel),		\
> +		RTOR(channel),		\
> +		BUCR(channel))

ditto

> +#define PRINT_SPI_REGS(dev, regs)		\
> +	dev_dbg(dev,				\
> +		"SPI_REGS\n"			\
> +		"    CONTROL    = 0x%08X\n"	\
> +		"    INT_STATUS = 0x%08X\n"	\
> +		"    TEST       = 0x%08X\n"	\
> +		"    PERIOD     = 0x%08X\n"	\
> +		"    DMA        = 0x%08X\n",	\
> +		rd_CONTROL(regs),		\
> +		rd_INT_STATUS(regs),		\
> +		rd_TEST(regs),			\
> +		rd_PERIOD(regs),			\
> +		rd_DMA(regs))

tritto.

> +static int flush(struct driver_data *drv_data)
> +{
> +	unsigned long limit = loops_per_jiffy << 1;
> +	void __iomem *regs = drv_data->regs;
> +	volatile u32 d;
> +
> +	dev_dbg(&drv_data->pdev->dev, "flush\n");
> +
> +	do {
> +		while (rd_INT_STATUS(regs) & SPI_STATUS_RR)
> +			d = rd_DATA(regs);
> +	} while ((rd_CONTROL(regs) & SPI_CONTROL_XCH) && limit--);
> +
> +	return limit;
> +}

The use of loops_per_jiffy seems inappropriate.  That's an IO-space read in
there, which is slow.  This timeout will be very long indeed.

> +static int dummy_writer(struct driver_data *drv_data)
> +{
> +	void __iomem *regs = drv_data->regs;
> +	u8 *tx, *tx_end;
> +	u32 remaining_data;
> +	u32 fifo_avail_space;
> +	u32 n;
> +
> +	/* Compute how many fifo writes to do */
> +	tx = (u8*)drv_data->tx;
> +	tx_end = (u8*)drv_data->tx_end;

Two unneeded casts.

> +	remaining_data = (u32)(tx_end - tx) / drv_data->n_bytes;

hm, we just wrote an inline function to do that, then didn't use it.

> +static int u8_writer(struct driver_data *drv_data)
> +{
> +	void __iomem *regs = drv_data->regs;
> +	u8 *tx, *tx_end;
> +	u32 remaining_data;
> +	u32 fifo_avail_space;
> +	u32 n;
> +
> +	/* Compute how many fifo writes to do */
> +	tx = (u8*)drv_data->tx;
> +	tx_end = (u8*)drv_data->tx_end;

Unneeded casts

> +	remaining_data = (u32)(tx_end - tx);

How come we didn't divide by drv_data->n_bytes this time?

> +static int u8_reader(struct driver_data *drv_data)
> +{
> +	void __iomem *regs = drv_data->regs;
> +	u8 *rx, *rx_end;
> +	u32 remaining_data;
> +	u32 fifo_rxcnt;
> +	u32 n;
> +
> +	/* Compute how many fifo reads to do */
> +	rx = (u8*)drv_data->rx;
> +	rx_end = (u8*)drv_data->rx_end;

casts

> +	remaining_data = (u32)(rx_end - rx);

Missing divide?

> +static int u16_writer(struct driver_data *drv_data)
> +{
> +	void __iomem *regs = drv_data->regs;
> +	u16 *tx, *tx_end;
> +	u32 remaining_data;
> +	u32 fifo_avail_space;
> +	u32 n;
> +
> +	/* Compute how many fifo writes to do */
> +	tx = (u16*)drv_data->tx;
> +	tx_end = (u16*)drv_data->tx_end;
> +	remaining_data = (u32)(tx_end - tx);

ditto

> +static int u16_reader(struct driver_data *drv_data)
> +{
> +	struct spi_regs __iomem *regs;
> +	u16 *rx, *rx_end;
> +	u32 remaining_data;
> +	u32 fifo_rxcnt;
> +	u32 n;
> +
> +	regs = drv_data->regs;
> +
> +	/* Compute how many fifo reads to do */
> +	rx = (u16*)drv_data->rx;
> +	rx_end = (u16*)drv_data->rx_end;

This code's awfully repetitive.  Can it be consolidated?

> +	remaining_data = (u32)(rx_end - rx);
> +	fifo_rxcnt = (rd_TEST(regs) & SPI_TEST_RXCNT) >> SPI_TEST_RXCNT_LSB;
> +	n = min(remaining_data, fifo_rxcnt);
> +	dev_dbg(&drv_data->pdev->dev,
> +		"u16_reader\n"
> +		"    remaining data = %d\n"
> +		"    fifo_rxcnt     = %d\n"
> +		"    fifo reads     = %d\n",
> +		remaining_data,
> +		fifo_rxcnt,
> +		n);
> +
> +	if (n > 0) {
> +		/* Read SPI RXFIFO */
> +		while (n--)
> +			*rx++ = rd_DATA(regs);
> +
> +		/* Update rx pointer */
> +		drv_data->rx = rx;
> +	}
> +
> +	return (rx >= rx_end);
> +}
> +
> +static void *next_transfer(struct driver_data *drv_data)
> +{
> +	struct spi_message *msg = drv_data->cur_msg;
> +	struct spi_transfer *trans = drv_data->cur_transfer;
> +
> +	/* Move to next transfer */
> +	if (trans->transfer_list.next != &msg->transfers) {
> +		drv_data->cur_transfer =
> +			list_entry(trans->transfer_list.next,
> +					struct spi_transfer,
> +					transfer_list);
> +		return RUNNING_STATE;
> +	}
> +
> +	return DONE_STATE;
> +}

Why does it use void*'s for this enumeration?

> +				dev_err(&drv_data->pdev->dev,
> +					"interrupt_transfer - "
> +					"trailing byte read failed\n");
> +			else
> +				dev_dbg(&drv_data->pdev->dev,
> +					"interrupt_transfer - end of rx\n");
> +
> +			/* End of transfer, update total byte transfered */
> +			msg->actual_length += drv_data->len;
> +
> +			/* Release chip select if requested, transfer delays are
> +			   handled in pump_transfers */
> +			if (drv_data->cs_change)
> +				drv_data->cs_control(SPI_CS_DEASSERT);
> +
> +			/* Move to next transfer */
> +			msg->state = next_transfer(drv_data);
> +
> +			/* Schedule transfer tasklet */
> +			tasklet_schedule(&drv_data->pump_transfers);

I see tasklets being scheduled, but no tasklet_disable() or tasklet_kill(),
etc.  Is this driver racy against shutdown or rmmod?

> +			return IRQ_HANDLED;
> +		}
> +
> +		status = rd_INT_STATUS(regs);
> +
> +		/* We did something */
> +		handled = IRQ_HANDLED;
> +	}
> +
> +	return handled;
> +}
> +
> +static irqreturn_t spi_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct driver_data *drv_data = (struct driver_data *)dev_id;
> +
> +	if (!drv_data->cur_msg) {
> +		dev_err(&drv_data->pdev->dev,
> +			"spi_int - bad message state\n");
> +		/* Never fail */
> +		return IRQ_HANDLED;

IRQ_NONE?

> +	}
> +
> +	return drv_data->transfer_handler(drv_data);
> +}
> +
>
> ..
>
> +	if ((drv_data->n_bytes == 2) &&
> +		(drv_data->len > SPI_FIFO_DEPTH*SPI_FIFO_BYTE_WIDTH) &&
> +		map_dma_buffers(drv_data)) {
> +		dev_dbg(&drv_data->pdev->dev,
> +			"pump dma transfer\n"
> +			"    tx      = 0x%08X\n"
> +			"    tx_dma  = 0x%08X\n"
> +			"    rx      = 0x%08X\n"
> +			"    rx_dma  = 0x%08X\n"
> +			"    len     = %d\n",
> +			(u32)drv_data->tx,
> +			(u32)drv_data->tx_dma,
> +			(u32)drv_data->rx,
> +			(u32)drv_data->rx_dma,
> +			(u32)drv_data->len);

The way to print a pointer is with %p, not with a cast to u32.

Also, it's incorrect (but it happens to work) to print u32's with %X.  %X
is defined on ints and unsigneds - you don't know what type the
architecture actually chose to use.  It could have used unsigned long.

So if one insists on casting pointers here, cast them to `unsigned'.

But %p would be better.

> +		/* Ensure we have the correct interrupt handler */
> +		drv_data->transfer_handler = dma_transfer;
> +
> +		/* Enable SPI and arm transfer */
> +		wr_CONTROL(rd_CONTROL(regs) |
> +				SPI_CONTROL_SPIEN | SPI_CONTROL_XCH,
> +				regs);
> +
> +		/* Setup tx DMA */
> +		if (drv_data->tx)
> +			/* Linear source address */
> +			CCR(drv_data->tx_channel) =
> +				CCR_DMOD_FIFO |
> +				CCR_SMOD_LINEAR |
> +				CCR_SSIZ_32 | CCR_DSIZ_16 |
> +				CCR_REN;
> +		else
> +			/* Read only transfer -> fixed source address for
> +			   dummy write to achive read */
> +			CCR(drv_data->tx_channel) =
> +				CCR_DMOD_FIFO |
> +				CCR_SMOD_FIFO |
> +				CCR_SSIZ_32 | CCR_DSIZ_16 |
> +				CCR_REN;
> +
> +		imx_dma_setup_single(
> +			drv_data->tx_channel,
> +			drv_data->tx_dma,
> +			drv_data->len,
> +			drv_data->rd_data_phys + 4,
> +			DMA_MODE_WRITE
> +		);

The ); all on its own is overdoing things a bit.

> +		if (drv_data->rx) {
> +			/* Setup rx DMA for linear destination address */
> +			CCR(drv_data->rx_channel) =
> +				CCR_DMOD_LINEAR |
> +				CCR_SMOD_FIFO |
> +				CCR_DSIZ_32 | CCR_SSIZ_16 |
> +				CCR_REN;
> +			imx_dma_setup_single(
> +				drv_data->rx_channel,
> +				drv_data->rx_dma,
> +				drv_data->len,
> +				drv_data->rd_data_phys,
> +				DMA_MODE_READ);

And inconsistent.

> +			imx_dma_enable(drv_data->rx_channel);
> +
> +			/* Enable SPI interrupt */
> +			wr_INT_STATUS(SPI_INTEN_RO, regs);
> +
> +			/* Set SPI to request DMA service on both
> +			   Rx and Tx half fifo watermark */
> +			wr_DMA(SPI_DMA_RHDEN | SPI_DMA_THDEN, regs);
> +		} else
> +			/* Write only access -> set SPI to request DMA
> +			   service on Tx half fifo watermark */
> +			wr_DMA(SPI_DMA_THDEN, regs);
> +
> +		imx_dma_enable(drv_data->tx_channel);
> +	} else {
> +		dev_dbg(&drv_data->pdev->dev,
> +			"pump pio transfer\n"
> +			"    tx      = 0x%08X\n"
> +			"    rx      = 0x%08X\n"
> +			"    len     = %d\n",
> +			(u32)drv_data->tx,
> +			(u32)drv_data->rx,
> +			(u32)drv_data->len);

More bad casting.  Please review entire patch.

> +		/* Ensure we have the correct interrupt handler	*/
> +		if (drv_data->rx)
> +			drv_data->transfer_handler = interrupt_transfer;
> +		else
> +			drv_data->transfer_handler = interrupt_wronly_transfer;
> +
> +		/* Enable SPI */
> +		wr_CONTROL(rd_CONTROL(regs) | SPI_CONTROL_SPIEN, regs);
> +
> +		/* Enable SPI interrupt */
> +		if (drv_data->rx)
> +			wr_INT_STATUS(SPI_INTEN_TH | SPI_INTEN_RO, regs);
> +		else
> +			wr_INT_STATUS(SPI_INTEN_TH, regs);
> +	}
> +}
> +
>
> ...
>
> +static int spi_imx_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_imx_master *platform_info;
> +	struct spi_master *master;
> +	struct driver_data *drv_data = NULL;
> +	struct resource *res;
> +	int irq, status = 0;
> +
> +	platform_info = dev->platform_data;
> +	if (platform_info == NULL) {
> +		dev_err(&pdev->dev, "probe - no platform data supplied\n");
> +		status = -ENODEV;
> +		goto err_no_pdata;
> +	}
> +
> +	/* Allocate master with space for drv_data */
> +	master = spi_alloc_master(dev, sizeof(struct driver_data));
> +	if (!master) {
> +		dev_err(&pdev->dev, "probe - cannot alloc spi_master\n");
> +		status = -ENOMEM;
> +		goto err_no_mem;
> +	}
> +	drv_data = spi_master_get_devdata(master);
> +	drv_data->master = master;
> +	drv_data->master_info = platform_info;
> +	drv_data->pdev = pdev;
> +
> +	master->bus_num = pdev->id;
> +	master->num_chipselect = platform_info->num_chipselect;
> +	master->cleanup = cleanup;
> +	master->setup = setup;
> +	master->transfer = transfer;
> +
> +	drv_data->dummy_dma_buf = SPI_DUMMY_u32;
> +
> +	/* Find and map resources */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "probe - MEM resources not defined\n");
> +		status = -ENODEV;
> +		goto err_no_iores;
> +	}
> +	drv_data->ioarea = request_mem_region(res->start,
> +						res->end - res->start + 1,
> +						pdev->name);
> +	if (drv_data->ioarea == NULL) {
> +		dev_err(&pdev->dev, "probe - cannot reserve region\n");
> +		status = -ENXIO;
> +		goto err_no_iores;
> +	}
> +	drv_data->regs = ioremap(res->start, res->end - res->start + 1);
> +	if (drv_data->regs == NULL) {
> +		dev_err(&pdev->dev, "probe - cannot map IO\n");
> +		status = -ENXIO;
> +		goto err_no_iomap;
> +	}
> +	drv_data->rd_data_phys = (dma_addr_t)res->start;

I don't think it's correct to cast a kernel virtual address straight to a
dma_addr_t.

> +	/* Attach to IRQ */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "probe - IRQ resource not defined\n");
> +		status = -ENODEV;
> +		goto err_no_irqres;
> +	}
> +	status = request_irq(irq, spi_int, SA_INTERRUPT, dev->bus_id, drv_data);

SA_INTERRUPT is deprecated.  Use IRQF_DISABLED.


