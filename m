Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWBCW4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWBCW4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWBCW4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:56:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:47496 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751502AbWBCW4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:56:03 -0500
Date: Fri, 3 Feb 2006 14:40:27 -0800
From: Greg KH <greg@kroah.com>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Controller Area Network (CAN) infrastructure
Message-ID: <20060203224027.GA22510@kroah.com>
References: <43D61374.8010208@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D61374.8010208@arcom.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 11:45:56AM +0000, David Vrabel wrote:
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6-working/drivers/can/can.c	2006-01-24 11:17:36.000000000 +0000
> @@ -0,0 +1,148 @@
> +/*
> + * Controller Area Network (CAN) infrastructure.
> + *
> + * Copyright (C) 2006 Arcom Control Systems Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/netdevice.h>
> +#include <linux/can/can.h>
> +
> +
> +ssize_t can_bit_rate_show(struct class_device *cdev, char *buf)
> +{
> +	struct can_device *can = to_can_device(cdev);
> +	return sprintf(buf, "%d\n", can->get_bit_rate(can));
> +}
> +
> +ssize_t can_bit_rate_store(struct class_device *cdev, const char *buf, size_t count)
> +{
> +	struct can_device *can = to_can_device(cdev);
> +	int bit_rate;
> +
> +	if (netif_running(&can->ndev))
> +		return -EBUSY;
> +
> +	bit_rate = simple_strtoul(buf, NULL, 0);
> +	can->set_bit_rate(can, bit_rate);
> +
> +	return count;
> +}
> +
> +CLASS_DEVICE_ATTR(bit_rate, 0644, can_bit_rate_show, can_bit_rate_store);
> +
> +
> +static struct net_device_stats *can_get_stats(struct net_device *netdev)
> +{
> +	struct can_device *can = netdev->priv;
> +
> +	return &can->stats;
> +}
> +
> +static void can_device_release(struct class_device *cdev)
> +{
> +	struct can_device *can = to_can_device(cdev);
> +
> +	class_device_remove_file(&can->cdev, &class_device_attr_bit_rate);
> +
> +	unregister_netdev(&can->ndev);
> +
> +	kfree(can);
> +}
> +
> +static struct class can_device_class = {
> +	.name     = "can",
> +	.owner   = THIS_MODULE,
> +	.release = can_device_release,
> +};

Can you use class_create() instead of making a static structure?  It
will make it easier for future driver core work.

thanks,

greg k-h
