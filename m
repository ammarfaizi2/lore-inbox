Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVKQPzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKQPzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKQPzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:55:36 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:18917 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932170AbVKQPzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:55:35 -0500
Date: Thu, 17 Nov 2005 10:55:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <gregkh@suse.de>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH 02/02] USB: add dynamic id functionality
 to USB core
In-Reply-To: <20051117003241.GC14896@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0511171049070.5089-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few minor comments...

On Wed, 16 Nov 2005, Greg KH wrote:

> +static ssize_t store_new_id(struct device_driver *driver,
> +			    const char *buf, size_t count)
> +{
> +	struct usb_driver *usb_drv = to_usb_driver(driver);
> +	struct usb_dynid *dynid;
> +	u32 idVendor = 0;
> +	u32 idProduct = 0;
> +	int fields = 0;
> +
> +	fields = sscanf(buf, "%x %x", &idVendor, &idProduct);
> +	if (fields < 0)
> +		return -EINVAL;

Don't you want to test (fields < 2)?

> +	if (get_driver(&usb_drv->driver)) {
> +		driver_attach(&usb_drv->driver);
> +		put_driver(&usb_drv->driver);
> +	}

Here you don't have to refer to &usb_drv->driver; you can just refer to 
driver.

> +static int usb_create_newid_file(struct usb_driver *usb_drv)
> +{
> +	int error = 0;
> +
> +	if (usb_drv->probe != NULL)
> +		error = sysfs_create_file(&usb_drv->driver.kobj,
> +					  &driver_attr_new_id.attr);
> +	return error;
> +}

This deserves to be an inline function.

> +static void usb_free_dynids(struct usb_driver *usb_drv)
> +{
> +	struct usb_dynid *dynid, *n;
> +
> +	spin_lock(&usb_drv->dynids.lock);
> +	list_for_each_entry_safe(dynid, n, &usb_drv->dynids.list, node) {
> +		list_del(&dynid->node);
> +		kfree(dynid);
> +	}
> +	spin_unlock(&usb_drv->dynids.lock);
> +}

This could be inline as well, although being longer, its overhead is less 
noticeable.

Alan Stern

