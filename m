Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWFVLqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWFVLqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbWFVLqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:46:09 -0400
Received: from trinity.fluff.org ([212.13.204.133]:40837 "EHLO
	trinity.fluff.org") by vger.kernel.org with ESMTP id S1161078AbWFVLqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:46:07 -0400
Date: Thu, 22 Jun 2006 12:45:06 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C bus driver for Philips ARM boards
Message-ID: <20060622114506.GF2028@trinity.fluff.org>
References: <20060622153146.2ae56e33.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622153146.2ae56e33.vitalywool@gmail.com>
User-Agent: Mutt/1.3.28i
X-Disclaimer: These are my views alone.
X-URL: http://www.fluff.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 03:31:46PM +0400, Vitaly Wool wrote:
> Please find below the I2C bus driver for Philips ARM boards (Philips IP3204 I2C IP block). This I2C controller can be found on PNX010x, PNX52xx and PNX4008 Philips boards.
> Any comments are welcome.
> 
>  arch/arm/mach-pnx4008/Makefile     |    2
>  arch/arm/mach-pnx4008/i2c.c        |  190 +++++++++
>  drivers/i2c/busses/Kconfig         |   10
>  drivers/i2c/busses/Makefile        |    2
>  drivers/i2c/busses/i2c-pnx.c       |  710 +++++++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-pnx4008/i2c.h |   86 ++++
>  include/linux/i2c-pnx.h            |   52 ++
>  7 files changed, 1051 insertions(+), 1 deletion(-)
> 
> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
> 
> Index: linux-2.6.git/drivers/i2c/busses/Kconfig
> ===================================================================
> --- linux-2.6.git.orig/drivers/i2c/busses/Kconfig
> +++ linux-2.6.git/drivers/i2c/busses/Kconfig
> @@ -517,4 +517,14 @@ config I2C_MV64XXX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mv64xxx.
>  
> +config I2C_PNX
> +       tristate "I2C bus support for Philips PNX targets"
> +       depends on ARCH_PNX4008 && I2C
> +       help
> +         This driver supports the Philips IP3204 I2C IP block master and/or
> +         slave controller
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i2c-pnx.
> +
>  endmenu
> Index: linux-2.6.git/drivers/i2c/busses/Makefile
> ===================================================================
> --- linux-2.6.git.orig/drivers/i2c/busses/Makefile
> +++ linux-2.6.git/drivers/i2c/busses/Makefile
> @@ -42,6 +42,8 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
>  obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> +obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
> +
>  
>  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
>  EXTRA_CFLAGS += -DDEBUG
> Index: linux-2.6.git/drivers/i2c/busses/i2c-pnx.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6.git/drivers/i2c/busses/i2c-pnx.c
> @@ -0,0 +1,710 @@
> +/*
> + * drivers/i2c/i2c-pnx.c
> + *
> + * Provides i2c support for PNX010x/PNX4008.
> + *
> + * Authors: Dennis Kovalev <dkovalev@ru.mvista.com>
> + * 	    Vitaly Wool <vwool@ru.mvista.com>
> + *
> + * 2004-2006 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/config.h>
> +#include <linux/interrupt.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/miscdevice.h>
> +#include <linux/timer.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/completion.h>
> +#include <linux/platform_device.h>
> +#include <asm/hardware.h>
> +#include <asm/irq.h>
> +#include <asm/uaccess.h>
> +#include <linux/i2c-pnx.h>
> +#include <asm/arch/i2c.h>
> +
> +struct pnx_i2c {
> +	int (*suspend) (struct platform_device * pdev, pm_message_t state);
> +	int (*resume) (struct platform_device * pdev);
> +	 u32(*calculate_input_freq) (struct platform_device * pdev);
> +	int (*set_clock_run) (struct platform_device * pdev);
> +	int (*set_clock_stop) (struct platform_device * pdev);
> +	struct i2c_adapter *adapter;
> +};
> +
> +char *i2c_pnx_modestr[] = {
> +	"Transmit",
> +	"Receive",
> +	"No Data",
> +};
> +
> +static inline void i2c_pnx_arm_timer(struct timer_list *timer, void *data)
> +{
> +	del_timer_sync(timer);
> +
> +	pr_debug("%s: Timer armed at %lu plus %u jiffies.\n",
> +		 __FUNCTION__, jiffies, TIMEOUT);

how about using the dev_dbg() macros?

> +	timer->expires = jiffies + TIMEOUT;
> +	timer->data = (unsigned long)data;
> +
> +	add_timer(timer);
> +}

> +static void i2c_pnx_stop(struct i2c_pnx_algo_data *alg_data)
> +{
> +	int cnt = 10000;
> +
> +	pr_debug("%s: %s() enter - stat = %04x.\n",
> +		 __FILE__, __FUNCTION__, alg_data->master->sts);
> +
> +	/* Write a STOP bit to TX FIFO */
> +	alg_data->master->fifo.tx = 0x000000ff | stop_bit;
> +
> +	/* Wait until the STOP is seen. */
> +	while (alg_data->master->sts & mstatus_active && cnt--);
> +
> +	pr_debug("%s: %s() exit - stat = %04x.\n",
> +		 __FILE__, __FUNCTION__, alg_data->master->sts);
> +}
> +
> +/**
> + * i2c_pnx_master_xmit - transmit data to slave
> + * @alg_data:		pointer to I2C-PNX algorithm data structure
> + *
> + * Sends one byte of data to the slave
> + */


