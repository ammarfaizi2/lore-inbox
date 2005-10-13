Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVJMCL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVJMCL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJMCL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:11:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:38542 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932494AbVJMCL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:11:57 -0400
Date: Wed, 12 Oct 2005 19:08:44 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051013020844.GA31732@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, finally.  Here's a set of _working_ patches that properly implement
nesting class_device structures, and the follow-on patches to move the
input subsystem to use them.  Hotplug and release functions work
properly now, and this will let us move /sys/block/ to use class and
class_device structures soon.

The input patches are on top of almost all of Dmitry's input patches.
All of them are together in one series in my public patches at:
	kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
and should show up in the next -mm release.

The sysfs tree looks the same as it did last time, but now hotplug works
properly for addition and removal, and we actually free the memory used
:)

For those that don't remember, here's the sysfs tree on my desktop:
$ tree /sys/class/input/ -d
/sys/class/input/
|-- input0
|   |-- capabilities
|   |-- event0
|   `-- id
|-- input1
|   |-- capabilities
|   |-- device -> ../../../devices/platform/i8042/serio1
|   |-- event1
|   |   `-- device -> ../../../../devices/platform/i8042/serio1
|   `-- id
|-- input3
|   |-- capabilities
|   |-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
|   |-- event2
|   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
|   |-- id
|   |-- mouse0
|   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
|   `-- ts0
|       `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
`-- mice

To answer the remaining questions from the last thread:

Q: how are you going to determine what is really a class_dev and what
   isn't, as there's no way to tell.
A: Who cares?  Seriously, tools like udev will watch for the "dev" file
   to be able create the required device node, and it will be the one
   getting the hotplug event.  attribute groups do not generate hotplug
   events, and you should not be having a file called "dev" in your
   attribute group anyway.

Q: why does event2, mouse0, and input3 in the above tree all have the
   same "device" symlink?
A: userspace tools expect that symlink there.  They do not know that if
   you traverse up a directory, and look at the symlink there, that's
   what the subdirectory points to too.  That would be a mess.  And, as
   those different class_device structures really are all bound to that
   same struct device, that is the proper representation of this.

Q: How can you determine between input interfaces and input devices?
A: input devices have a "dev" file.  And what really does userspace need
   to know here?

Q: Wait, what about nesting struct class instead?  That would work,
   right?
A: No, nesting classes is not going to happen.  Classes are "major"
   things, and aren't related to each other (well, some are by their
   name only, like the different "scsi*" classes, but to the user, they
   are separate.)
   Also, we can't emulate /sys/block with nested classes.  And no, we
   can't change this to be /sys/class/block/partitions and
   /sys/class/block/devices without almost every sysfs user complaining
   loudly.  That's not the real representation of the devices, and we
   need to really try to keep backward compatibility where we possibly
   can.

Ok, I think that covers everything.

Oh, one final thing.  I really don't think that input should be a class.
It looks like a "bus" and acts like a "bus" (you have different devices
that have different drivers bind to them, and you want to load those
drivers with the hotplug mechanism.)  The only thing keeping this from
being a bus is the fact that we can't bind multiple drivers to a single
device these days, and I can't see a way to move this code to that
model, so oh well...

thanks,

greg k-h
