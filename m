Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWBXUtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWBXUtK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWBXUsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:48:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22285 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932481AbWBXUsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:48:30 -0500
Date: Fri, 24 Feb 2006 20:48:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC] mmc: add OMAP driver
Message-ID: <20060224204823.GA28855@flint.arm.linux.org.uk>
Mail-Followup-To: Carlos Aguiar <carlos.aguiar@indt.org.br>,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>
References: <43F48BCA.8010608@indt.org.br> <20060216165957.GC29443@flint.arm.linux.org.uk> <43FF3680.2070608@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FF3680.2070608@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 12:38:24PM -0400, Carlos Aguiar wrote:
> All suggestions and comments are welcome.

Okay, further comments.  Almost there!

> +/* PIO only */
> +static void
> +mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
> +{
> +	int n;
> +	void __iomem *reg;
> +	u16 *p;
> +
> +	if (host->buffer_bytes_left == 0) {
> +		host->sg_idx++;
> +		BUG_ON(host->sg_idx == host->sg_len);
> +		mmc_omap_sg_to_buf(host);
> +	}
> +	n = 64;
> +	if (n > host->buffer_bytes_left)
> +		n = host->buffer_bytes_left;
> +	host->buffer_bytes_left -= n;
> +	host->total_bytes_left -= n;
> +	host->data->bytes_xfered += n;
> +
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

I thought I made a comment about readsw/writesw being more efficient
versions of these?

> +	host->buffer = p;
> +}

