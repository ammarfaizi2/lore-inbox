Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVEaXWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVEaXWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVEaXWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:22:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:11191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261183AbVEaXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:22:06 -0400
Date: Tue, 31 May 2005 16:32:15 -0700
From: Greg KH <greg@kroah.com>
To: dmitry pervushin <dpervushin@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [RFC] SPI core
Message-ID: <20050531233215.GB23881@kroah.com>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 08:09:16PM +0400, dmitry pervushin wrote:
> Hello guys,
> 
> In order to support the specific board, we have ported the generic SPI
> core to the 2.6 kernel. This core provides basic API to create/manage
> SPI devices like the I2C core does. We need to continue providing
> support of SPI devices and would like to maintain the SPI subtree. It
> would be nice if SPI core patch were applied to the vanilla kernel.
> I2C people do not like to mainain this code as well as I2C, so...

What do you mean by this?  Which i2c people?

Is this code intergrated into the driver model?
What does the /sys/ tree look like?
Why are you using a char device node?

> +/**
> + * spi_add_adapter - register a new SPI bus adapter
> + * @adap: spi_adapter structure for the registering adapter
> + *
> + * Make the adapter available for use by clients using name adap->name.
> + * The adap->adapters list is initialised by this function.
> + *
> + * Returns 0;

You have this a lot.  If the function can not fail, just make it a void
type :)

> +int spi_add_adapter(struct spi_adapter *adap)
> +{
> +	struct list_head *l;
> +
> +	INIT_LIST_HEAD(&adap->clients);
> +	down(&adapter_lock);
> +	init_MUTEX(&adap->lock);
> +	list_add(&adap->adapters, &adapter_list);
> +	up(&adapter_lock);
> +
> +	list_for_each(l, &driver_list) {

list_for_each_entry() please.

> +		struct spi_driver *drv =
> +		    list_entry(l, struct spi_driver, drivers);
> +
> +		if (drv->attach_adapter)
> +			drv->attach_adapter(adap);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * spi_del_adapter - unregister a SPI bus adapter
> + * @adap: spi_adapter structure to unregister
> + *
> + * Remove an adapter from the list of available SPI Bus adapters.
> + *
> + * Returns 0;
> + */
> +int spi_del_adapter(struct spi_adapter *adap)
> +{
> +	struct list_head *l;
> +
> +	down(&adapter_lock);
> +	list_del(&adap->adapters);
> +	up(&adapter_lock);
> +
> +	list_for_each(l, &driver_list) {
> +		struct spi_driver *drv =
> +		    list_entry(l, struct spi_driver, drivers);
> +
> +		if (drv->detach_adapter)
> +			drv->detach_adapter(adap);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * spi_get_adapter - get a reference to an adapter
> + * @id: driver id
> + *
> + * Obtain a spi_adapter structure for the specified adapter.  If the adapter
> + * is not currently load, then load it.  The adapter will be locked in core
> + * until all references are released via spi_put_adapter.
> + */
> +struct spi_adapter *spi_get_adapter(int id)
> +{
> +	struct list_head *item;
> +	struct spi_adapter *adapter;
> +
> +	down(&adapter_lock);
> +	list_for_each(item, &adapter_list) {
> +		adapter = list_entry(item, struct spi_adapter, adapters);
> +		if (id == adapter->nr && try_module_get(adapter->owner)) {
> +			up(&adapter_lock);
> +			return adapter;
> +		}
> +	}
> +	up(&adapter_lock);
> +	return NULL;
> +
> +}

Hm, that comment is not correct.  Please fix it as nothing is "loaded".

> +/**
> + * spi_put_adapter - release a reference to an adapter
> + * @adap: driver to release reference
> + *
> + * Indicate to the SPI core that you no longer require the adapter reference.
> + * The adapter module may be unloaded when there are no references to its
> + * data structure.
> + *
> + * You must not use the reference after calling this function.
> + */
> +void spi_put_adapter(struct spi_adapter *adap)
> +{
> +	if (adap && adap->owner)
> +		module_put(adap->owner);
> +}

Then why not use the traditional kref style of reference counting?  That
ensures that if you try to use the reference, bad things will happen?
Right now all you are doing is relying on module references, and you
aren't cleaning up the memory.

> +EXPORT_SYMBOL(spi_add_adapter);
> +EXPORT_SYMBOL(spi_del_adapter);
> +EXPORT_SYMBOL(spi_get_adapter);
> +EXPORT_SYMBOL(spi_put_adapter);
> +
> +EXPORT_SYMBOL(spi_add_driver);
> +EXPORT_SYMBOL(spi_del_driver);
> +EXPORT_SYMBOL(spi_get_driver);
> +EXPORT_SYMBOL(spi_put_driver);
> +
> +EXPORT_SYMBOL(spi_attach_client);
> +EXPORT_SYMBOL(spi_detach_client);
> +
> +EXPORT_SYMBOL(spi_transfer);
> +EXPORT_SYMBOL(spi_write);
> +EXPORT_SYMBOL(spi_read);

EXPORT_SYMBOL_GPL() perhaps?

> +/*  Define SPIDEV_DEBUG for debugging info  */
> +#undef SPIDEV_DEBUG

Use a Kconfig entry instead.

> +#ifdef SPIDEV_DEBUG
> +#define DBG(args...)	printk(KERN_INFO"spi-dev.o: " args)
> +#else
> +#define DBG(args...)
> +#endif

Please use dev_dbg() and friends instead of your own debugging macros.
The error log people will thank you (along with your users...)

> +#include <linux/init.h>
> +#include <asm/uaccess.h>
> +#include <linux/spi/spi.h>

Why a separate subdir for spi.h?

> +static int spidev_ioctl(struct inode *inode, struct file *file,
> +			unsigned int cmd, unsigned long arg)

Ick, please do NOT add new ioctls to the kernel.  Especially one as
complex and hard to audit as this one :(

The i2c dev interface is a mess, please don't duplicate it, there is no
need to do so.

Also, please run the code through sparse, I think it will spit out a lot
of errors here.

> +static int spidev_attach_adapter(struct spi_adapter *adap)
> +{
> +	struct spi_dev *spi_dev;
> +	int retval;
> +
> +	spi_dev = get_free_spi_dev(adap);
> +	if (IS_ERR(spi_dev))
> +		return PTR_ERR(spi_dev);
> +
> +#if defined( CONFIG_DEVFS_FS )
> +	devfs_mk_cdev(MKDEV(SPI_MAJOR, spi_dev->minor),
> +		      S_IFCHR | S_IRUSR | S_IWUSR, "spi/%d", spi_dev->minor);
> +#endif

No #if needed.  You do this a lot.


> +/*
> + * A driver is capable of handling one or more physical devices present on
> + * SPI adapters. This information is used to inform the driver of adapter
> + * events.
> + */
> +struct spi_driver {

Please use the driver model code.  That's what it is there for.

> +/*
> + * spi_adapter is the structure used to identify a physical SPI bus along
> + * with the access algorithms necessary to access it.
> + */
> +struct spi_adapter {

<snip>  Ick, don't copy the mess I did in the i2c core for i2c adapter
structures please.  It was a hack then, and I regret it still.  Please
fix it up properly.

This code is _very_ close to just a copy of the i2c core code.  Why
duplicate it and not work with the i2c people instead?

thanks,

greg k-h
