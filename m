Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVLAQVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVLAQVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVLAQVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:21:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12297 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932313AbVLAQVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:21:13 -0500
Date: Thu, 1 Dec 2005 16:21:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, greg@kroah.com, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
Message-ID: <20051201162102.GB31551@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@ru.mvista.com>,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
	basicmark@yahoo.com, komal_shah802003@yahoo.com,
	stephen@streetfiresound.com,
	spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201191109.40f2d04b.vwool@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 07:11:09PM +0300, Vitaly Wool wrote:
> The main changes are:
> 
> - Matching rmk's 2.6.14-git5+ changes for device_driver suspend and
>   resume calls
> - Matching rmk's request to get rid of device_driver's calls to
>   suspend/resume/probe/remove

Thanks.  Please see comments below though.

> +iii. struct spi_driver
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +struct spi_driver {
> +    	void* (*alloc)( size_t, int );
> +    	void  (*free)( const void* );
> +    	unsigned char* (*get_buffer)( struct spi_device*, void* );
> +    	void (*release_buffer)( struct spi_device*, unsigned char*);
> +    	void (*control)( struct spi_device*, int mode, u32 ctl );
> +        struct device_driver driver;
> +};

This doesn't appear to have been updated.

> +formed spi_driver structure:
> +	extern struct bus_type spi_bus;
> +	static struct spi_driver pnx4008_eeprom_driver = {
> +        	.driver = {
> +                   	.bus = &spi_bus,
> +                   	.name = "pnx4008-eeprom",
> +                   	.probe = pnx4008_spiee_probe,
> +                   	.remove = pnx4008_spiee_remove,
> +                   	.suspend = pnx4008_spiee_suspend,
> +                   	.resume = pnx4008_spiee_resume,
> +               	},
> +};

Ditto.

> +iv. struct spi_bus_driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +To handle transactions over the SPI bus, the spi_bus_driver structure must
> +be prepared and registered with core. Any transactions, either synchronous
> +or asynchronous, go through spi_bus_driver->xfer function.
> +
> +struct spi_bus_driver
> +{
> +        int (*xfer)( struct spi_msg* msgs );
> +        void (*select) ( struct spi_device* arg );
> +        void (*deselect)( struct spi_device* arg );
> +
> +	struct spi_msg *(*retrieve)( struct spi_bus_driver *this, struct spi_bus_data *bd);
> +	void (*reset)( struct spi_bus_driver *this, u32 context);
> +
> +        struct device_driver driver;
> +};

Does this need updating as well?

> +spi_bus_driver structure:
> +	static struct spi_bus_driver spipnx_driver = {
> +        .driver = {
> +                   .bus = &platform_bus_type,
> +                   .name = "spipnx",
> +                   .probe = spipnx_probe,
> +                   .remove = spipnx_remove,
> +                   .suspend = spipnx_suspend,
> +                   .resume = spipnx_resume,
> +                   },
> +        .xfer = spipnx_xfer,
> +};

>From this it looks like it does.

> +/**
> + * spi_bus_suspend - suspend all devices on the spi bus
> + *
> + * @dev: spi device to be suspended
> + * @message: PM message
> + *
> + * This function set device on SPI bus to suspended state, just like platform_bus does
> +**/
> +static int spi_bus_suspend(struct device * dev, pm_message_t message)
> +{
> +	int ret = 0;
> +
> +	if (dev && dev->driver && dev->driver->suspend ) {
> +		ret = TO_SPI_DRIVER(dev->driver)->suspend( TO_SPI_DEV(dev), message);
> +		if (ret == 0 )
> +			dev->power.power_state = message;
> +	}
> +	return ret;
> +}
> +
> +/**
> + * spi_bus_resume - resume functioning of all devices on spi bus
> + *
> + * @dev: device to resume
> + *
> + * This function resumes device on SPI bus, just like platform_bus does
> +**/
> +static int spi_bus_resume(struct device * dev)
> +{
> +	int ret = 0;
> +
> +	if (dev && dev->driver && dev->driver->suspend ) {
> +		ret = TO_SPI_DRIVER(dev->driver)->resume(TO_SPI_DEV(dev));
> +		if (ret == 0)
> +			dev->power.power_state = PMSG_ON;
> +	}
> +	return ret;
> +}

Ok, your bus_type suspend/resume methods call your spi_driver's suspend
and resume methods - good.

> +/*
> + * the functions below are wrappers for corresponding device_driver's methods
> + */
> +int spi_driver_probe (struct device *dev)
> +{
> +	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
> +	struct spi_device *sdev = TO_SPI_DEV(dev);
> +
> +	return sdrv && sdrv->probe ? sdrv->probe(sdev) : -EFAULT;
> +}
> +
> +int spi_driver_remove (struct device *dev)
> +{
> +	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
> +	struct spi_device *sdev = TO_SPI_DEV(dev);
> +
> +	return  (sdrv && sdrv->remove)  ? sdrv->remove(sdev) : -EFAULT;
> +}

These are fine, although sdrv will always be non-NULL here.

> +
> +void spi_driver_shutdown (struct device *dev)
> +{
> +	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
> +	struct spi_device *sdev = TO_SPI_DEV(dev);
> +
> +	if (sdrv && sdrv->shutdown)
> +		sdrv->shutdown(sdev);
> +}

dev->driver may be NULL here.  If it is NULL, sdrv will not be.
Hence you want to do:

	if (dev->driver && sdrv->shutdown)

instead.

> +
> +int spi_driver_suspend (struct device *dev, pm_message_t pm)
> +{
> +	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
> +	struct spi_device *sdev = TO_SPI_DEV(dev);
> +
> +	return (sdrv && sdrv->suspend) ?  sdrv->suspend(sdev, pm) : -EFAULT;
> +}
> +
> +int spi_driver_resume (struct device *dev)
> +{
> +	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
> +	struct spi_device *sdev = TO_SPI_DEV(dev);
> +
> +	return (sdrv && sdrv->resume) ? sdrv->resume(sdev) : -EFAULT;
> +}

If the bus_type does not call the device_driver suspend/resume methods,
these are not necessary.

Another oddity I notice is that if there isn't a driver or method, you're
returning -EFAULT - seems odd since if there isn't a driver do you really
want to prevent suspend/resume?

> +static inline int spi_driver_add(struct spi_driver *drv)
> +{
> +	drv->driver.bus = &spi_bus;
> +	drv->driver.probe = spi_driver_probe;
> +	drv->driver.remove = spi_driver_remove;
> +	drv->driver.shutdown = spi_driver_shutdown;

> +	drv->driver.suspend = spi_driver_suspend;
> +	drv->driver.resume = spi_driver_resume;

As a result of the comment above, you don't need these two initialisers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
