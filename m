Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSK0W3N>; Wed, 27 Nov 2002 17:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSK0W3N>; Wed, 27 Nov 2002 17:29:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:23947 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264877AbSK0W3M>; Wed, 27 Nov 2002 17:29:12 -0500
Date: Wed, 27 Nov 2002 14:40:36 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5 modutils getting back device table support
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Message-id: <3DE549E4.8080500@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200211272054.MAA07617@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> On November 26, 2002, David Brownell wrote:
> 

>>If you're really talking "strings", with arbitrary whitespace,
>>I rather like the idea of letting a bunch of key=value lines be
>>used as an ID. [...]
> 
> 
> 	That sounds sensible.  That decision would be up to invidual
> "bus types", but they'd probably mostly follow by example.  By the
> way, here are a few other features that I think might be desirable in
> choosing an ID format:

Actually the transformation of MODULE_DEVICE_TABLE entries
into strings has never been done in the kernel, it's been
part of "depmod".

Remember that the strings are needed outside the kernel, when
the module is _not_ yet loaded so it'd be pointless to expect
any "bus type" sysfs logic to help.  Where would the IDs appear?


> 	- Unless a match pattern ends in "$", pattern matching should
> 	  return success if the ID has trailing garbage.  That way
> 	  it will be easy to add additional detail to device ID's
> 	  later (for example, Jeff Garzik talks about adding a PCI
> 	  revision field).

Erm, which pattern matching are you referring to ... what the kernel
does?  I don't think the kernel should want a regex engine.  And the
kernel's current device table matching logic doesn't fit neatly into
any reasonable regex.  (These fields are meaningful only if that one
has this bit set, those are only meaningful if value != -1, etc).

Likewise I think _positional_ syntax is something to get rid of.
It's error prone (position off-by-one --> bug cascade), and in
fact the order of the id components should be irrelevant even for
pattern matching.  So adding new components (pci rev, usb rev,
whatever), in any order should never break the IDs.


>> >>> - No need for user level programs to query devices to generate
>> >>> hotplug information (goodbye pcimodules, usbmodules,
>> >>> isapnpmodules),
>> >
>> >>I think these can almost already go away now, with the info we have in
>> >>sysfs.
> 
> 
>>The latest (cvs) hotplug scripts won't try to any of use
>>those on 2.5 systems, it expects /sys/bus/$type/devices/*/*
>>to expose all the necessary information (for coldplug, and
>>for per-interface hotplug).
> 
> 
> 	USB /sys information appears to be only for the currently
> selected configuration, but we want to match drivers for all possible
> device configurations, even though most USB devices only define one.

It's meaningless to try binding a driver to any non-current device
config.  There's a patch pending (from Oliver Neukom) to fix up some
relatively gaping integrity holes in config management.

I do agree there should probably be a better way to access information
about alternate configurations (and interface settings) than reading
the information in "usbfs" ... but a good solution likely means moving
away from that default policy of "one value per file".


> Also, although the usb driverfs code is very clean, I'd still like to
> be able to configure out sysfs for systems that don't need it, and yet
> I might still want modules on those systems precisely because I want
> to mimize kernel memory footprint (by only loading certain drivers for
> users or situations that actually use them).

This correspond to the original usb hotplug design requirement
of "must be able to run without usbfs".  Met by having hotplug
events describe the device, and having device table entries (NOT
used just for module loading!) encode many kinds of patterns.

And running without "sysfs" will probably mean the same thing
that running without "usbfs" previously meant:  there's no way
to ensure that "coldplug" scenarios work right, since there must
be times during system bootstrap where not enough of the OS is
running (files, daemons, ...) to handle early hotplug events, and
they can't be regenerated (or played back) later.

- Dave





