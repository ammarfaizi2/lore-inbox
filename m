Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSHFRk7>; Tue, 6 Aug 2002 13:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHFRk6>; Tue, 6 Aug 2002 13:40:58 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:8974 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S315259AbSHFRkz>; Tue, 6 Aug 2002 13:40:55 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: driverfs and ieee1394
References: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>
From: Kristian Hogsberg <hogsberg@users.sf.net>
Date: 06 Aug 2002 19:44:29 +0200
In-Reply-To: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>
Message-ID: <m34re7zxtu.fsf@dhcp-17-1.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.9 |November
 16, 2001) at 06-08-2002 19:44:29,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.9 |November 16, 2001) at
 06-08-2002 19:44:34,
	Serialize complete at 06-08-2002 19:44:34
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

I've been reading through your driverfs and device model code, and
trying to change the ieee1394 subsystem over to use it.  The ieee1394
subsystem has some bus and device management functionality which works
much like the general device model code, and I think we could replace
much of this in the end.  But for now, I was just trying to hook it up
to the driverfs and use this to expose the subsystem status.

An ieee1394 device can have several programming interfaces
(i.e. several supported protocols for the same device), and I'm not
sure how to express this in the device model.  Ideally, you would
register a driver and specify which programming interface it supports
and the device model code would call probe for unmanaged devices that
has that interface (among others, possibly) .  Conversely, when a new
device is plugged in, the device model code should try to find a
driver that would work with one of the devices programming interfaces.

Likewise, many drivers support several programming interfaces - this
is supported in the PCI driver system, the usb subsystem and also in
the ieee1394 system (this was actually lifted from the PCI code).

I looked briefly at the usb solution, and it seems that they register
programming interfaces as subdevices of the actual device.  This has
the advantage of letting the general code do the work of iterating
through the interfaces, but it doesn't seem like the right way to use
the driverfs.  Another approach is to not register the actual devices
but only the interfaces like dev0:if0, dev0:if1, dev1:if0, etc. but
this doesn't express the structure of the bus in the directory
structure.  Finally, you could choose not to expose the interfaces at
all, and let the bus' match callback iterate through the supported
interfaces for drivers and devices, as is the case with the PCI
subsystem.

I know that the bus matching algorithm necessarily is bus specific,
but I think the concept of interfaces, as exposed by devices and
supported by drivers, is universal, so maybe the device model should
be extended to also incorporate interfaces in some way.

Anyway, for now I'll just implement the interface matching in the
match callback for the bus, and I plan to expose the interfaces of a
device by using the device_attribute mechanism.  In the ieee1394
subsystem, a device has a list of structs attached, each representing
an programming interface.  To implement a device_attribute entry per
interface in the directory for the device the show callback needs to
know which interface it is supposed to show.  As I see it, there are
basically two ways to do this and they both break the current API: 1)
include a void *user_data field in the device_attribute struct and
pass this as an extra argument to the show() and store() callbacks or
2) pass the pointer to the device_attribute struct to the callbacks
and let the callbacks use container_of() to figure out what they're
contained in.  I prefer the last solution, since you save the pointer
and I plan to embed the device_attribute structs in the struct
representing the interface anyway.  It requires only minimal changes
to the device model code but it breaks the API:

static ssize_t
dev_attr_show(struct driver_dir_entry * dir, struct attribute * attr,
	      char * buf, size_t count, loff_t off)
{
	struct device_attribute * dev_attr = to_dev_attr(attr);
	struct device * dev = to_device(dir);
	ssize_t ret = 0;

	if (dev_attr->show)
		ret = dev_attr->show(dev,dev_attr,buf,count,off);
	return ret;
}

Another issue is device naming (bus_id) - what's the convention?  I
can see from the PCI names that they use bus position, but this is
probably a bad idea for ieee1394.  Devices on the ieee1394 bus are
enumerated by a tree traversal algorithm, and hotplug events change or
even re-root the tree (the linux box isn't necessarily the root), and
thus, the bus addresses change.  Instead I was planning to using the
extended unique id (EUI) of the devices as device names.  The EUI is a
64 bit globally unique number, much like the MAC address of ethernet
cards.  However, there's only allocated 16 chars for the
bus_id... could you make it 20 chars, or do you have another
suggestion for device naming?

Kristian