> +
> +	/* Register I/O resource */
> +	if (!request_region(alg_data->base, I2C_BLOCK_SIZE, "i2c-pnx")) {
> +		printk(KERN_ERR
> +		       "I/O region 0x%08x for I2C already in use.\n",
> +		       alg_data->base);
> +		ret = -ENODEV;
> +		goto out0;
> +	}
> +
> +	i2c_pnx->set_clock_run(pdev);
> +
> +	/* Clock Divisor High This value is the number of system clocks
> +	 * the serial clock (SCL) will be high. n is defined at compile
> +	 * time based on the system clock (PCLK) and minimum serial frequency.
> +	 * For example, if the system clock period is 50 ns and the maximum
> +	 * desired serial period is 10000 ns (100 kHz), then CLKHI would be
> +	 * set to 0.5*(f_sys/f_i2c)-2=0.5*(20e6/100e3)-2=98. The actual value
> +	 * programmed into CLKHI will vary from this slightly due to
> +	 * variations in the output pad s rise and fall times as well as
> +	 * the deglitching filter length. In this example, n = 7, since
> +	 * eight bits are needed to hold the clock divider count.
> +	 */
> +
> +	tmp = ((freq_mhz * 1000) / I2C_PNX_SPEED_KHZ) / 2 - 2;
> +	alg_data->master->ckh = tmp;
> +	alg_data->master->ckl = tmp;
> +	alg_data->master->ctl = 0;
> +
> +	alg_data->master->ctl |= mcntrl_reset;
> +	while ((alg_data->master->ctl & mcntrl_reset) && cnt--) ;
> +	if (!cnt) {
> +		ret = -ENODEV;
> +		goto out1;
> +	}
> +	init_completion(&alg_data->mif.complete);
> +
> +	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
> +			0, CHIP_NAME, alg_data);
> +	if (ret)
> +		goto out2;
> +
> +	/* Register this adapter with the I2C subsystem */
> +	i2c_pnx->adapter->dev.parent = &pdev->dev;
> +	ret = i2c_add_adapter(i2c_pnx->adapter);
> +	if (ret < 0) {
> +		printk(KERN_INFO "I2C: Failed to add bus\n");
> +		goto out3;
> +	}
> +
> +	printk(KERN_INFO "%s: Master at %#8x, irq %d.\n",
> +	       i2c_pnx->adapter->name, alg_data->base, alg_data->irq);
> +
> +	return 0;
> +
> +      out3:
> +	free_irq(alg_data->irq, alg_data);
> +      out2:
> +	i2c_pnx->set_clock_stop(pdev);
> +      out1:
> +	release_region(alg_data->base, I2C_BLOCK_SIZE);
> +      out0:
> +	kfree(i2c_pnx);
> +      out:
> +	return ret;
> +}
> +
> +static int i2c_pnx_remove(struct platform_device *pdev)
> +{
> +	struct pnx_i2c *i2c_pnx = platform_get_drvdata(pdev);
> +	struct i2c_adapter *adap = i2c_pnx->adapter;
> +	struct i2c_pnx_algo_data *alg_data =
> +	    (struct i2c_pnx_algo_data *)adap->algo_data;
> +	int cnt = 10000;
> +
> +	/* Reset the I2C controller. The reset bit is self clearing. */
> +	alg_data->master->ctl |= mcntrl_reset;
> +	while ((alg_data->master->ctl & mcntrl_reset) && cnt--) ;
> +
> +	free_irq(alg_data->irq, alg_data);
> +	i2c_del_adapter(adap);
> +	i2c_pnx->set_clock_stop(pdev);
> +	release_region(alg_data->base, I2C_BLOCK_SIZE);
> +	kfree(i2c_pnx);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver i2c_pnx_driver = {
> +	.driver = {
> +		   .name = "pnx-i2c",
> +		   },
> +	.probe = i2c_pnx_probe,
> +	.remove = i2c_pnx_remove,
> +	.suspend = i2c_pnx_controller_suspend,
> +	.resume = i2c_pnx_controller_resume,
> +};
> +
> +static int __init i2c_adap_pnx_init(void)
> +{
> +	return platform_driver_register(&i2c_pnx_driver);
> +}
> +
> +static void i2c_adap_pnx_exit(void)
> +{
> +	return platform_driver_unregister(&i2c_pnx_driver);
> +}
> +
> +MODULE_AUTHOR("Dennis Kovalev <dkovalev@ru.mvista.com>");
> +MODULE_DESCRIPTION("I2C driver for PNX bus");
> +MODULE_LICENSE("GPL");
> +
> +subsys_initcall(i2c_adap_pnx_init);
> +module_exit(i2c_adap_pnx_exit);
> Index: linux-2.6.git/include/asm-arm/arch-pnx4008/i2c.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6.git/include/asm-arm/arch-pnx4008/i2c.h
> @@ -0,0 +1,86 @@
> +/*
> + *  include/asm-arm/arch-pnx4008/i2c.h
> + *
> + * Author: Vitaly Wool <vwool@ru.mvista.com>
> + *
> + * PNX4008-specific tweaks for I2C IP3204 block
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#ifndef __ASM_ARCH_I2C_H__
> +#define __ASM_ARCH_I2C_H__
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-pnx.h>
> +#include <linux/platform_device.h>
> +#include <asm/irq.h>
> +
> +enum {
> +	mstatus_tdi = 0x00000001,
> +	mstatus_afi = 0x00000002,
> +	mstatus_nai = 0x00000004,
> +	mstatus_drmi = 0x00000008,
> +	mstatus_active = 0x00000020,
> +	mstatus_scl = 0x00000040,
> +	mstatus_sda = 0x00000080,
> +	mstatus_rff = 0x00000100,
> +	mstatus_rfe = 0x00000200,
> +	mstatus_tff = 0x00000400,
> +	mstatus_tfe = 0x00000800,
> +};
> +
> +enum {
> +	mcntrl_tdie = 0x00000001,
> +	mcntrl_afie = 0x00000002,
> +	mcntrl_naie = 0x00000004,
> +	mcntrl_drmie = 0x00000008,
> +	mcntrl_daie = 0x00000020,
> +	mcntrl_rffie = 0x00000040,
> +	mcntrl_tffie = 0x00000080,
> +	mcntrl_reset = 0x00000100,
> +	mcntrl_cdbmode = 0x00000400,
> +};
> +
> +enum {
> +	rw_bit = 1 << 0,
> +	start_bit = 1 << 8,
> +	stop_bit = 1 << 9,
> +};
> +
> +struct i2c_regs {
> +	/* LSB */
> +	union {
> +		const u32 rx;	/* Receive FIFO Register - Read Only */
> +		u32 tx;		/* Transmit FIFO Register - Write Only */
> +	} fifo;
> +	u32 sts;		/* Status Register - Read Only */
> +	u32 ctl;		/* Control Register - Read/Write */
> +	u32 ckl;		/* Clock divider low  - Read/Write */
> +	u32 ckh;		/* Clock divider high - Read/Write */
> +	u32 adr;		/* I2C address (optional) - Read/Write */
> +	const u32 rfl;		/* Rx FIFO level (optional) - Read Only */
> +	const u32 _unused;	/* Tx FIFO level (optional) - Read Only */
> +	const u32 rxb;		/* Number of bytes received (opt.) - Read Only */
> +	const u32 txb;		/* Number of bytes transmitted (opt.) - Read Only */
> +	u32 txs;		/* Tx Slave FIFO register - Write Only */
> +	const u32 stfl;		/* Tx Slave FIFO level - Read Only */
> +	/* MSB */
> +};

