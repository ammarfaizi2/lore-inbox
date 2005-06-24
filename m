Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVFXAih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVFXAih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVFXAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:38:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:2970 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262959AbVFXAgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:36:19 -0400
Date: Thu, 23 Jun 2005 17:35:56 -0700
From: Greg KH <greg@kroah.com>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
Message-ID: <20050624003555.GA22397@kroah.com>
References: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 04:18:54PM +0400, dmitry pervushin wrote:
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

Use the built-in kernel functions, don't create a new one and go around
the _GPL export.

> +#ifdef CONFIG_SPI_DEBUG
> +#define DEBUG
> +#endif				/* CONFIG_SPI_DEBUG */

Have the Makefile define this for you, it's not needed in the .c file

> +#include <linux/spi/spi.h>

Why a separate subdirectory?  It should just go in include/linux/ like
everything else.

> +	if (NULL == dev || NULL == driver) {

dev == NULL instead of the other way around (yes, I know why you do
this, but the rest of the kernel is the other way, and gcc will warn you
if you forget a '=').

> +SPI_IDS_TABLE_BEGIN
> +    SPI_ID_ANY 
> +SPI_IDS_TABLE_END 

Ick, that's a horrible way to define things.  Please make it look like
real .c code.

> +static struct spi_driver spidev_driver = {
> +	.owner = THIS_MODULE,
> +	.driver = {
> +		   .name = "generic spi",

No spaces in driver names please.

> +	drvdata = (spidev_driver_data_t *) kmalloc(sizeof(spidev_driver_data_t),
> +						   GFP_KERNEL);

Cast is unnecessary.

Also, get rid of all typedefs, they are not acceptable.

> +#ifdef CONFIG_DEVFS_FS
> +	devfs_mk_cdev(MKDEV(SPI_MAJOR, drvdata->minor),
> +		      S_IFCHR | S_IRUSR | S_IWUSR, "spi/%d", drvdata->minor);
> +#endif

Don't put #ifdef in code where it is not needed at all.

> +	if (NULL == dev) {
> +		printk(KERN_ERR "%s: removing the NULL device\n", __FUNCTION__);
> +	}

Extra { } are not needed.

What is this checking for anyway?

Use dev_err() for these things.

> +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
> +			   loff_t * offset)
> +{
> +	char *tmp;
> +	int ret = 0;
> +#ifdef DEBUG
> +	struct inode *inode = file->f_dentry->d_inode;
> +#endif

#ifdef not nice to have here, it's not needed.

> +#define SPI_STUFF_FOUND -ECANCELED

Just use the raw error number, don't redefine it.

> +struct spi_adapter {
> +	/*
> +	 * This name is used to uniquely identify the adapter.
> +	 * It should be the same as the module name.
> +	 */
> +	char name[32];

Why not use the device.bus_id instead?

I too would like to see how this code is used, example drivers please.

thanks,

greg k-h
