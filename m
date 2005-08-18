Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVHRLdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVHRLdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVHRLdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:33:18 -0400
Received: from emulex.emulex.com ([138.239.112.1]:58314 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S932198AbVHRLdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:33:17 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: [PATCH] add transport class symlink to device object
Date: Thu, 18 Aug 2005 07:32:53 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F4424@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] add transport class symlink to device object
Thread-Index: AcWjv2Wqgr+FbkCNTQes8JIEKEBDvAAKQ+Gw
To: <greg@kroah.com>, <James.Bottomley@SteelEye.com>
Cc: <matthew@wil.cx>, <akpm@osdl.org>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
       <rmk@arm.linux.org.uk>, <dtor@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can live with this.  I would have liked the "class:" prefix, but the name
does start to get long, and this is ok.

-- james s

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Thursday, August 18, 2005 2:37 AM
> To: James Bottomley
> Cc: Matthew Wilcox; Smart, James; Andrew Morton; SCSI Mailing List;
> Linux Kernel; Alan Cox; Russell King; Dmitry Torokhov
> Subject: Re: [PATCH] add transport class symlink to device object
> 
> 
> On Wed, Aug 17, 2005 at 10:23:11PM -0700, Greg KH wrote:
> > On Mon, Aug 15, 2005 at 05:41:17PM -0500, James Bottomley wrote:
> > > Actually, isn't the fix to all of this to combine Greg and James'
> > > patches?
> > 
> > Yes it is.
> > 
> > > The Greg one fails in SCSI because we don't have unique 
> class device
> > > names (by convention we use the same name as the device 
> bus_id) and
> > > James' one fails for ttys because the class name isn't 
> unique.  However,
> > > if the link were derived from something like
> > > 
> > > <class name>:<class device name>
> > > 
> > > Then is would be unique in both cases.
> > 
> > I agree.
> > 
> > > Unless anyone can think of any more failing cases?
> > 
> > I'll try this out and see if anything breaks :)
> 
> Ok, here's the patch.  I like it, and I think it will prevent any
> duplicate symlinks from happening.  Anyone have any objections?
> 
> thanks,
> 
> greg k-h
> 
> --------------
> 
> Driver core: link device and all class devices derived from it.
> 
> To ease the task of locating class devices derived from a certain
> device create symlinks from parent device to its class devices.
> Change USB host class device name from usbX to usb_hostX to avoid
> conflict when creating aforementioned links.
> 
> Tweaked by Greg to have the symlink be "class_name:class_device_name"
> in order to prevent duplicate links.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/base/class.c   |   33 +++++++++++++++++++++++++++++++--
>  drivers/usb/core/hcd.c |    2 +-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> --- gregkh-2.6.orig/drivers/base/class.c	2005-08-17 
> 23:27:02.000000000 -0700
> +++ gregkh-2.6/drivers/base/class.c	2005-08-17 
> 23:27:25.000000000 -0700
> @@ -452,10 +452,29 @@ void class_device_initialize(struct clas
>  	INIT_LIST_HEAD(&class_dev->node);
>  }
>  
> +static char *make_class_name(struct class_device *class_dev)
> +{
> +	char *name;
> +	int size;
> +
> +	size = strlen(class_dev->class->name) +
> +		strlen(kobject_name(&class_dev->kobj)) + 2;
> +
> +	name = kmalloc(size, GFP_KERNEL);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	strcpy(name, class_dev->class->name);
> +	strcat(name, ":");
> +	strcat(name, kobject_name(&class_dev->kobj));
> +	return name;
> +}
> +
>  int class_device_add(struct class_device *class_dev)
>  {
>  	struct class * parent = NULL;
>  	struct class_interface * class_intf;
> +	char *class_name = NULL;
>  	int error;
>  
>  	class_dev = class_device_get(class_dev);
> @@ -500,9 +519,13 @@ int class_device_add(struct class_device
>  	}
>  
>  	class_device_add_attrs(class_dev);
> -	if (class_dev->dev)
> +	if (class_dev->dev) {
> +		class_name = make_class_name(class_dev);
>  		sysfs_create_link(&class_dev->kobj,
>  				  &class_dev->dev->kobj, "device");
> +		sysfs_create_link(&class_dev->dev->kobj, 
> &class_dev->kobj,
> +				  class_name);
> +	}
>  
>  	/* notify any interfaces this device is now here */
>  	if (parent) {
> @@ -519,6 +542,7 @@ int class_device_add(struct class_device
>  	if (error && parent)
>  		class_put(parent);
>  	class_device_put(class_dev);
> +	kfree(class_name);
>  	return error;
>  }
>  
> @@ -584,6 +608,7 @@ void class_device_del(struct class_devic
>  {
>  	struct class * parent = class_dev->class;
>  	struct class_interface * class_intf;
> +	char *class_name = NULL;
>  
>  	if (parent) {
>  		down(&parent->sem);
> @@ -594,8 +619,11 @@ void class_device_del(struct class_devic
>  		up(&parent->sem);
>  	}
>  
> -	if (class_dev->dev)
> +	if (class_dev->dev) {
> +		class_name = make_class_name(class_dev);
>  		sysfs_remove_link(&class_dev->kobj, "device");
> +		sysfs_remove_link(&class_dev->dev->kobj, class_name);
> +	}
>  	if (class_dev->devt_attr)
>  		class_device_remove_file(class_dev, 
> class_dev->devt_attr);
>  	class_device_remove_attrs(class_dev);
> @@ -605,6 +633,7 @@ void class_device_del(struct class_devic
>  
>  	if (parent)
>  		class_put(parent);
> +	kfree(class_name);
>  }
>  
>  void class_device_unregister(struct class_device *class_dev)
> --- gregkh-2.6.orig/drivers/usb/core/hcd.c	2005-08-17 
> 23:26:55.000000000 -0700
> +++ gregkh-2.6/drivers/usb/core/hcd.c	2005-08-17 
> 23:27:04.000000000 -0700
> @@ -782,7 +782,7 @@ static int usb_register_bus(struct usb_b
>  		return -E2BIG;
>  	}
>  
> -	bus->class_dev = class_device_create(usb_host_class, 
> MKDEV(0,0), bus->controller, "usb%d", busnum);
> +	bus->class_dev = class_device_create(usb_host_class, 
> MKDEV(0,0), bus->controller, "usb_host%d", busnum);
>  	if (IS_ERR(bus->class_dev)) {
>  		clear_bit(busnum, busmap.busmap);
>  		up(&usb_bus_list_lock);
> 
