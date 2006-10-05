Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWJEOQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWJEOQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWJEOQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:16:07 -0400
Received: from gate.perex.cz ([85.132.177.35]:454 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751384AbWJEOQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:16:04 -0400
Date: Thu, 5 Oct 2006 16:16:01 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@jikos.cz>, Castet Matthieu <castet.matthieu@free.fr>,
       Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] ALSA: fix kernel panic in initialization of mpu401 driver
In-Reply-To: <Pine.LNX.4.44L0.0610050959330.6226-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.61.0610051614220.9351@tm8103.perex-int.cz>
References: <Pine.LNX.4.44L0.0610050959330.6226-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Alan Stern wrote:

> On Thu, 5 Oct 2006, Jaroslav Kysela wrote:
> 
> > On Wed, 4 Oct 2006, Jiri Kosina wrote:
> > 
> > > I am getting kernel panic (NULL pointer dereference) on boot, with kernel 
> > > compiled with CONFIG_SND_MPU401_UART=y, on machine which does not have 
> > > this piece of hardware.
> > > 
> > > I have traced the problem down to 
> > > sound/drivers/mpu401/mpu401.c:snd_mpu401_probe() returning EINVAL, when 
> > > either port or IRQ parameters are not specified.
> > > 
> > > In such case, the drivers/base/bus.c:bus_attach_device() does not perform 
> > > klist_add_tail() call, but rather sets dev->is_registered to 0. This flag 
> > > is however not checked by the driver, so later on, when 
> > > alsa_card_mpu401_init() is called and platform_device_register_simple() 
> > > fails, the following callchain happens, causing NULL pointer dereference: 
> > > alsa_card_mpu401_init() -> platform_device_unregister() -> 
> > > platform_device_del() -> device_del() -> bus_remove_device() -> 
> > > klist_del() -> BOOM (the entry was not added to klist in 
> > > bus_attach_device()).
> > > 
> > > Proper solution is returning ENODEV from the ->probe() routine, which will 
> > > be correctly handled then by the rest of the device-driver attaching 
> > > subsystem (namely the retval check in bus_attach_device()). The following 
> > > patch fixes the problem, please apply.
> > 
> > Unfortunately, I do not think that it's a proper solution. I think that
> > platform device layer should play more nicely and if probe() fails for 
> > a reason and if platform_device_register_simple() does not set 
> > IS_ERR(), then platform_device_unregister() must be callable to free
> > all resources.
> > 
> > Also, you've proposed to not fix all returns in snd_mpu401_probe() only 
> > first two.
> > 
> > I would reject this patch and fix drivers/base/bus.c. The problematic 
> > change is in commit f2eaae197f4590c4d96f31b09b0ee9067421a95c and this 
> > patch will probably fix it:
> 
> Your patch is right as far as it goes, but it misses part of the problem.  
> device_add() shouldn't ignore the return value from bus_attach_device().  
> That's why we ended up trying to unregister a device which never was 
> properly registered in the first place.
> 
> What do you think of this addition to your patch (untested)?

Your addition looks good. Acked from me.

					Jaroslav

> Index: 18g20/drivers/base/bus.c
> ===================================================================
> --- 18g20.orig/drivers/base/bus.c
> +++ 18g20/drivers/base/bus.c
> @@ -453,8 +453,10 @@ void bus_remove_device(struct device * d
>  		remove_deprecated_bus_links(dev);
>  		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
>  		device_remove_attrs(dev->bus, dev);
> -		dev->is_registered = 0;
> -		klist_del(&dev->knode_bus);
> +		if (dev->is_registered) {
> +			dev->is_registered = 0;
> +			klist_del(&dev->knode_bus);
> +		}
>  		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
>  		device_release_driver(dev);
>  		put_bus(dev->bus);
> Index: 18g20/drivers/base/core.c
> ===================================================================
> --- 18g20.orig/drivers/base/core.c
> +++ 18g20/drivers/base/core.c
> @@ -485,7 +485,8 @@ int device_add(struct device *dev)
>  	if ((error = bus_add_device(dev)))
>  		goto BusError;
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> -	bus_attach_device(dev);
> +	if ((error = bus_attach_device(dev)))
> +		goto AttachError;
>  	if (parent)
>  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
>  
> @@ -504,6 +505,8 @@ int device_add(struct device *dev)
>   	kfree(class_name);
>  	put_device(dev);
>  	return error;
> + AttachError:
> +	bus_remove_device(dev);
>   BusError:
>  	device_pm_remove(dev);
>   PMError:

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
