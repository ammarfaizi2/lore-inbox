Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSHJVJk>; Sat, 10 Aug 2002 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSHJVJk>; Sat, 10 Aug 2002 17:09:40 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:56198 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317331AbSHJVJj>; Sat, 10 Aug 2002 17:09:39 -0400
Date: Sat, 10 Aug 2002 14:18:35 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] USB driver conversion to use
 "struct device_driver"
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D55832B.4040104@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020810001005.GA29490@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good to start seeing "driver model" changes as well as just "driverfs"
changes ...


 > Also, the driverfs representation of the USB devices has changed,
 > possibly for the worse.  Just try the patch to see what I mean :)

Why are devices children of the hub _interface_ now?  Today they're
children of the hub device.  The hub spec requires only one interface
for all hub devices, so it's safe the way it is today.  With devices
as children of hubs devices, things look more familiar ... hubs act
like pci bridges (which they logically resemble).


 > +static int usb_device_bind (struct device *dev, struct device_driver *drv)

Minor rough spot, please rename to usb_device_match() since it's
the bus_type->match() callback.  Might even be nice to split out
some of the relevant code into "usb-device.c", mirroring what the
"pci-device.c" code does but with bus-specific differences.  There's
too much random code in "usb.c" still for my taste!  And all code
at this level is usbcore-internal anyway, shouldn't be mixed with
public driver APIs. :)


>  struct usb_driver {
>  	struct module *owner;
>  	const char *name;
> +
> +	int	(*new_probe)	(struct usb_interface *intf);
> +	int	(*init)		(struct usb_interface *intf);
> +	void	(*new_disco)	(struct usb_interface *intf);
> +
> +	struct device_driver driver;
>  
>  	void *(*probe)(
>  	    struct usb_device *dev,		/* the device */

I don't see why this isn't done as a transparent wrapper around
the existing probe()/disconnect() routines.  PCI did this without
any such major changes to the driver API, and I thought being able
to do that was a (good!) device model design goal.

If we want to change the API to refocus on interfaces, rather
than device plus whichever kind of identifying number is used in
the relevant context, I'd rather start by getting rid of the
APIs that have been problematic (device + number).  That'd be
nice for configurations and endpoints too, but I think most of
those calls involve interfaces.  Those changes would be a lot
less invasive so far as device drivers are concerned.


Also, the generic driver model calls are probe/disconnect,
suspend/resume, and release.  Today, USB has probe/disconnect
but not the others.  I'd expect to see suspend/resume in there
before a new init callback ... but I see the init routine is
unused, maybe that just snuck in by accident.

- Dave


