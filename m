Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTDKDO7 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 23:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTDKDO7 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 23:14:59 -0400
Received: from granite.he.net ([216.218.226.66]:55051 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262771AbTDKDO4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 23:14:56 -0400
Date: Thu, 10 Apr 2003 20:24:24 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com
Cc: Daniel Stekloff <dsteklof@us.ibm.com>
Subject: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411032424.GA3688@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi all,

I'd like to finally announce the previously vapor-ware udev program that
I've talked a lot about with a lot of people over the past months.  The
first, very rough cut is at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-0.1.tar.gz

But what is it?  I've included an initial design document below that was
originally written by Dan Stekloff, and hacked up a bit by me.  But in
short, udev is a userspace replacement for devfs.  It will create and
destroy /dev entries based on the current system configuration.  It does
this by watching the /sbin/hotplug events on the system, and reading
information about these events from sysfs.

Right now the program is only in 1 piece, not the 3 pieces that the
design document talks about, but it does work with the default Linux
/dev naming scheme that almost everyone uses.  It can only work for
devices that create a dev file in sysfs, exposing their major/minor
number, so this is limited (currently only block and usb-serial devices
do this.)

If you want to test this with block devices, you will need the kobject
hotplug patches previously posted here for 2.5.67, which are also
available at:
	kernel.org/pub/linux/kernel/people/gregkh/misc/kobject-hotplug-?-2.5.67.patch

Anyway, this works for me, on my machines, and I am very interested in
feedback from everyone about both this concept, and the implementation
of this.  I've cced a lot of different lists, as they have all expressed
interest in this project.

Yes, I know there's still a lot of work to do (serialization, symlinks,
hooking hotplug so that others can also use it, etc.) but it's a first
step :)

I'd like to thank Dan Stekloff for constantly badgering me about this
project and for writing lots of good design documentation, it is greatly
appreciated.  Also, thanks to Pat Mochel for coming up with sysfs which
allows this project to be able to work at all.

thanks,

greg k-h

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=overview


We've got a couple goals for udev:

1) dynamic replacement for /dev
2) device naming
3) API to access info about current system devices

Splitting these goals into separate subsystems:

1) udev - dynamic replacement for /dev
2) namedev - device naming
3) libsysfs - a standard library for accessing device information on the
              system.

Udev
------

Udev will be responsible for responding to /sbin/hotplug on device
events.  It will receive the device class information along with
device's sysfs directory.  Udev will call the name_device function from
the naming device subsystem with that information and receive a unique
device name in return.  Udev will then query sysfs through the libsysfs
for specific device information required for creating the /dev node like
major and minor number.  Once it has the important information, udev
will create a /dev entry for the device, add the device to the in memory
table of current devices, and send notification of the successful event
through a D-BUS message.  On a remove call, udev will remove the /dev
entry, remove the device from the in memory table, and send
notification.

Udev will consist of a command udev - to be called from /sbin/hotplug.
It will require the in memory dynamic database/table for keeping track
of current system devices, and a library of routines for accessing that
database/table.  Udev will not care about "how" devices are named, that
will be separated into the device naming subsystem.  It's presented a
common device naming API by the device naming subsystem to use for
naming devices.



namedev
----------

>From comments people have made, the device naming part of udev has been
pushed into its own "subsystem".  The reason is to make this as flexible
and pluggable as possible.  The device naming subsystem, or namedev, will
present a standard interface for udev to call for naming a particular
device.  Under that interface, system administrators can plug in their
own methods for device naming.

We would provide a default naming scheme. The first prototype
implementation could simply take the sysfs directory passed in with the
device name function, query sysfs for the major and minor numbers, and
then look up in a static device name mapping file the name of the
device. The static device naming file could look just like devices.txt
in the Linux kernel's Documentation directory.  Obviously, this isn't a
great implementation because eventually we'd like major an minor numbers
to be dynamic.

The default naming scheme in the future would have a set of policies to
go through in order to determine the name of the device.  The device
naming subsystem would get the sysfs directory of the to be named device
and would use the following information in order to map the device's
name:

1) Label info - like SCSI's UUID
2) Bus Device Number
3) Topology on Bus
4) Kernel Name - DEFAULT

System administrators could use the default naming system or enterprise
computing environments could plug in their Universal Unique Identifier
(UUID) policies.  The idea is to make the device naming as flexible and
pluggable as possible.

The device naming subsystem would require accessing sysfs for device
information.  It will receive the device's sysfs directory in the call
from udev and use it to get more information to determine naming.  The
namedev subsystem will include a standard naming API for udev to use.
The default naming scheme will include a set of functions and a static
device naming file, which will reside in /etc or /var.



libsysfs
--------

There is a need for a common API to access device information in sysfs.
The device naming subsystem and the udev subsystem need to take the
sysfs directory path and query device information.  Instead of copying
code so each one will have to readdir, etc., splitting this logic of
sysfs calls into a separate library that will sit atop sysfs makes more
sense.  Sysfs callbacks aren't standard across devices, so this is
another reason for creating a common and standard library interface for
querying device information. 


--C7zPtVaVf+AK4Oqc--
