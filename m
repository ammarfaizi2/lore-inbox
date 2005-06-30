Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVF3UZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVF3UZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVF3UZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:25:32 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:15125 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262987AbVF3UUQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:20:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E6mrJ3rLEyIJvV//a+4zBZTaQOzA9ROBKBCel6Ce6gftZBD4WuNGbEwgHOQHqWslZdo80Tq0t7z6UNnrow5IlRgam9vMLViP8O2BC7bukZj6Zq6Y6uouq0oh4WBjOMo7cytkVJtpus47tR3ztJ/2zDVvmj2iXwmAPFpP7WZk78A=
Message-ID: <d120d500050630132025610e6a@mail.gmail.com>
Date: Thu, 30 Jun 2005 15:20:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20050630160150.GB6828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050624051229.GA24621@kroah.com>
	 <200506242322.57535.dtor_core@ameritech.net>
	 <20050629234755.GA19599@kroah.com>
	 <200506300113.54001.dtor_core@ameritech.net>
	 <20050630160150.GB6828@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Jun 30, 2005 at 01:13:53AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 29 June 2005 18:47, Greg KH wrote:
> > > On Fri, Jun 24, 2005 at 11:22:57PM -0500, Dmitry Torokhov wrote:
> > > > On Friday 24 June 2005 00:12, Greg KH wrote:
> > > > > Even so, with these two patches, people should be able to do things that
> > > > > they have been wanting to do for a while (like take over the what driver
> > > > > to what device logic in userspace, as I know some distro installers
> > > > > really want to do.)
> > > > >
> > > >
> > > > I think bind/unbind should be bus's methods and attributes should be
> > > > created only if bus supports such operations. Some buses either have
> > > > or may need additional locking considerations and will not particularly
> > > > like driver core getting in the middle of things.
> > >
> > > Examples of such?
> >
> > serio, gameport. Everything is protected by a semaphore, partly for
> > historical reasons, partly because when adding children devices parent
> > devices need to be locked too...
> 
> Why do parent devices need to be locked?  Reference counting in the
> driver core should take care of everything properly, right?  Also, these

Children devices access hardware thtough their parent, which has to be
functional at that time, otherwise if you initializing child device
while parent is half gone you'll get bunch of errors reported. And
again - historical reasons - when driver core did not allow adding
children from parents probe routines serio core had to work around it
and it required additional locking.

> are not hotpluggable devices, so it should be a lot easier :)

Some of them are and some are not. Hot-plugging an PS/2 mouse or
keyboard usually works, although there are exceptions.

> 
> > > Yes, a bus that isn't really expecting this to
> > > happen, as it has some odd locking logic in the
> > > registering/unregistering of a new driver for it, might have issues.
> > > But I'd say that this is the bus's fault, not the driver core's fault.
> > >
> >
> > I don't think so. Up to now all driver core iteractions were under
> > individual bus code control. Now out of sudden you allow disconnecting
> > device from its driver from outside of bus control and you are saying
> > that's all right. Driver core is a framework; buses use driver core to
> > simplify their tasks but driver core does not really control their
> > operations.
> 
> Well, yes and no.  I see the driver core driving a lot of interactions,
> due to the probing and matching and disconnecting all coming from the
> core, but I guess as they are usually initiated from the bus itself, I
> can see how you feel this way also.  So ok, yes, this is a change, I
> agree.  But it isn't one that should cause major issues.
> 

It is fixable and I meant to cange it, but not ATM and I hate leaving
the code with bad locking in kernel proper ;(

> > > > Btw, do we really need separate attributes for bind/unbind?
> > >
> > > Overloading a single file would be messier.  The overhead for an
> > > additional attribute per driver is quite small (I move the unbind
> > > attribute to the driver, as it makes more sense there as Pat mentioned.)
> > >
> >
> > Let me ask again - what if we need more operations similar to [un]bind,
> > such as rescan?
> 
> "rescan"?  Like reprobe the bus address space?  That sounds like a bus
> specific issue.  But if you like I could add a general bus callback for
> that and an attribute for it.  I know pci could use that for some odd
> cases (see the fakephp driver for an example of how to do rescan for pci
> devices from a driver itself.)
> 

No, it for entire bus space. Imagine you have a device that is marked
as "bind_mode=manual" because normally you don't want to have it
activated for some reason. Later you want to activate it. Right now in
serio you can do:

     echo -n "rescan" > /sys/bus/serio/devices/serioX/drvctl

and it will do the standard binding (match + probe) for that device
only. It is different from bus-wide rescan operation. Maybe rescan is
not the best name, but that what I have in serio for now.

Reconnect is indeed bus-specific issue but it is very close to rescan.
We already know the driver, we just want to reinitialize hardware, if
possible. Helps to keep input devices the same when mouse goes crazy
for some reason.

> > They do not use a specific driver but work for device.
> 
> Yes, and as such, rescan should be a bus attribute, not a driver or
> device one.
>

See above, I want a per-device operation here. Bus-wide one could be
also useful, but I was talking about per-device.
 
> > If you keep bind/unbind in driver and rescan/reconnect/etc in device
> > subdirectoty it will be rather messy. Please consider movin in the
> > opposite directtion - have bind and unbind attributes of device, not
> > driver.
> 
> No, I put bind/unbind in the driver directory.  There is no additions to
> the device directory.
> 

Could you give your rationale for putting it in driver?

> > Also, what about rolling bind_mode attribute into driver core as well?
> 
> Um, I don't recall what you are referring to here.  Have a
> pointer/patch?
> 

No patch at the moment, there were quite few changes since I sent it
to you last time. You could take a look in serio for the usage though.
Basically both drivers and devices get a new attribute "bind_mode"
(auto|manual). When bind mode is set to manual devices are bound to
driver only when user explicitely says so. This allows having 2+
drivers for the same hardware at the same time. The preferred one has
bind_mode=auto, secondary has bind_mode=manual. Take for example
serio_raw. We really want psmouse be loaded by default but if user
needs raw access to a specific serio port he can manually bind
serio_raw module to that port.

-- 
Dmitry
