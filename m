Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKSHqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKSHqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 02:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKSHqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 02:46:18 -0500
Received: from styx.suse.cz ([82.119.242.94]:25789 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750949AbVKSHqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 02:46:17 -0500
Date: Sat, 19 Nov 2005 08:46:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: [RFC] Convert pcspkr into platform device
Message-ID: <20051119074610.GB12551@midnight.suse.cz>
References: <200511182347.48652.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511182347.48652.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:47:48PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> The patch below converts pcspkr driver into a platform device. This allows
> input_dev it created to have a parent but that's pretty much it. I wonder
> it is makes any sense to do it...

It definitely does. Thanks!

> 
> -- 
> Dmitry
> 
> Input: pcspkr - convert into platform device
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/misc/pcspkr.c |   60 +++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 56 insertions(+), 4 deletions(-)
> 
> Index: work/drivers/input/misc/pcspkr.c
> ===================================================================
> --- work.orig/drivers/input/misc/pcspkr.c
> +++ work/drivers/input/misc/pcspkr.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
> +#include <linux/platform_device.h>
>  #include <asm/8253pit.h>
>  #include <asm/io.h>
>  
> @@ -24,7 +25,7 @@ MODULE_DESCRIPTION("PC Speaker beeper dr
>  MODULE_LICENSE("GPL");
>  
>  static struct input_dev *pcspkr_dev;
> -
> +static struct platform_device *pcspkr_platform_device;
>  static DEFINE_SPINLOCK(i8253_beep_lock);
>  
>  static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
> @@ -64,11 +65,48 @@ static int pcspkr_event(struct input_dev
>  	return 0;
>  }
>  
> +static int pcspkr_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
> +
> +	return 0;
> +}
> +
> +static void pcspkr_shutdown(struct platform_device *dev)
> +{
> +	/* turn off the speaker */
> +	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
> +}
> +
> +
> +static struct platform_driver pcspkr_platform_driver = {
> +	.driver		= {
> +		.name	= "pcspkr",
> +	},
> +	.suspend	= pcspkr_suspend,
> +	.shutdown	= pcspkr_shutdown,
> +};
> +
> +
>  static int __init pcspkr_init(void)
>  {
> +	int err;
> +
> +	err = platform_driver_register(&pcspkr_platform_driver);
> +	if (err)
> +		return err;
> +
> +	pcspkr_platform_device = platform_device_register_simple("pcspkr", -1, NULL, 0);
> +	if (IS_ERR(pcspkr_platform_device)) {
> +		err = PTR_ERR(pcspkr_platform_device);
> +		goto err_unregister_driver;
> +	}
> +
>  	pcspkr_dev = input_allocate_device();
> -	if (!pcspkr_dev)
> -		return -ENOMEM;
> +	if (!pcspkr_dev) {
> +		err = -ENOMEM;
> +		goto err_unregister_device;
> +	}
>  
>  	pcspkr_dev->name = "PC Speaker";
>  	pcspkr_dev->phys = "isa0061/input0";
> @@ -76,14 +114,26 @@ static int __init pcspkr_init(void)
>  	pcspkr_dev->id.vendor = 0x001f;
>  	pcspkr_dev->id.product = 0x0001;
>  	pcspkr_dev->id.version = 0x0100;
> +	pcspkr_dev->cdev.dev = &pcspkr_platform_device->dev;
>  
>  	pcspkr_dev->evbit[0] = BIT(EV_SND);
>  	pcspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
>  	pcspkr_dev->event = pcspkr_event;
>  
> -	input_register_device(pcspkr_dev);
> +	err = input_register_device(pcspkr_dev);
> +	if (err)
> +		goto err_free_input_device;
>  
>  	return 0;
> +
> + err_free_input_device:
> +	input_free_device(pcspkr_dev);
> + err_unregister_device:
> +	platform_device_unregister(pcspkr_platform_device);
> + err_unregister_driver:
> +	platform_driver_unregister(&pcspkr_platform_driver);
> +
> +	return err;
>  }
>  
>  static void __exit pcspkr_exit(void)
> @@ -91,6 +141,8 @@ static void __exit pcspkr_exit(void)
>          input_unregister_device(pcspkr_dev);
>  	/* turn off the speaker */
>  	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
> +	platform_device_unregister(pcspkr_platform_device);
> +	platform_driver_unregister(&pcspkr_platform_driver);
>  }
>  
>  module_init(pcspkr_init);
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
