Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVFWWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVFWWAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVFWV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:59:52 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:18948 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262662AbVFWV7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:59:13 -0400
Date: Thu, 23 Jun 2005 23:59:04 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Pervushin <dpervushin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] SPI core -- revisited
Message-Id: <20050623235904.494e64f3.khali@linux-fr.org>
In-Reply-To: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
References: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> we finally decided to rework the SPI core and now it its ready for
> your comments..  Here we have several boards equipped with SPI bus,
> and use this spi core with these boards;  Drivers for them are
> available by request (...and if community approve this patch)

I'm not exactly the best qualified person to comment on your work, but
I'd have a couple remarks nevertheless:

> --- linux-2.6.12/drivers/spi/helpers.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux/drivers/spi/helpers.c	2005-06-23 13:28:23.000000000 +0400
> @@ -0,0 +1,45 @@
> +/*
> + * drivers/spi/helper.c
> + *
> + * Helper functions.
> + *
> + * Author: dmitry pervushin <dpervushin@ru.mvista.com>
> + *
> + * 2004 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +
> +typedef struct {
> +	int (*callback) (struct device * dev, void *data);
> +	struct device_driver *drv;
> +	void *data;
> +} _find_t;
> +
> +static int dfed_callback(struct device *device, void *data)
> +{
> +	_find_t *local_data = (_find_t *) data;
> +
> +	return (device->driver != local_data->drv) ? 0 : 
> +	        (*local_data->callback) (device, local_data->data);
> +}
> +
> +int driver_for_each_dev(struct device_driver *drv, void *data,
> +			int (*callback) (struct device * dev, void *data))
> +{
> +	_find_t local_data;
> +
> +	local_data.drv = drv;
> +	local_data.data = data;
> +	local_data.callback = callback;
> +	return bus_for_each_dev(drv->bus, NULL, &local_data, dfed_callback);
> +}
> +
> +EXPORT_SYMBOL(driver_for_each_dev);

This stuff doesn't seem to be spi-specific at all. It would rather be
driver core material, right?

At any rate, I don't think anybody would enjoy a kernel module named
"helpers", whether spi-specific or not.

> +MODULE_AUTHOR("Jamey Hicks <jamey.hicks@compaq.com> Frodo Looijaard
> <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");

Please leave Frodo and Simon out of this. Crediting them in the headers
is fine if this work is derived from theirs, but they definitely are not
the authors of these modules.

> --- linux-2.6.12/drivers/spi/spi.h	1970-01-01 03:00:00.000000000 +0300
> +++ linux/drivers/spi/spi.h	2005-06-23 15:03:48.000000000 +0400
> (...)
> --- linux-2.6.12/include/linux/spi/spi.h	1970-01-01 03:00:00.000000000 +0300
> +++ linux/include/linux/spi/spi.h	2005-06-23 13:55:06.000000000 +0400

I don't think it's very smart to have two different files with the same
name in the kernel tree. More likely than not it will create confusion
at some point in time.

> +#define SELECT   	0x01
> +#define UNSELECT 	0x02
> +#define BEFORE_READ 	0x03
> +#define BEFORE_WRITE	0x04
> +#define AFTER_READ	0x05
> +#define AFTER_WRITE	0x06

This doesn't seem to belong there. You don't seem to use these values
anywhere in the spi core, and if you did these constants would need to
be prefixed with SPI_.

Thanks,
-- 
Jean Delvare