> +static irqreturn_t mmc_omap_irq(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct mmc_omap_host * host = (struct mmc_omap_host *)dev_id;
> +	u16 status;
> +	int end_command;
> +	int end_transfer;
> +	int transfer_error;
> +
> +	if (host->cmd == NULL && host->data == NULL) {
> +		status = OMAP_MMC_READ(host->base, STAT);
> +		printk(KERN_INFO "MMC%d: Spurious interrupt 0x%04x\n",
> +				host->id, status);

		dev_info(mmc_dev(host->mmc), "spurious irq 0x%04x\n", status);

There's no need to print host->id - mmc_dev(host->mmc) will print the
platform device bus_id, which is generated from the platform device
name and the platform device id.

> +		if (status != 0) {
> +			OMAP_MMC_WRITE(host->base, STAT, status);
> +			OMAP_MMC_WRITE(host->base, IE, 0);
> +		}
> +		return IRQ_HANDLED;
> +	}
> +
> +	end_command = 0;
> +	end_transfer = 0;
> +	transfer_error = 0;
> +
> +	while ((status = OMAP_MMC_READ(host->base, STAT)) != 0) {
> +		OMAP_MMC_WRITE(host->base, STAT, status);
> +#ifdef CONFIG_MMC_DEBUG
> +		printk(KERN_DEBUG "MMC IRQ %04x (CMD %d): ", status,
> +		       host->cmd != NULL ? host->cmd->opcode : -1);

		dev_dbg(mmc_dev(host->mmc), "MMC IRQ %04x (CMD %d): ",
			status, host->cmd != NULL ? host->cmd->opcode : -1);

> +		mmc_omap_report_irq(status);
> +		printk("\n");
> +#endif
> +		if (host->total_bytes_left) {
> +			if ((status & OMAP_MMC_STAT_A_FULL) ||
> +			    (status & OMAP_MMC_STAT_END_OF_DATA))
> +				mmc_omap_xfer_data(host, 0);
> +			if (status & OMAP_MMC_STAT_A_EMPTY)
> +				mmc_omap_xfer_data(host, 1);
> +		}
> +
> +		if (status & OMAP_MMC_STAT_END_OF_DATA) {
> +			end_transfer = 1;
> +		}
> +
> +		if (status & OMAP_MMC_STAT_DATA_TOUT) {
> +			dev_dbg(mmc_dev(host->mmc), "MMC%d: Data timeout\n",
> +					host->id);

			dev_dbg(mmc_dev(host->mmc), "data timeout\n");

> +			if (host->data) {
> +				host->data->error |= MMC_ERR_TIMEOUT;
> +				transfer_error = 1;
> +			}
> +		}
> +
> +		if (status & OMAP_MMC_STAT_DATA_CRC) {
> +			if (host->data) {
> +				host->data->error |= MMC_ERR_BADCRC;
> +				dev_dbg(mmc_dev(host->mmc), "MMC%d: Data CRC
> +						error, bytes left %d\n",
> +						host->id,
> +						host->total_bytes_left);

				dev_dbg(mmc_dev(host->mmc),
					 "data CRC error, bytes left %d\n",
					host->total_bytes_left);

> +				transfer_error = 1;
> +			} else {
> +				dev_dbg(mmc_dev(host->mmc), "MMC%d: Data CRC
> +						error\n", host->id);

				dev_dbg(mmc_dev(host->mmc), "data CRC error\n");

> +			}
> +		}
> +
> +		if (status & OMAP_MMC_STAT_CMD_TOUT) {
> +			/* Timeouts are routine with some commands */
> +			if (host->cmd) {
> +				if (host->cmd->opcode != MMC_ALL_SEND_CID &&
> +						host->cmd->opcode !=
> +						MMC_SEND_OP_COND &&
> +						host->cmd->opcode !=
> +						MMC_APP_CMD &&
> +						!mmc_omap_cover_is_open(host))
> +					dev_err(mmc_dev(host->mmc), "MMC%d:
> +							Command timeout,
> +							CMD%d\n", host->id,
> +							host->cmd->opcode);

					dev_err(mmc_dev(host->mmc),
						"command timeout, CMD %d\n",
						host->cmd->opcode);

> +				host->cmd->error = MMC_ERR_TIMEOUT;
> +				end_command = 1;
> +			}
> +		}
> +
> +		if (status & OMAP_MMC_STAT_CMD_CRC) {
> +			if (host->cmd) {
> +				dev_err(mmc_dev(host->mmc), "MMC%d: Command CRC
> +						error (CMD%d, arg 0x%08x)\n",
> +						host->id, host->cmd->opcode,
> +						host->cmd->arg);

				dev_err(mmc_dev(host->mmc),
					"command CRC error (CMD%d, arg 0x%08x)\n",
					host->cmd->opcode, host->cmd->arg);

> +				host->cmd->error = MMC_ERR_BADCRC;
> +				end_command = 1;
> +			} else
> +				dev_err(mmc_dev(host->mmc), "MMC%d: Command CRC
> +						error without cmd?\n",
> +						host->id);

				dev_err(mmc_dev(host->mmc),
					"command CRC error without cmd?\n");

> +		}
> +
> +		if (status & OMAP_MMC_STAT_CARD_ERR) {
> +			if (host->cmd && host->cmd->opcode == MMC_STOP_TRANSMISSION) {
> +				u32 response = OMAP_MMC_READ(host->base, RSP6)
> +					| (OMAP_MMC_READ(host->base, RSP7) << 16);
> +				/* STOP sometimes sets must-ignore bits */
> +				if (!(response & (R1_CC_ERROR
> +								| R1_ILLEGAL_COMMAND
> +								| R1_COM_CRC_ERROR))) {
> +					end_command = 1;
> +					continue;
> +				}
> +			}
> +
> +			dev_dbg(mmc_dev(host->mmc), "MMC%d: Card status error (CMD%d)\n",
> +			       host->id, host->cmd->opcode);

			dev_dbg(mmc_dev(host->mmc), "card status error (CMD%d)\n",
				host->cmd->opcode);

> +			if (host->cmd) {
> +				host->cmd->error = MMC_ERR_FAILED;
> +				end_command = 1;
> +			}
> +			if (host->data) {
> +				host->data->error = MMC_ERR_FAILED;
> +				transfer_error = 1;
> +			}
> +		}
> +
> +		/*
> +		 * NOTE: On 1610 the END_OF_CMD may come too early when
> +		 * starting a write 
> +		 */
> +		if ((status & OMAP_MMC_STAT_END_OF_CMD) &&
> +		    (!(status & OMAP_MMC_STAT_A_EMPTY))) {
> +			end_command = 1;
> +		}
> +	}
> +
> +	if (end_command) {
> +		mmc_omap_cmd_done(host, host->cmd);
> +	}
> +	if (transfer_error)
> +		mmc_omap_xfer_done(host, host->data);
> +	else if (end_transfer)
> +		mmc_omap_end_of_data(host, host->data);
> +
> +	return IRQ_HANDLED;
> +}

Same comments for the other dev_* and printk's.

> +static int __init mmc_omap_probe(struct platform_device *pdev)
> +{
> +	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
> +	struct mmc_host *mmc;
> +	struct mmc_omap_host *host = NULL;
> +	int ret = 0;
> +	
> +	if (platform_get_resource(pdev, IORESOURCE_MEM, 0) ||
> +			platform_get_irq(pdev, IORESOURCE_IRQ, 0)) {
> +		dev_err(&pdev->dev, "mmc_omap_probe: invalid resource type\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!request_mem_region(pdev->resource[0].start,
> +				pdev->resource[0].end - pdev->resource[0].start + 1,
> +				pdev->name)) {
> +		dev_dbg(&pdev->dev, "request_mem_region failed\n");
> +		return -EBUSY;
> +	}
> +
> +	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
> +	if (!mmc) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	host = mmc_priv(mmc);
> +	host->mmc = mmc;
> +
> +	spin_lock_init(&host->dma_lock);
> +	init_timer(&host->dma_timer);
> +	host->dma_timer.function = mmc_omap_dma_timer;
> +	host->dma_timer.data = (unsigned long) host;
> +
> +	host->id = pdev->id;
> +
> +	if (cpu_is_omap24xx()) {
> +		host->iclk = clk_get(&pdev->dev, "mmc_ick");
> +		if (IS_ERR(host->iclk))
> +			goto out;
> +		clk_enable(host->iclk);
> +	}
> +
> +	if (!cpu_is_omap24xx())
> +		host->fclk = clk_get(&pdev->dev, "mmc_ck");
> +	else
> +		host->fclk = clk_get(&pdev->dev, "mmc_fck");
> +
> +	if (IS_ERR(host->fclk)) {
> +		ret = PTR_ERR(host->fclk);
> +		goto out;
> +	}
> +
> +	/* REVISIT:
> +	 * Also, use minfo->cover to decide how to manage
> +	 * the card detect sensing.
> +	 */
> +	host->power_pin = minfo->power_pin;
> +	host->switch_pin = minfo->switch_pin;
> +	host->wp_pin = minfo->wp_pin;
> +	host->use_dma = 1;
> +	host->dma_ch = -1;
> +
> +	host->irq = pdev->resource[1].start;
> +	host->base = ioremap(pdev->res.start, SZ_4K);

What if ioremap fails with NULL?

> +
> +	 if (minfo->wire4)
> +		 mmc->caps |= MMC_CAP_4_BIT_DATA;
> +
> +	mmc->ops = &mmc_omap_ops;
> +	mmc->f_min = 400000;
> +	mmc->f_max = 24000000;
> +	mmc->ocr_avail = MMC_VDD_33_34;

Some cards want at least two bits set - use MMC_VDD_32_33|MMC_VDD_33_34
here please.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
