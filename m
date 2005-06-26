Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVFZUnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVFZUnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 16:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFZUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 16:43:22 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:2005 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbVFZUnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 16:43:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=crrMhS9FnDIpdvLAuUrUlFkM7/j185a8qTObg/uU03yJ2vN6s0ljN1eKner63Q50bPtkXs9bCLwsuG3gIQLR4mOOQ8CyU29UiPNT2giCPhMeKyJ6+HjyztqeSrnsQMvDBty1fF3A+AZnhbV/aKZD/BO1uihIdmcReSrrSLptmuw=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: dpervushin@ru.mvista.com
Subject: Re: [RFC] SPI core -- revisited
Date: Mon, 27 Jun 2005 00:49:10 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>
In-Reply-To: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506270049.10970.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 23:36, dpervushin@ru.mvista.com wrote:
> Here is the sample of usage of our SPI core; this is the driver of atmel
> chip connected to the pnx spi bus; 

> --- /dev/null
> +++ linux-2.6.10/drivers/spi/spi-pnx010x.c

> +#define DBG(args...)	pr_debug(args)

Just use pr_debug()

> +static void		*phys_spi_data_reg = 0;

NULL for pointers.

> +void spipnx_select_chip (void)
> +{
> +	unsigned reg = gpio_read_reg (PADMUX1_MODE0);
> +	gpio_write_reg ((reg & ~GPIO_PIN_SPI_CE), PADMUX1_MODE0); }

Closing brackets on the separate line, _please_.

> +static void spipnx_spi_init (void *algo_data) {

As well as opening ones.

> --- /dev/null
> +++ linux-2.6.10/drivers/spi/spi-pnx010x_atmel.c

> +#define DBG(args...)	pr_debug(args)

> +static struct spi_algorithm spipnx_algorithm = {
> +	name:		ALGORITHM_NAME,
> +	xfer:		spipnx_xfer,

	.name = ALGORITHM_NAME,
	.xfer = ...

> +static spi_pnx0105_algo_data_t spi_pnx_algo_data = {
> +	cb_data:		NULL,
> +	chip_cs_callback:	NULL,
> +};

> +static struct spi_adapter spipnx_adapter = {
> +	name:		ADAPTER_NAME,
> +	algo:		&spipnx_algorithm,
> +	algo_data:	(void *) &spi_pnx_algo_data,
> +	owner:		THIS_MODULE,
> +	alloc:		NULL,
> +	free:		NULL,
> +	copy_from_user:	NULL,
> +	copy_to_user:	NULL,
> +};

> +void *pnx_memory_alloc(size_t size, int base) {
> +	spi_pnx_msg_buff_t *buff;
> +
> +	buff = (spi_pnx_msg_buff_t *) kmalloc(sizeof(spi_pnx_msg_buff_t),

Useless cast.

> base);
> +	buff->size = size;
> +	buff->io_buffer = dma_alloc_coherent (NULL, size, &buff->dma_buffer,
> 
> +base);
> +	
> +	DBG("%s:allocated memory(%x) for io_buffer = %x dma_buffer = %x\n",
> +		__FUNCTION__, buff, buff->io_buffer,buff->dma_buffer );
> +
> +	return (void *) buff;
> +}

No error path. You're an optimist.

> +void pnx_memory_free(const void *data)
> +{
> +	spi_pnx_msg_buff_t *buff;
> +
> +	buff = (spi_pnx_msg_buff_t *) data;
> +	DBG("%s:deleted memory(%x) for io_buffer = %x dma_buffer = %x\n",
> +		__FUNCTION__, buff, buff->io_buffer,buff->dma_buffer );

%p was invented for pointers.

> +unsigned long pnx_copy_from_user(void *to, const void *from_user, 

const void __user *from, I believe.

> +unsigned long pnx_copy_to_user(void *to_user, const void *from,

const void __user *to.
