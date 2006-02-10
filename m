Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWBJCTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWBJCTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 21:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWBJCTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 21:19:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751006AbWBJCTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 21:19:34 -0500
Date: Thu, 9 Feb 2006 18:18:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: stephen@streetfiresound.com
Cc: linux-kernel@vger.kernel.org, dvrabel@arcom.com, david-b@pacbell.net,
       spi-devel-general@lists.sourceforge.net, nico@cam.org
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
Message-Id: <20060209181841.73e5d0b2.akpm@osdl.org>
In-Reply-To: <1139535480.30189.30.camel@ststephen.streetfiresound.com>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	<1139535480.30189.30.camel@ststephen.streetfiresound.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Street <stephen@streetfiresound.com> wrote:
>
> Attached is an updated patch to add SPI master controller for PXA2xx
> boards.  This update includes fixes for the PXA27x CPU to correctly
> handle the differences peripheral clock speeds with in the PXA2xx
> family.
> 

Driver looks pretty clean.  It's refreshingly deviod of comments ;)

Random minor observations:

> +static inline void flush(struct driver_data *drv_data)
> +{
> +	u32 sssr = drv_data->sssr;
> +	u32 ssdr = drv_data->ssdr;
> +
> +	do {
> +		while (SSP_REG(sssr) & SSSR_RNE) {
> +			(void)SSP_REG(ssdr);
> +		}
> +	} while (SSP_REG(sssr) & SSSR_BSY);
> +	SSP_REG(sssr) = SSSR_ROR ;
> +}

Suggest this be uninlined.

> +static inline void save_state(struct driver_data *drv_data)
> +static inline void restore_state(struct driver_data *drv_data)
> +static inline void dump_dma_state(struct driver_data *drv_data)
> +static inline void dump_ssp_state(struct driver_data *drv_data)
> +static inline void dump_message(char *header, struct spi_message *msg)
> +static inline void dump_transfer_state(char* header, struct driver_data *drv_data)
> +static inline void dump_chip_state(struct device *dev,
> +				char * header,
> +				struct chip_data *chip)

These appear to not have any callers?

Suggest they be uninlined, but that'd generate defined-but-not-used warnings.

> +static void null_writer(struct driver_data *drv_data)
> +{
> +	u32 sssr = drv_data->sssr;
> +	u32 ssdr = drv_data->ssdr;
> +	u8 n_bytes = drv_data->cur_chip->n_bytes;
> +
> +	while ((SSP_REG(sssr) & SSSR_TNF)
> +			&& (drv_data->tx < drv_data->tx_end)) {
> +		SSP_REG(ssdr) = 0;
> +		drv_data->tx += n_bytes;
> +	}
> +}

hm.

	#define SSP_REG(x) (*((volatile unsigned long *)x))

what's this doing?  Accessing a device register?  Cannot we use readl/writel?

> +static inline void* next_transfer(struct driver_data *drv_data)

                     ^^ swap these chars!

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
> +	} else
> +		return DONE_STATE;
> +}

Suggest this be uninlined.

> +		*(u32 *)(drv_data->null_dma_buf) = 0;

null_dma_buf gets typecast a lot.  Maybe make it a u32*?

