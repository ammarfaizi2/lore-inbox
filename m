Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318768AbSHLSVf>; Mon, 12 Aug 2002 14:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318781AbSHLSVf>; Mon, 12 Aug 2002 14:21:35 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:63119 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S318768AbSHLSVd>; Mon, 12 Aug 2002 14:21:33 -0400
Date: Mon, 12 Aug 2002 11:30:38 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] USB driver conversion to use "struct device_driver"
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D57FECE.3020700@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020810001005.GA29490@kroah.com> <3D55832B.4040104@pacbell.net>
 <20020812164521.GA15249@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Why are devices children of the hub _interface_ now?  
> 
> Good point, I noticed that this had changed, but haven't fixed it, I'll
> make sure it goes back to the way it was before.

Thanks ... those paths were getting really atrocious!

The other thing I noticed about the tree structure was that
the /drivers/bus/usb/devices directory has symlinks to both
interfaces and devices.  That's good for completeness, but
the device links aren't very useful (and they really clutter
up that directory, IMO, with two different kinds of object).
Do they need to show up there?

We know "<interface>/.." always gives the USB device, so we
don't really need such additional entries.


>>>struct usb_driver {
>>>	struct module *owner;
>>>	const char *name;
>>>+
>>>+	int	(*new_probe)	(struct usb_interface *intf);
>>>+	int	(*init)		(struct usb_interface *intf);
>>>+	void	(*new_disco)	(struct usb_interface *intf);
>>>+
>>>+	struct device_driver driver;
>>>
>>>	void *(*probe)(
>>>	    struct usb_device *dev,		/* the device */
>>
>>I don't see why this isn't done as a transparent wrapper around
>>the existing probe()/disconnect() routines.  PCI did this without
>>any such major changes to the driver API, and I thought being able
>>to do that was a (good!) device model design goal.
> 
> 
> I think making the probe() and disconnect() functions match the driver
> model makes more sense now.  We have an easier time of fixing all of the
> USB drivers at once, compared to the PCI driver interface, which has
> _lots_ more drivers to convert.

Even so.  This particular change also happens to make the
usb_device_id->driver_data useless ... if the driver API
changes, I'd need to see the MODULE_DEVICE_TABLE entry,
or at least its driver_data, get passed too.  That's a
key level of bus-specific glue that the driver model
doesn't explicitly acknowledge (seemingly expects to be
handled transparently by the bus glue).

I guess I shouldn't be too sensitive about incompatible
changes to the USB driver API, but in this case it bothers
me a bit even though I do like the idea of making drivers
think "correctly" (interface drivers, not device drivers).

Oh, and "new_disco" ... I thought "Disco is Dead"? :)


>>If we want to change the API to refocus on interfaces, rather
>>than device plus whichever kind of identifying number is used in
>>the relevant context, I'd rather start by getting rid of the
>>APIs that have been problematic (device + number).  That'd be
>>nice for configurations and endpoints too, but I think most of
>>those calls involve interfaces.  Those changes would be a lot
>>less invasive so far as device drivers are concerned.
> 
> 
> What APIs would those be?

 From a quick scan of <linux/usb.h>, I see these calls ...
all of which would be less error prone if they just passed
the relevant descriptor.  (Errors happen when folk assume
both two kinds of integer ID are the same... and it's also
just confusing.)  The interface->dev backlink you added is
useful, and help get rid of the need for many of these:

   usb_set_configuration(struct usb_device *dev, int);
   usb_set_interface(struct usb_device *dev, int, int);

   usb_find_interface_driver_for_ifnum(struct usb_device *dev, int);

   usb_bind_driver(struct usb_driver *,struct usb_device *, int);
	// usb_unbind_driver takes interface handle already!!

   usb_ifnum_to_ifpos(struct usb_device *dev, int);
   usb_ifnum_to_if(struct usb_device *dev, int);
	// basically, abolish the need for these calls

   usb_epnum_to_ep_desc(struct usb_device *dev, int);

Plus I'm strongly tempted to group all the "dev + pipe" calls
the same way ... better to just pass the endpoint descriptor
than to encode descriptor values as bitfields and then later
waste time (repeateadly) tearing apart those bitfields.


>>Also, the generic driver model calls are probe/disconnect,
>>suspend/resume, and release.  Today, USB has probe/disconnect
>>but not the others.  I'd expect to see suspend/resume in there
>>before a new init callback ... but I see the init routine is
>>unused, maybe that just snuck in by accident.
> 
> 
> Yes, the other callbacks will get added, and init() was added as part of
> the old original patch, I'll remove it.

I though that was what was going on!

Related issue to the suspend/resume code ... I recently noticed
(again) that the hub code was disconnecting top-down rather than
bottom up.  That should eventually get delegated to the driver
framework ... any idea whether there was a reason not to do that
bottom-up in the first place?  At what point does the driver model
kick in to handle that part of what the hub driver now does?  If
the patch you sent around did that, my quick look missed it ... :)

- Dave


> thanks for the comments,
> 
> greg k-h
> 



