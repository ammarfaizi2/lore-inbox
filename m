Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSK0Xvw>; Wed, 27 Nov 2002 18:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSK0Xvw>; Wed, 27 Nov 2002 18:51:52 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:3209 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264946AbSK0Xvs>; Wed, 27 Nov 2002 18:51:48 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 15:56:34 -0800
Message-Id: <200211272356.PAA07796@baldur.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: 2.5 modutils getting back device table support
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 27 2002, David Brownell wrote:
>Adam J. Richter wrote:
>> On November 26, 2002, David Brownell wrote:
>> 

>>>If you're really talking "strings", with arbitrary whitespace,
>>>I rather like the idea of letting a bunch of key=value lines be
>>>used as an ID. [...]
>> 
>> 
>> 	That sounds sensible.  That decision would be up to invidual
>> "bus types", but they'd probably mostly follow by example.  By the
>> way, here are a few other features that I think might be desirable in
>> choosing an ID format:

>Actually the transformation of MODULE_DEVICE_TABLE entries
>into strings has never been done in the kernel, it's been
>part of "depmod".

	That's the point of this change.


>Remember that the strings are needed outside the kernel, when
>the module is _not_ yet loaded so it'd be pointless to expect
>any "bus type" sysfs logic to help.  Where would the IDs appear?

	The ID would be the argument to modprobe (or
"hotplug pci want ...").  I showed where the strings would
be generated in the kernel in my previous posting at
http://marc.theaimsgroup.com/?l=linux-kernel&m=103828651528556&w=2

| /* In drivers/pci/pci-driver.c: */
| 
| void pci_for_each_id(struct device *dev, dev_id_callback_t callback,
|                       void *arg)
| {
|         struct pci_dev *pcidev = to_pci_dev(dev);
|         char id[100];
| 
|         sprintf(id, "pci-vendor=%04x-prod=%04x-...", pcidev->vendor,
|                 pcidev->product, ...);
|         return (*callback)(dev, id, arg);
| }


>> 	- Unless a match pattern ends in "$", pattern matching should
>> 	  return success if the ID has trailing garbage.  That way
>> 	  it will be easy to add additional detail to device ID's
>> 	  later (for example, Jeff Garzik talks about adding a PCI
>> 	  revision field).

>Erm, which pattern matching are you referring to ... what the kernel
>does?

	Yes.

>I don't think the kernel should want a regex engine.

	Not regex, just globbing ("*", "?", maybe "[0-9]").  It
will be shorter than the set of bus-specific match functions that
it replaces.  It might look something like this:

int match(char *pat, char *str)
{
	while (*pat != '*') {
		switch (*pat) {
			case '\0':
				return 1;	/* Trailing garbage OK */

			case '?':
				if (*str == '\0')
					return 0;
				goto char_matched;

			case '$':
				if (pat[1] == '\0')
					return *str == '\0';
				break;

			case '\\':
				pat++;  /* Yes, you can quote ascii 0. */
				break;

			default:
				break;
		}
		if (*pat != *str)
			return 0;
	char_matched:
		pat++;
		str++;
	}

	/* *pat == '*' */

	pat++;

	for (;;) {
		if (match(pat, str))
			return 1;
		if (*str == '\0')
			break;
		str++;
	}
	return 0;
}


>And the
>kernel's current device table matching logic doesn't fit neatly into
>any reasonable regex.  (These fields are meaningful only if that one
>has this bit set, those are only meaningful if value != -1, etc).

	Show me what you think is an example and I'll show you
how it would work with glob matching (no need for full blown
regular expressions).  You might want to take a look at Rusty's
converter, especially his "ADD" macro.  Here is the URL.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103723352317709&w=2


>Likewise I think _positional_ syntax is something to get rid of.
>It's error prone (position off-by-one --> bug cascade), and in
>fact the order of the id components should be irrelevant even for
>pattern matching.  So adding new components (pci rev, usb rev,
>whatever), in any order should never break the IDs.

	That would be a benefit, but I don't think that the bugs that
it would catch and the extensbility would be worth the code complexity
in the kernel right now.  So far, the needs for expansion that people
have found have small and addressible by linear extension of a
pattern.  The bugs that your approach would catch are the sort of
thing that would be noticed readily: driver doesn't load.  If the id
strings are not huge, then drivers that have multiple device ids will
generarally have the strings lined up together, so alignment errors
will be rare (but, yes, I expect they'll happen, just as we have
alignment errors when people use unnamed initializers in pci device ID
tables).

	I'm also ambivalent about the longer ID strings that your
scheme implies.

	However, feel free to write a string pattern matches that is
small and detects mismatches quickly (an average of half of all PCI
device ID's will have to be checked every time someone inserts a
cardbus card).  I'll be happy to take a look when you do.

>> 	USB /sys information appears to be only for the currently
>> selected configuration, but we want to match drivers for all possible
>> device configurations, even though most USB devices only define one.

>It's meaningless to try binding a driver to any non-current device
>config.

	I don't understand why you say that.  If I plug in a device
and there is some way that the system can interface to it, it should
try to do so by default.

 
>There's a patch pending (from Oliver Neukom) to fix up some
>relatively gaping integrity holes in config management.

	I don't know what you're referring to or how it's relevant.


>I do agree there should probably be a better way to access information
>about alternate configurations (and interface settings) than reading
>the information in "usbfs" ... but a good solution likely means moving
>away from that default policy of "one value per file".

	By the way, I don't know what problem you're referring to in
usbfs, although I think that discussion is tangential and probably
completely irrelevant to this one.


>> Also, although the usb driverfs code is very clean, I'd still like to
>> be able to configure out sysfs for systems that don't need it, and yet
>> I might still want modules on those systems precisely because I want
>> to mimize kernel memory footprint (by only loading certain drivers for
>> users or situations that actually use them).

>This correspond to the original usb hotplug design requirement
>of "must be able to run without usbfs".

	I give little credence to ex cathedra proclamations.  I care
about underlying technical advantages and disadvantages.


>Met by having hotplug
>events describe the device, and having device table entries (NOT
>used just for module loading!) encode many kinds of patterns.

	The scheme that I've described happens to eliminate use of
usbdevfs by eliminating the need for the usbmodules program, and it
also does not need sysfs or usbdevfs for hotplug events (coldplug
is another matter as you point out below).


>And running without "sysfs" will probably mean the same thing
>that running without "usbfs" previously meant:  there's no way
>to ensure that "coldplug" scenarios work right, since there must
>be times during system bootstrap where not enough of the OS is
>running (files, daemons, ...) to handle early hotplug events, and
>they can't be regenerated (or played back) later.

	That's a good point for sysfs, but it would be pretty
easy to add a system call or ioctl to tell the kernel to walk
the device tree and regenerate the all the modprobe
(or "hotplug <bustype> want") events for all unbound devices.

	By the way, for non-tiny systems, we could also provide
a file interface for reading the strings generated by the generic
device ID string generators that I described (as in pci_for_each_id)
so that you could read the ID's from a file.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