> +static void giveback(struct spi_message *message, struct driver_data *drv_data)
> +{
> +	struct spi_transfer* last_transfer;
> +
> +	last_transfer = list_entry(message->transfers.prev,
> +					struct spi_transfer,
> +					transfer_list);
> +
> +	if (!last_transfer->cs_change)
> +		drv_data->cs_control(PXA2XX_CS_DEASSERT);
> +
> +	message->state = NULL;
> +	if (message->complete) {
> +		message->complete(message->context);
> +	}

Unneeded braces.

> +static void dma_handler(int channel, void *data, struct pt_regs *regs)
> +{
> +	struct driver_data *drv_data = (struct driver_data *)data;

Unneeded typecast.

> +	/* PXA255x_SSP has no timeout interrupt, wait for tailing bytes */
> +	if ((drv_data->ssp_type == PXA25x_SSP)
> +		&& (channel == drv_data->tx_channel)
> +		&& (irq_status & DCSR_ENDINTR)) {
> +
> +		/* Wait for rx to stall */
> +		while (SSP_REG(sssr) & SSSR_BSY)
> +			cpu_relax();

A timeout here, perhaps?

> +		while (!(DCSR(drv_data->rx_channel) & DCSR_STOPSTATE))
> +			cpu_relax();

And here.

> +static irqreturn_t dma_transfer(struct driver_data *drv_data)
> +{
> +	u32 sssr = drv_data->sssr;
> +	u32 sscr1 = drv_data->sscr1;
> +	u32 ssto = drv_data->ssto;
> +	u32 irq_status = SSP_REG(sssr) & drv_data->mask_sr;
> +	u32 trailing_sssr = 0;
> +	struct spi_message *msg = drv_data->cur_msg;
> +
> +	if (irq_status & SSSR_ROR) {
> +		/* Clear and disable interrupts on SSP and DMA channels*/
> +		SSP_REG(ssto) = 0;
> +		SSP_REG(sssr) = drv_data->clear_sr;
> +		SSP_REG(sscr1) &= ~(drv_data->dma_cr1);
> +		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
> +		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
> +		unmap_dma_buffers(drv_data);
> +		flush(drv_data);
> +
> +		dev_warn(&drv_data->pdev->dev, "dma_transfer: fifo overun\n");
> +
> +		drv_data->cur_msg->state = ERROR_STATE;
> +		tasklet_schedule(&drv_data->pump_transfers);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Check for false positive timeout */
> +	if ((irq_status & SSSR_TINT) && DCSR(drv_data->tx_channel) & DCSR_RUN) {
> +		SSP_REG(sssr) = SSSR_TINT;
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (irq_status & SSSR_TINT || drv_data->rx == drv_data->rx_end) {
> +
> +		/* Clear and disable interrupts on SSP and DMA channels*/
> +		SSP_REG(ssto) = 0;
> +		SSP_REG(sssr) = drv_data->clear_sr;
> +		SSP_REG(sscr1) &= ~(drv_data->dma_cr1);
> +		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
> +		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
> +		while (!(DCSR(drv_data->rx_channel) & DCSR_STOPSTATE)
> +				|| (SSP_REG(sssr) & SSSR_BSY))
> +			cpu_relax();

And here.

> +		unmap_dma_buffers(drv_data);
> +
> +		/* Calculate number of trailing bytes, read them */
> +		trailing_sssr = SSP_REG(sssr);
> +		if ((trailing_sssr & 0xf008) != 0xf000) {
> +			drv_data->rx = drv_data->rx_end -
> +					(((trailing_sssr >> 12) & 0x0f) + 1);
> +			drv_data->read(drv_data);
> +		}
> +		msg->actual_length += drv_data->len;
> +
> +		/* Release chip select if requested, transfer delays are
> +		 * handled in pump_transfers */
> +		if (drv_data->cs_change)
> +			drv_data->cs_control(PXA2XX_CS_DEASSERT);
> +
> +		/* Move to next transfer */
> +		msg->state = next_transfer(drv_data);
> +
> +		/* Schedule transfer tasklet */
> +		tasklet_schedule(&drv_data->pump_transfers);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Never Fail */

WARN_ON(1)?

Why not return IRQ_NONE here?  That way, the IRQ system will save the
machine if the IRQ gets stuck.

> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
> +{
> 	...
> +	return IRQ_HANDLED;
> +}

Ditto.

> +static void pump_transfers(unsigned long data)
> +{
> 	...
> +		/* Enable dma end irqs on SSP to detect end of transfer */
> +		if (drv_data->ssp_type == PXA25x_SSP) {
> +			DCMD(drv_data->tx_channel) |= DCMD_ENDIRQEN;
> +		}

Braces.

> +static int setup(struct spi_device *spi)
> +{
> +	struct pxa2xx_spi_chip *chip_info = NULL;
> +	struct chip_data *chip;
> +	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
> +	unsigned int clk_div;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +
> +	if (drv_data->ssp_type != PXA25x_SSP
> +			&& (spi->bits_per_word < 4 || spi->bits_per_word > 32))
> +		return -EINVAL;
> +	else if (spi->bits_per_word < 4 || spi->bits_per_word > 16)
> +		return -EINVAL;
> +
> +	/* Only alloc (or use chip_info) on first setup */
> +	chip = spi_get_ctldata(spi);
> +	if (chip == NULL) {
> +		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
> +		if (!chip)
> +			return -ENOMEM;
> +
> +		chip->cs_control = null_cs_control;
> +		chip->enable_dma = 0;
> +		chip->timeout = 5;
> +		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
> +		chip->dma_burst_size = drv_data->master_info->enable_dma ?
> +					DCMD_BURST8 : 0;
> +
> +		chip_info = (struct pxa2xx_spi_chip *)spi->controller_data;

Unneeded cast.

> +	switch (drv_data->sscr0) {
> +		case SSP1_VIRT:
> +			clk_div = SSP1_SerClkDiv(spi->max_speed_hz);
> +			break;
> +		case SSP2_VIRT:
> +			clk_div = SSP2_SerClkDiv(spi->max_speed_hz);
> +			break;
> +		case SSP3_VIRT:
> +			clk_div = SSP3_SerClkDiv(spi->max_speed_hz);
> +			break;
> +		default:
> +			return -ENODEV;
> +	}

We normally lay out switch statements one tabstop less than this.

> +static void cleanup(const struct spi_device *spi)
> +{
> +	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);

Remove the typecast, change spi_get_ctldata() to take a const struct
spi_device *?  I guess that might cause warnings too - the compiler might
want spi_get_ctldata() to return a const thing.

Might be simpler to not have a const arg here.

> +	if (chip)
> +		kfree(chip);
> +}

kfree(NULL) is legal.

> +
> +	queue_work(drv_data->workqueue, &drv_data->pump_messages);

I see a queue_work(), but I see no flush_workqueue().  Basically a flush is
always needed to push through any pending work in the shutdown/close/rmmod
paths.

> +static int destroy_queue(struct driver_data *drv_data)
> +{
> +	int status;
> +
> +	status = stop_queue(drv_data);
> +	if (status != 0)
> +		return status;
> +
> +	destroy_workqueue(drv_data->workqueue);

hm, OK, destroy_workqueue() does flush_workqueue.

> +static int pxa2xx_spi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pxa2xx_spi_master *platform_info;
> +	struct spi_master *master;
> +	struct driver_data *drv_data = 0;
> +	struct resource *memory_resource;
> +	int irq;
> +	int status = 0;
> +
> +	platform_info = (struct pxa2xx_spi_master *)dev->platform_data;

Unneeded cast.

> +	drv_data->null_dma_buf = drv_data + sizeof(struct driver_data);
> +	drv_data->null_dma_buf = (void *)(((u32)(drv_data->null_dma_buf)
> +					 & 0xfffffff8) | 8);

Consider using the ALIGN() macro here.

This all looks very non-64-bit-capable.

> +out_error_master_alloc:
> +	(void)spi_master_put(master);

Remove the (void).  Unless it does something??

> +static void pxa2xx_spi_shutdown(struct platform_device *pdev)
> +{
> +	int status = 0;
> +
> +	if ((status = pxa2xx_spi_remove(pdev)) != 0) {
> +		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
> +	}

Braces.

> +#ifdef CONFIG_PM
> +static int stall_queue(struct driver_data *drv_data)
> +{
> +	unsigned long flags;
> +	unsigned limit = 500;
> +
> +	spin_lock_irqsave(&drv_data->lock, flags);
> +
> +	drv_data->run = QUEUE_STALLED;
> +
> +	while (drv_data->busy && limit--) {
> +		spin_unlock_irqrestore(&drv_data->lock, flags);
> +		msleep(10);
> +		spin_lock_irqsave(&drv_data->lock, flags);
> +	}

That looks a bit lame.  What's happening here?

> +	spin_unlock_irqrestore(&drv_data->lock, flags);
> +
> +	if (!list_empty(&drv_data->queue) || drv_data->busy)
> +		return -EBUSY;

Does the list_empty() make sense outside the lock?

