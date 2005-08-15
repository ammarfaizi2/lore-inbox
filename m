Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVHOWNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVHOWNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVHOWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:13:32 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:48135 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S965007AbVHOWNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:13:31 -0400
Date: Tue, 16 Aug 2005 00:14:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/5] add i2c_probe_device and i2c_remove_device
Message-Id: <20050816001413.50b9c6be.khali@linux-fr.org>
In-Reply-To: <20050815175438.GE24959@litech.org>
References: <20050815175106.GA24959@litech.org>
	<20050815175438.GE24959@litech.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> These functions can be used for special-purpose adapters, such as
> those on TV tuner cards, where we generally know in advance what
> devices are attached.  This is important in cases where the adapter
> does not support probing or when probing is potentially dangerous to
> the connected devices.

Do you know of any adapter actually not supporting the SMBus Quick
command (which we use for probing)?

> --- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/i2c-core.c
> +++ linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
> @@ -671,6 +671,75 @@ int i2c_control(struct i2c_client *clien
>  }
>  
>  /* ----------------------------------------------------
> + * direct add/remove functions to avoid probing
> + * ----------------------------------------------------
> + */
> +
> +int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
> +		     int addr, int kind)
> +{
> +	struct list_head   *item;
> +	struct i2c_driver  *driver = NULL;
> +
> +	/* There's no way to probe addresses on this adapter... */
> +	if (kind < 0 && !i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
> +		return -EINVAL;

Coding style please: one space after the comma. 

> +
> +	down(&core_lists);
> +	list_for_each(item,&drivers) {

Ditto.

> +		driver = list_entry(item, struct i2c_driver, list);
> +		if (driver->id == driver_id)
> +			break;
> +	}
> +	up(&core_lists);
> +	if (!item)
> +		return -ENOENT;
> +
> +	/* Already in use? */
> +	if (i2c_check_addr(adapter, addr))
> +		return -EBUSY;
> +
> +	/* Make sure there is something at this address, unless forced */
> +	if (kind < 0) {
> +		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> +				   I2C_SMBUS_QUICK, NULL) < 0)
> +			return -ENODEV;
> +
> +		/* prevent 24RF08 corruption */
> +		if ((addr & ~0x0f) == 0x50)
> +			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> +				       I2C_SMBUS_QUICK, NULL);
> +	}
> +
> +	return driver->detect_client(adapter, addr, kind);
> +}

You are duplicating a part of i2c_probe_address() here. Why don't you
simply call it?

This part of the code is very sensible because of the 24RF08 corruption
issue. I have plans to change the probing method, e.g. by using SMBus
Receive Byte instead of SMBus Quick for the 0x50-0x5F address range.
Thus I would really appreciate if this code would not be duplicated.

Thanks,
-- 
Jean Delvare
