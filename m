Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318866AbSHLX1p>; Mon, 12 Aug 2002 19:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318868AbSHLX1p>; Mon, 12 Aug 2002 19:27:45 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:62897 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S318866AbSHLX1o>; Mon, 12 Aug 2002 19:27:44 -0400
Date: Mon, 12 Aug 2002 16:36:51 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] USB driver conversion to use "struct device_driver"
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D584693.1020000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020810001005.GA29490@kroah.com> <3D55832B.4040104@pacbell.net>
 <20020812164521.GA15249@kroah.com> <3D57FECE.3020700@pacbell.net>
 <20020812213020.GB16872@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  usb_set_configuration(struct usb_device *dev, int);
>>  usb_set_interface(struct usb_device *dev, int, int);
>>
>>  usb_find_interface_driver_for_ifnum(struct usb_device *dev, int);
>>
>>  usb_bind_driver(struct usb_driver *,struct usb_device *, int);
>>	// usb_unbind_driver takes interface handle already!!
>>
>>  usb_ifnum_to_ifpos(struct usb_device *dev, int);
>>  usb_ifnum_to_if(struct usb_device *dev, int);
>>	// basically, abolish the need for these calls
>>
>>  usb_epnum_to_ep_desc(struct usb_device *dev, int);
>>
>>Plus I'm strongly tempted to group all the "dev + pipe" calls
>>the same way ... better to just pass the endpoint descriptor
>>than to encode descriptor values as bitfields and then later
>>waste time (repeateadly) tearing apart those bitfields.
> 
> 
> Agreed, I'll look into fixing up the above functions, unless someone
> wants to send me a patch doing it first :)

Maybe when Linus' release is a bit closer to the USB tree I could help
with that.  Right now it's sufficiently divergent to make usb patches
against usbcore be rather helpful in general (though maybe not in that
particular case).  I'll certainly be glad to take a whack at that.


>>Related issue to the suspend/resume code ... I recently noticed
>>(again) that the hub code was disconnecting top-down rather than
>>bottom up.  That should eventually get delegated to the driver
>>framework ... any idea whether there was a reason not to do that
>>bottom-up in the first place?  At what point does the driver model
>>kick in to handle that part of what the hub driver now does?  If
>>the patch you sent around did that, my quick look missed it ... :)
> 
> 
> Hm, I didn't realize it was going top-down at all.  What changes caused
> that?  And no, I don't think I changed it, as I didn't realize it had
> been changed in the first place :)

I think it's just been that way for ages, no changes.  It's actually
usb_disconnect(), not the hub driver, that goes top down, disconnecting
children only _after_ the parent is disconnected.  (Might be nice to
flag all devices as "dead" before disconnecting in such cases, but we
don't have a way to flag devices as "dead" AFAIK.  That'd make it easy
to fail new urb submissions for now-gone devices.)

If the current changes don't automagically make disconnection work
according to the device tree, something needs to change to make that
work correctly.  But I'm not sure what it'd be; seems like the converse
of the probe() changes you started.

- Dave


