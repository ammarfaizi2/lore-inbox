Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSK0Utj>; Wed, 27 Nov 2002 15:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264806AbSK0Uti>; Wed, 27 Nov 2002 15:49:38 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:38022 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264799AbSK0UtF>; Wed, 27 Nov 2002 15:49:05 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 12:54:00 -0800
Message-Id: <200211272054.MAA07617@baldur.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: [PATCH] Module alias and table support
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 26, 2002, David Brownell wrote:

>  >>> If we're going to use strings for device ID matching,
>  >>> then we can consolidate all of the xxx_device_id types into one:

>This is going to end up rewriting every MODULE_DEVICE_TABLE in the
>kernel, as well as hotplug and that depmod functionality, before
>hotplugging handles module loading again, isn't it? Somehow I'd
>rather not see us change so many things while we're "stabilizing".
[...]

	I already explained that this can be done by automated means,
(and it appears that Rusty Russell has already written much of the code
to do it):

| Initially, I would run a
| hacked version of depmod to output appropriate string-based device_id
| table declarations and append them to the corresponding .c files [...]


>If you're really talking "strings", with arbitrary whitespace,
>I rather like the idea of letting a bunch of key=value lines be
>used as an ID. [...]

	That sounds sensible.  That decision would be up to invidual
"bus types", but they'd probably mostly follow by example.  By the
way, here are a few other features that I think might be desirable in
choosing an ID format:

	- Unless a match pattern ends in "$", pattern matching should
	  return success if the ID has trailing garbage.  That way
	  it will be easy to add additional detail to device ID's
	  later (for example, Jeff Garzik talks about adding a PCI
	  revision field).

	- Maybe use your approach, or maybe avoid use of whitespace
	  and other characters with special meanings to the shell.
	  The question of what format is most "shell friendly" depends
	  on what shell script people have in mind to write for it.
	  For instance, without special characters, shell "case"
	  statements can correspond exactly to kernel pattern match text.
	  Examples of potential "real" uses would be appreciated.

	- Where this is easily achievable, use a format small enough
	  so that the ID string can be allocated in the kernel stack
	  to eliminate an error branch.

	- Prefer fixed-width hexadecimal, octal or binary numbers
	  to facilitate "bitmask" selections and because fixed-width
	  matching uses less stack space (and infintesmally less CPU).
	  "*" causes recursion in the match function, so use it
	  sparingly.

	- For hexademical, use capitalization opposite that of any text
	  buit into the ID string to reduce the chance of accidentally
	  writing a pattern that has an unanticipated incorrect match.

	- For devices that return an ASCII string (for example, ieee-1284
	  parallel port devices) maybe just use that.



>  >>> - No need for user level programs to query devices to generate
>  >>> hotplug information (goodbye pcimodules, usbmodules,
>  >>> isapnpmodules),
>  >
>  >>I think these can almost already go away now, with the info we have in
>  >>sysfs.

>The latest (cvs) hotplug scripts won't try to any of use
>those on 2.5 systems, it expects /sys/bus/$type/devices/*/*
>to expose all the necessary information (for coldplug, and
>for per-interface hotplug).

	USB /sys information appears to be only for the currently
selected configuration, but we want to match drivers for all possible
device configurations, even though most USB devices only define one.
Also, although the usb driverfs code is very clean, I'd still like to
be able to configure out sysfs for systems that don't need it, and yet
I might still want modules on those systems precisely because I want
to mimize kernel memory footprint (by only loading certain drivers for
users or situations that actually use them).


>  > static int try_every_driver_and_modprobe(struct device *dev, const char *id,
>  > 	    				  void *arg)
>  > {
>  > 	...
>  > 		request_module(id); /* or call hotplug or whatever */
>  > 	}
>  > 	BUG();	/* NOTREACHED */
>  > 	return -1;
>  > }

>Why a BUG?

	Because that line should never be reached.  However,
here is a cleaner (also untested) version of that routine:

static int try_every_driver_and_modprobe(struct device *dev, const char *id,
                                          void *arg)
{
        int try = 0;
        do {
                list_for_each(entry,&bus->drivers) {
                        struct device_driver * drv =
                                container_of(entry,struct device_driver,bus_list);
                        int result = try_this_driver(dev, id, drv);

                        if (result)
                                return result;
                }
	} while (try++ != 0 && request_module(id) == 0);
	return result;
}


>Hotplug is about more than just loading modules, and I'm not sure
>that "try every driver and hotplug" would make sense.

	The only activity being "tried" on each device is matching the
ID.  The probe function is only called if the ID matches.  The existing
code already works this way (with struct pci_device_id, usb_device_id,
etc.).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."




