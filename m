Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264728AbSJORwh>; Tue, 15 Oct 2002 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSJORwM>; Tue, 15 Oct 2002 13:52:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35227 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264627AbSJORvw>;
	Tue, 15 Oct 2002 13:51:52 -0400
Date: Tue, 15 Oct 2002 10:58:32 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Greg KH <greg@kroah.com>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [RFC] device_initialize()
In-Reply-To: <20021014172422.GE6955@kroah.com>
Message-ID: <Pine.LNX.4.44.0210151053040.1038-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there.

> ===== drivers/base/core.c 1.40 vs edited =====
> --- 1.40/drivers/base/core.c	Fri Oct 11 23:08:56 2002
> +++ edited/drivers/base/core.c	Mon Oct 14 09:36:58 2002
> @@ -150,6 +150,27 @@
>  }
>  
>  /**
> + * device_initialize - initialize a device
> + * @dev:	pointer to the device structure
> + */
> +int device_initialize (struct device *dev)
> +{
> +	if (!dev)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&dev->node);
> +	INIT_LIST_HEAD(&dev->children);
> +	INIT_LIST_HEAD(&dev->g_list);
> +	INIT_LIST_HEAD(&dev->driver_list);
> +	INIT_LIST_HEAD(&dev->bus_list);
> +	INIT_LIST_HEAD(&dev->intf_list);
> +	spin_lock_init(&dev->lock);
> +	atomic_set(&dev->refcount,1);
> +	dev->state = DEVICE_INITIALIZED;
> +	return 0;
> +}
> +
> +/**
>   * device_register - register a device
>   * @dev:	pointer to the device structure
>   *
> @@ -167,15 +188,10 @@
>  	if (!dev || !strlen(dev->bus_id))
>  		return -EINVAL;
>  
> -	INIT_LIST_HEAD(&dev->node);
> -	INIT_LIST_HEAD(&dev->children);
> -	INIT_LIST_HEAD(&dev->g_list);
> -	INIT_LIST_HEAD(&dev->driver_list);
> -	INIT_LIST_HEAD(&dev->bus_list);
> -	INIT_LIST_HEAD(&dev->intf_list);
> -	spin_lock_init(&dev->lock);
> -	atomic_set(&dev->refcount,2);
> -	dev->present = 1;
> +	if (dev->state != DEVICE_INITIALIZED)
> +		return -EINVAL;
> +
> +	get_device(dev);
>  	spin_lock(&device_lock);
>  	if (dev->parent) {
>  		get_device_locked(dev->parent);
> @@ -212,6 +228,7 @@
>  		if (dev->parent)
>  			put_device(dev->parent);
>  	}
> +	dev->state = DEVICE_INITIALIZED;
>  	put_device(dev);
>  	return error;
>  }

> ===== include/linux/device.h 1.34 vs edited =====
> --- 1.34/include/linux/device.h	Fri Oct 11 23:09:04 2002
> +++ edited/include/linux/device.h	Sun Oct 13 20:02:41 2002
> @@ -256,7 +256,11 @@
>  
>  extern int interface_add_data(struct intf_data *);
>  
> -
> +enum device_state {
> +	DEVICE_INITIALIZED =	1,
> +	DEVICE_REGISTERED =	2,
> +	DEVICE_GONE =		3,
> +};


Overall, I agree with the concept of the patch. I wonder though if we 
could do it without burdening all the callers of device_register() to 
first call device_initialize(). Well, tastefully at least. 

What about: 

enum device_state {
	DEVICE_UNINITIALIZED =  0,
	DEVICE_INITIALIZED =    1,
	DEVICE_REGISTERED =     2,   
	DEVICE_GONE =           3,
};

int device_register(struct device * dev)
{
	...
	if (dev->state == DEVICE_UNINITIALIZED)
		device_initialize(dev);
	...
}

This assumes that the device structure is initialized to 0 before 
device_register() is called (which it should be anyway to prevent other 
unpredictable behavior). 

Is that too ugly?

	-pat

