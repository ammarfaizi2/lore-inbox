Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbVIPAU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVIPAU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVIPAU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:20:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:28563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030507AbVIPAU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:20:57 -0400
Date: Thu, 15 Sep 2005 17:20:37 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916002036.GA6149@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, first off, I hate talking about architecture changes without showing
the code for what I am talking about first, but as this is an issue that
needs to be agreed upon by a wide range of developers, I'll just write
up what I am thinking about doing before actually doing it...

The problem:  We need a way to show complex class and class device
structures properly in sysfs.  Examples of these "complex" views are the
input layer's use of different input drivers for devices (usually the
same device), the video subsystem view of frame buffer devices and
monitors, and even the block layer with it's disks and partitions.

Proposed solutions in the past have been either add the ability to nest
classes themselves (as shown in Dmitry's recent proposal for fixing the
input layer), or add the ability to nest class_device structures (I
think others have tried to do this in the past, sorry for not
remembering the specifics.)  Both of these proposals don't really solve
the real problem, that of the fact that we need to come up with a
solution that all of the different subsystems can use properly.

So, here's my take on it.  Feel free to tell me what I messed up :)

I would like to add something called "subclasses" for lack of a better
term.  These subclasses would have both drivers, and devices associated
with them.  This would show up as the following tree of directories:

	/sys/class/input/
	|-- input0
	|   |-- event0
	|   `-- mouse0
	|-- input1
	|   |-- event1
	|   `-- ts0
	|-- mice
	`-- drivers
	    |-- event
	    |-- mouse
	    `-- ts

Here we have 3 struct class_devices like today, input0, input1, and
mice.  We also have struct subclass_drivers of event, mouse, and ts.
These will create the struct subclass_devices event0, mouse0, event1,
and ts0.  The "dev" node files will show up in the directories mice,
event0, mouse0, event1, and ts0, like you would expect them too.

So, this lets us create a solution for the input subsystem, but will it
also work for block and video?

For block, yes, I think so.  There is no requirement for a
subclass_driver to create the subclass devices.  Any code can create and
register with the class core a subclass device, just set up the parent
pointer and away you go.  So, in the following instance:
	/sys/class/block/
	`-- sda
	    |-- sda1
	    |-- sda2
	    `-- sda3

"block" would represent the struct class.
"sda" would represent the struct class_device.
"sda1", "sda2", and "sda3" would represent the different subclass
devices that are bound to the class device "sda".

And yes, before you all point out the class_interface logic, yes, the
subclass_driver stuff looks a lot like this idea.  Possibly we could
just get rid of the interface stuff and use the subclass_driver logic,
but I'd have to look at how people are using the interface logic before
I can give a confident answer about that.

Hotplug events would be simple with this scheme, the class stuff would
remain the same, and the devpath would just point to the subdir (hotplug
events would happen for both the class devices and the subclass
devices.)  And yes, udev and libsysfs would have to be changed to
support this, so we better get this right before pushing it out to the
world...

But, what about video devices?  David and Pat, we talked about this at
OLS, but Pat kept the paper we drew on, and the beer we were drinking at
the time has made my memory a bit fuzzy as to all of your requirements
for the video subsystem.  I remember things about frame buffers and
monitors and other things like that, but nothing specific, sorry.  Could
you outline your needs and I'll see if this proposed structure would
solve your issues?

Well, that was a very brief summary, of which I know there are lots of
questions for the areas I didn't explain well enough.  Comments?
Criticisms?  Want to see the code before commenting?

thanks,

greg k-h