ARGH, using structs to represent register sets is not good
practice, and worse, you've marked items in there const, so god
knows wether the compiler is going to cache results in the
cpu registers.

> +#define HCLK_MHZ		13
> +#define TIMEOUT			(2*(HZ))
> +
> +struct i2c_pnx_platform_data {
> +	int (*suspend) (struct platform_device * pdev, pm_message_t state);
> +	int (*resume) (struct platform_device * pdev);
> +	 u32(*calculate_input_freq) (struct platform_device * pdev);
> +	int (*set_clock_run) (struct platform_device * pdev);
> +	int (*set_clock_stop) (struct platform_device * pdev);
> +	struct i2c_adapter *adapter;
> +};
> +
> +#endif				/* __ASM_ARCH_I2C_H___ */
> Index: linux-2.6.git/include/linux/i2c-pnx.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6.git/include/linux/i2c-pnx.h
> @@ -0,0 +1,52 @@
> +/*
> + * include/linux/i2c-pnx.h
> + *
> + * Header file for i2c support for PNX010x/4008.
> + *
> + * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
> + *
> + * 2004 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#ifndef _I2C_PNX_H
> +#define _I2C_PNX_H
> +
> +typedef enum {
> +	xmit,
> +	rcv,
> +	nodata,
> +} i2c_pnx_mode_t;
> +
> +#define I2C_BUFFER_SIZE   0x100
> +
> +struct i2c_pnx_mif {
> +	int			ret;		/* Return value */
> +	i2c_pnx_mode_t	mode;		/* Interface mode */
> +	struct semaphore	sem;		/* Mutex for this interface */
> +	struct completion 	complete;	/* I/O completion */
> +	struct timer_list	timer;		/* Timeout */
> +	char *			buf;		/* Data buffer */
> +	int			len;		/* Length of data buffer */
> +};
> +
> +struct i2c_pnx_algo_data {
> +	u32	base;
> +	int	irq;
> +	int	clock_id;
> +	volatile struct i2c_regs *	master;
> +	char	buffer [I2C_BUFFER_SIZE];	/* contains data received from I2C bus */
> +	int	buf_index;			/* index within I2C buffer (see above) */
> +	struct i2c_pnx_mif	mif;
> +};
> +
> +#include <asm/arch/platform.h>
> +
> +#define TIMEOUT			(2*(HZ))
> +#define I2C_PNX_SPEED_KHZ	100
> +#define I2C_BLOCK_SIZE		0x100
> +#define CHIP_NAME		"PNX-I2C"
> +
> +#endif
> Index: linux-2.6.git/arch/arm/mach-pnx4008/Makefile
> ===================================================================
> --- linux-2.6.git.orig/arch/arm/mach-pnx4008/Makefile
> +++ linux-2.6.git/arch/arm/mach-pnx4008/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for the linux kernel.
>  #
>  
> -obj-y			:= core.o irq.o time.o clock.o gpio.o serial.o dma.o
> +obj-y			:= core.o irq.o time.o clock.o gpio.o serial.o dma.o i2c.o
>  obj-m			:=
>  obj-n			:=
>  obj-			:=
> Index: linux-2.6.git/arch/arm/mach-pnx4008/i2c.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6.git/arch/arm/mach-pnx4008/i2c.c
> @@ -0,0 +1,190 @@
> +/*
> + * arch/arm/mach-pnx4008/i2c.c
> + *
> + * I2C initialization for PNX4008.
> + *
> + * Author: Vitaly Wool <vitalywool@gmail.com>
> + *
> + * 2005-2006 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <asm/arch/platform.h>
> +#include <asm/arch/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/config.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +
> +static inline int i2c_pnx_suspend(struct platform_device *pdev,
> +				  pm_message_t state)
> +{
> +	int retval = 0;
> +#ifdef CONFIG_PM
> +	struct clk *clk;
> +	char name[10];
> +
> +	sprintf(name, "i2c%d_ck", pdev->id);

abuse of the clock system, you should pass the device as the first
argument, so the clk_get() implementor can differentiate between
different device's clocks of the same name!

ie:
	clk_get(&pdev->dev, "i2c");

> +	clk = clk_get(0, name);
> +	if (!IS_ERR(clk)) {
> +		clk_set_rate(clk, 0);
> +		clk_put(clk);
> +	} else
> +		retval = -ENOENT;
> +#endif
> +	return retval;
> +}
> +
> +static inline int i2c_pnx_resume(struct platform_device *pdev)
> +{
> +	int retval = 0;
> +#ifdef CONFIG_PM
> +	struct clk *clk;
> +	char name[10];
> +
> +	sprintf(name, "i2c%d_ck", pdev->id);
> +	clk = clk_get(0, name);

why not keep the struct clk with your adapter? this seems to
get re-used in several places, so keep the `struct clk *` since
you've got an implicit ref-lock on it by calling clk_get() it
isn't going anywhere!

> +	if (!IS_ERR(clk)) {
> +		clk_set_rate(clk, 1);
> +		clk_put(clk);
> +	} else
> +		retval = -ENOENT;
> +#endif
> +	return retval;
> +}
> +

These could have easily gone into the main driver, any
reason for keeping them seperate?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

