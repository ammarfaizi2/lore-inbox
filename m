Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWGaSxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWGaSxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWGaSxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:53:34 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:36101 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030321AbWGaSxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:53:34 -0400
Date: Mon, 31 Jul 2006 20:53:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
Subject: Re: [i2c] [patch 2.6.18-rc3] build fixes:  tps65010
Message-Id: <20060731205333.3d986eb6.khali@linux-fr.org>
In-Reply-To: <200607310725.34094.david-b@pacbell.net>
References: <200607310725.34094.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> The tps65010.c driver in the main tree never got updated with
> build fixes since the last batch of I2C driver changes; and the
> genirq trigger flags were updated wierdly too.

Typo, I guess you mean "weirdly".

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Index: o26/drivers/i2c/chips/tps65010.c
> ===================================================================
> --- o26.orig/drivers/i2c/chips/tps65010.c	2006-07-30 22:09:03.000000000 -0700
> +++ o26/drivers/i2c/chips/tps65010.c	2006-07-31 04:56:47.000000000 -0700
> @@ -43,13 +43,12 @@
>  /*-------------------------------------------------------------------------*/
>  
>  #define	DRIVER_VERSION	"2 May 2005"
> -#define	DRIVER_NAME	(tps65010_driver.name)
> +#define	DRIVER_NAME	(tps65010_driver.driver.name)
>  
>  MODULE_DESCRIPTION("TPS6501x Power Management Driver");
>  MODULE_LICENSE("GPL");
>  
>  static unsigned short normal_i2c[] = { 0x48, /* 0x49, */ I2C_CLIENT_END };
> -static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
>  
>  I2C_CLIENT_INSMOD;
>  

Yup, obviously correct.

> @@ -520,15 +519,16 @@ tps65010_probe(struct i2c_adapter *bus, 
>  		goto fail1;
>  	}
>  
> +	/* IRQ is active low, but some gpio lines can't support that */
> +	irqflags = IRQF_SAMPLE_RANDOM;
>  #ifdef	CONFIG_ARM
> -	irqflags = IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_LOW;
>  	if (machine_is_omap_h2()) {
>  		tps->model = TPS65010;
>  		omap_cfg_reg(W4_GPIO58);
>  		tps->irq = OMAP_GPIO_IRQ(58);
>  		omap_request_gpio(58);
>  		omap_set_gpio_direction(58, 1);
> -		irqflags |= IRQF_TRIGGER_FALLING;
> +		irqflags |= IRQF_TRIGGER_LOW;
>  	}
>  	if (machine_is_omap_osk()) {
>  		tps->model = TPS65010;
> @@ -543,8 +543,6 @@ tps65010_probe(struct i2c_adapter *bus, 
>  
>  		// FIXME set up this board's IRQ ...
>  	}
> -#else
> -	irqflags = IRQF_SAMPLE_RANDOM;
>  #endif
>  
>  	if (tps->irq > 0) {

This is more surprising. How did the interrupt type suddenly change
from "falling" to "low"? (Note that I am not an interrupt expert.)

Anyway, thanks for fixing this. This is one of the i2c drivers that I
can't compile on the architectures I work on, so I can't spot the
breakage.

I guess you want this fix in 2.6.18?

-- 
Jean Delvare
