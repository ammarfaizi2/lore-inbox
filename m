Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVLJME0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVLJME0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 07:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVLJME0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 07:04:26 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:33287 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S965053AbVLJMEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 07:04:25 -0500
Date: Sat, 10 Dec 2005 13:06:26 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH 3/3] i386: CS5535 chip support - SMBus
Message-Id: <20051210130626.603c8077.khali@linux-fr.org>
In-Reply-To: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
References: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
Reply-To: LM Sensors <lm-sensors@lm-sensors.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> Index: linux-2.6.14/drivers/i2c/busses/Makefile
> ===================================================================

If you are using quilt, please set QUILT_NO_DIFF_INDEX=1.

> --- linux-2.6.14.orig/drivers/i2c/busses/Kconfig
> +++ linux-2.6.14/drivers/i2c/busses/Kconfig
> @@ -84,6 +84,17 @@ config I2C_AU1550
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-au1550.
>  
> +config I2C_CS5535
> +	tristate "AMD CS5535 SMBus (Geode GX)"
> +	depends on I2C && CS5535 && EXPERIMENTAL
> +	help
> +	  Enable the use of the SMB controller on the CS5535 companion device.

Please use "SMBus" rather than "SMB" which is something different.

> --- /dev/null
> +++ linux-2.6.14/drivers/i2c/busses/i2c-cs5535.c
> @@ -0,0 +1,553 @@
> +/*  linux/drivers/i2c/i2c-cs5535.c

Redundant.

> + *
> + *  Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
> + *
> + *  AMD CS5535 SMB support - mostly identical to

SMBus.

> + *  National Semiconductor SCx200 ACCESS.bus support
> + *  except for the detection routine.
> + *
> + *  Based on scx200_acb.c which is:
> + *      Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>

Why not extend that driver then, rather than having a separate one?

> +#include <linux/config.h>

This file should no more be included explicitely.

> +#include <linux/pci.h>

Why would you need this?

> +#include <linux/interrupt.h>

And this?

> +MODULE_DESCRIPTION("AMD CS5535 SMB Driver");

SMBus :)

> +/* Needed to see if the cs5535 is present */
> +extern u32 cs5535_gpio_base;

Move this to a header file.

> +#undef DEBUG
> +
> +#ifdef DEBUG
> +#define DBG(x...) printk(KERN_DEBUG NAME ": " x)
> +#else
> +#define DBG(x...)
> +#endif

No. We have a global configuration flag which enables debugging on i2c
bus drivers (CONFIG_I2C_DEBUG_BUS). When enabled, DEBUG will be set for
you. Then, use dev_dbg (preferably) and pr_debug.

> +static void cs5535_smb_timeout(struct cs5535_smb_iface *iface)
> +{
> +	dev_err(&iface->adapter.dev, "timeout in state %s\n",
> +		cs5535_smb_state_name[iface->state]);
> +
> +	iface->state = state_idle;
> +	iface->result = -EIO;
> +	iface->needs_reset = 1;
> +}

I see relatively little interest in having a separate function for
this, when this really only is the error path of function
cs5535_smb_poll below.

> +static void cs5535_smb_poll(struct cs5535_smb_iface *iface)
> +{
> +	u8 status = 0;

Useless initialization.

> +	unsigned long timeout;
> +
> +	timeout = jiffies + POLL_TIMEOUT;
> +	while (time_before(jiffies, timeout)) {
> +

No blank line at beginning of blocks please.

> +		/* The i2c bus takes 9us per bit, 10 bits per transaction.
> +		 * This amounts to ~100us per char. Since that time is quite
> +		 * small and we can wait longer, we'll just yield.
> +		 */

Where do these figures come from? At 100kHz that would be 10us per bit,
and it's more like 9 bits per byte transfered. The bit count of a
transaction obviously depends on the transaction type (length), and can
be generally expressed as 2+9*N where N is the number of transferred
bytes (counting the address).

It's always approximate anyway as start and stop conditions are not
real bits, additional delays can occur between bytes, and slaves are
free to slow down the clock if they want to.

> +		yield();
> +
> +		status = smb_inb(SMBST);
> +		if ((status & (SMBST_SDAST | SMBST_BER | SMBST_NEGACK)) != 0) {
> +			cs5535_smb_machine(iface, status);
> +			return;
> +		}
> +	}
> +
> +	cs5535_smb_timeout(iface);
> +}

