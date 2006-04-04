Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWDDVBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWDDVBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWDDVBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:01:39 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:16070
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750869AbWDDVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:01:37 -0400
Date: Tue, 4 Apr 2006 14:00:48 -0700
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Message-ID: <20060404210048.GA5694@suse.de>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 04:23:43PM -0400, Dmitry Torokhov wrote:
> On 4/4/06, gregkh@suse.de <gregkh@suse.de> wrote:
> >
> > --- gregkh-2.6.orig/drivers/base/bus.c
> > +++ gregkh-2.6/drivers/base/bus.c
> > @@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
> >
> >        if (bus) {
> >                pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> > -               device_attach(dev);
> > +               error = device_attach(dev);
> > +               if (error < 0)
> > +                       goto exit;
> 
> I do not believe that this is correct. The fact that _some_ driver
> failed to attach to a device does not necessarily mean that device
> itself does not exist. While this assuption might work for platform
> devices it won't work for other busses.

Hm, no, I unwound this mess, and found the following:

 - bus_add_device() calls device_attach()
 - device_attach() calls bus_for_each_drv() for every driver on the bus
 - bus_for_each_drv() walks all drivers on the bus and calls
   __device_attach() for every individual driver
 - __device_attach() calls driver_probe_device() for that driver and device
 - driver_probe_device() calls down to the probe() function for the
   driver, passing it that driver, if match() for the bus matches this
   device.
 - if that probe() function returns -ENODEV or -ENXIO[1] then the error
   is ignored and 0 is returned, causing the loop to continue to try
   more drivers
 - if the probe() function returns any other error code, it is
   propagated up, all the way back to bus_add_device.
 - if the probe() function returns 0, the device is bound to the driver,
   and it returns 0.  Hm, looks like we continue to loop here too, we
   could probably stop now that we have bound a driver to the device.

So, I'm pretty sure that this is safe and should work just fine.  To be
sure, let me go reboot my box with this change on it after I finish this
email :)

Does that help?

thanks,

greg k-h

[1] - stupid agp drivers (or some other video drivers) require this.  I
    need to go fix them up so they don't do this, if they haven't been
    fixed already...
