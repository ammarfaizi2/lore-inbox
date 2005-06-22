Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVFVHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVFVHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVFVHs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:48:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:51129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262802AbVFVG1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:27:21 -0400
Date: Tue, 21 Jun 2005 23:26:27 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, mochel@digitalimplant.org, gregkh@suse.de,
       cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
Message-ID: <20050622062627.GA29759@kroah.com>
References: <20050621162213.GA6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621162213.GA6053@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 06:22:13PM +0200, Martin Schwidefsky wrote:
> [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
> 
> From: Cornelia Huck <cohuck@de.ibm.com>
> 
> Add bus_find_device() and driver_find_device() which allow a callback for each
> device in the bus's resp. the driver's klist.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> diffstat:
>  drivers/base/bus.c     |   31 +++++++++++++++++++++++++++++++
>  drivers/base/driver.c  |   34 ++++++++++++++++++++++++++++++++++
>  include/linux/device.h |    7 +++++++
>  3 files changed, 72 insertions(+)
> 
> diff -urpN linux-2.6/drivers/base/bus.c linux-2.6-patched/drivers/base/bus.c
> --- linux-2.6/drivers/base/bus.c	2005-06-21 17:36:38.000000000 +0200
> +++ linux-2.6-patched/drivers/base/bus.c	2005-06-21 17:36:45.000000000 +0200
> @@ -177,6 +177,37 @@ int bus_for_each_dev(struct bus_type * b
>  	return error;
>  }
>  
> +/**
> + * bus_find_device - device iterator for locating a particular device.
> + * @bus: bus type
> + * @start: Device to begin with
> + * @data: Data to pass to match function
> + * @match: Callback function to check device
> + *
> + * This is similar to the bus_for_each_dev() function above, but it
> + * returns a pointer to a device that is 'found', as determined
> + * by the @match callback. The callback should return a bool - 0 if
> + * the device doesn't match and 1 if it does.
> + * The function will return if a device is found.
> + */
> +
> +struct device * bus_find_device(struct bus_type * bus, struct device * start,
> +				void * data, int (*match)(struct device *, void *))
> +{
> +	struct klist_iter i;
> +	struct device * dev;
> +
> +	if (!bus)
> +		return NULL;
> +
> +	klist_iter_init_node(&bus->klist_devices, &i,
> +			     (start ? &start->knode_bus : NULL));
> +	while ((dev = next_device(&i)))
> +		if (match(dev, data))
> +			break;
> +	klist_iter_exit(&i);
> +	return dev;
> +}

What's wrong with just using bus_for_each_dev() instead?  You have to
supply a "match" type function anyway, so the caller doesn't have an
easier time using this function instead.

You also don't increment the reference properly when you return the
pointer, so you better document that... :(

In short, I don't think this is needed at all, as it's an almost
identical copy of bus_for_each_dev().

> diff -urpN linux-2.6/drivers/base/driver.c linux-2.6-patched/drivers/base/driver.c
> --- linux-2.6/drivers/base/driver.c	2005-06-21 17:36:38.000000000 +0200
> +++ linux-2.6-patched/drivers/base/driver.c	2005-06-21 17:36:45.000000000 +0200
> @@ -56,6 +56,40 @@ EXPORT_SYMBOL_GPL(driver_for_each_device
>  
>  
>  /**
> + * driver_find_device - device iterator for locating a particular device.
> + * @driver: The device's driver
> + * @start: Device to begin with
> + * @data: Data to pass to match function
> + * @match: Callback function to check device
> + *
> + * This is similar to the driver_for_each_device() function above, but it
> + * returns a pointer to a device that is 'found', as determined
> + * by the @match callback. The callback should return a bool - 0 if
> + * the device doesn't match and 1 if it does.
> + * The function will return if a device is found.
> + */
> +
> +struct device * driver_find_device(struct device_driver *drv,
> +				   struct device * start, void * data,
> +				   int (*match)(struct device *, void *))
> +{
> +	struct klist_iter i;
> +	struct device * dev;
> +
> +	if (!drv)
> +		return NULL;
> +
> +	klist_iter_init_node(&drv->klist_devices, &i,
> +			     (start ? &start->knode_driver : NULL));
> +	while ((dev = next_device(&i)))
> +		if (match(dev, data))
> +			break;
> +	klist_iter_exit(&i);
> +	return dev;
> +}

Same comment as above, I don't think this function is necessary.

thanks,

greg k-h
