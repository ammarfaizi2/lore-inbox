Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVJRHPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVJRHPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVJRHPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:15:39 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:46822 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S932415AbVJRHPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:15:39 -0400
Date: Tue, 18 Oct 2005 03:18:22 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <gregkh@suse.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>, dtor_core@ameritech.net,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051018071822.GC32655@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <gregkh@suse.de>,
	Kay Sievers <kay.sievers@vrfy.org>, dtor_core@ameritech.net,
	Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
	Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
	linux-kernel@vger.kernel.org
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de> <20051017232430.GA32655@neo.rr.com> <20051018052617.GA10263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018052617.GA10263@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 10:26:17PM -0700, Greg KH wrote:
> On Mon, Oct 17, 2005 at 07:24:30PM -0400, Adam Belay wrote:
> > 
> > Sounds good to me.  The changes to driver model internals may be substantial.
> > For example, because buses and classes will share more code, it's
> > reasonable to allow drivers to bind to any "device" object, even class
> > devices.  Of course this would be limited to classes that choose to
> > implement driver matching etc.  We are doing this now with the pci express
> > port driver.
> 
> That's a bus, not a class device.  Drivers bind to devices through a
> bus.  That's why we have busses.

If class devices and devices belong in the same tree, then clearly the original
distinction is artificial.  "struct bus_type" is a class of "struct device".
"struct class" is a class of "struct class_dev".  We now know of devices
in between these two extremes (e.g. pci express port driver).  It's also
possible that drivers will want to bind to class devices (e.g. a partition
driver binding to a block device).  Isn't it fair to say that the "bus_type"
vs. "class" distinction is also artificial?  At the very least they are
duplicating some code.

> 
> > Also, we could make driver objects a "class" and represent them in the
> > global device tree, giving each driver instance its own unique namespace.
> 
> Huh?  How would you do that?  Also, we really don't have different
> driver "instances", so trying to represent something like that in sysfs
> would probably be more work than it's worth.

(all in same tree)
pci0000:00.00 <- physical device
|
\- e1000:0 <- driver
 |
 \- eth0 <- class device
 
We already informally have driver instances.  They're pointed to in
"driver_data".

> 
> > > Oh, one tiny problem.  "virtual devices" are not currently represented
> > > in our device tree, but are in the class tree.  Things like the
> > > different vc and ttys and misc devices are examples of this.  I'll just
> > > put them on the "platform" bus if no one minds.
> > 
> > I think we should be trying to kill off the platform bus (it's artifical and
> > doesn't show the real relationships between these devices).  Instead, just
> > hang them off the root of the tree.
> 
> Everything that's currently a platform device go to the root?  No,
> that's not going to happen, sorry.

Not at all.  Rather, everything that's currently a platform device goes to
where it actually belongs in the device tree.  ACPI (and other firmware)
enumerates all of these devices.  They're generally children of LPCs and
ISA bridges.  Making a special exception for these devices is ugly when we
can easily represent them like every other device.  This will even be possible
without ACPI for many of these devices if we create an "ISA" bus driver
abstraction.

The main point here is that "platform" is really a hack to represent primitive
physical devices that don't fit well into the driver model.  There may be
better ways of approaching this problem.

> 
> > If the device doesn't have any parents or dependencies, then that's
> > logically where it belongs.
> 
> We do have a real platform "bus" that devices hang off of.  Where else
> is that keyboard controller at :)

As stated above, the keyboard actually does have a real location to hang off of.
Nonetheless, a keyboard controller is a physical device.  It's very different
from a "virtual device" like a tty.  Therefore, it seems unreasonable to make
virtual devices belong to the "platform" bus.

If a device doesn't have a parent device, it belongs at the root of the tree.
That's the only obvious way to represent such a lack of dependency.  This
applies to both class and physical devices.

Thanks,
Adam
