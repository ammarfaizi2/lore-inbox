Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWBAMow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWBAMow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWBAMow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:44:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46347 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161048AbWBAMov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:44:51 -0500
Date: Wed, 1 Feb 2006 12:44:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 1/5] MMC OMAP driver
Message-ID: <20060201124434.GC3072@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
References: <43DF6750.1060505@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DF6750.1060505@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 09:34:08AM -0400, Anderson Briglia wrote:
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

The 4 command types are decodable from the information provided.

bc - broadcast commands without response
bcr - broadcast commands with response
ac - addressed command
adtc - addressed data transfer command

>From this, there are three bits of information required:

1. is the command addressed or broadcast (bc/bcr vs ac/adtc)?
2. if broadcast, does it have a response (bc vs bcr)?
	(mrq->cmd->flags & MMC_RSP_MASK) != MMC_RSP_NONE
   satisfies this by definition.
3. if addressed, does it have a data transfer (ac vs adtc)?
	mrq->data != NULL
   satisfies this by definition.

Hence, to allow host drivers to decode the command type, we only need
to supply information on whether this was a broadcast or addressed
command.  This could be a flag MMC_CMD_BROADCAST, which is passed
with the command.

I'm thinking we want a couple of helper functions:

	mmc_resp_type(cmd)
	mmc_cmd_type(cmd)

which would allow the flags value to be tested for response and command
types - in which case we'd need to also have MMC_CMD_DATA as well.  For
an example of what I'm proposing, see the end of this message.

