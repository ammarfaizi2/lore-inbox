Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUAZVur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbUAZVur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:50:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:41897 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265557AbUAZVul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:50:41 -0500
Date: Mon, 26 Jan 2004 13:50:36 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 015 release
Message-ID: <20040126215036.GA6906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 015 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-015-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-015-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Major changes from the 014 version:
	- we finally look up the chain of sysfs device entries trying to
	  match all devices in the chain for each rule.

What this means to users:  Consider the following sysfs device:
$ tree /sys/class/input/mouse1/
/sys/class/input/mouse1/
|-- dev
|-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0
`-- driver -> ../../../bus/usb/drivers/hid

Now this is a USB trackball.  udev will follow that "device" symlink and
get to the following directory:
$ tree /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0
|-- bAlternateSetting
|-- bInterfaceClass
|-- bInterfaceNumber
|-- bInterfaceProtocol
|-- bInterfaceSubClass
|-- bNumEndpoints
|-- detach_state
|-- iInterface
`-- power
    `-- state

This is the directory of the USB interface that is bound to a mouse
driver.  But in itself, that directory is pretty boring, no vendor id,
no product id, no manufacturer string...  What a user really wants is
the directory above this:
$ tree /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1
|-- 2-1:1.0
|   |-- bAlternateSetting
|   ...
|-- bConfigurationValue
|-- bDeviceClass
|-- bDeviceProtocol
|-- bDeviceSubClass
|-- bMaxPower
|-- bNumConfigurations
|-- bNumInterfaces
|-- bcdDevice
|-- bmAttributes
|-- detach_state
|-- idProduct
|-- idVendor
|-- manufacturer
|-- power
|   `-- state
|-- product
`-- speed

Now this directory contains good stuff:
$ cat /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/product
Microsoft Trackball Optical®


So, in short, you can now write a udev rule for this device as:
SYSFS_product="Microsoft Trackball*", NAME="my_trackball", SYMLINK="input/mouse1"

and it will actually work :)

This is really helpful for all USB devices, and SCSI devices on USB or
Firewire buses.  If anyone has any questions about this, please let me
know, or bring it up on the linux-hotplug-devel mailing list.


Another big thing in this release is 'udevinfo'.  It's a way to get all
information out of the udev database about what devices are present,
what they are called, and other good stuff.  It also will walk the sysfs
chain of any device and print out all information on the device which
helps out a lot in creating rules for udev.

Thanks to Kay Sievers who wrote udevinfo.  Great job.


Also in this release is the start of a udev daemon.  It's really in 3
pieces:
	udevsend - sends the hotplug message to the udev daemon
	udevd - the udev daemon, gets the hotplug messages, sorts them
		in proper order, and passes them off to the udev program
		to act apon them.
	udev - still the same.

This lets us keep udevsend and udevd small, and hopefully bug free.
These programs still need a lot of work and polish before we feel they
are stable enough to use for everyone (they are not built right now in
the .rpm).  Help is appreciated here.

Thanks a lot to Kay Sievers and Xiaofeng Ling for the work on udevsend
and udevd.  Again, I really appreciate it.

Thanks also to everyone who has send me patches for this release, a full
list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v014 to v015
============================================

<mbuesch:freenet.de>:
  o LFS init script update

Greg Kroah-Hartman:
  o update klibc to version 0.98
  o clean up udevinfo on 'make clean'
  o add udevinfo man page to spec file
  o remove command line documentation from udev man page
  o create initial version of udevinfo man page
  o added URL to spec file
  o add udevinfo to udev.spec file
  o add udevinfo to install target of Makefile
  o rip out command line code from udev, now that we have udevinfo
  o udevinfo doesn't need to declare main_envp
  o move get_pair to udev_config.c because udevinfo doesn't need all of namedev.o
  o more makefile cleanups
  o move udevinfo into the main build and clean up the main Makefile a bit
  o clean up compiler warnings if building using klibc
  o make udevd only have one instance running at a time
  o new testd.block script for debugging
  o udevsnd : clean up message creation logic a bit
  o make bk ignore udevd and udevsend binaries
  o whitespace cleanups
  o remove TODO item about BUS value, as it is now done
  o add support for figuring out which device on the sysfs "chain" the rule applies to

Kay Sievers:
  o udevinfo - now a real program :)
  o udevd - cleanup and better timeout handling
  o udev - next round of udev event order daemon
  o fix udevd exec
  o udev - udevinfo with device chain walk
  o spilt udev into pieces


