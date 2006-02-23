Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWBWFFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWBWFFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWBWFFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:05:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64654
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751267AbWBWFFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:05:19 -0500
Date: Wed, 22 Feb 2006 21:05:25 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: better reference counting for klists
Message-ID: <20060223050525.GA8046@kroah.com>
References: <Pine.LNX.4.44L0.0601261415140.4713-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601261415140.4713-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 03:17:02PM -0500, Alan Stern wrote:
> Greg:
> 
> This is a revised version (as641b) of the earlier patch that James 
> Bottomley didn't like.  It goes in the direction of eliminating 
> klist_remove entirely.  (One more patch is still needed...)
> 
> 	Add an is_registered flag to struct device, so that drivers
> 	won't get bound to a device after it is gone.
> 
> 	When unregistering a driver, use the drv->unloaded completion
> 	to wait for the device_driver structure to be removed from
> 	the bus's klist instead of using klist_remove.  This also
> 	eliminates the need for the klist_drivers_get method.  (It's
> 	not a violation of the refcounting credo, because we have to
> 	wait in any case for the driver to be completely idle before 
> 	driver_unregister can return.)
> 
> 	Likewise, the klist_devices_get and klist_devices_put methods
> 	in drivers.c aren't needed, because we always have to wait for
> 	a device to be completely removed from its driver's klist.  In
> 	fact, this is the last remaining usage of klist_remove.
> 
> 	Move the call to a klist's put method outside the scope of the
> 	spinlock (i.e., move it from klist_release to klist_del and
> 	klist_next).
> 
> The one unpalatable aspect of this patch is that it adds a new single-bit 
> flag to struct device, thereby increasing the structure's size by at least 
> 4 bytes.
> 
> Alan Stern
> 
> 
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Index: usb-2.6/drivers/base/dd.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/dd.c
> +++ usb-2.6/drivers/base/dd.c
> @@ -72,6 +72,8 @@ int driver_probe_device(struct device_dr
>  {
>  	int ret = 0;
>  
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>  	if (drv->bus->match && !drv->bus->match(dev, drv))
>  		goto Done;
>  
> Index: usb-2.6/drivers/base/bus.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/bus.c
> +++ usb-2.6/drivers/base/bus.c
> @@ -367,6 +367,7 @@ int bus_add_device(struct device * dev)
>  
>  	if (bus) {
>  		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> +		dev->is_registered = 1;
>  		device_attach(dev);
>  		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
>  		error = device_add_attrs(bus, dev);
> @@ -393,7 +394,8 @@ void bus_remove_device(struct device * d
>  		sysfs_remove_link(&dev->kobj, "bus");
>  		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
>  		device_remove_attrs(dev->bus, dev);
> -		klist_remove(&dev->knode_bus);
> +		klist_del(&dev->knode_bus);
> +		dev->is_registered = 0;

Don't we have a race between these two lines?  How is that protected?

thanks,

greg k-h