> +#ifdef CONFIG_MMC_DEBUG
> +		printk(KERN_DEBUG "\tMMC IRQ %04x (CMD %d): ", status,

Please don't embed \t in printk strings.

> +				printk(KERN_DEBUG "MMC%d: Data CRC error, bytes left %d\n",
> +				       host->id, host->total_bytes_left);

pr_debug or even better dev_debug().

> +				printk(KERN_DEBUG "MMC%d: Data CRC error\n",
> +				       host->id);

ditto.

> +					printk(KERN_ERR "MMC%d: Command timeout, CMD%d\n",
> +					       host->id, host->cmd->opcode);

dev_err().

> +				host->cmd->error |= MMC_ERR_TIMEOUT;

These aren't something which you OR.  If you assume you can, if you
end up with MMC_ERR_TIMEOUT | MMC_ERR_BADCRC, you end up with
MMC_ERR_FIFO status instead.

> +				printk(KERN_ERR "MMC%d: Command CRC error (CMD%d, arg 0x%08x)\n",
> +				       host->id, host->cmd->opcode,
> +				       host->cmd->arg);
> +				host->cmd->error |= MMC_ERR_BADCRC;

Same.

> +			if (host->cmd) {
> +				host->cmd->error |= MMC_ERR_FAILED;

Ditto.

> +			if (host->data) {
> +				host->data->error |= MMC_ERR_FAILED;

Ditto.

> +static void mmc_omap_switch_handler(void *data)
> +{
> +	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
> +	struct mmc_card *card;
> +	static int complained = 0;
> +	int cards = 0, cover_open;
> +
> +	if (host->switch_pin == -1)
> +		return;
> +	cover_open = mmc_omap_cover_is_open(host);
> +	if (cover_open != host->switch_last_state) {
> +		kobject_uevent(&host->dev->kobj, KOBJ_CHANGE);
> +		host->switch_last_state = cover_open;
> +	}
> +	mmc_detect_change(host->mmc, 0);
> +	list_for_each_entry(card, &host->mmc->cards, node) {
> +		if (mmc_card_present(card))
> +			cards++;
> +	}

Is cards a write-only variable?

> +	if (mmc_omap_cover_is_open(host)) {
> +		if (!complained) {
> +			printk(KERN_INFO "MMC%d: cover is open\n", host->id);
> +			complained = 1;
> +		}
> +		if (mmc_omap_enable_poll)
> +			mod_timer(&host->switch_timer, jiffies +
> +				msecs_to_jiffies(OMAP_MMC_SWITCH_POLL_DELAY));
> +	} else {
> +		complained = 0;
> +	}
> +}


> +	data_addr = io_v2p((void __force *) host->base) + OMAP_MMC_REG_DATA;

Drivers should not use __force.

> +	frame = 1 << data->blksz_bits;
> +	count = (u32)sg_dma_len(sg);

Pointless cast.

> +	/* Some cards require more time to do at least the first read operation */
> +	timeout = timeout << 4;

Wouldn't this be a problem which isn't host specific?  If so, why should
the fix be limited to just omap hosts?  IOW: it's the wrong layer to fix
this problem.

> +static inline int is_broken_card(struct mmc_card *card)
> +{
> +	int i;
> +	struct mmc_cid *c = &card->cid;
> +	static const struct broken_card_cid {
> +		unsigned int manfid;
> +		char prod_name[8];
> +		unsigned char hwrev;
> +		unsigned char fwrev;
> +	} broken_cards[] = {
> +		{ 0x00150000, "\x30\x30\x30\x30\x30\x30\x15\x00", 0x06, 0x03 },
> +	};
> +
> +	for (i = 0; i < sizeof(broken_cards)/sizeof(broken_cards[0]); i++) {
> +		const struct broken_card_cid *b = broken_cards + i;
> +
> +		if (b->manfid != c->manfid)
> +			continue;
> +		if (memcmp(b->prod_name, c->prod_name, sizeof(b->prod_name)) != 0)
> +			continue;
> +		if (b->hwrev != c->hwrev || b->fwrev != c->fwrev)
> +			continue;
> +		return 1;
> +	}
> +	return 0;
> +}

I've already mentioned this to the OMAP folk... What problem is this
trying to work around?  If it's a card problem, it's at the wrong
level.  If it's a problem with the host not waiting the mandatory
80 cycles before starting a command, that could be the upper layers
or a host problem.

Either way, the right place to fix this is _not_ in the request
function but in the set_ios function.  The request function does
not know if the card has just been powered up.

> +
> +static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
> +{
> +	struct mmc_omap_host *host = mmc_priv(mmc);
> +
> +	WARN_ON(host->mrq != NULL);
> +
> +	host->mrq = req;
> +
> +	/* Some cards (vendor left unnamed to protect the guilty) seem to
> +	 * require this delay after power-up. Otherwise we'll get mysterious
> +	 * data timeouts.
> +	 */
> +	if (req->cmd->opcode == MMC_SEND_CSD) {

Moreover, it assumes that MMC_SEND_CSD is the first command.  It
is not.  This code is therefore itself broken.

> +static void innovator_fpga_socket_power(int on)
> +{
> +#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
> +
> +	if (on) {
> +		fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
> +		     OMAP1510_FPGA_POWER);
> +	} else {
> +		fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
> +		     OMAP1510_FPGA_POWER);
> +	}
> +#endif
> +}

Should be platform supplied data.

> +
> +/*
> + * Turn the socket power on/off. Innovator uses FPGA, most boards
> + * probably use GPIO.
> + */
> +static void mmc_omap_power(struct mmc_omap_host *host, int on)
> +{
> +#ifdef CONFIG_I2C
> +	if (on) {
> +		if (machine_is_omap_innovator())
> +			innovator_fpga_socket_power(1);
> +		else if (machine_is_omap_h2())
> +			tps65010_set_gpio_out_value(GPIO3, HIGH);
> +		else if (machine_is_omap_h3())
> +			/* GPIO 4 of TPS65010 sends SD_EN signal */
> +			tps65010_set_gpio_out_value(GPIO4, HIGH);
> +		else if (cpu_is_omap24xx()) {
> +			u16 reg = OMAP_MMC_READ(host->base, CON);
> +			OMAP_MMC_WRITE(host->base, CON, reg | (1 << 11));
> +		} else
> +			if (host->power_pin >= 0)
> +				omap_set_gpio_dataout(host->power_pin, 1);
> +	} else {
> +		if (machine_is_omap_innovator())
> +			innovator_fpga_socket_power(0);
> +		else if (machine_is_omap_h2())
> +			tps65010_set_gpio_out_value(GPIO3, LOW);
> +		else if (machine_is_omap_h3())
> +			tps65010_set_gpio_out_value(GPIO4, LOW);
> +		else if (cpu_is_omap24xx()) {
> +			u16 reg = OMAP_MMC_READ(host->base, CON);
> +			OMAP_MMC_WRITE(host->base, CON, reg & ~(1 << 11));
> +		} else
> +			if (host->power_pin >= 0)
> +				omap_set_gpio_dataout(host->power_pin, 0);
> +	}
> +#endif
> +}

Ditto.

> +static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct mmc_omap_host *host = mmc_priv(mmc);
> +	int dsor;
> +	int realclock, i;
> +
> +	if (ios->power_mode == MMC_POWER_UP && ios->clock < 400000)
> +		realclock = 400000;
> +	else
> +		realclock = ios->clock;

You've already told the MMC layer that your minimum clock is 400000
via mmc->f_min.  Therefore, you won't be offered a clock rate lower
than this, so this test is superfluous.

> +	host->bus_mode = ios->bus_mode;
> +	if (omap_has_menelaus()) {
> +		if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
> +			menelaus_mmc_opendrain(1);
> +		else
> +			menelaus_mmc_opendrain(0);
> +	}
> +	host->hw_bus_mode = host->bus_mode;

Since this is the only place where the bus mode is changed, why do you
have similar code elsewhere in this driver?

> +static int __init mmc_omap_probe(struct platform_device *pdev)
> +{
> +	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
> +	struct mmc_host *mmc;
> +	struct mmc_omap_host *host = NULL;
> +	int ret = 0;
> +
> +	if (pdev->resource[0].flags != IORESOURCE_MEM
> +	    || pdev->resource[1].flags != IORESOURCE_IRQ) {
> +		printk(KERN_ERR "mmc_omap_probe: invalid resource type\n");
> +		return -ENODEV;
> +	}

Eww.  Why not use the helper functions - platform_get_irq and
platform_get_resource ?

> +	if (cpu_is_omap24xx()) {
> +		host->iclk = clk_get(&pdev->dev, "mmc_ick");
> +		if (IS_ERR(host->iclk))
> +			goto out;
> +		clk_enable(host->iclk);
> +	}
> +
> +	if (!cpu_is_omap24xx())
> +		host->fclk = clk_get(&pdev->dev,
> +				    (host->id == 1) ? "mmc1_ck" : "mmc2_ck");
> +	else
> +		host->fclk = clk_get(&pdev->dev, "mmc_fck");

Wrong use of the clock API:

 * clk_get - lookup and obtain a reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock comsumer ID

The ID string is supposed to be the consumer ID, not the producer ID.
If you have multiple devices of the same type, this string is supposed
to be a constant, and you're supposed to use the struct device to
work out which producer is required.

> +	host->irq = pdev->resource[1].start;
> +	host->base = (void __iomem *)pdev->resource[0].start;

Resources are _not_ MMIO pointers.  Don't treat them as such.

> +	mmc->f_max = 24000000;
> +	mmc->ocr_avail = MMC_VDD_33_34;

FYI, some cards want at least _two_ bits set.  That's another card
problem.

> +
> +	/* Use scatterlist DMA to reduce per-transfer costs.
> +	 * NOTE max_seg_size assumption that small blocks aren't
> +	 * normally used (except e.g. for reading SD registers).
> +	 */
> +	mmc->max_phys_segs = 32;
> +	mmc->max_hw_segs = 32;
> +	mmc->max_sectors = 256; /* NBLK max 11-bits, OMAP also limited by DMA */
> +	mmc->max_seg_size = mmc->max_sectors * 512;
> +
> +	if (host->power_pin >= 0) {
> +		if ((ret = omap_request_gpio(host->power_pin)) != 0) {
> +			printk(KERN_ERR "MMC%d: Unable to get GPIO pin for MMC power\n",
> +			       host->id);
> +			goto out;
> +		}
> +		omap_set_gpio_direction(host->power_pin, 0);
> +	}
> +
> +	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
> +	if (ret)
> +		goto out;
> +
> +	host->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, host);
> +
> +	mmc_add_host(mmc);

At this point, the MMC host becomes live and will be used by the MMC layer.
Is any of the following setup required before the host is used?

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

Don't use set_irq_type + request_irq.  Use request_irq with the
appropriate SA_TRIGGER flags.

> +		if (ret) {
> +			printk(KERN_WARNING "MMC%d: Unable to get IRQ for MMC cover switch\n",
> +			       host->id);
> +			omap_free_gpio(host->switch_pin);
> +			host->switch_pin = -1;
> +			goto no_switch;
> +		}
> +		ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
> +		if (ret == 0) {
> +			ret = device_create_file(&pdev->dev, &dev_attr_enable_poll);
> +			if (ret != 0)
> +				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
> +		}
> +		if (ret) {
> +			printk(KERN_WARNING "MMC%d: Unable to create sysfs attributes\n",
> +					host->id);
> +			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
> +			omap_free_gpio(host->switch_pin);
> +			host->switch_pin = -1;
> +			goto no_switch;
> +		}
> +		if (mmc_omap_enable_poll && mmc_omap_cover_is_open(host))
> +			schedule_work(&host->switch_work);
> +	}
> +
> +	if (omap_has_menelaus())
> +		menelaus_mmc_register(mmc_omap_switch_callback, &host);


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
> +
> +	if (host) {
> +		ret = mmc_suspend_host(host->mmc, mesg);

You can't call mmc_suspend_host with IRQs disabled.  It might sleep.

> Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc.c
> ===================================================================
> --- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc.c	2006-01-25 16:11:46.000000000 -0400
> +++ linux-2.6.15-mmc_omap/drivers/mmc/mmc.c	2006-01-25 16:25:45.000000000 -0400
> @@ -392,7 +392,6 @@ static void mmc_deselect_cards(struct mm
>  	}
>  }
> 
> -
>  static inline void mmc_delay(unsigned int ms)
>  {
>  	if (ms < HZ / 1000) {

What's this change doing in a patch to add a driver?


Finally, here's the outline of what I'm proposing for passing command
types to MMC host drivers.  Comments?

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -21,24 +21,42 @@ struct mmc_command {
 	u32			arg;
 	u32			resp[4];
 	unsigned int		flags;		/* expected response type */
-#define MMC_RSP_NONE	(0 << 0)
-#define MMC_RSP_SHORT	(1 << 0)
-#define MMC_RSP_LONG	(2 << 0)
-#define MMC_RSP_MASK	(3 << 0)
+#define MMC_RSP_PRESENT	(1 << 0)
+#define MMC_RSP_136	(1 << 1)		/* 136 bit response */
 #define MMC_RSP_CRC	(1 << 3)		/* expect valid crc */
 #define MMC_RSP_BUSY	(1 << 4)		/* card may send busy */
 #define MMC_RSP_OPCODE	(1 << 5)		/* response contains opcode */
+#define MMC_CMD_BCAST	(1 << 6)		/* command is broadcast */
+#define MMC_CMD_DATA	(1 << 7)		/* command has data */
+
+/* compatibility */
+#define MMC_RSP_MASK	(MMC_RSP_PRESENT|MMC_RSP_136)
+#define MMC_RSP_SHORT	(MMC_RSP_PRESENT)
+#define MMC_RSP_LONG	(MMC_RSP_PRESENT|MMC_RSP_136)
 
 /*
  * These are the response types, and correspond to valid bit
  * patterns of the above flags.  One additional valid pattern
  * is all zeros, which means we don't expect a response.
  */
-#define MMC_RSP_R1	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE)
-#define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
-#define MMC_RSP_R2	(MMC_RSP_LONG|MMC_RSP_CRC)
-#define MMC_RSP_R3	(MMC_RSP_SHORT)
-#define MMC_RSP_R6	(MMC_RSP_SHORT|MMC_RSP_CRC)
+#define MMC_RSP_NONE	(0)
+#define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
+#define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
+#define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
+#define MMC_RSP_R3	(MMC_RSP_PRESENT)
+#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
+
+#define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
+
+/*
+ * These are the command types.
+ */
+#define MMC_CMD_AC	(MMC_RSP_PRESENT)
+#define MMC_CMD_ADTC	(MMC_RSP_PRESENT|MMC_CMD_DATA)
+#define MMC_CMD_BC	(MMC_RSP_BCAST)
+#define MMC_CMD_BCR	(MMC_RSP_PRESENT|MMC_RSP_BCAST)
+
+#define mmc_cmd_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_CMD_BCAST|MMC_CMD_DATA))
 
 	unsigned int		retries;	/* max number of retries */
 	unsigned int		error;		/* command error */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
