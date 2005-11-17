Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVKQRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVKQRAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVKQRAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:00:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:20616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932405AbVKQRAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:00:17 -0500
Date: Thu, 17 Nov 2005 08:25:33 -0800
From: Greg KH <gregkh@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH 02/02] USB: add dynamic id functionality to USB core
Message-ID: <20051117162533.GB26824@suse.de>
References: <20051117003241.GC14896@kroah.com> <Pine.LNX.4.44L0.0511171049070.5089-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511171049070.5089-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 10:55:33AM -0500, Alan Stern wrote:
> A few minor comments...
> 
> On Wed, 16 Nov 2005, Greg KH wrote:
> 
> > +static ssize_t store_new_id(struct device_driver *driver,
> > +			    const char *buf, size_t count)
> > +{
> > +	struct usb_driver *usb_drv = to_usb_driver(driver);
> > +	struct usb_dynid *dynid;
> > +	u32 idVendor = 0;
> > +	u32 idProduct = 0;
> > +	int fields = 0;
> > +
> > +	fields = sscanf(buf, "%x %x", &idVendor, &idProduct);
> > +	if (fields < 0)
> > +		return -EINVAL;
> 
> Don't you want to test (fields < 2)?

No, it's ok to just specify the vendor, if you want a product of 0 :)

PCI does it this way too.

> > +	if (get_driver(&usb_drv->driver)) {
> > +		driver_attach(&usb_drv->driver);
> > +		put_driver(&usb_drv->driver);
> > +	}
> 
> Here you don't have to refer to &usb_drv->driver; you can just refer to 
> driver.

Good point, changed, thanks.

> > +static int usb_create_newid_file(struct usb_driver *usb_drv)
> > +{
> > +	int error = 0;
> > +
> > +	if (usb_drv->probe != NULL)
> > +		error = sysfs_create_file(&usb_drv->driver.kobj,
> > +					  &driver_attr_new_id.attr);
> > +	return error;
> > +}
> 
> This deserves to be an inline function.
> 
> > +static void usb_free_dynids(struct usb_driver *usb_drv)
> > +{
> > +	struct usb_dynid *dynid, *n;
> > +
> > +	spin_lock(&usb_drv->dynids.lock);
> > +	list_for_each_entry_safe(dynid, n, &usb_drv->dynids.list, node) {
> > +		list_del(&dynid->node);
> > +		kfree(dynid);
> > +	}
> > +	spin_unlock(&usb_drv->dynids.lock);
> > +}
> 
> This could be inline as well, although being longer, its overhead is less 
> noticeable.

It's just not worth it to inline these, it's not speed critical at all.
I prefer to not inline stuff unless it help out somehow.

thanks for the review,

greg k-h
