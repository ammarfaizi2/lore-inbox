Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVGBE0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVGBE0C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 00:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVGBE0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 00:26:02 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:30828 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261782AbVGBEZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 00:25:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Date: Fri, 1 Jul 2005 23:25:30 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
References: <20050624051229.GA24621@kroah.com> <d120d500050630132025610e6a@mail.gmail.com> <20050701223114.GC2707@kroah.com>
In-Reply-To: <20050701223114.GC2707@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507012325.30628.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 July 2005 17:31, Greg KH wrote:
> On Thu, Jun 30, 2005 at 03:20:10PM -0500, Dmitry Torokhov wrote:
> > 
> > Children devices access hardware thtough their parent, which has to be
> > functional at that time, otherwise if you initializing child device
> > while parent is half gone you'll get bunch of errors reported. And
> > again - historical reasons - when driver core did not allow adding
> > children from parents probe routines serio core had to work around it
> > and it required additional locking.
> 
> Ok, that locking can now be removed :)
> 

Yes and it is great. I just need some time to do it.

> > > are not hotpluggable devices, so it should be a lot easier :)
> > 
> > Some of them are and some are not. Hot-plugging an PS/2 mouse or
> > keyboard usually works, although there are exceptions.
> 
> hot-plugging a ps/2 device is a short trip to a burnt out motherboard.
> I've worked with the ps/2 specs long enough to know that :)
> 

I am afraid this is somewhat old data. As far as I know modern PS/2 ports
allow hot-plugging just fine. Especially notebooks. Ask Vojtech.

> Anyway, you aren't discovering them on the fly, but I see how a rescan
> would help you out here, right?
>

It really depends. Normally, when a new PS/2 device is plugged we get
something in the port and this will internally (bus) schedule rescan,
which will detect the kindof device plugged and will load proper driver.
 
> > > > > > Btw, do we really need separate attributes for bind/unbind?
> > > > >
> > > > > Overloading a single file would be messier.  The overhead for an
> > > > > additional attribute per driver is quite small (I move the unbind
> > > > > attribute to the driver, as it makes more sense there as Pat mentioned.)
> > > > >
> > > >
> > > > Let me ask again - what if we need more operations similar to [un]bind,
> > > > such as rescan?
> > > 
> > > "rescan"?  Like reprobe the bus address space?  That sounds like a bus
> > > specific issue.  But if you like I could add a general bus callback for
> > > that and an attribute for it.  I know pci could use that for some odd
> > > cases (see the fakephp driver for an example of how to do rescan for pci
> > > devices from a driver itself.)
> > > 
> > 
> > No, it for entire bus space. Imagine you have a device that is marked
> > as "bind_mode=manual" because normally you don't want to have it
> > activated for some reason.
> 
> I don't like "modes" like that.  Just have the driver have no built in
> ids, then use the addition of a dynamic id from userspace do the bind,
> like pci.
>

This is a bit different. One can say that adding new device ID is similar
to overclocking - it may work but all bets are off. In bind mode case
driver explicitely specifies set of devices it supposed to support, the
only difference is that it is considered "secondary" and will require
user intervention to bind. But the driver's author "certified" that the
driver should work with given hardware. 

> > Later you want to activate it. Right now in serio you can do:
> > 
> >      echo -n "rescan" > /sys/bus/serio/devices/serioX/drvctl
> > 
> > and it will do the standard binding (match + probe) for that device
> > only. It is different from bus-wide rescan operation. Maybe rescan is
> > not the best name, but that what I have in serio for now.
> 
> Sure, for this I think it should be a bus specific thing.
> 
> > Reconnect is indeed bus-specific issue but it is very close to rescan.
> > We already know the driver, we just want to reinitialize hardware, if
> > possible. Helps to keep input devices the same when mouse goes crazy
> > for some reason.
> 
> But rescan/reconnect is a bus thing.  The driver core never kicks this
> off, nor should it.
> 

Driver core never kicks off anything. Everything either originates from
a bus or userspace. Bind/unbind is not initiated by driver core itself
either - you have a user requesting it (or driver/device become available
during bus initialization). The same with rescan (when initiated by user).

> > > > They do not use a specific driver but work for device.
> > > 
> > > Yes, and as such, rescan should be a bus attribute, not a driver or
> > > device one.
> > 
> > See above, I want a per-device operation here. Bus-wide one could be
> > also useful, but I was talking about per-device.
> 
> per-device scan doesn't make much sense for other busses, does it?
>

I am not sure. I guess if you also have bind_mode it might and it looks
like not only I want something like bind_mode.
 
> > > > If you keep bind/unbind in driver and rescan/reconnect/etc in device
> > > > subdirectoty it will be rather messy. Please consider movin in the
> > > > opposite directtion - have bind and unbind attributes of device, not
> > > > driver.
> > > 
> > > No, I put bind/unbind in the driver directory.  There is no additions to
> > > the device directory.
> > > 
> > 
> > Could you give your rationale for putting it in driver?
> 
> The driver is the thing you want to have bound to a device.

You can argue it both ways (I like the view whan device is an object you
perform some operation on and therefore action attributes are better suited
in devices directtory).

> Putting it 
> in every device directory would make the 20K scsi device people very
> unhappy as I take up even more of their 31bit memory :)
> 

I see. That would be an argument for folding all such operationsinto one
attribute with bus-specific multiplexor. But really, 20K scsi people are
probably better off without sysfs (they should still have hotplug events
as far as I can see so hotplug/usev should still work).

Just to reiterate - by beef is that if you put [un]bind into separate
directory similar operations will be split across 2 subdirectories. 

> > > > Also, what about rolling bind_mode attribute into driver core as well?
> > > 
> > > Um, I don't recall what you are referring to here.  Have a
> > > pointer/patch?
> > > 
> > 
> > No patch at the moment, there were quite few changes since I sent it
> > to you last time. You could take a look in serio for the usage though.
> > Basically both drivers and devices get a new attribute "bind_mode"
> > (auto|manual). When bind mode is set to manual devices are bound to
> > driver only when user explicitely says so. This allows having 2+
> > drivers for the same hardware at the same time. The preferred one has
> > bind_mode=auto, secondary has bind_mode=manual. Take for example
> > serio_raw. We really want psmouse be loaded by default but if user
> > needs raw access to a specific serio port he can manually bind
> > serio_raw module to that port.
> 
> Ah, ok, now I remember.  I still think this is more complex than needed,
> but don't have an alternative proposal right now :)

I think it is simplier and safer than adding a new device ID to a driver.
Plus, one might not want to bind that driver to all available devices -
imagine I have a MUX controller (4 AUX ports) and I have standard PS/2
mouse bound to serio1 and a special device I want to have raw access to
on seio4. All 4 serio ports have the same ID, so if I simply add this ID
to serio_raw it has a chance to bind to all 4 ports. With bind mode I
don't need to worry that it will "steal" port it I did not want it to
touch. 

-- 
Dmitry
