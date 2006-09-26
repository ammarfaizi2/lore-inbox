Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWIZOXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWIZOXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWIZOXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:23:44 -0400
Received: from ns.suse.de ([195.135.220.2]:4543 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWIZOXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:23:44 -0400
Date: Tue, 26 Sep 2006 07:23:40 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 26/47] Driver core: add groups support to struct device
Message-ID: <20060926142340.GA11999@kroah.com>
References: <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com> <20060926134654.GB11435@kroah.com> <d120d5000609260701q65039221rac64d043a5b55df9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609260701q65039221rac64d043a5b55df9@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 10:01:06AM -0400, Dmitry Torokhov wrote:
> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >On Tue, Sep 26, 2006 at 09:20:17AM -0400, Dmitry Torokhov wrote:
> >> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >> >From: Greg Kroah-Hartman <gregkh@suse.de>
> >> >
> >> >This is needed for the network class devices in order to be able to
> >> >convert over to use struct device.
> >> >
> >>
> >> Greg,
> >>
> >> You keep pushing out patches that merge class devices and standard
> >> devices but you still have not shown the usefullness of this process.
> >
> >I have not?  This has been discussed before.
> >
> 
> Care to send me a pointer?

Ugh, somewhere back in the lkml archives, sorry for not being more
specific...

> >> Why do you feel the need to change internal kernel structures
> >> (ever-expanding struct device to accomodate everything that is in
> >> struct class_device) when it should be possible to simply adjust sysfs
> >> representation of the kernel tree (moving class devices into
> >> /sys/device/.. part of the tree)  to udev's liking and leave the rest
> >> of the kernel alone. You have seen the patch, only minor changes in
> >> driver/base/class.c are needed to accomplish the move.
> >
> >Think about suspend.  We want a single device tree so that the class
> >gets called when a device is about to be suspended so that it could shut
> >down the network queue in a common way, before the physical device is
> >called.
> 
> Why can't the device itself manage it? If you want to stub out the
> common parts just create a function like netdev_suspend and call it at
> appropriate time.

Because you would then need to add that function call to _every_ network
device driver.  This way, we do not need to do that as the class gets
called in the proper place before the device driver does.

In short, it makes it much simpler for the device driver writer, as it
is one less thing for them to get wrong (you can implement it once in
the input core, and have it work for all input devices, no need to touch
every input driver too.)

> >It's also needed if we want to have a single device tree in general.
> >class_device was the wrong thing and is really just a duplicate of
> >struct device in the first place (the driver core code implementing it
> >is pretty much just a cut and paste job.)
> 
> They complement each other. They are different and need different
> methods to operate.

Not they are not.  They really are just the same thing.

> > The fact that we were
> >arbritrary marking it different has caused problems (look at the mess
> >that input causes to the class_device code, that's just not nice).
> >
> 
> The only mess is that you refused to deepen the classification (i.e.
> have sub-classes). If input could be a parent class and
> mice/event/js/ts would grow from it it won't be such a mess.

But that is what we are now allowing you to do with devices.  The whole
sub-class stuff was tried and failed.  But in the end, it would almost
work with input devices, but then why not just make it a real device, so
you can use whatever heirachy you want to.  I would think that you would
welcome this change.

> Alternatively we could go with input vs input_intf classes if flat
> classification is a must. Anyway, I don't think we want to break udev
> again.

Flat classification is not a must at all, and with these changes, you
don't need it.  As an example, here's what the input tree looks like
when changed over:
$ tree /sys/class/input/
/sys/class/input/
|-- event0 -> ../../devices/platform/pcspkr/input0/event0
|-- event1 -> ../../devices/platform/i8042/serio4/input1/event1
|-- event2 -> ../../devices/platform/i8042/serio3/input2/event2
|-- input0 -> ../../devices/platform/pcspkr/input0
|-- input1 -> ../../devices/platform/i8042/serio4/input1
|-- input2 -> ../../devices/platform/i8042/serio3/input2
|-- mice -> ../../devices/virtual/input/mice
|-- mouse0 -> ../../devices/platform/i8042/serio3/input2/mouse0
`-- ts0 -> ../../devices/platform/i8042/serio3/input2/ts0

If you want, you can move any of these input devices anywhere in the
heirchay that you wish to do so.  A symlink will be automatically
created in /sys/class/input so that userspace tools like udev can find
all of the input devices (which is something that is needed), but there
is no more rigid heirachy being imposed on any one.  You are free to
move them at will, and no userspace tools will break as they will be
following the symlink instead.

> >Kay also has a long list of the reasons why, I think he's posted it here
> >before.  Kay, care to send that list again?
> >
> 
> Kay did send it and I agree with all his reasons as to why we need the
> move.

Great, they why are you objecting to these driver core patches?

> However I do not agree with your implementation.

Which implementation?  The one I did for the class subsystem?  Ok,
that's fine, your patch is still in my queue to look at, I'm not
ignoring it at all (had a bunch of "real life" work to get through this
last week and weekend, sorry, am still catching up.)

Don't worry, I'm not going to be pushing any input subsystem changes
wihout going through you first :)

These driver core patches are merely the needed functions for us to do
those input and other subsystem changes, they should not affect anything
of yours at all.

> >> I really disappointed that there was no discussion/review of the
> >> implementation at all.
> >
> >There has not been any real implementation yet, only a few patches added
> >to the core that add a few extra functionality to struct device to allow
> >class_device to move that way.
> 
> If there was no real discussion why you requesting these changes to be
> pulled in the mainline?

I didn't think these patches were controversial at all.  They have been
in -mm for a few months now and work just fine.

Is there anything specfic in these patches that you object to?  Becides
the virtual thing (I tried it with a flat /sys/devices/virtual/ tree,
and it was a mess, I like the extra directory for classification, but in
the end, it doesn't matter, we can change it with no problem, as no
userspace tool will break if you move devices around the /sys/devices/
tree.)

thanks,

greg k-h
