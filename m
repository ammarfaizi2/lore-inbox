Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUJGWB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUJGWB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUJGWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:00:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:18876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268080AbUJGV6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:58:17 -0400
Date: Thu, 7 Oct 2004 14:40:04 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: Driver core change request
Message-ID: <20041007214004.GA23570@kroah.com>
References: <200410062354.18885.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410062354.18885.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 11:54:18PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> I am reworking my sysfs serio patches (trying to get dynamic psmouse
> protocol switching) and I am wondering if we could export device_attach
> function. Serio system allows user to request device rescan - force current
> driver to let go off the device and find another suitable driver. Also user
> can manually request device to be disconnected/connected to a driver. By
> having device_attach exported I could get rid of some duplicated code.

driver_attach() is global, so I don't have a problem with making
device_attach() global either.  Just send me a patch :)

> Also serio allows user to request a specific driver to be bound to a device
> in case there are several options (psmouse/serio_raw for example). To do
> that and not poke in the driver core guts too much I need something like the
> following:
> 
> int driver_probe_device(struct device_driver *dev, struct device *dev)
> {
>         int error;
>         
> 	dev->driver = drv;
>         if (drv->probe) {
>         	if ((error = drv->probe(dev))) {
>                 	dev->driver = NULL;
>                         return error;
>                 }
> 	}
>         device_bind_driver(dev);
>         return 0;
> }
> 
> 
> static int bus_match(struct device * dev, struct device_driver * drv)
> {
>         if (dev->bus->match(dev, drv))
> 		return driver_probe_device(drv, dev);
> 
>         return -ENODEV;
> }
> 
> I.e driver_probe_device is exported. Does it have a chance to be accepted?

What's wrong with doing what the pci core does in this situation and
call driver_attach()?

thanks,

greg k-h
