Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161269AbWJPJNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWJPJNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWJPJNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:13:37 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:15236 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161269AbWJPJNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:13:35 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
Date: Mon, 16 Oct 2006 11:13:30 +0200
User-Agent: KMail/1.9.5
Cc: Greg K-H <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20061016104411.1fb2bc57@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061016104411.1fb2bc57@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161113.31007.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 10:44, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Make multithreaded probing work per subsystem instead of per driver.
> 
> It doesn't make much sense to probe the same device for multiple drivers in
> parallel (after all, only one driver can bind to the device). Instead, create
> a probing thread for each device that probes the drivers one after another.
> Also make the decision to use multi-threaded probe per bus instead of per
> device and adapt the pci code.

I see that you also fix another problem with the previous code: probe would
be called with dev->sem taken in the single-threaded case, but not necessarily
in the multi-threaded case (because the kthread might run after the original
thread dropped the semaphore).  There may have been a similar problem with
USB locking, since there too probe was expecting a lock to be held that might
not be held when called from the kthread:

	 * This function must be called with @dev->sem held.  When called for a
	 * USB interface, @dev->parent->sem must be held as well.
	 */
	int driver_probe_device(struct device_driver * drv, struct device * dev)

I guess the code should be reviewed to check that all such problems have now
been eliminated.

Also, what about device removal racing with probe?  Is it possible for someone to
attempt to remove a device in the gap between the call to device_attach and the
kthread actually running and doing the probe?  That would result in remove and
probe being called in the wrong order...

Best wishes,

Duncan.

> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> ---
>  drivers/base/dd.c        |   54 +++++++++++++++++++++++------------------------
>  drivers/pci/pci-driver.c |    6 -----
>  include/linux/device.h   |    4 +--
>  include/linux/pci.h      |    2 -
>  4 files changed, 30 insertions(+), 36 deletions(-)
> 
> --- linux-2.6.orig/drivers/base/dd.c
> +++ linux-2.6/drivers/base/dd.c
> @@ -88,17 +88,9 @@ int device_bind_driver(struct device *de
>  	return ret;
>  }
>  
> -struct stupid_thread_structure {
> -	struct device_driver *drv;
> -	struct device *dev;
> -};
> -
>  static atomic_t probe_count = ATOMIC_INIT(0);
> -static int really_probe(void *void_data)
> +static int really_probe(struct device *dev, struct device_driver *drv)
>  {
> -	struct stupid_thread_structure *data = void_data;
> -	struct device_driver *drv = data->drv;
> -	struct device *dev = data->dev;
>  	int ret = 0;
>  
>  	atomic_inc(&probe_count);
> @@ -138,7 +130,6 @@ probe_failed:
>  	 */
>  	ret = 0;
>  done:
> -	kfree(data);
>  	atomic_dec(&probe_count);
>  	return ret;
>  }
> @@ -177,8 +168,6 @@ int driver_probe_done(void)
>   */
>  int driver_probe_device(struct device_driver * drv, struct device * dev)
>  {
> -	struct stupid_thread_structure *data;
> -	struct task_struct *probe_task;
>  	int ret = 0;
>  
>  	if (!device_is_registered(dev))
> @@ -189,19 +178,7 @@ int driver_probe_device(struct device_dr
>  	pr_debug("%s: Matched Device %s with Driver %s\n",
>  		 drv->bus->name, dev->bus_id, drv->name);
>  
> -	data = kmalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -	data->drv = drv;
> -	data->dev = dev;
> -
> -	if (drv->multithread_probe) {
> -		probe_task = kthread_run(really_probe, data,
> -					 "probe-%s", dev->bus_id);
> -		if (IS_ERR(probe_task))
> -			ret = really_probe(data);
> -	} else
> -		ret = really_probe(data);
> +	ret = really_probe(dev, drv);
>  
>  done:
>  	return ret;
> @@ -213,6 +190,19 @@ static int __device_attach(struct device
>  	return driver_probe_device(drv, dev);
>  }
>  
> +static int device_probe_drivers(void *data)
> +{
> +	struct device *dev = data;
> +	int ret = 0;
> +
> +	if (dev->bus) {
> +		down(&dev->sem);
> +		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
> +		up(&dev->sem);
> +	}
> +	return ret;
> +}
> +
>  /**
>   *	device_attach - try to attach device to a driver.
>   *	@dev:	device.
> @@ -229,14 +219,24 @@ static int __device_attach(struct device
>  int device_attach(struct device * dev)
>  {
>  	int ret = 0;
> +	struct task_struct *probe_task;
>  
>  	down(&dev->sem);
>  	if (dev->driver) {
>  		ret = device_bind_driver(dev);
>  		if (ret == 0)
>  			ret = 1;
> -	} else
> -		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
> +	} else {
> +		if (dev->bus->multithread_probe) {
> +			probe_task = kthread_run(device_probe_drivers, dev,
> +						 "probe-%s", dev->bus_id);
> +			if(IS_ERR(probe_task))
> +				ret = bus_for_each_drv(dev->bus, NULL, dev,
> +						       __device_attach);
> +		} else
> +			ret = bus_for_each_drv(dev->bus, NULL, dev,
> +					       __device_attach);
> +	}
>  	up(&dev->sem);
>  	return ret;
>  }
> --- linux-2.6.orig/drivers/pci/pci-driver.c
> +++ linux-2.6/drivers/pci/pci-driver.c
> @@ -422,11 +422,6 @@ int __pci_register_driver(struct pci_dri
>  	drv->driver.owner = owner;
>  	drv->driver.kobj.ktype = &pci_driver_kobj_type;
>  
> -	if (pci_multithread_probe)
> -		drv->driver.multithread_probe = pci_multithread_probe;
> -	else
> -		drv->driver.multithread_probe = drv->multithread_probe;
> -
>  	spin_lock_init(&drv->dynids.lock);
>  	INIT_LIST_HEAD(&drv->dynids.list);
>  
> @@ -559,6 +554,7 @@ struct bus_type pci_bus_type = {
>  
>  static int __init pci_driver_init(void)
>  {
> +	pci_bus_type.multithread_probe = pci_multithread_probe;
>  	return bus_register(&pci_bus_type);
>  }
>  
> --- linux-2.6.orig/include/linux/device.h
> +++ linux-2.6/include/linux/device.h
> @@ -57,6 +57,8 @@ struct bus_type {
>  	int (*suspend_late)(struct device * dev, pm_message_t state);
>  	int (*resume_early)(struct device * dev);
>  	int (*resume)(struct device * dev);
> +
> +	unsigned int multithread_probe:1;
>  };
>  
>  extern int __must_check bus_register(struct bus_type * bus);
> @@ -106,8 +108,6 @@ struct device_driver {
>  	void	(*shutdown)	(struct device * dev);
>  	int	(*suspend)	(struct device * dev, pm_message_t state);
>  	int	(*resume)	(struct device * dev);
> -
> -	unsigned int multithread_probe:1;
>  };
>  
>  
> --- linux-2.6.orig/include/linux/pci.h
> +++ linux-2.6/include/linux/pci.h
> @@ -356,8 +356,6 @@ struct pci_driver {
>  	struct pci_error_handlers *err_handler;
>  	struct device_driver	driver;
>  	struct pci_dynids dynids;
> -
> -	int multithread_probe;
>  };
>  
>  #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
