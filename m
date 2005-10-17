Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVJQXVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVJQXVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVJQXVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:21:53 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:18345 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S932370AbVJQXVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:21:51 -0400
Date: Mon, 17 Oct 2005 19:24:30 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <gregkh@suse.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>, dtor_core@ameritech.net,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051017232430.GA32655@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <gregkh@suse.de>,
	Kay Sievers <kay.sievers@vrfy.org>, dtor_core@ameritech.net,
	Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
	Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
	linux-kernel@vger.kernel.org
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017214430.GA5193@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:44:30PM -0700, Greg KH wrote:
> On Sat, Oct 15, 2005 at 05:08:55PM +0200, Kay Sievers wrote:
> > A lot! From general distro specific system-management to subsystem specific
> > setup tools and tons of udev rules... There is definitely no chance to break
> > /sys/class in _all_ subsystems by introducing subdirectories.
> 
> I agree.
> 
> > > Btw, is your proposal with moving it all into /sys/device less drastic?
> > 
> > Definitely, cause it keeps all the curent api! The only difference is that class-devices
> > are reached by symlinks instead of real directories. The pathes to the devices are
> > the same!
> 
> Ok, I've spent a while thinking about this proposal and originally I
> thought it was the same thing we had heard years ago.  But I was wrong,
> moving the class stuff into the device tree is the right thing to do, as
> long as we keep them as new "things" in the tree (previous proposals
> just had the /sys/class stuff as symlinks pointing to the devices
> themselves, which would not work for a range of reasons.)
> 
> So, what to do now?  Here's my proposal for the future.
> 
> We figure out some way to agree on the input stuff, using class_device
> and get that into 2.6.15.  Personally, I like the stuff I just did and
> is in the -mm tree :)
> 
> But, if you think we can't break userspace by adding nested class
> devices just yet, I agree, and can probably just put a symlink in
> /sys/class/input to the nested devices, which will make everything "just
> work".  I'll try that out later tonight and let you all know how it
> goes.
> 
> Then, we move the class stuff into real devices.  There was always a lot
> of duplication with the class and device code, and this shows that there
> is a commonality there.  At the same time, I'll work on making the
> attribute stuff easier and possibly merge the kobject and device
> structures together a bit (possibly I said, I don't know quite how much
> yet...)
> 
> But this second step is going to take a while, have to not break
> everything along the way, and should hopefully clean up a lot of mess
> tht the current driver core has.  I'd be glad to do it :)
> 
> Acceptable to everyone?

Sounds good to me.  The changes to driver model internals may be substantial.
For example, because buses and classes will share more code, it's
reasonable to allow drivers to bind to any "device" object, even class
devices.  Of course this would be limited to classes that choose to
implement driver matching etc.  We are doing this now with the pci express
port driver.

It also may make sense to move bus_types to the "class" interface.  The
layered classes suggestion is especially useful here because we can have a
"hardware" or "bus" class that acts as a parent for "pci", "usb", etc.

Also, we could make driver objects a "class" and represent them in the
global device tree, giving each driver instance its own unique namespace.

> 
> Oh, one tiny problem.  "virtual devices" are not currently represented
> in our device tree, but are in the class tree.  Things like the
> different vc and ttys and misc devices are examples of this.  I'll just
> put them on the "platform" bus if no one minds.

I think we should be trying to kill off the platform bus (it's artifical and
doesn't show the real relationships between these devices).  Instead, just
hang them off the root of the tree.  If the device doesn't have any parents
or dependencies, then that's logically where it belongs.

Thanks,
Adam
