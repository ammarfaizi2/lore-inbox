Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWDGGDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWDGGDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDGGDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:03:35 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:47020 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932283AbWDGGDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:03:34 -0400
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Thu, 6 Apr 2006 22:22:05 -0700
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net
References: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604062222.05661.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This driver supports the SPI controller on the MPC83xx SoC devices from Freescale.
> Note, this driver supports only the simple shift register SPI controller and not
> the descriptor based CPM or QUICCEngine SPI controller.

Or the QSPI on Coldfire; there's a driver for that floating around, but for an
older version of this framework (sans lists).


> --- /dev/null
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -0,0 +1,349 @@
> +/*
> + * MPC83xx SPI controller driver.
> + *
> + * Maintainer: Kumar Gala

Needs a "Copyright (C) 2006 <NAME>" for the GPL to be valid; it's
the copyright holder who licences the code.


> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> ...
> +
> +/* Default for SPI Mode, slowest speed, MSB, inactive high, 8-bit char */
> +#define	SPMODE_INIT_VAL (SPMODE_CI_INACTIVEHIGH | SPMODE_CP_RISE_EDGECLK | \
> +			 SPMODE_DIV16 | SPMODE_REV | SPMODE_MS | \
> +			 SPMODE_LEN(7) | SPMODE_PM(0xf))

Hmm, it will of course be overridden as soon as needed, but shouldn't
that default be "inactive low" clock?  SPI mode 0 that is.  That stands
out mostly because you were interpreting CPOL=0 as inactive high, and
that's not my understanding of how that signal works...


> +struct mpc83xx_spi {
> +	/* bitbang has to be first */
> +	struct spi_bitbang bitbang;
> +	struct completion tx_done, rx_ready;
> +
> +	u32 __iomem *base;

Erm, OK, but fwiw my preference is to have pointer-to-struct and let
the compiler calculate the offsets (and tell you when you pass the wrong
kind of pointer).  Otherwise such pointers should use "void __iomem *"
(or maybe in your case "__be32 *"?) for explicit {base,offset} addressing.


> +static inline void mpc83xx_spi_write_reg(__be32 * base, u32 reg, u32 val)
> +{
> +	out_be32(base + (reg >> 2), val);
> +}
> +
> +static inline u32 mpc83xx_spi_read_reg(__be32 * base, u32 reg)
> +{
> +	return in_be32(base + (reg >> 2));
> +}

... here you use "__be32" not "u32", and no "__iomem" annotation.  So
this is inconsistent with the declaration above.  Note that if you
just made this "&bank->regname" you'd be having the compiler do any
offset calculation magic, and the source code will be more obvious.


> +static
> +int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct mpc83xx_spi *mpc83xx_spi;
> +	u32 regval;
> +	u32 len = t->bits_per_word - 1;
> +
> +	if (len == 32)
> +		len = 0;

So the hardware handles 1-33 bit words?  It'd be good to filter
the spi_setup() path directly then, returning EINVAL for illegal
word lengths (and clock speeds).



> +static u32
> +mpc83xx_spi_txrx(struct spi_device *spi, unsigned nsecs, u32 word, u8 bits)
> +{
> +	struct mpc83xx_spi *mpc83xx_spi;
> +	mpc83xx_spi = spi_master_get_devdata(spi->master);
> +
> +	INIT_COMPLETION(mpc83xx_spi->tx_done);
> +	INIT_COMPLETION(mpc83xx_spi->rx_ready);
> +
> +	/* enable tx/rx ints */
> +	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIM_REG, SPIM_NF | SPIM_NE);
> +
> +	/* transmit word */
> +	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPITD_REG, word);
> +
> +	/* wait for both a tx & rx interrupt */
> +	wait_for_completion(&mpc83xx_spi->tx_done);
> +	wait_for_completion(&mpc83xx_spi->rx_ready);

I guess I'm surprised you're not using txrx_buffers() and having
that whole thing be IRQ driven, so the per-word cost eliminates
the task scheduling.  You already paid for IRQ handling ... why
not have it store the rx byte into the buffer, and write the tx
byte froom the other buffer?  That'd be cheaper than what you're
doing now ... in both time and code.  Only wake up a task at
the end of a given spi_transfer().

Plus, your IRQ handler should _not_ always return IRQ_HANDLED.
Only return it if you actually do enter one of those branches...


> +	mpc83xx_spi->sysclk = pdata->sysclk;

When MPC/PPC starts to support <linux/clk.h> would seem to be
the right sort of time to

	mpc83xx-spi->clk = clk_get(&pdev->dev, "spi_clk");

or whatever.


> +MODULE_DESCRIPTION("Simple Platform SPI Driver");

How about "Simple MPC83xx SPI driver"?

- Dave
