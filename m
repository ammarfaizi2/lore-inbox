Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVJYEmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVJYEmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 00:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVJYEmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 00:42:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:26535 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751420AbVJYEmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 00:42:03 -0400
Subject: Re: dev->release = (void (*)(struct device *))kfree;
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, jglauber@redhat.com,
       xenia@us.ibm.com, wein@de.ibm.com
In-Reply-To: <20051024201018.153550d6.zaitcev@redhat.com>
References: <20051024201018.153550d6.zaitcev@redhat.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 14:36:21 +1000
Message-Id: <1130214982.7919.96.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 20:10 -0700, Pete Zaitcev wrote:
> I seem to recall the discussion about this, but very dimly. Would someone
> be so kind to remind me, why the attached patch cannot be used?

If your struct device becomes a member of your vmlogrdr_priv structure,
then you need to tie the lifetime of that structure to the one of the
struct device kobject. Thus, you need to provide a "release" callback
that frees your entire vmlogrdr_priv structure and of course not free it
yourself (but simply consider it lost after you have called
device_unregister).

In addition, if you are in the module, you get into funky issues since
you must make sure your free routine doesn't "go away" with your module
before the object is freed (it may be held a long time in memory by some
userland thing opening a sysfs file to it). If you set the owner field
of the kobj, your module should be held there (but may become totally
un-rmmod'able in some circumstances, how fun...)

If you need to keep your vmlogrdr_priv structure around a little while
longer after device_unregister(), just increase it's refcount before
doing device_unregister() and drop it when you don't need it anymore. It
will still be unregistered (removed from the various lists) but the
release() callback won't be called until the last user.

Ben.


> -- Pete
> 
> diff -urp -X dontdiff linux-2.6.14-rc5/drivers/s390/char/vmlogrdr.c linux-2.6.14-rc5-lem/drivers/s390/char/vmlogrdr.c
> --- linux-2.6.14-rc5/drivers/s390/char/vmlogrdr.c	2005-09-13 01:06:11.000000000 -0700
> +++ linux-2.6.14-rc5-lem/drivers/s390/char/vmlogrdr.c	2005-10-24 20:05:26.000000000 -0700
> @@ -74,7 +74,7 @@ struct vmlogrdr_priv_t {
>  	int buffer_free;
>  	int dev_in_use; /* 1: already opened, 0: not opened*/
>  	spinlock_t priv_lock;
> -	struct device  *device;
> +	struct device device;
>  	struct class_device  *class_device;
>  	int autorecording;
>  	int autopurge;
> @@ -756,27 +756,14 @@ vmlogrdr_unregister_driver(void) {
>  
>  static int
>  vmlogrdr_register_device(struct vmlogrdr_priv_t *priv) {
> -	struct device *dev;
> +	struct device *dev = &priv->device;
>  	int ret;
>  
> -	dev = kmalloc(sizeof(struct device), GFP_KERNEL);
> -	if (dev) {
> -		memset(dev, 0, sizeof(struct device));
> -		snprintf(dev->bus_id, BUS_ID_SIZE, "%s",
> -			 priv->internal_name);
> -		dev->bus = &iucv_bus;
> -		dev->parent = iucv_root;
> -		dev->driver = &vmlogrdr_driver;
> -		/*
> -		 * The release function could be called after the
> -		 * module has been unloaded. It's _only_ task is to
> -		 * free the struct. Therefore, we specify kfree()
> -		 * directly here. (Probably a little bit obfuscating
> -		 * but legitime ...).
> -		 */
> -		dev->release = (void (*)(struct device *))kfree;
> -	} else
> -		return -ENOMEM;
> +	memset(dev, 0, sizeof(struct device));
> +	snprintf(dev->bus_id, BUS_ID_SIZE, "%s", priv->internal_name);
> +	dev->bus = &iucv_bus;
> +	dev->parent = iucv_root;
> +	dev->driver = &vmlogrdr_driver;
>  	ret = device_register(dev);
>  	if (ret)
>  		return ret;
> @@ -799,7 +786,6 @@ vmlogrdr_register_device(struct vmlogrdr
>  		return ret;
>  	}
>  	dev->driver_data = priv;
> -	priv->device = dev;
>  	return 0;
>  }
>  
> @@ -807,11 +793,8 @@ vmlogrdr_register_device(struct vmlogrdr
>  static int
>  vmlogrdr_unregister_device(struct vmlogrdr_priv_t *priv ) {
>  	class_device_destroy(vmlogrdr_class, MKDEV(vmlogrdr_major, priv->minor_num));
> -	if (priv->device != NULL) {
> -		sysfs_remove_group(&priv->device->kobj, &vmlogrdr_attr_group);
> -		device_unregister(priv->device);
> -		priv->device=NULL;
> -	}
> +	sysfs_remove_group(&priv->device.kobj, &vmlogrdr_attr_group);
> +	device_unregister(&priv->device);
>  	return 0;
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

