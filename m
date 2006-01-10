Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWAJGlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWAJGlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWAJGlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:41:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:20919 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750823AbWAJGlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:41:21 -0500
Subject: Re: [PATCH 12/24] pcspkr: register with driver core as a platfrom
	device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       mikey@neuling.org
In-Reply-To: <20060107172100.901011000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
	 <20060107172100.901011000.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 17:41:57 +1100
Message-Id: <1136875317.10235.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 12:16 -0500, Dmitry Torokhov wrote:
> plain text document attachment (pcspkr-platform-device.patch)
> Input: pcspkr - register with driver core as a platfrom device

Hi Dimitri !

That looks great, something we've been wanting to tackle for a while...
except for one thing :)

The actual creation of the device shouldn't be done there... only the
driver should be there. The device instanciation should be moved to the
i386 arch code (and/or any other architecture that might have this
thing).

On ppc64 for example, we have machines that will blow up when that
driver tries to poke random IOs, but we also have machines that do have
that legacy piece of hardware where expected. We can know it from the
firmware, thus we can decide wether to create the platform device or not
from the arch code.

What do you prefer ? Keep that the way you did for now and add some
#ifdef CONFIG_PPC64 with the ppc64 probe code in that driver or do you
want to call all the way to moving the actual device creation to the
platform code (as I think should be done) ?

Cheers,
Ben.

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/misc/pcspkr.c |   86 ++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 80 insertions(+), 6 deletions(-)
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
> @@ -23,8 +24,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@u
>  MODULE_DESCRIPTION("PC Speaker beeper driver");
>  MODULE_LICENSE("GPL");
>  
> -static struct input_dev *pcspkr_dev;
> -
> +static struct platform_device *pcspkr_platform_device;
>  static DEFINE_SPINLOCK(i8253_beep_lock);
>  
>  static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
> @@ -64,8 +64,11 @@ static int pcspkr_event(struct input_dev
>  	return 0;
>  }
>  
> -static int __init pcspkr_init(void)
> +static int __devinit pcspkr_probe(struct platform_device *dev)
>  {
> +	struct input_dev *pcspkr_dev;
> +	int err;
> +
>  	pcspkr_dev = input_allocate_device();
>  	if (!pcspkr_dev)
>  		return -ENOMEM;
> @@ -76,21 +79,92 @@ static int __init pcspkr_init(void)
>  	pcspkr_dev->id.vendor = 0x001f;
>  	pcspkr_dev->id.product = 0x0001;
>  	pcspkr_dev->id.version = 0x0100;
> +	pcspkr_dev->cdev.dev = &dev->dev;
>  
>  	pcspkr_dev->evbit[0] = BIT(EV_SND);
>  	pcspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
>  	pcspkr_dev->event = pcspkr_event;
>  
> -	input_register_device(pcspkr_dev);
> +	err = input_register_device(pcspkr_dev);
> +	if (err) {
> +		input_free_device(pcspkr_dev);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(dev, pcspkr_dev);
>  
>  	return 0;
>  }
>  
> -static void __exit pcspkr_exit(void)
> +static int __devexit pcspkr_remove(struct platform_device *dev)
>  {
> -        input_unregister_device(pcspkr_dev);
> +	struct input_dev *pcspkr_dev = platform_get_drvdata(dev);
> +
> +	input_unregister_device(pcspkr_dev);
> +	platform_set_drvdata(dev, NULL);
>  	/* turn off the speaker */
>  	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
> +
> +	return 0;
> +}
> +
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
> +static struct platform_driver pcspkr_platform_driver = {
> +	.driver		= {
> +		.name	= "pcspkr",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= pcspkr_probe,
> +	.remove		= __devexit_p(pcspkr_remove),
> +	.suspend	= pcspkr_suspend,
> +	.shutdown	= pcspkr_shutdown,
> +};
> +
> +
> +static int __init pcspkr_init(void)
> +{
> +	int err;
> +
> +	err = platform_driver_register(&pcspkr_platform_driver);
> +	if (err)
> +		return err;
> +
> +	pcspkr_platform_device = platform_device_alloc("pcspkr", -1);
> +	if (!pcspkr_platform_device) {
> +		err = -ENOMEM;
> +		goto err_unregister_driver;
> +	}
> +
> +	err = platform_device_add(pcspkr_platform_device);
> +	if (err)
> +		goto err_free_device;
> +
> +	return 0;
> +
> + err_free_device:
> +	platform_device_put(pcspkr_platform_device);
> + err_unregister_driver:
> +	platform_driver_unregister(&pcspkr_platform_driver);
> +
> +	return err;
> +}
> +
> +static void __exit pcspkr_exit(void)
> +{
> +	platform_device_unregister(pcspkr_platform_device);
> +	platform_driver_unregister(&pcspkr_platform_driver);
>  }
>  
>  module_init(pcspkr_init);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

