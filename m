Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVIPV51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVIPV51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVIPV51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:36493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750707AbVIPV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:26 -0400
Date: Fri, 16 Sep 2005 14:54:27 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916215427.GD13920@suse.de>
References: <20050916002036.GA6149@suse.de> <200509151958.45573.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509151958.45573.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 07:58:44PM -0500, Dmitry Torokhov wrote:
> On Thursday 15 September 2005 19:20, Greg KH wrote:
> > 
> > 	/sys/class/input/
> > 	|-- input0
> > 	|   |-- event0
> > 	|   `-- mouse0
> > 	|-- input1
> > 	|   |-- event1
> > 	|   `-- ts0
> > 	|-- mice
> > 	`-- drivers
> > 	    |-- event
> > 	    |-- mouse
> > 	    `-- ts
> > 
> > Here we have 3 struct class_devices like today, input0, input1, and
> > mice.  We also have struct subclass_drivers of event, mouse, and ts.
> > These will create the struct subclass_devices event0, mouse0, event1,
> > and ts0.  The "dev" node files will show up in the directories mice,
> > event0, mouse0, event1, and ts0, like you would expect them too.
> >
> 
> This proposed scheme does not answer the question: "what input interfaces
> present in my system?". Input interfaces are objects in their own right
> and deserve their own spot. Compare your picture with the one below:

Yes it does.  They are the leaf nodes in the tree.  They will also have
a "dev" file in them, which is the only real way to determine this for
stuff like udev and HAL.

I didn't show all the symlinks and files as I was trying to make the
directory structure the main point.  I can fill them in if you are
curious.

> [dtor@core ~]$ tree /sys/class/input/
> /sys/class/input/
> |-- devices
> |   |-- input0
> |   |   |-- device -> ../../../../devices/platform/i8042/serio1
> |   |   `-- event0 -> ../../../../class/input/interfaces/event0
> |   |-- input1
> |   |   |-- device -> ../../../../devices/platform/i8042/serio0
> |   |   |-- event1 -> ../../../../class/input/interfaces/event1
> |   |   |-- mouse0 -> ../../../../class/input/interfaces/mouse0
> |   |   `-- ts0 -> ../../../../class/input/interfaces/ts0
> |   `-- input2
> |       |-- device -> ../../../../devices/platform/i8042/serio0/serio2
> |       |-- event2 -> ../../../../class/input/interfaces/event2
> |       |-- mouse1 -> ../../../../class/input/interfaces/mouse1
> |       `-- ts1 -> ../../../../class/input/interfaces/ts1
> `-- interfaces
>     |-- event0
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input0
>     |-- event1
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input1
>     |-- event2
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input2
>     |-- mice
>     |   `-- dev
>     |-- mouse0
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input1
>     |-- mouse1
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input2
>     |-- ts0
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input1
>     `-- ts1
>         |-- dev
>         `-- device -> ../../../../class/input/devices/input2
> 
> Here you have exactly the same information as in your picture plus you can
> see the other class (input interfaces) as well.

Yeah, you can.  But you don't have a place for the "drivers" of those
interfaces, which is something you will probably need (I think video
needs them)

> The only issue is that links between those class devices are created in
> input core but we can solve it. We just need to allow class devices be
> children of other class devices.

No, I still don't think we need that.

> > So, this lets us create a solution for the input subsystem, but will it
> > also work for block and video?
> > 
> > For block, yes, I think so.  There is no requirement for a
> > subclass_driver to create the subclass devices.  Any code can create and
> > register with the class core a subclass device, just set up the parent
> > pointer and away you go.  So, in the following instance:
> > 	/sys/class/block/
> > 	`-- sda
> > 	    |-- sda1
> > 	    |-- sda2
> > 	    `-- sda3
> > 
> 
> Here is a different puzzle. Instead of adding interfaces to a device you
> partition it. I don't think we need to mix those 2 tasks together.

Well, whatever solution we come up with, has to work for block, input,
and video at the least, or it's not acceptable.

Ok, I'll go off and try to code this all up to see if it's even
possible, on my plane ride.  More from me next Tuesday...

thanks,

greg k-h
