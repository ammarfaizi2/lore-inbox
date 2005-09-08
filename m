Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVIHMXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVIHMXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVIHMXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:23:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54540 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964865AbVIHMXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:23:45 -0400
Date: Thu, 8 Sep 2005 13:23:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 5/5] SharpSL: Add new ARM PXA machines Spitz and Borzoi with partial Akita Support
Message-ID: <20050908132340.D31595@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1126007632.8338.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126007632.8338.130.camel@localhost.localdomain>; from rpurdie@rpsys.net on Tue, Sep 06, 2005 at 12:53:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:53:52PM +0100, Richard Purdie wrote:
> +/*
> + * MMC/SD Device
> + *
> + * The card detect interrupt isn't debounced so we delay it by HZ/4
> + * to give the card a chance to fully insert/eject.
> + */
> +static struct mmc_detect {
> +	struct timer_list detect_timer;
> +	void *devid;
> +} mmc_detect;

This isn't necessary.  The "devid" is in timer_list already - in the "data"
element.  This is passed to the callback function as its only argument.
Sure, it means a couple of extra casts, but that's an mis-feature we
all know about in the timer API.  It should've been a void *.

> +static void mmc_detect_callback(unsigned long data)
> +{
> +	mmc_detect_change(mmc_detect.devid);
> +}
> +
> +static irqreturn_t spitz_mmc_detect_int(int irq, void *devid, struct pt_regs *regs)
> +{
> +	mmc_detect.devid=devid;

Also you don't need to set it each time.  devid will be a constant.

> +	mod_timer(&mmc_detect.detect_timer, jiffies + HZ/4);
> +	printk(KERN_WARNING "MMC detect callback\n");

Do you really want this obvious debugging noise here?

> +	return IRQ_HANDLED;
> +}

Hence, this becomes:

static void mmc_detect_callback(unsigned long devid)
{
	mmc_detect_change((void *)devid);
}

static irqreturn_t spitz_mmc_detect_int(int irq, void *devid, struct pt_regs *regs)
{
	struct timer_list *timer = devid;
	mod_timer(timer, jiffies + HZ/4);
	return IRQ_HANDLED;
}

> +
> +static int spitz_mci_init(struct device *dev, irqreturn_t (*unused_detect_int)(int, void *, struct pt_regs *), void *data)
> +{
> +	int err;
> +
> +	/* setup GPIO for PXA27x MMC controller	*/
> +	pxa_gpio_mode(GPIO32_MMCCLK_MD);
> +	pxa_gpio_mode(GPIO112_MMCCMD_MD);
> +	pxa_gpio_mode(GPIO92_MMCDAT0_MD);
> +	pxa_gpio_mode(GPIO109_MMCDAT1_MD);
> +	pxa_gpio_mode(GPIO110_MMCDAT2_MD);
> +	pxa_gpio_mode(GPIO111_MMCDAT3_MD);
> +	pxa_gpio_mode(SPITZ_GPIO_nSD_DETECT | GPIO_IN);
> +	pxa_gpio_mode(SPITZ_GPIO_nSD_WP | GPIO_IN);
> +
> +	init_timer(&mmc_detect.detect_timer);
> +	mmc_detect.detect_timer.function = mmc_detect_callback;
> +	mmc_detect.detect_timer.data = (unsigned long) &mmc_detect;

	init_timer(&mmc_detect_timer);
	mmc_detect_timer.function = mmc_detect_callback;
	mmc_detect_timer.data = (unsigned long)data;

> +
> +	err = request_irq(SPITZ_IRQ_GPIO_nSD_DETECT, spitz_mmc_detect_int, SA_INTERRUPT,
> +			     "MMC card detect", data);

	err = request_irq(SPITZ_IRQ_GPIO_nSD_DETECT, spitz_mmc_detect_int, SA_INTERRUPT,
			     "MMC card detect", &mmc_detect_timer);

> +	if (err) {
> +		printk(KERN_ERR "spitz_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
> +		return -1;
> +	}
> +
> +	set_irq_type(SPITZ_IRQ_GPIO_nSD_DETECT, IRQT_BOTHEDGE);
> +
> +	return 0;
> +}
> +
> +/* Power control is shared with one of the CF slots so we have a mess */
> +static void spitz_mci_setpower(struct device *dev, unsigned int vdd)
> +{
> +	struct pxamci_platform_data* p_d = dev->platform_data;
> +
> +	unsigned short cpr = read_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR);
> +
> +	if (( 1 << vdd) & p_d->ocr_mask) {
> +		/* printk(KERN_DEBUG "%s: on\n", __FUNCTION__); */
> +		set_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_CF_POWER);
> +		mdelay(2);
> +		write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, cpr | 0x04);
> +	} else {
> +		/* printk(KERN_DEBUG "%s: off\n", __FUNCTION__); */
> +		write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, cpr & ~0x04);
> +		
> +		if (!(cpr | 0x02)) {
> +			mdelay(1);
> +			reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_CF_POWER);
> +		}
> +	}

Hmm, this actually highlights an API issue - we need to call the
setpower() function with an additional argument which says whether
we want the power on or off - a vdd value of zero is used for both
"off" and the lowest voltage.

> +        .pxafb_backlight_power  = NULL,

We don't normally include NULL initialisers.

> +#endif
> \ No newline at end of file

This should be fixed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
