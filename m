Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVBKAlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVBKAlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVBKAlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:41:05 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:13858 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261977AbVBKAkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:40:53 -0500
Date: Thu, 10 Feb 2005 16:40:33 -0800
From: Greg KH <gregkh@suse.de>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211004033.GA26624@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to announce, yet-another-hotplug based userspace project:
linux-ng.  This collection of code replaces the existing linux-hotplug
package with very tiny, compiled executable programs, instead of the
existing bash scripts.

It currently provides the following:
	- a /sbin/hotplug multiplexer.  Works identical to the existing
	  bash /sbin/hotplug.
	- autoload programs for usb, scsi, and pci modules.  These
	  programs determine what module needs to be loaded when the
	  kernel emits a hotplug event for these types of devices.  This
	  works just like the existing linux-hotplug scripts, with a few
	  exceptions.

But why redo this all in .c code?  What's wrong with shell scripts?
Nothing is wrong with shell scripts, unless you don't want to have an
interpreter in your initramfs/initrd and you want to provide
/sbin/hotplug and autoload module functionality.  Or if you have a huge
box that spawns a zillion hotplug events all at once, and you need to be
able to handle all of that with the minimum amount of processing time
and memory.

So, how small are these programs?  Take a look:
   text    data     bss     dec     hex filename
   4669      32     124    4825    12d9 hotplug
   5077       8     348    5433    1539 module_pci
   4925       8     412    5345    14e1 module_scsi
   5349       8     348    5705    1649 module_usb

Those are all static binaries, linked with klibc (which is included in
the hotplug-ng package, just like udev.)

This compares to the following bash scripts:
-rwxr-xr-x  1 root root  4412 Feb 10 15:28 /sbin/hotplug
-rw-r--r--  1 root root   702 Sep 24 08:04 /etc/hotplug/blacklist
-rw-r--r--  1 root root  5293 Sep 24 08:04 /etc/hotplug/hotplug.functions
-rwxr-xr-x  1 root root  3739 Sep 24 08:04 /etc/hotplug/pci.agent
-rwxr-xr-x  1 root root  1459 Sep 24 08:04 /etc/hotplug/scsi.agent
-rwxr-xr-x  1 root root 13466 Sep 24 08:04 /etc/hotplug/usb.agent
-rw-r--r--  1 root root 39306 Sep 24 08:04 /etc/hotplug/usb.distmap
-rw-r--r--  1 root root  4364 Sep 24 08:04 /etc/hotplug/usb.handmap
-rw-r--r--  1 root root   189 Sep 24 08:04 /etc/hotplug/usb.usermap

All of which are loaded into memory for each hotplug event (for specific
hotplug events, only that bus type of file is loaded.)

But what about speed?  With a completely unscientific measurement on my
old, slow laptop, it takes about 2 seconds from the time I plug a usb
device into the machine, for the proper module to be loaded.  With the
hotplug-ng program, it takes less than a second.

And for those of you who might remember the old dietHotplug program that
also did the same thing in a tiny amount of space, this project
obsoletes that one.  dietHotplug had to be rebuilt for every kernel that
was used on the system, hotplug-ng uses the ability for modprobe to
determine the module that needs to be loaded based on the module
aliases[1].

The code can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-ng-001.tar.gz
for those who wish to poke around in it.

I still have a few more programs to write to get it up to the same
functionality as the existing hotplug scripts (firmware, ieee1392, etc.)
but those will be done soon.  I'd like to get people's comments on the
idea, and welcome suggestions and even patches :)

hotplug-ng development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/hotplug-ng

If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h

[1] modprobe as it currently works stops loading modules when it finds
an alias that matches.  This does not work for drivers that claim to
support "all devices" and then later on fail on devices that they really
don't support.  For that, all matching drivers need to be loaded for the
system to work properly.  The linux-hotplug scripts handle this
correctly, so if you rely on this functionality, please stick with that
package for now.  I'll be modifying modprobe to add this feature in the
near future.

