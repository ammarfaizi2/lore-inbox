Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbUKEFDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbUKEFDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUKEFDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:03:13 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:42364 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262601AbUKEFDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:03:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Date: Fri, 5 Nov 2004 00:02:57 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Tejun Heo <tj@home-tj.org>,
       rusty@rustcorp.com.au, mochel@osdl.org
References: <20041104074330.GG25567@home-tj.org> <20041104175318.GH16389@kroah.com>
In-Reply-To: <20041104175318.GH16389@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411050002.57174.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 12:53 pm, Greg KH wrote:
> On Thu, Nov 04, 2004 at 04:43:30PM +0900, Tejun Heo wrote:
> >  Hello, again. :-)
> > 
> >  These are the manual device attach patches I was talking about in the
> > previous posting.  These patches need devparam patches to be applied
> > first.  It's composed of two parts.
> > 
> >  1. sysctl node dev.autoattach
> > 
> >  dev.autoattach is read/write integer sysctl node which controls
> > driver-model's behavior regarding device - driver association.
> 
> Ick, no new sysctls please.  Make this a per-bus attribute that gets
> written to in sysfs.  Much nicer and much finer control then.
>

I think that my bind)mode patches which allow to control binding through
sysfs on pre-device and per-driver base should suffice here. I really doubt
that anybody would want to keep autoattach disabled and do all matching
manually ;). Besides having per-driver attribute allows drivers authors
control binding.
 
> >  0: autoattach disabled.  devices are not associated with drivers
> >     automatically.  i.e. insmod'ing e100.ko won't cause it to attach to the
> >     actual e100 devices.
> >  1: autoattach enabled.  The default value.  This is the same as the
> >     current driver model behavior.  Driver model automatically associates
> >     devices to drivers.
> >  2: rescan command.  If this value is written, bus_rescan_devices() is
> >     invoked for all the registered bus types; thus attaching all
> >     devices to available drivers.  After rescan is complete, the
> >      autoattach value is set to 1.
> 
> Make this a different sysfs file.  "rescan" would be good.
> 
> Look at how pci can handle adding new devices to their drivers from
> sysfs.  If we can move that kind of functionality to the driver core, so
> that all busses get it (it will require a new per-bus callback though,
> se the other patches recently posted to lkml for an example of this),
> that would be what I would like to see happen.
> 
> >  2. per-device attach and detach sysfs node.
> > 
> >  Two files named attach and detach are created under each device's
> > sysfs directory.  Reading attach node shows the name of applicable
> > drivers.
>

Do we really need 2 or even 3 files ("attach", "detach" and "rescan")?
Given that you really can't (at least not yet) do all there operations
for all buses from the core that woudl require 3 per-bus callbacks.
I think reserving special values such as "none" or "detach" and "rescan"
shoudl work just fine and also willallow extending supported operations
on per-bus basis. For example serio bus supports "reconnect" option which
tries to re-initialize device if something happened to it. It does not
want to do rescan as that would generate new input devices while it is
much more convenient to re-use old ones. 
 
> How does a device know what drivers could be bound to it?  It's the
> other way around, drivers know what kind of devices they can bind to.

But when 2+ drivers can be bound to a device then particular _device_
gets to decide which driver is best suited for it, like in cases of
e100/eepro100 or psmouse/serio_raw.

> Let's add the ability to add more devices to a driver through sysfs,
> again, like PCI does.
>

Well, PCI does add a new ID to a driver allowing it to bind to a whole
new set of devices. I agree that this is a "driver" operation. 
 
> > Writing a driver name attaches the device to the driver.
> 
> No, do it the other way, attach a driver to a device.
>

I disagree. Here you working with particular device. You are not saying
"from now on I want e100 to bind all my 5 new network cards that happen
to have id XXXX:YYYY". Instead you are saying "I want to bind e100 driver
to this card residing at /sys/bus/pci/0000.....". In other word it is
operation on particular device and should be done by manipulating device
attribute.

-- 
Dmitry
