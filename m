Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWGFWqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWGFWqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWGFWqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:46:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWGFWqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:46:00 -0400
Date: Thu, 6 Jul 2006 15:49:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Message-Id: <20060706154930.1a8fbad5.akpm@osdl.org>
In-Reply-To: <20060706193157.GC14043@phoenix>
References: <20060706193157.GC14043@phoenix>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Tuttle <thinkinginbinary@gmail.com> wrote:
>
> (Sorry to repost... just going through the motions of ChangeLog and
> Signed-off-by headers.)
> 
> Here is a patch to the asus_acpi driver that links the Asus laptop LED's
> into the new LED subsystem.  It creates LED class devices named
> asus:mail, asus:wireless, and asus:touchpad, depending on if the laptop
> supports the mled, wled, and tled LED's.
> 
> Since it's so new, I added a config option to turn it on and off.  It's
> worked for me, though I have an Asus M2N, which only has the mail and
> wireless LED's.
> 
> ...
>
>  #include <linux/types.h>
>  #include <linux/proc_fs.h>
> +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> +#include <linux/leds.h>
> +#endif

The ifdef shouldn't be required.  If it is, ldes.h needs fixing.

> +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> +                
> +/* These functions are called by the LED subsystem to update the desired
> + * state of the LED's. */
> +static void led_set_mled(struct led_classdev *led_cdev,
> +                                enum led_brightness value);
> +static void led_set_wled(struct led_classdev *led_cdev,
> +                                enum led_brightness value);
> +static void led_set_tled(struct led_classdev *led_cdev,
> +                                enum led_brightness value);

declaration

> +/* LED class devices. */
> +static struct led_classdev led_cdev_mled =
> +        { .name = "asus:mail",     .brightness_set = led_set_mled };
> +static struct led_classdev led_cdev_wled =
> +        { .name = "asus:wireless", .brightness_set = led_set_wled };
> +static struct led_classdev led_cdev_tled =
> +        { .name = "asus:touchpad", .brightness_set = led_set_tled };

definition

> +/* These functions actually update the LED's, and are called from a
> + * workqueue.  By doing this as separate work rather than when the LED
> + * subsystem asks, I avoid messing with the Asus ACPI stuff during a
> + * potentially bad time, such as a timer interrupt. */
> +static void led_update_mled(void *private);
> +static void led_update_wled(void *private);
> +static void led_update_tled(void *private);

declaration

> +/* Desired values of LED's. */
> +static int led_mled_value = 0; 
> +static int led_wled_value = 0;
> +static int led_tled_value = 0; 

definition


This mingles declarations with definitions.  It's more conventional to keep
them together.

Please don' t initialise static storage to zero (the "= 0").  The C runtime
environment does that already, and the above construct will place the
values into .data and hence into .vmlinux.

> +/* LED workqueue. */
> +static struct workqueue_struct *led_workqueue;
> +
> +/* LED update work structs. */
> +DECLARE_WORK(led_mled_work, led_update_mled, NULL);
> +DECLARE_WORK(led_wled_work, led_update_wled, NULL);
> +DECLARE_WORK(led_tled_work, led_update_tled, NULL);

These all should be declared static.

> +/* LED work functions. */
> +static void led_update_mled(void *private) {

The opening brace goes in column 1.

> +        char *ledname = hotk->methods->mt_mled;
> +        int led_out = led_mled_value ? 1 : 0;
> +        hotk->status = (led_out) ? (hotk->status | MLED_ON) : (hotk->status & ~MLED_ON);
> +        led_out = 1 - led_out;
> +        if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
> +                printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
> +                       ledname);
> +}
> +
> +static void led_update_wled(void *private) {
> +        char *ledname = hotk->methods->mt_wled;
> +        int led_out = led_wled_value ? 1 : 0;
> +        hotk->status = (led_out) ? (hotk->status | WLED_ON) : (hotk->status & ~WLED_ON);
> +        if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
> +                printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
> +                       ledname);
> +}

It's usual to put a blank line at the end of the declaration of the
automatic valriables.

> +
> +/* Registers LED class devices and sets up workqueue. */
> +{
> +        destroy_workqueue(led_workqueue);
> +
> +        if (hotk->methods->mt_tled) {
> +                led_classdev_unregister(&led_cdev_tled);
> +        }
> +
> +        if (hotk->methods->mt_wled) {
> +                led_classdev_unregister(&led_cdev_wled);
> +        }
> +        
> +        if (hotk->methods->mt_mled) {
> +                led_classdev_unregister(&led_cdev_mled);
> +        }
> +}
> +
> +#endif

Add:

#else
static inline int led_initialize(struct device *parent)
{
}

static inline void led_terminate(void)
{
}
#endif

>  static int asus_hotk_add_fs(struct acpi_device *device)
>  {
>  	struct proc_dir_entry *proc;
> @@ -1299,6 +1443,10 @@
>  	/* LED display is off by default */
>  	hotk->ledd_status = 0xFFF;
>  
> +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> +        result = led_initialize(acpi_get_physical_device(device->handle));
> +#endif
> +
>        end:
>  	if (result) {
>  		kfree(hotk);
> @@ -1314,6 +1462,10 @@
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
>  
> +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> +        led_terminate();
> +#endif          
> +

And remove these ifdefs.


That way we avoid sprinkling ifdefs in the middle of the C code and we get
syntax- and type-checking even if the feature is configged off.

