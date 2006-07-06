Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWGFWkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWGFWkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWGFWkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:40:04 -0400
Received: from tim.rpsys.net ([194.106.48.114]:24533 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750981AbWGFWkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:40:01 -0400
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
From: Richard Purdie <rpurdie@rpsys.net>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060706193157.GC14043@phoenix>
References: <20060706193157.GC14043@phoenix>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 23:39:58 +0100
Message-Id: <1152225599.5544.202.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 15:31 -0400, Thomas Tuttle wrote:
> +#include <linux/config.h>

Not needed.

>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/proc_fs.h>
> +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> +#include <linux/leds.h>
> +#endif

Doesn't need the ifdefs, the header should be harmless

> +/* LED class devices. */
> +static struct led_classdev led_cdev_mled =
> +        { .name = "asus:mail",     .brightness_set = led_set_mled };
> +static struct led_classdev led_cdev_wled =
> +        { .name = "asus:wireless", .brightness_set = led_set_wled };
> +static struct led_classdev led_cdev_tled =
> +        { .name = "asus:touchpad", .brightness_set = led_set_tled };

Not the formatting I'm used to but I'm not sure if it breaks the
CodingStyle... :)

> +/* These functions actually update the LED's, and are called from a
> + * workqueue.  By doing this as separate work rather than when the
> LED
> + * subsystem asks, I avoid messing with the Asus ACPI stuff during a
> + * potentially bad time, such as a timer interrupt. */

More simply, "The led update functions can be called in interrupt
context so we use a work queue to pass the updates to acpi" or similar.

Words like "I" become meaningless in the source.
            
> +/* LED work functions. */
> +static void led_update_mled(void *private) {
> +        char *ledname = hotk->methods->mt_mled;
> +        int led_out = led_mled_value ? 1 : 0;
> +        hotk->status = (led_out) ? (hotk->status | MLED_ON) :
> (hotk->status & ~MLED_ON);
> +        led_out = 1 - led_out;
> +        if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
> +                printk(KERN_WARNING "Asus ACPI: LED (%s) write failed
> \n",
> +                       ledname);

The lack of locking on hotk->status makes me nervous but since it
appears to only contain LED data, its probably not too important and the
write_led function already there is equally bad...

> +/* Registers LED class devices and sets up workqueue. */
> +static int led_initialize(struct device *parent)
> +{
> +        int result;
> +
> +        if (hotk->methods->mt_mled) {
> +                result = led_classdev_register(parent,
> &led_cdev_mled);
> +                if (result)
> +                        return result;
> +        }
> +
> +        if (hotk->methods->mt_wled) {
> +                result = led_classdev_register(parent,
> &led_cdev_wled);
> +                if (result)
> +                        return result;
> +        }
> +
> +        if (hotk->methods->mt_tled) {
> +                result = led_classdev_register(parent,
> &led_cdev_tled);
> +                if (result)
> +                        return result;
> +        }
> +
> +        led_workqueue =
> create_singlethread_workqueue("led_workqueue");
> +
> +        return 0;
> +}
> +
> +/* Destroys the workqueue and unregisters the LED class devices. */
> +static void led_terminate(void)
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

What happens if the first led_classdev_register succeeds and the
subsequent calls fail? You need to think about all the different error
cases here...

Also, having looked at that ACPI driver, what happens to the existing
LED access functions via proc and how do they coexist with the LED
subsystem? Ultimately I guess they'd get removed but in the meantime
they present a problem. The LED subsystem does not have a brightness_get
function and assumes it has complete control of the LED. It therefore
caches the brightness value internally to itself. If we have a lot of
cases where this isn't going to work (like here), we could look at
adding an optional brightness_get function but I'd prefer to keep
complexity out of the class if possible. How common is that problem
going to be I wonder...

Richard



