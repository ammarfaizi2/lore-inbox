Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVGBBsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVGBBsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 21:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGBBsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:48:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:47337 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261677AbVGBBsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:48:09 -0400
Date: Fri, 1 Jul 2005 15:31:14 -0700
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050701223114.GC2707@kroah.com>
References: <20050624051229.GA24621@kroah.com> <200506242322.57535.dtor_core@ameritech.net> <20050629234755.GA19599@kroah.com> <200506300113.54001.dtor_core@ameritech.net> <20050630160150.GB6828@kroah.com> <d120d500050630132025610e6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050630132025610e6a@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 03:20:10PM -0500, Dmitry Torokhov wrote:
> On 6/30/05, Greg KH <greg@kroah.com> wrote:
> > On Thu, Jun 30, 2005 at 01:13:53AM -0500, Dmitry Torokhov wrote:
> > > On Wednesday 29 June 2005 18:47, Greg KH wrote:
> > > > On Fri, Jun 24, 2005 at 11:22:57PM -0500, Dmitry Torokhov wrote:
> > > > > On Friday 24 June 2005 00:12, Greg KH wrote:
> > > > > > Even so, with these two patches, people should be able to do things that
> > > > > > they have been wanting to do for a while (like take over the what driver
> > > > > > to what device logic in userspace, as I know some distro installers
> > > > > > really want to do.)
> > > > > >
> > > > >
> > > > > I think bind/unbind should be bus's methods and attributes should be
> > > > > created only if bus supports such operations. Some buses either have
> > > > > or may need additional locking considerations and will not particularly
> > > > > like driver core getting in the middle of things.
> > > >
> > > > Examples of such?
> > >
> > > serio, gameport. Everything is protected by a semaphore, partly for
> > > historical reasons, partly because when adding children devices parent
> > > devices need to be locked too...
> > 
> > Why do parent devices need to be locked?  Reference counting in the
> > driver core should take care of everything properly, right?  Also, these
> 
> Children devices access hardware thtough their parent, which has to be
> functional at that time, otherwise if you initializing child device
> while parent is half gone you'll get bunch of errors reported. And
> again - historical reasons - when driver core did not allow adding
> children from parents probe routines serio core had to work around it
> and it required additional locking.

Ok, that locking can now be removed :)

> > are not hotpluggable devices, so it should be a lot easier :)
> 
> Some of them are and some are not. Hot-plugging an PS/2 mouse or
> keyboard usually works, although there are exceptions.

hot-plugging a ps/2 device is a short trip to a burnt out motherboard.
I've worked with the ps/2 specs long enough to know that :)

Anyway, you aren't discovering them on the fly, but I see how a rescan
would help you out here, right?

> > > > > Btw, do we really need separate attributes for bind/unbind?
> > > >
> > > > Overloading a single file would be messier.  The overhead for an
> > > > additional attribute per driver is quite small (I move the unbind
> > > > attribute to the driver, as it makes more sense there as Pat mentioned.)
> > > >
> > >
> > > Let me ask again - what if we need more operations similar to [un]bind,
> > > such as rescan?
> > 
> > "rescan"?  Like reprobe the bus address space?  That sounds like a bus
> > specific issue.  But if you like I could add a general bus callback for
> > that and an attribute for it.  I know pci could use that for some odd
> > cases (see the fakephp driver for an example of how to do rescan for pci
> > devices from a driver itself.)
> > 
> 
> No, it for entire bus space. Imagine you have a device that is marked
> as "bind_mode=manual" because normally you don't want to have it
> activated for some reason.

I don't like "modes" like that.  Just have the driver have no built in
ids, then use the addition of a dynamic id from userspace do the bind,
like pci.

> Later you want to activate it. Right now in serio you can do:
> 
>      echo -n "rescan" > /sys/bus/serio/devices/serioX/drvctl
> 
> and it will do the standard binding (match + probe) for that device
> only. It is different from bus-wide rescan operation. Maybe rescan is
> not the best name, but that what I have in serio for now.

Sure, for this I think it should be a bus specific thing.

> Reconnect is indeed bus-specific issue but it is very close to rescan.
> We already know the driver, we just want to reinitialize hardware, if
> possible. Helps to keep input devices the same when mouse goes crazy
> for some reason.

But rescan/reconnect is a bus thing.  The driver core never kicks this
off, nor should it.

> > > They do not use a specific driver but work for device.
> > 
> > Yes, and as such, rescan should be a bus attribute, not a driver or
> > device one.
> 
> See above, I want a per-device operation here. Bus-wide one could be
> also useful, but I was talking about per-device.

per-device scan doesn't make much sense for other busses, does it?

> > > If you keep bind/unbind in driver and rescan/reconnect/etc in device
> > > subdirectoty it will be rather messy. Please consider movin in the
> > > opposite directtion - have bind and unbind attributes of device, not
> > > driver.
> > 
> > No, I put bind/unbind in the driver directory.  There is no additions to
> > the device directory.
> > 
> 
> Could you give your rationale for putting it in driver?

The driver is the thing you want to have bound to a device.  Putting it
in every device directory would make the 20K scsi device people very
unhappy as I take up even more of their 31bit memory :)

> > > Also, what about rolling bind_mode attribute into driver core as well?
> > 
> > Um, I don't recall what you are referring to here.  Have a
> > pointer/patch?
> > 
> 
> No patch at the moment, there were quite few changes since I sent it
> to you last time. You could take a look in serio for the usage though.
> Basically both drivers and devices get a new attribute "bind_mode"
> (auto|manual). When bind mode is set to manual devices are bound to
> driver only when user explicitely says so. This allows having 2+
> drivers for the same hardware at the same time. The preferred one has
> bind_mode=auto, secondary has bind_mode=manual. Take for example
> serio_raw. We really want psmouse be loaded by default but if user
> needs raw access to a specific serio port he can manually bind
> serio_raw module to that port.

Ah, ok, now I remember.  I still think this is more complex than needed,
but don't have an alternative proposal right now :)

thanks,

greg k-h
