Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSHLQpT>; Mon, 12 Aug 2002 12:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSHLQpT>; Mon, 12 Aug 2002 12:45:19 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:55566 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318743AbSHLQpS>;
	Mon, 12 Aug 2002 12:45:18 -0400
Date: Mon, 12 Aug 2002 09:45:21 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] USB driver conversion to use "struct device_driver"
Message-ID: <20020812164521.GA15249@kroah.com>
References: <20020810001005.GA29490@kroah.com> <3D55832B.4040104@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D55832B.4040104@pacbell.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 14:49:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 02:18:35PM -0700, David Brownell wrote:
> Why are devices children of the hub _interface_ now?  Today they're
> children of the hub device.  The hub spec requires only one interface
> for all hub devices, so it's safe the way it is today.  With devices
> as children of hubs devices, things look more familiar ... hubs act
> like pci bridges (which they logically resemble).

Good point, I noticed that this had changed, but haven't fixed it, I'll
make sure it goes back to the way it was before.

> Minor rough spot, please rename to usb_device_match() since it's
> the bus_type->match() callback.  Might even be nice to split out
> some of the relevant code into "usb-device.c", mirroring what the
> "pci-device.c" code does but with bus-specific differences.  There's
> too much random code in "usb.c" still for my taste!  And all code
> at this level is usbcore-internal anyway, shouldn't be mixed with
> public driver APIs. :)

The name will be changed, it's a hold over from when the driver model
function was called "bind".  And that's a good idea for a new file.

> > struct usb_driver {
> > 	struct module *owner;
> > 	const char *name;
> >+
> >+	int	(*new_probe)	(struct usb_interface *intf);
> >+	int	(*init)		(struct usb_interface *intf);
> >+	void	(*new_disco)	(struct usb_interface *intf);
> >+
> >+	struct device_driver driver;
> > 
> > 	void *(*probe)(
> > 	    struct usb_device *dev,		/* the device */
> 
> I don't see why this isn't done as a transparent wrapper around
> the existing probe()/disconnect() routines.  PCI did this without
> any such major changes to the driver API, and I thought being able
> to do that was a (good!) device model design goal.

I think making the probe() and disconnect() functions match the driver
model makes more sense now.  We have an easier time of fixing all of the
USB drivers at once, compared to the PCI driver interface, which has
_lots_ more drivers to convert.

> If we want to change the API to refocus on interfaces, rather
> than device plus whichever kind of identifying number is used in
> the relevant context, I'd rather start by getting rid of the
> APIs that have been problematic (device + number).  That'd be
> nice for configurations and endpoints too, but I think most of
> those calls involve interfaces.  Those changes would be a lot
> less invasive so far as device drivers are concerned.

What APIs would those be?

> Also, the generic driver model calls are probe/disconnect,
> suspend/resume, and release.  Today, USB has probe/disconnect
> but not the others.  I'd expect to see suspend/resume in there
> before a new init callback ... but I see the init routine is
> unused, maybe that just snuck in by accident.

Yes, the other callbacks will get added, and init() was added as part of
the old original patch, I'll remove it.

thanks for the comments,

greg k-h
