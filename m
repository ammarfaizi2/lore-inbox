Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVDRVLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVDRVLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDRVLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:11:00 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:19469 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261173AbVDRVKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:10:40 -0400
Date: Mon, 18 Apr 2005 23:10:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Derek Cheung" <derek.cheung@sympatico.ca>
Cc: "Greg KH" <greg@kroah.com>, "Randy Dunlap" <rddunlap@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-Id: <20050418231051.4eb460be.khali@linux-fr.org>
In-Reply-To: <001d01c5408f$18238850$1501a8c0@Mainframe>
References: <20050411200318.GA25550@kroah.com>
	<001d01c5408f$18238850$1501a8c0@Mainframe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek,

My comments on your code:

> +    Changes:
> +    v0.1	26 March 2005
> +		Initial Release - developed on uClinux with 2.6.9 kernel
> +    v0.2	11 April 2005
> +		Coding style changes
> +

Changelogs are not welcome in kernel code.

> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <asm/coldfire.h>
> +#include <asm/m528xsim.h>
> +#include <asm/types.h>
> +#include "i2c-mcf5282.h"

I can't see that you need config.h, errno.h nor string.h.

> +	/* printk(KERN_DEBUG "%s I2DR is %.2x \n", __FUNCTION__, *rxData); */

Please don't include dead code.

> +	timeout = 500;

You use a timeout of 500 in various places. I wonder if you shouldn't
have a define for it - in case it needs to be altered later.

> +	while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))
> +		udelay(1);
> +	if (timeout <= 0)
> +		printk(KERN_WARNING "%s - I2C IIF never set \n", __FUNCTION__);

These constructs are error-prone. I personally prefer:
	while(--timeout && ...)
		...
	if (!timeout)
		...

> +			rc += mcf5282_write_data(data->word & 0x00FF);
> +			rc += mcf5282_write_data((data->word & 0x00FF) >> 8);

Looks like a bug to me.

> +static s32 mcf5282_i2c_access(struct i2c_adapter *adap, u16 addr,
> +			      unsigned short flags, char read_write,
> +			      u8 command, int size, union i2c_smbus_data *data)
> (...)
> +		printk(KERN_WARNING "Not support I2C_SMBUS_PROC_CALL yet \n");

Don't use printk when you can user dev_{dbg,warn,info,err}. Also, please
no space before newline.

> +static u32 mcf5282_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_QUICK |
> +	       I2C_FUNC_SMBUS_BYTE |
> +	       I2C_FUNC_SMBUS_PROC_CALL |
> +	       I2C_FUNC_SMBUS_BYTE_DATA |
> +	       I2C_FUNC_SMBUS_WORD_DATA |
> +	       I2C_FUNC_SMBUS_BLOCK_DATA;
> +};

Don't say you support I2C_FUNC_SMBUS_PROC_CALL and
I2C_FUNC_SMBUS_BLOCK_DATA when you in fact don't. Not supporting some
functions is no problem, just leave them out for now. You can always
submit patches later.

> --- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h	1969-12-31 19:00:00.000000000 -0500
> +++ linux_dev/drivers/i2c/busses/i2c-mcf5282.h	2005-04-12 20:45:00.000000000 -0400

I see no reason to have a separate .h file for this.

> --- linux-2.6.11.6/drivers/i2c/busses/Kconfig	2005-03-25 22:28:29.000000000 -0500
> +++ linux_dev/drivers/i2c/busses/Kconfig	2005-04-12 20:45:24.000000000 -0400
> @@ -39,6 +39,16 @@ config I2C_ALI15X3
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-ali15x3.
>  
> +config I2C_MCF5282

Please keep the entries in somewhat alphabetical order.

> --- linux-2.6.11.6/drivers/i2c/busses/Makefile	2005-03-25 22:28:39.000000000 -0500
> +++ linux_dev/drivers/i2c/busses/Makefile	2005-04-13 18:52:03.000000000 -0400
> @@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
>  obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> +obj-$(CONFIG_I2C_MCF5282)	+= i2c-mcf5282.o

Ditto.

> +#define MCF5282_I2C_I2CR_IEN    (0x80)	/* I2C enable */
> +#define MCF5282_I2C_I2CR_IIEN   (0x40)  /* interrupt enable */
> +#define MCF5282_I2C_I2CR_MSTA   (0x20)  /* master/slave mode */
> +#define MCF5282_I2C_I2CR_MTX    (0x10)  /* transmit/receive mode */
> +#define MCF5282_I2C_I2CR_TXAK   (0x08)  /* transmit acknowledge enable */
> +#define MCF5282_I2C_I2CR_RSTA   (0x04)  /* repeat start */
> +
> +#define MCF5282_I2C_I2SR_ICF    (0x80)  /* data transfer bit */
> +#define MCF5282_I2C_I2SR_IAAS   (0x40)  /* I2C addressed as a slave */
> +#define MCF5282_I2C_I2SR_IBB    (0x20)  /* I2C bus busy */
> +#define MCF5282_I2C_I2SR_IAL    (0x10)  /* aribitration lost */
> +#define MCF5282_I2C_I2SR_SRW    (0x04)  /* slave read/write */
> +#define MCF5282_I2C_I2SR_IIF    (0x02)  /* I2C interrupt */
> +#define MCF5282_I2C_I2SR_RXAK   (0x01)  /* received acknowledge */

Parentheses are not needed here.

Thanks,
-- 
Jean Delvare
