Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUF1GxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUF1GxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 02:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUF1GxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 02:53:17 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:2688 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S264726AbUF1GxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 02:53:09 -0400
Date: Mon, 28 Jun 2004 08:52:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/19] New set of input patches
Message-ID: <20040628065259.GA1291@ucw.cz>
References: <200406280008.21465.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406280008.21465.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 12:08:21AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Here is the 2nd version of my set of input patches that mostly do serio sysfs
> integration. Among the changes - dropped psmouse KVM resync patch as it was
> bogus, added platform devices to those of serio providers that don't have
> proper parent device (i8042, q40kbd, etc).
> 
> 01-psmouse-state-locking.patch
>         - Acquire underlying serio lock when changing psmouse state to
>           prevent interrupt handler running on us

IMO drivers have no bussiness messing with the serio locks. We could use
'plug' and 'unplug' functions like the network driver use, or handle it
inside the driver, but taking the lock is the wrong thing to do.

> 02-serio-connect-mandatory.patch
>         - Make serio driviers connect/disconnect methods mandatory as these
>           methods open/close serio ports and link ports and drivers together.
>           Presently if a driver does not implement connect method it will not
>           be able to bind to a port anyway.

OK

> 03-serio-rename-1.patch
>         - Rename serio->driver to serio->port_data as with sysfs integration
>           driver is not the best name for arbitrary data

OK

> 04-serio-rename-2.patch
>         - Rename serio_dev to serio_driver as they are drivers in sysfs sense

OK

> 05-serio-dynamic-alloc.patch
>         - Switch from static to dynamic serio port allocation so serio ports
>           drivers can be freely unloaded even if not all references to ports
>           are dropped (sysfs req.)

OK

> 06-serio-no-recursion.patch
>         - Do not do recursive discovery of children ports, needed for sysfs
>           and generally better for stack usage.

Yes, this is very good.

> 07-serio-sysfs.patch
>         - sysfs integration. Register ports and drivers in driver model, link
>           them all together under /sys/bus/serio. Every driver has a default
>           attribute "descrip[tion" (from serio_driver->description); serio
>           ports have "decription", "driver" and "legacy_position".
>           Legacy_position porvides access to serio->phys to allow matching
>           with data in /proc/bus/input/devices

I'm not sure if we really need the 'legacy position' thing. We probably
should drop the 'phys' stuff some time after we transition to sysfs, and
exporting it through sysfs will make that harder.

> 08-serio-rebind.patch
>         - allow user to disconnect or rebind serio port by writing appropriate
>           data to it's sysfs attribute:
>               echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
>               echo -n "none" > /sys/bus/serio/devices/serio0/driver
>               echo -n "reconnect" > /sys/bus/serio/devices/serio0/driver
>               echo -n "rescan" > /sys/bus/serio/devices/serio0/driver

Very good idea.

> 09-serio-manual-bind.patch
>         - allow marking some drivers as requiring manual bind (to be used when
>           driver does not do automatic HW discovery)

OK

> 10-serio_raw.patch
>         - raw access to serio data ala 2.4 /dev/psaux

OK, finally those who insist on /dev/psaux can shut up

> (*) 11-platform-device-simple.patch
>         - Add platform_device_register_simple to register platform devices
>           requiring minimal resource and memory management. The release
>           function resides in driver core and that allows drivers registering
>           such devices be unloaded without waiting for the last reference to
>           be dropped.
> 	
> 12-i8042-to-platform-device.patch
>         - Convert i8042 to platform device instead of system device so
>           its ports have proper parent.

OK

> 13-serio-add-platform-devices.patch
> 	- Add platform devices to ct82c710, maceps2, q40kbd and rpckbd.

OK

> 14-serio-set-up-parents.patch
>         - Set up parent devices for serio ports in ambakmi, gscps2,
>           pcips2 and sa1111ps2.c

OK

> 15-synaptics-passthrough-handling.patch
>         - If data looks like a pass-through packet and tuchpad has
>           pass-through capability do not pass it to the main handler
>           if child port is disconnected.

I'll have to look closer on this one - I think we want to pass the data
to the serio layer even if there is no driver listening on the
passthrough serio.

> (*) 16-bus-default-drv-attrs.patch
>         - Add bus' default driver attributes (similar to defaulr device
>           attributes)
> 
> 17-serio-use-bus-default-attrs.patch
>         - Use bus' default driver and device attributes to manage serio
>           attributes 
> 
> (*) 18-add-driver-find.patch
>         - Add driver_find function, similar to device_find, to search for a
>           driver by its name.
> 
> 19-serio-use-driver-find.patch
>         - Use driver_find in serio_rebind_driver instead of implementing it
>           locally.

Very good.

> (*) These patches have also been sent to Greg KH.

Did he accept them already?

> This time I tried compiling the stuff using defconfing for SPACR64 and PPC64
> (thanks to Andrew for pointing to me availability of cross-compile
> tools), so I should be a bit better now... Alpha failed on cpumask.h...

Great! ;)

> The patches are against today's Linus tree + recent pull form Vojtech's tree
> + recent pull from Greg KH's tree. I have patches against 2.6.7 that will
> bring it to my version of the tree at:
> 
> 	http://www.geocities.com/dt_or/input/2_6_7/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