> +static s32 cs5535_smb_smbus_xfer(struct i2c_adapter *adapter,
> +				 u16 address, unsigned short flags,
> +				 char rw, u8 command, int size,
> +				 union i2c_smbus_data *data)
> +{
> (...)
> +	case I2C_SMBUS_BYTE:
> +		if (rw == I2C_SMBUS_READ) {
> +			len = 1;
> +			buffer = &data->byte;
> +		} else {
> +			len = 1;
> +			buffer = &command;
> +		}
> +		break;

You can refactor "len = 1".

> +	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
> +	    size, address, command, len, rw == I2C_SMBUS_READ);

rw == I2C_SMBUS_READ can be simplified to just rw.

> +	if (!len && rw == I2C_SMBUS_READ) {
> +		dev_warn(&adapter->dev, "zero length read\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len && !buffer) {
> +		dev_warn(&adapter->dev, "nonzero length but no buffer\n");
> +		return -EFAULT;
> +	}

These would be internal driver errors, right? If so, dev_warn is not
appropriate. I'd make these dependent upon DEBUG, and use dev_dbg.

> +	iface->address_byte = address << 1;
> +	if (rw == I2C_SMBUS_READ)
> +		iface->address_byte |= 1;

Can be simplified to:
	iface->address_byte = (address << 1) | rw;

> +	iface->command = command;
> +	iface->ptr = buffer;
> +	iface->len = len;
> +	iface->result = -EINVAL;
> +	iface->needs_reset = 0;

Wouldn't it be more efficient to have cs5535_smb_reset reset that flag
rather that doing it on each and every transaction?

> +static int __init cs5535_smb_create(int base, int index)
> +{
> +	struct cs5535_smb_iface *iface;
> +	struct i2c_adapter *adapter;
> +	int rc = 0;

Useless initialization.

> +	if (request_region(iface->base, SMB_IO_SIZE, adapter->name) == 0) {

if (!request_region(...)) {

> +	rc = cs5535_smb_probe(iface);
> +	if (rc) {
> +		dev_warn(&adapter->dev, "probe failed\n");
> +		goto errout;
> +	}

You can't use dev_warn() before the adapter is added. adapter->dev is
not defined at this point!

> +
> +	cs5535_smb_reset(iface);
> +
> +	if (i2c_add_adapter(adapter) < 0) {
> +		dev_err(&adapter->dev, "failed to register\n");
> +		rc = -ENODEV;
> +		goto errout;
> +	}

Ditto.

> +errout:
> +	if (iface) {
> +		if (iface->base)
> +			release_region(iface->base, SMB_IO_SIZE);
> +		kfree(iface);
> +	}
> +	return rc;
> +}

Please define more labels so that you do not have to test anything in
the cleanup path. While doing so, you'll probably notice that your
current cleanup code is not correct (if request_region fails you still
call release_region).

> +static int __init cs5535_smb_init(void)
> +{
> (...)
> +	return cs5535_smb_create(smb_base, 0);
> +}

Why did you partly setup the driver architecture so that you could
support several devices, and finally don't do it? It wouldn't work
properly anyway, as you have a single slot to store the interface
pointer. So maybe it would make more sense to simplify the code and
explicitely only support one device.

> +static void __exit cs5535_smb_cleanup(void)
> +{
> +	if (cs5535_iface != NULL) {
> +		release_region(cs5535_iface->base, SMB_IO_SIZE);
> +		i2c_del_adapter(&cs5535_iface->adapter);
> +		kfree(cs5535_iface);
> +	}
> +}

How could cs5535_iface be NULL at this point? Looks like a useless test
to me. You are also not cleaning up in the proper order, bus
deregistration should happen before region release, else you have
(theoretical) room for access to a no more reserved region.

> +
> +module_init(cs5535_smb_init);
> +module_exit(cs5535_smb_cleanup);
> +

No blank line at end of file please.

> --- linux-2.6.14.orig/include/linux/i2c-id.h
> +++ linux-2.6.14/include/linux/i2c-id.h
> @@ -256,6 +256,7 @@
>  #define I2C_HW_SMBUS_OV518	0x04000f /* OV518(+) USB 1.1 webcam ICs */
>  #define I2C_HW_SMBUS_OV519	0x040010 /* OV519 USB 1.1 webcam IC */
>  #define I2C_HW_SMBUS_OVFX2	0x040011 /* Cypress/OmniVision FX2 webcam */
> +#define I2C_HW_SMBUS_CS5535	0x040012

Some comment would be welcome.

Thanks,
-- 
Jean Delvare
