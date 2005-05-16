Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVEPRUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVEPRUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVEPRUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:20:17 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:20493 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261766AbVEPRTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:19:44 -0400
Date: Mon, 16 May 2005 19:19:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alexey Fisher <fishor@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: clean up and warnings patch for 2.6.12-rc4-mm1 i2c-chip
Message-Id: <20050516191942.0cd51155.khali@linux-fr.org>
In-Reply-To: <200505160014.36016.fishor@gmx.net>
References: <200505160014.36016.fishor@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

> Hi here is some clean ups for Kconfig in i2c/chips subdirectory and
> error handling fix up for chip max1619. Best  regards.

Thanks for the patch, see my comments inline.

> diff -uprN linux/drivers/i2c/chips/Kconfig linux-2.6-dev/drivers/i2c/chips/Kconfig
> --- linux/drivers/i2c/chips/Kconfig	2005-05-15 22:49:31.000000000 +0200
> +++ linux-2.6-dev/drivers/i2c/chips/Kconfig	2005-05-15 22:58:28.000000000 +0200
> @@ -29,6 +29,7 @@ config SENSORS_ADM1025
>  	help
>  	  If you say yes here you get support for Analog Devices ADM1025
>  	  and Philips NE1619 sensor chips.
> +	  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm1025.
>  
> @@ -38,6 +39,7 @@ config SENSORS_ADM1026
>  	select I2C_SENSOR
>  	help
>  	  If you say yes here you get support for Analog Devices ADM1026
> +	  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm1026.
>  
> @@ -48,6 +50,7 @@ config SENSORS_ADM1031
>  	help
>  	  If you say yes here you get support for Analog Devices ADM1031
>  	   and ADM1030 sensor chips.
> +	  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm1031.
>  
> @@ -198,8 +201,7 @@ config SENSORS_LM78
>  	select I2C_SENSOR
>  	help
>  	  If you say yes here you get support for National Semiconductor
>  	  LM78,
> -	  LM78-J and LM79.  This can also be built as a module which can be
> -	  inserted and removed while the kernel is running.
> +	  LM78-J and LM79.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm78.
> @@ -232,7 +234,7 @@ config SENSORS_LM85
>  	select I2C_SENSOR
>  	help
>  	  If you say yes here you get support for National Semiconductor
>  	  LM85
> -	  sensor chips and clones: ADT7463 and ADM1027.
> +	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm85.

Yes, these fixes to Kconfig are all correct.

> diff -uprN linux/drivers/i2c/chips/max1619.c linux-2.6-dev/drivers/i2c/chips/max1619.c
> --- linux/drivers/i2c/chips/max1619.c	2005-05-15 22:49:31.000000000 +0200
> +++ linux-2.6-dev/drivers/i2c/chips/max1619.c	2005-05-15 21:05:56.000000000 +0200
> @@ -195,6 +195,7 @@ static int max1619_detect(struct i2c_ada
>  	u8 reg_config=0, reg_convrate=0, reg_status=0;
>  	u8 man_id, chip_id;
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		err = -ENODEV;
>  		goto exit;
>  
>  	if (!(data = kmalloc(sizeof(struct max1619_data), GFP_KERNEL)))
>  	{
> @@ -234,6 +235,7 @@ static int max1619_detect(struct i2c_ada
>  			dev_dbg(&adapter->dev,
>  				"MAX1619 detection failed at 0x%02x.\n",
>  				address);
> +			return -ENODEV;
>  			goto exit_free;
>  		}
>  	}
> @@ -254,6 +256,7 @@ static int max1619_detect(struct i2c_ada
>  			dev_info(&adapter->dev,
>  			    "Unsupported chip (man_id=0x%02X, "
>  			    "chip_id=0x%02X).\n", man_id, chip_id);
> +			return -ENODEV;
>  			goto exit_free;
>  		}
>  	

No, these changes are not correct. Due to the fact i2c_detect() is
designed, i2c detection functions should never return -ENODEV. Doing so
would result in i2c_detect() to skip the probing of remaining addresses
for a given chip driver. We might change i2c_detect() to make it behave
differently at some point, but for now your previous code is correct and
should not be changed.

(Also note that the code of your changes itself is not correct at all,
as was pointed out elsewhere in this thread - but it doesn't really
matter now.)

> diff -uprN linux/drivers/pci/pci.ids linux-2.6-dev/drivers/pci/pci.ids
> --- linux/drivers/pci/pci.ids	2005-05-07 07:20:31.000000000 +0200
> +++ linux-2.6-dev/drivers/pci/pci.ids	2005-05-15 23:16:21.000000000 +0200
> @@ -5322,6 +5322,7 @@
>  	0459  LT WinModem
>  	045a  LT WinModem
>  	045c  LT WinModem
> +	045d  LT WinModem
>  	0461  V90 WildWire Modem
>  	0462  V90 WildWire Modem
>  	0480  Venus Modem (V90, 56KFlex)

This is a completely different change. Please submit unrelated changes
as different patches, because they will be applied by different persons
so it's way more convenient that way.

If you resubmit a patch with only the drivers/i2c/chips/Kconfig changes,
I'll get it applied. Don't forget a desription of the patch and the
Signed-Off-By line with your name and mail address at the top of the
post.

Thanks,
-- 
Jean Delvare
