Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWHFOfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWHFOfT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHFOfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:35:19 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:65040 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932539AbWHFOfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:35:18 -0400
Date: Sun, 6 Aug 2006 16:35:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Cc: tony@atomide.com, David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-Id: <20060806163516.5458d47c.khali@linux-fr.org>
In-Reply-To: <1154689868.12791.267626769@webmail.messagingengine.com>
References: <1154689868.12791.267626769@webmail.messagingengine.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

> I have attached the updated patch, which addresses the most of review
> comments.

Here we go for another review:

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -287,6 +287,14 @@ config I2C_OCORES
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-ocores.
>  
> +config I2C_OMAP
> +	tristate "OMAP I2C adapter"
> +	depends on I2C && ARCH_OMAP
> +	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Texas Instruments OMAP(http://www.ti.com/omap) I2C driver.
> +

Missing space before opening parenthesis. And "including support for a
driver" still doesn't make sense, sorry. The driver is what supports a
device.

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-omap.c

> +/* I2C System Test Register (OMAP_I2C_SYSTEST): */
> +#ifdef DEBUG
> +#define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
> +#define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
> +#define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
> +#define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
> +#define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
> +#define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
> +#define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
> +#define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
> +#endif
> +
> +/* I2C System Status register (OMAP_I2C_SYSS): */
> +#define OMAP_I2C_SYSS_RDONE		1		/* Reset Done */

Shouldn't it be (1 << 0) for consistency?

> +
> +/* I2C System Configuration Register (OMAP_I2C_SYSC): */
> +#define OMAP_I2C_SYSC_SRST		(1 << 1)	/* Soft Reset */
> +static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> +{
> +	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
> +		dev->iclk = clk_get(dev->dev, "i2c_ick");
> +		if (IS_ERR(dev->iclk)) {
> +			dev->iclk = NULL;
> +			return -ENODEV;
> +		}
> +	}
> +
> +	dev->fclk = clk_get(dev->dev, "i2c_fck");
> +	if (IS_ERR(dev->fclk)) {
> +		if (dev->iclk != NULL) {
> +			clk_put(dev->iclk);
> +			dev->iclk = NULL;
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}

You broke the second error path while trying to address my previous
objection... dev->fclk is still not reset to NULL on error, and
additionally you return 0 (instead of -ENODEV) if dev->iclk == NULL and
clk_get(dev->dev, "i2c_fck") fails. Please fix.

> +static int omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +	u16 psc = 0;
> +	unsigned long fclk_rate = 12000000;
> +	unsigned long timeout;
> +
> +	if (!dev->rev1) {
> +		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
> +		/* For some reason we need to set the EN bit before the
> +		 * reset done bit gets set. */
> +		timeout = jiffies + OMAP_I2C_TIMEOUT;
> +		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
> +			 OMAP_I2C_SYSS_RDONE)) {
> +			if (time_after(jiffies, timeout)) {
> +				dev_warn(dev->dev, "timeout waiting"
> +						"for controller reset\n");
> +				return -ETIMEDOUT;
> +			}
> +			msleep(1);
> +		}
> +	}
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +
> +	if (cpu_class_is_omap1()) {
> +		struct clk *armxor_ck;
> +
> +		armxor_ck = clk_get(NULL, "armxor_ck");
> +		if (IS_ERR(armxor_ck)) {
> +			dev_warn(dev->dev, "i2c: Could not get armxor_ck\n");

The "i2c: " should go away now that you use dev_warn() instead of
printk().

> +			fclk_rate = 12000000;

This is already the value of fclk_rate, you initialized it at the top
of the function.

> +		} else {
> +			fclk_rate = clk_get_rate(armxor_ck);
> +			clk_put(armxor_ck);
> +		}
> +
> +		if (fclk_rate > 16000000)
> +			psc = (fclk_rate + 8000000) / 12000000;
> +		else
> +			psc = 0;

Ditto.

> +	}

> +
> +/*
> + * Low level master read/write transaction.
> + */
> +static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> +			     struct i2c_msg *msg, int stop)
> +{
> +	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
> +	int r;
> +	u16 w;
> +	u8 zero_byte = 0;
> +
> +	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
> +		msg->addr, msg->len, msg->flags, stop);
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
> +
> +	/* Sigh, seems we can't do zero length transactions. Thus, we
> +	 * can't probe for devices w/o actually sending/receiving at least
> +	 * a single byte. So we'll set count to 1 for the zero length
> +	 * transaction case and hope we don't cause grief for some
> +	 * arbitrary device due to random byte write/read during
> +	 * probes.
> +	 */
> +	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
> +	if (msg->len == 0) {
> +		dev->buf = &zero_byte;
> +		dev->buf_len = 1;
> +	} else {

Hm, I thought we had all agreed that it wasn't acceptable? If msg->len
== 0, you can't handle the message, so return an error. Don't even
write to the address register.

> +		dev->buf = msg->buf;
> +		dev->buf_len = msg->len;
> +	}
> +	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);

> +static u32
> +omap_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C;
> +}

Most i2c chip drivers will not work then. You can actually achieve most
SMBus transactions, just not Quick Command. So you should return
I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK.

> +#ifdef DEBUG
> +			if (!(stat & OMAP_I2C_STAT_BB)) {
> +				dev_warn(dev->dev, "XRDY while bus not busy\n");
> +				bail_out = 1;
> +			}
> +#endif
> +			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> +			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
> +			if (bail_out)
> +				omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_SBD);
> +			continue;
> +		}

Enabling debug should never change the functional behavior of a driver.

Rest looks OK to me. Please address the few remaining issues and
resubmit your patch for inclusion.

-- 
Jean Delvare
