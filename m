Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318833AbSHLVaU>; Mon, 12 Aug 2002 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318839AbSHLVaU>; Mon, 12 Aug 2002 17:30:20 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:32783 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318833AbSHLVaT>;
	Mon, 12 Aug 2002 17:30:19 -0400
Date: Mon, 12 Aug 2002 14:30:21 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] USB driver conversion to use "struct device_driver"
Message-ID: <20020812213020.GB16872@kroah.com>
References: <20020810001005.GA29490@kroah.com> <3D55832B.4040104@pacbell.net> <20020812164521.GA15249@kroah.com> <3D57FECE.3020700@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D57FECE.3020700@pacbell.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 20:19:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 11:30:38AM -0700, David Brownell wrote:
> >>Why are devices children of the hub _interface_ now?  
> >
> >Good point, I noticed that this had changed, but haven't fixed it, I'll
> >make sure it goes back to the way it was before.
> 
> Thanks ... those paths were getting really atrocious!
> 
> The other thing I noticed about the tree structure was that
> the /drivers/bus/usb/devices directory has symlinks to both
> interfaces and devices.  That's good for completeness, but
> the device links aren't very useful (and they really clutter
> up that directory, IMO, with two different kinds of object).
> Do they need to show up there?
> 
> We know "<interface>/.." always gives the USB device, so we
> don't really need such additional entries.

Yeah, it is a bit ugly, and the whole symlink thing is going to be
revisited.  So for now I'm ignoring them, and hopefully Pat will decide
on something later on :)

> Even so.  This particular change also happens to make the
> usb_device_id->driver_data useless ... if the driver API
> changes, I'd need to see the MODULE_DEVICE_TABLE entry,
> or at least its driver_data, get passed too.  That's a
> key level of bus-specific glue that the driver model
> doesn't explicitly acknowledge (seemingly expects to be
> handled transparently by the bus glue).

Ugh, forgot about ->driver_info.  Ok, I'll go work on that, pci gets
around it by duplicating the "old" probe() interface.  I don't want to
throw away that info, as it is useful for some drivers.

> I guess I shouldn't be too sensitive about incompatible
> changes to the USB driver API, but in this case it bothers
> me a bit even though I do like the idea of making drivers
> think "correctly" (interface drivers, not device drivers).
> 
> Oh, and "new_disco" ... I thought "Disco is Dead"? :)

"new_disco" will be dead, once all the drivers are converted :)

> >What APIs would those be?
> 
> From a quick scan of <linux/usb.h>, I see these calls ...
> all of which would be less error prone if they just passed
> the relevant descriptor.  (Errors happen when folk assume
> both two kinds of integer ID are the same... and it's also
> just confusing.)  The interface->dev backlink you added is
> useful, and help get rid of the need for many of these:
> 
>   usb_set_configuration(struct usb_device *dev, int);
>   usb_set_interface(struct usb_device *dev, int, int);
> 
>   usb_find_interface_driver_for_ifnum(struct usb_device *dev, int);
> 
>   usb_bind_driver(struct usb_driver *,struct usb_device *, int);
> 	// usb_unbind_driver takes interface handle already!!
> 
>   usb_ifnum_to_ifpos(struct usb_device *dev, int);
>   usb_ifnum_to_if(struct usb_device *dev, int);
> 	// basically, abolish the need for these calls
> 
>   usb_epnum_to_ep_desc(struct usb_device *dev, int);
> 
> Plus I'm strongly tempted to group all the "dev + pipe" calls
> the same way ... better to just pass the endpoint descriptor
> than to encode descriptor values as bitfields and then later
> waste time (repeateadly) tearing apart those bitfields.

Agreed, I'll look into fixing up the above functions, unless someone
wants to send me a patch doing it first :)

> Related issue to the suspend/resume code ... I recently noticed
> (again) that the hub code was disconnecting top-down rather than
> bottom up.  That should eventually get delegated to the driver
> framework ... any idea whether there was a reason not to do that
> bottom-up in the first place?  At what point does the driver model
> kick in to handle that part of what the hub driver now does?  If
> the patch you sent around did that, my quick look missed it ... :)

Hm, I didn't realize it was going top-down at all.  What changes caused
that?  And no, I don't think I changed it, as I didn't realize it had
been changed in the first place :)

thanks,

greg k-h
