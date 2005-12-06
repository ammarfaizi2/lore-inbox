Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVLFVUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVLFVUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVLFVUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:20:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:49862 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030245AbVLFVUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:20:45 -0500
Date: Tue, 6 Dec 2005 13:20:18 -0800
From: Greg KH <greg@kroah.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC PATCH 1/8] LED: Add LED Class
Message-ID: <20051206212018.GB5937@kroah.com>
References: <1133788166.8101.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133788166.8101.125.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 01:09:26PM +0000, Richard Purdie wrote:
> +static void leds_class_release(struct class_device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static struct class leds_class = {
> +	.name		= "leds",
> +	.release	= leds_class_release,
> +};

Instead of this, just use class_create().  Then you don't need to
specify a release function at all.

> +/**
> + * leds_device_register - register a new object of led_device class.
> + * @dev: The device to register.
> + * @led_dev: the led_device structure for this device.
> + */
> +int leds_device_register(struct device *dev, struct led_device *led_dev)
> +{
> +	int rc;
> +
> +	led_dev->class_dev = kzalloc (sizeof (struct class_device), GFP_KERNEL);
> +	if (unlikely (!led_dev->class_dev))
> +		return -ENOMEM;
> +
> +	rwlock_init(&led_dev->lock);
> +
> +	led_dev->class_dev->class = &leds_class;
> +	led_dev->class_dev->dev = dev;
> +	led_dev->class_dev->class_data = led_dev;
> +
> +	/* assign this led its name */
> +	strncpy(led_dev->class_dev->class_id, led_dev->name, sizeof(led_dev->class_dev->class_id));
> +
> +	rc = class_device_register (led_dev->class_dev);

Use class_device_create() instead, it's simpler, and will work better
than creating your own class device in the future.

> +	if (unlikely (rc)) {
> +		kfree (led_dev->class_dev);
> +		return rc;
> +	}
> +
> +	/* register the attributes */
> +	class_device_create_file(led_dev->class_dev, &class_device_attr_brightness);
> +
> +	/* add to the list of leds */
> +	write_lock(&leds_list_lock);
> +	list_add_tail(&led_dev->node, &leds_list);
> +	write_unlock(&leds_list_lock);
> +
> +	printk(KERN_INFO "Registered led device: %s\n", led_dev->class_dev->class_id);
> +
> +	return 0;
> +}
> +
> +/**
> + * leds_device_unregister - unregisters a object of led_properties class.
> + * @led_dev: the led device to unreigister
> + *
> + * Unregisters a previously registered via leds_device_register object.
> + */
> +void leds_device_unregister(struct led_device *led_dev)
> +{
> +	class_device_remove_file (led_dev->class_dev, &class_device_attr_brightness);
> +
> +	class_device_unregister(led_dev->class_dev);
> +
> +	write_lock(&leds_list_lock);
> +	list_del(&led_dev->node);
> +	write_unlock(&leds_list_lock);
> +}
> +
> +EXPORT_SYMBOL(leds_device_suspend);
> +EXPORT_SYMBOL(leds_device_resume);
> +EXPORT_SYMBOL(leds_device_register);
> +EXPORT_SYMBOL(leds_device_unregister);

EXPORT_SYMBOL_GPL() perhaps?


> +
> +static int __init leds_init(void)
> +{
> +	return class_register(&leds_class);
> +}
> +
> +static void __exit leds_exit(void)
> +{
> +	class_unregister(&leds_class);

class_destroy() instead, if you use class_create().

Other than these minor things, looks good to me.

thanks,

greg k-h
