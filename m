Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWBPPPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWBPPPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWBPPPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:15:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161132AbWBPPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:15:15 -0500
Date: Thu, 16 Feb 2006 15:15:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC] mmc: add OMAP driver
Message-ID: <20060216151504.GA29443@flint.arm.linux.org.uk>
Mail-Followup-To: Carlos Aguiar <carlos.aguiar@indt.org.br>,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>
References: <43F48BCA.8010608@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F48BCA.8010608@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 10:27:22AM -0400, Carlos Aguiar wrote:
> +	/* Any data transfer means adtc type (but that information is not
> +	 * in command structure, so we flagged it into host struct.)
> +	 * However, telling bc, bcr and ac apart based on response is
> +	 * not foolproof:
> +	 * CMD0  = bc  = resp0  CMD15 = ac  = resp0
> +	 * CMD2  = bcr = resp2  CMD10 = ac  = resp2
> +	 *
> +	 * Resolve to best guess with some exception testing:
> +	 * resp0 -> bc, except CMD15 = ac
> +	 * rest are ac, except if opendrain
> +	 */
> +	if (host->data) {
> +		cmdtype = OMAP_MMC_CMDTYPE_ADTC;
> +	} else if (resptype == 0 && cmd->opcode != 15) {
> +		cmdtype = OMAP_MMC_CMDTYPE_BC;
> +	} else if (host->bus_mode == MMC_BUSMODE_OPENDRAIN) {
> +		cmdtype = OMAP_MMC_CMDTYPE_BCR;
> +	} else {
> +		cmdtype = OMAP_MMC_CMDTYPE_AC;
> +	}

This is no longer necessary - we now supply the command type via
cmd->flags.

> +static void
> +mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
> +{
> +	host->cmd = NULL;
> +

	if (cmd->flags & MMC_RSP_PRESENT) {
		if (cmd->flags & MMC_RSP_136) {
			cmd->resp[3] =
				OMAP_MMC_READ(host->base, RSP0) |
				(OMAP_MMC_READ(host->base, RSP1) << 16);
			cmd->resp[2] =
				OMAP_MMC_READ(host->base, RSP2) |
				(OMAP_MMC_READ(host->base, RSP3) << 16);
			cmd->resp[1] =
				OMAP_MMC_READ(host->base, RSP4) |
				(OMAP_MMC_READ(host->base, RSP5) << 16);
			cmd->resp[0] =
				OMAP_MMC_READ(host->base, RSP6) |
				(OMAP_MMC_READ(host->base, RSP7) << 16);
		} else {
			cmd->resp[0] =
				OMAP_MMC_READ(host->base, RSP6) |
				(OMAP_MMC_READ(host->base, RSP7) << 16);
		}
	}

would be clearer, and probably more efficient.  (gcc isn't really
that good at working out bit patterns from switch statements.)

> +	/* Optimize the loop a bit by calculating the register only
> +	 * once */
> +	reg = host->base + OMAP_MMC_REG_DATA;
> +	p = host->buffer;
> +	n /= 2;
> +	if (write) {
> +		while (n--)
> +			__raw_writew(*p++, reg);
> +	} else {
> +		while (n-- > 0)
> +			*p++ = __raw_readw(reg);
> +	}

readsw / writesw would be a far more efficient implementation.

> +	host->base = (void __iomem *)pdev->resource[0].start;

This is still very very very very wrong.  MMIO resources do not contain
virtual addresses.  Casting it to a virtual address like this is insane.

> +	mmc_add_host(mmc);

At this point the host becomes live.  Is the following initialisation
safe to do after the host has been manipulated to talk to MMC cards?

> +
> +	if (host->switch_pin >= 0) {
> +		INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
> +		init_timer(&host->switch_timer);
> +		host->switch_timer.function = mmc_omap_switch_timer;
> +		host->switch_timer.data = (unsigned long) host;
> +		if (omap_request_gpio(host->switch_pin) != 0) {
> +			printk(KERN_WARNING "MMC%d: Unable to get GPIO pin for MMC cover switch\n",
> +			       host->id);
> +			host->switch_pin = -1;
> +			goto no_switch;
> +		}
> +
> +		omap_set_gpio_direction(host->switch_pin, 1);
> +		set_irq_type(OMAP_GPIO_IRQ(host->switch_pin), IRQT_RISING);
> +		ret = request_irq(OMAP_GPIO_IRQ(host->switch_pin),
> +				  mmc_omap_switch_irq, 0, DRIVER_NAME, host);

Don't use set_irq_type, use request_irq with SA_TRIGGER_RISING please.

> +	if (host) {
> +		mmc_remove_host(host->mmc);
> +		free_irq(host->irq, host);
> +#ifdef CONFIG_I2C
> +		mmc_omap_power(host, 0);
> +#endif

Power should be turned off by the MMC layer anyway.

> +#ifdef CONFIG_PM
> +static int mmc_omap_suspend(struct platform_device *pdev, pm_message_t mesg)
> +{
> +	int ret = 0;
> +	struct mmc_omap_host *host = platform_get_drvdata(pdev);
> +
> +	if (host && host->suspended)
> +		return 0;
> +
> +	if (!irqs_disabled())
> +		return -EAGAIN;

IRQs will never be disabled here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
